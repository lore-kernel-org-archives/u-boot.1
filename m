Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE0AC021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 15:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D1A801BE;
	Thu, 20 Feb 2025 16:43:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LS6EekSr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44BF806FE; Thu, 20 Feb 2025 16:43:09 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C848001F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 16:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab7483b9bf7so175489166b.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 07:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740066187; x=1740670987; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hngrMSHVlHqSp4G5sSssCS4n/FP5XN89eZ34PkIqz3U=;
 b=LS6EekSr8aWCqOltR++trEsZag32zcm7gfSadQaxlnmnSeduEB5laB4A97OOgBwk86
 aoIVMmQV/P3itOi50Uz+iRNP+WqFdh/Wlyo5L/XUkqfbH8QcY3Ey+8Gq4sYswS9ET5wx
 xVPR8DZ+cKXinyU9y35cMCS5eLyXERFA4K0KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740066187; x=1740670987;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hngrMSHVlHqSp4G5sSssCS4n/FP5XN89eZ34PkIqz3U=;
 b=kJGd5bEP4+W2iMOdRUoFI1I+cThcsBy3Bo9r0IeVu0sUCnnhpZ+9eppGZ3QmLMmAkf
 3IA2SK1Cw6NfUMEwYZZxvak6uEytSriMFbaE8W1ldFbf2dh2ioaZvAIMJ++XjCSgofAd
 24X4Q4PZDPGdPcjjDbFW0/L6I+VvwWal6CgoqIesl+sT1yuTK6btIMStych7zA/FPxOR
 mEuH5OKdHqXgcLmm1b0EHiv2XxLoNjuhu7T/PcT0xMDoXGrphVyCiDQdQowmRY+9ZIRm
 EFC59n6ajduk46cWRsCfj9byG6aNDe9qbl1nRPveJlhg1LNhPOFB0mbgvhN6zAY8So3v
 NgYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl3PN8fgKy+roIgGlQpDzoVb0Eg+KG/BzWKUZQklJlItRFAtCJuJBENznoinUvrBmh2D0l5kE=@lists.denx.de
X-Gm-Message-State: AOJu0Yyfb0zXjwyWU5gb723owU+HAM+dJ+lQ+6k5n+7+6M9XfKXfHbTM
 v3t3PvJVeW8+ezetl9+aUi9k30zY6HVH/sGPBvDfRj+kt9QiBXZ3cMadXX4HCwH3RWO+4xlImaI
 BJZg18f5Kel2A+5gYMmr+T9WlozvZTYFDIdFG
X-Gm-Gg: ASbGnctewSBTxoYQTPsjmM50TEVtBj8hlEUKUKToEoehlVtjshXnK7stp9mfyBB6s/r
 9LYeFXTFpz9Ff/5ilJH6cHMAb0evf9FBfGJHb7o3XMeuUON+WOC3xjPME1+6OB8aCaK6YEZg2kg
 ==
X-Google-Smtp-Source: AGHT+IE4Tez4yvtcOq1US10vOd+t9bvB972u4/IbHqoKMKZVmnTVUoiLqSk4HhZGsEy7MW9ChkiQc+/QLAiM/KMSi5M=
X-Received: by 2002:a17:907:60d6:b0:ab7:f0fa:1340 with SMTP id
 a640c23a62f3a-abbcd0b2d3dmr944761566b.50.1740066186739; Thu, 20 Feb 2025
 07:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
 <CAFLszTic+bPv-JjsZ4JVz1RXQ247rmjPbGYzQhi5Z8=PC1728w@mail.gmail.com>
 <CAFLszTgunKAxdNwd9sO5=0bH1zrJkhMLackQ1gOfQqyApm91Jw@mail.gmail.com>
 <0c83fc06-6f7b-45b5-b8eb-2373222f8de4@cherry.de>
 <CAFLszTh73-QZMEReKVCEDgVsBeG1=ofmATBsO3X+r2C7iN8s1A@mail.gmail.com>
 <91a9b871-62b9-4774-843a-b92164e451f4@cherry.de>
In-Reply-To: <91a9b871-62b9-4774-843a-b92164e451f4@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Feb 2025 08:42:54 -0700
X-Gm-Features: AWEUYZm9_LEDH5L485XLFDk7dirwe1aH0ok54_hoCzh0PqBhbNucEKJqp0lqMvY
Message-ID: <CAFLszThrSwm6jggO-3ugYEpisBWB6VpEbsnpOJkufsZbPnBFAg@mail.gmail.com>
Subject: Re: [PATCH 0/3] rockchip: remove u-boot.rom generation and use
 binaries from simple-bin in simple-bin-image
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
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

On Thu, 20 Feb 2025 at 08:34, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 2/17/25 4:37 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Mon, 17 Feb 2025 at 08:37, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 2/15/25 2:17 PM, Simon Glass wrote:
> >>> Hi Quentin,
> >>>
> >>> On Thu, 13 Feb 2025 at 06:54, Simon Glass <sjg@chromium.org> wrote:
> >>>>
> >>>> Hi Quentin,
> >>>>
> >>>> On Tue, 11 Feb 2025 at 03:29, Quentin Schulz <foss+uboot@0leil.net> wrote:
> >>>>>
> >>>>> This gets rid of u-boot.rom generation as that was used only on Rockchip
> >>>>> Chromebooks and their maintainer (Simon) seems to agree[1] that
> >>>>> u-boot-rockchip-spi.bin should do the job now so we don't need to
> >>>>> generate it anymore. This was agreed for RK3399 Chromebooks, I'm
> >>>>> attempting to do the same for RK3288 Chromebooks as well so we don't
> >>>>> have anything requiring that u-boot.rom anymore.
> >>>>>
> >>>>> Since HAS_ROM is only guarding this u-boot.rom generation, they are
> >>>>> removed too from the individual configs.
> >>>>>
> >>>>> Finally, this also fixes an issue reported by Naoki[2] where binman
> >>>>> would try to find symbols from proper to install in xPL binary only for
> >>>>> it to not find it as we do not generate (on Aarch64) the proper binary
> >>>>> in simple-bin-spi image node, only in simple-bin, so it cannot have
> >>>>> access to the symbol. As to why this triggered only when some seemingly
> >>>>> unrelated symbols are enabled, I do not know.
> >>>>>
> >>>>> The first two commits are cleanups. If they are controversial, they can
> >>>>> be dropped and I'll apply the same fixes for rockchip-u-boot.dtsi to
> >>>>> {rk3288,rk3399}-u-boot.dtsi binman nodes.
> >>>>>
> >>>>> Note that none of the patches were tested outside of a simple build
> >>>>> test.
> >>>>
> >>>> Are you able to run them through my lab?
> >>>>
> >>>>>
> >>>>> [1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com
> >>>>> [2] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
> >>>>>
> >>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>>>> ---
> >>>>> Quentin Schulz (3):
> >>>>>         rockchip: rk3399: do not generate u-boot.rom anymore
> >>>>>         rockchip: rk3288: do not generate u-boot.rom anymore
> >>>>>         rockchip: avoid rebuilding most binaries for u-boot-rockchip-spi.bin
> >>>>>
> >>>>>    arch/arm/dts/rk3288-u-boot.dtsi       | 24 ------------------------
> >>>>>    arch/arm/dts/rk3399-u-boot.dtsi       | 35 -----------------------------------
> >>>>>    arch/arm/dts/rockchip-u-boot.dtsi     | 10 ++++++++++
> >>>>>    arch/arm/mach-rockchip/rk3288/Kconfig |  5 -----
> >>>>>    arch/arm/mach-rockchip/rk3399/Kconfig |  2 --
> >>>>>    5 files changed, 10 insertions(+), 66 deletions(-)
> >>>>> ---
> >>>>> base-commit: 636fcc96c3d7e2b00c843e6da78ed3e9e3bdf4de
> >>>>> change-id: 20250211-has_rom-u-boot-rockchip-spi-bin-df31b06ad2f3
> >>>>>
> >>>>> Best regards,
> >>>>> --
> >>>>> Quentin Schulz <quentin.schulz@cherry.de>
> >>>>>
> >>>>
> >>>
> >>> I'm not sure if you have tried this yet.
> >>>
> >>
> >> No I haven't.
> >>
> >>> This series produces a SPI file but the size is not the right size
> >>> (4MB). How could we solve that?
> >>>
> >>
> >> Which board(s) do you have an issue with? What is supposed to be the
> >> right size?
> >
> > kevin and bob, both 4MB - see CONFIG_ROM_SIZE
> >
>
> CONFIG_ROM_SIZE is x86-specific and is empty for me.

OK

>
> Why does it need to be 4MiB? Should we really care if it's less (it's
> currently 2.1MiB)?
>
> Also, I believe it should be 8MiB? c.f. /binman/rom/size property in
> arch/arm/dts/rk3399-gru-u-boot.dtsi (which I forgot to remove).

OK

>
> So I guess the answer to "how could we solve that" is to add
> /binman/simple-bin-spi/size property to all Chromebooks, so in
> arch/arm/dts/rk3399-gru-u-boot.dtsi and
> arch/arm/dts/rk3288-veyron-u-boot.dtsi).

Yes, that should work.

Regards,
Simon
