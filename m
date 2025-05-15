Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD804C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D399A8059D;
	Fri, 16 May 2025 01:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ut2WeBTe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1F0A806D8; Fri, 16 May 2025 01:30:31 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9234F80107
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-401c43671ecso1104134b6e.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747351828; x=1747956628; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=16f/3v6b5Dk8tK7N4Ozh6jRNV8cnRutFLlBjsotF/Xk=;
 b=ut2WeBTe5enMLfe1AR7385naXVck+u0H0eaWd/2GwlIppt8aQRTEonH7rfYJ5xfSvZ
 dJK6iemAkZBO7cf6zDJLTWM2kjY8QDr6Navkt7BjwVJzjFn9BYTqFXqXmKnr86Q8gI7G
 motfeJwfvvWd9HqfhApE+WqKF1n18+6wfbC1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747351828; x=1747956628;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16f/3v6b5Dk8tK7N4Ozh6jRNV8cnRutFLlBjsotF/Xk=;
 b=emRIno4mcYetWx/2bLkDfTNa3+7Ye2DEcPiwdxxWLHkoZjJQZRMpBdjkf/RGyG3yY/
 JrVim+DPdtZrKJZuGpyVigxNxT87mzTvvkBTl2S5FJkiTAul1bAxUiCVkKYPVcAMBMvb
 YiLKjR0h6//YVAd0ADsSgXr0QrZuDEfbPZEDFKXO4rSWem1ve2D3DUk9DGZxz0lyslN5
 tIMoYF5U12KWOO7GpV4cKb5QJsHV9VVXn2bYY9bv5DOdCkjp+Ahe+OSIP/qiNRECKNeH
 e052Wq1hB3y4w5bYv00/MLumSaC9eOEpztGBiHBj8BAKi7TibXbDvSds8qOBHftMzW96
 GcmA==
X-Gm-Message-State: AOJu0YxoybceXb+cMW+EVDfckTQ7tB1Pw0rNJnJP6IV9RK+6Du4IjZlN
 mwLhklnwAYVfnlcqOMHeULXUf+p/iuAagfKDs2chqL6yu3napgPkE4H8u9e284V95g8=
X-Gm-Gg: ASbGnctZ9UTQyFGmFMCL6QjPlMU3DShbn29DkrdZKL7XHWqeGvUwPLEwz8qrUhaChTQ
 ZTd7C8HZ0TPJ2CtNw5bJKJkH3YsZWLQbSo2h4HQbHojQ15hLMBr38jdfk96yL6PulWAMR1Z6z9o
 T9UMyaBWT5/U3JUQ+hSEFgk+1O097DFfrx4DOZu9I4g0MVKA2cYGGr3a18AkGsyLorfXCs6x7GW
 B2HXYRH7jSNXVrDWta/ZHrhOsRlRxGy6VwnRS7uNkwsW4nNkETXdiglbtsQImeTNeH7FXWT1Tcx
 2VKlXc65DqMrHWlx7of8RSGML6YWkK4zE15u9ajtZLHILj7vjHVXy4j74huSNq3ytlmkd6DKw3+
 78Ln5OgIUtI47
X-Google-Smtp-Source: AGHT+IGhGVAUHGXWxhOmMdJjlroVqiPTQEytW9LUE1fZYjzuARjoYc7YRO9902OlwixGrh3tnvPy9A==
X-Received: by 2002:a05:6808:201f:b0:3f4:e3e:10c5 with SMTP id
 5614622812f47-404cd47171bmr3131901b6e.0.1747351828187; 
 Thu, 15 May 2025 16:30:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d98060ecsm122141b6e.27.2025.05.15.16.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:30:27 -0700 (PDT)
Date: Thu, 15 May 2025 17:30:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>
Subject: Re: [PATCH] ARM: Align image end to 8 bytes to fit DT alignment
Message-ID: <20250515233025.GE100073@bill-the-cat>
References: <20250512161033.146396-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zrs50gSnXTqhDgex"
Content-Disposition: inline
In-Reply-To: <20250512161033.146396-1-marek.vasut@mailbox.org>
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


--zrs50gSnXTqhDgex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 06:10:28PM +0200, Marek Vasut wrote:

> Align U-Boot image end to 8 bytes to make sure DT alignment requirement
> is fulfilled. This fixes a possible failure in fdt_find_separate() in
> case the U-Boot image is aligned to 4 Bytes and DT is appended at the
> end at already 8 Byte aligned offset.
>=20
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Sam Edwards <cfsworks@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de

Link: https://source.denx.de/u-boot/u-boot/-/issues/30

That mentioned, we should stop waiting for the solution that covers all
cases and at least get more cases right.

Reviewed-by: Tom Rini <trini@konsulko.com>


--=20
Tom

--zrs50gSnXTqhDgex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgmeQ0ACgkQFHw5/5Y0
tyz4AAwAkbM+BkaawZxo8Zqw4q1PajjC+kmY6vAZy/gEm+V4VNc8w38hEUciIaDQ
Mho8c2iH7V6TxnRxGYtLuQYERbAYjhQ02ypevtQcXSFF2ewmf4ocSOww8c8u1nqg
H9uLgHM9sTnIvtyrIVf4uc8zvUKa6UugQH0SsVfpyUrVDkvB6CYSyIMBunZK9+aB
2EQ3sDcgw0hS+LTH8upXK4ToC3bXz31PCh5GZRI86yJZloQnooXEvyz52yuH5C7+
54nbjh4wt9xVS8859Kh8BmZ/3+ip8Xms0Oab6inKzi5mkh/hRxBqbjGSijEVdfv9
6/yqPehOn3coouJNpB2IrdfRJse7jzmZTyTamvdxZ3Jin/8lhG3VENpChwk1cMng
baV8jieVbDxRIkvrEUndbGz2IWsoJGyhCCYzWqQktymQAbqjrAR98Yaz1hkcdqNW
NB6kxaN7vxBIQTW8EJPYCUwfpW1FNCgIYWxfOz7XVw9e+TCVkzqMARrmh7qw7HWF
bHou3QyN
=/+aG
-----END PGP SIGNATURE-----

--zrs50gSnXTqhDgex--
