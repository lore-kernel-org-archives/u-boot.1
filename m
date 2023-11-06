Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F82C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D39487124;
	Mon,  6 Nov 2023 17:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="au/MqT5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E641E87124; Mon,  6 Nov 2023 17:33:31 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B9B87115
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7788db95652so327895085a.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288408; x=1699893208; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ht6oJst7F55AKf0gXlw/OBnxes7YmtZ6Wt6GetqOoGE=;
 b=au/MqT5l1upSQ+nre9ZC7P70W6BTDCHxSO5McIjNFbbwazAq16IdbN4Y1o4u9v8Ms4
 cWbQRT2iErIwtlCeWR6Td+asao2DMmyzKAfm/0GhoCEvAOpH4Mv2qyCwY0hpvn5wiNdF
 EpvbIRlOO5px1oulmzvAVP5YkqJmveW4iXJpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288408; x=1699893208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ht6oJst7F55AKf0gXlw/OBnxes7YmtZ6Wt6GetqOoGE=;
 b=Ue/N4HdBW2A3mFgRoKqVkFG0boi/Abwl/4ZexGC+I876Vzd+VCBBnb0NEH7vO5oyu3
 S0Ht4f1/Yew6qmJ1AFDxi7D4wPrpO+wId53XBuH3ZX0PJc1d3rYQU0yj8jQJS7mbF9fS
 ycFMtnHgZQcOX7PbIgsE/YHacznQEXP+qSRJc0ulADtjpAQHQWUKLshdgZsa6zdCHZvV
 ygtM9GPzRiMSmYadHIuJdoaYZ0vGLZmGQyNbEMuHeG8Gw5jgpXfwLWlwqAX3OVfcInuO
 VT0iE4hC81R6tWwpUB+xV6+SwfxF9IGxEPhsxzqGp7B+yyx4kUwsZHi2kmnf3Yg65aJx
 N5RA==
X-Gm-Message-State: AOJu0YyJUhn6EhJfH530M7lX2Q16YOlE8n0va2KzNAJJ7l5oqVUSB2yA
 HnJXH4rnUChxZpQ7rHx+zZ2UrC8C9WmwcAfdgCPxrA==
X-Google-Smtp-Source: AGHT+IHfZX20jf8FDYblL08uZxtZJAFjC4uMEeQ6YQJfDX4kPuuC02OCp5oXOZWCG9v/7SQr1l7R1Q==
X-Received: by 2002:a05:620a:2801:b0:775:69b4:b4e6 with SMTP id
 f1-20020a05620a280100b0077569b4b4e6mr36352361qkp.7.1699288408495; 
 Mon, 06 Nov 2023 08:33:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 m16-20020ae9e710000000b0076e1e2d6496sm3423639qka.104.2023.11.06.08.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:33:28 -0800 (PST)
Date: Mon, 6 Nov 2023 11:33:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v2] net: eth-uclass: Setup ROM source only when ROM
 reading passes
Message-ID: <20231106163326.GU496310@bill-the-cat>
References: <7fb2d512973481cf412a622deb747758bb539c48.1694787003.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TyutDwqFvD5n+alq"
Content-Disposition: inline
In-Reply-To: <7fb2d512973481cf412a622deb747758bb539c48.1694787003.git.michal.simek@amd.com>
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


--TyutDwqFvD5n+alq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 04:10:06PM +0200, Michal Simek wrote:

> There is no reason to setup ROM source if read_rom_hwaddr hook doesn't
> exist or reading mac address fails. It is ending up with confusion about
> mac address source.
>=20
> It is nicely visible if you put mac address to DT as
> local-mac-address =3D [ff ff ff ff ff ff];
> but also save ethaddr to variables
> setenv -f ethaddr 02:18:31:7e:3e:01
>=20
> Before this patch U-Boot prints that source is ROM
> Address in ROM is		ff:ff:ff:ff:ff:ff
> Address in environment is	02:18:31:7e:3e:01
>=20
> After that source is DT:
> Address in DT is		ff:ff:ff:ff:ff:ff
> Address in environment is	02:18:31:7e:3e:01
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Applied to u-boot/master, thanks!

--=20
Tom

--TyutDwqFvD5n+alq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFVYACgkQFHw5/5Y0
tyxvnQwAkpAA3rDtVDIEft+mNhWoaZjWUcpv7h/nOhX2RY/zT6iy24YLTSCLHu1x
uk4BfBEDTWGLi/h/re6CuaTxYUP5YFcWH0dJ/j9as+anUErTAQjamhrktZm+6PNH
S47hs9n0+8i++6gUXeCz2XFVGi5wmbplxb5Kf8vZb5XjFpYFryl0buEb/kLfkDmA
DnRLd1Wzfwal6jyeBdTnkxMu0rIrTm19kAbxX2fhP95B+CwMw9w8EJfG1OR+oyEF
H/sMiGlm8Z20cOj7v2PeHWIYDaYbS82RAqzR3Zm9nvLQYqi/GZ0uYQHcOGzP97j/
e4gHOAsC7qSUHLnVpE1nkQZHWKAjA8xF+aO5FbwZ3dMbBfzEjE4TT5gKm7Ih1SyN
4XZX/oxbw/fmfiq95a1W7k/iFcKAOO4OXlBaQrtsZcuJbfb3EpuOv70gPLzNdiyb
JhjvJEDf7YBfPvrUfWYuCwNg9EZ6ziQ/S6KUjQXxR7tyz3W2kS4USbFYVg6n8lG4
SW5uTsbM
=i96E
-----END PGP SIGNATURE-----

--TyutDwqFvD5n+alq--
