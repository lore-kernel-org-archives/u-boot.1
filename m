Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E82C27C77
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5128588852;
	Wed, 12 Jun 2024 18:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TJ7v7xfC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E24128884B; Wed, 12 Jun 2024 18:01:10 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C90D88881B
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6f9c1902459so1962629a34.0
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718208067; x=1718812867; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Chm4fz7mFdcbsV9DFvdgNrWkANxJ3bphKZ8dh+f+bJs=;
 b=TJ7v7xfCoVQXXeFGtnYNu8S0ZMTPpKErJk3SJIWvKm+IO4szYR6zD9Y44UWdvT9XUC
 chjpDqiH71Oqlo3Rn1FItabtLKTPxp9ySK6ANcNp8olWCgpAr/G+Hd99hkkwM1rOVE1U
 F149MvDp2PXkMtcgzvgKhftu0YWKzE9yvEQg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718208067; x=1718812867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Chm4fz7mFdcbsV9DFvdgNrWkANxJ3bphKZ8dh+f+bJs=;
 b=SxcBCrGRiPMYRECRha//G7ogUbSoPYWeMGdIysWKZDfKI7NKSewrLWb1LJ/lO/Gt3d
 H2eE28U8etTsFU/o64S3VOQitOgrZcetAmHbfUReOy/LntcFILkGLmiGbYtgVcgDy5iA
 r2medlp8WZ22tBjL9HdR53mOVYbNVXXp2Vk6N4VuK4pDn10UK9rjj/wNtDabJdHhcVhO
 Jd/rqtoHf9TeUfMzTtTULKWRD2wgjcokj0vNZRska/a9pBrBofknLBPHruaHa7Eo4kU5
 CReg78bNoExfRG+6S3UsqzWwOxRxZIkKjW0xVnhiR5aVfwsRovq3CPLFjnECtztpAXEl
 8DzQ==
X-Gm-Message-State: AOJu0YwvZJn1W5pog2xSKY9jGb8ZF5GS++/fiwVUUE1dgoMg0W7mECz1
 TkyBpdjicJLBN3b3eiVzUx9jqnDTJcSqS+Mtd+y7fMgdyA1hWQF8wzaboZbCERg=
X-Google-Smtp-Source: AGHT+IGo9itYTk3tM/pEfBT7rgZhSZqiQdztkA7ePIFo/k93kxQXiuDbI6d2sOR8Mg/PyewFpvqjjQ==
X-Received: by 2002:a9d:5e86:0:b0:6f9:8b51:c697 with SMTP id
 46e09a7af769-6fa1c0a6030mr2370712a34.19.1718208067401; 
 Wed, 12 Jun 2024 09:01:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f95aaef6bdsm2068801a34.52.2024.06.12.09.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:01:07 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:01:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
Subject: Re: [PATCH 14/20] CI: GitLab: Split build_world tasks
Message-ID: <20240612160104.GU68077@bill-the-cat>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-14-51472eb70357@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GiFQU6BO37gPxB3u"
Content-Disposition: inline
In-Reply-To: <20240611-docker-image-v1-14-51472eb70357@flygoat.com>
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


--GiFQU6BO37gPxB3u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:04:13PM +0100, Jiaxun Yang wrote:

> Current build_world task runs for too long on public gitlab
> runner.
>=20
> Split the job as what we've done to azure pipeline.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .gitlab-ci.yml | 103 +++++++++++++++++++++++++++++++++------------------=
------
>  1 file changed, 59 insertions(+), 44 deletions(-)

I don't like this. The list in Azure is because of the time limits there
and in turn we:
a) Have to tweak it periodically to keep things from running too long
b) Have to tweak it to ensure that we don't miss some new SoC/etc

--=20
Tom

--GiFQU6BO37gPxB3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZpxkAACgkQFHw5/5Y0
tyxgagv+Nm+upI4FCMpGOc1TW4rDyRTHSDUBIlkgGvlLvRB4WlomJ7WsvAjQDkkx
5/LI00pnP20HhOdG7s8x+p603cwo65stWOKlTx1wIu9xbyrCeoVs+Fnd+YI7wu/z
DlTP70+XGwrIcnmGL4MwUYRTTpcuKKUiN1mPtlM4+UH5d0S5nxoZkHfOp6Ui3YvV
SrL0x9Ps9FH5qwGFn2NplU5llyGJ57aVHWF0Yxx66fxQVgCFtihGiTP3NAuyjyzX
j3m8PNghcuFM0NQK3ekOdP4MzflDm1I6v0rXMz9Idc0TaDg2kPEwsZntp9S5SdZx
YY6/tVUKCtHvRbmtNHsZuxiBqmI3DYK5PH+o2oLwc1X3/8qUgcWmTLXGY8FhntMQ
hWYeB+Pyb5MZs1eO4xgsGGCHjuJlRYPNjIKSTMrGvdQXc6c0aEvB4osrkaoY2SFz
HW8irqvT4a89k/PjUuo+hDvJhjHhG/gt85tNKTOFKB0kfk8DJK13Jy7VQNLfo8M2
krqFEHPP
=EYu/
-----END PGP SIGNATURE-----

--GiFQU6BO37gPxB3u--
