Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9773C46CCD
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 10:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 381E2876DE;
	Wed, 20 Dec 2023 11:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iiz0zlFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE9AE876C9; Wed, 20 Dec 2023 11:39:17 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 588138750C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55361b7f38eso4093424a12.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 02:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703068753; x=1703673553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOFoml+FkhEHjDF9OkbvXs6jC30F7LjK8eDe8DmJADo=;
 b=iiz0zlFU/1fQANWTDmS/hGJJ2nif4fsOiNA/jb9bpiy+0acLH71imrAgeQpesDMplX
 hLIRUorkdDMIS/RnpXe30EGPRWIYNmN+GRftl3x2MIlte6QtLnOSX21RUsBiyHh4RbHH
 rXuen0u1is62csbujmob3vvnSpb+jRTKT5UOKCzOlAnGFq27apVhaOfcaZNayknJBYFj
 lLWE4b6hMjMcf7JprytPKJ5QP2e7OKM1RNsH1lZ2gxslnDCDK5gW5x1jY29R+kpuQMKA
 dphdSimvAj7rh60MnESyxfihNPUe2+C4lzgDcntOQmh9+sK0XYnLVpifofkCSWIJCi1b
 goug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703068753; x=1703673553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MOFoml+FkhEHjDF9OkbvXs6jC30F7LjK8eDe8DmJADo=;
 b=tzU/MomsQ5mswGKuM9XB/aSUHHxsz5PQeIpgwzPZx4ySXJsrL6InH2eeV2Nd805cLy
 nr7abG9jTYaJD5IECMJaIY66Ye7Y7YsHiZ8CiaZB8aFEYWQoblsykEirLhgtghzU8z2N
 KWBU4aYB6gmaXbnLqaqOYhPGhgWPjFR+BQa8OEdykjF7I9P+OVRhJ/fUmBJgXV3a2DHV
 06pMpMoz+WPbh36PIOGtN8rBfMLIqAZ0s/fPyzL+a9jpxKFBdM+aXeWhlf2MvIdqo1MX
 TxKmV3v7vtphSvFbmRMc7Ylkc7m9xwN1b5e3F7iLNMbCxUNOfS89cHVWEKciifOB9kIp
 ui7w==
X-Gm-Message-State: AOJu0YyFdzgr/7mDyAAJsx0AFqXZEFlL+iEdWxYOxJ7u1ht9CbTMp+Qy
 Uh0pehOiMoTP350GeUZNhVvT0ZC52LmK5g==
X-Google-Smtp-Source: AGHT+IF+tnO+bJabKcKE5vW539GZv26qiqBI4mDMa0Vd4fjWYb/VaMy3ooJ403pwIxeADY32pSK3sw==
X-Received: by 2002:a50:ab08:0:b0:551:4f66:af27 with SMTP id
 s8-20020a50ab08000000b005514f66af27mr6293989edc.31.1703068753476; 
 Wed, 20 Dec 2023 02:39:13 -0800 (PST)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch.
 [77.59.154.235]) by smtp.gmail.com with ESMTPSA id
 f19-20020a056402195300b005537b00132asm2259932edz.91.2023.12.20.02.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 02:39:12 -0800 (PST)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: u-boot@lists.denx.de,
	"NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 3/3] colibri-imx8x: configure usb hub to bypass mode
Date: Wed, 20 Dec 2023 11:38:11 +0100
Message-Id: <20231220103811.228515-4-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220103811.228515-1-andrejs.cainikovs@gmail.com>
References: <20231220103811.228515-1-andrejs.cainikovs@gmail.com>
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

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

This change configures Toradex Colibri iMX8X SoM USB
hub to bypass mode, and brings out of the reset state.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi | 15 +++++++++++++++
 arch/arm/dts/fsl-imx8qxp-colibri.dts         |  2 --
 configs/colibri-imx8x_defconfig              |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi b/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
index a6af4e5e2b7..6ab6b1f9ee6 100644
--- a/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
+++ b/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
@@ -84,6 +84,21 @@
 	bootph-some-ram;
 };
 
+&gpio_expander_43 {
+	usb-bypass-n-hog {
+		gpio-hog;
+		gpios = <5 GPIO_ACTIVE_LOW>;
+		line-name = "usb-bypass-n";
+		output-high;
+	};
+	usb-reset-n-hog {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_LOW>;
+		line-name = "usb-reset-n";
+		output-low;
+	};
+};
+
 &gpio0 {
 	bootph-some-ram;
 };
diff --git a/arch/arm/dts/fsl-imx8qxp-colibri.dts b/arch/arm/dts/fsl-imx8qxp-colibri.dts
index 295090ad711..b479921aff9 100644
--- a/arch/arm/dts/fsl-imx8qxp-colibri.dts
+++ b/arch/arm/dts/fsl-imx8qxp-colibri.dts
@@ -319,8 +319,6 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		reg = <0x43>;
-		initial_io_dir = <0xff>;
-		initial_output = <0x05>;
 	};
 };
 
diff --git a/configs/colibri-imx8x_defconfig b/configs/colibri-imx8x_defconfig
index 13c16bde3d8..ce60c509582 100644
--- a/configs/colibri-imx8x_defconfig
+++ b/configs/colibri-imx8x_defconfig
@@ -65,6 +65,7 @@ CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 CONFIG_CLK_IMX8=y
 CONFIG_CPU=y
+CONFIG_GPIO_HOG=y
 CONFIG_FXL6408_GPIO=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-- 
2.34.1

