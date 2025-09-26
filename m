Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A2CCAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 14:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FF42835B0;
	Fri, 26 Sep 2025 16:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="azriuL2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26C9E835B3; Fri, 26 Sep 2025 16:47:53 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD8378359F
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-62105d21297so4490873a12.0
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758898070; x=1759502870; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VxYACI1BfUQFgClU8J9Jrs1y7pqAvtRxf8XOAZulN6U=;
 b=azriuL2eLZo3t/PKyDGDDuL/+LT++CQKUFvsnHdmMQV2kIg74D0EfKEUvbhs5Dsl5c
 FncVo6vTfSAJ7E62u0FmZnSGaGh4nI+kY3K2XnnpeschzWqnBGvvTXJa0I8q+9b9FfGS
 qRuKF+9xZ7N1j6cHqzllnQYvW3rmj8sr9QuL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758898070; x=1759502870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VxYACI1BfUQFgClU8J9Jrs1y7pqAvtRxf8XOAZulN6U=;
 b=lknbPwg9cye6W/ArN4gMWycs4416MR/hu1OvwzPxhSp7L6hPDYxi0ueDcFVeugTGCy
 fbSn6H78ujamHTUtecSShhY3xcbSQF2t+4KWBryvJmPvp6Ws4luCvbyj35bOInZ/XBxo
 WoWQ1djpvnGsVFLR08+PMavQtzqs7idun0eocShqzzUqG8oo0cDXDmv1X1cIKi3yl96k
 0f+1OzMcOYpquQ10VHB014arEvjeVmHS5cGfqPY5QBdmEkdzqAIOPElFH/V0exuCeq8x
 eReADlas87ItTad6hBY2Vyw5gHzmtMpqAzklk9tzAbbf9LhvrCKoVXt51DMi4lzsq1YG
 lvbw==
X-Gm-Message-State: AOJu0Yxkn1jEt27ssSWWFxXEzOIN2kFUku4KRELdZ/nD14zYPs1xBybQ
 YRgILrqFzIcQXcezWFMrVo7ir7cWkGudZA9+2XuGc+Ili3Nflr28UI0yZdq5eGVOEjdK6cTywoE
 5Pakr0PPjIYzjOyNT3mdSXYfBL1KDyrbBOOg4+c0O
X-Gm-Gg: ASbGncsnd/JSSuqq3QIxiK0NQFrhUe4Yg7+xES7+392VsN1LzVxJCkAdOtSL/xlSUO1
 9NgrVQKgsgmw1z5VGIUZf2W6r4bYzVPThxBLSL50FORMlz02iJkpGfLL4kJWxiNCuPzZDpturT4
 clNG6eeQs0sEPCrfsEoanwlmfbyLpCpszsQmIi/DBJCMBoX9RB6g/8w4f5OUqSx/PdLXQsHm37S
 IfdVg==
X-Google-Smtp-Source: AGHT+IHi8AUt8wqQsedwiUnWFVyggkhFVIC7jhX8wzBmVkdSggfs/6OzPVJH3Jk+n0u5yBtqrYXrNoQUR+BHXNaZTGw=
X-Received: by 2002:a17:907:3f87:b0:b09:2331:f150 with SMTP id
 a640c23a62f3a-b34b84aba85mr928336866b.16.1758898069712; Fri, 26 Sep 2025
 07:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250925002308.2825164-1-sjg@u-boot.org>
 <20250925002308.2825164-3-sjg@u-boot.org>
 <20250925141849.GM197373@bill-the-cat>
In-Reply-To: <20250925141849.GM197373@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Sep 2025 08:47:37 -0600
X-Gm-Features: AS18NWCkgQTzUVeh1xGBABXcwH-e40IQfcd3LVk0U_ujOfAolIVZTEn0t9ReE-8
Message-ID: <CAFLszTg=0wvoum250GpWfwKeDDffO6_zZdGA2z8O6BE_sDCaaw@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] bootstd: select BLK rather than depending on it
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ezra Buehler <ezra.buehler@husqvarnagroup.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Stefan Roese <sr@denx.de>, Thomas Chou <thomas@wytron.com.tw>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

Hi Tom,

On Thu, 25 Sept 2025 at 08:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 24, 2025 at 06:23:01PM -0600, Simon Glass wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> >
> > With recent changes to how BLK works, we must use 'select' to enable the
> > BLK feature, which is currently required by BOOTSTD.
> >
> > This fixes the following error:
> >
> >     GEN     Makefile
> >   scripts/kconfig/conf  --syncconfig Kconfig
> >   boot/Kconfig:496:error: recursive dependency detected!
> >   boot/Kconfig:496:   symbol BOOTSTD_DEFAULTS depends on BOOTSTD
> >   boot/Kconfig:441:   symbol BOOTSTD default is visible depending on BLK
> >   drivers/block/Kconfig:1:    symbol BLK is selected by USB
> >   drivers/usb/Kconfig:1:      symbol USB is selected by BOOTSTD_DEFAULTS
> >
> > Disable BOOTSTD for the boards which don't have enough space or some
> > other problem:
> >
> >   zynq_cse_nand
> >   zynq_cse_nor
> >   zynq_cse_qspi
> >   gardena-smart-gateway-mt7688
> >   10m50
> >   3c120
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> This is the wrong direction. Please instead get the dependencies correct
> in the next patch. You're likely missing some conditionals on the
> selects you add as bootstd does not depend on BLK.

OK, I found that I shouldn't need the 'select USB' so I dropped that.
So I can send v8.

Also I spoke to Heinrich and we came up with the idea of supporting
bootdev priority in global boomeths, as a less hacky way of ensuring
the bootmgr doesn't slow down the boot when it isn't being used. That
would be a separate series but I can take a look at that.

- Simon
