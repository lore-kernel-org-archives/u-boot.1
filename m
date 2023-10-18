Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7ADCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 19:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A44486FF4;
	Wed, 18 Oct 2023 21:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fIKlkp3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A160686EDE; Wed, 18 Oct 2023 21:17:56 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF2386EDF
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 21:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b390036045so1172247b3a.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697656672; x=1698261472; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=81wofvtb/fEg9TOshQ0TjWGV25eCRJ0aWrPckbEadr8=;
 b=fIKlkp3MvfReEFaDrGpbHbxijOlJTQwQiqRtJko7bVzslLml8KO2PhB9uZasTHBsRh
 qVM9bxCri9vO+5PCvKm5GVEk3Hw2VO+oy12awC04TyTpRWM+TJA/CI6jXnSRcuo7NPAK
 RkLK1MEDc12nLCtoWXaHygMtHHdB6gLz5LqgJmKmAmRmhzb9BLhn9kXH5C16hx/vNVjM
 gmejIVmziSU8Rw4Bglnuh+GaYjv8wCIJvQNB3h207DqqwbZtEmYPe/tuUeFGlfDAdKty
 Qzu2MB+jy3/OJaHr5no+GO+6FkMAcD3cuFOiW42gLk+thXyGhyoUojKoLegP0n/S8kzN
 +uwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697656672; x=1698261472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=81wofvtb/fEg9TOshQ0TjWGV25eCRJ0aWrPckbEadr8=;
 b=iaM8qMZwTHBnd2M4IyN2vH8nnQXp17En0wFb0sS1Z5t+CTXE/Uuxf8OzzSU1Q92ThH
 WRPKaxKMtRtt/uoUIGSj3RMI7e1gcx+mGtW0dedyLxpMrs8GxbaksIKOhdKWI2vSykre
 rMY7qd5Bg6D9HPqHqxZJODnp3RiAwvvuqAGFVZ6sUrK7NiPWeEAhw7RyHbPxGKONeDiQ
 7hTFI5XHHdSHfNNUp+cJI6Kppm4PkuT+XOv9nUt4V6XE2yIMIRICWrb0kQUsSrBG85nL
 41YweVb1+GfyFpZuKsDBjPSMGF96eqchnc+WpWMauvcYyxC1GMxDEovaxsJR4LjPuiG8
 JrlA==
X-Gm-Message-State: AOJu0YwzSPtwyfMMWSRz2ToDq3zYTHW2JZfNqX729f4Ac8nAEggWRQPM
 eyF4BqtyPWfr139RK+Xl25Y=
X-Google-Smtp-Source: AGHT+IGRkx4pXzycKxQ6BxS1DPnET9LQluwYnJQeSWr8uU+kmS1FIBji5sbFwW3++AZukFaNooPpxQ==
X-Received: by 2002:a05:6a20:e117:b0:16c:b514:a4bc with SMTP id
 kr23-20020a056a20e11700b0016cb514a4bcmr77453pzb.4.1697656672607; 
 Wed, 18 Oct 2023 12:17:52 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f7a7:7252:9ef9:ef88])
 by smtp.gmail.com with ESMTPSA id
 ix7-20020a170902f80700b001c73eace0fesm277737plb.157.2023.10.18.12.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 12:17:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] imx8mp_evk: Convert to DM_PMIC
Date: Wed, 18 Oct 2023 16:17:41 -0300
Message-Id: <20231018191742.1303779-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Currently, the imx8mp_evk uses the non-DM code to initialize the PMIC.

Convert to DM_PMIC, which is the recommended way to access the PMIC.

While at it, fix multi-line comments style.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx8mp-evk-u-boot.dtsi | 18 ++++++++++-
 board/freescale/imx8mp_evk/spl.c    | 50 +++++++++++++++--------------
 configs/imx8mp_evk_defconfig        | 12 +++----
 3 files changed, 47 insertions(+), 33 deletions(-)

diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
index 9ed62f1bb02d..0bf489b46248 100644
--- a/arch/arm/dts/imx8mp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
@@ -13,6 +13,22 @@
 	};
 };
 
+&pinctrl_i2c1 {
+	bootph-all;
+};
+
+&pinctrl_pmic {
+	bootph-all;
+};
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@25} {
+	bootph-all;
+};
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@25/regulators} {
+	bootph-all;
+};
+
 &reg_usdhc2_vmmc {
 	u-boot,off-on-delay-us = <20000>;
 };
@@ -66,7 +82,7 @@
 };
 
 &i2c1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &i2c2 {
diff --git a/board/freescale/imx8mp_evk/spl.c b/board/freescale/imx8mp_evk/spl.c
index 246826a0d482..9dd2cbc799c3 100644
--- a/board/freescale/imx8mp_evk/spl.c
+++ b/board/freescale/imx8mp_evk/spl.c
@@ -67,40 +67,44 @@ struct i2c_pads_info i2c_pad_info1 = {
 	},
 };
 
-#if CONFIG_IS_ENABLED(POWER_LEGACY)
-#define I2C_PMIC	0
+#if CONFIG_IS_ENABLED(DM_PMIC_PCA9450)
 int power_init_board(void)
 {
-	struct pmic *p;
+	struct udevice *dev;
 	int ret;
 
-	ret = power_pca9450_init(I2C_PMIC, 0x25);
-	if (ret)
-		printf("power init failed");
-	p = pmic_get("PCA9450");
-	pmic_probe(p);
+	ret = pmic_get("pmic@25", &dev);
+	if (ret == -ENODEV) {
+		puts("No pmic@25\n");
+		return 0;
+	}
+	if (ret < 0)
+		return ret;
 
 	/* BUCKxOUT_DVS0/1 control BUCK123 output */
-	pmic_reg_write(p, PCA9450_BUCK123_DVS, 0x29);
+	pmic_reg_write(dev, PCA9450_BUCK123_DVS, 0x29);
 
 	/*
-	 * increase VDD_SOC to typical value 0.95V before first
-	 * DRAM access, set DVS1 to 0.85v for suspend.
+	 * Increase VDD_SOC to typical value 0.95V before first
+	 * DRAM access, set DVS1 to 0.85V for suspend.
 	 * Enable DVS control through PMIC_STBY_REQ and
 	 * set B1_ENMODE=1 (ON by PMIC_ON_REQ=H)
 	 */
-#ifdef CONFIG_IMX8M_VDD_SOC_850MV
-	/* set DVS0 to 0.85v for special case*/
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x14);
-#else
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x1C);
-#endif
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS1, 0x14);
-	pmic_reg_write(p, PCA9450_BUCK1CTRL, 0x59);
+	if (CONFIG_IS_ENABLED(IMX8M_VDD_SOC_850MV))
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x14);
+	else
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x1C);
 
-	/* Kernel uses OD/OD freq for SOC */
-	/* To avoid timing risk from SOC to ARM,increase VDD_ARM to OD voltage 0.95v */
-	pmic_reg_write(p, PCA9450_BUCK2OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x14);
+	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
+
+	/*
+	 * Kernel uses OD/OD freq for SOC.
+	 * To avoid timing risk from SOC to ARM,increase VDD_ARM to OD
+	 * voltage 0.95V.
+	 */
+
+	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x1C);
 
 	return 0;
 }
@@ -135,8 +139,6 @@ void board_init_f(ulong dummy)
 
 	enable_tzc380();
 
-	setup_i2c(0, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info1);
-
 	power_init_board();
 
 	/* DDR initialization */
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 820dc36e9cdd..0675f0f4f41b 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -7,9 +7,6 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mp-evk"
 CONFIG_SPL_TEXT_BASE=0x920000
@@ -88,8 +85,6 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
-# CONFIG_SPL_DM_I2C is not set
-CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -110,15 +105,16 @@ CONFIG_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-CONFIG_SPL_POWER_LEGACY=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
-CONFIG_POWER_PCA9450=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
-- 
2.34.1

