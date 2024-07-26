Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB77C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 14:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 344C0884C5;
	Fri, 26 Jul 2024 16:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O4QiPSsR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60A78884C5; Fri, 26 Jul 2024 16:33:29 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BAE988585
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 16:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3db1cd07753so407471b6e.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722004406; x=1722609206; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rHnBpCbsoIEHhhWqz1P6k2CMu7ue/l6FxJxX01FcsMc=;
 b=O4QiPSsRSfVbqC3rzlldGzCD5HAirTHgyhsE/FmaM80jo5/Vo3zKTpN3b8LAeRjyTB
 9zTtqpyu/wGwmWZ1f7YYgXXfRyYRJZka+24QCF9j/BixueCi/b+DcN6DjWzoELwiSCxo
 SXkZ0B88Ohq6OSYWcqskwV61wHtV5VZDkUWiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722004406; x=1722609206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHnBpCbsoIEHhhWqz1P6k2CMu7ue/l6FxJxX01FcsMc=;
 b=j0Ce9cIYoEseNeeMDOBNcoFYiC0BZSCS5pv5A1Wn/odxDtSSkWB/5RGggHhDvRT7I6
 /b3WBXrWL8DJjt8GbkJpzCBqlaHCx/biXkVaQMRqtDmWycxVi1cLUYSuBm9u8BQzQOU1
 7Kv476meTRyTAgiPsT8RznweWCkP9rUgIo2F20vaJRHq0JLGTIS/4HI6rps1lkkdBmsd
 YoBYOQbEkP/uKuNFXn2eSdAY7YFnxCAGwXF5VEROJuMOmixDPUWi+hM0+a/vqs+aZIrH
 Uaql7gTHVbqO6VS9oXnm0grG6KlRxjjj5uwyId2MqDmk+769cZJJxMfLbGlpts2RIPt1
 aIBg==
X-Gm-Message-State: AOJu0YwFCLJMjRWfh49hNSBbW4pvq7bIcMcMoQPqOKmaKDncRHLeOz8X
 rYS474bSo94UMxI6kXQHI5cms7VR9gjS5I9jK6lCEOSnMRXig8QjJ0tHuWLuuxU=
X-Google-Smtp-Source: AGHT+IF/xpaaI09sPEm3MiyzPYDyT3vgrs8pi72VlVQWROibV6gBwfvSFCbwAPkv5kYrOI1vPy66XQ==
X-Received: by 2002:a05:6808:1a1d:b0:3da:a032:24ca with SMTP id
 5614622812f47-3db10f320aamr7108027b6e.37.1722004405914; 
 Fri, 26 Jul 2024 07:33:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db1341ebbasm711530b6e.20.2024.07.26.07.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 07:33:25 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:33:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Anand Moon <linux.amoon@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v4 3/4] alist: Add support for an allocated pointer list
Message-ID: <20240726143320.GJ989285@bill-the-cat>
References: <20240726140038.194946-1-sjg@chromium.org>
 <20240726140038.194946-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tBJttr2V3c+tG3ES"
Content-Disposition: inline
In-Reply-To: <20240726140038.194946-4-sjg@chromium.org>
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


--tBJttr2V3c+tG3ES
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 08:00:37AM -0600, Simon Glass wrote:
> In various places it is useful to have an array of structures, but allow
> it to grow. In some cases we work around it by setting maximum number of
> entries, using a Kconfig option. In other places we use a linked list,
> which does not provide for random access and can complicate the code.
>=20
> Introduce a new data structure, which is a variable-sized list of structs
> each of the same, pre-set size. It provides O(1) access and is reasonably
> efficient at expanding linearly, since it doubles in size when it runs out
> of space.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v4:
> - Avoid using realloc() unless specifically enabled by Kconfig

Is this really so performance critical that we can't always just use
malloc/free here?

--=20
Tom

--tBJttr2V3c+tG3ES
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmajs6wACgkQFHw5/5Y0
tyxBrAv/T64s3wWor/2vd1gcDifi59M75sHBcq9TwZrdeL/BthiCyPgvZwsP7R/8
1DaD6dXpGpxK0IlTc1Z54z079ql7oXKq0AdHbf2e344xBkmZgHp/nIaCffqx+SWz
MyLPX8P7LGyDOpuclAK5ONwhw9jN761fril/QkxNuRXhAFilXfUk1iJZXLuKm7fr
20R6MaAvbPdCROXqG6thIQUBwHmyoGgDSEcXV03ygr2dB3SYiVfhvQ04P1Mn3PeP
AGU4vGjdCZYxIKKAnun+x6/vWgafYXFB4V2PEAbiNsYkeN6uSx65eA3tfXIssw3g
nJFDsMKZUIdvcT8FR0vn42WmXR2EwWgaGz59uoOQChXHuNpCX0M3RN4H89lVs/vs
EQRifvt3dlx6Xgr8oZ+Nnps4GH9WVCXkO9VwTmF0xi3COF9gO1lpsI9fHp66cyxz
eJ0otKUCGQYQh6PesdcpcotSMtU7CGStI8GaB7976xmnAzOr3M/BYRxpoLfU4TeX
ydu2j7hP
=q10I
-----END PGP SIGNATURE-----

--tBJttr2V3c+tG3ES--
