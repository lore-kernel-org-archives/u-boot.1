Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26D4C36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 16:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A935829C3;
	Fri,  4 Apr 2025 18:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rrHJ2524";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7758B829E7; Fri,  4 Apr 2025 18:33:22 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B926C829A0
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 18:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6021d118877so1054019eaf.2
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743784398; x=1744389198; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lhh+Oz0ty//n1KVNGe2RLs41xQRC7OhMqx4MoHMWAH0=;
 b=rrHJ2524lHKpDyMPvfMT5vzIXj56wBcggo/oJZdPk7hWI9IQpu7Q2+445l2haYds+0
 hFBlo/aSorC05r4ikGOaVJsSq5MC9dM/bL9l8kDjdgCPIgu2S8QcJUTxIuZ1IujBnJSI
 vQyZGepO+3DFThvJ79e87ofUt0RZ8pIU/0wvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743784398; x=1744389198;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lhh+Oz0ty//n1KVNGe2RLs41xQRC7OhMqx4MoHMWAH0=;
 b=CizJVh1to3ml7Oqs3hfbfZKcpO/FSociGxDe1AralagGL37iRcJUtQ5nPlYwUFvtxc
 XEfSknEZ2z2LLTcK1ziMqiW37D0kgwd7jpCFvTudgZGRNwnOQN8ClOF0J/ptg5IeXgz9
 7G4cxk9QFZwUEZMtq2mobds59wJfBQ2QhwqapXXJdWRCcQesk6J3TI4bTvCq6wLfZ1aq
 7VdQxPz5vm1iu/yxIG5S+SI9/pMyy/ZG++fDpkDVobbB8Sq6oqFASLpmP3tlpD6pHtMv
 m3PAWWsq06NG9n5N8Z0LYZpvns3reVc3BC31PgmqXpaNeeprLjAqaxsSvwnblwkM9/P3
 4Exw==
X-Gm-Message-State: AOJu0Yxwa4/28qSQMPB4hq/9KoqeRi8yHy9NCclwVhL53/RN5/PLG82L
 XQwTchknXmSqR1zHeHSZdC7flpQVONSXm/iyk0np+wxtIU59hvRycYEhlHK9YQU=
X-Gm-Gg: ASbGncuQoH05NI92ur/cagkBVVu1hXpIygig1Tr4aEpFFTl3tUiiajNvVY5k3r0Pq+y
 QsUk+7O4CVgJESBovchCRu8/6bHDQL7tuZ2rZI8XIx5+xUC0jpUjkaWqEjRMq5wr3AWbK1sTd5f
 4yya42qpfHcQGncWRQW9x7o8xFX3SH0j1DFryHGXxYnSfGzVAX8QJRpi6OOoiOgjo7ZyoUH40Aj
 RlYYvRWVgXU+f2uAm0n5pjoHuBLO8bwIOREapILRdk6ZJpAXqBtLFWFAS51YgD6Mglw29oH3pxA
 zTkWDRSL8s1I62e4aClS2JJ7EISdxrQX2bhMlTtK1x6XcNYqlMgNnH5woW7vW7QE2wJDq2zEq0/
 EAIKzAQ==
X-Google-Smtp-Source: AGHT+IFH5bpFNGGBBdbQ31nPrBNo6esSsYFgqJ/ISliqkK4duZrDAJJ5mH/EDf+C1BOdrGnrbluWNA==
X-Received: by 2002:a05:6870:724f:b0:289:2126:6826 with SMTP id
 586e51a60fabf-2cca1b60ac2mr2209038fac.30.1743784398326; 
 Fri, 04 Apr 2025 09:33:18 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e3059a2c8sm710963a34.49.2025.04.04.09.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 09:33:17 -0700 (PDT)
Date: Fri, 4 Apr 2025 10:33:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: SMBIOS tables missing on 2025.04-rc5 on qemu-x86
Message-ID: <20250404163315.GS5495@bill-the-cat>
References: <c1dc7446-d1d0-4ef2-b201-09fc612aa8db@uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4CI8j/im+j4naDKG"
Content-Disposition: inline
In-Reply-To: <c1dc7446-d1d0-4ef2-b201-09fc612aa8db@uni-duesseldorf.de>
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


--4CI8j/im+j4naDKG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 03:10:29PM +0200, Niklas Sombert wrote:

> Hi all,
>=20
> I've written a small EFI bootloader and I'm testing it on QEMU with OVMF =
and
> with u-boot (with the qemu-x86_defconfig as -bios in QEMU).
>=20
> On upgrading from 2025.01 to 2025.04-rc5, I've noticed that the SMBIOS
> tables that are passed via the SMBIOS EFI config table are completely bla=
nk
> (just zeroes instead of starting with SM3).
>=20
> This is pretty easy to reproduce:
>=20
> git checkout v2025.01
> make clean
> git clean -xf
> make qemu-x86_defconfig
> # edit .config: CONFIG_CMD_SMBIOS=3Dy
> make -j4
> qemu-system-i386 -bios u-boot.rom
> # type "smbios" in the prompt and see information about the system
>=20
> versus:
> git checkout v2025.04-rc5
> make clean
> git clean -xf
> make qemu-x86_defconfig
> # edit .config: CONFIG_CMD_SMBIOS=3Dy
> make -j4
> qemu-system-i386 -bios u-boot.rom
> # type "smbios" and get the following error:
> # do_smbios() Unknown SMBIOS anchor format
>=20
> This is on QEMU version 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.25), the one
> Ubuntu 22.04 currently ships, but I also get the same results on Ubuntu
> 24.04.
>=20
> Bisecting leads me to the following commit:
>=20
> commit d5bc5c6cb0291203fe848a8532a7ecbcd44cfe9e
> Author: Simon Glass <sjg@chromium.org>
> Date:   Fri Jan 10 17:00:26 2025 -0700
>=20
>     x86: emulation: Enable bloblist
>=20
>     Add bloblist support so that tables can be generated and placed in a
>     bloblist, then passed to a payload using UPL
>=20
>     Signed-off-by: Simon Glass <sjg@chromium.org>
>=20
> diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
> index 2771a4b9e19..792ba06c2b8 100644
> --- a/configs/qemu-x86_64_defconfig
> +++ b/configs/qemu-x86_64_defconfig
> @@ -1,6 +1,7 @@
>  CONFIG_X86=3Dy
>  CONFIG_TEXT_BASE=3D0x1110000
>  CONFIG_SYS_MALLOC_F_LEN=3D0x1000
> +CONFIG_BLOBLIST_SIZE_RELOC=3D0x20000
>  CONFIG_NR_DRAM_BANKS=3D8
>  CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_MAX_CPUS=3D2
> @@ -33,6 +34,7 @@ CONFIG_LOGF_FUNC=3Dy
>  CONFIG_SPL_LOG=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_PCI_INIT_R=3Dy
> +CONFIG_BLOBLIST=3Dy
>  CONFIG_BLOBLIST_FIXED=3Dy
>  CONFIG_BLOBLIST_ADDR=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
> index 947d15cd727..0b0e10c795f 100644
> --- a/configs/qemu-x86_defconfig
> +++ b/configs/qemu-x86_defconfig
> @@ -1,6 +1,7 @@
>  CONFIG_X86=3Dy
>  CONFIG_TEXT_BASE=3D0xFFF00000
>  CONFIG_SYS_MALLOC_F_LEN=3D0x1000
> +CONFIG_BLOBLIST_SIZE_RELOC=3D0x20000
>  CONFIG_NR_DRAM_BANKS=3D8
>  CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_MAX_CPUS=3D2
> @@ -23,6 +24,9 @@ CONFIG_LOG=3Dy
>  CONFIG_LOGF_FUNC=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_PCI_INIT_R=3Dy
> +CONFIG_BLOBLIST=3Dy
> +CONFIG_BLOBLIST_FIXED=3Dy
> +CONFIG_BLOBLIST_ADDR=3D0x10000
>  CONFIG_CMD_CPU=3Dy
>  CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
>  CONFIG_CMD_NVEDIT_EFI=3Dy
>=20
> Just setting CONFIG_BLOBLIST=3Dn solves this problem for me.
>=20
> I'm not sure how to debug this further, because v2025.01 doesn't build wi=
th
> the config from v2025.04-rc5:
> ld.bfd: arch/x86/lib/tables.o: in function `write_tables':
> /home/niklas/Build/u-boot/arch/x86/lib/tables.c:171: undefined reference =
to
> `acpi_write_rsdp'

I think for the v2025.04 release we should just put BLOBLIST=3Dn (so long
as CI passes still), and file an issue to sort this out for the next
release. Can you please file something at
https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues ? Thanks!

--=20
Tom

--4CI8j/im+j4naDKG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfwCb8ACgkQFHw5/5Y0
tyzYlQv/WsXGrgI1zErdZ1y3SA6+MHdlJ5121QuMUk4d87Wc2tnWII6Vp3JG6xTa
5wmkUPCOr9HBlIblyPVE5R4RAWzhu6KPQY0Th/KywAtaXfCNUmc22PONPdiYF4ot
A8Td9jqWizkn009romIllcBxB+hB9hWOe4z/RLgJkpEMo54AJBQXeTDdyOX3rjOk
4xSHjYFLFoR/bQD5ZgihOkqSWBLIH/jaLscAB/JXtdr7KItd6KLbEtItSQYLgZ+I
f8uge/+i4Ntu9+AyZePqFa+cWb1MdW4gROgL35+4aO2rCkd+ryXpm2BQqequr84o
v/8oMh/fQ1oJj4Mnng38q+8Stgu6iWckEPxioQvA4QLwEGIWNM7zytvBnEq5PhNl
5ndZps/6o3J+YxBAGrCuNuSgf/Pa4Q346FFhxNR7/b5rkaR3zACIvv98KYsA/hkQ
CUJmFRZNU8WXBWSeEYVIbBShf1+gLpBa5XLrHeuZeORGe7tVOrsQ0qnCHoRA0NJ/
8Sot0kdv
=Q235
-----END PGP SIGNATURE-----

--4CI8j/im+j4naDKG--
