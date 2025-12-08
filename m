Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE2DD3B7EA
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 21:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E50F83990;
	Mon,  8 Dec 2025 22:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SpNYWbuJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 203FA83AEE; Mon,  8 Dec 2025 22:01:20 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C48B8398D
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 22:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c6da42fbd4so2397767a34.1
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 13:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765227676; x=1765832476; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yt1XekKYhHs0/We2yfkxOUA18x9m3U0brMDm38rnuv0=;
 b=SpNYWbuJD71cZ0Jkj2waPXyAVQ1f4sJ1PeEyI+dlzGe7TCdGF+SDTaYl2HIZeIIDme
 GSFs/hd0U7NnTdsnxkouHoOci+SgWzExO6FB5jWCyuqzQWU9dSYy+c2frhfW/am6FhB+
 DDx489yYchm+vabCaMrYpnZIUB9fExN7H08Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765227676; x=1765832476;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yt1XekKYhHs0/We2yfkxOUA18x9m3U0brMDm38rnuv0=;
 b=aXsHXcsrcVjthwSJzJDZuYrrjyXocE2tY/HFkbPnMear3gu3MCnrFhlMfO36lw1To1
 lZITmBS2XCdyT2BPObAsBDdVquVX43oWDHqM+1+7e3EjRNr30N9lD+ni1fvLpfvPVf4w
 +QieP2U/t3HclELMmdFevgiuujg3RfAw1IrWhURXsp6p4EjzPTfACy/8UedEBSrU8eBF
 c2W7nbZzCxhtwBqq+3MAjB3p3Berd/SHoky/eBITYf4sBIN3ok1C3cIcghXO9ea6EvFn
 adiPKPr2+uOiDu7jpjDQUp5Y6M/IRLmZzfU7882T04PJV6TciauEX93XUYxsF+HcBmoa
 ybdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV69+qgNRPbbdceIPqwPg9yjwoYMZF7I9SZFlaA+yhe6GZJAS0gUYwemAeN9T6839WtXRkvmro=@lists.denx.de
X-Gm-Message-State: AOJu0YxLoLk11CR5IJ2Xy8rsYgN3i7VeFKrELo8Ffmj/MVZHo8mfH+ff
 oyOVhuJS9Cmogn53lNTQbLYFW5TSsgQOkWlZtylnKEOoc7ZT3xDZgS2CdRq7FllLTAw=
X-Gm-Gg: ASbGnctgkgmJDWrcOjGV3kk5QfLuhLgjq1vRohY9IuTBoAk7bLjqO43oqcV5xfDVTE+
 DsTHFF01BPPHCM0zGC6tFr4N5J3PQ0IClSfgOhRDNQgf83YPmRADoNYw8BB7Ff5xURyAArI45HQ
 VcJEd2aVM4iazmdULnw6leoM/K7iROAWgu4VfWQew/+1HsO+mJ9CxyfyDu2YGHzhdiEgusWwL0g
 +0nzIs5N/wPqv6A1Lx8Atvg3pVY0aiVcCKAmNBSiAiqzISa1rZzOrZo4Toe4+GPQN6J6P4n3Fka
 1MPMVJ1KleUNxdIpoJX0a6RghUlbgKO/WiaUYRul32qOfxIyOaHCVi+BDg9UhaFaNowUHAeyyaf
 9Q174wxqAswzZb2A9xBATeT3IXQOIg4hZ0gtAgiyxYxYD5S9RxrPWHT1g/xW3592zBc6pUujDE5
 0WdF0yZx14sXZHc4u4IJUSIuqJ6EgzQxaNk4qyBblxgkDk47Lj1A==
X-Google-Smtp-Source: AGHT+IFi6saLhK2kD7cHc9TRFtHpBzr0bq+1bsgtiqFA34Ara5MC7JeVb94wfu5s2fKqyy4sjmtSJw==
X-Received: by 2002:a05:6830:718c:b0:7c7:6cc3:c3f2 with SMTP id
 46e09a7af769-7c970861d3cmr4913996a34.18.1765227675927; 
 Mon, 08 Dec 2025 13:01:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a91eecbsm11114004a34.11.2025.12.08.13.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 13:01:15 -0800 (PST)
Date: Mon, 8 Dec 2025 15:01:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] Makefile: use --output-target instead of --target
Message-ID: <20251208210113.GT303283@bill-the-cat>
References: <20251208204738.62792-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oCXXtklPRiK+kYM7"
Content-Disposition: inline
In-Reply-To: <20251208204738.62792-1-heinrich.schuchardt@canonical.com>
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


--oCXXtklPRiK+kYM7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2025 at 09:47:38PM +0100, Heinrich Schuchardt wrote:

> The objcopy man-page teaches:
>=20
>     --target=3Dbfdname
>       Use bfdname as the object format for
>       both the input and the output file
>=20
> This implies for --target=3Defi-app-x86_64 that the input file would have
> to be an EFI app.
>=20
> Objcopy in binutils 2.45 checks this more strictly than previous versions
> and refuses to accept an ELF file as input with --target=3Defi-app-x86_64.
>=20
> Replace --target by --output-target for building sandbox and x86 EFI
> binaries.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--oCXXtklPRiK+kYM7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTc8lQAKCRAr4qD1Cr/k
Cs/vAQChZt7rcWgpi4Nvop68laVR70jP8aXYeMT/pX3GAB9BbgEAp0lYkReJpK1D
w33nKuroPlyhahSsEDqrPMahP5oV8AE=
=ch27
-----END PGP SIGNATURE-----

--oCXXtklPRiK+kYM7--
