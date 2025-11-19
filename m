Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94620CF3186
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 10:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB4283DBF;
	Wed, 19 Nov 2025 11:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lHhzZ6br";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 315DB83E0E; Wed, 19 Nov 2025 11:08:46 +0100 (CET)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E633F83BD2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 11:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6420dc2e5feso2617380d50.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 02:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1763546923; x=1764151723;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axgk2vm6mJPtwVyXiI0f80vVnLHjZah1W8HUDpaczyc=;
 b=lHhzZ6brpdeamBKPHWN06c8VH28S3yWd4DC+1xpHozImE5dizEY0/EVMpGcPy1eA/n
 Q4BROeVISFR24ARvykiLrMAntCkC/iYzdW2fHI9EHZaO/ICZEqAcD/7Tm+AVvaQJDGUj
 /HyV07eM8kQWnCfglz05mVFg9Xl0MyAkaoLsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763546923; x=1764151723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=axgk2vm6mJPtwVyXiI0f80vVnLHjZah1W8HUDpaczyc=;
 b=audGYLqqPu9W/oK3szVbhzRVen3ljJb5kdiLppyzZQA0jC5IXUhm0pICoAL7h5PnjP
 QqpXv9vB9M4FhXMvJ4HSWeyT9SR81f2PqEFeIr59dlE+kU7u5gvKknttQu+xRX4XYA2S
 brv6bXWwLp2TrsnawSPDtHBb/TIbYQzOXGb0uQt7EfTI9V2yvahMkN3ErwXF528cAQzq
 Za/C2sd0YhKuNE9XkKo9tWIBBbAj/LpNZsFW9agEUqpXGVUcrQgP44yUovtwNRoHIpnk
 Ud1kQvwHLUvDdyhIfpc6xoJciSvm2HyVCSP1qktmt2n+d8JENKNUz9BORezISPCfhvFJ
 m5Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDPDv60NkXAFEigCRiCPlTdvoRyEoJepZ0vH40/Esk4n0n1QDk7VEr11szr4CVhIrysUoAoHk=@lists.denx.de
X-Gm-Message-State: AOJu0YwGeoV62nFLi47N66jCdMACUFzBuyeR3sKDXkTd58RtvG1ayOnd
 P65sqVJ2mbzsueoGXZjfYoCfXwotfJeocQ9mEuqGvFn8e0jLF1AwuAzRd2uw7TRg9oquU2xWvv+
 IUu7h3opRCuzNNar0yC1E9sKDl4w1DZ96IBa2+q+rsQ==
X-Gm-Gg: ASbGncs3IuX0tG2/D33+jJzPvacW6ZW1oUTBje6RQMc/TvHuR6UbKoypcryRUIPfFNN
 +xhz4/b4qaWSkpHU4aBuuZCM4apjuCtj0e2n/000CWwimaT4wRUkqlCvRGQGC73GIp/4M9mCTi8
 l2lqmMx0bMws6izNPfgY/2QuWTAMncYDsy8jKGvcOtnC7/CXoIFWEQSrw7gG1xd4WZTSGa89JP0
 YUk0K3SE9YjdqmS7FOSvdunhoI3euh21e/BM61wfd3gB7OMZTMvP8Ldkr+qbWJrBPffbX/qFfvt
 gLM7go/2+87c/4sC1RZJmGGOBQ==
X-Google-Smtp-Source: AGHT+IHoFasgq5pHC23uLau48VO6y+cUe2S5b956FaQ2+l3x6He9PcWp14AzDcDRkrHbjIcumjqIdD3sxK7GgT2KlyA=
X-Received: by 2002:a05:690e:d8c:b0:63f:b410:e93 with SMTP id
 956f58d0204a3-642ed176e6fmr1358734d50.42.1763546922621; Wed, 19 Nov 2025
 02:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20250703170253.1231818-1-miquel.raynal@bootlin.com>
 <87frcwexyt.fsf@bootlin.com> <875xbegt1x.fsf@bootlin.com>
 <20251113142745.GI6688@bill-the-cat>
 <CAOf5uwn_ggFp-KW6qDcKYn1kKA6+FabyQLCT1ecVoBdv9s3UqQ@mail.gmail.com>
 <20251118143405.GA527619@bill-the-cat>
 <CAOf5uw=jx7jTgkeZytjU0t7VFHSVrXfntxrpapUSWrYh5z8exg@mail.gmail.com>
 <CAOf5uwmygi5z3ae_wgJxu4LSKWfEHfAzPTWzN3TUCk22pHqikQ@mail.gmail.com>
 <87cy5ecpd8.fsf@bootlin.com>
In-Reply-To: <87cy5ecpd8.fsf@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 19 Nov 2025 11:08:29 +0100
X-Gm-Features: AWmQ_blI1l3oz4gViAeUfEARpKxE4juAHt_ZTpOzTaABM8P0kf1O9sZiO5INXOk
Message-ID: <CAOf5uw=oRJEKu3FQZ253OrHDczmJrunXTjchzDfXvKQ6vr=xhg@mail.gmail.com>
Subject: Re: [PATCH] mtd: spinor: winbond: Describe several chips
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Vignesh R <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, U-Boot-Denx <u-boot@lists.denx.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Steam Lin <stlin2@winbond.com>
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

Hi Miquel

On Wed, Nov 19, 2025 at 11:01=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Michael,
>
> On 19/11/2025 at 10:06:42 +01, Michael Nazzareno Trimarchi <michael@amaru=
lasolutions.com> wrote:
>
> > Hi Tom, and Miguel
> >
> > I pick a large part of the patches now, and check them and rebase all
> > of them. I will prepare one pull request today and another later this
> > week
>

First of all I make a mistake with your name

> What do you mean by "a large part"? Can you be more specific about
> which patches you would not be picking and why?
>

Yes some of the patches are connected to Altera one and I need to look bett=
er
on them and I will look the next two days. Some of the patches are trivial:

- mtd: spinor: winbond: Describe several chips
- nand: raw: Kconfig: Correct some dependency issues
- cmd: mtd: benchmark: use lldiv() instead of 64-bit division
- spl: nand: typo 'destintion'
- mtd: spinand: add support for FudanMicro FM25S01A
- mtd: nand: raw: Drop SYS_NAND_SOFT_ECC from NAND_SANDBOX
- spi: spi-mem: fix coverity report CID 537478

Then I have applied the airoha spi patches on top of my queue.


> I am not comfortable with this sentence given for how long these have
> been reviewed and applied in Linux and also submitted to
> U-Boot. Custodians are supposed to work in best effort mode, but
> delaying, delaying and further delaying is not what I would qualify as
> an adapted behaviour. I understand you have other work to do. I also
> take my responsibility in reviewing and collecting and merging patches,

I will not delay anymore I will be more active regarding my duties

This is the branch u-boot-nand-20250918 . If you still want to go further
in the discussion and make the process better, I'm more then happy to
follow your suggestions.

> I may do errors and I correct them when that happens, but try not to put
> all the pressure on my very own shoulders, down to the situation where
> nothing moves anymore. Tom has been regularly trying to provide support
> and help. I would friendly suggest Amarula folks to adopts a softer/more
> progressive approach regarding maintainance roles.

We will try to work better.

Thanks,
Michael

>
> Thanks,
> Miqu=C3=A8l



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
