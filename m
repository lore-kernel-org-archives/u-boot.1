Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FEBC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 21:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A38887A28;
	Mon,  8 Jan 2024 22:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O1oHTm19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E5F087A47; Mon,  8 Jan 2024 22:11:55 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DC20877AF
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 22:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5cdf90e5cdeso291356a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 13:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704748311; x=1705353111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzuHr5ljxXe5twbIQo7He6O8ZfJothF8mxZ5zMhl+58=;
 b=O1oHTm19MyiSjvPgY0RFc2MdF/xLzOlUIX4Z+VKo8qInTRqZtTh7elyXxforkgSjBN
 nErCcyZu3JJFUkie/Al+/ii9rdmrFuFAO9RFGdmR3gL2M1WmH1X0zEnYHVdWepL0dKut
 griwXYk8hhsA1xGXd7qKpmPonPSXci3FO24I7seVlpESEbyXtvyCQo6+i7mkBMfVXk1i
 Nj23xJP5eQvPljvs1y3CQcoC15ue1hbeOHSav8SE1/0TQ/UmNG9S8aBC0ZUy3YeWWa2W
 bV/cfrepjQ1q9cVDgCGpGFlyZkTzI58HhiUtzcRcKlMqz05E7SAWpKyQbexi3ICjruGn
 UQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704748311; x=1705353111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzuHr5ljxXe5twbIQo7He6O8ZfJothF8mxZ5zMhl+58=;
 b=wlkHeF6VaA+OQaROKKyZBq5nlgroXzSqxgOiBhWM56+KLm2HafAWwnElkpDYMqQnEQ
 3OcCbJs9ffib0GN4qs3MYpcVYo52cDpJJgUDrBUzcaN2i7GWp6UUPoyrIpTCz4WVr5EH
 UopZt4jQfrIvlIowxbKlvqIDQ3u6cW+j04BczIlKjnBIS1KWSC9XIfKsJ3j60uthVJGo
 LL/QGlznYbeliw5iU/dtpQ+XH6rxz05dP1ybo8miCTPvinZ87DInugLDoN5dfLFUY3ci
 iMnvo5Pbdau1Z3PdUfM0XtciIa+L3IM7O6ZwOO1Hall7FjzMt09//KnZYz8JwNbxiXN4
 p81Q==
X-Gm-Message-State: AOJu0YzauZnx8Rv8e83gZVRWU739tX9ikOExcAyHw1jiH4q9LajPgU3O
 8s5DCP/OWQIEXV3OwIRzbZM=
X-Google-Smtp-Source: AGHT+IG64mOxPfujqRz17a7+YSD8DloXVWW9UnadsWMjSVkqMO2D9VarxbX0/+q42SSm5Eajz14w9g==
X-Received: by 2002:a05:6a00:2e8b:b0:6d9:b7b8:133f with SMTP id
 fd11-20020a056a002e8b00b006d9b7b8133fmr9293410pfb.1.1704748311382; 
 Mon, 08 Jan 2024 13:11:51 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:63f2:cfe7:4b90:23c])
 by smtp.gmail.com with ESMTPSA id
 r11-20020aa7988b000000b006d9aa6592d0sm304581pfl.82.2024.01.08.13.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 13:11:50 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: m.othacehe@gmail.com, peng.fan@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 3/3] imx8m: Select BINMAN at SoC level
Date: Mon,  8 Jan 2024 18:11:40 -0300
Message-Id: <20240108211140.3270595-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108211140.3270595-1-festevam@gmail.com>
References: <20240108211140.3270595-1-festevam@gmail.com>
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

All i.MX8M targets rely on using binman to generate the U-Boot
binary.

Select it at the SoC level instead of per board.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/mach-imx/imx8m/Kconfig | 39 +--------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 67da198956c2..b1937198402f 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -2,6 +2,7 @@ if ARCH_IMX8M
 
 config IMX8M
 	bool
+	select BINMAN
 	select GICV3 if ARMV8_PSCI
 	select HAS_CAAM
 	select ROM_UNIFIED_SECTIONS
@@ -41,13 +42,11 @@ choice
 
 config TARGET_IMX8MQ_CM
 	bool "Ronetix iMX8MQ-CM SoM"
-		select BINMAN
 	select IMX8MQ
 	select IMX8M_LPDDR4
 
 config TARGET_IMX8MQ_EVK
 	bool "imx8mq_evk"
-	select BINMAN
 	select IMX8MQ
 	select IMX8M_LPDDR4
 	select FSL_CAAM
@@ -56,26 +55,22 @@ config TARGET_IMX8MQ_EVK
 
 config TARGET_IMX8MQ_PHANBELL
 	bool "imx8mq_phanbell"
-	select BINMAN
 	select IMX8MQ
 	select IMX8M_LPDDR4
 
 config TARGET_IMX8MQ_REFORM2
 	bool "imx8mq_reform2"
-	select BINMAN
 	select IMX8MQ
 	select IMX8M_LPDDR4
 
 config TARGET_IMX8MM_DATA_MODUL_EDM_SBC
 	bool "Data Modul eDM SBC i.MX8M Mini"
-	select BINMAN
 	select IMX8MM
 	select IMX8M_LPDDR4
 	select SUPPORT_SPL
 
 config TARGET_IMX8MM_EVK
 	bool "imx8mm LPDDR4 EVK board"
-	select BINMAN
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
@@ -85,7 +80,6 @@ config TARGET_IMX8MM_EVK
 
 config TARGET_IMX8MM_ICORE_MX8MM
 	bool "Engicam i.Core MX8M Mini SOM"
-	select BINMAN
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
@@ -104,21 +98,18 @@ config TARGET_IMX8MM_ICORE_MX8MM
 
 config TARGET_IMX8MM_MX8MENLO
 	bool "Support i.MX8M Mini MX8Menlo board based on Toradex Verdin SoM"
-	select BINMAN
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
 
 config TARGET_IMX8MM_PHG
 	bool "i.MX8MM PHG board"
-	select BINMAN
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
 
 config TARGET_IMX8MM_VENICE
 	bool "Support Gateworks Venice iMX8M Mini module"
-	select BINMAN
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
@@ -130,7 +121,6 @@ config TARGET_IMX8MM_VENICE
 
 config TARGET_KONTRON_MX8MM
 	bool "Kontron Electronics N80xx"
-	select BINMAN
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
@@ -140,21 +130,18 @@ config TARGET_KONTRON_MX8MM
 
 config TARGET_IMX8MN_BSH_SMM_S2
 	bool "imx8mn-bsh-smm-s2"
-	select BINMAN
 	select IMX8MN
 	select SUPPORT_SPL
 	select IMX8M_DDR3L
 
 config TARGET_IMX8MN_BSH_SMM_S2PRO
 	bool "imx8mn-bsh-smm-s2pro"
-	select BINMAN
 	select IMX8MN
 	select SUPPORT_SPL
 	select IMX8M_DDR3L
 
 config TARGET_IMX8MN_EVK
 	bool "imx8mn LPDDR4 EVK board"
-	select BINMAN
 	select IMX8MN
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
@@ -163,7 +150,6 @@ config TARGET_IMX8MN_EVK
 
 config TARGET_IMX8MN_DDR4_EVK
 	bool "imx8mn DDR4 EVK board"
-	select BINMAN
 	select IMX8MN
 	select SUPPORT_SPL
 	select IMX8M_DDR4
@@ -172,7 +158,6 @@ config TARGET_IMX8MN_DDR4_EVK
 
 config TARGET_IMX8MN_VENICE
 	bool "Support Gateworks Venice iMX8M Nano module"
-	select BINMAN
 	select IMX8MN
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
@@ -184,14 +169,12 @@ config TARGET_IMX8MN_VENICE
 
 config TARGET_IMX8MP_DATA_MODUL_EDM_SBC
 	bool "Data Modul eDM SBC i.MX8M Plus"
-	select BINMAN
 	select IMX8MP
 	select IMX8M_LPDDR4
 	select SUPPORT_SPL
 
 config TARGET_IMX8MP_BEACON
 	bool "imx8mm Beacon Embedded devkit"
-	select BINMAN
 	select IMX8MP
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
@@ -201,21 +184,18 @@ config TARGET_IMX8MP_BEACON
 
 config TARGET_IMX8MP_DEBIX_MODEL_A
 	bool "Polyhex i.MX8M Plus Debix Model A SBC"
-	select BINMAN
 	select IMX8MP
 	select IMX8M_LPDDR4
 	select SUPPORT_SPL
 
 config TARGET_IMX8MP_DH_DHCOM_PDK2
 	bool "DH electronics DHCOM Premium Developer Kit (2) i.MX8M Plus"
-	select BINMAN
 	select IMX8MP
 	select IMX8M_LPDDR4
 	select SUPPORT_SPL
 
 config TARGET_IMX8MP_ICORE_MX8MP
 	bool "Engicam i.Core MX8M Plus SOM"
-	select BINMAN
 	select IMX8MP
 	select IMX8M_LPDDR4
 	select SUPPORT_SPL
@@ -229,7 +209,6 @@ config TARGET_IMX8MP_ICORE_MX8MP
 
 config TARGET_IMX8MP_EVK
 	bool "imx8mp LPDDR4 EVK board"
-	select BINMAN
 	select IMX8MP
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
@@ -239,7 +218,6 @@ config TARGET_IMX8MP_EVK
 
 config TARGET_IMX8MP_VENICE
 	bool "Support Gateworks Venice iMX8M Plus module"
-	select BINMAN
 	select IMX8MP
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
@@ -251,13 +229,11 @@ config TARGET_IMX8MP_VENICE
 
 config TARGET_PICO_IMX8MQ
 	bool "Support Technexion Pico iMX8MQ"
-	select BINMAN
 	select IMX8MQ
 	select IMX8M_LPDDR4
 
 config TARGET_IMX8MN_VAR_SOM
 	bool "Variscite imx8mn_var_som"
-	select BINMAN
 	select IMX8MN
 	select SUPPORT_SPL
 	select IMX8M_DDR4
@@ -268,27 +244,23 @@ config TARGET_IMX8MN_VAR_SOM
 
 config TARGET_KONTRON_PITX_IMX8M
 	bool "Support Kontron pITX-imx8m"
-	select BINMAN
 	select IMX8MQ
 	select IMX8M_LPDDR4
 
 config TARGET_VERDIN_IMX8MM
 	bool "Support Toradex Verdin iMX8M Mini module"
-	select BINMAN
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
 
 config TARGET_VERDIN_IMX8MP
 	bool "Support Toradex Verdin iMX8M Plus module"
-	select BINMAN
 	select IMX8MP
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
 
 config TARGET_IMX8MM_BEACON
 	bool "imx8mm Beacon Embedded devkit"
-	select BINMAN
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
@@ -298,7 +270,6 @@ config TARGET_IMX8MM_BEACON
 
 config TARGET_IMX8MN_BEACON
 	bool "imx8mn Beacon Embedded devkit"
-	select BINMAN
 	select IMX8MN
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
@@ -308,21 +279,18 @@ config TARGET_IMX8MN_BEACON
 
 config TARGET_PHYCORE_IMX8MM
 	bool "PHYTEC PHYCORE i.MX8MM"
-	select BINMAN
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
 
 config TARGET_PHYCORE_IMX8MP
 	bool "PHYTEC PHYCORE i.MX8MP"
-	select BINMAN
 	select IMX8MP
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
 
 config TARGET_IMX8MM_CL_IOT_GATE
 	bool "CompuLab iot-gate-imx8"
-	select BINMAN
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
@@ -330,7 +298,6 @@ config TARGET_IMX8MM_CL_IOT_GATE
 
 config TARGET_IMX8MM_CL_IOT_GATE_OPTEE
 	bool "CompuLab iot-gate-imx8 with optee support"
-	select BINMAN
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
@@ -338,28 +305,24 @@ config TARGET_IMX8MM_CL_IOT_GATE_OPTEE
 
 config TARGET_IMX8MP_RSB3720A1_4G
 	bool "Support i.MX8MP RSB3720A1 4G"
-	select BINMAN
 	select IMX8MP
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
 
 config TARGET_IMX8MP_RSB3720A1_6G
 	bool "Support i.MX8MP RSB3720A1 6G"
-	select BINMAN
 	select IMX8MP
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
 
 config TARGET_MSC_SM2S_IMX8MP
 	bool "MSC SMARC2 i.MX8MPLUS"
-	select BINMAN
 	select IMX8MP
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
 
 config TARGET_LIBREM5
 	bool "Purism Librem5 Phone"
-	select BINMAN
 	select IMX8MQ
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
-- 
2.34.1

