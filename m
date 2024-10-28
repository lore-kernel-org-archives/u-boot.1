Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBF2D33990
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 15:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4846089099;
	Mon, 28 Oct 2024 16:17:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bpv9jFnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 733F3890BF; Mon, 28 Oct 2024 16:17:45 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31B8B8908F
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b150dc7bc0so344773385a.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 08:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730128662; x=1730733462; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZrG9gi0mR/UsZp2TctTK5wRRqz/jvvjyAh90v8t3H/s=;
 b=bpv9jFnts3ytBNFQkan74SlD8Oge6rzKzp1V81TdDKy3In5DpVtx1EQqSMNSqEFMSk
 +d39vPvtKp1QQPWyMX62oeJVYKGP1Irk43FATcNzsN8ueJPplvWLMA3BzzCanPERtJXu
 7nkC51xZMdvv4Py6bR6ZZ8etUbMAccBkfDki0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128662; x=1730733462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrG9gi0mR/UsZp2TctTK5wRRqz/jvvjyAh90v8t3H/s=;
 b=GO1YB+6aNwVOaucc1ez07YXlsrblxKwR7vzaGfWpjSkSUjq+mzabPAGuxgJSSRg3Ll
 MhaigXpSurg8thSRsmV5pMZDnlD7fA4BGybIB3yWudeeB6ALxfk7mtn8zfA1PeYDCDg+
 1aLMvVvwQOoYKZ9UnWdgaGKta/R2Utt5GD/0YSYgwK1gM3kUqxWt+qJu+6kU0HvyIbV6
 MjuDawTp4PoOTERzqJFC+sjea8B+nH2vFL/nyLp0cZUxJPX8Nz9dBLLWiE/qh7gI/Gal
 r1CfCAewuox3Vygo2Ya+Txm5kgTvj6A/5x9g4h3D1s5s0XFS9L5uycGitsiLv1BWgaUs
 eXuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWYFqwKw5w4vNEL2cyQuNOyyvgoZae7Pqn3erG4L4+9wQL2nddZ7JDylAuwNO1a0G0RJiNBP0=@lists.denx.de
X-Gm-Message-State: AOJu0YxddeJFgp5fef9lz2R5psPrI6QSVVdyeggUOjAHwCElea21WmIa
 aKQZvdRkn7amDwXg/BQrAKmXYynSZQ9LtTsaO5+5DjX+jmWlYWDNKgjJiVPfraI=
X-Google-Smtp-Source: AGHT+IFIAEqRAA0H15GY+JoadesBSQPRoFSDlTg95YfAh3IkF2d0mzKhKnxlt6WcdaOFd80fLmhoIg==
X-Received: by 2002:a05:620a:4714:b0:7b1:8cda:6f4e with SMTP id
 af79cd13be357-7b193ed840bmr1292291385a.5.1730128661926; 
 Mon, 28 Oct 2024 08:17:41 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3480d7sm326858285a.123.2024.10.28.08.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:17:41 -0700 (PDT)
Date: Mon, 28 Oct 2024 09:17:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v8 2/8] efi_loader: Add a test app
Message-ID: <20241028151738.GO4959@bill-the-cat>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-3-sjg@chromium.org>
 <9f322139-ad6d-494d-879b-eab3211b874b@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6q65uNTnqvpddeNd"
Content-Disposition: inline
In-Reply-To: <9f322139-ad6d-494d-879b-eab3211b874b@gmx.de>
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


--6q65uNTnqvpddeNd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 06:59:10AM +0100, Heinrich Schuchardt wrote:
> On 10/22/24 14:00, Simon Glass wrote:
> > Add a simple app to use for testing. This is intended to do whatever it
> > needs to for testing purposes. For now it just prints a message and
> > exits boot services.
> >=20
> > There was a considerable amount of discussion about whether it is OK to
> > call exit-boot-services and then return to U-Boot. This is not normally
> > done in a real application, since exit-boot-services is used to
> > completely disconnect from U-Boot. However, since this is a test, we
> > need to check the results of running the app, so returning is necessary.
> > It works correctly and it provides a nice model of how to test the EFI
> > code in a simple way.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >=20
> > (no changes since v7)
> >=20
> > Changes in v7:
> > - Update commit message
> >=20
> >   lib/efi_loader/Kconfig   | 10 ++++++
> >   lib/efi_loader/Makefile  |  1 +
> >   lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 79 insertions(+)
> >   create mode 100644 lib/efi_loader/testapp.c
> >=20
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 69b2c9360d8..6ced29da719 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -565,6 +565,16 @@ config BOOTEFI_HELLO_COMPILE
> >   	  No additional space will be required in the resulting U-Boot binary
> >   	  when this option is enabled.
> >=20
> > +config BOOTEFI_TESTAPP_COMPILE
> > +	bool "Compile an EFI test app for testing"
> > +	default y
> > +	help
> > +	  This compiles an app designed for testing. It is packed into an ima=
ge
> > +	  by the test.py testing frame in the setup_efi_image() function.
> > +
> > +	  No additional space will be required in the resulting U-Boot binary
> > +	  when this option is enabled.
> > +
> >   endif
> >=20
> >   source "lib/efi/Kconfig"
> > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > index 00d18966f9e..87131ab911d 100644
> > --- a/lib/efi_loader/Makefile
> > +++ b/lib/efi_loader/Makefile
> > @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D initrddump
> >   ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
> >   apps-y +=3D dtbdump
> >   endif
> > +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) +=3D testapp
> >=20
> >   obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
> >   obj-$(CONFIG_EFI_BOOTMGR) +=3D efi_bootmgr.o
> > diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
> > new file mode 100644
> > index 00000000000..feb444c92e9
> > --- /dev/null
> > +++ b/lib/efi_loader/testapp.c
> > @@ -0,0 +1,68 @@
> > +// SPDX-License-Identifier: GPL-2.0+
>=20
> This is not a valid SPDX identifier. Please, use GPL-2.0-or-later.

We should switch to the proper one here, but there are numerous examples
of this today.

> > +/*
> > + * Hello world EFI application
> > + *
> > + * Copyright 2024 Google LLC
> > + * Written by Simon Glass <sjg@chromium.org>
> > + *
> > + * This test program is used to test the invocation of an EFI applicat=
ion.
> > + * It writes a few messages to the console and then exits boot services
> > + */
> > +
> > +#include <efi_api.h>
> > +
> > +static const efi_guid_t loaded_image_guid =3D EFI_LOADED_IMAGE_PROTOCO=
L_GUID;
> > +
> > +static struct efi_system_table *systable;
> > +static struct efi_boot_services *boottime;
> > +static struct efi_simple_text_output_protocol *con_out;
> > +
> > +/**
> > + * efi_main() - entry point of the EFI application.
> > + *
> > + * @handle:	handle of the loaded image
> > + * @systab:	system table
> > + * Return:	status code
> > + */
> > +efi_status_t EFIAPI efi_main(efi_handle_t handle,
> > +			     struct efi_system_table *systab)
> > +{
> > +	struct efi_loaded_image *loaded_image;
> > +	efi_status_t ret;
> > +	efi_uintn_t map_size;
> > +	efi_uintn_t map_key;
> > +	efi_uintn_t desc_size;
> > +	u32 desc_version;
> > +
> > +	systable =3D systab;
> > +	boottime =3D systable->boottime;
> > +	con_out =3D systable->con_out;
> > +
> > +	/* Get the loaded image protocol */
> > +	ret =3D boottime->open_protocol(handle, &loaded_image_guid,
> > +				      (void **)&loaded_image, NULL, NULL,
> > +				      EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> > +	if (ret !=3D EFI_SUCCESS) {
> > +		con_out->output_string
> > +			(con_out, u"Cannot open loaded image protocol\r\n");
> > +		goto out;
> > +	}
> > +
> > +	/* UEFI requires CR LF */
> > +	con_out->output_string(con_out, u"U-Boot test app for EFI_LOADER\r\n"=
);
> > +
> > +out:
> > +	map_size =3D 0;
> > +	ret =3D boottime->get_memory_map(&map_size, NULL, &map_key, &desc_siz=
e,
> > +				       &desc_version);
> > +	con_out->output_string(con_out, u"Exiting boot sevices\n");
>=20
> %s/sevices/services/g
>=20
> > +
> > +	/* exit boot services so that this part of U-Boot can be tested */
> > +	boottime->exit_boot_services(handle, map_key);
> > +
> > +	/* now exit for real */
> > +	ret =3D boottime->exit(handle, ret, 0, NULL);
>=20
> As written before boot services are not available after
> ExitBootServices(). Please, call the ResetSystem() service.

Right, but the point is to not do that and instead test what happens. I
think Ilias had said we need to make some big loud print on console that
you must reset the system for it to be usable afterwards, would that
be enough?

--=20
Tom

--6q65uNTnqvpddeNd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcfqw4ACgkQFHw5/5Y0
tyygywv+MTYCWp9R/olID2EBIym5ZZYyosB+uckotlkjRFjuw4fjnchPLeDsSHdL
f+ryc608RAo7lY9rQ8bmzBJ5QY0fEZVbnRLqJlr1fAVm9hjbpzHOBc5sK7xUUuyN
f6PlP29DQpG12JDjlDJ1NvV/taFuE9wPQYq4IMFfOA9s3xPrTt88x5H+tYwiqHwm
5EKe7S2p03XFsrSRgmZuWI7VStMJ8oGJRhSF+qMQWXqGBSW+dIyVrTdafcM/GliN
XNLPEUPDHkfYTT1ny+UREs2yx6klrmnNyuCVg+lDtz4n5OQidq1X2iQph3d4nXNf
d1iBj9KVB5YsHp5esn2Na+g6g7ZVy27+K4cTXGywx9lUSAMDnqup5rbDjuKM1BUg
S0x6shA9wqWr7po5Dhy8zsvcWLnnQdNYzoDwukwgmb/g0ufsjTpAH/6gjrHTSLS6
3AzR5bIss+TAbFzjE44+MUf7AvMZqyHqx41Q/9GT7ZVEtxXEDoUJcOAym9CJPYwp
dwA0eexl
=wQdp
-----END PGP SIGNATURE-----

--6q65uNTnqvpddeNd--
