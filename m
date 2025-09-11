Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDD7CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 21:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DFEB83322;
	Thu, 11 Sep 2025 23:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JIw7HkwM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9982A833C0; Thu, 11 Sep 2025 23:54:16 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E8DC8334F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 23:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-8876de33c86so97125739f.3
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 14:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757627653; x=1758232453; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aainlRELdefdZEHPUHyqNcM/2S1gUksk+vmW+Cdkl/s=;
 b=JIw7HkwMLBXrnfmWWWWKLOlZZT1VyPe75OSnODXWl3Pylno8w5TV6iAGZOQoz025i9
 /ikVmd8acpCYwkk29V4Ahtlb2fi3L4Aw5OezXSHxTWX6GtV3EF1s3k8hKhafy1P3nwoG
 iT56bkki62k4EfyWP1Gy+Jk9pS48kW2e428sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757627653; x=1758232453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aainlRELdefdZEHPUHyqNcM/2S1gUksk+vmW+Cdkl/s=;
 b=VjId2i6p7OU5WemBr5cDsgVXAanepm2FPkb8oADCsA245OxHisCtq0ykHUTLlNLdol
 xui3+CTYM36S6WyNDQb7zGnqMuroIHU86QdaWK72ArThtsN02Uh0VIkInhyR8ahGp4U1
 yRXVv0RJnS74v3NKqNYz3CsDW04bgxzQkWZj+o5dqNwaZFeEEBys5N/ZSteqIeypspQm
 Sh4cWLz1Iafk4pVn5VrHESR2lQ96JXxpj4egPTurqsF/vZPg2HNrzStt7MEwdzbX87Ju
 NJZ4vRlMvfTWhpWunvAx/ZXGPMYKgIS/OPfVjJOp3Ln9N6taFDVNf9ZX8GyqjkJSz0Ak
 1LCA==
X-Gm-Message-State: AOJu0YxfP0xOC1E3pef7/U5LWHLgXdXIywlcdre+F1gigVMLJt++MxUq
 3el56L3jnJ5IrBXo3sL3lidiZG8PUdPaLw0Z4n5xpzdvjO7CGQwEcBPGYw5JagTTNhhzPTG/GUd
 dOc5VvcI=
X-Gm-Gg: ASbGnctiDuvwLoOjRFF4oUl7LvlS/sDYZZmUJhCUBPzZRPDVZrdyvyJgtSOpXgOMZ5Z
 wfEkC2FmALhUo41Q8iMKJvezRGdmEybqyEdQpxqEOu1F5pAduJETDstvivNovgXNsnhXh4pQ4uO
 OXD6OnAcFUHhDxlDG77W8+mA4g7fJdi4Rt0f+d9KmyXtY+lRpuTUIhYRgXIzsq4/QKxr0Xdw7Bd
 rWS5wmbkPWw0ewMJg41u5x8TPrNYOxo/YAe84Twsr7WHer7iuPBUf64fVXv9HjrzgfrahOZe+a5
 p+MwBrV5az857iTOGCX70SMY1chAKlofBxuw9RSwie/he1Y4N/zzNjAiYa10mWU6HI812uohlsM
 TzufWE0XgKWHc1+DN7t2W2Hi/cNX6wxxTQDCyw9Bt2SLEyKGzb0QjS9MEqRMnsJFde0ZFlA==
X-Google-Smtp-Source: AGHT+IGrS57Nn1CqUf3V9s0ZcjAlEOChvtOxZxLSrJxKliC4vJj8/SvK0W2JFpxxiwOPkHB6N3ejJw==
X-Received: by 2002:a05:6602:3f88:b0:886:e276:efe2 with SMTP id
 ca18e2360f4ac-890336978f2mr135175339f.11.1757627653190; 
 Thu, 11 Sep 2025 14:54:13 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-88f2a7db2f1sm101517639f.0.2025.09.11.14.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 14:54:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 1/6] usb: dwc3: Tighten driver glue dependencies
Date: Thu, 11 Sep 2025 15:50:18 -0600
Message-ID: <20250911215404.3955132-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911215404.3955132-1-trini@konsulko.com>
References: <20250911215404.3955132-1-trini@konsulko.com>
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

A few of the platform specific DWC3 host glue drivers cannot build
without access to some platform specific header files. Express those
requirements in Kconfig as well.

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Add Marek's tag
---
 drivers/usb/dwc3/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 682a69106556..744dfa90463c 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -17,6 +17,7 @@ comment "Platform Glue Driver Support"
 
 config USB_DWC3_OMAP
 	bool "Texas Instruments OMAP5 and similar Platforms"
+	depends on ARCH_OMAP2PLUS
 	help
 	  Some platforms from Texas Instruments like OMAP5, DRA7xxx and
 	  AM437x use this IP for USB2/3 functionality.
@@ -39,14 +40,14 @@ config SPL_USB_DWC3_GENERIC
 
 config SPL_USB_DWC3_AM62
 	bool "TI AM62 USB wrapper"
-	depends on SPL_DM_USB && SPL_USB_DWC3_GENERIC && SPL_SYSCON
+	depends on SPL_DM_USB && SPL_USB_DWC3_GENERIC && SPL_SYSCON && ARCH_K3
 	help
 	  Select this for TI AM62 Platforms.
 	  This wrapper supports Host and Peripheral operation modes.
 
 config USB_DWC3_AM62
 	bool "TI AM62 USB wrapper"
-	depends on DM_USB && USB_DWC3_GENERIC && SYSCON
+	depends on DM_USB && USB_DWC3_GENERIC && SYSCON && ARCH_K3
 	help
 	  Select this for TI AM62 Platforms.
 	  This wrapper supports Host and Peripheral operation modes.
@@ -80,7 +81,7 @@ config USB_DWC3_UNIPHIER
 config USB_DWC3_LAYERSCAPE
 	bool "Freescale Layerscape platform support"
 	depends on DM_USB && USB_DWC3
-	depends on !USB_XHCI_FSL
+	depends on !USB_XHCI_FSL && ARM
 	help
 	  Select this for Freescale Layerscape Platforms.
 
@@ -99,12 +100,14 @@ menu "PHY Subsystem"
 
 config USB_DWC3_PHY_OMAP
 	bool "TI OMAP SoC series USB DRD PHY driver"
+	depends on ARCH_OMAP2PLUS
 	help
 	  Enable single driver for both USB2 PHY programming and USB3 PHY
 	  programming for TI SoCs.
 
 config USB_DWC3_PHY_SAMSUNG
 	bool "Exynos5 SoC series USB DRD PHY driver"
+	depends on ARCH_EXYNOS
 	help
 	  Enable USB DRD PHY support for Exynos 5 SoC series.
 	  This driver provides PHY interface for USB 3.0 DRD controller
-- 
2.43.0

