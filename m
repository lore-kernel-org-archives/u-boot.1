Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EBBE77183
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 22:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C81E1800D7;
	Mon, 16 Dec 2024 23:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kBa1iPGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FDC680104; Mon, 16 Dec 2024 23:05:24 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D77F800D2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 23:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so10691572a12.1
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 14:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734386721; x=1734991521; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vqu9JKp2GLJsgM4wan3dEl97D8QGB4MVnTnj2SnihEo=;
 b=kBa1iPGvk/abs2buWOnnEsvzlMA6+9f9nO+zeaKx2OXfhzobGNdv0t0R0LmTnEabRs
 McNTrkecx3/fOH9sqygmGXVZ6SJKDjkocYPcuzUb4JoBmFYJK4BfRLFg9Y0mPQzv8NmL
 U3RYhB46o2leue6lYTd9QXkxF1aG6OG1f0bkt0Hnc8Ywrhb9kPH9cQng03a6/TpTvRxM
 9EAdINiUfW5fgp/fMx+LXi0qIGXKj9Zl5dR4SNXm1wZ0/cnnHwNh6kCsaqz6tf82/tvV
 pVa74CJjOdPpAC9bWhDXtFchxluzN2HVFiOE9Rjlyhv7YfOBChHQeKBnZWCGazXPXecP
 SNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734386721; x=1734991521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vqu9JKp2GLJsgM4wan3dEl97D8QGB4MVnTnj2SnihEo=;
 b=EugYDBJa0FSRsISIzKZCtTR8s5ix17ahbbgS0ToGcK6DgTUGvK++fVvbF962ijxT+F
 lc0tmaQ/aI9D9ReW0j4pgtM7Ul+a4rTvR97ZRTitdJlcV9u4EORAR/DT1gjjtl/DLKPa
 K+1FYidYFgOxrUF7tX3PooB8+hrD7BWtNV6HnAhnmTvYmKok9PzLgeLWTr937Lm/BiHM
 poOiWmVCss2vENS2QHqONTzHkj751y+Xgb5gQxVEgGbN+5los5JZ4Tif4euAAi5pQIAx
 IN8RQO7jsZlZvER2tskrnYpJAnFmPlkB33m3FzgnMKZH+GmpGBBO4fwKBIzX/Ual+9aD
 kk2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYQFm3yk5xgPAyVZUCDr9ZoL0OepvE8L6goJRlh2EYfuE+FtWtMbB9JgNncPMOPxWhDH+rCZg=@lists.denx.de
X-Gm-Message-State: AOJu0YxDcl7qMyhP+h3MPGRWdu6opIpqtmi/SiMCI4fcSBc28ypgMaIE
 66im06H+CIiYfBBx9jt1Oe7OTJvQIRH8HqrvBasFLS79Wr5z41U3TTph+TpJRNHYgdMFQWvK5vg
 hOJPCkUMwcONAV1oOfqGvOx85eVqeKqJ3K+NflQ==
X-Gm-Gg: ASbGncsR6UPomFpGFMKbC5VtnYFsZQUlf2W/1ADoKOSJAfgVE6xnERnu2TFUws2bDt8
 IQ93KFtPny/+aI95D00YWFCT2zBBr7adIbRS3WTU=
X-Google-Smtp-Source: AGHT+IELs7vPX/3Xm2Zz9j+bYY6MRHscRBitk0Wj+BOTzMMozm0Hg0eLQMaZQausrWuWtPkdTbUaTBbQw/VDTvtS4ug=
X-Received: by 2002:a05:6402:4492:b0:5d4:c0c:70f9 with SMTP id
 4fb4d7f45d1cf-5d7d5571ac6mr885815a12.6.1734386721484; Mon, 16 Dec 2024
 14:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20241216114231.qpfwug3zfqkxn3d5@joaog-nb.corp.toradex.com>
 <CADg8p95K5sgLbqutnGWwcggU+o94GFrS5w3=GQecuO_NT5y6PQ@mail.gmail.com>
 <20241216142842.p5j4otcinwpszt5l@joaog-nb.corp.toradex.com>
 <20241216190255.GA55577@francesco-nb>
 <CADg8p96Aiy-DBNc8piA5gN01E+iWHZJ4OGhY5qjOK1wCUS-O7Q@mail.gmail.com>
 <Z2B_sqO2XcAMIF3H@gaggiata.pivistrello.it>
 <CADg8p94S5kzr_yDhs0m8M_J8U_jKLCkdQ+RXiQAbmL+uF+F4+w@mail.gmail.com>
 <CAC_iWjKV09uXouhvLTKXk3B+Qfw481_unXc1phLq674R0CKyZQ@mail.gmail.com>
 <Z2CCOS76kgh_Kun9@gaggiata.pivistrello.it>
In-Reply-To: <Z2CCOS76kgh_Kun9@gaggiata.pivistrello.it>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 17 Dec 2024 03:35:09 +0530
Message-ID: <CADg8p970OvCpHnXaL2iMKN+uDBom-gZ5DQcq3GshFYf-VvZDJw@mail.gmail.com>
Subject: Re: [REGRESSION] Out of memory error: unable to boot on imx8mp/imx8mm
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
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

On Tue, 17 Dec 2024 at 01:10, Francesco Dolcini <francesco@dolcini.it> wrot=
e:
>
> On Mon, Dec 16, 2024 at 09:35:58PM +0200, Ilias Apalodimas wrote:
> > On Mon, 16 Dec 2024 at 21:32, Sughosh Ganu <sughosh.ganu@linaro.org> wr=
ote:
> > >
> > > On Tue, 17 Dec 2024 at 00:59, Francesco Dolcini <francesco@dolcini.it=
> wrote:
> > > >
> > > > On Tue, Dec 17, 2024 at 12:37:38AM +0530, Sughosh Ganu wrote:
> > > > > On Tue, 17 Dec 2024 at 00:33, Francesco Dolcini <francesco@dolcin=
i.it> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > On Mon, Dec 16, 2024 at 11:28:42AM -0300, Jo=C3=A3o Paulo Gon=
=C3=A7alves wrote:
> > > > > > > Hi Sughosh,
> > > > > > >
> > > > > > > > Can you show the output of bdinfo. And also print the value=
 of ram_top
> > > > > > > > while booting the board.
> > > > > > > >
> > > > > > >
> > > > > > > Below are ram_top and bdinfo:
> > > > > >
> > > > > > We briefly discussed this off list, what is likely happen is th=
at our
> > > > > > heap is after 0xFFFFFFFF, or said in a simpler way in the 64-bi=
t address
> > > > > > space, while ram top is at the 4GB boundary.
> > > > > >
> > > > > > The solution seems to either move the heap down or move ram top=
 up.
> > > > >
> > > > > I am not sure I understand. Isn't the heap memory part of the U-B=
oot
> > > > > image, meaning it will always be below the ram_top? How do you ha=
ve
> > > > > this configuration where the heap is above ram_top? Can you point=
 me
> > > > > to the code where the heap is getting set above ram_top.
> > > >
> > > > I just guessed this, I might be plain wrong. I assume some malloc i=
s failing,
> > > > maybe Joao can confirm.
> > >
> > > Ah okay. If it is some efi allocation that is failing, then the
> > > allocation is not being done from heap. One thing that can be tried i=
s
> > > to have ram_top at 0x1_0000_0000 instead of 0xFFFF_FFFF.
> >
> > It was an EFI allocation that was failing by looking at the logs
>
> and initr_mmc.
>
> But yes, you are right, it happens during memory allocation using lmb. So=
 what
> I wrote is just wrong (sorry!).

Okay. Please try changing the value of ram_top to 0x1_0000_0000
instead of 0xFFFF_FFFF. That should work.

-sughosh

>
> Francesco
>
