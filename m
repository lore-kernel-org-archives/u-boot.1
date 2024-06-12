Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A46C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB75788842;
	Wed, 12 Jun 2024 18:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a8Q1WLPz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73BBE88846; Wed, 12 Jun 2024 18:50:54 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B9E88395
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5b96a781b63so43277eaf.1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718211051; x=1718815851; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7L0iq/GBuhTC2DdxQ9BTnewBp3Mq4cnT8eK+7jN9RRs=;
 b=a8Q1WLPzWjaoZuxoIAhneBVUO4BV463uXTTRFRf7u3zLCxVHJhfk2X5vCLehAvx08s
 p1zlPkVa3RNatwy8Dcy6VDPKnkGqh4+UO2Uhuxo5u1bSmwesjxls7N0PQqS7a2YC7etN
 kZSG6mWLW8ixumn5vOkB5V6Rql7O62NU4C2Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718211051; x=1718815851;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7L0iq/GBuhTC2DdxQ9BTnewBp3Mq4cnT8eK+7jN9RRs=;
 b=mMPaLi8vaQ2NQF4J7AzS9UB9eZiQkMFZHTtP957r3EKiZzYcr7BsIZhqWkYWCvIK77
 UsUry3WRGdJ4MYnR8GCfftXqu4Kuzw+Vuk1rtYRnuCuD5nuXy3YFjW4Se2cPFpkOVLX7
 v/FS7oXSvxiUgnq7j+fXISwuczbRzonm//FODSziWtXLTZmNHgtroz4x95nYO5Bissmr
 nv+C/7zXpvSRsnsFbnTcLWMPqaPcIPMV3yTULJQCa2KW7twTaO8jHNnGoO5ml0Lo8/hX
 +gytv3eYDCSQ0yaPYD/LsuQbE7XCQ9cw0NBviUKUT3yl8Agem2fMBredxwJvKjfK38vl
 iXHQ==
X-Gm-Message-State: AOJu0YyQfDMsJiSeRaehFZbZ8/1G77bEBCp2VNH48M7iGxHpG1f0IUxH
 nKhMlmaK/DBEE0yKBeQpRzRy1U+FJz50pzaMK6IuTrvDlUY9v/GD24NGfM3VGHg=
X-Google-Smtp-Source: AGHT+IGOFQQq6kTBFPblHIFptSX+brEWR2/W/DL9AAstv+kUcgyGhvfDSnzpNh6qWtPSlzRrGmWIMQ==
X-Received: by 2002:a05:6820:220a:b0:5ba:195:ba72 with SMTP id
 006d021491bc7-5bb3b950b7amr2892299eaf.2.1718211050652; 
 Wed, 12 Jun 2024 09:50:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bae06f9a3fsm1440000eaf.1.2024.06.12.09.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:50:50 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:50:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
Subject: Re: [PATCH 12/20] cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000
Message-ID: <20240612165048.GD68077@bill-the-cat>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-12-51472eb70357@flygoat.com>
 <20240612160053.GS68077@bill-the-cat>
 <49522625-8663-4102-82aa-cabc0f239afa@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EMMAKqMKs07EaCx/"
Content-Disposition: inline
In-Reply-To: <49522625-8663-4102-82aa-cabc0f239afa@app.fastmail.com>
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


--EMMAKqMKs07EaCx/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 05:13:37PM +0100, Jiaxun Yang wrote:
>=20
>=20
> =E5=9C=A82024=E5=B9=B46=E6=9C=8812=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=
=E5=8D=885:00=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> [...]
> >>  configs/octeon_nic23_defconfig | 1 -
> >>  2 files changed, 1 insertion(+), 2 deletions(-)
> >
> > This seems similar to:
> > https://patchwork.ozlabs.org/project/uboot/patch/20240524210817.1953298=
-1-rasmus.villemoes@prevas.dk/
> >
> > at least for CI. And for outside CI, I'm OK with just having the value
> > be changed in the defconfig as needed. We do support using config
> > fragments, so keeping such changes locally isn't too hard.
>=20
> So the default value is a little bit too hard even for some of the actual
> hardware.

Right, there's some platforms where it's too small and we should just
bump it up. I think for now the default is what we want it to be for
most platforms.

--=20
Tom

--EMMAKqMKs07EaCx/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZp0egACgkQFHw5/5Y0
tywdlgv/f5lL9BSh639/PjQRLxc2a9lvm8KYdf2/4Z6x0tztOrWvoFy0F3yIuFHb
KjsrXt1Zv1VBVjG8oy2PYO1M9/FqJXQb+h9LuRTpelf1u4MtGfYKc7X8+XySmkZH
3eRS8THQZ3SO5+aleNszNDRwfRg2gzf5knelAIQPYYcv92LmPGXu5aCUZeuIDrXN
hajoJHg94cpusfWBwGH/QjMu2fcMBdzEGlA5F3/2EwB6fGaO4o/TW9ZG23BLqxwx
YugqxgZL7J0CI+gr7ODg6devWJQIInKW/41altOtyZvFBFt6aprw1D4olYKx+N9x
mDOSn+Zn+4+KvS22ERLLZKqUXLl781qVWWQueMefbbWAu4wcylBLdr760/5jXR6k
8bIIaGNgMx+o6SIjDF3W8ACjDPByN3hF9uqZ7GkCGFIPrmFtDV/6krl2uN4tDlKg
S/CkRT8DJPMJrZjAPTSR8JXzvg/McBJyf5TXXO/SwGLpaJBOyDQa5la8R0bYrRKl
FTgtR8jR
=hCDu
-----END PGP SIGNATURE-----

--EMMAKqMKs07EaCx/--
