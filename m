Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCADEC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 16:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E49F88646;
	Tue, 11 Jun 2024 18:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mWdj3UlW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D52886C0; Tue, 11 Jun 2024 18:07:31 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99252885B8
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 18:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3d2062325fbso3413812b6e.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718122047; x=1718726847; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a/xgw+gsMSJA1JtxSF0e0Z+wBEYYO9Wh+ORoaL/xBLA=;
 b=mWdj3UlW4rXjQ6bo5vqq7TPdE4edLy9u4RVJLHOqH062pYy6PjT6p6n3t5CueRbn6o
 bSP9YA5p3IhsqKaNPWhPS419dvMr1N5JXoIJ4JPAhmIj54andJn6NNDGwMqPZbg1VRD8
 AkXKatexhE2UYYImXSmSLrBlshUn6ctx8ymWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718122047; x=1718726847;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/xgw+gsMSJA1JtxSF0e0Z+wBEYYO9Wh+ORoaL/xBLA=;
 b=pEM1GtRMK4/cCV8IjEy4Ftw3Qfk/YBlpspfZVF7Fm/CgjWFZ3rCmLNaZdYwqWfGqvF
 Z+M4+Wp/kbbpw45sbqphEl71Jx9TUG68bzCWR3Y5X7zkv+2PGvPOA9bfLixmYJ0Lem5O
 sTNOiXT8+boSjnmDAAuD2CBHQKEUklO7pOxkDe0UcD6zIID5/9ZMEggqmq86nGwI3n/y
 AHX4QLZbGaKO9hKv6GZGXcjnhOJW1u/dJAk8/VokAKSygPedx1Q7492qxW8hp3J+PfS+
 lYPxqwWcmlW2hVczdLeul5ZeZ2hE2GQTFSDWuVwbIjPGT/MTSsoqLwMzeUQjewO8J82T
 +pjw==
X-Gm-Message-State: AOJu0Yzmi/T/TjruUu44qa3fPZHfvaXlg9JJWNY4qP/OHr8+OwaNJBNM
 x/yBrTxaExwQi3FS996J7on0OkCbfLDx1zFwajFRiXVrTKE8my3M94UZiyv0jes=
X-Google-Smtp-Source: AGHT+IFqK2D2dF/yW9yHBENdOJweqjMtFV2Ca2r8MkFGrhijlyuLNTT3dA6x5y9VuGUmhwtil0/vxQ==
X-Received: by 2002:a05:6808:30a5:b0:3d2:26c8:7f02 with SMTP id
 5614622812f47-3d226c8807bmr8373427b6e.25.1718122047113; 
 Tue, 11 Jun 2024 09:07:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f977ccd4aasm1336747a34.65.2024.06.11.09.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 09:07:26 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:07:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [NEXT] Pull request efi-next-20240611
Message-ID: <20240611160724.GI68077@bill-the-cat>
References: <1e8d881a-6b93-453c-8639-34ca61aa82cd@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hLKgilD+eyEpHQPQ"
Content-Disposition: inline
In-Reply-To: <1e8d881a-6b93-453c-8639-34ca61aa82cd@gmx.de>
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


--hLKgilD+eyEpHQPQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 01:52:13PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> This pull request is for the next branch.
>=20
> The following changes since commit 4f836fb324ba500ecabdba4146c3ca9e1600cd=
f5:
>=20
>   memory: ti-gpmc: use printf to dump settings/timings (2024-06-07
> 14:07:23 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-next-20240611
>=20
> for you to fetch changes up to 535321c2ea76de44896330040d2e43aa4645d026:
>=20
>   efi_loader: rename struct efi_initrd_dp to efi_lo_dp_prefix
> (2024-06-10 11:43:37 +0200)
>=20
> Gitlab CI reported no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21059
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--hLKgilD+eyEpHQPQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZodjwACgkQFHw5/5Y0
tywlbQwAtxUQGko5z52WrrDWJgIsGQkD0pm3AelRCFtaY5wiNIEGBF7COn+Ca0CS
0VA1GSjlBfKj1IdrQHXAlRDIYw6doFX8GWIpmjl9X9p30YTMsHtswP2FUKLNzhSE
bOU8H0ImcPBHDT8zAP5VsIvICVkVHp1ZtMkXGxScVXKrEKbeZGImdJytNpFLsrCy
jkMwZDtsarWfL4rFBPoor8YdMGDXm02Ft8dCr8eNv3ZqXxGIrAgGSufV29cq67J/
JP6farHRatZtDoUiJecEsTFLyMaM0DZvmI0GYbGqx5WlR1JWvCK2XheuMpspUImL
So3/x517cnvvGlb8nGc8J+gu3IZQLvxYetucltWMU6Chn9FD7eViNbEU3fMrxf+E
7A4Q/f4vEQ/SYG9LH/BGam4rQ3ASK5krDSiQljpkmPlW2GfgLHoFlVbW3wqpdjN8
9Z3DliIZWFdfts62M/TgP9rGicDXRyeQknyjFgON0dRYUE6531fWKiSLDDXbcuRU
SZJgZuDb
=0xY4
-----END PGP SIGNATURE-----

--hLKgilD+eyEpHQPQ--
