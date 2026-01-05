Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D0CC79FA5
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB0483DE4;
	Mon,  5 Jan 2026 17:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IPV56yCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A6383DEE; Mon,  5 Jan 2026 17:53:55 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2258583D71
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:53:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKBwo8vDHe4hrat8RFhD2o07m+3AOBzL6KjSfJ2PyiLCSftUzoaPkCsZCEdi2WAvvxl4K2owU0E4r55//Z2qmS3dHZ1FuSTQunukkWG+QGPW2fTMI7z3/4w9zyILkREKnjAFwcoAjIOPtNXegFClHy3umDlRok2JPiTl/rMVXFkzDR8TP/MHRLN/mLyG+4DJ9bW83JZcNjJmLVFwnh321CmKFFcdvbinIJHlQAF9V8fSPP8imJ5T8j4mx68sMsQ6peuKsMKWQYYg8o9myrRZKKWGXYQSNPD9JGNiubIJmO4LNjN4EAZpiqpB3pr13V2YF+97QT9NMeo8rAfLUY1qlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy03Vl7YjBXCfqhBzfPN08dY+aCEOvxEsx3S86yV2HA=;
 b=qqYpic5eFlQiFSG8y5AGphhtv1cZMPK1xgJ+sCzaz7TuNHJl1Rc0dE6WTZ4i8J5MNhyhZwF3SGQD3db8xAm3lJia+yHOL1A8+cHjCs9K4C73+H2n+apoE7BLdtMpAhPu+Ot5R5jYHVA9wmq0eJqc3xuE6/bfdDGIm77GbKv1eyyqMrqTU/cnaOrCooAsDXONeLQAjxF/vO1ZonrhHZKT0p+ttxpUVAlXHwJpVpL6+xFOxYfBvwVrD23FJYR5IBwElrZhI9IRnWBadKnzavlThF1Nf5Id5NSTAbXnFjvmaVI2a/o6beH0XdUSYKVuv6PVIDZtvpytsALDOUo8whrZfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy03Vl7YjBXCfqhBzfPN08dY+aCEOvxEsx3S86yV2HA=;
 b=IPV56yCmfMELihXw4lpCPnlZ7EDcDHvraW9TRf5xtuLmDnElh+ZEOSRY92EsglfXbzEBgkPdNJoeTw+GdOvZRN/Um4PzLoSWWQuOw31TJqo/L3dvsO4AcpwdpnY7s0bqDooXwiRczGfS4L3nifaWLn73rMex4qq2zD6JpMG+pqw=
Received: from SJ0PR03CA0358.namprd03.prod.outlook.com (2603:10b6:a03:39c::33)
 by IA0PR10MB6769.namprd10.prod.outlook.com (2603:10b6:208:43e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 16:53:42 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::a9) by SJ0PR03CA0358.outlook.office365.com
 (2603:10b6:a03:39c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 16:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 16:53:40 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 10:53:37 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 10:53:36 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 5 Jan 2026 10:53:36 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 605Grash1481564;
 Mon, 5 Jan 2026 10:53:36 -0600
Message-ID: <ab775336-f4b8-40db-9638-37df669ecd18@ti.com>
Date: Mon, 5 Jan 2026 10:53:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] arm: mach-k3: Explicitly identify TIFSSTUB
 images when discarding buffers
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
 <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20251231173621.1069988-1-b-padhi@ti.com>
 <20251231173621.1069988-4-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251231173621.1069988-4-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|IA0PR10MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: b19cb66f-52a9-41ac-6a4e-08de4c7afa4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2RuT3ljNnl3RU1zTnhRNXFpNUpvbk1USHQwdnRkTmFQWitoWmpVWkZZOFpo?=
 =?utf-8?B?ZzZUWHE0RG5NMW1lcWEzdXRFWVdOTGVMcUJmTUwwTHlSN2tmSmZyeHhSdnRM?=
 =?utf-8?B?YVRBMEFQTmFZOWsrYlM4OXZwRXg5SEwzb2RIK2hPdFZBSk51QUZhcHNyV2hM?=
 =?utf-8?B?eCtpNXBkc0Q1M2N2dm1xYmh5RzZsdnJVZkU4bklqaFcwekJZVWZ6Rjg3YmtP?=
 =?utf-8?B?SVNMUFpGNWdEWG1jTUgrdVNBN3ZwbVdzZFAvWTAwNGdvMnhBeVhqWVZiZVQ3?=
 =?utf-8?B?cHVucHRYQ0JWbXVYNUhHMERxU1VHZmc2TDhsSDFPdm52dnp6RlNibnBSS0dW?=
 =?utf-8?B?WStiTU9EbXJ2VWZCcDYybVBlYlgvK21PdUpHTG5TeGdMdUFjVWRGZ05ZMTNN?=
 =?utf-8?B?NUZ0Si9HdjdERXI2UkxHODRMZG1NSHVVUm1naWl5K3hIdjNGY3hyVXZCY1Ew?=
 =?utf-8?B?RFpCVmpIYWZZY2dyd2hxK3RxTjBmd3dsczE5b3NxUVpQb2YrMUZPVjl6MTlw?=
 =?utf-8?B?ckpuNlRZVDVLcWdhTmx3R2RtMlFydm56a016anNGVU04TWI4d1drQVorWWl1?=
 =?utf-8?B?REFtajJZQkMzM1NqaDZxZUlSQUgzWWJicGRSbWNHVkYrcmltQkhWZTVNOXdL?=
 =?utf-8?B?VFJrdjlTU3UvQzRrVHhXZmJyUWFFU3diejJiY3JUdElBcFV4eHc2T29EVXpI?=
 =?utf-8?B?a3lOUVRWVWZLR3FpNWlwZ2xFNzdsVUxmN3k0RFN0U0xvSzVBMytHQXJ3Z0o1?=
 =?utf-8?B?WHYxdHl0Yi9pQzFpL3BWRVh3cDFaZWgxejB5bGRBMTdpcklFa1NJcU9YWUpF?=
 =?utf-8?B?d0poL2JVekZlRnpiSXZZcE1MV254OE5sY09QL2ZWVnN0K3Boc3ZFUVBScnhW?=
 =?utf-8?B?dGV0QzRCQlRNQ1pzN1kvUlN0MHB6N0QvTGc0dU5QWThUQ21tLzBCYnV2NWM1?=
 =?utf-8?B?VXpMUmUwTTAyckh6Y3crTDgrOUt6bmZrMlh1Sys5ZXVFVXE4UjJ2WDZweldp?=
 =?utf-8?B?MlhLV1N2bFJnYTJmdS9CdDY4a2VLZmZtOU4vTE92L0tpUGlJRVk1TEFXczgx?=
 =?utf-8?B?SWN2UVdDcVYwdlBzUXVzSUcrRStlOWMyOXFqbkdoNzkyZ2lPTW9PUTh6b0Zn?=
 =?utf-8?B?djlLSnRqcWJQUUJzTzgxWVFQZFJqZHJYWW9xNkRZOEhydlhGWXhmT0kraDVJ?=
 =?utf-8?B?R21SdXZDd0pZWTVCZ1NpeHp2N1IvdTlhR2ZHTEoyNmF6cC9hV25JNXM1eXRa?=
 =?utf-8?B?Q0dNV1MxbFZHaVdvWkQzSjFiWGh2R1Y5K1NlTjc5NXlGa2UrZjZDRzI3RTV1?=
 =?utf-8?B?WjczQm5zOHl5ZkhsSmt1eXc2V3NVcFRoMnoxRnJSNkErVzcyTlFpMDFSb2xJ?=
 =?utf-8?B?TnMrdTJvOSswRGYwTlVhaEhTa2UxalVVU2NBWDhOUGJ2OTFSUkNjY2o3N3ly?=
 =?utf-8?B?SEdjYm9KSERvcjZIcGhsZzFRc2FmeDg1WVRrUlBSL0kydGtRb0dXZDRDbmhQ?=
 =?utf-8?B?RHl4RlhhZ21EdDdBc2ZOOVdjb0FzTlU5blFBckk4YXdOZ2VnL2N2SkFTSStQ?=
 =?utf-8?B?V3JCYWhxRmhMaVl3Qjg0KzdMSlV1bjFTUjZTTld4YlIxWktMU3FPbkZqSHZK?=
 =?utf-8?B?US9KOHJ6ZVJaWmExT0Q4blIrVW9kOTErd3hUR2ZYUHA3TEl5dU9MZVplYWRB?=
 =?utf-8?B?aUxJL3k5R08zd1hVSUJGZUZlZWk5MERNSDA5eWlFTUJscm95c3lvUXBwd29y?=
 =?utf-8?B?b3h2N0dlRUkyTEJseVVhTmNpSGprYkxKS21HODkzYnZXY3Z0ZFdxbWNoZHVs?=
 =?utf-8?B?d0pGdFJBWXV2cmNQWVh6OUN2b3QybEZZQXpWT3ZETFFvM1BOZDdIVG1iZVo5?=
 =?utf-8?B?SjVLWDc3Q3pxZVNOcllFelFzUzZ0Q0ZxM2NGa2F3Z2NxNkRKamk2QzFxd2to?=
 =?utf-8?B?cE1KSm5hVGhIU21LbDdSeGREczFuSnp1dG82MCtob3FaRkpBUndxRDBERkZW?=
 =?utf-8?B?ak1pZCt0RDZLR21WU3JYOG9waXRLdTNKWHVJUitJU3ByVytXWkRQSGgyL2hN?=
 =?utf-8?B?NWNad0NDaXB3bis0SHg2M2FRaEdkN1ZMR2MzRm1YSDJQQzVXU2NTYTVEbXNH?=
 =?utf-8?Q?xtXk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 16:53:40.1139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b19cb66f-52a9-41ac-6a4e-08de4c7afa4b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6769
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

On 12/31/25 11:36 AM, Beleswar Padhi wrote:
> The board_fit_image_post_process() function assumes that all TIFSSTUB
> images appear at the end of the image_os_match[] array by using
> the condition:
> 
> 	i > IMAGE_ID_DM_FW

The check is (i < IMAGE_AMT && i > IMAGE_ID_DM_FW) so I has to be both
larger than IMAGE_ID_DM_FW *AND* less than IMAGE_AMT, given the enum is:

...
IMAGE_ID_DM_FW,
IMAGE_ID_TIFSSTUB_HS,
IMAGE_ID_TIFSSTUB_FS,
IMAGE_ID_TIFSSTUB_GP,
IMAGE_AMT,
...

Then only types that match this should be the 3 TIFSSTUB_* items.

That said, explicit matching is so much nicer, so you should keep this
patch but re-word the commit message.

> 
> However, this assumption breaks when new image types are appended to the
> enum and the array, causing unintended image types to match this
> condition and having their buffer sizes incorrectly set to 0 with:
> 
> 	*p_size = 0
> 
> To avoid this issue, replace the range-based check with an explicit
> match for TIFSSTUB image IDs.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> v3: Changelog:
> 1. None
> 
> Link to v2:
> https://lore.kernel.org/all/20250506104202.16741-7-b-padhi@ti.com/
> 
> v2: Changelog:
> 1. New patch. Fixes condition to allow new images to be added at the end
> of the enum.
> 
>   arch/arm/mach-k3/r5/common.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
> index 390e1324fb9..da1d1cb7230 100644
> --- a/arch/arm/mach-k3/r5/common.c
> +++ b/arch/arm/mach-k3/r5/common.c
> @@ -366,7 +366,9 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
>   		}
>   	}
>   
> -	if (i < IMAGE_AMT && i > IMAGE_ID_DM_FW) {
> +	if (i < IMAGE_AMT &&
> +	    (i == IMAGE_ID_TIFSSTUB_HS || i == IMAGE_ID_TIFSSTUB_FS ||
> +	     i == IMAGE_ID_TIFSSTUB_GP)) {

You can drop the (i < IMAGE_AMT) part of the check, it will always be true
if "i" is one of the TIFSSTUB_* values, so just:

if (i == IMAGE_ID_TIFSSTUB_HS ||
     i == IMAGE_ID_TIFSSTUB_FS ||
     i == IMAGE_ID_TIFSSTUB_GP) {

Andrew

>   		int device_type = get_device_type();
>   
>   		if ((device_type == K3_DEVICE_TYPE_HS_SE &&

