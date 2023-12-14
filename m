Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFF9C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC6B287AAF;
	Thu, 14 Dec 2023 18:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rt6I90ri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3771787AF1; Thu, 14 Dec 2023 18:53:54 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1842387AAA
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5e248b40c97so28545627b3.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702576431; x=1703181231; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W2ygLQwMIlcH7HdYeM7aoemQchFBkYNwKFfpz3VdS9s=;
 b=Rt6I90riSBoAgm2aoezRGJAnE8A8zlfhS159LZT4+xQKn3WzRYpMRDdPKGNxMlo058
 svdJmulKHSkE/yHUYLCie97LRgxZ9bHbTxJMAszBR3gHRfEwQQoR2qRcewUPK3GCP+rm
 5HyFtkYYNLKvSd6nW6VtgkO6v3Tma4R4qtzkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576431; x=1703181231;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2ygLQwMIlcH7HdYeM7aoemQchFBkYNwKFfpz3VdS9s=;
 b=QIDJ7+oCB7JbBleDuccuDgLnXg2mOvISAsG4PGWbcoufUQkHfyQ5F6a4ug4nG9kxZy
 3pXYagZTAv3iEnvV+wxfJnblwZ43Q3ocC/dkzowJsR2t94K9qTV8IzJuImBPn8iMf1x+
 aSmLQpe2GZplUyxlS3/uxzSWxs7ia0t7XIklBZ2igKHkYRO3GaPQaDhi251rwI8E/LTU
 xZeZ/RzX0B8MxiIfpkKcMW4gBFW6EyZXAwnP+Xp9tJQ/v8z5qKUe/9KmMQborzCKqdu3
 cxNqOTK1ppiorvaj2G+b2QwA+6kvmpu4Tl/ieybsoujymjS1iA9d+MkSUUT4YHYQfN+i
 L+1g==
X-Gm-Message-State: AOJu0YycJ+rgB3P/0NOIQKXB9j/5/FtW1075Hrgi3dR3KGtA93E76ucr
 uIq4MQOUjlPTit9R39fuITbR/A==
X-Google-Smtp-Source: AGHT+IFw50gh5/z4n4xxHifNHawWfXz8hc+Vr312QRedyjIiOBVxuwzRMNQ3nyep2PM8CsOS6Kqp1Q==
X-Received: by 2002:a81:6f84:0:b0:5e3:e9b5:af8f with SMTP id
 k126-20020a816f84000000b005e3e9b5af8fmr718105ywc.71.1702576430767; 
 Thu, 14 Dec 2023 09:53:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a258d8c000000b00dbcb622b2e9sm2192682ybl.53.2023.12.14.09.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:53:50 -0800 (PST)
Date: Thu, 14 Dec 2023 12:53:48 -0500
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] arm: spl: Use separate fault handlers instead of a
 single common one
Message-ID: <20231214175348.GM2513409@bill-the-cat>
References: <20231214162931.34236-1-csokas.bence@prolan.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JDjURCmjHCgYWQeL"
Content-Disposition: inline
In-Reply-To: <20231214162931.34236-1-csokas.bence@prolan.hu>
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


--JDjURCmjHCgYWQeL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 05:29:31PM +0100, Cs=F3k=E1s Bence wrote:

> It may be necessary to set breakpoints etc. on a specific fault handler i=
n SPL.
> Add a Kconfig option to separate the different handlers into their own in=
dividual infinite loops.
>=20
> Signed-off-by: Cs=F3k=E1s Bence <csokas.bence@prolan.hu>
> ---
>  arch/arm/Kconfig       | 10 ++++++++++
>  arch/arm/lib/vectors.S | 18 ++++++++++++++++++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 328e2ddc33..47494cb72b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -79,6 +79,16 @@ config SPL_SYS_NO_VECTOR_TABLE
>  	depends on SPL
>  	bool
> =20
> +config SPL_USE_SEPARATE_FAULT_HANDLERS
> +	bool "Use separate fault handlers instead of a single common one"
> +	depends on !SPL_SYS_NO_VECTOR_TABLE

Will this dep catch that this is only valid for !ARM64 && !CPU_V7M ?

> +	default n

"n" is the default, so don't add this.

Otherwise looks good.

--=20
Tom

--JDjURCmjHCgYWQeL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7QSwACgkQFHw5/5Y0
tyz0nwv6A121+un+VuOpNEhkcZK8etORy/2WuQfXa+00sxw4QnEurYZmvm00wZQ9
9g4vPVwDgcFUMTsyX/+aLdmF6iUpDsNzoJKnUzBEYBAt1mQle6xfL9z2qjv1wi/O
F+DFMgcJh6KjxYUAE7/qhS0krKJP9RT2PfVfUzKdRasG8FHhOtHYUQIjp7p4fLt7
UX035B2zlBpDNQbwcZflGZhVzySvSnOy4ghNeOi9uQnLMKHB01gNwiAUlrJto+km
ziUDwYUKwQJ9+5dMykq4KwLUsyse+cfRofbUruzqyHVLyPF3+UCC9mA5VKCq5GCl
h7uvThfRyp8Yr5UgYqsvV8k9caeHV+3zwdqFLB14fqvBJ+CC3oiLJC/JNMpax1Qi
ktr4fo/+KnDl0R3zR1I8o5qJAmMroc3g1IRdusJoWu9OqSfacZh0KI576JFkq8jA
mVxT4+9R0zzyCdhAY7Li21Z61JvsR+6+u2qBlYDYXiwZeWhFFEgds0IlNhtIcgls
RXENojAg
=JXx3
-----END PGP SIGNATURE-----

--JDjURCmjHCgYWQeL--
