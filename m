Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E4BC4167B
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 13:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FCEC87140;
	Wed,  8 Nov 2023 14:39:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Kd91PuyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A24887140; Wed,  8 Nov 2023 14:39:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27048871B7
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 14:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699450768; x=1700055568; i=xypron.glpk@gmx.de;
 bh=O7G2An8+GO+JTntDtYVWfzzwk6TC/0EIHBnkQThyNNw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Kd91PuySOyFFH4e2m7N1ByKw+bQwViSmAzZ+mo8c7R8APrKrC0IEjwMLks3l8HtS
 atbV8iLvNK2KWdq3HXYVQ66Ok+fuIh/CmUYpksa0QZwzYtsjX7ErJrNcRGpQY3EnH
 3rXH37Hs23ToJjP9gOlYQM8vFZfGr9bVGn1v9FWKuQg9GO3sAHd9XWWZegE7zPbsy
 e9i9Nc4yyuw9+usRKpN0qc0vQQDc/Ar9g8moxHSRAtrOxtNeHfU3jbGK70K9ehvz7
 7lZR7rv1soxcd0lGzltEAuj7ju4vl9ijsCHiZ39OSgLVauWbPrYfPa32BNu884Wtt
 Fo9ypm6FY06vwpIu9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.20.5.50] ([4.28.11.157]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8qj-1rf1902mST-00f7Sh; Wed, 08
 Nov 2023 14:39:28 +0100
Message-ID: <4ab6d6c2-f3f3-46f8-a7f2-cc9a56ba77d1@gmx.de>
Date: Wed, 8 Nov 2023 05:39:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] fs: fat: calculate FAT type based on cluster count
Content-Language: en-US, de-DE
To: christian.taedcke-oss@weidmueller.com
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20231108121239.26737-1-christian.taedcke-oss@weidmueller.com>
 <20231108121239.26737-3-christian.taedcke-oss@weidmueller.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231108121239.26737-3-christian.taedcke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cj3kyzjeJNPOFwVB3Sz2BFA1f2x7ixPwor089Y/lq8JNBCiwI25
 5YIVX+Ge3AcehY/pimSzF4sLVZ7JVRJ7kJimYmLac+5iqBGb3++VQfeZcxKyjvlwOpOHE9S
 r9eXkZjss9bb3y7GSHvL8eYOTXQ7iBeFSNAlZsJTwaUtmhE1jvFeB0eUvCt1NlSA11Btda7
 q1yz9BCDECrcqdfUPq5bQ==
UI-OutboundReport: notjunk:1;M01:P0:yBAf/duspc8=;d0ITsQo8xSXgoKVGNMqLsKQVZdc
 YzAaUPAuotuz1Yw6aDPON/Z7sWeYcMrMzsK4R841JA4dKuNsXrylFn0jbvlhX1Dg5UD0K/pKd
 0TX0hlP9ga6MhlpayrG9xBmJVOt8Euj2oOZsnSQDEY9bn6aKwGAU3fMua9+aJidAisMXRzCDA
 cjoDjZA1YL6Uzp5nw8F15SgJ5QIxVvrvRF/ovInRpUACFZiJzQfTBYaoVn+9rio8N9wL9u2fS
 67DdrcJhU4i6LVSoJxEnYyacTA7XfVD9lARMIKjytB3JcZrkr1gHs2vRfVrNkBjVx67/koQhd
 PsBxwFZIaBLAqyJSBlDPnWWMwgye9O/cYNwcN7ZrbIubfyYGJZGBcicquY8QDB8nR0UBWJGrs
 jm+uU6KM1RDDfxgdPPFf33ghb5Rcf1+7lFxuE8foyfzRFZVSAkCRNsMqcglQRsNkrLkZnqtA7
 ChjTFlkCBevriMjQtttNQfHZ+yy7n2AffMQPjotyNZ+BdKJsPulSa5pGDCgFswFY2rgMGSEDX
 UvmG7xbUkPmGvIjjJkyDuyj8XUnuYEAnmyF38DKKYh5JNaCvjAsfYip+nd/pwrFKaL3peS8gg
 zElbUnvFqWbiJGwNsHEd5gWhJZ+F05WVv5sbNG2HqKjkJBRycyNrcoCUGwGR+WWAsKqiI765V
 2cOryUuXEeA3CsACNnJRTpadDi4k8jfChpfSqZhzMXHF5Gqd34VHah2PaG0rYKiRKIGf8y+KE
 tmccYTs0tXy5f2yeqcbMOKzv4zTeFGdA0IzCRMBFOkR8Ss4n5zr8ry9aepK3vTA4dAC8IRKxi
 UVMlTXALeUCWuRKOhswH3A7slfGqBnXO2x/EPZeKnemSaAnXUCm803BYmGtS0HDdCm5yfvgya
 oQp2NAbhvDsgzRzmuKTYzruHnmNK1uzSmA5cLt+xK1uS0Bjypnau1bmVgqOBtCDzROURfB4AO
 Lq+suA==
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

On 11/8/23 04:12, christian.taedcke-oss@weidmueller.com wrote:
> From: Christian Taedcke <christian.taedcke@weidmueller.com>
>
> This fixes an issue where the FAT type (FAT12, FAT16) is not
> correctly detected, e.g. when the BPB field BS_FilSysType contains the
> valid value "FAT     ".
>
> According to the FAT spec the field BS_FilSysType has only
> informational character and does not determine the FAT type.
>
> The logic of this code is based on the linux kernel implementation
> from the file fs/fat/inode.c function fat_fill_super().
>
> For details about FAT see http://elm-chan.org/docs/fat_e.html
>
> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
> ---
>
>   fs/fat/fat.c             | 58 +++++++++++++++++++++++-----------------
>   include/fat.h            |  6 -----
>   test/image/spl_load_fs.c |  2 +-
>   3 files changed, 35 insertions(+), 31 deletions(-)
>
> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> index 8a0f4e4e6c..9179257ff2 100644
> --- a/fs/fat/fat.c
> +++ b/fs/fat/fat.c
> @@ -27,6 +27,9 @@
>
>   #define FATU8ARRAY2CPU16(x) (((x)[1] << 8) + (x)[0])
>
> +/* maximum number of clusters for FAT12 */
> +#define MAX_FAT12	0xFF4
> +
>   /*
>    * Convert a string to lowercase.  Converts at most 'len' characters,
>    * 'len' may be larger than the length of 'str' if 'str' is NULL
> @@ -485,6 +488,32 @@ static __u8 mkcksum(struct nameext *nameext)
>   	return ret;
>   }
>
> +/*
> + * Determine the FAT type
> + *
> + * Based on fat_fill_super() from the Linux kernel's fs/fat/inode.c
> + */
> +static int
> +determine_fat_bits(const boot_sector *bs)
> +{
> +	if (!bs->fat_length && bs->fat32_length) {
> +		return 32;
> +	} else {
> +		u16 fat_start =3D bs->reserved;
> +		u32 dir_start =3D fat_start + bs->fats * bs->fat_length;
> +		u32 rootdir_sectors =3D FATU8ARRAY2CPU16(bs->dir_entries) *
> +				      sizeof(dir_entry) /
> +				      FATU8ARRAY2CPU16(bs->sector_size);
> +		u32 data_start =3D dir_start + rootdir_sectors;
> +		u16 sectors =3D FATU8ARRAY2CPU16(bs->sectors);
> +		u32 total_sectors =3D sectors ? sectors : bs->total_sect;
> +		u32 total_clusters =3D (total_sectors - data_start) /
> +				     bs->cluster_size;
> +
> +		return (total_clusters > MAX_FAT12) ? 16 : 12;
> +	}
> +}
> +
>   /*
>    * Read boot sector and volume info from a FAT filesystem
>    */
> @@ -493,7 +522,6 @@ read_bootsectandvi(boot_sector *bs, volume_info *vol=
info, int *fatsize)
>   {
>   	__u8 *block;
>   	volume_info *vistart;
> -	int ret =3D 0;
>
>   	if (cur_dev =3D=3D NULL) {
>   		debug("Error: no device selected\n");
> @@ -508,7 +536,8 @@ read_bootsectandvi(boot_sector *bs, volume_info *vol=
info, int *fatsize)
>
>   	if (disk_read(0, 1, block) < 0) {
>   		debug("Error: reading block\n");
> -		goto fail;
> +		free(block);
> +		return -1;

Thanks for correcting the FAT type determination.

The change above does not look wrong. But as it is an unrelated change,
please, put it into a separate patch.

>   	}
>
>   	memcpy(bs, block, sizeof(boot_sector));
> @@ -527,33 +556,15 @@ read_bootsectandvi(boot_sector *bs, volume_info *v=
olinfo, int *fatsize)
>   		bs->info_sector =3D FAT2CPU16(bs->info_sector);
>   		bs->backup_boot =3D FAT2CPU16(bs->backup_boot);
>   		vistart =3D (volume_info *)(block + sizeof(boot_sector));
> -		*fatsize =3D 32;
>   	} else {
>   		vistart =3D (volume_info *)&(bs->fat32_length);
> -		*fatsize =3D 0;
>   	}
>   	memcpy(volinfo, vistart, sizeof(volume_info));
>
> -	if (*fatsize =3D=3D 32) {
> -		if (strncmp(FAT32_SIGN, vistart->fs_type, SIGNLEN) =3D=3D 0)
> -			goto exit;
> -	} else {
> -		if (strncmp(FAT12_SIGN, vistart->fs_type, SIGNLEN) =3D=3D 0) {
> -			*fatsize =3D 12;
> -			goto exit;
> -		}
> -		if (strncmp(FAT16_SIGN, vistart->fs_type, SIGNLEN) =3D=3D 0) {
> -			*fatsize =3D 16;
> -			goto exit;
> -		}
> -	}
> +	*fatsize =3D determine_fat_bits(bs);
>
> -	debug("Error: broken fs_type sign\n");
> -fail:
> -	ret =3D -1;
> -exit:
>   	free(block);
> -	return ret;
> +	return 0;
>   }
>
>   static int get_fs_info(fsdata *mydata)
> @@ -1158,9 +1169,8 @@ int file_fat_detectfs(void)
>
>   	memcpy(vol_label, volinfo.volume_label, 11);
>   	vol_label[11] =3D '\0';
> -	volinfo.fs_type[5] =3D '\0';
>
> -	printf("Filesystem: %s \"%s\"\n", volinfo.fs_type, vol_label);
> +	printf("Filesystem: FAT%d \"%s\"\n", fatsize, vol_label);
>
>   	return 0;
>   }
> diff --git a/include/fat.h b/include/fat.h
> index a9756fb4cd..3dce99a23c 100644
> --- a/include/fat.h
> +++ b/include/fat.h
> @@ -34,12 +34,6 @@ struct disk_partition;
>   /* Maximum number of entry for long file name according to spec */
>   #define MAX_LFN_SLOT	20
>
> -/* Filesystem identifiers */
> -#define FAT12_SIGN	"FAT12   "
> -#define FAT16_SIGN	"FAT16   "
> -#define FAT32_SIGN	"FAT32   "
> -#define SIGNLEN		8
> -
>   /* File attributes */
>   #define ATTR_RO	1
>   #define ATTR_HIDDEN	2
> diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
> index 297ab08a82..90e640b5de 100644
> --- a/test/image/spl_load_fs.c
> +++ b/test/image/spl_load_fs.c
> @@ -220,7 +220,7 @@ static size_t create_fat(void *dst, size_t size, con=
st char *filename,
>   	bs->root_cluster =3D cpu_to_le32(root_sector);
>
>   	vi->ext_boot_sign =3D 0x29;
> -	memcpy(vi->fs_type, FAT32_SIGN, sizeof(vi->fs_type));
> +	memcpy(vi->fs_type, "FAT32   ", sizeof(vi->fs_type));

This change is not described in the commit message. Putting it into a
separate patch would be preferable.

Best regards

Heinrich

>
>   	memcpy(dst + 0x1fe, "\x55\xAA", 2);
>
