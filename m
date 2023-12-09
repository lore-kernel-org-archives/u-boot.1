Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498AEC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 02:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3DAE874B7;
	Sat,  9 Dec 2023 03:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KDdrFCY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE3AE87536; Sat,  9 Dec 2023 03:59:36 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F9ED87215
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 03:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6d9d84019c5so1724074a34.3
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 18:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702090773; x=1702695573; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=icjMaRD7QkxFpG0NqfWvq1JMQ9+z7ZzgtX4d8KXqFZw=;
 b=KDdrFCY6zjT+oslFNDT7pg8Bf1EbF3nicL7mrL2ESsiRrdWO3YROar+YovASn1Qw4O
 uFGxjaBT3qB+4iXWacpG6Y8unjlJGRArXpSxEZ17EnsW+8Beb1H3/bZY4BAxL0Tq+nvZ
 WABtXbO3DKjdlicSSuQmEUG1o2yXelb+2HO/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702090773; x=1702695573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=icjMaRD7QkxFpG0NqfWvq1JMQ9+z7ZzgtX4d8KXqFZw=;
 b=dMFTsGrzGH0PowcL+85XsoBvFwC8/95dPj1q1uKX68LeVBOb+RrBg57mcXSmIgBTfE
 LXvaSH7cNoUWu7lL1Dgh9G7kUy93c5HOM8pCnlu0Tvm8cdp/3qjpVpY2IheIHNs8W+4X
 NjDsVdvjd7ZjEX+QvepOzIBlgFySOXksFA71nwc3xmPpb8YaoDzU08jfrP8gIR5pj95J
 555uy4LCLBQ22N4opznxGv7dHR1Z4WDN01b7H4QC/oC0+JjYmqspdsaijZrKGAi3I6fK
 73Wu+go3VFI9gNUIq6B1ipTipSqXOrIWWi1DSD0EVEcQGg6KtP145lhK/tRM2HvMgdc5
 6QIg==
X-Gm-Message-State: AOJu0YxNOekxLdLRk7+QMB1scpcFLGym9wcDRoq/X4KgFZXdI8zW5xRu
 KyyidqX0nGH++yVNyNtfDHh0ce9JnKSevzeHpmwTAQ==
X-Google-Smtp-Source: AGHT+IGuGy026NKqR0IlQVyEyE14rwLstats4EwN/2dWbjcFEZtQy49CZS7FGIdoFFWmnL0e5r3rTA==
X-Received: by 2002:a9d:7689:0:b0:6d9:cb22:b8e7 with SMTP id
 j9-20020a9d7689000000b006d9cb22b8e7mr1087891otl.65.1702090773182; 
 Fri, 08 Dec 2023 18:59:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 k206-20020a816fd7000000b005d0494763c1sm1134163ywc.140.2023.12.08.18.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 18:59:32 -0800 (PST)
Date: Fri, 8 Dec 2023 21:59:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-watchdog/master
Message-ID: <20231209025930.GY2513409@bill-the-cat>
References: <b5692c19-9431-47ee-9053-52deef9ac539@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JLqpOPMhUj4xdP35"
Content-Disposition: inline
In-Reply-To: <b5692c19-9431-47ee-9053-52deef9ac539@denx.de>
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


--JLqpOPMhUj4xdP35
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 11:18:17AM +0100, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull the following watchdog related fix:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--JLqpOPMhUj4xdP35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVz2A8ACgkQFHw5/5Y0
tyzs4gv/asBEIzdjqh42MM/Uug8rj26Rx9MzaXoB53X39QG3fi8RwnXl2Bjp694C
GEZbGUAUFToJQueszg3P35R6qnLe+YxPG5CATpBuNFWjsBulc0QuX3YBy0hD6Pog
49ueCBXmBhRdyznfpi/ep71YNLvEeE6fUHlApMBmYu/x8puqQ++t2nCerXeWp3aZ
tou8752vRaop0JqstvS0Xzw6eYCzcF2kqUY3qOfjoFLPu0Dbd9odsWoeXLQ3YHdI
vicGDHHZCx9pdmO5ykWfHeqsARhLD08no4pIbr5yi1/7Kv5sQr4JYw7yyE5Q7qzj
MuUZS67yOP4dhSSD8C35fU6SwWmdVTXOVk3ds73yD6OmGX+frXZIrZ+drCtLXbty
VKYDCgGNprFDi4cdEbc7cW5sXQhQGAwK6RPF8rqPjo5aYPOH+l79xUbR030IOSPh
symmWLXEQ0wjzoTVYDbhFqomjb8ICACFL+3OQbkzZ67gTT5sH3PalIsMmjWRMpyM
jWyJOg9Z
=yyA3
-----END PGP SIGNATURE-----

--JLqpOPMhUj4xdP35--
