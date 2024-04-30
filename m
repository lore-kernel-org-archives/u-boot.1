Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3C2C25B10
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 06:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18D19881DE;
	Tue, 30 Apr 2024 08:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cDyQfGL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 316A6881C6; Tue, 30 Apr 2024 08:38:14 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2DDE881DE
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 08:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-61af74a010aso52332807b3.0
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 23:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1714459090; x=1715063890;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/2u3dSqCwAj2Me7LhZXX2WkxbOSXC2Cfd2uu32AzeU=;
 b=cDyQfGL5MG0qD7Dg2rwhs2Ey/KAICghdXAjRrpZfz2M51uH0BPLhAH3BON9wwbaxZp
 7X6y9pf+nJDzWlV9DbcjrrPKEbSQdx3y3F7PeB6B/GnyEjeZgd4rh/q4wajGJUjmZ0ZE
 g6TR/CFyJgR1glne3mNNe/TwanuPzwPrVMXDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714459090; x=1715063890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/2u3dSqCwAj2Me7LhZXX2WkxbOSXC2Cfd2uu32AzeU=;
 b=XAE/tPGTgoQfuARpDsjrT78PEu4G6o9yNWpc9vA3SF2AsYT49cF2qWtKSOQ5zVxhDy
 F8LuMtmAOATYkFnbCraQ41Su3kofQwKuUK1EOfS9SlnMXVWMoGX1/SePZBvDGW2lqkGN
 wMtlJ7bCwSCKIW13zToPvxx5sUxmPgO9ECC0VxNZy/avHL2EDtZt12EH4Iv+pOtqYy9O
 1hpP+7g4RHMitsR77vbwaS2cW//H3puRxHm4oe6N60KvgpI7tFg53R9KpEYaCJF10vM4
 a0DJ7uEn71r980qN7by+8l85QdoOjVrYlHzroihfrYALGuSQps/aRTPWWYpUHI+boKKo
 Hjqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtWkS2Oqkxi4rdGkncR3Q8aY6CVzM8w4TeZj9I7Mv9T+hHcOz9tyW9dW0/ejqXJ4iMqIJGPA73GElovcgPYckskoU9qw==
X-Gm-Message-State: AOJu0Ywox60qDLkyjwKN2AqKMu84nK46uG/EP55lfRgjvN7/C7DeQg6+
 KHrpHjhF7fL+jwEycw1+l5Pmxbf2hiIWrSG7c9Sfu5rDIpdkV4bOF5FuydvBuXFwPNZkzWPmJK4
 v5oUTE91jSwjL6u8BkaNgUoNkju2XEQeIJP0tww==
X-Google-Smtp-Source: AGHT+IEomktd3nm05U85Cag1hnW4ZVJy7VCAdaJvIjC03DhbXwqM0kGdQJNYsPo1KK+2L6Hz1POlZEpvAJA52B5TJpg=
X-Received: by 2002:a05:690c:888:b0:61b:1dbf:e451 with SMTP id
 cd8-20020a05690c088800b0061b1dbfe451mr11445825ywb.46.1714459090379; Mon, 29
 Apr 2024 23:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240411-mtd-v1-1-fe300f6ab657@jookia.org>
 <CAOf5uwmcrh6M-GGYwZVk3D4LzZRnk8fE+88JJgtOAHJ_X2=P2Q@mail.gmail.com>
 <74dc9d77-9316-4c14-5d52-9b496cad2a76@denx.de>
 <20240426155200.GL1054907@bill-the-cat>
 <CAOf5uwmmGVvAffzojF=YDrcMrn48MtxjsoiScmrHcs6T+LQd_Q@mail.gmail.com>
In-Reply-To: <CAOf5uwmmGVvAffzojF=YDrcMrn48MtxjsoiScmrHcs6T+LQd_Q@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Tue, 30 Apr 2024 08:37:59 +0200
Message-ID: <CABGWkvqEyCzjfFcpkBd8+KMr-yye7EbRxHEh13VA-ywesJQupA@mail.gmail.com>
Subject: Re: [PATCH] ubi: Depend on MTD
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Kyungmin Park <kmpark@infradead.org>, 
 u-boot@lists.denx.de, John Watts <contact@jookia.org>
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

Hi Michael,

On Fri, Apr 26, 2024 at 5:56=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Dario
>
> On Fri, Apr 26, 2024 at 5:52=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Fri, Apr 26, 2024 at 07:18:18AM +0200, Heiko Schocher wrote:
> > > Hello Tom,
> > >
> > > On 11.04.24 08:09, Michael Nazzareno Trimarchi wrote:
> > > > Hi
> > > >
> > > > On Thu, Apr 11, 2024 at 7:06=E2=80=AFAM John Watts <contact@jookia.=
org> wrote:
> > > > >
> > > > > UBI required MTD to build correctly, add it as a Kconfig dependen=
cy.
> > > > >
> > > > > Signed-off-by: John Watts <contact@jookia.org>
> > > > > ---
> > > > > While working with UBI on my SPI NAND patch series I found it was
> > > > > possible to enable it without enabling the MTD subsystem.
> > > > > Add a Kconfig option to solve this.
> > > > > ---
> > > > >   drivers/mtd/ubi/Kconfig | 1 +
> > > > >   1 file changed, 1 insertion(+)
> > >
> > > Seems I am too dummy to find this patch in Patchwork, nor is it
> > > applied in master ... can you pick it up, or should I do this and
> > > send you a pull request?
> >
> > It's over at
> > https://patchwork.ozlabs.org/project/uboot/patch/20240411-mtd-v1-1-fe30=
0f6ab657@jookia.org/
> > currently but you can take it up and send it to me if you like.
> >
>
> Can you pick it up? Seems that you are delegate and was already reviewed =
by me

Yes, I will apply the patch to nand-next branch and test it with the CI pip=
eline

Thanks and regards,
Dario

>
> Michael
>
> > --
> > Tom
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
