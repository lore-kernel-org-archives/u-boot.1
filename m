Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF88C05052
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 13:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C943C87E75;
	Wed, 17 Apr 2024 15:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="d6T8phuk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6DBD87EBD; Wed, 17 Apr 2024 15:04:19 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B76E87E74
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 15:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8CDF73F118
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 13:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713359054;
 bh=iNY77QlWVSu8rR2AoMxTnaMbDs7cv70UXbLWy4H88ao=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=d6T8phukDgAodpp6aQjWPM9kXgcWE1E7gGurfoBTYg+8+d44Zu/3c+FYA1wqHfps0
 64kzD1I+6oeDL0JAPKQtyLNLndVij7WK7xzrGFN2mXb64puMjSJB9sBAsSC2kJc2lj
 w08wxGbYNoeUfMtL3c2Rv3t69BJMeYdjMt1p81oq7zeTiaZD639byl8j87VT7DFMrV
 JGJRuMfe9xx0Q7BqSbilt9BAFCtKweJSS/SAY8UndRHSDOanTkt3cjxUj3VfGBfuDK
 iY3kKH7GuvCOpcWmTvq0qbz4xrXceaqbTbjkURHc+t5o32oBAml12lDxBTYa8qfPup
 c0NbcTUSLN5Rw==
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-516e6aa6bfcso4578709e87.3
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 06:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713359053; x=1713963853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iNY77QlWVSu8rR2AoMxTnaMbDs7cv70UXbLWy4H88ao=;
 b=oD/8aH3dYqVFqI/PbZ7VVV4IH3WBg0NwWXXbZ52E2UilW/mc4nmuUXHMLgmy2W2cN9
 Zmaxo/67RXLjE1b6t/krH/xC2AzM7LBtDh7RsNePRSLdHs03fGpx6r+o2xlfcarPT3qO
 4C7jRm541bkJ8UlLKVHz4ZeOf6yWf8yRLBBCgbt3ZmZioF8xrYx68ggg4pLmPWpfa7xc
 UkA2PfJ4HjRWlucSiUKE30UEHyETTlzcFJa4KWI/QCFkXAkG781zwvb7RjiujeJGWf+O
 ovCWts+7AUhASDOGFZ/VEJpDTuwMxaFbT4QrghiBwGQeOkpT82b/XO3gtdUY/4B9pQ5D
 qcdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC0VIl1VDVga11hflRQKn8yVmyFVav1p/KkDGKpO/8h9EaYl3Qjow455OHPy/QNi8H98oNIhUgoqw20ojcoJ3LO9ur2Q==
X-Gm-Message-State: AOJu0YyDGPBaPk9M5mCw9TgP+jqaa9n3ZCY1fpchigrN4D6SjfKULSeu
 6x/tvVT/x1xFrryANhANRc4xOWR9WCwttmE4s4mFoWf2UiO9E628AmSmnpuY4RjYpBY15OdY6K2
 SGSnZe1G+HtM+70p+eXmy0HGF2dlAb7swEpJJg9k/cOyrQzX5amPhtw/UaMHzmrs/TOc=
X-Received: by 2002:a19:8c49:0:b0:517:87ba:aff3 with SMTP id
 i9-20020a198c49000000b0051787baaff3mr10377815lfj.43.1713359053368; 
 Wed, 17 Apr 2024 06:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF46rv7Vg77kjSB7D2JzSOIRJ+/2Zdj44kAeR5+nnZUE6sNwrg6nzG3HX4+Kmm06bzZ6zSkuQ==
X-Received: by 2002:a19:8c49:0:b0:517:87ba:aff3 with SMTP id
 i9-20020a198c49000000b0051787baaff3mr10377798lfj.43.1713359052867; 
 Wed, 17 Apr 2024 06:04:12 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a05600c138500b0041628f694dfsm2792377wmf.23.2024.04.17.06.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 06:04:11 -0700 (PDT)
Message-ID: <9d352b5f-f190-4363-89fa-0b70bc938900@canonical.com>
Date: Wed, 17 Apr 2024 15:04:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] efi_loader: add an EFI variable with the file
 contents
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Weizhao Ouyang <o451686892@gmail.com>,
 u-boot@lists.denx.de, kettenis@openbsd.org,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240417101928.119115-1-ilias.apalodimas@linaro.org>
 <20240417101928.119115-4-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240417101928.119115-4-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> Previous patches enabled SetVariableRT using a RAM backend.
> Although EBBR [0] defines a variable format we can teach userspace tools
> and write the altered variables, it's better if we skip the ABI
> requirements completely.
> 
> So let's add a new variable, in its own namespace called "VarToFile"
> which contains a binary dump of the updated RT, BS and, NV variables
> and will be updated when GetVariable is called.
> 
> Some adjustments are needed to do that.
> Currently we discard BS-only variables in EBS(). We need to preserve
> those on the RAM backend that exposes the variables. Since BS-only
> variables can't appear at runtime we need to move the memory masking
> checks from efi_var_collect() to efi_get_next_variable_name_mem()/
> efi_get_variable_mem() and do the filtering at runtime.
> 
> We also need an efi_var_collect() variant available at runtime, in order
> to construct the "VarToFile" buffer on the fly.
> 
> All users and applications (for linux) have to do when updating a variable
> is dd that variable in the file described by "RTStorageVolatile".
> 
> Linux efivarfs uses a first 4 bytes of the output to represent attributes
> in little-endian format. So, storing variables works like this:
> 
> $~ efibootmgr -n 0001
> $~ dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c of=/boot/efi/ubootefi.var skip=4 bs=1
> 
> [0] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage
> 
> Co-developed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   include/efi_variable.h            |  14 ++-
>   lib/charset.c                     |   2 +-
>   lib/efi_loader/efi_runtime.c      |  19 ++++
>   lib/efi_loader/efi_var_common.c   |   6 +-
>   lib/efi_loader/efi_var_mem.c      | 146 ++++++++++++++++++------------
>   lib/efi_loader/efi_variable.c     |   6 +-
>   lib/efi_loader/efi_variable_tee.c |   5 -
>   7 files changed, 130 insertions(+), 68 deletions(-)
> 
> diff --git a/include/efi_variable.h b/include/efi_variable.h
> index 42a2b7c52bef..b545a36aac50 100644
> --- a/include/efi_variable.h
> +++ b/include/efi_variable.h
> @@ -271,13 +271,16 @@ const efi_guid_t *efi_auth_var_get_guid(const u16 *name);
>    *
>    * @variable_name_size:	size of variable_name buffer in bytes
>    * @variable_name:	name of uefi variable's name in u16
> + * @mask:		bitmask with required attributes of variables to be collected.
> + *                      variables are only collected if all of the required
> + *                      attributes match. Use 0 to skip matching
>    * @vendor:		vendor's guid
>    *
>    * Return: status code
>    */
>   efi_status_t __efi_runtime
>   efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size, u16 *variable_name,
> -			       efi_guid_t *vendor);
> +			       efi_guid_t *vendor, u32 mask);
>   /**
>    * efi_get_variable_mem() - Runtime common code across efi variable
>    *                          implementations for GetVariable() from
> @@ -289,12 +292,15 @@ efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size, u16 *variable_na
>    * @data_size:		size of the buffer to which the variable value is copied
>    * @data:		buffer to which the variable value is copied
>    * @timep:		authentication time (seconds since start of epoch)
> + * @mask:		bitmask with required attributes of variables to be collected.
> + *                      variables are only collected if all of the required
> + *                      attributes match. Use 0 to skip matching
>    * Return:		status code
>    */
>   efi_status_t __efi_runtime
>   efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>   		     u32 *attributes, efi_uintn_t *data_size, void *data,
> -		     u64 *timep);
> +		     u64 *timep, u32 mask);
>   
>   /**
>    * efi_get_variable_runtime() - runtime implementation of GetVariable()
> @@ -334,4 +340,8 @@ efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
>    */
>   void efi_var_buf_update(struct efi_var_file *var_buf);
>   
> +efi_status_t __efi_runtime efi_var_collect_mem(struct efi_var_file *buf,
> +					       efi_uintn_t *lenp,
> +					       u32 check_attr_mask);
> +
>   #endif
> diff --git a/lib/charset.c b/lib/charset.c
> index df4f04074852..182c92a50c48 100644
> --- a/lib/charset.c
> +++ b/lib/charset.c
> @@ -387,7 +387,7 @@ int u16_strcasecmp(const u16 *s1, const u16 *s2)
>    *		> 0 if the first different u16 in s1 is greater than the
>    *		corresponding u16 in s2
>    */
> -int u16_strncmp(const u16 *s1, const u16 *s2, size_t n)
> +int __efi_runtime u16_strncmp(const u16 *s1, const u16 *s2, size_t n)
>   {
>   	int ret = 0;
>   
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index c8f7a88ba8db..99ad1f35d8f1 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -130,6 +130,8 @@ efi_status_t efi_init_runtime_supported(void)
>   				EFI_RT_SUPPORTED_CONVERT_POINTER;
>   
>   	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> +		int s = 0;

u8 s = 0;
should be enough.

> +
>   		ret = efi_set_variable_int(u"RTStorageVolatile",
>   					   &efi_guid_efi_rt_var_file,
>   					   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> @@ -141,6 +143,23 @@ efi_status_t efi_init_runtime_supported(void)
>   			log_err("Failed to set RTStorageVolatile\n");
>   			return ret;
>   		}
> +		ret = efi_set_variable_int(u"VarToFile",
> +					   &efi_guid_efi_rt_var_file,
> +					   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					   EFI_VARIABLE_RUNTIME_ACCESS,

Why is the variable set here? A comment would be helpful.
If you set it for protection, shouldn't it be EFI_VARIABLE_READ_ONLY?

An alternative would be to return EFI_INVALID_PARAMETER in 
efi_set_variable_int for any attempt to set a variable with GUID 
efi_guid_efi_rt_var_file.

> +					   sizeof(s),
> +					   &s, false);
> +		if (ret != EFI_SUCCESS) {
> +			log_err("Failed to set VarToFile\n");
> +			efi_set_variable_int(u"RTStorageVolatile",
> +					     &efi_guid_efi_rt_var_file,
> +					     EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					     EFI_VARIABLE_RUNTIME_ACCESS |
> +					     EFI_VARIABLE_READ_ONLY,
> +					     0, NULL, false);
> +
> +			return ret;
> +		}
>   		rt_table->runtime_services_supported |= EFI_RT_SUPPORTED_SET_VARIABLE;
>   	}
>   
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> index aa8feffd3ec1..7862f2d6ce8a 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -182,7 +182,8 @@ efi_get_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
>   {
>   	efi_status_t ret;
>   
> -	ret = efi_get_variable_mem(variable_name, guid, attributes, data_size, data, NULL);
> +	ret = efi_get_variable_mem(variable_name, guid, attributes, data_size,
> +				   data, NULL, EFI_VARIABLE_RUNTIME_ACCESS);
>   
>   	/* Remove EFI_VARIABLE_READ_ONLY flag */
>   	if (attributes)
> @@ -195,7 +196,8 @@ efi_status_t __efi_runtime EFIAPI
>   efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
>   				   u16 *variable_name, efi_guid_t *guid)
>   {
> -	return efi_get_next_variable_name_mem(variable_name_size, variable_name, guid);
> +	return efi_get_next_variable_name_mem(variable_name_size, variable_name,
> +					      guid, EFI_VARIABLE_RUNTIME_ACCESS);
>   }
>   
>   /**
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index 6c21cec5d457..65ab858c926e 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -36,9 +36,11 @@ efi_var_mem_compare(struct efi_var_entry *var, const efi_guid_t *guid,
>   	const u16 *data, *var_name;
>   	bool match = true;
>   
> -	for (guid1 = (u8 *)&var->guid, guid2 = (u8 *)guid, i = 0;
> -	     i < sizeof(efi_guid_t) && match; ++i)
> -		match = (guid1[i] == guid2[i]);
> +	if (guid) {
> +		for (guid1 = (u8 *)&var->guid, guid2 = (u8 *)guid, i = 0;
> +			i < sizeof(efi_guid_t) && match; ++i)
> +			match = (guid1[i] == guid2[i]);
> +	}
>   
>   	for (data = var->name, var_name = name;; ++data) {
>   		if (match)
> @@ -184,53 +186,6 @@ u64 __efi_runtime efi_var_mem_free(void)
>   	       sizeof(struct efi_var_entry);
>   }
>   
> -/**
> - * efi_var_mem_bs_del() - delete boot service only variables
> - */
> -static void efi_var_mem_bs_del(void)
> -{
> -	struct efi_var_entry *var = efi_var_buf->var;
> -
> -	for (;;) {
> -		struct efi_var_entry *last;
> -
> -		last = (struct efi_var_entry *)
> -		       ((uintptr_t)efi_var_buf + efi_var_buf->length);
> -		if (var >= last)
> -			break;
> -		if (var->attr & EFI_VARIABLE_RUNTIME_ACCESS) {
> -			u16 *data;
> -
> -			/* skip variable */
> -			for (data = var->name; *data; ++data)
> -				;
> -			++data;
> -			var = (struct efi_var_entry *)
> -			      ALIGN((uintptr_t)data + var->length, 8);
> -		} else {
> -			/* delete variable */
> -			efi_var_mem_del(var);
> -		}
> -	}
> -}
> -
> -/**
> - * efi_var_mem_notify_exit_boot_services() - ExitBootService callback
> - *
> - * @event:	callback event
> - * @context:	callback context
> - */
> -static void EFIAPI
> -efi_var_mem_notify_exit_boot_services(struct efi_event *event, void *context)
> -{
> -	EFI_ENTRY("%p, %p", event, context);
> -
> -	/* Delete boot service only variables */
> -	efi_var_mem_bs_del();
> -
> -	EFI_EXIT(EFI_SUCCESS);
> -}
> -
>   /**
>    * efi_var_mem_notify_exit_boot_services() - SetVirtualMemoryMap callback
>    *
> @@ -261,11 +216,7 @@ efi_status_t efi_var_mem_init(void)
>   	efi_var_buf->magic = EFI_VAR_FILE_MAGIC;
>   	efi_var_buf->length = (uintptr_t)efi_var_buf->var -
>   			      (uintptr_t)efi_var_buf;
> -	/* crc32 for 0 bytes = 0 */
>   
> -	ret = efi_create_event(EVT_SIGNAL_EXIT_BOOT_SERVICES, TPL_CALLBACK,
> -			       efi_var_mem_notify_exit_boot_services, NULL,
> -			       NULL, &event);
>   	if (ret != EFI_SUCCESS)
>   		return ret;
>   	ret = efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE, TPL_CALLBACK,
> @@ -276,10 +227,75 @@ efi_status_t efi_var_mem_init(void)
>   	return ret;
>   }
>   
> +/**
> + * efi_var_collect_mem() - Copy EFI variables matching attributes mask from
> + *                         efi_var_buf
> + *
> + * @buf:	buffer containing variable collection
> + * @lenp:	buffer length
> + * @mask:	mask of matched attributes
> + *
> + * Return:	Status code
> + */
> +efi_status_t __efi_runtime
> +efi_var_collect_mem(struct efi_var_file *buf, efi_uintn_t *lenp, u32 mask)
> +{
> +	static struct efi_var_file __efi_runtime_data hdr = {
> +		.magic = EFI_VAR_FILE_MAGIC,
> +	};
> +	struct efi_var_entry *last, *var, *var_to;
> +
> +	hdr.length = sizeof(struct efi_var_file);
> +
> +	var = efi_var_buf->var;
> +	last = (struct efi_var_entry *)
> +	       ((uintptr_t)efi_var_buf + efi_var_buf->length);
> +	if (buf)
> +		var_to = buf->var;
> +
> +	while (var < last) {
> +		u32 len;
> +		struct efi_var_entry *var_next;
> +
> +		efi_var_mem_compare(var, NULL, u"", &var_next);

On IRC you suggested to make u16_strlen __efi_runtime_code to replace 
this efi_var_mem_compare() call and avoid the modifications of said 
function. That might be more readable.

Best regards

Heinrich

> +		len = (uintptr_t)var_next - (uintptr_t)var;
> +
> +		if ((var->attr & mask) != mask) {
> +			var = (void *)var + len;
> +			continue;
> +		}
> +
> +		hdr.length += len;
> +
> +		if (buf && hdr.length <= *lenp) {
> +			efi_memcpy_runtime(var_to, var, len);
> +			var_to = (void *)var_to + len;
> +		}
> +		var = (void *)var + len;
> +	}
> +
> +	if (!buf && hdr.length <= *lenp) {
> +		*lenp = hdr.length;
> +		return EFI_INVALID_PARAMETER;
> +	}
> +
> +	if (!buf || hdr.length > *lenp) {
> +		*lenp = hdr.length;
> +		return EFI_BUFFER_TOO_SMALL;
> +	}
> +	hdr.crc32 = crc32(0, (u8 *)buf->var,
> +			  hdr.length - sizeof(struct efi_var_file));
> +
> +	efi_memcpy_runtime(buf, &hdr, sizeof(hdr));
> +	*lenp = hdr.length;
> +
> +	return EFI_SUCCESS;
> +}
> +
>   efi_status_t __efi_runtime
>   efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>   		     u32 *attributes, efi_uintn_t *data_size, void *data,
> -		     u64 *timep)
> +		     u64 *timep, u32 mask)
>   {
>   	efi_uintn_t old_size;
>   	struct efi_var_entry *var;
> @@ -291,11 +307,22 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>   	if (!var)
>   		return EFI_NOT_FOUND;
>   
> +	/*
> +	 * This function is used at runtime to dump EFI variables.
> +	 * The memory backend we keep around has BS-only variables as
> +	 * well. At runtime we filter them here
> +	 */
> +	if (mask && !((var->attr & mask) == mask))
> +		return EFI_NOT_FOUND;
> +
>   	if (attributes)
>   		*attributes = var->attr;
>   	if (timep)
>   		*timep = var->time;
>   
> +	if (!u16_strcmp(variable_name, u"VarToFile"))
> +		return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
> +
>   	old_size = *data_size;
>   	*data_size = var->length;
>   	if (old_size < var->length)
> @@ -315,7 +342,8 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>   
>   efi_status_t __efi_runtime
>   efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size,
> -			       u16 *variable_name, efi_guid_t *vendor)
> +			       u16 *variable_name, efi_guid_t *vendor,
> +			       u32 mask)
>   {
>   	struct efi_var_entry *var;
>   	efi_uintn_t len, old_size;
> @@ -324,6 +352,7 @@ efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size,
>   	if (!variable_name_size || !variable_name || !vendor)
>   		return EFI_INVALID_PARAMETER;
>   
> +skip:
>   	len = *variable_name_size >> 1;
>   	if (u16_strnlen(variable_name, len) == len)
>   		return EFI_INVALID_PARAMETER;
> @@ -347,6 +376,11 @@ efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size,
>   	efi_memcpy_runtime(variable_name, var->name, *variable_name_size);
>   	efi_memcpy_runtime(vendor, &var->guid, sizeof(efi_guid_t));
>   
> +	if (mask && !((var->attr & mask) == mask)) {
> +		*variable_name_size = old_size;
> +		goto skip;
> +	}
> +
>   	return EFI_SUCCESS;
>   }
>   
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index abc2a3402f42..4aaa05a617d7 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -209,14 +209,16 @@ efi_get_variable_int(const u16 *variable_name, const efi_guid_t *vendor,
>   		     u32 *attributes, efi_uintn_t *data_size, void *data,
>   		     u64 *timep)
>   {
> -	return efi_get_variable_mem(variable_name, vendor, attributes, data_size, data, timep);
> +	return efi_get_variable_mem(variable_name, vendor, attributes, data_size,
> +				    data, timep, 0);
>   }
>   
>   efi_status_t __efi_runtime
>   efi_get_next_variable_name_int(efi_uintn_t *variable_name_size,
>   			       u16 *variable_name, efi_guid_t *vendor)
>   {
> -	return efi_get_next_variable_name_mem(variable_name_size, variable_name, vendor);
> +	return efi_get_next_variable_name_mem(variable_name_size, variable_name,
> +					      vendor, 0);
>   }
>   
>   /**
> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> index dde135fd9f81..4f1aa298da13 100644
> --- a/lib/efi_loader/efi_variable_tee.c
> +++ b/lib/efi_loader/efi_variable_tee.c
> @@ -959,11 +959,6 @@ void efi_variables_boot_exit_notify(void)
>   		log_err("Unable to notify the MM partition for ExitBootServices\n");
>   	free(comm_buf);
>   
> -	/*
> -	 * Populate the list for runtime variables.
> -	 * asking EFI_VARIABLE_RUNTIME_ACCESS is redundant, since
> -	 * efi_var_mem_notify_exit_boot_services will clean those, but that's fine
> -	 */
>   	ret = efi_var_collect(&var_buf, &len, EFI_VARIABLE_RUNTIME_ACCESS);
>   	if (ret != EFI_SUCCESS)
>   		log_err("Can't populate EFI variables. No runtime variables will be available\n");

