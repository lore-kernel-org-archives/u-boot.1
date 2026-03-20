Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DB8108B912
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 12:15:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 336D083CF5;
	Fri, 20 Mar 2026 13:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BAy+HGiC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66CB583D71; Fri, 20 Mar 2026 13:15:42 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C34838FA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TitbLnhWiSd2FPl7IC3VwR6+On4E7qcIsnO5PMDYEJdY/gCRF+vo0Cq4bdRhHu9iQmhbXQogV09XqIkNteBK1TI5Bn+Mlj5uRKJ8VNGpx5eKh/NsLYBcSco7ZbPZOjW3ioCj/dO123Imx7E5iXO1am78VAJScJ7e7gHJnvk6kkrx6iU94XR+Yttbn2y9w2WXtWwTm4xw2f0xSZUaXk9MZo25XjHdSurlltI8W/mLpHELYGERzzXBJP9fcf8W3/F5xB8NpjoRa62+EMSjjDwPwpzt/3qWhZ9isYaL/Toz257wmzJFMuzuEf5LDJgdcP8crso9gdbdXIaJaPI7fPYAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9NCoafHtI58M8LvzIXFC5c3X9mHSSr8TXGFTRBx9es=;
 b=yLNzHKbfj/gAtKw5NEHBpAoHDySmLbJjcq2WhUlY8DGms6iRaWlZG6I00mmAEyrRYQ98xWX04joOWSh+6AkIm4LM7WG93rdX3f+ZRsKCEfGysGDsA3+d3afycuTyTE1meFEHwF3CK4wrzYHXDBev+er3FFuqmRu2nweMZcNuFrQKvn1aLl33r9I39dxeID964M0ib2OCdREp0EJVMsOM2G8zUMtRoS3MAyGUzLrfRqXQls3GZV3f//tUMnLIYKITLOvy0FdDce682PoLFi+YlnRHX4LWnlldmy8bO4d1A7xlxpSx9Y7xZEKUvDDv0B0oGC0Tdq8l8UuN0/TLR9VCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9NCoafHtI58M8LvzIXFC5c3X9mHSSr8TXGFTRBx9es=;
 b=BAy+HGiCZoCmIBss6vwj1EexFBllv7ldhLm+cAM47yrOpdjNdxiK1U5HBDys0saJnpZfeGSWIl1f9+OU8fgQ7xEF94g3bY2gjJ7oI0hWvTxycoAdghgeTKCarxKknmrEMqCoMnvpIR+J9jtOAc4nG7J8Hw6ubtdgiyi5tEeaQEA=
Received: from MN2PR06CA0018.namprd06.prod.outlook.com (2603:10b6:208:23d::23)
 by DM4PR10MB6912.namprd10.prod.outlook.com (2603:10b6:8:100::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 12:15:31 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:23d:cafe::28) by MN2PR06CA0018.outlook.office365.com
 (2603:10b6:208:23d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 12:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 12:15:30 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 07:15:30 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 07:15:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 20 Mar 2026 07:15:30 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62KCFTpU3788037;
 Fri, 20 Mar 2026 07:15:29 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 Mar 2026 17:45:28 +0530
Message-ID: <DH7LOJ2CSWR8.2DMVWNLPENH46@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Dhruva Gole <d-gole@ti.com>, "Aniket
 Limaye" <a-limaye@ti.com>, Bryan Brattlof <bb@ti.com>, Vignesh R
 <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Moteen Shah
 <m-shah@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] mach-k3: move k3_falcon_fdt_fixup out of r5/common.c
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260312-move_falcon_fixups_to_common-v1-1-d7c61bb5a77e@ti.com>
In-Reply-To: <20260312-move_falcon_fixups_to_common-v1-1-d7c61bb5a77e@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DM4PR10MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: e82adbe9-71b2-49a9-661b-08de867a6161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: HbyHaBdAE0jqLYkxoS3vRu/4KqakvOwx6ZL3BZqzP+hCvD533PkIpiMyw6rlEXCvhVP1ntbS7dhe1jV2wHaD+NNRSXuGEhWsuBJZUAyCXh47etZ1CjWC+WRsBpCNgZWZhsKn7LsECd/f6iBgbmahLEyx1GmCACSF7Hdwx2mq6JHoyOW0lBD8ASJhlYJmfx4XnzQJinGvN4YlwybMXIJrBDFTW/wjAsYFTGuOX1/dYPlyzXK90aLpCnD4hT7QIBMvKZGt115hKqZugKEy/KlQWA0m0oFfb+6NJjPIyQZ3oFS0nR9uGljEy2kUdXJUOqpQ/kJl+3MeHSECVvTWxJtRMkOKsc8H10YK1q0pQpKcTYdJlrux7QvX/8WcJ/t+M8A/ULkQ3iOBHvfDrZnGkJESIpQttE5PI1SGZc5moRRDZg8P/fOj404VglZQ27fjxB8r+7+INL9raq/lj6oc40/KCt7PyrwnHCAGNKYpsNqby2BfqyjPvWKXSq1sBl0ghCrW7rY7CFHPRAfl9fuzi611rXttFKx4C/Zn3sypew6KdP6p4oQSmIUdLuH65UIeRV0Bdq26KELjdYHNDJjIhg7MnSQPrUhisRUtuom44gYU33Y1uZxdtuxrmcvm5n98wUL+9ewKejwHkL5Ue6dsxCR6LqVM4h9u2cTJrWoqUSTazNi8GKncnRIO6kMJMLENdejlhwhfQdSn1pK4d0Kz/dfAb3CCmZ+JlLNBFIYNAfwrUQnXdnQoPfgZP0GZk50Qt4G8jcKI04uqT0DvNUfTwYBMRA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yxHc62JgA2LzSUGOGcNul4YLR6QGkHS31IzucEGHkzCd16j0S4ypjr+rn+aiOAkKlsdwF+1LkZHoAkMfOre05+AjUU7OySv1CJEuN5g0+PofF1WUYV1E5OqOSAXqZH76VgCbh+clsLSU9Wk4kPtMgHTp8H4M8NTp8sbn0jnLJdRXAxo4Q3QzGgVA7pJ8QZSVkn3p3bhKwrnRA3MhgpX0amMkUxbSSgLLwopq8V73ygPks8jwu0wFzPF9kEiKojWsb22Ij1A3JxHLiTjTUa7VMqNAMW6OsLQINjtZ7bu2oTc7IEHVqVrMH9U94PMb6xFVvD1tTSXwiVjlUHWHpHsBfi8a81H6TijKB1zitRg7nV+NUIjhEa8jFtyHr2AMZflazudT6n/xa2kkVVqP4EDZN4mAYzsHaRTbA7KS9IxSxM8v2bdG9Z4ThlKXCSEZWm5I
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:15:30.9875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82adbe9-71b2-49a9-661b-08de867a6161
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6912
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

On Thu Mar 12, 2026 at 5:34 PM IST, Anshul Dalal wrote:
> k3_falcon_fdt_fixup is used to perform fdt fixups at runtime in falcon
> mode such as adding bootargs. Currently the function is only accessible
> to the R5 SPL but could be useful for A53 SPL based falcon mode setups
> as well.
>
> Therefore this patch moves the function from r5/common.c to common.c.
>

Btw for testing purposes, I had used the following config fragment with
rootfs from the default tisdk image on am62x[1]:

# Enable falcon mode
CONFIG_SPL_OS_BOOT=3Dy
CONFIG_SPL_OS_BOOT_SECURE=3Dy
# We use envs for setting bootargs
CONFIG_SPL_ENV_SUPPORT=3Dy
# Allows for the SPL to detect UUID for kernel's rootfs
CONFIG_SPL_PARTITION_UUIDS=3Dy
# Perform FDT fixups from SPL
CONFIG_OF_SYSTEM_SETUP=3Dy
# We use the rootfs (i.e partition 2) for booting which is ext4 not FAT
CONFIG_SYS_MMCSD_FS_BOOT=3Dy
CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=3D2
CONFIG_SPL_FS_EXT4=3Dy
CONFIG_SPL_FS_LOAD_KERNEL_NAME=3D"boot/fitImage"
CONFIG_SPL_LOAD_FIT=3Dy
# Used as the 2MiB aligned load address for kernel
CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=3Dy
CONFIG_SYS_LOAD_ADDR=3D0x82000000
CONFIG_SPL_STACK_R_ADDR=3D0x88000000
CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x82000000
CONFIG_SPL_PAYLOAD_ARGS_ADDR=3D0x88000000
CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x2700000
CONFIG_SPL_GZIP=3Dy
# Disable all unsupported boot media to save space
# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
# CONFIG_SPL_SPI_FLASH_SUPPORT is not set
# CONFIG_SPL_YMODEM_SUPPORT is not set
# CONFIG_SUPPORT_EMMC_BOOT is not set
# CONFIG_SPL_NAND_SUPPORT is not set
# CONFIG_SPL_NOR_SUPPORT is not set
# CONFIG_SPL_RAM_DEVICE is not set
# CONFIG_SPL_FS_FAT is not set

I was wondering if it makes sense to add this config fragment to the
tree along with documentation for falcon mode from A53 SPL for K3
platforms?

[1]: https://www.ti.com/tool/PROCESSOR-SDK-AM62X

> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/mach-k3/common.c    | 80 ++++++++++++++++++++++++++++++++++++++=
++++++
>  arch/arm/mach-k3/common.h    |  5 ++-
>  arch/arm/mach-k3/r5/common.c | 77 --------------------------------------=
----
>  3 files changed, 84 insertions(+), 78 deletions(-)
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 2f3df5519c5..b0a75988714 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -457,6 +457,83 @@ static __maybe_unused void k3_dma_remove(void)
>  		pr_warn("DMA Device not found (err=3D%d)\n", rc);
>  }
> =20
> +static int k3_falcon_fdt_add_bootargs(void *fdt)
> +{
> +	struct disk_partition info;
> +	struct blk_desc *dev_desc;
> +	char bootmedia[32];
> +	char bootpart[32];
> +	char str[256];
> +	int ret;
> +
> +	strlcpy(bootmedia, env_get("boot"), sizeof(bootmedia));
> +	strlcpy(bootpart, env_get("bootpart"), sizeof(bootpart));
> +	ret =3D blk_get_device_part_str(bootmedia, bootpart, &dev_desc, &info, =
0);
> +	if (ret < 0) {
> +		printf("%s: Failed to get part details for %s %s [%d]\n",
> +		       __func__, bootmedia, bootpart, ret);
> +		return ret;
> +	}
> +
> +	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
> +		printf("ERROR: Failed to find rootfs PARTUUID\n");
> +		printf("%s: CONFIG_SPL_PARTITION_UUIDS not enabled\n",
> +		       __func__);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	snprintf(str, sizeof(str), "console=3D%s root=3DPARTUUID=3D%s rootwait"=
,
> +		 env_get("console"), disk_partition_uuid(&info));
> +
> +	ret =3D fdt_find_and_setprop(fdt, "/chosen", "bootargs", str,
> +				   strlen(str) + 1, 1);
> +	if (ret) {
> +		printf("%s: Could not set bootargs: %s\n", __func__,
> +		       fdt_strerror(ret));
> +		return ret;
> +	}
> +
> +	debug("%s: Set bootargs to: %s\n", __func__, str);
> +	return 0;
> +}
> +
> +int k3_falcon_fdt_fixup(void *fdt)
> +{
> +	int ret;
> +
> +	if (!fdt)
> +		return -EINVAL;
> +
> +	fdt_set_totalsize(fdt, fdt_totalsize(fdt) + CONFIG_SYS_FDT_PAD);
> +
> +	if (fdt_path_offset(fdt, "/chosen/bootargs") < 0) {
> +		ret =3D k3_falcon_fdt_add_bootargs(fdt);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
> +		ret =3D ft_board_setup(fdt, gd->bd);
> +		if (ret) {
> +			printf("%s: Failed in board setup: %s\n", __func__,
> +			       fdt_strerror(ret));
> +			return ret;
> +		}
> +	}
> +
> +	if (IS_ENABLED(CONFIG_OF_SYSTEM_SETUP)) {
> +		ret =3D ft_system_setup(fdt, gd->bd);
> +		if (ret) {
> +			printf("%s: Failed in system setup: %s\n", __func__,
> +			       fdt_strerror(ret));
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  void spl_perform_arch_fixups(struct spl_image_info *spl_image)
>  {
>  	void *fdt =3D spl_image_fdt_addr(spl_image);
> @@ -465,6 +542,9 @@ void spl_perform_arch_fixups(struct spl_image_info *s=
pl_image)
>  		return;
> =20
>  	fdt_fixup_reserved(fdt);
> +
> +	if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
> +		k3_falcon_fdt_fixup(fdt);
>  }
> =20
>  void spl_board_prepare_for_boot(void)
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index e970076d08e..466ad22f895 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -61,10 +61,13 @@ void do_board_detect(void);
>  void ti_secure_image_check_binary(void **p_image, size_t *p_size);
>  int shutdown_mcu_r5_core1(void);
> =20
> -#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE)
> +int k3_falcon_fdt_fixup(void *fdt);
> +#if !IS_ENABLED(CONFIG_ARM64)
>  int k3_r5_falcon_bootmode(void);
>  int k3_r5_falcon_prep(void);
>  #endif
> +#endif
> =20
>  #if (IS_ENABLED(CONFIG_K3_QOS))
>  void setup_qos(void);
> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
> index 03638366046..484d96f9536 100644
> --- a/arch/arm/mach-k3/r5/common.c
> +++ b/arch/arm/mach-k3/r5/common.c
> @@ -406,83 +406,6 @@ int k3_r5_falcon_bootmode(void)
>  		return BOOT_DEVICE_NOBOOT;
>  }
> =20
> -static int k3_falcon_fdt_add_bootargs(void *fdt)
> -{
> -	struct disk_partition info;
> -	struct blk_desc *dev_desc;
> -	char bootmedia[32];
> -	char bootpart[32];
> -	char str[256];
> -	int ret;
> -
> -	strlcpy(bootmedia, env_get("boot"), sizeof(bootmedia));
> -	strlcpy(bootpart, env_get("bootpart"), sizeof(bootpart));
> -	ret =3D blk_get_device_part_str(bootmedia, bootpart, &dev_desc, &info, =
0);
> -	if (ret < 0) {
> -		printf("%s: Failed to get part details for %s %s [%d]\n",
> -		       __func__, bootmedia, bootpart, ret);
> -		return ret;
> -	}
> -
> -	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
> -		printf("ERROR: Failed to find rootfs PARTUUID\n");
> -		printf("%s: CONFIG_SPL_PARTITION_UUIDS not enabled\n",
> -		       __func__);
> -		return -EOPNOTSUPP;
> -	}
> -
> -	snprintf(str, sizeof(str), "console=3D%s root=3DPARTUUID=3D%s rootwait"=
,
> -		 env_get("console"), disk_partition_uuid(&info));
> -
> -	ret =3D fdt_find_and_setprop(fdt, "/chosen", "bootargs", str,
> -				   strlen(str) + 1, 1);
> -	if (ret) {
> -		printf("%s: Could not set bootargs: %s\n", __func__,
> -		       fdt_strerror(ret));
> -		return ret;
> -	}
> -
> -	debug("%s: Set bootargs to: %s\n", __func__, str);
> -	return 0;
> -}
> -
> -static int k3_falcon_fdt_fixup(void *fdt)
> -{
> -	int ret;
> -
> -	if (!fdt)
> -		return -EINVAL;
> -
> -	fdt_set_totalsize(fdt, fdt_totalsize(fdt) + CONFIG_SYS_FDT_PAD);
> -
> -	if (fdt_path_offset(fdt, "/chosen/bootargs") < 0) {
> -		ret =3D k3_falcon_fdt_add_bootargs(fdt);
> -
> -		if (ret)
> -			return ret;
> -	}
> -
> -	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
> -		ret =3D ft_board_setup(fdt, gd->bd);
> -		if (ret) {
> -			printf("%s: Failed in board setup: %s\n", __func__,
> -			       fdt_strerror(ret));
> -			return ret;
> -		}
> -	}
> -
> -	if (IS_ENABLED(CONFIG_OF_SYSTEM_SETUP)) {
> -		ret =3D ft_system_setup(fdt, gd->bd);
> -		if (ret) {
> -			printf("%s: Failed in system setup: %s\n", __func__,
> -			       fdt_strerror(ret));
> -			return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>  int k3_r5_falcon_prep(void)
>  {
>  	struct spl_image_loader *loader, *drv;
>
> ---
> base-commit: 8bc2a5196c1c0bb5dbdaca073323da0015a0de37
> change-id: 20260312-move_falcon_fixups_to_common-34b602114608
>
> Best regards,

