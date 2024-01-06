Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7102BC46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 17:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E6BB87A07;
	Sat,  6 Jan 2024 18:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qfO5D7PM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21BA8879E5; Sat,  6 Jan 2024 18:41:36 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A330287A1D
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 18:41:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-595559ab71eso366463eaf.3
 for <u-boot@lists.denx.de>; Sat, 06 Jan 2024 09:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704562887; x=1705167687; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xDE3BZKG9fCWEVGIuynmm2TCsYRdTQJzm148i6tIjRU=;
 b=qfO5D7PM6QeIGbeZGvWP8+O265a7FUgwy2KjkeIaHYLHLVbx7E8orPfvdWswPlxVNY
 S8MySetEBfm31IvOvAhRVQNrj7lc9FT+qHK3bDa+crUsMkyMynMsgm0voxwpqxzQ2Qg5
 1G0MVYv4Oq7/LXj2prIu/ZnWj5z7M/sfxStXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704562887; x=1705167687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xDE3BZKG9fCWEVGIuynmm2TCsYRdTQJzm148i6tIjRU=;
 b=MR663zGWIxSgSbUzKZGwuDzs2bcqcf2fjtY3jV2SZIlK1z9Yhn48KjZ1i0HEJP8cvq
 XMaQ2sD8CjrlIt9isS9xigWQNSGKw2AEHDoGoK2ig8GuKQI7yXVFSFgJxyGeGZXj5Hg0
 IXnRNr7ZW7KoKPSoAv3Ou5VLtM2QGjLnfRh5w4W8Aotb0ysPF3MjZD3oG3Yvb2RFOcCS
 0cUeAn1YwMtLghlOyFOAIA/xera0Asr+xczzyx2H01bKSsAs2qLwcAIEE89FinVlxJyO
 URMfovIg/fR/dSorp5l23zStTB84xAbAN7jJim2v5QmPgoEeAJmYvOBiHN+Ork7tOBnt
 49IA==
X-Gm-Message-State: AOJu0Yy4oez+btwoCp0dh54jiIR6dmH6R7fjdHyJQhi4UJMY7MeKCpLy
 khfLB9iuvYRwaBHiaq6zx7ACw2K8vPoipA==
X-Google-Smtp-Source: AGHT+IFXP9jcT6yLOI3em6egbpV9k+YrjChD8igUc8NXKXhItSguUwFMObYOBT6QnDEy6XoonSskOQ==
X-Received: by 2002:a05:6359:3093:b0:175:5d72:5f6a with SMTP id
 rg19-20020a056359309300b001755d725f6amr804650rwb.36.1704562886623; 
 Sat, 06 Jan 2024 09:41:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 b2-20020a0cfb42000000b0067f0d8cf418sm1504263qvq.70.2024.01.06.09.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 09:41:26 -0800 (PST)
Date: Sat, 6 Jan 2024 12:41:24 -0500
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: u-boot@lists.denx.de, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] fw_env: keep calling read() until whole flash block is
 read
Message-ID: <20240106174124.GB1610741@bill-the-cat>
References: <20231213121354.13303-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MRQ9AljPQpKjuSH4"
Content-Disposition: inline
In-Reply-To: <20231213121354.13303-1-zajec5@gmail.com>
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


--MRQ9AljPQpKjuSH4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 01:13:54PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> It's totally valid for read() to provide less bytes than requested
> maximum. It may happen if there is no more data available yet or source
> pushes data in small chunks.
>=20
> This actually happens when trying to read env data from NVMEM device.
> Kernel may provide NVMEM content in page size parts (like 4096 B).
>=20
> This fixes warnings like:
> Warning on /sys/bus/nvmem/devices/u-boot-env0/nvmem: Attempted to read 16=
384 bytes but got 4096
> Warning on /sys/bus/nvmem/devices/u-boot-env0/nvmem: Attempted to read 12=
288 bytes but got 4096
> Warning on /sys/bus/nvmem/devices/u-boot-env0/nvmem: Attempted to read 81=
92 bytes but got 4096
>=20
> Since the main loop in flash_read_buf() is used to read blocks this
> patch adds a new nested one.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Applied to u-boot/next, thanks!

--=20
Tom

--MRQ9AljPQpKjuSH4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWZkMQACgkQFHw5/5Y0
tyzmLgwAlAFDZJYmW51T0P9wWVzfVhx2kzJfMiZwNl37lqwjbCYa8Xu+n4VONn8d
Xs5v93F0bCktnPYdOzV10nrldFNBDuKyYs/ZqmxJDvgJzcM1W8jeKSsfVY/dgwrI
fNSIgj7TpAB9LzqeJ2LQBCVl4kAaaWug7WztnIkOwYLAUclkWlq3JYyv3bWirjyq
sN4oapMRa3pk7JMVCw0Pv6yZMTqtmdWB1Qd6CbvO8jeffYelLqS5Cx37tUg0r1u7
Sp9QLVUMBFSCH2gm8qHmY2cijiFRbSkRWLxxUuBPzPsf7gRoby/JmGG9eotmHhPJ
/FsqKGkkaNmCtjZfACkGwjPn4yJQcLKEbptGoonEvEjeVlRWk6AOoo5LaVzE3tbm
IflrLXWFyTSZSZonKcbFdrRJRSR/f9SnPDbbImSmjYBnoUe420qkdSwMbMNrDk/E
ztPYX2dI4r1IDz+1yWXTpe0el4EyjvF3xQ3lEhZYlEEr1IS3AmI69y7oVoElv3NZ
scUYcevD
=ubbL
-----END PGP SIGNATURE-----

--MRQ9AljPQpKjuSH4--
