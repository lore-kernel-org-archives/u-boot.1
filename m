Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05764D5CCB8
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 15:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47CEC88FAA;
	Wed, 30 Oct 2024 16:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kPc1cKRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F00EE88FCB; Wed, 30 Oct 2024 16:02:29 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B4EE88F27
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 16:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b1511697a5so502507285a.2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730300546; x=1730905346; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c5jO02WTBkZbua+hQQeOHdhINLqdcPrjk2L7IFJ/VTM=;
 b=kPc1cKRc1EhuYLmyJydcYxf6hv3E2/8rrd7/6E+Uw4xYA1PP+TEeZC6uSRUEMKpmXQ
 LeQxQ8hy1weaIjLf2tLMZdpvb1g7HCQ6XWDh0rWbrKhZzacWGnWnFtulea3PJHkYczgW
 eIQ4xGVErroazQjoMh3XACV/X3e07+YTQNbo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730300546; x=1730905346;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c5jO02WTBkZbua+hQQeOHdhINLqdcPrjk2L7IFJ/VTM=;
 b=bonPrlNU3aarV8ERBqiXLLklZyBHJkUrl0YOGIEV5OEC1AAMrFBJam4h8s0pmCQM3n
 wOYiBruF1XsCmkpFlUpE1x1+xJTbAX/uqnIO2+OwvO0BPlTVlMhofISpTzfUOUF4cvh6
 rDquyWrl2aRirprHFAYm86HU/fKu/0kvxZVAwvGbAMlUksdHl1FRHFhPnit5PLIeuBkK
 wU490MNmHq1gJwd6kCAJokWKqcXLYLGtQEKN5cWMQ1lJLdMeWd6O3TCYfiQHuyKdOe9c
 wfLYVw1bSx3Me9g/jOsKOtVW/QZMzWepMfeN7urg+WNHoMc0/lQck7RqraRNLwH/z2o8
 sKWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiwTS8b2LKwK8DMofRcc/GSOC8kI7nLNBEpJl6hAn1SkMR6yJj71htjZ+L1fSbTw5dkcKt+4U=@lists.denx.de
X-Gm-Message-State: AOJu0Yyfxy+8RvSRPlMHbmGMVplk+POHgIUHblegcDJ3IzeDu4nh9cWf
 loa6+vfXyzBarsIf+AoJMJZqswemzyRBogrrNbuc1Gr9o2XZemt7eMeo4t3xzjk=
X-Google-Smtp-Source: AGHT+IGD1dv8yA5bJlvz21w/kPq+7B6M0Pmhb8cBVOCiCP38VFkyvKBw645qwOfVRlcLEM3nag+QAg==
X-Received: by 2002:a05:620a:1913:b0:7b1:7f5b:72c7 with SMTP id
 af79cd13be357-7b193ed48abmr2191201185a.1.1730300546027; 
 Wed, 30 Oct 2024 08:02:26 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d343e34sm515650485a.100.2024.10.30.08.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:02:25 -0700 (PDT)
Date: Wed, 30 Oct 2024 09:02:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v8 2/8] efi_loader: Add a test app
Message-ID: <20241030150222.GL2558755@bill-the-cat>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-3-sjg@chromium.org>
 <9f322139-ad6d-494d-879b-eab3211b874b@gmx.de>
 <CAFLszTgHvUo+0g+SBhC=Xbd_aFxdP_DF=wg_G3ZRTRP-k-2qVg@mail.gmail.com>
 <adacb624-28a8-41a0-a22b-19d2b9d3a5b1@gmx.de>
 <CAFLszThgu+jsDMDGJdESP+UOTRRGJ0ORN-xeDCkOYY7xPJq7-A@mail.gmail.com>
 <20241029164645.GF4959@bill-the-cat>
 <CAFLszThSAcQnnoyhTyd68m4LsO+W+Se0c7DmP9++Nx76zHzijQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X+TzLU6xNu5xlVPX"
Content-Disposition: inline
In-Reply-To: <CAFLszThSAcQnnoyhTyd68m4LsO+W+Se0c7DmP9++Nx76zHzijQ@mail.gmail.com>
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


--X+TzLU6xNu5xlVPX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 08:41:27AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 29 Oct 2024 at 17:46, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 29, 2024 at 04:46:16PM +0100, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Mon, 28 Oct 2024 at 19:43, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
> > > >
> > > > On 10/28/24 18:00, Simon Glass wrote:
> > > > > Hi Heinrich,
> > > > >
> > > > > On Mon, 28 Oct 2024 at 07:11, Heinrich Schuchardt <xypron.glpk@gm=
x.de
> > > > > <mailto:xypron.glpk@gmx.de>> wrote:
> > > > >  >
> > > > >  > On 10/22/24 14:00, Simon Glass wrote:
> > > > >  > > Add a simple app to use for testing. This is intended to do =
whatever it
> > > > >  > > needs to for testing purposes. For now it just prints a mess=
age and
> > > > >  > > exits boot services.
> > > > >  > >
> > > > >  > > There was a considerable amount of discussion about whether =
it is OK to
> > > > >  > > call exit-boot-services and then return to U-Boot. This is n=
ot normally
> > > > >  > > done in a real application, since exit-boot-services is used=
 to
> > > > >  > > completely disconnect from U-Boot. However, since this is a =
test, we
> > > > >  > > need to check the results of running the app, so returning is
> > > > > necessary.
> > > > >  > > It works correctly and it provides a nice model of how to te=
st the EFI
> > > > >  > > code in a simple way.
> > > > >  > >
> > > > >  > > Signed-off-by: Simon Glass <sjg@chromium.org <mailto:sjg@chr=
omium.org>>
> > > > >  > > ---
> > > > >  > >
> > > > >  > > (no changes since v7)
> > > > >  > >
> > > > >  > > Changes in v7:
> > > > >  > > - Update commit message
> > > > >  > >
> > > > >  > >   lib/efi_loader/Kconfig   | 10 ++++++
> > > > >  > >   lib/efi_loader/Makefile  |  1 +
> > > > >  > >   lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++=
+++++++
> > > > > +++++
> > > > >  > >   3 files changed, 79 insertions(+)
> > > > >  > >   create mode 100644 lib/efi_loader/testapp.c
> > > > >  > >
> > > > >  > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > >  > > index 69b2c9360d8..6ced29da719 100644
> > > > >  > > --- a/lib/efi_loader/Kconfig
> > > > >  > > +++ b/lib/efi_loader/Kconfig
> > > > >  > > @@ -565,6 +565,16 @@ config BOOTEFI_HELLO_COMPILE
> > > > >  > >         No additional space will be required in the resultin=
g U-
> > > > > Boot binary
> > > > >  > >         when this option is enabled.
> > > > >  > >
> > > > >  > > +config BOOTEFI_TESTAPP_COMPILE
> > > > >  > > +     bool "Compile an EFI test app for testing"
> > > > >  > > +     default y
> > > > >  > > +     help
> > > > >  > > +       This compiles an app designed for testing. It is pac=
ked
> > > > > into an image
> > > > >  > > +       by the test.py testing frame in the setup_efi_image(=
) function.
> > > > >  > > +
> > > > >  > > +       No additional space will be required in the resultin=
g U-
> > > > > Boot binary
> > > > >  > > +       when this option is enabled.
> > > > >  > > +
> > > > >  > >   endif
> > > > >  > >
> > > > >  > >   source "lib/efi/Kconfig"
> > > > >  > > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefi=
le
> > > > >  > > index 00d18966f9e..87131ab911d 100644
> > > > >  > > --- a/lib/efi_loader/Makefile
> > > > >  > > +++ b/lib/efi_loader/Makefile
> > > > >  > > @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D =
initrddump
> > > > >  > >   ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
> > > > >  > >   apps-y +=3D dtbdump
> > > > >  > >   endif
> > > > >  > > +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) +=3D testapp
> > > > >  > >
> > > > >  > >   obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
> > > > >  > >   obj-$(CONFIG_EFI_BOOTMGR) +=3D efi_bootmgr.o
> > > > >  > > diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testa=
pp.c
> > > > >  > > new file mode 100644
> > > > >  > > index 00000000000..feb444c92e9
> > > > >  > > --- /dev/null
> > > > >  > > +++ b/lib/efi_loader/testapp.c
> > > > >  > > @@ -0,0 +1,68 @@
> > > > >  > > +// SPDX-License-Identifier: GPL-2.0+
> > > > >  >
> > > > >  > This is not a valid SPDX identifier. Please, use GPL-2.0-or-la=
ter.
> > > > >  >
> > > > >  > > +/*
> > > > >  > > + * Hello world EFI application
> > > > >  > > + *
> > > > >  > > + * Copyright 2024 Google LLC
> > > > >  > > + * Written by Simon Glass <sjg@chromium.org <mailto:sjg@chr=
omium.org>>
> > > > >  > > + *
> > > > >  > > + * This test program is used to test the invocation of an E=
FI
> > > > > application.
> > > > >  > > + * It writes a few messages to the console and then exits b=
oot
> > > > > services
> > > > >  > > + */
> > > > >  > > +
> > > > >  > > +#include <efi_api.h>
> > > > >  > > +
> > > > >  > > +static const efi_guid_t loaded_image_guid =3D
> > > > > EFI_LOADED_IMAGE_PROTOCOL_GUID;
> > > > >  > > +
> > > > >  > > +static struct efi_system_table *systable;
> > > > >  > > +static struct efi_boot_services *boottime;
> > > > >  > > +static struct efi_simple_text_output_protocol *con_out;
> > > > >  > > +
> > > > >  > > +/**
> > > > >  > > + * efi_main() - entry point of the EFI application.
> > > > >  > > + *
> > > > >  > > + * @handle:  handle of the loaded image
> > > > >  > > + * @systab:  system table
> > > > >  > > + * Return:   status code
> > > > >  > > + */
> > > > >  > > +efi_status_t EFIAPI efi_main(efi_handle_t handle,
> > > > >  > > +                          struct efi_system_table *systab)
> > > > >  > > +{
> > > > >  > > +     struct efi_loaded_image *loaded_image;
> > > > >  > > +     efi_status_t ret;
> > > > >  > > +     efi_uintn_t map_size;
> > > > >  > > +     efi_uintn_t map_key;
> > > > >  > > +     efi_uintn_t desc_size;
> > > > >  > > +     u32 desc_version;
> > > > >  > > +
> > > > >  > > +     systable =3D systab;
> > > > >  > > +     boottime =3D systable->boottime;
> > > > >  > > +     con_out =3D systable->con_out;
> > > > >  > > +
> > > > >  > > +     /* Get the loaded image protocol */
> > > > >  > > +     ret =3D boottime->open_protocol(handle, &loaded_image_=
guid,
> > > > >  > > +                                   (void **)&loaded_image, =
NULL, NULL,
> > > > >  > > +                                   EFI_OPEN_PROTOCOL_GET_PR=
OTOCOL);
> > > > >  > > +     if (ret !=3D EFI_SUCCESS) {
> > > > >  > > +             con_out->output_string
> > > > >  > > +                     (con_out, u"Cannot open loaded image
> > > > > protocol\r\n");
> > > > >  > > +             goto out;
> > > > >  > > +     }
> > > > >  > > +
> > > > >  > > +     /* UEFI requires CR LF */
> > > > >  > > +     con_out->output_string(con_out, u"U-Boot test app for
> > > > > EFI_LOADER\r\n");
> > > > >  > > +
> > > > >  > > +out:
> > > > >  > > +     map_size =3D 0;
> > > > >  > > +     ret =3D boottime->get_memory_map(&map_size, NULL, &map=
_key,
> > > > > &desc_size,
> > > > >  > > +                                    &desc_version);
> > > > >  > > +     con_out->output_string(con_out, u"Exiting boot sevices=
\n");
> > > > >  >
> > > > >  > %s/sevices/services/g
> > > > >  >
> > > > >  > > +
> > > > >  > > +     /* exit boot services so that this part of U-Boot can =
be
> > > > > tested */
> > > > >  > > +     boottime->exit_boot_services(handle, map_key);
> > > > >  > > +
> > > > >  > > +     /* now exit for real */
> > > > >  > > +     ret =3D boottime->exit(handle, ret, 0, NULL);
> > > > >  >
> > > > >  > As written before boot services are not available after
> > > > >  > ExitBootServices(). Please, call the ResetSystem() service.
> > > > >
> > > > > I already explained this. If I call reset then U-Boot exits and t=
he
> > > > > console output cannot be checked by the C test. If I tell sandbox=
's
> > > > > reset-driver to ignore the reset request, then it also doesn't co=
me back
> > > > > to the test.
> > > > >
> > > > >  >
> > > > >  >
> > > > >  > > +
> > > > >  > > +     /* We should never arrive here */
> > > > >  > > +     return ret;
> > > > >  >
> > > > >  > After ExitBootServices() you must not return.
> > > > >  >
> > > > >  > You can just do an endless loop if ResetSystem() fails:
> > > > >  >
> > > > >  > for (;;);
> > > > >
> > > > > No, because I need to check the output of the app. Please can you=
 try to
> > > > > run this test so you can see what it is doing?
> > > >
> > > > The Python framework lets you check the output whether you are rebo=
oting
> > > > or not.
> > >
> > > Yes, I complained about catching reboots at the time, but it was
> > > submitted against my wishes. It is not a good design to create a
> > > problem in a test and then work around it later. It is easier to just
> > > return, rather than try to catch a reset in the Python test. For one
> > > thing, it makes using gdb much easier to have the test be
> > > self-contained.
> >
> > And sometimes a test needs to restart the actual system for the test.
> > This sounds like another case of that, and not some arbitrary bad design
> > restart.
>=20
> Sorry, but I cannot tell the difference. We should not have tests
> which need to restart, except in extreme circumstances.

That's unfortunate then. Perhaps you'll just have to trust me that there
are in fact tests where it's only valid to restart the system and not
fake restart the system.

> > To phrase that another way, you're trying to introduce workarounds in
> > the code to avoid having to make the test work like a real system. I do
> > not think that's a good idea for a test.
>=20
> Which work-around are you referring to?

Everything you're doing here.

> I discussed this somewhat with Heinrich earlier. We didn't really
> resolve it, but I did point out that if we want to reset/reinit the
> EFI system within U-Boot (as we do with driver model, devicetree and
> some other things) we can implement that when it is needed.

That would be even more workaround.

> > > > The test seems not to build on anything but sandbox. We should be a=
ble
> > > > to test the boot methods on QEMU systems.
> > >
> > > Most tests run only on sandbox. You are welcome to extend the tests to
> > > cover more architectures. However I believe the most important thing
> > > is to test the code itself.
> >
> > We also need to write things in such a way that we don't have to start
> > over from scratch when testing on other emulation platforms. It's true
> > that it's unlikely anyone will run the full cycle of booting various off
> > the shelf distributions and architectures and boot media for every
> > change. But I've got ~2 hours between assembling a pull request and
> > looking at the build results and anything I can throw at a host and come
> > back to in that time I'll do every time. Things that are automated but
> > marginally longer I'll do with every tagged release.
>=20
> I'm not sure how best to attack this, even now. With the Labgrid
> integration (I am still hoping will land soon) I can boot into QEMU
> and perhaps into grub, but booting right into a distro is going to
> need ssh and networking (which is fine, it's just another step).
>=20
> Anyway, that is a bid sideways of your point. Sandbox tests are always
> going to be much easier to write than Python ones. They are faster to
> run, as well. We can't do things like 'assert_nextline()' with QEMU.
> Also I can't single step into QEMU with the debugger. Also with
> sandbox, it is possible to check the internal U-Boot-state, whereas
> with QEMU we have to print something on the console. So I believe that
> writing a QEMU test is an entirely different job from writing a
> sandbox test.

I'm not sure how this is at all relevant to the point here. If you make
the test application follow the UEFI spec this is no different from the
existing hello world test we have in most respects.

> There is something fundamental here which can be changed. Sandbox is
> really just better for testing U-Boot code, so long as we design the
> code properly for testing. Of course if we insist on not designing the
> code properly for testing, that erodes the advantage. But that would
> be the wrong direction.

To be frank, I haven't been able to run the whole sandbox test suite
locally in the last 5+ years if ever, and had to throw it in to docker,
and then just got tired of fighting it and only see it in CI.

> > > > In efi_exit_boot_services() we
> > > >
> > > > * call dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL)
> > > > * call bootm_disable_interrupts()
> > > > * call board_quiesce_devices()
> > > > * disable all EFI timers
> > > > * disable EFI notification
> > > >
> > > > What do you expect U-Boot to do after all of this? You cannot reaso=
nably
> > > > do any follow on test without rebooting.
> > >
> > > OK, well we can always add more code later as needed. So far, this
> > > seems to pass CI without problems.
> >
> > What EFI-based tests do you run on sandbox after this, without resetting
> > the system? That would perhaps help clarify the point.
>=20
> It depends on the ordering of things in CI. From what I can tell most
> (or all?) of them run after this test.

Well, you shouldn't and I think earlier Heinrich was saying that perhaps
we need to NULL out a few things more then.

> But if this does cause a problem with future tests that we add, we
> should be able to fix it easily enough. In fact it would be nice to be
> able to re-init EFI.

Sounds like a lot of work-around work just to avoid testing that we are
in fact exiting services and resetting like we should.

--=20
Tom

--X+TzLU6xNu5xlVPX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmciSnoACgkQFHw5/5Y0
tyyBuQwAsEwWLqVvZ0vPtYuz2HC6IVs6aP+C5VysPwoudT7mEZRwvTGIhvycf2z8
xGRXAHO+RRsbKjOY82AOkt/zWg4lOCNCvvlRccbQ1VAErkLd1MWHSAL5m0yu1xCU
YorWC6TFV3O7Qtvxy2O/wYJtoHXI/8VLjuXQQjA7Bd0D9Ka7sjqHH/uVXDA1Cg92
GcmmHoLnWKbs4RwNADXb+8gbdaJUUXJL32WQnTDRx/WqELIv+X9xoZikAPOOB5ws
LxGD9bC86y46kqUCfHHzbUaedYfi+kQp4J0Ewb2WAW4rbE01G4JHmpnkyuu/rMeI
3tGVK1aOkp78ub8/tNDBksQs/UK4wjABcb2w6RpPvarS0dHLuPC3gIA85i4Y11CF
LkTG/FlRctsOtetzU9ItMRFaIJ7oHHp57uqbtqPipfJWGi4cz1doF0B1TRuOEyqd
9NKKR7L/UBNbhmEMCBEQfVHsmV/qP60xqAm5trQR0seDbdXSMJbHdDG6rnPF7UNg
38Dk3GOd
=IXMK
-----END PGP SIGNATURE-----

--X+TzLU6xNu5xlVPX--
