Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97424C6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 12:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D74A588243;
	Fri, 29 Mar 2024 13:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kGRcmAuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98C3C8824D; Fri, 29 Mar 2024 13:57:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34E318823C
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 13:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711717029; x=1712321829; i=xypron.glpk@gmx.de;
 bh=14BfY2OgpWyj9gMhThLv414/b+0Q3ipbdTiPXoG10jI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=kGRcmAuwecjMOUSilBOkfQYkIUo5sCGBMoYXGthmPcS1Y2yWXVu3JR2DNk+lGblI
 btEtgRbdHPiVE/ojBY/qD1uKtjXAoyGymnyGDIWWxEPw2PfvuY30bM7zNpQiidtKi
 v3JjgyjvrXrd4vqWRQ7Rpjn+D2rZi+51S3LZnqC/gQV+2qh/a5EPrB/W63oYG64Jo
 IsZP+V/+R/xe4Fi23P5ZPtGknxWHmbRbVjAdQIqHWqbtyhAg9rt5s3eTYVFn41nQI
 6e0G70NnqeV3oWbW5MB1efTogt0fKLhI+RIOCETV5w+RDiDvZGkU5EbKKLAZTZaa2
 gYI2JiP0wEkNn6wIcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUmD-1rzm260aZb-00CvoC; Fri, 29
 Mar 2024 13:57:09 +0100
Message-ID: <9ef1225a-a5d8-431c-b281-20c521614356@gmx.de>
Date: Fri, 29 Mar 2024 13:57:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] efi_loader: conditionally enable SetvariableRT
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: ardb@kernel.org, kettenis@openbsd.org, pbrobinson@gmail.com,
 xypron.glpk@gmx.de, u-boot@lists.denx.de, trini@konsulko.com,
 caleb.connolly@linaro.org, sumit.garg@linaro.org, sjg@chromium.org,
 abdellatif.elkhlifi@arm.com, takahiro.akashi@linaro.org,
 sughosh.ganu@linaro.org, kojima.masahisa@socionext.com, bmeng@tinylab.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240329071929.2461441-1-ilias.apalodimas@linaro.org>
 <87msqh8bta.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <87msqh8bta.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hNNGlxP8uAbTQwZ6zw1QjApecEWilRy9wYWLv3PQ4RCaTYhNOTL
 Xr2HPJlg7eHgyoxYNwKz9IBdLUxFYgx04njK4jTSBNEP2iYIilQOYLdKdEoFC+qWAMMhbJJ
 CVuEFVJTDeF8PfVUylmN1gw3R55C0oyELmt7Wy8pRo013MRu8wwxDBudeAqIzleOgMe8fhP
 UMhcFjfF+hv6HTBXN3Cgw==
UI-OutboundReport: notjunk:1;M01:P0:peQN+KBO1IA=;+35uQBdssBcl1QzC/eX+UPrW+Yf
 Bdes1tMOqiGG92H+4p2o644Am9O6dbNBUQYUBy7ey0WstSkji8PydQ3hM6P/tLnzkxW2Kb/14
 wbcJK02iXr9jTuUHS2+NfVKLrj7u+df46l40x/JVckGDzaUCbpxScRUrkVwBPgkrMoZrfPBBE
 zyfrWw/spihhMRG5sp5Achxiixs15WcYXd+D3gdjhbi9sL/z0JQwPyo75gCEgsQnmVA0xneEE
 3fz7UapDP0MYpFcj+m3KHgxjH0PwPPSsVfAzOJFwRs2efadQEPcUsaeVhstrcjLPbn04Py+cZ
 nEgAmXNqlAt0PrzU8F/DCp2ZNWPsaMYB/vmDRzBw81HySpfx/VdApBAGovkU+pBG1+gZDEApj
 tBowHHNiP/3prL+9wHJvSWOmjX4OkrajqJKDe8vNwfRIGkp76TyKrpUap8VQV6L8sUOUj60Gp
 OKnuGjkNhWJs2oQXiCtOIkcL9T9HYABIRPaqF8hzmyfO2EZh+5DV9PlU8T/hI4U59vRvad3r+
 fI6IjjE2pkLh9szm1bXQW6qaCOJdXzEyp4Zy08MEBOAK1+w/a1a7DglLLUtK62wDCpF7rbDja
 O96Ci9ITmwsP3vVqvXgazc8T/NGaHSQNDO7FMo2W8CZ1uazEpbIzy0PMK+xMkCpdho5ZJm2pg
 I3bYwE7bU8PzoLvNyqeKCM7UPhByieTr7kNED50icwSfINrFfD2CPMFSlrG9UB/PTi1tjfl3y
 UdwLbyBa9Q7h6zlCTpZxobruD4EABcndLKSHE0wp2yobNAEiVuRSMHbqlAUf/Yikq0SicGDLW
 YoLYgKi+hNIPcvSm/t+8xtMytTsOZ+jQtoXU3BDfVA/ME=
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

On 3/29/24 13:25, Mark Kettenis wrote:
>> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Date: Fri, 29 Mar 2024 09:19:27 +0200
>>
>> When EFI variables are stored on file we don't allow SetVariableRT,
>> since the OS doesn't know how to access or write that file.  At the sam=
e
>> time keeping the U-Boot drivers alive in runtime sections and performin=
g
>> writes from the firmware is dangerous -- if at all possible.
>>
>> For GetVariableRT  we copy runtime variables in RAM and expose them to
>> the OS. Add a Kconfig option and provide SetVariableRT using the same
>> memory backend. The OS will be responsible for syncing the RAM contents
>> to the file, otherwise any changes made during runtime won't persist
>> reboots.
>>
>> It's worth noting that the variable store format is defined in EBBR [0]
>> and authenticated variables are explicitly prohibited, since they have
>> to be stored on a medium that's tamper and rollback protected.
>>
>> - pre-patch
>> $~ mount | grep efiva
>> efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,no=
exec,relatime)
>>
>> $~ efibootmgr -n 0001
>> Could not set BootNext: Read-only file system
>>
>> - post-patch
>> $~ mount | grep efiva
>> efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,no=
exec,relatime)
>>
>> $~ efibootmgr -n 0001
>> BootNext: 0001
>> BootCurrent: 0000
>> BootOrder: 0000,0001
>> Boot0000* debian        HD(1,GPT,bdae5610-3331-4e4d-9466-acb5caf0b4a6,0=
x800,0x100000)/File(EFI\debian\grubaa64.efi)
>> Boot0001* virtio 0      VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000=
000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,850000001f000000)=
/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600850000000000){auto_created=
_boot_option}
>>
>> $~ efivar -p -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-BootNext
>> GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c
>> Name: "BootNext"
>> Attributes:
>>          Non-Volatile
>>          Boot Service Access
>>          Runtime Service Access
>> Value:
>> 00000000  01 00
>>
>> [0] https://arm-software.github.io/ebbr/index.html#document-chapter5-va=
riable-storage
>>
>> Open questions:
>> Looking at the EFI spec, I can't find a documented way of notifying the=
 OS
>> that the storage is volatile. I would like to send a hint to the OS abo=
ut
>> that and I was thinking of adding a configuration table with the filena=
me,
>> which U-Boot expects to be on the ESP. Alternatively we could add a dev=
ice
>> path which would be a bit harder to parse from the userspace applicatio=
n,
>> but safer in case multiple ESPs are present.
>
> Should there be a way for the OS to opt-in to this new behaviour?

With the patch you could handle persisting variables in user space
without any modifications of the OS. E.g. use fanotify to watch all
efivarfs mounts in Linux.

Ilias has also been considering a Linux driver for file based variables
inside the OS but then you wouldn't need this patch.

>
>> Since I am not too familiar with how BSDs treat and expose config table=
s,
>> we could instead add a RO efi variable with identical semantics, which
>> would be easier to read from userspace.
>
> There is an EFIIOC_GET_TABLE ioctl that allows retreiving a table by GUI=
D.

This seems to be BSD specific.

@Ilias: How would you read a configuration from user space in Linux?

Best regards

Heinrich

>
>
>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>>   lib/efi_loader/Kconfig                        |  14 +++
>>   lib/efi_loader/efi_runtime.c                  |   4 +
>>   lib/efi_loader/efi_variable.c                 | 108 ++++++++++++++++-=
-
>>   .../efi_selftest_variables_runtime.c          |  13 ++-
>>   4 files changed, 126 insertions(+), 13 deletions(-)
>>
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index a7c3e05c13a0..c7f7383189e5 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -63,6 +63,20 @@ config EFI_VARIABLE_FILE_STORE
>>   	  Select this option if you want non-volatile UEFI variables to be
>>   	  stored as file /ubootefi.var on the EFI system partition.
>>
>> +config EFI_RT_VOLATILE_STORE
>> +	bool "Allow variable runtime services in volatile storage (e.g RAM)"
>> +	depends on EFI_VARIABLE_FILE_STORE
>> +	help
>> +	  When EFI variables are stored on file we don't allow SetVariableRT,
>> +	  since the OS doesn't know how to write that file. At he same time
>> +	  we copy runtime variables in DRAM and support GetVariableRT
>> +
>> +	  Enable this option to allow SetVariableRT on the RAM backend of
>> +	  the EFI variable storate. The OS will be responsible for syncing
>> +	  the RAM contents to the file, otherwise any changes made during
>> +	  runtime won't persist reboots.
>> +	  Authenticated variables are not supported.
>> +
>>   config EFI_MM_COMM_TEE
>>   	bool "UEFI variables storage service via the trusted world"
>>   	depends on OPTEE
>> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.=
c
>> index 18da6892e796..b38ce239e2d2 100644
>> --- a/lib/efi_loader/efi_runtime.c
>> +++ b/lib/efi_loader/efi_runtime.c
>> @@ -126,6 +126,10 @@ efi_status_t efi_init_runtime_supported(void)
>>   				EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
>>   				EFI_RT_SUPPORTED_CONVERT_POINTER;
>>
>> +	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
>> +		rt_table->runtime_services_supported |=3D
>> +			EFI_RT_SUPPORTED_SET_VARIABLE;
>> +
>>   	/*
>>   	 * This value must be synced with efi_runtime_detach_list
>>   	 * as well as efi_runtime_services.
>> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variabl=
e.c
>> index 40f7a0fb10d5..3b770ff16971 100644
>> --- a/lib/efi_loader/efi_variable.c
>> +++ b/lib/efi_loader/efi_variable.c
>> @@ -218,17 +218,21 @@ efi_get_next_variable_name_int(efi_uintn_t *varia=
ble_name_size,
>>   	return efi_get_next_variable_name_mem(variable_name_size, variable_n=
ame, vendor);
>>   }
>>
>> -efi_status_t efi_set_variable_int(const u16 *variable_name,
>> -				  const efi_guid_t *vendor,
>> -				  u32 attributes, efi_uintn_t data_size,
>> -				  const void *data, bool ro_check)
>> +/**
>> + * efi_check_setvariable() - checks defined by the UEFI spec for setva=
riable
>> + *
>> + * @variable_name:	name of the variable
>> + * @vendor:		vendor GUID
>> + * @attributes:		attributes of the variable
>> + * @data_size:		size of the buffer with the variable value
>> + * @data:		buffer with the variable value
>> + * Return:		status code
>> + */
>> +static efi_status_t __efi_runtime EFIAPI
>> +efi_check_setvariable(const u16 *variable_name, const efi_guid_t *vend=
or,
>> +		      u32 attributes, efi_uintn_t data_size,
>> +		      const void *data)
>>   {
>> -	struct efi_var_entry *var;
>> -	efi_uintn_t ret;
>> -	bool append, delete;
>> -	u64 time =3D 0;
>> -	enum efi_auth_var_type var_type;
>> -
>>   	if (!variable_name || !*variable_name || !vendor)
>>   		return EFI_INVALID_PARAMETER;
>>
>> @@ -256,6 +260,25 @@ efi_status_t efi_set_variable_int(const u16 *varia=
ble_name,
>>   	     !(attributes & EFI_VARIABLE_BOOTSERVICE_ACCESS)))
>>   		return EFI_INVALID_PARAMETER;
>>
>> +	return EFI_SUCCESS;
>> +}
>> +
>> +efi_status_t efi_set_variable_int(const u16 *variable_name,
>> +				  const efi_guid_t *vendor,
>> +				  u32 attributes, efi_uintn_t data_size,
>> +				  const void *data, bool ro_check)
>> +{
>> +	struct efi_var_entry *var;
>> +	efi_uintn_t ret;
>> +	bool append, delete;
>> +	u64 time =3D 0;
>> +	enum efi_auth_var_type var_type;
>> +
>> +	ret =3D efi_check_setvariable(variable_name, vendor, attributes, data=
_size,
>> +				    data);
>> +	if (ret !=3D EFI_SUCCESS)
>> +		return ret;
>> +
>>   	/* check if a variable exists */
>>   	var =3D efi_var_mem_find(vendor, variable_name, NULL);
>>   	append =3D !!(attributes & EFI_VARIABLE_APPEND_WRITE);
>> @@ -434,7 +457,72 @@ efi_set_variable_runtime(u16 *variable_name, const=
 efi_guid_t *vendor,
>>   			 u32 attributes, efi_uintn_t data_size,
>>   			 const void *data)
>>   {
>> +#if IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)
>> +	struct efi_var_entry *var;
>> +	efi_uintn_t ret;
>> +	bool append, delete;
>> +	u64 time =3D 0;
>> +
>> +	/* Authenticated variables are not supported */
>> +	if (attributes & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
>> +			return EFI_INVALID_PARAMETER;
>> +
>> +	ret =3D efi_check_setvariable(variable_name, vendor, attributes, data=
_size,
>> +				    data);
>> +	if (ret !=3D EFI_SUCCESS)
>> +		return ret;
>> +
>> +	/* check if a variable exists */
>> +	var =3D efi_var_mem_find(vendor, variable_name, NULL);
>> +	append =3D !!(attributes & EFI_VARIABLE_APPEND_WRITE);
>> +	attributes &=3D ~(u32)EFI_VARIABLE_APPEND_WRITE;
>> +	delete =3D !append && (!data_size || !attributes);
>> +
>> +	if (var) {
>> +		if (var->attr & EFI_VARIABLE_READ_ONLY)
>> +			return EFI_WRITE_PROTECTED;
>> +
>> +		/* attributes won't be changed */
>> +		if (!delete && (((var->attr & ~(u32)EFI_VARIABLE_READ_ONLY) !=3D
>> +		    (attributes & ~(u32)EFI_VARIABLE_READ_ONLY))))
>> +			return EFI_INVALID_PARAMETER;
>> +		time =3D var->time;
>> +	} else {
>> +		if (delete || append)
>> +			/*
>> +			 * Trying to delete or to update a non-existent
>> +			 * variable.
>> +			 */
>> +			return EFI_NOT_FOUND;
>> +	}
>> +
>> +	if (delete) {
>> +		/* EFI_NOT_FOUND has been handled before */
>> +		attributes =3D var->attr;
>> +		ret =3D EFI_SUCCESS;
>> +	} else if (append) {
>> +		u16 *old_data =3D var->name;
>> +
>> +		for (; *old_data; ++old_data)
>> +			;
>> +		++old_data;
>> +		ret =3D efi_var_mem_ins(variable_name, vendor, attributes,
>> +				      var->length, old_data, data_size, data,
>> +				      time);
>> +	} else {
>> +		ret =3D efi_var_mem_ins(variable_name, vendor, attributes,
>> +				      data_size, data, 0, NULL, time);
>> +	}
>> +
>> +	if (ret !=3D EFI_SUCCESS)
>> +		return ret;
>> +	/* We are always inserting new variables, get rid of the old copy */
>> +	efi_var_mem_del(var);
>> +
>> +	return EFI_SUCCESS;
>> +#else
>>   	return EFI_UNSUPPORTED;
>> +#endif
>>   }
>>
>>   /**
>> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/ef=
i_selftest/efi_selftest_variables_runtime.c
>> index 4700d9424105..6001b44989c8 100644
>> --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
>> +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
>> @@ -62,9 +62,16 @@ static int execute(void)
>>   				    EFI_VARIABLE_BOOTSERVICE_ACCESS |
>>   				    EFI_VARIABLE_RUNTIME_ACCESS,
>>   				    3, v + 4);
>> -	if (ret !=3D EFI_UNSUPPORTED) {
>> -		efi_st_error("SetVariable failed\n");
>> -		return EFI_ST_FAILURE;
>> +	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
>> +		if (ret !=3D EFI_SUCCESS) {
>> +			efi_st_error("SetVariable failed\n");
>> +			return EFI_ST_FAILURE;
>> +		}
>> +	} else {
>> +		if (ret !=3D EFI_UNSUPPORTED) {
>> +			efi_st_error("SetVariable failed\n");
>> +			return EFI_ST_FAILURE;
>> +		}
>>   	}
>>   	len =3D EFI_ST_MAX_DATA_SIZE;
>>   	ret =3D runtime->get_variable(u"PlatformLangCodes", &guid_vendor0,
>> --
>> 2.37.2
>>
>>

