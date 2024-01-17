Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD906C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93CB387BA8;
	Wed, 17 Jan 2024 15:26:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HmRlC5qC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C9887B66; Wed, 17 Jan 2024 15:26:58 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6972987BAD
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dbed179f0faso8540651276.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705501613; x=1706106413; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XfHq8pa5fzWsN/OprTYXSN4O+fBYEUxjAs5GEIfDVtU=;
 b=HmRlC5qCN9fJQqRDYrGbLsh6Oc1UGnT0nESgNjSk2rdsRx16jJtLFxlsiSp9zU2dyz
 5BZRLBd029s6p5K2XZeA/h5BwHghXOSRkcMvyERfgXbi4JTkFAoX8i40UzmGbfMhDWAe
 RLFHZbECQVxPcr0cWOcgtB0lw7pUmugTTxxj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501613; x=1706106413;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfHq8pa5fzWsN/OprTYXSN4O+fBYEUxjAs5GEIfDVtU=;
 b=apDhQ4o5WYwa43iH+XqY2N4y+HPEai4tkRlWw9qZzyIZOZlpB3MdDJsCf4tW4PyR8r
 fGBCYIDPACFu6WWdeeWIjzjU+fjg3DVxJvRXJ0WELE4g0qe2CDd+FoPeBqKGuDHlZX+s
 r0i5m7sHygv3yQt3TzkFF+GLv/ovk/guEIAzUobcTS7l9gLHK1wsLAojNw26gz2SUk6c
 ucrVgLBtVWO/5WoorDnJh5hu90gtYC6T/Isnt5RLonxddo+Y376X2AJfCV+AxhWAQdCY
 AVHAXlDLVc6VErtMlIjcmYA/v8Z2fxbcPuhA/nxsLmrlQwBmOpkjSU9biVtRsH1ObXJs
 hzgA==
X-Gm-Message-State: AOJu0Yw6w01T3M71AvKiaebPaPRLsjXLBcRx3Pa4bVByZR4blvUk6ALa
 RmupBNBlRRs4Mk5lMAHn1cJvRloG9uqvBw==
X-Google-Smtp-Source: AGHT+IEa8vlWbYDEvKBUivk6KNroqNlvrEuP0DZjaAnCx4H6XCgYEJzLs8WlJltO1fqh69W/XnCXSQ==
X-Received: by 2002:a81:9205:0:b0:5ee:5d8a:51e1 with SMTP id
 j5-20020a819205000000b005ee5d8a51e1mr458014ywg.27.1705501613160; 
 Wed, 17 Jan 2024 06:26:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 m195-20020a0dcacc000000b005ff4da78ec4sm1704935ywd.130.2024.01.17.06.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:26:52 -0800 (PST)
Date: Wed, 17 Jan 2024 09:26:50 -0500
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] reset: npcm: Add support for Nuvoton NPCM BMC family
Message-ID: <20240117142650.GR12635@bill-the-cat>
References: <20240103072933.1319033-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YubPttGfpM1OzZ5u"
Content-Disposition: inline
In-Reply-To: <20240103072933.1319033-1-JJLIU0@nuvoton.com>
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


--YubPttGfpM1OzZ5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 03:29:33PM +0800, Jim Liu wrote:

> Add reset controller driver for Nuvoton BMCs.
> The npcm reset driver not only supports reset each module reset
> but setting initial value of reset Control Registers.
>=20
> And The driver support each module reset.
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Applied to u-boot/master, thanks!

--=20
Tom

--YubPttGfpM1OzZ5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWn46oACgkQFHw5/5Y0
tywmYgwAhUhFMIu44e5iWC4+qQ37Yqa9p9gMT+lUtJZ2YRBakx8m/Q4QtxVQIwt2
owhSfAkyap8XELQJKrq4AXGOmnnIDciI5HC3BBmiY0h9Bwx2tyoaSd1MKbCQz19K
kD3e1tgFdb9vGar/e8aDf/SjyjlKG+cegL9ePkYiqWrxTO3Thz+KWATfTIYG6eNt
NQ+EHZUM+6XCMtiHbOAuvwH0aFF6nmxzNavJSF4C6Gp6iKHw3dyZ8QvhHq7nlMc7
uK8I8xD7XqM4gsoxK+BTqhr6OvEt67KAR1CU9DWinq2tgli3x+HcdZUs9NnrOq0F
a1kgOgL+39vq9vvfYfOFmUwdcTrN2Kgx+XJo51Db7i7f2iO+fMu9DcqdBRahZLy3
elIKaMdMp7IVJ40454gxxnj2HVkQXHJxZkS9KnS0EvXUv4YS4lwjYXEOB8vTx/Ec
usZca+Kx6k6BERo2egGfIwKuP7u6kP97spF1qIKtmG96fZNaNs1NhMRAN01HhFD5
tHWBozjT
=pcW5
-----END PGP SIGNATURE-----

--YubPttGfpM1OzZ5u--
