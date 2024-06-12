Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E41DC27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBF018884A;
	Wed, 12 Jun 2024 18:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FMr7Dyxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0FF28884B; Wed, 12 Jun 2024 18:02:36 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73327883F5
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d226c5a157so2442445b6e.2
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718208153; x=1718812953; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qo8j1zPRr1EBQ+8HKczxEDtNHO/x/FlgnReXrAUwBlo=;
 b=FMr7DyxoCkE4nSMDQuYuZf1oKBZj4IsSgL8kMAgTxNPp/6tFtzTM1TXrm5Xo6sszwb
 2XHzfExnx7T3Aqvs+hXfgwq86QgyEg8DnEk7ii8PlTGY8acHVwi/uqysOWedKQHMUN1F
 7ySoL9c1F0R+7r1AUonEim64bim87VaILrCvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718208153; x=1718812953;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qo8j1zPRr1EBQ+8HKczxEDtNHO/x/FlgnReXrAUwBlo=;
 b=L0ESXAkrrG5XrAmyFNFVBbN9R7Xb+KAiPvwdowlaNTo0JFV0KXRiyfrj543wkBZw/+
 X6XFCjD5MsviOG6z1MqdZTl6/4xu9kc7HIxaktFXzKsD8OJCCbhbQHAdTnB0wkckoAet
 Iy72APx+ltPHjx4qTpk5+4NZhTO0PRqwewI2ZIVSlGDo29MBWtFq+VJYEXgJBW8jB645
 AkeEv6K1TH/VEyaCIetL+kSEC31hlkMMbIdOxrsObOG+WvXF2NQScydxliePUrVftu+A
 Ffna/P+b7bvd+hHc42oamiMB0WvfxPn+trP7MZJ191ttSDQTK65TuRglHOhO9UH7octz
 wEMQ==
X-Gm-Message-State: AOJu0YxgfFxajfE+OgyRvfYCePulHhLL/cBDw0ez/ggmU7zYc9Fn1qsR
 iVAOjPZ5ywKVrBA7J6ObQscQUj/KTRqy7UwHOiyG86venyVVk0cTqe1TVeS6JVY=
X-Google-Smtp-Source: AGHT+IE1r6hh9rDEha8bQ2Mmvh2mO3SiuIm5fITaa4QTSwev2eQ0Twi4de00gtLQoJ5rYnMknVvaFg==
X-Received: by 2002:a05:6808:1b09:b0:3d2:2877:513d with SMTP id
 5614622812f47-3d23e0cf5a4mr2275355b6e.39.1718208152958; 
 Wed, 12 Jun 2024 09:02:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d242affa88sm99435b6e.1.2024.06.12.09.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:02:32 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:02:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
Subject: Re: [PATCH 16/20] CI: Dockerfile: Bump various software version
Message-ID: <20240612160109.GV68077@bill-the-cat>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-16-51472eb70357@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G52XPkIqysZnJJGZ"
Content-Disposition: inline
In-Reply-To: <20240611-docker-image-v1-16-51472eb70357@flygoat.com>
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


--G52XPkIqysZnJJGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:04:15PM +0100, Jiaxun Yang wrote:

> Bump base OS to Ubuntu noble, grub to 2.12, QEMU to 9.0 (drop
> cherry-pick for m68k as it's already in 9.0) and other tools
> to latest version.
>=20
> Remove unsupported python2.
>=20
> Install some required python packages for buildman/binman.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  tools/docker/Dockerfile | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>=20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 5824d371f259..e3b2c2d57555 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -2,7 +2,7 @@
>  # This Dockerfile is used to build an image containing basic stuff to be=
 used
>  # to build U-Boot and run our test suites.
> =20
> -FROM ubuntu:jammy-20240227
> +FROM ubuntu:noble
>  MAINTAINER Tom Rini <trini@konsulko.com>
>  LABEL Description=3D" This image is for building U-Boot inside a contain=
er"
> =20

For reproducibility I keep us on date-tags and not just the raw
release tag/latest. Also, I'm not yet ready to move us past Jammy
without a big reason. Once 24.04.1 comes out, perhaps. So it's good to
know at least this wasn't too much work to move forward. Also, we should
keep the bumping of various tools to their own commit, each.

--=20
Tom

--G52XPkIqysZnJJGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZpxpYACgkQFHw5/5Y0
tywn8wv/RayG7iZ0QL4ePO81es77T/1JdlnG/tgYRv4lud1qnTp4ZUWAm426zgef
MCHAey2g2jPbiamtfC8E96LkWtmTh5uG17mdKLzBO16cEvmedyAXTj4xGCaq/voW
N/5R6D60xXeIhYU/EL4RwEyzUV2Ww9waCkBOlla61zKbNryXj8A2dcZfmSbp9d1D
2j2GYYQ0K42a+sMTyNiS8poxmDCoNgOVq60eO4mMunltqbRcxyIL1ZM2ecRIasgR
eQS+1LRGr2o/X2nI37WjpevnOhlqj4cHL27ZYgiyVQeLV4EDQW1PdEcGUDOuA77J
oZGaRgxUrY07OvxY+B+9TE2LMP1F5V20mlmu26nbRwkVIE49i//kfbq6nd/nY+f+
aWOzxkNKtk3fdNsG33p3DOPg29OSzV31puMJL+450OqE6i5OsEJhz8j6HocGJJsf
4nwRB1LEPdLfFbaB/PTPY+KGua6oyLRfjOR85vGZw1VPcGoOHe+QYMfBQuAUx22J
1LcAKMAv
=8ooh
-----END PGP SIGNATURE-----

--G52XPkIqysZnJJGZ--
