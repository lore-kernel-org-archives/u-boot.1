Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6209C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 12:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48C9488453;
	Wed, 17 Apr 2024 14:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oxDy/Y+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D18B38845D; Wed, 17 Apr 2024 14:28:05 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DF0D882C4
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 14:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EAA213FB69
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 12:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713356879;
 bh=iSOjoU1TtQT2hbOk6Svtzw2hNNc/a5XCnn/4Gp2ZeOo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=oxDy/Y+14/h73F5319KrlveT+5K+OcABvIDNmWIAqS60+0b0SUsx02wi7TVJfdc2q
 0cqig2Ea9ITkLJEoqjQx4CzJFSm3HY8a6mhl1/dOmxyH5fcQHvsNj0Rep9Rqp+Ty80
 ZXiKVWSPfAh3OJcMgrYcHnZ1pOgxjyKnJ0NMW+XQ1VveWVCh7/B9Z8xlvP+rWOCn0k
 rba+ua2jcAV5O6CYWR8ZIlqnkOC8OItjO1eU2APGtfyVuZPH329RULHSZ80LmTg019
 05iiAfpvyzHtRlRfoNSB5nyjYgKCXdR++1MtAOkLiC4Tz34dwvzmKsgpA5XLz7X2nX
 mV1WChdDhAK0Q==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-416aea853e3so21105275e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 05:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713356879; x=1713961679;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iSOjoU1TtQT2hbOk6Svtzw2hNNc/a5XCnn/4Gp2ZeOo=;
 b=ZaYMtD5XA3vy+8vzrCquQ7zLgoZTxdOltya+3EyKiBrHD2vz4s+INFMbtBRDpG25pe
 JgLT8rO5XN7azauZplaInzdPplC0CuI1IWOg32FdcqUCyuDUBNXiOKtoeYatAMhFqjnx
 GddLaUwzG9Z/w3QJijedI8HkZB7K3dEeCpT3HwZgfIfDH0JSpvFkfrjvmOnxjDydJEMf
 iRiMtpg8CcDygxV2kdhcxyFW1jV24dl9jrW2g6jCfnNTAAEirtIcKda/N5yD7c5OzlFi
 mIJOX9UN8vQKazOsd0vL6pXMqw6RREVI9O7pFzrcyj/fvbQL9WUTUvgjjux9sLbROKIh
 88Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwb5d6ePUAjjGkf0/7zqQemGR/9gImWm7VE0eUNbT7poLrpu01qwkceImVQH7W0MonIEunuv+VI+ODnoHPGNjIvSbO3Q==
X-Gm-Message-State: AOJu0YxxRG7iBJ/xGAaMtzSr1tMIfIxcEJn7tUANgyzMPQnbTnKy4F4t
 r5DM1dLnpgrq8mXYyye3gphpO/QzdPaW4/Y6X1PkUb6dIPzv/saemOwjXMgjvLa5WgMIHC1tx7+
 AZtO/cpmzu+kjkNML4Y5ns2JhgaQLF9zmY5P/pT9I3MgIUanCerC478xRdAunlwNIQyM=
X-Received: by 2002:a05:600c:154b:b0:418:9941:cb78 with SMTP id
 f11-20020a05600c154b00b004189941cb78mr3290611wmg.13.1713356879371; 
 Wed, 17 Apr 2024 05:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsZTwFbH2ol6qQdv0v7cvDxtwty4HEuxiviN30NgdPjb4tuSj9nHfwSLsmTFaKQLBukfNzEQ==
X-Received: by 2002:a05:600c:154b:b0:418:9941:cb78 with SMTP id
 f11-20020a05600c154b00b004189941cb78mr3290592wmg.13.1713356878832; 
 Wed, 17 Apr 2024 05:27:58 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a5d4305000000b0033e91509224sm17394288wrq.22.2024.04.17.05.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 05:27:58 -0700 (PDT)
Message-ID: <747da8ef-33c4-40d6-9470-1e8ce5dbbb9e@canonical.com>
Date: Wed, 17 Apr 2024 14:27:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] efi_loader: conditionally enable SetvariableRT
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, kettenis@openbsd.org
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Janne Grunau <j@jannau.net>,
 Simon Glass <sjg@chromium.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sam Edwards <CFSworks@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240417101928.119115-1-ilias.apalodimas@linaro.org>
 <20240417101928.119115-2-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240417101928.119115-2-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 17.04.24 12:19, Ilias Apalodimas wrote:
> When we store EFI variables on file we don't allow SetVariable at runtime,
> since the OS doesn't know how to access or write that file.  At the same
> time keeping the U-Boot drivers alive in runtime sections and performing
> writes from the firmware is dangerous -- if at all possible.
> 
> For GetVariable at runtime we copy runtime variables in RAM and expose them
> to the OS. Add a Kconfig option and provide SetVariable at runtime using
> the same memory backend. The OS will be responsible for syncing the RAM
> contents to the file, otherwise any changes made during runtime won't
> persist reboots.
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
>          Non-Volatile
>          Boot Service Access
>          Runtime Service Access
> Value:
> 00000000  01 00
> 
> [0] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/Kconfig                        |  16 +++
>   lib/efi_loader/efi_runtime.c                  |   4 +
>   lib/efi_loader/efi_variable.c                 | 115 ++++++++++++++++--
>   .../efi_selftest_variables_runtime.c          |  13 +-
>   4 files changed, 134 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index e13a6f9f4c3a..cc8371a3bb4c 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -62,6 +62,22 @@ config EFI_VARIABLE_FILE_STORE
>   	  Select this option if you want non-volatile UEFI variables to be
>   	  stored as file /ubootefi.var on the EFI system partition.
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
> +	  the EFI variable storage. The OS will be responsible for syncing
> +	  the RAM contents to the file, otherwise any changes made during
> +	  runtime won't persist reboots.
> +	  Authenticated variables are not supported. Note that this will
> +	  violate the EFI spec since writing auth variables will return
> +	  EFI_INVALID_PARAMETER
> +
>   config EFI_MM_COMM_TEE
>   	bool "UEFI variables storage service via the trusted world"
>   	depends on OPTEE
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index a61c9a77b13f..dde083b09665 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -127,6 +127,10 @@ efi_status_t efi_init_runtime_supported(void)
>   				EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
>   				EFI_RT_SUPPORTED_CONVERT_POINTER;
>   
> +	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
> +		rt_table->runtime_services_supported |=
> +			EFI_RT_SUPPORTED_SET_VARIABLE;
> +
>   	/*
>   	 * This value must be synced with efi_runtime_detach_list
>   	 * as well as efi_runtime_services.
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index e6c1219a11c8..abc2a3402f42 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -219,17 +219,20 @@ efi_get_next_variable_name_int(efi_uintn_t *variable_name_size,
>   	return efi_get_next_variable_name_mem(variable_name_size, variable_name, vendor);
>   }
>   
> -efi_status_t efi_set_variable_int(const u16 *variable_name,
> -				  const efi_guid_t *vendor,
> -				  u32 attributes, efi_uintn_t data_size,
> -				  const void *data, bool ro_check)
> +/**
> + * setvariable_allowed() - checks defined by the UEFI spec for setvariable
> + *
> + * @variable_name:	name of the variable
> + * @vendor:		vendor GUID
> + * @attributes:		attributes of the variable
> + * @data_size:		size of the buffer with the variable value
> + * @data:		buffer with the variable value
> + * Return:		status code
> + */
> +static efi_status_t __efi_runtime
> +setvariable_allowed(const u16 *variable_name, const efi_guid_t *vendor,
> +		    u32 attributes, efi_uintn_t data_size, const void *data)
>   {
> -	struct efi_var_entry *var;
> -	efi_uintn_t ret;
> -	bool append, delete;
> -	u64 time = 0;
> -	enum efi_auth_var_type var_type;
> -
>   	if (!variable_name || !*variable_name || !vendor)
>   		return EFI_INVALID_PARAMETER;
>   
> @@ -261,6 +264,25 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>   	     !(attributes & EFI_VARIABLE_BOOTSERVICE_ACCESS)))
>   		return EFI_INVALID_PARAMETER;
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
> +	ret = setvariable_allowed(variable_name, vendor, attributes, data_size,
> +				  data);
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +
>   	/* check if a variable exists */
>   	var = efi_var_mem_find(vendor, variable_name, NULL);
>   	append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> @@ -454,7 +476,78 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
>   			 u32 attributes, efi_uintn_t data_size,
>   			 const void *data)
>   {
> -	return EFI_UNSUPPORTED;
> +	struct efi_var_entry *var;
> +	efi_uintn_t ret;
> +	bool append, delete;
> +	u64 time = 0;
> +
> +	if (!IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
> +		return EFI_UNSUPPORTED;
> +
> +	/*
> +	 * Authenticated variables are not supported. The EFI spec
> +	 * in §32.3.6 requires keys to be stored in non-volatile storage which
> +	 * is tamper and delete resistant.
> +	 * The rest of the checks are in setvariable_allowed()
> +	 */
> +	if (attributes & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
> +		return EFI_INVALID_PARAMETER;
> +	/* BS only variables are hidden deny writing them */
> +	if (!(attributes & EFI_VARIABLE_RUNTIME_ACCESS))
> +		return EFI_INVALID_PARAMETER;
> +
> +	ret = setvariable_allowed(variable_name, vendor, attributes, data_size,
> +				  data);
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +
> +	/* check if a variable exists */
> +	var = efi_var_mem_find(vendor, variable_name, NULL);
> +	append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> +	attributes &= ~EFI_VARIABLE_APPEND_WRITE;
> +	delete = !append && (!data_size || !attributes);
> +
> +	if (var) {
> +		if (var->attr & EFI_VARIABLE_READ_ONLY ||
> +		    !(var->attr & EFI_VARIABLE_NON_VOLATILE))
> +			return EFI_WRITE_PROTECTED;
> +
> +		/* attributes won't be changed */
> +		if (!delete && (((var->attr & ~EFI_VARIABLE_READ_ONLY) !=
> +		    (attributes & ~EFI_VARIABLE_READ_ONLY))))
> +			return EFI_INVALID_PARAMETER;
> +		time = var->time;
> +	} else {
> +		if (!(attributes & EFI_VARIABLE_NON_VOLATILE))
> +			return EFI_INVALID_PARAMETER;
> +		if (append && !data_size)
> +			return EFI_SUCCESS;
> +		if (delete)
> +			return EFI_NOT_FOUND;
> +	}
> +
> +	if (delete) {
> +		/* EFI_NOT_FOUND has been handled before */
> +		attributes = var->attr;
> +		ret = EFI_SUCCESS;
> +	} else if (append && var) {
> +		u16 *old_data = (void *)((uintptr_t)var->name +
> +			sizeof(u16) * (u16_strlen(var->name) + 1));
> +
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
>   }
>   
>   /**
> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> index 4700d9424105..4c9405c0a7c7 100644
> --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> @@ -62,9 +62,16 @@ static int execute(void)
>   				    EFI_VARIABLE_BOOTSERVICE_ACCESS |
>   				    EFI_VARIABLE_RUNTIME_ACCESS,
>   				    3, v + 4);
> -	if (ret != EFI_UNSUPPORTED) {
> -		efi_st_error("SetVariable failed\n");
> -		return EFI_ST_FAILURE;
> +	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> +		if (ret != EFI_INVALID_PARAMETER) {

A comment might be helpful here:

     /* At runtime only non-volatile variables may be set. */

Otherwise looks good to me.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +	} else {
> +		if (ret != EFI_UNSUPPORTED) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
>   	}
>   	len = EFI_ST_MAX_DATA_SIZE;
>   	ret = runtime->get_variable(u"PlatformLangCodes", &guid_vendor0,

