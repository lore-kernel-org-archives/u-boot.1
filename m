Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5623C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D4688043;
	Mon,  4 Mar 2024 16:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UQ/MAWiA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A3E788042; Mon,  4 Mar 2024 16:28:04 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ABDC88040
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7881e45ccb5so187807185a.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566077; x=1710170877; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+uwaHUKjmFHQBAWSTTcNHyEi0v1Q1D8l2ks0KzzdO90=;
 b=UQ/MAWiAGAABsIhU7qgaS0jsdG6BBsg3BNRt48fZijdS+t8MzAuX7nGuEYw/CA4yHT
 A+YhJ543hxWbTt5ncUzFc2q7ZpaPuTRbkCuTifIMuK5yaO+63o02uH9J+lmIVTNmk6lw
 LJfOn5TMuqm/fm7e9Mh9Vv2gNBQdpBRltRRCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566077; x=1710170877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uwaHUKjmFHQBAWSTTcNHyEi0v1Q1D8l2ks0KzzdO90=;
 b=u11v3wOm+pMxunkDEHBnO/fpkhVctduceeSTewfDKVpsdVcbdab2cJ8A6JU2R97ZDI
 Bx//vMUeA2RpConmnnjdsbv2/V7mScWHHnqXG1UfIOjfYIhE9JLvvz0Gl/4jWnHDSD17
 eyH08hJ5k29XSM478Ch+9uFm4tAD0HoXtj4JJn0nI/sicrz0Pj6q9A+gJc1e5pfUuBIn
 RlMIBkvhnlSkhJTkgcZ+SbNBbeO4lFTgcC3t2/UHnTc+BG/u7hFKfHCXIwXtsEn/5y5E
 Rm2yRUbmjIyeo7kU1rFn8IxFLU/XHyY5uH3vdVx8sezzGrNlj3hDljj014IQMv8g1ou5
 TBgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaZHBxrooR8BtcZH/P/eTT6Zy+ji6VX1KNbreenrzzSX1c8W8PGHn97QxOq2diehAK5l3nqJzywV5hD/4pA3haosH4oQ==
X-Gm-Message-State: AOJu0Yw6y5ucsf8mB8naNzz9gBt/eHEQw/O+Ymsc2Lvf/YUvkJQyLCwL
 nVUQI7e73PnNRhcSCsdx1l8i7MYYxrZnaDRORqy2GyuAl4ZLDGKNZ69fk74LFNE=
X-Google-Smtp-Source: AGHT+IHF876t80XWppK/NlpzetTMzUyA3PlTQyXhh7PdAxua8v9j5T76fV/y+tHaXiT4WP9zkfqYXw==
X-Received: by 2002:a05:620a:471e:b0:788:22ad:c880 with SMTP id
 bs30-20020a05620a471e00b0078822adc880mr6591225qkb.5.1709566077008; 
 Mon, 04 Mar 2024 07:27:57 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 x10-20020ae9e64a000000b0078803b1a3d3sm3816541qkl.86.2024.03.04.07.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:27:56 -0800 (PST)
Date: Mon, 4 Mar 2024 10:27:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Luka Kovacic <luka.kovacic@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Lin Jinhan <troy.lin@rock-chips.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Grzegorz Szymaszek <gszymaszek@short.pl>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/1] rng: eliminate common.h include from RNG drivers
Message-ID: <20240304152753.GX1523872@bill-the-cat>
References: <20240212234448.39552-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fL5JQseD61u+N1pp"
Content-Disposition: inline
In-Reply-To: <20240212234448.39552-1-heinrich.schuchardt@canonical.com>
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


--fL5JQseD61u+N1pp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:44:47AM +0100, Heinrich Schuchardt wrote:

> Usage of common.h is deprecated.
>=20
> * Remove common.h from RNG drivers.
> * Sort includes.
> * Add time.h to sandbox driver.
> * Add linux/types.h to rng.h to provide size_t.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/next, thanks!

--=20
Tom

--fL5JQseD61u+N1pp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6HkACgkQFHw5/5Y0
tyzw1wv+JeTwaJaK5UzvL9LWZGDQ6/R6461oWelyXMgFp4x77sm0nxuf+brduo1y
LbAX7tXjPBeeq6TsHfrQccvy4iKbfYg+GhyI4QjEiL2i2uPr2D/Gu7nACz1YQ/5O
+FUowtLvU2RsZj1XnuuX2flY34DSx3pmdK2Ui98Thd64NqK4xZFCL64dU3rhl62P
T7Obfq5s+7+KhI3qFyxI/BWUQu3O8tzaCrZjIEsKm/Hyj8ZzB1r4zinWZPX16jmi
Cs2fX/P61197NBEha1yDyL7JqP8TUfiUfSosi+OAIajmAO8ZDERT6lrMQNIKc9x2
/yLad8rDHG8VKhwP5oUo68xuh02+E4BGDgYItGYhYKO5R3k+ZZw0io7S2khvurmB
xo/Ixde5EERYzsr7EDnrBYDzIrLPSW4S/oAiKBifu1ATmtPvnjtbxKUhHFwTKsVn
EJQvbfLVuM7OM+gAJEptBLqAiO4EOWNYKnrwJ9Tk0p3ELJsgKjtHy3Meigp67ktv
WZeDTcv9
=TUhl
-----END PGP SIGNATURE-----

--fL5JQseD61u+N1pp--
