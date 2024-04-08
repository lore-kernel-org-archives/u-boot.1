Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1138C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 06:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C8587F13;
	Mon,  8 Apr 2024 08:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jTSFecN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9196087FB5; Mon,  8 Apr 2024 08:41:39 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2A0787C77
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 08:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712558462; x=1713163262; i=xypron.glpk@gmx.de;
 bh=r9MYgSFdZ2Y0U+9TCCSaU1owihZk9Hsw02IkCzoKwyw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=jTSFecN2dJyqvwD0G8zHrNi/P1MdsUgKZH2OzmoLb28A4475woqNNCi1Y46bMPiY
 Zm6EDX/Fa2b+OOZ6/98cKRSkZ01cW/4pUqavsU7UVh4Niv0NzTCcwP3nBAp3vulBj
 BMYC5gRw3vGKZ/kuyEGUF+XFdN331dJWjkTOtOuT8CIXw765XFmfTNKpd5lSiMVWM
 QgDqb7FGss1ntkMZ5fs1MSsnnoXy3r6GO66xzrmtheoOgh5txhaD22BtEkljK+g+P
 wecmGslmO5VTaoC4U+t2+BfBXGfCg+PvDIjawbThsLYJIy5Sbav02orqlbU/mHGnS
 dBExjXsmHB7MxbBJqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wq3-1svDKJ0X1d-012FFp; Mon, 08
 Apr 2024 08:41:02 +0200
Message-ID: <6c399b8c-f5f8-4b1b-a74a-0de72ef9002e@gmx.de>
Date: Mon, 8 Apr 2024 08:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] efi_loader: add an EFI variable with the variable
 file contents
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Bin Meng <bmeng@tinylab.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Weizhao Ouyang
 <o451686892@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 u-boot@lists.denx.de, kettenis@openbsd.org
References: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
 <20240406140203.248211-4-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240406140203.248211-4-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cVX9pROFJEI2nIPriVkMmP8DTfu2q6U3CjaW9rXw++OJv+X9W8T
 Foq3h43SSKYCxNf1os2OhoCJHOR5yfxt5IUQM3x4s79caW5nAtvVv4hsWU2AlYfZKWZ1lV5
 RKSHmfR6lat0fqbEUGq636DhZgkrnqMiBWWkCdYoyuwqingXPgYN6Y3vSCHCb+KJo7pf4Oh
 QIgzo5QFJbMWDF0UMzfYA==
UI-OutboundReport: notjunk:1;M01:P0:HMKMwMqg+GY=;/e0zJnCkpll2vldK6pmkULtK9oo
 qji0wh8HyYPo8cMVzOfL0NjEYh/eOOsFBt7vYBO8vwcZlx445W61W09oHLJQfddaQa0cmj4YG
 Zia0vOj4RfOiWZyjKzUxD2PPuoF7PK35yGC/3hv1MnIYybo11qd6fqlpIuJjJVW54J4LbBcE0
 m80bFW4CFGM909ybRaF5+EKDwxseZbwZ5LvBjVVrFz4WqeWL6VhtQk42hGz7vjx3qwLwAdO2e
 e35J5I06D++Qv18R4SE4acg1AbmJ0cvSLELiOzi0xx0UHKroTxEFOTNnHXNRf12zE+IcnEp7G
 +fxAIB8Cdf+lHpCNcUsH+psMN0aQcZYn6C4Basxb6nc5FFG6rc1mBVjwwNk3NuUa4g53aPMa8
 NlKCaUrvSOvQFyeKNCLysDRqe4SA7u58oUFIftJp9GugU3I1yQTdK91VNVrGjP+xbTQtPtAln
 DQz4s7LYJVSEaOWkiXazGigBbNSx8tDTJHHbgqa0z/Yb766UxSgtypb5ZAeq3r6m80xgv/r30
 R4GfDclJkFhzb3doMWCkq7nVeLcQAfPYFMxWslbClrxOcIDg9vuRjaVIAh84Q68P8fDh2vMoP
 FEBWJFnpww8jCivYWK7YbloYgWQRkkJBC80OA3tM5ee8m/jAluIuuDHAF3/+04rU8xG14ZaRs
 rtzNXdKPaXI6WCP3YUyYkdpY210rFHpf5syni3Hx8oQnmA4gsCUobT1iMKQjh7u3eXNg21MZ+
 iaf15EbwJ6gxAPC7Krl/hlL36pA1JHo5mMXRdCiWqPburWO9ZBdjfYgum72o882Gs84QieELQ
 ZTjfXgcIKGOPCawk/eMkpVTnRSjpyV2hZ5EcPE8vtzfYg=
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
> Previous patches enabled SetVariableRT using a RAM backend.
> Although EBBR [0] defines a variable format we can teach userspace tools
> and write the altered variables, it's better if we skip the ABI
> requirements completely.
>
> So let's add a new variable, in its own namespace called "VarToFile"
> which contains a binary dump of the updated RT, BS and, NV variables.
>
> Some adjustments are needed to do that. Currently we discard BS-only
> variables in EBS(). We need to preserve those on the OS RAM backend
> that exposes the variables. Since BS-only variables can't appear at RT
> we need to move the memory masking checks from efi_var_collect() to
> efi_get_next_variable_name_mem()/efi_get_variable_mem() and do the
> filtering at runtime. We also need to make efi_var_collect() available
> at runtime, in order to construct the "VarToFile" buffer with BS, RT &
> NV variables.
>
> All users and applications (for linux) have to do when updating a variab=
le
> is dd that variable in the file described by "RTStorageVolatile".
>
> Linux efivarfs uses a first 4 bytes of the output to represent attribute=
s
> in little-endian format. So, storing variables works like this:
>
> $~ efibootmgr -n 0001
> $~ dd if=3D/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-1=
1e818c3130c of=3D/boot/efi/ubootefi.var skip=3D4 bs=3D1
>
> [0] https://arm-software.github.io/ebbr/index.html#document-chapter5-var=
iable-storage

This change actually doubles the amount of memory needed to store a
variable at runtime. How do you reflect this in QueryVariableInfo()?

>
> Suggested-by:Ard Biesheuvel <ardb@kernel.org> # dumping all variables to=
 a variable
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   include/efi_variable.h            |  15 +++-
>   lib/efi_loader/efi_boottime.c     |   2 +
>   lib/efi_loader/efi_var_common.c   |  43 +++++------
>   lib/efi_loader/efi_var_file.c     |   1 -
>   lib/efi_loader/efi_var_mem.c      |  90 ++++++++++-------------
>   lib/efi_loader/efi_variable.c     | 118 ++++++++++++++++++++++++------
>   lib/efi_loader/efi_variable_tee.c |   1 -
>   7 files changed, 164 insertions(+), 106 deletions(-)
>
> diff --git a/include/efi_variable.h b/include/efi_variable.h
> index 42a2b7c52bef..8963339b9bb6 100644
> --- a/include/efi_variable.h
> +++ b/include/efi_variable.h
> @@ -271,13 +271,15 @@ const efi_guid_t *efi_auth_var_get_guid(const u16 =
*name);
>    *
>    * @variable_name_size:	size of variable_name buffer in bytes
>    * @variable_name:	name of uefi variable's name in u16
> + * @mask:		bitmask with required attributes of variables to be collecte=
d.
> + *                      variables are only collected if all of the requ=
ired
>    * @vendor:		vendor's guid
>    *
>    * Return: status code
>    */
>   efi_status_t __efi_runtime
>   efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size, u16 *v=
ariable_name,
> -			       efi_guid_t *vendor);
> +			       efi_guid_t *vendor, u32 mask);
>   /**
>    * efi_get_variable_mem() - Runtime common code across efi variable
>    *                          implementations for GetVariable() from
> @@ -289,12 +291,14 @@ efi_get_next_variable_name_mem(efi_uintn_t *variab=
le_name_size, u16 *variable_na
>    * @data_size:		size of the buffer to which the variable value is copi=
ed
>    * @data:		buffer to which the variable value is copied
>    * @timep:		authentication time (seconds since start of epoch)
> + * @mask:		bitmask with required attributes of variables to be collecte=
d.
> + *                      variables are only collected if all of the requ=
ired

This line looks incomplete.

>    * Return:		status code
>    */
>   efi_status_t __efi_runtime
>   efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendo=
r,
>   		     u32 *attributes, efi_uintn_t *data_size, void *data,
> -		     u64 *timep);
> +		     u64 *timep, u32 mask);
>
>   /**
>    * efi_get_variable_runtime() - runtime implementation of GetVariable(=
)
> @@ -334,4 +338,11 @@ efi_get_next_variable_name_runtime(efi_uintn_t *var=
iable_name_size,
>    */
>   void efi_var_buf_update(struct efi_var_file *var_buf);
>
> +/**
> + * efi_prealloced_rt_memory() - Get a pointer to preallocated EFI memor=
y
> + *                              available at runtime
> + *
> + * Return: pointer to preallocated runtime usable buffer
> + */
> +void __efi_runtime *efi_prealloced_rt_memory(void);
>   #endif
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index 1951291747cd..39481c89a688 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -97,6 +97,8 @@ const efi_guid_t efi_guid_load_file_protocol =3D EFI_L=
OAD_FILE_PROTOCOL_GUID;
>   const efi_guid_t efi_guid_load_file2_protocol =3D EFI_LOAD_FILE2_PROTO=
COL_GUID;
>   /* GUID of the SMBIOS table */
>   const efi_guid_t smbios_guid =3D SMBIOS_TABLE_GUID;
> +/* used by special U-Boot variables during SetVariableRT */
> +const efi_guid_t efi_guid_efi_rt_var_file =3D U_BOOT_EFI_RT_VAR_FILE_GU=
ID;
>
>   static efi_status_t EFIAPI efi_disconnect_controller(
>   					efi_handle_t controller_handle,
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_co=
mmon.c
> index 07b9603d49f3..4abc90e411e7 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -182,7 +182,8 @@ efi_get_variable_runtime(u16 *variable_name, const e=
fi_guid_t *guid,
>   {
>   	efi_status_t ret;
>
> -	ret =3D efi_get_variable_mem(variable_name, guid, attributes, data_siz=
e, data, NULL);
> +	ret =3D efi_get_variable_mem(variable_name, guid, attributes, data_siz=
e,
> +				   data, NULL, EFI_VARIABLE_RUNTIME_ACCESS);
>
>   	/* Remove EFI_VARIABLE_READ_ONLY flag */
>   	if (attributes)
> @@ -195,7 +196,8 @@ efi_status_t __efi_runtime EFIAPI
>   efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
>   				   u16 *variable_name, efi_guid_t *guid)
>   {
> -	return efi_get_next_variable_name_mem(variable_name_size, variable_nam=
e, guid);
> +	return efi_get_next_variable_name_mem(variable_name_size, variable_nam=
e,
> +					      guid, EFI_VARIABLE_RUNTIME_ACCESS);
>   }
>
>   /**
> @@ -427,18 +429,15 @@ void *efi_get_var(const u16 *name, const efi_guid_=
t *vendor, efi_uintn_t *size)
>    *
>    * Return:	Status code
>    */
> -efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp,=
 loff_t *lenp,
> -					    u32 check_attr_mask)
> +efi_status_t __efi_runtime
> +efi_var_collect(struct efi_var_file **bufp, loff_t *lenp, u32 check_att=
r_mask)
>   {
>   	size_t len =3D EFI_VAR_BUF_SIZE;
>   	struct efi_var_file *buf;
>   	struct efi_var_entry *var, *old_var;
>   	size_t old_var_name_length =3D 2;
>
> -	*bufp =3D NULL; /* Avoid double free() */
> -	buf =3D calloc(1, len);
> -	if (!buf)
> -		return EFI_OUT_OF_RESOURCES;
> +	buf =3D (struct efi_var_file *)efi_prealloced_rt_memory();
>   	var =3D buf->var;
>   	old_var =3D var;
>   	for (;;) {
> @@ -451,32 +450,26 @@ efi_status_t __maybe_unused efi_var_collect(struct=
 efi_var_file **bufp, loff_t *
>   			return EFI_BUFFER_TOO_SMALL;
>
>   		var_name_length =3D (uintptr_t)buf + len - (uintptr_t)var->name;
> -		memcpy(var->name, old_var->name, old_var_name_length);
> -		guidcpy(&var->guid, &old_var->guid);
> -		ret =3D efi_get_next_variable_name_int(
> -				&var_name_length, var->name, &var->guid);
> +		efi_memcpy_runtime(var->name, old_var->name, old_var_name_length);
> +		efi_memcpy_runtime(&var->guid, &old_var->guid, sizeof(efi_guid_t));
> +		ret =3D efi_get_next_variable_name_mem(&var_name_length, var->name,
> +						     &var->guid, check_attr_mask);
>   		if (ret =3D=3D EFI_NOT_FOUND)
>   			break;
> -		if (ret !=3D EFI_SUCCESS) {
> -			free(buf);
> +		if (ret !=3D EFI_SUCCESS)
>   			return ret;
> -		}
>   		old_var_name_length =3D var_name_length;
>   		old_var =3D var;
>
>   		data =3D (u8 *)var->name + old_var_name_length;
>   		data_length =3D (uintptr_t)buf + len - (uintptr_t)data;
> -		ret =3D efi_get_variable_int(var->name, &var->guid,
> +		ret =3D efi_get_variable_mem(var->name, &var->guid,
>   					   &var->attr, &data_length, data,
> -					   &var->time);
> -		if (ret !=3D EFI_SUCCESS) {
> -			free(buf);
> +					   &var->time, check_attr_mask);
> +		if (ret !=3D EFI_SUCCESS)
>   			return ret;
> -		}
> -		if ((var->attr & check_attr_mask) =3D=3D check_attr_mask) {
> -			var->length =3D data_length;
> -			var =3D (struct efi_var_entry *)ALIGN((uintptr_t)data + data_length,=
 8);
> -		}
> +		var->length =3D data_length;
> +		var =3D (struct efi_var_entry *)ALIGN((uintptr_t)data + data_length, =
8);
>   	}
>
>   	buf->reserved =3D 0;
> @@ -490,5 +483,3 @@ efi_status_t __maybe_unused efi_var_collect(struct e=
fi_var_file **bufp, loff_t *
>
>   	return EFI_SUCCESS;
>   }
> -
> -
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file=
.c
> index 413e1794e88c..8614e3d34706 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -83,7 +83,6 @@ efi_status_t efi_var_to_file(void)
>   error:
>   	if (ret !=3D EFI_SUCCESS)
>   		log_err("Failed to persist EFI variables\n");
> -	free(buf);
>   	return ret;
>   #else
>   	return EFI_SUCCESS;
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index 6c21cec5d457..a7af0604733e 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -16,6 +16,7 @@
>    * relocation during SetVirtualAddressMap().
>    */
>   static struct efi_var_file __efi_runtime_data *efi_var_buf;
> +static void __efi_runtime_data *efi_rt_prealloced;
>   static struct efi_var_entry __efi_runtime_data *efi_current_var;
>
>   /**
> @@ -184,53 +185,6 @@ u64 __efi_runtime efi_var_mem_free(void)
>   	       sizeof(struct efi_var_entry);
>   }
>
> -/**
> - * efi_var_mem_bs_del() - delete boot service only variables
> - */
> -static void efi_var_mem_bs_del(void)
> -{
> -	struct efi_var_entry *var =3D efi_var_buf->var;
> -
> -	for (;;) {
> -		struct efi_var_entry *last;
> -
> -		last =3D (struct efi_var_entry *)
> -		       ((uintptr_t)efi_var_buf + efi_var_buf->length);
> -		if (var >=3D last)
> -			break;
> -		if (var->attr & EFI_VARIABLE_RUNTIME_ACCESS) {
> -			u16 *data;
> -
> -			/* skip variable */
> -			for (data =3D var->name; *data; ++data)
> -				;
> -			++data;
> -			var =3D (struct efi_var_entry *)
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
> -efi_var_mem_notify_exit_boot_services(struct efi_event *event, void *co=
ntext)
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
>    * efi_var_mem_notify_exit_boot_services() - SetVirtualMemoryMap callb=
ack
>    *
> @@ -241,6 +195,7 @@ static void EFIAPI __efi_runtime
>   efi_var_mem_notify_virtual_address_map(struct efi_event *event, void *=
context)
>   {
>   	efi_convert_pointer(0, (void **)&efi_var_buf);
> +	efi_convert_pointer(0, (void **)&efi_rt_prealloced);
>   	efi_current_var =3D NULL;
>   }
>
> @@ -261,13 +216,21 @@ efi_status_t efi_var_mem_init(void)
>   	efi_var_buf->magic =3D EFI_VAR_FILE_MAGIC;
>   	efi_var_buf->length =3D (uintptr_t)efi_var_buf->var -
>   			      (uintptr_t)efi_var_buf;
> -	/* crc32 for 0 bytes =3D 0 */
>
> -	ret =3D efi_create_event(EVT_SIGNAL_EXIT_BOOT_SERVICES, TPL_CALLBACK,
> -			       efi_var_mem_notify_exit_boot_services, NULL,
> -			       NULL, &event);
> +	/*
> +	 * efi_var_collect() needs to run at runtime and provide us
> +	 * copies of variables used for the VarToFile variable.
> +	 * Preallocate memory equal to the variable storage and
> +	 * preserve it to copy variables around
> +	 */
> +	ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> +				 EFI_RUNTIME_SERVICES_DATA,
> +				 efi_size_in_pages(EFI_VAR_BUF_SIZE),
> +				 &memory);
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
> +	efi_rt_prealloced =3D (void *)(uintptr_t)memory;
> +
>   	ret =3D efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE, TPL_CALLB=
ACK,
>   			       efi_var_mem_notify_virtual_address_map, NULL,
>   			       NULL, &event);
> @@ -279,7 +242,7 @@ efi_status_t efi_var_mem_init(void)
>   efi_status_t __efi_runtime
>   efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendo=
r,
>   		     u32 *attributes, efi_uintn_t *data_size, void *data,
> -		     u64 *timep)
> +		     u64 *timep, u32 mask)
>   {
>   	efi_uintn_t old_size;
>   	struct efi_var_entry *var;
> @@ -291,6 +254,9 @@ efi_get_variable_mem(const u16 *variable_name, const=
 efi_guid_t *vendor,
>   	if (!var)
>   		return EFI_NOT_FOUND;
>
> +	if (mask && !((var->attr & mask) =3D=3D mask))
> +		return EFI_NOT_FOUND;
> +
>   	if (attributes)
>   		*attributes =3D var->attr;
>   	if (timep)
> @@ -315,7 +281,8 @@ efi_get_variable_mem(const u16 *variable_name, const=
 efi_guid_t *vendor,
>
>   efi_status_t __efi_runtime
>   efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size,
> -			       u16 *variable_name, efi_guid_t *vendor)
> +			       u16 *variable_name, efi_guid_t *vendor,
> +			       u32 mask)
>   {
>   	struct efi_var_entry *var;
>   	efi_uintn_t len, old_size;
> @@ -324,6 +291,7 @@ efi_get_next_variable_name_mem(efi_uintn_t *variable=
_name_size,
>   	if (!variable_name_size || !variable_name || !vendor)
>   		return EFI_INVALID_PARAMETER;
>
> +skip:
>   	len =3D *variable_name_size >> 1;
>   	if (u16_strnlen(variable_name, len) =3D=3D len)
>   		return EFI_INVALID_PARAMETER;
> @@ -347,6 +315,11 @@ efi_get_next_variable_name_mem(efi_uintn_t *variabl=
e_name_size,
>   	efi_memcpy_runtime(variable_name, var->name, *variable_name_size);
>   	efi_memcpy_runtime(vendor, &var->guid, sizeof(efi_guid_t));
>
> +	if (mask && !((var->attr & mask) =3D=3D mask)) {
> +		*variable_name_size =3D old_size;
> +		goto skip;
> +	}
> +
>   	return EFI_SUCCESS;
>   }
>
> @@ -354,3 +327,14 @@ void efi_var_buf_update(struct efi_var_file *var_bu=
f)
>   {
>   	memcpy(efi_var_buf, var_buf, EFI_VAR_BUF_SIZE);
>   }
> +
> +void __efi_runtime *efi_prealloced_rt_memory(void)
> +{
> +	char *s;
> +	int count =3D EFI_VAR_BUF_SIZE;
> +
> +	s =3D (char *)efi_rt_prealloced;
> +	while (count--)
> +		*s++ =3D 0;
> +	return efi_rt_prealloced;
> +}
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable=
.c
> index f97c8c57f75c..4f529169ea54 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -22,6 +22,8 @@
>   #include <u-boot/crc.h>
>   #include <asm/sections.h>
>
> +static const efi_guid_t __efi_runtime_data efi_guid_efi_rt_var_file =3D
> +						U_BOOT_EFI_RT_VAR_FILE_GUID;
>   #ifdef CONFIG_EFI_SECURE_BOOT
>
>   /**
> @@ -208,14 +210,16 @@ efi_get_variable_int(const u16 *variable_name, con=
st efi_guid_t *vendor,
>   		     u32 *attributes, efi_uintn_t *data_size, void *data,
>   		     u64 *timep)
>   {
> -	return efi_get_variable_mem(variable_name, vendor, attributes, data_si=
ze, data, timep);
> +	return efi_get_variable_mem(variable_name, vendor, attributes, data_si=
ze,
> +				    data, timep, 0);
>   }
>
>   efi_status_t __efi_runtime
>   efi_get_next_variable_name_int(efi_uintn_t *variable_name_size,
>   			       u16 *variable_name, efi_guid_t *vendor)
>   {
> -	return efi_get_next_variable_name_mem(variable_name_size, variable_nam=
e, vendor);
> +	return efi_get_next_variable_name_mem(variable_name_size, variable_nam=
e,
> +					      vendor, 0);
>   }
>
>   /**
> @@ -479,6 +483,8 @@ if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
>   	efi_uintn_t ret;
>   	bool append, delete;
>   	u64 time =3D 0;
> +	struct efi_var_file *buf;
> +	loff_t len;
>
>   	/*
>   	 * Authenticated variables are not supported the rest of the checks
> @@ -520,30 +526,60 @@ if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
>   			return EFI_NOT_FOUND;
>   	}
>
> -	if (delete) {
> +	if (!delete) {
> +		/*
> +		 * We always insert new variabes and delete the old one when
> +		 * appending
> +		 */
> +		len =3D 2 * (u16_strlen(variable_name) + 1) + data_size +
> +			sizeof(struct efi_var_entry);
> +		if (var && append)
> +			 len +=3D 2 * var->length;
> +		/*
> +		 * We will copy the variable update into VarToFile,
> +		 * account for it twice
> +		 */
> +		len *=3D 2;
> +		if (len > efi_var_mem_free())
> +			return EFI_OUT_OF_RESOURCES;
> +		if (append && var) {
> +			u16 *old_data =3D var->name;
> +
> +			for (; *old_data; ++old_data)
> +				;
> +			++old_data;
> +			ret =3D efi_var_mem_ins(variable_name, vendor, attributes,
> +					      var->length, old_data, data_size,
> +					      data, time);
> +		} else {
> +			ret =3D efi_var_mem_ins(variable_name, vendor, attributes,
> +					      data_size, data, 0, NULL, time);
> +		}
> +	} else {
>   		/* EFI_NOT_FOUND has been handled before */
>   		attributes =3D var->attr;
>   		ret =3D EFI_SUCCESS;
> -	} else if (append && var) {
> -		u16 *old_data =3D var->name;
> -
> -		for (; *old_data; ++old_data)
> -			;
> -		++old_data;
> -		ret =3D efi_var_mem_ins(variable_name, vendor, attributes,
> -				      var->length, old_data, data_size, data,
> -				      time);
> -	} else {
> -		ret =3D efi_var_mem_ins(variable_name, vendor, attributes,
> -				      data_size, data, 0, NULL, time);
>   	}
> -
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
>   	/* We are always inserting new variables, get rid of the old copy */
>   	efi_var_mem_del(var);
>
> -	return EFI_SUCCESS;
> +	/*
> +	 * Create a volatile variable that userspace apps can dd and
> +	 * update the file contents
> +	 */
> +	ret =3D efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;
> +	var =3D efi_var_mem_find(&efi_guid_efi_rt_var_file, u"VarToFile", NULL=
);
> +	if (var)
> +		efi_var_mem_del(var);
> +
> +	ret =3D efi_var_mem_ins(u"VarToFile", &efi_guid_efi_rt_var_file,
> +			      EFI_VARIABLE_RUNTIME_ACCESS, len, buf, 0,
> +			      NULL, time);
> +	return ret;
>   } else
>
>   	return EFI_UNSUPPORTED;
> @@ -557,11 +593,11 @@ void efi_variables_boot_exit_notify(void)
>   	const efi_guid_t efi_guid_efi_rt_var_file =3D U_BOOT_EFI_RT_VAR_FILE_=
GUID;
>   	const efi_guid_t rt_prop_guid =3D EFI_RT_PROPERTIES_TABLE_GUID;
>   	efi_status_t ret;
> +	struct efi_var_file *buf;
> +	loff_t len;
> +	bool fail =3D false;
>
>   	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> -		struct efi_rt_properties_table *rt_prop =3D
> -			efi_get_configuration_table(&rt_prop_guid);
> -
>   		ret =3D efi_set_variable_int(u"RTStorageVolatile",
>   					   &efi_guid_efi_rt_var_file,
>   					   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> @@ -569,11 +605,47 @@ void efi_variables_boot_exit_notify(void)
>   					   EFI_VARIABLE_READ_ONLY,
>   					   sizeof(EFI_VAR_FILE_NAME),
>   					   EFI_VAR_FILE_NAME, false);
> +		if (ret !=3D EFI_SUCCESS) {
> +			fail =3D true;
> +			goto out;
> +		}
> +
> +		ret =3D efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
> +		if (ret !=3D EFI_SUCCESS) {
> +			fail =3D true;
> +			goto out;
> +		}
> +
> +		ret =3D efi_set_variable_int(u"VarToFile",
> +					   &efi_guid_efi_rt_var_file,
> +					   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					   EFI_VARIABLE_RUNTIME_ACCESS,
> +					   len,
> +					   buf, false);
>   		if (ret !=3D EFI_SUCCESS)
> -			rt_prop->runtime_services_supported |=3D ~EFI_RT_SUPPORTED_SET_VARIA=
BLE;
> -		else
> -			log_err("Can't RTStorage. SetVariableRT won't be available\n");
> +			fail =3D true;
> +out:
> +		if (fail) {
> +			efi_set_variable_int(u"RTStorageVolatile",
> +					     &efi_guid_efi_rt_var_file,
> +					     EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					     EFI_VARIABLE_RUNTIME_ACCESS |
> +					     EFI_VARIABLE_READ_ONLY, 0, 0,
> +					     false);

Not providing VarToFile because the memory buffer is more than half
filled before ExitBootServices() is unexpected behavior. This needs rework=
.

It is not necessary to create VarToFile in the internal memory buffer.
You could generate it when the user calls GetVariable() in the user
provided buffer.

Best regards

Heinrich

> +			efi_set_variable_int(u"VarToFile",
> +					     &efi_guid_efi_rt_var_file,
> +					     EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					     EFI_VARIABLE_RUNTIME_ACCESS, 0, 0,
> +					     false);
> +		} else {
> +			struct efi_rt_properties_table *rt_prop =3D
> +				efi_get_configuration_table(&rt_prop_guid);
> +
> +			rt_prop->runtime_services_supported |=3D
> +					EFI_RT_SUPPORTED_SET_VARIABLE;
> +		}
>   	}
> +
>   	/* Switch variable services functions to runtime version */
>   	efi_runtime_services.get_variable =3D efi_get_variable_runtime;
>   	efi_runtime_services.get_next_variable_name =3D
> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_vari=
able_tee.c
> index dde135fd9f81..9d0e270591ea 100644
> --- a/lib/efi_loader/efi_variable_tee.c
> +++ b/lib/efi_loader/efi_variable_tee.c
> @@ -969,7 +969,6 @@ void efi_variables_boot_exit_notify(void)
>   		log_err("Can't populate EFI variables. No runtime variables will be =
available\n");
>   	else
>   		efi_var_buf_update(var_buf);
> -	free(var_buf);
>
>   	/* Update runtime service table */
>   	efi_runtime_services.query_variable_info =3D
> --
> 2.37.2
>

