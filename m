Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A14C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F515877DE;
	Wed, 20 Dec 2023 13:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="eV4GxFW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F7E86FD5; Wed, 20 Dec 2023 10:12:49 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8306687480
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 10:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naresh.solanki@9elements.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40c339d2b88so58374125e9.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 01:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1703063566; x=1703668366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TcmuEfxvBJvA4U3yIPgtYKn2+Egh6a8qao8SrdaKDao=;
 b=eV4GxFW3Uj1PmO0RDr7nMPzO5Z6sTbq8pcKpQtYodyl/8ZCG1w6rY7syM/bctacAkJ
 lYq70NLmaW/RA4MXHU+D2ykUKnNYOyHBlDvzpHktuSnkWo9fIHpojSFpR3VOzMEmO+Wh
 GjfGmHxvwFMWPAEsfRe0BQX4jY9bquu+QEFp57cmlD0MaVt1tBe0KJqGLVTZhOV2ocau
 yOj+KrTKlDE8GpCArfyXloxrbkQCjb/d3LI/WErF9HhR8jrhFu3OQ2+BI9Mc3w6tYVFX
 aWsUbK6CwR+eqt762iUAxJQNLbou68kT1C7wt8rPYnIDOKh4CEHHdcxUmkIlL3am3PFk
 nFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703063566; x=1703668366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TcmuEfxvBJvA4U3yIPgtYKn2+Egh6a8qao8SrdaKDao=;
 b=bdW0Rslex4ODs3XM9OpcRxH+gZVw6mApep28ucazFFBKlMl+41nozDBi8+KGd47duO
 IUMMRuopO7WcQiSxLRiF8qvyVysBZ5NWeGNPvQZGAAslhruzVGWfiW/Z4pSb3bxgkGQV
 kW16ENkRMwgJVsTw0FjMolQtOjjTmT69U3IpE1NSa1f+e7Da2Spig5rOFTIddeJMoDMs
 Itc5Ty/T7RSgYHNfa9IHDGAkwoGrUw/2ORfJkxHf5KujnypiD6WKO+Sx2rATtrqPJNrs
 XvCmfgfu9LA9Rsp7LD7QcVlX5SeO55mao3URnuAMiuulrqcSoH7DrF/z7xGBhbMO6yVM
 T3QA==
X-Gm-Message-State: AOJu0YxuXnPZixehjrI8QWg9GkA0fpjth8c2alXqqAODdb1zAn0Qit7j
 CioTRCJY9ptUIZXAA3OjPHPuYPVu4Rt12QzGB/Yd4Q==
X-Google-Smtp-Source: AGHT+IHrhi2/UlFTfqbqsU/Gen4jnAcTa8qSjBidvPvJ62ggYkTMJwxjv0ismPhX55d6GdY0n55VcA==
X-Received: by 2002:a05:600c:3d85:b0:40d:22d3:e359 with SMTP id
 bi5-20020a05600c3d8500b0040d22d3e359mr1216190wmb.3.1703063566235; 
 Wed, 20 Dec 2023 01:12:46 -0800 (PST)
Received: from stroh80.sec.9e.network
 (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
 by smtp.gmail.com with ESMTPSA id
 bh20-20020a05600c3d1400b0040d15dcb77asm6530224wmb.23.2023.12.20.01.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 01:12:44 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: u-boot@lists.denx.de, "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Naresh Solanki <naresh.solanki@9elements.com>
Subject: [PATCH] sbp1: Add support for IBM SBP1 board
Date: Wed, 20 Dec 2023 14:42:24 +0530
Message-ID: <20231220091236.1059109-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Dec 2023 13:13:44 +0100
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

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add defconfig & devicetree for IBM SBP1 board BMC based on AST2600 SoC.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---

Changes:
- Update MAINTAINERS
---
 arch/arm/dts/Makefile                |   4 +-
 arch/arm/dts/ast2600-sbp1.dts        |  96 ++++++++++++++++++++
 board/aspeed/evb_ast2600/MAINTAINERS |   1 +
 configs/ibm-sbp1_defconfig           | 126 +++++++++++++++++++++++++++
 4 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/ast2600-sbp1.dts
 create mode 100644 configs/ibm-sbp1_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 1be08c5fdc..85514fb8ba 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1353,7 +1353,9 @@ dtb-$(CONFIG_BCM6878) += \
 	bcm96878.dtb
 
 dtb-$(CONFIG_ASPEED_AST2500) += ast2500-evb.dtb
-dtb-$(CONFIG_ASPEED_AST2600) += ast2600-evb.dtb
+dtb-$(CONFIG_ASPEED_AST2600) += \
+	ast2600-evb.dtb \
+	ast2600-sbp1.dtb
 
 dtb-$(CONFIG_ARCH_STI) += stih410-b2260.dtb
 
diff --git a/arch/arm/dts/ast2600-sbp1.dts b/arch/arm/dts/ast2600-sbp1.dts
new file mode 100644
index 0000000000..5c862e2c1c
--- /dev/null
+++ b/arch/arm/dts/ast2600-sbp1.dts
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "ast2600-evb.dts"
+
+/ {
+	model = "IBM SBP1";
+	compatible = "ibm,sbp1-bmc", "aspeed,ast2600";
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	aliases {
+		mmc0 = &emmc;
+		mmc1 = &sdhci0;
+		mmc2 = &sdhci1;
+		ethernet0 = &mac2;
+		ethernet1 = &mac3;
+	};
+
+	cpus {
+		cpu@0 {
+			clock-frequency = <1200000000>;
+		};
+		cpu@1 {
+			clock-frequency = <1200000000>;
+		};
+	};
+
+};
+
+&uart1 {
+	bootph-all;
+	status = "okay";
+};
+
+&uart5 {
+	status = "disabled";
+};
+
+&mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mdio3_default &pinctrl_mdio4_default>;
+};
+
+&mac0 {
+	status = "disabled";
+};
+
+&mac1 {
+	status = "disabled";
+};
+
+&gpio0 {
+	status = "okay";
+	line_50 {
+		gpio-hog;
+		gpios = <50 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "BMC_MAC1_RESET_N";
+	};
+	line_175 {
+		gpio-hog;
+		gpios = <175 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "BMC_MAC0_RESET_N";
+	};
+};
+
+&spi1 {
+	status = "disabled";
+};
+
+&spi2 {
+	status = "disabled";
+};
+
+&emmc {
+	status = "disabled";
+};
+
+&sdhci0 {
+	status = "disabled";
+};
+
+&sdhci1 {
+	status = "disabled";
+};
diff --git a/board/aspeed/evb_ast2600/MAINTAINERS b/board/aspeed/evb_ast2600/MAINTAINERS
index e83aae5d6a..5368e8ee5f 100644
--- a/board/aspeed/evb_ast2600/MAINTAINERS
+++ b/board/aspeed/evb_ast2600/MAINTAINERS
@@ -4,3 +4,4 @@ S:	Maintained
 F:	board/aspeed/evb_ast2600/
 F:	include/configs/evb_ast2600.h
 F:	configs/evb-ast2600_defconfig
+F:	configs/ibm-sbp1_defconfig
diff --git a/configs/ibm-sbp1_defconfig b/configs/ibm-sbp1_defconfig
new file mode 100644
index 0000000000..cf667217cc
--- /dev/null
+++ b/configs/ibm-sbp1_defconfig
@@ -0,0 +1,126 @@
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
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0xe0000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="ast2600-sbp1"
+CONFIG_DM_RESET=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x83000000
+CONFIG_SPL_SIZE_LIMIT=0x10000
+CONFIG_SPL=y
+# CONFIG_ARMV7_NONSEC is not set
+CONFIG_SYS_LOAD_ADDR=0x83000000
+CONFIG_SPL_PAYLOAD="u-boot.img"
+CONFIG_BUILD_TARGET="u-boot-with-spl.bin"
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_FIT=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200n8 root=/dev/ram rw earlycon"
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="run bootspi"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x83000000
+CONFIG_SPL_BSS_MAX_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2000000
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SPL_FIT_IMAGE_TINY=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_RAM_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=276
+CONFIG_CMD_BOOTZ=y
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_IMI is not set
+# CONFIG_CMD_XIMG is not set
+CONFIG_CMD_EEPROM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_DHCP=y
+CONFIG_BOOTP_BOOTFILESIZE=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_NCSI=y
+CONFIG_CMD_EXT4=y
+CONFIG_DOS_PARTITION=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_EFI_PARTITION=y
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_SECT_SIZE_AUTO=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
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
+# CONFIG_EFI_LOADER is not set
+CONFIG_PHANDLE_CHECK_SEQ=y
-- 
2.41.0

