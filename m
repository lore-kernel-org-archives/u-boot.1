Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88B7C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6F6084B1E;
	Thu,  9 Jul 2026 03:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U7flthTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA26D84B19; Thu,  9 Jul 2026 03:53:19 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F30984994
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6a3776acb16so377406eaf.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783561996; x=1784166796; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4VDgQOgo60cpsT3avTiRJXQQQ9Ei6Sw1QPpKNcBl7GI=;
 b=U7flthTUhuOJdMhO1djwMxtXFsXrURTUWH078yGcEhLnPa+IYliiPHpoCrdRZGLP/m
 e88aJ4VPqDT7dhWSD+R85wSoIjSm0u//Oo+EePIjotJ7TzvX5ykfl/pZpgKAP9j9MGkk
 pAGmLFaPSA2eNHAz7VlgfCke5D97w7aAU8ywc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783561996; x=1784166796;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4VDgQOgo60cpsT3avTiRJXQQQ9Ei6Sw1QPpKNcBl7GI=;
 b=WwDmGhjtC1AvS6PBE6R4TemW8Rqm85TfxUWyNttfbeGPMzioymYjtgiKoXdpZqPjjD
 mJ+Z+b7jk3dRkmQP5RVxftK2fsg7EydgEhIZuRw+GU+7ps2UQxuYbNSPnjdYR/toFkFL
 ORw2tKLaW8PgjNxIxnRoROUdZfaIiR5A7nFTEBhy00t0+EExt1ydQIRlgpIvToYDuzAH
 oOJgDCbPRYhDhmGK3t/n5TwaIdbFxLXSnnG6dv5hwwc5zKCdsoEBKQfZRK5coLcmwIhz
 bijvXCnsvYPjSxpaTKHFSEW0T3/UmQtQKE+u7hRQnESWSc2kwrkhItBOVWKmARRl5fDz
 R7sg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gr8aZ+6DXt1MUIZdeVzSlU+ung6czFb4fljbTgBY8cyDRjqCiSzB6mAq3DId9P23bjRe2a0I=@lists.denx.de
X-Gm-Message-State: AOJu0Yyy4OZpkCA68xgTJV3fp/9g5xo+DQfYby5d+EAgvEcj6pBQqajd
 GhjEpyXWQUxbNYu2kFScVFePtno8bERbqg+XECplzN7McbxqaTyfPD4Fo6N4/HuIIcTE6+wHwMh
 0u9VMcHY=
X-Gm-Gg: AfdE7cnMvsdnixeGVzH8OZnHJlGcegUEGW4AP9v9Gzo3pdte8GJpWv3TlEf0ReGOxKi
 +tozwGpa+us+LWnoSW4AlUY2jCnge4AWsQC7UxGTHwy7Q0fXfTkQUoUo9mtV8YUdV0VRWeTyENP
 8nwf3yrdXwLNRwz1YcBcSFQbXy04tY01bY7MF5qlAEawtQ4I354DOMlOIyeOuBCUNyOV91LRejB
 +Fto+v3kopTZ4Swy3WYbRpdR2bxOX/nP2UMZwaitqoLjZenjVi5fqre1GzkhkBuc4Y3EVpu3RRc
 k8Y0kKNG9Izu4fKvVMCq6QNxg8Hr2B5sfSqHF7jkutiw9Vmjbl0+fsT2NP3KmdNVhmd4ajiXT7H
 sC71kxmBFdNYSpcnl6C4yoUA66zkkDSrkutaiKlFpdYXNpA1w6RwZGNjsayj2ql1BgSuFNXLg08
 tZ9BPTSeyIWoIC6vdkfOBw/BxOxENz6MZPP1MWTBky8yLXFH70jq1bGUvnrmo5RZhp7kbq2TerF
 5RhYviHuSf5RbgGlmLDzQW+sjdp6S1t1+iUYzSeJJAkDwbw
X-Received: by 2002:a05:6820:2224:b0:6a1:43bc:d0b3 with SMTP id
 006d021491bc7-6a36d89b9dbmr3433794eaf.27.1783561996400; 
 Wed, 08 Jul 2026 18:53:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a37ee43617sm202618eaf.12.2026.07.08.18.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 18:53:15 -0700 (PDT)
Date: Wed, 8 Jul 2026 19:53:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 11/11] spl: Use CONFIG_IS_ENABLED() for LIBCOMMON_SUPPORT
 checks
Message-ID: <20260709015313.GV749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-12-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DBfiQOE/MquXn0iQ"
Content-Disposition: inline
In-Reply-To: <20260708220540.3368825-12-jonas@kwiboo.se>
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


--DBfiQOE/MquXn0iQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:05:37PM +0000, Jonas Karlman wrote:

> Use CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT) instead of directly checking
> CONFIG_SPL_LIBCOMMON_SUPPORT when guarding printf/log calls to depend on
> correct xPL_LIBCOMMON_SUPPORT symbol. Also change to use IS_ENABLED()
> for the XPL_BUILD symbol checks for consistency.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--DBfiQOE/MquXn0iQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak7/CQAKCRAr4qD1Cr/k
CmtcAQChKU+C2y/d+Zh1YD9peMtNopZl8gupZpyeSCVoOCSU2AEAhxgvvh8Blc7c
yxwGTBqGu0Y/AomlIrj6fzQoovMlgAQ=
=kkcz
-----END PGP SIGNATURE-----

--DBfiQOE/MquXn0iQ--
