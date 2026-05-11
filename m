Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AAACD3427
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 09:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06E0B846BE;
	Mon, 11 May 2026 11:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sNdk+YPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A68D8483F; Mon, 11 May 2026 11:53:38 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A6084666
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEdJTdi6q9cm9pCi/hcBAnTMxFwBnMqGFIJsSJpQaVA8hQApkrrnhO0C+9vVBV4sfdgkIITc4L1/1MKkq1uh26bM/moIU5VQaK+CzvjruVNsLoLKdCFGRxXxozLDcDhiMC1OgK3P0uQ7/mWD9lyBnCS3X9WwdFijxEfui5uFNmHzyhyQaVoNXnatqNHid2Vx8yqw8NOkc3d0dCcr8hhb50jAKLN7ERyjA30ucKWjejUuGsa4dBeVbPM20SeFBL9eGbnSVo631UD/7aezwYeeQcFGZi6k+LFyaJuK1Pcxkw9EEMp4f/j1gfDP851r8bV9NFZB+X8S0HjJZuSCVGqdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zK/u2k5h8BjUP01VnKZBxnrDubRZSjEq4+RXNVDLyI=;
 b=LKf7jQMJn4XJILifVlHi+hywK5bKMu/mOuFCgydG36Q7CLbiCqfk9IeYzd6UT8MfkQwb+pLGS+zku4asSPkDA1l9NUmQ2WcDz/s0pW3EzCQ0EGVD7nEHW5nJAtWlT71RjkTDJP0s63pjHF8m8b0Y1MiuhQaYfbl6rkHxF70CCtmGzJJYr4inwKpjaHectYYnHhA4DiaVpvC4+pw1x+W7kXsxWeftuj5BXs7EIs81LO4Q1hgJk4OdTnfAiouE7dtr0o3kiiDVOJVVkBV1xdDrRH0ILKzAoHpEBOosZPWfbc29wlGuw3CoW6+Y1l2bDMLUFKPdiTXF6A3I96VH4QOS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zK/u2k5h8BjUP01VnKZBxnrDubRZSjEq4+RXNVDLyI=;
 b=sNdk+YPX74yBc0I+noavkLvjwYYhfcH8B089xwWUsgavAQKAHqK4183NLi1Zbpvsxo8jmOzVf6fnnYzTPxUDj9nYDkBUZCbz7T9kBW0z24Lgt+ceXuED0sEYYlkDluwgc7jGN3/aLpwjnynwyj7uoP/HvECuEa4OVgAIRO3BXvQ=
Received: from CH2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:610:60::20)
 by BLAPR10MB4868.namprd10.prod.outlook.com (2603:10b6:208:333::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 09:53:30 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::d2) by CH2PR14CA0010.outlook.office365.com
 (2603:10b6:610:60::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 09:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 09:53:29 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 04:53:26 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 04:53:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 04:53:25 -0500
Received: from [172.24.26.211] (lt5cg60819vj.dhcp.ti.com [172.24.26.211])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64B9rLUf3447693;
 Mon, 11 May 2026 04:53:22 -0500
Message-ID: <ac17d4b9-e31f-4ab1-836d-b8b188dfe8b6@ti.com>
Date: Mon, 11 May 2026 15:23:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] board: ti: j721e: Add resume detection for
 J721e/J7200
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Abhash Kumar
 <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-4-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260430084414.1354490-4-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|BLAPR10MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef94179-3d9a-4207-1dc5-08deaf4327b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hhC7Grt6ThhlXiiFSPb+juQhbn0/rprvXRDiehUPdl3pIkK0/p/0muHNTJE54zzqNthc7cM7IzXrLS4DUSunB+HNWWPUlTQddgVizh9LR7H1t9upn1dfnEAWiEkgtIfsjL2SibksGiDJbrmclsVCF9s2+kdtTgkeCd/DWUhod2Hq8qeZYardH/c7ya+Yr6OggYD1/KPrJNV2kuXvX2nNTidjkQCgV3tiKWXk3ztLez6gVaImU8RK3UUPCyzsei1ZXlmW9oOQ2n9jbf+27EbUMbf+81HjR5HtoQLpJgqmkLKQWx6gu6FJ0SYFzaJhcDIAAtSwJZ2UVCltmWg/rpJeE66HL8TuUXMgajz1WzTCmfKPGCAb7jvgt7eCYC0xWxM19vkVbVuw6kWBW0OWzfBeQzVVE9K0bwDw/v0XdD4yxi9ldcY/EeoEAPmMev8gsshGPiAdyXLvrSZrI2LZS9trZSojFtP4Xlt0+ef7LyAuPPy9Iqa4MSLj59bI5HWnePNCvrP+ND+XiDn8ZyCa5gl9/pw9fBsGJ39qjwVLPQ2Q2+tZIgpZZ1SdxeaYEJR8E8shJnQVl8Uwli9QhhB6t8N299b+qiBTjLF1Yxecm3dtWkHp+Jsi3og7CvQP382L1LvpZTETMSA0h65FyJig2oruNQp3VF9R5S793pFpFBUlTDuMQhRD+kUDZpAvbHjU1aJW
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WZbmWd3zeau97+IXhOma3B3C/sHVyGFO5MtvJ63gzbYxFI5gUaYqBidJQ6DJtrVM0DfLhWywM+tl8zIqpO9Q4pqxnsqkY3WydTytesYPA3LiMRpBr09kxwcm4H3Fz6BTuBqJEHAZc0JS/n7qG4QT/Xgk+HB5xUV9tGQvVy4W3HBsZr8IumJGIsBCMqAD/FX0d7p4Cp2EEMC5xPaicrmJjgSYmPttVGPpulKx0exV/kYFS1ULn4Fn8RaqTePqczgnyv2nZrrdWvnjnZ93gn1kAaZpmHTwL1oRyxsyDxkrl/cfgOgm4BipOgGXzB+DpvlE5L1/WYiXZ1rxAFvQ/+nHxv88VDK1ojtdyC2bKc91oXifAs1dyWa7ib7qzBtRjXv6PauMDZC+ZhxM6xSM1oMibUbBMeNHOs1IkXjxKCkCqnyeaD0OMBAAnO4NAL0wdKZG
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 09:53:29.5773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef94179-3d9a-4207-1dc5-08deaf4327b1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4868
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



On 4/30/2026 2:13 PM, Richard Genoud (TI) wrote:
> From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
> 
> Add the capability to detect a resume. This overrides the weak
> function j7xx_board_is_resuming(void).
> To detect the resume, SPL searches a magic value (0xBA) in a register
> of PMICA.
> This value is set by DM-Firmware during the suspend sequence.
> 
> Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
> Co-developed-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
> Signed-off-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  board/ti/common/k3-lpm.h | 17 +++++++++++++++++
>  board/ti/j721e/evm.c     | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 board/ti/common/k3-lpm.h
> 
> diff --git a/board/ti/common/k3-lpm.h b/board/ti/common/k3-lpm.h
> new file mode 100644
> index 000000000000..a2141a0c25a8
> --- /dev/null
> +++ b/board/ti/common/k3-lpm.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2026, Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2026, Bootlin
> + */
> +
> +#ifndef __K3_LPM_H
> +#define __K3_LPM_H
> +
> +/* Magic value in PMIC register to indicate the suspend state (SOC_OFF) */
> +#define K3_LPM_MAGIC_SUSPEND 0xba
> +
> +/* PMIC register where the magic value resides */
> +#define K3_LPM_SCRATCH_PAD_REG 0xcb
> +
> +#endif /* __K3_LPM_H */
> +
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index 881392bd963a..67ff13828514 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -17,9 +17,11 @@
>  #include <spl.h>
>  #include <dm.h>
>  #include <asm/arch/k3-ddr.h>
> +#include <power/pmic.h>
>  
>  #include "../common/board_detect.h"
>  #include "../common/fdt_ops.h"
> +#include "../common/k3-lpm.h"
>  
>  #define board_is_j721e_som()	(board_ti_k3_is("J721EX-PM1-SOM") || \
>  				 board_ti_k3_is("J721EX-PM2-SOM"))
> @@ -469,6 +471,41 @@ err_free_gpio:
>  	}
>  }
>  
> +#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM))
> +
> +bool j7xx_board_is_resuming(void)
> +{
> +	struct udevice *pmica;
> +	int ret;
> +
> +	if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
> +		goto end;
> +
> +	ret = uclass_get_device_by_name(UCLASS_PMIC,
> +					"pmic@48", &pmica);
> +	if (ret) {
> +		printf("Getting PMICA init failed: %d\n", ret);
> +		goto end;
> +	}
> +	debug("%s: PMICA is detected (%s)\n", __func__, pmica->name);
> +
> +	if (pmic_reg_read(pmica, K3_LPM_SCRATCH_PAD_REG) == K3_LPM_MAGIC_SUSPEND) {
> +		debug("%s: board is resuming\n", __func__);
> +		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);

If you failed to clear magic word then, we are not in correct state.
So doing all work with PMIC, set state to resuming

> +
> +		/* clean magic suspend */
> +		if (pmic_reg_write(pmica, K3_LPM_SCRATCH_PAD_REG, 0))
> +			printf("Failed to clean magic value for suspend detection in PMICA\n");
> +	} else {
> +		debug("%s: board is booting (no resume detected)\n", __func__);
> +		gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
> +	}
> +end:
> +	return gd_k3_resuming() == K3_RESUME_STATE_RESUMING;
> +}
> +
> +#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J7200_R5_EVM */
> +
>  void spl_board_init(void)
>  {
>  	struct udevice *dev;

