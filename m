Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C543C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E28BF84AD0;
	Thu,  9 Jul 2026 03:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LHwIcmA4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CA0A84994; Thu,  9 Jul 2026 03:52:34 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20A3B84AD0
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-497d3e4460aso574248b6e.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783561951; x=1784166751; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9yf02e1L68e1qRxn3TgVmZj/b0gORUsZJ9V7B+EOKuA=;
 b=LHwIcmA4ra1ma7TR0UXmxB3sifljl8pFuWQGv+zUTxb8OuJ5cpRLRoLYgRV7Rho7zu
 m734jdQDc7iSIDr0g3co0hvYvII64wgGxzGP/vxs1CV6LijKI5JCIVQ3tsRxUAGhnRUj
 JGRSNkGjZ3yJfnXs/q4JOTpphYE6Co75Ub6nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783561951; x=1784166751;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9yf02e1L68e1qRxn3TgVmZj/b0gORUsZJ9V7B+EOKuA=;
 b=Ltcdmh2Gx0WMwjzJT7KBF8vfM2pEH2iVvXsq48mCFF6sub6sF3gMtqFHHp5N3f4sQO
 2QqCj5owStlR59i9EerAnxGiZ0lshJs1x8OAQLgi0uwXtIiX9IyUW12lzUEhMYlsaQwp
 /HIxRa+8oXlh/ASvznmNxsy80pfsqeJ8BFztHIGc669H9U5CKupAFbfQAQ/uZb13tiSp
 N1qXrkLYiyKWyEl7rL4EAigHYQ881EhT6EA4kzQrgxlOV4YN+iZynwlW/aeDlbdqiV5C
 l/rytKc/jgd9LDp6ufGiO5RmT5iU5SQ6abMBVzk8BUdN0sUfmUG2C7KakHfXBb78s+qL
 h0qw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LhpCDnnfWNQLb1RnrcpZ/v2ypxQ0Qz7HksOSskEB/vak1jQRlYRMxj0OiARss5EEzPUT4F+Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxJ0SZpBzADRYGjl7L/sn07uuhD/9/GY8DY0bwa2ALTnFSuxIUM
 El3pZk3G3w1chVVs9u9xtOpscVUftLU7okpK0OnV043ycwyyaxDMPfSMH+NRjhvYB33gclMeCGP
 cLJBknyg=
X-Gm-Gg: AfdE7cnmN5mk3WAmhngMphCAESzi4mC5Rkgjgn0WcGBCuSOxWulmc5mmQrUOZ8IWhTF
 o7XuimUG4WLyQWUb6md75KCbXfFBhtHfw72bQ+kQbkGn4C//gpFwtTxv05pNbDA/9/E3ReFa3Gj
 UKkRQlx6IdOiwYFrjn1ugcviMDvjc1Xv2uxGLn2CkBxM7e8Bm1I9FYlDQIhFh2NEwvfdeBZSCBV
 sNG1dv5+Gtk36Ei0dSyIS0TYMmS4oJ17nhnQcE6noUjWX3pdsgbRjE+AzNOGP/fifCbYMcw3ZCU
 wkhrCU1qwzinYlwyQoR6714X14Oh4jhr42t0wZ76kdXulbicYiCjotUilxkPdalgscN6ThICH47
 KWNLNapLnzyDbzZlCZ/JzFPOgEJcbHqjOj9nuk+hIs1MojRin5VN+7CAqVQLOP8aS48X2GxN3Zg
 bqRCVlMxgUG8iC55G9gjxuqovuz2LdFkts6ITqC2M9pX/S0MfhBgAIC5G4WuD/mnALihnxL65V7
 30dmtorvLPcP4axGQCozsQs1cY/8OrcENzlUw==
X-Received: by 2002:a05:6820:8189:b0:69e:89f8:9640 with SMTP id
 006d021491bc7-6a37d8cc690mr452273eaf.18.1783561950902; 
 Wed, 08 Jul 2026 18:52:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a377bd9cb1sm1334078eaf.15.2026.07.08.18.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 18:52:30 -0700 (PDT)
Date: Wed, 8 Jul 2026 19:52:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 04/11] x86: apl: fsp_bindings: Drop redundant
 CONFIG_TPL_BUILD check
Message-ID: <20260709015227.GO749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-5-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FLzd7/dEenVVqSYs"
Content-Disposition: inline
In-Reply-To: <20260708220540.3368825-5-jonas@kwiboo.se>
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


--FLzd7/dEenVVqSYs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:05:30PM +0000, Jonas Karlman wrote:

> The XPL_BUILD symbol is set for all xPL phases, i.e. TPL, VPL and SPL.
> Conditional guards that test for both XPL_BUILD and TPL_BUILD symbols
> are therefore redundant.
>=20
> Drop the redundant TPL_BUILD symbol check from conditional guards that
> also test for the XPL_BUILD symbol to cleanup from an old SPL to XPL
> symbol rename.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--FLzd7/dEenVVqSYs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak7+2wAKCRAr4qD1Cr/k
Cq/BAQDtYMNwr/Wn7/2DxZNX0C1UMGPEi2FGfX8Jg1AGX46DzwD7BWeSOZZUhJQQ
R3SGdM2AZE1VahYEfAtbB8jSAb87NA4=
=sUhX
-----END PGP SIGNATURE-----

--FLzd7/dEenVVqSYs--
