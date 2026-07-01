Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D212FC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 14:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3705584BE0;
	Wed,  1 Jul 2026 16:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uIlH55YK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B028384BEC; Wed,  1 Jul 2026 16:16:54 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBB2984B92
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 16:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7eb4d532e65so171716a34.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782915410; x=1783520210; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vg56B6xKZ5BILz4NFSYWzcrpSouIdVFLor1SBPhZzIs=;
 b=uIlH55YK2b083wT/fv4i1nU64gCc5e2eqNZfsCAVwn7GH/XQ8w0P+R1/FUVU+OK13b
 bac0arOArxQUAhBKHAXkamjs7tmandwrKU9gJUMRixnYFdD4eJCT3HR1bKfaM5KNqEIs
 w8rs5WIYxRWLV/Pdlq4y19OEXSqP4962am+CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782915410; x=1783520210;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vg56B6xKZ5BILz4NFSYWzcrpSouIdVFLor1SBPhZzIs=;
 b=ru5TUPBPJeF2NtXTjNbB/mIyHkZgUNTwWqvPSpZLYw9lg7w3mjBNz4qniMu0F7V64T
 3q4ckW2CAp68hx1Z5w0Csk5smp0MpJNSivq+SRzIGvqhu+fpv+3o579tjeUYQOiLWxBg
 xLCnbYQ0bVOwERamMeILXdQW6Iaw67Z+JPorl7MtZ/JdcnYlpc3JteaDJ/MS9zxP+Hmu
 Mctm7TSsnqf/dST8emn6Ie4YskHSidAlYyIC34KvLB2oiRWS5RCvQFsjon+EdqHo8XuC
 6Ca71fG2Z5llgCdxwinbd9u0OV2qWY9dupVL3/E13rallMHUbh5uHMBe2oWN4Cnj5MxS
 FKJQ==
X-Gm-Message-State: AOJu0YxgwC2SFA00hR8Ut2pBHn+fX1Tjm9odP/QT1l4PRej5I53VlsME
 iKEdDmcElJ5kgpmYqQA1WpvWisDYvTgE00VOx3z6jf453pQvO2ZiLLFruN5vsiK6TKl5ii28Ewj
 HhDy65es=
X-Gm-Gg: AfdE7cmyZ4HJBL39myMr7ezg9ymbrUyvNl8XRmoe1XxURkIFPXzGeDzWg9HE2CZ/iWi
 VeWpbwlWoD51PExZpUpVgQCASaQ2GdbfbjA3w1Z0Lao2tOiQSdvOSBDIExbrViOfn8pFApTEOZt
 mBEMX4GQdUUc9s8NKGa4wPD5R0hK59YX0BhcVbjIXUSs/ezFBArUHSJAZIFg62hsY8s+8D6ukUs
 G+HYKPJSM/A3LQGpGGM/p2mqoW5aJ1PzKI6zjptwizqL3RSxeYdi0u+ReDQkyEHSjm5/wbGefpM
 VLfNmCACSKsfsIqhUtKsjsKUan5v07HBOO+oL/3HnExktJmww/cn3JGfkUMCtJMvBOIAyqtFVkh
 11uTGBWTZdIK1JOWePyrN3Q0dUq/u3rncWj1T/gOXjJFtPLarZGeX4PlcJ/aAvO89ki2hu2jMnt
 YgkKcfZ3cmeMkshP/nfGoL5755skfZfRr7rR/NhgrYUu/1mMq0Vgpv4VfeM1aEByWrC2YikmOuj
 LvDAYc4++b+m1b1w0VCQF4CUzKHHHf4tdGITA==
X-Received: by 2002:a05:6808:398c:b0:496:7a:213f with SMTP id
 5614622812f47-4960efd4219mr1201748b6e.31.1782915408924; 
 Wed, 01 Jul 2026 07:16:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-496068f17a1sm1533616b6e.8.2026.07.01.07.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 07:16:48 -0700 (PDT)
Date: Wed, 1 Jul 2026 08:16:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de
Subject: Re: Unresolved conflicts after 0d8e33717d7e in MAINTAINERS
Message-ID: <20260701141646.GH749385@bill-the-cat>
References: <akT0Mqg2JpDoKVOB@pie>
 <akT1-Mwmc2022vTl@pie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ySwRDCCgPeov2LRK"
Content-Disposition: inline
In-Reply-To: <akT1-Mwmc2022vTl@pie>
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


--ySwRDCCgPeov2LRK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 11:11:52AM +0000, Yao Zi wrote:
> On Wed, Jul 01, 2026 at 11:04:18AM +0000, Yao Zi wrote:
> > Hi list,
> >=20
> > I noticed merge commit 0d8e33717d7e ("Merge patch series "arm: aspeed:
> > add initial AST2700 SoC support""), which has already landed in next,
> > seems to leave a part of conflicted changes unresolved.
> >=20
> > ARM AXIADO AX3005 SCM3005
> > M:      Siu Ming Tong <smtong@axiado.com>
> > M:      Karthikeyan Mitran <kmitran@axiado.com>
> > M:      Prasad Bolisetty <pbolisetty@axiado.com>
> > S:      Maintained
> > F:      arch/arm/dts/ax3005*
> > F:      arch/arm/mach-axiado/
> > F:      board/axiado/scm3005/
> > F:      configs/ax3005_scm3005_defconfig
> > F:      include/configs/ax3005-scm3005.h
> > =3D=3D=3D=3D=3D=3D=3D
> > F:      drivers/pinctrl/aspeed/
> > F:      drivers/pwm/pwm-aspeed.c
> > F:      drivers/ram/aspeed/
> > F:      drivers/reset/reset-ast*.c
> > F:      drivers/watchdog/ast_wdt.c
> > N:      aspeed
> > N:      ast2700
> > >>>>>>> 4a72fd9fb09109857303ca64fd259009e1d4b554
>=20
> Adding list to cc, sorry for the mistake.

I thought this was resolved in the merge commit? I don't see that in the
current file at the tip of the next branch.

--=20
Tom

--ySwRDCCgPeov2LRK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakUhSgAKCRAr4qD1Cr/k
CvwYAQDfl4uxobjNHU33bHFwMOmfqGY6kLgnfoqBb30Z8yFxUAEAmGL62g8YUepu
BkIyXd7uoyJ/r+tj5IooedJoBBnV5w8=
=xeh5
-----END PGP SIGNATURE-----

--ySwRDCCgPeov2LRK--
