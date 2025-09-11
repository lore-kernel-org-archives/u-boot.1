Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6017CAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 17:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A2D833BF;
	Thu, 11 Sep 2025 19:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CbouewRH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 150A6833EC; Thu, 11 Sep 2025 19:24:37 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F26AA83390
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 19:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-43838d8064bso619658b6e.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757611474; x=1758216274; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F1kQ6OUpBXV6Kot3+mCCUdYZJIAQuNKQduGmMg8iWUc=;
 b=CbouewRHOGlZKpfZjsOXFKTHIbjcyn0D92HzTZxyz/ds+yIKYpHA5x9fVUO3DU/wvn
 yf0/R7cSiJOudm3tRn2mvYinfQpK6Lvq3u1oFL8LpYQJtLLYdiiF/X2HjzKiPELncRKm
 VHBCuh+TwLb6O6lO+wdIbjuCx7p71xL9JoV6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757611474; x=1758216274;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1kQ6OUpBXV6Kot3+mCCUdYZJIAQuNKQduGmMg8iWUc=;
 b=fbawteRnVsPGAIOqXewkHHjUNCBEH1FWpxIYAFmwxGR2px4WfIJDCUhtEmVtg/LWh7
 Bd6/Uy9opYI1/syOYNacBbDDHSdjpyX36k54pfU2LUy7kZbf/Plb2/DJun6uxzYUA8sJ
 AfPOJJCdN8gbap3/28dMdUroxmU7eC6hgl3ZpKDBI1Rze7166d1M6xfPgSP9JHc2wJnU
 el9v4EVba43wCocYpoBXL/3Nm1yixCAt755HSISaML61zDONfKyrgd8MEKYpprVW/cmJ
 e31GCwnuG8hiDkphoXK5Jr8m+JQTihD/aO7RzNjx6gb/xAgpECJuTmhnyjNE6vCXMav/
 K74g==
X-Gm-Message-State: AOJu0Yxw2CVbFLDwbLTo2ux9peimzqX9CfyTa66awKxyG3KYYkO4KOXc
 izpgzzh8kfSO/WeOMWX2HfBxLB6tDtEMquDXGXGiEOGru4DShkfuSE2ShJdxFdvcHEY=
X-Gm-Gg: ASbGncsq3Lo71Hz2r0Y3JZLwdzMKs3PwqS2YMPztRJer8t/4NiFVXp/+Hr6HUcj/2Ow
 PcH6JkFfHkGnUI3opBHfVS5JyqtYBE84iVos7yXsUrIE4SmDDnLDR9+jgGn2rwal5r8MRbE+lfy
 3VBqwtuqYLmOCrsYZnI5XZUMHHpdo9ycR4C1mEgxMtRKds86y/eh6/J9aqOiPlOmRfJmmrFgA4H
 lizlrecxQKijsc/UdQC9z4+5EYoAZPN8emfhg5nG24SM5MNVPK1YSGz20wafom8lsdse8ZMQnY2
 qBS0KFgnwKB6f76C+ZuZw1+Q3xB0Q5ORyyAsrznnXemiO1VM5K/Dd0cqQbNF0a+V3GA2emHZmck
 ipYzoqIPHO5KzKQjbdCH/rF4y13FzcACnMAIMYFfOu0MlsEwowdRN+zX+
X-Google-Smtp-Source: AGHT+IHDfJnDyKqTJPZ2/lFvdFG0mhuhny2WmP2sS41wOdu7c9HW9Z3vw9Xe7HB+ExuJRRIfL7Q7mw==
X-Received: by 2002:a05:6808:f08:b0:431:5a87:9c69 with SMTP id
 5614622812f47-43b7b9aa9c4mr1775615b6e.1.1757611473653; 
 Thu, 11 Sep 2025 10:24:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43b82b059d2sm324399b6e.32.2025.09.11.10.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 10:24:32 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:24:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH RFT v1 05/17] spl: ext: load kernel image before args in
 falcon
Message-ID: <20250911172430.GV124814@bill-the-cat>
References: <20250911131414.3296697-1-anshuld@ti.com>
 <20250911131414.3296697-6-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3maZSFdxzlXx7s66"
Content-Disposition: inline
In-Reply-To: <20250911131414.3296697-6-anshuld@ti.com>
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


--3maZSFdxzlXx7s66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 06:44:01PM +0530, Anshul Dalal wrote:

> Load the kernel image before args in falcon mode to be consistent with
> the load order for other boot media.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--3maZSFdxzlXx7s66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMMFzgAKCRAr4qD1Cr/k
CmSKAQCS/K1mjo1SfH08cTNam4XD9dIhLp1LOEX6ryvavzr0TgD/XKlGym+Y6iqG
SA+JuboomsY5++dKfjbyzUuGsKmOyww=
=jCBj
-----END PGP SIGNATURE-----

--3maZSFdxzlXx7s66--
