Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C25D3A673
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 16:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEF0B88E96;
	Tue, 29 Oct 2024 17:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CklMwjjf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A814889189; Tue, 29 Oct 2024 17:46:52 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46A0288E32
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbd12b38b4so30483836d6.2
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730220409; x=1730825209; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fFnK7yM2DTG45FGVJ1o5gPCMotfM1Cseyzk6sGpMkM0=;
 b=CklMwjjfT7bjUhT72Tqh1LYKly3/sQm2eqNDz8bNomjh6EHQyJCq5kTbQdELltWrD0
 ttk2gfHqaPmSoI+U4ZflrhQOh46Jw9dhpG16iU/Rs4a9rR/AC53JLATWFkiHZUxe5PyM
 A83Clj9IsoW/3Z1KNDKOFDZQmc8hO8v/0YWAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730220409; x=1730825209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFnK7yM2DTG45FGVJ1o5gPCMotfM1Cseyzk6sGpMkM0=;
 b=jfzhSCTZmzBUuxHbQ6puXRAS4xY6kVy8AI9Am3O82ph2+WKzh9skNhvZ5Wd6PNV0tB
 eJX5T0+FsWapHCbt5PCqCHN9B2Gs+3XBN4mlb9LjIiYzwZqHmv9ph8MZZBq6SJRzGhVy
 ztnpewj+eJJ8BJGED1FmpO3NJ4598xLXkW+VX/AtSPvREgAIp0tQf/52sNIOXJYbnAaT
 4NEzKktYHSoR+LTlWLVoIudEsp6Ordtvkt4fbg0VOViA6yWkut1D2V7A5GRP3f+AtZrw
 nt6ZUEQFcwNhI6X7KPo3GeytLv0lDev0KfIStoZ5tFLD9a1tsAITsJEQO7lJiuwz4HQl
 DLJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFt3nkvHc8VhoPL5qTn0fFWFSKylYGAu38+4uEB2LRcFX5ynCKs1OlIewLlFkR+CqAwbUB1Tk=@lists.denx.de
X-Gm-Message-State: AOJu0YzjnbEwxaxF+ybZdrMjpA6b8m4VqTb5gp/YupwihSawtSA2AsOX
 81ugJdGBjH07mSBl5Mw4fVqSbAR79cu6aKfgKODObYzJE2nIEGL8lDtHwrfbQT8=
X-Google-Smtp-Source: AGHT+IH67nzA+E12a1dMmX9dHxGvjhZsvx8heoXnvS3J3NfCISYqxXXxglU0cygsr/z0LhA3BGkzew==
X-Received: by 2002:a05:6214:2d48:b0:6cc:42d:bb6 with SMTP id
 6a1803df08f44-6d1856bb1bdmr182873846d6.16.1730220409058; 
 Tue, 29 Oct 2024 09:46:49 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d179a2d963sm43466886d6.119.2024.10.29.09.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 09:46:48 -0700 (PDT)
Date: Tue, 29 Oct 2024 10:46:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v8 2/8] efi_loader: Add a test app
Message-ID: <20241029164645.GF4959@bill-the-cat>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-3-sjg@chromium.org>
 <9f322139-ad6d-494d-879b-eab3211b874b@gmx.de>
 <CAFLszTgHvUo+0g+SBhC=Xbd_aFxdP_DF=wg_G3ZRTRP-k-2qVg@mail.gmail.com>
 <adacb624-28a8-41a0-a22b-19d2b9d3a5b1@gmx.de>
 <CAFLszThgu+jsDMDGJdESP+UOTRRGJ0ORN-xeDCkOYY7xPJq7-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4l0K0IeSHvuUYx0o"
Content-Disposition: inline
In-Reply-To: <CAFLszThgu+jsDMDGJdESP+UOTRRGJ0ORN-xeDCkOYY7xPJq7-A@mail.gmail.com>
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


--4l0K0IeSHvuUYx0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 04:46:16PM +0100, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Mon, 28 Oct 2024 at 19:43, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > On 10/28/24 18:00, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Mon, 28 Oct 2024 at 07:11, Heinrich Schuchardt <xypron.glpk@gmx.de
> > > <mailto:xypron.glpk@gmx.de>> wrote:
> > >  >
> > >  > On 10/22/24 14:00, Simon Glass wrote:
> > >  > > Add a simple app to use for testing. This is intended to do what=
ever it
> > >  > > needs to for testing purposes. For now it just prints a message =
and
> > >  > > exits boot services.
> > >  > >
> > >  > > There was a considerable amount of discussion about whether it i=
s OK to
> > >  > > call exit-boot-services and then return to U-Boot. This is not n=
ormally
> > >  > > done in a real application, since exit-boot-services is used to
> > >  > > completely disconnect from U-Boot. However, since this is a test=
, we
> > >  > > need to check the results of running the app, so returning is
> > > necessary.
> > >  > > It works correctly and it provides a nice model of how to test t=
he EFI
> > >  > > code in a simple way.
> > >  > >
> > >  > > Signed-off-by: Simon Glass <sjg@chromium.org <mailto:sjg@chromiu=
m.org>>
> > >  > > ---
> > >  > >
> > >  > > (no changes since v7)
> > >  > >
> > >  > > Changes in v7:
> > >  > > - Update commit message
> > >  > >
> > >  > >   lib/efi_loader/Kconfig   | 10 ++++++
> > >  > >   lib/efi_loader/Makefile  |  1 +
> > >  > >   lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++=
+++
> > > +++++
> > >  > >   3 files changed, 79 insertions(+)
> > >  > >   create mode 100644 lib/efi_loader/testapp.c
> > >  > >
> > >  > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > >  > > index 69b2c9360d8..6ced29da719 100644
> > >  > > --- a/lib/efi_loader/Kconfig
> > >  > > +++ b/lib/efi_loader/Kconfig
> > >  > > @@ -565,6 +565,16 @@ config BOOTEFI_HELLO_COMPILE
> > >  > >         No additional space will be required in the resulting U-
> > > Boot binary
> > >  > >         when this option is enabled.
> > >  > >
> > >  > > +config BOOTEFI_TESTAPP_COMPILE
> > >  > > +     bool "Compile an EFI test app for testing"
> > >  > > +     default y
> > >  > > +     help
> > >  > > +       This compiles an app designed for testing. It is packed
> > > into an image
> > >  > > +       by the test.py testing frame in the setup_efi_image() fu=
nction.
> > >  > > +
> > >  > > +       No additional space will be required in the resulting U-
> > > Boot binary
> > >  > > +       when this option is enabled.
> > >  > > +
> > >  > >   endif
> > >  > >
> > >  > >   source "lib/efi/Kconfig"
> > >  > > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > >  > > index 00d18966f9e..87131ab911d 100644
> > >  > > --- a/lib/efi_loader/Makefile
> > >  > > +++ b/lib/efi_loader/Makefile
> > >  > > @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D init=
rddump
> > >  > >   ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
> > >  > >   apps-y +=3D dtbdump
> > >  > >   endif
> > >  > > +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) +=3D testapp
> > >  > >
> > >  > >   obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
> > >  > >   obj-$(CONFIG_EFI_BOOTMGR) +=3D efi_bootmgr.o
> > >  > > diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
> > >  > > new file mode 100644
> > >  > > index 00000000000..feb444c92e9
> > >  > > --- /dev/null
> > >  > > +++ b/lib/efi_loader/testapp.c
> > >  > > @@ -0,0 +1,68 @@
> > >  > > +// SPDX-License-Identifier: GPL-2.0+
> > >  >
> > >  > This is not a valid SPDX identifier. Please, use GPL-2.0-or-later.
> > >  >
> > >  > > +/*
> > >  > > + * Hello world EFI application
> > >  > > + *
> > >  > > + * Copyright 2024 Google LLC
> > >  > > + * Written by Simon Glass <sjg@chromium.org <mailto:sjg@chromiu=
m.org>>
> > >  > > + *
> > >  > > + * This test program is used to test the invocation of an EFI
> > > application.
> > >  > > + * It writes a few messages to the console and then exits boot
> > > services
> > >  > > + */
> > >  > > +
> > >  > > +#include <efi_api.h>
> > >  > > +
> > >  > > +static const efi_guid_t loaded_image_guid =3D
> > > EFI_LOADED_IMAGE_PROTOCOL_GUID;
> > >  > > +
> > >  > > +static struct efi_system_table *systable;
> > >  > > +static struct efi_boot_services *boottime;
> > >  > > +static struct efi_simple_text_output_protocol *con_out;
> > >  > > +
> > >  > > +/**
> > >  > > + * efi_main() - entry point of the EFI application.
> > >  > > + *
> > >  > > + * @handle:  handle of the loaded image
> > >  > > + * @systab:  system table
> > >  > > + * Return:   status code
> > >  > > + */
> > >  > > +efi_status_t EFIAPI efi_main(efi_handle_t handle,
> > >  > > +                          struct efi_system_table *systab)
> > >  > > +{
> > >  > > +     struct efi_loaded_image *loaded_image;
> > >  > > +     efi_status_t ret;
> > >  > > +     efi_uintn_t map_size;
> > >  > > +     efi_uintn_t map_key;
> > >  > > +     efi_uintn_t desc_size;
> > >  > > +     u32 desc_version;
> > >  > > +
> > >  > > +     systable =3D systab;
> > >  > > +     boottime =3D systable->boottime;
> > >  > > +     con_out =3D systable->con_out;
> > >  > > +
> > >  > > +     /* Get the loaded image protocol */
> > >  > > +     ret =3D boottime->open_protocol(handle, &loaded_image_guid,
> > >  > > +                                   (void **)&loaded_image, NULL=
, NULL,
> > >  > > +                                   EFI_OPEN_PROTOCOL_GET_PROTOC=
OL);
> > >  > > +     if (ret !=3D EFI_SUCCESS) {
> > >  > > +             con_out->output_string
> > >  > > +                     (con_out, u"Cannot open loaded image
> > > protocol\r\n");
> > >  > > +             goto out;
> > >  > > +     }
> > >  > > +
> > >  > > +     /* UEFI requires CR LF */
> > >  > > +     con_out->output_string(con_out, u"U-Boot test app for
> > > EFI_LOADER\r\n");
> > >  > > +
> > >  > > +out:
> > >  > > +     map_size =3D 0;
> > >  > > +     ret =3D boottime->get_memory_map(&map_size, NULL, &map_key,
> > > &desc_size,
> > >  > > +                                    &desc_version);
> > >  > > +     con_out->output_string(con_out, u"Exiting boot sevices\n");
> > >  >
> > >  > %s/sevices/services/g
> > >  >
> > >  > > +
> > >  > > +     /* exit boot services so that this part of U-Boot can be
> > > tested */
> > >  > > +     boottime->exit_boot_services(handle, map_key);
> > >  > > +
> > >  > > +     /* now exit for real */
> > >  > > +     ret =3D boottime->exit(handle, ret, 0, NULL);
> > >  >
> > >  > As written before boot services are not available after
> > >  > ExitBootServices(). Please, call the ResetSystem() service.
> > >
> > > I already explained this. If I call reset then U-Boot exits and the
> > > console output cannot be checked by the C test. If I tell sandbox's
> > > reset-driver to ignore the reset request, then it also doesn't come b=
ack
> > > to the test.
> > >
> > >  >
> > >  >
> > >  > > +
> > >  > > +     /* We should never arrive here */
> > >  > > +     return ret;
> > >  >
> > >  > After ExitBootServices() you must not return.
> > >  >
> > >  > You can just do an endless loop if ResetSystem() fails:
> > >  >
> > >  > for (;;);
> > >
> > > No, because I need to check the output of the app. Please can you try=
 to
> > > run this test so you can see what it is doing?
> >
> > The Python framework lets you check the output whether you are rebooting
> > or not.
>=20
> Yes, I complained about catching reboots at the time, but it was
> submitted against my wishes. It is not a good design to create a
> problem in a test and then work around it later. It is easier to just
> return, rather than try to catch a reset in the Python test. For one
> thing, it makes using gdb much easier to have the test be
> self-contained.

And sometimes a test needs to restart the actual system for the test.
This sounds like another case of that, and not some arbitrary bad design
restart.

To phrase that another way, you're trying to introduce workarounds in
the code to avoid having to make the test work like a real system. I do
not think that's a good idea for a test.

> > The test seems not to build on anything but sandbox. We should be able
> > to test the boot methods on QEMU systems.
>=20
> Most tests run only on sandbox. You are welcome to extend the tests to
> cover more architectures. However I believe the most important thing
> is to test the code itself.

We also need to write things in such a way that we don't have to start
over from scratch when testing on other emulation platforms. It's true
that it's unlikely anyone will run the full cycle of booting various off
the shelf distributions and architectures and boot media for every
change. But I've got ~2 hours between assembling a pull request and
looking at the build results and anything I can throw at a host and come
back to in that time I'll do every time. Things that are automated but
marginally longer I'll do with every tagged release.

> > In efi_exit_boot_services() we
> >
> > * call dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL)
> > * call bootm_disable_interrupts()
> > * call board_quiesce_devices()
> > * disable all EFI timers
> > * disable EFI notification
> >
> > What do you expect U-Boot to do after all of this? You cannot reasonably
> > do any follow on test without rebooting.
>=20
> OK, well we can always add more code later as needed. So far, this
> seems to pass CI without problems.

What EFI-based tests do you run on sandbox after this, without resetting
the system? That would perhaps help clarify the point.

--=20
Tom

--4l0K0IeSHvuUYx0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchEXUACgkQFHw5/5Y0
tyylogv9E+HVfsSiThT0+Gs4ku0DXbuMidRk4QGxTWerTQsZzweXGd4yUeQmIFoF
ZHREruyMd7zBWSeN9eD52Wlp2j6LhuSVGCBlZfdaqPkoxK+vl7BhAxyylZ+g+5RJ
dFtPLGA82qYD9i1iqfESo/zjbzR/VSr9R1M8e72g/cY80SpwzOpyy4At0Z/GCPDY
/AjoRj9DLklZQL2XrF8yYKyKPdrYyGmDmaS3n7cDQXbiPbYkrZUGQpVYFA/T7Xuv
444xUSkj/TI/u7vglMJn/j3S4Z/EqjkRK4SJ0U/L0KWFuhD1iIVUtLKUIgqwavXz
JFAw6Lg6GByqKb5zrbh0mejDx/BNT74Hs/OVhDSDxCXwnwS/Emzb/CWIjq0RoiZT
FEuqIj8xWTWN1zLuH8mr1BALEkYG6IRG96Nlx9VfJwNEPA9dogaHUU6xko9MP3g5
dM3i6Se/Gwz1HbOUpxYQPRLnV1I43Hd02PiWJaYabJaQuUs5jH+42mW8PjZeZ4Fo
+0OvM8z9
=ppc4
-----END PGP SIGNATURE-----

--4l0K0IeSHvuUYx0o--
