Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49177C44521
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 13:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E744B84A12;
	Sun, 19 Jul 2026 15:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fUJpG6ua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D9A98488B; Sun, 19 Jul 2026 14:18:11 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34F52838D7
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 14:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prasanth.padarthi10@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ceed7018c8so37769355ad.1
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784463487; x=1785068287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BD1MYg0Lu3lxRHzJtwDQUCMi2is5vDgotoUKrfHituw=;
 b=fUJpG6uaklvXE9gpzXoyPZE/nUNg7+b7jUE9jVD2gdk3Xk4JPfvpr97HUUB67SSdly
 NkIf9lyCFz0qPJwlWfA8VoO1nhduwK2zZCY1oFulr3cQfo1LgHm0Npwdu74NOPak96s7
 SPUBpUKJgz92Lz7cbLwC4Aa4uv+0mkIL/DFG3YMGFnTi6qQXbKly2zPOUnmGGseTY7PO
 n+Ta83/L+vA5P21FhaLHqtH7pbWjsNPeEwpNiPOxIxUQfHSnQ053fSdh/8zrlZBdRG8b
 IGDnKB6Izx3bRRlwY3ZcCBfF3WkjVZIkyvBXXTVEmjbEPmqU3Q42vwYCVllJhSLlkjNg
 M4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784463487; x=1785068287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BD1MYg0Lu3lxRHzJtwDQUCMi2is5vDgotoUKrfHituw=;
 b=OGj2KuTATgTBR7gpec3eVnyeyp+iG25erJyLru09LhpA1M+T6TAvwPU0tQM6xUwbkc
 KsSqnCUHltid4GJjr8L56NYsfx23ayWPslzCf33NZbRhgujgSpsgeClOH6s25EcAAQCg
 6ufvqWPfd1Rl8y1GL0IczS4E2UuW6EylTx2sehXP0dH9BHi01QCSaqmTxD3/4SL2GUA8
 kLMUXZY2pqA5qZO3V424u9vADDHiNbNZp86xIOmoXcsZKpeZomxqgVooymthBVdjxemv
 0JYl/0LI+c2lB30Dw2nZlH1xVT8jzoRKHzFvf5P5FWw3GLtWo3QGodQz5gjHc4b7OYfl
 GZrQ==
X-Gm-Message-State: AOJu0YxbgVkj+JuL2jK2TJyv2F/jqcXzSsQYXu44pmaFHWdfwKj1Fwb8
 cnLuRinWcwQkuW5eP07hOGmrD898WjGBJCE6QTzQlXUF26osl7GKqT/MZgenyA==
X-Gm-Gg: AfdE7cnRCqzKc4Q1Z0A1ZJjw+JJDS0PE0uLyBuKv1vRdoJEgND7oDK5Qo2TEbW8mXUZ
 qoZ4LMnzWFowiKWD3trgT38JShPefgGWV1Ddc0tucrLY4bDTC2MTvH6IXo1nkjO+10RTbGxSwev
 GJaiuGL1uU6+rECkrYSBf4xUbQCDzhEFyFZcK3rRjK3JpBc96q37JGCBMDrTQ6XbkZw4ebg2LZf
 Ceh/t4zOdCpguvUGfaI8NcSOK9bzut+FyWNQp82ELp6LKFOg5EtjX9cYDOvtikj5J0rVVnOlKFp
 /kVCrnnllGypFA6z4NrlQLlSqWg5r2huiiZ2a/f5mzELzSzTulKN1p+QcVWClxTqHPBylqDGFwD
 03E6wgTxVryPe2TO0WOuOf5dDOBK7dIH4/s+vp8+jbaTRkt8Tpj/aTB414KuPHIr9hli6bZJQKV
 Hd/6JdSw4JJCjUNaw+6bpPbdIwS7JCW44=
X-Received: by 2002:a05:6a21:ae11:b0:3c3:c130:3532 with SMTP id
 adf61e73a8af0-3c3c13044f6mr5637905637.41.1784463487522; 
 Sun, 19 Jul 2026 05:18:07 -0700 (PDT)
Received: from debian.prasanth ([103.183.205.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a20c158sm28364130eec.29.2026.07.19.05.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 05:18:07 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com,
 BMC-SW@aspeedtech.com, joel@jms.id.au,
 Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [RFC PATCH v1 1/1] arm: aspeed: Add ASRock Rack B650D4U BMC support
Date: Sun, 19 Jul 2026 17:47:52 +0530
Message-ID: <20260719121752.88393-2-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260719121752.88393-1-prasanth.padarthi10@gmail.com>
References: <20260719121752.88393-1-prasanth.padarthi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 19 Jul 2026 15:11:38 +0200
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

Add U-Boot support for the AST2600 BMC on the ASRock Rack B650D4U.

Describe the 512 MiB DRAM, UART5 console, watchdog, 64 MiB SPI
NOR, RTL8211F-connected MAC0 and RMII/NCSI-connected MAC2.

Use the existing AST2600 EVB target infrastructure and a
board-specific defconfig.

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 MAINTAINERS                      |   6 ++
 arch/arm/dts/ast2600-b650d4u.dts |  74 ++++++++++++++++++++
 configs/b650d4u_defconfig        | 115 +++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 arch/arm/dts/ast2600-b650d4u.dts
 create mode 100644 configs/b650d4u_defconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index d4b527560aa..52aefd17217 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -213,6 +213,12 @@ F:	drivers/reset/reset-ast2500.c
 F:	drivers/watchdog/ast_wdt.c
 N:	aspeed
 
+ASROCK RACK B650D4U BMC
+M:	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
+S:	Maintained
+F:	arch/arm/dts/ast2600-b650d4u.dts
+F:	configs/b650d4u_defconfig
+
 ARM BROADCOM BCM283X / BCM27XX
 M:	Matthias Brugger <mbrugger@suse.com>
 M:	Peter Robinson <pbrobinson@gmail.com>
diff --git a/arch/arm/dts/ast2600-b650d4u.dts b/arch/arm/dts/ast2600-b650d4u.dts
new file mode 100644
index 00000000000..97a9e17dc15
--- /dev/null
+++ b/arch/arm/dts/ast2600-b650d4u.dts
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+#include "ast2600-u-boot.dtsi"
+
+/ {
+	model = "ASRock Rack B650D4U BMC";
+	compatible = "asrock,b650d4u-bmc", "aspeed,ast2600";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+};
+
+&uart5 {
+	bootph-all;
+	status = "okay";
+};
+
+&sdrammc {
+	clock-frequency = <400000000>;
+};
+
+&wdt1 {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fmcquad_default>;
+
+	flash@0 {
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&mdio0 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mac0 {
+	status = "okay";
+
+	/* The PCB provides TX delay; the PHY provides RX delay. */
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&ethphy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+};
+
+&mac2 {
+	status = "okay";
+	phy-mode = "rmii";
+	use-ncsi;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+};
diff --git a/configs/b650d4u_defconfig b/configs/b650d4u_defconfig
new file mode 100644
index 00000000000..3a548a9528f
--- /dev/null
+++ b/configs/b650d4u_defconfig
@@ -0,0 +1,115 @@
+CONFIG_ARM=y
+CONFIG_SYS_DCACHE_OFF=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SPL_SYS_THUMB_BUILD=y
+CONFIG_ARCH_ASPEED=y
+CONFIG_TEXT_BASE=0x80000000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x800
+CONFIG_ASPEED_AST2600=y
+CONFIG_TARGET_EVB_AST2600=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SPL_LDSCRIPT="arch/arm/mach-aspeed/ast2600/u-boot-spl.lds"
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="ast2600-b650d4u"
+CONFIG_DM_RESET=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x83000000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x83000000
+CONFIG_SPL_BSS_MAX_SIZE=0x1000000
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2000000
+CONFIG_SYS_LOAD_ADDR=0x83000000
+CONFIG_SPL_SIZE_LIMIT=0x10000
+CONFIG_SPL=y
+# CONFIG_ARMV7_NONSEC is not set
+CONFIG_SPL_PAYLOAD="u-boot.img"
+CONFIG_BUILD_TARGET="u-boot-with-spl.bin"
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=276
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SPL_FIT_IMAGE_TINY=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_BOOTZ=y
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_IMI is not set
+# CONFIG_CMD_XIMG is not set
+CONFIG_CMD_EEPROM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_BOOTP_BOOTFILESIZE=y
+CONFIG_CMD_NCSI=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_DOS_PARTITION=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_EFI_PARTITION=y
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_ASPEED_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_ASPEED=y
+CONFIG_I2C_EEPROM=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ASPEED=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_SST=y
+CONFIG_SPI_FLASH_WINBOND=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_NCSI=y
+CONFIG_DM_MDIO=y
+CONFIG_FTGMAC100=y
+CONFIG_ASPEED_MDIO=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_SPI_DIRMAP=y
+CONFIG_SPI_ASPEED_SMC=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_WDT=y
+CONFIG_SHA384=y
+CONFIG_SPL_CRC32=y
+CONFIG_HEXDUMP=y
+CONFIG_PHANDLE_CHECK_SEQ=y
-- 
2.47.3

