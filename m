Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BAAC54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B6488A3C;
	Mon,  2 Sep 2024 00:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UtYqu+JE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25003889FC; Mon,  2 Sep 2024 00:27:48 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F35FE889FC
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-39d22965434so13702075ab.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229664; x=1725834464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WL8AW1iwOEe5uhwAoQzo/LgeIFDwCpMMcRbgPCfb3c=;
 b=UtYqu+JEbssO3c/qWMG2LBNV8oZV7QMCCj+C+K4M11QOn+xyr8a5E6RGEnKUC4Nkez
 3nlsaL9WtDnsJ7Ugjen9XpycXShm8NrchsisKG6jOONm+oa9J/gNt4OYxiH3rjzdjTo5
 cG1Y6JU8prxeWViDigO27yaVGuI0SPf4gIQaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229664; x=1725834464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WL8AW1iwOEe5uhwAoQzo/LgeIFDwCpMMcRbgPCfb3c=;
 b=i5hi2/u8fUpmni0LKyvbQODBPw0mVP0hR9hGoOhp0o8+ByJjN5i+hBL3vQ+87Kny5r
 TnJeExKrbd5RupJ7I1mH2vYGk8oDtDFLp5XYu8GvjnD0rXg9DmNM+smLWv1BlbNifwoH
 qAmoeaLYdn//5F/CJTVDqzEhkJqjP9Ik3E9M1IArrRBDN4POdlkDf/KTIP6gnPYL3sf7
 j+pEpTeboN5oJxVwkUqhlXzIuk1tDpNHNayRmEifkRH5QSPM13rrbQT7eCkHKLv3tgQV
 qBi0vKaxmi1ODYbalLqF+T5L36p0k8gPAmqHdYZ1/xLED6uPYpFvkff2AkqdH/Vtpxo5
 RtOg==
X-Gm-Message-State: AOJu0Yy9OV7T0fMpM7JrRjyKsVsBt+BciDKzU/St9kHyTjcTuVsASSzY
 RVLq/DnIY3YAkx61TTWF8zHdFyT+fOn3bF1GyFeM+8qinD2E+QEJ4thNy8nsl+N1gHyx2jZZ5v8
 =
X-Google-Smtp-Source: AGHT+IHc8I5YOVabMrfTCBmhdi1dtTXpOlExVTG7hNT0EANmDLan3vR3rR/ZuzAVPMRYE0PvVeuXhA==
X-Received: by 2002:a05:6e02:1aaa:b0:375:a3eb:bfcd with SMTP id
 e9e14a558f8ab-39f38b0c73fmr91340305ab.8.1725229664164; 
 Sun, 01 Sep 2024 15:27:44 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2e17bb4sm1866981173.82.2024.09.01.15.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 3/8] bootstd: Avoid depending on BLK
Date: Sun,  1 Sep 2024 16:27:29 -0600
Message-Id: <20240901222734.462334-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222734.462334-1-sjg@chromium.org>
References: <20240901222734.462334-1-sjg@chromium.org>
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

In principle bootstd can work without block devices, even if it does
require driver model to be enabled in that case.

The use of a 'depends on BLK' for BOOTSTD conflicts with the way 'BLK'
is now defined, producing recursive errors through multiple different
paths, one of which is this (with Linksprite_pcDuino3 and
BOOTSTD_DEFAULTS enabled):

  arch/arm/Kconfig:7:error: recursive dependency detected!
  arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_UNIPHIER_V8_MULTI
  arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
     part of choice <choice>
  arch/arm/mach-uniphier/Kconfig:6: choice <choice> contains symbol
     ARCH_UNIPHIER_V8_MULTI
  arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
     part of choice SPL
  arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends on SUPPORT_SPL
  common/spl/Kconfig:1: symbol SUPPORT_SPL is selected by ASPEED_AST2600
  arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST2600 is part of
     choice <choice>
  arch/arm/mach-aspeed/Kconfig:12: choice <choice> contains symbol
     ASPEED_AST2500
  arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST2500 is part of
     choice DM_RESET
  arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RESET is selected
     by CLK_RCAR_GEN3
  drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 depends on
     CLK_RENESAS
  drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS depends on CLK
  drivers/clk/Kconfig:3: symbol CLK is selected by IMX8M_POWER_DOMAIN
  drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_DOMAIN depends on
     POWER_DOMAIN
  drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is selected by
     BCM6318_USBH_PHY
  drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depends on PHY
  drivers/phy/Kconfig:4: symbol PHY is selected by USB_EHCI_MX7
  drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 depends on USB
  drivers/usb/Kconfig:1: symbol USB is selected by BOOTSTD_DEFAULTS
  boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on BOOTSTD
  boot/Kconfig:398: symbol BOOTSTD depends on BLK
  drivers/block/Kconfig:1: symbol BLK is selected by PVBLOCK
  drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
  Kconfig:176: symbol XEN depends on ARM64

We don't want to revert the change to BLK, which has been in place for
a year now. We don't want to select BLK in BOOTSTD since it should
support booting without block devices. The only realistic option is to
remove BOOTSTD's dependency on BLK.

Disable standard boot on the one board which fails.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Drop wip (work-in-progress) comment in commit

Changes in v2:
- Add new patch to resolve BOOTSTD->BLK recursion with Kconfig

 boot/Kconfig                                   | 2 +-
 configs/gardena-smart-gateway-mt7688_defconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 7ac34574079..291919ea1ef 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -398,7 +398,7 @@ config BOOT_DEFAULTS
 menuconfig BOOTSTD
 	bool "Standard boot"
 	default y
-	depends on DM && OF_CONTROL && BLK
+	depends on DM && OF_CONTROL
 	help
 	  U-Boot supports a standard way of locating something to boot,
 	  typically an Operating System such as Linux, provided by a distro such
diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index f4642e3fcff..36bf5f11d9a 100644
--- a/configs/gardena-smart-gateway-mt7688_defconfig
+++ b/configs/gardena-smart-gateway-mt7688_defconfig
@@ -30,6 +30,7 @@ CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=655360
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
+# CONFIG_BOOTSTD is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_STOP_STR="x"
-- 
2.34.1

