Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D1BC982F3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 19:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F8C836AC;
	Fri, 16 Jan 2026 20:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oqsYOCwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A406838BB; Fri, 16 Jan 2026 20:28:45 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10AE78367F
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 20:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45c9fdf2a06so678870b6e.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768591721; x=1769196521; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jEgvs/moihqaoOErxv3ruyIOqtTzZ8swcEEBj+kboIQ=;
 b=oqsYOCwNDSdSkauOA+Q1QVgktNwygBn5vHg22G8lKP11KfIiUPX9BPRfPHlfcFGzN9
 d1JqGo/kBOBQv9KSNg1kGYB1XceLQ1fyc0AcvHXPWtB5/wj9PhXgHCspNC5Yh0V3VYqk
 mCkDYYp4sxs1E+5uwbpqV++Bpuiv4pmNBkJUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768591721; x=1769196521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jEgvs/moihqaoOErxv3ruyIOqtTzZ8swcEEBj+kboIQ=;
 b=DR05WnTS8sVm6fTKduG2mTA2YXCUIAR7dsjuqSH10tJ4WJXLHuPLPNFepnIcqktcXZ
 KCZ+XgWfK7OjdKb63XqbzvKXEVoobDvSMLzxT+25m6qjZoutb/M1H8OPcyO1rO94/anM
 dC+RzOC5ViNi0B9F5OEkDYtfPVjqubgmDn1snoSJ/yUur5URy8NfbB4SVmm9/nqsIJZZ
 OL6jhPSt9eLK+/EDO4oYOPCATIEhFKBVyQufk6yWru7FX1tN37etTKqTJewuXu7lLa7I
 Bu0iQG9cLL+8W/Qc2GogJlm10ZX3m5JceF2fipgYOR+5pnjXGL9a5wY8UMeaWyHQMjGV
 og+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfDGcOgx3mG6QaIKc3un+d9ZSFj+ljBf/trUp2wTKY7hqloUD5be4kFLDCZ5aQMKSW4ZXIji4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywd+1fJ8uOPP6EKLyR2g6PAOP+Lz9hpSZeJvDbuzF0uhAyLBTI4
 xVRXmLfoFdYptdGlDtVWOD9ePzKJitHIc6pktQ63gVNMH62h1x10iimnWWKKiUSIlOQ=
X-Gm-Gg: AY/fxX7WCsD/zlzHS6R75LWfTDTBi4Frs7F34v2AD+F/5OUgxNy613NTRewv+jEM9JP
 q8WZjUPuBnvDYcqwzuxYkPTr3tfvdoQKa0WVhQV0ES/q1yC6zD7pwjD0jsZPN3g7sw0CspcjdKx
 PDdJtF6O8AgFEngbhnKasMdUp2rGR5TLNIsrna7zGbjqsjf1EjFRsWkbVZU0s8bbszQZ22Ihlp5
 I2EAWOUvJqaFPqVe/OJ4HNH6RrFQ3VKYo1XZ8EMWNc2+H3/WaQNzXVAIGjbyPlXwOK+1mMoE+hn
 Q5o7/tOUZgYLexPLrhT7Nl9+4Wdy/A/xPnuvzQ0OLlB1+LYBWONidlVjpQSyXslo7r7odNTpV3z
 MX/6gppSbWPEdN70YQUrAi6UJ2OL7mMevJJX/ndY3XD48SwUR2mVJyxm98j5YuZPuRkcEkKHRhR
 HtbszUVoxoCcD0TRj+BuS4Y+zneeupff1sfGPofcfydK7TxvPkSn5qYUdwNNj2Eb2igHwkxx1Zw
 vBIAGu6wEWAoI1LUW5+kG+qrfosW/rylfrc9s4=
X-Received: by 2002:a05:6808:150e:b0:450:3c7b:e7d0 with SMTP id
 5614622812f47-45c9c0c23f5mr1633297b6e.48.1768591720729; 
 Fri, 16 Jan 2026 11:28:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9dff95a2sm1731483b6e.11.2026.01.16.11.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 11:28:40 -0800 (PST)
Date: Fri, 16 Jan 2026 13:28:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] ARM: dts: stm32: Add bootph-all in ltdc node in
 stm32mp257f-ev1-u-boot
Message-ID: <20260116192837.GO3416603@bill-the-cat>
References: <20260116-add_bootph_all_for_ltdc-v1-1-de4dc0ae1115@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EsYNrY+v/FG556Bi"
Content-Disposition: inline
In-Reply-To: <20260116-add_bootph_all_for_ltdc-v1-1-de4dc0ae1115@foss.st.com>
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


--EsYNrY+v/FG556Bi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 08:12:06PM +0100, Patrice Chotard wrote:

> Add bootph-all property in ltdc node in stm32mp257f-ev1-u-boot.dtsi
> to fix the following issue :
>=20
> Video device 'display-controller@48010000' cannot allocate frame buffer
> memory - ensure the device is set up beforen
> stm32_rifsc bus@42080000: display-controller@48010000 failed to bind on
> bus (-28)
> stm32_rifsc bus@42080000: Some child failed to bind (-28)
> initcall_run_r(): initcall initr_dm() failed
> ERROR ### Please RESET the board ###
>=20
> Fixes: 29ab19c2bead ("Subtree merge tag 'v6.18-dts' of dts repo [1] into =
dts/upstream")
>=20
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi b/arch/arm/dts/stm3=
2mp257f-ev1-u-boot.dtsi
> index b70cd8b52ce..c3c9c94f165 100644
> --- a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
> @@ -52,6 +52,10 @@
>  	};
>  };
> =20
> +&ltdc {
> +	bootph-all;
> +};
> +
>  &usart2 {
>  	bootph-all;
>  };
>=20

Are you upstreaming these? Thanks.

--=20
Tom

--EsYNrY+v/FG556Bi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWqRYgAKCRAr4qD1Cr/k
CvLwAP0V23ghorscORmR2MndF5n4juoLhCniHNJd2HHS3ECovgEA5FQfQqfyX0WA
PeYCZ1k1G5oqLmSr+nu6w4FCPKtcWAY=
=5awd
-----END PGP SIGNATURE-----

--EsYNrY+v/FG556Bi--
