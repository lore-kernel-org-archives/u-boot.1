Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FEAC001DB
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1671C86874;
	Tue, 15 Aug 2023 16:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hTTQm5gy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F118B8682B; Tue, 15 Aug 2023 16:43:50 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03263869B8
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-58439daf39fso57966857b3.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110626; x=1692715426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cEKV1PvfjwULo/p8SFNut+msq9SUtIS6K5WRP+xTVjo=;
 b=hTTQm5gyuJtYxlzLZmN/hBMbUXRLHTK0yfIladLuZ9IcQZulmeYuBn7sNMBneZXFi9
 TeARxdKvmiuJl/JMs2iw7/RCv1GUiummLNbq4GzMbAN5Ne/MFD3Cs5nOD4lcpUg4Im02
 LpK5XqyXEQ7BYQlSLT09OEmVMrzUXbPOUxTb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110626; x=1692715426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEKV1PvfjwULo/p8SFNut+msq9SUtIS6K5WRP+xTVjo=;
 b=P5/1jOmW36fq4YYueHCC9Yhq+VdVbx8L7AihcHH1MHdhQlAHgZcqpM2AbhJi2ACFtr
 TuKD586rU4/jHjm6ITO2cru4Op2zG1lJReg0Dx1iDbaPtb014nuCIjmfeIdu40GZGAUM
 lgB69fuNGQdtZM4GEDPKoMfAVwP2vg/+z45mgZYLi05qFimTzWLUh+YG3Y75MIbTqEpW
 fUbY3SMqHTP/qqo85pCbCp5sc4rjgKFeFJP/SY68CzRkPfIijhWLz1xPB0eoYzRizMlV
 bC10XvAbKuH1O017fVwq+bYYai+Kqr+7lk8kuCxFhIT4sSkrc00V+wQMtyEMI+X4/XLT
 agkA==
X-Gm-Message-State: AOJu0Yxfki+s4WC/SozwRYjDZOMH7fQRorDTA9T1FQEjIWEUWUYSgQ5g
 yecKXBtK5AoAyxug7NcAKlHhPw==
X-Google-Smtp-Source: AGHT+IHT41EjraCv4UaxQHgSnm9euMKeHQzZHjHHacA0fSt4zNwIS5IU/n8PB+/p0zMK9StwxY/pzg==
X-Received: by 2002:a81:6d49:0:b0:579:efbb:cbe3 with SMTP id
 i70-20020a816d49000000b00579efbbcbe3mr14260642ywc.43.1692110625806; 
 Tue, 15 Aug 2023 07:43:45 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 w187-20020a8162c4000000b0057a918d6644sm3435759ywb.128.2023.08.15.07.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:43:45 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:43:43 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Michal Suchanek <msuchanek@suse.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Samuel Holland <samuel@sholland.org>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3] gpio: Use separate bitfield array to indicate GPIO is
 claimed
Message-ID: <20230815144343.GW3630934@bill-the-cat>
References: <20230801232602.86719-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mtCMggOydFsOg159"
Content-Disposition: inline
In-Reply-To: <20230801232602.86719-1-marex@denx.de>
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


--mtCMggOydFsOg159
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 01:26:02AM +0200, Marek Vasut wrote:

> The current gpio-uclass design uses name field in struct gpio_dev_priv as
> an indicator that GPIO is claimed by consumer. This overloads the function
> of name field and does not work well for named pins not configured as GPIO
> pins.
>=20
> Introduce separate bitfield array as the claim indicator.
>=20
> This unbreaks dual-purpose AF and GPIO operation on STM32MP since commit
> 2c38f7c31806 ("pinctrl: pinctrl_stm32: Populate uc_priv->name[] with pinm=
ux node's name")
> where any pin which has already been configured as AF could no longer be
> claimed as dual-purpose GPIO. This is important for pins like STM32 MMCI
> st,cmd-gpios .
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--mtCMggOydFsOg159
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbjx8ACgkQFHw5/5Y0
tywe2gv+KzD6i91xvPuJvlAK/E/c4Z7gCT6kG143w+YSUQs4m+5n2A9Ow99rd21e
f/pTxSn4Gu72/P7IZfdUYh+no5D3SUBKRq+BfVescbIGPnhs5X+haIkJS+f5jpdj
Bx7cZGC07EvsT/m5aGxJgHb2hwTi13nUVCGSCHHZ/HsQFCTCgjWy+q0Vku70GwwE
P4Z0O0Zj7jCqNGecqoblPjrobDwb0zE1kdeatNnyc3Vm1yJRTo/IYBriYD2HBT5P
lUEjrmx5NWm7lkHA6el9ix4OCnXb+9X6o1ahlFhnePapzHde+Q6SVubWR0+9Y8zQ
L6/Zg//nDzznOFSbe6qJwkFUV5hMD6A6d4G59SbUK2BolKmFv0suuusvuUwcgLxW
u8IEpc9K84imA3DPpkZvFbuRa6FcaFgezirmMneOmfDwe8NVDIHBmgfLmuis3CQ0
2CjSPU5g68LVnIi3cY4yecVUOK7cdsNo/hqO1ETcGzCOntLLbqZN8SBbwgIBL1Dl
BuIelNJL
=KBvC
-----END PGP SIGNATURE-----

--mtCMggOydFsOg159--
