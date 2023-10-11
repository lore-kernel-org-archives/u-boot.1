Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFE9CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEC0186EC9;
	Wed, 11 Oct 2023 21:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jwL0cRc9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 104EB86E17; Wed, 11 Oct 2023 20:39:27 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AB3686E03
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59e88a28b98so753507b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049494; x=1697654294; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KlZBK4DeZ2cfTyWyoME5HjVJZ3GNCGb4D3Tpk/NkzrI=;
 b=jwL0cRc95fH9ra1pVQINoUutJbUYhi2XrpF3jDT5Pb+NqsxnWGfFoA1O48Ix+OjMV0
 z5PF5LdmOZyfWbw6RuFSlVYXHMjP6mQWSINiB/XEhXiyT7IdHieEKez/WOpX7aQitV3v
 TbZPQYRvFPwJq5bw8kaiLFcjiTm6NH/IvIyTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049494; x=1697654294;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlZBK4DeZ2cfTyWyoME5HjVJZ3GNCGb4D3Tpk/NkzrI=;
 b=j9HGGuzqanNq56Op12wGfoh1Xuhu7R7TO8siUcV2oxFJaHrCnfc10CQxoMalTMZ8Mi
 7hw4TUGMpxw2dubFTZPv7uq9dG6MQ1zP3WNCCYVMwqcrsz7eMdnXESvSAlKSGkXOzqj0
 5Wnly5cZSebWLjN7leF3UYlOQahL3rTY6m9X8ZqqZxGyMvQANy06YREzYkBI6bnPoRjb
 oU87wLVb6h9kV17mWciEhwIxvHVDoHy+sHN1Ie2QcwHiVXy86JBh86toiHpekyCmlcrU
 sgy+aBLRWMiUYa74C0x1GCtdiuK1yChVt21H7Buv6R5vVGhSsq7zZHpPzd84PiyflvvQ
 7rVQ==
X-Gm-Message-State: AOJu0Yz8bzXb9eCsxOKCupNeQGtj6UZrrOV4kaFPVzvDnNlbFnqmHzCQ
 eqLV4QhVI15j8QqD/1Q3z5vjxw==
X-Google-Smtp-Source: AGHT+IGn/R8DA0gBBTmpxn7hFwgLmt/rtj/DbKrnv4w/JAbZkm10OZvcCktLBQTKiEF+er29GoO0fw==
X-Received: by 2002:a81:6dd6:0:b0:5a7:d088:2c5d with SMTP id
 i205-20020a816dd6000000b005a7d0882c5dmr2580112ywc.26.1697049493858; 
 Wed, 11 Oct 2023 11:38:13 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a819c04000000b00595394ba941sm5272703ywa.81.2023.10.11.11.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:38:13 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:38:11 -0400
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] ARM: psci: move GIC address override to Kconfig
Message-ID: <20231011183811.GD3119521@bill-the-cat>
References: <20231001225212.19081-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+FCO70LjrSC6hM8V"
Content-Disposition: inline
In-Reply-To: <20231001225212.19081-1-andre.przywara@arm.com>
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


--+FCO70LjrSC6hM8V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 11:52:12PM +0100, Andre Przywara wrote:

> As the code to switch an ARM core from secure to the non-secure state
> needs to know the base address of the Generic Interrupt Controller
> (GIC), we read an Arm Cortex defined system register that is supposed to
> hold that base address. However there are SoCs out there that get this
> wrong, and this CBAR register either reads as 0 or points to the wrong
> address. To accommodate those systems, so far we use a macro defined in
> some platform specific header files, for affected boards.
>=20
> To simplify future extensions, replace that macro with a Kconfig variable
> that holds this override address, and define a default value for SoCs
> that need it.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Sam Edwards <CFSworks@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--+FCO70LjrSC6hM8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm65MACgkQFHw5/5Y0
tyzrawwAkflvdWKhChadw5yk/wgPwsDFerHxMtxLn5XZs8Kmmga9PWoil34kHBbD
e2DjH6YfZa5WCW993ihEd/jiLwOEhD2l4UQ28YJb/iVNnQonYZtgtismozcbCfRS
/KzaRArc2HzOCH2bLz6hEnTQ3JwEGK1XcCgPezQahK9f8+Cqpd0yoGm95TwHsR4Q
t0XED2QmMfyc1Q1sPgkitNX/uRzFwGSbLWbubQRKbuD5cOGYldhzFxmDwvbmirKN
IFmg1S6QNDR9nXlWZaPaOFmJyFunzibewne3o0rhKSns90PhEW6qcpL/ktLP2Rv0
4N+MUf5/WKuvlAnN5FE5pMHkr0SziBFQ3PTaWnqTR7up1hNuK2yXBKgR8dqX7+m/
zf1QVDRHiq6oXyc44xrF4+g7lu4GDa6YLU6kp7PuWRv5SLQaCaK1FWeLTZ38Sj76
YVRNjeBQqYNjeBb23O/NA+iiVDv0RCx3/uvxuyu0X6zdZadjFhOI7ZHPDkfDmbom
7yaAIi9g
=G2Gh
-----END PGP SIGNATURE-----

--+FCO70LjrSC6hM8V--
