Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FAAC021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 15:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8AEB8083C;
	Mon, 17 Feb 2025 16:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gf1uRoh0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C3DE809A4; Mon, 17 Feb 2025 16:38:11 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05E8C807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 16:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aba868c6e88so458400366b.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 07:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739806688; x=1740411488; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GFijI5GWp5NRaJ8EMPoWfvnWswOu6qg91sl1d26OAno=;
 b=Gf1uRoh09GFLJxZ1gjYEa89EKHkUSRqRVjDyEI3koG6egSchKXFHafgpCUl8MXbhG4
 lIaULJGuEFZ5r54Mt/rzD846VEbCNv4rvnfVbhpafT2biZJ5MmbCNlicLiQaHqEx7EqQ
 fFl4mnIWxZX3XW9rsD6JIY8V/bYY+fQo3HgO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739806688; x=1740411488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GFijI5GWp5NRaJ8EMPoWfvnWswOu6qg91sl1d26OAno=;
 b=xLdfHodsZpU1WBzuKzE0P28ddNOLdiSgqnyK9MsC1aBn+XEJVfY5+Gm9LsrLaWmv/X
 1mmIfs2D++nI3f8C/5DQvesLj75RP37ZZmXASa1a/zZZShXcswzGd8dGiLR5kWKh6Uwx
 DQf3jKWoM13jMH96lO1kk/GuZkmROdLvY8zBHmmHptwk85oxm6ES+LvdWca4iGGWnoPa
 PiG/7UJijOSB9Roi4lEf4/Bp643psyRRJWpOtBLgW23io2EZ8XtKwOwh7GH4mGsGHT2W
 l9fi6cg//AjpnnWUNmFwhH1X0wUkDcqi/HQFxOqiiGV0UQVVbXV4YbvA/ZtZMWriaJ9x
 0RFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV24pfEl67WjLDfKbjUKS3o2/JK4oTaaVCI23NH5HtV1iHGVKEB5OXGFMl27rjVkXY8y3yNHjE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxz8u+2bNa7HNLNseWhnQmtVmP7A2x1O1BkBnCGdq3czpYTQJP3
 84h4QkoP9+PkIXBOKmtpgqikZ8bx6ZCuYgN66NbxvV0JQYr3+/tZ/qeOIip0VZHHJ5HMmsaFgO8
 G95ykhRzGBRehg7eYGKYVJyh73LAsKXhbf1nFOKJfNbOX6ZI=
X-Gm-Gg: ASbGncu/jqRlJhZcZGa7zevO6X5+gfw5c5iMrhVHPUrFXqaOzRWdl2nVap30KftTNqG
 RKWkfwZmzjBdx6eSD/+nd2hvW/QPcPH4pKdgVPVl/F53iMcsWUH2/PcZY9fKomOCb4cX0ZfaKeg
 ==
X-Google-Smtp-Source: AGHT+IGxmtSI7GBMYZaC17BI/IH+Y+OnkGVffrEjVQcYjojqafc/s3fmpcAKshaqOJTt1uqvxLl5Zw+boLazGRoc1Pg=
X-Received: by 2002:a17:907:7f16:b0:ab7:5fcd:d4de with SMTP id
 a640c23a62f3a-abb70e5ca5dmr1025202766b.50.1739806688428; Mon, 17 Feb 2025
 07:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
 <CAFLszTic+bPv-JjsZ4JVz1RXQ247rmjPbGYzQhi5Z8=PC1728w@mail.gmail.com>
 <CAFLszTgunKAxdNwd9sO5=0bH1zrJkhMLackQ1gOfQqyApm91Jw@mail.gmail.com>
 <0c83fc06-6f7b-45b5-b8eb-2373222f8de4@cherry.de>
In-Reply-To: <0c83fc06-6f7b-45b5-b8eb-2373222f8de4@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Feb 2025 08:37:54 -0700
X-Gm-Features: AWEUYZl62muSDMqcX6fZHfxVMl7DVasHK0x3Leziyh9pPcAWtHqA90GCEAaKq-k
Message-ID: <CAFLszTh73-QZMEReKVCEDgVsBeG1=ofmATBsO3X+r2C7iN8s1A@mail.gmail.com>
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

On Mon, 17 Feb 2025 at 08:37, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 2/15/25 2:17 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Thu, 13 Feb 2025 at 06:54, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Quentin,
> >>
> >> On Tue, 11 Feb 2025 at 03:29, Quentin Schulz <foss+uboot@0leil.net> wrote:
> >>>
> >>> This gets rid of u-boot.rom generation as that was used only on Rockchip
> >>> Chromebooks and their maintainer (Simon) seems to agree[1] that
> >>> u-boot-rockchip-spi.bin should do the job now so we don't need to
> >>> generate it anymore. This was agreed for RK3399 Chromebooks, I'm
> >>> attempting to do the same for RK3288 Chromebooks as well so we don't
> >>> have anything requiring that u-boot.rom anymore.
> >>>
> >>> Since HAS_ROM is only guarding this u-boot.rom generation, they are
> >>> removed too from the individual configs.
> >>>
> >>> Finally, this also fixes an issue reported by Naoki[2] where binman
> >>> would try to find symbols from proper to install in xPL binary only for
> >>> it to not find it as we do not generate (on Aarch64) the proper binary
> >>> in simple-bin-spi image node, only in simple-bin, so it cannot have
> >>> access to the symbol. As to why this triggered only when some seemingly
> >>> unrelated symbols are enabled, I do not know.
> >>>
> >>> The first two commits are cleanups. If they are controversial, they can
> >>> be dropped and I'll apply the same fixes for rockchip-u-boot.dtsi to
> >>> {rk3288,rk3399}-u-boot.dtsi binman nodes.
> >>>
> >>> Note that none of the patches were tested outside of a simple build
> >>> test.
> >>
> >> Are you able to run them through my lab?
> >>
> >>>
> >>> [1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com
> >>> [2] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
> >>>
> >>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>> ---
> >>> Quentin Schulz (3):
> >>>        rockchip: rk3399: do not generate u-boot.rom anymore
> >>>        rockchip: rk3288: do not generate u-boot.rom anymore
> >>>        rockchip: avoid rebuilding most binaries for u-boot-rockchip-spi.bin
> >>>
> >>>   arch/arm/dts/rk3288-u-boot.dtsi       | 24 ------------------------
> >>>   arch/arm/dts/rk3399-u-boot.dtsi       | 35 -----------------------------------
> >>>   arch/arm/dts/rockchip-u-boot.dtsi     | 10 ++++++++++
> >>>   arch/arm/mach-rockchip/rk3288/Kconfig |  5 -----
> >>>   arch/arm/mach-rockchip/rk3399/Kconfig |  2 --
> >>>   5 files changed, 10 insertions(+), 66 deletions(-)
> >>> ---
> >>> base-commit: 636fcc96c3d7e2b00c843e6da78ed3e9e3bdf4de
> >>> change-id: 20250211-has_rom-u-boot-rockchip-spi-bin-df31b06ad2f3
> >>>
> >>> Best regards,
> >>> --
> >>> Quentin Schulz <quentin.schulz@cherry.de>
> >>>
> >>
> >
> > I'm not sure if you have tried this yet.
> >
>
> No I haven't.
>
> > This series produces a SPI file but the size is not the right size
> > (4MB). How could we solve that?
> >
>
> Which board(s) do you have an issue with? What is supposed to be the
> right size?

kevin and bob, both 4MB - see CONFIG_ROM_SIZE

Regards,
Simon
