Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4F9C25B7C
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 15:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2DCF87EBD;
	Thu, 23 May 2024 17:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r09v6A9s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2472E87F52; Thu, 23 May 2024 17:32:47 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4141287E88
 for <U-Boot@lists.denx.de>; Thu, 23 May 2024 17:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-69b782287f9so11601866d6.0
 for <U-Boot@lists.denx.de>; Thu, 23 May 2024 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716478363; x=1717083163; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J4nWq6AKpnNyvG0Izs7zMLPkpQJqO2BMmVH8Q3gHeaQ=;
 b=r09v6A9sew+jFqtAUuVB1LP6/YuBfUiopxJbZr2p4NuNq26ZhVfsvSkhnrlryIh5WB
 66/epZezRXlISoQyU4m89XfEf94tQy/LsDrXXxuwlg2LJTmwYmwarJHcxO51CVX7LDNh
 l2Kyi+SuS6uZeMOMzSgV0R7hQp75d5jp1lyIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478363; x=1717083163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4nWq6AKpnNyvG0Izs7zMLPkpQJqO2BMmVH8Q3gHeaQ=;
 b=SO0x5bOSxw+DZ4V6ZjLp0ZPk7OkWc+A5xVDZXMfM6BDEJ6pJAZ042aUyFR8L021y8+
 jfSlwLq4/4oPMVEoGdDPZrG+W90z6lgChhDqRMw08dox/nf5wFVFlJvXBrkrwc0i/R+D
 h4y5UiOmybCEhuKJj70WQiQ0ZFXzDmlzv1HM7+54Fbixul5tSzo+nRA6WI79a+bNnO2q
 SA/KPkK/hZHUbzJmhdnr4U+QKUSNe92DMj9uaep6ODbHQni8v2//IEutha/bjgb/0IN3
 Izss9AeVhCRzDPiPVjGH650V/CkeBMpb4Uy/J+SgQGAAK/unlOe/ReJhtnzWun59x2aH
 LWZA==
X-Gm-Message-State: AOJu0YwUH+XyKNmDXSfuDEgB3T4QxpM2TGKV1c70zt7NPf8VcSa3TR6i
 A2/Eiz9zxfbi42+qS/1uHUVuDSDpXmNNUuS4izj9npUoOWlX3hSIwbfyW38edG0KqL6PLcR8jQp
 q
X-Google-Smtp-Source: AGHT+IEz4SwnXgaog1M3dnvuOJ5EmnujASX0Pu0Rmbzg5gusgmRQDmvufxjcP5QEBYf5vTRTpMaSEw==
X-Received: by 2002:a05:6214:3986:b0:6aa:5098:8846 with SMTP id
 6a1803df08f44-6ab7f35358dmr57354676d6.14.1716478362753; 
 Thu, 23 May 2024 08:32:42 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ab93037dabsm6104846d6.28.2024.05.23.08.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:32:42 -0700 (PDT)
Date: Thu, 23 May 2024 09:32:39 -0600
From: Tom Rini <trini@konsulko.com>
To: "Brunham, Kalen" <kalen.brunham@intel.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Message-ID: <20240523153239.GS2568172@bill-the-cat>
References: <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <DM4PR11MB5296769279BCDD505F614E6BE3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521234624.GF2568172@bill-the-cat>
 <DM4PR11MB5296918A0447369D6B27891DE3EB2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240522143908.GI2568172@bill-the-cat>
 <DM4PR11MB52968E794BE8B0A882A519A6E3EB2@DM4PR11MB5296.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9ZJ2HibkFYxPCliW"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB52968E794BE8B0A882A519A6E3EB2@DM4PR11MB5296.namprd11.prod.outlook.com>
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


--9ZJ2HibkFYxPCliW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 05:22:24PM +0000, Brunham, Kalen wrote:

> Hi Tom,
>=20
> BLK is currently a dependency for EFI_LOADER as shown in the snippet from=
 lib/efi_loader/Kconfig below. Perhaps the question is why EFI_LOADER requi=
res a block device? If I remove this depends on BLK line, then I can enable=
 EFI and successfully simulate the EFI hello world on my test design.=20
>=20
>=20
> config EFI_LOADER
> 	bool "Support running UEFI applications"
> 	depends on OF_LIBFDT && ( \
> 		ARM && (SYS_CPU =3D arm1136 || \
> 			SYS_CPU =3D arm1176 || \
> 			SYS_CPU =3D armv7   || \
> 			SYS_CPU =3D armv8)  || \
> 		X86 || RISCV || SANDBOX)
> 	# We need EFI_STUB_64BIT to be set on x86_64 with EFI_STUB
> 	depends on !EFI_STUB || !X86_64 || EFI_STUB_64BIT
> 	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> 	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> 	depends on BLK
> 	depends on !EFI_APP
> 	default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8

Do you recall why this is Heinrich?

--=20
Tom

--9ZJ2HibkFYxPCliW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZPYZcACgkQFHw5/5Y0
tywClgwAjHxIgvtIQTq7F+efoS0GqwOewQSVqoXrjg8Dys/PMSc3/BDNkxGOEkoE
+zDrmp5etRo2M9OzdmVT+x+iR2TgN8Ys5GNqSisMA+oxnh1NA95IzjXfBRMcPRzO
juIiGvRmfjZB8LyjGPW1V4osfeyFi5lnrzWGFuQbRHQaFKyUofw+aKOQPS54xgUp
e1DPAfEDHiQq9CvrmfPHyfQ16n1IT6/jHIct3fiPlAtzrBpmmXEt7CLdFxEX79rY
Igfbc8iLh9h6p8V9mHaxmXuhfkGgGENFiy6UsUMm8vG/LUcUb1cWW+yvQaUL4KbC
Vn1gv7/Vj2SkvW0lZIicOoFrfbY0exnmiLiGHm7O7hSOc7N87UT2MC0Yu0XuD97g
zD+VgWuZPajvpAbgzJ62ltUWR7o1BgyJ3PorQQOGhXMX1Hg3sdaqs48BG8Vqto7F
vd0K89+zxEkerOvz/RasP5Yv2mI55EYnMSehd302KRR7SNNfhDmZ/LsLK9NFWBs0
ySxQYSwX
=zvlI
-----END PGP SIGNATURE-----

--9ZJ2HibkFYxPCliW--
