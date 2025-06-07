Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED19BC61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 09:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B22782C13;
	Sat,  7 Jun 2025 11:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WfsnoWE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4352380E9A; Sat,  7 Jun 2025 11:37:48 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B33FA82BBF
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 11:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-604b9c53f6fso675373a12.2
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 02:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749289065; x=1749893865;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6nnZ0z5CVcOZdPOmtmHivfMo/xRCiH6ugcO0Mzzk4VI=;
 b=WfsnoWE/wkShVEaeovGeo+2zpDPH3IOK0x/4wQdcBwnZmT3gMJXYUiQR+HvCtsHXCP
 ZkY9uK/nT9/mL7eCACNY9Pkn+tx1y4WHdjxm94UFqc8Q6xxGTg08Kpz+Ovd7j48G0GZe
 GbxDUGXCfk3PT/WB2uSe9b/LEyfP8ffUjt0Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749289065; x=1749893865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6nnZ0z5CVcOZdPOmtmHivfMo/xRCiH6ugcO0Mzzk4VI=;
 b=ptg4l7eZOXKpqoKkjEgfTQAeZ6dd69Ka3YX3fV1b5rzBtuYBPz+GgPJNIYi44mESMs
 iom6MlqvVzzShE/OQpVf2piW1bWfzXaR5Ki0iWY9eoRJyY94a28NwibB/ReoJEtVcEsA
 7nHPnVgvmquPonxfu9jihUvC6fcZfrFYUzwn1LnsRsUk0Y85jxExiTBLTvH2DLP9dzsQ
 2ZUao6mk5jEztybMas1rUwsG4PISgpcHR+xYo9skMDCixdmAJFNzYXFIg3kcoQ7xLUvA
 0XAXpQxp5nc7aCyJ6evV3pq2/BE7QIXmU4gmLb5yIJ1YyIzc7YrzJyQH9jtndsSJ9FTL
 TfqQ==
X-Gm-Message-State: AOJu0YyaFAR7sb5tfl2wgAzbtOMIHbizBf4JmESgA9C4jCbIV0RfxdEz
 UkPuDmvYJ693V9SuaoVYldRn1gmPICWS3whuaDEzZ1P27+w9068tmW7Pho1i5qpb6hVCfIcCAyP
 UAWVp
X-Gm-Gg: ASbGncs9Hknq2VwzhTxKQzsNQWOLLLO4RPeLrEv7OoMQJBODRenXgq8c/f3uQZ715sb
 YMN1JrgEob71hFuBjANAJCk/O3SjoraqXem+JLcwslIAGf59+gE7N8Hs+WrI12dQmT9Yfzo9h4P
 9/RIQ541g4kXtjaG60vzvw95JUjrg4ZgdWjaOhoB3+16coFXNc2WbFf7xTF6vw8fQLA7fw9woRt
 a8A1SIByuNE0c93krQ4iz7Pw1QzH7JXMmuWsjB8Eltry5ZVERI6Kny/urqMbJgNUkp6yAak/HLC
 kF63SwxPIwJfI4eRkv2BmZhlcmlLm3wZzrTNpsxyjX5AgOmBYAbH66+oKih4Ho5NH97oVg96atr
 M0h2niEGMXbWhHvjil7OTnoV22HDJaWfWs2frmjat0Q6bOjTSH1Ryysri26/u+qX5AAFbuXbyVU
 I2h2uqaDKd90zAGQVmzGsmxc0=
X-Google-Smtp-Source: AGHT+IHXy+RZjYbnMDEzeLMHSgRjVATxr1x21fMyUTcMFXjZwt/KQCdBMYdInCwy4OCo4XZP2fa0UA==
X-Received: by 2002:a17:906:1359:b0:ade:433c:6412 with SMTP id
 a640c23a62f3a-ade433c6574mr85288266b.3.1749289064912; 
 Sat, 07 Jun 2025 02:37:44 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-5-95-99.retail.telecomitalia.it. [87.5.95.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc38cffsm246524966b.124.2025.06.07.02.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 02:37:44 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 9/9] board: stm32: add stm32h747-discovery board support
Date: Sat,  7 Jun 2025 11:37:17 +0200
Message-ID: <20250607093730.2249536-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
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

The board includes an STM32H747XI SoC with the following resources:
 - 2 Mbytes Flash
 - 1 Mbyte SRAM
 - LCD-TFT controller
 - MIPI-DSI interface
 - FD-CAN
 - USB 2.0 high-speed/full-speed
 - Ethernet MAC
 - camera interface

Detailed information can be found at:
https://www.st.com/en/evaluation-tools/stm32h747i-disco.html

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/mach-stm32/stm32h7/Kconfig        |  4 +++
 board/st/stm32h747-disco/Kconfig           | 15 ++++++++
 board/st/stm32h747-disco/MAINTAINERS       |  7 ++++
 board/st/stm32h747-disco/Makefile          |  6 ++++
 board/st/stm32h747-disco/stm32h747-disco.c | 42 ++++++++++++++++++++++
 configs/stm32h747-disco_defconfig          | 35 ++++++++++++++++++
 drivers/clk/stm32/clk-stm32h7.c            |  5 +++
 include/configs/stm32h747-disco.h          | 32 +++++++++++++++++
 8 files changed, 146 insertions(+)
 create mode 100644 board/st/stm32h747-disco/Kconfig
 create mode 100644 board/st/stm32h747-disco/MAINTAINERS
 create mode 100644 board/st/stm32h747-disco/Makefile
 create mode 100644 board/st/stm32h747-disco/stm32h747-disco.c
 create mode 100644 configs/stm32h747-disco_defconfig
 create mode 100644 include/configs/stm32h747-disco.h

diff --git a/arch/arm/mach-stm32/stm32h7/Kconfig b/arch/arm/mach-stm32/stm32h7/Kconfig
index 70233a4b23cd..72f20c477d04 100644
--- a/arch/arm/mach-stm32/stm32h7/Kconfig
+++ b/arch/arm/mach-stm32/stm32h7/Kconfig
@@ -6,11 +6,15 @@ config TARGET_STM32H743_DISCO
 config TARGET_STM32H743_EVAL
 	bool "STM32H743 Evaluation board"
 
+config TARGET_STM32H747_DISCO
+	bool "STM32H747 Discovery board"
+
 config TARGET_STM32H750_ART_PI
 	bool "STM32H750 ART Pi board"
 
 source "board/st/stm32h743-eval/Kconfig"
 source "board/st/stm32h743-disco/Kconfig"
+source "board/st/stm32h747-disco/Kconfig"
 source "board/st/stm32h750-art-pi/Kconfig"
 
 endif
diff --git a/board/st/stm32h747-disco/Kconfig b/board/st/stm32h747-disco/Kconfig
new file mode 100644
index 000000000000..a7b2c09a327f
--- /dev/null
+++ b/board/st/stm32h747-disco/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_STM32H747_DISCO
+
+config SYS_BOARD
+	default "stm32h747-disco"
+
+config SYS_VENDOR
+	default "st"
+
+config SYS_SOC
+	default "stm32h7"
+
+config SYS_CONFIG_NAME
+	default "stm32h747-disco"
+
+endif
diff --git a/board/st/stm32h747-disco/MAINTAINERS b/board/st/stm32h747-disco/MAINTAINERS
new file mode 100644
index 000000000000..d48649f773f3
--- /dev/null
+++ b/board/st/stm32h747-disco/MAINTAINERS
@@ -0,0 +1,7 @@
+STM32H747 DISCOVERY BOARD
+M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
+S:	Maintained
+F:	board/st/stm32h747-disco
+F:	include/configs/stm32h747-disco.h
+F:	configs/stm32h747-disco_defconfig
+F:	arch/arm/dts/stm32h747*
diff --git a/board/st/stm32h747-disco/Makefile b/board/st/stm32h747-disco/Makefile
new file mode 100644
index 000000000000..e11f052cc88f
--- /dev/null
+++ b/board/st/stm32h747-disco/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2025 Dario Binacchi <dario.binacchi@amarulasolutions.com>
+#
+
+obj-y	:= stm32h747-disco.o
diff --git a/board/st/stm32h747-disco/stm32h747-disco.c b/board/st/stm32h747-disco/stm32h747-disco.c
new file mode 100644
index 000000000000..be0884bdeb4d
--- /dev/null
+++ b/board/st/stm32h747-disco/stm32h747-disco.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * stm32h747i-disco support
+ *
+ * Copyright (C) 2025 Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include <dm.h>
+#include <init.h>
+#include <log.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+	if (ret) {
+		debug("DRAM init failed: %d\n", ret);
+		return ret;
+	}
+
+	if (fdtdec_setup_mem_size_base() != 0)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+int dram_init_banksize(void)
+{
+	fdtdec_setup_memory_banksize();
+
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/configs/stm32h747-disco_defconfig b/configs/stm32h747-disco_defconfig
new file mode 100644
index 000000000000..8a0c72450d1e
--- /dev/null
+++ b/configs/stm32h747-disco_defconfig
@@ -0,0 +1,35 @@
+CONFIG_ARM=y
+CONFIG_ARCH_STM32=y
+CONFIG_TEXT_BASE=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x24040000
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DEFAULT_DEVICE_TREE="st/stm32h747i-disco"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_LOAD_ADDR=0xd0400000
+CONFIG_STM32H7=y
+CONFIG_TARGET_STM32H747_DISCO=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=3
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot.\n"
+CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_DEFAULT_FDT_FILE="stm32h747i-disco"
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=282
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SYS_PROMPT="U-Boot > "
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_ISO_PARTITION is not set
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NO_NET=y
+CONFIG_STM32_SDMMC2=y
+# CONFIG_PINCTRL_FULL is not set
diff --git a/drivers/clk/stm32/clk-stm32h7.c b/drivers/clk/stm32/clk-stm32h7.c
index 6acf2ff0a8fb..aa3be414a29f 100644
--- a/drivers/clk/stm32/clk-stm32h7.c
+++ b/drivers/clk/stm32/clk-stm32h7.c
@@ -114,6 +114,7 @@
 #define		QSPISRC_PER_CK		3
 
 #define PWR_CR3				0x0c
+#define PWR_CR3_LDOEN			BIT(1)
 #define PWR_CR3_SCUEN			BIT(2)
 #define PWR_D3CR			0x18
 #define PWR_D3CR_VOS_MASK		GENMASK(15, 14)
@@ -375,7 +376,11 @@ int configure_clocks(struct udevice *dev)
 	clrsetbits_le32(pwr_base + PWR_D3CR, PWR_D3CR_VOS_MASK,
 			VOS_SCALE_1 << PWR_D3CR_VOS_SHIFT);
 	/* Lock supply configuration update */
+#if IS_ENABLED(CONFIG_TARGET_STM32H747_DISCO)
+	clrbits_le32(pwr_base + PWR_CR3, PWR_CR3_LDOEN);
+#else
 	clrbits_le32(pwr_base + PWR_CR3, PWR_CR3_SCUEN);
+#endif
 	while (!(readl(pwr_base + PWR_D3CR) & PWR_D3CR_VOSREADY))
 		;
 
diff --git a/include/configs/stm32h747-disco.h b/include/configs/stm32h747-disco.h
new file mode 100644
index 000000000000..393445a8ae1f
--- /dev/null
+++ b/include/configs/stm32h747-disco.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <config.h>
+#include <linux/sizes.h>
+
+/* For booting Linux, use the first 16MB of memory */
+#define CFG_SYS_BOOTMAPSZ		SZ_16M
+
+#define CFG_SYS_FLASH_BASE		0x08000000
+
+#define CFG_SYS_HZ_CLOCK		1000000
+
+#define BOOT_TARGET_DEVICES(func) \
+	func(MMC, mmc, 0)
+
+#include <config_distro_bootcmd.h>
+#define CFG_EXTRA_ENV_SETTINGS				\
+			"kernel_addr_r=0xD0008000\0"		\
+			"fdtfile=stm32h747i-disco.dtb\0"	\
+			"fdt_addr_r=0xD0408000\0"		\
+			"scriptaddr=0xD0418000\0"		\
+			"pxefile_addr_r=0xD0428000\0" \
+			"ramdisk_addr_r=0xD0438000\0"		\
+			BOOTENV
+
+#endif /* __CONFIG_H */
-- 
2.43.0

