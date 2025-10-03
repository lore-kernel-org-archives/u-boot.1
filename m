Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C726CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 831F383870;
	Fri,  3 Oct 2025 22:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="peg1vHG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CDB78387E; Fri,  3 Oct 2025 22:17:25 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA908386F
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-887764c2868so253962139f.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759522642; x=1760127442; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KDUYwNj1SQQH4tKqBZOGGpr1iORCnhAskOVSuSXUVj4=;
 b=peg1vHG3CL/rXOFjiDunCYPR3YBGMexPhycXZR6vAxAE03OGqtg/yUSV4UlrOXBU6p
 3CkY3Vy6zfD1lrHzAXzsMhcUev0m8kSU3M7gS52eshmagjFyulUUHOjHRg7dgDXI14Rc
 k1LU7HNWPk8EEH48gjq7S8B8876NQf17lvJ0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759522642; x=1760127442;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDUYwNj1SQQH4tKqBZOGGpr1iORCnhAskOVSuSXUVj4=;
 b=nOwaRbbnqAH7bUWBLX8SNXevpeYwigfx32aNKHfELXELYjpsvwFwSGzgY9pJptd2IE
 CBWra6BWyduZ2/0N8xfRUFN60K4znMPpg3KTAFFwncGuyedqv6gNJTj5OoHEZHEZHrm4
 LZEiOGNroPClNjuk/gf4iuswHpROrW3t5buFjTdRmuz5panQpv/OAyPRbkF0sQcAEAm6
 LZn4ToI7YpR6QClXhl3t5gAdNY7Vg0yjlll0mlgJisdsPITunExB9ErNSWBV2/LtCmhX
 GxFs9E666515vSq0omsWj1kbnlgGz6n91Q1uPMAU/3Hhmz/7/j0y6Xai8z1zftm9HzoF
 g65Q==
X-Gm-Message-State: AOJu0YxEpWGsQFKCpifPf2M63SXMrH4FwBEZpINjmvOyffIuj3b3q3Ml
 JOPVRRbzgJ11jFlCELCStkAsD5MAqP4cAqeBRnJDgBdEBtcDZB7uPqbLRANAY+i7yQ8=
X-Gm-Gg: ASbGncvuFlZi7OwTKwcvOQBZgiL+DFnfD8Q9GlngV8ArTDY43j1Y3FiLLwDArzJBh95
 urlI8mU/UgPIT2LHBYmIRXik8sOJrUAgIbidtACvJ0qW4tAsaKKpMqjuTZ+zidwpiQlEvwvPnr+
 6MHxkcyoSDJMc9Cjr7MngCxLG89TKlZw7JItftMW+EWtWvcam1a+wCRscrzd7ry+guZaKFkptRu
 /GOqta2k4W5ZRZs4s7l6s0S0XdRJ3jYb2Ut8P7kf1dy/Y0cB2/mHyJA9URmTzVJOd1EgLbN6IuI
 qCpppfY3KJba0jLeCdULFfX+1PIK5j9O3fiYMmuQecAncFAfsk2pMT+7bfYXJ8xn7SziUPksj1n
 rzwwu2NWSeO+vCzePUiJuTzNdC9o2LG81SXYwlzED4er/KSj307kUTjFsxbMZGRGswM9aW0T9Qc
 dH5kd1bbCXtQ==
X-Google-Smtp-Source: AGHT+IGEhUJOOoZcD7KJBidp3IEDk4C/hMBnkp7T9z0bVcubaggAgvHuRu+uayO4DWsjGUk9JlqaSg==
X-Received: by 2002:a05:6e02:216e:b0:424:30f:8e7c with SMTP id
 e9e14a558f8ab-42e7ad28804mr67400475ab.10.1759522641818; 
 Fri, 03 Oct 2025 13:17:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ebc8400sm2228374173.42.2025.10.03.13.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:17:21 -0700 (PDT)
Date: Fri, 3 Oct 2025 14:17:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v2 1/5] docker: add OP-TEE and TF-A build for testing
 Firmware Handoff
Message-ID: <20251003201718.GT6093@bill-the-cat>
References: <20251003192222.767882-1-raymond.mao@linaro.org>
 <20251003192222.767882-2-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5sqdDFdpAss7LQu4"
Content-Disposition: inline
In-Reply-To: <20251003192222.767882-2-raymond.mao@linaro.org>
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


--5sqdDFdpAss7LQu4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 12:22:15PM -0700, Raymond Mao wrote:

> Fetch OP-TEE (4.7.0), TF-A (v2.13.0), MbedTLS (v3.6) and build
> bl1 and fip with both Firmware Handoff and Measured Boot enabled.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in V2:
> - Move OP-TEE dependencies into the common group.
> - Fetch MbedTLS/TF-A and build bl1/fip in dockerfile instead of
>   post-buildman script.
> - Remove Trust Boot related build options.
>=20
>  tools/docker/Dockerfile | 74 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 71 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 5b4c75f8400..0a213a7a61e 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -58,6 +58,9 @@ RUN if [ "$TARGETPLATFORM" =3D "linux/amd64" ]; then \
>  RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt,sharing=3Dlocked \
>      --mount=3Dtype=3Dcache,target=3D/var/lib/apt,sharing=3Dlocked \
>      apt-get update && apt-get install -y \
> +	adb \
> +	acpica-tools \
> +	autoconf \
>  	automake \
>  	autopoint \
>  	bc \
> @@ -65,21 +68,26 @@ RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt,sh=
aring=3Dlocked \
>  	bison \
>  	build-essential \
>  	byacc \
> +	ccache \
>  	cgpt \
>  	clang-18 \
>  	coreutils \
>  	cpio \
> +	cscope \
>  	curl \
>  	device-tree-compiler \
>  	dosfstools \
>  	e2fsprogs \
> +	e2tools \
>  	efitools \
>  	erofs-utils \
>  	exfatprogs \
>  	expect \
>  	fakeroot \
> +	fastboot \
>  	fdisk \
>  	flex \
> +	ftp-upload \
>  	gawk \
>  	gdisk \
>  	gettext \
> @@ -92,11 +100,20 @@ RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt,s=
haring=3Dlocked \
>  	imagemagick \
>  	inetutils-telnet \
>  	iputils-ping \
> +	libattr1-dev \
> +	libcap-ng-dev \
>  	libconfuse-dev \
> +	libfdt-dev \
> +	libftdi-dev \
>  	libgit2-dev \
>  	libjson-glib-dev \
> +	libglib2.0-dev \
> +	libgmp3-dev \
>  	libgnutls28-dev \
>  	libgnutls30 \
> +	libhidapi-dev \
> +	libmpc-dev \
> +	libncurses5-dev \
>  	libpixman-1-dev \
>  	libpython3-dev \
>  	libsdl1.2-dev \
> @@ -110,9 +127,11 @@ RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt,s=
haring=3Dlocked \
>  	lz4 \
>  	lzma-alone \
>  	lzop \
> +	make \
>  	mount \
>  	mtd-utils \
>  	mtools \
> +	netcat \
>  	net-tools \
>  	ninja-build \
>  	openssl \
> @@ -122,12 +141,16 @@ RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt,=
sharing=3Dlocked \
>  	python-is-python3 \
>  	python2.7 \
>  	python3 \
> +	python3-cryptography \
>  	python3-dev \
>  	python3-pip \
> +	python3-pyelftools \
> +	python3-serial \
>  	python3-sphinx \
>  	python3-tomli \
>  	python3-venv \
>  	rpm2cpio \
> +	rsync \
>  	sbsigntool \
>  	socat \
>  	softhsm2 \
> @@ -136,13 +159,20 @@ RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt,=
sharing=3Dlocked \
>  	sudo \
>  	swig \
>  	texinfo \
> +	unzip \
>  	util-linux \
>  	uuid-dev \
>  	vboot-kernel-utils \
>  	vboot-utils \
> +	wget \
> +	xdg-utils \
>  	xilinx-bootgen \
> +	xsltproc \
> +	xterm \
>  	xxd \
> -	zip
> +	xz-utils \
> +	zip \
> +	zlib1g-dev

Are some of these deps perhaps optional? I would hope we could build
without cscope and xterm, to pick randomly from the top and bottom of
the list. I ask since everything we add here makes the container larger,
and it's already very big. I'm almost wondering if we should (follow-up,
later) add a step where we remove things that tools we built needed, but
U-Boot doesn't need for build/tests.

--=20
Tom

--5sqdDFdpAss7LQu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOAvTgAKCRAr4qD1Cr/k
CjM6AQD29TMLKXkWWAztPb2sMwE87j8MDVRGutY6HJMtz4FlrgEAlHm/dzsEcftv
BsH2CzTSWl46z7AyIn5pR8d6DjZqggk=
=+ydD
-----END PGP SIGNATURE-----

--5sqdDFdpAss7LQu4--
