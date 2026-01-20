Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86401D2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA4A83A8D;
	Tue, 20 Jan 2026 15:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kDVYPyR8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 996F283A9F; Tue, 20 Jan 2026 15:53:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F55083A6A
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1768920784; x=1769525584; i=xypron.glpk@gmx.de;
 bh=i7vtATgr8CKxIcDpSmw4cT6Q5unmb0TBQt058F5YYeU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kDVYPyR8PFlJWkDDyy+s84LM6ywvvt2f6Z0tLjPlt627wKFTQr6KFaBTD1zp3MNM
 9JkaVU8NPSmf8QAsoMLJdTJPgFl17LA1Q/vMJwc1QQaXN9PXwBxdCqWzr2DaqkU0n
 KmIAE7Zy4vQ15q6czjNQqVe2+pT9FRVCso57j9LvC7i2MAkJ+3lXjipONbItYHi+a
 YOapbE0gierCkh/VbA61kTdRXE0GSv9gPgaOgon/YUEweg6KLX1UCT/bFG0cYfpfw
 T6Wzd15tu6t5fPG2yHZMovtCCPuN7ggSWIUkcD42jnINL0v1VTyy2UDtJIiV+xG4n
 kAzTqO4PJIuXlnVerg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.127] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDkm-1w1vmC2CiG-00vYAI; Tue, 20
 Jan 2026 15:53:04 +0100
Message-ID: <a45fa439-535d-4bdf-8ac7-94b3150d117e@gmx.de>
Date: Tue, 20 Jan 2026 15:53:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] efi_loader: disk: Extend EFI_PARTITION_INFO_PROTOCOL
 to support MBR
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: eballetb@redhat.com, alexl@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Javier Tia <javier.tia@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de
References: <20260120133630.1695055-1-javierm@redhat.com>
 <20260120133630.1695055-5-javierm@redhat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260120133630.1695055-5-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SnCJh4+ba4M9CJF07+TsrfkQY3+54tPVnI06DtKVjvno7L4MMj9
 KvapGIjzEqiJ8QdN65qaGQgYVMtPLFoeXxtrxEa0akjR2eQz3FP6U7WvQfdjl7ixxWD5fsy
 k0UJi3AkhNVVfg1RqW+tzWg12m5BR6W/ZIzHauZmrP7xSpv68Elyb9bOaZ/ruc5RBXcT2Kp
 lVsHBYBzgMSQgK+q1uxnw==
UI-OutboundReport: notjunk:1;M01:P0:YO6wQB9TNuk=;b549WfjaPYHUOu7lJQN/gx2thFj
 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
 cSnyouYS61EMX8jClqbc
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

On 1/20/26 14:36, Javier Martinez Canillas wrote:
> The EFI_PARTITION_INFO_PROTOCOL provides detailed information about
> partitions. The UEFI specification mentions that both GPT and MBR
> partition schemes are supported, but the U-Boot implementation only
> supports the former.
>=20
> This can cause compatibility issues for platforms whose boot ROM only
> supports MBR. This change adds support for MBR partition tables to
> the protocol, making U-Boot compatible with systems that require a
> legacy MBR table.
>=20
> To implement this, the existing part_get_info_extended() function,
> which already traverses DOS partitions, is refactored to optionally
> retrieve the raw MBR partition record. This provides the necessary
> data for the EFI subsystem.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
>   disk/part_dos.c           | 63 ++++++++++++++++++++++++---------------
>   include/part.h            | 14 +++++++++
>   lib/efi_loader/efi_disk.c |  9 ++++--
>   3 files changed, 59 insertions(+), 27 deletions(-)
>=20
> diff --git a/disk/part_dos.c b/disk/part_dos.c
> index 60c3d6773696..5b508483bae7 100644
> --- a/disk/part_dos.c
> +++ b/disk/part_dos.c
> @@ -201,7 +201,9 @@ static void print_partition_extended(struct blk_desc=
 *desc,

Please add a Sphinx style function description describing the usage of=20
the parameters.

>   static int part_get_info_extended(struct blk_desc *desc,
>   				  lbaint_t ext_part_sector, lbaint_t relative,
>   				  int part_num, int which_part,
> -				  struct disk_partition *info, uint disksig)
> +				  struct disk_partition *info,
> +				  dos_partition_t *mbr,
> +				  uint disksig)
>   {
>   	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, desc->blksz);
>   	struct disk_partition wdinfo =3D { 0 };
> @@ -232,9 +234,11 @@ static int part_get_info_extended(struct blk_desc *=
desc,
>   	if (CONFIG_IS_ENABLED(PARTITION_UUIDS) && !ext_part_sector)
>   		disksig =3D get_unaligned_le32(&buffer[DOS_PART_DISKSIG_OFFSET]);
>  =20
> -	ret =3D part_get_info_whole_disk(desc, &wdinfo);
> -	if (ret)
> -		return ret;
> +	if (info) {
> +		ret =3D part_get_info_whole_disk(desc, &wdinfo);
> +		if (ret)
> +			return ret;
> +	}
>  =20
>   	/* Print all primary/logical partitions */
>   	pt =3D (dos_partition_t *) (buffer + DOS_PART_TBL_OFFSET);
> @@ -247,25 +251,29 @@ static int part_get_info_extended(struct blk_desc =
*desc,
>   		    (pt->sys_ind !=3D 0) &&
>   		    (part_num =3D=3D which_part) &&
>   		    (ext_part_sector =3D=3D 0 || is_extended(pt->sys_ind) =3D=3D 0))=
 {
> -			if (wdinfo.blksz > DOS_PART_DEFAULT_SECTOR)
> -				info->blksz =3D wdinfo.blksz;
> -			else
> -				info->blksz =3D DOS_PART_DEFAULT_SECTOR;
> -			info->start =3D (lbaint_t)(ext_part_sector +
> -					get_unaligned_le32(&pt->start_sect));
> -			info->size  =3D (lbaint_t)get_unaligned_le32(&pt->nr_sects);
> -			part_set_generic_name(desc, part_num,
> -					      (char *)info->name);
> -			/* sprintf(info->type, "%d, pt->sys_ind); */
> -			strcpy((char *)info->type, "U-Boot");
> -			info->bootable =3D get_bootable(pt);
> -			if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
> -				char str[12];
> -
> -				sprintf(str, "%08x-%02x", disksig, part_num);
> -				disk_partition_set_uuid(info, str);
> +			if (info) {
> +				if (wdinfo.blksz > DOS_PART_DEFAULT_SECTOR)
> +					info->blksz =3D wdinfo.blksz;
> +				else
> +					info->blksz =3D DOS_PART_DEFAULT_SECTOR;
> +				info->start =3D (lbaint_t)(ext_part_sector +
> +							 get_unaligned_le32(&pt->start_sect));
> +				info->size  =3D (lbaint_t)get_unaligned_le32(&pt->nr_sects);
> +				part_set_generic_name(desc, part_num,
> +						      (char *)info->name);
> +				/* sprintf(info->type, "%d, pt->sys_ind); */
> +				strcpy((char *)info->type, "U-Boot");
> +				info->bootable =3D get_bootable(pt);
> +				if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
> +					char str[12];
> +
> +					sprintf(str, "%08x-%02x", disksig, part_num);
> +					disk_partition_set_uuid(info, str);
> +				}
> +				info->sys_ind =3D pt->sys_ind;
>   			}
> -			info->sys_ind =3D pt->sys_ind;
> +			if (mbr)
> +				memcpy(mbr, pt, sizeof(*mbr));
>   			return 0;
>   		}
>  =20
> @@ -285,7 +293,8 @@ static int part_get_info_extended(struct blk_desc *d=
esc,
>  =20
>   			return part_get_info_extended(desc, lba_start,
>   				 ext_part_sector =3D=3D 0 ? lba_start : relative,
> -				 part_num, which_part, info, disksig);
> +						      part_num, which_part, info,
> +						      mbr, disksig);
>   		}
>   	}
>  =20
> @@ -317,7 +326,13 @@ static void __maybe_unused part_print_dos(struct bl=
k_desc *desc)
>   static int __maybe_unused part_get_info_dos(struct blk_desc *desc, int=
 part,
>   					    struct disk_partition *info)
>   {
> -	return part_get_info_extended(desc, 0, 0, 1, part, info, 0);
> +	return part_get_info_extended(desc, 0, 0, 1, part, info, NULL, 0);
> +}
> +
> +int __maybe_unused part_get_mbr(struct blk_desc *desc, int part,
> +				dos_partition_t *mbr)
> +{
> +	return part_get_info_extended(desc, 0, 0, 1, part, NULL, mbr, 0);
>   }
>  =20
>   int is_valid_dos_buf(void *buf)
> diff --git a/include/part.h b/include/part.h
> index daebbbc2e68f..84dbdbbd1494 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -704,6 +704,20 @@ int write_mbr_partitions(struct blk_desc *dev,
>   int layout_mbr_partitions(struct disk_partition *p, int count,
>   			  lbaint_t total_sectors);
>  =20
> +/**
> + * part_get_mbr() - Get the MBR partition record of a partition
> + *
> + * This function reads the MBR partition record for a given block
> + * device and partition number.
> + *
> + * @desc:	block device descriptor
> + * @part:	partition number for which to return the partition record
> + * @mbr:	MBR partition record
> + *
> + * Return:	0 on success, otherwise error
> + */
> +int part_get_mbr(struct blk_desc *desc, int part, dos_partition_t *mbr)=
;
> +
>   #endif
>  =20

Please, put the partition library changes into one patch and the EFI=20
changes into another.

Best regards

Heinrich

>   #if CONFIG_IS_ENABLED(PARTITIONS)
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 130c4db9606f..f8a57539ec61 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -475,9 +475,12 @@ static efi_status_t efi_disk_add_dev(
>   #if CONFIG_IS_ENABLED(DOS_PARTITION)
>   		case PART_TYPE_DOS:
>   			info->type =3D PARTITION_TYPE_MBR;
> -
> -			/* TODO: implement support for MBR partition types */
> -			log_debug("EFI_PARTITION_INFO_PROTOCOL doesn't support MBR\n");
> +			ret =3D part_get_mbr(desc, part, &info->info.mbr);
> +			if (ret) {
> +				log_debug("get MBR for part %d failed %ld\n",
> +					  part, ret);
> +				goto error;
> +			}
>   			break;
>   #endif
>   		default:

