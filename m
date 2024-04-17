Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17156C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 12:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91D2D8845D;
	Wed, 17 Apr 2024 14:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EmBJL5dd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D7CD8845E; Wed, 17 Apr 2024 14:34:20 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C6108832B
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 14:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2da08b06e0dso60480111fa.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 05:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713357257; x=1713962057; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBJbYMYUQFRcUC1NQgzRocM/+gNn11PDQ4ScgT7x+c4=;
 b=EmBJL5ddDQshqpdB87fcMx/LWhskTRNnjCkoOd4+O/xBEy9aIan94IY8HiZ1xr38Xu
 VWae83kGbmd8FMltfzibfwS5cNb1O3I/C+GLjIaectzi5doQLVwH/EJWX00DaXi0+KKh
 jrREBaDDQ+YG1mXS/RrHB+zsdH8hhvoAfyzSfUPB1EycCeu69M+pC35aLlyFU+f5oxtV
 sTm1HoJrx+m6E8wtM1lW0HpRhIr5DCcWPVOH9X55fp5+bQszUBJ4JgvzoX4sN0ZR3rls
 0TQnAvrs/QWaGFJ+7uKg7lhbZQWu2gIRG34vM58pK5d2m/TE3Q+1wGOrAu4Uaswz8iBf
 tSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713357257; x=1713962057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBJbYMYUQFRcUC1NQgzRocM/+gNn11PDQ4ScgT7x+c4=;
 b=T8VMgzWzSr7KlkZKl6J5ITYoRkYgOTIb6lsjtIUmx/GaXMxEwlYRjxy9TMRFFIMHNW
 cHJRXLhCDOUjq+E9pom3geoXprrEl4a4OREBi7QS1u2cJOH0xWUfFvnJ45MblP8/GrRn
 Hndk3MiMCGm6TDq/xJ1EJk0c2B9AJWVzEl3fEoDlW9ra/FEYHPxeociG0YrcLJI/7v6n
 KETuWqKQRxNWF+WLmMKrLlT4zZ25Rd1i1bvoUW38WjDdeVCLZprEcn6zIWWOevOF8X0a
 FRumPimaRQbU/doec8ooSFilg4lmppLZr3TpgkNXMwjWQC3jUHpAo9ear/SZyLqISFw3
 JY/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjj3zt46tCq4xHOOMTI+UXzxdFgr2UNTanD8C6Vw6Ogj5W0/DFZNb38Ob68AFIvtkkOSeprvKa4mEPPU4t4vRpbxDG/Q==
X-Gm-Message-State: AOJu0YycFGew0aEbUUb3D3RBKQkxCj3bYA/jnPRx+5ZjO40oHwxlyHe/
 slUrhKUB7JZjUiyb7y6qM8TYKQAN+IbM3BPKEzCepxcqtq6zQWnbwJQzksvZnWs09pfWFdjmh7s
 DGYRk2F8xnBDP7meoXpBtuljr9HplvVim3Lcaqg==
X-Google-Smtp-Source: AGHT+IFiK1BoXoAa26qJ+2k9R5XhlH2ErsBPSinRIFzKf0/HguGDYLeeT2tn8VsM1MpsakgKLOE0ToEsw9Hz4CuxMcM=
X-Received: by 2002:a05:651c:120e:b0:2da:9ed:9b43 with SMTP id
 i14-20020a05651c120e00b002da09ed9b43mr8801994lja.31.1713357256511; Wed, 17
 Apr 2024 05:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240417101928.119115-1-ilias.apalodimas@linaro.org>
 <20240417101928.119115-2-ilias.apalodimas@linaro.org>
 <747da8ef-33c4-40d6-9470-1e8ce5dbbb9e@canonical.com>
In-Reply-To: <747da8ef-33c4-40d6-9470-1e8ce5dbbb9e@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 17 Apr 2024 15:33:40 +0300
Message-ID: <CAC_iWjKiupGYLoYNOq37bTcBoZ57vPichUHGWayOASu2kqmg0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] efi_loader: conditionally enable SetvariableRT
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: kettenis@openbsd.org, caleb.connolly@linaro.org, sumit.garg@linaro.org, 
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com, 
 pjones@redhat.com, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Janne Grunau <j@jannau.net>, Simon Glass <sjg@chromium.org>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sam Edwards <CFSworks@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 17 Apr 2024 at 15:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 17.04.24 12:19, Ilias Apalodimas wrote:
> > When we store EFI variables on file we don't allow SetVariable at runti=
me,
> > since the OS doesn't know how to access or write that file.  At the sam=
e
> > time keeping the U-Boot drivers alive in runtime sections and performin=
g
> > writes from the firmware is dangerous -- if at all possible.
> >
> > For GetVariable at runtime we copy runtime variables in RAM and expose =
them
> > to the OS. Add a Kconfig option and provide SetVariable at runtime usin=
g
> > the same memory backend. The OS will be responsible for syncing the RAM
> > contents to the file, otherwise any changes made during runtime won't
> > persist reboots.
> >
> > It's worth noting that the variable store format is defined in EBBR [0]
> > and authenticated variables are explicitly prohibited, since they have
> > to be stored on a medium that's tamper and rollback protected.
> >
> > - pre-patch
> > $~ mount | grep efiva
> > efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,no=
exec,relatime)
> >
> > $~ efibootmgr -n 0001
> > Could not set BootNext: Read-only file system
> >
> > - post-patch
> > $~ mount | grep efiva
> > efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,no=
exec,relatime)
> >
> > $~ efibootmgr -n 0001
> > BootNext: 0001
> > BootCurrent: 0000
> > BootOrder: 0000,0001
> > Boot0000* debian        HD(1,GPT,bdae5610-3331-4e4d-9466-acb5caf0b4a6,0=
x800,0x100000)/File(EFI\debian\grubaa64.efi)
> > Boot0001* virtio 0      VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000=
000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,850000001f000000)/=
VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600850000000000){auto_created_b=
oot_option}
> >
> > $~ efivar -p -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-BootNext
> > GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c
> > Name: "BootNext"
> > Attributes:
> >          Non-Volatile
> >          Boot Service Access
> >          Runtime Service Access
> > Value:
> > 00000000  01 00
> >
> > [0] https://arm-software.github.io/ebbr/index.html#document-chapter5-va=
riable-storage
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   lib/efi_loader/Kconfig                        |  16 +++
> >   lib/efi_loader/efi_runtime.c                  |   4 +
> >   lib/efi_loader/efi_variable.c                 | 115 ++++++++++++++++-=
-
> >   .../efi_selftest_variables_runtime.c          |  13 +-
> >   4 files changed, 134 insertions(+), 14 deletions(-)
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index e13a6f9f4c3a..cc8371a3bb4c 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -62,6 +62,22 @@ config EFI_VARIABLE_FILE_STORE
> >         Select this option if you want non-volatile UEFI variables to b=
e
> >         stored as file /ubootefi.var on the EFI system partition.
> >
> > +config EFI_RT_VOLATILE_STORE
> > +     bool "Allow variable runtime services in volatile storage (e.g RA=
M)"
> > +     depends on EFI_VARIABLE_FILE_STORE
> > +     help
> > +       When EFI variables are stored on file we don't allow SetVariabl=
eRT,
> > +       since the OS doesn't know how to write that file. At he same ti=
me
> > +       we copy runtime variables in DRAM and support GetVariableRT
> > +
> > +       Enable this option to allow SetVariableRT on the RAM backend of
> > +       the EFI variable storage. The OS will be responsible for syncin=
g
> > +       the RAM contents to the file, otherwise any changes made during
> > +       runtime won't persist reboots.
> > +       Authenticated variables are not supported. Note that this will
> > +       violate the EFI spec since writing auth variables will return
> > +       EFI_INVALID_PARAMETER
> > +
> >   config EFI_MM_COMM_TEE
> >       bool "UEFI variables storage service via the trusted world"
> >       depends on OPTEE
> > diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.=
c
> > index a61c9a77b13f..dde083b09665 100644
> > --- a/lib/efi_loader/efi_runtime.c
> > +++ b/lib/efi_loader/efi_runtime.c
> > @@ -127,6 +127,10 @@ efi_status_t efi_init_runtime_supported(void)
> >                               EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP =
|
> >                               EFI_RT_SUPPORTED_CONVERT_POINTER;
> >
> > +     if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
> > +             rt_table->runtime_services_supported |=3D
> > +                     EFI_RT_SUPPORTED_SET_VARIABLE;
> > +
> >       /*
> >        * This value must be synced with efi_runtime_detach_list
> >        * as well as efi_runtime_services.
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variabl=
e.c
> > index e6c1219a11c8..abc2a3402f42 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -219,17 +219,20 @@ efi_get_next_variable_name_int(efi_uintn_t *varia=
ble_name_size,
> >       return efi_get_next_variable_name_mem(variable_name_size, variabl=
e_name, vendor);
> >   }
> >
> > -efi_status_t efi_set_variable_int(const u16 *variable_name,
> > -                               const efi_guid_t *vendor,
> > -                               u32 attributes, efi_uintn_t data_size,
> > -                               const void *data, bool ro_check)
> > +/**
> > + * setvariable_allowed() - checks defined by the UEFI spec for setvari=
able
> > + *
> > + * @variable_name:   name of the variable
> > + * @vendor:          vendor GUID
> > + * @attributes:              attributes of the variable
> > + * @data_size:               size of the buffer with the variable valu=
e
> > + * @data:            buffer with the variable value
> > + * Return:           status code
> > + */
> > +static efi_status_t __efi_runtime
> > +setvariable_allowed(const u16 *variable_name, const efi_guid_t *vendor=
,
> > +                 u32 attributes, efi_uintn_t data_size, const void *da=
ta)
> >   {
> > -     struct efi_var_entry *var;
> > -     efi_uintn_t ret;
> > -     bool append, delete;
> > -     u64 time =3D 0;
> > -     enum efi_auth_var_type var_type;
> > -
> >       if (!variable_name || !*variable_name || !vendor)
> >               return EFI_INVALID_PARAMETER;
> >
> > @@ -261,6 +264,25 @@ efi_status_t efi_set_variable_int(const u16 *varia=
ble_name,
> >            !(attributes & EFI_VARIABLE_BOOTSERVICE_ACCESS)))
> >               return EFI_INVALID_PARAMETER;
> >
> > +     return EFI_SUCCESS;
> > +}
> > +
> > +efi_status_t efi_set_variable_int(const u16 *variable_name,
> > +                               const efi_guid_t *vendor,
> > +                               u32 attributes, efi_uintn_t data_size,
> > +                               const void *data, bool ro_check)
> > +{
> > +     struct efi_var_entry *var;
> > +     efi_uintn_t ret;
> > +     bool append, delete;
> > +     u64 time =3D 0;
> > +     enum efi_auth_var_type var_type;
> > +
> > +     ret =3D setvariable_allowed(variable_name, vendor, attributes, da=
ta_size,
> > +                               data);
> > +     if (ret !=3D EFI_SUCCESS)
> > +             return ret;
> > +
> >       /* check if a variable exists */
> >       var =3D efi_var_mem_find(vendor, variable_name, NULL);
> >       append =3D !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> > @@ -454,7 +476,78 @@ efi_set_variable_runtime(u16 *variable_name, const=
 efi_guid_t *vendor,
> >                        u32 attributes, efi_uintn_t data_size,
> >                        const void *data)
> >   {
> > -     return EFI_UNSUPPORTED;
> > +     struct efi_var_entry *var;
> > +     efi_uintn_t ret;
> > +     bool append, delete;
> > +     u64 time =3D 0;
> > +
> > +     if (!IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
> > +             return EFI_UNSUPPORTED;
> > +
> > +     /*
> > +      * Authenticated variables are not supported. The EFI spec
> > +      * in =C2=A732.3.6 requires keys to be stored in non-volatile sto=
rage which
> > +      * is tamper and delete resistant.
> > +      * The rest of the checks are in setvariable_allowed()
> > +      */
> > +     if (attributes & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCE=
SS)
> > +             return EFI_INVALID_PARAMETER;
> > +     /* BS only variables are hidden deny writing them */
> > +     if (!(attributes & EFI_VARIABLE_RUNTIME_ACCESS))
> > +             return EFI_INVALID_PARAMETER;
> > +
> > +     ret =3D setvariable_allowed(variable_name, vendor, attributes, da=
ta_size,
> > +                               data);
> > +     if (ret !=3D EFI_SUCCESS)
> > +             return ret;
> > +
> > +     /* check if a variable exists */
> > +     var =3D efi_var_mem_find(vendor, variable_name, NULL);
> > +     append =3D !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> > +     attributes &=3D ~EFI_VARIABLE_APPEND_WRITE;
> > +     delete =3D !append && (!data_size || !attributes);
> > +
> > +     if (var) {
> > +             if (var->attr & EFI_VARIABLE_READ_ONLY ||
> > +                 !(var->attr & EFI_VARIABLE_NON_VOLATILE))
> > +                     return EFI_WRITE_PROTECTED;
> > +
> > +             /* attributes won't be changed */
> > +             if (!delete && (((var->attr & ~EFI_VARIABLE_READ_ONLY) !=
=3D
> > +                 (attributes & ~EFI_VARIABLE_READ_ONLY))))
> > +                     return EFI_INVALID_PARAMETER;
> > +             time =3D var->time;
> > +     } else {
> > +             if (!(attributes & EFI_VARIABLE_NON_VOLATILE))
> > +                     return EFI_INVALID_PARAMETER;
> > +             if (append && !data_size)
> > +                     return EFI_SUCCESS;
> > +             if (delete)
> > +                     return EFI_NOT_FOUND;
> > +     }
> > +
> > +     if (delete) {
> > +             /* EFI_NOT_FOUND has been handled before */
> > +             attributes =3D var->attr;
> > +             ret =3D EFI_SUCCESS;
> > +     } else if (append && var) {
> > +             u16 *old_data =3D (void *)((uintptr_t)var->name +
> > +                     sizeof(u16) * (u16_strlen(var->name) + 1));
> > +
> > +             ret =3D efi_var_mem_ins(variable_name, vendor, attributes=
,
> > +                                   var->length, old_data, data_size, d=
ata,
> > +                                   time);
> > +     } else {
> > +             ret =3D efi_var_mem_ins(variable_name, vendor, attributes=
,
> > +                                   data_size, data, 0, NULL, time);
> > +     }
> > +
> > +     if (ret !=3D EFI_SUCCESS)
> > +             return ret;
> > +     /* We are always inserting new variables, get rid of the old copy=
 */
> > +     efi_var_mem_del(var);
> > +
> > +     return EFI_SUCCESS;
> >   }
> >
> >   /**
> > diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/ef=
i_selftest/efi_selftest_variables_runtime.c
> > index 4700d9424105..4c9405c0a7c7 100644
> > --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> > +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> > @@ -62,9 +62,16 @@ static int execute(void)
> >                                   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> >                                   EFI_VARIABLE_RUNTIME_ACCESS,
> >                                   3, v + 4);
> > -     if (ret !=3D EFI_UNSUPPORTED) {
> > -             efi_st_error("SetVariable failed\n");
> > -             return EFI_ST_FAILURE;
> > +     if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> > +             if (ret !=3D EFI_INVALID_PARAMETER) {
>
> A comment might be helpful here:
>
>      /* At runtime only non-volatile variables may be set. */
>
> Otherwise looks good to me.
>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Thanks, Heinrich!
I'll add the comment in v3

>
> > +                     efi_st_error("SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +     } else {
> > +             if (ret !=3D EFI_UNSUPPORTED) {
> > +                     efi_st_error("SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> >       }
> >       len =3D EFI_ST_MAX_DATA_SIZE;
> >       ret =3D runtime->get_variable(u"PlatformLangCodes", &guid_vendor0=
,
>
