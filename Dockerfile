# Start from a core stack version
FROM jupyter/scipy-notebook:11a777c0a87c

# Install from requirements.txt file
COPY --chown=${NB_UID}:${NB_GID} requirements.txt /tmp/
RUN mamba install --yes --file /tmp/requirements.txt && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# For packages not available via conda, use pip
# Install from requirements.pip.txt file
COPY --chown=${NB_UID}:${NB_GID} requirements.pip.txt /tmp/
RUN pip install -r /tmp/requirements.pip.txt
