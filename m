Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8741C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E87781DE3;
	Wed, 19 Mar 2025 15:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MHu61Aoi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7996081E72; Wed, 19 Mar 2025 15:52:37 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F063781E5A
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2235189adaeso17051795ad.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742395951; x=1743000751; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+Rhyj+QPF07F4j4Ai5vUjxMGH99a7/Ur5IRwi9VglOw=;
 b=MHu61AoiEyITaWSyp0xoNPMEYnQNYQQ2YfQMP4k2FhnPosnkA6tXgRPuQvN0yzno0Q
 edVYoCK6L1W/ppzD8XGUbvR8fUA98hZ2LV4C9cCtv9J5XzNX7EwWcIZWXDOoAYsUazWZ
 X6LDhsmt2EByKCX6MdCJeuOZE4OF4pUoDjTLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395951; x=1743000751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Rhyj+QPF07F4j4Ai5vUjxMGH99a7/Ur5IRwi9VglOw=;
 b=MgYc1PQiHH8GJnUeRbD4oiWeZlE2KsJwD8fc9lh+tO3pF5OwnYpj6+WSvFqc8Rlqg1
 ZKLUTWAWxW3Xj6fX3x4kVVDaHYCY0Tac+lCrxBj7GRIg4lGUYDwLX/F0Hsw6JFnHyZQR
 0YH584y0EjyplWhhwnF7zAHus5mh92NEAHXIxrJWQgPddZJq1FrWmPQfbW2CxonMQJK/
 bs3MnBnIEx03ijEbxQzGE4PuYwkk7FBp3HG/FHj9jcn8MiEuAPiagftorVdMia3qI8gp
 fZ0hMZtMuCDAz554m8vR2tmhEL8TIrUY0+yxs5dPRYij9ponxh2O6wcBGM0HKb0q+SSm
 D3jQ==
X-Gm-Message-State: AOJu0Ywdymnu3P2kXsvj0jxM2bti/M1xlSlvSWlFwO/U+cM+EPitc3k8
 LPW+Qr098n7Zpznw6JpV0klepHiW6/g8n5spyVi7m1K8TbWmHnzRSEw4Ht+R6BM=
X-Gm-Gg: ASbGncu6EhjUpemCA8Fhk/IxiIJFf1VQ541p/6d5zMSyRzFR+H6kDvgHBPWcCWn2NNg
 VfZqyjofj0ppo2Nz8SeESfQXvSTNFKHV/OZmffJlRfjTF/QdXx/YDbpN4+PRLqAAQLowiO6H5a1
 HUgYthJuKUvFy9Bz2whJgpBas3fdMaYSLW+eyfnAMGDlJHdP32Eaan52EIh/TYTcA4lzeeWIcwZ
 F7A8Zn4W3o6vLVM17uy4+eIoU1uJ+XapehkQt2QNDO/qauYs1FdIrJFrNQSWTsCeSd34yaNEsCN
 oDki3O/cQTZzimEY+7e4Wcftl+CDUqeoTYiJSmzUylYy9A==
X-Google-Smtp-Source: AGHT+IESLwZSrYh8yMSRQAcH9C1/wAoXrl1LTXjOiHGRP94KWotFAszTmw9i91+vKNSpcFsrprCIgw==
X-Received: by 2002:a17:903:40ce:b0:21f:5063:d3ca with SMTP id
 d9443c01a7336-2262cc2dec3mr118284655ad.16.1742395951475; 
 Wed, 19 Mar 2025 07:52:31 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd4a4bsm114959105ad.216.2025.03.19.07.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:52:30 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:52:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com
Subject: Re: [PATCH 1/5] cmd: fuse: Remove custom string functions
Message-ID: <20250319145228.GH2640854@bill-the-cat>
References: <20250319084714.335777-1-h-vm@ti.com>
 <20250319084714.335777-2-h-vm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hs/i/s2g2ddTmuXH"
Content-Disposition: inline
In-Reply-To: <20250319084714.335777-2-h-vm@ti.com>
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


--Hs/i/s2g2ddTmuXH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 02:17:10PM +0530, Harsha Vardhan V M wrote:

> Remove custom string functions and replace them with normal string
> functions. Remove the custom strtou32 and replace it with
> simple_strtoul.
>=20
> Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Hs/i/s2g2ddTmuXH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfa2iwACgkQFHw5/5Y0
tyw2CAwAomh3Cvwf+ZW6wUtBLGxetOQ9YF+mfSvTLVDbPpItkMfbkOP0gAWwl27t
aob3hOJUb7UK1Ath6vxL+wMUgqhaweL9JnmFZk8uREhfa/NI222DI/iYDc+GMs5K
EXWPclWTj2fUFmHRdo8ab9iVnBa8nAI1OBi35RiWeoufdSONolPysZmoGNyz0D54
pGmB5iPmCfENzODUbA+nqrKYPoZyVOKbFPV37QB/oz+6x08WOY3U7ht089R4ZL1d
wSZMUJfOkcoXp6zywvoyk9c9jGPMLhyF5NvX5vbQ1npWNGFo78b7x8/Fcg2Ilwl3
Le2GtsMg8wCapHa/sC0SXNPIgN6BffbVzZ11Gn3cjdA+W/6YK6Y+y5yzpO4ONjWe
sMLvQQnonTIaU4Pnde7Je6/a8diLcmQ3pVulG+utsqPZMw3wu5FPNwMrGnuTa7Ya
5DM6pgHDMX3moTckif44JPApYUU/YEVAUPC+B/GRAOHpzYgKzvZOqvfN/Lz5tgAd
4vZopqk/
=vG41
-----END PGP SIGNATURE-----

--Hs/i/s2g2ddTmuXH--
