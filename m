Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CD4C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656F783A9A;
	Wed,  6 Aug 2025 16:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dLeTWPSf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526C683A6A; Wed,  6 Aug 2025 16:56:09 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF08983A5A
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-61b43c84905so1284324eaf.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492164; x=1755096964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OOygT2Yl4g+puut43cRfOvvKrPyvInqQtLe9039fMms=;
 b=dLeTWPSfxpiox6Ng7VFck6qPCjqF7UlR4ZSt8+XFUKqbLltCOcIhK3YVAMXTkFuJA0
 OppE6s5JVWmxd1CMbkp/G2+hyPxGL8sefSLWmldt466OAUPgTfUesO/AOZirgToSpgs5
 N5QInLH0HXlzT1CFV17rx7SEYeHXMpcv0U4dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492164; x=1755096964;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OOygT2Yl4g+puut43cRfOvvKrPyvInqQtLe9039fMms=;
 b=a/3dkPtmLKAmn/ujI6GB/wjyTv65hz8ClAPFwE319EWkoFy+RG0dSsVnOZ9jMYmA2b
 Mg3s/nlLfL1UxF49pOm7ZhhFGUEBz+yOaID8J/9Ww3hH9S62Ycl8pZat9M/KFmyEPlfL
 XpqCoPtHd54xVHxF2mIoIQU8VCLhuFPgi9x0S02NvCKn3OyzyiCclGezUIPFQ+sbFkc7
 WkRvn+a1zeGHl89mbGVIDFWsLd9jdVLfKV+sEUuvS05iCQmnyU3C5DzeHS/qE0c5gKAN
 eIGPGVhgyfLiRa0cTqEr8D+HEb+ygw2On/LYNT58iPv7KavDVJTGpF5ZQny4M+ehon4U
 11NA==
X-Gm-Message-State: AOJu0YzK12dvUfKqPzApJbEv0GB7mC3b7LFYzwR93OTqcc9Th0HLV4Qd
 u9riBtywpwEZEr2J2SHzUmrb8E8Uwe4/nAhsXi5jheV2olYIb4x/CdfCnHccI4CAZ0LzL4KfMNx
 hO+SwudI=
X-Gm-Gg: ASbGnctbr91kAQFZic5jxYlMhfVYmVtIXGoeQollhykSXeI5ngsf/sreJGnnxcvYq1H
 BjOG5NNC6uSFWl+/9TmMJo/c5N6JP7ZITTp3IYKYzP3gpYQAKKLrimuY8fUkhDrpzxJtLfE+AtZ
 Ti1XOds1Oa/YazDxS+HxUun1ADtcu6hV07pBFB10SPkfFFg95DhTWJm24iOgKNUHPYDp+U6ChU/
 bbee0PAF7R02dIqcidhvOh5K81ME28NxGvFEADDLXlOjn2OpxQM13bMRlG7arQq072tKBqth2Xx
 5mp9FzK9Zrj91VVRZ7dVP0fJiH6IwRsxtENi+91Wxb0FSmW5DBo+rfMtDO4FiawGyey80ySOsfe
 rj88XhVpCGwSf5YPp/oK6N8d2DfTA6tPd9CQ0Lj0C5HDSOkRlGpq5gMSmGVs=
X-Google-Smtp-Source: AGHT+IGIeNVlWoLMMNgoPDGiqATolUj91SqGLiuR4BZBiQ5BnDvpmySENqqNFjiyJqsQVhFC9S8jAA==
X-Received: by 2002:a05:6871:806:b0:307:b28:48e3 with SMTP id
 586e51a60fabf-30be2bf0633mr1854597fac.18.1754492164492; 
 Wed, 06 Aug 2025 07:56:04 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30ba8228a79sm1925391fac.35.2025.08.06.07.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:56:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH 1/7] usb: dwc3: Tighten driver glue dependencies
Date: Wed,  6 Aug 2025 08:55:55 -0600
Message-ID: <20250806145601.1664563-1-trini@konsulko.com>
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

A few of the platform specific DWC3 host glue drivers cannot build
without access to some platform specific header files. Express those
requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut@mailbox.org>
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

