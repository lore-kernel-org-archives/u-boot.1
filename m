Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA78C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09BAB8802F;
	Mon,  4 Mar 2024 16:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cf7VJ3qu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C39C486FCE; Mon,  4 Mar 2024 16:29:22 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9749088176
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-78823b45e88so48018785a.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566158; x=1710170958; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9oknl9ROvL95E3hySUd5LOW44bU5s1N27vgn9Q+SJDk=;
 b=cf7VJ3qucTguIfVYiirt+1MBzFoNZ4PcSUGpA9IjOo4OFrJI4y90aJS1hd1QhIDJyM
 aqr/ftOgk/7VleSxLfOvcCqv5Zab7qVs345p4xs55FMYkmdv6zp1hW+4BT1lIwWe4ari
 /RLq7tvhvtCQpGslGe9ZXQfcompmgUopebEYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566158; x=1710170958;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oknl9ROvL95E3hySUd5LOW44bU5s1N27vgn9Q+SJDk=;
 b=eLEX0TLeNkTYTS3awiOQ/9a59JKmKbMxe64eElOwt2a5GX+TPk5VkH3pfIufcHZ19x
 Qlk7Gn1/i9jGDZX6ssvCJhZsYj5NDYrtGZ4ThKNLvtcn0kVPS4WRzndUSqGK9OjU+5ce
 sWzGQa5VpqMlZkXM8N6Tv0EtKrrcz+ao0pZVvjw+bd26bHZTG0RGOQR5l+yhepNC8mD4
 JA1OPxcxG3axq1geKUysmC+Iy0cp8rGUAtWigK8i/plu867784sBjaZ/QaYDnrwmfc8e
 dVfOFiOpxciorFKyQoKInUrubTwuWVwG75iEUqJFElZje1TM6oaZ+CV6cGy6NK8JNO9Z
 KDcw==
X-Gm-Message-State: AOJu0YxLLGbjBkLDRLcDmOZv4FIHFcgk2qRF3HXPDh8R5PsBgGQIDiac
 BU3LCy3Xj7ZrC4Q4KKiS8DIXymX8MERzqp8LtIVIue7kNTVOAEOM4UU8Vy7qeJs=
X-Google-Smtp-Source: AGHT+IE+z90xY2BxtditA2Wnxx6S4PMeJop3sDr4lPdksK3GCpzuxYAtRTfc4ykFyAnkzegV02OjmA==
X-Received: by 2002:a05:620a:5e02:b0:788:193b:1283 with SMTP id
 xz2-20020a05620a5e0200b00788193b1283mr8164093qkn.19.1709566158461; 
 Mon, 04 Mar 2024 07:29:18 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 y8-20020a37e308000000b0078823dd535fsm1574007qki.112.2024.03.04.07.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:29:18 -0800 (PST)
Date: Mon, 4 Mar 2024 10:29:16 -0500
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v3 1/1] Makefile: pass -undef option to cmd_gen_envp
Message-ID: <20240304152916.GL1523872@bill-the-cat>
References: <20240223114206.21720-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0cZjaBUr+8ourluk"
Content-Disposition: inline
In-Reply-To: <20240223114206.21720-1-sebastien.szymanski@armadeus.com>
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


--0cZjaBUr+8ourluk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 12:42:06PM +0100, S=E9bastien Szymanski wrote:

> Without the '-undef' option, the 'linux' string in .env files is
> replaced with the string '1 '.
> For example, in the board/armadeus/opos6uldev/opos6uldev.env file,
>=20
> kernelimg=3Dopos6ul-linux.bin
>=20
> becomes
>=20
> kernelimg=3Dopos6ul-1 .bin
>=20
> in the include/generated/env.in file.
>=20
> That's because 'linux' is a System-specific Predefined Macros. [1]
>=20
> Pass the '-undef' option to fix this issue.
>=20
> [1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/cpp/System-specific-Predefi=
ned-Macros.html
>=20
> Signed-off-by: S=E9bastien Szymanski <sebastien.szymanski@armadeus.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--0cZjaBUr+8ourluk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6MwACgkQFHw5/5Y0
tywzTwwAm7tq1IGTsOCe+SvUFnjk3P+0nTIIgZrqASfXeSxo/RRffMIkQnzycGl1
/Zhf95lSJUc8CdUkSpUZrxO6RoWrOM7KaG+W0GK9ePLBS8vjwZThXGZ2zbbxL5c2
5m5/BYVSFAFwS0VPzf790R6d2gMSesLpqX09F3yc1pGSpV9MDx4YRgPhs9qfI6DT
UKAt5kmIwD1DdM4dXLDagX8LdrCn1YogXDy5Ha0bZ54wLnPM8+4sBXzrSosel3SA
sQuBmFQABA0JyGvZETfB6pWcpfBAwIOjQ3JGWcNiKUZtAMdthrAm/hoSsn/SPaP6
pAde4bDKsKtyXz9a2xnlY3I44yEKFHTEcsoc7RCp6Sj7I7jAk7ZRJx7ktxcntMGW
+W2vENmJ4+IhSshsSEkffCKF9sUZzLHhRQSiHSZhhJez8F0btaVwXuVxezrtywFy
hJZeOB83GFxGzEJA65YHODof9JHwwDroKsF299lD34ZcCyxBHds4aOdElcOmY/a7
79RkM9Yf
=LkPw
-----END PGP SIGNATURE-----

--0cZjaBUr+8ourluk--
