Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04766C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 14:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8585280944;
	Sun,  9 Feb 2025 15:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HQbFYRuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C9780885; Sun,  9 Feb 2025 15:28:13 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CC5E80141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21f44e7eae4so51765395ad.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739111289; x=1739716089; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IF22Dm7DJwthnTClJ0tC4GIaTF/QOriijpeSX9qQkmI=;
 b=HQbFYRuUbTR1noRfT5CXSa1yrJg8mpZR0L4PtOHzm5nMc1ZBBvD2kzMNnR5UX4kiM2
 tSQSSGj2AYhwhJAkvkHOTHLTVCyDWtklUguznlgcrPq8ITCzg9fyUvHAfaffpdCKDuc8
 Le9SPlZhNxN0hK4eP9Wj/gd9zpEJw+0t0byzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111289; x=1739716089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IF22Dm7DJwthnTClJ0tC4GIaTF/QOriijpeSX9qQkmI=;
 b=FTGhcm8TtJkFKwsb4q/bwvQ10upZBMxmOCIWcIOhSroWO9kiuAVgT+9LHP7urWj37H
 GrgGPVoYpXwy94UYDtnCbpIsqBtj/h0LSXgwiNHF8obHjUbxBDypdcQ++DiUaPEtXxGG
 7jW0J0igEjJRdK88N4xBVRQuheRCskhZpcLwSwxKuJB00qc8mkZfXEqGEZ7sAOr8RO9U
 76g0t7W0rnJ9umLGxa7kaKFQ9nYvaSB6jJhvyt76uymv0ai0VCj9FTxjlhzpUzH5UD0H
 /TPhVlhytF4hyH6nuc95SANC0W5duY/ih/KtZyq64wdkvwnRwUmLsnu4s/Gr45iRoLbL
 6ddw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsIRb49IiyIxD7DZzQfDDRR4i0nqdp1dNtSMO7ZcWuG4uFpQKxLqHeVkCKg3bVbNdjkk28yI8=@lists.denx.de
X-Gm-Message-State: AOJu0YzZ7ir9TyDigsAX4nmmsgMH2/y9Lw8NwQR2cY9k7spcNAoH/jba
 /EE9W9ELMZ3qsYOMw++73ouXZ/IM4/CRBCGjbT956FCpZZEcWMEKLtLhmF+TK4uOkpT5Qcy0iCx
 wrhY4oQUOmgqWg8XN0rpQno8P8sEcukVEr7+x
X-Gm-Gg: ASbGncvLFG4r1OuF82eZmyN5kkQL9dljPLrM+Es3ev/1LX0Hl7qfDtPLAnnKoJNeZaA
 PDfE+0X/iK358JUq6DKJCeEaak+kNxMtAFWOMzW7E4Oce8x3s+zbraCs6yZZvJ8XIhwIHxJRknw
 ==
X-Google-Smtp-Source: AGHT+IF7sn+yk3f8+eIOPL+StCdcxdZDgY07v71EFTbUUxJfnpFQGfcMc3tN8iiJnc0ltZNhf8N3ZGxgyYtn3Nl1q5Q=
X-Received: by 2002:a17:903:2345:b0:216:6fb5:fd83 with SMTP id
 d9443c01a7336-21f4e716972mr138685355ad.29.1739111289599; Sun, 09 Feb 2025
 06:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20250129132529.807031-1-naoki@radxa.com>
 <20250129132529.807031-3-naoki@radxa.com>
 <2d237669-cab8-418c-ad47-0cf936d76a86@cherry.de>
 <CAFLszTi7EuM36eSrKehuH_fOkbkE0ZX79jkpZAAn7PonS1EgNQ@mail.gmail.com>
 <7178d2ce-9c13-4ab7-9c56-aff84b65461a@cherry.de>
In-Reply-To: <7178d2ce-9c13-4ab7-9c56-aff84b65461a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:27:51 -0700
X-Gm-Features: AWEUYZmNyJK_KwvVR96xkSNHOPMX359aIbdjqLPhRaqzYFymSKr1WAleJjL-AWw
Message-ID: <CAFLszThsSbQL8ijj7TOdZFX21cZCa2AzKEb4bfUqe5FVOiN7qQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rockchip: Fix binman error
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com, trini@konsulko.com, jonas@kwiboo.se, 
 dsimic@manjaro.org, pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org, 
 ian.roberts@timesys.com, nathan.morrison@timesys.com, greg.malysa@timesys.com, 
 bb@ti.com
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

Hi Quentin,

On Thu, 6 Feb 2025 at 09:54, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 2/6/25 1:46 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Wed, 5 Feb 2025 at 06:00, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Naoki,
> >>
> >> On 1/29/25 2:25 PM, FUKAUMI Naoki wrote:
> >>> After adding the below configs, binman produces an error.
> >>>
> >>>    CONFIG_SPL_DFU
> >>>    CONFIG_SPL_ENV_SUPPORT
> >>>    CONFIG_SPL_USB_DWC3_GENERIC
> >>>    CONFIG_SPL_USB_GADGET
> >>>
> >>> binman: Section '/binman/simple-bin-spi': Symbol '_binman_u_boot_any_prop_size'
> >>>      in entry '/binman/simple-bin-spi/mkimage/u-boot-spl/u-boot-spl-nodtb': Entry 'u-boot-any' not found in list (u-boot-tpl-nodtb,u-boot-tpl-dtb,u-boot-tpl,u-boot-spl-nodtb,u-boot-spl-dtb,u-boot-spl,mkimage,fit,simple-bin-spi)
> >>>
> >>> Add "no-write-symbols;" to u-boot-tpl and u-boot-spl.
> >>>
> >>
> >> I'll be frank with you, I have no clue what's happening :)
> >
> > I means that simple-bin-spi has a binary inside it, u-boot-spl, which
> > uses binman_sym_declare(ulong, u_boot_any, size). Most likely it is
> > the one at the top of common/spl.c
> >
> > This symbol is filled in (by binman, at build-time) with the size of
> > the U-Boot binary. If there is no such U-Boot image then it cannot do
> > this.
> >
>
> Why is it not failing right now? Why does it fail when you enable
> CONFIG_SPL_DFU, CONFIG_SPL_ENV_SUPPORT, CONFIG_SPL_USB_DWC3_GENERIC,
> CONFIG_SPL_USB_GADGET for Rock-Pi-4?

I added these to the end of configs/rock-pi-4-rk3399_defconfig

CONFIG_SPL_DFU=y
CONFIG_SPL_ENV_SUPPORT=y
CONFIG_SPL_USB_DWC3_GENERIC=y
CONFIG_SPL_USB_GADGET=y
CONFIG_DM_USB=y

then build and don't see these errors. Can you please give a little
more detail so I can repeat this?

> This doesn't generate the
> u-boot.itb file we need for simple-bin-spi as we anyway take the fit
> blob generated by simple-bin instead.
>
> It would make sense to always fail if this relies on u-boot.itb to be
> built for simple-bin-spi as well?
>
> I suggested to use only blobs from simple-bin in simple-bin-spi but
> according to
> https://docs.u-boot.org/en/latest/develop/package/binman.html#image-dependencies
> this is undefined behavior. Maybe we should use a template
> (https://docs.u-boot.org/en/latest/develop/package/binman.html#templates)
> and rebuild everything for the SPI image as well. I saw such a patch in
> your VBE part H series I believe, maybe it makes sense to have this
> merged separately?

Yes I am adding a template in that series, but I would rather get that
submitted, since Binman does currently process images in series.

>
> This feels somewhat wrong though, if I'm not mistaken every binary used
> in simple-bin and simple-bin-spi is the same, to the exception of how
> the idbloader.img is generated (-T rkspi/rksd), so it doesn't make a lot
> of sense to me to go through a complete rebuild of all binaries, instead
> of just running mkimage a second time with the same set of binaries. But
> if that's the only way to have something with defined behavior AND
> working, then so be it.

For now at least I think it is best to keep the images independent,
with a template to reduce the duplication.

Regards.

Simon
