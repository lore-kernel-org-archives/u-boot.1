Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD824CD37BF
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 20:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B33A83D7A;
	Wed, 12 Nov 2025 21:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GCEU/GKP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3DA883D6C; Wed, 12 Nov 2025 21:03:27 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED57D83D0B
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 21:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30cce892b7dso569317fac.1
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 12:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762977804; x=1763582604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v+K1jaX9U5bpgdpOryL7WNYw828XvOH421rSGgCKNV8=;
 b=GCEU/GKPs57MunJOeXIjJPFA+UoxzTAHQu4uAzHExO1kHekxj5W4h4zshjMOPcaV+B
 kfMfuNDJZrwkIp7I+8F3X81ZB4H6ebKSbDLfpubaNYdr55NHCdUuXzWVkuQUZ5ecOlOG
 0oCvsJ9i1oq/ouM5hfEpjhjsnQ/MdrrdpWMys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762977804; x=1763582604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v+K1jaX9U5bpgdpOryL7WNYw828XvOH421rSGgCKNV8=;
 b=oxF8q2W4B9AkYWy383+f4PiI81NBT99JA2A9/Kgjzg/W2rPpDp6xgQS841D31nQN8t
 qKiDq5jpZ8u+xupByYbiv9zd/UsrVxvkNeTitmD8lfhlXuwX2tLP6BQJ7qF75FRGRyGR
 GRx/hSDsHLACIY6CRCIcMwVqfVp1elqQz0fWzJakaoZrwxLO3cREGkJrya+FwiP4baU9
 Z0AEjg+KNoiXHG1NbFk6tY21kzcV1DFisHjgiro5NHthCH5f8b8QkxxelVyp4JBleudO
 8yKG/5epVsjXienOMHnJ7M3l/A8gYuo2LjXXskcXd/p2hREWxOsyIlpII1beTzGS4M91
 EaKw==
X-Gm-Message-State: AOJu0YzdYPl4Xb8aY3Qok5JPiT2Kq6zqljp8RtPYvNZsBCMZ4M1er8Mq
 ZLsuGp+Py2cKOpOLIBq/qfXaoXuUPnfT/LuSEqnrpfge99OY4QrTXx5SAGadztduS09lFkFkH0K
 46juZdrP55g==
X-Gm-Gg: ASbGnctWZObEg58bGEwutXdELhUnq0fsd3ccP5aLORYAF6+rFB5xMULBaLz4Gqtz13p
 +uWYq+yXXRskdnOglQ8WOg/rbGVkNk3slCez1xNQg//zjTASTHwXZazLvM2nJdtV5W3bvLYsNVE
 bWq6RsD7RuMyaFbV9aX/fUVs9ElBz1mAzqQgg/A/zO+PymabKUtgurMOvmrU3h4rzADDtYGvLyq
 jW2PjgSKitgOO6sEmpaXyYc17PRnWQQLTF1I7O7FW7I5bsjkqEizszarqZCgw5a3NOY9O16Yssj
 x+ZeILHNjC2j3EPkdX4BvSe1nz0E/ODoe+lNdvUImW1OzAfo42q1KNvFisnqH8AnbFoudBN2zfy
 u9Zz26RZNK9AnpSlKd+ZcYyxeB2/xg+KlIHMz1Gf23R7Tdr7awYnNCJlVf0GjMc6agKwPuuzIcC
 BOnfu99sMEy5bks2aPdZ+qavcmk+XG7zQZoT80rwL6rJ/U2fv3faoi
X-Google-Smtp-Source: AGHT+IFMnLLvtQu5dxbNxiluiq1StcMzf4Sk1ql9pYpYZ/JCbAZM8eBBUSUgm7J4pZN1e/yoQRfNEg==
X-Received: by 2002:a05:6871:bd0d:b0:3d2:6747:552d with SMTP id
 586e51a60fabf-3e83434f47amr1700275fac.50.1762977803516; 
 Wed, 12 Nov 2025 12:03:23 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e83281c9bbsm2169596fac.18.2025.11.12.12.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 12:03:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCHv2 2/7] video: tegra: Rework some of the driver dependencies
Date: Wed, 12 Nov 2025 14:00:03 -0600
Message-ID: <20251112200315.1111980-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112200315.1111980-1-trini@konsulko.com>
References: <20251112200315.1111980-1-trini@konsulko.com>
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

Looking these drivers over, all of them cannot build without access to
some platform specific header files. Express those requirements in
Kconfig as well. Furthermore, update the logic a bit more to reflect
which parts are optional when other drivers are enabled and which parts
cannot be enabled (meaningfully) by themselves.

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 configs/star_defconfig      |  1 +
 drivers/video/tegra/Kconfig | 19 ++++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/configs/star_defconfig b/configs/star_defconfig
index 59eabdcb2b43..7015c417e9eb 100644
--- a/configs/star_defconfig
+++ b/configs/star_defconfig
@@ -86,4 +86,5 @@ CONFIG_VIDEO_LCD_LG_LH400WV3=y
 CONFIG_VIDEO_LCD_HITACHI_TX10D07VM0BAA=y
 CONFIG_BACKLIGHT_AAT2870=y
 CONFIG_VIDEO_BRIDGE=y
+CONFIG_VIDEO_TEGRA=y
 CONFIG_TEGRA_8BIT_CPU_BRIDGE=y
diff --git a/drivers/video/tegra/Kconfig b/drivers/video/tegra/Kconfig
index f32972d937e5..8bc29f2838bd 100644
--- a/drivers/video/tegra/Kconfig
+++ b/drivers/video/tegra/Kconfig
@@ -1,10 +1,12 @@
 config HOST1X_TEGRA
-	bool "NVIDIA Tegra host1x BUS support"
-	depends on SIMPLE_BUS
+	bool
+	select SIMPLE_BUS
+	help
+	  NVIDIA Tegra host1x BUS support
 
 config VIDEO_TEGRA
 	bool "Enable Display Controller support on Tegra devices"
-	depends on OF_CONTROL
+	depends on OF_CONTROL && ARCH_TEGRA
 	select HOST1X_TEGRA
 	help
 	   Enable support for Display Controller found in Tegra SoC. The
@@ -17,7 +19,7 @@ config VIDEO_TEGRA
 
 config VIDEO_DSI_TEGRA
 	bool "Enable DSI controller support on Tegra devices"
-	depends on VIDEO_BRIDGE && PANEL && DM_GPIO
+	depends on VIDEO_BRIDGE && PANEL && DM_GPIO && ARCH_TEGRA
 	select VIDEO_TEGRA
 	select VIDEO_MIPI_DSI
 	help
@@ -27,7 +29,7 @@ config VIDEO_DSI_TEGRA
 
 config VIDEO_HDMI_TEGRA
 	bool "Enable HDMI support on Tegra devices"
-	depends on VIDEO_BRIDGE && DM_I2C
+	depends on VIDEO_BRIDGE && DM_I2C && ARCH_TEGRA
 	select I2C_EDID
 	select VIDEO_TEGRA
 	help
@@ -36,16 +38,14 @@ config VIDEO_HDMI_TEGRA
 
 config TEGRA_BACKLIGHT_PWM
 	bool "Enable Tegra DC PWM backlight support"
-	depends on BACKLIGHT
-	select VIDEO_TEGRA
+	depends on BACKLIGHT && VIDEO_TEGRA
 	help
 	   Enable support for the Display Controller dependent PWM backlight
 	   found in the Tegra SoC and usually used with DSI panels.
 
 config TEGRA_8BIT_CPU_BRIDGE
 	bool "Enable 8 bit panel communication protocol for Tegra 20/30"
-	depends on VIDEO_BRIDGE && DM_GPIO
-	select VIDEO_TEGRA
+	depends on VIDEO_BRIDGE && DM_GPIO && VIDEO_TEGRA
 	select VIDEO_MIPI_DSI
 	help
 	   Tegra 20 and Tegra 30 feature 8 bit CPU driver panel control
@@ -54,6 +54,7 @@ config TEGRA_8BIT_CPU_BRIDGE
 
 config VIDEO_TEGRA124
 	bool "Enable video support on Tegra124"
+	depends on ARCH_TEGRA
 	imply VIDEO_DAMAGE
 	help
 	   Tegra124 supports many video output options including eDP and
-- 
2.43.0

