Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCEEE9A047
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 13:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 401B583D17;
	Wed, 18 Feb 2026 14:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Uhj2idGj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 870B583AC5; Wed, 18 Feb 2026 14:28:18 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10EB683A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 14:28:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ro2ucPAZ8dRqCICLAojeEIseUmmMrGnvo9WsWdxga3veHOx+WIhcis4OtdITuwqlYrel6LlMD+Us8LSpft+eLOMgBZ5vPuYDRsIj0w7rVkXAPp6gRx6mbaZzMrSZls4i4Uqkg3HO079ZIhnRTlYXJXtYlhyKng6hAZt7uzpV2etq8nFsWaX0jZGD58CQvv5kuMP6HaMeUSMhgTt4ZYSmFiw5NTLnHTqsrEqt8j/vZtFunJ2G20EP7AvVksExa0AoR0rbhlChFrDjdiEZuvtGbvjg4/HBwEtWp0gizwfc9dNNByfOA6ZUJpVeRmBQNu9+yfb5rHyBapdsRa4lclJzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALt9BcFwT414xgMGxhMbUPPorA4GYm+GmhJTkHSVzyA=;
 b=QTKiu5tX1XpJ3ANytMtmC91oQftiYXKjhPMyqFjskp3wyXaorHhx0rZD0y0C68KypTpqen8arZz/P0vUuG1yZ4yRR5hjHEaeSQFvMEJIKEf3vyO3v6f52QVIGnpmG/Qus0MY3UQsifgesHfxJoXEzribJtqYKgdnLU/tuAjhciOZ2zXJmczkKEZGZ07eYKvjiYlsbEW4pMFE24l9MqQQTpE/wSAOzVpkNIMoJxbo5xw7o6q3+ej5MjKFymXTHfqnfVTeS4wkl2JVX7Pzipbxg3fZNSmSqGwjuQjN/p2nC2Qd72d8ydYyaU6iNukvM0AvLm4l026ZtHWTPS0yK8GMcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALt9BcFwT414xgMGxhMbUPPorA4GYm+GmhJTkHSVzyA=;
 b=Uhj2idGjYoUnrrfq1G6JdXlEerw4Vg0ofODtGlf5LwNUUK+5yvzKzwueozWWb+jY0JjpuvfALigJTHsklHO0Ho/IXqz+llSi8AN4lir3311H7boqch939uBqkJaK1HLs60IF77BItaVw/1jD7INQ6QKZIa7ZuaNmBIlDBReOtzo=
Received: from SJ0PR13CA0164.namprd13.prod.outlook.com (2603:10b6:a03:2c7::19)
 by CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Wed, 18 Feb
 2026 13:28:13 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::45) by SJ0PR13CA0164.outlook.office365.com
 (2603:10b6:a03:2c7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 13:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 13:28:12 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 07:28:11 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 07:28:11 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 07:28:11 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61IDS5Fr902115;
 Wed, 18 Feb 2026 07:28:05 -0600
Message-ID: <405e1c7f-6cfb-47d4-9148-8876d47a2253@ti.com>
Date: Wed, 18 Feb 2026 18:58:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] arm: mach-k3: j784s4: Update SoC autogen data to
 enable PCIe boot
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <m-chawdhry@ti.com>, <c-vankar@ti.com>, <neil.armstrong@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <j-keerthy@ti.com>,
 <semen.protsenko@linaro.org>, <afd@ti.com>, <anshuld@ti.com>,
 <peng.fan@nxp.com>, <ahalaney@redhat.com>, <mkorpershoek@kernel.org>,
 <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
 <20260216102858.2745657-2-s-vadapalli@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260216102858.2745657-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|CO1PR10MB4722:EE_
X-MS-Office365-Filtering-Correlation-Id: 744273e4-f73c-495b-a605-08de6ef19065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|921020|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZS9JSmFCWlF0YjBiRGtxb2xGM0VZdmpkSlh6dlpoeXdGMlljK0I0dlJ0RVZG?=
 =?utf-8?B?UHp6Y2Z6Z3BHRnRuRG0zV1pRckcvdDl4VXQ4SWdmTnNqa2JSVm9SMi9FNzhG?=
 =?utf-8?B?KzZHd1RkeC9idDBHYW5OaUhVTncxV0tjRmh6MkJUR3FxL2w2a2hXQnNFOVRI?=
 =?utf-8?B?bE5zUHpYb0g4VnB5dFBXZHc0NU1mak5XSCtZcXhkam9acXdhMzJ2ZllmUUNJ?=
 =?utf-8?B?bGpCU1VvM0ZPN0hwMkJRL3diOURHT25oNUhLQkNNS1RtVXdoTTJyVTZmdU1D?=
 =?utf-8?B?dWFZSTZtY1JMUmlLOW9leGlqaVByNzR0ampwMnRTZ05CZFJJMWRHUXZ4NVJr?=
 =?utf-8?B?OFNjcDR5NXlpaDN4djV6REVPZkxLblJESElXL09wcjlXbFYzV3RwWEpsYVU3?=
 =?utf-8?B?cWVtR283SkRqTmlWY3M3ZEkybTIvM2pkVTFCSXZrMzlUWXhrUENVQTc3Y0pI?=
 =?utf-8?B?V0tiNjFsSGJkUkJySTJ6TXZYQXU2MVZpMjlYMUtCOThsZTN2amdxT2hPSXNk?=
 =?utf-8?B?R3ROQUV2UFR2WmhITWRtYnJzZElpT3BQelRLU3pQVkxXQkFuVFhEcmMrYUpj?=
 =?utf-8?B?aHFXTFMxejFQUHlwN2dDakwyVlZMRVc3QWNYSTFHZm9LSUFnOEJGL09PVTFh?=
 =?utf-8?B?YzlsZmwxK1RHZHFTUE02STEwdWk0bTBKYy9pY1ZFbjljNGVzN2ZOMHJWN3lo?=
 =?utf-8?B?V2ViRFBEcFJnZzhmOUtOeXZrNmhaVEY1d3A3TkdpUm90Zkl1K043L1BsckM1?=
 =?utf-8?B?cWJiNG1pZU5BbjRKUE5NN2dHbWlneEUxYWNlaWdRSjVhN2xLK1lQYXU5T0Q3?=
 =?utf-8?B?NFZyWXhIZkFya2ZWb2ZuSzRZcWtqRVBpVVcvU3VUNHk1U2FGSEJhYkhzQkdW?=
 =?utf-8?B?VENaZW1ZeGNoaVl1OEZPbXVteGNJQTlyRDQwNW5pdkxabzViQTA2OEtaWml0?=
 =?utf-8?B?TnVGNzlTdmlhQzhsVWpTR2Y5VUoxeFRSYlFsQkJBRGY4WCtSczFiWjF2alov?=
 =?utf-8?B?UExOMVh0cjlUVkxHZU9WaWNsTkRBc0RqK2lPd29GeGpEQlNyY2d2SkdyMUhP?=
 =?utf-8?B?RjI0VGRWZkxvaTg5M3hxM0RxNGhKWWNOVCtxaW1RNVUvbng3MU8xcEp3cDdU?=
 =?utf-8?B?ZTI1MkFQMGdzUlJyYTJiSkFPMXlNS2tWVnNNVjN1QVVwakJpaDcydC9MV3RY?=
 =?utf-8?B?M2JOc1ZuNlhSRnp2ZjRHeGhnYzd6ZHBhWnJxcUg1MWFLR1ZNVzZtMXNhWm5R?=
 =?utf-8?B?WkNkWEJtYWRsQjE0MnIzVzhBZFZmbDc4ZXhnNmpMN255VFcwejk1WUJQSmtI?=
 =?utf-8?B?NFNMUUxEck83RzRTR3BnSFA1R0ZmL2ZPWDF2a1ZrVFo0TC9YVnBIa09YRW1v?=
 =?utf-8?B?Tk1ZSG1rcUdhYVlNeWM2T01qM05qcEJtbk5LeVpYcUs5TWVpKzQzNHJNN0J6?=
 =?utf-8?B?MWwwRE1TSmhHY1JCVURwYS9tdTh1SFBuUXlPZ29qcVVkN096TGNZSG53ZUJn?=
 =?utf-8?B?YW5NTGthUHBzVDBvWjJhWmk3Y002bzRpSTN0bWtRcTlubzlDS2lNemJrRWdP?=
 =?utf-8?B?VWJUak1kK01TeHNqNTRkQSsvdS92VHJjcXByQ1MxaGovYXR3U2JrRCtvMVdm?=
 =?utf-8?B?MDNPdkJiMG5pYTU4ZGVlTWZrTUxZTEcxRElCS2RheFF3OUNybDIyc2pSVTkv?=
 =?utf-8?B?c210VWlZWG1MQjB1aERFMGhVZWZtdDgrUWU0MU9laGRkT2ZYdjRmT1lVMUlL?=
 =?utf-8?B?bDlwU0pwNHNyM3RaZTFid2hrbFIyYitNL0tUNnZ4VkVCWHAvL0ZsSThVcncv?=
 =?utf-8?B?djI3KytHSkc3UmYrQWxLenZNeFZsR2EyOUMyVy9PcmtqQW5TRVM0UGZIN3Ev?=
 =?utf-8?B?WWZJMEx3YW0rNWZnK28xWXNIODZ1SjNDclRIR3RBaXFxdk0vWXN0TkFZRHNZ?=
 =?utf-8?B?NHlqdnJocDg1SEdQdU9sRUJRc0tFSWEycnZnY0hRb2VKYm1XcEN6MDlSaWM5?=
 =?utf-8?B?L3dpL1FVSTVxVUxhKzA0eGhvdm5aMDZvTGVoNFFFSGpvSXhRTkJMUkZLdGtE?=
 =?utf-8?B?b1JVcXBVS1Z5cTY3Z0VqenZSa0plMmVuRkIvbk1UV1J4N1dUNlhOcGxZNDhQ?=
 =?utf-8?B?bzFLUTBGWkJPUU1IVkRUYVh1UE9SMVkxME5yN3RweldCL3BCU1dqNDNKWVYx?=
 =?utf-8?Q?CDjFe8sUSNtrP2FVX0MUYxM=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(921020)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qb8fln07uFFaG+BESZrLjJ3UiwsZttBThAc/pX0momFe+aqH1zNAZ8aDPaGARcCJYbQ+QV/U+sHLlKi6cJv5Uviaogfzj9/zEiczMrUNJIp6iGgdHXBHXdMffYiU9lsLtO5mntfBjGKgSRhBw2fPjESmpjGIdaTmyATNEEGy/s4fiD6yMqyDzxEbaJ3mQP8NG49l5cchx3k5a2dxNtL3iw/X2C8ZGh/Wdafl5gde3BEGkPwCGcerQXjWKu89W6aOdskzwWrX2cnK3VKuudDz3S2Df6cZcGXKj7aBOaIE55fLXVqFwAsK9VzEyTiNCoupeT6s5q5k0zpr98hA4nFoPVWN4dhPOE9pHanyhbOEyWBi8XrG+8TKzPaqe0xiquxY+Tto9R7gJKoc9Awr6j3dA9HYFDSLw2T5HyOiNYulDewcyC+TYZH8Ke0alPlxjn/a
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 13:28:12.0671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 744273e4-f73c-495b-a605-08de6ef19065
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4722
X-Mailman-Approved-At: Wed, 18 Feb 2026 14:32:16 +0100
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


On 2/16/2026 3:58 PM, Siddharth Vadapalli wrote:
> From: Hrushikesh Salunke <h-salunke@ti.com>
>
> To enable PCIe boot on J784S4 SoC SERDES0 and PCIE1 should be enabled
> and configured at the R5 stage. Add the required clk-data and dev-data
> for SERDES0 and PCIE1.
>
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>   arch/arm/mach-k3/r5/j784s4/clk-data.c | 184 ++++++++++++++++++++++++--
>   arch/arm/mach-k3/r5/j784s4/dev-data.c |  45 ++++---
>   2 files changed, 201 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm/mach-k3/r5/j784s4/clk-data.c b/arch/arm/mach-k3/r5/j784s4/clk-data.c
> index 24780eb6562..228b424d3f2 100644
> --- a/arch/arm/mach-k3/r5/j784s4/clk-data.c
> +++ b/arch/arm/mach-k3/r5/j784s4/clk-data.c
> @@ -5,7 +5,7 @@
>    * This file is auto generated. Please do not hand edit and report any issues
>    * to Bryan Brattlof <bb@ti.com>.
>    *
> - * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2020-2026 Texas Instruments Incorporated - https://www.ti.com/
>    */

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   
>   #include <linux/clk-provider.h>
> [..]
