Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F19C48286
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 01:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A51A87CAA;
	Fri,  2 Feb 2024 02:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PPaCu1bY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 259EB87C00; Fri,  2 Feb 2024 02:49:04 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC5FE87C66
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 02:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-59584f41f1eso466376eaf.1
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 17:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706838539; x=1707443339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5IepMW8EkuILbkH4NmsPvXcwJ8fMRTAABl26sZI0tVk=;
 b=PPaCu1bYO5jgkiNu+JVlT6Y9regfRrDeMGgna26n0ckTOq3R/ew8PqaGCGicd+RuQK
 UwrnREs4RBN7Rmmc6tOrkFEDVu0ti1er5IqR2pLjBXHxiOj1kheor3xPaXSuxKvIwXKI
 PG1ebu4FGE+GlGg145GUSDQcJsPq+rZbogvobXGVNI0Rh/B95cUPsupZql8Yx+4Q8Kb4
 UOiHq58FQaW+5ZLDcxwp1+F42zNvkVT9A7RkSIyyzczrcVcEz5crVE381sfwnQzqD2Ri
 YQM88Bxtntso6gZkpwx7xG7nEdCqsxoXfb6CDO39aSnDGBAy/NMWSw+Swq3+SR5cL1by
 aIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706838539; x=1707443339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5IepMW8EkuILbkH4NmsPvXcwJ8fMRTAABl26sZI0tVk=;
 b=K49Tgr59iFC4ASvMADmO3abkE8xC1WtKE//xSHSA/afvgfrlGNm3fQsWFLdZUDzDLF
 WUEoj0KkK61IO9P71Ezid67ovD/zG21dHcRE2ylCfmwwJ3d99BYH1wnrkDOengZ39PjR
 gj185LzoMCFiZyTihkgJoiHpDfsnG1coUkc7K9OY3hQh/yRtoD8hxz6bDbzVC1x0nt54
 eDG642ojX/v3MV2E6LH0pdfvRCHNp75CS50koHY6CXOb5iWEcYNs2Iu3i1PY0uRnwYtI
 GQ08J0XRhG7KEIdSTFt2ygovQPX0x4+HEx5Vd/lwNtXMfABG8BuOdzSZq+Clyr9O0ZnT
 RDqA==
X-Forwarded-Encrypted: i=0;
 AJvYcCXvNgBYw09V91FjyHSNM8Qnzntkp4n6diI4Z/lRV41QMrbAQxCf6mX/lk3sxkMQHBS+bDT2WK8ZPybKa4jayqjCNMmJ1g==
X-Gm-Message-State: AOJu0YwDxStQZ5QhxlYraAozNL6EqpBF+y52tC0GN2DLwb1Myr5s/Gmi
 bKCboSbJmhOqDVz5JuqS9oLDQdkhGUepMd5YnA8EXypJbK9WWMra
X-Google-Smtp-Source: AGHT+IG0XZkAYtbF7xAVtfBlyj8eMfP47Xa+pbpqzC3t5jFSWu1ESkQ9Ht0PU2Qr/EGVzGj/w7nNCg==
X-Received: by 2002:a05:6358:5e15:b0:176:c8e5:d1f4 with SMTP id
 q21-20020a0563585e1500b00176c8e5d1f4mr4076844rwn.1.1706838539239; 
 Thu, 01 Feb 2024 17:48:59 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXtOiplPSr3LBBaziFsJJo8aMDOsNuBvtO5QQOZKjU6Wr47tug5ohc8YssBGge/RxK2DaN6cWeE1w0IAs16z9DYcjL+3Fpdqv7AU1GhAUTq7AuvCrRhxg==
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8e7a:352d:b9a0:297a])
 by smtp.gmail.com with ESMTPSA id
 du13-20020a056a002b4d00b006d9b345092dsm406048pfb.156.2024.02.01.17.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 17:48:58 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] mx6sabresd: Convert to watchdog driver model
Date: Thu,  1 Feb 2024 22:48:49 -0300
Message-Id: <20240202014849.4022787-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202014849.4022787-1-festevam@gmail.com>
References: <20240202014849.4022787-1-festevam@gmail.com>
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

