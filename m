Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5444C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 08:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B8E783046;
	Mon,  7 Jul 2025 10:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lUz8FAaq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Z2N9W2wm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2767D8305C; Mon,  7 Jul 2025 10:40:20 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C99583043
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 10:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bbHk95w19z9shW;
 Mon,  7 Jul 2025 10:40:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751877617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bHosHBE8Fs2Irz5I/ERltmvBAJmDUDRmG2Fp/DBv4GY=;
 b=lUz8FAaq3ycfQF73LKeHg1EAJC4hLcmFksMK1qWTQ19m1qF/Iz4oIJ0PIMVu5jAdPu617x
 4oiVL5PXHIpKsg+Z1IppXPVUxXIPqDlVkOwPkO4joKlqUwgWAZ3FlTp/OTIqjhWklxZE+O
 GfwW6kUuBLrny8QiGyyvmhRlhWIPkgqgNsTmRLY1xVWtV+BkhHPwvEpPI4j/x/ygvI6sEX
 twtEyVpkxXQRkiIKLRQAoruDR3YB0cvYEyx/YlzQaNpQFhlFy6UFN8UOUDezl6vnOH7uq6
 njwkN9O9fPOLapFBLu6wht+G9uE7Q7WVGFlKyEUpxw6Tx86Fkk6pJYqDz7+Jmw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751877615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bHosHBE8Fs2Irz5I/ERltmvBAJmDUDRmG2Fp/DBv4GY=;
 b=Z2N9W2wmFK1L19yUCNhyknKe+2Q33IJem/bYbAKQUjY/jjHMcHVrDiGSJ4x8IACshFHbfe
 OrOhkKI+jV2KZ3TVEaCQbiNwqOV9ma6GXofOC8ildoo1nycxLymY/35MGq5BsicCW4kfJU
 YefAgkkAmQ92qvBMxQnBbpMk6RTyBHVPT0vHh7m69sYifYXknYipHP0QmTVGAe8lspqpnI
 VuULSMk5tLQ0Ghe8pVrK8NIy+X9wWmTtWnn0TuXdHqaO+uLS1c0oKsMOMQdjCid9GSc5Jy
 pJkEsS31TJaQ91EdDlaREh+3SU6thtW8FhvgmUbOoukwK5+QctQyZ68NRRXusQ==
To: u-boot@lists.denx.de
Cc: damm@opensource.se, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] ARM: renesas: Split common RZ/A1 and GR-PEACH defconfigs
Date: Mon,  7 Jul 2025 10:39:31 +0200
Message-ID: <20250707084001.8254-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ytuo7hjggf9oenskjijasgex734i69f5
X-MBO-RS-ID: d0a7118a5a732e20c12
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

Split the RZ/A1 GR-PEACH defconfig into board-specific defconfig
and common RZ/A1 SoC defconfig. This is a preparatory patch for
new RZ/A1 boards, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Magnus Damm <damm@opensource.se>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Drop ENV_OFFSET and ENV_SIZE from renesas_rza1.config to avoid reassignment
---
 configs/grpeach_defconfig   | 71 ++++++-------------------------------
 configs/renesas_rza1.config | 55 ++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 61 deletions(-)
 create mode 100644 configs/renesas_rza1.config

diff --git a/configs/grpeach_defconfig b/configs/grpeach_defconfig
index 0f141b6f0a2..110af10860b 100644
--- a/configs/grpeach_defconfig
+++ b/configs/grpeach_defconfig
@@ -1,69 +1,18 @@
+#include <configs/renesas_rza1.config>
+
 CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x18000000
-CONFIG_SYS_MALLOC_LEN=0x100000
-CONFIG_SYS_MALLOC_F_LEN=0x400
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20900000
-CONFIG_ENV_SIZE=0x10000
-CONFIG_ENV_OFFSET=0x80000
-CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r7s72100-gr-peach"
-CONFIG_RZA1=y
-CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_SYS_MONITOR_LEN=524288
-CONFIG_SYS_LOAD_ADDR=0x20400000
-CONFIG_SYS_CLK_FREQ=66666666
-# CONFIG_EFI_LOADER is not set
-CONFIG_BOOTDELAY=3
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="ignore_loglevel"
-CONFIG_SYS_CBSIZE=256
-CONFIG_SYS_PBSIZE=256
-# CONFIG_DISPLAY_CPUINFO is not set
-# CONFIG_BOARD_EARLY_INIT_F is not set
-CONFIG_HUSH_PARSER=y
-# CONFIG_CMD_ELF is not set
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_SNTP=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_MAC_PARTITION=y
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
+CONFIG_TARGET_GRPEACH=y
+
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_DM_SPI_FLASH=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_SPI_MAX_HZ=50000000
+CONFIG_ENV_OFFSET=0x80000
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_RZA1_GPIO=y
-CONFIG_LED=y
-CONFIG_LED_GPIO=y
-# CONFIG_MMC is not set
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_SPI_MAX_HZ=50000000
 CONFIG_MTD=y
-CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
-# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
-CONFIG_BITBANGMII=y
-CONFIG_PHY_SMSC=y
-CONFIG_DM_ETH_PHY=y
-CONFIG_SH_ETHER=y
-CONFIG_PINCTRL=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_SCIF_CONSOLE=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_RENESAS_RPC_SPI=y
-CONFIG_TIMER=y
-CONFIG_RENESAS_OSTM_TIMER=y
-CONFIG_USB=y
-CONFIG_USB_R8A66597_HCD=y
-CONFIG_USB_STORAGE=y
diff --git a/configs/renesas_rza1.config b/configs/renesas_rza1.config
new file mode 100644
index 00000000000..10d817f03a7
--- /dev/null
+++ b/configs/renesas_rza1.config
@@ -0,0 +1,55 @@
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SYS_MALLOC_F_LEN=0x400
+# CONFIG_BOARD_EARLY_INIT_F is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_EFI_LOADER is not set
+# CONFIG_MMC is not set
+CONFIG_BITBANGMII=y
+CONFIG_BOOTARGS="ignore_loglevel"
+CONFIG_BOOTDELAY=3
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_USB=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20900000
+CONFIG_DM_ETH_PHY=y
+CONFIG_DM_GPIO=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_SPI=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_HUSH_PARSER=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MAC_PARTITION=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_PHY_SMSC=y
+CONFIG_PINCTRL=y
+CONFIG_RENESAS_OSTM_TIMER=y
+CONFIG_RENESAS_RPC_SPI=y
+CONFIG_RZA1=y
+CONFIG_RZA1_GPIO=y
+CONFIG_SCIF_CONSOLE=y
+CONFIG_SH_ETHER=y
+CONFIG_SPI=y
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_CLK_FREQ=66666666
+CONFIG_SYS_LOAD_ADDR=0x20400000
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SYS_PBSIZE=256
+CONFIG_TIMER=y
+CONFIG_USB=y
+CONFIG_USB_R8A66597_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_USE_BOOTARGS=y
-- 
2.47.2

