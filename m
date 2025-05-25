Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4E4C54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 09:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB4482AB9;
	Sun, 25 May 2025 11:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ta48O/gl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D459982AE2; Sun, 25 May 2025 11:24:00 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67E97829E7
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 11:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748165033; x=1748769833; i=xypron.glpk@gmx.de;
 bh=gZ79riSGSDhbpKPDZrgFb1NUxWBOq9S/sAfAiJ35JDk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ta48O/glNULLOo/HyMAEg9q+7ajU87AOpV80UdeNXiYOuFgMWUIrbmEbKb83dGV8
 MteovchHMS5oPMHuhmLb3K9n5tuv7TpKIUs4K0rKfpeLg+WeToHKgXEPA5J3Uru6w
 Dba1f3ked+vbn/snRJjwPgRFfe2cHLrrCrVLqdvs4IN0nVsFfgIaT1s/c58aKaHHk
 qaLjOtGjm97kO1HdpVgZ4iADGpaPN9ZZCBhcSme9vGmINJZWmVM0TPLx76zIVLku/
 BFfYWP4REJSJz8UmG6ussQRsCigyExRSAnoomvvkEAMICTG/wUa3hBQkaeqG5dDZV
 ET1+08G7EPN+63mgXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.142]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSbxD-1uUIfR2mBF-00RCTy; Sun, 25
 May 2025 11:23:52 +0200
Message-ID: <6c3c3f3e-2ceb-448b-ab25-87729d117d8e@gmx.de>
Date: Sun, 25 May 2025 11:23:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] efi: Rename END to EFI_DP_END
To: Simon Glass <sjg@chromium.org>
Cc: Adriano Cordova <adrianox@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>, Moritz Fischer <moritzf@google.com>,
 Pawel Kochanowski <pkochanowski@sii.pl>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250524172827.1243975-1-sjg@chromium.org>
 <20250524172827.1243975-3-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250524172827.1243975-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lP3N80f9tEPcO4R/mxJ8rMqvwtFS/KR17xU/VVb/22vb6zkLUgx
 5cN8sosZKt4G00ubi8cUGQshQcfnhST+6FJRSuRvMoy73bUn9m/0uhKVAV+I46uR56QWtPz
 +YBmBbyQuTJMmRKqRZwMATlWX7tqKGqbt9BGFE+uyFweLX5v7wevK0kmcdT7Sh5ayvL8jE5
 4X7rY0yC0qn1yP22opK9Q==
UI-OutboundReport: notjunk:1;M01:P0:61jk4djOvMY=;0DlvFt6phEe4vF/z10tY6pQfu5A
 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
 41FeqydMf3MoI=
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

On 5/24/25 19:28, Simon Glass wrote:
> This exported symbol has a very generic name. Rename it to indicate that
> it relates to EFI and device-paths.
>=20
> Fix checkpatch warnings related to use of multiple assignments.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Thank you for fixing this.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>=20
> ---
>=20
> Changes in v2:
> - Fix EFI_DP_3 typo
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
> index de1647b943c..6e14d34a6bd 100644
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
> index 01e58031573..109496d9e95 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -813,7 +813,7 @@ static int efi_boot_add_uri(int argc, char *const ar=
gv[], u16 *var_name16,
>   	lo->label =3D label;
>  =20
>   	uridp_len =3D sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
> -	uridp =3D efi_alloc(uridp_len + sizeof(END));
> +	uridp =3D efi_alloc(uridp_len + sizeof(EFI_DP_END));
>   	if (!uridp) {
>   		log_err("Out of memory\n");
>   		return CMD_RET_FAILURE;
> @@ -823,10 +823,10 @@ static int efi_boot_add_uri(int argc, char *const =
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
> index 33b6cfe9b79..03fbe8f1622 100644
> --- a/include/efi_device_path.h
> +++ b/include/efi_device_path.h
> @@ -15,12 +15,12 @@ struct efi_load_option;
>   struct udevice;
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
> @@ -85,11 +85,11 @@ efi_handle_t efi_dp_find_obj(struct efi_device_path =
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
> @@ -101,8 +101,8 @@ const struct efi_device_path *efi_dp_last_node(const=
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
> @@ -115,7 +115,7 @@ efi_uintn_t efi_dp_instance_size(const struct efi_de=
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
> @@ -139,7 +139,7 @@ struct efi_device_path *efi_dp_dup(const struct efi_=
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
> @@ -160,10 +160,11 @@ struct efi_device_path *efi_dp_concat(const struct=
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
> @@ -216,7 +217,7 @@ efi_dp_append_instance(const struct efi_device_path =
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
> @@ -226,7 +227,7 @@ efi_dp_append_instance(const struct efi_device_path =
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
> @@ -408,7 +409,7 @@ struct efi_device_path *search_gpt_dp_node(struct ef=
i_device_path *device_path);
>    *
>    * Set the device path to an IPv4 path as provided by efi_dp_from_ipv4
>    * concatenated with a device path of subtype DEVICE_PATH_SUB_TYPE_MSG=
_URI,
> - * and an END node.
> + * and an EFI_DP_END node.
>    *
>    * @server:	URI of remote server
>    * @dev:	net udevice
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a2ab90030b4..3ef0a9e73f3 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -856,7 +856,8 @@ efi_bootmgr_enumerate_boot_options(struct eficonfig_=
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
> index 818f993f7cc..7316a76f462 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -22,11 +22,11 @@
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
> @@ -214,7 +214,7 @@ efi_uintn_t efi_dp_size(const struct efi_device_path=
 *dp)
>   struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
>   {
>   	struct efi_device_path *ndp;
> -	size_t sz =3D efi_dp_size(dp) + sizeof(END);
> +	size_t sz =3D efi_dp_size(dp) + sizeof(EFI_DP_END);
>  =20
>   	if (!dp)
>   		return NULL;
> @@ -237,7 +237,7 @@ efi_device_path *efi_dp_concat(const struct efi_devi=
ce_path *dp1,
>  =20
>   	if (!dp1 && !dp2) {
>   		/* return an end node */
> -		ret =3D efi_dp_dup(&END);
> +		ret =3D efi_dp_dup(&EFI_DP_END);
>   	} else if (!dp1) {
>   		ret =3D efi_dp_dup(dp2);
>   	} else if (!dp2) {
> @@ -254,9 +254,9 @@ efi_device_path *efi_dp_concat(const struct efi_devi=
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
> @@ -265,14 +265,14 @@ efi_device_path *efi_dp_concat(const struct efi_de=
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
> @@ -284,26 +284,26 @@ struct efi_device_path *efi_dp_append_node(const s=
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
> @@ -341,17 +341,17 @@ struct efi_device_path *efi_dp_append_instance(
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
> @@ -366,17 +366,17 @@ struct efi_device_path *efi_dp_get_next_instance(s=
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
> @@ -763,13 +763,13 @@ struct efi_device_path *efi_dp_from_part(struct bl=
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
> @@ -836,7 +836,7 @@ struct efi_device_path *efi_dp_from_file(const struc=
t efi_device_path *dp,
>   	if (fpsize > U16_MAX)
>   		return NULL;
>  =20
> -	buf =3D efi_alloc(dpsize + fpsize + sizeof(END));
> +	buf =3D efi_alloc(dpsize + fpsize + sizeof(EFI_DP_END));
>   	if (!buf)
>   		return NULL;
>  =20
> @@ -853,7 +853,7 @@ struct efi_device_path *efi_dp_from_file(const struc=
t efi_device_path *dp,
>   		pos +=3D fpsize;
>   	}
>  =20
> -	memcpy(pos, &END, sizeof(END));
> +	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
>  =20
>   	return buf;
>   }
> @@ -862,7 +862,7 @@ struct efi_device_path *efi_dp_from_uart(void)
>   {
>   	void *buf, *pos;
>   	struct efi_device_path_uart *uart;
> -	size_t dpsize =3D dp_size(dm_root()) + sizeof(*uart) + sizeof(END);
> +	size_t dpsize =3D dp_size(dm_root()) + sizeof(*uart) + sizeof(EFI_DP_E=
ND);
>  =20
>   	buf =3D efi_alloc(dpsize);
>   	if (!buf)
> @@ -873,7 +873,7 @@ struct efi_device_path *efi_dp_from_uart(void)
>   	uart->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MSG_UART;
>   	uart->dp.length =3D sizeof(*uart);
>   	pos +=3D sizeof(*uart);
> -	memcpy(pos, &END, sizeof(END));
> +	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
>  =20
>   	return buf;
>   }
> @@ -887,13 +887,13 @@ struct efi_device_path __maybe_unused *efi_dp_from=
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
> @@ -903,7 +903,7 @@ struct efi_device_path __maybe_unused *efi_dp_from_e=
th(struct udevice *dev)
>    *
>    * Set the device path to an ethernet device path as provided by
>    * efi_dp_from_eth() concatenated with a device path of subtype
> - * DEVICE_PATH_SUB_TYPE_MSG_IPV4, and an END node.
> + * DEVICE_PATH_SUB_TYPE_MSG_IPV4, and an EFI_DP_END node.
>    *
>    * @ip:		IPv4 local address
>    * @mask:	network mask
> @@ -934,7 +934,7 @@ static struct efi_device_path *efi_dp_from_ipv4(stru=
ct efi_ipv4_address *ip,
>   	if (srv)
>   		memcpy(&dp.ipv4dp.remote_ip_address, srv, sizeof(*srv));
>   	pos =3D &dp.end;
> -	memcpy(pos, &END, sizeof(END));
> +	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
>  =20
>   	dp1 =3D efi_dp_from_eth(dev);
>   	if (!dp1)
> @@ -979,7 +979,7 @@ struct efi_device_path *efi_dp_from_http(const char =
*server, struct udevice *dev
>   	}
>  =20
>   	uridp_len =3D sizeof(struct efi_device_path) + strlen(tmp) + 1;
> -	uridp =3D efi_alloc(uridp_len + sizeof(END));
> +	uridp =3D efi_alloc(uridp_len + sizeof(EFI_DP_END));
>   	if (!uridp) {
>   		log_err("Out of memory\n");
>   		return NULL;
> @@ -991,7 +991,7 @@ struct efi_device_path *efi_dp_from_http(const char =
*server, struct udevice *dev
>   	memcpy(uridp->uri, tmp, strlen(tmp) + 1);
>  =20
>   	pos =3D (char *)uridp + uridp_len;
> -	memcpy(pos, &END, sizeof(END));
> +	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
>  =20
>   	dp2 =3D efi_dp_concat(dp1, (const struct efi_device_path *)uridp, 0);
>  =20
> @@ -1009,11 +1009,11 @@ struct efi_device_path *efi_dp_from_mem(uint32_t=
 memory_type,
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
> @@ -1022,7 +1022,7 @@ struct efi_device_path *efi_dp_from_mem(uint32_t m=
emory_type,
>   	mdp->end_address =3D start_address + size;
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
> index 2acae7856f9..44b806aadc4 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -200,7 +200,7 @@ efi_status_t efi_load_option_dp_join(struct efi_devi=
ce_path **dp,
>   		efi_free_pool(tmp_dp);
>   		if (!*dp)
>   			return EFI_OUT_OF_RESOURCES;
> -		*dp_size +=3D efi_dp_size(initrd_dp) + sizeof(END);
> +		*dp_size +=3D efi_dp_size(initrd_dp) + sizeof(EFI_DP_END);
>   	}
>  =20
>   	if (fdt_dp) {
> @@ -210,10 +210,10 @@ efi_status_t efi_load_option_dp_join(struct efi_de=
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

