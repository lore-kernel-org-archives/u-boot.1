Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59098C6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 13:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67DE088233;
	Fri, 29 Mar 2024 14:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CM97wK8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 754A588230; Fri, 29 Mar 2024 14:52:00 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 912B988228
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 14:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d52e65d4a8so26881651fa.0
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711720317; x=1712325117; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SJ+1QdSa31V1x+wdXBMXS+bu9Bw3PmUULpvZuN7dito=;
 b=CM97wK8FmkiwPh+hrhnscn1oRvwbrP1lHHntwHCZuNj94AZFWCGyDJWGy+XtxMcxkt
 fPvvI1s6tS5+L0p0E25Fa8ILTQuqlCYBk+7h/f7TY3HO0wJZE+zEDFouq5lYE9tvBUPE
 Yr/XJLscGHnGJctBA9lndF5jz0ttYs3p431SFFe+MjmduAAoyVYLdB7vcwGd74M9G44d
 tPTRYUEuQpt4NrxEjKgozOK/5O5ky8J+6gw6SB2Co1jjtO4D/rJyopHDOkgaGXKcp3Zx
 fIUki24yAGZvFMp5GiDOXrFi0A+xOj8sGtFRz6v44d1kIBQdYYNZqd24BGPmhuJxSIX5
 TU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711720317; x=1712325117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SJ+1QdSa31V1x+wdXBMXS+bu9Bw3PmUULpvZuN7dito=;
 b=tfmOWWHqNPLXkp1wdvGvOF1aKK7VPquNVshZslILx98TnmVaacEb0HmyFHoaCtNDxO
 RbG+gvD6h6xotDZ/Eb5pQkKuvTvpfykFzzrn9IvZB3stpGrU+/AsDxbXTpkX0n5y/SK4
 186NAA12uZ3cHWzsmTH0jIQGz89vfem1NyEh6N+/sy5gjKLmS6NJ2T23VrfMLR0D8dAs
 GyRIuDltUC90GjZiw3hTlfAOBDqyyuDubSEo085xsKtarMNHK9IpsgIxnGa8hj9J8Bkh
 jSIdsOoOsgcRMt9VjxF+ZpcB7Q29CDMOjLjjDhqp/3L5nkHaioCrY/xOlWAd5KkLHkhr
 ylBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4T686PilLAZDwaz/KrqKdtvZ7U1roAUdxkgOm1whS0YKSxjE6y7UrTnBV5SDQwS4lxHJJZoVGi7F2hmbHBshvTZGhFQ==
X-Gm-Message-State: AOJu0YwrYe3QzYdgKJOID18nAeU6NP2y7PJxzAjLvRAIVo4JSn4Kyt8C
 TrSFIkNADmWDPWgGMZS2+AdXycI70eNM9tLkjV/VBuMnq5lqt31g5/xpBQTwIuJIwIFw/P+adQk
 FIhwPk4hzUedwKDCjAqsOQ7b0oDPms3x1CIKoIg==
X-Google-Smtp-Source: AGHT+IGK9Qf3+sUfzq3xFMiXguD0tUkPQw8NuUyX+rTU1hJXJ0HStcpxyzy4aOx6AaN4yQSkormyjEnKIfexqRJTnog=
X-Received: by 2002:a2e:9f53:0:b0:2d4:2651:1483 with SMTP id
 v19-20020a2e9f53000000b002d426511483mr1270560ljk.35.1711720316724; Fri, 29
 Mar 2024 06:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240329071929.2461441-1-ilias.apalodimas@linaro.org>
 <87msqh8bta.fsf@bloch.sibelius.xs4all.nl>
 <9ef1225a-a5d8-431c-b281-20c521614356@gmx.de>
In-Reply-To: <9ef1225a-a5d8-431c-b281-20c521614356@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 29 Mar 2024 15:51:20 +0200
Message-ID: <CAC_iWjKGTKMNeiX3X7PdcdPg1h7UHnYgfS3vEVFXJ9mw6aPuCQ@mail.gmail.com>
Subject: Re: [RFC PATCH] efi_loader: conditionally enable SetvariableRT
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, ardb@kernel.org,
 kettenis@openbsd.org, 
 pbrobinson@gmail.com, u-boot@lists.denx.de, trini@konsulko.com, 
 caleb.connolly@linaro.org, sumit.garg@linaro.org, sjg@chromium.org, 
 abdellatif.elkhlifi@arm.com, takahiro.akashi@linaro.org, 
 sughosh.ganu@linaro.org, kojima.masahisa@socionext.com, bmeng@tinylab.org
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

On Fri, 29 Mar 2024 at 14:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 3/29/24 13:25, Mark Kettenis wrote:
> >> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> Date: Fri, 29 Mar 2024 09:19:27 +0200
> >>
> >> When EFI variables are stored on file we don't allow SetVariableRT,
> >> since the OS doesn't know how to access or write that file.  At the same
> >> time keeping the U-Boot drivers alive in runtime sections and performing
> >> writes from the firmware is dangerous -- if at all possible.
> >>
> >> For GetVariableRT  we copy runtime variables in RAM and expose them to
> >> the OS. Add a Kconfig option and provide SetVariableRT using the same
> >> memory backend. The OS will be responsible for syncing the RAM contents
> >> to the file, otherwise any changes made during runtime won't persist
> >> reboots.
> >>
> >> It's worth noting that the variable store format is defined in EBBR [0]
> >> and authenticated variables are explicitly prohibited, since they have
> >> to be stored on a medium that's tamper and rollback protected.
> >>
> >> - pre-patch
> >> $~ mount | grep efiva
> >> efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,noexec,relatime)
> >>
> >> $~ efibootmgr -n 0001
> >> Could not set BootNext: Read-only file system
> >>
> >> - post-patch
> >> $~ mount | grep efiva
> >> efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
> >>
> >> $~ efibootmgr -n 0001
> >> BootNext: 0001
> >> BootCurrent: 0000
> >> BootOrder: 0000,0001
> >> Boot0000* debian        HD(1,GPT,bdae5610-3331-4e4d-9466-acb5caf0b4a6,0x800,0x100000)/File(EFI\debian\grubaa64.efi)
> >> Boot0001* virtio 0      VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,850000001f000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600850000000000){auto_created_boot_option}
> >>
> >> $~ efivar -p -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-BootNext
> >> GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c
> >> Name: "BootNext"
> >> Attributes:
> >>          Non-Volatile
> >>          Boot Service Access
> >>          Runtime Service Access
> >> Value:
> >> 00000000  01 00
> >>
> >> [0] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage
> >>
> >> Open questions:
> >> Looking at the EFI spec, I can't find a documented way of notifying the OS
> >> that the storage is volatile. I would like to send a hint to the OS about
> >> that and I was thinking of adding a configuration table with the filename,
> >> which U-Boot expects to be on the ESP. Alternatively we could add a device
> >> path which would be a bit harder to parse from the userspace application,
> >> but safer in case multiple ESPs are present.
> >
> > Should there be a way for the OS to opt-in to this new behaviour?
>
> With the patch you could handle persisting variables in user space
> without any modifications of the OS. E.g. use fanotify to watch all
> efivarfs mounts in Linux.

Even better er can teach efivar etc to do this, which is going to be
seamless for distros

>
> Ilias has also been considering a Linux driver for file based variables
> inside the OS but then you wouldn't need this patch.

Yea, I changed my mind on that upcall. I don't think it's elegant and
it's going to be linux specific. The reason for doing what this patch
propose, is get wider OS adoption.

>
> >
> >> Since I am not too familiar with how BSDs treat and expose config tables,
> >> we could instead add a RO efi variable with identical semantics, which
> >> would be easier to read from userspace.
> >
> > There is an EFIIOC_GET_TABLE ioctl that allows retreiving a table by GUID.
>
> This seems to be BSD specific.
>
> @Ilias: How would you read a configuration from user space in Linux?

Linux exposes some config tables in sys/. e.g ./firmware/efi/esrt/.
$~ ls /sys/firmware/efi/esrt/
entries  fw_resource_count  fw_resource_count_max  fw_resource_version

 I think we would have to add code for that new special table, unless
I am missing something.

/Ilias
>
> Best regards
>
> Heinrich
>
> >
> >
> >> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> ---
> >>   lib/efi_loader/Kconfig                        |  14 +++
> >>   lib/efi_loader/efi_runtime.c                  |   4 +
> >>   lib/efi_loader/efi_variable.c                 | 108 ++++++++++++++++--
> >>   .../efi_selftest_variables_runtime.c          |  13 ++-
> >>   4 files changed, 126 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >> index a7c3e05c13a0..c7f7383189e5 100644
> >> --- a/lib/efi_loader/Kconfig
> >> +++ b/lib/efi_loader/Kconfig
> >> @@ -63,6 +63,20 @@ config EFI_VARIABLE_FILE_STORE
> >>        Select this option if you want non-volatile UEFI variables to be
> >>        stored as file /ubootefi.var on the EFI system partition.
> >>
> >> +config EFI_RT_VOLATILE_STORE
> >> +    bool "Allow variable runtime services in volatile storage (e.g RAM)"
> >> +    depends on EFI_VARIABLE_FILE_STORE
> >> +    help
> >> +      When EFI variables are stored on file we don't allow SetVariableRT,
> >> +      since the OS doesn't know how to write that file. At he same time
> >> +      we copy runtime variables in DRAM and support GetVariableRT
> >> +
> >> +      Enable this option to allow SetVariableRT on the RAM backend of
> >> +      the EFI variable storate. The OS will be responsible for syncing
> >> +      the RAM contents to the file, otherwise any changes made during
> >> +      runtime won't persist reboots.
> >> +      Authenticated variables are not supported.
> >> +
> >>   config EFI_MM_COMM_TEE
> >>      bool "UEFI variables storage service via the trusted world"
> >>      depends on OPTEE
> >> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> >> index 18da6892e796..b38ce239e2d2 100644
> >> --- a/lib/efi_loader/efi_runtime.c
> >> +++ b/lib/efi_loader/efi_runtime.c
> >> @@ -126,6 +126,10 @@ efi_status_t efi_init_runtime_supported(void)
> >>                              EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
> >>                              EFI_RT_SUPPORTED_CONVERT_POINTER;
> >>
> >> +    if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
> >> +            rt_table->runtime_services_supported |=
> >> +                    EFI_RT_SUPPORTED_SET_VARIABLE;
> >> +
> >>      /*
> >>       * This value must be synced with efi_runtime_detach_list
> >>       * as well as efi_runtime_services.
> >> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> >> index 40f7a0fb10d5..3b770ff16971 100644
> >> --- a/lib/efi_loader/efi_variable.c
> >> +++ b/lib/efi_loader/efi_variable.c
> >> @@ -218,17 +218,21 @@ efi_get_next_variable_name_int(efi_uintn_t *variable_name_size,
> >>      return efi_get_next_variable_name_mem(variable_name_size, variable_name, vendor);
> >>   }
> >>
> >> -efi_status_t efi_set_variable_int(const u16 *variable_name,
> >> -                              const efi_guid_t *vendor,
> >> -                              u32 attributes, efi_uintn_t data_size,
> >> -                              const void *data, bool ro_check)
> >> +/**
> >> + * efi_check_setvariable() - checks defined by the UEFI spec for setvariable
> >> + *
> >> + * @variable_name:  name of the variable
> >> + * @vendor:         vendor GUID
> >> + * @attributes:             attributes of the variable
> >> + * @data_size:              size of the buffer with the variable value
> >> + * @data:           buffer with the variable value
> >> + * Return:          status code
> >> + */
> >> +static efi_status_t __efi_runtime EFIAPI
> >> +efi_check_setvariable(const u16 *variable_name, const efi_guid_t *vendor,
> >> +                  u32 attributes, efi_uintn_t data_size,
> >> +                  const void *data)
> >>   {
> >> -    struct efi_var_entry *var;
> >> -    efi_uintn_t ret;
> >> -    bool append, delete;
> >> -    u64 time = 0;
> >> -    enum efi_auth_var_type var_type;
> >> -
> >>      if (!variable_name || !*variable_name || !vendor)
> >>              return EFI_INVALID_PARAMETER;
> >>
> >> @@ -256,6 +260,25 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> >>           !(attributes & EFI_VARIABLE_BOOTSERVICE_ACCESS)))
> >>              return EFI_INVALID_PARAMETER;
> >>
> >> +    return EFI_SUCCESS;
> >> +}
> >> +
> >> +efi_status_t efi_set_variable_int(const u16 *variable_name,
> >> +                              const efi_guid_t *vendor,
> >> +                              u32 attributes, efi_uintn_t data_size,
> >> +                              const void *data, bool ro_check)
> >> +{
> >> +    struct efi_var_entry *var;
> >> +    efi_uintn_t ret;
> >> +    bool append, delete;
> >> +    u64 time = 0;
> >> +    enum efi_auth_var_type var_type;
> >> +
> >> +    ret = efi_check_setvariable(variable_name, vendor, attributes, data_size,
> >> +                                data);
> >> +    if (ret != EFI_SUCCESS)
> >> +            return ret;
> >> +
> >>      /* check if a variable exists */
> >>      var = efi_var_mem_find(vendor, variable_name, NULL);
> >>      append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> >> @@ -434,7 +457,72 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
> >>                       u32 attributes, efi_uintn_t data_size,
> >>                       const void *data)
> >>   {
> >> +#if IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)
> >> +    struct efi_var_entry *var;
> >> +    efi_uintn_t ret;
> >> +    bool append, delete;
> >> +    u64 time = 0;
> >> +
> >> +    /* Authenticated variables are not supported */
> >> +    if (attributes & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
> >> +                    return EFI_INVALID_PARAMETER;
> >> +
> >> +    ret = efi_check_setvariable(variable_name, vendor, attributes, data_size,
> >> +                                data);
> >> +    if (ret != EFI_SUCCESS)
> >> +            return ret;
> >> +
> >> +    /* check if a variable exists */
> >> +    var = efi_var_mem_find(vendor, variable_name, NULL);
> >> +    append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> >> +    attributes &= ~(u32)EFI_VARIABLE_APPEND_WRITE;
> >> +    delete = !append && (!data_size || !attributes);
> >> +
> >> +    if (var) {
> >> +            if (var->attr & EFI_VARIABLE_READ_ONLY)
> >> +                    return EFI_WRITE_PROTECTED;
> >> +
> >> +            /* attributes won't be changed */
> >> +            if (!delete && (((var->attr & ~(u32)EFI_VARIABLE_READ_ONLY) !=
> >> +                (attributes & ~(u32)EFI_VARIABLE_READ_ONLY))))
> >> +                    return EFI_INVALID_PARAMETER;
> >> +            time = var->time;
> >> +    } else {
> >> +            if (delete || append)
> >> +                    /*
> >> +                     * Trying to delete or to update a non-existent
> >> +                     * variable.
> >> +                     */
> >> +                    return EFI_NOT_FOUND;
> >> +    }
> >> +
> >> +    if (delete) {
> >> +            /* EFI_NOT_FOUND has been handled before */
> >> +            attributes = var->attr;
> >> +            ret = EFI_SUCCESS;
> >> +    } else if (append) {
> >> +            u16 *old_data = var->name;
> >> +
> >> +            for (; *old_data; ++old_data)
> >> +                    ;
> >> +            ++old_data;
> >> +            ret = efi_var_mem_ins(variable_name, vendor, attributes,
> >> +                                  var->length, old_data, data_size, data,
> >> +                                  time);
> >> +    } else {
> >> +            ret = efi_var_mem_ins(variable_name, vendor, attributes,
> >> +                                  data_size, data, 0, NULL, time);
> >> +    }
> >> +
> >> +    if (ret != EFI_SUCCESS)
> >> +            return ret;
> >> +    /* We are always inserting new variables, get rid of the old copy */
> >> +    efi_var_mem_del(var);
> >> +
> >> +    return EFI_SUCCESS;
> >> +#else
> >>      return EFI_UNSUPPORTED;
> >> +#endif
> >>   }
> >>
> >>   /**
> >> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> >> index 4700d9424105..6001b44989c8 100644
> >> --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> >> +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> >> @@ -62,9 +62,16 @@ static int execute(void)
> >>                                  EFI_VARIABLE_BOOTSERVICE_ACCESS |
> >>                                  EFI_VARIABLE_RUNTIME_ACCESS,
> >>                                  3, v + 4);
> >> -    if (ret != EFI_UNSUPPORTED) {
> >> -            efi_st_error("SetVariable failed\n");
> >> -            return EFI_ST_FAILURE;
> >> +    if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> >> +            if (ret != EFI_SUCCESS) {
> >> +                    efi_st_error("SetVariable failed\n");
> >> +                    return EFI_ST_FAILURE;
> >> +            }
> >> +    } else {
> >> +            if (ret != EFI_UNSUPPORTED) {
> >> +                    efi_st_error("SetVariable failed\n");
> >> +                    return EFI_ST_FAILURE;
> >> +            }
> >>      }
> >>      len = EFI_ST_MAX_DATA_SIZE;
> >>      ret = runtime->get_variable(u"PlatformLangCodes", &guid_vendor0,
> >> --
> >> 2.37.2
> >>
> >>
>
