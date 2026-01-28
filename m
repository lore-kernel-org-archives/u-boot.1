Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04F5D3F074
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 15:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 578FA83FC6;
	Wed, 28 Jan 2026 16:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FYIqho0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52CE583FD6; Wed, 28 Jan 2026 16:26:40 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 933F283DFF
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 16:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHIdbtLhVECjnZ8l58MJYgbP2sNPzYKZbkAecEzCacIg+Vv6CxXUXJGQpfzU7q27oo6BrxGNLikwlO3z98xd7VAFHnmJhtZvGMbJ/xSWnJnoYVXF+iugNzgPHYQPQ1pSjCltTSbIJuU1yBYOe2gC/e3nh9AgR0Tng0D0vHDHtns6KszaVfuXnctY04tduk/+4dJ7fwmvLUvtOr9nyEEUpYPE8PVXvWGnxUT1tq5iTRWCEPJ/8WfI+5M+fPdgHG21eR1IWf9PY37Eb6sEixF8GfILsRKC8VbWYGuVfHSr7trCK1Bkf1daFCXlNiaR7Eg5RSWSIMgQsnYdpHRiMXwK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1vZGCrPVq5Qpa7THB/1rrp8yihewAlWfM8tx8lHsRU=;
 b=ZcylCu+S1et0Fdhi0R7ZzZPGQAf3g4+iBoYUruJRQkOW7IC+XuWN5tqhdtnoGLv42uTa/9g3yoO2U5ddiLtH8tsW9XrPgYpSClpSxJ6DizArFUSq+L3ZKab9zMea7gd16Bl+6i0s/o6PN4Arde2kCcKNti9/deRlhGq2nu1RxoNWeM+O4Kd5aXbS7J1aFFgcxpFdRIQmn/SRtNz39b/t1cyST+OIFjUP6wEAq3xFEpRSz/2c5aHAu9ggWTKXZ8qowpORUCiwfauWVsesF/tsYmVao4iQelKTHO75YLQzF+vPxNR1C4D3ee3D7qom0xstMwRcUKTFlakGUEOlS74oqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1vZGCrPVq5Qpa7THB/1rrp8yihewAlWfM8tx8lHsRU=;
 b=FYIqho0KNlNBIi/0/1RCDNhzF+XhYBquHUUYJ3hG7jkMcTHwnrNP6p+W0OC72Fv09OoWrboTuT+hrEk/gg7k/dthkKa4Nxo5XTvzYSmX2s9BQ3YM/4T18NHJAtxsBMH9OipvOU8F4hssCb4LLEFTct6smh9eLVsxLPJZTbOBcNA=
Received: from PH0PR07CA0044.namprd07.prod.outlook.com (2603:10b6:510:e::19)
 by PH7PR10MB7011.namprd10.prod.outlook.com (2603:10b6:510:273::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 15:26:33 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:e:cafe::ac) by PH0PR07CA0044.outlook.office365.com
 (2603:10b6:510:e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 28 Jan 2026 15:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 28 Jan 2026 15:26:33 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 09:26:32 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 09:26:32 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 28 Jan 2026 09:26:32 -0600
Received: from [10.249.130.12] ([10.249.130.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60SFQPSC2572203;
 Wed, 28 Jan 2026 09:26:26 -0600
Message-ID: <139a01e9-c395-47f0-a09d-1c591c178bf9@ti.com>
Date: Wed, 28 Jan 2026 20:56:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tools: fit_image: Fallback to 8-byte alignment for
 flat_dt images
To: Marek Vasut <marek.vasut@mailbox.org>, <trini@konsulko.com>
CC: <sean.anderson@seco.com>, <ilias.apalodimas@linaro.org>,
 <malysagreg@gmail.com>, <sughosh.ganu@linaro.org>,
 <philip.molloy@analog.com>, <marek.vasut+renesas@mailbox.org>,
 <james.hilliard1@gmail.com>, <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>,
 <praneeth@ti.com>, <u-boot@lists.denx.de>
References: <20260128141834.2322865-1-b-padhi@ti.com>
 <71adda09-1f3b-48f7-aaed-845e6a30b6ca@mailbox.org>
Content-Language: en-US
From: "Padhi, Beleswar" <b-padhi@ti.com>
In-Reply-To: <71adda09-1f3b-48f7-aaed-845e6a30b6ca@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|PH7PR10MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a08b63-4677-4bb8-baf7-08de5e819e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVltc0V4bzZ6NGN3czlJK0xWT3R1ZUxmN0dIU1hyckJuS0l6OHVtSnFMMExi?=
 =?utf-8?B?Uy9MS3ZYNnV1WkpxY2xRRzh1Wnh6L0MybWRjRHd3VDN5TnNnbWZUZm9tQUNM?=
 =?utf-8?B?SUxoVzNVME1YNkp5NnhoaG5hdC9JWUpDcWE5ZTV5d3RrS09wS1IxbC9wTmlL?=
 =?utf-8?B?RlhuNWVjRUVIRzc2Mk9ROXp2dGN6dUNCdDMyYVd4YmpVc3RJZGFQYzJ5U1F2?=
 =?utf-8?B?U0creTNzME5ZbzVrZXdibnpIcEJ3U1NIU0JMVU0yWWg0REtRUWpjMXdkRWhZ?=
 =?utf-8?B?Z1F5aVdXVWtES0s3Tk1EK1AxUHBEdjF1OHROQk12UnovS0FlZ2JlbGtQVm8z?=
 =?utf-8?B?SUhTclY2SGczN0lxbFRxeGVyZ1VsNjZObjdyaC9rY3kwU3B5Sm5neWlrK2I3?=
 =?utf-8?B?L2l6QWx5M2ZzZDFGYzJ4OHhibVo2d1QvNTQzK1FYc1ZxK09BdUZGQzVxeHhT?=
 =?utf-8?B?b3F3QWQrS0pmSDk1bXMxdDRkYVNnSDhHQTRiZHpNeVpjclE1Rk9Pc0puQVhw?=
 =?utf-8?B?cG81RVBPK3c0OGVWRVFYc1p6ellqenlyanpvTkNnWTNPUVMwQ1lYM0xpQ1BK?=
 =?utf-8?B?YUFUMUpCaWFiUEhUQTBuc3BpVm01b1VITnBUWm5TLy9sZEo3U3hxNldabDli?=
 =?utf-8?B?MWxLSjd1WmgybWV1Yk1WU2VmNkJ1bWNlOGMyOUV4K0xsYXc2ZDZDMHlkM3VM?=
 =?utf-8?B?U2Rub0hjQ205dmFxWFQvYkdiRHc0RERzNXlhdi9aa0g5Wkc2QXBpWUF2NytB?=
 =?utf-8?B?cmE1Z3NPdGtWNkNvN3F3SUJWK1NNTlhiUFpRVDVUSE9GMGZoaGJmVXc3ZTFn?=
 =?utf-8?B?ajUzZktEb04zQVV4WTlpdm0vYy90SHVya2ZaRkNDSk90YlRDM0plRWxlTUti?=
 =?utf-8?B?dTJpcmdna0FTbTh0L1hiWmdoQUdmWHJObnZyR3hzSjdDd3R0ODVSKy9kdHFO?=
 =?utf-8?B?MkdoMTQ3TjYrMW0wN2F2OHU5aWwzS3hpdkpoSks4RG5OUE92Nll4dm1qKzNv?=
 =?utf-8?B?bGF2SEJhNEtVbXJVZGpjczdnd08yYXRKTUdTYWZYRFBkbnlaVHZ4TEZCUHdW?=
 =?utf-8?B?Z1dSSVkzSzVhY0srT2tSTDhtNHJlb1ArSzFEd2tvTU9FendZYklZQ0hEcE5k?=
 =?utf-8?B?WGd1eHF4TmN5alMxZDVBeGtlRnFBODlYZWdUUVltSXp2QXI0czhDWlJyZlY1?=
 =?utf-8?B?N1pkRkJDREU3MUZxUzgyM1I0bkhjUEhyd1R0WjNQa1I2algrd1FScHMxUGxD?=
 =?utf-8?B?ZGVIRG5RaU9ZTnZ2YWdMSk0vRlU0YWdvY0d3dlhmZVB2VVNvNms4QW00anZi?=
 =?utf-8?B?VG1PN2JMNTQ4RlpvWDZOSTQyL3RZMHdsc21CUVZDa3p2WlZyMm1hbDhIdEJI?=
 =?utf-8?B?VlNPWE1PWkZvb1VFQkpFSS9YckhVL2plWGI5V3ZQRngrR1dZTEJEenpaZnhy?=
 =?utf-8?B?ZXQ4bHZDanBmNkU3ejRnS3daUW4yWkZqeGU2L3FFc0pwTm1EWGdOSXB3bEVO?=
 =?utf-8?B?djdsU0hxYTgyNUFGTks0aGc5dlhkd2pNcWMyNDBKVG1VaitSdGpnNzBUWS9i?=
 =?utf-8?B?ZVhuN2Y0dGxYZ0FYeUNndGU2Vmd4QTN3U3ZYZkd4bkhhTFBMa0diYkRMWWJP?=
 =?utf-8?B?MjJ4UjZqYk00b0dkWGlKdDZDRUlWeTRzdU1oZHFoNEJpbGtZK0ZYclFSQ0Rw?=
 =?utf-8?B?VTYxSHBlcmVPUGI0RkdHQVhPUExVa3dvQWl2anp1WmhjRTBFWGxNUnRCMnFQ?=
 =?utf-8?B?cnc4bEF5REZmOHJnZmlxNm5sbmVod1c2N1JQWndGOXIrRzZ5UnZ1QnlzMTZN?=
 =?utf-8?B?RDhlRlo3dUNqWEthckYzMUlhb3g1WFpjaGMwTktNcGcyaEozQXJuenpKd0RH?=
 =?utf-8?B?b3pmdFhDS2twd3BWME0wWlR1Ylh4V3lIaTFDUDIveHYwZ1ZpQllYSjR2N2da?=
 =?utf-8?B?NkVxczRHRWZjUEx5MC9wWjdqajQrYWtHc1FlYjErUWJMc2RnVnZOT09LY3Nr?=
 =?utf-8?B?WWxWSFZTMG03ZnVCYVRGV3RZb05ubjJHSjQwdytreUVXTCsrTlNKVnhDUTM5?=
 =?utf-8?B?QmdvTXJ5eVhoZWlIbGxtMHZKZ2VjaG1JVmFMQ2RFendpRDFwMk1vaExBRjNQ?=
 =?utf-8?B?YXZkU2tMQ1J5TU8vcGswT2p5MXRBU3VJckIwWnc3UTc1akRPZFNzWXlPWkpK?=
 =?utf-8?B?TzQwY2ZlKzU0TE9lNlJzOEdOUGxweHp1eXV0NFQ3Yzh5amx4V2JLUEZOZE5C?=
 =?utf-8?B?blp5eHhXdDZibHJKdTAwS2FjVFhBPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 15:26:33.4262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a08b63-4677-4bb8-baf7-08de5e819e77
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7011
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


On 1/28/2026 8:26 PM, Marek Vasut wrote:
> On 1/28/26 3:18 PM, Beleswar Padhi wrote:
>> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> Please drop this , it isnt needed.
>
>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
>> packed inside the multidtb.fit FIT image. While the individual DTBs
>> and the FIT image start address are 8-byte aligned, the DTBs embedded
>> within the FIT image are not guaranteed to maintain 8-byte alignment.
>>
>> This misalignment causes -FDT_ERR_ALIGNMENT failure in
>> setup_multi_dtb_fit() when locating the next available DTB within the
>> FIT blob and setting gd->fdt_blob, because of the recent libfdt
>> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
>> version v1.7.2-35-g52f07dcca47c")
>>
>> To fix this, check the image type when extracting
>
> "extracting" ? This code changes mkimage, so not "extracting" but 
> "packing" (into fitImage), right ?


Well the function name is fit_extract_data(). It is documented as extracting
all the data properties of a node to the end of the fit. So just keeping the
same terminology. Its obviously not in the same context as extracting data
out of a FIT image to consume information...

>
>> FIT image data and
>> set the alignment size to 8 bytes (if not already) only for flat_dt
>> images. This ensures correct alignment for device tree blobs as per the
>> DT spec, while also allowing different alignment sizes for other image
>> types within the FIT.
>
> [...]
>
>> diff --git a/tools/fit_image.c b/tools/fit_image.c
>> index e865f65a400..f842c845771 100644
>> --- a/tools/fit_image.c
>> +++ b/tools/fit_image.c
>> @@ -682,9 +682,17 @@ static int fit_extract_data(struct 
>> image_tool_params *params, const char *fname)
>>       for (node = fdt_first_subnode(fdt, images);
>>            node >= 0;
>>            node = fdt_next_subnode(fdt, node)) {
>> -        const char *data;
>> +        const char *data, *type;
>>           int len;
>>   +        /* Fallback to 8-byte alignment for DTBs if unaligned */
>> +        type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
>> +        if (type &&
>> +            len == sizeof("flat_dt") &&
>> +            !memcmp(type, "flat_dt", len) &&
>> +            align_size & 0x7)
>
> What will be the resulting alignment if align_size = 0x1f ? 8 right ? 
> I think it should be 0x20 .


I thought we agreed on resetting align_size to 8 if its not already aligned
(regardless if < or > 8) in v3 version of this patch[0]. Do we really 
have to
align the align_size var itself? It seems like a overkill to me...

[0]: 
https://lore.kernel.org/all/75b9e8b8-dbbe-4502-8d4f-9a50b332bc7f@mailbox.org/

Thanks,
Beleswar

