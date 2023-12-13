Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA6FC4167D
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61074877E2;
	Wed, 13 Dec 2023 17:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="h1rFjEV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D81B877E2; Wed, 13 Dec 2023 17:22:40 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B3C86564
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dbcd1e7adf3so805389276.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702484557; x=1703089357;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WxOrdZEm0XCA6HIfSi2mxQrHkO3PkyCd8xWFhSJXOmI=;
 b=h1rFjEV4htRoupbIkVeuL5aICGOaenzF2KhHYZZM/bwZiDtUrXOxKqsbIAlcUJwDRR
 WtCSDiGjiDfM62cnrFdqOWbkTDC3RpWGViJv5Wior6fR/RjIgAlUPZJYd28LLZcJZq/g
 xnWdatZhN0X4LN2kulZvP8WWMH3HgWiluT2fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702484557; x=1703089357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxOrdZEm0XCA6HIfSi2mxQrHkO3PkyCd8xWFhSJXOmI=;
 b=UODbZLID3dR82Xlp8fhFnStMYOJplB1Hg7/63O8ex4Oo8lA8YCw3fxtDVXG9ET5YtH
 SEn7S7y+y3qsOZhpLvLxiEuwcqrzbRKGqHbcEBrfuwSPyvqniL69wwBbecVUoXSQXuwi
 kRPmYHJ1/18zC62StUyL/7gGvZ1016rXJnHklrxxXnC+NvIrZt4YQk9rZY2jIBja2oFe
 1/Ap7Oh4vECSKWuYfJUYvQax7plsWB9sAuMb6Aa8DtMSpy0KmAhh3Nq1eHB9XSOExP/i
 wJv5xA80WXrcx6/n99RA9srIAsvToJ27BWA+JptIRlk2TWXNgwLqNM6GEF/fOipJgXmp
 keLQ==
X-Gm-Message-State: AOJu0YzpBHKBUv/xO+sPewDFnpiCULdz/54e8E6XtYvcOS3ASo4+euV5
 406tYAdDqIhaWAI+69tKnTUi8B8ujdM5XkdPg1RRAA==
X-Google-Smtp-Source: AGHT+IEKlsppP9ycEjzRqN47rq+Lbn6l8LDiCr3A5ymKTxaPY1gdVVxpvF1CbG1Ubs25CfF6h0rwvastDotHkFw3eBQ=
X-Received: by 2002:a25:e74a:0:b0:dbc:d090:1d10 with SMTP id
 e71-20020a25e74a000000b00dbcd0901d10mr791840ybh.129.1702484557079; Wed, 13
 Dec 2023 08:22:37 -0800 (PST)
MIME-Version: 1.0
References: <20231204085247.9772-1-venkatesh.abbarapu@amd.com>
 <b687ac77-96b2-4bb5-a353-e209818bba09@amd.com>
In-Reply-To: <b687ac77-96b2-4bb5-a353-e209818bba09@amd.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 13 Dec 2023 21:52:25 +0530
Message-ID: <CAMty3ZAaTZkM7jx_h8pLysiCKbSQmdQiKWWxR-YncAt_b8vSfg@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spi-nor: Add IS25LP02G flash support
To: Michal Simek <michal.simek@amd.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com, Sreekanth Sunnam <Sreekanth.Sunnam@amd.com>
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

On Wed, Dec 13, 2023 at 9:19=E2=80=AFPM Michal Simek <michal.simek@amd.com>=
 wrote:
>
>
>
> On 12/4/23 09:52, Venkatesh Yadav Abbarapu wrote:
> > Add support for ISSI 256MB flash IS25LP02G. This part supports 4byte
> > opcodes. It also supports dual and quad read.
> >
> > Signed-off-by: Sreekanth Sunnam <Sreekanth.Sunnam@amd.com>
> > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> > ---
> > Changes in v2:
> > - Fixed the name to Sreekanth Sunnam.
> > ---
> >   drivers/mtd/spi/spi-nor-ids.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-id=
s.c
> > index 3cb132dcff..9a73198227 100644
> > --- a/drivers/mtd/spi/spi-nor-ids.c
> > +++ b/drivers/mtd/spi/spi-nor-ids.c
> > @@ -217,6 +217,8 @@ const struct flash_info spi_nor_ids[] =3D {
> >                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) =
},
> >       { INFO("is25lp01g",  0x9d601b, 0, 64 * 1024, 2048,
> >                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) =
},
> > +     { INFO("is25lp02g",  0x9d6022, 0, 64 * 1024, 4096,
> > +                     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) =
},
> >       { INFO("is25wp008", 0x9d7014, 0, 64 * 1024,  16, SPI_NOR_QUAD_REA=
D) },
> >       { INFO("is25wp016", 0x9d7015, 0, 64 * 1024,  32, SPI_NOR_QUAD_REA=
D) },
> >       { INFO("is25wp032",  0x9d7016, 0, 64 * 1024,  64,
>
> Jagan/Tom: Do you want to take it? Or should I take it via my tree?

Picked on my tree.

Jagan.
