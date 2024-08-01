Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF07C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 21:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE63388B6A;
	Thu,  1 Aug 2024 23:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X8JCovXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A0F88B1D; Thu,  1 Aug 2024 23:16:09 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F21F88B70
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 23:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-26119999171so5145061fac.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 14:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722546965; x=1723151765; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=avbkhpM82ag+nsgikKpq918mQeW6EHn6FQpt29Ce7Mc=;
 b=X8JCovXGcjW6kLKJ//+1RKdnF3e6352Z7YbOAhvQH0i2ltKuzfvB2MQZ94pywVCpnI
 Kgn6Cunb2mJUyglNMYK1IIYULaC2L36QGNUOQl21QYDEmAij8you4LCrHrLIUd6O1jEy
 JHQyHZy27oz5PaNfKHbeSuom2LK5x8RZrIMtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722546965; x=1723151765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avbkhpM82ag+nsgikKpq918mQeW6EHn6FQpt29Ce7Mc=;
 b=Hv4B1oWQj4DHAg5Yjf7K/lmWxHqs7wNFooc7LRvCEkYu+q5iz6/ITnHM/crupBz2/R
 QwvJTz5PjJRasw/fY4gIhCEKCVa/fgfHEcC4UfG7BW4iyL4rzYjTy068EYWtSG2QSlom
 bP3VSevdI0Z7pSztP4+NWibk0Xw3bxDuqIT2Tco+NshRFuI5c29R586i6vugw468quc3
 8FROhsXE5XvvweZnnzL6UUxq9lwPIwEnu4lBv1FxSsyer0zRya3khl6nJ2eMiGPcl8z6
 L07kBcXwmJsL1Rqx91uzrf7+4cjo1I+QlgDb+CMKzIERa9uK/pzVFe0PJfZYptHiKu3l
 /A8g==
X-Gm-Message-State: AOJu0YyWXixfji5uXfjND18f/UyQz5qxGEP12AWqxOdbn37undW5kg6z
 z5GNBoBuJsE1i8ygqoLkZziqyY0SEmiBZfJD1bIzFbHBctJRvaSqk5JzTbTaHYMFdI0UR1CsmkU
 eA6Y=
X-Google-Smtp-Source: AGHT+IFcDJU0HM4N/dh6DUWqyL06vOQj6dqBuaASk1Dq2pQ1n4TeFnTb8mU2QtrJZ2OhwJY+jtmvlw==
X-Received: by 2002:a05:6870:d208:b0:260:e093:ff8d with SMTP id
 586e51a60fabf-26891f3ef3bmr1442358fac.45.1722546965028; 
 Thu, 01 Aug 2024 14:16:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a2f1af9sm25883fac.13.2024.08.01.14.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 14:16:04 -0700 (PDT)
Date: Thu, 1 Aug 2024 15:16:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v5 27/27] configs: enable MbedTLS as default setting
Message-ID: <20240801211600.GL3794063@bill-the-cat>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
 <20240731172556.1348487-28-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cSpYocdzbm/irHj0"
Content-Disposition: inline
In-Reply-To: <20240731172556.1348487-28-raymond.mao@linaro.org>
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


--cSpYocdzbm/irHj0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 10:25:37AM -0700, Raymond Mao wrote:

> Enable MbedTLS as default setting for qemu arm64
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
> Changes in v3
> - None.
> Changes in v4
> - None.
> Changes in v5
> - Remove unused config MBEDTLS_LIB_TLS.
> - Remove EFI_SECURE_BOOT from the default config.
>=20
>  configs/qemu_arm64_defconfig | 3 +++
>  configs/sandbox_defconfig    | 3 +++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 7e166f43908..22d38608842 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -67,4 +67,7 @@ CONFIG_TPM2_MMIO=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_EHCI_PCI=3Dy
>  CONFIG_SEMIHOSTING=3Dy
> +CONFIG_MBEDTLS_LIB=3Dy
> +CONFIG_MBEDTLS_LIB_CRYPTO=3Dy
> +CONFIG_MBEDTLS_LIB_X509=3Dy
>  CONFIG_TPM=3Dy
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 93b52f2de5c..679bbf69936 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -343,6 +343,9 @@ CONFIG_FS_CBFS=3Dy
>  CONFIG_FS_CRAMFS=3Dy
>  CONFIG_ADDR_MAP=3Dy
>  CONFIG_CMD_DHRYSTONE=3Dy
> +CONFIG_MBEDTLS_LIB=3Dy
> +CONFIG_MBEDTLS_LIB_CRYPTO=3Dy
> +CONFIG_MBEDTLS_LIB_X509=3Dy
>  CONFIG_ECDSA=3Dy
>  CONFIG_ECDSA_VERIFY=3Dy
>  CONFIG_TPM=3Dy

Please run this through savedefconfig as I believe it's just one line,
not 3, in the end.

--=20
Tom

--cSpYocdzbm/irHj0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmar+xAACgkQFHw5/5Y0
tyxV+Av/Q8ioSgztOrsNmzyQd4/36/NubY4xJlo4rfPyD8lUigF/CPde2mrTJyS2
vCQFVTEysgo8Oj1LgRmrpX+4PtJA0BVPpHqNZqC81NrjJfsuE7jELA5V+NSjjSIF
+XhWKUb467Ojo/2oZGJQcqNT70EF/+aYLf6XgLWERzpeqjb7wuwFFtvLR1+9732Z
DIUhulquNMokqtD4Y0DCjp3ZujNMutmbnZeUsV//ogOW3YJGFFbYIUa1+PAs65Hz
FWE0OFbYPzTpQcDuXO0NJ/NHEp774IZRom+Zjh5MaLsQFghndsv5OwccnH4snf0o
0arJR+pC2davr0gstHzialopofQ2aglvzYeKgB+pvaTmUzRiusjkOdwUsFFpE+WO
CzhgIJg8OQqfdjJXqmaBl0kMlvM1N5D0NqRW3D1GkZeALSX1iwfZ2II86WlYhLKA
b03UPHFQYG+0OqW/US0rFCRwLJhflisLVP88MIrLV/jJKBhH3lDrUTgCR9TzYYsy
OfDhxqDV
=X9sT
-----END PGP SIGNATURE-----

--cSpYocdzbm/irHj0--
