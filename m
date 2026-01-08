Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0087D1D461
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76063841C2;
	Thu,  8 Jan 2026 15:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FLiQiM2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7032F841E7; Thu,  8 Jan 2026 15:37:49 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4331C8416C
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3e89d226c3aso3084413fac.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767883066; x=1768487866; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1nzqvOBp4qz90RMt0hld3gCJFHxZGm1hL8NFW43sivY=;
 b=FLiQiM2dcr27mP4j59DumzrHuej7nUO0qH+kA32UpR4QzxhkW/D+Uv6BnM5GyurkRc
 9NZ1y0qG1L1xgexVtDXMKQzaUes5jlBpL2lpM/72ErLcLVTRpK6vryzJBKZy38Vhuj6X
 HzwTtSbJYrofI6XEVcCA1FqvfpWnmYQDV4s5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767883066; x=1768487866;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nzqvOBp4qz90RMt0hld3gCJFHxZGm1hL8NFW43sivY=;
 b=dzhLDCuveHFnfu2uxagm0kimsYqEfIogawa+UkDKsKrD33uZntI1s6xZpbhoyd2lyK
 baofgHQnHt5d3ugjZub0oTXmiuI6sKskn1DfBY+JLHPUQt2Bx17kPgPp8aXFicyurldo
 cIw64o5uWc2bFfCbOtrZOG10z/uMn10mzWWbgpLyoEqBBNtxuBX4ny/pi4yLEknRg1G7
 7Vyhf1JPqwl86fhStKT/FuM/wbBbQCQ5FVM2Hbu11IWCGRU/ES6uvdfkSdjWj4O8NOQ3
 K2nI3omHVqAr/HsWA+eH69xa0w4gTj/5go/O9MuHSAzoKKNLIq9mGFWWMa2+wCI48rjE
 Ayzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW3kqxxFUUOQ131drcqgqUxK+fUduVhq55hhRzQne6cZ8DFdu28UhC0tk/XCG79vy6nn2eVrk=@lists.denx.de
X-Gm-Message-State: AOJu0YwKNqffcOqKNV/zadYSoE6xXqr/32OV+Hezf5vtd5MK8hYbv8e6
 cDnbOUOnFsCrAHembd5GxCQ6S9qNFKABIB0rOY2CHebzlX1fDH4cvRwnydrqPd6hSUM=
X-Gm-Gg: AY/fxX6np4pHX/1akNb2UD2qWmMfJM5ewoonynmWx9Xf1Xh4jWBVzLFR37vvO2IOBRx
 bxa53Q8oOJRpsuRxFlnuRoQUGJWlwrOb3jjIzl5fUokOzyhwvmqQ+/kAwez8FAX4PAsNPDobsgt
 MiGV+0Lnx4651zQ6LJ1K/ibASdHAYBU59OYXlEhZP2MI0ZC005c6FYo9uZnLXdO130G+A3H6zAA
 D74pHDp1M3tl9xjdqPvWmgu3PjlenWe+NtA1KPTzaY9xSyoQ/Rs9kQJEomkYvHWqNjrYq0ZtJdR
 v85Qa4bXpI/4sTbo3FJpj1XxrWLum5OiEO28tgSEWzSdb9ry4nnjB+Ctro+VKYEh7kdxO1Pp2HP
 ym9XgXUrUIAO6xeHXqG73twsdR99p/cVp9LzOmHcnbffpKuuDHUhoxNXzTTUfDAdX47Fa4DAfiP
 VFUs8jqjzRghIcMbFSjL64yZQfxAzC08bR4WN6P2MViK3esCP8VjFxeI2BjjduHrQNPYnbjrNrq
 60fR9t4XrXPTJyzphDE68148quV5a9v1D37w1w=
X-Google-Smtp-Source: AGHT+IGcSkduLQHN+wwbxU9NIqNxvXm6pCO05o3NGSHd1pnAD1iRtrXOWxl9rg4kglDIgyKyO7t//A==
X-Received: by 2002:a05:6871:4004:b0:3e1:474b:beb3 with SMTP id
 586e51a60fabf-3ffc09d109amr3132202fac.17.1767883065643; 
 Thu, 08 Jan 2026 06:37:45 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa5161468sm5140931fac.22.2026.01.08.06.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:37:45 -0800 (PST)
Date: Thu, 8 Jan 2026 08:37:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 michal.simek@amd.com, j-humphreys@ti.com, raymondmaoca@gmail.com,
 paul.liu@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH v1] firmware: psci: Refactor EFI runtime PSCI reset
 handling
Message-ID: <20260108143742.GT3416603@bill-the-cat>
References: <20260108105146.1285450-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NP9YIBchFci+qyzt"
Content-Disposition: inline
In-Reply-To: <20260108105146.1285450-1-aswin.murugan@oss.qualcomm.com>
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


--NP9YIBchFci+qyzt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2026 at 04:21:46PM +0530, Aswin Murugan wrote:

> Previously, U-Boot=E2=80=99s PSCI-based implementation of `efi_reset_syst=
em()`
> was always enabled when `CONFIG_PSCI_RESET` was set, but it did not
> handle additional arguments required for specialized reset modes. This
> caused issues where special reboot requests (e.g., bootloader, EDL)
> were ignored, resulting in a normal reboot.
>=20
> This change introduces a new configuration option,
> `CONFIG_EFI_PSCI_RESET_RUNTIME`, to explicitly control whether the
> runtime PSCI-specific EFI reset implementation is enabled. By default,
> the PSCI EFI reset is disabled unless this config is selected, allowing
> the kernel to handle the reset logic and pass the necessary arguments
> for the intended reset mode correctly.
>=20
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  drivers/firmware/psci.c |  4 ++--
>  lib/efi_loader/Kconfig  | 10 ++++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 2e3223e1c32..009c6153d0c 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -244,7 +244,7 @@ static void __maybe_unused do_psci_probe(void)
>  	uclass_get_device_by_name(UCLASS_FIRMWARE, DRIVER_NAME, &dev);
>  }
> =20
> -#if IS_ENABLED(CONFIG_EFI_LOADER) && IS_ENABLED(CONFIG_PSCI_RESET)
> +#if IS_ENABLED(CONFIG_EFI_PSCI_RESET_RUNTIME)
>  efi_status_t efi_reset_system_init(void)
>  {
>  	do_psci_probe();
> @@ -266,7 +266,7 @@ void __efi_runtime EFIAPI efi_reset_system(enum efi_r=
eset_type reset_type,
>  	while (1)
>  		;
>  }
> -#endif /* IS_ENABLED(CONFIG_EFI_LOADER) && IS_ENABLED(CONFIG_PSCI_RESET)=
 */
> +#endif /* IS_ENABLED(CONFIG_EFI_PSCI_RESET_RUNTIME) */
> =20
>  #ifdef CONFIG_PSCI_RESET
>  void reset_misc(void)
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 13e44be1d06..23c9e5cd1ea 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -106,6 +106,16 @@ config EFI_HAVE_RUNTIME_RESET
>  	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
>  		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
> =20
> +config EFI_PSCI_RESET_RUNTIME
> +	bool "EFI Runtime PSCI Reset Support"
> +	depends on ARM_PSCI_FW
> +	help
> +	  Enable PSCI-based reset implementation for EFI runtime services.
> +	  This allows the EFI runtime to perform system resets and power-off
> +	  operations using the ARM Power State Coordination Interface (PSCI)
> +	  firmware interface, providing a standardized method for system
> +	  power management across different ARM platforms.
> +
>  endmenu
> =20
>  menu "UEFI Variables"

Using tools/qconfig.py we can see that 379 platforms today enable this
support:
$ ./tools/qconfig.py -f PSCI_RESET EFI_LOADER
379 matches
=2E..

So we should make the new symbol be "default y if EFI_LOADER && PSCI_RESET"
so that platforms that want to behave differently still can but existing
functionality isn't removed.

--=20
Tom

--NP9YIBchFci+qyzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV/BNQAKCRAr4qD1Cr/k
Cgy/AP9F8Y0xCbqYH4UeQSp1w/R58YWLepG7vp9xtg6pRx2DjQEA9Fs9XF2gblRF
M6ds8Wc+JJ2XGuTPMTegVr5pra8RLww=
=mpq5
-----END PGP SIGNATURE-----

--NP9YIBchFci+qyzt--
