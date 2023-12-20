Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E0AC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 07:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0747A870B7;
	Wed, 20 Dec 2023 08:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QCKmQuf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53A29874F6; Wed, 20 Dec 2023 08:23:57 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6A738700D
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 08:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dbd029beef4so393551276.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 23:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703057032; x=1703661832;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzQ2t8Qc2Kmw1DGS5vGGdu5mECfo8RFCpV3hvolcouA=;
 b=QCKmQuf9jrJvD1rSjgDou1O8UzdeKAXwhj+vWXCYRRivPKPvAmD1+Ij7OCyk3yoGzu
 1skq45/q3FuHWMXOrDNY6qBq/uzWm1aCWH/yiGWy0fZ347LWJQCBzynUJnPRXm2J4tsh
 iyEk23WmV8FwQ3Owh5l9DJx529WmAF/bpEpGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703057032; x=1703661832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzQ2t8Qc2Kmw1DGS5vGGdu5mECfo8RFCpV3hvolcouA=;
 b=FvKkgZ1LID8kE/daAFxrqCVr0yj76DKw7jL6lCqlsDdqwZhA15htF9NpraNwv7NRjF
 HEzNYUv8BGfVVO727Ds6xRh85stByUyit4Ekv79xrYILol2gxkVRTyiiUt4aEMZXI9Sb
 g3Kf5luBPt9/Oft6LwqpVNPzMUW6+d2fGuLBJVz5GFJhVJyzQEfHtlgOdmyNrfRBGqui
 3yCgHAHsyapU9Jll6au9WRuY6A/l+/XrN2JaYgOx01aqSUcE6DiauVBcZWCC2hzU/+2v
 XttNTjfY2gg5lpLNR4/1KWujpIt25Noxc6uNqRgFGTU68YgxzXcrSVHDIsQUjrO6c4Z9
 WH+g==
X-Gm-Message-State: AOJu0YyVP5IIJzZoVUfFzoNV3naxLhN8zv03m7PahJc2ejvRSSoBCbxo
 zlTT5MsKBRulss0jJwI6SSYLTJGB9oxky7BQCd/TmKISrIBh1W8RGq4=
X-Google-Smtp-Source: AGHT+IHpwH211OLtzyy1UNawwtaNV0pNJnVHhplfw1dKj436jcNCR360QLccDDAUbrroIwGZr2vvj3v4th23m+xwnZY=
X-Received: by 2002:a25:ca56:0:b0:dbd:af22:f751 with SMTP id
 a83-20020a25ca56000000b00dbdaf22f751mr116950ybg.44.1703057032481; Tue, 19 Dec
 2023 23:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20231017070507.1254286-1-bigunclemax@gmail.com>
 <CAMty3ZCubyd9y5dqGTaEHDGNbai1Yg3vgiY-oivBQqUznqe0dw@mail.gmail.com>
 <CALHCpMi-rqf0E2aEyACF1Y0-j6NVXQfQjgrNYwzMZdkdLgPP1w@mail.gmail.com>
In-Reply-To: <CALHCpMi-rqf0E2aEyACF1Y0-j6NVXQfQjgrNYwzMZdkdLgPP1w@mail.gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 20 Dec 2023 12:53:41 +0530
Message-ID: <CAMty3ZAspbfig=h3_W0wXc3qQHbnmiHpJ2qwAH+Pek9EbW1EMg@mail.gmail.com>
Subject: Re: [PATCH v1] spi: dw: add check for Rx FIFO overflow
To: Maxim Kiselev <bigunclemax@gmail.com>
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

On Mon, Dec 18, 2023 at 11:01=E2=80=AFPM Maxim Kiselev <bigunclemax@gmail.c=
om> wrote:
>
> Hello Jagan,
>
> =D0=BF=D0=BD, 18 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 14:28, J=
agan Teki <jagan@amarulasolutions.com>:
> >
> > On Tue, Oct 17, 2023 at 12:35=E2=80=AFPM Maksim Kiselev <bigunclemax@gm=
ail.com> wrote:
> > >
> > > If even one byte is lost due to Rx FIFO overflow then we will never
> > > exit the read loop. Because the (priv->rx !=3D priv->rx_end) conditio=
n will
> > > be always true.
> > >
> > > Let's check if Rx FIFO overflow occurred and exit the read loop
> > > in this case.
> > >
> > > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > > ---
> > >  drivers/spi/designware_spi.c | 24 +++++++++++++++++++++---
> > >  1 file changed, 21 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_sp=
i.c
> > > index 1c7d0ca310..0f443bff8e 100644
> > > --- a/drivers/spi/designware_spi.c
> > > +++ b/drivers/spi/designware_spi.c
> > > @@ -111,6 +111,15 @@
> > >  #define SR_TX_ERR                      BIT(5)
> > >  #define SR_DCOL                                BIT(6)
> > >
> > > +/* Bit fields in ISR, IMR, RISR, 7 bits */
> > > +#define DW_SPI_INT_MASK                        GENMASK(5, 0)
> > > +#define DW_SPI_INT_TXEI                        BIT(0)
> > > +#define DW_SPI_INT_TXOI                        BIT(1)
> > > +#define DW_SPI_INT_RXUI                        BIT(2)
> > > +#define DW_SPI_INT_RXOI                        BIT(3)
> > > +#define DW_SPI_INT_RXFI                        BIT(4)
> > > +#define DW_SPI_INT_MSTI                        BIT(5)
> >
> > Why do we need unused macros?
>
> Actually DW_SPI_INT_RXOI is used. As for the other bits in DW_SPI_RISR,
> I decided to add them all to match a Linux driver.
>
> We already have a lot of unused macro in this driver (ex. definitions
> for bits in CTRLR0_FRF,
> CTRLR0_MODE regs and so on).
>
> So, what's a problem with adding the DW_SPI_RISR bits?

I'm not fond of unused change in the particular patch, better to send
the updated one with used bits.

Jagan.
