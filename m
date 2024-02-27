Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74A0C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 13:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16AC587FB1;
	Tue, 27 Feb 2024 14:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lFV62xKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0EBF87FDC; Tue, 27 Feb 2024 14:29:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4107287EDF
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 14:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1709040537; x=1709645337; i=xypron.glpk@gmx.de;
 bh=wzqowPAp70hwzQLteVlHEQHDznyJHkPsDcJVUE1BfLU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=lFV62xKadQkw98C8KyTy9C6zt1+2WZXp5ZRtFh5uUGdNa2LSLO66O1bndu6TTirj
 mOP9sv6WU6Scj9mcCrDOherwb5Ct2Kqkgk+npQop/bp0kD+ZV0edvDmJ9k+LQrIO1
 yRZaRQ6wS05WGKT0SJ+beuIdNtax3AUOu4wSXPRfBevehdZVTSH6nnKGi+mYREhkK
 AxyH3N1Ibpok78Ca2YWGUYELD+7iAXH08OsqHvJLkvkUteIjTqNzJjqoyMPajGsz5
 pTizrTj798Begqx23rz+6LX5MmfZzspr77yEuNqj8Z9dnKWJzRZCOLc6P26j3lZFI
 ED2Xo579CVKK31R5sQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([95.222.37.56]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1rNYzK1l2J-00IWJI; Tue, 27
 Feb 2024 14:28:57 +0100
Message-ID: <56973f73-4757-4a3f-961a-abaf181f2d7a@gmx.de>
Date: Tue, 27 Feb 2024 14:28:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] disk: support MTD partitions
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: kernel@salutedevices.com, u-boot@lists.denx.de,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 frieder.schrempf@kontron.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 bmeng@tinylab.org, tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com, michal.simek@amd.com,
 mikhail.kshevetskiy@iopsys.eu, patrice.chotard@foss.st.com
References: <20240227100441.1811047-1-avromanov@salutedevices.com>
 <20240227100441.1811047-3-avromanov@salutedevices.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240227100441.1811047-3-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FNDSuFWIBDJVx48Y+B58XSXRupQaRuftqOuAlAOxre3Em0c+a+y
 eI2Dh4Kza0uwmEk3eVrwsO/xISDKv8NWwPRJIJziJlaTPFkbsD1LuvJk0ATAjg7S6xRWmvD
 MjUh+MQpO3BAGSInn8dO4aSlw19N0aq5VuVfsVlfVYsvt1Fs9zr+zWLcHPh2O8Pie9/lPjY
 5QKUSiFm1rflXcCDl01MQ==
UI-OutboundReport: notjunk:1;M01:P0:s5X+w0Sn9rk=;kzdeI7lYctzWb3Ix7uTCgCy2ySO
 jct2BgpwNPygwzmSjySkulR2lupzePlXYlT5q1p6M7GgXYW1z0VwEHKINXWxWB9AU7BS5wm/h
 1VGnEijUu7GP2NNaT5S7qW5QseLuSHaGOmyr1jLh1gMTNoGlEolvBXj/YHA/pVqCqTGYEaMzh
 68/BDlTj+X+9HM0W2acTXhsCN0Psc8F9AURglhXpFF0FLoR7Th1Wg0GjfjQa88HYlMIQdtnbW
 TZvfuGyHIeBlo/xijYaUg6JSN2wSpDNeHnyf+goPvLR2FmUKKZXIXQij3GG2IE6O07jTJXeyT
 6Y0ED03g/93Mw8+cc1KJUw2THTo6z0mg1pmuhqPB86JBkbXKtFnyp2Pj6670S4b7BB6sWnBbu
 vwWb/JoiW6gfBSr7g5YB8XQYqxeX69uWvuED+q5hQsLMHKiqKq0mS2V83QmSIomQ0Lc8OTss4
 3CjDV+O+vfXBri0x1QuAK3cgtCt1x1sFngGxKMet/ConIWIrGRy/4iOC8Erf8XglJWDIIvxL5
 jwlJcu3eOySBopzXqRYMyvZr+8hrSCs4CJR/Tf8f50PGfAJvuX+fr/i/TE2COPjZ/QFBIp5hw
 J4AcLW0dcrE8jZsts466QIT4da6OhwegCnUkQ29wDA8NNAOvYwRD5rAlpk13aWuG8eVjENPnb
 OrEl6ZTFYwbIfHvVjXgghLHBVQNcWMjfCxXpKt3rsDs8lpdpwboOgAksJ5Nbv2JULm81mjAz2
 LeilQP2NdJdB7tNM/mWgE6X7AyNH4iZ3tgcM3YZT14plAB+XzJV1E+k4hwSMbJbFA//hG+Izb
 IykeqRbhmra7v7DRgIWbSs3/bzLlksYkkn/odVWWbp3Yg=
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

On 27.02.24 11:04, Alexey Romanov wrote:
> Add new MTD partition driver, which can be useful with
> mtdblock driver combination.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   disk/part.c           |  5 +++-
>   drivers/mtd/Kconfig   |  1 +
>   drivers/mtd/mtdpart.c | 69 +++++++++++++++++++++++++++++++++++++++++++
>   include/part.h        |  2 ++
>   4 files changed, 76 insertions(+), 1 deletion(-)
>
> diff --git a/disk/part.c b/disk/part.c
> index 36b88205ec..0fc5cc0419 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -304,7 +304,8 @@ static void print_part_header(const char *type, stru=
ct blk_desc *desc)
>   	CONFIG_IS_ENABLED(DOS_PARTITION) || \
>   	CONFIG_IS_ENABLED(ISO_PARTITION) || \
>   	CONFIG_IS_ENABLED(AMIGA_PARTITION) || \
> -	CONFIG_IS_ENABLED(EFI_PARTITION)
> +	CONFIG_IS_ENABLED(EFI_PARTITION) || \
> +	CONFIG_IS_ENABLED(MTD_PARTITIONS)
>   	puts ("\nPartition Map for ");
>   	switch (desc->uclass_id) {
>   	case UCLASS_IDE:
> @@ -343,6 +344,8 @@ static void print_part_header(const char *type, stru=
ct blk_desc *desc)
>   	case UCLASS_BLKMAP:
>   		puts("BLKMAP");
>   		break;
> +	case UCLASS_MTD:
> +		puts("MTD");
>   	default:
>   		printf("UNKNOWN(%d)", desc->uclass_id);
>   		break;
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index 1902351719..40272f7e50 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -2,6 +2,7 @@ menu "MTD Support"
>
>   config MTD_PARTITIONS
>   	bool
> +	select PARTITIONS
>
>   config MTD
>   	bool "Enable MTD layer"
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index 4886392a1c..608908c193 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -21,6 +21,8 @@
>
>   #include <common.h>
>   #include <malloc.h>
> +#include <memalign.h>
> +#include <part.h>
>   #include <linux/bug.h>
>   #include <linux/errno.h>
>   #include <linux/compat.h>
> @@ -1055,3 +1057,70 @@ uint64_t mtd_get_device_size(const struct mtd_inf=
o *mtd)
>   	return mtd->size;
>   }
>   EXPORT_SYMBOL_GPL(mtd_get_device_size);
> +
> +static struct mtd_info *mtd_get_partition_by_index(struct mtd_info *mtd=
, int index)
> +{
> +	struct mtd_info *part;
> +	int i =3D 0;
> +
> +	list_for_each_entry(part, &mtd->partitions, node)
> +		if (i++ =3D=3D index)
> +			return part;
> +
> +	debug("Partition with idx=3D%d not found on MTD device %s\n", index, m=
td->name);
> +	return NULL;
> +}
> +
> +static int __maybe_unused part_get_info_mtd(struct blk_desc *dev_desc, =
int part_idx,
> +					    struct disk_partition *info)

You use the function in U_BOOT_PART_TYPE(mtd). In struct part_driver
there are no conditional fields. Why mark it as __maybe_unused?

> +{
> +	struct mtd_info *master =3D blk_desc_to_mtd(dev_desc);
> +	struct mtd_info *part;
> +
> +	if (!master) {
> +		pr_err("MTD device is NULL\n");
> +		return -EINVAL;
> +	}
> +
> +	part =3D mtd_get_partition_by_index(master, part_idx);
> +	if (!part) {
> +		debug("Failed to find partition with idx=3D%d\n", part_idx);
> +		return -EINVAL;
> +	}
> +
> +	snprintf(info->name, PART_NAME_LEN, part->name);
> +	info->start =3D part->offset / dev_desc->blksz;
> +	info->size =3D part->size / dev_desc->blksz;
> +	info->blksz =3D dev_desc->blksz;
> +
> +	return 0;
> +}
> +
> +static void __maybe_unused part_print_mtd(struct blk_desc *dev_desc)

ditto

Best regards

Heinrich

> +{
> +	struct mtd_info *master =3D blk_desc_to_mtd(dev_desc);
> +	struct mtd_info *part;
> +
> +	list_for_each_entry(part, &master->partitions, node)
> +		printf("- 0x%012llx-0x%012llx : \"%s\"\n",
> +		       part->offset, part->offset + part->size, part->name);
> +}
> +
> +static int part_test_mtd(struct blk_desc *dev_desc)
> +{
> +	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, dev_desc->blksz);
> +
> +	if (blk_dread(dev_desc, 0, 1, (ulong *)buffer) !=3D 1)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +U_BOOT_PART_TYPE(mtd) =3D {
> +	.name		=3D "MTD",
> +	.part_type	=3D PART_TYPE_MTD,
> +	.max_entries	=3D MTD_ENTRY_NUMBERS,
> +	.get_info	=3D part_get_info_ptr(part_get_info_mtd),
> +	.print		=3D part_print_ptr(part_print_mtd),
> +	.test		=3D part_test_mtd,
> +};
> diff --git a/include/part.h b/include/part.h
> index db34bc6bb7..f7f3773a95 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -30,12 +30,14 @@ struct block_drvr {
>   #define PART_TYPE_ISO		0x03
>   #define PART_TYPE_AMIGA		0x04
>   #define PART_TYPE_EFI		0x05
> +#define PART_TYPE_MTD		0x06
>
>   /* maximum number of partition entries supported by search */
>   #define DOS_ENTRY_NUMBERS	8
>   #define ISO_ENTRY_NUMBERS	64
>   #define MAC_ENTRY_NUMBERS	64
>   #define AMIGA_ENTRY_NUMBERS	8
> +#define MTD_ENTRY_NUMBERS	64
>   /*
>    * Type string for U-Boot bootable partitions
>    */

