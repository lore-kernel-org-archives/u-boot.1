Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270ABC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 22:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85755820EB;
	Sat,  3 May 2025 00:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ovu79XuH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0223A81FAB; Sat,  3 May 2025 00:21:27 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 797D28210D
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 00:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2c2504fa876so893054fac.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746224483; x=1746829283; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cYRxZHjS9yzYP/bWeeSEEe8LkG+v31UWkEW8BDL7aiU=;
 b=ovu79XuHNGs52nbsqSuRc12hwGzRwoKBY8NrQwhLCxDPX4VET5K1xoAiu5REKs/1hm
 3oiBSBkH6U2/VeyE3vj3lQnjCCHplLrXPVy5P8V+hzVnBPgZl3y9oeY9e7XvgiqhdA8s
 kHLTBIaN8WQ4Pfpy1FGwl8eESInbhUh48dzco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746224483; x=1746829283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYRxZHjS9yzYP/bWeeSEEe8LkG+v31UWkEW8BDL7aiU=;
 b=jsjnm+A28ohprVygWLmnMpYo37rbDBnvmPT/Bn73bzpSVhcBG5PkbB4ImDRcq3eado
 sQWt4FhvgAjoKs4rxtZNelsgNmqg6i+UHbcYM2xo/pBhZUMWEJAfM9+Xy4XiAy+uFcyw
 /Iop+auHjtxfEr0r+H2/qGJIyeV/1l93eBJJDFZDZHiRSOs+EUJxJcEexfs0yDXKQtk2
 W165Rwb0qDs+5zlcAmpUmRTFi/xS90XpuAojxeVU+Aht4xSDk4xe83PSKNTKZfxbOOPV
 /zpx2AaZr79nvf3Mwn8fWE5YukM2jioDysuXAZX6+Y34dG22dAuDvrOKSPuLf+xE1tHw
 iZFg==
X-Gm-Message-State: AOJu0YzDTknzfQiBmIpNuOmh0FNR9nMxwk7UdVcXnMKwPJZ4GBLb0J0M
 bg09NITJT3XjXWsN3nQbzd0uXrmN7SZt49BZlVamrFVKfp/wJ8wyRIp1O09XUsw8pDeWg/IiHBZ
 S
X-Gm-Gg: ASbGncsO7po2CuxsfCE3KFJexa2aZlh+WBoA64ZCZAy6KgCK4I6AuqQ8j24eY6A74ii
 8dD68Fh2wp0+Nm0hPNsM8PwdkFzwahacma4mWhdWjVldbhTJQRtU2NNI0Pr9PWMcntYimBeBpnU
 rh4dSt4VOTZklXbBlkXeCsgWYc9in7syKuGtUQ0ZHVktDnAMKiPj5JcjePkvLDg0la/eydfy2M6
 4X6VJS3O7SYg5/KoK/gek8l7W0ysmwrdkjbcqVRElgWg20D2FBiIkPm6xzM6AXFhU0kNEExi1sR
 +swUuwgKIMXka1YdkRco+xlsyIbC+DoAvaMJHlLFMSUkfBkrXbbQZd6zjjIWGT4X9ZSr/6orvLC
 7Gw==
X-Google-Smtp-Source: AGHT+IHFNrr/femCnrRK1GE3W1nmpHUpYSogjeXWcWjcQnVkfhkE/icSbzHTlXbIkfdB2vZfY+aAkA==
X-Received: by 2002:a05:6870:8982:b0:2c2:2f08:5e5b with SMTP id
 586e51a60fabf-2dab2fe3b8fmr2291427fac.13.1746224483122; 
 Fri, 02 May 2025 15:21:23 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0ee1948sm818327fac.19.2025.05.02.15.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 15:21:22 -0700 (PDT)
Date: Fri, 2 May 2025 16:21:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20250502222120.GB1261075@bill-the-cat>
References: <CAFLszTjmTK3n=nqmBMp3_9gONZBm3VctKkqguq3Pb3K3or8Pnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ft5dYmwmxBK1+V+Z"
Content-Disposition: inline
In-Reply-To: <CAFLszTjmTK3n=nqmBMp3_9gONZBm3VctKkqguq3Pb3K3or8Pnw@mail.gmail.com>
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


--Ft5dYmwmxBK1+V+Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 03:40:32PM -0600, Simon Glass wrote:

> Hi Tom,
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/26056
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D77&view=
=3Dresults
>=20
>=20
> The following changes since commit 6cc812f8cc55c132458c7da5b9fb7666315cbe=
8c:
>=20
>   Merge patch series "video: Enhancements related to truetype and
> console" (2025-05-02 13:57:26 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-2may25
>=20
> for you to fetch changes up to d31d3a2949873b6217036650a449c1a1f74e6244:
>=20
>   patman: Drop the old status code (2025-05-02 14:54:39 -0600)
>=20
> ----------------------------------------------------------------
> patman improved to prepare for new features
>=20
> - Create a separate module for the 'send' function
> - Move to asyncio for patchwork comms
>=20
> ----------------------------------------------------------------
> Simon Glass (30):

You posted these three days ago, which is very quick for
non-security/regression fixes, and didn't post v2 where you rebased to
master and should have reworded:
https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/5a4f8a1f339ce4d=
e2eca812bc19cca1e2ad6b9ea
as the commit message and the change no longer match up.

And this is the same standard I hold everyone else to as well.

--=20
Tom

--Ft5dYmwmxBK1+V+Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgVRVgACgkQFHw5/5Y0
tywQswv+JQTsH0Pp4/M4Gjev+04pNLyKAox2XEbKX8z8eaEc91rFSRAVITI+UrB2
TKk6Velfk7Xo+bw+oT5d2Wex6hP+j4x2vb4WlSjb8/9itTEZNaNm5ywNS3zpzQC5
eilxmQZ4jAYOKGxI/5LBnTnW7eIPNXWccJ3WuyUpKUl5bEV+Jpwm03htv2pARE86
QdPeRCScPmcP6K+hkQ7NRXEJvkjGqV/oG/6G6visOtbVJ4nkBIY8Ie19U/51icCm
6MGEcS+6Lv3ZNFCgmNbu+DHa761MK/lmtLJEGiF4VT/uVZQWEePO/6qXRoM5JbC+
BUczDfxTmV1kFoOg+I7Kc6CFBG7hOiyA421PfFB0VVGcWBfZywR443XbLZxY2nB4
6MzJWwbbrsAum4/uIeqrpom9VZj8POavehDb7Ee4v7gQJlIk/9bxDxzyDuqLv+IE
dwu0EmlBGRcUGG4juqudvcaoFyX5RGe3j7qeAkAYH2bl+J3qTHy73P/T5/p81y78
Ewoapyty
=5BEi
-----END PGP SIGNATURE-----

--Ft5dYmwmxBK1+V+Z--
