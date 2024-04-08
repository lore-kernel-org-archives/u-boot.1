Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE18CD128A
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 06:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9284B87F13;
	Mon,  8 Apr 2024 08:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fcCh6vSN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E90F887D6A; Mon,  8 Apr 2024 08:15:43 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 903EF87A4B
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 08:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712556923; x=1713161723; i=xypron.glpk@gmx.de;
 bh=ZB7Vv3e+mXQV76Q5eslHUVjaloIlv2API93W+Vwenn8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=fcCh6vSN3GgO0ROj+4AcB1B4mJRjWxbX1DgnJkt5sjrfs9VBs3NuDwYWlZYzcDfh
 m4r1XqvLcs1SRgW1uvJ+6bImPvNAQNcG1xdBS3zJUWev/wGwfEunz5xtUevtB3mYh
 Eu45/RLCW5n/N9nxUv5Aduin3LBoR/NLGCtOczCYowJzdkB4YAcUT1CPt6uBjgKWY
 Eqg5HglqXSrOPyxR2X49HUoQJc5OOLi2jcysuPc3x8xy0OKqGhVvulSbzFLbd3a1a
 UFqptspWWyg5zOe/Vsz9F/P2vbTWQ5vi5Q9ug/FYWxMS4C7/7LnFJa0qL6KmDqMCj
 rEPKU67zy4wFTH+Hzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KPg-1ssit721Wk-010KJZ; Mon, 08
 Apr 2024 08:15:23 +0200
Message-ID: <dc566111-9171-4d77-b446-88c79b309a0b@gmx.de>
Date: Mon, 8 Apr 2024 08:15:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] efi_loader: conditionally enable SetvariableRT
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Bin Meng <bmeng@tinylab.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de,
 kettenis@openbsd.org
References: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
 <20240406140203.248211-2-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240406140203.248211-2-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AMp6CKCQkIIhzYtW/CXOU2ahNsMT/I/OufijwzntdEBen+iIyzU
 8ns7C3Fm5ilI0EE4nEy2HTaAAR755Izc4vkHNCSIYkHrHV4F4bvm0CXxuz8xfYSpxjsxkD6
 Vukuj+ncekkT/IC1JYfbRAZ8j3/oPqBtYgTKkIn7yJAn0gtqGPpi5NqwpKw2LDC2dChwjp1
 3LqCHb7Viv0eX9F0PWOnQ==
UI-OutboundReport: notjunk:1;M01:P0:35triOFI5q0=;2HGZhXzvccRHJKAHPzHwu9VEpjn
 XB8RGs59ZuxwrxSK31pxbsPV2HJjTqpmdXhfhwjEmgFNMWN9PKLqTYqA3bqE9bhuxuY2AsGy0
 +oDivAUzB/yfyZUiqF+xS/SEL/2NNqC/rizBKnm/h7zooK0dBRq3H3Q61xFTUsE1a44zHOZKS
 Ptpo/c4JUi6zqmiUVFk+8zzX2O4uhcA3LFIV09tgEZSlrHGr/owN8HXXXv/L88e+4cp1WrCox
 CwXMotQE/++SMVRTHLqdgz6ZgUpuIGIYlFyYCBss77dM2VhVQ8rfF9h5kDYD8vWhIbE7vGS33
 3LoHP/4AnJ6KGDuv9BJ79wJS6Hk3OuJicestdsVCV5jSQUpF7AjVIqjNO+RUur36fiQ9df/CK
 DFpx3dxzViiAXeqDCFy+ToIDxwXykBhiEkSnoIJcrH0HEwQTsy19CghOnoITGH55SBGqBYlCp
 vVaXNgq49hxLhqH8Kve46JXMtOE/uk1wlVSsrJXrLhOXBFDkl0YS8rE4MQ2LiLCCznIw5F8zO
 6pefW8FtExczHt+GsBmuRMdDgsSGdfEVYwN3+V94h/bSXBO4/eCRc7tzWiyHdXAwV8APdeare
 x0ccblouh5X+LxfP9n9pxRSiHFoQind5DrJg8gxTc2ejdfwDC3uMpRW+m+5O95zKbQgYyJLGr
 hhiFTobUaVbL3cOlKFHis0f2St/pRh0i7W86X8U3e9RW+4mOVM6oiacPzUASbd8HNcMet9/G8
 FQGmBOczMMDC32LK0uaysWFQdrQ49KEHtO/mAo/piGT40IpQQzm2eMKrY4/PW4R4ke7gKVM0l
 30LqV/vNtSQ1qjf2D9/6i8b9lqltEdO+4e6ct3s5FK/Q0=
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

On 4/6/24 16:01, Ilias Apalodimas wrote:
> When EFI variables are stored on file we don't allow SetVariableRT,

Neither in the UEFI standard nor in U-Boot we have a function SetVariableR=
T.

%s/SetVariableRT/SetVariable at runtime/

> since the OS doesn't know how to access or write that file.  At the same
> time keeping the U-Boot drivers alive in runtime sections and performing
> writes from the firmware is dangerous -- if at all possible.
>
> For GetVariableRT  we copy runtime variables in RAM and expose them to

%s/GetVariabeRT/GetVariable at runtime/

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
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/Kconfig                        |  16 +++
>   lib/efi_loader/efi_runtime.c                  |   5 +
>   lib/efi_loader/efi_variable.c                 | 114 ++++++++++++++++--
>   .../efi_selftest_variables_runtime.c          |  13 +-
>   4 files changed, 135 insertions(+), 13 deletions(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index a7c3e05c13a0..b210ceea6d64 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -63,6 +63,22 @@ config EFI_VARIABLE_FILE_STORE
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
> index 18da6892e796..8ebbea7e5c69 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -10,6 +10,7 @@
>   #include <dm.h>
>   #include <elf.h>
>   #include <efi_loader.h>
> +#include <efi_variable.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <rtc.h>
> @@ -126,6 +127,10 @@ efi_status_t efi_init_runtime_supported(void)
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
> index 6fe3792a12a5..f79041e6bedd 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -218,17 +218,20 @@ efi_get_next_variable_name_int(efi_uintn_t *variab=
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
> + * setvariable_allowed() - checks defined by the UEFI spec for setvaria=
ble
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

Can we reuse this function in efi_query_variable_info_int()?

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
> @@ -260,6 +263,25 @@ efi_status_t efi_set_variable_int(const u16 *variab=
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
> +	ret =3D setvariable_allowed(variable_name, vendor, attributes, data_si=
ze,
> +				  data);
> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;
> +
>   	/* check if a variable exists */
>   	var =3D efi_var_mem_find(vendor, variable_name, NULL);
>   	append =3D !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> @@ -452,6 +474,78 @@ efi_set_variable_runtime(u16 *variable_name, const =
efi_guid_t *vendor,
>   			 u32 attributes, efi_uintn_t data_size,
>   			 const void *data)
>   {
> +if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {

This line should be indented by one tab.

Can we put the EFI_UNSUPPORTED exit on top to avoid a very long if branch:

	if (!IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
		return EFI_UNSUPPORTED.

If we implement SetVariable() at runtime, we should also enable
QueryVariableInfo().

> +	struct efi_var_entry *var;
> +	efi_uintn_t ret;
> +	bool append, delete;
> +	u64 time =3D 0;
> +
> +	/*
> +	 * Authenticated variables are not supported the rest of the checks
> +	 * are in setvariable_allowed()

Please, describe here why they are not implemented, yet.

> +	 */
> +	if (attributes & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
> +		return EFI_INVALID_PARAMETER;
> +	/* BS only variables are hidden deny writing them */
> +	if (!(attributes & EFI_VARIABLE_RUNTIME_ACCESS))
> +		return EFI_INVALID_PARAMETER;
> +

Isn't this duplicating logic from efi_set_variable_int()?
Can we carve out more common code?

Best regards

Heinrich

> +	ret =3D setvariable_allowed(variable_name, vendor, attributes, data_si=
ze,
> +				  data);
> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;
> +
> +	/* check if a variable exists */
> +	var =3D efi_var_mem_find(vendor, variable_name, NULL);
> +	append =3D !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> +	attributes &=3D ~EFI_VARIABLE_APPEND_WRITE;
> +	delete =3D !append && (!data_size || !attributes);
> +
> +	if (var) {
> +		if (var->attr & EFI_VARIABLE_READ_ONLY ||
> +		    !(var->attr & EFI_VARIABLE_NON_VOLATILE))
> +			return EFI_WRITE_PROTECTED;
> +
> +		/* attributes won't be changed */
> +		if (!delete && (((var->attr & ~EFI_VARIABLE_READ_ONLY) !=3D
> +		    (attributes & ~EFI_VARIABLE_READ_ONLY))))
> +			return EFI_INVALID_PARAMETER;
> +		time =3D var->time;
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
> +		attributes =3D var->attr;
> +		ret =3D EFI_SUCCESS;
> +	} else if (append && var) {
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
> +} else
> +
>   	return EFI_UNSUPPORTED;
>   }
>
> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi=
_selftest/efi_selftest_variables_runtime.c
> index 4700d9424105..4c9405c0a7c7 100644
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
> +		if (ret !=3D EFI_INVALID_PARAMETER) {
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

