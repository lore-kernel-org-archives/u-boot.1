Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2D3D339A0
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 16:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF122890E9;
	Mon, 28 Oct 2024 17:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qJormAI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B3C0890D0; Mon, 28 Oct 2024 17:52:17 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0700489099
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 17:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3e600ae1664so2627797b6e.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730134334; x=1730739134; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HzUEF67FdjxQuUMStrsK3jg8KIIb0I3FhW2P5EExLLE=;
 b=qJormAI4NHe7huWTdgS5TMBTOafLsEIOoYOgN27hRzx3Xl9BGtpib12tYyGnsfTtem
 rjJUb+fNF3e00ypyQ2MnBDm5e7ajIznDixEbdmZHeq7mh86JhCiESRWF4C4n37Qb0/Dj
 YBKdhoC9ng8i3TFtSDhne9XaCfPIM7kf017x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730134334; x=1730739134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HzUEF67FdjxQuUMStrsK3jg8KIIb0I3FhW2P5EExLLE=;
 b=EUd/eNm1hGamPDXZgqyNpYXCYOIQ0PYoOsyuknXLar9KYjGEmqPkgv36kzobkniefs
 Q7xW1IT2g/baNCD3EDjBSJ0Arqvq86hTiBx7YyW/WIyU4ESzvgW5AAHU6Rg320Uazg/T
 eVx95hhDF+gMqXTkp6X7Ls8PuVSy1Fi6MZC049S1h6oflBZhg7arohM2KUbq+/gOmPe6
 ouHchrrLBSmp06LP0k4onCJosWteVoHmbDGgflLAmF5bFpH8KUkl7TspiKnyGMhCXDNc
 X25SoIoxadjXHzJC5nVIuB1uMqLrwkQxKHkmvYNrQwj9rv4w8pYIyasSMAt33re0MLdV
 PvTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0dpq/Q45lEnJPBUTTSSEROHEqM5X4OwJ7IToZZwDAc6m8d/3W88EVFMOE+F7dSAUo7RB6VzY=@lists.denx.de
X-Gm-Message-State: AOJu0YwnBFd105ukcMXy3ANu9X3rECUHvPzwC8oVcwhURc/4NZIJl8Oc
 PMMYyQu8Q/xL8n76BxbQNQQ2LLAV6lgLK0WwYr/cpyK9POV0ryAPoxb5voboRcY=
X-Google-Smtp-Source: AGHT+IEF5T180D3iRDbkfw+bHZScGLf4r3RWGngCtR4pj9aCoW8f59smp4mYtQZX4tHoItG2HUCHDw==
X-Received: by 2002:a05:6808:1925:b0:3e5:f9ee:a2b3 with SMTP id
 5614622812f47-3e63824b4ecmr8262613b6e.4.1730134333570; 
 Mon, 28 Oct 2024 09:52:13 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17991329bsm34041376d6.58.2024.10.28.09.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 09:52:12 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:52:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v8 2/8] efi_loader: Add a test app
Message-ID: <20241028165210.GQ4959@bill-the-cat>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-3-sjg@chromium.org>
 <9f322139-ad6d-494d-879b-eab3211b874b@gmx.de>
 <20241028151738.GO4959@bill-the-cat>
 <aff49443-ab1d-44a9-ad61-64dfa6114e37@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yMOIMV2VlZpDWk/T"
Content-Disposition: inline
In-Reply-To: <aff49443-ab1d-44a9-ad61-64dfa6114e37@gmx.de>
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


--yMOIMV2VlZpDWk/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 05:47:08PM +0100, Heinrich Schuchardt wrote:
> On 10/28/24 16:17, Tom Rini wrote:
> > On Mon, Oct 28, 2024 at 06:59:10AM +0100, Heinrich Schuchardt wrote:
> > > On 10/22/24 14:00, Simon Glass wrote:
> > > > Add a simple app to use for testing. This is intended to do whateve=
r it
> > > > needs to for testing purposes. For now it just prints a message and
> > > > exits boot services.
> > > >=20
> > > > There was a considerable amount of discussion about whether it is O=
K to
> > > > call exit-boot-services and then return to U-Boot. This is not norm=
ally
> > > > done in a real application, since exit-boot-services is used to
> > > > completely disconnect from U-Boot. However, since this is a test, we
> > > > need to check the results of running the app, so returning is neces=
sary.
> > > > It works correctly and it provides a nice model of how to test the =
EFI
> > > > code in a simple way.
> > > >=20
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >=20
> > > > (no changes since v7)
> > > >=20
> > > > Changes in v7:
> > > > - Update commit message
> > > >=20
> > > >    lib/efi_loader/Kconfig   | 10 ++++++
> > > >    lib/efi_loader/Makefile  |  1 +
> > > >    lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++=
++++++
> > > >    3 files changed, 79 insertions(+)
> > > >    create mode 100644 lib/efi_loader/testapp.c
> > > >=20
> > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > index 69b2c9360d8..6ced29da719 100644
> > > > --- a/lib/efi_loader/Kconfig
> > > > +++ b/lib/efi_loader/Kconfig
> > > > @@ -565,6 +565,16 @@ config BOOTEFI_HELLO_COMPILE
> > > >    	  No additional space will be required in the resulting U-Boot =
binary
> > > >    	  when this option is enabled.
> > > >=20
> > > > +config BOOTEFI_TESTAPP_COMPILE
> > > > +	bool "Compile an EFI test app for testing"
> > > > +	default y
> > > > +	help
> > > > +	  This compiles an app designed for testing. It is packed into an=
 image
> > > > +	  by the test.py testing frame in the setup_efi_image() function.
> > > > +
> > > > +	  No additional space will be required in the resulting U-Boot bi=
nary
> > > > +	  when this option is enabled.
> > > > +
> > > >    endif
> > > >=20
> > > >    source "lib/efi/Kconfig"
> > > > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > > > index 00d18966f9e..87131ab911d 100644
> > > > --- a/lib/efi_loader/Makefile
> > > > +++ b/lib/efi_loader/Makefile
> > > > @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D initrdd=
ump
> > > >    ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
> > > >    apps-y +=3D dtbdump
> > > >    endif
> > > > +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) +=3D testapp
> > > >=20
> > > >    obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
> > > >    obj-$(CONFIG_EFI_BOOTMGR) +=3D efi_bootmgr.o
> > > > diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
> > > > new file mode 100644
> > > > index 00000000000..feb444c92e9
> > > > --- /dev/null
> > > > +++ b/lib/efi_loader/testapp.c
> > > > @@ -0,0 +1,68 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > >=20
> > > This is not a valid SPDX identifier. Please, use GPL-2.0-or-later.
> >=20
> > We should switch to the proper one here, but there are numerous examples
> > of this today.
> >=20
> > > > +/*
> > > > + * Hello world EFI application
> > > > + *
> > > > + * Copyright 2024 Google LLC
> > > > + * Written by Simon Glass <sjg@chromium.org>
> > > > + *
> > > > + * This test program is used to test the invocation of an EFI appl=
ication.
> > > > + * It writes a few messages to the console and then exits boot ser=
vices
> > > > + */
> > > > +
> > > > +#include <efi_api.h>
> > > > +
> > > > +static const efi_guid_t loaded_image_guid =3D EFI_LOADED_IMAGE_PRO=
TOCOL_GUID;
> > > > +
> > > > +static struct efi_system_table *systable;
> > > > +static struct efi_boot_services *boottime;
> > > > +static struct efi_simple_text_output_protocol *con_out;
> > > > +
> > > > +/**
> > > > + * efi_main() - entry point of the EFI application.
> > > > + *
> > > > + * @handle:	handle of the loaded image
> > > > + * @systab:	system table
> > > > + * Return:	status code
> > > > + */
> > > > +efi_status_t EFIAPI efi_main(efi_handle_t handle,
> > > > +			     struct efi_system_table *systab)
> > > > +{
> > > > +	struct efi_loaded_image *loaded_image;
> > > > +	efi_status_t ret;
> > > > +	efi_uintn_t map_size;
> > > > +	efi_uintn_t map_key;
> > > > +	efi_uintn_t desc_size;
> > > > +	u32 desc_version;
> > > > +
> > > > +	systable =3D systab;
> > > > +	boottime =3D systable->boottime;
> > > > +	con_out =3D systable->con_out;
> > > > +
> > > > +	/* Get the loaded image protocol */
> > > > +	ret =3D boottime->open_protocol(handle, &loaded_image_guid,
> > > > +				      (void **)&loaded_image, NULL, NULL,
> > > > +				      EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> > > > +	if (ret !=3D EFI_SUCCESS) {
> > > > +		con_out->output_string
> > > > +			(con_out, u"Cannot open loaded image protocol\r\n");
> > > > +		goto out;
> > > > +	}
> > > > +
> > > > +	/* UEFI requires CR LF */
> > > > +	con_out->output_string(con_out, u"U-Boot test app for EFI_LOADER\=
r\n");
> > > > +
> > > > +out:
> > > > +	map_size =3D 0;
> > > > +	ret =3D boottime->get_memory_map(&map_size, NULL, &map_key, &desc=
_size,
> > > > +				       &desc_version);
> > > > +	con_out->output_string(con_out, u"Exiting boot sevices\n");
> > >=20
> > > %s/sevices/services/g
> > >=20
> > > > +
> > > > +	/* exit boot services so that this part of U-Boot can be tested */
> > > > +	boottime->exit_boot_services(handle, map_key);
> > > > +
> > > > +	/* now exit for real */
> > > > +	ret =3D boottime->exit(handle, ret, 0, NULL);
> > >=20
> > > As written before boot services are not available after
> > > ExitBootServices(). Please, call the ResetSystem() service.
> >=20
> > Right, but the point is to not do that and instead test what happens. I
> > think Ilias had said we need to make some big loud print on console that
> > you must reset the system for it to be usable afterwards, would that
> > be enough?
> >=20
>=20
> There is no point in testing what happens as this call is not allowable.
>=20
> Do we really need to zero out the bootservices table for people who do
> not read the spec to find out the hard way?

Then perhaps this is a case where "test causes U-Boot to reset, check
for that as the result" is what the test needs to do, as it's not an
arbitrary reset?

--=20
Tom

--yMOIMV2VlZpDWk/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcfwTYACgkQFHw5/5Y0
tyxhHQv/dxW9GxB5oDqi8Pqtm7O2Xf03DCsvFafgqxt+t4hXQvrjpndT++w1+cPj
C2fuiV8cbpQ4D9EtZRIOa2fkwYbM2oxhgth1lHzm6b17NlwYrH/zxbh1QTHSX2jF
0LHhOMBVHrDi713W68/mKL81zASPpm45xYixpg0jV766VNs+dRy3mtaqzNhGlt2T
vgIsIUAwY0CJM0W7a5YntIUoKGpbEDvdRxVrHIHbG6cPKJLzkiyyBaheOwzaSQSm
WykZbVMxLtRb78cjJBF0COyk5Mm616v9gSbxn8G23djBlH9J8RykoGqDA3Klkohq
78K7XYWlm42cuZoLqEJBvrmK+RhGPEI/nM8TJJReQJxDSG4HAHqmRJeNzjF2oNju
zPTwbZsA3tDLqsvekczVLx10oRpHok4WPZY0+2LntVLHCWI3M6VONZdI42Aa9rnL
SdbdO42xQ+oaAl+MnieG8V10dENpj/VEu0M2owwhiShGPXZtgN/pIMm00WWmD8Go
UUziclIM
=LF56
-----END PGP SIGNATURE-----

--yMOIMV2VlZpDWk/T--
