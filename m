Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63318C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 19:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDEB5870A2;
	Fri, 17 Nov 2023 20:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E7GsoRUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C284786DEE; Fri, 17 Nov 2023 20:42:05 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 816A486EE2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 20:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-778a20df8c3so145154985a.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 11:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700250122; x=1700854922; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JusrKhRXeVpAQ6PisLjcbG3zXtAcvSzPpOalnpYk5JM=;
 b=E7GsoRURIepQqR5uYHCZTCf6N8YPNrv4fcYFXNCGPEHeFFl08VMFcELKxSroafiPpy
 vm3YCBR6k34xktVGTqxmX9u2tF+AD4mykLB2cicLTX615I6C8vyH+MmEtR9HBv8Q7Upw
 zbDhLKrecIBAUI039Ol14PqVWCF6QWn6Ua75E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700250122; x=1700854922;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JusrKhRXeVpAQ6PisLjcbG3zXtAcvSzPpOalnpYk5JM=;
 b=ENheiqmDUe2GiLN7vsd21TiG6p3dZkwMK14Izy0stIn51GSzZjLTHvUfkr71MfCMP3
 gIGA0Tfij6O0b8dKK+iIH5VwsMHfGZGv7I0Y79+UexGSWkX5L+ZDJuXdY+iIprll9xcY
 6njxGnhLhgPo2qPIuRfFcJXmaWhDUDg5B92Fi8t6c0lNI8Gx4VzWjw857/lp3hQm1VM4
 KDE60IzboBbmafh03+WNkXu2yAP8/JhP6Mtl/65xpUq8h6NFs4V4SFn0HtwMQVVzlVSi
 erJ156G4oB+myOR3eAD0Mm6WCZodnKJdyNTV07+AWqaC6VDs5BvFC8luHRlprkwmXwAW
 1q2Q==
X-Gm-Message-State: AOJu0Yx0ikWNj8eRRcVaHzr+B96i3+2Y/0vOxFp9AMFm3+d6DSOTzHpP
 ekDX54SploRAJTnf9ruPhdTtgw==
X-Google-Smtp-Source: AGHT+IHTly14vypiKxv0EbdnUk2gZMrG74EZVYu9ScKQ8ULo4+Sz+LNTH0PIbCz+nubSxy6weVFL7w==
X-Received: by 2002:a05:620a:3955:b0:779:f0a1:3128 with SMTP id
 qs21-20020a05620a395500b00779f0a13128mr585494qkn.63.1700250122330; 
 Fri, 17 Nov 2023 11:42:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 p25-20020a05620a113900b00767dcf6f4adsm821104qkk.51.2023.11.17.11.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 11:42:01 -0800 (PST)
Date: Fri, 17 Nov 2023 14:42:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefano Babic <sbabic@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v1 1/2] imx: spl_imx_romapi: fix comment about
 stream(usb) download failure
Message-ID: <20231117194200.GS170968@bill-the-cat>
References: <20231026073220.244387-1-marcel@ziswiler.com>
 <20231026073220.244387-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g1fJ62k5+z+tRtwP"
Content-Disposition: inline
In-Reply-To: <20231026073220.244387-2-marcel@ziswiler.com>
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


--g1fJ62k5+z+tRtwP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 09:32:19AM +0200, Marcel Ziswiler wrote:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> Fix comment about Stream(USB) download failure.
>=20
> Fixes: 1cbebc786276 ("imx: add rom api support")
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--g1fJ62k5+z+tRtwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXwggACgkQFHw5/5Y0
tyy6Wwv/Q9qs7xGibJvdiLHDUl44tLkTkbInRSowOhPpY3by5iPwEcDp4yJGWzAY
wczVyJQSA4nYxcyBEMXwcCVAaOqyY4NL5VOmm8outbw7Jx/UhBeZt3ewTgrbntJT
vSwWSsQw3LarAt8iIo6aPWQ5AofXfsvG4T24i9RMAJBLp3aarxSglP14yAmZzUuB
SUbVwfgMwNhQ4HfdRsJ/zajDOhV6p3nQB2dD2kQgdjZ6M/HoJ24P5xVp6LJio8rw
UurWDi81JccmoxVzyTO0kvampAYwbhOjYT5oHrdVe41fk7rA5/1hV/aaQ6aA93U3
n182qNlctgAU9MK5Bmp3siyMCCh19J/QX4Q5n9NDM4cUM5as0pV7nEh3wV8/8w4+
eKCGOizy+spMNEw2I8J4yaMcQMFek9OpJNlZ1MXnowKkxjEqYSVMDOj3C32toXuZ
wEihDUIByNpHTi4rtB9+c0qUP7Y2CrDgB4iDYl3UZahEcC5tJJQ/ygXoVA38hWmX
9pndSD/T
=MOz6
-----END PGP SIGNATURE-----

--g1fJ62k5+z+tRtwP--
