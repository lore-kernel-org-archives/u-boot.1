Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852DFC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 19:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B9080F9C;
	Tue, 22 Apr 2025 21:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lj6gVizi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D1E180FDA; Tue, 22 Apr 2025 21:37:03 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 676C880F6B
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 21:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-401c43671ecso116324b6e.0
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745350619; x=1745955419; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0zJKuO0yDiJZexMdqoFFkAOgEIhVJW3slZ2NdO/ZuY0=;
 b=Lj6gVizi0Y+LMhDduKzxb+m7IML0cAEsGwso7XHxDsovdM2Eb22rg1qPwf0UTAh14l
 UFXFwZH9Gw/lqTQJwjCdw+blJdAwDRouB+nsGVaC136wrer9tsx7M7R9i6Xc4U6I+BsS
 RPtA2lf9ff2MOADCSHsLjozpHBu/4ujML6UmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350619; x=1745955419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0zJKuO0yDiJZexMdqoFFkAOgEIhVJW3slZ2NdO/ZuY0=;
 b=pGkXbCg6PEQrRYfmGRHQZFJSeuGqrzmzMYJOnC0oeniMnP7AKCjOnztl0dZcuHQ9rv
 mudq3tdR5zdpCTld9pS6dK3y9zrb2O2jSwzJ5aNRXyTxqn8h6kjtJr48V6zVybXt/JO0
 Sa/DKMoTNwBSqcggWNHdYhufq1F8xxA/eWHqmYIIEJWvPQS9ejKSh1nvnM2LsyYxVPCG
 Pinnl/TgW/M9zrRIRqVvBctT04PLBiI5dXjwqaId/rewJXnD/8sezRkL0DzboNR3YOXv
 89LLV3jf52v3E2PrwcXAGO5BQ1V49kq6rd4lqJjjYlPwxF9KF8AbZ7ammUlcr4u6GA+8
 PRqA==
X-Gm-Message-State: AOJu0Yyve9krnJChDyWtMKb0zFN8Bfcag4uxkBTWtWoKSE9jGUGQ6qa7
 YGD9tj5/mubH4xaT3QVFvQhKZMLegiqUfNNrMffm1FWl40iPpySryuSrjxPkTfEFspU4HAL2NM7
 9
X-Gm-Gg: ASbGnct/yRpeVe1/TuB/XiEJFlQXSb7bbn3Ihl7OSqfAx6wJzTlonzpJPQ2QVm3o70q
 7z7DsmVLui03borB0HxCpaXe0AUYVCTNideS1NkVzoBdxbHJXQK6QaFPvB6WHKpfDIaF4n0rMNv
 TYTlohgDzHJj4wfEC2S7IeJV6Ln2j99QMzqu3pP3+JKY8ocQwYqCOAoTWNNviLa4PsSu85yvsoN
 F4jOkZO6/19Y0ixx2QG9EFT2dbr3UMMDYdHnLOoUPslZ2C35xW4Ui16uTKVr4gWb6t4gE16/KIm
 g5L4xQ/Nq4KF/hmHUGb40gcoLXOala2FckmC0dog8nTaDpz1mJVaYJS/bJYMmTjmeDg2CACvAgC
 5/rKD
X-Google-Smtp-Source: AGHT+IFkX6D6E57eBcavWHk8Gg6BuIttb9TuDW/RRUB5g7QFu8gBy4uL9w0dgr0tiCQSlt/qj6YGZA==
X-Received: by 2002:a05:6808:80aa:b0:3fa:1d22:6d28 with SMTP id
 5614622812f47-401e410f50emr116215b6e.18.1745350618952; 
 Tue, 22 Apr 2025 12:36:58 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401beeaf8f2sm2217400b6e.10.2025.04.22.12.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:36:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Harrison Mutai <harrison.mutai@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, nd <nd@arm.com>,
 Manish Pandey <Manish.Pandey2@arm.com>
Subject: [PATCH] Docker, CI: Add vexpress_fvp / vexpress_fvp_bloblist support
Date: Tue, 22 Apr 2025 13:36:56 -0600
Message-ID: <20250422193657.512324-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This adds the vexpress_fvp and vexpress_fvp_bloblist platforms to the
list of platforms we test via emulator in CI. In order to do this we
need to first have our container runtime have TF-A builds for the
vexpress_fvp platform, both with and without transfer list support as
well as installing "telnet" so that we can access console. In the CI
files we check for the existence of /opt/tf-a/${TEST_PY_BD} and if
found, copy bl1.bin and fip.bin to /tmp and set the variables so that we
can later run FVP to run.

Note that we currently disable the hostfs (semihosting) tests as they
trigger a bug in FVP. This has been reported upstream, and can be
enabled when fixed.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Harrison Mutai <harrison.mutai@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: nd <nd@arm.com>
Cc: Manish Pandey <Manish.Pandey2@arm.com>
---
 .azure-pipelines.yml    | 13 +++++++++++++
 .gitlab-ci.yml          | 23 +++++++++++++++++++++++
 tools/docker/Dockerfile | 17 +++++++++++++----
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index cb787d32f142..0a9f7b508ddd 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -307,6 +307,13 @@ stages:
               /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
               /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
           fi
+          # If we have TF-A binaries, we need to use them.
+          if [[ -d /opt/tf-a/"\${TEST_PY_BD}" ]]; then
+            cp /opt/tf-a/"\${TEST_PY_BD}"/fip.bin /opt/tf-a/"\${TEST_PY_BD}"/bl1.bin /tmp;
+            export fip=/tmp/fip.bin;
+            export bl1=/tmp/bl1.bin;
+            export PATH=/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:\${PATH};
+          fi
           export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
           export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci
           # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k \$var" if not
@@ -428,6 +435,12 @@ stages:
           TEST_PY_BD: "vexpress_ca9x4"
           TEST_PY_ID: "--id qemu"
           TEST_PY_TEST_SPEC: "not sleep"
+        vexpress_fvp:
+          TEST_PY_BD: "vexpress_fvp"
+          TEST_PY_TEST_SPEC: "not sleep and not hostfs"
+        vexpress_fvp_bloblist:
+          TEST_PY_BD: "vexpress_fvp_bloblist"
+          TEST_PY_TEST_SPEC: "not sleep and not hostfs"
         integratorcp_cm926ejs:
           TEST_PY_BD: "integratorcp_cm926ejs"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5f3418e482fe..0268938fea99 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -96,6 +96,13 @@ stages:
         /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
         /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f ${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
       fi
+    # If we have TF-A binaries, we need to use them.
+    - if [[ -d /opt/tf-a/"${TEST_PY_BD}" ]]; then
+        cp /opt/tf-a/"${TEST_PY_BD}"/fip.bin /opt/tf-a/"${TEST_PY_BD}"/bl1.bin /tmp/;
+        export fip=/tmp/fip.bin;
+        export bl1=/tmp/bl1.bin;
+        export PATH=/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:${PATH};
+      fi
     # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if not
     - export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
       export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci;
@@ -504,6 +511,22 @@ sifive_unleashed_spi-nor test.py:
     TEST_PY_ID: "--id spi-nor_qemu"
   <<: *buildman_and_testpy_dfn
 
+vexpress_fvp test.py:
+  variables:
+    TEST_PY_BD: "vexpress_fvp"
+    TEST_PY_TEST_SPEC: "not sleep and not hostfs"
+  tags:
+    - ${DEFAULT_AMD64_TAG}
+  <<: *buildman_and_testpy_dfn
+
+vexpress_fvp_bloblist test.py:
+  variables:
+    TEST_PY_BD: "vexpress_fvp_bloblist"
+    TEST_PY_TEST_SPEC: "not sleep and not hostfs"
+  tags:
+    - ${DEFAULT_AMD64_TAG}
+  <<: *buildman_and_testpy_dfn
+
 xilinx_zynq_virt test.py:
   variables:
     TEST_PY_BD: "xilinx_zynq_virt"
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index be46135d6a52..37076de01011 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -90,6 +90,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	help2man \
 	iasl \
 	imagemagick \
+	inetutils-telnet \
 	iputils-ping \
 	libconfuse-dev \
 	libgit2-dev \
@@ -233,10 +234,18 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
 	cd /tmp/tf-a/ && \
 	git checkout v2.12.0 && \
-	cd tools/fiptool && \
-	make -j$(nproc) && \
-	mkdir -p /usr/local/bin && \
-	cp fiptool /usr/local/bin && \
+	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
+		PLAT=fvp BL33=/dev/null -j$(nproc) all fip && \
+	mkdir -p /usr/local/bin /opt/tf-a/vexpress_fvp && \
+	cp tools/fiptool/fiptool /usr/local/bin && \
+	cp build/fvp/release/fip.bin build/fvp/release/bl1.bin \
+		/opt/tf-a/vexpress_fvp/ && \
+	rm -rf build/fvp && \
+	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
+		PLAT=fvp BL33=/dev/null TRANSFER_LIST=1 -j$(nproc) all fip && \
+	mkdir -p /opt/tf-a/vexpress_fvp_bloblist && \
+	cp build/fvp/release/fip.bin build/fvp/release/bl1.bin \
+		/opt/tf-a/vexpress_fvp_bloblist/ && \
 	rm -rf /tmp/tf-a
 
 # Download the Arm Architecture FVP platform. This file is double compressed.
-- 
2.43.0

