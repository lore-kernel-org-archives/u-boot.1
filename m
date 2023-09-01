Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553D5CA0FEC
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 20:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C05C86758;
	Fri,  1 Sep 2023 22:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qsfMbG2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D0B58657B; Fri,  1 Sep 2023 22:41:51 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C5EF860CA
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 22:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6bd045336c6so1834081a34.2
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 13:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693600905; x=1694205705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5dAvl/9xw971DH4LQIzvfjjkWM9xRLU6aKIxy2SYs2I=;
 b=qsfMbG2P7Nsun+CiA4vfxNIA8WFmwF6m1iz9Sy35D8k73xsZvJjtELGeYyt2x9T3aq
 bbAn/NiGmLsAc8TrZQGs0872t/r6NdJFPuCaK5IUZPoqCizNYA56lgrAj6qKTqjn77UD
 f2DFi2XRMhh+/cDm+mZ7Ufq28qjWv+VETOf3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693600905; x=1694205705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5dAvl/9xw971DH4LQIzvfjjkWM9xRLU6aKIxy2SYs2I=;
 b=k/G1FNZjsnKxyi0OTjVzWj/IZG+pAmxjmtrUQziIPF62aPH3F2Cyhr/pzRGJniGJD4
 7SazIrnotQ22W13ZZ7QchpMXB8ILCeGWxg5AmWrUd7Tn77x3F3vZDUfZUomL8MMyEXFO
 AL46xVkhMwsGN2ns/eeSBrRRPAJJfbdm5XkyW2giRLEzndPMKWI/cIdo9TtfKsaSIG80
 7E3zxhDw8RMRMMUawyHL3VXLSfNNU/i2CUmI7W+DAAgbD0zYQxcBK1TcvdUYRpuCspaT
 YCDlhMFWzT3aY9vJA+CbSYrVs18R4z1Y3t230RXH8Bmbfk1S1SNnE2jI+QaI0Wlfx9Ji
 asPA==
X-Gm-Message-State: AOJu0YyhL8tFnFCzedJdwSltOFB+KPnQttnurRu6CeUc9+ey1jngI085
 1Br7RaPFMTcyd71p1pCnQqxAapmArhykBrefilrLYQ==
X-Google-Smtp-Source: AGHT+IEwSjmMd4yvXv+USrPPxeO6UfWdLG+4c9dluh/nqJhja6d7DIM3yTu3DjqYZ2CUfs0cvTZZCw==
X-Received: by 2002:a05:6358:6f92:b0:13c:b54e:fe67 with SMTP id
 s18-20020a0563586f9200b0013cb54efe67mr3472973rwn.0.1693600905282; 
 Fri, 01 Sep 2023 13:41:45 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-4587-e14d-65a2-5068.res6.spectrum.com.
 [2603:6081:7b00:6400:4587:e14d:65a2:5068])
 by smtp.gmail.com with ESMTPSA id
 k66-20020a252445000000b00d071631665fsm1075707ybk.59.2023.09.01.13.41.43
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:41:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/3] Azure: Rework test_py job to publish its wrapper script
Date: Fri,  1 Sep 2023 16:41:41 -0400
Message-Id: <20230901204143.3617876-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Both to aide in debugging of any test.py issues as well as to make it
easier to split the current matrix in two, have a new job that creates
and publishes the current wrapper script we use for test.py jobs.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 161 ++++++++++++++++++++++++-------------------
 1 file changed, 90 insertions(+), 71 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 48cbdd41e191..cd9048964eea 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -244,6 +244,83 @@ stages:
     steps:
       - script: make pip
 
+  - job: create_test_py_wrapper_script
+    displayName: 'Create and stage a wrapper for test.py runs'
+    pool:
+      vmImage: $(ubuntu_vm)
+    steps:
+      - checkout: none
+      - script: |
+          cat << EOF > test.sh
+          #!/bin/bash
+          set -ex
+          # the below corresponds to .gitlab-ci.yml "before_script"
+          cd \${WORK_DIR}
+          git config --global --add safe.directory \${WORK_DIR}
+          git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
+          ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
+          ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
+          grub-mkimage --prefix=\"\" -o ~/grub_x86.efi -O i386-efi normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd
+          grub-mkimage --prefix=\"\" -o ~/grub_x64.efi -O x86_64-efi normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd
+          if [[ "\${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
+              wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.2/opensbi-1.2-rv-bin.tar.xz | tar -C /tmp -xJ;
+              export OPENSBI=/tmp/opensbi-1.2-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
+          fi
+          if [[ "\${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]]; then
+              wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.2/opensbi-1.2-rv-bin.tar.xz | tar -C /tmp -xJ;
+              export OPENSBI=/tmp/opensbi-1.2-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
+          fi
+          # the below corresponds to .gitlab-ci.yml "script"
+          cd \${WORK_DIR}
+          export UBOOT_TRAVIS_BUILD_DIR=/tmp/\${TEST_PY_BD}
+          if [ -n "\${BUILD_ENV}" ]; then
+              export \${BUILD_ENV};
+          fi
+          pip install -r tools/buildman/requirements.txt
+          tools/buildman/buildman -o \${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e --board \${TEST_PY_BD} \${OVERRIDE}
+          cp ~/grub_x86.efi \${UBOOT_TRAVIS_BUILD_DIR}/
+          cp ~/grub_x64.efi \${UBOOT_TRAVIS_BUILD_DIR}/
+          cp /opt/grub/grubriscv64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_riscv64.efi
+          cp /opt/grub/grubaa64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm64.efi
+          cp /opt/grub/grubarm.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm.efi
+          # create sdcard / spi-nor images for sifive unleashed using genimage
+          if [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]]; then
+              mkdir -p root;
+              cp \${UBOOT_TRAVIS_BUILD_DIR}/spl/u-boot-spl.bin .;
+              cp \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.itb .;
+              rm -rf tmp;
+              genimage --inputpath . --config board/sifive/unleashed/genimage_sdcard.cfg;
+              cp images/sdcard.img \${UBOOT_TRAVIS_BUILD_DIR}/;
+              rm -rf tmp;
+              genimage --inputpath . --config board/sifive/unleashed/genimage_spi-nor.cfg;
+              cp images/spi-nor.img \${UBOOT_TRAVIS_BUILD_DIR}/;
+          fi
+          if [[ "\${TEST_PY_BD}" == "coreboot" ]]; then
+              wget -O - "https://drive.google.com/uc?id=1uJ2VkUQ8czWFZmhJQ90Tp8V_zrJ6BrBH&export=download" |xz -dc >\${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom;
+              wget -O - "https://drive.google.com/uc?id=149Cz-5SZXHNKpi9xg6R_5XITWohu348y&export=download" >cbfstool;
+              chmod a+x cbfstool;
+              ./cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
+          fi
+          virtualenv -p /usr/bin/python3 /tmp/venv
+          . /tmp/venv/bin/activate
+          pip install -r test/py/requirements.txt
+          pip install pytest-azurepipelines
+          export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
+          export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci
+          # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k \$var" if not
+          ./test/py/test.py -ra -o cache_dir="\$UBOOT_TRAVIS_BUILD_DIR"/.pytest_cache --bd \${TEST_PY_BD} \${TEST_PY_ID} \${TEST_PY_TEST_SPEC:+"-k \${TEST_PY_TEST_SPEC}"} --build-dir "\$UBOOT_TRAVIS_BUILD_DIR" --report-dir "\$UBOOT_TRAVIS_BUILD_DIR"
+          # the below corresponds to .gitlab-ci.yml "after_script"
+          rm -rf /tmp/uboot-test-hooks /tmp/venv
+          EOF
+      - task: CopyFiles@2
+        displayName: 'Copy test.sh for later usage'
+        inputs:
+          contents: 'test.sh'
+          targetFolder: '$(Build.ArtifactStagingDirectory)'
+      - publish: '$(Build.ArtifactStagingDirectory)/test.sh'
+        displayName: 'Publish test.sh'
+        artifact: testsh
+
 - stage: test_py
   jobs:
   - job: test_py
@@ -372,81 +449,14 @@ stages:
           TEST_PY_ID: "--id qemu"
           TEST_PY_TEST_SPEC: "not sleep"
     steps:
+      - download: current
+        artifact: testsh
       - script: |
-          cat << EOF > test.sh
-          set -ex
-          # make environment variables available as tests are running inside a container
-          export WORK_DIR="${WORK_DIR}"
-          export TEST_PY_BD="${TEST_PY_BD}"
-          export TEST_PY_ID="${TEST_PY_ID}"
-          export TEST_PY_TEST_SPEC="${TEST_PY_TEST_SPEC}"
-          export OVERRIDE="${OVERRIDE}"
-          export BUILD_ENV="${BUILD_ENV}"
-          EOF
-          cat << "EOF" >> test.sh
-          # the below corresponds to .gitlab-ci.yml "before_script"
-          cd ${WORK_DIR}
-          git config --global --add safe.directory ${WORK_DIR}
-          git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
-          ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
-          ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
-          grub-mkimage --prefix=\"\" -o ~/grub_x86.efi -O i386-efi normal  echo lsefimmap lsefi lsefisystab efinet tftp minicmd
-          grub-mkimage --prefix=\"\" -o ~/grub_x64.efi -O x86_64-efi normal  echo lsefimmap lsefi lsefisystab efinet tftp minicmd
-          if [[ "${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
-              wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.2/opensbi-1.2-rv-bin.tar.xz | tar -C /tmp -xJ;
-              export OPENSBI=/tmp/opensbi-1.2-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
-          fi
-          if [[ "${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "${TEST_PY_BD}" == "sifive_unleashed" ]]; then
-              wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.2/opensbi-1.2-rv-bin.tar.xz | tar -C /tmp -xJ;
-              export OPENSBI=/tmp/opensbi-1.2-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
-          fi
-          # the below corresponds to .gitlab-ci.yml "script"
-          cd ${WORK_DIR}
-          export UBOOT_TRAVIS_BUILD_DIR=/tmp/${TEST_PY_BD};
-          if [ -n "${BUILD_ENV}" ]; then
-              export ${BUILD_ENV};
-          fi
-          pip install -r tools/buildman/requirements.txt
-          tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e --board ${TEST_PY_BD} ${OVERRIDE}
-          cp ~/grub_x86.efi ${UBOOT_TRAVIS_BUILD_DIR}/
-          cp ~/grub_x64.efi ${UBOOT_TRAVIS_BUILD_DIR}/
-          cp /opt/grub/grubriscv64.efi ${UBOOT_TRAVIS_BUILD_DIR}/grub_riscv64.efi
-          cp /opt/grub/grubaa64.efi ${UBOOT_TRAVIS_BUILD_DIR}/grub_arm64.efi
-          cp /opt/grub/grubarm.efi ${UBOOT_TRAVIS_BUILD_DIR}/grub_arm.efi
-          # create sdcard / spi-nor images for sifive unleashed using genimage
-          if [[ "${TEST_PY_BD}" == "sifive_unleashed" ]]; then
-              mkdir -p root;
-              cp ${UBOOT_TRAVIS_BUILD_DIR}/spl/u-boot-spl.bin .;
-              cp ${UBOOT_TRAVIS_BUILD_DIR}/u-boot.itb .;
-              rm -rf tmp;
-              genimage --inputpath . --config board/sifive/unleashed/genimage_sdcard.cfg;
-              cp images/sdcard.img ${UBOOT_TRAVIS_BUILD_DIR}/;
-              rm -rf tmp;
-              genimage --inputpath . --config board/sifive/unleashed/genimage_spi-nor.cfg;
-              cp images/spi-nor.img ${UBOOT_TRAVIS_BUILD_DIR}/;
-          fi
-          if [[ "${TEST_PY_BD}" == "coreboot" ]]; then
-              wget -O - "https://drive.google.com/uc?id=1uJ2VkUQ8czWFZmhJQ90Tp8V_zrJ6BrBH&export=download" |xz -dc >${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom;
-              wget -O - "https://drive.google.com/uc?id=149Cz-5SZXHNKpi9xg6R_5XITWohu348y&export=download" >cbfstool;
-              chmod a+x cbfstool;
-              ./cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f ${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
-          fi
-          virtualenv -p /usr/bin/python3 /tmp/venv
-          . /tmp/venv/bin/activate
-          pip install -r test/py/requirements.txt
-          pip install pytest-azurepipelines
-          export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
-          export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci;
-          # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if not
-          ./test/py/test.py -ra -o cache_dir="$UBOOT_TRAVIS_BUILD_DIR"/.pytest_cache --bd ${TEST_PY_BD} ${TEST_PY_ID} ${TEST_PY_TEST_SPEC:+"-k ${TEST_PY_TEST_SPEC}"} --build-dir "$UBOOT_TRAVIS_BUILD_DIR" --report-dir "$UBOOT_TRAVIS_BUILD_DIR";
-          # the below corresponds to .gitlab-ci.yml "after_script"
-          rm -rf /tmp/uboot-test-hooks /tmp/venv
-          EOF
-          cat test.sh
           # make current directory writeable to uboot user inside the container
           # as sandbox testing need create files like spi flash images, etc.
           # (TODO: clean up this in the future)
           chmod 777 .
+          chmod 755 $(Pipeline.Workspace)/testsh/test.sh
           # Filesystem tests need extra docker args to run
           set --
           if [[ "${TEST_PY_BD}" == "sandbox" ]]; then
@@ -462,7 +472,16 @@ stages:
               set -- "$@" --security-opt apparmor=unconfined
           fi
           # Some tests using libguestfs-tools need the fuse device to run
-          docker run "$@" --device /dev/fuse:/dev/fuse -v $PWD:$(work_dir) $(ci_runner_image) /bin/bash $(work_dir)/test.sh
+          docker run "$@" --device /dev/fuse:/dev/fuse \
+                         -v $PWD:$(work_dir) \
+                         -v $(Pipeline.Workspace):$(Pipeline.Workspace) \
+                         -e WORK_DIR="${WORK_DIR}" \
+                         -e TEST_PY_BD="${TEST_PY_BD}" \
+                         -e TEST_PY_ID="${TEST_PY_ID}" \
+                         -e TEST_PY_TEST_SPEC="${TEST_PY_TEST_SPEC}" \
+                         -e OVERRIDE="${OVERRIDE}" \
+                         -e BUILD_ENV="${BUILD_ENV}" $(ci_runner_image) \
+                         $(Pipeline.Workspace)/testsh/test.sh
         retryCountOnTaskFailure: 2 # QEMU may be too slow, etc.
 
 - stage: world_build
-- 
2.34.1

