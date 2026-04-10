Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0034F36BAA
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 05:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B90F83D8A;
	Fri, 10 Apr 2026 07:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UbFQF3ls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E9D084099; Fri, 10 Apr 2026 07:11:09 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57034839D9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 07:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-65075c2ba66so1941890d50.1
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 22:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775797866; cv=none;
 d=google.com; s=arc-20240605;
 b=JwY2JlW7zBS30i43v7DH+WcVI0O0Ik/UXYOVI/Hiu4h4HeXkO1JyqvfwbRGhT/gHFO
 ejUJqBUVrG3pMemaJ5pP72PmORXDz7Oe/ZwMwnm1XeG7FipjWvzjITlaxsOaUfntYB8+
 3K7oVCs1i8EHHmeAgrrs2Uxg9kLYzRMlI8V+i3bc/FWnCgQbn08ptkUaaB8TJ5bjA87t
 7L4pJJcaWiUvfdixFKAfTJniKLd+lMbk9AmH0svOa6tOICdZBaNGAwUF8X+fL1VK72xK
 2khYA4cSk4zbNzl+CyYegklkyvuChzztwkFYl1u04yD6AyG5/MIHRFlSC2q2TA/NvrxY
 AJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7uYdkWw4N+y9NR11JaamI9t8jL8n2AkRqo5qBYafHXM=;
 fh=CESvrhOEG7tuS/1/Cusj+Niuiu4UuX+AdXAGI7/IF4Q=;
 b=WRAA1p48lQr7HVkVBgKxrub/dCzurfOcs/vxi8Rb+j1ZlgsWkZzaVQP+A3PTct3nEV
 OWClV/UNgqPI2tlqIeiupJDwFRe/zw/TmmyGXBXF+kaRFkaTsJNeLzYydYw8wt2ivX1o
 NZwHzwGq37Tna3w9z1/OSNMMF4ukBVDe/OscC67/DjBEeX83JKN5PsGKZjzwFjtaOyeu
 tctcS9aiCFZkUELtfAoIghst6IvPiGPmlc3zCJpki12OIcGkH1XXVzEZveavcjrrFK9x
 ozTTe/P/vzsSrKirl+p0z/4RuR4bT+DvFAKH6QZxC2V6azwBvpLqycL5pO8jdGBA+Kn8
 SQ8A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775797866; x=1776402666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7uYdkWw4N+y9NR11JaamI9t8jL8n2AkRqo5qBYafHXM=;
 b=UbFQF3lspCUVm8sYvul1U6IKZ+ptd/YPHnFirXhE67kOu787IOcDKSW5WqpsH+SQJM
 NMjyEieFH7OGamkJ/MeIhF245a2b6b/gfwtM8Rg2DcLi+XBXWKO/ElMEj6RhOAWe4saQ
 AlTDakXpOfYxFJ7tZsN8nk//qpcZY8CTCcaZBfIfCidtBCBRrj/0ck9fKKXqUWTO3WDP
 BDNBCHHv7oSIIrscRDzzK6pJpnRHImNKyWcdzFfaofDuMOv8BC6e6t8uk0TtkIVenP3z
 wQQcn9zKjehGjygwufxnthYL+mGd7BMaQwyG2Giyzi6roLFOsU6Avt2KxdkuBYpS4mVU
 XVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775797866; x=1776402666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7uYdkWw4N+y9NR11JaamI9t8jL8n2AkRqo5qBYafHXM=;
 b=iazuFdFbN6kTvA+EbQZRpTgOT2P/mLL4v9xqFiZXNp8hcboj8iMEs4yaa0VWt1hkWR
 iXxqbOUlUBxQZ5SMo7pTv782v9Ho9VXxjtOuZmR2ZgKrgB8hhiE28P2YXYifDr4G4euT
 nUb2L0c5THyYCpO/syOYVccFl6YN8RnQRX2e+j25bBtPK2zz6siFZYdeElNEgcimSgHU
 pYWawe+aZ74ugakUIeGKuwuCAHttLbVm1709Ho2OHDOhh+rNcehgoetJU5SlKiRDFZHk
 guBpRRdq8/wFoEfNxS5B03XV6Y6YlgjkPsOOYNkPcOq2zhajwgCJLaaWF6V4XkdlOqPV
 w7ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWChMoQmri48XaICmGoWD5d7PkhvPJL1dJNdVtQcQlGq4e4VCYPMCNvB9siErTVqIbOvFFsL5I=@lists.denx.de
X-Gm-Message-State: AOJu0YzcEEx/Sp2HMcFkaS3vNZ8MIKflwWV2be2ntzRcUV7k73w5iPV5
 zpuxgXNmwXlUJsq9i5WjH6ihetGf47T3fgTbu5pHEo75NdvkToPNwDKWHcPvLWaWKs26QG3aOH0
 YOyACF47u5uGs0loNb+XCg0YX6Lriwq9dbU7Qf1ILRw==
X-Gm-Gg: AeBDiesfBzzJPeKw1lSqBxBf0OX06i4EUsfKW1seviQpgYoaGGgXxd7/Z5lxXQ05isE
 w+n0VUnvq8POpznJE8SHKGCkKmXPzvO2numk7jgKwCnAc9QpNM65x25+4hXSvA9HvRlmskdvyTu
 fBV2C2sUCAxe+6sOuvJjT2D91HbiWRPNpFYKijOwbG+nc0q0CQt1EYXAdqbyTOdYdW9in7M5L+K
 lF0Rhlh0A249D1P5MH9TWILY3FwTEJXs6732nz7j83OmlGmpcZjdWYMboK63L21+bwTPxy6Fktk
 KvSUo7f9VNw7uAgIIPJxSN4ZCwbJiTb6f+fLY6VtT0wWPD1pa3B5tqzGs0FKnYqN/JVJybH2kS8
 C3XDSoJiXBLMcAYcOQDcLCYPkHL8OfDlfB2svVcGlt8GApMJiyt4p1cV1hlPr1kAIdNakkn6Jpd
 JSQSOqAiByC+p/w9O0dvyJ43lwqxMKw7VUJrZ1A00vjoNa/KVQcNHy9wvItpjhGj1zHcWIfzZDu
 vuvqYXeMOqji1jzCBFt+ZeKiDAcx4raTRHuOeU0XkLHkejEWwojvFKqbfOeW8ED+wr+kueCYg/6
 eYaP1YXAogSnANQwHJz2eNh3buGBrXeMZgNZ0ytv5mI=
X-Received: by 2002:a53:dad0:0:b0:64e:a8d7:46d0 with SMTP id
 956f58d0204a3-65198be2c4bmr1188663d50.63.1775797866043; Thu, 09 Apr 2026
 22:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-3-ilias.apalodimas@linaro.org>
 <b4015957-76b8-4531-b694-cae143a65f49@mailbox.org>
In-Reply-To: <b4015957-76b8-4531-b694-cae143a65f49@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Apr 2026 08:10:28 +0300
X-Gm-Features: AQROBzB0TwZqFmR-5oB24QdWbHG23gTsDmNfAXsMsa2LShi-R6Z0PMd5MQKvT7M
Message-ID: <CAC_iWjLb1dWh1TLmw_XXbJcypp1C-4s7C628dZ73z_8QRPvwdA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] common: move ram_base calculation to independent
 INITCALL()
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
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

Apologies for the late reply

On Sun, 5 Apr 2026 at 07:32, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 4/3/26 11:01 AM, Ilias Apalodimas wrote:
> > Currently, ram_base is calculated within setup_dest_addr().
> > However, upcoming patches that enable U-Boot relocation to the highest
> > DRAM bank require ram_base to be initialized earlier.
> >
> > The default dram_init_banksize() definition relies on ram_base
> > to calculate the start of the first bank. But following patches
> > will move that function to execute immediately before setup_dest_addr().
> >
> > So let's split the ram_base initialization in its own INITCALL.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   common/board_f.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/common/board_f.c b/common/board_f.c
> > index 91c569da9682..7df92281c35a 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> > @@ -329,6 +329,14 @@ __weak int arch_setup_dest_addr(void)
> >       return 0;
> >   }
> >
> > +static int setup_ram_base(void)
> > +{
> > +#ifdef CFG_SYS_SDRAM_BASE
> > +     gd->ram_base = CFG_SYS_SDRAM_BASE;
>
> Would it make sense to reset the variable to 0 in case
> CFG_SYS_SDRAM_BASE is not defined ?
>
> Or better yet, how about moving CFG_SYS_SDRAM_BASE to Kconfig with
> default value 0 ?

I did in fact test this. However boards set ram_base to values in
various places, so I didn't include it till we sort out the board mess
first. I'd like to keep it as is unless someone really minds.


Cheers
/Ilias
