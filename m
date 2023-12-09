Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E942EC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 15:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD2D887692;
	Sat,  9 Dec 2023 16:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sSAC2D/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E31D8764D; Sat,  9 Dec 2023 16:49:06 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 111D0876A6
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 16:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5d3efc071e2so28472197b3.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 07:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702136943; x=1702741743; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iL0VUFkHeOJuLmetdpMiPrZVEV8o3kakpGKEmUR4aIc=;
 b=sSAC2D/5YMyS1hdXICiYl8eXs8uQB7rpJPLi6icERZmP6w0rCNtRPNsiSjVvvA7EqD
 qQit4JAX/iF80XSt+WzY7CSSDLA1WiUCqfjJ5xWPC3GqbA4D8B9fDfDvoqT1D+BhjnnD
 uOLiMDsP9H9fl6XaRzYpWW5VJXq5FrOh6DGQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702136943; x=1702741743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iL0VUFkHeOJuLmetdpMiPrZVEV8o3kakpGKEmUR4aIc=;
 b=oaB/S0t4H+J8cZ7zVAOwjl3ozgmt3UUu//ACzBpC4pCGS3y90ES9zD1r2p6UuJcKD1
 YZxwkMu1P5SR7X6dRjqp74KW4cqsZlB5iOTr0cY8HWSLOKiv86TIC8lPET6/N8p+dK/g
 awDO6UZeHMjTeKmPgnR24XnCSW02lvq5J7m+wvZEcShkRQzmpdZZX9pvNY0pXyYwf2DD
 Ny+6ebiwACyZ5rHxMN+uCrIQ+dKDX5JHaiX4L7eS82KQv1tqye4YcUHUpnW2q/PnXvbe
 urmY+kv3bn2kh54+NlRkS4x/pFFFhmb7KWY7nKZQ/0mMXBQ8vrKKgCzSAQeerRxfbEtF
 2giw==
X-Gm-Message-State: AOJu0YyYmvHuBCqM9afA4RXbURJ0X4Yw5v2hbOjc1M37pHha6AJsQ9kM
 7DdLvcbcTCYIsae0Z4ixery8IQ==
X-Google-Smtp-Source: AGHT+IFt/nNbiyYJ3Gho3M6I2m++h7F+Sh6vWgS3Yx0Iv9H3eVgyL9mdaIOKqTl0QxobpwKHCdbaeg==
X-Received: by 2002:a0d:f846:0:b0:5d7:1941:2c1b with SMTP id
 i67-20020a0df846000000b005d719412c1bmr1335104ywf.72.1702136942779; 
 Sat, 09 Dec 2023 07:49:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 v78-20020a814851000000b005d418758bcfsm1549221ywa.93.2023.12.09.07.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 07:49:02 -0800 (PST)
Date: Sat, 9 Dec 2023 10:49:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rick Chen <rick@andestech.com>, Roger Knecht <rknecht@pm.me>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH 03/13] x86: zboot: Create a separate ZBOOT option for
 zboot logic
Message-ID: <20231209154900.GJ2513409@bill-the-cat>
References: <20231204002944.897949-1-sjg@chromium.org>
 <20231204002944.897949-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="04m6m4ZR1pKRYB8t"
Content-Disposition: inline
In-Reply-To: <20231204002944.897949-4-sjg@chromium.org>
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


--04m6m4ZR1pKRYB8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 05:29:28PM -0700, Simon Glass wrote:

> Most of the functionality of zboot is contained in the logic which
> handles a zimage. Create a separate Kconfig for the logic so that it can
> (later) be used without the command itself being enabled.
>=20
> Enable ZBOOT by default on x86, with the command depending on that. The
> existing 'imply' can therefore be removed.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--04m6m4ZR1pKRYB8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0jGwACgkQFHw5/5Y0
tyzrhAv7BGZf82AxE5pgdloRJqn5T9CPhL6XKJfzuM38LllRQuJ5EAkvUY7H9HdV
B9iaeF2OHHS0no5fx2wk2MKGEAKWUxd5TWLf4oo5JoMauibE0N0jS8PuGwTW8ygP
hYcJEVOqQJgjJp+b2t8ADpRmEa9K4hbcs1BUKWHMMKEg+fnpWDGutr3rq88PI348
yaaN7KKmFzIHOW/45CkAc+Xz5Fk8HrldgJv3qkg5I1oF7V5Lgww5H4KhaMH/tZY+
myvOOSuXSRyXmQmRmVBnXVCZv5nGnIdpjrOzkWRUBF28HWBKPfNgPe8Rmhy6aO3q
R71wiLAG+sbwXzfYQoKI+ZJyJ45+MXE5l2OBEyyePUR3rRRw8IAamkkLdVHyocml
+jALN+bPNvohBlTsD1T+2uqF6S6wJlR9opJCE1ttmAa8fdI07j+Vemzb1/UVV1v7
Py5r7o39vU62d2ro8rt9IqllHV3MqAC2J0cN673BlskdmEgdigAABq3P3GOM/Kdu
Nhz8RayE
=FfEK
-----END PGP SIGNATURE-----

--04m6m4ZR1pKRYB8t--
