Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D055CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 18:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6E3083AD1;
	Wed,  5 Nov 2025 19:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IHrXfujK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCAF083AE9; Wed,  5 Nov 2025 19:09:50 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E114B83AC5
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 19:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KI7fF1i6SiyXGx2yd9pCZXr3TYLHFLL7CGuzEWkKxMm9B6BZJ/5lDfzWh/wCzHCUeiNTQkfXznGx+jOMUhvCXaTkeTKWwFMNl2kRRhS3PBpoKialqL/wdQ2IXz4kJnOK1jqFcIdtgobu1m/r+ECJ6YiWtSUM2ExSbmf2UIOzuPjXkx5HFNsFXZGjoZSohUV+PMsiNUSe1uHT0m29h2ckjJ9VTaUdSrK6bBzBnnKF463AhnJu7CkD5TLmoE0Qul6jT13wYuPWo3wkIx2al24I1tpdoKukAenMP3nz5T4L83X7T9liadkK94K1tcOPd7LYHKVpRuYnYJ5GbYXI35c7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDzWu2qkZ5Ed+qpl6hn9bI+g5S67uKFw08IUFtxG5Tg=;
 b=c5LFmXDsiaVZPIaUQwYlsNkwAtQyna7Jz3aWW+uCrF96t0cK/I3XOXviwxpMg/3wSP7Ok3fpbHtdkpPMZoz/ZejRkRA6Ihj53qwWtG8Bh6VMhm5PPGysHMZwDuF40e+LCohexJ+ggitudNJgnt/4tcD9DnRN+KRoZOGjGqjxclrvC4zoxvC2IaJjWmc3bYKchw/YT6rUZDF/ZUf+YSoMXAO7qWW0RwSmX2D1ATuFvBEEBasSzSMq23kOPG5C3kWMkrxsWNxcJ3m3g8luYtQxGK4dVcHFtW5EtRkegKMwEfv/mR4WnIk1nl5TTqwEIhfGJUlkoclmEsyJiAyijr4nSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=dh-electronics.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDzWu2qkZ5Ed+qpl6hn9bI+g5S67uKFw08IUFtxG5Tg=;
 b=IHrXfujKRAIG3sRVKylecPYQoHaxLt3AvHjbva02mxV8wC5LSpIL6d3d1gZRFCl5KIsB7OjnirDEhA3b/Vk/vbUjDVhkS0O9wA7u5gMEfgYMIvtmhywxME9y0NhpYmwG1uA/uBN6kLwpNLP/Pff9Vem7aEDfqSQoZ1GbqAZyyTo=
Received: from SN7PR04CA0057.namprd04.prod.outlook.com (2603:10b6:806:120::32)
 by DS4PR10MB997551.namprd10.prod.outlook.com (2603:10b6:8:31a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Wed, 5 Nov
 2025 18:09:43 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::f1) by SN7PR04CA0057.outlook.office365.com
 (2603:10b6:806:120::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 18:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 18:09:42 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 12:09:38 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 12:09:38 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 12:09:38 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5I9bEt4130113;
 Wed, 5 Nov 2025 12:09:37 -0600
Message-ID: <31b4e016-379d-4637-8a02-896a897fc371@ti.com>
Date: Wed, 5 Nov 2025 12:09:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: am65x_usbdfu: add
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Judith Mendez <jm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Vignesh R <vigneshr@ti.com>, Christoph Niedermaier
 <cniedermaier@dh-electronics.com>
References: <20251105-am65_dfu_fix-v2-1-ccada89d966d@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251105-am65_dfu_fix-v2-1-ccada89d966d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DS4PR10MB997551:EE_
X-MS-Office365-Filtering-Correlation-Id: 51852b37-5b28-46c8-f212-08de1c967e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|34020700016|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEN6TUtXdHRabURLWXVzYlpZdkRURnpndGQzZDhJQTUwWlZ4SVB3UCtIU0Q4?=
 =?utf-8?B?WGd3d3RPWFB1K29GQVBFWFNybzczOUNuNVppR29QcisrSHlQUEVlVndCZ0Y5?=
 =?utf-8?B?S25UQlRuRDNwL0t0eDVBdzV2RXVBaDE0OWJzTUFBbnhKei9VZGdITE4waXcx?=
 =?utf-8?B?MUVxbEI0RXRJSjdtR0tRL3RWK28zbVJMTklHcStRWUdFUFZicnUrUXhDU1R4?=
 =?utf-8?B?K2Jrakp1TFJmOVZSSWVUMnlyRmZPUExsZjBTS0tCZzY2YTI0ZEo4dEtOSm9v?=
 =?utf-8?B?OGMyM0FmS2xWb1FHVjRZOW82RWhVVnFQUVVEcVk3L1ZZMFZQdEhxa3N3VWY0?=
 =?utf-8?B?Wk93T05NT3ZhVUlKK1VvUnFHZkNSZUdrRUkzcFp0NDVLMnhHY0sxZlc2VW9i?=
 =?utf-8?B?L0k0dVVSUGgzL2VmdXlwd0ZuK2hhT1I1bXFvQjBKSkVZU2xoTnVOYmtQYm1s?=
 =?utf-8?B?bjRqdHBZdnFPMjdTZ2MzNEJZaWpJRzBWdTIrKzF6UUZybFFnMVV1MDRlbUlJ?=
 =?utf-8?B?cjd6N2JPT3RpeDdMdjBLdFhwTGJvT3llNFNxWjVFbVNBazdtNGVtdFcxQTFm?=
 =?utf-8?B?bi9LRWNwQnlnaGZLcS9yZ096M3ZNNm9wb2pFcE1MYWV2V3R0REFCNUx0aXR5?=
 =?utf-8?B?QVZ5OGkxT3puQ3BsQXVaKytoNlNLclVoWjZ4bFR0cmdLWjB4cWRHTWJ0a1NK?=
 =?utf-8?B?d2x6S0k3eFdBdFA5THhvR3ZwTC8rb2VxNGhMdUJrY2l5VXdubkcxYzV1TWhq?=
 =?utf-8?B?UE5oMnJsWTZVenpick8wd21GMlZvVXdiVzhuNkpNZmFZMHNoQlB6M253Nmw1?=
 =?utf-8?B?YVhrVFFFbVVSV1owZm9HaWNxWDZEN3FZc1I5NGp4czJ1a1Qwa1FObXR2bkRQ?=
 =?utf-8?B?cTI2dmFMUVJnRmFQbVZla1hOaUlBQnY4enNaUXFwTk5pMVIwQjZqQjFmbWxx?=
 =?utf-8?B?ZmN6b2JhOGFBVW9zcDJoZXlKWGVSREhiV2lZdTZWLzJGZW1nYkZnVnZLZ1Fk?=
 =?utf-8?B?bjFENnZoenN6eGhlWVdTSVNPN3dOaWxQbjBJRmhDRnpoZjY4WUVHRmtnMzhj?=
 =?utf-8?B?bTVLRnlJTTkxZ2ZodURSUm81KzQvYW0zWnlKZ0tzbVg4Z01SeHBnVFdWMjZL?=
 =?utf-8?B?T0FGRWg4OEt3SEFhZHBXRzhoSXVnQXY5NTJnQnJHM0NtT2pVVGY4SndxZmdS?=
 =?utf-8?B?SHF3dDVyeFRoaWRKdDJ2TFMyVGhkRXhtbysvQTJaV0hmZGRERkpaeGxsN3lq?=
 =?utf-8?B?TGF6Ym9zQXJ1bEc4ZjVzZXpPdHF3NzBFREZ4Z0Y5MUQ0djFCZ3ZGZ1pYMmhm?=
 =?utf-8?B?ejJpRldNSXRoc0w0NGxnKzJ3aVNaUXRlOWs5eldLZmcwMk02NXhUYlJLcU45?=
 =?utf-8?B?VDJjc3BheHlyaklvemhBWmFHbjg1bHhFMjY5QlpiZXJwcVk5OXJQR05yS08z?=
 =?utf-8?B?Zy9xKzZJRDg4ZXp2b0pOdndsZEF5dUV6dDViS09RbWRmNmwrRXBYNjY4TUtv?=
 =?utf-8?B?M0VQaU1yU1RiVTg3eW5vOG9HYUJxdXlhano3UlZZb0dQU3BxdEI1Ui9jc1F0?=
 =?utf-8?B?U2RnSGxsMmF4WjdRaFRMRmluMFVsNDBJYzhyUWJYZnhRZlV6MGZGenN5U2xM?=
 =?utf-8?B?VjExZlZ1ZzZ4bGFLdlRiM1dhWkNaVXZSQzJjNHVLZkVicEszWlc3aDcwZm1O?=
 =?utf-8?B?OXB5YzdwQ09KSkxaVUhzL1pTcVVadDRqZ21nM2JGZXNqSzNhWmdTaW52S2Zr?=
 =?utf-8?B?QjlBdWVQNDF6UEh6UndaTDA0TEVOYnE1TERNNlo3b0FDOVFMdm1NWUhzQjRN?=
 =?utf-8?B?ZURpUzlwNzluOWV6S2pCVUF1RDhQTSs5R2wzSUNYajV3RHc4MnhCWDhBUGgr?=
 =?utf-8?B?QTEya0Z1bjR3d3pSNzE1ZENyVHlPelVmSVluOWJqcjA0dCtzS1gxc2MrOVJn?=
 =?utf-8?B?ampCc1dQZmJQYUtnZ2dTbzh4UXZTNTBKTXJWR085NmN6VzY2ZUU5K2J5NGhW?=
 =?utf-8?B?VlRZMjVSV3h4OU5WRnFnbFlwZmNhdm9kZlVCaTRWZEtCcThJeEYvVW1CcFZE?=
 =?utf-8?B?anpkcXpxTjdTOUFST3FldGtNUk10V1NsVGtDUm9JL0tUYUp4Znd4QnR2SWkz?=
 =?utf-8?Q?gS04=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(34020700016)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 18:09:42.4252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51852b37-5b28-46c8-f212-08de1c967e64
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997551
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

On 11/5/25 10:21 AM, Anshul Dalal wrote:
> Since the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
> with an extra Kconfig"), SPL_USE_TINY_PRINTF_POINTER_SUPPORT has been
> made mandatory in order to use %p which would earlier have defaulted to
> a 'long' print.
> 
> Without this config symbol, k3_sysfw_dfu_download fails to set the
> correct value for the DFU string with:
> 
>   sprintf(dfu_str, "sysfw.itb ram 0x%p 0x%x", addr,
>     CONFIG_K3_SYSFW_IMAGE_SIZE_MAX);
> 
> The value we get "sysfw.itb ram 0x? 0x41c29d40" causes a boot failure.
> 
> Therefore this patch sets SPL_USE_TINY_PRINTF_POINTER_SUPPORT for the
> usbdfu defconfig.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Not sure if a 'Fixes' tag is appropriate here since the commit
> 1e24e84db41a ("tiny-printf: Handle formatting of %p with an extra
> Kconfig") did cause a regression though I think the problem existed with
> the usage of "%p" with TINY_PRINTF set to begin with.

So I do think this fix is valid, but it would be nice to not have to fix
this in each defconfig that might fall into this trap. Instead is there
some way to bake this into the Kconfig logic so that when K3, DFU, and
USE_TINY_PRINTF are set, the SPL_USE_TINY_PRINTF_POINTER_SUPPORT symbol
is also set automatically?

Or better yet, since this looks to be specific to k3_sysfw_dfu_download()
using 0x%p in a place where USE_TINY might be enabled we could just switch
to using 0x%x with a cast there.

Although the best solution IMHO would be to fix 1e24e84db41a which
doesn't seem right to me. We used to have it so TINY_PRINTF would
simply fall though with %p and use the %x handling. The commit
does point out that %pa / %pap would be wrong but it doesn't actually
fix those anyway, just removes the ability for %p to work without
that new flag..

Andrew

> ---
> Changes in v2:
> - Remove unrelated changes
> - Link to v1: https://lore.kernel.org/r/20251105-am65_dfu_fix-v1-1-acc29111dccf@ti.com
> ---
>   configs/am65x_evm_r5_usbdfu_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
> index f9161f1fe111ff97f7aa79f10b21c3b0ab1dad32..add03dce002b2abd913770cd836d2cd8c852ed5e 100644
> --- a/configs/am65x_evm_r5_usbdfu_defconfig
> +++ b/configs/am65x_evm_r5_usbdfu_defconfig
> @@ -6,6 +6,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x57000
>   CONFIG_SPL_GPIO=y
>   CONFIG_SPL_LIBCOMMON_SUPPORT=y
>   CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SPL_USE_TINY_PRINTF_POINTER_SUPPORT=y
>   CONFIG_SOC_K3_AM654=y
>   CONFIG_K3_EARLY_CONS=y
>   CONFIG_TARGET_AM654_R5_EVM=y
> 
> ---
> base-commit: 1c250e444ad3b15315ee8b0fcb3fc3acc26449e2
> change-id: 20251105-am65_dfu_fix-1144eec06b19
> 
> Best regards,

