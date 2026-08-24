Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96B7C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 15:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07B0B6062C;
	Mon, 24 Aug 2026 15:28:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E74BRjqkL_kF; Mon, 24 Aug 2026 15:28:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787585314;
	bh=7trM+DGRKneAwcX9KpGGlgN1aA8xPsr4qs0ezoUF1uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O6QK5yRqyQ6hQV+8WzyZF/XDEK5yICoZ0ZxPGkRIvtvrkK9IchQowAjdTeqPdw0pC
	 yxHUMRrp0tGU63bMDr3BSPW7EG36g7lLTSpGYr3Nzd2Rbr6zux/+f36XTEsZhrgMRC
	 uJQrku3uQh3v6YYG5/bALjRTwXcDtMvmwMFphSQinkk+yG109ivO4QmgIXColRKiNE
	 heWxguwZI5kI3/L/LFesafsBgewkT086DwUmaQH/y+ossor0QP8KIGSgsfnT6xJ+ht
	 yw7ri/I3hvsgAONP9rebwh2d+WVQeubvZwy0hHVPdxmhbs7/CbdhfgBOaa7ZYf5u2g
	 zDJjD3pFyQqCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E30EA605ED;
	Mon, 24 Aug 2026 15:28:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 43CAC396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A326605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_lTT92Q5zA8 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:28:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::;
 helo=mail-oi2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GclqiNgd
Received: from mail-oi2-x00.google.com (mail-oi2-x00.google.com
 [IPv6:2607:f8b0:4864:32::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2500D605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:31 +0000 (UTC)
Received: by mail-oi2-x00.google.com with SMTP id
 46e09a7af769-7e9f9a3167aso941554a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787585310; x=1788190110;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7trM+DGRKneAwcX9KpGGlgN1aA8xPsr4qs0ezoUF1uY=;
 b=GclqiNgdILBuCG5Q9hRIuTVHcCqyI1GKUWtPfl3D/u0XqUzzRIAvngzbTJu83fd9Nn
 XlVg0a3GDgSZLLUDwnPjL26EA9xRjEMOkhvyr/VCbvAkbRhZ+5lByDS8EWN/Pd/FQmqQ
 lhXmNZt03tiwIDJlBVPJD/bwN/aleauqEznQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585311; x=1788190111;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7trM+DGRKneAwcX9KpGGlgN1aA8xPsr4qs0ezoUF1uY=;
 b=BI64RNpkY5VQgo4xOZ1pX7NpYGOApYPU5+nfFbUxTQBD8LVliyzfZ14WdVOhz777ti
 sa0zPrVoFjxZkkMD0E/GAi2YF6417A7/IpzcZse5xOgcjWRIY3EKE2mOKryN9PGCDYeU
 e+36eA3pJyH6ezX8l6InQKsnAHKCgFG0Hcmcou2yx5vNmH7iriDXhQvGqaEs13mJA0ce
 bR5N2RyuZInw1BjasFqf3+WZjGixF6r86aiBvK+2Ax0i1VJgK3KKqYhbQ55t2tAioAux
 r/ufelxnDwsCLhEb9vjER80kPYR5GIKoFUSgJv1EWZnJo7SwkI6KldmWAHMWe6Z0c16v
 x2dw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbC2LwXB9dTqdPbLSLYOcPNBdWcweQl6zLLFbwB2NmvmLpZWJsjc2wHHkJ4uuL1R1aYoyXr/Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kaY5BNI9qh8o8r/mpnGSAFhSCAYjHGZUvbdTgghSoJeVCoHYU7
 i8FZYfBOSmuIdaERENaA3CDCuzKcPoC5cBjT6AkaJYevbX/GDcUu3+xd3p0Azte+ZLj6LQI8+Va
 y1QWyk5TtGe3e4Yo=
X-Gm-Gg: AR+sD12UTg7Hg3d0RCta/u93rsmipdZaqyDE3ojiYu91p6ePi2mEJjSYImS4iu+kp7O
 GFbBN+CKdayIJzy18iTOoRvKQ1RXnuV9VmFisO8pjTuur70rpJW/tTc+tYWk/CD/ebV3qn6Oil0
 CKeHJxSoT93erD0iYgBV2Oa/GdvWitPtre6aPztE8REoEWPLlawdl6Kfba/Ziak/3l8g1qf3AhE
 QQfm8UEUdMnV3TtR/0FPteZ8Ab4A3leItln3u75XtpiYHIcocd9SwHBct5Iy2+fvj61Ljp/Qgco
 cM//WdRYL791tkgZ31OB9RTN+41TNzdoANjgGDeTaQP4Jx6wgQ8wmxBhgCu0pezOyQzS4YORJV7
 vqIAtWxxF9cWTwW/0Ud7aTiCUMTs3xQAPi4G1xQ63MxMYu4DqLAkcxpQyWpton4P6Y4YG7FRfNG
 SRu71yC2mbbWur3hr7aYeeYq0qqP50uBrPSqKR8xNMdLVVaITRvum2fhoR2XPveqgWCXzksXCr3
 NKzlxMaDYq0QivVIJjmUYRhtE4mRDCgCMUJ7LZV881+vS6nKpd25OK6zWmLlig0OyAvbo7g5TYY
 x0y9Sb1ppA==
X-Received: by 2002:a05:6830:498e:b0:7ea:b8c:41a2 with SMTP id
 46e09a7af769-7f461015c2fmr31391096a34.0.1787585310536; 
 Mon, 24 Aug 2026 08:28:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fc7fb48sm4855765a34.19.2026.08.24.08.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:28:29 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:28:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
Message-ID: <20260824152703.GF523975@bill-the-cat>
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
 <fa38d1ba-ea87-4e29-905d-f71c04dcd458@cherry.de>
 <e14e6b85-97d7-4546-88d5-7d5e3a875ae7@amd.com>
 <e128ba15-d1aa-4414-9273-8fe999e054d4@cherry.de>
 <ad8a8f9d-8fab-4976-9d9b-10e7f5bade9f@amd.com>
 <4d7ef207-189d-4b7b-8fb1-385dc1411add@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZBWPe+jZvWKWCX3z"
Content-Disposition: inline
In-Reply-To: <4d7ef207-189d-4b7b-8fb1-385dc1411add@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--ZBWPe+jZvWKWCX3z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[CC list trimmed, Google did not like that long list..]

On Mon, Aug 24, 2026 at 12:16:22PM +0200, Quentin Schulz wrote:
>=20
>=20
> On 8/24/26 12:14 PM, Michal Simek wrote:
> >=20
> >=20
> > On 8/24/26 12:11, Quentin Schulz wrote:
> > >=20
> > >=20
> > > On 8/24/26 12:07 PM, Michal Simek wrote:
> > > >=20
> > > >=20
> > > > On 8/24/26 11:54, Quentin Schulz wrote:
> > > > > Hi Michal,
> > > > >=20
> > > > > On 8/24/26 9:18 AM, Michal Simek wrote:
> > > > > > A number of file (F:) entries across the MAINTAINERS files poin=
ted to
> > > > > > files or directories which had been renamed or removed over tim=
e. Drop
> > > > > > these stale references so that every F: entry resolves to an ex=
isting
> > > > > > path.
> > > > > >=20
> > > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > > ---
> > > > > [...]
> > > > > > diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> > > > > > b/arch/arm/ mach- rockchip/rk3576/MAINTAINERS
> > > > > > index 79cf9e97f70b..62c3ce765e0d 100644
> > > > > > --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> > > > > > +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> > > > > > @@ -13,7 +13,6 @@ F:=A0=A0=A0 configs/nanopi-m5-rk3576_defconfig
> > > > > > =A0 NANOPI-R76S-RK3576
> > > > > > =A0 M:=A0=A0=A0 Jonas Karlman <jonas@kwiboo.se>
> > > > > > =A0 S:=A0=A0=A0 Maintained
> > > > > > -F:=A0=A0=A0 arch/arm/dts/rk3576-nanopi-r76s*
> > > > >=20
> > > > > This is a leftover from v1 which had a file there, but we
> > > > > merged the v2. See
> > > > > https://eur02.safelinks.protection.outlook.com/?
> > > > > url=3Dhttps%3A%2F%2Flore.kernel.org%2Fu-
> > > > > boot%2F20260108143551.4017839-3- jonas%40kwiboo.se%2F&data=3D05%7=
C02%7Cquentin.schulz%40cherry.de%7C20d22328c2c14b04e70608df01c79b5d%7C5e0e1=
b5221b54e7b83bb514ec460677e%7C0%7C0%7C639231628996802560%7CUnknown%7CTWFpbG=
Zsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT=
WFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D%2BGNHaQOa3XRWnaRD%2BMBZJDH3t5=
4Q17ZQGynxdQr34e8%3D&reserved=3D0
> > > > > and https://lore.kernel.org/u-boot/20260310000610.592998-3-jonas@=
kwiboo.se/
> > > > >=20
> > > > > For now we don't have U-Boot-specific additions to the
> > > > > upstream DTS for the NanoPi R76S but we could in the future,
> > > > > so having a wildcard like that would allow Jonas to be
> > > > > notified if one ever gets added. So it's not completely
> > > > > useless. No strong opinion on still deleting it or not.
> > > >=20
> > > > File is there or not. If you add it in future you should extend
> > > > that fragment and that's it.
> > > >=20
> > >=20
> > > And Jonas won't be Cc'ed on it being added if someone forgets to
> > > update MAINTAINERS (which honestly is very likely), that's my point.
> > > He maintains the board but won't be notified if something directly
> > > related to the board he maintains gets added.
> >=20
> > you can use N: regex fragment for it.
> >=20
>=20
> Fair enough.

And part of the point of this series is to enable CI to make sure no
more mismatches get in, so we can't have speculative entries.

--=20
Tom

--ZBWPe+jZvWKWCX3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoxjGwAKCRAr4qD1Cr/k
CjCiAP94vj/5lDxKcNYaTeJCcogR/KeO6XWKnXutvV6UeW6bpAD/RvbrUjT7+u1b
CjSFZyclhqQg9Yu0p1w1fdEzKyfvCwU=
=6ZJL
-----END PGP SIGNATURE-----

--ZBWPe+jZvWKWCX3z--
