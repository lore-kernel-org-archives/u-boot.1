Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8B6CD11DD
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 12:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 992AC8815D;
	Fri, 29 Mar 2024 13:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vx0EuD8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C29388233; Fri, 29 Mar 2024 13:46:39 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D951187E53
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 13:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d71765d3e1so8335751fa.0
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711716396; x=1712321196; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bN8DfNoT3b6e+ShijizrW9/p0dlR0ctMq3IWIdpTUNI=;
 b=Vx0EuD8zRjlEA+GI2eOKTmIzx+8PZJHyUh7jgTMdQaPzTnRKYcuwCXqnM0olGVWbIP
 gSkpp4p4OOS8xraX/RYbQSSHUTC+/ut9E5CQfGF67LBOvevwFz7WZYO2olA+nh/jTfQt
 2mgKbLI5ZqB++wBe1xo/4cZgEyWgxGrejPuA99hE6C90Gq9eEA2qccJImoVPko/ZrBJr
 DB5A0SeThZRlUoPUQGwH4luQRHZZTHFEiNM0LUuQ7Mtegns1ZJhFsUZZcDnFCH4/h3BE
 QFn00f3tRR6sMvtIxTotHlBABHQOlSEC4c8DDRSlvx0SGk7NBd0peNgUzSP1BuIZhb6Z
 JxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711716396; x=1712321196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bN8DfNoT3b6e+ShijizrW9/p0dlR0ctMq3IWIdpTUNI=;
 b=RkT/L5xV/fgLIh/kbOARdzLHRjFa/Uhtcu8aH80tFIumip8Nc7gRyxquE7AH7fjkqS
 mILkuWFIVDlzChZJxc3m09tRyDLUj9q1yAqSlDbS7gjy+F6pr4movbEy7RJKaakHh6uA
 /a5d4zzYg5IFxLZSdwVl7UPz6qkeVQfCLoFSkkNysLNDW6hMjQFoXapzD7aKiICEBuI/
 s3mjGVPB7akFF4CEK65HpPBAQE+S54DdMsQjzNpoFMzG/kgbnEpbTrg8xJ0L6+DSua7S
 GR+giH2dTuOqXZCinaWJixZl1oBHzkOM+WojoEkP0gNHRnsa+Nd7DKHqCZW7L04LRMrK
 1J6g==
X-Gm-Message-State: AOJu0YzTFekgbMArCgU7zbsEkdgxuNErR3k0z5DKe9IOlQqiXC5tqgNK
 LQxCzaOFQhDEL2h8HaxFAYvo0sep5YFKfqbzafqPtvk64F2ip6iaPMjGd2ADZgnnQ3rGtIeNOdV
 L1atVFtTIHaACftC1AFlyyRn51CrzI/RMP3N6DA==
X-Google-Smtp-Source: AGHT+IFZPAOO8RTzAThHk08qz2sQvE25wlM/aw0KsgyfVnuG0QXiPLRA6xZH0pXRjyWfGMEa0awP0a5gYXlSEKzUbts=
X-Received: by 2002:a2e:8443:0:b0:2d6:d7ff:5d40 with SMTP id
 u3-20020a2e8443000000b002d6d7ff5d40mr1619447ljh.38.1711716396076; Fri, 29 Mar
 2024 05:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240329071929.2461441-1-ilias.apalodimas@linaro.org>
 <7b9afe57-7454-49d9-930e-abcaa829b0d9@gmx.de>
In-Reply-To: <7b9afe57-7454-49d9-930e-abcaa829b0d9@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 29 Mar 2024 14:45:59 +0200
Message-ID: <CAC_iWjKS16PCDYmpmsRabpaAeV=7Q0NS+jPVJZLSYduqEReQvQ@mail.gmail.com>
Subject: Re: [RFC PATCH] efi_loader: conditionally enable SetvariableRT
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, caleb.connolly@linaro.org, 
 sumit.garg@linaro.org, Simon Glass <sjg@chromium.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, pbrobinson@gmail.com, kettenis@openbsd.org, 
 ardb@kernel.org
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

[...]

> >
> > +config EFI_RT_VOLATILE_STORE
> > +     bool "Allow variable runtime services in volatile storage (e.g RAM)"
> > +     depends on EFI_VARIABLE_FILE_STORE
> > +     help
> > +       When EFI variables are stored on file we don't allow SetVariableRT,
> > +       since the OS doesn't know how to write that file. At he same time
> > +       we copy runtime variables in DRAM and support GetVariableRT
> > +
> > +       Enable this option to allow SetVariableRT on the RAM backend of
> > +       the EFI variable storate. The OS will be responsible for syncing
>
> Hello Ilias,
>
> I like the idea of adding this for experimenting. We should express that
> this is just experimental and may be removed in future releases, if we
> find a better solution.

U-Boot documentation is good enough? I've cc'ed Peter (which maintain
efivar AFAIK). If we agree on how to teach efivar/efibootmgr to use
that file, I can describe it in docs

>
> %s/storate/stroage/
>
> > +       the RAM contents to the file, otherwise any changes made during
> > +       runtime won't persist reboots.
> > +       Authenticated variables are not supported.
>
> Should we mention here that this behavior is not compliant with the UEFI
> specification?
>
> Should we unset CONFIG_EFI_EBBR_2_1_CONFORMANCE if this flag is set?

No, I don't think so. I'll ask around to make sure. However, EBBR
already standardizes the file format and explicitly prevents storing
authenticated variables. There's a separate test suite from arm called
SIE (SEcurity interface extensions) which is complementary to
SystemReady-IR and tests EFI authenticated variables.

>
> > +
> >   config EFI_MM_COMM_TEE
> >       bool "UEFI variables storage service via the trusted world"
> >       depends on OPTEE
> > diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> > index 18da6892e796..b38ce239e2d2 100644
> > --- a/lib/efi_loader/efi_runtime.c
> > +++ b/lib/efi_loader/efi_runtime.c
> > @@ -126,6 +126,10 @@ efi_status_t efi_init_runtime_supported(void)
> >                               EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
> >                               EFI_RT_SUPPORTED_CONVERT_POINTER;
> >
> > +     if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
> > +             rt_table->runtime_services_supported |=
> > +                     EFI_RT_SUPPORTED_SET_VARIABLE;
> > +
> >       /*
> >        * This value must be synced with efi_runtime_detach_list
> >        * as well as efi_runtime_services.
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> > index 40f7a0fb10d5..3b770ff16971 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -218,17 +218,21 @@ efi_get_next_variable_name_int(efi_uintn_t *variable_name_size,
> >       return efi_get_next_variable_name_mem(variable_name_size, variable_name, vendor);
> >   }
> >
> > -efi_status_t efi_set_variable_int(const u16 *variable_name,
> > -                               const efi_guid_t *vendor,
> > -                               u32 attributes, efi_uintn_t data_size,
> > -                               const void *data, bool ro_check)
> > +/**
> > + * efi_check_setvariable() - checks defined by the UEFI spec for setvariable
> > + *
> > + * @variable_name:   name of the variable
> > + * @vendor:          vendor GUID
> > + * @attributes:              attributes of the variable
> > + * @data_size:               size of the buffer with the variable value
> > + * @data:            buffer with the variable value
> > + * Return:           status code
> > + */
> > +static efi_status_t __efi_runtime EFIAPI
> > +efi_check_setvariable(const u16 *variable_name, const efi_guid_t *vendor,
> > +                   u32 attributes, efi_uintn_t data_size,
> > +                   const void *data)
> >   {
> > -     struct efi_var_entry *var;
> > -     efi_uintn_t ret;
> > -     bool append, delete;
> > -     u64 time = 0;
> > -     enum efi_auth_var_type var_type;
> > -
> >       if (!variable_name || !*variable_name || !vendor)
> >               return EFI_INVALID_PARAMETER;
> >
> > @@ -256,6 +260,25 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
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
> > +     u64 time = 0;
> > +     enum efi_auth_var_type var_type;
> > +
> > +     ret = efi_check_setvariable(variable_name, vendor, attributes, data_size,
> > +                                 data);
> > +     if (ret != EFI_SUCCESS)
> > +             return ret;
> > +
> >       /* check if a variable exists */
> >       var = efi_var_mem_find(vendor, variable_name, NULL);
> >       append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> > @@ -434,7 +457,72 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
> >                        u32 attributes, efi_uintn_t data_size,
> >                        const void *data)
> >   {
> > +#if IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)
>
> Please, use 'if' instead of #if. The

Sure

>
> > +     struct efi_var_entry *var;
> > +     efi_uintn_t ret;
> > +     bool append, delete;
> > +     u64 time = 0;
> > +
> > +     /* Authenticated variables are not supported */
> > +     if (attributes & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
>
> Adding EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS here would make it
> clearer that all authenticated variables are unsupported.

Ok, will do

>
> Non-volatile variables are read-only at runtime. Please, check that
> EFI_VARIABLE_NON_VOLATILE is set.

You mean volatile right? But yea this needs fixing

>
> if ((attributes & (
>    EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS |
>    EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS |
>    EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS)) ||
>    (~attributes & EFI_VARIABLE_NON_VOLATILE)
>      return EFI_INVALID_PARAMETER;
>
> > +                     return EFI_INVALID_PARAMETER;
> > +
> > +     ret = efi_check_setvariable(variable_name, vendor, attributes, data_size,
> > +                                 data);
> > +     if (ret != EFI_SUCCESS)
> > +             return ret;
> > +
> > +     /* check if a variable exists */
> > +     var = efi_var_mem_find(vendor, variable_name, NULL);
> > +     append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> > +     attributes &= ~(u32)EFI_VARIABLE_APPEND_WRITE;
>
> Why is the u32 conversion necessary? The result should be the same
> without conversion.
>
> The UEFI specification defines the different attribute constants as
> 32bit. Why do we define them as 64bit in include/efi.h?

I guess this is an existing misinterpretation of the spec.
I copy pasted this check from efi_set_variable_int(). It seems we
should fix both.
I'll include the fix in v2

>
> > +     delete = !append && (!data_size || !attributes);
> > +
> > +     if (var) {
> > +             if (var->attr & EFI_VARIABLE_READ_ONLY)
> > +                     return EFI_WRITE_PROTECTED;
> > +
> > +             /* attributes won't be changed */
> > +             if (!delete && (((var->attr & ~(u32)EFI_VARIABLE_READ_ONLY) !=
> > +                 (attributes & ~(u32)EFI_VARIABLE_READ_ONLY))))
> > +                     return EFI_INVALID_PARAMETER;
>
> ditto
>
> > +             time = var->time;
> > +     } else {
> > +             if (delete || append)
>
> EDK II allows to create a variable with EFI_VARIABLE_APPEND_WRITE. See
> previous discussions about changing this at boot time.

Yes, the reason I kept it like this is that we didn't merge that yet
and I wanted to keep the same behavior. I'll update this one

[...]

Thanks
/Ilias
