Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC77C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 08:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BC9B87ECB;
	Sat, 27 Jan 2024 09:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gkA0VPk4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC4D287EC9; Sat, 27 Jan 2024 09:20:54 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85FDF87ECB
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 09:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55790581457so895658a12.3
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 00:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706343652; x=1706948452; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eg8LgevGiZ3QQNCt/W1XZCHJdnVFMH9aJZ9lCWTlvTk=;
 b=gkA0VPk4cvRV/fgFr7xJKotaKSE0llKiwi8em6Kn9mUNEjYLp3E/HKlF+/ucvYX+Na
 T+PxixGWqs5GlRq97MC6aV2XplKG2wJs4VSEGSxBppGk6mt3Fr/hiP5ZDAP+C5AkTHfZ
 YuDf9V/r/ZUvlRc4hoMhpyQabGDrKTvRQvoQY3ZnsIJxDF/4cVORGLBVnD6ENuJwgHx0
 Upbek03NhiZkXiTYnhyTQ1pkN3wSNA5FWQrIipVC57/uW4WgGbqHMBtXAOGH5RGDqul6
 B72IcE4eVV9pjGlaNhR9xyxE38chXp2Px7oPwr88mFNwzZJ62mL6fyvu8AkOM1GpcXfs
 s1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706343652; x=1706948452;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eg8LgevGiZ3QQNCt/W1XZCHJdnVFMH9aJZ9lCWTlvTk=;
 b=vMq70N/GXEalhaI/7jxJ8NjKu95VixTGufGhpTEg/jkr0Q9zCWB1KwUTCm5dJBK0j6
 x0r22/80TXmQpO6dKSUVawiai7jwi0sYqTxKQqx7G4fXBMYhKPM3PZD6A8JSU5gC8y1C
 ukKKQiuhMpbgHlNmkTi/pasfZGVUq0uLQn4HpN39tu5KjmyQAtJNSvakePQe5768mFHt
 NYstYjh2F6qVW22ObpAY5KEnJoCG9YRR5oDltTVEGxrmh9b4xoU1Pl4oUt63SZ2sdFSA
 TetVW5OGQFtO8yQ4zT4rReBLAojT/mAvf494nfCTTyQDRjJw9eqlFf7kdmsC1ikCsZIn
 plwQ==
X-Gm-Message-State: AOJu0YyecxSP20DbP90gg48Zl5dcUAqkpuxY6fCKsGEY/uFuCPKjT+Tn
 i8KBWr2BmNEZxRNvOjTGQkY179V8TTtX+A5+eh3uZGWkaiVHDUqZvOo0zfwvDxLjhIbfpXaGS7g
 IBDYMluiVYk7qTv/xVQXuQMuEXYo=
X-Google-Smtp-Source: AGHT+IGf5wa4yDeK1l3lwdcRcrRaGGJNh/sYcRbxw3KiJfNsLVw7OUxDIX15TAZfKrTtoEdWTHWC14xXzETCJiolQ7w=
X-Received: by 2002:a17:906:a042:b0:a31:58fc:bd83 with SMTP id
 bg2-20020a170906a04200b00a3158fcbd83mr716723ejb.10.1706343651693; Sat, 27 Jan
 2024 00:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20240121114909.2909574-1-bigunclemax@gmail.com>
 <20240126171100.3d10e8b1@donnerap.manchester.arm.com>
In-Reply-To: <20240126171100.3d10e8b1@donnerap.manchester.arm.com>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Sat, 27 Jan 2024 11:20:40 +0300
Message-ID: <CALHCpMhJZmiKXTMJdoE4a6UzzMzU3x-koBBjmnAKTKiipFzdgQ@mail.gmail.com>
Subject: Re: [PATCH v1] sunxi: R528: add UART1 support
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>, 
 Marek Vasut <marex@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

=D0=BF=D1=82, 26 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 20:11, And=
re Przywara <andre.przywara@arm.com>:
>
> On Sun, 21 Jan 2024 14:49:08 +0300
> Maksim Kiselev <bigunclemax@gmail.com> wrote:
>
> > Add PG6-PG7 pins configuration for the SPL to allow use UART1
> > on boards with the Allwinner R528/T113 family.
>
> That looks alright. Not super happy to take yet another combination, but
> well. Also see below.
>
> > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>
> > ---
> >
> > I tested this patch on LC-PI-T113 board.
> > This board can be found on eBay or Aliexpress, and looks like
> > that it is widespread enough to send this patch to the upstream :)
>
> ... it would be even better to have a DT and defconfig then, right?
> Then we would have a user for this code part then. Any chance you could
> send something to that effect?

Well, I can try to do this.

> Are there any BSP code drops, or a schematic or some other documentation?
> I couldn't find something on a quick search.

The google drive link
https://drive.google.com/drive/folders/1lrqDsxtGl8WvU7o547lT9IkHwGyAHXFU
is the only =E2=80=9Cofficial=E2=80=9D documentation that I found.
It contains a board scheme, some datasheets and a useless fw image :)

> Cheers,
> Andre
>
>
> >  arch/arm/mach-sunxi/board.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
> > index 11a4941822..9dedcd45f5 100644
> > --- a/arch/arm/mach-sunxi/board.c
> > +++ b/arch/arm/mach-sunxi/board.c
> > @@ -159,6 +159,10 @@ static int gpio_init(void)
> >       sunxi_gpio_set_cfgpin(SUNXI_GPG(3), SUN5I_GPG_UART1);
> >       sunxi_gpio_set_cfgpin(SUNXI_GPG(4), SUN5I_GPG_UART1);
> >       sunxi_gpio_set_pull(SUNXI_GPG(4), SUNXI_GPIO_PULL_UP);
> > +#elif CONFIG_CONS_INDEX =3D=3D 2 && defined(CONFIG_MACH_SUN8I_R528)
> > +     sunxi_gpio_set_cfgpin(SUNXI_GPG(6), 2);
> > +     sunxi_gpio_set_cfgpin(SUNXI_GPG(7), 2);
> > +     sunxi_gpio_set_pull(SUNXI_GPG(7), SUNXI_GPIO_PULL_UP);
> >  #elif CONFIG_CONS_INDEX =3D=3D 3 && defined(CONFIG_MACH_SUN8I_H3)
> >       sunxi_gpio_set_cfgpin(SUNXI_GPA(0), SUN8I_H3_GPA_UART2);
> >       sunxi_gpio_set_cfgpin(SUNXI_GPA(1), SUN8I_H3_GPA_UART2);
>

Best wishes,
Maksim
