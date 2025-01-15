Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFBBC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF0C680702;
	Wed, 15 Jan 2025 02:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uIYFcSMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D38A580214; Wed, 15 Jan 2025 02:13:34 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71461806FE
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d89a727a19so3824376d6.0
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736903611; x=1737508411; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LQs1chD39Rt91YsejXU1Jig4WEn+8sF211FMm8mBNk0=;
 b=uIYFcSMygYwcJk+Hjh+0J8CYclWywWGBH0CU5ujmwzRh+Is5jnx6RpE3GQxKz94Isw
 JQ9uixdxgBahW9N7V4mYqEnq6nVfkSJkeo3N04m6W3jHsEB33CUImF1VP1xQCSHTb5i4
 1i0s6Ppr1KzeNEgX5iAyWsZs8+Yg4UEwbq2Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736903611; x=1737508411;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQs1chD39Rt91YsejXU1Jig4WEn+8sF211FMm8mBNk0=;
 b=k4Mqo8ggzB5SpVngI0RzbhIGygb91OZPpG2hwES2IELq4zv9/sbLQu3sWH3h/9JynV
 uR2TEg7xQF+TPbpit4MZ+dmt7F3wUuA4Q/F2FeAPfeZAZuP48uP0YGE+xOlNRF6we8ev
 8/HTi3WrXM2Y1e1Pct1RqYBLRK3gjZ6yAFbMS4keQUCpGIJuP8gH0vrWAi/uMRVA7xjW
 N/8TBFT8cAlmv6W7ldxb+ZVXimxwvkwaaQ1cuvZHU1guwEPdM3vAghVSsNczibBhk9SJ
 MIb8r2CzPPcqwGqmOpWQwBrfB7P1Ode30viPVcVEL8MD4budOEt/fJYzfm+yxSG+uwpF
 C1fg==
X-Gm-Message-State: AOJu0YyYwAb2eCRhTyH86Yc0HqQmfdG9jhodWKFVLwVOWP8LqZuAHI2g
 QePM9/PxVGkPqviYhwi2V3omyLvNPRCMeUngqDiRiU6UNf4/9nLkg16glmADnTioc0MaIGkiHFH
 z
X-Gm-Gg: ASbGncsd6aDzwnwMKqD6+TQed0uneaZ4HSXZBYh3Skkum81FoXBO4CJma9oKW4li1XY
 pxk+5IFBPWfGjnHgSzDkCMQK/75kya4gvsWumTRxawvuxBT9wweUrCd3APXzYOEbCjQl8cNfROI
 cwHzQZd+mhzVx2BjoVxtuLy1dqAML3x+zTWqeIE9dpFnnN7x6GU27FJwC+VerI16BY+su2pJaJ5
 vb/76qZpmPPXmOmV9oBPEUYEYdtNGouX/GsWlYnBBuN+QcaxFv8qg==
X-Google-Smtp-Source: AGHT+IFrYcfcCpycCyZQgTAuAZv2/pfSlTOSJRIv1aiUyqrFc2SbC9emSJBxiZaQi37mf6akKUQpFA==
X-Received: by 2002:a05:6214:4344:b0:6d9:2f70:2dab with SMTP id
 6a1803df08f44-6e192c3be29mr20189526d6.16.1736903611237; 
 Tue, 14 Jan 2025 17:13:31 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade8929asm59059836d6.100.2025.01.14.17.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:13:30 -0800 (PST)
Date: Tue, 14 Jan 2025 19:13:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx patches for v2025.04-rc1 v2
Message-ID: <20250115011327.GQ3476@bill-the-cat>
References: <c9bd4bcb-8118-4433-b103-4fdc476c7344@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1cSMIZL0ZhDTEeJ4"
Content-Disposition: inline
In-Reply-To: <c9bd4bcb-8118-4433-b103-4fdc476c7344@monstr.eu>
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


--1cSMIZL0ZhDTEeJ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 03:50:16PM +0100, Michal Simek wrote:

> Hi Tom,
>=20
> here are some patches I have collected so far. There is nothing significa=
nt
> in it. Just trying to clean my inbox. I am not expecting many changes for
> .04 anyway.
>=20
> Thanks,
> Michal
>=20
> The following changes since commit 6a0db9ee030f634731b792d864fc7a9df6cc6b=
80:
>=20
>   Merge branch 'master' of
> https://source.denx.de/u-boot/custodians/u-boot-usb (2025-01-13 08:25:00
> -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2025.04-rc1-v2
>=20
> for you to fetch changes up to 3a2bf24a85b2b35f1c7d6f0633d6aa528a6970b8:
>=20
>   rtc: zynqmp: allow on Versal architectures (2025-01-14 15:34:51 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--1cSMIZL0ZhDTEeJ4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeHC7cACgkQFHw5/5Y0
tyyo5Qv9Fdynif41W/dGcZwtkjYO909++mdH5qY6djdv0e4RqWdwc0vSMMfp+CHt
YCeoN/ZlU26eEe+Gzc7MnqB3WwpemXwQmV2CIORaSb7oAqYxqrDIxYhqHySfXkmg
IHNOkaryfien2BPyzQK0xlJH28EDWbmUvNUSAa7G/2VHanBvkO09h7kbcGEOohQh
1GFuoe9E/l0nhAESoVK5deolNFot5hV3gQzp7GrHrtbwfKMVxTs+5Cz9MRhMlT3l
CXN6Pelit5VQ25U+t4wUw1QuGOt6g1GmFYy9XLd55b93mHTdlaVaD4cQMdvl9UuJ
IkXb+zIsA6wXGoBynr67H787Iqb6wUhgo/zoK7T2Ecm6HsDFqCrSHEuYYVZ1KKFe
vp9dYmS1xeFHE7lvyrB2Q7qHINCF4cEqK/bdctCkhbAdN/OcWwc1BAeZBnV9jdtj
sGT+gJseZjEL0OxkxjscKXTXUAvYvCBttuF9rJfqvRH50Xz2EB3HlTKFb4Dc/CbJ
WZDyaxVC
=BCCy
-----END PGP SIGNATURE-----

--1cSMIZL0ZhDTEeJ4--
