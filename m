Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F8FCCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 12:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45EB883A41;
	Mon, 10 Nov 2025 13:58:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ydu3/cUX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B4883A5C; Mon, 10 Nov 2025 13:58:42 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC90283A1A
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 13:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-343806688c5so1261065a91.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 04:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762779518; x=1763384318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/PDXpZJZRoIym6Ks7rStYx/tg16ljbtAffO06w3+u3w=;
 b=Ydu3/cUXLaVUoLOwtd15x11XGm0LIY0wbgXE/qE3HlIy6x3MvrGHsehkxcXQ7k9QlE
 l+5uNtGxqAvQ/Lt3ByYF2PWY+1+R4GJ4GIGJtGwkUnSG1b4z5CSOKmL3nFRUvqOocIqS
 6igPfYvg3gau+CCk7UuQAM+ACEp2vQj97O14CpiS6qBz5+mRPqVTfWXpiNouoLnKmRUS
 VBlW5DqRdGLusK/2kGPmA20NkI+yknIFBwYKbYKOJytVLyw8hQbpH7cmOf1wXkqhQ98S
 M5fGhFLr3wcCIA4gJ/xh9LbtbP4yyhOGKhzF7ArNDM63K10Lipq4/IBC2meGMMmUI6rv
 QVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762779518; x=1763384318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/PDXpZJZRoIym6Ks7rStYx/tg16ljbtAffO06w3+u3w=;
 b=Hsb4fb1p1w+q0Saj1NcGlRNDYGZL+IwJnzw7JP6Tlb5gsKlH1KlbJvOXz0KnDK6Jq/
 qA24nLoa7HKKIkftNjhxXcqEzaKfmyzmHx8LPMtQFtuPBh23yw2lgJtOmmUMdLpMcx/Y
 ZnkmdeDvY3+y4yTqpqvQrtZ+r2xfhJT0Vl/IemobAXQUsL6Poozh4azd5/ASCFk2TJeV
 6uOfqVCKf9mSl8CjHgczeOJJydcqF1DqGk53T6GvgtH+wDJbcCcltFp6E7Z6cT6rPCYG
 XIQVHC7WFW9RWct8AQZQrepvHWbDdZ9USSos4tan4rb/sLLlL5kfl65goFjlY+wyg/lZ
 P+bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYlIN/IEVu4OBwyZkJfJ29es8osz5pmJAcwDGHYRxUp57tQKaPaS9++kZsjPgghHV8hMLoNz0=@lists.denx.de
X-Gm-Message-State: AOJu0YzT9rz1ZgBxYl3qGbUjMKyw3Wa19qo6qCG11N7Tq2NkcZdtz2Vw
 tDXo3uGrZA5z+Dcwh95lYnrvXrekZg20QnebhgWNTekp85G9WU793Vkr
X-Gm-Gg: ASbGnctdRucX0zq9MJRwR6QcLmawrRevFDwlpMKp+c5L66glPUbiLyrc/H5J99Lt8Jc
 BT9ez888RkXQZC0+An21MKixZbQLt5uBH4JEkjrR88DNIUnAjv4hXRWSCMhlUgsaTXC54FgD8dO
 j1OoTHQeXv5FZf2fgeXaTPGyOzK8a6YQq+n85FjY+KmQT/VBCKb3zVJYR/i9WY0XDK98+nTDrQD
 TCp2V/yn+ZyncbRnLHfzPXJqF/TRsNil20pQGzU2hgJUQBk/5DIi2xkpKlRJR2syPdvXHO3KX03
 N/Kj+nvGunTD66Sn7lrJBVpOZOjsk34LjM9pCbvMQtx1S7RC2Kb1+X1Xim8xQndBe0O7IN3yDMF
 3yW2itstcJnE0CAERfm7I2hBx9l6FexMT9YdOXVBuOr2QPmm6xLcFo9HA1+FGXaAxMsPF9qN/v5
 6Lik0zQg==
X-Google-Smtp-Source: AGHT+IFCgjOsocQe1Pw8qmZwAZssemSKyRenYuumu7nY2azYD93wnolR1WA8DCXcQLUlEeQpptT9Ew==
X-Received: by 2002:a17:90b:314a:b0:340:d511:e164 with SMTP id
 98e67ed59e1d1-3436cbf339amr11045808a91.19.1762779518183; 
 Mon, 10 Nov 2025 04:58:38 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343abec3836sm1865850a91.18.2025.11.10.04.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 04:58:37 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 1/2] qemu: arm: Rename QEMU arm* defconfig files
Date: Mon, 10 Nov 2025 20:58:27 +0800
Message-Id: <20251110125828.1643327-1-bmeng.cn@gmail.com>
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

Other QEMU defconfig files use a hyphen between "qemu" and the
architecture name, but ARM uses an underscore. Rename the ARM
defconfigs for consistency.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---
Tested with
- an updated u-boot ci runner docker image
- an updated u-boot-test-hooks repo with patches below
  http://patchwork.ozlabs.org/project/uboot/list/?series=481545

Tested result on azure: PASS
https://dev.azure.com/bmeng/GitHub/_build/results?buildId=523&view=results

Changes in v2:
- Add missing azure and gitlab ci changes

 .azure-pipelines.yml                          | 24 +++++++++----------
 .gitlab-ci.yml                                | 24 +++++++++----------
 MAINTAINERS                                   |  2 +-
 arch/arm/dts/qemu-arm.dts                     |  2 +-
 arch/arm/dts/qemu-arm64.dts                   |  2 +-
 board/emulation/qemu-arm/MAINTAINERS          |  2 +-
 ...pi_defconfig => qemu-arm64_acpi_defconfig} |  2 +-
 ...u_arm64_defconfig => qemu-arm64_defconfig} |  0
 ...ip_defconfig => qemu-arm64_lwip_defconfig} |  2 +-
 ...{qemu_arm_defconfig => qemu-arm_defconfig} |  0
 doc/board/emulation/qemu-arm.rst              |  6 ++---
 doc/develop/driver-model/virtio.rst           |  6 ++---
 doc/develop/uefi/uefi.rst                     |  2 +-
 tools/docker/Dockerfile                       |  8 +++----
 14 files changed, 41 insertions(+), 41 deletions(-)
 rename configs/{qemu_arm64_acpi_defconfig => qemu-arm64_acpi_defconfig} (54%)
 rename configs/{qemu_arm64_defconfig => qemu-arm64_defconfig} (100%)
 rename configs/{qemu_arm64_lwip_defconfig => qemu-arm64_lwip_defconfig} (80%)
 rename configs/{qemu_arm_defconfig => qemu-arm_defconfig} (100%)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 3b684ec73ba..1009938f332 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -254,9 +254,9 @@ stages:
           cd \${WORK_DIR}
           git config --global --add safe.directory \${WORK_DIR}
           git clone --depth=1 https://github.com/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
-          # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
-          # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
-          ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+          # qemu-arm64_lwip_defconfig is the same as qemu-arm64 but with NET_LWIP enabled.
+          # The test config and the boardenv file from qemu-arm64 can be re-used so create symlinks
+          ln -s conf.qemu-arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu-arm64_lwip_na
           ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
@@ -470,20 +470,20 @@ stages:
           TEST_PY_BD: "integratorcp_cm926ejs"
           TEST_PY_ID: "--id qemu"
           TEST_PY_TEST_SPEC: "not sleep"
-        qemu_arm:
-          TEST_PY_BD: "qemu_arm"
+        qemu-arm:
+          TEST_PY_BD: "qemu-arm"
           TEST_PY_TEST_SPEC: "not sleep"
-        qemu_arm64:
-          TEST_PY_BD: "qemu_arm64"
+        qemu-arm64:
+          TEST_PY_BD: "qemu-arm64"
           TEST_PY_TEST_SPEC: "not sleep"
-        qemu_arm64_lwip:
-          TEST_PY_BD: "qemu_arm64_lwip"
+        qemu-arm64_lwip:
+          TEST_PY_BD: "qemu-arm64_lwip"
           TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
-        qemu_arm64_tfa_fw_handoff:
-          TEST_PY_BD: "qemu_arm64"
+        qemu-arm64_tfa_fw_handoff:
+          TEST_PY_BD: "qemu-arm64"
           TEST_PY_ID: "--id fw_handoff_tfa_optee"
           TEST_PY_TEST_SPEC: "test_fw_handoff"
-        qemu_arm_sbsa_ref:
+        qemu-arm_sbsa_ref:
           TEST_PY_BD: "qemu-arm-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
         qemu_m68k:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0337380f98e..5f91780c764 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -35,9 +35,9 @@ stages:
     # Clone uboot-test-hooks
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     - git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
-    # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
-    # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
-    - ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+    # qemu-arm64_lwip_defconfig is the same as qemu-arm64 but with NET_LWIP enabled.
+    # The test config and the boardenv file from qemu-arm64 can be re-used so create symlinks
+    - ln -s conf.qemu-arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu-arm64_lwip_na
     - ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
     - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
     - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
@@ -377,32 +377,32 @@ integratorcp_cm926ejs test.py:
     TEST_PY_ID: "--id qemu"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm test.py:
+qemu-arm test.py:
   variables:
-    TEST_PY_BD: "qemu_arm"
+    TEST_PY_BD: "qemu-arm"
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm64 test.py:
+qemu-arm64 test.py:
   variables:
-    TEST_PY_BD: "qemu_arm64"
+    TEST_PY_BD: "qemu-arm64"
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm64_lwip test.py:
+qemu-arm64_lwip test.py:
   variables:
-    TEST_PY_BD: "qemu_arm64_lwip"
+    TEST_PY_BD: "qemu-arm64_lwip"
     TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm64_tfa_fw_handoff test.py:
+qemu-arm64_tfa_fw_handoff test.py:
   variables:
-    TEST_PY_BD: "qemu_arm64"
+    TEST_PY_BD: "qemu-arm64"
     TEST_PY_ID: "--id fw_handoff_tfa_optee"
     TEST_PY_TEST_SPEC: "test_fw_handoff"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm_sbsa test.py:
+qemu-arm_sbsa test.py:
   variables:
     TEST_PY_BD: "qemu-arm-sbsa"
     TEST_PY_TEST_SPEC: "not sleep"
diff --git a/MAINTAINERS b/MAINTAINERS
index 60772a494a3..1be1003fa5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1444,7 +1444,7 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-net.git
 F:	cmd/lwip/
 F:	cmd/net-lwip.c
-F:	configs/qemu_arm64_lwip_defconfig
+F:	configs/qemu-arm64_lwip_defconfig
 F:	drivers/net/sandbox-lwip.c
 F:	include/net-lwip.h
 F:	lib/lwip/Makefile
diff --git a/arch/arm/dts/qemu-arm.dts b/arch/arm/dts/qemu-arm.dts
index 230c630f04f..cbe023317d7 100644
--- a/arch/arm/dts/qemu-arm.dts
+++ b/arch/arm/dts/qemu-arm.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR MIT
 /*
- * Empty device tree for qemu_arm
+ * Empty device tree for qemu-arm
 
  * Copyright 2021 Google LLC
  */
diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
index 95fcf53ed74..382d131f47f 100644
--- a/arch/arm/dts/qemu-arm64.dts
+++ b/arch/arm/dts/qemu-arm64.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR MIT
 /*
- * Empty device tree for qemu_arm64
+ * Empty device tree for qemu-arm64
 
  * Copyright 2021 Google LLC
  */
diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
index 538769f8040..b2b1fce75cf 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -5,5 +5,5 @@ F:	board/emulation/qemu-arm/
 F:	board/emulation/common/
 F:	include/configs/qemu-arm.h
 F:	include/configs/qemu-sbsa.h
-F:	configs/qemu_arm*
+F:	configs/qemu-arm*
 F:	configs/qemu-arm-sbsa_defconfig
diff --git a/configs/qemu_arm64_acpi_defconfig b/configs/qemu-arm64_acpi_defconfig
similarity index 54%
rename from configs/qemu_arm64_acpi_defconfig
rename to configs/qemu-arm64_acpi_defconfig
index f85f2913530..ef4c9f156c5 100644
--- a/configs/qemu_arm64_acpi_defconfig
+++ b/configs/qemu-arm64_acpi_defconfig
@@ -1,2 +1,2 @@
-#include <configs/qemu_arm64_defconfig>
+#include <configs/qemu-arm64_defconfig>
 #include <board/emulation/configs/acpi.config>
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu-arm64_defconfig
similarity index 100%
rename from configs/qemu_arm64_defconfig
rename to configs/qemu-arm64_defconfig
diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu-arm64_lwip_defconfig
similarity index 80%
rename from configs/qemu_arm64_lwip_defconfig
rename to configs/qemu-arm64_lwip_defconfig
index e8f976efaf7..c00d0a9da57 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu-arm64_lwip_defconfig
@@ -1,4 +1,4 @@
-#include <configs/qemu_arm64_defconfig>
+#include <configs/qemu-arm64_defconfig>
 
 CONFIG_ARM=y
 CONFIG_ARCH_QEMU=y
diff --git a/configs/qemu_arm_defconfig b/configs/qemu-arm_defconfig
similarity index 100%
rename from configs/qemu_arm_defconfig
rename to configs/qemu-arm_defconfig
diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
index 1c91c7f3ac6..8c2fe8cccf3 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -30,12 +30,12 @@ Set the CROSS_COMPILE environment variable as usual, and run:
 
 - For ARM::
 
-    make qemu_arm_defconfig
+    make qemu-arm_defconfig
     make
 
 - For AArch64::
 
-    make qemu_arm64_defconfig
+    make qemu-arm64_defconfig
     make
 
 Running U-Boot
@@ -102,7 +102,7 @@ Booting distros
 ---------------
 
 It is possible to install and boot a standard Linux distribution using
-qemu_arm64 by setting up a root disk::
+qemu-arm64 by setting up a root disk::
 
     qemu-img create root.img 20G
 
diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index 9a5e3240c3c..8750228693b 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -32,8 +32,8 @@ network and block device, the most two commonly used devices, are supported.
 
 The following QEMU targets are supported.
 
-  - qemu_arm_defconfig
-  - qemu_arm64_defconfig
+  - qemu-arm_defconfig
+  - qemu-arm64_defconfig
   - qemu-arm-sbsa_defconfig
   - qemu-riscv32_defconfig
   - qemu-riscv64_defconfig
@@ -51,7 +51,7 @@ variable being properly set to a working toolchain for ARM:
 
 .. code-block:: bash
 
-  $ make qemu_arm_defconfig
+  $ make qemu-arm_defconfig
   $ make
 
 You can even create a QEMU ARM target with VirtIO devices showing up on both
diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 3ca22b572a9..4505fa588ba 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -713,7 +713,7 @@ HTTP(s) Boot can be activated by specifying::
 
 For QEMU targets there's a Kconfig that supports this by default::
 
-    make qemu_arm64_lwip_defconfig
+    make qemu-arm64_lwip_defconfig
 
 The commands and functionality are similar to the legacy stack, with the notable
 exception of not having to define an "httpserverip" if you are trying to resolve
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index d2384219c06..39badd57ee5 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -228,7 +228,7 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
 
-# Build OP-TEE for qemu_arm64
+# Build OP-TEE for qemu-arm64
 RUN git clone --depth=1 https://github.com/OP-TEE/optee_os.git /tmp/optee_os \
 	-b 4.7.0 && \
 	cd /tmp/optee_os/ && \
@@ -241,7 +241,7 @@ RUN git clone --depth=1 https://github.com/OP-TEE/optee_os.git /tmp/optee_os \
 		CFG_REE_FS=n CFG_CORE_ARM64_PA_BITS=48  \
 		CFG_TEE_CORE_LOG_LEVEL=2
 
-# Build fiptool, bl1 and fip for fvp and qemu_arm64
+# Build fiptool, bl1 and fip for fvp and qemu-arm64
 RUN git clone --depth=1 -b mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git /tmp/mbedtls
 RUN git clone --depth=1 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a \
 	-b v2.13.0 && \
@@ -271,9 +271,9 @@ RUN git clone --depth=1 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.
 		MBOOT_EL_HASH_ALG=sha256 \
 		MBEDTLS_DIR=/tmp/mbedtls \
 		-j$(nproc) all fip && \
-	mkdir -p /opt/tf-a/qemu_arm64_fw_handoff_tfa_optee && \
+	mkdir -p /opt/tf-a/qemu-arm64_fw_handoff_tfa_optee && \
 	cp build/qemu/release/fip.bin build/qemu/release/bl1.bin \
-		/opt/tf-a/qemu_arm64_fw_handoff_tfa_optee/ && \
+		/opt/tf-a/qemu-arm64_fw_handoff_tfa_optee/ && \
 	rm -rf /tmp/optee_os && \
 	rm -rf /tmp/mbedtls && \
 	rm -rf /tmp/tf-a
-- 
2.34.1

