Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3C6C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 20:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0A1082E8E;
	Thu, 17 Apr 2025 22:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="paWU4aYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E113782EDA; Thu, 17 Apr 2025 22:58:40 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AF38144A
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 22:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c27166ab3so784403a34.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 13:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744923517; x=1745528317; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6gIia96uG9LYkb3PoDUnBNHktbAN8nyz8ufgPVAaYew=;
 b=paWU4aYuSUBvnDE4mO02GYsIgkCZ4k/5tsWFaxqr/P3y6slbvk6aumVgY/z3j4Np2u
 mLhHskK5K6CCFnV1qYvwpQtA+rps7QdxnxbDVFFu/BrnqGykbJve+AefHH00jRCdrKMd
 xWCCVTAc0xnEh6XsqiszbIo4hG9qhYldzkVHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744923517; x=1745528317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gIia96uG9LYkb3PoDUnBNHktbAN8nyz8ufgPVAaYew=;
 b=frHFyRaNT4yEDMiw+t7QNSt1FVgfbXHJTgqAVnEvL/54RWk4FFIr5jT7DkqtNfTdYR
 Md35aFIODFjYDSlk4VnifuwDbqUCjMuq0STtGQjYs+KkDBVXZkjkjlVBAis7YhzxUFf+
 +Fmxg3VeH7MtOJniehFEirsbtGhb9uv5fsd00gca6EhnsWUs2wZVzPTpHAOsvsph1DM9
 opQrWhAItiq4x8X9J9IHbqe2VTXGi9oM6bPdOx6YuXxDbHdAtqff8z6PzK4Wpxs88H/o
 10At4zF6015MKT12eKMYT5QhD9bs7Q6rLrt88ZfG/z0gOrehFpV0crgtl7uCe69EHkmF
 0vTw==
X-Gm-Message-State: AOJu0YxPboVbloab+ZTVsrfBbvBzUb+WMJiXTPAgmmZ+xK4b637RDSPw
 96sGjBgcJwapsdK4MA86fojv6yI389MuSoWTjhnX1br/mJ7S64UDcBY8i6CHYfQ=
X-Gm-Gg: ASbGnctTxVfpUrc/QFTt6stBqhqHv0TOjLXMmv5FdLVzgDcHg1+Z05Hw2+/d/l0NXlh
 Iq6aRr7MBlnzf9BwUOKOs1v8AICWbYg30uFg39WEL8OrC+X2pU5/hNwnHKsB5tEEwpau/Q2hfAG
 z5cYrKJIK8j8e6JbdgqV5MyJUab93JQwxeVzioPhpUYyA4MgwO4WBxDSnxyAMXZmm6nZvYGQSVN
 0uMkon39946Peodzr9SthnSRymlo1GKLdiDRVuM9Oo0m+AkxJKIjGscIrqwb0pbisYlcnb1rVf6
 se8D+BOfewEZ/ple8a57mV6mSLstb6Wxde0oi9K9xEatSd4P1+UBHZ7ehJV2Mn4qvmaQ/AOsGN3
 GFQ==
X-Google-Smtp-Source: AGHT+IFkVgTIFp+SMTpJfgzc/UfcAEdsrve/gGvc9Xkn6PyfQOY0kJ9I/zrn+qCaekNlAP0R/LhP5Q==
X-Received: by 2002:a05:6830:d89:b0:72b:f997:19c4 with SMTP id
 46e09a7af769-7300633746bmr127829a34.26.1744923517342; 
 Thu, 17 Apr 2025 13:58:37 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73004884887sm87560a34.45.2025.04.17.13.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 13:58:36 -0700 (PDT)
Date: Thu, 17 Apr 2025 14:58:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, nm@ti.com
Subject: Re: [PATCH v7 1/4] spl: remove usage of CMD_BOOTx from image parsing
Message-ID: <20250417205833.GA3017152@bill-the-cat>
References: <20250408141436.712387-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0hCW5zDHY6DIVJkL"
Content-Disposition: inline
In-Reply-To: <20250408141436.712387-1-anshuld@ti.com>
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


--0hCW5zDHY6DIVJkL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2025 at 07:44:30PM +0530, Anshul Dalal wrote:

> Using CMD_* configs from spl doesn't make logical sense. Therefore this
> patch replaces the checks for CMD_BOOTx with newly added library symbols
> BOOTI, BOOTM and BOOTZ which are enabled by their respective CMD_* or
> SPL_* counterparts.
>=20
> SPL_BOOTZ is enabled by default for 32-bit ARM systems and SPL_BOOTI is
> enabled by default for 64-bit ARM and RISCV.
>=20
> The respective C files (image.c/zimage.c) are compiled based on library
> symbols BOOTx instead which are in turn selected by both CMD_BOOTx and
> SPL_BOOTx as required.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

So, for the series, we have a few problems, still. First, this is still
not size neutral as we now end up dropping bootz from a few 32bit
platforms (gwventana_nand, display5, gwventana_emmc, display5_factory)
and growing colibri_vf. Next and more importantly, as after Nishanth's
explanation, TF-A isn't going to support this case either, I believe
it's best to just drop this part of the support as well. Thanks for the
effort all the same.

--=20
Tom

--0hCW5zDHY6DIVJkL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBa3IACgkQFHw5/5Y0
tyxHBAv/WJMCDYOozHPUWGubmdn1UOXVBlg8pCKvAIoLt4FA5xpiu4dWrR8F038r
WCjD1tURqnXwE4tGcedh75VPrM4KUGQtXhL1R1jNY97x17G+zgKr1he69MHQjxuM
NmWICCX2HckUqaCytG33/51CEt7fVmqTG6ANUDYCjiNL/i5PA5nVrrLgsiaKFFEU
qmDi7h4ryQ1P/DAvKFYMWuSEIPQoELgEcw4n6mQ4xa0W0/MC4Dm7ZbbzZEEJDrKl
NyaNP0KE3ip/DmZbGNrtVNKF2ZJg0uzp3BVNy2ZOSRW8oSflZUuig+RxJbdoWOFX
YSZ8fp7uKd4f9TPkwCUj6M41hgv5PR8eIK+xj913Ay2Gth1IodsvsQwN5Z5TFEV5
iL3Dm6n3VS9SWQyI4c5O2a5hvAFOr3PWsnNs8vTtUQJul+7wYUQqk4/l4YpBajFw
2lx1T5Y0Pgd86/bKUnjwJmuL/+xU+Tz64wdpYJAIZnR4qjFVU72i0AM8FiDs1hzp
T7ZjHRtm
=etOI
-----END PGP SIGNATURE-----

--0hCW5zDHY6DIVJkL--
