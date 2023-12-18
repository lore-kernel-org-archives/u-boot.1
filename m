Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C258C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 17:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFF48717E;
	Mon, 18 Dec 2023 18:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ddRsiBQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3397F871B1; Mon, 18 Dec 2023 18:31:20 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 507B68715C
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 18:31:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a2330a92ae6so242514466b.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 09:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702920678; x=1703525478; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXFZT6y1/YJbFGc4onVelfetQBZANAIjam+bEitJP7Y=;
 b=ddRsiBQnXGw1nEeuqxgSXkL4PXL9LigGqDbS/KqYXL1Mwzq0dxp6X6B/xdbk6UzSI8
 Pxuew3c2hGYtoVTEB68WO5aGW/SGWc3V/ea7FlRSjQCLuV7pjd/w6gEVRtVvegIDiGye
 DCEttRSn+EhzyjJmJCxbK7NNDWVBxZKWthZNXrxBIAU8fcIqzn3LBf45en82J9JvnFqV
 Yuy5Y4SW1Mc+VyrDAsHkmHzxfdRFwGVPVZptKUQYKDpbqCsbEcS0wwZh6XM/kbYlPB4B
 YdzJuONrOH7w/5BCfJjfgEcLYQFP3leEdq9b3vWNh1wM6+zTdstfZiAG32SKAUroGhTE
 lq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702920678; x=1703525478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QXFZT6y1/YJbFGc4onVelfetQBZANAIjam+bEitJP7Y=;
 b=BM9ayAFbUKp2K0hvJpWLnk4yhpTMUHMI85zsUokcQIcuI2x4U69LbA50QE0TSrya4x
 g07mUgnqsm+ujAGsSg7kMPlBwAyjAIlmyHpn0H9Hi7d/2byjH+1Eih34t3tqZQXV4tYZ
 tFCSMa0wIJx5kJHuKYZemPZYGqn33dI5cm3unxT64PsoRNcnkYFY3sG4ngE6vKwPNrEi
 iXAnLA/5wbg39eE5SW/DUeuQ78E6aJ7XjkWJRMfcVfVxQf+HWYjm4UIVHwZpdNNwFGLD
 H4mw8JF7QXi98xfQFg/ZUxBoCKgFK9yCBLG6FSrRh2kCMv82LwLWcxNIQ5wDRdZZVsMQ
 QEcw==
X-Gm-Message-State: AOJu0YztBf5z7h+uA6WuuUDPctwqJFu0/H2Kry3OXYKU6qEgYILSoc18
 WakZcM9Leb5AbLF3FDCE2N/g2qgQuFAw/e3+PC4=
X-Google-Smtp-Source: AGHT+IFf4lqsUUgssy1vHGqJZFtwfHOqRipBeA27TRrgJlhDiwlx1a0V2IUf5oOGC1bMcXXhGtvQr2HvkpbTW9QjfeM=
X-Received: by 2002:a17:907:9408:b0:a01:9d8b:db17 with SMTP id
 dk8-20020a170907940800b00a019d8bdb17mr11704760ejc.15.1702920677496; Mon, 18
 Dec 2023 09:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20231017070507.1254286-1-bigunclemax@gmail.com>
 <CAMty3ZCubyd9y5dqGTaEHDGNbai1Yg3vgiY-oivBQqUznqe0dw@mail.gmail.com>
In-Reply-To: <CAMty3ZCubyd9y5dqGTaEHDGNbai1Yg3vgiY-oivBQqUznqe0dw@mail.gmail.com>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Mon, 18 Dec 2023 20:31:06 +0300
Message-ID: <CALHCpMi-rqf0E2aEyACF1Y0-j6NVXQfQjgrNYwzMZdkdLgPP1w@mail.gmail.com>
Subject: Re: [PATCH v1] spi: dw: add check for Rx FIFO overflow
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
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

Hello Jagan,

=D0=BF=D0=BD, 18 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 14:28, Jag=
an Teki <jagan@amarulasolutions.com>:
>
> On Tue, Oct 17, 2023 at 12:35=E2=80=AFPM Maksim Kiselev <bigunclemax@gmai=
l.com> wrote:
> >
> > If even one byte is lost due to Rx FIFO overflow then we will never
> > exit the read loop. Because the (priv->rx !=3D priv->rx_end) condition =
will
> > be always true.
> >
> > Let's check if Rx FIFO overflow occurred and exit the read loop
> > in this case.
> >
> > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > ---
> >  drivers/spi/designware_spi.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.=
c
> > index 1c7d0ca310..0f443bff8e 100644
> > --- a/drivers/spi/designware_spi.c
> > +++ b/drivers/spi/designware_spi.c
> > @@ -111,6 +111,15 @@
> >  #define SR_TX_ERR                      BIT(5)
> >  #define SR_DCOL                                BIT(6)
> >
> > +/* Bit fields in ISR, IMR, RISR, 7 bits */
> > +#define DW_SPI_INT_MASK                        GENMASK(5, 0)
> > +#define DW_SPI_INT_TXEI                        BIT(0)
> > +#define DW_SPI_INT_TXOI                        BIT(1)
> > +#define DW_SPI_INT_RXUI                        BIT(2)
> > +#define DW_SPI_INT_RXOI                        BIT(3)
> > +#define DW_SPI_INT_RXFI                        BIT(4)
> > +#define DW_SPI_INT_MSTI                        BIT(5)
>
> Why do we need unused macros?

Actually DW_SPI_INT_RXOI is used. As for the other bits in DW_SPI_RISR,
I decided to add them all to match a Linux driver.

We already have a lot of unused macro in this driver (ex. definitions
for bits in CTRLR0_FRF,
CTRLR0_MODE regs and so on).

So, what's a problem with adding the DW_SPI_RISR bits?

Cheers,
Maksim

>
> Jagan.
