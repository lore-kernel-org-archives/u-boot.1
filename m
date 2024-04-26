Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3838C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4750788384;
	Fri, 26 Apr 2024 17:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZR9sjPfP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C69618869E; Fri, 26 Apr 2024 17:56:41 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8187788499
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2dd6a7ae2dcso36217821fa.1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1714146999; x=1714751799;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAjiRWdt+0TRYD10Lzd4/Aty3LtTVJdOU5ta17+PX8M=;
 b=ZR9sjPfPVQ8LiqmcDuJaz+/8SA8iWGjS/UmAYwVeWgd66j22vG5Swgegw8A/sQPZKF
 39SgGUkSCR33+7ByEqXPoQ5ZxWUgh+l0hiIwva7XV/fr9bm9yZRE5QsU9LDix4qk7M5z
 trB/O4+HO0uzVuKiSXCGHzHxqtI3diCXMRRo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714146999; x=1714751799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAjiRWdt+0TRYD10Lzd4/Aty3LtTVJdOU5ta17+PX8M=;
 b=aDUUBt/RKn3CgCthtTYT1hoy63LHmIKE5SyML/xg+pCbXoAWnnmkJKQDc1TM4yVHF8
 eAXeDUxnpphXOd9pFfYCcF1EMe39Z0/WdqiMhKbPZGjIlcFnDgXqwN/TO0u/dqmiq1b6
 Ufqe3Mx41I2eeqgk6YMhq738GwEGrsuUCOBn21K9/GcWs8mI3faS3gntzlAB4UGnGapi
 PMZgdgfhROmLAVLNFMlcugdG2f20t4L/LYd8DY9CPvMUdEnLWOmzXzAuZoOTdlq5LBNy
 6UqeHNWl+u6/uFTDuzvw6BLTsY/Dp/XTGrxN2mWBIZE210QtQ9PO2rxnKNMTRzg1qWV4
 s/hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl2FR8nm+Z1roAJZksWAIvOsYiZxC+BgauPvVm/qLM650DXuYkkE1j2z+Fjidpjl46e3MUkivN4Enh8Qh3mwUXBj+dlQ==
X-Gm-Message-State: AOJu0YwO9NE7HM2DXx0SKYYQffdP4dgvwHq+nAYl9Q+DvwPOYZk+K/KW
 yY2k2kGsXfEzpm0X5WQo9OUgGw8GD6hjkYoksQhlEqec3TLWWd5AQM7jaYbti9a+rvw6e0unioR
 8sUk1TtzroQqSzRb8MZQ+YMnVCZDGJQCaDmSzoQ==
X-Google-Smtp-Source: AGHT+IEe4WCAPI58a9cbXTrAFOGUsgbL5tnXdT6OUQpn7IhiYJntaOsY/uVkA3Xx9kqk/lvGhz84Cd5EIzLme9nTmIc=
X-Received: by 2002:a2e:9a8d:0:b0:2d4:49d1:38e with SMTP id
 p13-20020a2e9a8d000000b002d449d1038emr2459187lji.28.1714146998594; Fri, 26
 Apr 2024 08:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240411-mtd-v1-1-fe300f6ab657@jookia.org>
 <CAOf5uwmcrh6M-GGYwZVk3D4LzZRnk8fE+88JJgtOAHJ_X2=P2Q@mail.gmail.com>
 <74dc9d77-9316-4c14-5d52-9b496cad2a76@denx.de>
 <20240426155200.GL1054907@bill-the-cat>
In-Reply-To: <20240426155200.GL1054907@bill-the-cat>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 26 Apr 2024 17:56:26 +0200
Message-ID: <CAOf5uwmmGVvAffzojF=YDrcMrn48MtxjsoiScmrHcs6T+LQd_Q@mail.gmail.com>
Subject: Re: [PATCH] ubi: Depend on MTD
To: Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Heiko Schocher <hs@denx.de>, Kyungmin Park <kmpark@infradead.org>,
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

Hi Dario

On Fri, Apr 26, 2024 at 5:52=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Apr 26, 2024 at 07:18:18AM +0200, Heiko Schocher wrote:
> > Hello Tom,
> >
> > On 11.04.24 08:09, Michael Nazzareno Trimarchi wrote:
> > > Hi
> > >
> > > On Thu, Apr 11, 2024 at 7:06=E2=80=AFAM John Watts <contact@jookia.or=
g> wrote:
> > > >
> > > > UBI required MTD to build correctly, add it as a Kconfig dependency=
.
> > > >
> > > > Signed-off-by: John Watts <contact@jookia.org>
> > > > ---
> > > > While working with UBI on my SPI NAND patch series I found it was
> > > > possible to enable it without enabling the MTD subsystem.
> > > > Add a Kconfig option to solve this.
> > > > ---
> > > >   drivers/mtd/ubi/Kconfig | 1 +
> > > >   1 file changed, 1 insertion(+)
> >
> > Seems I am too dummy to find this patch in Patchwork, nor is it
> > applied in master ... can you pick it up, or should I do this and
> > send you a pull request?
>
> It's over at
> https://patchwork.ozlabs.org/project/uboot/patch/20240411-mtd-v1-1-fe300f=
6ab657@jookia.org/
> currently but you can take it up and send it to me if you like.
>

Can you pick it up? Seems that you are delegate and was already reviewed by=
 me

Michael

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
