Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CDAE9A03E
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 08:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E270583CE3;
	Wed, 18 Feb 2026 09:42:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="v1YbJ/ms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C440183CF2; Wed, 18 Feb 2026 09:42:26 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE47E83C19
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 09:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCRLLOP16EjuthvGmP6ev8+PWjL3oc3rOGmWSqD77ABRV4QxzgPgHFAXbHOfSRoUWnbqKGicJXa/Ds6iAgYAPhi1S6cSYnhVoyNLmtoJUyI5JNsc5rTGFbsa+bouEuQXB33WRIZIhHm3Djyp81dvtMcjuSe9gLO5xiVQQchSf1+x9MwJ2tRj0WAB8uX93HQ9An0F5N3x8a0TwG+1u2TFCqntCGMAZziH52WmwJxnQ2ydFLKgT1YHk+EYANh78ZI3e6rKL924oHGP9XhC/MWCC0cCdsMrXBKhoutiO4d2QfayRBbD3qBAOmFIgvIPZpjhVc/WW91qWjMYzGSASNu19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JX8RKxcfxwID5SuUsfZKiKBAcTXjtk5qJpmiIbKLdfY=;
 b=wI2Y4loYyKvvF1IfjGphoIDGZb35UeBK6VdqluKsVLkRIdqV1Idyc4xeH577iBs0u4DyL0ENhcJOesj5NESgLmH5YvUs20xR4pQyschWbl4Nl883ft/ImTEnTh4QliZWl+k/JtzQ7qrDq5qos4jVXWgwh5J737DzL3OcJIb9Ji9BYXFEtT2vd027AKSC0rCPFURxjmrKZ9kMYAQxPCfKZplGj5MDE+ewsrp2f6SE+zMGX3IMH/mPq4vpwB9whruSgMuwhb0+/ZuuVEGwpMQL511wwpbsCDmtPvJrwu3sueV/Ei8nHgv8h2T+yhFheOd7upBj2qqoJweOx23/I+nvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX8RKxcfxwID5SuUsfZKiKBAcTXjtk5qJpmiIbKLdfY=;
 b=v1YbJ/msDKMJUNOT68IER01bmOpnMTXVKe93xO6RhKHlBqG5NfFV0t7bvhTmJ/sIW20lWqJl1VmDeX86q6yXAL+bz6VUQq5gWeCZJFyGLzu22u+FGAyGyTJA5CZD9SC4sSSXi3Pin+MRY5xa3BFej6vVPOdE+HsWXjNgglAS3kw=
Received: from SA9PR13CA0148.namprd13.prod.outlook.com (2603:10b6:806:27::33)
 by LV8PR10MB7942.namprd10.prod.outlook.com (2603:10b6:408:209::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 08:42:19 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:27:cafe::51) by SA9PR13CA0148.outlook.office365.com
 (2603:10b6:806:27::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Wed,
 18 Feb 2026 08:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 08:42:19 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 02:42:19 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 02:42:18 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 02:42:18 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I8gHia574104;
 Wed, 18 Feb 2026 02:42:18 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Feb 2026 14:12:17 +0530
Message-ID: <DGHYCYEIXTKK.1FYQH6YASASKO@ti.com>
Subject: Re: [PATCH 1/7] common: spl: mtd: Add support for loading images
 from MTD
From: Anshul Dalal <anshuld@ti.com>
To: Anurag Dutta <a-dutta@ti.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <s-k6@ti.com>, <gehariprasath@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260217112156.272154-1-a-dutta@ti.com>
 <20260217112156.272154-2-a-dutta@ti.com>
In-Reply-To: <20260217112156.272154-2-a-dutta@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|LV8PR10MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: fe39f04e-2b8e-4206-a61e-08de6ec9a092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzNNNDlMSnphY0hSQXlqMkpIZTlzN3Zsb0xMWjNkTmJOdTNDa2lUaFNpLysz?=
 =?utf-8?B?b0tRSG5TNWQwMW9RODJQMHVmSFJ0SzJYd0t1YldOS0R0Zk4xaHhMNkNQTndK?=
 =?utf-8?B?Ulova3VUUS9EQVRtM2xjWHYxejd0Q0NpaTU5TWhTc1ZLamJCRm92UXBPRkRW?=
 =?utf-8?B?dFNJQXgxL1dzL05lZkl0eWZtQnMrSVhnY2VUQ2lMSjdVLzh1ZVJUV2d0ZTl0?=
 =?utf-8?B?SDVuZlE0Y0FmM1F5d2p0N0lYZk5aZVJZakZCRFlMWE0vUzJoNnUwTnBVTk9M?=
 =?utf-8?B?cC94cDRKRmxtRnB4THdyaVI5VHc4RlRMcXJVL1VtQXhWa291TkNjcHROaHJV?=
 =?utf-8?B?SEQ0RXBsSUo1SUxIMmN3R2sySi8zUHFkaEpEWjc5Vmg4ODY4OEJiMjlLeVBJ?=
 =?utf-8?B?bGdTYVdubExnTkFDVmZCV0pSS2VzdmlpdUhwRTJjWjhmU1VOTzNsWEJQVlNP?=
 =?utf-8?B?NmNzSUdsaC9OOFU0YUJaWXRsR1gzSUZockk5LzhJd2ZtWjRXWWY4UnBJaERR?=
 =?utf-8?B?YnJ4ZHdWZThCUndJUGlwM3JZdC8vcGY4cG9iSnI4ZGh3alNVK3d2Wlg1MUla?=
 =?utf-8?B?dEdwbmVoUHhjRHFybHMyVHZleXFGZXRBTjV4WUFoVVF2dExHSXdlVS82bVpB?=
 =?utf-8?B?RlBPbldSQlM5TmN0M2JPMUJad0JLcVpXdXdNTWpoQkhwTkdIRlBTYzlUdWlT?=
 =?utf-8?B?WDdUeHJhRy80Z0U3TDQxSlBiMzRYVGtUYTBDMFI5NUhkQlVVaEVnN09YdENM?=
 =?utf-8?B?cHJjcnBZZDlBby9hMkJCZk0wOEQxc0hCbTNvbU9iVm9TMStaOWV1YkFrM0lz?=
 =?utf-8?B?QksxamlobW5TYVdLT3R1UW1BcWx0U0NvbXpxamMzbXJCVXEweFJIMk5vZUpJ?=
 =?utf-8?B?OGdpUHVoRmZDMmhmcEhCZUYvWDlRUC9NSzUxK2dUMmpqeTdpMTFsL0pVWk5j?=
 =?utf-8?B?ZHpPMWsvcVdaR0o1emg5Uk9RMVk0a1Bxc3U3RnZETk0zQndzdkFiSTN4TFhO?=
 =?utf-8?B?NlNBN0Z0S2pDSldDVDBFV1RPQXlqOXQ0MEZtMERCNnd4Q0xkcWlzb2wvakxr?=
 =?utf-8?B?SnN2cHZJSUhsZ25JbkJiRTErVGYxYXRVcE9GZnRyc0hJZG1ML2pHellNaEFp?=
 =?utf-8?B?WjVxNU1sZGxpeGl0S3FDLzlHR2NHQ3JxTFQ1TGUzT0Z3eWJUckg4UFZVenNB?=
 =?utf-8?B?Q2lKVk9KSS8wdlpWWUhNMCtvZHlsdDZ6eHY5UHhGRFJ4RVEzaTJsYUFMY1Iw?=
 =?utf-8?B?Q0VqWTBRVml5TDdiRnpvcytnRitCSzNwMUdtZXh3d28wMTB1K3IyN3I3dUg0?=
 =?utf-8?B?S3ZjMDJUQ1dBQzNDQnZpR2JwUmFjUUQwbHluK1o2VHVERlJ2SkE3VmZLRWZX?=
 =?utf-8?B?SWhBZTdQTHgvbFdiMTRKUDgvZDltZmFnTjAwWnVWMVo3TjB2dXdaYmorUWNt?=
 =?utf-8?B?cEtuY2Fja2l3bkdEZGNQU3lneVFPRGlKOTRCQmdqNzQwRFFEMGZiTS95TVRh?=
 =?utf-8?B?ZVcyTnBCbDc5ckhFVk5KaUkyRDQ3OWJCQTdrVHdTT01VNXJWWVFLeGV4ZlNo?=
 =?utf-8?B?UEJsMDhUUEx0ZUg1bnY4Vm1Wb0gvSGx4WkxsSE4yZjltaFpyNHNBajR5Sjky?=
 =?utf-8?B?MUJndkJBbWhHZFFiSjd4dXJ6YndwOTJXMDExTVZ3YjFtNjBHRVVpcktFSGJ4?=
 =?utf-8?B?dWV5WE9oUDV3S0ZIOVVxOXlIV0JKdFZ5TDlWOFVZVXRIUUdKNXlvYi9NTDNj?=
 =?utf-8?B?akR0UXFFT1VmVzV6UG5Xc2UrYS9sUmpnMVl3UFJlZFRRdnFYK2UxNUVVOVVv?=
 =?utf-8?B?NXp1WVNuWU5Xdm5kMUhGNVkyQTlTdjZ0LyttOHkyT3UwbTdmL1VpTE9LamNY?=
 =?utf-8?B?OFh4WndicWRYZEIrd1llN1MxNEdXTUowOW5ZenU4WlF4bGpIZk9OdUZUcjNS?=
 =?utf-8?B?SG5QYXl2dExaQStpaXlzZGNJNDloZVlvSUZhYlRJeUhrMkd1dVlDOVJ5cjhm?=
 =?utf-8?B?VVYxdUw2SEJKS1ZPL3R6QXE2b0w4KzlIWmFpcmVhY2p6NXJSek5kWm1ERG5G?=
 =?utf-8?B?bEVIZjl4dUhSOVhmSkw0d3NYUGVOaWdIMWhxUVZmZHJpUlk4TXVFZkI3S1M5?=
 =?utf-8?B?U09rdnRkeXRabDIxWFVvUERCUG9acGtGT2p2KzVhTC9DNzVYWjdUSmwvNi96?=
 =?utf-8?B?eUE9PQ==?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fU5GtEaAOPH7RBZ5xZfNDD9kpam309QO93m4agG5o0PynQDEbuLJmbPDz/M9555OSmeslv1CO/Lnxi//rnxsvGCSCxR2o2jTUxAUvUH5SBb/noY34k6saALbhrj0g2hzRf1jLqvF9pGPwcVhGJJ7OfYEEvQ3UZ4Mm79LLrS+yZiI2gxjFXSjmoTP37f0NEdDREAFZrM0fttDahH6+JZRhG1KMAscH164eVMdSQn+ZvXHyXd585FrWAyIP4IQwqI1YOI6J6rLxfr5OzMEdNdUMdnDozFk3ghU4rCZdgS+gRs39AtPJTHgtrGj3hE/bU56ftZm/P65uGOQoT94bboJcReRcmL1bWVGauoF9AwrX8EIX3QlT3MPHNRVuC3G7XaaFT/a3+BWrZpbzKFkuFrwz7v6TeStkM7viQfLjpv7+PVZseYWyQM8hkddQuQ0mFLR
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 08:42:19.3936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe39f04e-2b8e-4206-a61e-08de6ec9a092
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7942
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

On Tue Feb 17, 2026 at 4:51 PM IST, Anurag Dutta wrote:
> From: Apurva Nandan <a-nandan@ti.com>
>
> Introduce support for using MTD subsystem for loading images from
> memory flashes. This will provide the support of using mtd functions
> which are abstracted over the type of flash being used, to load the
> boot images from the flash.
>
> Currently, add support for only SPI NAND flashes. This can be extended
> to all other flash types, when required.
>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>

Asides form what Sean said, I have a few comments below:

> ---
>  common/spl/spl_mtd.c      | 90 +++++++++++++++++++++++++++++++++++++++
>  common/spl/spl_mtd_nand.c | 31 ++++++++++++++
>  include/spl.h             | 18 ++++++++
>  3 files changed, 139 insertions(+)
>  create mode 100644 common/spl/spl_mtd.c
>  create mode 100644 common/spl/spl_mtd_nand.c
>
> diff --git a/common/spl/spl_mtd.c b/common/spl/spl_mtd.c
> new file mode 100644
> index 00000000000..341e1a73392
> --- /dev/null
> +++ b/common/spl/spl_mtd.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * FIT image loader functions using MTD read
> + *
> + * Copyright (C) 2026 Texas Instruments Incorporated - http://www.ti.com=
/
> + *	Apurva Nandan <a-nandan@ti.com>
> + */
> +#include <config.h>
> +#include <image.h>
> +#include <log.h>
> +#include <spl.h>
> +#include <asm/io.h>
> +#include <mtd.h>
> +
> +uint32_t __weak spl_mtd_get_uboot_offs(void)
> +{
> +	return CONFIG_SYS_MTD_U_BOOT_OFFS;

NIT: The symbol is used here but is not added until 4/7 of the series.

> +}
> +
> +static ulong spl_mtd_fit_read(struct spl_load_info *load, ulong offs,
> +			      ulong size, void *dst)
> +{
> +	struct mtd_info *mtd =3D load->priv;
> +	int err;
> +	size_t ret_len;
> +
> +	err =3D mtd_read(mtd, offs, size, &ret_len, dst);
> +	if (!err)
> +		return ret_len;
> +
> +	return 0;
> +}
> +
> +struct mtd_info *spl_prepare_mtd(uint boot_device)
> +{
> +	struct mtd_info *mtd =3D NULL;
> +
> +	mtd_probe_devices();
> +
> +	switch (boot_device) {
> +	case BOOT_DEVICE_SPINAND:
> +		mtd =3D get_mtd_device_nm("spi-nand0");
> +		break;
> +	default:
> +		puts(PHASE_PROMPT "Unsupported MTD Boot Device!\n");
> +		break;
> +	}
> +
> +	return mtd;
> +}
> +
> +int spl_mtd_load(struct spl_image_info *spl_image,
> +		 struct mtd_info *mtd, struct spl_boot_device *bootdev)
> +{
> +	int err;
> +	struct legacy_img_hdr *header;
> +	__maybe_unused struct spl_load_info load;
> +	size_t ret_len;
> +
> +	header =3D spl_get_load_buffer(0, sizeof(*header));
> +
> +	err =3D mtd_read(mtd, spl_mtd_get_uboot_offs(), sizeof(*header),
> +		       &ret_len, (void *)header);
> +	if (err)
> +		return err;
> +
> +	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
> +	    image_get_magic(header) =3D=3D FDT_MAGIC) {
> +		debug("Found FIT\n");
> +		load.priv =3D mtd;
> +		load.bl_len =3D 1;
> +		load.read =3D spl_mtd_fit_read;
> +		return spl_load_simple_fit(spl_image, &load,
> +					   spl_mtd_get_uboot_offs(), header);
> +	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
> +		load.priv =3D mtd;
> +		load.bl_len =3D 1;
> +		load.read =3D spl_mtd_fit_read;
> +		return spl_load_imx_container(spl_image, &load,
> +					      spl_mtd_get_uboot_offs());
> +	} else {
> +		err =3D spl_parse_image_header(spl_image, bootdev, header);
> +		if (err)
> +			return err;
> +		return mtd_read(mtd, spl_mtd_get_uboot_offs(), spl_image->size,
> +				&ret_len, (void *)(ulong)spl_image->load_addr);
> +	}
> +
> +	return -EINVAL;
> +}
> diff --git a/common/spl/spl_mtd_nand.c b/common/spl/spl_mtd_nand.c
> new file mode 100644
> index 00000000000..9bc6ff86ee8
> --- /dev/null
> +++ b/common/spl/spl_mtd_nand.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * FIT image loader using MTD read
> + *
> + * Copyright (C) 2026 Texas Instruments Incorporated - http://www.ti.com=
/
> + *	Anurag Dutta <a-dutta@ti.com>
> + */
> +#include <config.h>
> +#include <image.h>
> +#include <log.h>
> +#include <spl.h>
> +#include <asm/io.h>
> +#include <mtd.h>
> +
> +static int spl_mtd_load_image(struct spl_image_info *spl_image,
> +			      struct spl_boot_device *bootdev)
> +{
> +	struct mtd_info *mtd;
> +	int ret;
> +
> +	mtd =3D spl_prepare_mtd(BOOT_DEVICE_SPINAND);
> +	if (IS_ERR_OR_NULL(mtd)) {
> +		printf("MTD device %s not found, ret %ld\n", "spi-nand",
> +		       PTR_ERR(mtd));
> +		return -EINVAL;
> +	}
> +
> +	return spl_mtd_load(spl_image, mtd, bootdev);
> +}
> +
> +SPL_LOAD_IMAGE_METHOD("SPINAND", 0, BOOT_DEVICE_SPINAND, spl_mtd_load_im=
age);
> diff --git a/include/spl.h b/include/spl.h
> index 06dc28362d3..c4442be4fdb 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -1219,4 +1219,22 @@ int spl_reloc_prepare(struct spl_image_info *image=
, ulong *addrp);
>   */
>  int spl_reloc_jump(struct spl_image_info *image, spl_jump_to_image_t fun=
c);
> =20
> +/* SPL MTD functions */
> +/**
> + * spl_prepare_mtd() - Prepares the mtd for the corresponidng boot devic=
e
> + *
> + * @boot_device: A number indicating the BOOT_DEVICE type
> + */
> +struct mtd_info *spl_prepare_mtd(uint boot_device);
> +
> +/**
> + * spl_mtd_load() - FIT Image loader
> + *
> + * @spl_image: SPL image to jump to
> + * @mtd: MTD device descriptor with geometry, flags, and read/write/eras=
e function pointers
> + * @bootdev: boot device used by SPL
> + */
> +int spl_mtd_load(struct spl_image_info *spl_image, struct mtd_info *mtd,
> +		 struct spl_boot_device *bootdev);
> +
>  #endif

