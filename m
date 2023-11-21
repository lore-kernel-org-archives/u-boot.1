Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A928C61D97
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B981086784;
	Tue, 21 Nov 2023 23:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rh4Myx95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C298C868AE; Tue, 21 Nov 2023 23:43:53 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81025842D0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-462ac0f82e3so588509137.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700606630; x=1701211430; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PKASd/DW+K7t9kQWtF7C/04a4e29lV1OtHZ9hYL1I1o=;
 b=rh4Myx95CnFOlj6txanqro/CwQMJJ7DMfUln0G+Fj2Ucg73qQyCu/F+iHlNVv+Hh9E
 Hjij284DKPpzdyw9RJSj3Iu5PMKh0xuDEvWdh2mTksnKtO2IoOO0R0KU+du1wqmJRzB4
 /RxP8GrwdbJGhbZDt44WHT+med0qsSEgZlmwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700606630; x=1701211430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKASd/DW+K7t9kQWtF7C/04a4e29lV1OtHZ9hYL1I1o=;
 b=m3DaTcUAFg+vIBlL4SJv9Xpk/pCcwXEuIQMQogT0+RE4t9QhgNnu+wne3Vz9ZQGgrZ
 gW6S6+yGcZrf3QeH4TOv6FmqFtTIlygrSzCkrYV9ySqUOmHyD36+WYyxPwtaYTXRj9rN
 PIewTfzHDRTWMKOzRK9ySvtkmZ3n0g08N8+LOrjtwWbdDpEZmxZ0eXNWUnX/7k+XA4ZF
 qtUwTHObdV6LygGmIJsb+hf2fBEgDU6Tx4cc46yjpQv6lZnDGzVnfD518gpXAbP/+0cY
 aLVZgIx1pleiuJkST9fbzimZCqxlNTvZjGOcUMSJ7ad6+V7zLCS1tudw1AMrOqAVoJgU
 Bfzg==
X-Gm-Message-State: AOJu0YyCZ9MrUqDcepkZf/XCx5fGbf+hKaUXTRkPS5nALslX0vAJNv6u
 EEm5I5dUGzCSduzlDHC8a5xjCQ==
X-Google-Smtp-Source: AGHT+IGiVbHZ6vDVbmiAUCIR/E0mVouqMqgBLTO5kkiiE1CFEY6PFXQVlzA4RXQp7qIDpmmvxITKNQ==
X-Received: by 2002:a67:c007:0:b0:45d:8a91:5465 with SMTP id
 v7-20020a67c007000000b0045d8a915465mr640076vsi.26.1700606629740; 
 Tue, 21 Nov 2023 14:43:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 r14-20020a0562140c4e00b00679f5aee64bsm152724qvj.122.2023.11.21.14.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 14:43:49 -0800 (PST)
Date: Tue, 21 Nov 2023 17:43:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: mii: Add tests for mii command
Message-ID: <20231121224347.GO2513409@bill-the-cat>
References: <20231121084051.3381640-1-love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UcAEPLN9HhqCRKe4"
Content-Disposition: inline
In-Reply-To: <20231121084051.3381640-1-love.kumar@amd.com>
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


--UcAEPLN9HhqCRKe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 02:10:51PM +0530, Love Kumar wrote:

> Add below test cases for mii commands:
> mii_info -To display MII PHY info
> mii_list - To list MII devices
> mii_set_device - To set MII device
> mii_read - To reads register from MII PHY address
> mii_dump - To display data from MII PHY address
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

A thing I'm not sure about now is on my j721e_evm_a72:
=3D> mii device
MII devices: 'mdio@f00' 'ethernet@46000000port@1'
Current device: 'mdio@f00'
=3D> mii info
=3D>
=3D> mii device 'ethernet@46000000port@1'
=3D> mii info 0
PHY 0x00: OUI =3D 0x80028, Model =3D 0x23, Rev =3D 0x01, 100baseT, FDX

Which I think matches how things are overall on this platform. So, I
don't know if it's reasonable to say I should just disable the test here
entirely, or if the test should be able to / require device to be set.
Especially since I think as-written it's finding a bug in FEC stuff.

--=20
Tom

--UcAEPLN9HhqCRKe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVdMqAACgkQFHw5/5Y0
tyxeBQv9F51YRILdyzkqhBFsZeTRolJs/N+xfCLF9aaf5MGu9soeaKOMQqWaFGgC
fdR2nd0LUXVmu8+khOqWOHF4QN5iMYJPC+hO45jzEhVqXRFiJEAEIo4VwxMpcEa+
1RzlywwZjvxFjKLyJ/B3YoxqL5zLrYq1UnyjfIWXsh3hp5L2amXlEO1O6gmwqjHX
aefGKrB9AOxU7qmVoS0KCHB57MydePEFnEMxeS12hIdjKsvpkM8RntHr0E0yLizc
xh8l56gz0Rv8027BRhFobOcqhBmw5tZ121lx+9D9hW8yAop9Efa/7yKHIkdq61hJ
05zrlNgTIxYJgMehXuyVeDSX7woJJ/ug+V1WVvVsJDGaLLIiW9XobkF3d1rVZPXL
I57LRSAU7vsJ2AL1+6ZX1lSyWC0XXD7u3zvbr9vNsg2FIi8Ax+PjORsJtwH5PhcL
sin7RG0WHz8jjqz6SiRVtfcBQFUBacaWVWTBbqHffN6O837oO0IkK7feApCjZebJ
pKpUp6hh
=b99T
-----END PGP SIGNATURE-----

--UcAEPLN9HhqCRKe4--
