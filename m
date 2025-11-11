Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD21CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 14:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B5A83B97;
	Tue, 11 Nov 2025 15:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HhDm8rqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A870883BDF; Tue, 11 Nov 2025 15:42:48 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8338583B95
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 15:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c284d4867eso1154679a34.3
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 06:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762872165; x=1763476965; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NCycZxtOLBJg8NwP3r3ApGF8aGio7f6yqCqOI+dHZTQ=;
 b=HhDm8rqOZpROUj8JShKY0j2ehk3E+4VyAbIaY1G7OXDbqknEXMdRlzwl/P/7HtmGfS
 6UABZQciZZz4/mYMc7FXTw/N9MY1i7CHkbspNdQT4awoQ37m7Xzio/9RHQ7Ie+57/xyS
 fgpfc+vNSjee4ErZO5MoAHbYv6MUm36mk3jRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762872165; x=1763476965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NCycZxtOLBJg8NwP3r3ApGF8aGio7f6yqCqOI+dHZTQ=;
 b=UtXLGEw7S8kb5i3Q/OPrUe2SFeuZLHf2XDVeywWKdN2M6gtUPHBseI4IZ0k68JV+20
 2IThEsWBOVuqkq0lqLvPvGXaurmpSPBQvpo8C9ckktjchcdq9jgUMsPh5F+LS8Zbb+dS
 detyF5q1Wz7PsUruhtOVm+lnZDWA74r+pJMOUmx0uCrYhY35ehvWnSv6Am2694dPySmp
 FG64BbahOIQ0fk3SR2rU0Z7x5do8ci7wbcd/htGLT0Tl9HIwWpAXGQINHmMTtZWgdXjQ
 ggnncBMROshGLNl5npVV8jYm39NhfyKOC7SAhwWg02dOGkSBcblWsTUC9ZiBZyY8NwPr
 hswg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZgV3bCKNGGnuLCuSkf9hcHHrAFupvc8LhmwBAqMqvYsWWIZVBB4jmk55gWqbFwXiGRdViV70=@lists.denx.de
X-Gm-Message-State: AOJu0Yyy0dnK4SXoDjuLcULHCyKJvf81PH4g5LBioDgp4IIfaTDS9EyD
 LkBqFu0X2bj2wdeKHniC5LAuo/Fn3qmvospP1a0jVV8Q2ZBSYW/fhJpDd8GEOwP+kok=
X-Gm-Gg: ASbGnctyzwaFEuWtyN9o4YZwh+MaTo1YwSeSz2Ck3xh56T5kd94LSmUlUd5m3Cw5qkz
 nmsTGmdlf2U5uEUUaG0diNN+AI4qIRePwbW5bxvwcDFQ9TYdnZuF8SVMbm6sxYTGx6zGNpTuxTo
 Z46W//tv6gXROT3qO3WYOJ6DBCI8shgOmf9CYgGIRcZnpvuFszfdje3WSLIgHXQUb35RnaToeko
 GccynSz9P17JJReQheFkrvVHwngC1FT03vuGAMEMMM1Q7e7iVx9AYkp+cdRbFY9zqJWgm83GdI6
 fUF6eUhMWQrTzB8GTUxku0mkmOWA6RmOncWiaYV+mk2AmcMi9+pnGcdzYoTC7wIswY6Jr2z1a4H
 DMldjZW8RXGOnhzO/y8JDHojBgUKvOV9qYQUO+BhXXhnk07qfVx08bnxlDbHYqM1wj2LIqWDXDT
 TiPLNSl7YxcS1BU/22szNmpmWJx7w7YljRGLTpRreQ2Ahzt6jntQ==
X-Google-Smtp-Source: AGHT+IHgKwjtWQTQBG2W8VOm/g8A0UHVI3YBDdqovTw9mQWyhBjJ0Goa+qDqkcwwCsBeU8+95QJCtg==
X-Received: by 2002:a05:6830:2a91:b0:7c7:dc3:d0d1 with SMTP id
 46e09a7af769-7c70dc3d3admr3922538a34.36.1762872165255; 
 Tue, 11 Nov 2025 06:42:45 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f10f7ab4sm7017598a34.22.2025.11.11.06.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 06:42:44 -0800 (PST)
Date: Tue, 11 Nov 2025 08:42:42 -0600
From: Tom Rini <trini@konsulko.com>
To: "Ng, Boon Khai" <boon.khai.ng@altera.com>
Cc: Nikunj Kela <nikunj.kela@sima.ai>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Subject: Re: [PATCH v3] net: xgmac: Augment mdio read/write with cl-45 format
 support
Message-ID: <20251111144242.GV6688@bill-the-cat>
References: <20250829041232.1160655-1-nikunj.kela@sima.ai>
 <SA3PR03MB7187A45D6B0588067C348FDAB406A@SA3PR03MB7187.namprd03.prod.outlook.com>
 <SA3PR03MB71877E9BB24B98DB4120000BB4CFA@SA3PR03MB7187.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LpgQhExvqZhqKJKH"
Content-Disposition: inline
In-Reply-To: <SA3PR03MB71877E9BB24B98DB4120000BB4CFA@SA3PR03MB7187.namprd03.prod.outlook.com>
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


--LpgQhExvqZhqKJKH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 09:31:23AM +0000, Ng, Boon Khai wrote:

> Hi Tom,
>=20
> Can you help to take a look at this patchwork?

As it's socfpga specific I've re-assigned it to Tien Fong Chee now.

--=20
Tom

--LpgQhExvqZhqKJKH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRNLWwAKCRAr4qD1Cr/k
CuYMAPwM1R6bnE/xUlWTMJrxf86+STAIdz3eZw3zwKcfucCupQEAlkUgYJmn0qww
eF4EuYGs1L/2H8+eT1X3oa1l9i3UDgo=
=9dy3
-----END PGP SIGNATURE-----

--LpgQhExvqZhqKJKH--
