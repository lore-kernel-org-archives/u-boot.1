Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BF5C636EE
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 18:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FDB588744;
	Wed, 28 Aug 2024 20:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OaW/8D83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 044BA8870D; Wed, 28 Aug 2024 20:56:35 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE4B888D4
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 20:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a8049d4a40so4598285a.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724871392; x=1725476192; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ULAbRzwZrkyyHpUr+uIAWQTrjZJi8YqeFXAaoJQKRbE=;
 b=OaW/8D83YC8qd6lCEznigFHBOkwzvSCW8W8jQxBRjcLxYWjYghI5NDRoQYqMYxHeFG
 /JhIB8/xodTHe4V3CEgOP6kF4/4XrzptTbK9h5NnvgT/a5eRwUHAQ7tXMSZWQLwSLzNX
 CFN8VyHpBhnO41cIQH0aZLtaesSBJJuTisUC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724871392; x=1725476192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULAbRzwZrkyyHpUr+uIAWQTrjZJi8YqeFXAaoJQKRbE=;
 b=BSjxkxWUo9iEr89FbcZH0carDnL5efJfKBQ/aBdwg+VprbuYQunc/Zxjwrpagmuobx
 t95suvha1Pgydn+hWOVpZLX3DrbovPU77ewPcj34sYGWglJxQgXbfkHiSuFfBjl//e0d
 XDe5cgb0uT62+ZpWaPDUxuL2KM7lCBi6HcOzQu/xcw7t6Z78vNumWmA10cuTnR8U3MuF
 kqHXqFLf9SI9m4HaAUfnV6OKbe4BW63CbuHaDHsyChJNIOlCE1mpU2eNsAFRH8PGdFGx
 GdCYXlr3nJO2HLcAZgBWBvR8+iZ572uPOJnFeN+JcrbBLAXpMl/KdKKEC2s4cjrA38Ye
 udOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU1RMMVn0KCIXmUKNA6ZBK2XgwW+LPXautrcOsBrjoRrhQB9mBCTgQ1Ju3FwjaXYv7VUUHpzw=@lists.denx.de
X-Gm-Message-State: AOJu0YyAj1vkxrSTsubAmZfNaP08+cqW1PeXaEN6wlxCt9eDes5b3T2C
 WjaxH9XUPRJpkxl2leA4IjzMVxHl46U+ymJRx4wjxnhoKZ67uySf+e8Wt+Afz/4=
X-Google-Smtp-Source: AGHT+IFNBOGTe5cZZoKY8AhI78VZ47fjtxxiyRzaLTpb60qixHIMOBYza5pxD+D1a6kfkL9K1+ksZg==
X-Received: by 2002:a05:620a:d83:b0:7a1:c40d:7575 with SMTP id
 af79cd13be357-7a8041b363dmr34242785a.17.1724871391506; 
 Wed, 28 Aug 2024 11:56:31 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a8042414cdsm8357385a.21.2024.08.28.11.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 11:56:30 -0700 (PDT)
Date: Wed, 28 Aug 2024 12:56:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] bootstage: Fix unstash of records from SPL
Message-ID: <20240828185627.GT2479150@bill-the-cat>
References: <20240803124149.2916030-1-jonas@kwiboo.se>
 <20240803124149.2916030-2-jonas@kwiboo.se>
 <172486961888.3064792.636174658599384187.b4-ty@konsulko.com>
 <c6b27581-890d-4308-84df-2f338a81e15f@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dhyCpa9Ed7pwp1dZ"
Content-Disposition: inline
In-Reply-To: <c6b27581-890d-4308-84df-2f338a81e15f@kwiboo.se>
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


--dhyCpa9Ed7pwp1dZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 08:32:36PM +0200, Jonas Karlman wrote:

> Hi Tom,
>=20
> On 2024-08-28 20:26, Tom Rini wrote:
> > On Sat, 03 Aug 2024 12:41:44 +0000, Jonas Karlman wrote:
> >=20
> >> The commit b81e31a1e6c5 ("bootstash: Do not provide a default address
> >> for all") changed a bootstage unstash call to bootstage stash, this
> >> has resulted in bootstage records stashed in SPL no longer get unstaged
> >> in U-Boot proper. Fix this by changing back to a unstage call.
> >>
> >>
> >=20
> > Applied to u-boot/next, thanks!
> >=20
>=20
> I expected this patch to go to master as it fixes a regression
> introduced in v2024.10-rc1.

OK, good point. I'll push it to master when I have other stuff as well,
I've cherry-picked it now.

--=20
Tom

--dhyCpa9Ed7pwp1dZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbPctgACgkQFHw5/5Y0
tywISwwAibS3Hfa8g7/eE5XSxz1NIFml99cfN+SRImLLHHAyRY2jdu1/DZZu/Ao8
WdO+EiF3LUF2CHr5HUM9bQKmd0rMYzoGg8PvHXAXbzSHAjaXAbG8CvZjp7+mWBZk
Rjl2nRKKzNKOoh394gzGkyRViMvjAC9rKIGjPvUptxZ/ZTaZpDjVxsScCMVKiaPL
/C5BzVyHl7sfh2mMorpuxMbLHKYaBitaWxA7VDY67BCS3plPUcA3W8m0KaL1Kq7V
SthTVTZp8NVWVRaCvGOzeyAUWqHqMgYsXUYLvDsY7edFR6/iBgK+xeMtnoNut1H0
P3FD0qUA1r7+FCC6HmVBdEGXk+F5rZapJyEGm2bxn/5fEP5H7n6vP1bCVaNC8gcf
H65U0HWisjLPyp0prMGWp1d8WC+8WZ3/f3B1xzjQXPfBFejzwEay3mxlJ74aUk55
QiN4Y1Th+KPfliyf2OK1zWQFXywhOBZ2szSCDrRWgSyorbPse46jqYIRgRZehimq
n8AoGD2L
=blpn
-----END PGP SIGNATURE-----

--dhyCpa9Ed7pwp1dZ--
