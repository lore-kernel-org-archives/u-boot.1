Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C383D5E147
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 08:19:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 578E588FC8;
	Fri,  8 Nov 2024 09:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YgweMOAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E02D88900E; Fri,  8 Nov 2024 09:19:35 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41CA588F62
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 09:19:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7ee11ff7210so1382848a12.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 00:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1731053972; x=1731658772;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ea9ihxe3ENWYGzPII7M4qr1HJIT7NK3x82JK1coGJZg=;
 b=YgweMOAQ7gopGmr8cwaGQWdtciFiaK2AP0RnlkqgGq3Xw2QKqA1iLqTWGZk63VEXUF
 ynyt/Ob/i2Xi2y7m7qkuPL6KIea/q4L0luTUw47XfLjSVktZKjAyzPjhdMyaA81ZeKqy
 HVo2JF8BBI/HlyLGKhyqb2DrL7eiT4aGAbH1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731053972; x=1731658772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ea9ihxe3ENWYGzPII7M4qr1HJIT7NK3x82JK1coGJZg=;
 b=MjPlYVp2+PBBRD3QOYoijNXTNCtZm0GIq3aFg8fHpG+Kf4RCh0PqCa2M3lrnBBSDHC
 fHcXAEBtLxMFQewCqRXd91oI5+/Ru+fUgai2p2keSWMLuLSHkxJwKZk4lEokoqm7bG3E
 swowuquSIW2WwKEULyIzG4UFBHkYmzCvpt0nfFOxzwDFJXTPLosCJ8c1o7RXhmwS4l+U
 3SsT6TyaTL0C9gcbQc6VPwsQXH88oQr2/SjCfaycX/HLE3jlaF+4/sHlTpzaYtGMw9rt
 2KalVf7jnpHCff8OcuTpEeVZojgo7NmUkTH85yGOwezpfeDuNQ0z0mUQE0FiZFLfvQJk
 J7/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8FxyI0WiwV4DqGpVUYfOn+dVCOtoH2foY4arSkytrVQ0YGVqHrCiRfrdhqsCeq1y8QdZii8U=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9iWhLFlRlzH1vOeh+8mTRyEge4dHj4CVAi0CQyRtTmnN+Qe8t
 N8JPh9INFOie4OAq2y0QUy0pPDuc7LGlbCdoL9w363c+PKjJI+RKunpgq0740UVgCm747KllgAP
 +bP0PqXVkISK0mq3iv589NXZpmTpQBkE2XPTigQ==
X-Google-Smtp-Source: AGHT+IHZ7DbPsCoNWqTrb55MuDHZqxFi9UO8Jzs14dxN932gKny43y5YHdPVVEcZtx0MhDjc0x3+HeLTmy+bJPeaRY8=
X-Received: by 2002:a05:6a21:9994:b0:1dc:1147:92dd with SMTP id
 adf61e73a8af0-1dc22b57976mr2556060637.34.1731053971672; Fri, 08 Nov 2024
 00:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20241106210348.218507-1-dregan@broadcom.com>
 <20241106210348.218507-4-dregan@broadcom.com>
 <CACRpkdYt64S=X2_-VO5h=0kgZ5hcoVWOnzYRK5k39AX0cMkD_A@mail.gmail.com>
 <50f852ca0d50e518dc40b1545bc78d38@mail.gmail.com>
In-Reply-To: <50f852ca0d50e518dc40b1545bc78d38@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 8 Nov 2024 09:19:20 +0100
Message-ID: <CAOf5uwnEmztY+_RVDUm4W30x5_dix7LLRUAybcJtwRfxEsQk=A@mail.gmail.com>
Subject: Re: [PATCH 3/4] mtd: rawnand: brcmnand: Add BCMBCA read data bus
 interface
To: William Zhang <william.zhang@broadcom.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, david regan <dregan@broadcom.com>,
 u-boot <u-boot@lists.denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@mail.com>,
 Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
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

Hi all

On Fri, Nov 8, 2024 at 3:22=E2=80=AFAM William Zhang <william.zhang@broadco=
m.com> wrote:
>
> Hi Linus,
>
> > -----Original Message-----
> > From: Linus Walleij <linus.walleij@linaro.org>
> > Sent: Thursday, November 7, 2024 6:16 AM
> > To: david regan <dregan@broadcom.com>
> > Cc: u-boot <u-boot@lists.denx.de>; Dario Binacchi
> > <dario.binacchi@amarulasolutions.com>; Michael Trimarchi
> > <michael@amarulasolutions.com>; Anand Gore
> > <anand.gore@broadcom.com>; William Zhang
> > <william.zhang@broadcom.com>; Kursad Oney
> > <kursad.oney@broadcom.com>; Philippe Reynes
> > <philippe.reynes@softathome.com>; Florian Fainelli
> > <florian.fainelli@broadcom.com>; Miquel Raynal
> > <miquel.raynal@bootlin.com>; Kamal Dasu <kamal.dasu@broadcom.com>;
> > David Regan <dregan@mail.com>; Tom Rini <trini@konsulko.com>; Jiaxun
> > Yang <jiaxun.yang@flygoat.com>
> > Subject: Re: [PATCH 3/4] mtd: rawnand: brcmnand: Add BCMBCA read data
> > bus interface
> >
> > On Wed, Nov 6, 2024 at 10:04=E2=80=AFPM david regan <dregan@broadcom.co=
m>
> > wrote:
> >
> > > The BCMBCA broadband SoC integrates the NAND controller differently t=
han
> > > STB, iProc and other SoCs.  It has different endianness for NAND cach=
e
> > > data.
> > >
> > > Add a SoC read data bus shim for BCMBCA to meet the specific SoC need
> > > and performance improvement using the optimized memcpy function on
> > NAND
> > > cache memory.
> > >
> > > This is a port of the upstream Linux patch to U-Boot.
> > >
> > > https://lore.kernel.org/linux-mtd/20240223034758.13753-12-
> > william.zhang@broadcom.com/
> > >
> > > Signed-off-by: david regan <dregan@broadcom.com>
> >
> > The patch looks fine, but shouldn't the existing brcmnand_read_data_bus=
()
> > in drivers/mtd/nand/raw/brcmnand/brcmnand.c also be replaced with
> > brcmnand_soc_data_bus_read()?
> >
> > Maybe this is a problem in the upstream kernel driver though :/
> >
> The upstream kernel driver is correct because it uses exec_op to read the
> parameter
> page/ONFI data but exec_op is not available to the u-boot code base.  So
> this new function
> brcmnand_soc_data_bus_read tries to do that in generic way to handle the
> endianness
> difference between platforms. But I agree it causes confusing to existing
> brcmnand_read_data_bus.
>
> We are working on a better solution and will update.
>
> > Yours,
> > Linus Walleij

I'm thinking of applying this series for a general cleanup. What would
like to have in cover letter, is what board
this series was tested, due the fact that some of the code is not
necessary anymore

Michael



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
