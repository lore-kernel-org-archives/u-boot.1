Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D01C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 15:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79D0B8081A;
	Thu,  1 May 2025 17:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WR9KiAp2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 198D5809A5; Thu,  1 May 2025 17:47:02 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58FC18070C
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 17:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adriano.cordova@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 45D083F13F
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746114416;
 bh=VQcmZOrCZ9xcBkrPpnDsKTMkkXFlrrOkCwYywkF9uYs=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=WR9KiAp2NBzda81Jrc+IgC35uGm4Cj1Ykrz3utFilfwKSHF7PhfWeImmyoyypzcfa
 Vsq6VFxoqJtKdc62WvlF2x7jrOqihHywDjXES77iVWsjhPHxZ2ahUSerMkh0v0FfGh
 KlUpyc3EI0NEXskUHjcJh3Vy7YV/0m/pQFZpE/RKClSBHp6Edka2LXNE1MGLaDi94/
 ixUdFhwoUacmJWdvmol7PVQEW48a87lbXA2scUv1i+THaDzlBMD1LRpK4yP/izSh4+
 Jm/NCALHmNHZGpnu2LXKNRrimdCZElGwN42lKwKEZy7UsrSvhdIJ1dZLySdIiYs5pQ
 zgkgLaXCgnO0Q==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf327e9a2so7754565e9.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 08:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746114416; x=1746719216;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VQcmZOrCZ9xcBkrPpnDsKTMkkXFlrrOkCwYywkF9uYs=;
 b=bPdYVeD/AN8mMrLHNlynDUQqCobsavG3OT7SDNQ5pK9yKBMzlE+LRYN5CRu22qgT7E
 ifk9LMTrROJR4aTIKEHiQy9869TBxhJllZPQuSHTnhfzR9aTO8iqg+5Y2Yf+JAjJykor
 30t6TJ3UHw+NZ3m83YzS7h1hZnpNm9zxaGISYrYrJ7NZXkSr5yZQ4EarQIsCRKBomyZB
 gYqZk/WOukQbCew/eJFgXiUsb43iH463uHeVHgDEtLCCtsQ82sbZgL1j5i0FncvUFzi9
 wJmTVz+a1Dd48iQom7VyfSmZ50D3KtK1Zw+X81xOpKymJBjT2W+XvSn69f8D1MRNK2sL
 pV9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV70viOXGmMF6N+UihBEQJ/YDY/mx1ebns8FYBOnPV8s5dSBb4AijuRFqJYqGkjmzDn7+w/HEs=@lists.denx.de
X-Gm-Message-State: AOJu0YzNfmvbNgqnrGYzYlYfHm2Mwi3vBqsQFgLcXpJJojCbheQQxYKf
 hTo2/fkszKuJgV2fhyUqacn4A5yygqi+F0CsoIGc19xA5UKRxld2AEzt/FzIpGtUcFBm3f84wwP
 Nz/Z8nRW5kO5zif2fPxrxTJYQ2ytyw5r1DOa5zpxr02DUqX3gjdtJNJjrSCSnTwTADjrFJ/igUz
 DgkyYUsu4t6nrUadHs+v1fz8uNJnEnhjsPcUq12iS+6Q==
X-Gm-Gg: ASbGncsLNHVEOAlI8ZztnHEL2bM9TGtEbSKKICgPBDqR5+FT//Aom7g2OxWERyNIxzw
 M6xpOXVbPmBNBBgsYxPbHfYO5T25K1W/HmEVXLjB7C8KTU3zNRLa6Xy7U21aB9tYCpGp8
X-Received: by 2002:a05:600c:1e87:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-441b1f33b69mr68174945e9.13.1746114415753; 
 Thu, 01 May 2025 08:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH65uDL78DhTcwPNNV1L8XRmXaBMrSVwhkwE4FM6GIwAAqLjcCaA7vESBTBCsCsPCDtjBAsc6dSAJdZDX73PD8=
X-Received: by 2002:a05:600c:1e87:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-441b1f33b69mr68174735e9.13.1746114415446; Thu, 01 May 2025
 08:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250501011514.2209452-1-adriano.cordova@canonical.com>
 <20250501011514.2209452-2-adriano.cordova@canonical.com>
 <4bbbb9dd-bbdb-4b57-9eb6-211e483915d5@gmx.de>
In-Reply-To: <4bbbb9dd-bbdb-4b57-9eb6-211e483915d5@gmx.de>
From: Adriano Cordova Fedeli <adriano.cordova@canonical.com>
Date: Thu, 1 May 2025 11:47:35 -0400
X-Gm-Features: ATxdqUFhH5p0YC4XTS3Zi2MB_i3V8vla_yMi_ByQmFOn5_oDbZjZt160e2K-BZk
Message-ID: <CAFQa3MJQ=RvqMr0rFrV6y9MY8SMpV4sf_Uo3SnEEWbLzaqiweA@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: bootbin: split initrd registration and
 installation
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Adriano Cordova <adrianox@gmail.com>, ilias.apalodimas@linaro.org,
 sjg@chromium.org, 
 trini@konsulko.com, o451686892@gmail.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich,

Calling efi_initrd_register to both save the initrd device path and install
the initrd LF2 protocol complicates error handling. efi_bootmgr also calls
efi_initrd_register, but many functions are called between that and
do_bootefi_exec. If any fail, we should uninstall the protocol. The same
issue exists in efi_bootbin.

Delaying efi_initrd_register would require passing the initrd down the call
chain, e.g. to efi_run_image in efi_bootbin and passing it from
try_load_entry in efi_bootmgr. I think this should be avoided.

Instead, we can install the protocol in do_bootefi_exec=E2=80=94a shared po=
int of
efi_bootmgr and efi_bootbin=E2=80=94and set the initrd device paths early, =
avoiding
the need to pass them. efi_initrd_dp could even be set once in
try_load_entry using BootCurrent, instead of retrieving the initrd each tim=
e
the LF2 protocol is used.

Best,
Adriano

On Thu, 1 May 2025 at 03:15, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote=
:

> On 5/1/25 03:15, Adriano Cordova wrote:
> > Current support for initrd in EFI booting has two flaws:
> >
> > 1. Installs a NULL initrd via LoadFile2 protocol if `efi_binary_run_dp`
> does
> >     not provide an initrd. In this case, a LoadFile2 should not be
> installed
> >     at all.
> > 2. Initrd is not properly uninstalled if booting fails at some point
> between
> >     initrd installation and the call to `do_bootefi_exec`. This affects
> both
> >     booting via `efi_bootbin` and via `efi_bootmgr`.
> >
> > This commit splits the process of setting an initrd into two steps:
> >
> > First, `efi_initrd_set_from_mem` creates a memory-backed device path fo=
r
> the
> > initrd. (This step is not necessary when using `efi_bootmgr`, and for
> now is
> > only used when booting FIT images, but the `bootefi` command could now =
be
> > expanded to receive an initrd argument.)
> >
> > Second, `efi_initrd_install` creates an initrd handle and installs the
> > LoadFile2 protocol exposing the initrd. This is needed both when bootin=
g
> with
> > `efi_bootbin` and with `efi_bootmgr`, so it is called in
> `do_bootefi_exec`,
> > which is the first common point between the two bootflows.
> >
> > Also, as `do_bootefi_exec` is the only place where `efi_initrd_install`
> is
> > called, the cleanup function `efi_initrd_uninstall` can be called befor=
e
> > exiting `do_bootefi_exec` instead of using the event
> > `efi_guid_event_group_return_to_efibootmgr`. (This also makes more sens=
e
> as
> > now initrd is also used by `efi_bootbin`.)
> >
> > Fixes: 36835a9105c ("efi_loader: binary_run: register an initrd")
> > Reported-by: Weizhao Ouyang <o451686892@gmail.com>
> > Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > ---
> >   include/efi_loader.h             |  8 ++-
> >   lib/efi_loader/efi_bootbin.c     | 14 +++---
> >   lib/efi_loader/efi_bootmgr.c     |  7 ---
> >   lib/efi_loader/efi_helper.c      | 11 +++++
> >   lib/efi_loader/efi_load_initrd.c | 84 +++++++++++++++++--------------=
-
> >   5 files changed, 68 insertions(+), 56 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 144b749278a..0a3ca799287 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -597,6 +597,12 @@ efi_status_t efi_env_set_load_options(efi_handle_t
> handle, const char *env_var,
> >   void *efi_get_configuration_table(const efi_guid_t *guid);
> >   /* Install device tree */
> >   efi_status_t efi_install_fdt(void *fdt);
> > +/* Install initrd LoadFile2 protocol */
> > +efi_status_t efi_initrd_install(void);
> > +/* Uninstall initrd LoadFile2 protocol */
> > +efi_status_t efi_initrd_uninstall(void);
> > +/* Set an initrd */
> > +efi_status_t efi_initrd_set_from_mem(void *initrd, size_t initd_sz);
> >   /* Execute loaded UEFI image */
> >   efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)=
;
> >   /* Run loaded UEFI image with given fdt */
> > @@ -667,8 +673,6 @@ efi_status_t efi_http_register(const efi_handle_t
> handle,
> >                              struct efi_service_binding_protocol
> *http_service_binding);
> >   /* Called by bootefi to make the watchdog available */
> >   efi_status_t efi_watchdog_register(void);
> > -efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd);
> > -efi_status_t efi_initrd_deregister(void);
> >   /* Called by bootefi to make SMBIOS tables available */
> >   /**
> >    * efi_acpi_register() - write out ACPI tables
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.=
c
> > index d0f7da309ce..637f2c0d195 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -220,7 +220,6 @@ static efi_status_t efi_binary_run_dp(void *image,
> size_t size, void *fdt,
> >                                     struct efi_device_path *dp_img)
> >   {
> >       efi_status_t ret;
> > -     struct efi_device_path *dp_initrd;
> >
> >       /* Initialize EFI drivers */
> >       ret =3D efi_init_obj_list();
> > @@ -234,13 +233,12 @@ static efi_status_t efi_binary_run_dp(void *image=
,
> size_t size, void *fdt,
> >       if (ret !=3D EFI_SUCCESS)
> >               return ret;
> >
> > -     dp_initrd =3D efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd,
> initd_sz);
> > -     if (!dp_initrd)
> > -             return EFI_OUT_OF_RESOURCES;
> > -
> > -     ret =3D efi_initrd_register(dp_initrd);
> > -     if (ret !=3D EFI_SUCCESS)
> > -             return ret;
> > +     /* Set initrd if provided */
> > +     if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> > +             ret =3D efi_initrd_set_from_mem(initrd, initd_sz);
> > +             if (ret !=3D EFI_SUCCESS)
> > +                     return ret;
> > +     }
> >
> >       return efi_run_image(image, size, dp_dev, dp_img);
> >   }
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.=
c
> > index c0df5cb9acd..19c7e16a25b 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -683,13 +683,6 @@ static efi_status_t try_load_entry(u16 n,
> efi_handle_t *handle,
> >       if (ret !=3D EFI_SUCCESS)
> >               goto error;
> >
> > -     /* try to register load file2 for initrd's */
> > -     if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> > -             ret =3D efi_initrd_register(NULL);
> > -             if (ret !=3D EFI_SUCCESS)
> > -                     goto error;
> > -     }
> > -
> >       log_info("Booting: Label: %ls Device path: %pD\n", lo.label,
> lo.file_path);
> >
> >       /* Ignore the optional data in auto-generated boot options */
> > diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> > index 3936139ca41..b4c207ea33f 100644
> > --- a/lib/efi_loader/efi_helper.c
> > +++ b/lib/efi_loader/efi_helper.c
> > @@ -658,6 +658,13 @@ efi_status_t do_bootefi_exec(efi_handle_t handle,
> void *load_options)
> >               goto out;
> >       }
> >
> > +     /* Create initrd handle and install LoadFile2 protocol */
> > +     if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> > +             ret =3D efi_initrd_install();
> > +             if (ret !=3D EFI_SUCCESS)
> > +                     goto out;
> > +     }
> > +
> >       /* Call our payload! */
> >       ret =3D EFI_CALL(efi_start_image(handle, &exit_data_size,
> &exit_data));
> >       if (ret !=3D EFI_SUCCESS) {
> > @@ -683,6 +690,10 @@ out:
> >               }
> >       }
> >
> > +     /* Destroy initrd handle with LoadFile2 protocol */
> > +     if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD))
> > +             ret =3D efi_initrd_uninstall();
> > +
> >       /* Control is returned to U-Boot, disable EFI watchdog */
> >       efi_set_watchdog(0);
> >
> > diff --git a/lib/efi_loader/efi_load_initrd.c
> b/lib/efi_loader/efi_load_initrd.c
> > index b5d58943a80..7210bf16d09 100644
> > --- a/lib/efi_loader/efi_load_initrd.c
> > +++ b/lib/efi_loader/efi_load_initrd.c
> > @@ -74,7 +74,40 @@ static efi_status_t get_initrd_fp(struct
> efi_device_path **initrd_fp)
> >   }
> >
> >   /**
> > - * efi_initrd_from_mem() - load initial RAM disk from memory
> > + * efi_initrd_set_from_mem() - set initial RAM disk from memory
> > + *
> > + * Set efi_initrd_dp to a memory mapped device path pointing
> > + * to @initrd. If @initrd is NULL then efi_initrd_dp gets cleared.
> > + *
> > + *
> > + * @initrd:    address of initrd or NULL if none is provided
> > + * @initrd_sz: size of initrd
> > + * Return:     status code
> > + */
> > +efi_status_t efi_initrd_set_from_mem(void *initrd, size_t initd_sz)
> > +{
> > +     struct efi_device_path *old_initrd_dp;
> > +
> > +     old_initrd_dp =3D efi_initrd_dp;
>
> In efi_initrd_uninstall() we free the device-path and set efi_initrd_dp
> =3D NULL.
> It seems you are handling the case of efi_initrd_install() failing here.
>
> To me this looks a bit convoluted. Calling efi_initrd_register() as in
> your v3 series would allow handling errors when they occur.
>
> The static variable efi_initrd_dp should receive some documentation in
> the code explaining how it is used. This could be in a separate patch.
>
> I will merge your v3 series as it fixes the case of no initrd.
>
> We can handle the uninstallation of the LoadFile2 protocol in a patch on
> top of that.
>
> Best regards
>
> Heinrich
>
> > +
> > +     if (!initrd) {
> > +             efi_initrd_dp =3D NULL;
> > +             goto out;
> > +     }
> > +
> > +     efi_initrd_dp =3D efi_dp_from_mem(EFI_LOADER_DATA,
> (uintptr_t)initrd, initd_sz);
> > +     if (!efi_initrd_dp) {
> > +             efi_initrd_dp =3D old_initrd_dp;
> > +             return EFI_OUT_OF_RESOURCES;
> > +     }
> > +
> > +out:
> > +     efi_free_pool(old_initrd_dp);
> > +     return EFI_SUCCESS;
> > +}
> > +
> > +/**
> > + * efi_initrd_get_from_mem() - get initial RAM disk from memory
> >    *
> >    * This function copies the initrd from the memory mapped device
> >    * path pointed to by efi_initrd_dp
> > @@ -84,7 +117,7 @@ static efi_status_t get_initrd_fp(struct
> efi_device_path **initrd_fp)
> >    *
> >    * Return:                  status code
> >    */
> > -static efi_status_t efi_initrd_from_mem(efi_uintn_t *buffer_size, void
> *buffer)
> > +static efi_status_t efi_initrd_get_from_mem(efi_uintn_t *buffer_size,
> void *buffer)
> >   {
> >       efi_status_t ret =3D EFI_NOT_FOUND;
> >       efi_uintn_t bs;
> > @@ -155,7 +188,7 @@ efi_load_file2_initrd(struct efi_load_file_protocol
> *this,
> >       }
> >
> >       if (efi_initrd_dp)
> > -             return EFI_EXIT(efi_initrd_from_mem(buffer_size, buffer))=
;
> > +             return EFI_EXIT(efi_initrd_get_from_mem(buffer_size,
> buffer));
> >
> >       ret =3D get_initrd_fp(&initrd_fp);
> >       if (ret !=3D EFI_SUCCESS)
> > @@ -224,14 +257,14 @@ out:
> >   }
> >
> >   /**
> > - * efi_initrd_deregister() - delete the handle for loading initial RAM
> disk
> > + * efi_initrd_uninstall() - delete the handle for loading initial RAM
> disk
> >    *
> >    * This will delete the handle containing the Linux specific vendor
> device
> > - * path and EFI_LOAD_FILE2_PROTOCOL for loading an initrd
> > + * path and the installed EFI_LOAD_FILE2_PROTOCOL for loading an initr=
d
> >    *
> >    * Return:  status code
> >    */
> > -efi_status_t efi_initrd_deregister(void)
> > +efi_status_t efi_initrd_uninstall(void)
> >   {
> >       efi_status_t ret;
> >
> > @@ -255,42 +288,22 @@ efi_status_t efi_initrd_deregister(void)
> >   }
> >
> >   /**
> > - * efi_initrd_return_notify() - return to efibootmgr callback
> > - *
> > - * @event:   the event for which this notification function is
> registered
> > - * @context: event context
> > - */
> > -static void EFIAPI efi_initrd_return_notify(struct efi_event *event,
> > -                                               void *context)
> > -{
> > -     efi_status_t ret;
> > -
> > -     EFI_ENTRY("%p, %p", event, context);
> > -     ret =3D efi_initrd_deregister();
> > -     EFI_EXIT(ret);
> > -}
> > -
> > -/**
> > - * efi_initrd_register() - create handle for loading initial RAM disk
> > + * efi_initrd_install() - create handle for loading initial RAM disk
> >    *
> >    * This function creates a new handle and installs a Linux specific
> vendor
> >    * device path and an EFI_LOAD_FILE2_PROTOCOL. Linux uses the device
> path
> >    * to identify the handle and then calls the LoadFile service of the
> > - * EFI_LOAD_FILE2_PROTOCOL to read the initial RAM disk. If dp_initrd =
is
> > - * not provided, the initrd will be taken from the BootCurrent variabl=
e
> > - *
> > - * @dp_initrd:       optional device path containing an initrd
> > + * EFI_LOAD_FILE2_PROTOCOL to read the initial RAM disk. If
> efi_initrd_dp
> > + * is not set the initrd will be taken from the BootCurrent variable. =
If
> > + * an initrd is not found the handle is not created.
> >    *
> >    * Return:  status code
> >    */
> > -efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd)
> > +efi_status_t efi_initrd_install(void)
> >   {
> >       efi_status_t ret;
> > -     struct efi_event *event;
> >
> > -     if (dp_initrd) {
> > -             efi_initrd_dp =3D dp_initrd;
> > -     } else {
> > +     if (!efi_initrd_dp) {
> >               /*
> >               * Allow the user to continue if Boot#### file path is not
> set for
> >               * an initrd
> > @@ -314,12 +327,5 @@ efi_status_t efi_initrd_register(struct
> efi_device_path *dp_initrd)
> >               return ret;
> >       }
> >
> > -     ret =3D efi_create_event(EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
> > -                            efi_initrd_return_notify, NULL,
> > -                            &efi_guid_event_group_return_to_efibootmgr=
,
> > -                            &event);
> > -     if (ret !=3D EFI_SUCCESS)
> > -             log_err("Creating event failed\n");
> > -
> >       return ret;
> >   }
>
>
