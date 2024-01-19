Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59689C47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFF987D03;
	Fri, 19 Jan 2024 17:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TpSOnyVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D4087D12; Fri, 19 Jan 2024 17:08:57 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF23187D03
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-361a1665897so3712505ab.2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680534; x=1706285334; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jFdd6q8PHIDamW8vKavXR36MgBkVqPneoIKRbr1nl3g=;
 b=TpSOnyVVYQLFpyLZOh7/2rglmt6mdazVMhHxtyqyISfNSTURJHFdsghJnaAPAJNoIL
 1RA4Mtk6zjwkwDn0EQf7piYf/trLhj3MFMC/eVW6b6g8RRpDzsm6YEQ0xcemLjsCunDQ
 bv2VEFt5SEXbdP0KMYxg4Yec+yAe+8N2B14vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680534; x=1706285334;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFdd6q8PHIDamW8vKavXR36MgBkVqPneoIKRbr1nl3g=;
 b=F+2zqmnniox41nxjlOcZsnc2WQYSsBsKsdtg2WgqQmaiWxQKrhaAEPQeeD9JGJ2E03
 AfvRhgG+iz1yA6IaKyb2nTKgStvvoDf+mFu81vfLciLNhSxVvoHF08tuNWVXg8qEeWd0
 eyaFGXAxSqlPHzY0gwHh3eqTyqKthrvReZY4zkvc8KNmstl+8Wx//DTQAsfopL1ZkFJB
 xaIRy0vf6B250J9ujCpU9UwQhAJykK5TMBNkH6Z/eBAfYGLPYSEz59pDZcmQW4V8eERA
 nq03fsxO7nFAU5IaT63XvnjVCa4GDbH57CsMKFEFaV5KCSFQLc4sWM8qHCSjrnDkguRy
 x0vQ==
X-Gm-Message-State: AOJu0Ywo12eGVwCgOlkf8nw1pGLfI25dXafCkuAc6xoBoF/sVrLThOml
 BpYChjXygego/8NFVWU8lMyHMWtHkXvCKZ/Gnk0REZMeRngMY+mkkf+qSANef3Q=
X-Google-Smtp-Source: AGHT+IGLO51UQLMg/FdrIiKE5j6ezlCOMUhE/vHr2WMBOsiQA5ew0wuJuTh8MZHY2Tjya5uUbb7PaA==
X-Received: by 2002:a05:6e02:c69:b0:35f:f506:765e with SMTP id
 f9-20020a056e020c6900b0035ff506765emr41105ilj.16.1705680534420; 
 Fri, 19 Jan 2024 08:08:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 h7-20020a25d007000000b00dc24255cfbbsm1828364ybg.33.2024.01.19.08.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:08:54 -0800 (PST)
Date: Fri, 19 Jan 2024 11:08:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] include: env: ti: add default for
 do_main_cpsw0_qsgmii_phyinit
Message-ID: <20240119160852.GS12635@bill-the-cat>
References: <20240108-b4-upstream-fix-semicolon-v1-0-9437b3dc90ea@ti.com>
 <20240108-b4-upstream-fix-semicolon-v1-2-9437b3dc90ea@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qToYdXf+7B8Y1hrO"
Content-Disposition: inline
In-Reply-To: <20240108-b4-upstream-fix-semicolon-v1-2-9437b3dc90ea@ti.com>
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


--qToYdXf+7B8Y1hrO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 01:48:49PM +0530, Manorit Chawdhry wrote:

> By default this variable is unset and this causes the test condition to
> fail on devices that don't have this defined. Set a default value for
> this.
>=20
>    =3D> boot
>    ## Error: "main_cpsw0_qsgmii_phyinit" not defined
>    [...]
>=20
> Fixes: 0d72b0f2f83b ("include: env: ti: ti_common: Run main_cpsw0_qsgmii_=
phyinit conditionally")
>=20
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied to u-boot/master, thanks!

--=20
Tom

--qToYdXf+7B8Y1hrO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnpQACgkQFHw5/5Y0
tyxmmgv9G5Jt48IgGSbSzfj5dy/ItmQqlhNhqP0OU1fJsZ0ubfGw52bnzOV+u6uT
pnK314BlrZs/EDp9G6gUNgHN1d+7KFRINYdxoadA423sT32UUbI5LEDBvJflmrz6
iA0EWRLhk/cg+FCzfZDulXrfpd2um7NLjvC/B2E7tZI5PXriphtDlTdfR7FN4b2o
fkBt5pl7O7fCaDq4MwlSCX1h7r3ysljGJ9XKi5ajkEU5t7OJ8Ev5kVcWrfvvDTop
4xNomKvbPY8/1N/TLqMVI9hMcsXe8KWmFGW+eRsqgakXD+SY2V4cASDFLIG8fkxx
1zaEmGCjzjVvyHi0x5n0jgdVnznvpN1OLCi07HS1ST8cvldznrzBM48M3de3y7TG
bo4eZTO3KIZ0gS2N3H8JVJxBOxl8RkmwWK0Asw8I1btLNohgtjmmwZMtzTdm/Sz/
QbKZEmYdicbWzLDydAYZZRUYGAimiQJu0wGU0SxzvZ0d514ryr15EQUwHp7GRK8L
iNA3N7cO
=ZFso
-----END PGP SIGNATURE-----

--qToYdXf+7B8Y1hrO--
