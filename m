Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F889C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 16:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE0D87BF2;
	Fri,  2 Feb 2024 17:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="StkhgVmB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60F2287BF2; Fri,  2 Feb 2024 17:04:18 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A65C87186
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 17:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d722740622so4049775ad.0
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 08:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706889854; x=1707494654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTvyaINkirJySMHirPeZLKqUxFNBlnKeiZ2Cggxua8E=;
 b=StkhgVmBq3ekSk6ueXyn+V1jlBXmN1ma+Q223fDcRhLsuPA/LBkltGPnJBgp8SXXxJ
 PLjnVQnNCnv5iZZNgAcyH1vzGh+g2HAjJGHeUkZpemtOBzTTc2TN74hLeFaHSZywYM6d
 9pMRsO2JRDhrlQ56vX7Ob6UmX1DrLnClXOPf2aSD+gnLDmlljQG3erFhBOZ1bSPNsK+3
 aLghdgLfpoelVBGd121zv8tVIPD8lSdTaVwrSuHZhRxEn+enYAGFm+qDe6lbyckT0SYU
 aJlG98A69oxKvXbGhwb6+wXSplDvmmERBWbvX3IuBhdmL58nJk/2Wfj1yoTIDS9R+4CM
 chQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706889854; x=1707494654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTvyaINkirJySMHirPeZLKqUxFNBlnKeiZ2Cggxua8E=;
 b=LHi9mur6bU/SxyNpNHilZAyuwnGVWr8NuUbQjtzrg7lYEBX+KyRPzwfaxmMSWDacLb
 MYm4XqpxvQ0QDU1/LROwrHi8N7qzg8M0Qgyz2foqGrvV59uXyr2eq2OKL3homMaVCrXT
 JJodniUaRpR5D9GkkukcIrTpFhqL0FBc1Q6V92hqoLrR2PcF5n9bBUjFnavb0Oax/lYy
 xn2qaPcMD84nTD7ptpHWQuzZL/veYQ7mO7wfg5RAwd4Ebgnn9FVxIV9NicEtPqhEpqYX
 8dSkAt1u2SwA9QOT4rOn/1SE1dp8CtNpDZZtaF9UUdvky7V2vHINtvALoaIehFTBzdL4
 9rog==
X-Gm-Message-State: AOJu0Yy7Na8elCjd2Ii1+O6kBzOORT41adxzTIFQ2yPeRTZt113C1VW2
 yvqfM4R19TRV8uMHA3yfsQnVTObaWnIVDSt3IqUqK6GgF0eKy+II
X-Google-Smtp-Source: AGHT+IEUbl8RkiP8sw2KHJN0S/eBBD7gT12TYv2wwu1qCM3oJN10IujMqQVLAqUOqlD9yFgmPC7EMA==
X-Received: by 2002:a17:902:ee85:b0:1d8:f06a:9b6f with SMTP id
 a5-20020a170902ee8500b001d8f06a9b6fmr6446267pld.1.1706889854376; 
 Fri, 02 Feb 2024 08:04:14 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU0W4xk/E+OS5aqMawteFrw9ih7Sxa4kulCpZTPEqn/uAhOWNF0J5bYnR5nvOSSpGW7YnpclK38yO+sFtQfVux+ucc9EYJ9d015ZhA5UiDi+8qxFfnbG1+pYItTuhMlczX/ThDBWigEVZyn
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:fa09:d56a:f130:f280])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a170902b7c400b001d8b8bf8e44sm1780086plz.92.2024.02.02.08.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 08:04:14 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de,
	trini@konsulko.com
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 2/3] mx6sabresd: Convert to watchdog driver model
Date: Fri,  2 Feb 2024 13:04:04 -0300
Message-Id: <20240202160405.4126192-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202160405.4126192-1-festevam@gmail.com>
References: <20240202160405.4126192-1-festevam@gmail.com>
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

Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
the 'reset' command in U-Boot to not cause a board reset.

Fix it by switching to the watchdog driver model via sysreset, which
is the preferred method for implementing the watchdog reset.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- None.

 arch/arm/dts/imx6qdl-sabresd-u-boot.dtsi | 9 +++++++++
 configs/mx6sabresd_defconfig             | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/dts/imx6qdl-sabresd-u-boot.dtsi b/arch/arm/dts/imx6qdl-sabresd-u-boot.dtsi
index 5c4101b76da2..9e9c4422f00e 100644
--- a/arch/arm/dts/imx6qdl-sabresd-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-sabresd-u-boot.dtsi
@@ -9,6 +9,11 @@
 	aliases {
 		mmc1 = &usdhc3;
 	};
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog2>;
+		bootph-pre-ram;
+	};
 };
 
 &usdhc3 {
@@ -18,3 +23,7 @@
 &pinctrl_usdhc3 {
 	bootph-pre-ram;
 };
+
+&wdog2 {
+	bootph-pre-ram;
+};
diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index f19df607e7ae..69685f12eb10 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -103,6 +103,8 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MXC_SPI=y
@@ -129,3 +131,4 @@ CONFIG_IMX_HDMI=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.34.1

