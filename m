Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF2FD59F76
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 14:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADFCF839F1;
	Sat, 13 Dec 2025 15:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V9fCIN/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7671E8307F; Sat, 13 Dec 2025 08:00:01 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 579AC807C0
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 07:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpSxaTzSJ0DRQmzYtE73J5YSiQxSoPnEUP/miDxcd5sYRmdvHQqfvG64xPh3AhDMDHJvuuM/DhozvA6xsF4ljBM9wdktwJBH4sxPDxBzSG31Wqf3oTwsABHR+YBtsaa91BDCSU+hIuQO0mM0Ooeqd+EXpHu3QOnEuoh7T6cHXdettd17m/TqXIj/nJ0P+KGpa1toC+LopJiBPhdr9p0S1YXejZQcnCGyIZNiwdHiq/3B67C6CJ4NyYLriKa+/He+lSlFqR9Zc+10wEoL9bzoYvhGrQRyQtNzdqM0wC1scMHGI5iJMiXFZeVUt5jyp5Y3KupuF+4Iespy6KLP6xYr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWCB+B3drLOKrmUXKdeR43jBXJ8mmY6Qs+ueFXFynXc=;
 b=NB6E4XfclJotXXIfHQf2232sibSPy+o+jU/+CRsmU4KQ22QGf7CPRiqKRWO+6PSIW7iJBkMjhrb6o1dQIBYn/RSa4L1Z5i1V511I65c2FaxP0UkIcCLUWX6wmlPuQs/DHvFDdOztRsxBigxRp7PNhZQqEtHUsTDMpSfWQRkCXVAhzWbt22X+FR/5pUsEnEo4Reh9nTPy9jXRHpFx1s/nEhAj/6pCvmmDI5piOof+zyx0vNH7miYxTGIqPGVVLV6O4a6VQDAaaN0r7Os8YGceYT3vDUGZADAch+bCCe+P5gDm6N+gqOaVOo0MjVsvSpSAVAEGxN+Wu/rtxsu05lDieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWCB+B3drLOKrmUXKdeR43jBXJ8mmY6Qs+ueFXFynXc=;
 b=V9fCIN/WRCHEi6AAFGxJsiYP/FkEtp3H+i0iGsAUAxI3RraC5ITAO0HTAimyMEspd6oGf86qYtaN725SUScXC1lHIafxuCdzVbzPGdh9+jRdcRck68o9DyeBagt1b2C4lnLt3dr+vo27c8cTTVwZasWWchP9U24g2rOxaQ5zpaw=
Received: from SN6PR2101CA0009.namprd21.prod.outlook.com
 (2603:10b6:805:106::19) by MW4PR10MB6536.namprd10.prod.outlook.com
 (2603:10b6:303:22d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Sat, 13 Dec
 2025 06:59:56 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::4c) by SN6PR2101CA0009.outlook.office365.com
 (2603:10b6:805:106::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.5 via Frontend Transport; Sat,
 13 Dec 2025 06:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 13 Dec 2025 06:59:55 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:59:53 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:59:50 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 00:59:50 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD6xeNx3343550;
 Sat, 13 Dec 2025 00:59:41 -0600
Message-ID: <80202eaf-aa50-4203-8ada-1c7787ba7743@ti.com>
Date: Sat, 13 Dec 2025 12:29:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/13] arm: dts: k3-am62p: Add r5 device nodes
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
 <20251210-topic-am62-ioddr-v2025-04-rc1-v7-11-f113b156f83f@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-11-f113b156f83f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|MW4PR10MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c74acb-4727-41c1-5fdd-08de3a1538a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlc5VXZzcXZWRHVPbE8wT3RwbkYzWmkySUpISmpDUnVNVGpGbVFQdllXZHpa?=
 =?utf-8?B?a0ZpeStkVUhyNURMT2xQeWlTQlg4Z2lHV3lDU3orQ1c2OVhHVUQ4eCtZYU1z?=
 =?utf-8?B?bXBCOWxWbEdSM0xqMjFLTmo4UG9JcFdQeGROWDl4R1JYamFWRlQ3RGE4UlN3?=
 =?utf-8?B?ZDRpSC9FSUlnSk53Y1F0Ni9BK3BsK25VRmJCUnNNSFk5eURqY2ZZNDBMZ3lS?=
 =?utf-8?B?RlVXNFY4SHhXMzdPRFZ1S3lBdnZEYUVUOFpIY2J6MHhncit6cCtkTXdKd1pY?=
 =?utf-8?B?dC94RUI1VW1CS1NDNm41b3RQZjJJYnIyRlBUTmZKZHVmclBmSHpROTZyU3ps?=
 =?utf-8?B?cHNMWjg4TkJBRS9ZRVViWGk2U2Rqdy9kYi9kcC82NVNYVDYwc2ZFL3Eza0F2?=
 =?utf-8?B?UitUL1lRRkRld0NodHpNSTRlZDY0dUNpM0xsdXh5eHJDbExHUE1zTTNOV2pr?=
 =?utf-8?B?ZlhqbHNvTTh4dzhHeEE1UzRNVjBWb21sbFI1L2ErQTUwUlFHdGNnSUtSVG52?=
 =?utf-8?B?bm9aeVNac09KWFptZVZuY1lMdUhlN1dURDQzMTVsTzErQVNLVWNkN21zNzlH?=
 =?utf-8?B?SUUzOHVOV3g3TVB4Q1AyL0FTYVA4QmphQlRxeUdvVlBNOHF4QlNvSmVlLzJo?=
 =?utf-8?B?Q0ZoZWo0bWFWYy85K0hka3FSdHg2YnMrWUVpeUczUTFxYU9Lc1RhVGJIVmNv?=
 =?utf-8?B?Tm9ycEFkTEgyM0N2ekZGR25GMkt1QThiMjNpQTcraEdhYjZueTd3UHdzL0JF?=
 =?utf-8?B?ZkVGdmw0L3orZUpRVzNabFJreXI0M2dFcW02WUtLWnBQWDZLYzVNVERzeDVI?=
 =?utf-8?B?dWRxR2RkSmE4d1JycmxLeGMyMXY4MHh6NzFPU2loVkFkTmNUUUcreTlWN3Jo?=
 =?utf-8?B?cXpIeVdTSFRLT0FwK2tBci9jOGZGUTRTZzA2WnhKdGdQbkh5Skw4K1ZoOWJO?=
 =?utf-8?B?TnNiWlhuV0dVTnJjWTh2OGlyeWdiOGV4N2dQS3dLU0ZUc0FKcXU2NHpadGdn?=
 =?utf-8?B?YXNGSHJVVmltM1RoR3NOSVB4bmRoeWM5Vll6TXJYTE40bWZBM2Fqb2gwSEZ6?=
 =?utf-8?B?V3RzSHVSa2FOU3lnQXkvRnVPZTR3TUhyMk9ScjBzOXJvUFU2dzVadVl0d29F?=
 =?utf-8?B?RldYUE5Bbm1IZk5oRVJ0V0tWM24yOHljY2Q2aW9HbEJRUEZIbXVEam9jREt6?=
 =?utf-8?B?eGFUWHZJRXhzc1ZvUGtlMHY4MEJHTTFtU2txOUk3aCtRTUJBdjhCSlRPWW5X?=
 =?utf-8?B?eEd2OElGVytSRnBCZ2psWng4czM1Tjh6UzNTdjRubzZVdUpIcXN3QU1FTGlQ?=
 =?utf-8?B?Z1hCNncyZ29CQVdKUmFUdE56amh4Q24wcTRFV2tMNkJzNFhsem9OeGFOWkxD?=
 =?utf-8?B?eHdBUGRMUEhHcDg4MHBuR2VzaHJEYkJsWkkyRW9NS0xBQ1JDanlBU1lJbWtW?=
 =?utf-8?B?VFVSbjdQK2lPUG4yd0ZDYXZDdTZ2VUJlMlplM2YrVkZwZWt6cHFickRpOVJX?=
 =?utf-8?B?ZHRZZmdHcHA1NzRra2ZUbURSSzFGNmxVK21pR1pmck14blR6L1JRZ25MWTRS?=
 =?utf-8?B?OGlYU0ZrcDIxZGlyc2d6NHQvNHJCdFBES2lPWXNSb1NxbnJoZGwvUjRKTGFF?=
 =?utf-8?B?c3dkYzBoQW9IVHJLcGQxZVhMdUVsNGpuWUFKMm1ld0pSVmtET2tjcmlYb3lt?=
 =?utf-8?B?VHRMRXFVUGI0MVAzdUxIMEJWcWVoaXRQRkZuZ0ZHR1RWL2FRUlNUVEp0Ympk?=
 =?utf-8?B?OEJ2Wm1mcDNxZHlHYmFPYjFsSXVPekwwWmFPM1FZL0ZrcE83YjdNNVU2LytX?=
 =?utf-8?B?MUl3R2gyWWdMUks4eXhLRkZUZUxuQmlLTndaNFdqeHQ4cUlaRDQwRitGOUVO?=
 =?utf-8?B?TkUwZFN6YnFtUTArN1ZwMkVMMlBnL0gvOEZ6MmdINE5maXRuZmJ6WFQ0cUhH?=
 =?utf-8?B?U3dtbXVZK1RvZ1Z0N0IzRGpXeU5OY3k4M3BnaU0vS242N0gxaHhKZWpTZ0Nw?=
 =?utf-8?B?eWlZK2NDNGEvZlU2MUxEaTVaWkdpZXd1WGk2dEQrMStIRzI1WWJ1dHJJYzZ1?=
 =?utf-8?B?UkFYcU8vaGRMY3EwOUp2eTF1M3hEa2tsMGxaRXVtejVZNHJjbE1GV2ROVitw?=
 =?utf-8?Q?QsE0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 06:59:55.1817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c74acb-4727-41c1-5fdd-08de3a1538a6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6536
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


On 12/10/2025 7:39 PM, Markus Schneider-Pargmann (TI.com) wrote:
> These are needed in SPL to be able to resume from DDR immediately after
> booting from IO+DDR.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> index cf087c6e343a8af6f4bb2093bb6c3f28395a2686..26133d818973214914f68838f678dda5aba63970 100644
> --- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> @@ -13,6 +13,14 @@
>   	};
>   };
>   
> +&wkup_r5fss0_core0_memory_region {
> +	bootph-pre-ram;
> +};
> +
>   &dmsc {
>   	bootph-pre-ram;
>   };
> +
> +&wkup_r5fss0_core0 {
> +	bootph-pre-ram;
> +};

For this patch,

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

Please push to kernel device tree as well.

