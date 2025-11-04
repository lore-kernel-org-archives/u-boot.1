Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAA7CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 21:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C37F8390D;
	Tue,  4 Nov 2025 22:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EXSuoGQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FBF8390D; Tue,  4 Nov 2025 22:12:06 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5A62836D1
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 22:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c5308f6aedso4194323a34.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 13:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762290722; x=1762895522; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dt+gGkj6nP57Qp3K2emj40kuawGT95sRURSUAyyt9v0=;
 b=EXSuoGQai09vLfhK/U+EQ4QQs2TStkTAFMDGsEZT45GrnNCIcKQNxTkbWH/F4jFR2d
 iaPrlw2ulrl9gEEYlfAhUt0dEIscGI9bZ9F9nG7wNCBM8LtR7VLcNfR+b30o5OnMtc56
 AOgIgUAoLMpQszn+sUAJ8eSmWFhZFCcMTnLSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762290722; x=1762895522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dt+gGkj6nP57Qp3K2emj40kuawGT95sRURSUAyyt9v0=;
 b=e0/pho3F68lABVwz+I+gvFhbJAwuY2GVsAYsnDD4nNUrxBNmUjUqa6qi0iiv26pi/M
 JEAwv+EnqQbm3d0sqfpHbWimDz79m8nnvjPsfq7fYBuuPHdyYKQdKKPgstqylSoFqrSw
 /IQgKHtGxhm7lFe2D3Unw9GPe4iAWn+DDrmKCDj2CN624oudGzrrnRAQRM+GIFg0Ftov
 7huT6hD5D81sjgfvKgHxzLG9pxAqsAEVdP/NwxEu/GetP80LpPgH+xyIDGDLtD4QzTw2
 mE8pMPdLGZfcupL+D9HtB0VzMDWjrHWf3nLWlWJeQcOZpbeNQdpouaiPnRstXU1CzAhz
 NH2Q==
X-Gm-Message-State: AOJu0Yxjq9+mCRI7SuxHrR3I26w7JLrGBUw1Mmwr0yF86tB9UGASD62S
 v6x5ZaHdMo4OBPu6kgPpK1Q/fKKdqpegbfo9JEKMxyDYmrxzhAlJWmqurXyzhNKNKCY=
X-Gm-Gg: ASbGncsqTWwkLH67OZzy8/poxv5waR8Lnskh7RFrF1+4k074MTWXCnhbwK6dF6IMCAC
 E1zHlr+B0u3QTWVc1cAG1rAOdjomwRGrbqySYkvb1nwajk1jNQncG13RnhP0PrSFQqr4yEuV95Q
 aczPSeMKbb94lgqIQrFC68UWI7WnoMTcwjfRaZTTAOsTF4ZqiYb3guarONiIY4tFQ63KGemDlP0
 4l7Bv39t+PNqQw2M0Pby6G72b5cMxm2vkYnpJbTPrpW15/+8DyTJ8U3hAitf5aDa/YuEFDWXGvR
 H9p9nSKQ4JRs/stg5czIIOMBeuy9641WcEOpkTmXgJ+Zw+3QvQYduHh4wJ+dghY2iRJh1DGHjEZ
 CdM5Iuf6pHtC4aY4RgcHa2x3/MUQU5rzlHc9Oe9ku2RYrTMhRUcPKRCN7yZJ7IWUhk0Rg+dsCAC
 Am92zf8k/ZZeIziqO9RtmKiViL+N2/frQ6F8PmPII=
X-Google-Smtp-Source: AGHT+IHJRHIZDuhY9fUnwGKkeMuAzsHVPVXz56sCP6/peCKSLRptMP0b78FF5ceCGGmC/VImLJUAIQ==
X-Received: by 2002:a05:6808:189e:b0:44f:6d6d:4a04 with SMTP id
 5614622812f47-44fed36fed5mr421583b6e.58.1762290722357; 
 Tue, 04 Nov 2025 13:12:02 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fd84b3662sm1012713b6e.9.2025.11.04.13.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 13:12:01 -0800 (PST)
Date: Tue, 4 Nov 2025 15:11:59 -0600
From: Tom Rini <trini@konsulko.com>
To: adriana <adriana@arista.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Richard Weinberger <richard@nod.at>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH] boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI
 boots
Message-ID: <20251104211159.GH6688@bill-the-cat>
References: <20251104-smbios-v1-1-99b79a8f59b3@arista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xftis/SurcJsclQi"
Content-Disposition: inline
In-Reply-To: <20251104-smbios-v1-1-99b79a8f59b3@arista.com>
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


--xftis/SurcJsclQi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 08:15:21AM -0800, adriana wrote:

> The Linux kernel can discover SMBIOS tables through two primary methods:
> 1. Via EFI tables, when using EFI boot;
> 2. Via the 'linux,smbios3-entrypoint' property in the /chosen node of
> the device tree.
>=20
> When U-Boot boots a Linux kernel using a non-EFI command ("bootm",
> "bootz", or "booti"), the kernel relies on the device tree to detect
> the hardware. If SMBIOS tables are available in U-Boot, they should
> be passed to the kernel via this device tree property.
>=20
> This patch modifies boot_fdt_prepare(), to inject the SMBIOSv3 table
> address into the device tree if there is a table generated by U-boot.
> The "board_fdt_chosen_smbios" is weak in order to leave the possibilty
> for specific boards to select custom SMBIOS addresses.
>=20
> The changes in this patch are added in the context of supporting this
> device tree property in linux kernel:
> https://lkml.org/lkml/2025/10/24/1393
>=20
> Signed-off-by: adriana <adriana@arista.com>

The Signed-off-by line should have your full name please, thanks. Next,
we should have a Link for
https://github.com/devicetree-org/dt-schema/pull/177 and looking at
that, it's just smbios3-entrypoint now. Please wait for that pull
request to be merged and then post v2 of this code that matches the
accepted schema. Thanks!

--=20
Tom

--xftis/SurcJsclQi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQpsGAAKCRAr4qD1Cr/k
CiqUAQDRSEkQ5trGp0XBEJAl0cCLWiuDB8H28R4kN7vNFy3esgEA3zR0qPUsWDVE
bTB230jTjCNF+6L/suarW88bQ9UgWQA=
=uzb7
-----END PGP SIGNATURE-----

--xftis/SurcJsclQi--
