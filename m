Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C594CCD11DD
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 11:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BBD788248;
	Fri, 29 Mar 2024 12:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="O3ktHwDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F1488248; Fri, 29 Mar 2024 12:24:14 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C28F88234
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 12:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711711436; x=1712316236; i=xypron.glpk@gmx.de;
 bh=ONEVvpsn8/SehSFLcB2vXmDOt0in9lDhJlFVuI9hyB8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=O3ktHwDxi+4rput6sxRkoaFP/QmuBfAGwrwQikj0KdEYEc2N5M/4cJ1OkQ/3wPAe
 rLpZUpCiTBAnoGT0Ljen5J8St38qEjbfAIPd8steq2+1wsPVQxe9rjfwCMsQ1Azzk
 HrBqBPsDLwUVHrNIy2eB9FthLPn3iG1O5m8XFs8YT8I5XVf0re9Bq/fnxsKnm80i7
 rRPe6rJ0jRjONIgk+XMxJS6pLWdEpcvnsyYvcYWaDTumf0RMABtTwUDYK6Jhiapa2
 qH1Yp79JR9nrroj77scKqZ0ztQkVczBS3/tzjq/ELbmKW6+9RAA2qRpop2lTyvH3W
 J+ieKkycuU0rF/0VNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeQr-1sKk9o3gBv-00VgPR; Fri, 29
 Mar 2024 12:23:55 +0100
Message-ID: <7b9afe57-7454-49d9-930e-abcaa829b0d9@gmx.de>
Date: Fri, 29 Mar 2024 12:24:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] efi_loader: conditionally enable SetvariableRT
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, caleb.connolly@linaro.org,
 sumit.garg@linaro.org, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Bin Meng
 <bmeng@tinylab.org>, pbrobinson@gmail.com, kettenis@openbsd.org,
 ardb@kernel.org
References: <20240329071929.2461441-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240329071929.2461441-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OnKoLNxpZICy6RpLbTjobZw/lZxpkH2+M1KIe8jzK4kfeM/zkVk
 zPb3zkXHu9V7eru46mSkMF8xAMRNUmgT6eeuoHMGTTVxgmE5TupP2EamEEX6AH1nTYCRJQl
 F88beEvfU0aWnaL56K6x3JnXawx8nmna0i54Fwxqx3pGf8VhrvgPdkHExSK3R+8XByzG/fj
 iJXF687ccsTRmDx4Ot2bA==
UI-OutboundReport: notjunk:1;M01:P0:+rjw+NFC7hg=;VZnWjBWSjzM/fZ9fwIRBHUhZYKv
 o7dL1EYnpjqtfWxRYkXCR7e3miNom/PrRAOrJH5YdqhP26Um/1fPxBuBvXu802CM8xA7QkTdX
 fver0GXIIYix2oqXH2vbsFmQzjQzye3U52doY6xQKOM8IgAA579EPOI/MArBxBd/a4SentxFX
 gJ7rtXhCP1luTCkO5qwkjU+Nz9HypomByh5DrOUwrKTz6m3r6JW2WCHVXrABZ22TbRtiphGsy
 ccNt8EYTSfkkk1ATUIK01QdgjXAinZh8iWwyfWKIlWXfP9hugPnW7+BhysGW4RhZjyhudhm3h
 Byczfjs5SlZeKVeoaFt4A2Tip3A+4ZpuiNI7RloMQd/zL9WgTIBZb/KCCtKEnPmWldkFRb9jM
 Jgs2FRtTrawUslSN7/k0P2q2ia03LjQBEsQVgow90R+RObggPVPVnsc595raSg5Nc7elLgXJi
 Ufk41BB1s+ZZG3uoyrvkgdBWbc3+2geyvR4HjsmyhnqnyxNUqAOO4P247Wu3K9ZgvKbkuA2t5
 IzVd7rfSvFH8v1BLg9566TBvqi7v9/ehYStBbd2aVKQt7XEs1JY3gjhKaFkZMjQopMPNZ/X7S
 tgOsOXsMPeCr4e9/KLLKl311EF/A3K08ASuOdhGLF0o9N+Nv0YhjBWZJ2fLYFhoanBz3aoChf
 D8DIRL755E099uBR+kYegzpH7NSiOQ5EVbF91q+d6jQsTSwo5O1S1FUWVD9wy+p9+ATuanc4L
 oWzA7ceZv5T0L8E0pIzBaIUUtJ5yj+gaLO6lJ11zVkpmLbM+7iHLuAlsPsYQpE8o+QM8rZVb8
 NpIdRFilzESWTrrMyDpoilxicyY0XlZFvV52xduekyIpY=
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

On 3/29/24 08:19, Ilias Apalodimas wrote:
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
> efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,noe=
xec,relatime)
>
> $~ efibootmgr -n 0001
> Could not set BootNext: Read-only file system
>
> - post-patch
> $~ mount | grep efiva
> efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noe=
xec,relatime)
>
> $~ efibootmgr -n 0001
> BootNext: 0001
> BootCurrent: 0000
> BootOrder: 0000,0001
> Boot0000* debian        HD(1,GPT,bdae5610-3331-4e4d-9466-acb5caf0b4a6,0x=
800,0x100000)/File(EFI\debian\grubaa64.efi)
> Boot0001* virtio 0      VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,00000=
00000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,850000001f000000)/=
VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600850000000000){auto_created_=
boot_option}
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
> [0] https://arm-software.github.io/ebbr/index.html#document-chapter5-var=
iable-storage
>
> Open questions:
> Looking at the EFI spec, I can't find a documented way of notifying the =
OS
> that the storage is volatile. I would like to send a hint to the OS abou=
t
> that and I was thinking of adding a configuration table with the filenam=
e,
> which U-Boot expects to be on the ESP. Alternatively we could add a devi=
ce
> path which would be a bit harder to parse from the userspace application=
,
> but safer in case multiple ESPs are present.
>
> Since I am not too familiar with how BSDs treat and expose config tables=
,
> we could instead add a RO efi variable with identical semantics, which
> would be easier to read from userspace.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/Kconfig                        |  14 +++
>   lib/efi_loader/efi_runtime.c                  |   4 +
>   lib/efi_loader/efi_variable.c                 | 108 ++++++++++++++++--
>   .../efi_selftest_variables_runtime.c          |  13 ++-
>   4 files changed, 126 insertions(+), 13 deletions(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index a7c3e05c13a0..c7f7383189e5 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -63,6 +63,20 @@ config EFI_VARIABLE_FILE_STORE
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
> +	  the EFI variable storate. The OS will be responsible for syncing

Hello Ilias,

I like the idea of adding this for experimenting. We should express that
this is just experimental and may be removed in future releases, if we
find a better solution.

%s/storate/stroage/

> +	  the RAM contents to the file, otherwise any changes made during
> +	  runtime won't persist reboots.
> +	  Authenticated variables are not supported.

Should we mention here that this behavior is not compliant with the UEFI
specification?

Should we unset CONFIG_EFI_EBBR_2_1_CONFORMANCE if this flag is set?

> +
>   config EFI_MM_COMM_TEE
>   	bool "UEFI variables storage service via the trusted world"
>   	depends on OPTEE
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 18da6892e796..b38ce239e2d2 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -126,6 +126,10 @@ efi_status_t efi_init_runtime_supported(void)
>   				EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
>   				EFI_RT_SUPPORTED_CONVERT_POINTER;
>
> +	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
> +		rt_table->runtime_services_supported |=3D
> +			EFI_RT_SUPPORTED_SET_VARIABLE;
> +
>   	/*
>   	 * This value must be synced with efi_runtime_detach_list
>   	 * as well as efi_runtime_services.
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable=
.c
> index 40f7a0fb10d5..3b770ff16971 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -218,17 +218,21 @@ efi_get_next_variable_name_int(efi_uintn_t *variab=
le_name_size,
>   	return efi_get_next_variable_name_mem(variable_name_size, variable_na=
me, vendor);
>   }
>
> -efi_status_t efi_set_variable_int(const u16 *variable_name,
> -				  const efi_guid_t *vendor,
> -				  u32 attributes, efi_uintn_t data_size,
> -				  const void *data, bool ro_check)
> +/**
> + * efi_check_setvariable() - checks defined by the UEFI spec for setvar=
iable
> + *
> + * @variable_name:	name of the variable
> + * @vendor:		vendor GUID
> + * @attributes:		attributes of the variable
> + * @data_size:		size of the buffer with the variable value
> + * @data:		buffer with the variable value
> + * Return:		status code
> + */
> +static efi_status_t __efi_runtime EFIAPI
> +efi_check_setvariable(const u16 *variable_name, const efi_guid_t *vendo=
r,
> +		      u32 attributes, efi_uintn_t data_size,
> +		      const void *data)
>   {
> -	struct efi_var_entry *var;
> -	efi_uintn_t ret;
> -	bool append, delete;
> -	u64 time =3D 0;
> -	enum efi_auth_var_type var_type;
> -
>   	if (!variable_name || !*variable_name || !vendor)
>   		return EFI_INVALID_PARAMETER;
>
> @@ -256,6 +260,25 @@ efi_status_t efi_set_variable_int(const u16 *variab=
le_name,
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
> +	u64 time =3D 0;
> +	enum efi_auth_var_type var_type;
> +
> +	ret =3D efi_check_setvariable(variable_name, vendor, attributes, data_=
size,
> +				    data);
> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;
> +
>   	/* check if a variable exists */
>   	var =3D efi_var_mem_find(vendor, variable_name, NULL);
>   	append =3D !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> @@ -434,7 +457,72 @@ efi_set_variable_runtime(u16 *variable_name, const =
efi_guid_t *vendor,
>   			 u32 attributes, efi_uintn_t data_size,
>   			 const void *data)
>   {
> +#if IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)

Please, use 'if' instead of #if. The

> +	struct efi_var_entry *var;
> +	efi_uintn_t ret;
> +	bool append, delete;
> +	u64 time =3D 0;
> +
> +	/* Authenticated variables are not supported */
> +	if (attributes & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)

Adding EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS here would make it
clearer that all authenticated variables are unsupported.

Non-volatile variables are read-only at runtime. Please, check that
EFI_VARIABLE_NON_VOLATILE is set.

if ((attributes & (
   EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS |
   EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS |
   EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS)) ||
   (~attributes & EFI_VARIABLE_NON_VOLATILE)
     return EFI_INVALID_PARAMETER;

> +			return EFI_INVALID_PARAMETER;
> +
> +	ret =3D efi_check_setvariable(variable_name, vendor, attributes, data_=
size,
> +				    data);
> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;
> +
> +	/* check if a variable exists */
> +	var =3D efi_var_mem_find(vendor, variable_name, NULL);
> +	append =3D !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> +	attributes &=3D ~(u32)EFI_VARIABLE_APPEND_WRITE;

Why is the u32 conversion necessary? The result should be the same
without conversion.

The UEFI specification defines the different attribute constants as
32bit. Why do we define them as 64bit in include/efi.h?

> +	delete =3D !append && (!data_size || !attributes);
> +
> +	if (var) {
> +		if (var->attr & EFI_VARIABLE_READ_ONLY)
> +			return EFI_WRITE_PROTECTED;
> +
> +		/* attributes won't be changed */
> +		if (!delete && (((var->attr & ~(u32)EFI_VARIABLE_READ_ONLY) !=3D
> +		    (attributes & ~(u32)EFI_VARIABLE_READ_ONLY))))
> +			return EFI_INVALID_PARAMETER;

ditto

> +		time =3D var->time;
> +	} else {
> +		if (delete || append)

EDK II allows to create a variable with EFI_VARIABLE_APPEND_WRITE. See
previous discussions about changing this at boot time.

Best regards

Heinrich

> +			/*
> +			 * Trying to delete or to update a non-existent
> +			 * variable.
> +			 */
> +			return EFI_NOT_FOUND;
> +	}
> +
> +	if (delete) {
> +		/* EFI_NOT_FOUND has been handled before */
> +		attributes =3D var->attr;
> +		ret =3D EFI_SUCCESS;
> +	} else if (append) {
> +		u16 *old_data =3D var->name;
> +
> +		for (; *old_data; ++old_data)
> +			;
> +		++old_data;
> +		ret =3D efi_var_mem_ins(variable_name, vendor, attributes,
> +				      var->length, old_data, data_size, data,
> +				      time);
> +	} else {
> +		ret =3D efi_var_mem_ins(variable_name, vendor, attributes,
> +				      data_size, data, 0, NULL, time);
> +	}
> +
> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;
> +	/* We are always inserting new variables, get rid of the old copy */
> +	efi_var_mem_del(var);
> +
> +	return EFI_SUCCESS;
> +#else
>   	return EFI_UNSUPPORTED;
> +#endif
>   }
>
>   /**
> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi=
_selftest/efi_selftest_variables_runtime.c
> index 4700d9424105..6001b44989c8 100644
> --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> @@ -62,9 +62,16 @@ static int execute(void)
>   				    EFI_VARIABLE_BOOTSERVICE_ACCESS |
>   				    EFI_VARIABLE_RUNTIME_ACCESS,
>   				    3, v + 4);
> -	if (ret !=3D EFI_UNSUPPORTED) {
> -		efi_st_error("SetVariable failed\n");
> -		return EFI_ST_FAILURE;
> +	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +	} else {
> +		if (ret !=3D EFI_UNSUPPORTED) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
>   	}
>   	len =3D EFI_ST_MAX_DATA_SIZE;
>   	ret =3D runtime->get_variable(u"PlatformLangCodes", &guid_vendor0,
> --
> 2.37.2
>

