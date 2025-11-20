Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66B3CFA466
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 02:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BED883734;
	Fri, 21 Nov 2025 03:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PcJIpN0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E6948405F; Thu, 20 Nov 2025 23:28:46 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26ED883734
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 23:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=k-willis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TN0mp7HtSAcunPCfPKT22l41t5R5MidGK07AfUUNmGfMDSspRxON2KW9Ubwes/v5e2+6+WmTlZjdn7iJqxrDnhOjr0Rb1feB6XR3h9C+ykPTWvJt13RNX02OBQWPpED4VZRsuyVFAx2c0y7+vyD0X9T8n4U/pNo7fB1Ml7RqpP0tBTrfZE8TZ0jF5JONKkCDHz/ad7oQwdwc25ef9Z3zdlLwFZqYvB+60mkalG6CaZxof1T/YFsftZuTs3/9htkVe1s8BgYC/2y3g2fyTT5MvMUPxBigsOQ533vWuAEf6Pj3PuyfEp+2XbK4wlJQY18YpUZf3jfzdUv7VZx2fxf3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvfjNWmNJnv0WdSHiPfb4gx1omzAa6cB/LIIYPj/RAU=;
 b=SucLqNqofGI9dZLRuVFTKoXm2ob1JTMpWo7y3UMxfCBO2MJUj0uR+M8GJT4FZAD+E2vXJ8GnT5D8ihtQLBQNy0eAszWwQw0Y3M+2M6A/8fjS+ke6XAReTnaJ8aA+0pJL7ZC6zvPyNUJ70coVBm4Vm4CavvNM/P/jBVayZ+tH13xsFmPHZgiBtOViXpoKwGbqdLUOASqdA2Tm0laLOYvlLUyU3ZgTE+O//5YuL2IJII9OcKcD38oQ6NL+4GA70UwYy2N5VSAb7TMhG7QEcEJF/9fh88I8FB/Ge6bXbIceQMPAlcnvcVgcaEjgZJZuIEmxUYDTORgrO8Fw1RPZCNU/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvfjNWmNJnv0WdSHiPfb4gx1omzAa6cB/LIIYPj/RAU=;
 b=PcJIpN0jTpdjDEjvVwjHPcOYOO5hg2IaqWx8vjKiQePHBU8vxoO2ird7vZbbpO5b2d2gVjYyyR/svx2HKyJaRi2V5WiYsksifurCFCHIrYo1nZclgb191h1AJqRul1pOa0lbQjW7CUzOX1K9etq/uWs54rjmSXvK6ON8rjH08wM=
Received: from BN8PR04CA0056.namprd04.prod.outlook.com (2603:10b6:408:d4::30)
 by BN0PR10MB5077.namprd10.prod.outlook.com (2603:10b6:408:12e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 22:28:41 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::21) by BN8PR04CA0056.outlook.office365.com
 (2603:10b6:408:d4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 22:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Thu, 20 Nov 2025 22:28:38 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 16:28:38 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 16:28:33 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 16:28:33 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AKMSXCh180356;
 Thu, 20 Nov 2025 16:28:33 -0600
Message-ID: <9c9bd24a-a8c1-47d6-ac5e-1cb006aa9aae@ti.com>
Date: Thu, 20 Nov 2025 16:28:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/13] configs: am62p_evm_r5_defconfig: Enable IODDR
 resume support
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Akashdeep
 Kaur" <a-kaur@ti.com>, <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, Devarsh Thakkar
 <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Andre Przywara
 <andre.przywara@arm.com>, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-13-6dd99a7271bb@baylibre.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-13-6dd99a7271bb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|BN0PR10MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: d651dba3-0d71-429c-39ad-08de288426f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am93N2JVY05pTUZpUzdQeGtLcnA5cXIzMVRUUmhhYi9XdmhPQi9QVThDUDNH?=
 =?utf-8?B?USs1bmNoTnR0VGN6YmJyeFI4dTJPeTBhZWxheEcvK2t5bFFnZFY0UFNqMWpp?=
 =?utf-8?B?YnBZUm9Yb1dwbkNiOC9mSXY4YUt3cTZrQ1MvQU9sZFNsNkVHVXZJM0htNVhP?=
 =?utf-8?B?b0dnU3NlZWxGdTZOZDZ2QnlPV25hZTY1Z1l1VkJvdkl4S3J4L1NoT0VVeEox?=
 =?utf-8?B?dit2WkNVei9kQWk5c1dhbDNmcE1Rb0pVU3lWd2h2STltb0FTRk1sdU1WdWdv?=
 =?utf-8?B?bU1wQzEwQmdjM1FtbnVKK1FVV0tQSGt1YndZdzBVaWRJc05YOE9rWXFMalZm?=
 =?utf-8?B?ZjNwZy9MSURxQjEzT05uWjJsaUJZS01sY2o2b3FFMit2b1dJOUE5cnBYd1V1?=
 =?utf-8?B?WHJIVzJmNnVFeHllTVEzaytSaUJ0QlhNUzU1ZWhuZEFvWU4yZlVtSkVFeUFD?=
 =?utf-8?B?cGxaV1VIeStyNzJRV01aQWs1QzE0YnZpcmo2T1QwRnE3TkpZd1VWWmlScGIy?=
 =?utf-8?B?Z0ZyZjRJRlZsOGlhblNPN3pScStFcWFNOWl5aElqYUxJSGlzS1ZDZWVCQTk3?=
 =?utf-8?B?TDNCSTNGVWVCZHdSdHB6V3V4VWpxTnFZcWUyRU9OTDg3bm9MaTlDZ0JOckNM?=
 =?utf-8?B?S1hQOGNaQ3hsWno4ZmJ6QlNjMTF0eWlGRWZFcmdjYUZ1L1BTa2JJWFZxZWVY?=
 =?utf-8?B?dmtDbEV0eGZ2cXVZbUgrY0h4S3FsWG1jM0hHVnZnRGdRVXIzN1pYaTIwRDdl?=
 =?utf-8?B?YkxWK3lUT2FKYlRQVWw5WWFGZkRWYURYZFNoVExNcEpjTi9NYS9GbjZxWUds?=
 =?utf-8?B?SmFZV1M3ZmpLeXQ2RjQwWTB3S1l0Zm4xR1ErRXEwRjJ5a0RCMythb0VGYktB?=
 =?utf-8?B?ZFNyaVlkNStwZGdIYzByU25KaUtXUXhNaE9mZkZIVVF6TmEreXpTSzBDYngr?=
 =?utf-8?B?d01hN1h3SmQ4bzVmcG0ydzVuekhrd2FTWUhtRzdpbVRyTEtKNHRxS04yUWwv?=
 =?utf-8?B?blpqcU80MytEME91WEF3UzhKakcwTDZzVG85UzdwOUsxdnBkeCtuSXJJOTQz?=
 =?utf-8?B?RmhYdXZlRDUvYmtkWmwzMTdqMXpwNWR1WS9SZC9jWTluU1A3TXF5N2s0U0Ft?=
 =?utf-8?B?R2VDUERoaUNQTFBrNlovNmJmUkxORjBDdG8ycG9hYnJGUHovN21XakdoZlR4?=
 =?utf-8?B?N1prVVlkTEJwQWQvc1hDdEFCZ2xkeFE2RFNSL256eGJoc0VPOUgrRnhYbWhq?=
 =?utf-8?B?RkJLaWJmdUhFOGRqWFBaOXNsNGRiMEdJKzhCd0UvUUthampWOU1WOFBGZERG?=
 =?utf-8?B?RCtCRXFnSlVybW9Lais4SElRbDRjVVVaQUFTTWpNMXdxUGg0MnVxdW1BNEQ4?=
 =?utf-8?B?cFYwcloxYi9xdWxTU0R0amRISDhNNlFYWHQ1OXg4QTNsRUJCeTRvZVEzU290?=
 =?utf-8?B?NXZCVjJFeTQ0NFptTG90ZGUyWUVNaVRUQmpPTTIybVpGTjZZVWV6NFJFdXRi?=
 =?utf-8?B?cjdqTDR3d1RueG95SEtBZXdWK2tqc1QwZXB4dEc2QkFhQnA2eDNGSndSWk9u?=
 =?utf-8?B?bHpYY3JxTXVPclYzYWRnYkxHWkJFL2w0LzdiM3hmeU1GMjNLZTJmRU12OFkz?=
 =?utf-8?B?VXVzM2hJa202N3R5Z2c3dHE0YjBFUEZUY1ViaXdTOGdTS2FLRlZMR1dnd2J4?=
 =?utf-8?B?QWwrT0o4OUZNeUV5d3VyeThJYXk4bEprbEl6TXlpR21wVVV6ZHBZbTk2dmE1?=
 =?utf-8?B?THdxSTQ1aTFxWDFOdXM1OXlSblBmSDhuSzNGRTJTQXl5QXljRExzS2JDN1la?=
 =?utf-8?B?Wk02bTF4ZXRUYlk4V2YvWDJOeEhGNHdYQTRHUm9GVXpJd0RlVVlvUjlITDl2?=
 =?utf-8?B?OHVGbkxyQ3B3VHVaYkpCS095R3c5NG5yUjJ6Rm4vbVpnYmtmUmhEZy9mMHFl?=
 =?utf-8?B?MmZIU1VwUmxEUzhxbUV4ZlVNYTVJZUtXUU1jckQxSUZ6Zkl0L2RwT2U4N0t5?=
 =?utf-8?B?cGRMMy9VM0JkbkNMMFVrNXpsZ2JVQnlVYkxVV3BhODVkM1NNdHdDNTRDUHps?=
 =?utf-8?B?ZlFvMldESXFOSm9sTUZRTFQyVTc5WFlzYm5mMTU1STVFSURFbU0xT1lQaTdH?=
 =?utf-8?Q?hAhc=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 22:28:38.6370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d651dba3-0d71-429c-39ad-08de288426f5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5077
X-Mailman-Approved-At: Fri, 21 Nov 2025 03:09:02 +0100
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

On 11/20/25 10:03, Markus Schneider-Pargmann (TI.com) wrote:
> Enable K3_IODDR to enable support to resume from DDR after exiting
> IO+DDR.
> 
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   configs/am62px_evm_r5_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
> index c9592d7b6c4cc037a886fe81385791269a825aa3..39e8093597352e6ed3fb67ac59e0494239a51352 100644
> --- a/configs/am62px_evm_r5_defconfig
> +++ b/configs/am62px_evm_r5_defconfig
> @@ -123,3 +123,4 @@ CONFIG_SPL_TIMER=y
>   CONFIG_OMAP_TIMER=y
>   CONFIG_LIB_RATIONAL=y
>   CONFIG_SPL_LIB_RATIONAL=y
> +CONFIG_K3_IODDR=y
> 

Reviewed-by: Kendall Willis <k-willis@ti.com>

