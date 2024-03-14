Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD9BC54E69
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 12:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED18387FA3;
	Thu, 14 Mar 2024 13:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ScdWXIMK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEED487FA7; Thu, 14 Mar 2024 13:46:59 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A41F87FA0
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 13:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-42e29149883so3698501cf.2
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710420415; x=1711025215; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JgzBAhFP17xSJcnFNb5lYkKOf/m5jH2XPtWftm6YJbo=;
 b=ScdWXIMKmHN21swjvTxmTFmjcb9+HSOvYeQWs5Wa8m4ZTMB0dnAjYm5+6uVVs5cXtY
 +bmAIR0i9xXrsA/BWjH2rcVTuRjzWXz8ph6BiV83t2jpCvxhHJE9kUofz9tOvcNS4aoE
 29QhKEYl4IW5K3BnWq7CXG3Gsi8fiFT0jJNXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710420415; x=1711025215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JgzBAhFP17xSJcnFNb5lYkKOf/m5jH2XPtWftm6YJbo=;
 b=CPRnYvJl6xsI22fKEADseLStDJTR+Z13vzs6itrWMe0jrDb9AQ2rVuGJHizhw4T7S5
 0TwU3RWsO/osNnfpjvB7EylWMIxBPl8bYVI6qSjVyJW5+RPZzv6k4QHHko1AlwEEX1/+
 Lbvmws0Xqu04xVd/qbpCKnEoiinWdYUtSVCggaekB3OCtbWbsy2r+u/yHagMIUwXEcmJ
 M4D/UW/5os+1NOoSx+JVXrK/KtIS00b/GeiUL8db4yS6ofy6sJ3QY3ctfoIbCvWxVg+n
 0hahW0KnaROlspnjq2TjWu49XZvR8H0uum/8spmLwvVT6bpUSyQodLqxQbSRGraMvj4X
 Kd5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyGKyX/7FQP8D5GbewPkvwYRi0rPvrblxEhqKyMVnOyMm63M4ZM0L4HdUOPzRbJnOuiPDZNm+bZYOA6AsrXfW09nljiA==
X-Gm-Message-State: AOJu0YyHFJMd8dIiwfx+SPtcQFveZA8YEMffrBTwNHUBCUWURg0oMZyY
 LU7YRbqq04kfO9JHQB9JLx5x7yHSBn37IP81ELMci3zhmKvzEbJSaaXn41db4SI=
X-Google-Smtp-Source: AGHT+IFn1wogDkDb081rBtICCCTB5VUqZj9kxTAEHFsfuBZ3eMLR92gUgpCGFQlw/0LkMewxM/lFtw==
X-Received: by 2002:ac8:5984:0:b0:42f:2130:cdb0 with SMTP id
 e4-20020ac85984000000b0042f2130cdb0mr577432qte.32.1710420414901; 
 Thu, 14 Mar 2024 05:46:54 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 i23-20020ac84f57000000b0042f1e47e652sm721177qtw.79.2024.03.14.05.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 05:46:54 -0700 (PDT)
Date: Thu, 14 Mar 2024 08:46:52 -0400
From: Tom Rini <trini@konsulko.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: "Anwar, Md Danish" <a0501179@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v6] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Message-ID: <20240314124652.GV3442575@bill-the-cat>
References: <20240228120645.958316-1-danishanwar@ti.com>
 <20240307124612.GA4110939@bill-the-cat>
 <af15ffae-fbf1-4b14-8035-1f95beb440e1@ti.com>
 <dc9cb18e-e7a0-4389-abc7-fbeda907bd56@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bbFqeSiisvPVBYri"
Content-Disposition: inline
In-Reply-To: <dc9cb18e-e7a0-4389-abc7-fbeda907bd56@ti.com>
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


--bbFqeSiisvPVBYri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 02:02:08PM +0530, MD Danish Anwar wrote:
>=20
>=20
> On 11/03/24 10:34 am, Anwar, Md Danish wrote:
> >=20
> >=20
> > On 3/7/2024 6:16 PM, Tom Rini wrote:
> >> On Wed, Feb 28, 2024 at 05:36:45PM +0530, MD Danish Anwar wrote:
> >>> Add APIs to set a firmware_name to a rproc and boot the rproc with the
> >>
> >>> same firmware.
> >>>
> >>> Clients can call rproc_set_firmware() API to set firmware_name for a =
rproc
> >>> whereas rproc_boot() will load the firmware set by rproc_set_firmware=
() to
> >>> a buffer by calling request_firmware_into_buf(). rproc_boot() will th=
en
> >>> load the firmware file to the remote processor and start the remote
> >>> processor.
> >>>
> >>> Also include "fs-loader.h" and make remoteproc driver select FS_LOADE=
R in
> >>> Kconfig so that we can call request_firmware_into_buf() from remotepr=
oc
> >>> driver.
> >>>
> >>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >>> Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> >>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> >>
> >> This breaks building on am64x_evm_r5 am65x_evm_r5_usbdfu
> >> am65x_evm_r5_usbmsc in next currently, thanks.
> >>
> > I will work on fixing this build error and re-spin the patch.
> >=20
>=20
> Hi Tom, Roger,
>=20
> This patch adds "request_firmware_into_buf()" in the rproc driver. To
> use this API, FS_LOADER is needed. So I am adding "select FS_LOADER" in
> REMOTEPROC Kconfig option. As a result whenever REMOTEPROC is enabled,
> FS_LOADER also gets enabled.
>=20
> Now arch/arm/mach-k3/common.c [1] and arch/arm/mach-omap2/boot-common.c
> [2] has a "load_firmware()" API which calls fs-loader APIs and they have
> below if condition before calling fs-loader APIs.
>=20
> if (!IS_ENABLED(CONFIG_FS_LOADER))
> 		return 0;
>=20
> Till now, CONFIG_FS_LOADER was not set as a result the load_firmware()
> API in above mentioned files, was returning 0.
>=20
> Now as this patch enables CONFIG_FS_LOADER, as a result the code after
> the if check starts getting executed and it tries to look for
> get_fs_loader() and other fs-loader APIs but this is done at SPL and at
> this time FS_LOADER is not built yet as a result we see below error.
> The if checks only checks for CONFIG_FS_LOADER but not for
> CONFIG_SPL_FS_LOADER.
>=20
>   AR      spl/boot/built-in.o
>   LD      spl/u-boot-spl
> arm-none-linux-gnueabihf-ld.bfd: arch/arm/mach-k3/common.o: in function
> `load_firmware':
> /home/danish/workspace/u-boot/arch/arm/mach-k3/common.c:184: undefined
> reference to `get_fs_loader'
> arm-none-linux-gnueabihf-ld.bfd:
> /home/danish/workspace/u-boot/arch/arm/mach-k3/common.c:185: undefined
> reference to `request_firmware_into_buf'
> make[2]: *** [/home/danish/workspace/u-boot/scripts/Makefile.spl:527:
> spl/u-boot-spl] Error 1
> make[1]: *** [/home/danish/workspace/u-boot/Makefile:2055:
> spl/u-boot-spl] Error 2
> make[1]: Leaving directory '/home/danish/uboot_images/am64x/r5'
> make: *** [Makefile:177: sub-make] Error 2
>=20
> This bug has always been there but as CONFIG_FS_LOADER was never
> enabled, this build error was never seen as the load_firmware() API will
> return 0 without calling fs-loader APIs.
>=20
> Now that this patch enables CONFIG_FS_LOADER, the bug gets exposed and
> build error is seen.
>=20
> My opinion here would be, to check for CONFIG_IS_ENABLED(FS_LOADER)
> instead of IS_ENABLED(CONFIG_FS_LOADER) as the former will check for the
> appropriate config option (CONFIG_SPL_FS_LOADER / CONFIG_FS_LOADER)
> based on the build stage.
>=20
> I tested with the below diff and I don't see build errors with
> am64x_evm_r5, am65x_evm_r5_usbdfu, am65x_evm_r5_usbmsc configs.
>=20
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index f411366778..6792ff7467 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -162,7 +162,7 @@ int load_firmware(char *name_fw, char
> *name_loadaddr, u32 *loadaddr)
>         char *name =3D NULL;
>         int size =3D 0;
>=20
> -       if (!IS_ENABLED(CONFIG_FS_LOADER))
> +       if (!CONFIG_IS_ENABLED(FS_LOADER))
>                 return 0;
>=20
>         *loadaddr =3D 0;
> diff --git a/arch/arm/mach-omap2/boot-common.c
> b/arch/arm/mach-omap2/boot-common.c
> index 57917da25c..aa0ab13d5f 100644
> --- a/arch/arm/mach-omap2/boot-common.c
> +++ b/arch/arm/mach-omap2/boot-common.c
> @@ -190,7 +190,7 @@ int load_firmware(char *name_fw, u32 *loadaddr)
>         struct udevice *fsdev;
>         int size =3D 0;
>=20
> -       if (!IS_ENABLED(CONFIG_FS_LOADER))
> +       if (!CONFIG_IS_ENABLED(FS_LOADER))
>                 return 0;
>=20
>         if (!*loadaddr)
>=20
>=20
> Tom, Roger, Please let me know if this looks ok.
> If it's ok, I will post this diff as a separate patch and once that is
> merged Tom can merge this patch or I can send a v7 if needed.

Yes, this seems like the right path, thanks.

--=20
Tom

--bbFqeSiisvPVBYri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXy8bwACgkQFHw5/5Y0
tyzX/gwAoVWusEiSOQtyldx9sGNdRqSdQMV/17OSwja9+CUx5rdaOJzniGTCzial
319xzgJTUfL3SIjc3pEoCVyMCpIE0tzN0aCUwCUMb7KMW1PX0Qqqb3lgOU4Uwbsr
s5cjqu11QeiTSUMztGxwmJlzqAnYy+Cb5xf8cMifterFTHA+usS/VjTsp5QuHweJ
PwZU/Otuhw9vYfjULoBGg0uAQTC9tlV1Sg95mtrflip9GEDIC2VHaDPVI+jM70hp
1Qs0/NRKkuKYZSxHLnjJdH2+UeKRy4R1KGNTDRyfgTcJ3o3/Wrpz5KOJkrlu1xCS
CCynaJJaG9TiLsKLoxkwwpYhBiQBLFriur5iY7cGeWlLLs6pVnqxHSQlrwbVYRHF
SDgkcUoEeYXeuGpKn+tmJ94fba3H4Ch2Dkxo13/XkOGOkhrSMiPOZ40gri+/XQD1
fOmr6BU1PhO/fFvI18tDG3zeTLiBrrftz6cchgPThfBNzj9byEYpuSK2ySaCI2Bc
CNv/iQoA
=c1NZ
-----END PGP SIGNATURE-----

--bbFqeSiisvPVBYri--
