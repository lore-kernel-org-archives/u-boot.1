Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDA6C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7784987D1F;
	Fri, 19 Jan 2024 17:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XBzcTNzQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11F2987D19; Fri, 19 Jan 2024 17:09:02 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9995D87D37
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5f3da7ba2bfso8507527b3.3
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680538; x=1706285338; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wFzZKR7WFKZUf/uBhrC4Kq77SgoVPnlxXu4coYegchY=;
 b=XBzcTNzQ0E0sYduxtetNSG9v9LbYwY5yyGrbkU1SalPP5o7RFcEV7d7yXXYQoDnFyH
 3UNwlzMFUgglIB/Ee/3KjoN7x9Ozjl0X/a3MKwpyH/aSf9i3pKT97QCOQBdzajMQ6zcm
 lR9IIEHPyUzTEWMEK2Np22osCEiVwi2ziWKvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680538; x=1706285338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFzZKR7WFKZUf/uBhrC4Kq77SgoVPnlxXu4coYegchY=;
 b=CUzAWXxZcgQUWSLdSPTJRSDekPNWD+czUn/pMZTmxgUp+Xg/fOD8zXYrw+evUKO+0n
 gOuW0tJf6MP6GAExOg4/tb2lMKTsxdQHp1r5kq9C0Bv1ut85kh8wPB6lQvVsLX1sl7Ge
 H75nlhYHWOsibbPTsI3bt33w/B26Ju6aoQxxTzK4nZ8n4/Chhlx+ASt8r1FZBAQAo3rj
 Ll/KXkd8gnJTNT7ZJl9R0y+9qTP8CNreJS9zEDKNDBrIHtEdXhLRyqTqivIyJ1J/YC/9
 efKaLMU5kwCLIodyRgku55P4qSK/Z8kofJveCxcfk6C6UDh5wW8Z6Mrg3oB/JMi9iO71
 FAcA==
X-Gm-Message-State: AOJu0YyfckCvUC7ypblLuNg8QQ5ilNh1Tdmusvn7vsh1r+1SvjuMg5rp
 nBK0FBEBbosUvbZPjwz7Ml3qXnAevMyzY2DDU3Mw/L8CIbhqf6dJbrSpaydf9u4=
X-Google-Smtp-Source: AGHT+IEV642BllhepB0bpFW/7RbD/MqXmAt2Ksa7ydwsJRZMSvRxOcZjHl/RkcWtwxUCqw3TTs309A==
X-Received: by 2002:a0d:f182:0:b0:5ff:9e41:bd13 with SMTP id
 a124-20020a0df182000000b005ff9e41bd13mr120083ywf.39.1705680538313; 
 Fri, 19 Jan 2024 08:08:58 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 bf22-20020a05690c029600b005d0fea7ad01sm7456862ywb.122.2024.01.19.08.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:08:57 -0800 (PST)
Date: Fri, 19 Jan 2024 11:08:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: vigneshr@ti.com, praneeth@ti.com, nm@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH] board: ti: am64: Support TMDS64EVM
Message-ID: <20240119160856.GT12635@bill-the-cat>
References: <20240108131650.100519-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gbF2L9tHL7GhAKzp"
Content-Disposition: inline
In-Reply-To: <20240108131650.100519-1-rogerq@kernel.org>
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


--gbF2L9tHL7GhAKzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 03:16:50PM +0200, Roger Quadros wrote:

> The TMDS64EVM [1] ships with AM64X SR2.0 HS-FS chip
> and a slightly different board name in the board information
> EEPROM header. Support this board.
>=20
> [1] https://www.ti.com/tool/TMDS64EVM
>=20
> Gets rid of below message at boot
> "Unidentified board claims AM64-EVM in eeprom header"
>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--gbF2L9tHL7GhAKzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnpgACgkQFHw5/5Y0
tyxBgAv9HczIa9y3TqcbHWg+taofk6Ej9OipqnAS4IzJa6yQjHB1hDgT5254V4DO
rvrhtWOBDjfH2eJ+Gz1eU8l58AhruhBtvweLAWRh7hRkA+0Y58hf+LwR2JGgqWTU
WXuF7Mpfzx8BIVVrpEurAjtL01KnDxAcZTgCdEDcgSmEwSjdC6a8TJ0mzawRd17V
9Pmpo0Z0CDV34Fk15wzGKvHY/wifkOF0gLCB4wmRxRW3QsZBhOp5+OieMrP2X/fO
Wc6wjVGxbCYiPqLaBjy7XtNwZ/iNSnBkN6QtyHzP+9zacKRFOjUBq7IhXRxUJxse
JL2cZI6bio8bvKapNeDnuySqg2+n9S5Wuz+jUsuFS2FH6i1NO+iUHaiXtXCGLR7Y
9DePIVdi1CoNFjJDuJZOxMqiDUJ4daZCtxpTDnMXxyRVrZkgD3wON1LIqC3Qw884
gMcI/uWchPU2oN/8SueL/2BqfPXHy5KDG124cbMOV+POjvrXeiN81v49Yku1xzEY
/g22hvgd
=Ltfi
-----END PGP SIGNATURE-----

--gbF2L9tHL7GhAKzp--
