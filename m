Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE40DC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40C22881AA;
	Thu, 28 Mar 2024 16:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R7w/JQZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0BCC88150; Thu, 28 Mar 2024 16:09:15 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2223881A1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:09:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-78bc322a55cso18309785a.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711638553; x=1712243353; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Scy/aNSaruoYyFijQtJe+bob1Usk+nVyDkhWOAlVDzc=;
 b=R7w/JQZJzyNgZ7+xiztshTaAL6j0WLhYGqwxmUdhF7p1X4zNECsDCxP2EQME2S/3co
 oxHK3KZ9Un6yyBm4ua3cMUWPrwV9Nrx5MTUrMAvuKqDBETC5Xw4lKZrWnXlA9y8+SFyJ
 eGs9Sv8zyxk/qAq8FvbXpniSVL8Ojm/W5+7HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638553; x=1712243353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Scy/aNSaruoYyFijQtJe+bob1Usk+nVyDkhWOAlVDzc=;
 b=nvER6wUyTST66Ew+F5SRruBb9/5z/K4G+FBqorKozBsZBU0ElKHX49uYFJ39ZNeO02
 oWcMWiJb2s8m/2aPKNkRqX2mlVP7truVvtqGB7yr6392sqTQ1g3LW8HOUr4eBL/7CY08
 N87+SQvtfudab0Va17NjaPmW8Bdi9PNVTcJ/xuCGc2EWWUkngnVQqzLMiZcxBySUqPVe
 KGrm2yDDyy5P7hchbbg8bAkKAx7oTznI9YVkKDWIQPFHHEVo863YIlHhdwE4UpRdbwcW
 mNB79YuHdS5iTNjiQvZNVVTphW5MVj2mYB9Nt/AQ3jmnVdDEY8mvqQGOQXIYzN9Rw4SY
 pvQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUECKDjON+sW6AojWSxd4ggVyvtdBg7l8+r7HQNz01dSaWkQxkY0gXGaUWuRrDlLE7ezyEjqgTG2t0jrFBIbM4Fdozi0w==
X-Gm-Message-State: AOJu0YxECVmw5pkkvJ9zN1kWe30ABB78rrrWoxzqgLzDdTQWGnX3HS46
 PjgOVlgoW1ecesTraehglfQaMjzwQji35rBm2alK+VYB9zGOumNU/MIv5bZl1jtMXEiZRSosISm
 6
X-Google-Smtp-Source: AGHT+IHrbvSA5DfnAA42ZIx6ycxBAD6tvOub/lTupLRXIrILda7coM5qu/wZjw13/6CSrdd8zJpLOQ==
X-Received: by 2002:a05:620a:c8c:b0:78a:33f9:908c with SMTP id
 q12-20020a05620a0c8c00b0078a33f9908cmr2703705qki.36.1711638552780; 
 Thu, 28 Mar 2024 08:09:12 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a05620a229800b0078a469ada0fsm590821qkh.67.2024.03.28.08.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:09:11 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:09:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH 1/1] net: phy: Fix signed shift overflow
Message-ID: <20240328150909.GX3442575@bill-the-cat>
References: <20240104042623.103398-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9g7011uXTGQSMrrA"
Content-Disposition: inline
In-Reply-To: <20240104042623.103398-1-heinrich.schuchardt@canonical.com>
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


--9g7011uXTGQSMrrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 05:26:23AM +0100, Heinrich Schuchardt wrote:

> From: Eugeniu Rosca <erosca@de.adit-jv.com>
>=20
> Booting R-Car Gen3 arm64 U-Boot with CONFIG_UBSAN=3Dy resulted in:
>=20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  UBSAN: Undefined behaviour in drivers/net/phy/phy.c:728:19
>  left shift of 1 by 31 places cannot be represented in type 'int'
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Fix it by appending the UL suffix to the numeric literal. While at it,
> convert the type of "addr" variable from signed to unsigned, to protect
> against shifting the numeric literal by a negative value (which would
> lead to yet another undefined behavior).
>=20
> Fixes: 1adb406b0141 ("phy: add phy_find_by_mask/phy_connect_dev")
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
>=20
> * Using U-suffix for integer is sufficient.
> * ffs() of non-zero value cannot be 0. But addr being unsigned is
> * preferable.
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/next, thanks!

--=20
Tom

--9g7011uXTGQSMrrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFiBUACgkQFHw5/5Y0
tyxz6Av/aglavIH+Xvdr3g4M4eGLBkzxO01Kbcj9E4aSdTn9c4+bxGwoQu8mf7aU
+UueDM/RTsjfNLn4whZwiu2BVb/3/FimUEsBTmH1c5PiZK4k9VSCiMllZbaA5Jvk
9ezPtN7z/CuO1z9WW0K9vQ5aRf/p88tqJQqaAvOT2MhHW6s2IDF/TRpm4NVwQ8Ky
NKtPRs93E1GdQTM84VvEIXqKqT8PS+zfdIj438yPcuQhzPXvDCbQfHDbRBcz/IF8
CDTjy+BCbGMCCgOLSviI/DSsxlorJMWgV2me2OZ1bus5rm7AcgYsrdge3vfb7z/6
fz9+NAHRf+C7ZHvfw6YX44zFCy18lUBJPcucGZynjuwqPReNs5KAG7oFIG1BvK5q
pkGJ0myZSX7UlA148Kg/HbzbDowCNK+1cjBUVQmzgaiR8pfJ7Uh0L1d+frsPF1Tf
RCiftYVts0tmeHiSFPc4INq0ESyfvyEPFs6t1F2Y+TwJb3TPZBYVrWKeoNwPDB5M
/4AEIVn6
=cDLF
-----END PGP SIGNATURE-----

--9g7011uXTGQSMrrA--
