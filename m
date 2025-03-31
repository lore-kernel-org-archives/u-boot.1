Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046A7C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 15:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 774CA8129B;
	Mon, 31 Mar 2025 17:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EijxjgGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 908D18171B; Mon, 31 Mar 2025 17:57:08 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C2A81026
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 17:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3f8ae3ed8adso2707211b6e.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 08:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743436625; x=1744041425; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=edWBWPTHDrbrbZD6PQYhdMxIqQR7ajF5ukK1EnABukw=;
 b=EijxjgGSEgzQphwUlvfAu5ZQrQ8gqsDPJ9/NhoVwg/AtkqqZST+tZGerWFEEcoDsfd
 NnXN5Ubda71hx8D0ZV+B59BrPFpc3Ia2y9yxs4E3tWCyQgja97HEduVxy8rt542x21hP
 YUsDk7NgPMDOpfab6UDAmv9i3uSx7T2AEy1VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743436625; x=1744041425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=edWBWPTHDrbrbZD6PQYhdMxIqQR7ajF5ukK1EnABukw=;
 b=s9mGZnH9gRqjOlcyi3NU/K37qtTUTCXk2BfYlgp0IFlQo5q5w3Fk4EoXWgTKMbH18s
 AKYIJYiAc1I0xNQdS+ccT3wy+GSToBgmz3N5/O03YWTwS5i/v+gd6mX4pHsUC6cMZnY8
 k2W0iFzXZLsv3h+gtG5mFQXcX4YMTsB0XTdoU7EPNU1FSLRUHVvA04ZxkEUWFKkLN5Mv
 oQV12MDCdUJEpx0sKlOkvaoLapG5mwGi9QUCzCSXicP3QSLWHFQHxlp9FnMU1C4VQthu
 WahS6WKKlcXSDKtdmOqdRX/rCQ5FDIsf1ZLg/1sDv5WFZ+asYxyGFLZiRsIjNIcSFzA0
 NFlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/aHZbx50OA2J107ezqGbfIxOJrK81hg0Lor6nUbV2zNIfu0/oyZiF8SdJRflMNox+HMJxyaM=@lists.denx.de
X-Gm-Message-State: AOJu0YzBNfK1dfd6YFbxN4H6NyRRkhm98oSslFhnGpbvlAv+12zVH8RP
 1k88gI5BPPfCdYp1xrlqtsesbq0IcdJdeMrfxkRhFbhTiZPCs9TvkwmkVQnAkLE=
X-Gm-Gg: ASbGncv0+jjhrAUnyyeFm0eyHVuKpr0+IceKA6j+kAihYyilER2fwN/oT5PsAgYKn/2
 s8ZYbi2Yu2T7tuAOeX+iT/R2VEchbEJYA+n8BK0j3lIbaGeNbzgCb8RMYpHOK3S36RM08htHyZF
 hw369tV5zDwWrYGolzwDhnLfbAG8olbkdgNh6jRCflGI5KQamJPJKLjv6uZkN5qEX1PLNusdWyx
 iRLSj1P38ZuSZR5EHx+b5Us1Ao4b/rJ7ClH4ugeBBa8xB0er+AAwga8VWQdo5wUgMiNSW3fsvc6
 HvZDie8TwQs70FF3z71NHGBM+U8gjdZtbUi1azX+VLM0uIUTpnlkJaWHp5MUcOLumwGU81xSPME
 bFcrb1w==
X-Google-Smtp-Source: AGHT+IGTGLSf1MkmJHREMl8OPwky9Y2uH00DlRgRCvOiCBgOUve9xheEuMLlo5a6JoEaUs2z4iftsg==
X-Received: by 2002:a05:6808:d4e:b0:3fe:ab9b:1a93 with SMTP id
 5614622812f47-3ff0f5b4670mr5369225b6e.26.1743436625031; 
 Mon, 31 Mar 2025 08:57:05 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6028452714esm1515397eaf.24.2025.03.31.08.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 08:57:04 -0700 (PDT)
Date: Mon, 31 Mar 2025 09:57:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 09/18] usb: xhci: annotate switch/case fallthrough properly
Message-ID: <20250331155702.GZ93000@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-10-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BwPsetSJh033NcnQ"
Content-Disposition: inline
In-Reply-To: <20250327153313.2105227-10-andre.przywara@arm.com>
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


--BwPsetSJh033NcnQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 03:33:04PM +0000, Andre Przywara wrote:

> The USB XHCI code uses an implicit switch/case fallthrough to share code
> for handling full speed and low speed transfers.
>=20
> Add our "fallthrough;" statement-like macro before the second label in
> the XHCI code, to avoid a warning when GCC's -Wimplicit-fallthrough
> warning option is enabled.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--BwPsetSJh033NcnQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfqu04ACgkQFHw5/5Y0
tyyQCwwAlhkNgmy1daZaYSpGeIK1pTCUez+gCbr+l20x16dTcYkw9MhhP8GNy19g
F9+S2RUFcFH60LBzsWfBwyVJHL6tvyP2NjohwBrvbX+2V/JAHKNAqDMubPi5nU+4
ajnpbibhelNCfihDW6brHU37AAgfa0bYwrwXuGQw6nBSzyMQ7LwEPfP04wKcNhVh
dy85bGQQwJdy5tzfdk6JHZdTJNfID4yhMEaQOmNSGWeqV+1gH18Wr+09+0KRkUKI
Ien1LN8gwlzczbNJ9gTjURL3NISX9phaBfkUAgUBCOc1acTQ7qcc7+v14+lCWxGA
a9S/33fsbHAulp9ZoSS/Xfq/9EfQ66belZSvPXvx+y+GTShIp7SmaeXPyIeI4D2p
HPQRXswUc9oBY5luqYeUreTNmEu7Z0/fNtepyGhgDf58GfnKCeFLAzvTrP6rQV58
pKOhD2VWx0QyuZAJJORLQL/D9xHh1Yg8rjythwI6g5ER1e5RVUOnUkZLQe/OubZ/
RLg6T9QT
=3G2f
-----END PGP SIGNATURE-----

--BwPsetSJh033NcnQ--
