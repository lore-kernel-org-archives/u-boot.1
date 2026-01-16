Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDA8C982C7
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 14:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CABF482BF2;
	Fri, 16 Jan 2026 15:40:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cLIMpRql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA5C583015; Fri, 16 Jan 2026 15:40:31 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9432480077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 15:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7cfe2a6bf81so239755a34.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 06:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768574428; x=1769179228; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ORATuPhShUyWlaD+b8LfSXql1TiM16XL3e5Bf1Fm3hc=;
 b=cLIMpRqlWMWGmuMFcAkdBfhFrS2mwvu2v7uiDtyAN3k+F0vaqrVIweoScNRPAB5kpJ
 0WuQwyt65mR/4RThnHqvc4rrjmh2phtyxxhI3vhF+Co7vcSRtKPUtX4IIoH1NpgKVZ5k
 PvPoHNyZCpdWVgySlMnhIhLYdg5zz6Mt5hww4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768574428; x=1769179228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ORATuPhShUyWlaD+b8LfSXql1TiM16XL3e5Bf1Fm3hc=;
 b=eE+5Jov53ylx7CiEf8Ms8yLl3rJ5uddP9r8qkubLvswF1UcvSEv5tZNzh+0x8yJIaO
 6t90dxBoAR7vlNVnaaxFQ7k9z38alw3Eh4xj3OslnmYkB3QtlmTgE0EJwNhcQdpnSfJB
 VjONzlRk1gRUn/jb3I1OF7G3xJeDqSpQo6c6QzNJc7LsEKpN5WAIc8z2nvy+h+iyiB5Z
 vxJZixQ6Ge8Vx70fZnbECWCJPMb4dixf/6MlZ/7YUm92V8DuCORNUh2LmDcP2Ilip6Lo
 2mSf9l8DHiPh34eLYsA7LEbn/y0hfjvRSHn4FwaZLP/muClDrfOqnTkOucDTP528jc8t
 3c5Q==
X-Gm-Message-State: AOJu0Yx7hR+S3JdA57C1fgbF/hPB83xeGJualyoCjJpMkzguG6n7YPn8
 KV2H66Tf9l4SBKZ+zTsu0q0HIS3lqNZKAUyRkNLBIkpWANggweWTES9+Bz1FjXm7nFE=
X-Gm-Gg: AY/fxX7I2wsxhhP9v6gDD31XerJ2/HvISYavs/kZN1F22Ag6o42JDLolRL5W24rQBzC
 PPw9T4RFEe1YvUCFZ8fhvhnuD/p1w/YykFsvL4XdLovA+ZRpoPcH1zLqc/zJbbK89Xsoa/aINdI
 t6dj2UKjK2B2Bn/fc4UKBb7EmdnDqBZwZCwyOOl2jh/MJ34GdwYiBRQVtRtSh79jDteUhJClnxi
 puJv7xeu2t4x0lAZP4TAs2Bl20THevQ3P4DcDXqBqN4u9OP3WKR1gbVuUNP4d0vfWnnqpHX8azt
 VymC+SSx/BI3I5DF3MhG1kstp5LxcjWQKh3+JTOztbUqyZAzA4QoN+o0sDwt3JzUWtOb4Wz19yy
 hKJDcGEzKYeqSvgNBQmr4s/LwCgFzuuHDU2QAehvyh35F+1g+8HnaTcRT40Pj24xGCnoRcg978f
 RCqP9bqvwbbLwdCcCxXOHo/jPJAvnufCxcx9gU/WnEKQmsY1FFc583XqL95VxmsAVFUwV4lSU9n
 0J2vk5Uj8nEWiphWSPiug/OlIdaf3Lf35VESH4=
X-Received: by 2002:a05:6830:82ad:b0:7c7:5907:b1a8 with SMTP id
 46e09a7af769-7cfe010e938mr1243225a34.13.1768574428266; 
 Fri, 16 Jan 2026 06:40:28 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0e92d3sm1789225a34.9.2026.01.16.06.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 06:40:27 -0800 (PST)
Date: Fri, 16 Jan 2026 08:40:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Joel Stanley <joel@jms.id.au>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
Message-ID: <20260116144024.GJ3416603@bill-the-cat>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <CAC_iWjLUX38Z0ucpN37EsKE8T8w+Qw5hpteFRm=5uaf+Yfnv7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G5A4pwRfX5qfSIsK"
Content-Disposition: inline
In-Reply-To: <CAC_iWjLUX38Z0ucpN37EsKE8T8w+Qw5hpteFRm=5uaf+Yfnv7g@mail.gmail.com>
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


--G5A4pwRfX5qfSIsK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 11:59:49AM +0200, Ilias Apalodimas wrote:

> Hi Tom,
>=20
> arch/arm/cpu/armv8/u-boot.lds and arch/arm/mach-omap2/u-boot-spl.lds
> can use the same alignment. Is the omap2 case covered by the TI
> patches? I think it's better if you bundle this up in this series

Correct, the TI patches fix omap2 (and a number of other platforms, that
linker script should be renamed, it's the sram+sdram SPL case)
platforms. I mentioned needing it in the cover letter btw :)

--=20
Tom

--G5A4pwRfX5qfSIsK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWpN1QAKCRAr4qD1Cr/k
Cp0VAP9n2iqI/jE6n+WWE4jmWuQX4wxCo20LBEtTpGfbIPK4FAEAiwG5XtFFps3r
eBSzwrkgPj9S5+nF+O4CVm173HY8pwI=
=+MMw
-----END PGP SIGNATURE-----

--G5A4pwRfX5qfSIsK--
