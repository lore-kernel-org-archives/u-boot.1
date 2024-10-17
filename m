Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6E5D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D00A8916C;
	Fri, 18 Oct 2024 01:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jHHNrKJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71F8B88F23; Fri, 18 Oct 2024 01:12:08 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 908EC8912B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbd1ae26a6so10308556d6.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206722; x=1729811522; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x9LnxrxaRFkthNDuSl0he+jfWzB99vTiytD/7gS3+E4=;
 b=jHHNrKJIojJGN9V5JOg7kVPpgiJlUoUDJhDprCgVw2JSvlSM9+0HU0rjDSnv6yEVkd
 GfP4xUCR25AyATq8jbT+XxFJviczvvntwTii6gHowQL1yaLrScg2iuSKLxbvH5yfcDnf
 byhTH6zXWRvxdM6jOXmvPCbEhaXuNsZqZUdps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206722; x=1729811522;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x9LnxrxaRFkthNDuSl0he+jfWzB99vTiytD/7gS3+E4=;
 b=hYdxlegyFHD7Eg6Gll+BPj0RkZTel5057i7iCgyujkzKkqCzjad/ujBXP045a6nJyG
 2h/4vx/+O6VITBFHbFRyi0q2SG4yXiAMx9uDq0RCWfJ7gh0SUsNbs+5HNr1Em0MYQUAU
 /bixIz/A/OihTV7tCz1VOp+jm0Cw1hN6BRz66Iakis8uTZyJS5sB9if3G2QNexSwHjr6
 P8Akqqqok5V6OUzOcqeY+2IOlBiXatJSWYixhMWFt1OPROFYSH1pWVGA94OPoS2/6M2m
 Wju/ZULjXHqnnhV6lfUwNKM7oAXD5znGXgdqiFR1X/l8DCqLK0EHz5RVYVUzTsmJuXlE
 hOyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXE7cXI1+OVPXtGETngbj1ZFnHMpgQ41pdz2zPalKPZEZjj3KRLaFmCE9wWL1mV5VRPJYKRiA=@lists.denx.de
X-Gm-Message-State: AOJu0YwdCqmYPpMcYOL51VJJ1r8PKKxXudR4hFuDabHrMmXC0oXNraZQ
 ao9kKOCQ+GRTMFiT61gwwXtpS0vNqZ+Bd1i8FLR/xGhAHxQ7tlu8PsiQBVQZYnGUEkD4jiIbxuV
 OBL/QBMuvtaF4Zou+Orm8T0UstKfChXNKalEJ
X-Google-Smtp-Source: AGHT+IEOwJlIbXd2YmJlgtzh/IhgmEQO34G4FaisLsDNClnLCaWVe7WLpHzf9OiksaH/UtIM5R2c6Xi7h0nPJXqLoKU=
X-Received: by 2002:a05:6214:5b03:b0:6c7:c7ff:958e with SMTP id
 6a1803df08f44-6cde150789amr8335666d6.18.1729206722476; Thu, 17 Oct 2024
 16:12:02 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:02 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240901222734.462334-4-sjg@chromium.org>
References: <20240901222734.462334-4-sjg@chromium.org>
 <20240901222734.462334-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:12:02 -0700
X-Google-Sender-Auth: m0E7_6-kal3wSHmL6OFWnGUC7VQ
Message-ID: <CAFLszTivbDM10hCKTvnhKdWXsd6Xc8uMkt8PHt2nw3a1jASgnQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] bootstd: Avoid depending on BLK
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Applied to u-boot-dm, thanks!
