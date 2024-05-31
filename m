Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E351C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 16:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DBE9887F8;
	Fri, 31 May 2024 18:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mbeuVQJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 358C888800; Fri, 31 May 2024 18:48:08 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE219887F8
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 18:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-48bafe04292so628561137.2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717174084; x=1717778884; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WMmrZibF027qCopx4TnA0B+odNQ+tALaTNwwFXExCwo=;
 b=mbeuVQJnUrMqBdbVcD9JhtL8bp5vlTWAsuQUYhXAE6Fmoop+Y5AnxHxGKOOVTzyo6k
 VQDhr3egaG8Zc6AgFCeh4dZ3SG/al/g5N4m+oPOlu1QN1hFy4foOUSeeQ47eMD9j40Ni
 dxSOQDaTJVQ2IdepmGAbMDkvL2NyP+M94WpkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717174084; x=1717778884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMmrZibF027qCopx4TnA0B+odNQ+tALaTNwwFXExCwo=;
 b=wuctyrup613+EMja4W9TySwtUG8wecCl5MML8xzMOBfuLY4+Rav0IxKW7c6ALBoWJb
 oY20sQXn2oAJNodBMvseDaO+YdhUyZTsQhdT004t4n6sIOJ6u54UIIe9yr8Pi3ZETkQ+
 M1/9BJT+ZctgS/iolM0EINpZFbhlFrbPfsqpEs956VQwakbMyGCrJskWADaIxirSIF/M
 zCHgPzRpZ8Pu/B8jwZo7P8AV8Nes8IgU2ANG4dPHMN88YmQS0RECLw1GVGIfvCpUM/n1
 FgMKx/TJ0STHgNALDCtxKce7dFmEuCwJCSn9f3CMUukb27ywAWQXOfois6AExl7v/8md
 OIxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhH1PWoe1b2+GwFPW87B4z0hI0UVcIgX3yQgiGvqLsri+UIJPmtctNy1VKGz0JpA93aJhXDtjlEAYBgTXCGl63FZGBQQ==
X-Gm-Message-State: AOJu0Yzg0HOF5+CfvnA22x4f+VCKd6HdA59xeGlWG+ExO1MRaRyaph1B
 q9fO8jtRfo8VdL4hL3Dz7O40YupbxXiAShooQu81it+O0zrcrVXf3kF2gNZdo34=
X-Google-Smtp-Source: AGHT+IGSqZSGRpEeyR3srUi8PKuPySFkyxY6Ope5TofQSPmLwrfpoLH+mI9QmJJrO6YLb6pJ8zTyTQ==
X-Received: by 2002:a05:6102:2223:b0:48b:923b:d8b6 with SMTP id
 ada2fe7eead31-48bc217a286mr2696849137.19.1717174084023; 
 Fri, 31 May 2024 09:48:04 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f328fcc9sm70166385a.129.2024.05.31.09.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 09:48:03 -0700 (PDT)
Date: Fri, 31 May 2024 10:47:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, srk@ti.com, s-vadapalli@ti.com,
 vigneshr@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
Message-ID: <20240531164759.GO3714513@bill-the-cat>
References: <20240513-for-2024-07-beagleplay-eth-v2-0-a9bf457c3bb8@kernel.org>
 <171622056331.1577131.5584438868595064237.b4-ty@konsulko.com>
 <95fad9de-5fd3-4dd4-8a13-850dc81da26d@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fcC0ZVcfkTCpT56h"
Content-Disposition: inline
In-Reply-To: <95fad9de-5fd3-4dd4-8a13-850dc81da26d@kernel.org>
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


--fcC0ZVcfkTCpT56h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 07:32:37PM +0300, Roger Quadros wrote:
> Hi Tom,
>=20
> On 20/05/2024 18:56, Tom Rini wrote:
> > On Mon, 13 May 2024 15:13:53 +0300, Roger Quadros wrote:
> >=20
> >> Sync AM62 device tree files with Linux v6.9 and
> >> add in the missing bits in -u-boot.dtsi to get CPSW
> >> Ethernet working.
> >>
> >> CI testing
> >> https://github.com/u-boot/u-boot/pull/534
> >>
> >> [...]
> >=20
> > Applied to u-boot/next, thanks!
> >=20
>=20
> I see that this series was applied to u-boot master as well
> and then later reverted by commit d678a59d2d719da9e807495b4b021501f2836ca5
> as it was based on u-boot/next
>=20
> Can I re-send this series based on u-boot/master so it can be still appli=
ed to master?
> Without this Ethernet is broken on beagleplay.

Was ethernet working on v2024.04?

--=20
Tom

--fcC0ZVcfkTCpT56h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZZ/zkACgkQFHw5/5Y0
tywNfAwAqBsUbVzMAUmImgKAxUla4LUfS+YC5wyAUmHBQuoMjkDO6KuvwZurneqi
ALSSnDQnGQ1SO1N1tKBKur8XTeuEgQy+K6Qvh1wR1Xyg9j12mY1vaBzHMsMggkA/
ItAbMXbb/DYpZF79t8L1kSlKBSLmikd2BAtwizGwjLzCtKjRC+8RigfLVPYYOXHF
0j6Xf5TI0gGXRUORa5SqRmXNJtsKzJU037os3k+aHjCKtckaimbA94ag1OGL7lsY
SputwXKnbzca91pwri4kM9BoiJubHHgIDakXmcKQWTc2WF1AB64NgrkSDM3Wi4J1
sOxQuv58ZHM9fFkv99olTX8WaM6uW9kKml3cZAsxVJJ2R5q5CGDItlYMc3a1wvK6
1USFvsNem4B8LGXphDOqvEFyyQJRxGEjHkMMFls4CTAZtiY2ptPkSrB5I7YysC2D
zcgde5Qn8Tt/Ov7sdq3dkWqvhwMidfwTbn+zy4hMAgP8wlmN1Cw9VqAHuoGL1W/T
Msxeew/v
=6Sa6
-----END PGP SIGNATURE-----

--fcC0ZVcfkTCpT56h--
