Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7191EC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 15:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8177828BC;
	Thu,  8 May 2025 17:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C6B6Yjd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F581828A2; Thu,  8 May 2025 17:35:11 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E2C982977
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 17:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72b0626c785so975657a34.2
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746718506; x=1747323306; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I9OKMAVTQxVTbvp2Y2Yp6dXVi3AA4igNQSIiK3CJGFI=;
 b=C6B6Yjd2Cxai4LfQaq/U+RHudyr7oZ5DiYE3Nsn2yeHd+PEmzMB5PHj12HZ/2pC3vk
 Uof1yriiRJcOJbuaimZCfs3a67spUq2Ys7PEnC/5xmX5iQmAc1/Q3Eg1Im0Zhx0Z+cKn
 befFjXMhANsAg3qKFKKU7k4hEM5yZ9h08EThA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746718506; x=1747323306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9OKMAVTQxVTbvp2Y2Yp6dXVi3AA4igNQSIiK3CJGFI=;
 b=iAm33EfR2R9bHaIUvdj3SBacc5kEHGSAqzf9SLI2rjfgez56nXjCS51vBdWFsAa5ju
 TgpNRXsw5qpZJMZ1QMs98LNXCg7XXAEUaXMD/JY6t4zcO0Gz4gxyVuI36wYXd5I3Jh/O
 PUsQEx8bJXnPwLECWLbKAllssPjC/OMEpdB3vAyLhW7U6B/Tb7SEojWccu7u0irWqoCv
 HQspz/S3kicH/2M4bsJKhrtufmNGo+yac67UhcKiVgoNVfGjJ8M2gA7vJHgjzey8Gtnj
 5sDX+RZKKeCrQuPsjRsXmRZwCIRAz1+ruDptzYiRmsqi/A/oCk5W+qY5gy64VEsTOxq8
 55Yw==
X-Gm-Message-State: AOJu0YzE9DctLYBMYMkmPuQuH93NeYcrXo8DKs/YaaZj5YUIYDekVf27
 5omRmH6y1swsOYOlGEmId4D4HpkR7zrgdVjs9/5G0kXrO5y9qBedR0OM+Hi7scs=
X-Gm-Gg: ASbGnct0NfEa1sJ2BTY/4tpko6fidjkzTTX5/y/YExZ1s6xo5+NBYkNa0HXAnoqF+6G
 8DxRN2HZwOxEixjMLbHRUIXFGxKscpTxQoAEqWDLlKIKl+PGx01AYGXOupTIEnEE+DyPNmuGEo5
 BO1xFXsGHU5wFFmlVE1gp1Gmmenwbc1CcoidC+fHHSx45VHvCgRL5md9Gorl8jayjhU7r2wlbrn
 KZBOEKL3D+qsnSnOZci0l5MjFcnNgw7/mnQxMi4FtZQMfPSY9CL0bu1ZR/WjQrT+4l0cuGmRo/4
 FqNEYdQ2ClHxIHPmEDqdeJ4tN2GgqNDZUJRNUxMevJnMzbkqvmEE+xe8D+IO86CBDTmO2x4cRR6
 kXQ==
X-Google-Smtp-Source: AGHT+IFgJi/XS/y37hxStVvWwfuzWsUTl3y6P8W2stagNGUjoheNrrFt0VIByLyj4iyqoLgn8EAnBw==
X-Received: by 2002:a05:6830:d81:b0:72b:992b:e50 with SMTP id
 46e09a7af769-73226acf3b0mr79610a34.21.1746718506125; 
 Thu, 08 May 2025 08:35:06 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7322647ef6dsm52373a34.1.2025.05.08.08.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 08:35:05 -0700 (PDT)
Date: Thu, 8 May 2025 09:35:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de,
 jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, joe.hershberger@ni.com, sjg@chromium.org,
 d.schultz@phytec.de
Subject: Re: [PATCH 2/2] mtd: bootdev: Add Kconfig option for defining script
 parameters
Message-ID: <20250508153503.GB603748@bill-the-cat>
References: <20250508131641.2561876-1-w.egorov@phytec.de>
 <20250508131641.2561876-3-w.egorov@phytec.de>
 <20250508152710.GA603748@bill-the-cat>
 <19faf506-47bf-4c13-837b-5ea286861685@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EWYJ23xgIsp+frPu"
Content-Disposition: inline
In-Reply-To: <19faf506-47bf-4c13-837b-5ea286861685@phytec.de>
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


--EWYJ23xgIsp+frPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 06:31:52PM +0300, Wadim Egorov wrote:
> Am 08.05.25 um 18:27 schrieb Tom Rini:
> > On Thu, May 08, 2025 at 03:16:41PM +0200, Wadim Egorov wrote:
> > > Introduce USE_SPI_FLASH_SCRIPT Kconfig option to enable setting defau=
lt
> > > environment values for loading boot scripts from SPI flash. When enab=
led,
> > > SPI_FLASH_SCRIPT_OFFSET and SPI_FLASH_SCRIPT_SIZE define the default
> > > script_offset_f and script_size_f variables.
> > >=20
> > > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> > > ---
> > >   drivers/mtd/spi/Kconfig | 26 ++++++++++++++++++++++++++
> > >   include/env_default.h   |  4 ++++
> > >   2 files changed, 30 insertions(+)
> > >=20
> > > diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
> > > index ca60a425ba3..fc154ec89d7 100644
> > > --- a/drivers/mtd/spi/Kconfig
> > > +++ b/drivers/mtd/spi/Kconfig
> > > @@ -89,6 +89,32 @@ config BOOTDEV_SPI_FLASH
> > >   	  If unsure, say N
> > > +config USE_SPI_FLASH_SCRIPT
> > > +	bool "Enable default SPI flash script parameters"
> > > +	depends on BOOTDEV_SPI_FLASH
> > > +	help
> > > +	  Enable this option to provide default values for SPI flash script=
 loading.
> > > +	  These values will be assigned to the 'script_offset_f' and 'scrip=
t_size_f'
> > > +	  environment variables at boot time if not already defined in the =
environment.
> > > +
> > > +	  If unsure, say N.
> > > +
> > > +config SPI_FLASH_SCRIPT_OFFSET
> > > +	hex "Offset for SPI flash script (script_offset_f)"
> > > +	depends on USE_SPI_FLASH_SCRIPT
> > > +	help
> > > +	  This option sets the default value for the 'script_offset_f' envi=
ronment
> > > +	  variable. It specifies the offset (in bytes) in SPI flash from wh=
ich
> > > +	  the boot script should be loaded.
> > > +
> > > +config SPI_FLASH_SCRIPT_SIZE
> > > +	hex "Size of SPI flash script (script_size_f)"
> > > +	depends on USE_SPI_FLASH_SCRIPT
> > > +	help
> > > +	  This option sets the default value for the 'script_size_f' enviro=
nment
> > > +	  variable. It specifies the number of bytes to read from SPI flash=
 to
> > > +	  load the boot script.
> > > +
> > >   config SPI_FLASH_SFDP_SUPPORT
> > >   	bool "SFDP table parsing support for SPI NOR flashes"
> > >   	depends on !SPI_FLASH_BAR
> > > diff --git a/include/env_default.h b/include/env_default.h
> > > index c72cf123004..9f2f222519d 100644
> > > --- a/include/env_default.h
> > > +++ b/include/env_default.h
> > > @@ -127,6 +127,10 @@ const char default_environment[] =3D {
> > >   #ifdef CONFIG_BOOTSCRIPT_DHCP
> > >   	"boot_script_dhcp=3D"	CONFIG_BOOTSCRIPT_DHCP	"\0"
> > >   #endif
> > > +#ifdef USE_SPI_FLASH_SCRIPT
> > > +	"script_offset_f=3D"	__stringify(CONFIG_SPI_FLASH_SCRIPT_OFFSET)"\0"
> > > +	"script_size_f=3D"	__stringify(CONFIG_SPI_FLASH_SCRIPT_SIZE)"\0"
> > > +#endif
> >=20
> > This should be CONFIG_... yes? Did that just get missed in uplifting
> > this from, I assume, an internal tree?
> >=20
>=20
> I will double check, test and resend a v2.
>=20
> But is the general idea for defaulting standard boot environment variables
> in env_default.h okay?

That I am still thinking on. But I did want to be sure you're testing
the whole path out elsewhere and this was just a typo :)

--=20
Tom

--EWYJ23xgIsp+frPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgczycACgkQFHw5/5Y0
tyyymgwAsuOZQ0KYtMwZFWM86hnVd0UXpcK8OYuO06PfG4tB/MYyZOgK1QUZS5QT
oQ8+WUCv3EZCZIhfcs7IuvoECq4mfWv748N1fbOxGvZZdFMINKwKenblxoWs5U3o
tWJqxMOZQ0Ob/VkRBkNQKE6valy8lmwTVd4LYxUHYWLn2XlbROFX4HUE1HsRerXo
BMWeh5EZzlobljpzlsRtMohnNfUAqMysMqX3uIp5K0NH3FEwzTzATr91MGNhP53R
RPZQmZxoN6d/GCeBQfeE1PuFoibnLK7Zpeb5nLhUKXRv/BelkRdCo7cdEJSSVv/z
DU6oUK13IS0gbgOYwx7G57zNf1HQ1btIfm6PxdMY94fmO0jIwJsAoOuL5g0LJwq2
2jMlQxWlQ0ZIzxnvIOVB+6LNraFMzF/NFR/4yn2MmvOrUlL6jBu6noMlC/Rt01cN
KRnmt8k0F6C44G5hC4hXf8414g+LMFzIdyg8kdLV6oBoO1nu4VH5icNde1uXGq1s
NVVBpTi7
=5AF2
-----END PGP SIGNATURE-----

--EWYJ23xgIsp+frPu--
