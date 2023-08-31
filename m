Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D951FC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:26:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3168667A;
	Thu, 31 Aug 2023 18:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T5+SfJMx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE79E8666B; Thu, 31 Aug 2023 18:26:23 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3FD88669B
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5920efd91c7so11815047b3.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693499178; x=1694103978; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=arHrWF758uMO3KNraFFAfqX7nesLiwwwnZiT1F+G87g=;
 b=T5+SfJMx2rr24mz89zDjJZEdXORlA568WkaDIF7ZPUI8Yd/VEYNvPyIbj6zqhoc7Jg
 65ffyfJ2lxB8bQHf3o+EDNmh4S9/96vn3UhfP47DSQecqT3IaTFZMqxbJ8GXlNTeV8/J
 E17dpDGTF2Bn8W2uLqw4jA+x/oVotGoONtatk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693499178; x=1694103978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arHrWF758uMO3KNraFFAfqX7nesLiwwwnZiT1F+G87g=;
 b=FxECZh0FAKMtgkJAheYty67J+kP6+GqrUt13vQhxd4o67l0Q8vNrOiZmAKNrbHaSN4
 zuuAe8TG4yw+7/9+CbGpJDTi2+HLNXNvILxqzKT27eeIXyOkLm50tV6OaNU5nLyaFrAP
 v3ymxdRb+yEh2E6PJfVnXxZq8EYAh6kUu+5tv6c+sfbrFPcmkl2LHVVUfTqx4WwOCtMx
 16rq9lCJpHFrLJRLwL/Fku6fjbPmCTFyjAug3FyWvSjyvnxcf1aiiBpI/9T4eCoFRV1B
 X30eFtVvHM7hTBj0gCZP1+6v6QXCmUH+E4kVDN8hxnNtWzZnKQQ0Trek5i6dtTskUTbS
 HVnQ==
X-Gm-Message-State: AOJu0Yyi/36wbtE04hhcZXdmO2OXxTz2pZgXSmUV4qGVehy91ciO69q5
 TE0KqQ8PBKlDsIeHKoXVTPhPYw==
X-Google-Smtp-Source: AGHT+IFgkVRO1TtE5Dq2zt8l5D+EPeOB5RzpnbJVYeNT0d8iXT+nW0SjihtHUcdzgFeKQIK85a67ww==
X-Received: by 2002:a81:91c3:0:b0:586:9c8b:ae7 with SMTP id
 i186-20020a8191c3000000b005869c8b0ae7mr5592310ywg.46.1693499178686; 
 Thu, 31 Aug 2023 09:26:18 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 u67-20020a0deb46000000b0057087e7691bsm510400ywe.56.2023.08.31.09.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:26:18 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:26:16 -0400
From: Tom Rini <trini@konsulko.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH] pci: pcie-brcmstb: bring over some robustness
 improvements from Linux
Message-ID: <20230831162616.GB3101304@bill-the-cat>
References: <20230814223413.169955-1-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZvPygrNpxFNFYAqp"
Content-Disposition: inline
In-Reply-To: <20230814223413.169955-1-CFSworks@gmail.com>
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


--ZvPygrNpxFNFYAqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 04:34:13PM -0600, Sam Edwards wrote:

> Since the initial U-Boot driver was ported here from Linux, the latter
> has had a few changes for robustness/stability. This patch brings over
> two of them:
> - Do not attempt to access the configuration space of a PCIe device if
>   the link has gone down, as that will result in an asynchronous SError
>   interrupt which will crash U-Boot.
> - Wait for the recommended 100ms after PERST# is deasserted.
>=20
> I sent this patch while debugging a crash involving PCIe, but these
> are unrelated improvements. I do not believe that this patch fixes any
> real-world bug.
>=20
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--ZvPygrNpxFNFYAqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwvyUACgkQFHw5/5Y0
tywcAAwAlZiMncSsXa4YtiTflDePL+XRWFTEs3te9ivuM/IXEE/obJj9prNqEKal
OlcRJR4Oxkjr1ZKE23wGhETaJGov4I76lvgLcQOKhFhU0hiTR6+Z7+99tR2sVimu
vak2RNeHSRhz74illr7z3mGBa077y+seUk3S+TWMfDYDH8hSGD24xZxZ0IVjIKMa
lKROUib6YjAMisn2Wh8/5c60Y99pDm7ITtdb3Kn885LLG+Pjc8S2HYA9AfRygEtz
7DsljIlQh/YuiLOoSaKt33mOp6dl62v8PYtI2G3ZuWyMNfsjVH+K2aLY7yTKeTLY
urwvDGcx0m/xuf8yRUgq9C2ngt6/cdpOUmrx+yLQ3oWepjod4OlgQgA+BZFwu3OZ
4k9Y1j1ug0ZyId8lMzqW+7XO81wA7MsdFhtRCl67p2jF83ubYl/BBj8Ia5AEmt1o
uZZlIyWIw4f1hlIrGTKN0jimPIC2xAG2v/g6gTknfDQr2tX9EziyNfKr4jbUAZta
SUfM7gLB
=IGae
-----END PGP SIGNATURE-----

--ZvPygrNpxFNFYAqp--
