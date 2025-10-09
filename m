Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FDCCCD183
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 15:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F6784461;
	Thu,  9 Oct 2025 17:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="B4NlWYkc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 892C8844AE; Thu,  9 Oct 2025 17:20:04 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2C0C8421F
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 17:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-27d3540a43fso10843205ad.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 08:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1760023199; x=1760627999;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=osKdUEZAMNBNNVHA3ZhvtUtPJJCBLxytYrjkYlLr/mI=;
 b=B4NlWYkcM7dHQKuPMNKBWYJm0Rw0T15lg+BR/7f86yfBQmB0U5IG7wtERMyR95mJAu
 Jd9vyWsl10/8g/HfK9cmbDoCR2E42sZwQtYGMTeQiPuCmKqxxpY+d6DA2SR7EB1zc5id
 yiDpy/5czQKMOUg11brd9adz59uElAevE0eDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760023199; x=1760627999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=osKdUEZAMNBNNVHA3ZhvtUtPJJCBLxytYrjkYlLr/mI=;
 b=evug7hSAZiqP6IKKEPOFEij/4nWNDv2oZ9/7xZrzL45Ft0Wur4kdpV3uJf1WB1WcI7
 v/Mvb2QAz/Xwll/6KFbRrkB811AUtFU4iPO34iHpCjqXFBJj8z96kQnuzgZDCsdB/5Jq
 iiOZ8kTem+Y4IdivFabEFRP6G35w6jtF0QRf1kv8VG4/Z0+mG1xKMLSWONT0ekijkscf
 LX0fKr+O2NzjfPRJ6k0kwUum9XJ9TQl3TpkeRWcL9i36QHwfZm3s5fYoxDTQMOnqpZ2l
 zZp0ZmEk9Tw4sLufIHLWGJU3Fl5dAfxKKLHIpqCgCU0dnDxUhtz/CXbWexiwGvDt3V6K
 X5EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2yZHmSqvBgV8B58mLxjUJlqwXZMvgPIXY2KHxFTn4pOteFdges5z83mkNGynMkmYWzX7m1qw=@lists.denx.de
X-Gm-Message-State: AOJu0YxUL7h6onTp5AHIT9taEeAjovJ1k/LY09H3gsAHV0liU41Yg5hv
 69fcd3FoJ8RdHWbtUUFOndwyi5pedAJ1Hn8CA9aho+j3l+S1F4P35LZT/ibMh+922YxA/zB0OaF
 ywG6bJtiCDRXu7TZrHKFicxTmEyM8IPVJ6MjBHO7ynCivKDKIWpMsKf0=
X-Gm-Gg: ASbGncvJK4Y+QBQrD5k9HfZQ3N/YcOf2UxKHUoXZiyrwmeZIlw2uBfpat2zzk6FLp4W
 2/+VX7unmt5j3Q+nIyvAD9wJCOClBJpzSWuM3z62H4m+5HCTlKjcMhrTF53qRNA7ERfYnaIJ/K3
 kNI589KCz6wWEjEcier7L+WVXvGbzw9XYF0AgB4wnbpfRp/oWfxxycpFFD6TsxTay6KfPYHJglG
 ygAKy/sEZ0v2P70euwsEpDXXKq2P0UN5n/hg3J+G0WhArj+ubb4j8HbrcFo48w=
X-Google-Smtp-Source: AGHT+IGVhhv9ek0PrJhTzq+EuZf6YsMYsEIvAT4toy87BeDwo+3ZrhFcIJcoiDluORsd0cl5CACrIvQF1TUnSmkc2AU=
X-Received: by 2002:a17:903:1aa4:b0:27c:a35a:1321 with SMTP id
 d9443c01a7336-290272e6f79mr88364465ad.51.1760023198760; Thu, 09 Oct 2025
 08:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250926153136.3680867-1-trini@konsulko.com>
 <e4db9bab-9de2-4810-ab19-7654be60dae5@linaro.org>
 <20251009142601.GN298503@bill-the-cat>
 <0372ee71-0b8a-449f-983e-63ef024e5ac3@linaro.org>
 <20251009151117.GO298503@bill-the-cat>
In-Reply-To: <20251009151117.GO298503@bill-the-cat>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 9 Oct 2025 17:19:47 +0200
X-Gm-Features: AS18NWAVo6-dGdn7IRUtAnpahAE-b2sPExpO6Tl_QpHwU41rGTAhLBU7fxqGFz4
Message-ID: <CAOf5uw=xmKDbqbBog_ZzNmQSdNFtsfKx4SH8w=2aPzwGVu2bZQ@mail.gmail.com>
Subject: Re: [PATCH] nand: atmel: Rework ATMEL_EBI and DM_NAND_ATMEL
 interaction
To: Tom Rini <trini@konsulko.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi

I will add to my queue that I have now with patches, I have already
prepared a branch

Michael

On Thu, Oct 9, 2025 at 5:11=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 09, 2025 at 05:58:48PM +0300, Eugen Hristev wrote:
> >
> >
> > On 10/9/25 17:26, Tom Rini wrote:
> > > On Thu, Oct 09, 2025 at 12:48:29PM +0300, Eugen Hristev wrote:
> > >>
> > >>
> > >> On 9/26/25 18:31, Tom Rini wrote:
> > >>> The way that the NAND driver under DM_NAND_ATMEL is probed is by th=
e
> > >>> dummy memory driver controlled by ATMEL_EBI. Rather than require th=
at
> > >>> for NAND to work both be enabled, make NAND select ATMEL_EBI and do=
 not
> > >>> prompt for ATMEL_EBI as it only triggers the probe for NAND.
> > >>>
> > >>> Signed-off-by: Tom Rini <trini@konsulko.com>
> > >>> ---
> > >>> Cc: Eugen Hristev <eugen.hristev@linaro.org>
> > >>> Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > >>> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> > >>> ---
> > >>>  drivers/memory/Kconfig       | 2 +-
> > >>>  drivers/mtd/nand/raw/Kconfig | 1 +
> > >>>  2 files changed, 2 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> > >>> index eaee739c6aab..591d9d9c6569 100644
> > >>> --- a/drivers/memory/Kconfig
> > >>> +++ b/drivers/memory/Kconfig
> > >>> @@ -14,7 +14,7 @@ config MEMORY
> > >>>     For now this uclass has no methods yet.
> > >>>
> > >>>  config ATMEL_EBI
> > >>> - bool "Support for Atmel EBI"
> > >>> + bool
> > >>>   help
> > >>>     Driver for Atmel EBI controller. This is a dummy
> > >>>     driver. Doesn't provide an access to EBI controller. Select
> > >>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kc=
onfig
> > >>> index aa4bb2a0595c..f083113486ed 100644
> > >>> --- a/drivers/mtd/nand/raw/Kconfig
> > >>> +++ b/drivers/mtd/nand/raw/Kconfig
> > >>> @@ -50,6 +50,7 @@ config SYS_NAND_NO_SUBPAGE_WRITE
> > >>>  config DM_NAND_ATMEL
> > >>>   bool "Support Atmel NAND controller with DM support"
> > >>>   depends on ARCH_AT91
> > >>
> > >> Which branch is this patch based on ?
> > >> I have a conflict because this line ^^ is missing in master ("depend=
s on
> > >> ARCH_AT91")
> > >> Is there another patch for that ?
> > >
> > > Ugh, yes, sorry, this patch depends on:
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250711151604.22242=
43-1-trini@konsulko.com/
> > >
> >
> > Then maybe Dario can pick this up together with the dependency patch ?
>
> Works for me, Dario?
>
> --
> Tom



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
