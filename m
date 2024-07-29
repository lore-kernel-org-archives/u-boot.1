Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3EEC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 18:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D79688837;
	Mon, 29 Jul 2024 20:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CF12+jbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 114D088842; Mon, 29 Jul 2024 20:17:00 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D10F388804
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 20:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-260f81f7fb5so2404030fac.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722277016; x=1722881816; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L2ivlkoMIMqzPPxAuLVGU14zKvHhaIMPWmf+ewIoUAA=;
 b=CF12+jbEAIO33qDGQHa5C+d4Tc8GKMFZ0qJVuDkzp1iv4MIND5FsDEVD6jm1SG7O+9
 UeYXOByeOlAplCSaP3p9wTEe3eaI47WvXIg0BjTHYrTzpWcho37nXS77RryXGpLMjtJI
 2mdaOZSz2j9KDsA0Dlq9xIm14yrF0NO8IN9EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722277016; x=1722881816;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2ivlkoMIMqzPPxAuLVGU14zKvHhaIMPWmf+ewIoUAA=;
 b=IupR7luU3La0+dEdMUQbnqi+417uvmA4MfVsRWhE+Yj8LxtRM8QpeqZlJHSkpF+Few
 GQu7ctUPUUo1RXxzyYoDFg2pUlk5ziz1XrAPKdxRn3nCUbmrgKhJvZKwQWCpaznyUSna
 jB4tmyvtGpO4IkYRzlIKe6IP5/ceaTOr/3CefLo69uLT3BTWATYpvRpRB57J1QBas7m2
 owspqTHuv9zZvN080bP3BTzGAf45eVvXQPL6Z0AanHpe8BAQLZEyeM8AXUOznQanOAzS
 PHEzcNzytFqFcZtDxt5lp6Zu9T8DgEd53aR00ucI6hddNtdF9mThnycm8CevTpkVbKok
 XAwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwQZmMZ1DAXuUiGRMn3r/dyxgDybx1ctB8Ix4b3CAL/fEgpaWV9jItmYxWFDZT4U2HFKCpMV3ndtEXDRdu3irDYawFHg==
X-Gm-Message-State: AOJu0YzMj4gU/TLDGKBjOayq7bDedmSH3tJTdVP1kwAd5sc3njDQTWFV
 ma6Su4O6l+xscui9F6ftPWaqSTOfnocEH310SRjireuKaQaBItHvwaaKw95EylI=
X-Google-Smtp-Source: AGHT+IHrU8aidfXTbryB36GjvznbnXozIjI+7e5V8S+jx6AYBguU8oDnlRKCpyfr0zSZbVMTtQvZUg==
X-Received: by 2002:a05:6870:15c4:b0:261:2072:7b5d with SMTP id
 586e51a60fabf-267d4d951f2mr11489736fac.29.1722277016462; 
 Mon, 29 Jul 2024 11:16:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7094fb00b87sm571765a34.65.2024.07.29.11.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 11:16:55 -0700 (PDT)
Date: Mon, 29 Jul 2024 12:16:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
Message-ID: <20240729181651.GN989285@bill-the-cat>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
 <CADg8p95EwPkVH4Lo2+9O8QeSrE90xLpUQXYEngK+YEr+YiJ=qA@mail.gmail.com>
 <CADg8p95cc=d31LWXzThVY8L=iV_Cg4dnOpQVy81obZM-ejJzQA@mail.gmail.com>
 <CAFLszThHu8xoF4AB0xdSWQzy9JC1ePkpGGg05+4zhbB85qtRkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ljk9V+ywivU+q6XS"
Content-Disposition: inline
In-Reply-To: <CAFLszThHu8xoF4AB0xdSWQzy9JC1ePkpGGg05+4zhbB85qtRkQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--Ljk9V+ywivU+q6XS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 09:28:57AM -0600, Simon Glass wrote:
> Hi Sughosh,
>=20
> On Sun, 28 Jul 2024 at 12:07, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> > On Thu, 25 Jul 2024 at 18:24, Sughosh Ganu <sughosh.ganu@linaro.org> wr=
ote:
> > >
> > > On Thu, 25 Jul 2024 at 02:24, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
> > > >
> > > > > From: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > Use this new data structure in the utility function.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > >  lib/strto.c | 35 +++++++++++++++++++----------------
> > > > >  1 file changed, 19 insertions(+), 16 deletions(-)
> > > >
> > > > This is rather big growth when we didn't already have realloc:
> > > > 05: lib: Convert str_to_list() to use alist
> > > >    aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
> > > >             xilinx_versal_mini_emmc0: all +1765 rodata +37 text +17=
28
> > > >                u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
> > > >                  function                                   old    =
 new   delta
> > > >                  realloc                                      -    =
1120   +1120
> > > >                  alist_ensure_ptr                             -    =
 140    +140
> > > >                  alist_expand_to                              -    =
 136    +136
> > > >                  alist_init                                   -    =
 108    +108
> > > >                  alist_uninit_move_ptr                        -    =
  76     +76
> > > >                  alist_add_ptr                                -    =
  72     +72
> > > >                  alist_uninit                                 -    =
  48     +48
> > > >                  str_to_list                                204    =
 232     +28
> > > >
> > >
> > > I am working on an implementation of lmb maps using lists. The list
> > > nodes are then allocated with calloc, which I believe is included in
> > > most of the board images. We can then compare the size impact with the
> > > two implementations (alist vs list). Thanks.
> >
> > I have worked on implementing the LMB maps using simple lists, and we
> > do get a good size benefit with the list based implementation. I have
> > used the script that was shared by Tom some time back to get the size
> > impact [1]. The readings are with 1) alists with realloc 2) alist with
> > malloc and 3) using linked list. These are on a RPI4 build, which has
> > LMB enabled. I have checked the impact on a xilinx_versal_mini config
> > as well, which does not have LMB enabled, and the size impact result
> > is best with lists. The list based changes can be checked on my github
> > [2].
>=20
> Thanks for doing that. It is quite hard to read with the LTO enabled.

I don't think LTO is enabled there?

--=20
Tom

--Ljk9V+ywivU+q6XS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAman3IwACgkQFHw5/5Y0
tywDUQv+KbsxqDgEtx28s+Li4XqnwzP/ANTw9VcNOP1e97OYXz8lp+kUG7VE9g+x
abjBNgjdrUwBEFP8K/CPqpAu6cY+oCRxEcsXesGFa9qOay3LBAZ57Qij3SUrwKsV
/4AfiX/uT0h3DluVoqQrff1e3PgEygyfzIwR91EBjWD1vAzf85QTzd3NSyRCfTBG
nF1uUgM50yVvMCg7fYSkyI2wCKLx24PsSbVJC2Li7vWw8tZMjPvUF2jAyfOwY9qR
2lXYEDpXfWCiqXUEhoWPnSGe7NJv/5rDgm394uc19TeT1sXONwU43xo/BlIuhPJd
HmnqFehi5vVtqGe8zruGe59PXdwQZrSaQThtIcms7m0d03XDCim27bnOzhPix0RY
QlapJAwnXeQMEak9CdgatBBnBHD5VodAOSGBT0LxoWa/ZjVL4ArzdF9X7PhhM5gN
e6n8sUpRiMHJBhwyZpo9g5DyLboPNIzAyavy+E3CVG8jFdhHwqrCRmENes2ULJRW
31eStpoe
=/hsu
-----END PGP SIGNATURE-----

--Ljk9V+ywivU+q6XS--
