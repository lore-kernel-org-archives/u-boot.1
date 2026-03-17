Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717E9FB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3DFF84101;
	Tue, 17 Mar 2026 02:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zf4q99yX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7298407F; Tue, 17 Mar 2026 02:24:26 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F9D84011
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-463f00cda04so3104662b6e.2
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710661; x=1774315461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gd4AGbK3BowJAFwFdb+BvxyC3l5ChIAOmpBAJ1EwixY=;
 b=Zf4q99yXaAIosXHuGyABUaO5GK9XjHOcb+dcnUJT7yrjy3MXdOAxcfXoRVsmMPxv4i
 v9xxK3t4KiUrIUNkRfKAPojh39HptBjETusx1Cp+nmMlvi0ySq9ChxicBcBa5+eP2WMB
 nLvRBqXqli4rGGBaJpGL0HAz41pRD+QTM+tQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710661; x=1774315461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gd4AGbK3BowJAFwFdb+BvxyC3l5ChIAOmpBAJ1EwixY=;
 b=JNuWwDcDX4QsRLwnqLo90TAFSJrRSIJMoDZf4A5JO2bca1bB7XJw41XjCbwENvQn3J
 0sD2HWgwtJBgINi7+khXW+fFg0OwUSWCfsZ/zX2a2tBLPHVaa0su8+l+Lrs6UFLE/Obw
 gLxYR2S+rV6HWdcEDuVzsYcrB1MFZhukQ8/VriTOJWvLThkq8s3CUA0oDQIKkgW8xPGr
 5QwskIOKD7qpgRcjmKTt5dh4r8/g18PLyqDMYlkD97XatY+4tGVFWiuq4VXzkVtBb3rH
 kgSBVUeep9X4GMR7yhq6CRAzoUdNFK8V9ExdaaLUY7VxypbIyEzjAbPNM8LzP6QtUGQR
 74Lw==
X-Gm-Message-State: AOJu0YxG1ysTEblsQG+47B6+y46LM9ZiF8OWpbI0jzvHsecWKPOgzcuv
 Qxm6dq7I9+dyolPaXmlaSTHU4JI0EVNAex4vPOfyDtPGyT7NQ63Kplu6UJIxpr5CSPvaWE58HRg
 sPpv6sWY=
X-Gm-Gg: ATEYQzxaHmkRoSnE8mDCvhxT7wdyF6wPkydoyoIyUzBONpnb87CyDLJvZiQln/muu+H
 26BhqpGAnvfl4LmtIKGc0sKf14D9yw87581b6w5ClMQNCEYWwatVxPhmJuc8aReWwrpQRSTvjc5
 OPRsMJQEqhUQLNFRkfg4nTFechAkPRrR2FoSOZu71fonTjVO/bOUIUHh2fFQfmP+241MElEzhOX
 rIH4R5Yq/eklh8gzaVP+aW8+liexrWAK3JZtlQz890NsUBmxivY6OOy+YekmxH8U6SfhIyxaic3
 uoPMPwHGb3vVWOBRtmVx8cupUKDuZ41GR+5UPUX3DmLM4wnQURJ125YHgXqCJRJINJII+eYcJ9V
 7gFB3Fui/wpW9ONVawglUiKATKwq7LAGjvEZEdiy2f76pVKlA47UPzPIM1gRkHr510syBoCP1v2
 MXT/VgkaLnAg008AXFDR7LBdNXy4N0YPr+pFSkAA19hfnDfw/yZGlt4lFg8kn/8Ot/KOr+mmlYc
 mztgThbe/ceu425FUPTmZREp2sDnRr/xTfYFbN6KoQl8gvbdUs=
X-Received: by 2002:a05:6808:a59a:20b0:467:91:fb32 with SMTP id
 5614622812f47-467575390acmr6250102b6e.39.1773710661524; 
 Mon, 16 Mar 2026 18:24:21 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4674de9eee9sm7991208b6e.13.2026.03.16.18.24.20
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] core: Rework REGMAP symbols implementation
Date: Mon, 16 Mar 2026 19:24:19 -0600
Message-ID: <20260317012419.4162359-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have an issue with the dependencies
for REGMAP (and xPL variants). As this is a library function, it should
always be selected and not depended on by other functionality. This is
largely done correctly today, so just correct the few outliers.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-airoha/Kconfig       |  1 +
 arch/arm/mach-aspeed/Kconfig       |  1 +
 arch/powerpc/cpu/mpc83xx/Kconfig   |  1 +
 configs/imx8m_data_modul.config    |  1 -
 configs/imx95_evk.config           |  1 -
 configs/imx_dhsom.config           |  1 -
 configs/kontron-osm-s-mx8mp.config |  1 -
 configs/kontron-osm-s-mx93.config  |  1 -
 configs/renesas_rcar64.config      |  1 -
 drivers/clk/microchip/Kconfig      |  1 -
 drivers/core/Kconfig               | 19 +++++++++++--------
 drivers/misc/Kconfig               |  3 ++-
 drivers/mmc/Kconfig                |  3 ++-
 13 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-airoha/Kconfig b/arch/arm/mach-airoha/Kconfig
index b9cd0a413e10..4b0374001d0c 100644
--- a/arch/arm/mach-airoha/Kconfig
+++ b/arch/arm/mach-airoha/Kconfig
@@ -10,6 +10,7 @@ config TARGET_EN7523
 	bool "Airoha EN7523 SoC"
 	select CPU_V7A
 	select ARMV7_SET_CORTEX_SMPEN
+	select REGMAP
 	help
 	  The Airoha EN7523 family (en7523/en7529/en7562) is an ARM-based
 	  SoCs with a dual-core CPU. It comes with Wi-Fi 5/6 support and
diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index 9cf60378c118..c88b1e59366e 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -18,6 +18,7 @@ config ASPEED_AST2500
 	bool "Support Aspeed AST2500 SoC"
 	select CPU_ARM1176
 	select DM_RESET
+	select REGMAP
 	help
 	  The Aspeed AST2500 is a ARM-based SoC with arm1176 CPU.
 	  It is used as Board Management Controller on many server boards,
diff --git a/arch/powerpc/cpu/mpc83xx/Kconfig b/arch/powerpc/cpu/mpc83xx/Kconfig
index 8ac83420ee22..0dc72c874237 100644
--- a/arch/powerpc/cpu/mpc83xx/Kconfig
+++ b/arch/powerpc/cpu/mpc83xx/Kconfig
@@ -73,6 +73,7 @@ config TARGET_KMTEPR2
 config TARGET_GAZERBEAM
 	bool "Support gazerbeam"
 	select ARCH_MPC8308
+	select REGMAP
 	select SYS_FSL_ERRATUM_ESDHC111
 	imply ENV_IS_IN_FLASH
 	help
diff --git a/configs/imx8m_data_modul.config b/configs/imx8m_data_modul.config
index 4634a0972f09..18c7bb536fa0 100644
--- a/configs/imx8m_data_modul.config
+++ b/configs/imx8m_data_modul.config
@@ -149,7 +149,6 @@ CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_PROT_TCP_SACK=y
-CONFIG_REGMAP=y
 CONFIG_RGMII=y
 CONFIG_RTC_M41T62=y
 CONFIG_SF_DEFAULT_SPEED=50000000
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
index 3db583cce597..e7832d86fe91 100644
--- a/configs/imx95_evk.config
+++ b/configs/imx95_evk.config
@@ -92,7 +92,6 @@ CONFIG_ETHPRIME="eth0"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_SPL_DM=y
-CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_CLK=y
diff --git a/configs/imx_dhsom.config b/configs/imx_dhsom.config
index 4a3ddc7e90b7..a0d67c8a0688 100644
--- a/configs/imx_dhsom.config
+++ b/configs/imx_dhsom.config
@@ -28,7 +28,6 @@ CONFIG_ENV_SECT_SIZE_AUTO=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 
-CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 
 CONFIG_DM_GPIO=y
diff --git a/configs/kontron-osm-s-mx8mp.config b/configs/kontron-osm-s-mx8mp.config
index a8881726e079..786fd3e7a6de 100644
--- a/configs/kontron-osm-s-mx8mp.config
+++ b/configs/kontron-osm-s-mx8mp.config
@@ -117,7 +117,6 @@ CONFIG_TFTP_TSIZE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
diff --git a/configs/kontron-osm-s-mx93.config b/configs/kontron-osm-s-mx93.config
index a6d316de3d87..c2d4de4efa8a 100644
--- a/configs/kontron-osm-s-mx93.config
+++ b/configs/kontron-osm-s-mx93.config
@@ -115,7 +115,6 @@ CONFIG_TFTP_TSIZE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_ADC=y
 CONFIG_ADC_IMX93=y
diff --git a/configs/renesas_rcar64.config b/configs/renesas_rcar64.config
index c2cb88dc157f..da4b262fc6a5 100644
--- a/configs/renesas_rcar64.config
+++ b/configs/renesas_rcar64.config
@@ -6,7 +6,6 @@ CONFIG_CMD_TEMPERATURE=y
 CONFIG_DM_THERMAL=y
 CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_RCAR_GEN3_THERMAL=y
-CONFIG_REGMAP=y
 CONFIG_REMAKE_ELF=y
 CONFIG_RENESAS_RPC_SPI=y
 CONFIG_SUPPORT_RAW_INITRD=y
diff --git a/drivers/clk/microchip/Kconfig b/drivers/clk/microchip/Kconfig
index 62072e100b18..6ac7c9c56547 100644
--- a/drivers/clk/microchip/Kconfig
+++ b/drivers/clk/microchip/Kconfig
@@ -2,6 +2,5 @@ config CLK_MPFS
 	bool "Clock support for Microchip PolarFire SoC"
 	depends on CLK && CLK_CCF
 	depends on SYSCON
-	depends on REGMAP
 	help
 	  This enables support clock driver for Microchip PolarFire SoC platform.
diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index c9253099e6ea..5419bf65b5d6 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -195,7 +195,7 @@ config DM_DMA
 	  the physical address space.
 
 config REGMAP
-	bool "Support register maps"
+	bool
 	depends on DM
 	select DEVRES
 	help
@@ -206,7 +206,7 @@ config REGMAP
 	  direct memory access.
 
 config SPL_REGMAP
-	bool "Support register maps in SPL"
+	bool
 	depends on SPL_DM
 	help
 	  Hardware peripherals tend to have one or more sets of registers
@@ -216,7 +216,7 @@ config SPL_REGMAP
 	  direct memory access.
 
 config TPL_REGMAP
-	bool "Support register maps in TPL"
+	bool
 	depends on TPL_DM
 	help
 	  Hardware peripherals tend to have one or more sets of registers
@@ -226,7 +226,7 @@ config TPL_REGMAP
 	  direct memory access.
 
 config VPL_REGMAP
-	bool "Support register maps in VPL"
+	bool
 	depends on VPL_DM
 	help
 	  Hardware peripherals tend to have one or more sets of registers
@@ -237,7 +237,7 @@ config VPL_REGMAP
 
 config SYSCON
 	bool "Support system controllers"
-	depends on REGMAP
+	select REGMAP
 	help
 	  Many SoCs have a number of system controllers which are dealt with
 	  as a group by a single driver. Some common functionality is provided
@@ -246,7 +246,8 @@ config SYSCON
 
 config SPL_SYSCON
 	bool "Support system controllers in SPL"
-	depends on SPL_REGMAP
+	depends on SPL_DM
+	select SPL_REGMAP
 	help
 	  Many SoCs have a number of system controllers which are dealt with
 	  as a group by a single driver. Some common functionality is provided
@@ -255,7 +256,8 @@ config SPL_SYSCON
 
 config TPL_SYSCON
 	bool "Support system controllers in TPL"
-	depends on TPL_REGMAP
+	depends on TPL_DM
+	select TPL_REGMAP
 	help
 	  Many SoCs have a number of system controllers which are dealt with
 	  as a group by a single driver. Some common functionality is provided
@@ -264,7 +266,8 @@ config TPL_SYSCON
 
 config VPL_SYSCON
 	bool "Support system controllers in VPL"
-	depends on VPL_REGMAP
+	depends on VPL_DM
+	select VPL_REGMAP
 	help
 	  Many SoCs have a number of system controllers which are dealt with
 	  as a group by a single driver. Some common functionality is provided
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index a0aa290480eb..798f1dbf26cf 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -350,7 +350,8 @@ config MXS_OCOTP
 
 config NPCM_HOST
 	bool "Enable support espi or LPC for Host"
-	depends on REGMAP && SYSCON
+	depends on SYSCON
+	select REGMAP
 	help
 	  Enable NPCM BMC espi or LPC support for Host reading and writing.
 
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 39caf2eff1b7..22bd3a972bdf 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -627,8 +627,9 @@ config MMC_SDHCI_AM654
 	depends on ARCH_K3
 	depends on MMC_SDHCI
 	depends on OF_CONTROL
-	depends on REGMAP
 	select MMC_SDHCI_IO_ACCESSORS
+	select REGMAP
+	select SPL_REGMAP if SPL_MMC
 	help
 	  Support for Secure Digital Host Controller Interface (SDHCI)
 	  controllers present on TI's AM654 SOCs.
-- 
2.43.0

