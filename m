Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCBFD7495E
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 07:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEC6D891D2;
	Wed, 30 Oct 2024 08:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LLnhNAa1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB06D891E1; Wed, 30 Oct 2024 08:41:41 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0E70890AE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 08:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539fb49c64aso10409386e87.0
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 00:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730274099; x=1730878899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RH4uEwFYLkCBUecZpOgi75DNQ56wsrX3V0LO4y0tHPA=;
 b=LLnhNAa1ia/sPbzd+nRx5zrHC1Z1WYA5vjIoClkMtgqctD9zdBMCus3ivTfZNdTtxy
 gJbHUYOQG7YiHZwP8ZAvXukzhuiv+8K4BqmL+r2hxF+V6Lg0O6drCYIn4St5wL9AnDKG
 HjeSfuK30u7FnJunX6OI9Y1hmy+H6VAJ8NpJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730274099; x=1730878899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RH4uEwFYLkCBUecZpOgi75DNQ56wsrX3V0LO4y0tHPA=;
 b=Tj+L1zAQqx7Gm6zPfJWy6srpmjyq9SXKNjnwekR9uCkDQR9gzr1tAgWyJn99c3v/PR
 tZLqG+ZWN+U4TTh5N0PV2P1ak8Rlxyyhz0AhoJa09SyqZNo8ZPfhBIHrIX3Pgqg1hL5c
 ygBrjjIs3g9AI77saLitjWLPgQfd6VM+4P4rYF9//YNV0iAzvnhDe9RsfHj0cAJQ1qsq
 Bcan8v40sYWU9cMgRxmSTQLph8sMS0qAAnTai/KZuV0q06Q2W4ArOWhi9BIVhaBygBK2
 bzYjME1Vr7pAKnBR8H4uZQqG+ie32x4ta9JsrOmhVXyADOR3NMUytX8nBETYuGe3b9LC
 HmtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtZaszGRqDNs34ZZ6p9VzIxUraM8sMEALjoo7v7i+GCtv7y7l0VKq1ASd9Cdd1bymhtOIK964=@lists.denx.de
X-Gm-Message-State: AOJu0YyMF4GtEMWcqxEMzWLuDWTE5ApXnElpheSKLxHSfN/dy3froShH
 xXir/tvI8KBcIf6+4OGudvO5BI8gw8AgVDCdaeRGsaX1yjMWmethmyNqPobSzuVUnCuDXU9N3Fj
 LLFdWKW0QmY9si2J20qxWthJfTlRFQgyyT+Y5
X-Google-Smtp-Source: AGHT+IH5KVyTgVtTdbVgeX86mXqmRf3F/ifNtinK0ShwyomoBd0xDMeR+eLWpbxBoK5DG1qNQTcFxa+U9PJSDRKJ6ks=
X-Received: by 2002:a05:6512:3051:b0:52c:9ae0:beed with SMTP id
 2adb3069b0e04-53b34a35058mr10995777e87.52.1730274098610; Wed, 30 Oct 2024
 00:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-3-sjg@chromium.org>
 <9f322139-ad6d-494d-879b-eab3211b874b@gmx.de>
 <CAFLszTgHvUo+0g+SBhC=Xbd_aFxdP_DF=wg_G3ZRTRP-k-2qVg@mail.gmail.com>
 <adacb624-28a8-41a0-a22b-19d2b9d3a5b1@gmx.de>
 <CAFLszThgu+jsDMDGJdESP+UOTRRGJ0ORN-xeDCkOYY7xPJq7-A@mail.gmail.com>
 <20241029164645.GF4959@bill-the-cat>
In-Reply-To: <20241029164645.GF4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Oct 2024 08:41:27 +0100
Message-ID: <CAFLszThSAcQnnoyhTyd68m4LsO+W+Se0c7DmP9++Nx76zHzijQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/8] efi_loader: Add a test app
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Tue, 29 Oct 2024 at 17:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 29, 2024 at 04:46:16PM +0100, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 28 Oct 2024 at 19:43, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 10/28/24 18:00, Simon Glass wrote:
> > > > Hi Heinrich,
> > > >
> > > > On Mon, 28 Oct 2024 at 07:11, Heinrich Schuchardt <xypron.glpk@gmx.de
> > > > <mailto:xypron.glpk@gmx.de>> wrote:
> > > >  >
> > > >  > On 10/22/24 14:00, Simon Glass wrote:
> > > >  > > Add a simple app to use for testing. This is intended to do whatever it
> > > >  > > needs to for testing purposes. For now it just prints a message and
> > > >  > > exits boot services.
> > > >  > >
> > > >  > > There was a considerable amount of discussion about whether it is OK to
> > > >  > > call exit-boot-services and then return to U-Boot. This is not normally
> > > >  > > done in a real application, since exit-boot-services is used to
> > > >  > > completely disconnect from U-Boot. However, since this is a test, we
> > > >  > > need to check the results of running the app, so returning is
> > > > necessary.
> > > >  > > It works correctly and it provides a nice model of how to test the EFI
> > > >  > > code in a simple way.
> > > >  > >
> > > >  > > Signed-off-by: Simon Glass <sjg@chromium.org <mailto:sjg@chromium.org>>
> > > >  > > ---
> > > >  > >
> > > >  > > (no changes since v7)
> > > >  > >
> > > >  > > Changes in v7:
> > > >  > > - Update commit message
> > > >  > >
> > > >  > >   lib/efi_loader/Kconfig   | 10 ++++++
> > > >  > >   lib/efi_loader/Makefile  |  1 +
> > > >  > >   lib/efi_loader/testapp.c | 68 +++++++++++++++++++++++++++++++++++
> > > > +++++
> > > >  > >   3 files changed, 79 insertions(+)
> > > >  > >   create mode 100644 lib/efi_loader/testapp.c
> > > >  > >
> > > >  > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > >  > > index 69b2c9360d8..6ced29da719 100644
> > > >  > > --- a/lib/efi_loader/Kconfig
> > > >  > > +++ b/lib/efi_loader/Kconfig
> > > >  > > @@ -565,6 +565,16 @@ config BOOTEFI_HELLO_COMPILE
> > > >  > >         No additional space will be required in the resulting U-
> > > > Boot binary
> > > >  > >         when this option is enabled.
> > > >  > >
> > > >  > > +config BOOTEFI_TESTAPP_COMPILE
> > > >  > > +     bool "Compile an EFI test app for testing"
> > > >  > > +     default y
> > > >  > > +     help
> > > >  > > +       This compiles an app designed for testing. It is packed
> > > > into an image
> > > >  > > +       by the test.py testing frame in the setup_efi_image() function.
> > > >  > > +
> > > >  > > +       No additional space will be required in the resulting U-
> > > > Boot binary
> > > >  > > +       when this option is enabled.
> > > >  > > +
> > > >  > >   endif
> > > >  > >
> > > >  > >   source "lib/efi/Kconfig"
> > > >  > > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > > >  > > index 00d18966f9e..87131ab911d 100644
> > > >  > > --- a/lib/efi_loader/Makefile
> > > >  > > +++ b/lib/efi_loader/Makefile
> > > >  > > @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) += initrddump
> > > >  > >   ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
> > > >  > >   apps-y += dtbdump
> > > >  > >   endif
> > > >  > > +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) += testapp
> > > >  > >
> > > >  > >   obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
> > > >  > >   obj-$(CONFIG_EFI_BOOTMGR) += efi_bootmgr.o
> > > >  > > diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
> > > >  > > new file mode 100644
> > > >  > > index 00000000000..feb444c92e9
> > > >  > > --- /dev/null
> > > >  > > +++ b/lib/efi_loader/testapp.c
> > > >  > > @@ -0,0 +1,68 @@
> > > >  > > +// SPDX-License-Identifier: GPL-2.0+
> > > >  >
> > > >  > This is not a valid SPDX identifier. Please, use GPL-2.0-or-later.
> > > >  >
> > > >  > > +/*
> > > >  > > + * Hello world EFI application
> > > >  > > + *
> > > >  > > + * Copyright 2024 Google LLC
> > > >  > > + * Written by Simon Glass <sjg@chromium.org <mailto:sjg@chromium.org>>
> > > >  > > + *
> > > >  > > + * This test program is used to test the invocation of an EFI
> > > > application.
> > > >  > > + * It writes a few messages to the console and then exits boot
> > > > services
> > > >  > > + */
> > > >  > > +
> > > >  > > +#include <efi_api.h>
> > > >  > > +
> > > >  > > +static const efi_guid_t loaded_image_guid =
> > > > EFI_LOADED_IMAGE_PROTOCOL_GUID;
> > > >  > > +
> > > >  > > +static struct efi_system_table *systable;
> > > >  > > +static struct efi_boot_services *boottime;
> > > >  > > +static struct efi_simple_text_output_protocol *con_out;
> > > >  > > +
> > > >  > > +/**
> > > >  > > + * efi_main() - entry point of the EFI application.
> > > >  > > + *
> > > >  > > + * @handle:  handle of the loaded image
> > > >  > > + * @systab:  system table
> > > >  > > + * Return:   status code
> > > >  > > + */
> > > >  > > +efi_status_t EFIAPI efi_main(efi_handle_t handle,
> > > >  > > +                          struct efi_system_table *systab)
> > > >  > > +{
> > > >  > > +     struct efi_loaded_image *loaded_image;
> > > >  > > +     efi_status_t ret;
> > > >  > > +     efi_uintn_t map_size;
> > > >  > > +     efi_uintn_t map_key;
> > > >  > > +     efi_uintn_t desc_size;
> > > >  > > +     u32 desc_version;
> > > >  > > +
> > > >  > > +     systable = systab;
> > > >  > > +     boottime = systable->boottime;
> > > >  > > +     con_out = systable->con_out;
> > > >  > > +
> > > >  > > +     /* Get the loaded image protocol */
> > > >  > > +     ret = boottime->open_protocol(handle, &loaded_image_guid,
> > > >  > > +                                   (void **)&loaded_image, NULL, NULL,
> > > >  > > +                                   EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> > > >  > > +     if (ret != EFI_SUCCESS) {
> > > >  > > +             con_out->output_string
> > > >  > > +                     (con_out, u"Cannot open loaded image
> > > > protocol\r\n");
> > > >  > > +             goto out;
> > > >  > > +     }
> > > >  > > +
> > > >  > > +     /* UEFI requires CR LF */
> > > >  > > +     con_out->output_string(con_out, u"U-Boot test app for
> > > > EFI_LOADER\r\n");
> > > >  > > +
> > > >  > > +out:
> > > >  > > +     map_size = 0;
> > > >  > > +     ret = boottime->get_memory_map(&map_size, NULL, &map_key,
> > > > &desc_size,
> > > >  > > +                                    &desc_version);
> > > >  > > +     con_out->output_string(con_out, u"Exiting boot sevices\n");
> > > >  >
> > > >  > %s/sevices/services/g
> > > >  >
> > > >  > > +
> > > >  > > +     /* exit boot services so that this part of U-Boot can be
> > > > tested */
> > > >  > > +     boottime->exit_boot_services(handle, map_key);
> > > >  > > +
> > > >  > > +     /* now exit for real */
> > > >  > > +     ret = boottime->exit(handle, ret, 0, NULL);
> > > >  >
> > > >  > As written before boot services are not available after
> > > >  > ExitBootServices(). Please, call the ResetSystem() service.
> > > >
> > > > I already explained this. If I call reset then U-Boot exits and the
> > > > console output cannot be checked by the C test. If I tell sandbox's
> > > > reset-driver to ignore the reset request, then it also doesn't come back
> > > > to the test.
> > > >
> > > >  >
> > > >  >
> > > >  > > +
> > > >  > > +     /* We should never arrive here */
> > > >  > > +     return ret;
> > > >  >
> > > >  > After ExitBootServices() you must not return.
> > > >  >
> > > >  > You can just do an endless loop if ResetSystem() fails:
> > > >  >
> > > >  > for (;;);
> > > >
> > > > No, because I need to check the output of the app. Please can you try to
> > > > run this test so you can see what it is doing?
> > >
> > > The Python framework lets you check the output whether you are rebooting
> > > or not.
> >
> > Yes, I complained about catching reboots at the time, but it was
> > submitted against my wishes. It is not a good design to create a
> > problem in a test and then work around it later. It is easier to just
> > return, rather than try to catch a reset in the Python test. For one
> > thing, it makes using gdb much easier to have the test be
> > self-contained.
>
> And sometimes a test needs to restart the actual system for the test.
> This sounds like another case of that, and not some arbitrary bad design
> restart.

Sorry, but I cannot tell the difference. We should not have tests
which need to restart, except in extreme circumstances.

>
> To phrase that another way, you're trying to introduce workarounds in
> the code to avoid having to make the test work like a real system. I do
> not think that's a good idea for a test.

Which work-around are you referring to?

I discussed this somewhat with Heinrich earlier. We didn't really
resolve it, but I did point out that if we want to reset/reinit the
EFI system within U-Boot (as we do with driver model, devicetree and
some other things) we can implement that when it is needed.

>
> > > The test seems not to build on anything but sandbox. We should be able
> > > to test the boot methods on QEMU systems.
> >
> > Most tests run only on sandbox. You are welcome to extend the tests to
> > cover more architectures. However I believe the most important thing
> > is to test the code itself.
>
> We also need to write things in such a way that we don't have to start
> over from scratch when testing on other emulation platforms. It's true
> that it's unlikely anyone will run the full cycle of booting various off
> the shelf distributions and architectures and boot media for every
> change. But I've got ~2 hours between assembling a pull request and
> looking at the build results and anything I can throw at a host and come
> back to in that time I'll do every time. Things that are automated but
> marginally longer I'll do with every tagged release.

I'm not sure how best to attack this, even now. With the Labgrid
integration (I am still hoping will land soon) I can boot into QEMU
and perhaps into grub, but booting right into a distro is going to
need ssh and networking (which is fine, it's just another step).

Anyway, that is a bid sideways of your point. Sandbox tests are always
going to be much easier to write than Python ones. They are faster to
run, as well. We can't do things like 'assert_nextline()' with QEMU.
Also I can't single step into QEMU with the debugger. Also with
sandbox, it is possible to check the internal U-Boot-state, whereas
with QEMU we have to print something on the console. So I believe that
writing a QEMU test is an entirely different job from writing a
sandbox test.

There is something fundamental here which can be changed. Sandbox is
really just better for testing U-Boot code, so long as we design the
code properly for testing. Of course if we insist on not designing the
code properly for testing, that erodes the advantage. But that would
be the wrong direction.

>
> > > In efi_exit_boot_services() we
> > >
> > > * call dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL)
> > > * call bootm_disable_interrupts()
> > > * call board_quiesce_devices()
> > > * disable all EFI timers
> > > * disable EFI notification
> > >
> > > What do you expect U-Boot to do after all of this? You cannot reasonably
> > > do any follow on test without rebooting.
> >
> > OK, well we can always add more code later as needed. So far, this
> > seems to pass CI without problems.
>
> What EFI-based tests do you run on sandbox after this, without resetting
> the system? That would perhaps help clarify the point.

It depends on the ordering of things in CI. From what I can tell most
(or all?) of them run after this test.

But if this does cause a problem with future tests that we add, we
should be able to fix it easily enough. In fact it would be nice to be
able to re-init EFI.

Regards,
Simon
