Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04339C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9150584BE0;
	Wed,  1 Jul 2026 19:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TmCjC0Di";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E1884BC8; Wed,  1 Jul 2026 19:16:28 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FB0C84C1D
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6a166742b44so584306eaf.2
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782926184; x=1783530984; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G1t7aHuqGNkg/RfrsBFO47RKFvVnf8CGbY7WQhaVH2Y=;
 b=TmCjC0Di/8PKfJqqfCLgBFfZ+c6nPl20+vu9KhNCF+weWhUGKALLbxvq3jAmnREL5D
 IDyupctRk1r1MjVboYKliN9aKOmV5y8/f7dH7qnK9PqxgJco66fNqGhB2O5drqH20wIZ
 c3Hqhow5Kc3YfU3ZQv3mja3pbvwHvYmZ8Jz68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782926184; x=1783530984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G1t7aHuqGNkg/RfrsBFO47RKFvVnf8CGbY7WQhaVH2Y=;
 b=nPvS7hISsabtGI/Ye1iuE9j8ZVpF9U21t+b8dyHnRz6EXu5eh8yoTj/pDo18S8zooM
 dU+mNi3aOoynKwEc9mpiyIsrpeUDQhQ27SadYRSL4yDteYIK2JeUAJrOxnZW6Vm/5/n9
 NlYgv/ZKiVOsWZI+ZVH9fbX7D6p4ezZ6zBJ1EdE522tOniSF4c6qYxxUasvlFElZDSV3
 sLZbokP7c92V5I1eBZYftn5jsWMTey3AkMtJloZJeC10Q3KE7aMrVcIwxAdEXD+9HssD
 Fs/TM5sqhFrqDXHApRaEMIyqOcPZOb+9AbMaFaDtqrliHL9B6zjXo3qwzljGhkoWO2qW
 Dyuw==
X-Gm-Message-State: AOJu0YweBcphiSF4WNDj9GM/XivQmnjRuzWVKk9C3IV+DGKLF7gKEh50
 eSNPwxse0yiLgisagHl5a8swEh0nIH28jVXLlE5Y4OCH/pJKfZpTFIBkvJRTX59avbAYm1UErdJ
 hpvlDMK1uVg==
X-Gm-Gg: AfdE7clNmLXsc5ccJhvtqn6a3tXi2FhwqUyRaFEoQmPEnxsE4U8De7btppUzey6EQ6b
 t674I1bEdvn9PBr1kE0nyA4DWU0PG6JgRi8qUWelNrf6vY+f06Iz2xZv80HdlgoBX3mS5AKcQZm
 R/AQEpfYVPffi2N5pl6oKY6hJaev2i/yTPnWWE3EYAyENkYsZrrolSkDg+Mcec+LoEi09Acuid+
 98FrSaFK9eFDoPBAXe+vgp7qK1wKL9RKM97B/4c0l3CbzOWk6KxJAdRd3FdhqgKRBsHyLqd718a
 PQPdkYhmKDibSul7LUIWFKfEb4CXq57MHbrvAlCI0lwqcKpd3w4qOF4HKKf0njkwp3zD9mwF1fj
 eHgjllliYTde7rdOWXPnnVCW7IIjfn5QflbckmANzQq0e1spoYZaG5IJx0qc0Sh5N6bmvZUsM05
 bSeqx8Vpn9yPZQEJ368OYUnFLIyW8pIXk3NNrkolzSLhRr8ZB+IHAzelPmiknrS9tasX0lHA7u3
 CTVVt5J90z0T48O1pf6PjlJaaajbhIYXXn14Q==
X-Received: by 2002:a05:6820:f036:b0:6a1:61d4:79ab with SMTP id
 006d021491bc7-6a30d75fc83mr874044eaf.8.1782926184034; 
 Wed, 01 Jul 2026 10:16:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cbedcc452sm240805fac.18.2026.07.01.10.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:16:23 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:16:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de
Subject: Re: Unresolved conflicts after 0d8e33717d7e in MAINTAINERS
Message-ID: <20260701171621.GK749385@bill-the-cat>
References: <akT0Mqg2JpDoKVOB@pie> <akT1-Mwmc2022vTl@pie>
 <20260701141646.GH749385@bill-the-cat> <akVKZT2DE88Eosm4@pie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bUMzW+3k01Ekw2IZ"
Content-Disposition: inline
In-Reply-To: <akVKZT2DE88Eosm4@pie>
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


--bUMzW+3k01Ekw2IZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 05:12:05PM +0000, Yao Zi wrote:
> On Wed, Jul 01, 2026 at 08:16:46AM -0600, Tom Rini wrote:
> > On Wed, Jul 01, 2026 at 11:11:52AM +0000, Yao Zi wrote:
> > > On Wed, Jul 01, 2026 at 11:04:18AM +0000, Yao Zi wrote:
> > > > Hi list,
> > > >=20
> > > > I noticed merge commit 0d8e33717d7e ("Merge patch series "arm: aspe=
ed:
> > > > add initial AST2700 SoC support""), which has already landed in nex=
t,
> > > > seems to leave a part of conflicted changes unresolved.
> > > >=20
> > > > ARM AXIADO AX3005 SCM3005
> > > > M:      Siu Ming Tong <smtong@axiado.com>
> > > > M:      Karthikeyan Mitran <kmitran@axiado.com>
> > > > M:      Prasad Bolisetty <pbolisetty@axiado.com>
> > > > S:      Maintained
> > > > F:      arch/arm/dts/ax3005*
> > > > F:      arch/arm/mach-axiado/
> > > > F:      board/axiado/scm3005/
> > > > F:      configs/ax3005_scm3005_defconfig
> > > > F:      include/configs/ax3005-scm3005.h
> > > > =3D=3D=3D=3D=3D=3D=3D
> > > > F:      drivers/pinctrl/aspeed/
> > > > F:      drivers/pwm/pwm-aspeed.c
> > > > F:      drivers/ram/aspeed/
> > > > F:      drivers/reset/reset-ast*.c
> > > > F:      drivers/watchdog/ast_wdt.c
> > > > N:      aspeed
> > > > N:      ast2700
> > > > >>>>>>> 4a72fd9fb09109857303ca64fd259009e1d4b554
> > >=20
> > > Adding list to cc, sorry for the mistake.
> >=20
> > I thought this was resolved in the merge commit? I don't see that in the
> > current file at the tip of the next branch.
>=20
> It's strange. It's still there in the tip of next branch fetched in my
> side, and I could find it on both U-Boot's GitLab instance[1] and
> GitHub[2] as well.
>=20
> > --=20
> > Tom
>=20
> Best regards,
> Yao Zi
>=20
> [1]: https://source.denx.de/u-boot/u-boot/-/blob/next/MAINTAINERS?ref_typ=
e=3Dheads#L235
> [2]: https://github.com/u-boot/u-boot/blob/5602e89a834ccbedc686053b14206c=
062a144107/MAINTAINERS#L235

Oh, sigh, I see it now, thank you.

--=20
Tom

--bUMzW+3k01Ekw2IZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakVLYgAKCRAr4qD1Cr/k
CktyAP4s0LCbOEVD9IiLdd/QXLTcPwAhfgQ7ZLWNZJ6ESxdkkAD/YWecpfCPXRXs
0TDwBLk0mof2G6W1o+D9hOhBiNvD6wk=
=WQT7
-----END PGP SIGNATURE-----

--bUMzW+3k01Ekw2IZ--
