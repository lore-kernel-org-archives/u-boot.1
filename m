Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDA6C4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDC83879FE;
	Fri, 12 Jan 2024 14:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G4cidCLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46A9B879F7; Fri, 12 Jan 2024 14:46:18 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 328AB8794F
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:46:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e7f0bf46a2so63261297b3.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705067175; x=1705671975; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z2Dorxw5Huj+YbBaB7wNZLypm815HDIG9CdAL/h+JpY=;
 b=G4cidCLh4DoW4YN0GHAOYYltsD3O9xdet59wFEUAEoDyFt/nT6oPVkBQ6zWIWBVlQf
 R1Z8JaS3ykIKh1BdGxT8kQg77lWocbeatuRU7oNndqc46PEp9VOKx5qtG6rkQ0B7DxWE
 yISaUoI6ZEKrOFQ9ed+qBhdT8/bziQIrCjQ4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067175; x=1705671975;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2Dorxw5Huj+YbBaB7wNZLypm815HDIG9CdAL/h+JpY=;
 b=g16QbY6HgdD7ZaSsKLqHzxGgdlnzPIKMfVCoGSb4BE3yVDheYXcz8/ZqirjNMN12Gn
 G/A42HUZWJ3vlPgOl3LJmYa12D4xhlaTz5pVjh1RRBuEJ4vO0AoZ3VjSHEmmgZ8DYMIY
 AWRI6fykxJWOg/2bgei5tz0TbHRsdVdoNVcd/qcsn7IdorB2/5tCqz6BisQuimLNpmI8
 6qUdPuVeq7DM8y145ylbNvgrQ/IVaAU4yD4jXm5Xjm+7C2L+T7QI9WhUiAeZnVhM+dgF
 sty60gIUQB18BDnSKg+JQ5gzbnSJQT4jzliMMjp4VRi7BTh5Ln8oEfzGLAAWugUc3HM4
 kG0Q==
X-Gm-Message-State: AOJu0YxOesIlrAGdsVk6lPA2BwXpJwhBcceexlQWLpff88lvmDKTYu3n
 7g85FBLr9T0rFZPasB1KsZgCEx/pSKEMfA==
X-Google-Smtp-Source: AGHT+IHjGQDfNFgo8OvbOE6vsRUvRoTRRJoWoLRFiqB+FA27QwyEr2qdOGWKtx2xJQQPBZ/jVGFqcQ==
X-Received: by 2002:a81:e208:0:b0:5de:7455:1a09 with SMTP id
 p8-20020a81e208000000b005de74551a09mr1244428ywl.76.1705067174812; 
 Fri, 12 Jan 2024 05:46:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 w76-20020a0dd44f000000b005e3d041cc4csm1338464ywd.84.2024.01.12.05.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:46:14 -0800 (PST)
Date: Fri, 12 Jan 2024 08:46:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] test: build test/boot for CONFIG_UT_BOOTSTD=n
Message-ID: <20240112134612.GS1610741@bill-the-cat>
References: <20231216151954.66658-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G/vFvVwqqfght/wb"
Content-Disposition: inline
In-Reply-To: <20231216151954.66658-1-heinrich.schuchardt@canonical.com>
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


--G/vFvVwqqfght/wb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 04:19:54PM +0100, Heinrich Schuchardt wrote:

> Building sandbox_defconfig with
>=20
>     CONFIG_UT_BOOTSTD=3Dn
>     CONFIG_MEASURMENT=3Dy
> =20
> results in an error:
>=20
>     /usr/bin/ld: test/cmd_ut.o:(.data.rel.cmd_ut_sub+0x408):
>     undefined reference to `do_ut_measurement'
>=20
> Fixes: 5999ea20fa42 ("test: Add sandbox TPM boot measurement")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--G/vFvVwqqfght/wb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhQqQACgkQFHw5/5Y0
tyw2Rwv/YYRSSaM7ProYeVph5qH35ZnT/+nJXALPskm4rQehufvUPPo8fpGRRTYK
n2RScbsCAMvBYNt+PZLKiS1wgdKDu/jaBwaD4nW3r+igZzuaZKvnn6YI3mdG7sZ5
n2dB8dhoe6gqgZs6XmqR+mhPg/e6WMihI40wm+8W4qL7/DqIh4QUNG/8aB3GJusr
mZDbAhwpN4kYjjUvYQ01X06QqBSvMj9UEeshdSb8V00hrxL0caNCEIWarTWkTZG0
2jqzGpmW86Z7oqbznTWHxOWQsei1wFT2NG44xXaLAA3yNCqpex3SBuCaIhA0/jdr
f+4VMr+DYIvxF5eiVGYQ8qxALH7aJleT9Lc5Xp1QqGZrvmoCTsmCUt934Yu3GFG2
m9/yxP5w9dqU2VACcejy+UHy/A4EjNF7cA/hifRUbSAhvfxLZ8w0mwjKkaa2Xk7e
s8ytlobCOnCWR565T3aajQIAhycQoOjbp+KhAmRLlFmhXntg/B213jX8W5XD7DF9
MJVK8SGR
=g2lF
-----END PGP SIGNATURE-----

--G/vFvVwqqfght/wb--
