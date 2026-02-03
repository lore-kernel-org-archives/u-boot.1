Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E0EE87854
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 18:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A32483C29;
	Tue,  3 Feb 2026 19:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ldYO6DYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9716B83C30; Tue,  3 Feb 2026 19:14:51 +0100 (CET)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25E4083BFE
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 19:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-40866608701so3179922fac.1
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 10:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770142487; x=1770747287; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3PphesFuuznXjyldpv9C1nH9JjsxsC16mN5zdjDjQZE=;
 b=ldYO6DYf152HeaZpNbFPXrDPY41auhyk13QJaOg1CTuxCcaJ/ZiykV+8ENoB/3yn+v
 ckh1UKDG5kznv6imqHXKGYtuRN4E9PqcIpNtnqX+c4rNjvM2cHtfSlGyi+W6K9aa4UDs
 t62TLjfqPo17UObwZ/J4xL1jnPyQvmGqiZ2Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770142487; x=1770747287;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3PphesFuuznXjyldpv9C1nH9JjsxsC16mN5zdjDjQZE=;
 b=DfuwzTCBO++U4ZWEGhmpTz2ZV8ik5iO/l1IO3fCdD7S1vuPxonUaIhngyVNwSknQdA
 5ZqihPWATfotialpTqoIiblvSs1SBXNDRgg9N1EZaDxVFUNTSwqA0EW4bWPS1hH/e9Qu
 Va0bT2XERzxEuzNbU/vu6x1uAQ39qCKvnLAQzkHHAVjwd4O42s7/cb2S2JcBseu8CpdL
 L4QSkEbUJd049K24PMUZ7XYhqb4tbADXUSXdzR1GeZSxT8QXBMPKWIiQ2Xzv7B1AUw6Q
 7szcLp43cPr3mjjck+gZKrFk3SHa6jSpS0gQB5elv9X9m1qIEliDW4IwN/67zzM2/AP4
 zCcw==
X-Gm-Message-State: AOJu0YzfZayldKoNlkk3MePiPkGKHQlUERRZgvrPoASzV9Mu3Y25sEVs
 uycqvo57vFGHBe+m5w1T82VV4es0pnnO37/O1CXSfF/9fSWEvFP9qUXV0l25crDxpzQ=
X-Gm-Gg: AZuq6aL4QPvAaut0JJK/9BPhilYMsIgp5ZMWhYwUFs/q5Iu5nYGDrcMq/ZYo9pVgsfB
 IJjIP6IiNSqDck7FJ1e6tAHavF3TEsL5z4gUhCRHDTTgY6jox4rWn4HzgvI7p+IWNchol7sC7U3
 R8ibStHG28b5Xs5kMS1ZVkrAQDpmZib7rvhLS7+MhxnmbPgTpwUWb6Ad41oN3V3TMqKRYJqNCs8
 hwwIFiXgQgCb+baYf5XxG9ebY3uIdqrnygF4YM8FvumxHcI64kx/OwRugnmjvhKyE37jevhy++8
 mpvW06feNMhotZ6nvMw4hxUId5MoWpt0xx/im1WdsP1YfkhX3GGMPHBnhdjfxHmNlLO9cEHyZeK
 UBhVUZWHRJheayCojIecYOG1Uctdy99jumgPT5qWupATPkt7tcroNJq68NVaIwiEhI/OcPJZU4O
 WsxD5bg08gB885k6gLfZjgl7iuLLwdfje9MX5nLS+bFsKM0hK+Yb9hPtSfaqfQqkTIYLtjOZDcz
 GQMI6O3MN32hBQgi6blSugVOpcLrGHMbFCULKA=
X-Received: by 2002:a05:6871:7406:b0:3f4:fed5:d88b with SMTP id
 586e51a60fabf-40a53f034ecmr114962fac.35.1770142487535; 
 Tue, 03 Feb 2026 10:14:47 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5448d703sm79646fac.18.2026.02.03.10.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:14:46 -0800 (PST)
Date: Tue, 3 Feb 2026 12:14:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Cc: u-boot@lists.denx.de, bmeng.cn@gmail.com
Subject: Re: [PATCH 2/2] Fix x86 baytrail boot flow, UPD/VPD Updates
Message-ID: <20260203181444.GQ2603314@bill-the-cat>
References: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
 <20250714210249.4139916-2-eric.schikschneit@novatechautomation.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ay9Vlab8eYpM0Adl"
Content-Disposition: inline
In-Reply-To: <20250714210249.4139916-2-eric.schikschneit@novatechautomation.com>
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


--ay9Vlab8eYpM0Adl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 04:02:49PM -0500, Eric Schikschneit wrote:

> The VPD has been updated to include additional values found in the Intel
> FSP_MR5 Integration Guide.
>=20
> Disable MRC_CACHE for the baytrail platform as this will break the boot f=
low
> as well. This issue has not been diagnosed further, but I suspect it is s=
imilar
> to my previous patch and related to how modern GCC generates the low level
> op-codes.
>=20
> Patch 2 of 2
>=20
> Upstream-Status: Pending
>=20
> Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.co=
m>
[snip]
> +	/* Set all values to known good defaults as documented in 	*
> +	 * Intel FSP_MR5 file: BAYTRAIL_FSP.bsf				*/
> +
> +	/* NOTE: This breaks u-boot ability to set board options via	*
> +	 * device tree, but guarantees specific known values..		*
> +	 * you wouldnt use an uninitialized variable would you??	*/

/*
 * Multi-line comments like this please per
 * https://docs.u-boot.org/en/latest/develop/codingstyle.html
 */

And we should spell out that device tree can't set these any more in the
commit message, along with spelling out why we can't do that anymore
safely (why can't we?). Thanks.

--=20
Tom

--ay9Vlab8eYpM0Adl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYI7CQAKCRAr4qD1Cr/k
CkEQAQDistLB1s38ymYg7sbR65myuLFiiycU5J9Ti8Nlz3GKMwD8CzuqWqXxNHUR
kq7jRNv0vaRdegx2rk9k/ubuoWhpBAk=
=i3ck
-----END PGP SIGNATURE-----

--ay9Vlab8eYpM0Adl--
