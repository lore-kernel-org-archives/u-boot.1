Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C4DD462BF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 15:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B92A5895B0;
	Wed, 13 Nov 2024 16:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HoKEoPCt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22DBE895A3; Wed, 13 Nov 2024 16:09:56 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED66189595
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 16:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a3b8b34be9so23622425ab.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731510591; x=1732115391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=txzVoFcXfZJs9byniiPJbogKt6kP8EHHy0SyGxCkR4g=;
 b=HoKEoPCtuAQWxjy30n7uolzE2bAiI4hLNx4ibLYmDy4G4TvTEKtsy060G6sDaNcoQh
 egq1SdlLlMhOteTMZUVe3dIXm56JwxjbNxfsbOcp5Q0XTDs4HuPygM3eZKl0GprkQIVA
 aEGVyK4fTRBX+JLdiqggc9u0oNNV0BxcPjfvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731510591; x=1732115391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=txzVoFcXfZJs9byniiPJbogKt6kP8EHHy0SyGxCkR4g=;
 b=mk5lmfZRfd1B7lk/pLHVNlG5wXg+ZXY1IiHJOUyI96DlL11UcEGqmBMcWzZHDKSuJI
 V+hLNqxmN1J6oaT7t2n+hqmabyv/Dc9tVfwWalIZ9qKfNhuBSib8iDKkfGQUVi0+FApo
 exzpDQqjaEZgi0HVJqCiOahUIfoKMP2cf5IhfKvb9Jud6QiSgxpfSvDo12ciduqSFOK+
 N4CCOMBGIeY208FaxM9qdNiT2l1/Huolt1qE1isw8iTga5MSqOcgjuo3hCN9h6X0+IxQ
 4fMvCU0qbsotb8ZOu1jPlL21EZMeEkMCmmOtolXYMK3Pi9oTssvez33gaXUtdc4tt9S7
 fF2Q==
X-Gm-Message-State: AOJu0YxQdLoFX7g7uZ4tVUpK4lpI9wgc+dUCyu8jc0DXA0ZVYLD+c8R9
 TiedACORkMRx4vxVvqSHd8dLyEDQ7MADPDXk6uzjW18UJ14vD2+QaMRYd+IGQhJwmYxNDVhigjU
 =
X-Google-Smtp-Source: AGHT+IGLt4GnQYgK4zvikCvKy29z8ULW/mX+Bw1atq3LXSMNHNiDhncuE8X9HrTnp0aRZtl0AqI/qg==
X-Received: by 2002:a05:6e02:144c:b0:3a5:e1a8:8ab1 with SMTP id
 e9e14a558f8ab-3a6f19944bfmr220997565ab.3.1731510590894; 
 Wed, 13 Nov 2024 07:09:50 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a719d6b62fsm2710105ab.18.2024.11.13.07.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:09:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v5 1/8] bootstd: Avoid depending on BLK
Date: Wed, 13 Nov 2024 08:09:31 -0700
Message-Id: <20241113150938.1534931-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113150938.1534931-1-sjg@chromium.org>
References: <20241113150938.1534931-1-sjg@chromium.org>
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
index 7dd30a030e3..b5433e88f10 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -393,7 +393,7 @@ config BOOT_DEFAULTS
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

