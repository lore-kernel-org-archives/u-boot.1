Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CDAC369A7
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 10:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF0A682E86;
	Tue,  8 Apr 2025 12:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="V4t0u/cS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3973982F4D; Tue,  8 Apr 2025 12:57:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B67D782B63
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 12:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744109871; x=1744714671; i=xypron.glpk@gmx.de;
 bh=67rQphH1jJhYpGhwRcGfJlpZ8GYWqa8hqWq34APJwjs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=V4t0u/cSsr4BlIjtbVXv19X1OTUbOcGrTGdt9pOqmbuQf0JqGrCvi+57+77oolLm
 kTad6YalVtfBAViAQkIU+XXzkKQtw4LDOTqdRCPBw6NTGuQCRwmmDTGJ2z53DerWG
 FszRXVqo5fG0yqzaSdGaLT9xYib/XO7vDwOUm0xJGIGaHPf7BwbebWkbiB7mN+1V7
 FXv9HX61rc6OXNUpJD8TC5Scq7Y8zWDuKlHk/99y5mlt+Qb050ikaT1m/85SrRgCI
 g4zmSb4x7qU3wa1ALb0BFvc54DWz1UN/EYT/MgkgNo2+anZL6RfwBJE+mTS7tfr8s
 TZUr3sA+Ejfl44yR+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1po0-1u4JZX1m9Y-002Obe; Tue, 08
 Apr 2025 12:57:51 +0200
Message-ID: <0e1b03c0-fb81-478e-a800-0653801a2f5d@gmx.de>
Date: Tue, 8 Apr 2025 12:57:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] part: efi: add GPT PTE cache used with
 part_get_info_cached() API
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250408-topic-gpt-cache-v2-0-de76e47debb7@linaro.org>
 <20250408-topic-gpt-cache-v2-2-de76e47debb7@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250408-topic-gpt-cache-v2-2-de76e47debb7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XW+XHv1IBisJTowT0xYwr320fgAvGDi+PTNRywz0lXzMoWCZzTa
 PzupFHeTbrA6ueSD6WBw3i4YQXZ7g1HXRWotz91FM1r2q2VlLa1yc7Le9WMDaDIZjGaFv9Z
 7GKmLiaL1+qE64gS6LwVtDKhMkN5Prw3ajTGyo5jqpg/TonYnI+MNkLrTVh7ZeMk8af54l0
 xRB9Pv0vB2CTX6s4cEGGQ==
UI-OutboundReport: notjunk:1;M01:P0:N8epYtyfQrI=;J/9HvS79eERNejxtf0q4r9Daxyj
 B4XjLs+MJIx1tzlMlXI5T/gkdJs/2+++AdxR9huKsMODe+BScSQKgwVgFpV7bU+EWxupa9qQG
 Dkv0UF4cszI0DOXu9D/ZWTl0oubHXOI7Ngm7uQnCrxZSVd6sHLZPbnXkbEXmyVn+3umVTbB78
 NcXKL5HwfQE8QXi+V6ZDaSpcME+q2t21FjRlPWhbKQMH9bcStBo0tLqOeRLBUe5r2LsSXDHj/
 n+jJpU+nJRXcghpGW5snVeUT5ZGcIvlYNdweo7jXd1EW1pIoFOkX1CahiW2hU6o5VFHCaDd6d
 F36X/YEXWuojkOmnpnu6zji0xG819mOYXaf2UISc4W6vRnquv6lDP9lgyL5e7HBK+4N12GQxH
 KokA+MlmxjRzb6mf3ko+22IRPGheGz7UwR5GPWOrRwH0eTyO0pDaWiTWNw45mLZenus/TanS+
 xB1J8nkcE1xWFDsAL+VktigWBLGeWmLpIGb5lAA7iX83a9dC4nBzOSe5fCX2VyNBA9NsUoDit
 Di9Dio4ua9THEPvC2dVzYSnx30g701oIxrLaDk94ihJKRhl4AfimMSqWUrO0hOZJKcIctgIMU
 YhEaopc5nEwFAV2lLdgNQFd7Kk9ILp3JuH07zf/i4Fzv0gr4Wt90sSYUtIFIi/0B0j1V/0Mf5
 MYHMbBGEufK2CLsx/aq08VyTOlXkSWRNckgfyP5RVpqD2Q1bydbQsfFirRcMcQCXLotoR8gf3
 3na6U41aodrFIZhNFnYSdaS3d8tLehJyYRSCjEnWPd9vEb4ElSC0OTTBFX7Q+PDGOdaTEuh+k
 eK178vlMNvyjj8H0RH3v/gftaHWGxxWR2NnuwTlE267RvgfNHPiSgdjJlwAsF1ozqcrCa+Jx0
 +B1A+YpiSj8nria2k6UknBqWLgdXfv83cJB7IhwA7Hf7noBk0hrzqpxFfsDo5lwRIbIidn1Ab
 JTi4EVdXS9UibXBBjQCTYkHrTmbAsux+OhWEvBfvzPb7O7+SmQLIEYSqV2HMtyM1xbm+4VNr5
 y82O23LGTza2z8DKUg59J8KTo68hchsUrlo2SBjv0JNeRZq/Av+lQWlivBA4FOL1huKh71o3v
 /TmCmyLxG5bKET29ITa1eW2M3l9Bu04fxc4FsNaP1zn3KOE8Fn0LT81SgR9jQiXHLDLDk+3un
 krYzTHm+ywcf+XP8nFiEk5PxeZWUB8D4NnkFdOFyWmva+X9iXshb5M/y7+GgL3dNbCbGu6hCg
 KFU1nRqxH19rVdMcBT6UE0cqcZyXEGKBKRhhroiVHfbNAlCb3gLnXrL35PhNmICD+E+VqZy89
 uty6NE+485Xz6n/qZjJuHDv3ezjtdPJiAh9CVXf9khCghwci8w/IEkfSCkadC2AVo+MZRetfQ
 hO3WntrlsnUe5Z3v1YdNzfr3Bv3+pqzE3r2mZO7JaDFeGGqE2endzkGcYbjjhsgrg1uZjlbAg
 WM8r777oLazaF5wlqvglWb9Nxfbw=
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

On 08.04.25 11:13, Neil Armstrong wrote:
> Implement a simple cache for part_efi to be used by the newly
> introduced part_get_info_cached() API.
>
> The cache simply stores a successfully scanned GPT PTE if called
> from the part_get_info_cached() ops, and will return the cached
> data if the blk_desc and lba offset matches, invalidating the
> cache if not.
>
> The cache will only operate if called from the part_get_info_cached()
> API, all the over calls will operate uncached, making sure we
> can still update & re-scan the GPT partitions like before.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   disk/part_efi.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++-=
--------
>   1 file changed, 96 insertions(+), 18 deletions(-)
>
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index 932d058c184ce6946b7142e7c2d9637b28e4661e..949968fcd30fc18766a023e7=
3f43ca1381dcef89 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -55,12 +55,58 @@ static inline u32 efi_crc32(const void *buf, u32 len=
)
>   static int pmbr_part_valid(struct partition *part);
>   static int is_pmbr_valid(legacy_mbr * mbr);
>   static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pg=
pt_head,
> -			gpt_entry **pgpt_pte);
> +			gpt_entry **pgpt_pte, bool cache);
>   static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
>   					 gpt_header *pgpt_head);
>   static int is_pte_valid(gpt_entry * pte);
>   static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
> -			  gpt_entry **pgpt_pte);
> +			  gpt_entry **pgpt_pte, bool cache);
> +

Please, describe the structure and its members.

https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-and-enum=
eration-documentation

> +static struct gpt_pte_cache_data {
> +	struct blk_desc *desc;
> +	u64 lba;
> +	gpt_entry *gpt_pte;
> +	gpt_header gpt_head;
> +} gpt_pte_cache;
> +

Please, describe all functions.

> +static void clear_gpt_pte_cache(void)
> +{
> +	if (gpt_pte_cache.desc) {
> +		if (gpt_pte_cache.gpt_pte)
> +			free(gpt_pte_cache.gpt_pte);
> +
> +		memset(&gpt_pte_cache, 0, sizeof(gpt_pte_cache));
> +	}
> +}
> +
> +static void cache_gpt_pte(struct blk_desc *desc, u64 lba,
> +			  gpt_entry *gpt_pte, gpt_header *pgpt_head)
> +{
> +	if (gpt_pte_cache.gpt_pte)
> +		free(gpt_pte_cache.gpt_pte);
> +
> +	gpt_pte_cache.desc =3D desc;
> +	gpt_pte_cache.lba =3D lba;
> +	gpt_pte_cache.gpt_pte =3D gpt_pte;
> +	if (pgpt_head)
> +		memcpy(&gpt_pte_cache.gpt_head, pgpt_head, sizeof(gpt_header));
> +}
> +
> +static gpt_entry *get_cached_gpt_pte(struct blk_desc *desc, u64 lba,
> +				     gpt_header *pgpt_head)
> +{
> +	if (gpt_pte_cache.desc && gpt_pte_cache.gpt_pte) {
> +		if (gpt_pte_cache.desc =3D=3D desc &&
> +		    gpt_pte_cache.lba =3D=3D lba) {
> +			memcpy(pgpt_head, &gpt_pte_cache.gpt_head, sizeof(gpt_header));
> +			return gpt_pte_cache.gpt_pte;
> +		}
> +
> +		clear_gpt_pte_cache();
> +	}
> +
> +	return NULL;
> +}
>
>   static char *print_efiname(gpt_entry *pte)
>   {
> @@ -205,7 +251,7 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
>   	unsigned char *guid_bin;
>
>   	/* This function validates AND fills in the GPT header and PTE */
> -	if (find_valid_gpt(desc, gpt_head, &gpt_pte) !=3D 1)
> +	if (find_valid_gpt(desc, gpt_head, &gpt_pte, false) !=3D 1)
>   		return -EINVAL;
>
>   	guid_bin =3D gpt_head->disk_guid.b;
> @@ -224,7 +270,7 @@ static void __maybe_unused part_print_efi(struct blk=
_desc *desc)
>   	unsigned char *uuid;
>
>   	/* This function validates AND fills in the GPT header and PTE */
> -	if (find_valid_gpt(desc, gpt_head, &gpt_pte) !=3D 1)
> +	if (find_valid_gpt(desc, gpt_head, &gpt_pte, false) !=3D 1)
>   		return;
>
>   	debug("%s: gpt-entry at %p\n", __func__, gpt_pte);
> @@ -258,8 +304,13 @@ static void __maybe_unused part_print_efi(struct bl=
k_desc *desc)
>   	return;
>   }
>
> -static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int =
part,
> -					    struct disk_partition *info)
> +static void __maybe_unused part_get_info_cache_free_efi(struct blk_desc=
 *desc)
> +{
> +	clear_gpt_pte_cache();
> +}
> +
> +static int _part_get_info_efi(struct blk_desc *desc, int part,
> +			      struct disk_partition *info, bool cache)
>   {
>   	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
>   	gpt_entry *gpt_pte =3D NULL;
> @@ -271,13 +322,14 @@ static int __maybe_unused part_get_info_efi(struct=
 blk_desc *desc, int part,
>   	}
>
>   	/* This function validates AND fills in the GPT header and PTE */
> -	if (find_valid_gpt(desc, gpt_head, &gpt_pte) !=3D 1)
> +	if (find_valid_gpt(desc, gpt_head, &gpt_pte, cache) !=3D 1)
>   		return -EINVAL;
>
>   	if (part > le32_to_cpu(gpt_head->num_partition_entries) ||
>   	    !is_pte_valid(&gpt_pte[part - 1])) {
>   		log_debug("Invalid partition number %d\n", part);
> -		free(gpt_pte);
> +		if (!cache)
> +			free(gpt_pte);
>   		return -EPERM;
>   	}
>
> @@ -307,11 +359,23 @@ static int __maybe_unused part_get_info_efi(struct=
 blk_desc *desc, int part,
>   	log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", info->start=
,
>   		  info->size, info->name);
>
> -	/* Remember to free pte */
> -	free(gpt_pte);
> +	if (!cache)
> +		free(gpt_pte);
>   	return 0;
>   }
>
> +static int __maybe_unused part_get_info_cached_efi(struct blk_desc *des=
c, int part,
> +						   struct disk_partition *info)
> +{
> +	return _part_get_info_efi(desc, part, info, true);
> +}
> +
> +static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int =
part,
> +					    struct disk_partition *info)
> +{
> +	return _part_get_info_efi(desc, part, info, false);
> +}
> +
>   static int part_test_efi(struct blk_desc *desc)
>   {
>   	ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, legacymbr, 1, desc->blksz);
> @@ -689,7 +753,7 @@ int gpt_verify_headers(struct blk_desc *desc, gpt_he=
ader *gpt_head,
>   	 */
>   	if (is_gpt_valid(desc,
>   			 GPT_PRIMARY_PARTITION_TABLE_LBA,
> -			 gpt_head, gpt_pte) !=3D 1) {
> +			 gpt_head, gpt_pte, false) !=3D 1) {
>   		log_debug("Invalid GPT\n");
>   		return -1;
>   	}
> @@ -706,7 +770,7 @@ int gpt_verify_headers(struct blk_desc *desc, gpt_he=
ader *gpt_head,
>   	}
>
>   	if (is_gpt_valid(desc, (desc->lba - 1),
> -			 gpt_head, gpt_pte) !=3D 1) {
> +			 gpt_head, gpt_pte, false) !=3D 1) {
>   		log_debug("Invalid Backup GPT\n");
>   		return -1;
>   	}
> @@ -765,9 +829,9 @@ int gpt_repair_headers(struct blk_desc *desc)
>   	int ret =3D -1;
>
>   	is_gpt1_valid =3D is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA,
> -				     gpt_h1, &gpt_e1);
> +				     gpt_h1, &gpt_e1, false);
>   	is_gpt2_valid =3D is_gpt_valid(desc, desc->lba - 1,
> -				     gpt_h2, &gpt_e2);
> +				     gpt_h2, &gpt_e2, false);
>
>   	if (is_gpt1_valid && is_gpt2_valid) {
>   		ret =3D 0;
> @@ -1023,12 +1087,13 @@ static int is_pmbr_valid(legacy_mbr *mbr)
>    * lba is the logical block address of the GPT header to test
>    * gpt is a GPT header ptr, filled on return.
>    * ptes is a PTEs ptr, filled on return.
> + * cache is a bool, true to use the cached gpt_pte from previous call

"use the cache" or "use cached GPT if available"?

It remains unclear what will happen if cache=3D1 and no entry is found.

Best regards

Heinrich

>    *
>    * Description: returns 1 if valid,  0 on error, 2 if ignored header
>    * If valid, returns pointers to PTEs.
>    */
>   static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pg=
pt_head,
> -			gpt_entry **pgpt_pte)
> +			gpt_entry **pgpt_pte, bool cache)
>   {
>   	/* Confirm valid arguments prior to allocation. */
>   	if (!desc || !pgpt_head) {
> @@ -1036,6 +1101,12 @@ static int is_gpt_valid(struct blk_desc *desc, u6=
4 lba, gpt_header *pgpt_head,
>   		return 0;
>   	}
>
> +	if (cache) {
> +		*pgpt_pte =3D get_cached_gpt_pte(desc, lba, pgpt_head);
> +		if (*pgpt_pte)
> +			return 1;
> +	}
> +
>   	ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, mbr, 1, desc->blksz);
>
>   	/* Read MBR Header from device */
> @@ -1081,6 +1152,9 @@ static int is_gpt_valid(struct blk_desc *desc, u64=
 lba, gpt_header *pgpt_head,
>   		return 0;
>   	}
>
> +	if (cache)
> +		cache_gpt_pte(desc, lba, *pgpt_pte, pgpt_head);
> +
>   	/* We're done, all's well */
>   	return 1;
>   }
> @@ -1090,23 +1164,25 @@ static int is_gpt_valid(struct blk_desc *desc, u=
64 lba, gpt_header *pgpt_head,
>    *
>    * gpt is a GPT header ptr, filled on return.
>    * ptes is a PTEs ptr, filled on return.
> + * cache if a bool, use cached GPT if available
>    *
>    * Description: returns 1 if found a valid gpt,  0 on error.
>    * If valid, returns pointers to PTEs.
>    */
>   static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
> -			  gpt_entry **pgpt_pte)
> +			  gpt_entry **pgpt_pte, bool cache)
>   {
>   	int r;
>
>   	r =3D is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, gpt_head,
> -			 pgpt_pte);
> +			 pgpt_pte, cache);
>
>   	if (r !=3D 1) {
>   		if (r !=3D 2)
>   			log_debug("Invalid GPT\n");
>
> -		if (is_gpt_valid(desc, desc->lba - 1, gpt_head, pgpt_pte)
> +		if (is_gpt_valid(desc, desc->lba - 1, gpt_head, pgpt_pte,
> +				 true)
>   		    !=3D 1) {
>   			log_debug("Invalid Backup GPT\n");
>   			return 0;
> @@ -1210,6 +1286,8 @@ U_BOOT_PART_TYPE(a_efi) =3D {
>   	.name		=3D "EFI",
>   	.part_type	=3D PART_TYPE_EFI,
>   	.max_entries	=3D GPT_ENTRY_NUMBERS,
> +	.get_info_cache_free	=3D part_get_info_ptr(part_get_info_cache_free_ef=
i),
> +	.get_info_cached	=3D part_get_info_ptr(part_get_info_cached_efi),
>   	.get_info	=3D part_get_info_ptr(part_get_info_efi),
>   	.print		=3D part_print_ptr(part_print_efi),
>   	.test		=3D part_test_efi,
>

