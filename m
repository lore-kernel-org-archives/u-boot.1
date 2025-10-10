Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005B2CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59E3383FE6;
	Fri, 10 Oct 2025 13:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="noM0K+Mb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A7483FC1; Fri, 10 Oct 2025 13:14:29 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C7B84057
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-78af9ebe337so1515982b3a.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760094865; x=1760699665; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bUmkErVuPJxP6lUzviLUoigyb5ab6Zu0MwiAfrbyP9A=;
 b=noM0K+MbASFlQZqehPqJHolZLrnidRtxi1yML/bVZF+fanthkwHxRQmkaILD2JrAx2
 +km2j1KYYj0L4O6Li545UncLhm2+KuwzcVut3Qyy1oFivH/jYQ5BMjtBT7XnZqmUw85/
 x3NXR0gNho0RVw6zD0VlPkErNPcwlbL/i9Dpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760094865; x=1760699665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bUmkErVuPJxP6lUzviLUoigyb5ab6Zu0MwiAfrbyP9A=;
 b=kSfSgHKivdT8H5M7x0vKO5DrKs/iv89oU8UOgU8+jtJXDrRLZ40idPbNDJXA/AKwwQ
 FgI6j3uAFNSjoD5JyiRkJNFOO5y6EF2zSlxUFiN5xBZCEIX1sa3Y0muAHaxY6NQhCMEq
 Wc93sUkJorZiYZbuCbvZud8gLsP5tlbJTwLNtfwws3CO6b2b8pKd0ozH9f8M9ScEa8Zj
 Rb5FlPPTjsCXoSzpcrMRakn3PkLVXor8duSOvHetB9wjwCSTJDuD70hSfxEQWAfsDl6Q
 LWv3gvcFhfPJKgDHrgqGcIIoxAA6EjiUpAU9JqjLAwxzvm6EN2xt2GkKAzi6JlHzFfCE
 0oNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHam3QE8shJF9DFZzvhnfXcgOza67eklWZ+mo7cRlp4eGquuJfdgDJ+wD9eF+dU5uVyu3BSfk=@lists.denx.de
X-Gm-Message-State: AOJu0YwIyMnSaonOHnXOsx4Vk0GC3Dk7Nt1iTqSfwbk4v57RwniQl6fU
 EiajH26E39yomUE1+nC+rp+vgxEY4hdBc2GgqGfDl3h42g8Ef/QmPHMgZNOjJynYYhzzeGBAamp
 2HPq9CJej/qbKCMXpaRdiKiBR2b9Zv9HH9fE/SiZ5
X-Gm-Gg: ASbGncsgvDjcI/7ibUxvssSw2WHbgYUjLWJza6e89/42ykXBTbqUGS9KXUhwaLVCWBD
 DRz0XVrptSgNKZaXLPLwoV4WVe01AIq5T7+AEaBhLzJPWT8GU58edtsrIloAp6Qou25V2K0DMG8
 7EaS7NE783I5psivPMWyIDKSPtYJcbFJLH++OJUJFg7aGPa+0RvZIg5SWYyBppi+xeM8+DaQtKw
 /HnxmbcDEGOD9Wfg1lNjNqys7QSA5LUjDSQgL5PPok=
X-Google-Smtp-Source: AGHT+IH82c0CSaCKhctDdq+7Xk8WXdwBEaqvuOroVxr6BzNCCWeAlcGrwjP1sVRQQd64wFHFMYws1Wrp0zR2VEQwtUM=
X-Received: by 2002:a05:6a20:6a09:b0:2e0:6215:82bb with SMTP id
 adf61e73a8af0-32da839f33dmr13363983637.37.1760094865122; Fri, 10 Oct 2025
 04:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-14-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-14-e09b39e54de5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 12:13:24 +0100
X-Gm-Features: AS18NWCaf1oNpmylWE3sUh-lmZh2kT6MHDb1fFi6kwycqdeUXj0Vrm0hfqIvEqc
Message-ID: <CAFLszTibp1WrVB7PVjpTLd0eeKrP9khDvozf2ukauKaeCSG-pQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] boot: Remove legacy extension board support
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

On Thu, 9 Oct 2025 at 15:51, Kory Maincent (TI.com)
<kory.maincent@bootlin.com> wrote:
>
> Remove the legacy extension board implementation now that all boards
> have been converted to use the new UCLASS-based framework. This
> eliminates 223 lines of legacy code while preserving functionality
> through the modern driver model approach.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>
> Changes in v2:
> - Remove a missing DM_EXTENSION_SCAN in cmd/Kconfig
> ---
>  MAINTAINERS                        |  1 -
>  arch/Kconfig                       |  2 +-
>  arch/arm/mach-imx/imx8m/Kconfig    |  4 +-
>  arch/arm/mach-omap2/am33xx/Kconfig |  2 +-
>  arch/arm/mach-omap2/omap5/Kconfig  |  2 +-
>  arch/arm/mach-sunxi/Kconfig        |  2 +-
>  board/ti/common/Makefile           |  2 +-
>  boot/Kconfig                       |  3 --
>  boot/Makefile                      |  3 +-
>  boot/extension-uclass.c            | 18 +++----
>  boot/extension.c                   | 97 --------------------------------------
>  cmd/Kconfig                        |  2 +-
>  cmd/extension_board.c              | 74 ++++-------------------------
>  include/extension_board.h          | 55 ++++++---------------
>  14 files changed, 40 insertions(+), 227 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

This is a really nice way of doing it, doing the conversion and then
removing at the end.
