Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3312FC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 17:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A43874C4;
	Tue, 31 Oct 2023 18:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QeA8z2VB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 960AF875DC; Tue, 31 Oct 2023 18:46:33 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B0DF874B7
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 18:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-778927f2dd3so348717285a.2
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698774390; x=1699379190; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0yjXefJMiQwOm9iUrHuAcp0feH32yqK3sWNMYrnOR+Q=;
 b=QeA8z2VBdk08WgVcJcuUShiy4zy206Tfy7T6Mq2+FUTWgIXrlnKL1FzP8B7V6WG1zi
 hJLF6pUOCIiOtgVVOQrYslIoQn2Eh6eovqLUBK6umruRCGHGEubN2ls1QyjvtPUAMPz5
 IfoN/qJWqJ7+TaMMRTSJDfGcdfyMdhkD/uMk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698774390; x=1699379190;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yjXefJMiQwOm9iUrHuAcp0feH32yqK3sWNMYrnOR+Q=;
 b=PEpNAf6LB4tJ/9tdqRQZjMRZvR5oeOtCFka6ouGAKNZhdm8n1jBEQWmo5m4aDUHL0H
 o1L44UA0GpXhvCuJ/ll1JLV45LEwRcQPAV/Qm5+kJIG/y8f2qWw5xiCpgMFJaaqvSyq5
 MykQTj0FDDjxwMHGEneHXoXhmJrvYC52dR0CFeO0tzqdxS3BQVus6vGtZo8Cg2vs2KC7
 vepmXLxHR5X1XcHf/nnQ/BmSBWgijiSrPfldFBL7a68Y3JIgA5rHcT599kkZmy6BszoU
 deUZYpprAPOO68UqNcySlSL0ebEKkYcyjVdObaDwfzMgDoXZpOdkPtMI5gYuEqnB6YUR
 yThQ==
X-Gm-Message-State: AOJu0YwEaBs5E9k8pQThv8nVZQep2fnqFsVHuFWZPPfPEQbgMKF8ESEj
 uit9JQ3QR7YxBTbByW7HdQK4MdQ8QAg4FihL2u5zPQ==
X-Google-Smtp-Source: AGHT+IHwQlBo0uAiAVHgCuZU/VjNVIWapnaQrMXId2JOKBRlo2tXgIbOVlr6IQRYxF0gq0qs8w4vng==
X-Received: by 2002:a05:620a:b09:b0:778:6a53:f13f with SMTP id
 t9-20020a05620a0b0900b007786a53f13fmr11973718qkg.21.1698774390214; 
 Tue, 31 Oct 2023 10:46:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 d9-20020a05620a166900b0077890c8896bsm685752qko.134.2023.10.31.10.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:46:29 -0700 (PDT)
Date: Tue, 31 Oct 2023 13:46:27 -0400
From: Tom Rini <trini@konsulko.com>
To: abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de, nd@arm.com, Emekcan Aras <emekcan.aras@arm.com>
Subject: Re: [PATCH 3/3] corstone1000: enable PSCI reset
Message-ID: <20231031174627.GY496310@bill-the-cat>
References: <20231026125051.321493-1-abdellatif.elkhlifi@arm.com>
 <20231026125051.321493-4-abdellatif.elkhlifi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3YV1d6s1wiazXSZ0"
Content-Disposition: inline
In-Reply-To: <20231026125051.321493-4-abdellatif.elkhlifi@arm.com>
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


--3YV1d6s1wiazXSZ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 01:50:51PM +0100, abdellatif.elkhlifi@arm.com wrote:

> From: Emekcan Aras <emekcan.aras@arm.com>
>=20
> enable PSCI reset used for the system reset
>=20
> Even though Corstone-1000 does not implement the entire PSCI APIs,
> it relies on PSCI reset interface for the system reset.
>=20
> Signed-off-by: Emekcan Aras <emekcan.aras@arm.com>
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Applied to u-boot/master, thanks!

--=20
Tom

--3YV1d6s1wiazXSZ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVBPXMACgkQFHw5/5Y0
tyztvQv+NTHSTnB0Da+x4lYQKhlUAaym0cY5ZK9PhxjuQ57wtJwL6nPCnwv4dnae
vEiGp1fPW4gOkmsorJ5oSZMIz3+Ar55OQVzYtn74JeH3lXx1RwRZ+mmaVk2GFE0Z
pBpsYGxhqmajV0V0lbiJf0J9nnhaB3twAtffvByA7PaHDo2ags0XdfOv3U4WEdNE
G6MCgxSP71BOoLtmmzLwZkWd3UAWGtdw/H0DXmJp3PabXLn7ui9OOhsH1yL+r3/x
alRYib4GeNqXa63+D6c/ZiLRuyGMWDHIR7VrAiSDaRQK/9OCAYfRXTz1Wc+lEE++
kHNqgikP8SnNBQI9ryhKNF6Xzx8MCgOcx7/h4mOC3X+KSqAyofxakkhPlsA6zJiK
agnQQLg4daMnRF6781sOG4OgF14jdEygorOMG+QcFj+vDXJacjFJMkbjzXNW+mKo
dhZW07o9V4v6D7mD688Dpj3mDwtZg3UhvJxE4rW0PBOgWwq9E/ldAYpdeMXV/2qL
vAuET+9J
=Q7Eq
-----END PGP SIGNATURE-----

--3YV1d6s1wiazXSZ0--
