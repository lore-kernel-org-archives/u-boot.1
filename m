Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FEBC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 14:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08319864E5;
	Mon, 13 Nov 2023 15:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TM4KJ9y5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05BA486D82; Mon, 13 Nov 2023 15:37:42 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89E8863D3
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699886259; x=1700491059; i=xypron.glpk@gmx.de;
 bh=a7gZ7CDCrZ36wVM9lDAXM38wO1v1uusmbQ+SU4hCJv0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=TM4KJ9y5wlm0seXlXPOYCBWH5k9PLrpxgittdkQq6iG0I5e3LGJDhSxsErbJx3d+
 yvpDc8+f1sv2DCPhJxQWEzHyQMHijGQnfgYvaevrKvQnQxbPC/tZb8LUGFzwBRMjw
 9nt02xId0ArmaQYVbogTNkUAn+RVrndqVh5OdtEj+2/wlj2XgExCWNUKfF35kEf+J
 n8L2rwNP6zNYDYcjouUdtRxQDkM3xkJK6wgBdU82d34bkTL/ASXbwPlwcWnYqaU1c
 vPWHDPH8unICtEqIZgCAF/de/BkhYVnfqRuXAD+CCQWRSt78Mp3wDR0nSyAtiHm9Y
 ft7Sz4IIShTLX0tUBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzQkE-1rFw7G3qwC-00vLTg; Mon, 13
 Nov 2023 15:37:38 +0100
Message-ID: <f1fb200b-8aef-4cb8-b988-cb6f9a076132@gmx.de>
Date: Mon, 13 Nov 2023 15:37:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Clean up efi_dp_append and efi_dp_concat
Content-Language: en-US, de-DE
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: masahisa.kojima@linaro.org, u-boot@lists.denx.de
References: <20231107173636.114705-1-ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231107173636.114705-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:drisor1sLqmVAzcKnpSnqL4uhZixDRi0iBjs/haNDUta/bRgJ1a
 UzFK9RbeQXi9zsRjB51qcd0cWYpmxuuC321Wnh2SUUnd51Ujb9iLT2Z2Pww+J4dTEILe08d
 8c/pu4ojsjza5gmc3mGBsbigqRpDTPoc9ZYc/ZRbiU5qn+hE0PjsNp0VUDyxGq7VOcwJyKI
 BUGiRcCI5iDRLlc67zuKQ==
UI-OutboundReport: notjunk:1;M01:P0:ncNV0c9PpLI=;ekdkYJ4KLk2WZ9I24ufI7TJrSTJ
 MFNTE5LDzOTYF7TcMTyg/rz9W778ic3ukPq9Zr0zyFxzLXzonRaEI8YxJ4lRJ0I0jkY8TXUnP
 b8jGKP6po4y2qNxBpMzxW++TGEY283vTzLMgXL7bLL+HYlBtVgGiPjKAqk8XqMC/GKckoE+Rn
 8QhfeTJwJCYY1kVAWHeTl8jQ+39fwGKl+2P1hpH6if80Tuzq4FQZRRdBko3PQeTglA0mc40vY
 VmTkfWc8jPoetVeamuZnoydLQPlgNXvycCPfRopC7bowDHP3Kf6nKKsJO4SKSVVJ55/AtWut2
 TnJMfZ5j4fsNT5JPYaKEzqk//jJfuFKFNC+DLS34q5YiWDMAK6hgzgHQnnohBgblVdNXtIn9M
 RCNxaSc/kAD3afkohQtqjM3ciaPH1OL3Mft54Act1E70FwWGdh3u+koPs8shW1nQx/3LidCUU
 QYLTRn5KL1XMl0BWLdHuChsAKisUhZdwtdye9IJqF01juDqMP/km4SL6VH2ThvT0JqE4VBjGh
 vRcdNLaFHGcExnAm2oD6YDd4lkaTmGqeeoLoYVQB6aekL61bbD0RPPwN2SyaMLNkx7myMM1Dc
 Kt2Hm3kRGRbiGCIHY5ZrTNEJc85Vfd9NuCZ2tUSMa0vMQ7snt5Y/6QiNW18sDT558giterKA3
 SuM/hHQ5PmBKgiizKrI/ydeJQ28nEqLJZqHuelDByFtdOu1Uj28cEnh9LA6qtpSK1N0QQ9pjU
 M6q7kJe+ImadqI89zGIJrX8jv3tcq3xWO0XtOS3EJO/IuIPA9wZwWbEOASPhfMgKhA2LeDlUO
 U1b+rwi676kLzHxHTPPO2zb99Ysoq/eN8e6UYhgj50K5Ax15fFiqJDyM5H03LHqZfcnwvEyn0
 1jnmNtV0ARm5Qi1ChWQWQTrWVshxBi+s7g72cf/0W5QZdZeXLOdE64gZ9PisgqG7oeT2OIG7k
 hJAemB3eGwUTvITxmnzgywMuWJs=
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

On 11/7/23 18:36, Ilias Apalodimas wrote:
> Looking back at the initrd storing functionality, we introduced three
> functions, efi_dp_append_or_concatenate(), efi_dp_append/concat(). In
> hindsight we could have simplified that by a lot. First of all none of
> the functions append anything. They all allocate a new device path and
> concatenate the contents of two device paths in one. A boolean parameter
> controls the final device path -- if that's true an end node is injected
> between the two device paths.
>
> So let's rewrite this and make it a bit easier to read. Get rid of
> efi_dp_append(), efi_dp_concat() and rename
> efi_dp_append_or_concatenate() to efi_dp_concat(). This is far more
> intuitive and the only adjustment that is needed is an extra boolean
> argument on all callsites.

After this patch we still have efi_dp_append_instance(). The only
difference to efi_dp_concat(,,true) seems only to be the type of end
node used as separator.

Hence the last argument of efi_dp_contat() should be be either of:

* 0
* DEVICE_PATH_SUB_TYPE_INSTANCE_END
* DEVICE_PATH_SUB_TYPE_END

>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Kojima-san, I think this might affect your EFI HTTP boot series.
> I don't mind waiting for this and merging it after your series goes in
> (and adjust it). The changes should be trivial anyway
>
>   cmd/bootefi.c                              |  4 +-
>   cmd/eficonfig.c                            |  7 ++-
>   cmd/efidebug.c                             |  6 +-
>   include/efi_loader.h                       |  5 +-
>   lib/efi_loader/efi_bootmgr.c               |  2 +-
>   lib/efi_loader/efi_boottime.c              |  2 +-
>   lib/efi_loader/efi_device_path.c           | 66 ++++++----------------
>   lib/efi_loader/efi_device_path_utilities.c |  2 +-
>   8 files changed, 32 insertions(+), 62 deletions(-)
>
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index 20e5c94a33a4..eb839136bf7e 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -513,8 +513,8 @@ efi_status_t efi_run_image(void *source_buffer, efi_=
uintn_t source_size)
>   			goto out;
>   		msg_path =3D file_path;
>   	} else {
> -		file_path =3D efi_dp_append(bootefi_device_path,
> -					  bootefi_image_path);
> +		file_path =3D efi_dp_concat(bootefi_device_path,
> +					  bootefi_image_path, false);
>   		msg_path =3D bootefi_image_path;
>   		log_debug("Loaded from disk\n");
>   	}
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index e6e8a0a488e7..470adb7eddbf 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -528,7 +528,7 @@ struct efi_device_path *eficonfig_create_device_path=
(struct efi_device_path *dp_
>   	p +=3D fp_size;
>   	*((struct efi_device_path *)p) =3D END;
>
> -	dp =3D efi_dp_append(dp_volume, (struct efi_device_path *)buf);
> +	dp =3D efi_dp_concat(dp_volume, (struct efi_device_path *)buf, false);
>   	free(buf);
>
>   	return dp;
> @@ -1481,7 +1481,8 @@ static efi_status_t eficonfig_edit_boot_option(u16=
 *varname, struct eficonfig_bo
>   			ret =3D EFI_OUT_OF_RESOURCES;
>   			goto out;
>   		}
> -		initrd_dp =3D efi_dp_append((const struct efi_device_path *)&id_dp, d=
p);
> +		initrd_dp =3D efi_dp_concat((const struct efi_device_path *)&id_dp,
> +					  dp, false);
>   		efi_free_pool(dp);
>   	}
>
> @@ -1492,7 +1493,7 @@ static efi_status_t eficonfig_edit_boot_option(u16=
 *varname, struct eficonfig_bo
>   	}
>   	final_dp_size =3D efi_dp_size(dp) + sizeof(END);
>   	if (initrd_dp) {
> -		final_dp =3D efi_dp_concat(dp, initrd_dp);
> +		final_dp =3D efi_dp_concat(dp, initrd_dp, true);
>   		final_dp_size +=3D efi_dp_size(initrd_dp) + sizeof(END);
>   	} else {
>   		final_dp =3D efi_dp_dup(dp);
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index 201531ac19fc..a62298bf5987 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -698,8 +698,8 @@ struct efi_device_path *create_initrd_dp(const char =
*dev, const char *part,
>   	if (!short_fp)
>   		short_fp =3D tmp_fp;
>
> -	initrd_dp =3D efi_dp_append((const struct efi_device_path *)&id_dp,
> -				  short_fp);
> +	initrd_dp =3D efi_dp_concat((const struct efi_device_path *)&id_dp,
> +				  short_fp, false);
>
>   out:
>   	efi_free_pool(tmp_dp);
> @@ -841,7 +841,7 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, in=
t flag,
>   		goto out;
>   	}
>
> -	final_fp =3D efi_dp_concat(file_path, initrd_dp);
> +	final_fp =3D efi_dp_concat(file_path, initrd_dp, true);
>   	if (!final_fp) {
>   		printf("Cannot create final device path\n");
>   		r =3D CMD_RET_FAILURE;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index e24410505f40..398cd20c7ae6 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -808,8 +808,6 @@ efi_uintn_t efi_dp_instance_size(const struct efi_de=
vice_path *dp);
>   /* size of multi-instance device path excluding end node */
>   efi_uintn_t efi_dp_size(const struct efi_device_path *dp);
>   struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp);
> -struct efi_device_path *efi_dp_append(const struct efi_device_path *dp1=
,
> -				      const struct efi_device_path *dp2);
>   struct efi_device_path *efi_dp_append_node(const struct efi_device_pat=
h *dp,
>   					   const struct efi_device_path *node);
>   /* Create a device path node of given type, sub-type, length */
> @@ -928,7 +926,8 @@ struct efi_load_option {
>   struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
>   				       const efi_guid_t *guid);
>   struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp=
1,
> -				      const struct efi_device_path *dp2);
> +				      const struct efi_device_path *dp2,
> +				      bool split_end_node);
>   struct efi_device_path *search_gpt_dp_node(struct efi_device_path *dev=
ice_path);
>   efi_status_t efi_deserialize_load_option(struct efi_load_option *lo, u=
8 *data,
>   					 efi_uintn_t *size);
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a40762c74c83..646c7c7faaad 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -110,7 +110,7 @@ static efi_status_t try_load_from_file_path(efi_hand=
le_t *fs_handles,
>   		if (!dp)
>   			continue;
>
> -		dp =3D efi_dp_append(dp, fp);
> +		dp =3D efi_dp_concat(dp, fp, false);
>   		if (!dp)
>   			continue;
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index 0b7579cb5af1..709ea07655c2 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -1821,7 +1821,7 @@ efi_status_t efi_setup_loaded_image(struct efi_dev=
ice_path *device_path,
>   	if (device_path) {
>   		info->device_handle =3D efi_dp_find_obj(device_path, NULL, NULL);
>
> -		dp =3D efi_dp_append(device_path, file_path);
> +		dp =3D efi_dp_concat(device_path, file_path, false);
>   		if (!dp) {
>   			ret =3D EFI_OUT_OF_RESOURCES;
>   			goto failure;
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index ed7214f3a347..ad79b65843e9 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -272,30 +272,27 @@ struct efi_device_path *efi_dp_dup(const struct ef=
i_device_path *dp)
>   }
>
>   /**
> - * efi_dp_append_or_concatenate() - Append or concatenate two device pa=
ths.
> - *				    Concatenated device path will be separated
> - *				    by a sub-type 0xff end node
> + * efi_dp_concat() - Concatenate two device paths and add and terminate=
 them
> + *                   with an end node.
>    *
> - * @dp1:	First device path
> - * @dp2:	Second device path
> - * @concat:	If true the two device paths will be concatenated and separ=
ated
> - *		by an end of entrire device path sub-type 0xff end node.
> - *		If true the second device path will be appended to the first and
> - *		terminated by an end node
> + * @dp1:	    First device path
> + * @dp2:	    Second device path
> + * @split_end_node: If true the two device paths will be concatenated a=
nd
> + *                  separated by an end node.

This description is unclear. Do you mean DEVICE_PATH_SUB_TYPE_END or
DEVICE_PATH_SUB_TYPE_INSTANCE_END?

We would better make the parameter a three-state value:

* 0
* DEVICE_PATH_SUB_TYPE_INSTANCE_END
* DEVICE_PATH_SUB_TYPE_END

> + *		    If false the second device path will be concatenated to the
> + *		    first one as-is.
>    *
>    * Return:
>    * concatenated device path or NULL. Caller must free the returned val=
ue
>    */
> -static struct
> -efi_device_path *efi_dp_append_or_concatenate(const struct efi_device_p=
ath *dp1,
> -					      const struct efi_device_path *dp2,
> -					      bool concat)
> +struct
> +efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
> +			       const struct efi_device_path *dp2,
> +			       bool split_end_node)
>   {
>   	struct efi_device_path *ret;
>   	size_t end_size =3D sizeof(END);

This assignment is not needed if (!dp1 || !dp2).

>
> -	if (concat)
> -		end_size =3D 2 * sizeof(END);
>   	if (!dp1 && !dp2) {
>   		/* return an end node */
>   		ret =3D efi_dp_dup(&END);
> @@ -307,14 +304,18 @@ efi_device_path *efi_dp_append_or_concatenate(cons=
t struct efi_device_path *dp1,
>   		/* both dp1 and dp2 are non-null */
>   		unsigned sz1 =3D efi_dp_size(dp1);
>   		unsigned sz2 =3D efi_dp_size(dp2);
> -		void *p =3D efi_alloc(sz1 + sz2 + end_size);
> +		void *p;
> +
> +		if (split_end_node)
> +			end_size =3D 2 * sizeof(END);

We assign end_size twice in this case. We should instead move the first
assignment to the if:

		if (!split_end_node)
			end_size =3D sizeof(END);
		else
			end_size =3D 2 * sizeof(END);

Best regards

Heinrich

> +		p =3D efi_alloc(sz1 + sz2 + end_size);
>   		if (!p)
>   			return NULL;
>   		ret =3D p;
>   		memcpy(p, dp1, sz1);
>   		p +=3D sz1;
>
> -		if (concat) {
> +		if (split_end_node) {
>   			memcpy(p, &END, sizeof(END));
>   			p +=3D sizeof(END);
>   		}
> @@ -328,37 +329,6 @@ efi_device_path *efi_dp_append_or_concatenate(const=
 struct efi_device_path *dp1,
>   	return ret;
>   }
>
> -/**
> - * efi_dp_append() - Append a device to an existing device path.
> - *
> - * @dp1:	First device path
> - * @dp2:	Second device path
> - *
> - * Return:
> - * concatenated device path or NULL. Caller must free the returned valu=
e
> - */
> -struct efi_device_path *efi_dp_append(const struct efi_device_path *dp1=
,
> -				      const struct efi_device_path *dp2)
> -{
> -	return efi_dp_append_or_concatenate(dp1, dp2, false);
> -}
> -
> -/**
> - * efi_dp_concat() - Concatenate 2 device paths. The final device path =
will
> - *                   contain two device paths separated by and end node=
 (0xff).
> - *
> - * @dp1:	First device path
> - * @dp2:	Second device path
> - *
> - * Return:
> - * concatenated device path or NULL. Caller must free the returned valu=
e
> - */
> -struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1=
,
> -				      const struct efi_device_path *dp2)
> -{
> -	return efi_dp_append_or_concatenate(dp1, dp2, true);
> -}
> -
>   struct efi_device_path *efi_dp_append_node(const struct efi_device_pat=
h *dp,
>   					   const struct efi_device_path *node)
>   {
> diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader=
/efi_device_path_utilities.c
> index a07d9bab3a3c..fa211aee495e 100644
> --- a/lib/efi_loader/efi_device_path_utilities.c
> +++ b/lib/efi_loader/efi_device_path_utilities.c
> @@ -77,7 +77,7 @@ static struct efi_device_path * EFIAPI append_device_p=
ath(
>   	const struct efi_device_path *src2)
>   {
>   	EFI_ENTRY("%pD, %pD", src1, src2);
> -	return EFI_EXIT(efi_dp_append(src1, src2));
> +	return EFI_EXIT(efi_dp_concat(src1, src2, false));
>   }
>
>   /*
> --
> 2.40.1
>

