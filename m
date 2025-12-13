Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACB3D5AE41
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 14:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60885828A2;
	Sat, 13 Dec 2025 15:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YoMo+lwJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3F0583642; Sat, 13 Dec 2025 07:39:14 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 843C883045
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 07:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U44q6mIKWuBHuDCkE8/sxY65s6giSvkxlrWZYRNMWrkf8UFdxrJGvqvqUeQZ/x4UchXuEQbzNC/d+EzUKgX2UiAY57O6fNdpvjYyCuHlKei7tQSQGR+H+YWe2TJIdi3P8RzXRcG/Rf1XCM7XBCuvo7HyuEW9PX7OC/O0kGpj+VSUR2B6EdbDFIshm45VRvM/oK2U47hisAqUvWK1xw4HsTn2ziB4pFFCOcpuwr8TR+smAGgIpuVuWghUeG7e5OIG62Pwt9ReaHM8wasOCVuLVEDeO0ywFJ7hS7CjILreNpOc42Gj/U7yAdrg9T/19TE/RoUmF4qkKPV114PvsVVQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv4sr4sHYAOOz6zsfesBEgH3kKTRCIjXdNEA8/An30w=;
 b=TKdp9ImM4kpRf1gthmX4JwXSDP0MflZs6efNL/gPauftEFkDr/wRI+wOUZ48s3JiSzRYtricD9EmOIREhpXaJ+ECci3REW6stSrP1OHP/Ip0CUt8/TxN64CFN7k4ABDJeBAMZC1ZBYWgx/FNtyzp8iUh1kKZCv1MCWuUr+uXaE+RFH82le0vV7Ov8mH1T0cUTXi1INVtcI1D888jkVe0g+ymW+CJ24VvO12oDlbnEUyrYUSc94FoWWdF465SpPZbkOyj4qG94n+I7UP/wG9eH+lS9+dhS2e1cgWHFj5pBQ94hXtOh5YY1FP1LVjlhHRv45FWOGzHILb31FcHyH3CPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv4sr4sHYAOOz6zsfesBEgH3kKTRCIjXdNEA8/An30w=;
 b=YoMo+lwJutP+PLhCqezRBzMI7l0Q5a36deR9T7fQtkjrnJi1IoWaxJ3bxPPwLv51VMo03a6FLUz1ll4PONNRt8aSaBYG5Xvlz10GgI3euwsR9K2bDdaMbpZ1sYoQKGPKKed+04+MfLgJUdbkpMbz3g06dILHgmQm9tzka2Th3gA=
Received: from SA1P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::16)
 by IA1PR10MB6712.namprd10.prod.outlook.com (2603:10b6:208:42f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Sat, 13 Dec
 2025 06:39:08 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::f7) by SA1P222CA0012.outlook.office365.com
 (2603:10b6:806:22c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.11 via Frontend Transport; Sat,
 13 Dec 2025 06:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 13 Dec 2025 06:39:06 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:39:05 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:39:03 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 00:39:03 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD6crWs3324655;
 Sat, 13 Dec 2025 00:38:53 -0600
Message-ID: <c1d177f3-f7b1-411e-9a13-f4e5f81a0b28@ti.com>
Date: Sat, 13 Dec 2025 12:08:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/13] ram: k3-ddrss: Add support for DDR in
 self-refresh
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Kendall
 Willis" <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
 <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>, Moteen Shah
 <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow
 <e@freeshell.de>, Devarsh Thakkar <devarsht@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Jerome Forissier <jerome.forissier@linaro.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
 <20251210-topic-am62-ioddr-v2025-04-rc1-v7-4-f113b156f83f@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-4-f113b156f83f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA1PR10MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a238e2-37d6-41ff-f97a-08de3a12507b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1BmMkU3d215dHgxNjlhMTdRYjZkQWZ4c2RaWlo0emttUG0zS2RyZ0QvRHpT?=
 =?utf-8?B?emZXc3NxS1JMZUEzcXNsL1hVT2xrWklDaVNxZEJWWDRmREtEZnQyNEdPZ2Jo?=
 =?utf-8?B?b2FvRlcrRmhjYkZjdlE4blR6Wncxd0djd0dkaWxCSCs2LzVNeVpuV05EZTZ3?=
 =?utf-8?B?b1lSNi9kazJGWWd1TTFpZzFobnVqeUVjUXhqU043Z1ZvTHlRSERoUU1xR0ti?=
 =?utf-8?B?WWhqUVRsZExDWUxxVU14Q0FPS0NMclAxSy8yT25lQlZpMmVSdEtkOEYzSG8z?=
 =?utf-8?B?WkxWQ3FjU0UvL3FDUWxKRzBEblJGQnQ1TndaNkwva1NIRHJrcENmUUMwQWhw?=
 =?utf-8?B?TkZMMFZKTi82TzA3VGx4R0c1WXBEdDBDTFgzUHRYZkhXNitOL0JmNnBaWlBY?=
 =?utf-8?B?YnY3Vnc5SHhyRlUvMW1IaUQ1VFpWZGlXYzc4Q3hpWW1Vb3FQM1RtOVRLZUsz?=
 =?utf-8?B?aDNNWUVrdkZac2JxS1hQajZXZm4wMjVBOHcwcG5sSEFlUlhSQ2tyK3VLWEJr?=
 =?utf-8?B?akJkZy9OUm1pZkZJdkVtcUpBKzdjRUZhVm5TNUJ2WmE3VzlSMFJxTHNaak96?=
 =?utf-8?B?M3RYbGZneU5hQ2JSSTVBT1hKRnhhdXZKa2pQOUNNNWJmTVNRRVBrYWZMaVhD?=
 =?utf-8?B?bWRoUHlpWGJPeVFNakNTUTVvU0l5ZCt3RFpHUkhOWXoreUVpOGt4b3ZsWStN?=
 =?utf-8?B?a0RVdDJ5MHdYeU5qZG44Z1F0eDZFRFRnNDBBOGoyR0dEalRPdyttUUE3aWVN?=
 =?utf-8?B?NnFqc2hqVkI0MUVpRkFUV0FKNmsxZFRSaFl6d0kzS1g3RUkxTnAwQjJWWG1L?=
 =?utf-8?B?UTQ4N3R4Y2VVaE5mTXpld1lYamtORkhjMHJUM1lFSUxxdHlENVBpZDFSNGRZ?=
 =?utf-8?B?aHpDTUNxME1MdStPQ0NSM2ZJU0pySURZc2lUV0dnNlpod2huaTczK21tY2dr?=
 =?utf-8?B?dy9ZVkMwYklGTTlHU3F6NFRJdERwUnJjcFZ3bzE1V3p3SWo2cW9SOFB0bkMv?=
 =?utf-8?B?NjFVRGQxWkhIdjZHR3NCK2RUVTlBYVJna1p3SEpqaENLSk9VRzd1UDZQZ0k4?=
 =?utf-8?B?MW9PVUxSd3UwR3BjbnFreEtlYXJGZjh0QUJncGxxc25na2N5YjVXcXY3VllW?=
 =?utf-8?B?Z2kyZ0tKZkZqeUNNaVM1RTVzOGJRVmFZNXgyOEVnRTE4RTR0MFRrVWNpSytl?=
 =?utf-8?B?QTJvb29pelpYOVBpaFNySFYzWDhFWkZlaStpYmt0YXdmNnlERUc3cXZFSE1s?=
 =?utf-8?B?UmhKMytoL2doQVBWOUkvb2VQbWpKdzY4Vms3cmJ0OHdEY0c3MVh6YTRhZ0wy?=
 =?utf-8?B?dXorUk43aUZxdzJtSVBuTWptUVZmaHlkSXlYbFFYSEd2eDNUdkJ6ZE5FT3BC?=
 =?utf-8?B?ZVZVa2JVL1VKRDBBR2EvR2psdkhIRmJqTXhycFFxSjhwM1RIYkJ1aTgzRmVJ?=
 =?utf-8?B?dzB6Zmwrc3phZGJLR1VZYWNON3dOYmtTcnZEaU9BMFpEazJtNFBFU2NSckdT?=
 =?utf-8?B?dEE5cVRLbkpoTnUwRTlMSm4xWlZTYms3bDdleStJWnNmbkdqZTMrN1pZREZV?=
 =?utf-8?B?SnNLZ1ptZFZEQW9aQk1NM0tXd3VyOHhYRVVmTCtQZkV2Kys5Q1NLS2tPQW82?=
 =?utf-8?B?amhlYmptUTJZWENDZFdKOUNlczFmVVc0VUhNenRJY05qeGI5SU9TWUdGY0ZL?=
 =?utf-8?B?RUNxVnBjeVc2MWR5RExKeUFSaU52QVd5MzZsQkZSOVJ4d214Rm9uT3FaeUJH?=
 =?utf-8?B?dnVjZ2VZbUp6TkpWZmpBTkY4cm1QNUsyNndYZkpabWxMTklreEp3eGhCQlBr?=
 =?utf-8?B?NDZtNVM1eXZENGl6dDQ2SmdadGkyN3JMZ2NQQ2VxRisxMHVNbmg5SVBUSUxM?=
 =?utf-8?B?ZUo2SGpPTGpOczN1dVFCMk85QVpPeHl2RTdBa0RoWGcxRmdDZm91K0F2RmZZ?=
 =?utf-8?B?a3U2M2w2NExydzhEbXB4MzArQjM2V091eXZ0U0lTRndSR1U5UnhoOU5lZW9Q?=
 =?utf-8?B?WHBBUDhiSWQrRFRSSmpXM3FyaWwrRDBaOG0yc1pGby9GMWc4RkxXWVc4MGRl?=
 =?utf-8?B?cWNlWklkUkk5UEsvZDI0akhreSt0Ris0ZGV3Vi9TNTFUUCtrQ3NjcmpMVG5P?=
 =?utf-8?Q?qrek=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 06:39:06.6872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a238e2-37d6-41ff-f97a-08de3a12507b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6712
X-Mailman-Approved-At: Sat, 13 Dec 2025 15:04:07 +0100
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

Thanks for clean up Markus,

On 12/10/2025 7:38 PM, Markus Schneider-Pargmann (TI.com) wrote:
> In IO+DDR the DDR is kept in self-refresh while the SoC cores are
> powered off completely. During boot the normal initialization routine of
> DDR is slightly different to exit self-refresh and keep the DDR contents.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   drivers/ram/k3-ddrss/Makefile       |   1 +
>   drivers/ram/k3-ddrss/k3-ddrss-lpm.c | 175 ++++++++++++++++++++++++++++++++++++
>   drivers/ram/k3-ddrss/k3-ddrss-lpm.h |   9 ++
>   drivers/ram/k3-ddrss/k3-ddrss.c     |  16 ++++
>   4 files changed, 201 insertions(+)
>
> diff --git a/drivers/ram/k3-ddrss/Makefile b/drivers/ram/k3-ddrss/Makefile
> index 823d1887178174021778296e6626cadfd11170de..8a2ece1c27eeae51593467259337483a852f5f85 100644
> --- a/drivers/ram/k3-ddrss/Makefile
> +++ b/drivers/ram/k3-ddrss/Makefile
> @@ -4,6 +4,7 @@
>   #
>   
>   obj-$(CONFIG_K3_DDRSS) += k3-ddrss.o
> +obj-$(CONFIG_K3_DDRSS) += k3-ddrss-lpm.o
>   obj-$(CONFIG_K3_DDRSS) += lpddr4_obj_if.o
>   obj-$(CONFIG_K3_DDRSS) += lpddr4.o
>   ccflags-$(CONFIG_K3_DDRSS) += -Idrivers/ram/k3-ddrss/
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.c b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2556632df8806623118c72cca55cfbf370211ae0
> --- /dev/null
> +++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +


Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/

> +#include <asm/io.h>
> +#include <linux/compiler_types.h>
> +#include <linux/types.h>
> +#include <time.h>
> +#include <vsprintf.h>
> +#include <wait_bit.h>
> +
> [..]
> +	is_lpm_resume = k3_ddrss_wkup_conf_boot_is_resume();

Sorry, but repeating same thing k3_ddrss_wkup_conf_boot_is_resume could 
have different implementation for different SOCs

> +
> +	if (is_lpm_resume)
> +		dev_info(dev, "Detected IO+DDR resume\n");
> +
>   	ddrss->dev = dev;
>   	ret = k3_ddrss_power_on(ddrss);
>   	if (ret)
> @@ -895,12 +902,21 @@ static int k3_ddrss_probe(struct udevice *dev)
>   	k3_lpddr4_init(ddrss);
>   	k3_lpddr4_hardware_reg_init(ddrss);
>   
> +	if (is_lpm_resume)
> +		k3_ddrss_self_refresh_exit(ddrss->ddrss_ctl_cfg);
> +
>   	ret = k3_ddrss_init_freq(ddrss);
>   	if (ret)
>   		return ret;
>   
> +	if (is_lpm_resume)
> +		k3_ddrss_deassert_retention();
> +
>   	k3_lpddr4_start(ddrss);
>   
> +	if (is_lpm_resume)
> +		k3_ddrss_lpm_resume(ddrss->ddrss_ctl_cfg);
> +
>   	if (IS_ENABLED(CONFIG_K3_INLINE_ECC)) {
>   		if (!ddrss->ddrss_ss_cfg) {
>   			printf("%s: ss_cfg is required if ecc is enabled but not provided.",
>
