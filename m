Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F0BCDB483
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 15:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D9B786E64;
	Tue, 17 Oct 2023 17:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DFqjBEVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ECCD86E64; Tue, 17 Oct 2023 17:50:10 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A2686EE2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 17:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7af52ee31so70820377b3.2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697557805; x=1698162605; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kX2jPZZnq6l60jF9sCjRFc62Wz9RazcDUbjGlrx/Jek=;
 b=DFqjBEVqvTjO7vZbVSNk0SATUC8jVIcei9nc1susZcdaZWF3/O+2Y2qp+/mCmaVWJP
 VEvAf5BU1DG0Prxi4o/M7ioc/95E5MUeSe4FpxXXDIjjIFXHIHmpmlsdkPa+9TN2h/49
 H4kUMDqN4QtLnLACMOI7cfZHClsVF+msffpR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697557805; x=1698162605;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kX2jPZZnq6l60jF9sCjRFc62Wz9RazcDUbjGlrx/Jek=;
 b=NMgtZ/Dm0ihtQgJ5PbGHOe9wR8tXWt6gUSyphHnSGJuiJqKlASgiiVUcMmvhVoEZWu
 JJ1+mQ7p8RmneYegQCbeYoeG8G6Kr8DnfKBeIHUag61m/4Ojomi6RUh0yGy2FwgpVTKV
 B71VLBSN4d0T7r/Hxi0JTZxbF4bQZzmNZ/GNqHj+tDPzFSIK/RE87UvMMs+o4lzANW/A
 30KQYPxBEKv/bcqGwwFFyXXw0Jmw5nKAWULWSOovjpteUrX7GpdyetHVeZh6UjSR21KW
 QYvFCMsbeFHCIeUpaufJmjFyjm3sLTymnaG1TmxQxA/wOc+3T5FoG8lv6j5rJjmyBkJy
 0Mlg==
X-Gm-Message-State: AOJu0YyCcn2PpoIVmc9c0RucaKQOIwjfueHLVI4y3yUg3MzJLJ18puQI
 wogpDoeiXNaQ5DNqUw9/FV16Ig==
X-Google-Smtp-Source: AGHT+IEiqyaxul9P1YLsM2hBCmLMPOmEple9FLSdle6SIMUjpgHNUhbSOoTEL2K7fgkJ8CYpfh1tIQ==
X-Received: by 2002:a0d:d4ce:0:b0:5a7:ba54:aef5 with SMTP id
 w197-20020a0dd4ce000000b005a7ba54aef5mr2804394ywd.21.1697557804803; 
 Tue, 17 Oct 2023 08:50:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 q4-20020a0de704000000b005a4d922cf77sm707653ywe.119.2023.10.17.08.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 08:50:04 -0700 (PDT)
Date: Tue, 17 Oct 2023 11:50:02 -0400
From: Tom Rini <trini@konsulko.com>
To: Wojciech =?utf-8?B?Tml6acWEc2tp?= <niziak@spox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: env: Allow U-Boot scripts to be placed in a .env file
Message-ID: <20231017155002.GK3119521@bill-the-cat>
References: <6591c92d-6ea7-4434-89bb-d64f0ac68068@spox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zY7W7UT6zzmr8mxV"
Content-Disposition: inline
In-Reply-To: <6591c92d-6ea7-4434-89bb-d64f0ac68068@spox.org>
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


--zY7W7UT6zzmr8mxV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 10:14:13AM +0200, Wojciech Nizi=C5=84ski wrote:
> Hello.
>=20
> Very nice feature was introduced in commit:
>=20
> =C2=A0=C2=A0=C2=A0 86b9c3e4e48ba47ef28781d06b97846aca74bc8e|
> =C2=A0=C2=A0=C2=A0 env: Allow U-Boot scripts to be placed in a .env file
>=20
> This feature works as extension for old CFG_EXTRA_ENV_SETTINGS and make me
> confused why it doesn't work for configured default env file.
>=20
> Now in U-Boot config we have two features related to external environment
> file:
>=20
> 1st feature (introduced by mentioned commit):
>=20
> =C2=A0=C2=A0=C2=A0 CONFIG_ENV_SOURCE_FILE "Environment file to use"
>=20
> 2nd feature
>=20
> =C2=A0=C2=A0=C2=A0 CONFIG_USE_DEFAULT_ENV_FILE "Create default environmen=
t from file"
>=20
> =C2=A0=C2=A0=C2=A0 CONFIG_DEFAULT_ENV_FILE "Path to default environment f=
ile"
>=20
> In 1st feature only basename of .env file can be specified. So env file c=
an
> be located only in board dir which is a limitation for this nice feature:
>=20
> =C2=A0=C2=A0=C2=A0 "The file must be in the board directory and have a .e=
nv extension, so
> =C2=A0=C2=A0=C2=A0 the resulting filename is typically
> board/<vendor>/<board>/<CONFIG_ENV_SOURCE_FILE>.env"
>=20
> In 2nd feature I can specify default env file as full path so it can be
> located everywhere - even outside U-Boot source - which is very nice when
> U-Boot is built by Buildroot. I can easily set path as system environment
> variable and it works:
>=20
> =C2=A0=C2=A0=C2=A0 CONFIG_USE_DEFAULT_ENV_FILE=3Dy
> CONFIG_DEFAULT_ENV_FILE=3D"$(BR2_EXTERNAL_FOO_PATH)/board/foo/u-boot.env"
>=20
> Unfortunately I cannot do the same for 1st feature without patching U-Boot
> sources to put my custom env file into board dir.
>=20
> I can see two way of improving features:
> =C2=A01st: to extend 1st feature with ability to specify full patch to en=
v file,
> or
> =C2=A02nd one: run the same parsing mechanism also for 2nd feature (defau=
lt env
> file).

Your analysis of how things work is correct.  The intention is that, as
you noted, is that the plain text environment and CONFIG_ENV_SOURCE_FILE
replace the older default environment found in include/env_default.h and
often augmented by the board.h file via (formerly CONFIG now CFG)
EXTRA_ENV_SETTINGS and CONFIG_USE_DEFAULT_ENV_FILE to be the complete
replacement of the environment option.  So I think the next reasonable
step would be to be able to have plain text environment style files work
for CONFIG_USE_DEFAULT_ENV_FILE which I think you're saying doesn't
today.  But I think that yes, a patch to parse the new-style plain text
files for CONFIG_USE_DEFAULT_ENV_FILE would be good, and I suspect
buildroot has enough users of that feature that any corner cases with
trying to parse older files could be caught and fixed?

--=20
Tom

--zY7W7UT6zzmr8mxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUurSEACgkQFHw5/5Y0
tyxRpgv/Tj92sqi3DnSpDKGzyt0FkTv1jVgoX9qhYR38ULuVMN5UzxWkrPZ10uqN
VbZVAfIRlWpgDQqF/o/QbJoIUf1GciKEH2Z2ltLv18z1wFp1xFb/9QmDvOWg+L96
BtYs5MnX/GBEen/75QZ0xajr01DuI43htM4TA5p5ckQzIe1hgY6vvPthUVZcjNd/
Z6sHFJIVxS4LytKaVRFNVQqUHWjPUldx2dXZpNJToiiFO01ghM5NcqNHOV2gTuMY
V7EtuYUcZpf1Ixml4Qe2VXSpPQ3zdks3xntLUEU4qEotgXoh5l/27JmX4V8XIyQI
r5NONbea28xcI/MxXUQnOCbVHwqjKWNjcI28BnBcGwpHxF7JhNZL6QRS06jUcPPz
LYmH5yulvRd8RwtE1fYSf/xSNKWX6UqEwG6JiiTooLQpia6KH058pWzgNRRsZqbd
JzoVB6OhC4wEo5pEBDf+bABF7yNF+9cQ/byezz3w36uB435pYgGgPfD0YWTEgK82
3wDjh5LV
=DT7E
-----END PGP SIGNATURE-----

--zY7W7UT6zzmr8mxV--
