Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A87C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 16:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 199BA87A0B;
	Thu,  4 Jan 2024 17:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="H/d1vmzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56032879A9; Thu,  4 Jan 2024 16:54:16 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C949879BE
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rLQ2t-0003As-27; Thu, 04 Jan 2024 10:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=e6093ZPEKRoQToZmeYfo5J02ZfJ3ZopPfWHChblNbOM=; b=H/d1vmzlnbkCEJtJPjEh
 OFm8yXR9UCruomt4J8No9mA1Z5KQGOTQmw6FS9rkIHYompSJ1K8E081uhLZvivShiVHEAsqmy2huX
 Py5Pg09RnPiVRqAIscCxLbMdWERy3SJnn3Q4k3u23uvhgKywWpmWF7YDVmUdH8p83L5+TljgmCX+u
 8e6/uIN5JMWAYZ7nGxMElEc+dH9x7G5F4XeiTzWs8LwT+92/9Dh4rZnlQVv3wO0NGUiosVBjzC9GJ
 HLbfXoAgIBMkXZ3+6HkcCEftAK1mWxG3n2XNRJDQbcrdiH0k9E6xF+OJSknnTV+NHf99g9UVn7ycs
 5x6yXgwbR3esng==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 3/4] imx9: imx93_evk: Add binman support.
Date: Thu,  4 Jan 2024 16:53:56 +0100
Message-ID: <20240104155357.21865-4-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240104155357.21865-1-othacehe@gnu.org>
References: <20240104155357.21865-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Jan 2024 17:10:51 +0100
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

From: Mathieu Othacehe <m.othacehe@gmail.com>

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi |  2 +
 arch/arm/mach-imx/imx9/Kconfig           |  1 +
 configs/imx93_11x11_evk_defconfig        |  2 +
 configs/imx93_11x11_evk_ld_defconfig     |  2 +
 doc/board/nxp/imx93_11x11_evk.rst        | 68 ++++++++++++++++++++++++
 doc/board/nxp/index.rst                  |  1 +
 6 files changed, 76 insertions(+)
 create mode 100644 doc/board/nxp/imx93_11x11_evk.rst

diff --git a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
index 4ecb53ed8be..a99ba99bfb4 100644
--- a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
@@ -3,6 +3,8 @@
  * Copyright 2022 NXP
  */
 
+#include "imx93-u-boot.dtsi"
+
 / {
 	wdt-reboot {
 		compatible = "wdt-reboot";
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index c51f80f311a..7ba38355398 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -29,6 +29,7 @@ choice
 
 config TARGET_IMX93_11X11_EVK
 	bool "imx93_11x11_evk"
+        select BINMAN
 	select IMX93
 
 endchoice
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 3c9b09eec7a..e53eea120d7 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -8,6 +8,8 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/container.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx93-11x11-evk"
 CONFIG_SPL_TEXT_BASE=0x2049A000
diff --git a/configs/imx93_11x11_evk_ld_defconfig b/configs/imx93_11x11_evk_ld_defconfig
index 37aa1efa7fd..c24b722600c 100644
--- a/configs/imx93_11x11_evk_ld_defconfig
+++ b/configs/imx93_11x11_evk_ld_defconfig
@@ -8,6 +8,8 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x400000
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/container.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx93-11x11-evk"
 CONFIG_SPL_TEXT_BASE=0x2049A000
diff --git a/doc/board/nxp/imx93_11x11_evk.rst b/doc/board/nxp/imx93_11x11_evk.rst
new file mode 100644
index 00000000000..fb0ecf8af58
--- /dev/null
+++ b/doc/board/nxp/imx93_11x11_evk.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx93_11x11_evk
+=======================
+
+U-Boot for the NXP i.MX93 EVK on the 11x11mm board
+
+Quick Start
+-----------
+
+- Get and Build the ARM Trusted firmware
+- Get the DDR firmware
+- Get ahab-container.img
+- Build U-Boot
+- Boot
+
+Get and Build the ARM Trusted firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.8
+
+.. code-block:: bash
+
+   $ unset LDFLAGS
+   $ make PLAT=imx93 bl31
+   $ cp build/imx93/release/bl31.bin $(srctree)
+
+Get the DDR firmware
+--------------------
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.21.bin
+   $ chmod +x firmware-imx-8.21.bin
+   $ ./firmware-imx-8.21.bin
+   $ cp firmware-imx-8.21/firmware/ddr/synopsys/lpddr4*.bin $(srctree)
+
+Get ahab-container.img
+---------------------------------------
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-sentinel-0.10.bin
+   $ chmod +x firmware-sentinel-0.10.bin
+   $ ./firmware-sentinel-0.10.bin
+   $ cp firmware-sentinel-0.10/mx93a0-ahab-container.img $(srctree)
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx93_11x11_evk_defconfig
+   $ make
+
+Burn the flash.bin to MicroSD card offset 32KB:
+
+.. code-block:: bash
+
+   $ dd if=flash.bin of=/dev/sd[x] bs=1024 seek=32 conv=notrunc
+
+Boot
+----
+
+Set Boot switch to SD boot
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 4514b8951ba..3bd9ed3c873 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -11,6 +11,7 @@ NXP Semiconductors
    imx8mp_evk
    imx8mq_evk
    imx8qxp_mek
+   imx93_11x11_evk
    imxrt1020-evk
    imxrt1050-evk
    ls1046ardb
-- 
2.25.1

