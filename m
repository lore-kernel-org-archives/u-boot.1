Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CB8C021A1
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 15:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFDEB80885;
	Sun,  9 Feb 2025 16:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B5NS255Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3588808E6; Sun,  9 Feb 2025 16:44:13 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAD7D80821
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 16:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5de6e26d4e4so1160337a12.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 07:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739115851; x=1739720651; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tKdiR9Rd/S4weEqND37MjjEzEgwWFqct2x9mijRI8H4=;
 b=B5NS255Y97TZgqxSCkgpfbJ+yZmoDy2143Ghy/np7rKeESvE/nb3xmMrnaYbvVuFdv
 Z/1KO06/CT6h80vtCR7YswUzFsocsOWOp6FvHnCHdEnztrFlzgiXs1axh7iFdI2SwWT4
 Z5xoc4tDfxXIl150riZ6aVgUn24dg31fYufkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739115851; x=1739720651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tKdiR9Rd/S4weEqND37MjjEzEgwWFqct2x9mijRI8H4=;
 b=wj8/HxTym69fQ1N9MN53/3ei9FWCn5EB/tDl+oJy6w1dtg1JsPPr9RdMo8TC2qPnw9
 ubaPWpJrdbhvRxM7czKcyHwf2MhSynRU+65B7C6fsS2xFQvl7FLH3mcEJxssyqopMzkv
 N4vO1/rYH7hp0YVskZ/8PwuNJJiNsqlpkycFcPDM0UgGoKSRfnj6qDfeCA5WgGzogMbr
 rP789MzefNCccNzlYz12mmKhP33BQBAAjSlqY1InvEkV0z1eIlLdAN5oOHvOtaeHEfRU
 3aJ0aiPrg1Lnr5iFD4N4VOEc9QF6TDUpqx/fqhyOGlC1QAsea2/5sU/qSkUQHhL4pkVG
 S/bA==
X-Gm-Message-State: AOJu0Yxliur5WSeBzZ6iUiAOfBXH1Uy5V/PeL9LJzi3sftYgZIZQx53T
 DnpPoVGqumooz86sE67InlivWB0GkSfO2iuN+usN3Qbt0o2gLJyRd1i6X2pd6RCSD06wNso3hQ2
 Y3kY5t5CaPWf0yO4Fq3FnndEsVaC4o1TvWFV7
X-Gm-Gg: ASbGncvrYvKNOkJi3SKlRBJiMX3wPhF1KaE8ahMsw3yfGw2JvLP4h0T08eKPBqYcM0b
 Kk3lwE9fmGykADDNgg6W/LVM6GvcyJDQY9u78Qx4D826nv9EheeQzzn55cSGPABMqbiWdWqwjVw
 ==
X-Google-Smtp-Source: AGHT+IFqdvA+YJwTpc+J6GK4tKrr+05qwEkUngVdYW4eWKzD/VYtiTiulZfmAVIoVoBQbob5IL6oJrewq4GPwl75z+s=
X-Received: by 2002:a05:6402:2546:b0:5d9:f21a:aa26 with SMTP id
 4fb4d7f45d1cf-5de450a9e4cmr10561526a12.24.1739115851234; Sun, 09 Feb 2025
 07:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-22-sjg@chromium.org>
 <440fa821-6eb7-4b5f-a513-97c96145abdd@kwiboo.se>
 <CAFLszTi0p-U6ttMbqGPfFhs1PgZag3PMW0rUQOahymS=DpGzPA@mail.gmail.com>
 <00a94d2f-a611-4fe3-8ed2-d056feb7a1f7@kwiboo.se>
In-Reply-To: <00a94d2f-a611-4fe3-8ed2-d056feb7a1f7@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 08:43:59 -0700
X-Gm-Features: AWEUYZmMLyGpSIAVjVyI6aw9yn3P9eiIUoJoDrc_iuQru5mHp4PxOlGcHiaW4So
Message-ID: <CAFLszTjfwMOsL92W5DoL0WENcywJY-YaCU-BTxyWapawywyD7A@mail.gmail.com>
Subject: Re: [PATCH 21/29] rockchip: Provide a VPL phase on rk3399
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Chen-Yu Tsai <wens@csie.org>, 
 Christopher Obbard <chris.obbard@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, 
 Greg Malysa <greg.malysa@timesys.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
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

Hi Jonas,

On Sun, 9 Feb 2025 at 08:39, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-09 15:27, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Wed, 5 Feb 2025 at 09:06, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 2025-02-05 02:55, Simon Glass wrote:
> >>> Add support for this new phase, which runs after TPL. It determines the
> >>> state of the machine, then selects which SPL image to use. SDRAM init is
> >>> then done in SPL, so that it is updatable.
> >>
> >> I am still unsure how this makes it more updatable, what happen when
> >> DRAM init fails and board freezes? Are we relying on e.g. a watchdog to
> >> properly reset a frozen board and try next image?
> >
> > Yes, that's right. Also, when you do an upgrade you are not changing
> > the only copy, thus avoiding bricking devices with a bad or partial
> > update.
>
> Yes, it is unfortunate that the older Rockchip SoCs BootROM does not do
> hash/checksum validation, thankfully the newer SoCs does, so for newer
> SoCs it is more likely that bad code brick your device instead of a bad
> or partial update.
>
> Also, Rockchips "Flash Open Source Solution Developer Guide" even
> recommend to write multiple idblock headers to flash storage, this may
> be something that we should consider. Typically, Rockchip BootROM will
> check 5 positions in MMC for a valid idblock.
>
> Is there some code that configures a watchdog or similar that can help
> unfreeze due to a bad code update using this?

Not yet, but it would be nice to have.

[..]

Regards,
Simon
