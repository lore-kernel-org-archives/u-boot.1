Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341A9C6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 11:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4547D881A1;
	Fri, 29 Mar 2024 12:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KluqE7xs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28B5F88243; Fri, 29 Mar 2024 12:02:17 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9256D87D1D
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 12:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d4979cd8c8so18494991fa.0
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 04:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711710134; x=1712314934; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m8hcnlSouVEuKFMbENjO/rlXyQJQQpCOleY2Q1v3j1E=;
 b=KluqE7xsCxcVMdDFs09XrG2VmFDGTBGrrTFQ1lUOwdvLxdlRxXk5nLgRMvDt/ntOFX
 BTfh6In9zGcob/VZ05aKOnuajPKwoD+1gHVMfSvWSU6psI0ofJ/qBt9hsp2orrtWegCJ
 i4i1gBgI5+LunJb+rgOZ3RzX1JVjlYb4K633D9CqmewvCB7X9kh1ZhxyNcropfCrIK/d
 /lPKoUaqfs+MGLt4QtuAS7sBch1V/F8+2muZ5yxGXt8xdstJ64XpDzGfVa+r9hCmuMzm
 3xZhxUHJsQOCGSqg85m4UUM3QDpLNmqP9GAd9VMmBQ4jcrI0u6nN+EVD1zGjTQ9UrdKp
 L5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711710134; x=1712314934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m8hcnlSouVEuKFMbENjO/rlXyQJQQpCOleY2Q1v3j1E=;
 b=JV4ykd/FBoPPboZZihO3y+yQicEIo3aD6WJg+afCSmZDawyTUNUGbeHthRrhCSZl/E
 zI6o5fdPWRidzvj2m6NdkOOaDj0dz8sCdjvj2AkCjs4WLpd5fz3UiEAiHb4+ukcqrUJJ
 3oomRv8gs5iasX9fNRLxOfvOousfi+x2G3vUCBiFBMlYqqw22l/BxpdMaeYGOh2NgS7L
 6i/bEL9gzknlOvHPMbop9XC+g/x5JZyMiQ1nDKYGbx9Tepc/ALA8QAuJHsASTZujOkJ4
 Cuqz1z1VVm+YJUlLxsBhs2sX9JJq1rATwNA9gFJzi5oVTLhbu/qt5cALjm+h93hKSw68
 xWnA==
X-Gm-Message-State: AOJu0Yx10UWSV2AobNn149i+aVlBB2LZYsg+BRRc2zuSERRcTDKBo5Z6
 KgQaO4zxQdDxJm8sIDUklmll4xXsUjO227vzugHfYRVUrRCM5rhpvjDKf5KcAylldEDuEJ4Cv2M
 CJ/UodgIqZd92Wp5rS4X5OloWK5hO8hBPBrdXog==
X-Google-Smtp-Source: AGHT+IFkdlQ6WUqMUr4h3vWiIs9Somea6brh1D+tVII9vYgLeVLXTk707i2hyQJn1bXrpFRAx+a9D2uyMOITsJ9Z6AI=
X-Received: by 2002:a2e:99d8:0:b0:2d4:8411:8b41 with SMTP id
 l24-20020a2e99d8000000b002d484118b41mr1733945ljj.17.1711710133689; Fri, 29
 Mar 2024 04:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240329071929.2461441-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240329071929.2461441-1-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 29 Mar 2024 13:01:36 +0200
Message-ID: <CAC_iWj+rR5grnfs29H+ZmvomJ5_U42i6pxf1h8HYuXGBGCZOZQ@mail.gmail.com>
Subject: Re: [RFC PATCH] efi_loader: conditionally enable SetvariableRT
To: ardb@kernel.org, kettenis@openbsd.org, pbrobinson@gmail.com, 
 xypron.glpk@gmx.de, Peter Jones <pjones@redhat.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, caleb.connolly@linaro.org, 
 sumit.garg@linaro.org, Simon Glass <sjg@chromium.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>
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

+cc Peter

On Fri, 29 Mar 2024 at 09:19, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> When EFI variables are stored on file we don't allow SetVariableRT,
> since the OS doesn't know how to access or write that file.  At the same
> time keeping the U-Boot drivers alive in runtime sections and performing
> writes from the firmware is dangerous -- if at all possible.
>
> For GetVariableRT  we copy runtime variables in RAM and expose them to
> the OS. Add a Kconfig option and provide SetVariableRT using the same
> memory backend. The OS will be responsible for syncing the RAM contents
> to the file, otherwise any changes made during runtime won't persist
> reboots.
>
> It's worth noting that the variable store format is defined in EBBR [0]
> and authenticated variables are explicitly prohibited, since they have
> to be stored on a medium that's tamper and rollback protected.
>
> - pre-patch
> $~ mount | grep efiva
> efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,noexec,relatime)
>
> $~ efibootmgr -n 0001
> Could not set BootNext: Read-only file system
>
> - post-patch
> $~ mount | grep efiva
> efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
>
> $~ efibootmgr -n 0001
> BootNext: 0001
> BootCurrent: 0000
> BootOrder: 0000,0001
> Boot0000* debian        HD(1,GPT,bdae5610-3331-4e4d-9466-acb5caf0b4a6,0x800,0x100000)/File(EFI\debian\grubaa64.efi)
> Boot0001* virtio 0      VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,850000001f000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600850000000000){auto_created_boot_option}
>
> $~ efivar -p -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-BootNext
> GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c
> Name: "BootNext"
> Attributes:
>         Non-Volatile
>         Boot Service Access
>         Runtime Service Access
> Value:
> 00000000  01 00
>
> [0] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage
>
> Open questions:
> Looking at the EFI spec, I can't find a documented way of notifying the OS
> that the storage is volatile. I would like to send a hint to the OS about
> that and I was thinking of adding a configuration table with the filename,
> which U-Boot expects to be on the ESP. Alternatively we could add a device
> path which would be a bit harder to parse from the userspace application,
> but safer in case multiple ESPs are present.

Replying to myself here, but after a discussion with Ard we could
- Add an EFI RO variable which contains the filename in the ESP u-boot
used to store the variables
- teach efivar/efibootmgr how to write that file
- When a SetVariable takes place, we first write the file and then
update the RAM backend

That's nice because distros won't have to do anything to enable it
apart from updating to newer versions of those binaries.

We also discussed having an entire copy of the variables in that RO
variable. That would make userspace life easier, as it would just have
to 'dd' that variable in the file. This is a bit trickier than it
sounds because the firmware needs to reason about the variables that
go in that 'megavariable' (only boottime/runtime, non-volatiles ones),
but it's still doable.

>
> Since I am not too familiar with how BSDs treat and expose config tables,
> we could instead add a RO efi variable with identical semantics, which
> would be easier to read from userspace.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/efi_loader/Kconfig                        |  14 +++
>  lib/efi_loader/efi_runtime.c                  |   4 +
>  lib/efi_loader/efi_variable.c                 | 108 ++++++++++++++++--
>  .../efi_selftest_variables_runtime.c          |  13 ++-
>  4 files changed, 126 insertions(+), 13 deletions(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index a7c3e05c13a0..c7f7383189e5 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -63,6 +63,20 @@ config EFI_VARIABLE_FILE_STORE
>           Select this option if you want non-volatile UEFI variables to be
>           stored as file /ubootefi.var on the EFI system partition.
>
> +config EFI_RT_VOLATILE_STORE
> +       bool "Allow variable runtime services in volatile storage (e.g RAM)"
> +       depends on EFI_VARIABLE_FILE_STORE
> +       help
> +         When EFI variables are stored on file we don't allow SetVariableRT,
> +         since the OS doesn't know how to write that file. At he same time
> +         we copy runtime variables in DRAM and support GetVariableRT
> +
> +         Enable this option to allow SetVariableRT on the RAM backend of
> +         the EFI variable storate. The OS will be responsible for syncing
> +         the RAM contents to the file, otherwise any changes made during
> +         runtime won't persist reboots.
> +         Authenticated variables are not supported.
> +
>  config EFI_MM_COMM_TEE
>         bool "UEFI variables storage service via the trusted world"
>         depends on OPTEE
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 18da6892e796..b38ce239e2d2 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -126,6 +126,10 @@ efi_status_t efi_init_runtime_supported(void)
>                                 EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
>                                 EFI_RT_SUPPORTED_CONVERT_POINTER;
>
> +       if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
> +               rt_table->runtime_services_supported |=
> +                       EFI_RT_SUPPORTED_SET_VARIABLE;
> +
>         /*
>          * This value must be synced with efi_runtime_detach_list
>          * as well as efi_runtime_services.
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index 40f7a0fb10d5..3b770ff16971 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -218,17 +218,21 @@ efi_get_next_variable_name_int(efi_uintn_t *variable_name_size,
>         return efi_get_next_variable_name_mem(variable_name_size, variable_name, vendor);
>  }
>
> -efi_status_t efi_set_variable_int(const u16 *variable_name,
> -                                 const efi_guid_t *vendor,
> -                                 u32 attributes, efi_uintn_t data_size,
> -                                 const void *data, bool ro_check)
> +/**
> + * efi_check_setvariable() - checks defined by the UEFI spec for setvariable
> + *
> + * @variable_name:     name of the variable
> + * @vendor:            vendor GUID
> + * @attributes:                attributes of the variable
> + * @data_size:         size of the buffer with the variable value
> + * @data:              buffer with the variable value
> + * Return:             status code
> + */
> +static efi_status_t __efi_runtime EFIAPI
> +efi_check_setvariable(const u16 *variable_name, const efi_guid_t *vendor,
> +                     u32 attributes, efi_uintn_t data_size,
> +                     const void *data)
>  {
> -       struct efi_var_entry *var;
> -       efi_uintn_t ret;
> -       bool append, delete;
> -       u64 time = 0;
> -       enum efi_auth_var_type var_type;
> -
>         if (!variable_name || !*variable_name || !vendor)
>                 return EFI_INVALID_PARAMETER;
>
> @@ -256,6 +260,25 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>              !(attributes & EFI_VARIABLE_BOOTSERVICE_ACCESS)))
>                 return EFI_INVALID_PARAMETER;
>
> +       return EFI_SUCCESS;
> +}
> +
> +efi_status_t efi_set_variable_int(const u16 *variable_name,
> +                                 const efi_guid_t *vendor,
> +                                 u32 attributes, efi_uintn_t data_size,
> +                                 const void *data, bool ro_check)
> +{
> +       struct efi_var_entry *var;
> +       efi_uintn_t ret;
> +       bool append, delete;
> +       u64 time = 0;
> +       enum efi_auth_var_type var_type;
> +
> +       ret = efi_check_setvariable(variable_name, vendor, attributes, data_size,
> +                                   data);
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
>         /* check if a variable exists */
>         var = efi_var_mem_find(vendor, variable_name, NULL);
>         append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> @@ -434,7 +457,72 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
>                          u32 attributes, efi_uintn_t data_size,
>                          const void *data)
>  {
> +#if IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)
> +       struct efi_var_entry *var;
> +       efi_uintn_t ret;
> +       bool append, delete;
> +       u64 time = 0;
> +
> +       /* Authenticated variables are not supported */
> +       if (attributes & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
> +                       return EFI_INVALID_PARAMETER;
> +
> +       ret = efi_check_setvariable(variable_name, vendor, attributes, data_size,
> +                                   data);
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
> +       /* check if a variable exists */
> +       var = efi_var_mem_find(vendor, variable_name, NULL);
> +       append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> +       attributes &= ~(u32)EFI_VARIABLE_APPEND_WRITE;
> +       delete = !append && (!data_size || !attributes);
> +
> +       if (var) {
> +               if (var->attr & EFI_VARIABLE_READ_ONLY)
> +                       return EFI_WRITE_PROTECTED;
> +
> +               /* attributes won't be changed */
> +               if (!delete && (((var->attr & ~(u32)EFI_VARIABLE_READ_ONLY) !=
> +                   (attributes & ~(u32)EFI_VARIABLE_READ_ONLY))))
> +                       return EFI_INVALID_PARAMETER;
> +               time = var->time;
> +       } else {
> +               if (delete || append)
> +                       /*
> +                        * Trying to delete or to update a non-existent
> +                        * variable.
> +                        */
> +                       return EFI_NOT_FOUND;
> +       }
> +
> +       if (delete) {
> +               /* EFI_NOT_FOUND has been handled before */
> +               attributes = var->attr;
> +               ret = EFI_SUCCESS;
> +       } else if (append) {
> +               u16 *old_data = var->name;
> +
> +               for (; *old_data; ++old_data)
> +                       ;
> +               ++old_data;
> +               ret = efi_var_mem_ins(variable_name, vendor, attributes,
> +                                     var->length, old_data, data_size, data,
> +                                     time);
> +       } else {
> +               ret = efi_var_mem_ins(variable_name, vendor, attributes,
> +                                     data_size, data, 0, NULL, time);
> +       }
> +
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +       /* We are always inserting new variables, get rid of the old copy */
> +       efi_var_mem_del(var);
> +
> +       return EFI_SUCCESS;
> +#else
>         return EFI_UNSUPPORTED;
> +#endif
>  }
>
>  /**
> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> index 4700d9424105..6001b44989c8 100644
> --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> @@ -62,9 +62,16 @@ static int execute(void)
>                                     EFI_VARIABLE_BOOTSERVICE_ACCESS |
>                                     EFI_VARIABLE_RUNTIME_ACCESS,
>                                     3, v + 4);
> -       if (ret != EFI_UNSUPPORTED) {
> -               efi_st_error("SetVariable failed\n");
> -               return EFI_ST_FAILURE;
> +       if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> +               if (ret != EFI_SUCCESS) {
> +                       efi_st_error("SetVariable failed\n");
> +                       return EFI_ST_FAILURE;
> +               }
> +       } else {
> +               if (ret != EFI_UNSUPPORTED) {
> +                       efi_st_error("SetVariable failed\n");
> +                       return EFI_ST_FAILURE;
> +               }
>         }
>         len = EFI_ST_MAX_DATA_SIZE;
>         ret = runtime->get_variable(u"PlatformLangCodes", &guid_vendor0,
> --
> 2.37.2
>
