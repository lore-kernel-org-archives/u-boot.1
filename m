Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E182C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 21:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B01826B2;
	Thu,  3 Apr 2025 23:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oxVnfWAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE0E68215D; Thu,  3 Apr 2025 23:56:25 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6295A82898
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 23:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72bbd3a3928so888253a34.2
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 14:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743717382; x=1744322182; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OyMYqAh6iLB/NmN4Tln9k5U86cFgbZcYsdy57xa2fRE=;
 b=oxVnfWAc/3Lj0r6pggS2mXNzGulvZ+sYTGqsAYaOglE2n38uLRGRSPGfPtaoOQ0KPr
 dZsweITjQ8+mN1UlZeZgPp31VMyFvnmCbTWOUY+ako+Bu27mV6P2uG3f6DKvcEiablVj
 AD6Jw3vGSZULkC/PQDxhbdeyNr2CR4Favd8Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717382; x=1744322182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OyMYqAh6iLB/NmN4Tln9k5U86cFgbZcYsdy57xa2fRE=;
 b=XibmauVh0xIoKItnwi4GLki5rgcE/2sqLNQNBG4/C0LCqayjgoPmepCSBdRU7HPOv0
 0GRoT2V3UHXLuX7PY2CU3NFlmjzeZ46HsdsMcqiL6lSaiD5+UkWr6lnnocvkEWULnOFQ
 /LzHe2txKKEhsn1mD4LTh8VoaFj/naZ/gSVufJOP5KBBDIqBHbDRMuitIByxt+D33Ss1
 P1ebuVx4JC6vbEt/AYyPpM9GCY8PMLkbrfzYpjNV/KY8koBrUEzhbHDchbEGxg4omO9I
 bLAPNxZdswcPvO6uOFQNaIv3GhRrnkVirwEHxgfw+ePYgl/LcbuOwa2WQ0EdhYRHEX/D
 86Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgayUgpwY22IS/7m0AJgV13QjKO4Wai0B7X3g27yM5yYLBr/QU8QAvYvSqSF1G0fAymAUkyWE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6Oje3kb0+X1DpLX1eb3cyJ68iqT2EeTIy0boyQYtgqBd1Ntl6
 kMrpWLyPh3yQuRrP4sEbIIiOnwSQlEdme5AaJDyWEfc2Wa7pupwMG6lO2EED2UWPCryGI70QHGR
 9RJc=
X-Gm-Gg: ASbGncvni0RyZdIfJds1M3NQ927tOX9uR/EOBXto9fch4zBsX1QxFQqDy1qFouLE9TI
 GQrlmfV+1Osa7M8vHGf7aZLVGd+/bdzVVsLwHJzyd21m6GNxRD6YYw3q7BnGqcB/+7uNk4wILN1
 iiX/a9r0N0EYSTOhvRSN3uUWw5zgTMnLlNMK3rHKBZQbyAOlxUFuj0riYX+dm2fl/rLeVQL2aXi
 f874AX8GAQMaidwp/Q9MGQ9emyWX/v7M2GZ4FQg/mm3RIIzSebcQW23y3DeXhsU3rL/zEi/f+I5
 YL0ZdiIljspmZog4OkmXdOThhLOqoyMh4bX9FnUF9nz+dfxMcqrUtokxVx2TAIEWK6EPuANurA1
 e2AIhFw==
X-Google-Smtp-Source: AGHT+IH+Va0v3F70LT2ZnMg/vJ1FU3HdY6kH/jyz7pU1ThNvVMNF+xOBeUf5m8Gmfgmxj/96fmBOgA==
X-Received: by 2002:a05:6830:61c3:b0:72b:9014:f5cc with SMTP id
 46e09a7af769-72e37fd1228mr294199a34.25.1743717382037; 
 Thu, 03 Apr 2025 14:56:22 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e3059a28esm387085a34.43.2025.04.03.14.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 14:56:21 -0700 (PDT)
Date: Thu, 3 Apr 2025 15:56:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v5 00/29] pxe: Precursor series for supporting read_all()
 in extlinux / PXE
Message-ID: <20250403215618.GP5495@bill-the-cat>
References: <20250306002533.2380866-1-sjg@chromium.org>
 <174234008117.1788726.14383009154862416750.b4-ty@konsulko.com>
 <10a57d25-d484-4903-8f25-e373c451bc21@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="REXQk1ZQ1vjePzm9"
Content-Disposition: inline
In-Reply-To: <10a57d25-d484-4903-8f25-e373c451bc21@kwiboo.se>
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


--REXQk1ZQ1vjePzm9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2025 at 10:57:24PM +0200, Jonas Karlman wrote:
> Hi Tom and Simon,
>=20
> On 2025-03-19 00:21, Tom Rini wrote:
> > On Wed, 05 Mar 2025 17:24:54 -0700, Simon Glass wrote:
> >=20
> >> This series includes some patches related to allowing read_all() to be
> >> used with the extlinux / PXE bootmeths.
> >>
> >> These patches were split out from the stb4 series, since it will need =
to
> >> have additional patches for LWIP, to avoid breaking PXE booting when
> >> LWIP is used.
> >>
> >> [...]
> >=20
> > Applied to u-boot/next, thanks!
>=20
> This series broke booting a compressed arm64 defconfig Linux kernel
> (without module loading) due to changes in decompression buffer length.
>=20
> My arm64 defconfig kernel (Image.gz) is ~24 MiB compressed and ~85 MiB
> uncompressed.
>=20
> Before this series the decompression buffer was 10x the kernel_comp_size
> and now it is instead limited by the SYS_BOOTM_LEN Kconfig symbol.
>=20
> A broken boot using current next branch:
>=20
>   Retrieving file: /Image.gz
>   Retrieving file: /initramfs.cpio.gz
>   append: earlycon
>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x06000000:=
394d3c' conf_fdt '3df16350' images 000000003ffe53a0
>      kernel data at 0x02080000, len =3D 0x00000000 (0)
>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
>   find_other type 2 os 5
>   ## Flattened Device Tree blob at 3df16350
>      Booting using the fdt blob at 0x3df16350
>   Working FDT set to 3df16350
>   load_os load 8000000 image_start 2080000 image_len 2000000
>      Uncompressing Kernel Image to 8000000
>   Error: inflate() returned -5
>   Image too large: increase CONFIG_SYS_BOOTM_LEN
>   Must RESET board to recover
>   Resetting the board...
>=20
> Changing SYS_BOOTM_LEN from default 64 MiB to 128 MiB fixed the boot:
>=20
>   Retrieving file: /Image.gz
>   Retrieving file: /initramfs.cpio.gz
>   append: earlycon
>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x06000000:=
394d3c' conf_fdt '3df16430' images 000000003ffe5480
>      kernel data at 0x02080000, len =3D 0x00000000 (0)
>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
>   find_other type 2 os 5
>   ## Flattened Device Tree blob at 3df16430
>      Booting using the fdt blob at 0x3df16430
>   Working FDT set to 3df16430
>   load_os load 8000000 image_start 2080000 image_len 2000000
>      Uncompressing Kernel Image to 8000000
>      kernel loaded at 0x08000000, end =3D 0x0d3b5a00
>      Loading Ramdisk to 3cb51000, end 3cee5d3c ... OK
>      Loading Device Tree to 000000003cb3f000, end 000000003cb509df ... OK
>   Working FDT set to 3cb3f000
>=20
>   Starting kernel ...
>=20
> Do we need to increase the default SYS_BOOTM_LEN for ARM64 now?

Ugh. I thought the decompression buffer, which we would be just lmb'ing,
was some multiple of the compressed image. Can you please bisect down to
which commit in the series broke this?

--=20
Tom

--REXQk1ZQ1vjePzm9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfvBAIACgkQFHw5/5Y0
tyyLkQwAqjz3vuiW85pdA7eRKIMpV4bIvr2vNhS9rOFQx2vxDFKvsfiYXSCJEvU4
/T/OA3pCbWfrTDIhDvlD0tzhJJbluX0e+pr+e2R1SbHdkhE8F0vMpVHSqLWwgp/G
isVaOrWqumTufnI3HXnJqRzDp0I2lgbAfx4y4hSnaQQN+Z5j8KfhuZ/afiDZOxjQ
E5Nqk9MZmttJehVaR+hbGxp0hP466JX4fTX7hMAR1rrK6tTYnFXBDsGiYI6YbFcA
8WtsF7iuEQC7Wmq/T6rIj9HPKu+2j32xWar5Jq09jIWqMynioybYoq9ZEewfqv6K
0VKyfq4TLBE+IiucrmF7pyNzvR7I1wEHqxSWd5uHrk5OloaqTS2WHYXx/I8YywGU
5GDUmltYEjiJa+iAzCtX7zGPZ+/ZpOcv9nhjtxunHZ8rGud0Tqaj3JeAVOvUqg+U
dUho/6EPlqyNlIuHQogP5c//pC1Na9JJwIp4G9ZkAmGybfLp0bX2aDHPg5q0k9Bm
Q5jrn2cr
=WfSi
-----END PGP SIGNATURE-----

--REXQk1ZQ1vjePzm9--
