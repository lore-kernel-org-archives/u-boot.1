Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9835C6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 12:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 327E48822D;
	Fri, 29 Mar 2024 13:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="eO1SCueU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1763688234; Fri, 29 Mar 2024 13:25:27 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FFC788203
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 13:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 539edf13-edc7-11ee-b571-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 539edf13-edc7-11ee-b571-005056992ed3;
 Fri, 29 Mar 2024 13:24:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=MVAhuazbfiK2BX2KZ9P+uB43f6OILa9bD/yzVb+vWY4=;
 b=eO1SCueU6KagydbuwjKwBQfSHatEXs5Er20K1mfSO55BnAyo5ZgzGQiRsMyPcVHN6HH6c32AJHmsu
 BS0BfHoB86jEUWnqHYOSwPRsbT4kF55XumPIrN9YclNaI/RvPJCAk3mwwK54RAP4wpKu+LxN94QVh6
 C/REe79cLPdrnyadvUvo+zd4xCsPZUxEcJ/UUI+C/xmpSCT4ay2pnDYB7eGMs5wFAhFrt1M7v9aTGG
 njNWn46UpRia0iEYNx5huKr3V+m0H9xPWwRO1AKM5VPaNZpurxVnrgoQm+nMENCLjbzf5+cqiZoL8m
 BRc16olfXKUMIp/mLzMjrsi6/JmdotQ==
X-KPN-MID: 33|wCGSeARN7dsgyjJMXjroU4zj+uvJjcDN6oDUXb7We+7ih01VhWArt/ID8id1qdO
 EXaaNdQDtX9BmZZec2Trcd3ywj6Dut2PXLn9ak6UcaB4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|9jQH/ZPXtMaxYgh7qo6WWjBkOZ3QfPnlPHFV26UZb6y31qW2ETv4iDpgNWkCHGZ
 8iRfSXryXy388ZVZuhrGxXQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 69822b0e-edc7-11ee-896c-00505699d6e5;
 Fri, 29 Mar 2024 13:25:22 +0100 (CET)
Date: Fri, 29 Mar 2024 13:25:21 +0100
Message-Id: <87msqh8bta.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: ardb@kernel.org, kettenis@openbsd.org, pbrobinson@gmail.com,
 xypron.glpk@gmx.de, u-boot@lists.denx.de, trini@konsulko.com,
 caleb.connolly@linaro.org, sumit.garg@linaro.org,
 ilias.apalodimas@linaro.org, sjg@chromium.org,
 abdellatif.elkhlifi@arm.com, takahiro.akashi@linaro.org,
 sughosh.ganu@linaro.org, kojima.masahisa@socionext.com, bmeng@tinylab.org
In-Reply-To: <20240329071929.2461441-1-ilias.apalodimas@linaro.org> (message
 from Ilias Apalodimas on Fri, 29 Mar 2024 09:19:27 +0200)
Subject: Re: [RFC PATCH] efi_loader: conditionally enable SetvariableRT
References: <20240329071929.2461441-1-ilias.apalodimas@linaro.org>
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

> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Date: Fri, 29 Mar 2024 09:19:27 +0200
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

Should there be a way for the OS to opt-in to this new behaviour?

> Since I am not too familiar with how BSDs treat and expose config tables,
> we could instead add a RO efi variable with identical semantics, which
> would be easier to read from userspace.

There is an EFIIOC_GET_TABLE ioctl that allows retreiving a table by GUID.


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
>  	  Select this option if you want non-volatile UEFI variables to be
>  	  stored as file /ubootefi.var on the EFI system partition.
> 
> +config EFI_RT_VOLATILE_STORE
> +	bool "Allow variable runtime services in volatile storage (e.g RAM)"
> +	depends on EFI_VARIABLE_FILE_STORE
> +	help
> +	  When EFI variables are stored on file we don't allow SetVariableRT,
> +	  since the OS doesn't know how to write that file. At he same time
> +	  we copy runtime variables in DRAM and support GetVariableRT
> +
> +	  Enable this option to allow SetVariableRT on the RAM backend of
> +	  the EFI variable storate. The OS will be responsible for syncing
> +	  the RAM contents to the file, otherwise any changes made during
> +	  runtime won't persist reboots.
> +	  Authenticated variables are not supported.
> +
>  config EFI_MM_COMM_TEE
>  	bool "UEFI variables storage service via the trusted world"
>  	depends on OPTEE
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 18da6892e796..b38ce239e2d2 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -126,6 +126,10 @@ efi_status_t efi_init_runtime_supported(void)
>  				EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
>  				EFI_RT_SUPPORTED_CONVERT_POINTER;
> 
> +	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
> +		rt_table->runtime_services_supported |=
> +			EFI_RT_SUPPORTED_SET_VARIABLE;
> +
>  	/*
>  	 * This value must be synced with efi_runtime_detach_list
>  	 * as well as efi_runtime_services.
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index 40f7a0fb10d5..3b770ff16971 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -218,17 +218,21 @@ efi_get_next_variable_name_int(efi_uintn_t *variable_name_size,
>  	return efi_get_next_variable_name_mem(variable_name_size, variable_name, vendor);
>  }
> 
> -efi_status_t efi_set_variable_int(const u16 *variable_name,
> -				  const efi_guid_t *vendor,
> -				  u32 attributes, efi_uintn_t data_size,
> -				  const void *data, bool ro_check)
> +/**
> + * efi_check_setvariable() - checks defined by the UEFI spec for setvariable
> + *
> + * @variable_name:	name of the variable
> + * @vendor:		vendor GUID
> + * @attributes:		attributes of the variable
> + * @data_size:		size of the buffer with the variable value
> + * @data:		buffer with the variable value
> + * Return:		status code
> + */
> +static efi_status_t __efi_runtime EFIAPI
> +efi_check_setvariable(const u16 *variable_name, const efi_guid_t *vendor,
> +		      u32 attributes, efi_uintn_t data_size,
> +		      const void *data)
>  {
> -	struct efi_var_entry *var;
> -	efi_uintn_t ret;
> -	bool append, delete;
> -	u64 time = 0;
> -	enum efi_auth_var_type var_type;
> -
>  	if (!variable_name || !*variable_name || !vendor)
>  		return EFI_INVALID_PARAMETER;
> 
> @@ -256,6 +260,25 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>  	     !(attributes & EFI_VARIABLE_BOOTSERVICE_ACCESS)))
>  		return EFI_INVALID_PARAMETER;
> 
> +	return EFI_SUCCESS;
> +}
> +
> +efi_status_t efi_set_variable_int(const u16 *variable_name,
> +				  const efi_guid_t *vendor,
> +				  u32 attributes, efi_uintn_t data_size,
> +				  const void *data, bool ro_check)
> +{
> +	struct efi_var_entry *var;
> +	efi_uintn_t ret;
> +	bool append, delete;
> +	u64 time = 0;
> +	enum efi_auth_var_type var_type;
> +
> +	ret = efi_check_setvariable(variable_name, vendor, attributes, data_size,
> +				    data);
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +
>  	/* check if a variable exists */
>  	var = efi_var_mem_find(vendor, variable_name, NULL);
>  	append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> @@ -434,7 +457,72 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
>  			 u32 attributes, efi_uintn_t data_size,
>  			 const void *data)
>  {
> +#if IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)
> +	struct efi_var_entry *var;
> +	efi_uintn_t ret;
> +	bool append, delete;
> +	u64 time = 0;
> +
> +	/* Authenticated variables are not supported */
> +	if (attributes & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
> +			return EFI_INVALID_PARAMETER;
> +
> +	ret = efi_check_setvariable(variable_name, vendor, attributes, data_size,
> +				    data);
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +
> +	/* check if a variable exists */
> +	var = efi_var_mem_find(vendor, variable_name, NULL);
> +	append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> +	attributes &= ~(u32)EFI_VARIABLE_APPEND_WRITE;
> +	delete = !append && (!data_size || !attributes);
> +
> +	if (var) {
> +		if (var->attr & EFI_VARIABLE_READ_ONLY)
> +			return EFI_WRITE_PROTECTED;
> +
> +		/* attributes won't be changed */
> +		if (!delete && (((var->attr & ~(u32)EFI_VARIABLE_READ_ONLY) !=
> +		    (attributes & ~(u32)EFI_VARIABLE_READ_ONLY))))
> +			return EFI_INVALID_PARAMETER;
> +		time = var->time;
> +	} else {
> +		if (delete || append)
> +			/*
> +			 * Trying to delete or to update a non-existent
> +			 * variable.
> +			 */
> +			return EFI_NOT_FOUND;
> +	}
> +
> +	if (delete) {
> +		/* EFI_NOT_FOUND has been handled before */
> +		attributes = var->attr;
> +		ret = EFI_SUCCESS;
> +	} else if (append) {
> +		u16 *old_data = var->name;
> +
> +		for (; *old_data; ++old_data)
> +			;
> +		++old_data;
> +		ret = efi_var_mem_ins(variable_name, vendor, attributes,
> +				      var->length, old_data, data_size, data,
> +				      time);
> +	} else {
> +		ret = efi_var_mem_ins(variable_name, vendor, attributes,
> +				      data_size, data, 0, NULL, time);
> +	}
> +
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +	/* We are always inserting new variables, get rid of the old copy */
> +	efi_var_mem_del(var);
> +
> +	return EFI_SUCCESS;
> +#else
>  	return EFI_UNSUPPORTED;
> +#endif
>  }
> 
>  /**
> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> index 4700d9424105..6001b44989c8 100644
> --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> @@ -62,9 +62,16 @@ static int execute(void)
>  				    EFI_VARIABLE_BOOTSERVICE_ACCESS |
>  				    EFI_VARIABLE_RUNTIME_ACCESS,
>  				    3, v + 4);
> -	if (ret != EFI_UNSUPPORTED) {
> -		efi_st_error("SetVariable failed\n");
> -		return EFI_ST_FAILURE;
> +	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> +		if (ret != EFI_SUCCESS) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +	} else {
> +		if (ret != EFI_UNSUPPORTED) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
>  	}
>  	len = EFI_ST_MAX_DATA_SIZE;
>  	ret = runtime->get_variable(u"PlatformLangCodes", &guid_vendor0,
> --
> 2.37.2
> 
> 
