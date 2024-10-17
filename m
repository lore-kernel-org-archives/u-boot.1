Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B56D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:31:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4488E892B7;
	Fri, 18 Oct 2024 01:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BTKofnc+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A5C98928E; Fri, 18 Oct 2024 01:25:42 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7248A892BA
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a3b1aa0e80so6261535ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207538; x=1729812338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZbML1BPH9MKzr86Gln0St56oaFhR5wT5cI17EJlBao=;
 b=BTKofnc+K6+sh1tyquQXEQHmjjekq8aXu98WshPi5mSWW7Okw7xRorQoZSttH8w+5R
 GG/FSwMxjkLEaCv65RYZtaYV4jj1hrKc6q9+uUZDWPSXtWoT6loQQjEv4mUY8H2Lrr7E
 87ANBvEH1TvTjurrEjpQQsTfHQs61JZ0/dzG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207538; x=1729812338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gZbML1BPH9MKzr86Gln0St56oaFhR5wT5cI17EJlBao=;
 b=bQGuGB3QwtyvFwWQvOcKhdKN3ZjLiza+DifC13Ow2vBi2o6TR7ArTmO9Qya4hm2EjL
 zdtHic4bTvU17uPSYSMTVG1yus8d/s1XTqxsr7A92zIOpj+J322ahU4Cx5RxkvFQ/mrc
 Hz01APCvkKnrzgmw47JvPE2aF4DYLR9bXz6xevJDpxYhYFl2G7g7xd7sfCHhlmVCunG8
 GePwqtYKyNf6wbgx/83qox2YVQ+JGqF1LUYBnK/HCVCLgC58O3HPPM+/cy/Crm+o5O0V
 IP4POID2NN3qGI45TaSgZC43SmT8Z1TYQL3NWCySnoPYBKaLEjC8Ai3ha3Huhlf7Tfax
 uByQ==
X-Gm-Message-State: AOJu0YzCpx63d84cHcVWBysy58KOc4jCt4q+s1F8t/57IvIFlpTipTv+
 3esziNfeX3GgpKxipgs5GQgaApKbSPTqFYo8WV1NHQt1G59hb2rUoiWE59VJoDM2bR7D7oZ4L4Y
 =
X-Google-Smtp-Source: AGHT+IFnxyMpEQ93h16DJ7QtroGnw9NuIULr+/rUn8wYu1pQOYyB3ZFQb80uAlp/tzaUr8LmXJpR9A==
X-Received: by 2002:a05:6e02:1aa3:b0:3a3:b4ec:b400 with SMTP id
 e9e14a558f8ab-3a3f409e6ebmr3700085ab.17.1729207538083; 
 Thu, 17 Oct 2024 16:25:38 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ac9csm122057173.29.2024.10.17.16.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v4 3/8] bootstd: Avoid depending on BLK
Date: Thu, 17 Oct 2024 17:25:26 -0600
Message-Id: <20241017232531.726559-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232531.726559-1-sjg@chromium.org>
References: <20241017232531.726559-1-sjg@chromium.org>
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

(no changes since v3)

Changes in v3:
- Drop wip (work-in-progress) comment in commit

Changes in v2:
- Add new patch to resolve BOOTSTD->BLK recursion with Kconfig

 boot/Kconfig                                   | 2 +-
 configs/gardena-smart-gateway-mt7688_defconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 1d50a83a2d2..ccbc113d8e2 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -400,7 +400,7 @@ config BOOT_DEFAULTS
 menuconfig BOOTSTD
 	bool "Standard boot"
 	default y
-	depends on DM && OF_CONTROL && BLK
+	depends on DM && OF_CONTROL
 	help
 	  U-Boot supports a standard way of locating something to boot,
 	  typically an Operating System such as Linux, provided by a distro such
diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index b7f4a76ce68..85f42a3ab6d 100644
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

