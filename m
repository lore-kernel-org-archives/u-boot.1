Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F86C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 18:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 537E681E18;
	Mon, 16 Jun 2025 20:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jINjOE0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6493C82A0A; Mon, 16 Jun 2025 20:44:06 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AEAD81760
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 20:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-70e78e04e48so38611097b3.1
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750099443; x=1750704243; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DnVgjcgRu8mJCWYyGTBfVTGjBWIlvFe3LYt2gbZqjrw=;
 b=jINjOE0ldMjsMcT/appiuqQXkMzxskQkfkhhDA3jm96ZJ04KPbrHu8B1Zx57qupZl1
 1uo5cGzzKKjPNlO7ZB2DjS6Tap/doseVYGzaERNM6G0gqySh4emLF4DGHVp1LaU7ybDm
 gRJHeamwGNjUv99xPWF7Y2h4KjFykO7nxHLVA09FPHGugwQBj6fGNlahPNvMLUL8xoBm
 9MKOepvBj+4Eqdt5QqEXro8IEyieftHPMZX81VUSgtgLt6z4xLk+oYffyoQvs6rm1fuG
 7nsrfMRh6NAU3A+sH4kXwUYGAxomIPL3qXHQ/gV7VDCmXTTA+/WdRf40rFpPPNGELtqQ
 UHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750099443; x=1750704243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnVgjcgRu8mJCWYyGTBfVTGjBWIlvFe3LYt2gbZqjrw=;
 b=WwYgz7+DAYdEXO5lhkm8OzzE4ge7R3iSxelwGjSTVTZswZJGkgGTKgrFr0WSgkxrf/
 aVEonpjgJZ05ETbddL7f/FQdvffhS2IICMXZQc4NyQfoo+lTAylg9/uIhFwKvU2fShp4
 gtMrpB1e1HQJRr83LfxkQfl6Lpicme74QkU/4OqN9C2T9YGpiFU3no5bcoDMRz3Q3+ei
 YgcQi2uRymbzZDMiX7PAl6aWEmyGOKg9wIiAbQyy9O2hgWdItHjcO0Sdn5Y+WqMWg4C1
 aaT53bz/Dq/0RsGgqVqBl1VHbyt5EKh/5I0KTlHNT4S0wLXoJRoOg41c5x9mp/tB7pwj
 XDhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2OOnoMQG9cJkNBu3mAvC/1Gdo8InWCtqhqm8cH/d4/XBWAW4Dlx8SdjMoby1SG3MdFmzvN/g=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3eIXh+I6yanjabgkCQqilkaqWIV1fc3Fbbz++fiiCF51pAAqL
 ktee2vsnIvfRnyM0B4rkb1hczYEoajJAU7F5zUBfbWRaPd2PXsEVji67AP6zneKK5GmslsacIpB
 jUY+qvgz0AGR+O040xcJsQ4c6zHdXIRuvWmrL/aar/w==
X-Gm-Gg: ASbGncvx+pzfsIzw2LAE/LhQA+7BTa6D2CM5RytZHrjfDU8zgU2UiQjtpDLXbvQlQDT
 0dHD6E8+xlNprqR43mV3FEWTY8L3N3Mugdyia+29OKSmukDlettKh5dvZK66arZXPv+LqZ4s9bj
 +2Phl6EgW0K07J0HvFmB3oK3/9rmTt61wFs21gTj65cB4e
X-Google-Smtp-Source: AGHT+IHL6Whs8B+waJrnb6Wh3WxYJuzyX2doej5cS4EMhYYn5viOfTw0UW768M/5sOZWNfxrCzuM9eC81D2PUgguJeU=
X-Received: by 2002:a05:690c:4:b0:70e:2168:7330 with SMTP id
 00721157ae682-71175431f62mr146068177b3.19.1750099442971; Mon, 16 Jun 2025
 11:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250616075035.1144220-1-ilias.apalodimas@linaro.org>
 <c7d2a64f-1415-4481-9c2c-072e0abb2698@linaro.org>
 <CAC_iWjJxE_XSbHAZcxf2bVssnyqesT5td3XxAAvs80-PSMQOjQ@mail.gmail.com>
 <20250616164243.GH1382132@bill-the-cat>
In-Reply-To: <20250616164243.GH1382132@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Jun 2025 21:43:26 +0300
X-Gm-Features: AX0GCFsMDs79wU9V4zY4yX0PNiWzin_4UJ-hPvqYe1PUo94oqD1zm4NRO3XU6Ug
Message-ID: <CAC_iWjJK6EAahzHk52dyS8GLgy+L4yAtLPG8W0_3ri6Knhze7Q@mail.gmail.com>
Subject: Re: [PATCH] arm: io.h: Fix io accessors for KVM
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, mikko.rapeli@linaro.org, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

On Mon, 16 Jun 2025 at 19:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jun 16, 2025 at 04:11:32PM +0300, Ilias Apalodimas wrote:
> > Hi Jerome,
> >
> > [...]
> >
> > >
> > > If I'm not mistaken, this patch is doing two things that are unrelated:
> > > (1) fix the KVM issue and
> > > (2) get rid of the __arch_*() macros in favor of the __raw_*() macros
> >
> > I can split it, but I don't see much point since we redefine the raw_macros.
>
> For point 2, I'm not sure it's worth splitting, no.
>
> > > IMO this should be two separate patches.
> > >
> > > >
> > > >  /*
> > > >   * The compiler seems to be incapable of optimising constants
> > > > diff --git a/drivers/spi/fsl_dspi.c b/drivers/spi/fsl_dspi.c
> > > > index f2393c041f44..545561ad1169 100644
> > > > --- a/drivers/spi/fsl_dspi.c
> > > > +++ b/drivers/spi/fsl_dspi.c
> > > > @@ -123,8 +123,10 @@ static uint dspi_read32(uint flags, uint *addr)
> > > >
> > > >  static void dspi_write32(uint flags, uint *addr, uint val)
> > > >  {
> > > > -     flags & DSPI_FLAG_REGMAP_ENDIAN_BIG ?
> > > > -             out_be32(addr, val) : out_le32(addr, val);
> > > > +     if (flags & DSPI_FLAG_REGMAP_ENDIAN_BIG)
> > > > +             out_be32(addr, val);
> > > > +     else
> > > > +             out_le32(addr, val);
> > > >  }
> > >
> > > Unrelated change
> >
> > Due to the the new do {} while(0) macro this doesn't compile, so it
> > needs to go together.
>
> It can be done first as what the driver does now is valid but
> clever-for-clever-sake, and cleaning this up is valid before the new
> macros.
>

Ok looking at it again, the platforms that need changing are v7 only.
Due to to issues mentioned in the commit message, I decided not to
change v7, so i can drop these completely now.

I'll send a v2 with the IO changes only.

Thanks
/Ilias
> --
> Tom
