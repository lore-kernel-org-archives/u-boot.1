Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B765C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 15:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A49F87D35;
	Wed,  7 Feb 2024 16:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F6akCb3K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56BE187C8F; Wed,  7 Feb 2024 16:45:24 +0100 (CET)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62ABB87D26
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 16:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe592dso331957241.0
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 07:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707320721; x=1707925521; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r5cJIS8b2t6d/V9gqhI1Fnv0PoR1UPdCF80Q211iuVI=;
 b=F6akCb3KDl0lLf98UANITxZjZEDdx+4C6Ni44X+GhUqw+CIc1VXMhBaanB2DTqflRJ
 Cu1xndcrddx9NjmeToGivq7+RVpYCGYBu0OPS/9cou0U6jxQF2xYI+LfmSEw/dBbAVfP
 OPtM25s6Mj0DZRBMevTheBxKRomhkR2tGYIAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707320721; x=1707925521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5cJIS8b2t6d/V9gqhI1Fnv0PoR1UPdCF80Q211iuVI=;
 b=VRl/o2xgn2/hwoHkkq1pl3Ir16adA38+aBfyJIs0LQa0JxxJ7EnJ/ykgFDSLdos4YU
 nWgxJf0wq9CqpPfWF+XBuLk7IvdoGCcnALjggh3hEYmuEzTvew9BVu59Dn//rAw89Ykq
 HKAPK7xe5cM3F6icvDwvg0OI45eHMa/bNzf4uBZRWJHum2TwgEuImlfD3ib81X93ylA8
 kmD2okgol81uwa3uVb3/vzb+ZkQiAlBDDvyWSFOdECnaIGLcF4pbjB8g5JAP8TYMN7uE
 rJbWK9FY8/UUHDH+epim0rRdHbMr9k9TYn4bknRi/7BsLI5v5DQ3ZeBQ3TyXoX5a+3pZ
 peIg==
X-Gm-Message-State: AOJu0YyJ6n+j7GdC8UWXwSMJErWzQf5lSEZW+hKzMJng4cX0Pd/16OFb
 ToxzxGFxTGY/Kp9EiR6abpujWSFXeqeYfI1y6OZAbct+0iAqy/FjiY6rDZVluCQ=
X-Google-Smtp-Source: AGHT+IEMZ7Oit4z/UsYhWJePE9jMq6rcyNB+4E/EuHFi41riUhiykg1SSJgCirsuVnNqsq/sAarB3Q==
X-Received: by 2002:a05:6102:4426:b0:46d:2ba7:c531 with SMTP id
 df38-20020a056102442600b0046d2ba7c531mr3406203vsb.6.1707320721049; 
 Wed, 07 Feb 2024 07:45:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWVWNFbUHqqfdUl38hTAL2TRWWNb6TSDWBj9TxPsnmWwLS/NG3ueiIKr3vmwkpUpx+Giz4FcZoZY/Q=
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 nw3-20020a0562143a0300b006879b82e6f0sm692904qvb.38.2024.02.07.07.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 07:45:20 -0800 (PST)
Date: Wed, 7 Feb 2024 10:45:18 -0500
From: Tom Rini <trini@konsulko.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V5 2/2] firmware: ti_sci: Add comment explaining the
 is_secure code
Message-ID: <20240207154518.GG1152441@bill-the-cat>
References: <20240130145959.879882-1-d-gole@ti.com>
 <20240130145959.879882-3-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pQ/Uof3oBqULb5tU"
Content-Disposition: inline
In-Reply-To: <20240130145959.879882-3-d-gole@ti.com>
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


--pQ/Uof3oBqULb5tU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 08:30:00PM +0530, Dhruva Gole wrote:

> Add a comment to explain the code under is_secure condition of
> ti_sci_do_xfer. This will help avoid confusion amongst people who may in
> future touch upon this code.
>=20
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--pQ/Uof3oBqULb5tU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXDpY4ACgkQFHw5/5Y0
tyzBlAv+P9QQvYDVM7gAL7eOpr6Ny21rEaEGXYFcvGooKIV2PAVT38CQ/hKdKz8p
OOwCrYUOmzJxEt4MQIaoctak9G/EUxQfeHevk7rP78TZgM4tPJ4WLdjCnWVbOxz0
YF3tI+MU2LdQAKJI1MXH8twaFRyUw6OQgyQcf03ohRuvvqz0LMmVJTLnUT6q/1nu
qjtUeXhrenj6yaANFs24tU0H/Rm1ATFFo9RGN58DYI4pIPa2nMTGKGaOIXTYydLY
aFmYb+8HxUf0f1OKYmwi2izn2GfShIPcQKE29Wg6RNJTN/CBe2dQ6zuMCGEsmaV4
XP+2ZkBS9Jd4ikdew7ZC/sj01JDzroTUStfqygLKf1c9uPJncduUzclw2vOS/DIy
1NxVlAAuo1aZ/UI946Ds+/Gw7pXF0xCiBEHyCHePA1Uqrtd9GQFTfTx5yZwZXRCH
IfJN2lW6UnsXj2hO3PnriK6lnJTYmLDjOLbTLXoHQbY4ckv8wlwi8osTXAhtECo4
Ycrx6FRo
=0WNw
-----END PGP SIGNATURE-----

--pQ/Uof3oBqULb5tU--
