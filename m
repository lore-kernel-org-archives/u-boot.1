Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61DECDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 15:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EDE287787;
	Sun, 22 Oct 2023 17:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ass9CgaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E0587717; Sun, 22 Oct 2023 17:55:50 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 954BF87782
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 17:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d9a6399cf78so2035987276.0
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697990146; x=1698594946; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SUDcxU2+9ZnHcBmj9JImOWgtfhK2/j8bVKAvlIIaX9E=;
 b=ass9CgaMORzYpDMkOlapT8QAMYaq9m5bkHD8uFztzWvvhSn7JW2Zx8Ie0WaiYUyUJ9
 /DTbjoQHd2yUbpKt0Z0tAH7Yki54fOWW/RhU18pbaF1LU58ZIWcgS3QKg+hQ4YWiJAmw
 wG9H0rUG8LuisK1XNVqgzUYYqvzeqlTeKWT9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697990146; x=1698594946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUDcxU2+9ZnHcBmj9JImOWgtfhK2/j8bVKAvlIIaX9E=;
 b=Jt/Hs+PRfSH4KlDbxvQW+T+qDy90ropfwZ1CnUENiz2tv37GSmkpPkr20Z5eUeqlvk
 G6z/QOsoB8vrbO0Ue6Fq48wFty3G7BWalY1b2EOylLSM3PhTfJmcm0ei/SYmGou85neu
 YRYYYkVfKhDbcn+s+vBIjztibP+dOJLY6tUfx3XoD75NqKSVii5O+SbDOsU6I0Goqn9m
 pytFZgv1koaVCRM6hkINSPWbWDLl+TkWGJbKo3Zmjbn4t7R8cyLPaRdVEW0Synq9JIpx
 bt5XsV6x23EgqAXbtQ8/oyztidw0rVBI4BybI6VF2hzyDM7jL7SjMEXRSbBZoVkiKKop
 Qz1w==
X-Gm-Message-State: AOJu0Yy3WzRGL0gX0RJTBEBFxGjeL4Cal5++HqDmRdwPYNPkaCfpysU6
 xlOCfPTpr9jWpJZeUblsxgPivMrPLkn7fUNRv0yFtg==
X-Google-Smtp-Source: AGHT+IFVcxIhDBuxzZ+lFBjlbL/nmZezxY/R767cRUh+u3V0J08gHghmA84OULeqWOdZW4blGFLF2A==
X-Received: by 2002:a25:d111:0:b0:d9a:be2c:ce3d with SMTP id
 i17-20020a25d111000000b00d9abe2cce3dmr9755759ybg.8.1697990146228; 
 Sun, 22 Oct 2023 08:55:46 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d02f-b9d9-0a79-793c.res6.spectrum.com.
 [2603:6081:7b00:6400:d02f:b9d9:a79:793c])
 by smtp.gmail.com with ESMTPSA id
 v73-20020a25abcf000000b00d9b4ddf1c32sm2070127ybi.2.2023.10.22.08.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 08:55:45 -0700 (PDT)
Date: Sun, 22 Oct 2023 11:55:43 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 1/1] efi_loader: expose the device-tree file name
Message-ID: <20231022155543.GC496310@bill-the-cat>
References: <20231022084733.113326-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NG+WQDmRLihtPJxe"
Content-Disposition: inline
In-Reply-To: <20231022084733.113326-1-heinrich.schuchardt@canonical.com>
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


--NG+WQDmRLihtPJxe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 10:47:33AM +0200, Heinrich Schuchardt wrote:

> Forward and backward compatibility of Linux kernel device-trees is
> sometimes missing. One solution approach is to load a kernel specific
> device-tree. This can either be done via a U-Boot scripts (like the one
> generated by Debian package flash-kernel or by a boot loader like GRUB.
> The boot loader approach currently requires to know the device-tree name
> before first boot which makes it unusable for generic images.
>=20
> Expose the device-tree file name as EFI variable FdtFile.
> This will allow bootloaders to load a kernel specific device-tree.
>=20
> The variable will not be exposed on ACPI based systems or if the
> environment variable fdtfile is not defined.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
> 	Add documentation
> v2:
> 	Use a unique GUID to enable future U-Boot independent
> 	standardization.
> 	Do not try to add the variable on ACPI based systems.
> ---
>  doc/develop/uefi/uefi.rst  | 17 +++++++++++++++++
>  include/efi_loader.h       |  5 +++++
>  lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>=20
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index fb16ac743a..a81d09ae81 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -916,6 +916,23 @@ So our final format of the FilePathList[] is::
> =20
>      Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x=
01) - initrd_n ...] - end node (0xff)
> =20
> +EFI variable FdtFile
> +~~~~~~~~~~~~~~~~~~~~
> +
> +Ideally U-Boot would always expose a device-tree that can be used for bo=
oting
> +any operating systems. Unfortunately operating systems like Linux someti=
mes
> +break forward and backward compatibility. In this case there is a need t=
o load
> +an operating system version specific device-tree.
> +
> +U-Boot has an environment variable fdtfile identifying the device-tree f=
ile to
> +load. The content of this variable is exposed as EFI variable Fdtfile, v=
endor
> +GUID d45dde69-3bd6-40e0-90d5-6b606aa57730. It contains the device-tree p=
ath
> +name as a NUL terminated ASCII string.
> +
> +On 32bit ARM this is currently only a file name, e.g. 'imx6dl-wandboard.=
dtb'.
> +On other architectures the file name is preceded by the vendor directory=
, e.g.
> +'rockchip/rk3326-odroid-go2.dtb'.

The Linux Kernel has split 32bit ARM up by directory now, too.

--=20
Tom

--NG+WQDmRLihtPJxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU1RfgACgkQFHw5/5Y0
tyw+lQwAm6+DdYCh+j0+N52XDhPxcf/+MFTolR7Z8vKjsawsb9CEqMC1/pGmGn2P
uNSSEkhiW31nYDGBWVkDScX64SOMn9E4swMYVpzdJEDBcCAvIEcHzu62P+nBhOqT
z8/6fG/Wh8fOUrC7Vl3tLe9DrAEJVQs07aK7MwazUKcPDrjuiwbeyNwUnl/tjqY+
mRvJmrIxFs6RbBCcUq0/SWDaUR8+v7AmPEUWYVYmKven7L4mV2aC9h5N7HTh5Di4
xPd9IoB+TDCIEV8n12CG78hNs2LbXtseIx1Y+FAf99tVjI6zhzaB2gRI4dOpnQV4
eg8B4FzF+aZ0foZMJmll63yOO5hAVjupx4XSfK124EqU22V4qCYQq6JX6Kcubevq
jXW+kEkBZyn0dUoge55/+uzL8dkVwBNllz3Ncv0gwL+wT/CmeOCkJWfAVxf+mtPz
CqRJ3MB4WAfZnjxqmPmstcMRViBTdCAUOdccAsOqfeU2PrguzCsJ7QmDS/eIBLX/
qnhpeOwo
=tdE+
-----END PGP SIGNATURE-----

--NG+WQDmRLihtPJxe--
