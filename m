Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C807106ACD4
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 17:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93409842F2;
	Thu, 12 Mar 2026 18:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UJNB9axa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB08842F4; Thu, 12 Mar 2026 18:20:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58DC484238
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 18:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773336013; x=1773940813; i=xypron.glpk@gmx.de;
 bh=D/0pX4qOsJv5hWJ0cX5oFTOxEOvXGc+OFz8ucIPH2v0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UJNB9axaHk+cp9h2m3BlIhuXsduRwSf3uLe2MjjwATP1CaUGhPyEGlXFrwzJruox
 b9m1cD0zEGg+1L0FZbfCv5b7lzhGJ2yJRKM66qThbo+iaZmg13uV5LibW0YwT81MI
 qXTVQrM8rD4yF8XHpIk4FyiHyQ2VR2SMhAnXbnMOcqxfo+sJ3hOg82C05elmBv984
 HtKL1BAZ/AiZiCBPiaDzX0cU79cJxWxwwgSUlOUhHRxkm86ji3v82uRWKTkZghJbM
 aOsLY+JQnz11kfWsJUHTWr6QTSSMqHpZbrFDqeLs/ok9nbysAb1x5jBxRs+TURZto
 gfBg25bUdPk1HRp0gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1vZY5P00OI-0103SM; Thu, 12
 Mar 2026 18:20:13 +0100
Message-ID: <ab89f37a-9782-49c8-b06d-ee1b2d870650@gmx.de>
Date: Thu, 12 Mar 2026 18:20:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: avoid superfluous variable store writes on
 unchanged data
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shantur Rathore <i@shantur.com>, Tom Rini <trini@konsulko.com>
References: <00b03eb724de3e8b3e46ec630860e751bdc40011.1773322038.git.michal.simek@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <00b03eb724de3e8b3e46ec630860e751bdc40011.1773322038.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2BiJZUWO+hU0g1x0dCkXQgpZxDUBIvRZp3xwDe+nVIeQy/PskpS
 XXpQSIJxymO2KkAvhMC7NoduQIVry1f7Ll4MojSs2g10juPLnSeMdpRCpgVj2ypfz2a41J3
 1Z4muvmjGzeU3t0Zf8kIgvQza2ERKA3uJL86H0mrXt7FfwFzTxAH3m0VQZzxrKSAFHADA4O
 QhzNJQTGmekkFP5dZF1kg==
UI-OutboundReport: notjunk:1;M01:P0:HtMFWyy4Q5c=;sZezLHsojKGvrixw+aTfBHpLJRU
 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
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

On 3/12/26 14:27, Michal Simek wrote:
> Every SetVariable() call triggers efi_var_mem_ins() followed by
> efi_var_to_storage(), even when the variable value is not actually
> changing. This is unfriendly to flash-backed stores that suffer
> wear from unnecessary erase/write cycles.
>=20
> Add a change-detection path to efi_var_mem_ins(): when size2 =3D=3D 0
> (i.e. not an append) and the caller passes a non-NULL changep flag,
> look up the existing variable and compare attributes, length, time
> and data byte-by-byte. If everything matches, set *changep =3D false
> and return EFI_SUCCESS without touching the variable buffer.
>=20
> Both efi_set_variable_int() and efi_set_variable_runtime() now
> check the flag and skip efi_var_mem_del() / efi_var_to_storage()
> when nothing changed.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Thank you Michal for the patch.

I ran the VariableServices tests of the SCT with this patch on top of=20
origin/next and saw no new failures. The following are failing anyway=20
because our implementation of authorized variables is incomplete:

* AuthVar_Conf
* AuthVar_Func

Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>=20
>   include/efi_variable.h          |  8 +++++++-
>   lib/efi_loader/efi_var_common.c |  2 +-
>   lib/efi_loader/efi_var_mem.c    | 29 ++++++++++++++++++++++++++++-
>   lib/efi_loader/efi_variable.c   | 27 ++++++++++++++++++---------
>   4 files changed, 54 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/efi_variable.h b/include/efi_variable.h
> index fc1184e5ca1a..c3229c717d89 100644
> --- a/include/efi_variable.h
> +++ b/include/efi_variable.h
> @@ -216,6 +216,11 @@ void efi_var_mem_del(struct efi_var_entry *var);
>    * The variable is appended without checking if a variable of the same=
 name
>    * already exists. The two data buffers are concatenated.
>    *
> + * When @changep is non-NULL and @size2 is 0, the function compares the=
 new
> + * value against an existing variable with the same name and vendor. If
> + * attributes and data are identical the insertion is skipped and *@cha=
ngep
> + * is set to false, avoiding superfluous writes.
> + *
>    * @variable_name:	variable name
>    * @vendor:		GUID
>    * @attributes:		variable attributes
> @@ -224,13 +229,14 @@ void efi_var_mem_del(struct efi_var_entry *var);
>    * @size2:		size of the second data field
>    * @data2:		second data buffer
>    * @time:		time of authentication (as seconds since start of epoch)
> + * @changep:		pointer to change flag (may be NULL)
>    * Result:		status code
>    */
>   efi_status_t efi_var_mem_ins(const u16 *variable_name,
>   			     const efi_guid_t *vendor, u32 attributes,
>   			     const efi_uintn_t size1, const void *data1,
>   			     const efi_uintn_t size2, const void *data2,
> -			     const u64 time);
> +			     const u64 time, bool *changep);
>  =20
>   /**
>    * efi_var_mem_free() - determine free memory for variables
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_co=
mmon.c
> index c89a4fce4ff8..d63c2d1b1cd8 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -526,7 +526,7 @@ efi_status_t efi_var_restore(struct efi_var_file *bu=
f, bool safe)
>   			continue;
>   		ret =3D efi_var_mem_ins(var->name, &var->guid, var->attr,
>   				      var->length, data, 0, NULL,
> -				      var->time);
> +				      var->time, NULL);
>   		if (ret !=3D EFI_SUCCESS)
>   			log_err("Failed to set EFI variable %ls\n", var->name);
>   	}
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index 31180df9e3a0..e364672db81a 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -159,12 +159,39 @@ efi_status_t __efi_runtime efi_var_mem_ins(
>   				const efi_guid_t *vendor, u32 attributes,
>   				const efi_uintn_t size1, const void *data1,
>   				const efi_uintn_t size2, const void *data2,
> -				const u64 time)
> +				const u64 time, bool *changep)
>   {
>   	u16 *data;
>   	struct efi_var_entry *var;
>   	u32 var_name_len;
>  =20
> +	if (changep)
> +		*changep =3D true;
> +
> +	/*
> +	 * If this is not an append (size2 =3D=3D 0), check whether the variab=
le
> +	 * already exists with identical attributes and data. When nothing
> +	 * changed we can skip the write and avoid superfluous erases.
> +	 */
> +	if (!size2 && changep) {
> +		struct efi_var_entry *old;
> +
> +		old =3D efi_var_mem_find(vendor, variable_name, NULL);
> +		if (old && old->attr =3D=3D attributes &&
> +		    old->length =3D=3D size1 && old->time =3D=3D time) {
> +			u16 *old_data;
> +
> +			for (old_data =3D old->name; *old_data; ++old_data)
> +				;
> +			++old_data;
> +
> +			if (!memcmp(old_data, data1, size1)) {
> +				*changep =3D false;
> +				return EFI_SUCCESS;
> +			}
> +		}
> +	}
> +
>   	var =3D (struct efi_var_entry *)
>   	      ((uintptr_t)efi_var_buf + efi_var_buf->length);
>   	var_name_len =3D u16_strlen(variable_name) + 1;
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable=
.c
> index 8512bc20f11e..9923936c1b59 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -277,6 +277,7 @@ efi_status_t efi_set_variable_int(const u16 *variabl=
e_name,
>   	struct efi_var_entry *var;
>   	efi_uintn_t ret;
>   	bool append, delete;
> +	bool changed =3D false;
>   	u64 time =3D 0;
>   	enum efi_auth_var_type var_type;
>  =20
> @@ -366,6 +367,7 @@ efi_status_t efi_set_variable_int(const u16 *variabl=
e_name,
>   	if (delete) {
>   		/* EFI_NOT_FOUND has been handled before */
>   		attributes =3D var->attr;
> +		changed =3D true;
>   		ret =3D EFI_SUCCESS;
>   	} else if (append && var) {
>   		/*
> @@ -380,15 +382,19 @@ efi_status_t efi_set_variable_int(const u16 *varia=
ble_name,
>   		ret =3D efi_var_mem_ins(variable_name, vendor,
>   				      attributes & ~EFI_VARIABLE_APPEND_WRITE,
>   				      var->length, old_data, data_size, data,
> -				      time);
> +				      time, &changed);
>   	} else {
>   		ret =3D efi_var_mem_ins(variable_name, vendor, attributes,
> -				      data_size, data, 0, NULL, time);
> +				      data_size, data, 0, NULL, time,
> +				      &changed);
>   	}
>  =20
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
>  =20
> +	if (!changed)
> +		return EFI_SUCCESS;
> +
>   	efi_var_mem_del(var);
>  =20
>   	if (var_type =3D=3D EFI_AUTH_VAR_PK)
> @@ -396,10 +402,7 @@ efi_status_t efi_set_variable_int(const u16 *variab=
le_name,
>   	else
>   		ret =3D EFI_SUCCESS;
>  =20
> -	/*
> -	 * Write non-volatile EFI variables
> -	 * TODO: check if a value change has occured to avoid superfluous writ=
es
> -	 */
> +	/* Write non-volatile EFI variables to storage */
>   	if (attributes & EFI_VARIABLE_NON_VOLATILE) {
>   		if (IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE))
>   			return EFI_SUCCESS;
> @@ -498,6 +501,7 @@ efi_set_variable_runtime(u16 *variable_name, const e=
fi_guid_t *vendor,
>   	struct efi_var_entry *var;
>   	efi_uintn_t ret;
>   	bool append, delete;
> +	bool changed =3D false;
>   	u64 time =3D 0;
>  =20
>   	if (!IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
> @@ -549,6 +553,7 @@ efi_set_variable_runtime(u16 *variable_name, const e=
fi_guid_t *vendor,
>   	if (delete) {
>   		/* EFI_NOT_FOUND has been handled before */
>   		attributes =3D var->attr;
> +		changed =3D true;
>   		ret =3D EFI_SUCCESS;
>   	} else if (append && var) {
>   		u16 *old_data =3D (void *)((uintptr_t)var->name +
> @@ -556,15 +561,19 @@ efi_set_variable_runtime(u16 *variable_name, const=
 efi_guid_t *vendor,
>  =20
>   		ret =3D efi_var_mem_ins(variable_name, vendor, attributes,
>   				      var->length, old_data, data_size, data,
> -				      time);
> +				      time, &changed);
>   	} else {
>   		ret =3D efi_var_mem_ins(variable_name, vendor, attributes,
> -				      data_size, data, 0, NULL, time);
> +				      data_size, data, 0, NULL, time,
> +				      &changed);
>   	}
>  =20
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
> -	/* We are always inserting new variables, get rid of the old copy */
> +
> +	if (!changed)
> +		return EFI_SUCCESS;
> +
>   	efi_var_mem_del(var);
>  =20
>   	return EFI_SUCCESS;

