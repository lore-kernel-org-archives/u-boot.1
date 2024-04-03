Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA09CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 604D9881AF;
	Wed,  3 Apr 2024 14:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gujpOsm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D4C88212; Wed,  3 Apr 2024 14:23:54 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79FAD87842
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712146997; x=1712751797; i=xypron.glpk@gmx.de;
 bh=7oeoa57xtQBGWqwDTaBFdQTmTxG3fMKBdFZsFA01VqA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=gujpOsm0a4n2PzIKy5PnZuOhx8lmN2bnkgdX0morAC8wq9lCCMHdvnfLHvEpdcni
 voxVxBNgaheG2yDLdDgzoNEQguVaT8BEoUEO11OtsgNo+ibWlr8OFaRdm66/MsN/G
 rrrqU+khhdsZwUiSyh1HQUBu8VQAvRoFjj3fVgD8dZv/7w9BSOEPxNlD0EGxY06W4
 7Byo5l07yhTs/wQiAFr5lAIw75R4AaoYVnaDnjldvwM7PDH3Kr8eCn/EZ190ut2N8
 4NUdrK5oXEx0VWuSTkDODY9LXGBROLBXiYJpqNC5K2FhTd2HmnOnV+LY+YVwJIVw8
 QC3K4P6aWydYARPHcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5eR-1s89cP3fiH-00J4zY; Wed, 03
 Apr 2024 14:23:16 +0200
Message-ID: <3ddc6c93-ad4b-41b2-a7e5-3a28b511dd1b@gmx.de>
Date: Wed, 3 Apr 2024 14:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] disk: support MTD partitions
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: kernel@salutedevices.com, u-boot@lists.denx.de,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 frieder.schrempf@kontron.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 bmeng@tinylab.org, tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com, michal.simek@amd.com,
 mikhail.kshevetskiy@iopsys.eu, patrice.chotard@foss.st.com
References: <20240307130726.1582487-1-avromanov@salutedevices.com>
 <20240307130726.1582487-2-avromanov@salutedevices.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240307130726.1582487-2-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1oseuu2F9xYhoKdcH/DP1d9LAdEKoiQ6xdF6JKgGrf9VFcZTH1C
 ly9qnv2+W+fTlcu80EN7J9GMc5PYuY3URksadxNhtdSDbD9+5tu7LEuaWE0EARXBCcM+Esu
 wQr88wYWe3IFgMZnZftbRldHxFWG21v60k43Gn/EoGo+tTGztlpvKB6YopOKmz2MKVUVTBR
 h3jzu4VeqSO8JXZi0I+5A==
UI-OutboundReport: notjunk:1;M01:P0:eZaAfO6p9YA=;7+toAio8ZNsbN2dDjOUj1uByLxq
 tKDfWGc7V3AKlBAh7KtOdZyMhQN4PgYbuqj2oS+nq+wA7vahJ2Qs6HDgNIVngHWa9l3iZFuc5
 qKFEvXmkKdwwVXAOekVh+7GOTZlupOpnt/1MeSK7tju77vfW1m6YbnRHMifhkroq8q6rSaZJt
 Re0JhXaorI7vAzGvPENMyd7O4L4d2N8zJK1izrBkVqFaWr4WbCrsac9HE6VvWdiKX6bcW6qjn
 GwNz7ebC+611t3ON2L9ylUP9RyEy128TyQ3AulUcBCFaEm/qyNdilh9F5761hDMgi+vy4UaKg
 19V0qWFxnOiToC0sHUNSgOGTKbBjjq9b4oYC3n9mrW/vsxo3OZcYOsRF268oq1Wl0Himekir9
 AWs4YF/hqT37cyZ/mQsWtpFi0aIcOEsiJPhjFRKXSOTpWqyO7d5W/uGGvcCTwMtQ8P2mSUT+H
 g9gOZZre+upMUl3Y4DcF5jgAsnQ9ugFD844YADfDkoQ7pCcQxyBn7tUrwndoY0L60htWrq7HY
 Nm8i/Cq6WD6Doaq8ztphFT8fp/s1iK1eenDDckZvEY43hZCTzqPpW1gwBu1uUuQXKZIF7kZTs
 dhlV3ziCxG0H1JwFdWDQUdUKbGWO3Q/pizQ1VZngbw1hTdSzPKB5hahxjQx6r4Gg6PgmveabF
 qg7kFLI7G5NJbATFTCilYMlGB9vWkenOa7aSsjDU697TzSLLBQE8UhVQbTrbQEyrj3k/FUg7C
 PStUr+y4T7jgQKPraX+wDysq/v/JXrtceJflsnvsjkeRMcV1iOSLZGL6ronw+Q0/mEYfOC+Dq
 bazVbGbcD8yHnuo0HXinjFlS12KiYzIs1SC8F0Mw4+edk=
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

On 07.03.24 14:07, Alexey Romanov wrote:
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

The function should simply call uclass_get_name() instead of duplicating i=
t:

[PATCH 1/1] disk: simplify print_part_header()
https://lore.kernel.org/u-boot/20240403114047.84030-1-heinrich.schuchardt@=
canonical.com/T/#u

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
> index 4886392a1c..67244869f2 100644
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
> +static int part_get_info_mtd(struct blk_desc *dev_desc, int part_idx,
> +			     struct disk_partition *info)
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
> +static void part_print_mtd(struct blk_desc *dev_desc)
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

Please, add a blank line here.

Best regards

Heinrich

>   /*
>    * Type string for U-Boot bootable partitions
>    */

