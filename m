Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC873D3C92D
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 17:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A41A88FC7;
	Sun, 20 Oct 2024 19:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="goobXQwj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d7ytH72a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C14188FB8; Sun, 20 Oct 2024 19:28:17 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8381C88E6B
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 19:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XWllM1tz1z9sZZ;
 Sun, 20 Oct 2024 19:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729445295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CiRNToE2c0cxJIjLjMKPSrHbNxmLaKryXf5XadZCxV0=;
 b=goobXQwjfGAmC2kc2lsTJlpjpCj1MWjA1zcko0TFmuA0F1pjqV+QJ5O0EsvixHkRpdmvjJ
 yB4bc07vSGGBHiHEqnnCqdoWINdAflViv/zvlK3FtPZfxc5yoI9v/VSAgpRZPyhE/rt4fA
 A2I8STIqTfFRkDNOihO83+kXNgD1n5kzqC6Jm3Tkd6D5+/pA5XoKXpueFPNy12KDSnVux9
 CA1TrndDGsmoh1NHov3f8PZr72C/aSHNP9Q3N0QtAvLW9E7PxVZHk/NZJUooA4wF1jwuFF
 fTbmepk0Z5CJ4k6QGYT1ZSu842Ov1WPuRZITr6vxvMRGKaxMsc4QEkg34bFwqg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729445293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CiRNToE2c0cxJIjLjMKPSrHbNxmLaKryXf5XadZCxV0=;
 b=d7ytH72ae5/xhm7/OTv+Znhh+9hS0OXoGqWIfqaSD73wB70KxxARM6yn9UW31mo6BD5iEN
 GfrBn1EQh+CkCuMA9WKaMZ8HH54MIi3Jho1TIk+vHRRsCraDxT8QXPbwZUB0kSTcqZe85S
 WTDd737vozaAJzZEie5Ll30Q3UsxZwltaAVSIetgquRoLKgivREqM9caAzBWf1YfjrDgaZ
 2QFs1nUcIXMVXf6h18v+EjXrTV16IFSWMbQyn9TwD0iAZNJSVtAq+pJ0WHKMuVDELo1e0F
 5PN2qXpnLo6FbsdMg+iww56XZzFVx6+CIyb8mwcVOeExiaAUlwN9W78sm4Hvrw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] ARM: renesas: Deduplicate common Renesas defconfig
Date: Sun, 20 Oct 2024 19:27:17 +0200
Message-ID: <20241020172734.1187843-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241020172734.1187843-1-marek.vasut+renesas@mailbox.org>
References: <20241020172734.1187843-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: krk9rjufwxbj15nwxfkkx3q9e4i3sf18
X-MBO-RS-ID: 2eb36f891aa733633f0
X-Rspamd-Queue-Id: 4XWllM1tz1z9sZZ
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

Deduplicate common Renesas defconfig by factoring out the common
parts into generic renesas_rcar_defconfig and including those using
the #include <configs/...> preprocessor macro in the current set of
board specific defconfigs. The preprocessor macro is applicable
to defconfigs as well.

This introduces no functional change, the resulting .config are
identical for all Renesas systems.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Cogent Embedded, Inc." <source@cogentembedded.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/renesas_rcar2_defconfig  | 31 ++-----------------------------
 configs/renesas_rcar64_defconfig | 31 ++-----------------------------
 configs/renesas_rcar_defconfig   | 29 +++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 58 deletions(-)
 create mode 100644 configs/renesas_rcar_defconfig

diff --git a/configs/renesas_rcar2_defconfig b/configs/renesas_rcar2_defconfig
index d9b516a7739..10cd2e56c8d 100644
--- a/configs/renesas_rcar2_defconfig
+++ b/configs/renesas_rcar2_defconfig
@@ -1,58 +1,32 @@
+#include <configs/renesas_rcar_defconfig>
+
 # CONFIG_CMD_IMI is not set
 # CONFIG_CMD_XIMG is not set
 # CONFIG_EFI_LOADER is not set
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RENESAS=y
-CONFIG_ARM=y
 CONFIG_BOOTDELAY=3
-CONFIG_CLK=y
-CONFIG_CLK_RENESAS=y
-CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MII=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_SDRAM=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_USB=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4f000000
-CONFIG_DM_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_SPI=y
-CONFIG_DM_SPI_FLASH=y
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_ENV_SIZE=0x40000
-CONFIG_FIT=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_HUSH_PARSER=y
-CONFIG_MTD=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_OF_CONTROL=y
 CONFIG_PARTITION_UUIDS=y
 CONFIG_PCI=y
 CONFIG_PCI_RCAR_GEN2=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_PFC=y
-CONFIG_RCAR_GPIO=y
 CONFIG_RENESAS_SDHI=y
-CONFIG_SCIF_CONSOLE=y
 CONFIG_SH_QSPI=y
-CONFIG_SPI=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_I2C_RCAR_IIC=y
@@ -66,4 +40,3 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_USB_STORAGE=y
-CONFIG_VERSION_VARIABLE=y
diff --git a/configs/renesas_rcar64_defconfig b/configs/renesas_rcar64_defconfig
index 3e2cc50b02c..df5863495b2 100644
--- a/configs/renesas_rcar64_defconfig
+++ b/configs/renesas_rcar64_defconfig
@@ -1,41 +1,14 @@
-CONFIG_ARCH_RENESAS=y
-CONFIG_ARM=y
-CONFIG_CLK=y
-CONFIG_CLK_RENESAS=y
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
+#include <configs/renesas_rcar_defconfig>
+
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_SPI=y
-CONFIG_DM_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_SPI=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_FIT=y
-CONFIG_HUSH_PARSER=y
-CONFIG_MTD=y
-CONFIG_OF_CONTROL=y
 CONFIG_PHY_ANEG_TIMEOUT=20000
-CONFIG_RCAR_GPIO=y
 CONFIG_REGMAP=y
 CONFIG_REMAKE_ELF=y
 CONFIG_RENESAS_RPC_SPI=y
-CONFIG_SCIF_CONSOLE=y
-CONFIG_SPI=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_SYSCON=y
 CONFIG_SYS_LOAD_ADDR=0x58000000
 CONFIG_SYS_MALLOC_BOOTPARAMS=y
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MONITOR_LEN=1048576
-CONFIG_VERSION_VARIABLE=y
diff --git a/configs/renesas_rcar_defconfig b/configs/renesas_rcar_defconfig
new file mode 100644
index 00000000000..1a8413b5599
--- /dev/null
+++ b/configs/renesas_rcar_defconfig
@@ -0,0 +1,29 @@
+CONFIG_ARCH_RENESAS=y
+CONFIG_ARM=y
+CONFIG_CLK=y
+CONFIG_CLK_RENESAS=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_DM_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_SPI=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_FIT=y
+CONFIG_HUSH_PARSER=y
+CONFIG_MTD=y
+CONFIG_OF_CONTROL=y
+CONFIG_RCAR_GPIO=y
+CONFIG_SCIF_CONSOLE=y
+CONFIG_SPI=y
+CONFIG_VERSION_VARIABLE=y
-- 
2.45.2

