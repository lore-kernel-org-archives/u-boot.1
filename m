Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6690DFA3737
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 10:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C273588C63;
	Fri, 13 Sep 2024 11:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="a18ZQJhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E79F388D16; Fri, 13 Sep 2024 11:57:33 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD8D88C3E
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso9469435e9.2
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221444; x=1726826244;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBwSq5ZmOlgcVv1nfYy6SQy98WXEHyPhDxPXNiUuXhY=;
 b=a18ZQJhuiKTvqg7OXMdhQwd4SNPs/CBUAoAKjdgAaejlU16ZXvpPj/OOElrZLo5wYQ
 ntmorgDxKTklW4mCFBpcAeN6uHrQ6IPLzhYUR5OfipOGyk3sO2Z5+quqVxLDiR09QWiJ
 PXiZzhUOPemgql/127174WY2MWfpq7qyqxIHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221444; x=1726826244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dBwSq5ZmOlgcVv1nfYy6SQy98WXEHyPhDxPXNiUuXhY=;
 b=sKIpWLSNQEhIYK1dwXTavVpQ2v30WsZkui99HbK73pat9/03y4d/nAKthitay8sb4d
 Vx8Y2V0r9vZCNkjbDMTwv8E3TFR7TaTN25otnD7KwsBpsgIktzJyqM+aeGpHvaabwDtx
 WuJp25iX3Z1z9q8a8NoTmNLFGAxY5req2j6TRdTcKXT3qzw6MVbTn/mFgTg3dEwl3lXF
 BERfbyqh/knfZWKC9okwGIe1WbayCyu89Ya7k2QJctzRPIhL213fSzZ/iUoNffpzNWxu
 blkZfhIZRpN6OX/tEqsYKBKkEX9CD64XL3Hn6PwZ0eHV7h7iSPQxxGAwiCgBlC0J89Wl
 nLug==
X-Gm-Message-State: AOJu0YxJxCd//2q0AYwGneYfU4nDOYh4puDgA8CaRUuuaO1md6+8y1pM
 4d9PBQHM78gHaqLaH0QLxjjQrACI/oD/wXxZR/MyUVlXXU89PI9KDaZzpGqYBWjiQxDkzfua356
 WOEU=
X-Google-Smtp-Source: AGHT+IHtSfUm4V+2WQvYyqxfMrXkyd2fbmqwiRABZmcy0xISG2i6C/1YyU/gBZK68bBtW7cExKBGyQ==
X-Received: by 2002:a05:6000:1862:b0:374:cc4b:596e with SMTP id
 ffacd0b85a97d-378d6235e10mr1875542f8f.37.1726221443935; 
 Fri, 13 Sep 2024 02:57:23 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:23 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 20/26] imx8mn_bsh_smm_s2/pro: Enable display on reference
 design
Date: Fri, 13 Sep 2024 11:56:02 +0200
Message-ID: <20240913095622.72377-21-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

Co-developed-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---

 .../dts/imx8mn-bsh-smm-s2-u-boot-common.dtsi  | 23 +++++++++++++++++++
 configs/imx8mn_bsh_smm_s2_defconfig           | 15 ++++++++++++
 configs/imx8mn_bsh_smm_s2pro_defconfig        | 15 ++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/arch/arm/dts/imx8mn-bsh-smm-s2-u-boot-common.dtsi b/arch/arm/dts/imx8mn-bsh-smm-s2-u-boot-common.dtsi
index 19b0d8977539..8cae580e2851 100644
--- a/arch/arm/dts/imx8mn-bsh-smm-s2-u-boot-common.dtsi
+++ b/arch/arm/dts/imx8mn-bsh-smm-s2-u-boot-common.dtsi
@@ -6,6 +6,19 @@
 
 #include "imx8mn-u-boot.dtsi"
 
+/ {
+	aliases {
+		display0 = &lcdif;
+	};
+
+	samsung_dsi_host: dsi-host {
+		compatible = "samsung,sec-mipi-dsi";
+		clocks = <&clk IMX8MN_CLK_DSI_PHY_REF>;
+		clock-names = "sclk_mipi";
+		status = "okay";
+	};
+};
+
 &{/soc@0/bus@30800000/i2c@30a20000/pmic@4b} {
 	bootph-pre-ram;
 };
@@ -30,6 +43,16 @@
 	bootph-pre-ram;
 };
 
+&lcdif {
+	display = <&display0>;
+
+	/* panel is r8g8b8 */
+	display0: display@0 {
+		bits-per-pixel = <24>;
+		bits-per-color = <8>;
+	};
+};
+
 &pinctrl_i2c1 {
 	bootph-pre-ram;
 };
diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index b4351a392eff..2fa8bc22747e 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -56,6 +56,7 @@ CONFIG_SYS_PROMPT="> "
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_BMP=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=gpmi-nand"
 CONFIG_MTDPARTS_DEFAULT="gpmi-nand:64m(nandboot),16m(nandfit),32m(nandkernel),1m(nanddtb),8m(nandtee),-(nandrootfs)"
@@ -74,6 +75,8 @@ CONFIG_FASTBOOT_BUF_ADDR=0x40480000
 CONFIG_FASTBOOT_BUF_SIZE=0x20000000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 # CONFIG_MMC is not set
@@ -94,12 +97,17 @@ CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX8M_BLK_CTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_BD71837=y
 CONFIG_SPL_DM_PMIC_BD71837=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_IMX=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
@@ -112,5 +120,12 @@ CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_LCD_SYNAPTICS_R63353=y
+CONFIG_VIDEO_BRIDGE_SAMSUNG_DSIM=y
+CONFIG_VIDEO_MXS=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
 CONFIG_IMX_WATCHDOG=y
 # CONFIG_FAT_WRITE is not set
diff --git a/configs/imx8mn_bsh_smm_s2pro_defconfig b/configs/imx8mn_bsh_smm_s2pro_defconfig
index 0faa3376fd3d..b6b62b9d53f9 100644
--- a/configs/imx8mn_bsh_smm_s2pro_defconfig
+++ b/configs/imx8mn_bsh_smm_s2pro_defconfig
@@ -53,6 +53,7 @@ CONFIG_CMD_FUSE=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_BMP=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
@@ -68,6 +69,8 @@ CONFIG_FASTBOOT_BUF_SIZE=0x20000000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -83,12 +86,17 @@ CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX8M_BLK_CTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_BD71837=y
 CONFIG_SPL_DM_PMIC_BD71837=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_IMX=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
@@ -101,5 +109,12 @@ CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_LCD_SYNAPTICS_R63353=y
+CONFIG_VIDEO_BRIDGE_SAMSUNG_DSIM=y
+CONFIG_VIDEO_MXS=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
 CONFIG_IMX_WATCHDOG=y
 # CONFIG_FAT_WRITE is not set
-- 
2.43.0

