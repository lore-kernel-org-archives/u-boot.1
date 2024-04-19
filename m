Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4A9C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 21:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D5CE8868D;
	Fri, 19 Apr 2024 23:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RYXSjdpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A40A7886A5; Fri, 19 Apr 2024 23:31:48 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D22488526
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 23:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3c74abe247bso474670b6e.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713562305; x=1714167105; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z1r7hextjqDDSE3iNoglYfiEuFkI/MWZ/nihIhGSx6c=;
 b=RYXSjdpwoHswdxiRmhbm6SHgGmuga0siczMsBvwq9o1JmiTuZ7yWzXDDfDYBaOF5jr
 Uecc+4G8yk0XawpTUfODHMdaPMKAIoodsNMt5uCC2Bt2ZvZl+IaLZP3kDQ2/thLpTvpx
 ChpLKsPrvbtZxTu3+e6E5xGFqgePeF+3jWKUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713562305; x=1714167105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1r7hextjqDDSE3iNoglYfiEuFkI/MWZ/nihIhGSx6c=;
 b=VocUOtqJqI4hycBgOvpaXoc53Q5LizACQlLnB1b2noqVCOEplCgR44Vgv/ZHRn7PWa
 3kPUjO0qgbn/ieWi1rNeD8eLWNeiJF0cGy8KlVqeFDVtzITQNXsF3V6SBFSO02EtWFZD
 MgdA/Vsn+wWuYgxO59lbWYl66IpiX+ORElibC679CZR0o1fhLlB08wnp2MOJC8lue0vZ
 c9JbxnNwnUWM3SRLZ+SdlskX3xFD7Ar0IRbHELoPwAeJ9PRacvK0mvxP4tqk0HYAEj0W
 Xce3VtY06k6nvsfkduzyHefymg5qVFSL7tCHiRnQwryQ5KW7BekEIrQ7Br7hV5OCLjkC
 y0Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNBQ2/EUafERs5fBN4LDLwC/xWeZYfMV3+zRjOlvaEY91/DVvbuFF6iBo0eFSU1wc/5Z++3HDpb2R8o+/YQzytnbEyUg==
X-Gm-Message-State: AOJu0YyxWJQA36qAycXlkP2bhwap9pkCSTbiCS09SMIFpgQmGgv8tqjl
 13eh2GMo0vvPg3H2FlKqiECt3OMPSr0LyP/kiGF/Se91tElpiZmnjkHV6134vB+W76gEOWV91lG
 UdXE=
X-Google-Smtp-Source: AGHT+IHi0LR3j+Nf8fowUV/QBMZjZWPchP9ShnWvjxTQHe69gPWgoh1Hbvlnd04c3M9XIjk25KBzSA==
X-Received: by 2002:a54:4697:0:b0:3c7:25ea:cee0 with SMTP id
 k23-20020a544697000000b003c725eacee0mr3053565oic.37.1713562304895; 
 Fri, 19 Apr 2024 14:31:44 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 t23-20020ac865d7000000b00437794a29aesm1914433qto.71.2024.04.19.14.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 14:31:44 -0700 (PDT)
Date: Fri, 19 Apr 2024 15:31:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240419
Message-ID: <20240419213142.GO1054907@bill-the-cat>
References: <874jbx4r91.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Co1mg6BwJPILghD3"
Content-Disposition: inline
In-Reply-To: <874jbx4r91.fsf@baylibre.com>
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


--Co1mg6BwJPILghD3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 11:48:58AM +0200, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Here is a new development for master:
>=20
> - new "fastboot oem board" command
>=20
> This CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/p=
ipelines/20427
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit 2c3fa4b8add3cb6a440184ab67debc6867d383=
c0:
>=20
>   sandbox: don't call os_close with invalid file descriptor (2024-04-17 1=
7:06:16 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20240419
>=20
> for you to fetch changes up to b2acf59baf917c3b4002c1b2094ddb46c03ab02e:
>=20
>   fastboot: introduce 'oem board' subcommand (2024-04-18 14:54:38 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Co1mg6BwJPILghD3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYi4r4ACgkQFHw5/5Y0
tyxqEQv+MjDgteKSfKqMSqJUIN05e0hHQzrrnU+Jkjk/ya8gSSWOFi9A1uiY59Cm
wE4i+7zbfYc+tV418VGpC4LhjYu095Ztxqi1rHYeR8rZGnz7JYc881+w8XopK5dF
2K3iAX7dTjsz+ZkGRuHetiiK1wPeyjGwa8d6fUfv4Krt9fFzfTvWrbet1npf6AW7
V6R0j1C4erxR19Ll72f3vGihMWgATOcPb79zs3BxAwOfwtI7yYI5hO+AyNLTl3fX
WSNTpL/93R5JY2KXHlxg85UXerIft1RLjSy+wTxa56CE7l8BdY6hjIyJvXLN9wFQ
vhvcHIPFe84HdlMNkohUwr186bQF/NX//fWVdj3Pcr3NmX1kiT1M0S71uQZeWIb4
23HQsKNcJn2owKMtP+8LaelELGtaTqXz9anAR05YwVQJ8IBgdFeUGXNkOlf4pQbs
DZz07Dq64vidayai5dZFxncT+SDE3vVItOxufB+gWT0jK9lnPEOo6MqlwHvf+bqp
6IJ4FOzd
=3PtS
-----END PGP SIGNATURE-----

--Co1mg6BwJPILghD3--
