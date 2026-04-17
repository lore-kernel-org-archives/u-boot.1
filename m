Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891EBF8E499
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 04:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1BF83FC0;
	Fri, 17 Apr 2026 06:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="db5DLq56";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF6883BC8; Fri, 17 Apr 2026 06:00:27 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E35683FC0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 06:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfw2iAm7PzLggoEpvKdK6KGR873+9mRnd7+iP66eTdylEGTaKGvsQ+RJMvYBB6ayuGbvfhedBYWOYcu2HF//Z7eyCWBZhEcvr4mdfQ+DSIW+yyUUUP1kAUAZk4BDXoLXMhm/7u3wrh7CdHQPV1FMLgDNLRhJZDPs/7hezI52L+MhcnsTxoBX28nMSq8ZMz0XsE3F0yCQmOJ2ofXZCoEndossjXcG5qKj/vPmsRAk2cUqh58HOiPe1ia0f3yO/dz6dK61muN2t7U2hOWqrWkzmpDD4FSOMXP6Alsl2FFWvhOxMPvoNb0tqlHIkdIYSGSw9187mE38RdQ+GoS79kqrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSqyOfCij/0lBuYk63BNHSKK8X9d/JZ3IkkMlmRGOVo=;
 b=c6HzpngDQ5yUWf4ftSZdok1fKktitFSSNCgsoMwnk3mMfGZW/Ejvm1wRp4HRNIFbpCEq9C7wzKmx4vUGyKr5MRdnrd9I9WyyBkHqc/47YCZwpWzRJehoAdtRtjlpVlijn1/J4jgxDyXMoPytNfzDIVMnjITc1BXvPzHjXCUHGf6fv/tYnS5Wk2kgNWV+puwAs7LVAPn+KpUxRTshA7z1Gfaa177JxoYunYy4WmvcZ9avGJNAOegr5dpstKXUHYtMEl9FxdXZdxRncI+kuCEDYo0xHDVrxy8FiuWg/RGlJLokDNxxqov4BA7NaDqU0yL6LIi+yMdH/C9SV1ikZHS1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSqyOfCij/0lBuYk63BNHSKK8X9d/JZ3IkkMlmRGOVo=;
 b=db5DLq56epvkMLiNNJMlf/TC0SRShhN0qhH9yRi4yY9e2fdwOjt0K9+pGF5Bmh93ChVgxGLXcTY6e1mZF9KXABYrpwk2HuKXwNmlmbxwic3deN8qG+UoIPcOpNOPpz48wwUSkRWP8sIL4tBumxtYdN9QQC7tQA/feivNvczKLOCH9IIuzjkCWesycShbmNwj51IQpXOavuR8w/kbh4MoJGHhZ1ZMY3hmjYS3q7I5zkM704qwf+T3xUI3TyoTNdkyQzOQc2f1BABVcbB/uCIQiLO85fgXwgI+rUl+0os7XFrprSToHpecSJY41P2PKnJjmVT6AhWnF9KdV7KT1Rztiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH1PR03MB8142.namprd03.prod.outlook.com (2603:10b6:610:2b1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Fri, 17 Apr
 2026 04:00:19 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 04:00:19 +0000
Message-ID: <b91b4abc-c060-44fb-b99e-a3ac6f12aed0@altera.com>
Date: Fri, 17 Apr 2026 12:00:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: Add fitImage for SPL programs periph RBF
 only
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
References: <20260311050319.24941-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260311050319.24941-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CH1PR03MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7a6fc2-42ac-4813-6962-08de9c35d6e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: /oGiMvR61x4xqwLf04J9PSYmmpgGtY4mm3S7W26Cy3PLCVIHCOQ35Q1TrXLNUpfGKEg6JorWpNakV+9o2EWiazES2kFnmmxX3WUz0XnwU2SwYYx8wuFv2FbtJW6/X6FuKR1lrYTygwJQPPRH+tbpWSJHXWxM3jIpx2eG2aFRd8YJ1oF7kvBRYk4asZSfZiIORg3KgPv+WdYMz2UFPcVpXXSj89Kless+EFeQxW5vItWdmAFMFI5ThQcPTzKwPu2gsc0R3W2q/yOqBVUZUhVF3iNfp3Qzufi8OdbVrg6keiKUUV480VpdzkkENj/kCNI6KeFFYFPY43qLYLjYxMWrmb7culPtQjMwb8ZAP/ulwLS7NYa7pt44bXbP2xqJcpr6WphFkS1RDwDPm5uyINh+aiNJbiqqrerC8QIM42aq1ZCIshBH2YI3CSWWHZuodOeuQkvLgQq2kfAz5WKXrxNGcCCwpW+CheccLTjFMvgDrmcr8gnE22M0dQGJMPQuYD4uvVXOmp/MfJXO099xbDIVWPnQQpZtCfcZQxDkUEkCeBi10zKg0eu30UbPa/caP0CD+LqaRMPLYK19677vCrUqZBk/JnKnCmRSI+D1ZiBYcHnB4+exOmqlzn2OrGwgHTLKdkyMITyEsVb25ioM0/tTphqvbBm1iZ68FoDgdZSbuHZQztqHmQ94zqGIrktZ/0xv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1Q5S1o5YldNTmVTbC9tVEEwMERzN0Rzd085MnlQcG1JY1BteEI2ZHdOSThV?=
 =?utf-8?B?cTBwaDFYUDE3UEl1TStuMnB4a0g2b09wR3B2Y0hTTE5jUU4xVlpHRytUZVZC?=
 =?utf-8?B?SnZOQ3N1LzAyTWVLalFGOUhOWGZFQ3NqcW56cndnYzE0c0R6Nlo2RzJRTlI0?=
 =?utf-8?B?T09GSHI2RjFBSDVscUJhSHgvTEZSZ25ZQ0dXMlk5QW0zV0ZIRmtaSGV1aEJQ?=
 =?utf-8?B?VzhSamlKZ3FWUkRmN0VUaXMxWVpUSUdhSEZ4WVBHTnFJRjB4dFBadHJnVE5o?=
 =?utf-8?B?TlFDSVpkdVZjRWliZDdrMDg5dnNGTmtvNVE0azRhQ0xqcmIrTi9QSnU2dzJt?=
 =?utf-8?B?YjBXTDZXa1ZKcVZGY3hicitteWdIN0ZhR1puZjFBVmk4cFFHQjlWNE5Db1Y5?=
 =?utf-8?B?OE4xYm1IN1g1SzZZdFpIajhCMDh2OHFkZVJBRHJHZHZHZzZ0MDZ2OGlaR0FX?=
 =?utf-8?B?eEpEdCt2TG12TWM3cUoxcnFZQytFcXIzUVB0dTZTV01OVVYrb0JQcmU4Ymxw?=
 =?utf-8?B?enZwWUQ5ZVVlMmcwSHNVdHV1MUNGUDMzZHNHdlhjMlFyY3I0dk85SzNWQkdU?=
 =?utf-8?B?YXF1OGxXNXdqK2k0TEN5bk4xSE9vQVVOMUdVZmE5VW1kcDFRNlNabTVkajVP?=
 =?utf-8?B?RzJMeG9zWklZekgwclNpUlVqckJ2UmZWeXNScm5BbVpjakNXSkRGUHc3V1BD?=
 =?utf-8?B?VzJZby9jUzM4Z0xlOGxGMDNLSk8xcTE4czFXNmQ2encyY2lmcWdDenNoUFox?=
 =?utf-8?B?K2xYYzJZR2ZsTExjNEVwRkt1OFVaS25Gcm5FM2RxVWx1K1lvQ0kxTnpWMVY0?=
 =?utf-8?B?ZmxIRkRhVlAyTnBDRmpGbjF4eDVHYUpGaEtXbWRvbHltVlZCSUpxRm52NzlM?=
 =?utf-8?B?TGw4d0NRWDkwVHlacGJIMWMzYUNYTXFyamI5NER6UGZVT0YzL0cydlZIakpw?=
 =?utf-8?B?cHZiejFWTWVBNzVIaVJHbFNzRjBEd29iYU5lYzZsUmJYZGZmSWVJNUFhMHcy?=
 =?utf-8?B?QlladXoxYXhhQlF5b0hIT3hQSTJJcjVDOUZYQzQ1aDM3c0l0SDdpcWZ3TFZ5?=
 =?utf-8?B?NFRQOVdLcmgvZVlrSG4rNEJvL3l5OFdCRkxtME5mTXZLdkxoMU5hbkZlWkZ3?=
 =?utf-8?B?elEzZVRxOUwrNFhXQnNOQkc0dDUwY25nTVlDTHBVYkFaeEVMNEpBd21kSk1r?=
 =?utf-8?B?a1dpd0VlK1k4Vlc1aFk2eCsySGUvdW5RWGl0dE5YOFo3RW1JTkgwNUQ5emJY?=
 =?utf-8?B?TWlnVVNmQnZaL3ZGajhnbzJsZlZtQTJzZGo0WVhmWVdoZ2NPQlJlcUVPdXpW?=
 =?utf-8?B?enZITmhiakVUK2pVVzFlcXJnbjcvMmlYMUtBb2R4TWNOck1mOTQrbmtIdTVl?=
 =?utf-8?B?TW80ejVqOXA5dTN1QWQzYVFWZjRIbjRFeG9xdTFPR0tLU3B6RVdEUWIzNGhO?=
 =?utf-8?B?UlpXSC9mRGZ4c0ptQW5NbElUUnZJMGJTYkYzMXQzbzBSRTBTbmw5ZWM4RGxX?=
 =?utf-8?B?MUlWeWFvWlBVSjgrYW1kTEJySjB3QXhvaml6ZlprVGdnd0ZFcFNIVzhrbGJR?=
 =?utf-8?B?QnBIZnc4WHZZZk1WekVKbHAyKy9GL3BKNENQOW9kWEZYcmFQN1E4Nms5NElR?=
 =?utf-8?B?VzJadmMvZktBd3lNLzZGM3haeG1oK3NTaHRCNkE5RmF6QkdpNXRCRVhQWXg4?=
 =?utf-8?B?U1VYZ1Y1ZzBCMTd1NzhxR3hHbDE2WHlSalhlL3E5MWpjdEJRQnZ2dnUrT3Fx?=
 =?utf-8?B?cjBrdzNjU0VzbUlkR2NaUXBNb1ZSbko5NURmenFHWlYvZmI5VXo4ODZRdGsw?=
 =?utf-8?B?WkFIVEhyWjJlT25FT0o2clV2S0xSeVZPc1VxOEJyMUtVN0doTVFZaWVwQkxm?=
 =?utf-8?B?Mk02Y1puNmZzb3g0TzV4MlJHNTJ1Qk9XaXlkNm05dHhnMUVGZU1MbXZLQWtT?=
 =?utf-8?B?Y1pLbkV1NHRKYVB2Nm4wYWdvdjBBWmg3NkpTcmFGcjhXL09sS3lKWUlzd2h2?=
 =?utf-8?B?dkJlMERhU0RBQURGeG1Ld3BSZEdpdkh6bTlkSGlib25aNmZEK2d4VG9TM0Vr?=
 =?utf-8?B?Vk9NRU1QbUxUYmhtOEhmL002YnVGa2xVV2xPbUtja2VXQTM3TkJIZFN5R09S?=
 =?utf-8?B?V2Z1Q3hNNzM4VHBBQ0JCNkRSd1MvWXp2SkR3NEdOcGdvZ3pPQWRselV0VkJG?=
 =?utf-8?B?bkgvV29BZStLWEhTWFZpMWVROWljYUJFUmRERkhGT2dTV3ZkNExPeU5iRXN1?=
 =?utf-8?B?RGhSODU5M0Z4aS9PUjMvWXA0SEdUMEk0cUNmNEFoY0NwcjhsRWJLd2RoWURt?=
 =?utf-8?B?dHRqVGpkTHlvNlA4UVdMZjFIU0xxZjVZV25DaFk0WnBhZWNwMkRqUzh5RzAw?=
 =?utf-8?Q?MPIluNJpyZi40Bio=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7a6fc2-42ac-4813-6962-08de9c35d6e3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 04:00:19.1412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWiou8hCKXsfgyVCkhlTdqlAr4TL/PZzlQR21ZgylHnRFIpqH2Y5xMFTolt0F84GGHPS+FvWGUkvy9VMU9gk2CLSVDa++dp4EkJaSQ41Zkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR03MB8142
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

Hi DInesh,


On 11/3/2026 1:03 pm, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> This is fitImage for programming peripheral RBF only in SPL, so that user
> has option to program core RBF in U-Boot proper. The advantage of
> programming core RBF in U-Boot proper especially for SDMMC boot the
> performance can be increased up to around 90%, because program core RBF


Please clarify what “~90%” is relative to (e.g. core programming time, 
total SPL time, etc.).

> in SPL hitting penalty on alignment issue in common FAT driver.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   .../fit_spl_fpga_periph_only.its              | 38 +++++++++++++++++++
>   configs/socfpga_arria10_defconfig             |  2 +-
>   include/configs/socfpga_common.h              |  2 +
>   3 files changed, 41 insertions(+), 1 deletion(-)
>   create mode 100644 board/altera/arria10-socdk/fit_spl_fpga_periph_only.its
>
> diff --git a/board/altera/arria10-socdk/fit_spl_fpga_periph_only.its b/board/altera/arria10-socdk/fit_spl_fpga_periph_only.its
> new file mode 100644
> index 00000000000..06ba0328477


Documentation: 
https://github.com/u-boot/u-boot/blob/master/doc/device-tree-bindings/fpga/altera-socfpga-a10-fpga-mgr.txt

still describe a single fit_spl_fpga.itb built from fit_spl_fpga.its.

Please document the two-stage flow: which ITS produces which ITB,what 
must be placed on the boot medium,

and what SPL vs U-Boot proper load.


> --- /dev/null
> +++ b/board/altera/arria10-socdk/fit_spl_fpga_periph_only.its
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> + /*

  Comment block formatting after the SPDX line: avoid the stray space 
before /* for consistency with common U-Boot style


> + * Copyright (C) 2020 Intel Corporation <www.intel.com>

Copyright year on the new file: align with current practice for new 
contributions.


> + *
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +	description = "FIT image with FPGA bistream";

description = "FIT image with FPGA bistream"; — typo: bitstream (same 
typo exists in fit_spl_fpga.its; fixing the new file at minimum would 
help).


> +	#address-cells = <1>;
> +
> +	images {
> +		fpga-periph-1 {
> +			description = "FPGA peripheral bitstream";
> +			data = /incbin/("../../../ghrd_10as066n2.periph.rbf");
> +			type = "fpga";
> +			arch = "arm";
> +			compression = "none";
> +		};
> +
> +		fpga-core-1 {
> +			description = "FPGA core bitstream";
> +			data = /incbin/("../../../ghrd_10as066n2.core.rbf");
> +			type = "fpga";
> +			arch = "arm";
> +			compression = "none";
> +		};
> +	};
> +
> +	configurations {
> +		default = "config-1";
> +		config-1 {
> +			description = "Boot with FPGA early IO release config";
> +			fpga = "fpga-periph-1";
> +		};
> +	};
> +};
> diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
> index b32f40ae408..1648e4bda4b 100644
> --- a/configs/socfpga_arria10_defconfig
> +++ b/configs/socfpga_arria10_defconfig
> @@ -20,7 +20,7 @@ CONFIG_SPL_FIT=y
>   CONFIG_DISTRO_DEFAULTS=y
>   CONFIG_USE_BOOTARGS=y
>   CONFIG_BOOTARGS="console=ttyS0,115200"
> -# CONFIG_USE_BOOTCOMMAND is not set
> +CONFIG_BOOTCOMMAND="run fatscript;run prog_core;bridge enable;run distro_bootcmd"


Changing from “no default bootcommand” to run fatscript; run prog_core; 
bridge enable; run distro_bootcmd
is a strong default for all users of socfpga_arria10_defconfig.

It assumes MMC, FAT, optional u-boot.scr, fit_spl_fpga.itb on the card, 
and a

sensible ordering with bridge enable after FPGA steps.

Users booting from QSPI/NAND or without those files may get surprising 
behavior.

You can opt-in FPGA chain + clearer prog_core in 
socfpga_arria10_socdk.h, see the example in next comment.


>   CONFIG_DEFAULT_FDT_FILE="socfpga_arria10_socdk_sdmmc.dtb"
>   CONFIG_SYS_CONSOLE_IS_IN_ENV=y
>   CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
> diff --git a/include/configs/socfpga_common.h b/include/configs/socfpga_common.h
> index 2acfdc7df4a..2c01bf9d9fa 100644
> --- a/include/configs/socfpga_common.h
> +++ b/include/configs/socfpga_common.h
> @@ -154,6 +154,8 @@
>   	"pxefile_addr_r=0x02200000\0" \
>   	"ramdisk_addr_r=0x02300000\0" \
>   	"socfpga_legacy_reset_compat=1\0" \
> +	"prog_core=if load mmc 0:1 ${loadaddr} fit_spl_fpga.itb;" \
> +		"then fpga loadmk 0 ${loadaddr}:fpga-core-1; fi\0" \

prog_core must not live in socfpga_common.h for all SoCFPGA boards. 
Please move this to socfpga_arria10_socdk.h

You can replace above with macro SOCFPGA_BOARD_ENV_APPEND. And define 
the macro in socfpga_arria10_socdk.h

/*
   * SD/MMC boot uses CFG_EXTRA_ENV_SETTINGS from socfpga_common.h; append
   * Arria 10 SOCdk-only variables here so other SoCFPGA boards are 
unaffected.
   *
   * Default CONFIG_BOOTCOMMAND stays "run distro_bootcmd" (no MMC/FAT/FIT
   * assumptions at autoboot). For two-stage FPGA (script, core 
bitstream, bridges,
   * then distro), run: bootcmd_fpga_mmc
   *   e.g. setenv bootcmd "run bootcmd_fpga_mmc"; saveenv
   * or invoke that from u-boot.scr.
   */
#if !defined(CONFIG_QSPI_BOOT) && !defined(CONFIG_NAND_BOOT)
#define SOCFPGA_BOARD_ENV_APPEND                        \
     "prog_core=if load mmc 0:1 ${loadaddr} fit_spl_fpga.itb; then "    \
         "if fpga loadmk 0 ${loadaddr}:fpga-core-1; then "        \
         "echo prog_core: ok; "                        \
         "else echo prog_core: fpga_loadmk_failed; fi; " \
         "else echo prog_core: fit_load_failed; fi\0"            \
     "bootcmd_fpga_mmc=run fatscript; run prog_core; bridge enable; "    \
         "run distro_bootcmd\0"
#endif


Best regards,

Tien Fong

