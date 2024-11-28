Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2CAD70DE6
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 17:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D065489D1E;
	Thu, 28 Nov 2024 18:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="m1vW4Ijv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B36897F7; Thu, 28 Nov 2024 18:06:07 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E50589D27
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 18:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732813561; x=1733418361; i=xypron.glpk@gmx.de;
 bh=dyRbm6tMhixTs7KXlhsJWz6iQT8hE7M27w5J31Jwa0E=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=m1vW4IjvlPeSeaSwwvzMVCrDPwHOi2Y6dQfZ32lL8285XcnYvY5H6XAbGYikBbiG
 nIgh6tNcQ3ET8UGajpYHk3mAqEBm/8esuqFBXV05KzeLq34dUIrYPTNof+VLVd3oE
 OipXRtoJuaNJBl67VhbY2/ZB1Z8tlKnifRWDs6JzQQiN/FgrEpHD625msSo3ZKlww
 XOjLl2AAdq9+Thu4NtPBL5cCtROoe0fpVskkWjJTpJilBC/g4Gf9ds/NN6zL4TkLY
 I5PiRmlOhf0WmxLPI/Dr8elHP/FowGmrkXxUrgvJvqwm1n/lYKqBs2tXFiBNrqsWM
 bP9GhnhaKhh3CRPitw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4z6q-1ti6fd21nI-00tqKQ; Thu, 28
 Nov 2024 18:06:01 +0100
Message-ID: <dec42d99-6eb4-4272-bf9a-79ecff3bde47@gmx.de>
Date: Thu, 28 Nov 2024 18:06:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/28] efi_loader: Use a separate struct for memory
 nodes
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241128154727.771871-1-sjg@chromium.org>
 <20241128154727.771871-11-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128154727.771871-11-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mC0Toe4kkdB2t1P8h9Gz+KIGAzT1sF/wLl2xZivBGT1+DOGz66y
 youpa0QCqgqkByUPWWfI2C0GzZx+aZcbQID+BWqoGnNo4rSpgLPMijVWvEtVb94GyengQuN
 Ec9KuuEUkXePhvcolnHglYQSxzs6WSzdmbbDQTW/lZE13oo4ZzPhseTOXJeXGEibUlRyrLH
 3i5KSLGHS0f5Vq2bRaSkw==
UI-OutboundReport: notjunk:1;M01:P0:CxrGRIllLBA=;YqbwNJJDWrxqYr5GIr2MJPlRAAx
 +rwk5GQPJf4HHwQrMIWAbnA/j2vnH8agMiaAdlwFClESDwuNbSry2Ow/++r6Jgudv2AVMFYA3
 vNeQ28C5OAjdbVSwfusruJIw0dxghYhOW4AkoOWIhBvi1OtCxjc0TTspEhKCf/fRhfUu5hAI1
 nKGnlcgc72tfgxBfnHPIz5C53Uyrpbuq83S5nomA/s1QQtRMYyDaAtHcczwr8Y6qoWVD1Kp/g
 RNnnuZy8F7jNCSeDWdltOwnDCXy/x3ZOeKmdulWOobIC4qHp0aZiXprU0JqNWtzuwZBzQRDHI
 OqYqcBuWZDwL1AjKm7Ez3RhIoffAtnHvLl4XhhDs6HP4tfNhGusRUrtcrYCem7xEhHqT+FmQt
 ADy5cj7PIjuyocNNz/0u3fdh5qEjVPpuqEWeAfU+mabx30GPuiUTi6LWPGks+TWhGEVjOtoYK
 jc/iIGbUtJpYcecphOcrDRb5G0bZZvL+W18NzTZIB9bnRLl8qiwDnVMqV2Cy2Vj7jnVjIOmnM
 79hW41jfjlWY08c0sxEmVIeVcw18Ds4YneGfMmcy9yzNfWJRz+F07zqe08ZVt6fCVxBPtBIKx
 rcLLNW4HQHuAU4NuJdE2oLoViw23wogY6GHc+HHkA+f/fr8s8voKhZT0QJIkYHi9bwXGfH3As
 /GKEpaiVMzm9w0Hn47yFpyWdHIPOJJ6fWUp9PxKIJWc/VulgveLulNLrpnRVj7crY/q04QDyI
 hFH81md4eOqXC1gcJbskHVSTJPdl3MTUOI57Xs9/1ISXzchZY5cz3xjFS4WKJquzBnAxsh4RH
 wSEmxFhM3aawbCOliXB7Kzq26xIzvSmCNvggEKkDqzwS0BKdTdU1tMvMZWkv5EI+vnOARGbLg
 hnO/1ot/tlKyKQaCQHXtYPboFK1PWw8oooWcgZ80AhGBY+/FLqm//r+np3u9q9ADst82j82b8
 gs/mVj0OrCdFsOoAUyCzYi+OUfFLbSUiVPOrjK6brtFPVNZRHEkrCfZgVzVVtLVBmFYYxwMWt
 vOrL8XXtKhVDjvTfy3FsCBqEqrIaI3YxDzl+EEQn+o4KQJS51Ejj3nALbS/io0rWRngg+cGND
 qOdwy6s3M=
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

On 28.11.24 16:47, Simon Glass wrote:
> At present efi_memory uses struct efi_mem_desc for each node of its
> memory list. This is convenient but is not ideal, since:
>
> - it means that the fields are under a 'desc' sub-structure
> - it includes an unused 'reserved' field
> - it includes virtual_start which is confusing as it is always the same
>    as physical_start
> - we must use u64 to store pointers, since that is how they are returned
>    by calls to efi_get_memory_map()
>
> As a first step to tidying this up, create a new, private struct to hold
> these fields.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

The EFI memory map should be generated from LMB.

We should not waste our time on code which shall be removed and possibly
introduce regressions in the meantime.

Best regards

Heinrich

> ---
>
> Changes in v2:
> - Add new patch to use a separate stuct for memory nodes
>
>   lib/efi_loader/efi_memory.c | 49 +++++++++++++++++++++++++++++++------
>   1 file changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 3cece51f030..9e4158edfaf 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -27,9 +27,39 @@ DECLARE_GLOBAL_DATA_PTR;
>
>   efi_uintn_t efi_memory_map_key;
>
> +/**
> + * struct priv_mem_desc - defines an memory region
> + *
> + * Note that this struct is for use inside U-Boot and is not visible to=
 the
> + * EFI application, other than through calls to efi_get_memory_map(), w=
here this
> + * internal format is converted to the external struct efi_mem_desc for=
mat.
> + *
> + * @type (enum efi_memory_type): EFI memory-type
> + * @reserved: unused
> + * @physical_start: Start address of region in physical memory
> + * @virtual_start: Start address of region in physical memory
> + * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE=
_SIZE
> + *	bytes)
> + * @attribute: Memory attributes (see EFI_MEMORY...)
> + */
> +struct priv_mem_desc {
> +	u32 type;
> +	u32 reserved;
> +	efi_physical_addr_t physical_start;
> +	efi_virtual_addr_t virtual_start;
> +	u64 num_pages;
> +	u64 attribute;
> +};
> +
> +/**
> + * struct efi_mem_list - defines an EFI memory record
> + *
> + * @link: Link to prev/next node in list
> + * @desc: Memory information about this node
> + */
>   struct efi_mem_list {
>   	struct list_head link;
> -	struct efi_mem_desc desc;
> +	struct priv_mem_desc desc;
>   };
>
>   #define EFI_CARVE_NO_OVERLAP		-1
> @@ -116,7 +146,7 @@ static int efi_mem_cmp(void *priv, struct list_head =
*a, struct list_head *b)
>    * @desc:	memory descriptor
>    * Return:	end address + 1
>    */
> -static uint64_t desc_get_end(struct efi_mem_desc *desc)
> +static uint64_t desc_get_end(struct priv_mem_desc *desc)
>   {
>   	return desc->physical_start + (desc->num_pages << EFI_PAGE_SHIFT);
>   }
> @@ -138,8 +168,8 @@ static void efi_mem_sort(void)
>   	while (merge_again) {
>   		merge_again =3D false;
>   		list_for_each_entry(lmem, &efi_mem, link) {
> -			struct efi_mem_desc *prev;
> -			struct efi_mem_desc *cur;
> +			struct priv_mem_desc *prev;
> +			struct priv_mem_desc *cur;
>   			uint64_t pages;
>
>   			if (!prevmem) {
> @@ -194,11 +224,11 @@ static void efi_mem_sort(void)
>    * to re-add the already carved out pages to the mapping.
>    */
>   static s64 efi_mem_carve_out(struct efi_mem_list *map,
> -			     struct efi_mem_desc *carve_desc,
> +			     struct priv_mem_desc *carve_desc,
>   			     bool overlap_conventional)
>   {
>   	struct efi_mem_list *newmap;
> -	struct efi_mem_desc *map_desc =3D &map->desc;
> +	struct priv_mem_desc *map_desc =3D &map->desc;
>   	uint64_t map_start =3D map_desc->physical_start;
>   	uint64_t map_end =3D map_start + (map_desc->num_pages << EFI_PAGE_SHI=
FT);
>   	uint64_t carve_start =3D carve_desc->physical_start;
> @@ -680,7 +710,12 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory=
_map_size,
>   	/* Return the list in ascending order */
>   	memory_map =3D &memory_map[map_entries - 1];
>   	list_for_each_entry(lmem, &efi_mem, link) {
> -		*memory_map =3D lmem->desc;
> +		memory_map->type =3D lmem->desc.type;
> +		memory_map->reserved =3D lmem->desc.reserved;
> +		memory_map->physical_start =3D lmem->desc.physical_start;
> +		memory_map->virtual_start =3D lmem->desc.virtual_start;
> +		memory_map->num_pages =3D lmem->desc.num_pages;
> +		memory_map->attribute =3D lmem->desc.attribute;
>   		memory_map--;
>   	}
>

