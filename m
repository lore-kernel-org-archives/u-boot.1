Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C43AC54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04A9D83281;
	Fri, 23 May 2025 15:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="f85kjX2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CCA3831FE; Fri, 23 May 2025 15:18:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 249A58310F
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748006277; x=1748611077; i=xypron.glpk@gmx.de;
 bh=YG5M2Oz+ssKBj8KEAqhhuGTDDvJE6lCWidm7cIlBoWI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=f85kjX2H3JSgMT/XLuRc4YVSCwu+f3Qkk9UWcrjRNFhm6WXa/MF9U9ik0vkSgGaz
 hGVhNT2IuaRjZ185LlAVj9Ly+h4D2KBPvzBeuTxNwEkdlQTqz9CLBUvPvDXWt9b2V
 DtAfKbnxj1IJPfTf2r/DmNzDVUVPZ+ixB/pDHb04WeL5Rantnsqg5/MzsMTu6Qle8
 DNgjADH8vmndt3Z3aWJv6eopFh1DIwgfVaSDfiDRVTvpJCkJ1T0qQLJDcIZzoTGA9
 U+TXEud1oHQ2RVSnW1DrprajMNXuuaBocEfeGM79ATFuLECQeyO+HgTTYhB+DFPC6
 H5aFnZS6IaK3SSVkXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4b1y-1uK6RW3exq-00CuRU; Fri, 23
 May 2025 15:17:57 +0200
Message-ID: <953a44b8-fcdc-4516-bb1c-77e0afb67b9f@gmx.de>
Date: Fri, 23 May 2025 15:17:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] efi: Rename END to EFI_DP_END
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Moritz Fischer <moritzf@google.com>, Pawel Kochanowski
 <pkochanowski@sii.pl>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250523130651.1329593-1-sjg@chromium.org>
 <20250523130651.1329593-4-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250523130651.1329593-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R5cW4vRh8zZE3z1EypI3AXcyaQG2aHHXOEGh9fXY1Rj9Jh8OppR
 sHQhwrKHzh6GbTeXxS18iXIkGsiDd2OqGslz5lGaHfk3JNwpJSGaOSU68CAs0rsz2yEL4zJ
 Te27yEIT77CqAZ5NNn3YbqM7Cd+oAo6Lw0Q8rXNteuY9sbiVVnSgjGOFUdVjzmUHo2eaKEn
 jptpTRkKbTtmXl+HnVvXg==
UI-OutboundReport: notjunk:1;M01:P0:EB0q87hRNI4=;UQbenZpeekD69Ne5mq2EIqvSkgC
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

On 23.05.25 15:06, Simon Glass wrote:
> This exported symbol has a very generic name. Rename it to indicate that
> it relates to EFI and device-paths.
>=20
> Fix checkpatch warnings related to use of multiple assignments.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>=20
>   cmd/eficonfig.c                            |  4 +-
>   cmd/efidebug.c                             |  6 +-
>   include/efi_device_path.h                  | 27 +++----
>   lib/efi_loader/efi_bootmgr.c               |  3 +-
>   lib/efi_loader/efi_device_path.c           | 86 +++++++++++-----------
>   lib/efi_loader/efi_device_path_utilities.c |  2 +-
>   lib/efi_loader/efi_helper.c                |  6 +-
>   7 files changed, 68 insertions(+), 66 deletions(-)
>=20
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index 7142a704fef..9de8da6f0a4 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -515,7 +515,7 @@ struct efi_device_path *eficonfig_create_device_path=
(struct efi_device_path *dp_
>   	struct efi_device_path_file_path *fp;
>  =20
>   	fp_size =3D sizeof(struct efi_device_path) + u16_strsize(current_path=
);
> -	buf =3D calloc(1, fp_size + sizeof(END));
> +	buf =3D calloc(1, fp_size + sizeof(EFI_DP_END));
>   	if (!buf)
>   		return NULL;
>  =20
> @@ -527,7 +527,7 @@ struct efi_device_path *eficonfig_create_device_path=
(struct efi_device_path *dp_
>  =20
>   	p =3D buf;
>   	p +=3D fp_size;
> -	*((struct efi_device_path *)p) =3D END;
> +	*((struct efi_device_path *)p) =3D EFI_DP_END;
>  =20
>   	dp =3D efi_dp_shorten(dp_volume);
>   	if (!dp)
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index d7006307ec4..f52ba8de279 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -841,7 +841,7 @@ static int efi_boot_add_uri(int argc, char *const ar=
gv[], u16 *var_name16,
>   	lo->label =3D label;
>  =20
>   	uridp_len =3D sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
> -	uridp =3D efi_alloc(uridp_len + sizeof(END));
> +	uridp =3D efi_alloc(uridp_len + sizeof(EFI_DP_END));
>   	if (!uridp) {
>   		log_err("Out of memory\n");
>   		return CMD_RET_FAILURE;
> @@ -851,10 +851,10 @@ static int efi_boot_add_uri(int argc, char *const =
argv[], u16 *var_name16,
>   	uridp->dp.length =3D uridp_len;
>   	strcpy(uridp->uri, argv[3]);
>   	pos =3D (char *)uridp + uridp_len;
> -	memcpy(pos, &END, sizeof(END));
> +	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
>  =20
>   	*file_path =3D &uridp->dp;
> -	*fp_size +=3D uridp_len + sizeof(END);
> +	*fp_size +=3D uridp_len + sizeof(EFI_DP_END);
>  =20
>   	return CMD_RET_SUCCESS;
>   }
> diff --git a/include/efi_device_path.h b/include/efi_device_path.h
> index 252253c5f28..c6a548946a6 100644
> --- a/include/efi_device_path.h
> +++ b/include/efi_device_path.h
> @@ -14,12 +14,12 @@ struct blk_desc;
>   struct efi_load_option;
>  =20
>   /*
> - * END - Template end node for EFI device paths.
> + * EFI_DP_END - Template end node for EFI device paths.
>    *
>    * Represents the terminating node of an EFI device path.
>    * It has a type of DEVICE_PATH_TYPE_END and sub_type DEVICE_PATH_SUB_=
TYPE_END
>    */
> -extern const struct efi_device_path END;
> +extern const struct efi_device_path EFI_DP_END;
>  =20
>   /**
>    * efi_dp_next() - Iterate to next block in device-path
> @@ -84,11 +84,11 @@ efi_handle_t efi_dp_find_obj(struct efi_device_path =
*dp, const efi_guid_t *guid,
>    * efi_dp_last_node() - Determine the last device path node before the=
 end node
>    *
>    * Iterate through the device path to find the very last node before
> - * the terminating END node.
> + * the terminating EFI_DP_END node.
>    *
>    * @dp: Pointer to the device path.
>    * Return: Pointer to the last actual data node before the end node if=
 it exists
> - * otherwise NULL (e.g., if dp is NULL or only an END node).
> + * otherwise NULL (e.g., if dp is NULL or only an EFI_DP_END node).
>    */
>   const struct efi_device_path *efi_dp_last_node(const struct efi_device=
_path *dp);
>  =20
> @@ -100,8 +100,8 @@ const struct efi_device_path *efi_dp_last_node(const=
 struct efi_device_path *dp)
>    * end node (if any) or the final device path. The end node is not inc=
luded.
>    *
>    * @dp: Pointer to the device path.
> - * Return: Size in bytes of the first instance, or 0 if dp is NULL or a=
n END
> - * node
> + * Return: Size in bytes of the first instance, or 0 if dp is NULL or a=
n
> + * EFI_DP_END node
>    */
>   efi_uintn_t efi_dp_instance_size(const struct efi_device_path *dp);
>  =20
> @@ -114,7 +114,7 @@ efi_uintn_t efi_dp_instance_size(const struct efi_de=
vice_path *dp);
>    *
>    * @dp: Pointer to the device path.
>    * Return: Total size in bytes of all nodes in the device path (exclud=
ing the
> - * final END node), or 0 if dp is NULL.
> + * final EFI_DP_END node), or 0 if dp is NULL.
>    */
>   efi_uintn_t efi_dp_size(const struct efi_device_path *dp);
>  =20
> @@ -138,7 +138,7 @@ struct efi_device_path *efi_dp_dup(const struct efi_=
device_path *dp);
>    * @dp2:        Second device path
>    * @split_end_node:
>    * - 0 to concatenate (dp1 is assumed not to have an end node or it's =
ignored,
> - *   dp2 is appended, then one END node)
> + *   dp2 is appended, then one EFI_DP_END node)
>    * - 1 to concatenate with end node added as separator (dp1, END_THIS_=
INSTANCE,
>    *   dp2, END_ENTIRE)
>    *
> @@ -159,10 +159,11 @@ struct efi_device_path *efi_dp_concat(const struct=
 efi_device_path *dp1,
>    * Create a new device path by appending a given node to an existing
>    * device path.
>    * If the original device path @dp is NULL, a new path is created
> - * with the given @node followed by an END node.
> + * with the given @node followed by an EFI_DP_END node.
>    * If the @node is NULL and @dp is not NULL, the original path @dp is
>    * duplicated.
> - * If both @dp and @node are NULL, a path with only an END node is retu=
rned.
> + * If both @dp and @node are NULL, a path with only an EFI_DP_END node =
is
> + * returned.
>    * The caller must free the returned path (e.g., using efi_free()).
>    *
>    * @dp:   Original device path (can be NULL).
> @@ -215,7 +216,7 @@ efi_dp_append_instance(const struct efi_device_path =
*dp,
>    *
>    * Given a pointer to a pointer to a device path (@dp), this function =
extracts
>    * the first instance from the path. It allocates a new path for this =
extracted
> - * instance (including its instance-specific END node). The input point=
er
> + * instance (including its instance-specific EFI_DP_END node). The inpu=
t pointer
>    * (*@dp) is then updated to point to the start of the next instance i=
n the
>    * original path, or set to NULL if no more instances remain.
>    * The caller is responsible for freeing the returned instance path (e=
.g.,
> @@ -225,7 +226,7 @@ efi_dp_append_instance(const struct efi_device_path =
*dp,
>    * On output, *@dp is updated to point to the start of the next instan=
ce,
>    * or NULL if no more instances.
>    * @size: Optional pointer to an efi_uintn_t variable that will receiv=
e the size
> - * of the extracted instance path (including its END node).
> + * of the extracted instance path (including its EFI_DP_END node).
>    * Return: Pointer to a newly allocated device path for the extracted =
instance,
>    * or NULL if no instance could be extracted or an error occurred (e.g=
.,
>    * allocation failure).
> @@ -407,7 +408,7 @@ struct efi_device_path *search_gpt_dp_node(struct ef=
i_device_path *device_path);
>    *
>    * Set the device path to an IPv4 path as provided by efi_dp_from_ipv4
>    * concatenated with a device path of subtype DEVICE_PATH_SUB_TYPE_MSG=
_URI,
> - * and an END node.
> + * and an EFI_DP_3 node.

This looks like a typo.

Best regards

Heinrich

>    *
>    * @server:	URI of remote server
>    * @dev:	net udevice
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 8579cc1a8d7..f223e6cc064 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -843,7 +843,8 @@ efi_bootmgr_enumerate_boot_options(struct eficonfig_=
media_boot_option *opt,
>   		lo.label =3D dev_name;
>   		lo.attributes =3D LOAD_OPTION_ACTIVE;
>   		lo.file_path =3D device_path;
> -		lo.file_path_length =3D efi_dp_size(device_path) + sizeof(END);
> +		lo.file_path_length =3D efi_dp_size(device_path) +
> +			sizeof(EFI_DP_END);
>   		/*
>   		 * Set the dedicated guid to optional_data, it is used to identify
>   		 * the boot option that automatically generated by the bootmenu.
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index b53fdb1b9c2..e138c6c24de 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -23,11 +23,11 @@
>   #include <asm-generic/unaligned.h>
>   #include <linux/compat.h> /* U16_MAX */
>  =20
> -/* template END node: */
> -const struct efi_device_path END =3D {
> +/* template EFI_DP_END node: */
> +const struct efi_device_path EFI_DP_END =3D {
>   	.type     =3D DEVICE_PATH_TYPE_END,
>   	.sub_type =3D DEVICE_PATH_SUB_TYPE_END,
> -	.length   =3D sizeof(END),
> +	.length   =3D sizeof(EFI_DP_END),
>   };
>  =20
>   #if defined(CONFIG_MMC)
> @@ -215,7 +215,7 @@ efi_uintn_t efi_dp_size(const struct efi_device_path=
 *dp)
>   struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
>   {
>   	struct efi_device_path *ndp;
> -	size_t sz =3D efi_dp_size(dp) + sizeof(END);
> +	size_t sz =3D efi_dp_size(dp) + sizeof(EFI_DP_END);
>  =20
>   	if (!dp)
>   		return NULL;
> @@ -238,7 +238,7 @@ efi_device_path *efi_dp_concat(const struct efi_devi=
ce_path *dp1,
>  =20
>   	if (!dp1 && !dp2) {
>   		/* return an end node */
> -		ret =3D efi_dp_dup(&END);
> +		ret =3D efi_dp_dup(&EFI_DP_END);
>   	} else if (!dp1) {
>   		ret =3D efi_dp_dup(dp2);
>   	} else if (!dp2) {
> @@ -255,9 +255,9 @@ efi_device_path *efi_dp_concat(const struct efi_devi=
ce_path *dp1,
>   			sz1 =3D split_end_node;
>  =20
>   		if (split_end_node)
> -			end_size =3D 2 * sizeof(END);
> +			end_size =3D 2 * sizeof(EFI_DP_END);
>   		else
> -			end_size =3D sizeof(END);
> +			end_size =3D sizeof(EFI_DP_END);
>   		p =3D efi_alloc(sz1 + sz2 + end_size);
>   		if (!p)
>   			return NULL;
> @@ -266,14 +266,14 @@ efi_device_path *efi_dp_concat(const struct efi_de=
vice_path *dp1,
>   		p +=3D sz1;
>  =20
>   		if (split_end_node) {
> -			memcpy(p, &END, sizeof(END));
> -			p +=3D sizeof(END);
> +			memcpy(p, &EFI_DP_END, sizeof(EFI_DP_END));
> +			p +=3D sizeof(EFI_DP_END);
>   		}
>  =20
>   		/* the end node of the second device path has to be retained */
>   		memcpy(p, dp2, sz2);
>   		p +=3D sz2;
> -		memcpy(p, &END, sizeof(END));
> +		memcpy(p, &EFI_DP_END, sizeof(EFI_DP_END));
>   	}
>  =20
>   	return ret;
> @@ -285,26 +285,26 @@ struct efi_device_path *efi_dp_append_node(const s=
truct efi_device_path *dp,
>   	struct efi_device_path *ret;
>  =20
>   	if (!node && !dp) {
> -		ret =3D efi_dp_dup(&END);
> +		ret =3D efi_dp_dup(&EFI_DP_END);
>   	} else if (!node) {
>   		ret =3D efi_dp_dup(dp);
>   	} else if (!dp) {
>   		size_t sz =3D node->length;
> -		void *p =3D efi_alloc(sz + sizeof(END));
> +		void *p =3D efi_alloc(sz + sizeof(EFI_DP_END));
>   		if (!p)
>   			return NULL;
>   		memcpy(p, node, sz);
> -		memcpy(p + sz, &END, sizeof(END));
> +		memcpy(p + sz, &EFI_DP_END, sizeof(EFI_DP_END));
>   		ret =3D p;
>   	} else {
>   		/* both dp and node are non-null */
>   		size_t sz =3D efi_dp_size(dp);
> -		void *p =3D efi_alloc(sz + node->length + sizeof(END));
> +		void *p =3D efi_alloc(sz + node->length + sizeof(EFI_DP_END));
>   		if (!p)
>   			return NULL;
>   		memcpy(p, dp, sz);
>   		memcpy(p + sz, node, node->length);
> -		memcpy(p + sz + node->length, &END, sizeof(END));
> +		memcpy(p + sz + node->length, &EFI_DP_END, sizeof(EFI_DP_END));
>   		ret =3D p;
>   	}
>  =20
> @@ -342,17 +342,17 @@ struct efi_device_path *efi_dp_append_instance(
>   		return efi_dp_dup(dpi);
>   	sz =3D efi_dp_size(dp);
>   	szi =3D efi_dp_instance_size(dpi);
> -	p =3D efi_alloc(sz + szi + 2 * sizeof(END));
> +	p =3D efi_alloc(sz + szi + 2 * sizeof(EFI_DP_END));
>   	if (!p)
>   		return NULL;
>   	ret =3D p;
> -	memcpy(p, dp, sz + sizeof(END));
> +	memcpy(p, dp, sz + sizeof(EFI_DP_END));
>   	p =3D (void *)p + sz;
>   	p->sub_type =3D DEVICE_PATH_SUB_TYPE_INSTANCE_END;
> -	p =3D (void *)p + sizeof(END);
> +	p =3D (void *)p + sizeof(EFI_DP_END);
>   	memcpy(p, dpi, szi);
>   	p =3D (void *)p + szi;
> -	memcpy(p, &END, sizeof(END));
> +	memcpy(p, &EFI_DP_END, sizeof(EFI_DP_END));
>   	return ret;
>   }
>  =20
> @@ -367,17 +367,17 @@ struct efi_device_path *efi_dp_get_next_instance(s=
truct efi_device_path **dp,
>   	if (!dp || !*dp)
>   		return NULL;
>   	sz =3D efi_dp_instance_size(*dp);
> -	p =3D efi_alloc(sz + sizeof(END));
> +	p =3D efi_alloc(sz + sizeof(EFI_DP_END));
>   	if (!p)
>   		return NULL;
> -	memcpy(p, *dp, sz + sizeof(END));
> +	memcpy(p, *dp, sz + sizeof(EFI_DP_END));
>   	*dp =3D (void *)*dp + sz;
>   	if ((*dp)->sub_type =3D=3D DEVICE_PATH_SUB_TYPE_INSTANCE_END)
> -		*dp =3D (void *)*dp + sizeof(END);
> +		*dp =3D (void *)*dp + sizeof(EFI_DP_END);
>   	else
>   		*dp =3D NULL;
>   	if (size)
> -		*size =3D sz + sizeof(END);
> +		*size =3D sz + sizeof(EFI_DP_END);
>   	return p;
>   }
>  =20
> @@ -764,13 +764,13 @@ struct efi_device_path *efi_dp_from_part(struct bl=
k_desc *desc, int part)
>   {
>   	void *buf, *start;
>  =20
> -	start =3D buf =3D efi_alloc(dp_part_size(desc, part) + sizeof(END));
> -	if (!buf)
> +	start =3D efi_alloc(dp_part_size(desc, part) + sizeof(EFI_DP_END));
> +	if (!start)
>   		return NULL;
>  =20
> -	buf =3D dp_part_fill(buf, desc, part);
> +	buf =3D dp_part_fill(start, desc, part);
>  =20
> -	*((struct efi_device_path *)buf) =3D END;
> +	*((struct efi_device_path *)buf) =3D EFI_DP_END;
>  =20
>   	return start;
>   }
> @@ -837,7 +837,7 @@ struct efi_device_path *efi_dp_from_file(const struc=
t efi_device_path *dp,
>   	if (fpsize > U16_MAX)
>   		return NULL;
>  =20
> -	buf =3D efi_alloc(dpsize + fpsize + sizeof(END));
> +	buf =3D efi_alloc(dpsize + fpsize + sizeof(EFI_DP_END));
>   	if (!buf)
>   		return NULL;
>  =20
> @@ -854,7 +854,7 @@ struct efi_device_path *efi_dp_from_file(const struc=
t efi_device_path *dp,
>   		pos +=3D fpsize;
>   	}
>  =20
> -	memcpy(pos, &END, sizeof(END));
> +	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
>  =20
>   	return buf;
>   }
> @@ -863,7 +863,7 @@ struct efi_device_path *efi_dp_from_uart(void)
>   {
>   	void *buf, *pos;
>   	struct efi_device_path_uart *uart;
> -	size_t dpsize =3D dp_size(dm_root()) + sizeof(*uart) + sizeof(END);
> +	size_t dpsize =3D dp_size(dm_root()) + sizeof(*uart) + sizeof(EFI_DP_E=
ND);
>  =20
>   	buf =3D efi_alloc(dpsize);
>   	if (!buf)
> @@ -874,7 +874,7 @@ struct efi_device_path *efi_dp_from_uart(void)
>   	uart->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MSG_UART;
>   	uart->dp.length =3D sizeof(*uart);
>   	pos +=3D sizeof(*uart);
> -	memcpy(pos, &END, sizeof(END));
> +	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
>  =20
>   	return buf;
>   }
> @@ -888,13 +888,13 @@ struct efi_device_path __maybe_unused *efi_dp_from=
_eth(struct udevice *dev)
>  =20
>   	dpsize +=3D dp_size(dev);
>  =20
> -	start =3D buf =3D efi_alloc(dpsize + sizeof(END));
> -	if (!buf)
> +	start =3D efi_alloc(dpsize + sizeof(EFI_DP_END));
> +	if (!start)
>   		return NULL;
>  =20
> -	buf =3D dp_fill(buf, dev);
> +	buf =3D dp_fill(start, dev);
>  =20
> -	*((struct efi_device_path *)buf) =3D END;
> +	*((struct efi_device_path *)buf) =3D EFI_DP_END;
>  =20
>   	return start;
>   }
> @@ -904,7 +904,7 @@ struct efi_device_path __maybe_unused *efi_dp_from_e=
th(struct udevice *dev)
>    *
>    * Set the device path to an ethernet device path as provided by
>    * efi_dp_from_eth() concatenated with a device path of subtype
> - * DEVICE_PATH_SUB_TYPE_MSG_IPV4, and an END node.
> + * DEVICE_PATH_SUB_TYPE_MSG_IPV4, and an EFI_DP_END node.
>    *
>    * @ip:		IPv4 local address
>    * @mask:	network mask
> @@ -935,7 +935,7 @@ static struct efi_device_path *efi_dp_from_ipv4(stru=
ct efi_ipv4_address *ip,
>   	if (srv)
>   		memcpy(&dp.ipv4dp.remote_ip_address, srv, sizeof(*srv));
>   	pos =3D &dp.end;
> -	memcpy(pos, &END, sizeof(END));
> +	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
>  =20
>   	dp1 =3D efi_dp_from_eth(dev);
>   	if (!dp1)
> @@ -981,7 +981,7 @@ struct efi_device_path *efi_dp_from_http(const char =
*server, struct udevice *dev
>   	}
>  =20
>   	uridp_len =3D sizeof(struct efi_device_path) + strlen(tmp) + 1;
> -	uridp =3D efi_alloc(uridp_len + sizeof(END));
> +	uridp =3D efi_alloc(uridp_len + sizeof(EFI_DP_END));
>   	if (!uridp) {
>   		log_err("Out of memory\n");
>   		return NULL;
> @@ -993,7 +993,7 @@ struct efi_device_path *efi_dp_from_http(const char =
*server, struct udevice *dev
>   	memcpy(uridp->uri, tmp, strlen(tmp) + 1);
>  =20
>   	pos =3D (char *)uridp + uridp_len;
> -	memcpy(pos, &END, sizeof(END));
> +	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
>  =20
>   	dp2 =3D efi_dp_concat(dp1, (const struct efi_device_path *)uridp, 0);
>  =20
> @@ -1010,11 +1010,11 @@ struct efi_device_path *efi_dp_from_mem(uint32_t=
 memory_type, void *start_ptr,
>   	struct efi_device_path_memory *mdp;
>   	void *buf, *start;
>  =20
> -	start =3D buf =3D efi_alloc(sizeof(*mdp) + sizeof(END));
> -	if (!buf)
> +	start =3D efi_alloc(sizeof(*mdp) + sizeof(EFI_DP_END));
> +	if (!start)
>   		return NULL;
>  =20
> -	mdp =3D buf;
> +	mdp =3D start;
>   	mdp->dp.type =3D DEVICE_PATH_TYPE_HARDWARE_DEVICE;
>   	mdp->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MEMORY;
>   	mdp->dp.length =3D sizeof(*mdp);
> @@ -1023,7 +1023,7 @@ struct efi_device_path *efi_dp_from_mem(uint32_t m=
emory_type, void *start_ptr,
>   	mdp->end_address =3D mdp->start_address + size;
>   	buf =3D &mdp[1];
>  =20
> -	*((struct efi_device_path *)buf) =3D END;
> +	*((struct efi_device_path *)buf) =3D EFI_DP_END;
>  =20
>   	return start;
>   }
> diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader=
/efi_device_path_utilities.c
> index f3ef3eabdae..87d52df5066 100644
> --- a/lib/efi_loader/efi_device_path_utilities.c
> +++ b/lib/efi_loader/efi_device_path_utilities.c
> @@ -32,7 +32,7 @@ static efi_uintn_t EFIAPI get_device_path_size(
>   	efi_uintn_t sz =3D 0;
>  =20
>   	EFI_ENTRY("%pD", device_path);
> -	/* size includes the END node: */
> +	/* size includes the EFI_DP_END node: */
>   	if (device_path)
>   		sz =3D efi_dp_size(device_path) + sizeof(struct efi_device_path);
>   	return EFI_EXIT(sz);
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 5a0a97fe6d0..117c6811254 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -199,7 +199,7 @@ efi_status_t efi_load_option_dp_join(struct efi_devi=
ce_path **dp,
>   		efi_free_pool(tmp_dp);
>   		if (!*dp)
>   			return EFI_OUT_OF_RESOURCES;
> -		*dp_size +=3D efi_dp_size(initrd_dp) + sizeof(END);
> +		*dp_size +=3D efi_dp_size(initrd_dp) + sizeof(EFI_DP_END);
>   	}
>  =20
>   	if (fdt_dp) {
> @@ -209,10 +209,10 @@ efi_status_t efi_load_option_dp_join(struct efi_de=
vice_path **dp,
>   		efi_free_pool(tmp_dp);
>   		if (!*dp)
>   			return EFI_OUT_OF_RESOURCES;
> -		*dp_size +=3D efi_dp_size(fdt_dp) + sizeof(END);
> +		*dp_size +=3D efi_dp_size(fdt_dp) + sizeof(EFI_DP_END);
>   	}
>  =20
> -	*dp_size +=3D sizeof(END);
> +	*dp_size +=3D sizeof(EFI_DP_END);
>  =20
>   	return EFI_SUCCESS;
>   }

