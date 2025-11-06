Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80ECCCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 15:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA34C83BAD;
	Thu,  6 Nov 2025 16:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IvgvKanx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A2BC83B85; Thu,  6 Nov 2025 16:30:22 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE92983B85
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 16:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-29470bc80ceso13365925ad.1
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 07:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762443018; x=1763047818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T2diJi9bxS5uZQJrYiI8jqnvlPQ6QfytrBHmrWWjCKk=;
 b=IvgvKanxJ+oHHp160FXTvJTLuhC2nxdxXEfr/YviIngrudzElcu1eLjHIVdLf68vzW
 c/9widR3lSm6ecRlTf0Fd3hx/9JcB7MEqKNFYkVLgXpfjq1Rk3FvfdQmUytrQbtRUo39
 rSjpqIqY4mgjErWR0aYHPQ/Rj82TgjZqzIlpIIOisdNaNbImvc3FY4/rQAKSv7Z9M0OG
 SfOxaytoDD8ONq2m9nEQOKYLKm4rTiM3gVlPkgm0/OJAzwqZXx6tBKUki46P0nUOcDl2
 OzzAfmOZ+DxkNfCAsLiIAC0oFE+GWp8xPtuGfxGqcn8KM75Yps9sda/SCb8IJXiusBEI
 TYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762443018; x=1763047818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T2diJi9bxS5uZQJrYiI8jqnvlPQ6QfytrBHmrWWjCKk=;
 b=DQTOXl2NN6pyZDaTXUA2lnvgeqCCVe4k6FqMVpslswCkDOADwaBrZA0lmJPbQgrp4i
 hM8ei8a+LPdR9csYpxy9j8OL/KwBSrkfxXZkbDsiij86WJIPfTWbD1hfnaA0AdCy7AaJ
 dg6enOkoFdugAA9up4cKs7DyA5Un/wwF0IEwUM7sWtwHWurkG7q2SgOItoz0nRmPz2Au
 FP/pJWYEE81+DO035I9LHMywfr6EW6YiZj2sF7ve1WtAxWkzknE8sdziZKgS0BLnFFlp
 OrbSNSQAublHGXExXZBpefkj5sopcfF1HOt7AR754VOcxW0fc47ArecvcVyFsRAKS0w9
 gibg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5nVMeMvvDfDAa2FKa4QDb+0qNgrI9bKCUdzERYo+EIvZLJhBXv9SgR/gOTMdp0SwgO86pQAk=@lists.denx.de
X-Gm-Message-State: AOJu0YycsyJAygdvMXoqKxiHUfO4AtfXzI9eqi55cXU/Ey60Pq5g13Iy
 sXWfqO9YNnKlzUEX5tp5VREgAZFaESRnTONs+Z29kNdySeHIw4BGQ9sl
X-Gm-Gg: ASbGncv/o38rQf3z15i59CEiR3V6FVDCOvYgBSzSgkqM57/xVVI+F2OLLyIooOkZ1K5
 W1QUBw0CEOxbNvrwWGziwzUhpn1qokNSuBcmZgqKSGCY0UzhQivCMjau5FKjRwEpQP+UV42U9ZB
 bF3J7jXXmqBKKvBGk+7NwA1nMGmzvYbrzxwOKdHdrk3MgCH1RJV4VVTLr9lZ8e6RbX/ICh4H8d4
 qkJxlGQ2zs+ePNosuk2SVk6088QGlVavFT3Yu6Y1jYhv0+kFNeWgElHu4dbQ8E0V+kfFJOxO7o+
 4U9KVfp3n1gKU5Zh3utUI2tzM7uJ0Z1AvPl6I1+HiR1/O2ozBsbmMouUHlUWrMdykLtclIU/JVX
 i7zIhpQ1Jom1mv/fWv7ipP0vPQXd3SxMZTRIj+FRoNFDI6bDXkh0nRHz4XLeKH6zPlCme2A4=
X-Google-Smtp-Source: AGHT+IE2A+UDyqvfVvfaj5SpiVF2I9G/L9qR87ZhUMrdcxTiN+udHMCBvs2wAmykyGSk9CAzjfkq4w==
X-Received: by 2002:a17:902:ce02:b0:272:d27d:48de with SMTP id
 d9443c01a7336-296510437admr53679765ad.18.1762443018145; 
 Thu, 06 Nov 2025 07:30:18 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29650967e11sm33024855ad.8.2025.11.06.07.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 07:30:17 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: [PATCH 1/2] qemu: arm: Rename QEMU arm* defconfig files
Date: Thu,  6 Nov 2025 23:30:08 +0800
Message-Id: <20251106153009.887102-1-bmeng.cn@gmail.com>
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
---

 MAINTAINERS                                                 | 2 +-
 arch/arm/dts/qemu-arm.dts                                   | 2 +-
 arch/arm/dts/qemu-arm64.dts                                 | 2 +-
 board/emulation/qemu-arm/MAINTAINERS                        | 2 +-
 ...{qemu_arm64_acpi_defconfig => qemu-arm64_acpi_defconfig} | 2 +-
 configs/{qemu_arm64_defconfig => qemu-arm64_defconfig}      | 0
 ...{qemu_arm64_lwip_defconfig => qemu-arm64_lwip_defconfig} | 2 +-
 configs/{qemu_arm_defconfig => qemu-arm_defconfig}          | 0
 doc/board/emulation/qemu-arm.rst                            | 6 +++---
 doc/develop/driver-model/virtio.rst                         | 6 +++---
 doc/develop/uefi/uefi.rst                                   | 2 +-
 tools/docker/Dockerfile                                     | 4 ++--
 12 files changed, 15 insertions(+), 15 deletions(-)
 rename configs/{qemu_arm64_acpi_defconfig => qemu-arm64_acpi_defconfig} (54%)
 rename configs/{qemu_arm64_defconfig => qemu-arm64_defconfig} (100%)
 rename configs/{qemu_arm64_lwip_defconfig => qemu-arm64_lwip_defconfig} (80%)
 rename configs/{qemu_arm_defconfig => qemu-arm_defconfig} (100%)

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
index d2384219c06..fca9fcb66c6 100644
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
-- 
2.34.1

