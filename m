Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B7FC3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 09:43:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2392D87719;
	Mon, 25 Dec 2023 10:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QA3D0xqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3858F8765B; Mon, 25 Dec 2023 10:43:01 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 444928765B
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 10:42:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703497378; x=1704102178; i=xypron.glpk@gmx.de;
 bh=wqlzssIvl3lMju8Z0pPwQ0Igtl2eerFuxzoGznMBZXs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=QA3D0xqFsNMb8FkQzFKmeqZvv6yUG2WzinVNiupJv2GnzEy7H4f1fteJP6zzT1Mh
 U7jit13GYupXL22k0sIpx2uM4yCQ1+CzwzrjLHjoEv0OG4bkdr4Gf5kVriwM+jIMG
 7As74dNW6On3fHHr6jmHeV5Uk6XQ+4mKJD7u/8dLlwisxy9egOS/v6ux6/pvORqPa
 T8mZNV0Ge76AZ7Bkq5/9ueQ0tzT67cX27soOb4xv3jCL4w4I/d76bdLC7f9d+6Mrb
 3/5FmVCcsuy8vt4LoKHnKenUcqrE+VXey5GqROFrIUDY+sU0I1XNa/EflMkLohPG+
 /et0v6d1DirlgcvK6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.136] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7Ka-1rOsDQ190E-00Be5G; Mon, 25
 Dec 2023 10:42:58 +0100
Message-ID: <76b22009-920f-4962-ba27-ff009b7e1e82@gmx.de>
Date: Mon, 25 Dec 2023 10:42:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] efi_loader: remove unused members from struct
 efi_disk_obj
Content-Language: en-US
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Takahiro Akashi
 <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
References: <20231225044356.626900-1-masahisa.kojima@linaro.org>
 <20231225044356.626900-2-masahisa.kojima@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231225044356.626900-2-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rW3FAYEZmR3EG5/nVP4nTiOU5P29SDunkkn4GUIMJeAo7H5aoSf
 3uTSzcMxEJnB2PsfKbM5JQVcryayxndikPYaNNOBdl2MsIR+QgFEPddAgkJRmb5oZQ3iMio
 rtjnjonUUIndvlCgzdEJpFpCuknlC/cFURwdg13lULM7+P8f44HN2UMGexBoDI3QS2jF8ec
 46fvWgA5PBlFE1WTbkelQ==
UI-OutboundReport: notjunk:1;M01:P0:+BPnfPfBy0M=;ke7uQ3cdMTKKTEey6iWquht9I74
 q5ar125TTJFvxEt2nbnD2C5BjWvBjvVwPDIQxdNFYO8+cCLOYLEWW0Bn78u0lRVumBojMYWGr
 +W5N5HWlhwYtFW23aq7Mup+DGqAjFAVVBsPKYNlUkmG8yWGn2ZqbvSahyxIfdnqOeMvq4mwcn
 0+g91w7i2XhCAPhcpr1a7qo6jTfH9YKqFLJ+rA6BWsRvo0S/MGUaqHLCBnERHqMdXx7jl97wL
 AFLfFhhRabmAWdQj2Tv3F90NQz3rs25f+5nKk0iaF9Jsna0QmgPGJY5aoYpOG2lm78ha0ywPR
 9USNrM/8YrxqdP7oGlLesPpiBxzvez+SvuRrinVQ4G8aGqvkyDGdlMITWBiObX151r1y3degM
 yib+EcUbFxQNZXpAqQpDZrIRiUYJHrt+1j2v2nCw92FbMyns767PyCxTWJnLEDcoMkRNDJAJn
 KE/OxqbTIEKVdaImkxFTszgJQC7hruDy6WEPtKfbbTJ7JthfTOPNViCpW2/3lJB26c0DH6mEP
 QSeFh/A31nUzpw6dvZGcRNivjV1C1U2cThKqZKuaGphIGyE74U85QBUDMyDGDJkLbftCn2w//
 Y2sTx2Tnd4Acnkj602NILNDBnYV3iIbRTV0y2+6bKnpZUvSidyKf0ObduncV9cQFU51wswVAu
 b9oFf4hph6ry6/g2O/8BKY1TNzMHvG3QrU7rJlmXATTZ/neC9hXDZeYwNDViYbqhjtYAd0a4+
 FqpN+RSkII7YmI7i4ECk+90qgNannfQSRTujDdoFUIleiIbrq0Fd9lFkR+TDMdwnEEwklu5/c
 jcKmcWgsXOVtZr7uNzDuIEJeNv6Ki2IjPKR6AIRQZxLbcCHLxBR4Qq6AY1iMN1uSkB2FE7ueg
 rB/DelqrxNRSaPNFe21j7Y/EhObtSH7OMgpzTiIMz8zsaRC/UshB185NIFavGR1P+8h1zerco
 Kj6cobBW8jzPTZoBSduSFQku6U8=
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

On 12/25/23 05:43, Masahisa Kojima wrote:
> part and dev_index in struct efi_disk_obj are not used,
> let's remove it.
>
> This commit also removes the invalid structure comment
> for @dev, it does not exist.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_disk.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index f0d76113b0..a2f8b531a3 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -32,20 +32,15 @@ const efi_guid_t efi_system_partition_guid =3D PARTI=
TION_SYSTEM_GUID;
>    *
>    * @header:	EFI object header
>    * @ops:	EFI disk I/O protocol interface
> - * @dev_index:	device index of block device
>    * @media:	block I/O media information
>    * @dp:		device path to the block device
> - * @part:	partition
>    * @volume:	simple file system protocol of the partition
> - * @dev:	associated DM device
>    */
>   struct efi_disk_obj {
>   	struct efi_object header;
>   	struct efi_block_io ops;
> -	int dev_index;
>   	struct efi_block_io_media media;
>   	struct efi_device_path *dp;
> -	unsigned int part;
>   	struct efi_simple_file_system_protocol *volume;
>   };
>
> @@ -383,7 +378,6 @@ static int efi_fs_exists(struct blk_desc *desc, int =
part)
>    * @parent:		parent handle
>    * @dp_parent:		parent device path
>    * @desc:		internal block device
> - * @dev_index:		device index for block device
>    * @part_info:		partition info
>    * @part:		partition
>    * @disk:		pointer to receive the created handle
> @@ -394,7 +388,6 @@ static efi_status_t efi_disk_add_dev(
>   				efi_handle_t parent,
>   				struct efi_device_path *dp_parent,
>   				struct blk_desc *desc,
> -				int dev_index,
>   				struct disk_partition *part_info,
>   				unsigned int part,
>   				struct efi_disk_obj **disk,
> @@ -456,7 +449,6 @@ static efi_status_t efi_disk_add_dev(
>   		diskobj->dp =3D efi_dp_from_part(desc, part);
>   		diskobj->media.last_block =3D desc->lba - 1;
>   	}
> -	diskobj->part =3D part;
>
>   	/*
>   	 * Install the device path and the block IO protocol.
> @@ -499,7 +491,6 @@ static efi_status_t efi_disk_add_dev(
>   			goto error;
>   	}
>   	diskobj->ops =3D block_io_disk_template;
> -	diskobj->dev_index =3D dev_index;
>
>   	/* Fill in EFI IO Media info (for read/write callbacks) */
>   	diskobj->media.removable_media =3D desc->removable;
> @@ -519,7 +510,7 @@ static efi_status_t efi_disk_add_dev(
>
>   	EFI_PRINT("BlockIO: part %u, present %d, logical %d, removable %d"
>   		  ", last_block %llu\n",
> -		  diskobj->part,
> +		  part,
>   		  diskobj->media.media_present,
>   		  diskobj->media.logical_partition,
>   		  diskobj->media.removable_media,
> @@ -566,7 +557,7 @@ static int efi_disk_create_raw(struct udevice *dev, =
efi_handle_t agent_handle)
>   	diskid =3D desc->devnum;
>
>   	ret =3D efi_disk_add_dev(NULL, NULL, desc,
> -			       diskid, NULL, 0, &disk, agent_handle);
> +			       NULL, 0, &disk, agent_handle);
>   	if (ret !=3D EFI_SUCCESS) {
>   		if (ret =3D=3D EFI_NOT_READY) {
>   			log_notice("Disk %s not ready\n", dev->name);
> @@ -627,7 +618,7 @@ static int efi_disk_create_part(struct udevice *dev,=
 efi_handle_t agent_handle)
>   		return -1;
>   	dp_parent =3D (struct efi_device_path *)handler->protocol_interface;
>
> -	ret =3D efi_disk_add_dev(parent, dp_parent, desc, diskid,
> +	ret =3D efi_disk_add_dev(parent, dp_parent, desc,
>   			       info, part, &disk, agent_handle);
>   	if (ret !=3D EFI_SUCCESS) {
>   		log_err("Adding partition for %s failed\n", dev->name);

