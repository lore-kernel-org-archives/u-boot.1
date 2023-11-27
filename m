Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0A2C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED6D877CB;
	Mon, 27 Nov 2023 19:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V7Ft5oqu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29CEA877BE; Mon, 27 Nov 2023 19:36:04 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E06287772
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dafe04717baso4040048276.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 10:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701110161; x=1701714961; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YcZg34yblkWeKgZHZVydEI698tm6FTIjTM2kC8F7AdE=;
 b=V7Ft5oqu0rP0Wpf2l4XSgk5ebnF3SITbrWIb2DsV5yx0NfJinjCXuYwasXb17hh+Xv
 panehxcMS8ZHyxlk57ivUtQ2V0U29UtO3HPjlFcEZPFQ7DUvf/711iE2ca3Uqf9rEYsT
 /O+mKl+lSmXPHNlgQMm2XLHPE8XQWKMOk6WCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701110161; x=1701714961;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YcZg34yblkWeKgZHZVydEI698tm6FTIjTM2kC8F7AdE=;
 b=HcbIK8HcMyjc3/L0jb9migO9SOir1EZVtvvhxYEaZn2jbzadJ6gs39FMAAi+aLUAgr
 P6vxBfQI/7H5VKCsDxi7MEM05qGCOorNXtv1m3GfO6Nv7507mBTnsTsfnkrfu/KPidxR
 DDVA6pvRj8pqwlJBavJKnRVqZdtxfEEsG1AlO7DV2NrO0uYF8ayS+UtXWIE3BZ1ec8lz
 Eqvg3SxJ4F4YPT1ZxFR5bP0YRORsP1p9DuUKxaAnrDNFWCHfH7aA1OyfNSG9lZv2RGKv
 v9LK0xIWiXU6iT3MWEd+i6Vs7unSdjqQYZ6DLSG8xJw+PGnHMGofpgTxZaSe2UqZOC97
 uwXw==
X-Gm-Message-State: AOJu0Yzu6VxwhtVdWShODQnsa126uX5u/UJ14m2P6IZkSACgvyvQpqlI
 I8qxdQA8q7qpWaP1rSRUh7WMKLarAq42MzZWkla+Zg==
X-Google-Smtp-Source: AGHT+IFf9A7Rx+ZIrFx/v6jdEPefBCAOGUasMYA3UEh71GCmFheHXbfd4S96WN4FlQwLtc4MQcZx3Q==
X-Received: by 2002:a25:4286:0:b0:d9c:7b92:90b9 with SMTP id
 p128-20020a254286000000b00d9c7b9290b9mr11524780yba.14.1701110160801; 
 Mon, 27 Nov 2023 10:36:00 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 m142-20020a252694000000b00d9abce6acf2sm3210772ybm.59.2023.11.27.10.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 10:36:00 -0800 (PST)
Date: Mon, 27 Nov 2023 13:35:58 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 21/43] mach-socfpga: do not overlap defines with lwip
Message-ID: <20231127183558.GT2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-22-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KGf43pKHEtg8+E7g"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-22-maxim.uvarov@linaro.org>
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


--KGf43pKHEtg8+E7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:57:04PM +0600, Maxim Uvarov wrote:
> Fix compilation issue with overlapping lwip and march defines.
>=20
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  arch/arm/mach-socfpga/include/mach/handoff_soc64.h | 6 ------
>  arch/arm/mach-socfpga/wrap_handoff_soc64.c         | 9 +++++++++
>  2 files changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/ar=
m/mach-socfpga/include/mach/handoff_soc64.h
> index 902fc6bfb5..9b85e5865b 100644
> --- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> @@ -78,12 +78,6 @@
> =20
>  #ifndef __ASSEMBLY__
>  #include <asm/types.h>
> -enum endianness {
> -	LITTLE_ENDIAN =3D 0,
> -	BIG_ENDIAN,
> -	UNKNOWN_ENDIANNESS
> -};
> -
>  int socfpga_get_handoff_size(void *handoff_address);
>  int socfpga_handoff_read(void *handoff_address, void *table, u32 table_l=
en);
>  #endif
> diff --git a/arch/arm/mach-socfpga/wrap_handoff_soc64.c b/arch/arm/mach-s=
ocfpga/wrap_handoff_soc64.c
> index e7cb5ea89c..df0701ec85 100644
> --- a/arch/arm/mach-socfpga/wrap_handoff_soc64.c
> +++ b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
> @@ -10,6 +10,15 @@
>  #include <errno.h>
>  #include "log.h"
> =20
> +#ifndef __ASSEMBLY__
> +#include <asm/types.h>
> +enum endianness {
> +	LITTLE_ENDIAN =3D 0,
> +	BIG_ENDIAN,
> +	UNKNOWN_ENDIANNESS
> +};
> +#endif

Since this moves from a header to a C file you don't need __ASSEMBLY__,
and just move the enum and don't move the <asm/types.h> portion as well.

--=20
Tom

--KGf43pKHEtg8+E7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVk4Y4ACgkQFHw5/5Y0
tyxDyAwAlseTGazeCcyUqQMeW2LlvP8garXQc/B2PvJrUuBnt0yyUAQg1fCU6pbt
r+dcY4ousJ3y6gVSTTbGHBJb+ZERkSV7tjEcG9CJyrPWOJ5g/Tpp4+JSzM3TjH/P
ohLlyGtErFJ1tqzorA/rBe5kGx9Db3BV/vN5d2a+mDPmnpebLJVvCRbnGux0LEuT
I1ncozO4fCq2cIJquHDCbKW0XFe9Xh3uqoI1v0U+OP7afcfXn2aO4fLoNjNqMzXL
uvLMiRmjLfAoprG4WQi52lDpxiDo7nQnT7Mr7GqfWZVv5vh0FM84gvYz6X7HIwUm
QHR0BujyqjDyEKUQmobkKyM7YxTX5c1z5FMTYL2R9CJ2Zo/B2bZXzTpC7OEvdxRK
zOH/WI3vGi1hUuXlJVQClV5Pkmilt3XmIFN0rhf4gPGe1eDAIVPM8+LtvqewFE2v
oWO7DcN3KbG5jDVgfhLQy4N0xYcmhX2Qmxuehkgsb2CzNKvAqZGqop/9b431Tray
jLKhI56o
=i9xA
-----END PGP SIGNATURE-----

--KGf43pKHEtg8+E7g--
