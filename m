Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E675CDB481
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4510586ED0;
	Wed, 11 Oct 2023 21:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hl3P8iep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F31D48082A; Wed, 11 Oct 2023 20:41:43 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7915686E28
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a7ba0828efso1828277b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049512; x=1697654312; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l9GKD3kvT2ENAQUm4vOxhIis5BmNuv+1TEfoEtVPoqI=;
 b=hl3P8iepnpYv1BwDe23jRXhjPNftHGbHY1xerSNpQ20X1s/DBuHJE8RzXEuo+i4Hen
 BqeHMjac4sdh4h+glQLkiIKA2A/PWNT9AXDZgKnmVzTfuaaGteMLslaXIdgqU/2BRmaL
 7R0YYpRze2FMHZC97As6u9my0vfVo/8ey6nno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049512; x=1697654312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l9GKD3kvT2ENAQUm4vOxhIis5BmNuv+1TEfoEtVPoqI=;
 b=cCGkEV+wbMNBZGfIKPHZRvVyASdUIzQESaIyTaJdPsha3g2pZBrCANjjsWNzkeGtu0
 3ZqJhx6wVXbEpWXvx9HiZCHqqZ8c1vgOO/zZdcPuz5+kqfAmKG+mruM/M4GISJBI+cdQ
 uxho6Z8kKLcLv/H7U/zbhzoGrlrE0bLANx1LZ/bYeIoqHXayoTJ3CHhCosdAOL1MBqcr
 mvvyT0Wly6qNbLEtpCRvvyf06Tf0FOY+nk9Mplnnb5t1/jq1u+ScRHnfISWek4y5wKe9
 6rFNcCs7dbx1MZv51wMR8c1uWAWH+8PdZEiSffWqjExxKlblcjx0DN+EXmx4tG34H+bs
 1q6Q==
X-Gm-Message-State: AOJu0YwIgHHJzXENFhIydtcdBt5iHi3Ffli9ozIUnw0kigK42DleIL4R
 2novx/KA/JumFO56Vl9d1NDrvA==
X-Google-Smtp-Source: AGHT+IGJeW+RF3f99AX0p/jcjY5k52JUdp8fNf7Lnprnrb7K162YUp0tDqvZHH1C+gwh4PkQdhqZ3g==
X-Received: by 2002:a81:a250:0:b0:5a7:a874:d83e with SMTP id
 z16-20020a81a250000000b005a7a874d83emr8037424ywg.42.1697049512673; 
 Wed, 11 Oct 2023 11:38:32 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 q66-20020a0dce45000000b0059bcadded9dsm5349031ywd.116.2023.10.11.11.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:38:32 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:38:30 -0400
From: Tom Rini <trini@konsulko.com>
To: Joao Marcos Costa <jmcosta944@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de,
 Y.Moog@phytec.de
Subject: Re: [PATCH v4 0/8] Port gen_compile_commands.py from Linux to U-Boot
Message-ID: <20231011183830.GH3119521@bill-the-cat>
References: <20231001100036.34936-1-jmcosta944@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lrBT2AOKTnRH4Cdk"
Content-Disposition: inline
In-Reply-To: <20231001100036.34936-1-jmcosta944@gmail.com>
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


--lrBT2AOKTnRH4Cdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 12:00:28PM +0200, Joao Marcos Costa wrote:

> Hello U-Boot community,
>=20
> I'm submitting a patch series that ports the gen_compile_commands.py
> script from the Linux kernel's sources to U-Boot. This script, originally
> located in scripts/clang-tools/gen_compile_commands.py, enables the
> generation of compile_commands.json file for improved code navigation
> and analysis. The series consists of the initial script import, the
> necessary modifications for U-Boot compatibility, and finally some
> documentation.
>=20
> Your feedback on these contributions would be greatly appreciated.

For the series, applied to u-boot/master, thanks!

--=20
Tom

--lrBT2AOKTnRH4Cdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm66YACgkQFHw5/5Y0
tyz/kAv/ay85FfLFJG+09D3LZ6Dw8XjR2rzERDFjvwfmWtqFst8D6NF2cSpGvB6Y
QHCS6TMg+EuL6Z7BJmMsRuPBasZabxbFKvxpQJUly9fgVDh+hshYUt0x/QyOOGjp
8Yd2lLXSqpHJ6WymIw20hJAl/0v95bNtQzrD58Tm7wLuR2J23LO4hJMDgp71PTvb
aHSpPpIyz4xEGdVFbPPtiVsMIyi4ACIBnSLfsJEnAcHeQhZn5xyUHb8kXxhzknEf
Zul3Pb7YUNekkWgxdFse8AdnW5tagwD0X2xbcXE8SulzFjQPBXNxPzdwZ0/qd3vF
Ro2eEaxIxHgxyaJifESmoNnNTPYxwEuYh/rxLZNIMFROFKAsUTXcrL37zfWo75Pu
OwSUROaAOmCwq2QlSJp2WNv6cCkbIV8/A0ud1irXn+p8lV+L64cd0vgOlaks4CHS
VECrVxm0tPlHSJWdbiu3eTpi9iFq0kSzJbyoymceB+3HW6zc9oqO71dgnmi4SCg3
U4cdVWUW
=4oBw
-----END PGP SIGNATURE-----

--lrBT2AOKTnRH4Cdk--
