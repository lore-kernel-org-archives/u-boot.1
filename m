Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D8BD729E9
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 16:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FD7C890E7;
	Fri, 29 Nov 2024 17:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f7grUci4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6FAF8913C; Fri, 29 Nov 2024 17:09:32 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E10C890D5
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 17:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d888fc8300so3554236d6.3
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 08:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732896569; x=1733501369; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ikGek+6SaT6Q1g3TFQDwsJI7kNW9TGsJNIsLpMl7WcE=;
 b=f7grUci4rpmJOE/o5Z9hfDbIxwy6O7C16eh0JIulKq5BN1xo76IxKTac+BOCa/+Arx
 MuJXI08lQCBSj93cALTD7hqg7CZkcu3NMajIo+UL3wbgwfAuDt1MUHpxJKJuJEdzRE53
 SEKQ5wW+o/PV+uBhXRi/Lf6IL3DuCR8LpVos8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732896569; x=1733501369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ikGek+6SaT6Q1g3TFQDwsJI7kNW9TGsJNIsLpMl7WcE=;
 b=G7tPBT/+h7iY7EbTD7F2Z7VKDXPEdv/HAplnCK16p3BrLqduzgwmPl40UNSXHUzijI
 k70ZaX4UZdwleFkGkvBe2VlUPOvl48niMbn4Xi8ZvufYrg80r2W2Gxppo9js7xLG3Ilf
 9MuMtZFGW2rR9CUnhVFXGEe4h7jEFLrCIpSk5S4BnUVhuMOnrvem2FXkhA0uUysV88Yq
 iCwGWVhkC2+HhS6JSJRzG3c3ifqVyBZdoM4/Jlm/wkFMZqIJK+PNSyfBHgLADT4PjEf5
 JPUfGbGEgiy444995fTqJ607Offu1zeuBj1g4ms38Xwtzn9+diFT26aDrZtSUEFzocPX
 1ahA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf+zD/2rbDd+PzOUE2k+EX2g64NfzpnihCtaeZtGXZvLebsReRXzk7lAarVYqOtNfPhdNhKoU=@lists.denx.de
X-Gm-Message-State: AOJu0YwHJc81X9f29meOLZjbVnjU7TLCukoGkEaBZio9AsTcJIbBUBmT
 T71RefKjHcpFS/W+nGYQauFk4KpmJvDe7tyXOwVA3nTtw6uvdRhPEhTrkePENvQ=
X-Gm-Gg: ASbGncsPCE4HOzuLSuDpTlISiT+zci14l1EKUR88Nq28NfCHx9C1GSyfJjXJumAHlGh
 GPAkkZUkHvZ/aEfQ2bBLvO/D2GRWIGh2U7rqddYlLX3gSPLvJ99s6ytKvYHfICCtQKgS1SEjxu4
 moOcq4hlIs7xCSzy3cmXXV+2FG7N66INBGO+sBGg7mM39rL6QZk2RdcLz+fKFjDx1XYBFyWVI3L
 l8wQz6WVnZR3MEC4qOnhHriDr2uaZF9yUR570DApVC1uW4J8w==
X-Google-Smtp-Source: AGHT+IEl3N4XXKGtVGgbtYVVKQU7H3PI3drI715P6KgJ+y8m7V6t8WcuKEXCDDqaRIGSzBBsW8l+5A==
X-Received: by 2002:a05:6214:500d:b0:6d4:1a42:8efa with SMTP id
 6a1803df08f44-6d864bf0cc7mr176731946d6.0.1732896569268; 
 Fri, 29 Nov 2024 08:09:29 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8751631f2sm17707696d6.6.2024.11.29.08.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 08:09:28 -0800 (PST)
Date: Fri, 29 Nov 2024 10:09:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de,
 Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH] verdin-am62: fix FASTBOOT_BUF_ADDR and FASTBOOT_BUF_SIZE
Message-ID: <20241129160925.GL3600562@bill-the-cat>
References: <20241129151257.90607-1-hiagofranco@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="emafidViCPTywubO"
Content-Disposition: inline
In-Reply-To: <20241129151257.90607-1-hiagofranco@gmail.com>
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


--emafidViCPTywubO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 12:12:57PM -0300, Hiago De Franco wrote:

> From: Hiago De Franco <hiago.franco@toradex.com>
>=20
> The current value of CONFIG_FASTBOOT_BUF_ADDR is incorrect for hardware
> with 512MB and 1GB of RAM. The RAM address ranges for these devices are:
>=20
> - 512MB:
>   - Start: 0x80000000
>   - End:   0xA0000000
> - 1GB:
>   - Start: 0x80000000
>   - End:   0xC0000000
>=20
> The current buffer address makes fastboot downloads work only on
> hardware with 2GB of RAM.
>=20
> To fix this issue:
> 1. Lower CONFIG_FASTBOOT_BUF_ADDR to 0x80080000. This places the buffer
>    near the beginning of RAM with a 512KB offset, as starting at exactly
>    0x80000000 conflicts with the ATF load address. Following
>    K3_ATF_LOAD_ADDR configuration, ATF is loaded at 0x80000000:
>=20
>   config K3_ATF_LOAD_ADDR
>     hex "Load address of ATF image"
>     default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5=
 || SOC_K3_J722S)
>     default 0x70000000
>     help
>       The load address for the ATF image. This value is used to build the
>       FIT image header that places ATF in memory where it will run.
>=20
> 2. Reduce the size of the download buffer to 128MB, avoiding overlaps
>    with RAMDISK_ADDR_R. This is a good enough value for individual
>    downloads.
>=20
> Theses changes make fastboot downloads work with 512MB and 1GB devices.
>=20
> Fixes: defe30a78b76 ("verdin-am62: add DFU, USB and UUU fastboot support")
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> ---
>  configs/verdin-am62_a53_defconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_=
defconfig
> index 49fb9790e295..6fa1a9d2c552 100644
> --- a/configs/verdin-am62_a53_defconfig
> +++ b/configs/verdin-am62_a53_defconfig
> @@ -122,8 +122,8 @@ CONFIG_SYS_DFU_MAX_FILE_SIZE=3D0x800000
>  CONFIG_DMA_CHANNELS=3Dy
>  CONFIG_TI_K3_NAVSS_UDMA=3Dy
>  CONFIG_USB_FUNCTION_FASTBOOT=3Dy
> -CONFIG_FASTBOOT_BUF_ADDR=3D0xC0000000
> -CONFIG_FASTBOOT_BUF_SIZE=3D0x2F000000
> +CONFIG_FASTBOOT_BUF_ADDR=3D0x80080000
> +CONFIG_FASTBOOT_BUF_SIZE=3D0x8000000
>  CONFIG_FASTBOOT_UUU_SUPPORT=3Dy
>  CONFIG_TI_SCI_PROTOCOL=3Dy
>  CONFIG_GPIO_HOG=3Dy

Why not 0x88200000 which is what CONFIG_SYS_LOAD_ADDR is?

--=20
Tom

--emafidViCPTywubO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdJ5zIACgkQFHw5/5Y0
tyz75AwAqLIrwnUekX2gkG6yVJacER04ibuK6VWdjt4EEeinMruhs1z8mBt/1KPl
2qzX/YY+JlpNMN4cWh2wW5RarnwhrUdmXzB1OFe1S/juZAlJ0E5e+qQ7aiHfHdX8
pXoNrBo7rwKwdjnuz33r4lu/vTopeShMVOZkhSdyql4EXCs0U+K1uQtjCES/I6+b
ZkAn8zX2b/HasYyhoR4Ov16XVNF+nbFbSjQx6M7SrlKD9D6pqLlhyw4ak3Vt8gch
rpQYyISwyoqpTYJOoNh02SvjQPVcyLKStsfu8HmjYXvO8LA+aJdLCj8scXMqGLIh
f9WnSPOCuMyLVzkXdO6Kd+SkuQvPUuh2FQjsj3Mxc5bjhKGF/N5UvKlGudJYmEih
3Uc/7TdW+g2fwUciilPdl+5iLowK9oaFUuf4wbpaJ8rNSNByt70lDo+a8eRPWLCM
whaUfrKhsPVgAjZYaTaHr22/PRCWpXhi9ASCSwXGWfPP3moXq2UBEcDNEM/4LCdf
sq1TpLpL
=2Fyj
-----END PGP SIGNATURE-----

--emafidViCPTywubO--
