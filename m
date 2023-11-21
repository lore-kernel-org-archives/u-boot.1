Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC87C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 19:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB55871FC;
	Tue, 21 Nov 2023 20:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OYiWyzR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3801386FB2; Tue, 21 Nov 2023 20:07:28 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E11E871FC
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 20:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-778a6c440faso296744185a.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700593643; x=1701198443; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ix3JNel68a0Dvk75kNJO3KQAzLbCZH+r375Eg5PjIQ8=;
 b=OYiWyzR1SnibozPQnuW4zdb/6z/rSv4cyX0+UjYJL350GfdXYsinnw6Mgu/WH1XNnS
 m0W8AyOEvleIuGoEalkhqgemjxN0Uu4HY3vo7tcALgeZmdHYiCTpQbUNN69mZkcgMzIW
 TVSWn8OORbkgGGDeKwkKdneZh6JW5nkYqL5Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700593643; x=1701198443;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ix3JNel68a0Dvk75kNJO3KQAzLbCZH+r375Eg5PjIQ8=;
 b=CjOLVbpghRhg0U5z9iexcLIU9tTSqDPoalg2cSL3zUh9jqurlZSZarB9nMY4gicUNk
 lnEOoKma8DOEjDyYKo9rikDjvhpORi+88ZPo9NnA+5AYaheID+yhqdkrucDtCUp4A62O
 Ji9aK4JDNsyozTR7Nd0Rpe+Mfoof7mJXUIdb/4G7MZPs9CuRfBkEcxltxltvQkkZswqc
 ijeBOwV0/VQR9bmLK0ubM4f9GEUdTAdF2J+y8r0bl79DOK1nYgQghTZnWLN/rfPZeSRY
 cdHL9Yumg09U49m6tf52PPpUtw+DkIgaSC5/PE2Xj+SQGCZqZ0WPvWuqh1Ksn7CiyKH1
 gRFg==
X-Gm-Message-State: AOJu0YzYvnP4c0+R2m9sRUHApkBf0Wptimx2DjGe9F1543whNA76CAUh
 iRxKZekOhYF8Esm9UErzB2nMWw==
X-Google-Smtp-Source: AGHT+IEnjOjB1sgmpF+0K1fO1fWPD6Ak4SfDb4cyE+B2fKVL+eydhT8MFFEQb2x4cB8E9aB5Gzv5+A==
X-Received: by 2002:a05:620a:1037:b0:773:c4c8:2d58 with SMTP id
 a23-20020a05620a103700b00773c4c82d58mr9049950qkk.59.1700593643117; 
 Tue, 21 Nov 2023 11:07:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 x10-20020ae9f80a000000b00767d8e12ce3sm3841828qkh.49.2023.11.21.11.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 11:07:22 -0800 (PST)
Date: Tue, 21 Nov 2023 14:07:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 02/21] arm: allow CONFIG_LINUX_KERNEL_IMAGE_HEADER to be
 set in defconfig
Message-ID: <20231121190720.GD2513409@bill-the-cat>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <20231121-b4-qcom-common-target-v1-2-9492198e0c15@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G0V+CtYyc4wIixcb"
Content-Disposition: inline
In-Reply-To: <20231121-b4-qcom-common-target-v1-2-9492198e0c15@linaro.org>
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


--G0V+CtYyc4wIixcb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 05:09:25PM +0000, Caleb Connolly wrote:

> Let this option be enabled dynamically for boards that support multiple
> mechanisms for booting U-Boot (e.g. as a first-stage or chainloaded
> bootloader).
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> This patch has no dependencies
>=20
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index bd48131292e3..1add4282f336 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -81,7 +81,7 @@ config SPL_SYS_NO_VECTOR_TABLE
> =20
>  config LINUX_KERNEL_IMAGE_HEADER
>  	depends on ARM64
> -	bool
> +	bool "Linux kernel binary header"
>  	help
>  	  Place a Linux kernel image header at the start of the U-Boot binary.
>  	  The format of the header is described in the Linux kernel source at

Why are we not select'ing this like the other platforms which need the
same do?

--=20
Tom

--G0V+CtYyc4wIixcb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVc/+gACgkQFHw5/5Y0
tyyvKgv9HdON1nSaKQpoDiN+6i2tgZK36/+Q6smvRnLPdS6ZiuX7+KDv6Pqtv3IP
tWmGIOejCcewBCRevzSC9OL+sc1dDc+sbku1XL/A5JsDp9HaTXcwW2OlgDFW4NCd
M/cjaccw0K0Vm+reX41Rf3oaocCSvmb12gCI48x3qBWZm2it81iHJthT50dheJbL
2FQWVJHljVN3a2H4P3ZKULbmjPIzBnC0WLQsXQdC1j5VV7/H9DKo62U13e9wZX4v
Nmgg8cyk6gxsU5q7QDCFa0iE+20cx2hIYpepprhADX6RLU76H+R5rVTXxeGnJo1R
oxMoAaa4PKfwisHBKDB3stWqQUqkKRVe9kF7//lrKTmgAL73TVO5Djb7mwgLhHqs
PYyLizsezaAaIM8QFBONjpck0SUEMkrTJJS3BEpJUnWjULoLXsMW0maWkjtiPoyf
LaYkxzNEnYx9R1QTK2tcgySJdyKzrGEfOWJmvKcsrfL1zpa2t2Gh1pmC42jgIgNB
8W4rf97f
=KY/C
-----END PGP SIGNATURE-----

--G0V+CtYyc4wIixcb--
