Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BF3C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 14:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CB5D82CFA;
	Wed, 25 Jun 2025 16:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gSeH+sip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8233082D21; Wed, 25 Jun 2025 16:26:04 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 495BA82C4C
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-54998f865b8so1386186e87.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750861549; x=1751466349; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v66K0ZSDjl6pygdRgC5xz8R60y7ifzIxEJm2PdeUw6M=;
 b=gSeH+sipqG/fZ29WB7korX01WeC6/7aHfoYLO1YQVXbj+kyQYvaxPUN1qHt13BRcOK
 om4iIb/ncbB2rqr3G3GGUb+t5BTC8pfLzeGYT6HZYdatI4xUwBAYnIgyk2U8vLW2hdSQ
 tMV/Tk79xeb3/KnzmY/baclulrBhj1G106PPaQVdxF5LELBY9/zSk2GNf4rptnXZoChE
 KQlZtl9HkNEKa6KNkxgjbW/AqEKFsp0ACSqfKR9RwkDAlyn4GTSV4dP212bpfFmO4L+l
 djnfqY+lGtQlotvRbZhmIHdZkywTgWOnRjtN8H7UChwTAn2Ktq6PXDjFAb1bUjhzGBFr
 ZP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750861549; x=1751466349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v66K0ZSDjl6pygdRgC5xz8R60y7ifzIxEJm2PdeUw6M=;
 b=Eyao4F+kT0k4IJblcdnkpnYDIol7psdiqnSqOszKo/rWbppCY7Iksw81NFST9JM7Wx
 /GZN50Q5Q4EnzyVAfp1gQ/e5iSLR8MXjYVPhjZinevsbvy2QTnBVceAefvkR6x8flg/b
 W9q7xDvgo5vwFl8qRWm23zS0b2DqZ+uNTTaiO9Zoe01m8mjuaTw5/YKqF8Q+Blap07T0
 qDyXJkOANPlaHPfMjeLug8dBKk4EH/L3g+8DoUjNBgRNtQ77vNHbJFTCf6VAfQFNoBz6
 hBQ4FVhfVxKsgL0VCOvksHqqc1tFxFjCOeearylpvvI4Ld9p8mRh3LX2MYQNp8cASsdk
 km5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvtV6e7pje0h+qPuBmkIvVEI6148o9nqneNBc3LLjSQOXo+c0p6+ul2+BZWu89QVIXsYrj9vc=@lists.denx.de
X-Gm-Message-State: AOJu0YzRsvIsde9LRxwLoKG3JUT95RMXEIdgGXgJ15xE/ewNwHH2gR9W
 6YFR3GWbL8IgYSal3tCvWmrci2LPIF4MIoF55YWmDR+mHlfnCEzTLd7nn2GB0Layg3vpAjEsGwg
 pRto1gvpvCp8lSbQCCdR501ofYbtDCoc=
X-Gm-Gg: ASbGncthd7r79S1WOHjXSgj5+F4cbS8b876xXZACULvLGOuXUH0pUzflzQks4lNnkCT
 BRLzaAFCJcv/FM5BRCpfBkuBsuJWPqJYi6w9Sir/YW4CwM1Oly3uHBOHnu8Q5ogLE/C76M/fyuU
 SkJmYktxwOFiQvS28IZaY/OwnSwHav4zCZt/fKkJ6cbofItJR+Rt5d3Cpr927xvyGc+FvikYwtK
 dM=
X-Google-Smtp-Source: AGHT+IEWifWv66DFfNYbIU+Pl6u2wUrgAFfQvQwv32+jtfhV1PRVxtBhVodQfL2YtRVUKho4vLrcaPcPJv9DM52wHQ0=
X-Received: by 2002:a05:6512:3ba6:b0:553:30fc:cedf with SMTP id
 2adb3069b0e04-554fdf574acmr1010120e87.38.1750861549167; Wed, 25 Jun 2025
 07:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250624204700.972663-1-lukma@denx.de>
 <20250624204700.972663-2-lukma@denx.de>
 <20250624210116.GL4003484@bill-the-cat> <20250625083637.1d286cec@wsk>
In-Reply-To: <20250625083637.1d286cec@wsk>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Jun 2025 11:25:37 -0300
X-Gm-Features: Ac12FXwC2NEQ-TK5AIuSlQAwrGed-NmAJ6P9tUWbJkMpS3eL4DmUfvnziWohvyQ
Message-ID: <CAOMZO5A7wMhDxKrYdg_PkZ5-PJXgStNszau=+Df3-ZC7G6PasQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dts: Add u-boot specific 'fsl,mux_mask' property to
 iomuxc for vf610
To: Lukasz Majewski <lukma@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 uboot-imx@nxp.com, albert.aribaud@3adev.fr, u-boot@lists.denx.de
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

Hi Lukasz,

On Wed, Jun 25, 2025 at 3:36=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:

> It looks like in Linux the mux_mask is hardcoded (for Vybrid vf610):
> https://elixir.bootlin.com/linux/v6.16-rc3/source/drivers/pinctrl/freesca=
le/pinctrl-vf610.c#L321

I suggest doing the same approach in U-Boot's pinctrl-vf610.c driver
instead of doing it in u-boot.dtsi.

The less we diverge from Linux, the better.

> In u-boot other SoCs use it as well, but with different values:
> - arch/arm/dts/imxrt1050.dtsi -> 0x7
> - arch/arm/dts/imx8ulp-evk-u-boot.dtsi -> 0xf00

imxrt1050 and imx8ulp use different pinctrl drivers.
