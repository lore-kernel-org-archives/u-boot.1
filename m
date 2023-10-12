Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64A9CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C79486D62;
	Thu, 12 Oct 2023 05:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ii0LqiTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B43A86D20; Thu, 12 Oct 2023 05:12:20 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A0886D62
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50567477b29so692834e87.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697080335; x=1697685135; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCj5QirZmk5QVx3WdHV3q/F9dxA6hS1itmgQM+d1SH0=;
 b=ii0LqiTSHmgVzfQ3Oa8dCeZx+WvpKJsYfxYKTZ5yZShyludD5v+rf8yW/EdhgX5D+V
 D0zUMZVLbiLYKOlcmeNaBtMWaQbmsMmD4FppcZ2DDLeDdHVj09WVBinfjiWrXh5ARC4Q
 VMmLzz8fNRMDEbGMe08EgI6LzNTf+vOR5AiyhsJKyXfN9InH6y08Jb9RPBWjXmabrr+u
 fMqsu1dABlUs1OsFBDnFBhQxq+MSeTSnkydlSwPg2NxBvwjlVQzvv5qD0NDnAF2/SZoj
 +aHC9PfhfOyNdDvUk9MIwztiqLs9ejJMnemxT9IC9r95UFj6ebT6ZVAgAG+tdd6XH5oJ
 nOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697080335; x=1697685135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FCj5QirZmk5QVx3WdHV3q/F9dxA6hS1itmgQM+d1SH0=;
 b=FYNpIRvcla8T+FV73AluiOsdCaPIQ0zM6tmTMDyfSRJjvrfN7/3rX0qV9VLRY5CjHa
 oXaAC7u9mpJm1818gusnSKZkcpIIVgFq5JpaYlAL74gfhEDTVEstDgB3C4BU1Ql9RnJX
 AW+HsobaPQrWgqvRnL5+fvPMN4UMhB93ltKw8o+dBS/dDJv33upGgenmTDBSQ3udrcUK
 qwftkfEXorNAUxWE0H/DSs0xQo7mtNfmxw3b/OLNhbU6x2dlLzSSkkVleeUKdC/Tgsp3
 tonMMAaQn+8M3PFIzCrAZ4s6s8nBhRKWTsAD1IXx88MyOE8OwZhk+dodNZIUlLA7zRE3
 zl5Q==
X-Gm-Message-State: AOJu0Yy39W2gK3jMWEMVic7WULzSTqm6mqI+9pJZhzzwH0ELTkoJLdtE
 tMkQJKvkSrMmNr1YV4RNG3n2Av9YqbYrzqf1q2A=
X-Google-Smtp-Source: AGHT+IHC+0XI3tUR/j0JtbJZ+8BDy/YwvinWO6PE6qyTUTQm8xPe9fc2dXY4CWAvSCXGzRsJfXGocW49Zp1gQbYKNnY=
X-Received: by 2002:a05:6512:1052:b0:503:fee:5849 with SMTP id
 c18-20020a056512105200b005030fee5849mr22992293lfb.53.1697080335235; Wed, 11
 Oct 2023 20:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231011084533.2325296-1-JJLIU0@nuvoton.com>
 <20231011084533.2325296-3-JJLIU0@nuvoton.com>
 <20231011142008.GD3119521@bill-the-cat>
In-Reply-To: <20231011142008.GD3119521@bill-the-cat>
From: Jim Liu <jim.t90615@gmail.com>
Date: Wed, 11 Oct 2023 20:12:04 -0700
Message-ID: <CAKUZ0+Hs6g5as8Ge-oeRahiAHZpg4aZdZ50BGTEymSLwmTOjJg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] configs: npcm: support more uart baud rate
To: Tom Rini <trini@konsulko.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, YSCHU@nuvoton.com, 
 u-boot@lists.denx.de
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

Hi Tom

Thanks for your review.
Google and other customers need to change baud rate so I added this table.

I will modify the name to CFG_SYS_BAUDRATE_TABLE.

Best regards,
Jim


On Wed, Oct 11, 2023 at 7:20=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Oct 11, 2023 at 04:45:30PM +0800, Jim Liu wrote:
> > add uart baud rate table to arbel(npcm8xx) and poleg(npcm7xx)
> >
> > Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> > ---
> >  include/configs/arbel.h | 5 ++++-
> >  include/configs/poleg.h | 2 ++
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/configs/arbel.h b/include/configs/arbel.h
> > index 891257bc93..c45b2ac137 100644
> > --- a/include/configs/arbel.h
> > +++ b/include/configs/arbel.h
> > @@ -7,10 +7,13 @@
> >  #define __CONFIG_ARBEL_H
> >
> >  #define CFG_SYS_SDRAM_BASE           0x0
> > -#define CFG_SYS_BOOTMAPSZ            (30 << 20)
> > +#define CFG_SYS_BOOTMAPSZ            (128 << 20)
> >  #define CFG_SYS_BOOTM_LEN            (20 << 20)
> >  #define CFG_SYS_INIT_RAM_ADDR        CFG_SYS_SDRAM_BASE
> >  #define CFG_SYS_INIT_RAM_SIZE        0x8000
> > +#define CONFIG_SYS_BAUDRATE_TABLE    { 9600, 14400, 19200, 38400, 5760=
0, 115200, 230400, \
> > +                                       380400, 460800, 921600 }
> > +
> >
> >  /* Default environemnt variables */
> >  #define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=3D80400000\0"   \
> > diff --git a/include/configs/poleg.h b/include/configs/poleg.h
> > index 1e96e838be..fd0e9a7362 100644
> > --- a/include/configs/poleg.h
> > +++ b/include/configs/poleg.h
> > @@ -13,6 +13,8 @@
> >  #define CFG_SYS_BOOTMAPSZ            (0x30 << 20)
> >  #define CFG_SYS_SDRAM_BASE           0x0
> >
> > +#define CONFIG_SYS_BAUDRATE_TABLE    { 57600, 115200, 230400, 460800 }
> > +
> >  /* Default environemnt variables */
> >  #define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=3D80200000\0"   \
> >               "stdin=3Dserial\0"   \
>
> This is now CFG_SYS_BAUDRATE_TABLE, do you really need something other
> than the default as well?
>
> --
> Tom
