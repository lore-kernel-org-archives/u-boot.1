Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C19FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 10:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BE408460D;
	Tue, 28 Apr 2026 12:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NDy2KBcn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BA7C84612; Tue, 28 Apr 2026 12:57:58 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14FF18460B
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 12:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDqNgC0DwMnj1Q/tJqeobewwwbG3kQel7VEdnksuZ1AhcVgmdQX1ALXrZaJVkDc3MNqKv43hUfRxgxtV3IZ/aFXPKWzMKcdheXK0I/7wXEi8PY3g09mpVCybEqm8FT5x0OUV9W06JhEwL1zBX797bl52knJgrmTsIPFchxssBTNpOJ1t4TpbYVP2nHovvUXrpLu7GuV5ngSrh3eX67tcGQQnQqEpMsSIKW4BbH9ALXLNXFkqqx2ODydW8qWzjkEiw0co+cxq8GR2g30G/PWWUrtsQ8Gme2PNn6wXzp34Xzvi+NQiQfdn7We6PaAUdInGQBkpjYy9qKcez8Ek3rCRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhxPJcrNjPSVUwuPLZE3KCsSCQRpFB3MyK358UBK3SY=;
 b=sTC3BO1pN08aihZ7l14SqD9lgUWdb9qHhX3IUhNnXtOrNZ+SiWmPxftSQeZcJu262qCTwIa8atOh8PTnLdzlBz3+tan1JiafcK1uEzu8DsoLtzDF2D9vk0xbMRiN32J/+uCaZSYt3l+zkYILE78yFRv5X5ePuNF7CvuzAHyCI+1L2KvH6iMGleQAb3KOqq6AtNYp5rG7fzLd0tv/LZZLyYQTSQKA4JTAm05ES1vTLTYPTTxwbcoDe/vwDl2mGFeqNl41wkprQ1y4KfXo+7GuN/RmSZFMeH6Rfi54PtMGBSYlxdG+ij7nC7gdTrvPoLq8/jpMR7VS1hPVsxStg19SYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhxPJcrNjPSVUwuPLZE3KCsSCQRpFB3MyK358UBK3SY=;
 b=NDy2KBcn7jqjl+qB1p01aAW46dFR3b7RIla2T5o7wlwRJckznp0jxa4rVLnx8/4NYDs6EeYYt47I4j/Kav+LuJzGsPkY2pJQ4I5LilKHe96y0StSDdLqaYcyb6JloBRhenMxmjUrcPrsh4t3dFl4mJSi0PzCchsmftXmk3CG2fY=
Received: from CH0PR03CA0252.namprd03.prod.outlook.com (2603:10b6:610:e5::17)
 by LV0PR10MB997660.namprd10.prod.outlook.com (2603:10b6:408:33c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.28; Tue, 28 Apr
 2026 10:57:53 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::78) by CH0PR03CA0252.outlook.office365.com
 (2603:10b6:610:e5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Tue,
 28 Apr 2026 10:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:57:52 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 05:57:52 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 05:57:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 05:57:51 -0500
Received: from [10.24.50.162] (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63SAvmgv810162;
 Tue, 28 Apr 2026 05:57:49 -0500
Message-ID: <6d3b07d4-98cb-4d7e-9c6a-dd117889ef11@ti.com>
Date: Tue, 28 Apr 2026 16:27:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] arm: mach-k3: Use FIT image data addr as
 fallback if 'load' prop is missing
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-3-b-padhi@ti.com>
 <20260427195527.GM41863@bill-the-cat>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20260427195527.GM41863@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|LV0PR10MB997660:EE_
X-MS-Office365-Filtering-Correlation-Id: a07bde67-e79e-4ddb-973a-08dea514fed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: L1xi+K/NOGjqRQP40Jqh4b33rQpT+Zgn/amNIzOg9rAIDs8XLSfhKiaRyTkq8Gpz2NUn4iFFmg0CMwfdHJzQUmjJzXEkb3+bdywa2diQKXTdSUmvwvIhtLrOdZUGLevAg0a4n8C1Oj0uYeRGZDhyKdooj9T6PG3eu0YCnQQEdAJyeactSQadIEP3uaQ5RSo4Y9KvzlxzpPqZ07X0SYs+jiU3KbxDkT2lyJGBStry8QJNyNV67286+en8N6MyoKM9iPtkc2QFOFM9MNovsqwcFar80A4Eh9SZyiYwgiXbnpaxI5roSTiNyfYokvO6ohoU/bDF2nznPL+QEGO/ujWYqd4V2r62m24aFQ8pg5jM6ERrfwS/2mloYt8sPVpPIySdTzeTuJFuutV+1wPTuHtykyQVZSFuw/GupnZPtZ8Tp2zCsbtVZpBQcChLNQdh/cj9ytlv1mscIeiUv247+jERWB539wyStR2+9oA407oZ+/6Adb+fIUznS0uZv24IRCi+B4kmBw1qTnS2h9w1aqRZjW1Z7VsLgVDSeWI0XRckFRQI9XJehvrLq/MJe+ZMcWzYff+R5M4l5jpGYZn1R5HSZJxVYd9mtpqGhSh2hxlo0670cmFxe6XNSlRvhaaRgZn5nIMdaliwOhRGbskUBYxdzC3FjuM79tvJir4wcvxEv9ycnj/ukrCHMIwlXbgLTOrDhVqkrNxI3tuwQOjDqsaVy976F7oc9OP9fo/kfg5/mlVbMGbB2F2o9MezENeynbrt1xDG35FZ0GiIMU05Cx6RUEXlWs8ZeNnQKcSK26ihqG8=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VOiJPseMrWwrrEqRV5GSQ+4tMR8DxaWe7fqzRZKxpZxMSZbskfivdTl0QpCT1I511Dg2IAOFjTuad2Gt6lemygg1bIoi2RbKzomU8TMO0Pud+dOyQ5awZcgFmk1i7dyQGaIrV8kVhrN4DDy5HisMGePwGRUM/V/QZJ9fHAjkKBnICFJb79j/R9P/dqWWBdbLoFI+1w8yjh4Tan39P37Pu/ToAW3F6z1uVI7ggfNXzpUbJPe3gv9kfE0lxT9KHSIqodiHeblOntdbmHYDGTp/Cq1e+rC7+kmTwX9zplFyDaEMF0M/xBVOr+2q4wdFOGlmCb7dwlWnfUPs1qRj+Ns1J0P1OglB3VyFqSDlBCXka3THsdhAdvBcetzwaLqSgU9Qwvmdlv0MgSU7WFQpyPJ9qStXAI0AL6Gm2UjNQ9qbWhJKDphLp21Z/fYffAK24vuA
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:57:52.5193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a07bde67-e79e-4ddb-973a-08dea514fed0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997660
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


On 28/04/26 01:25, Tom Rini wrote:
> On Sat, Apr 25, 2026 at 09:07:33AM +0530, Beleswar Padhi wrote:
>
>> It is possible for FIT Images to skip mentioning the pre-defined 'load'
>> address property. In those cases, SPL uses the actual address of the FIT
>> Image data as the fallback load address. Use this FIT data address for
>> referencing the image when the 'load' property is missing.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>> v4: Changelog:
>> 1. None
>>
>> Link to v3:
>> https://lore.kernel.org/all/20251231173621.1069988-3-b-padhi@ti.com/
>>
>> v3: Changelog:
>> 1. None
>>
>> Link to v2:
>> https://lore.kernel.org/all/20250506104202.16741-6-b-padhi@ti.com/
>>
>> v2: Changelog:
>> 1. New patch. Fetch FDT Data addr for accessing image if 'load' prop is
>> not present in node.
>>
>>  arch/arm/mach-k3/r5/common.c | 23 +++++++++++++++++++++--
>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
>> index 484d96f9536..50c4231655e 100644
>> --- a/arch/arm/mach-k3/r5/common.c
>> +++ b/arch/arm/mach-k3/r5/common.c
>> @@ -328,12 +328,15 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
>>  				  size_t *p_size)
>>  {
>>  	int len;
>> -	int i;
>> +	int i, ret;
>>  	const char *os;
>> -	u32 addr;
>> +	u32 addr, load_addr;
>> +	const void *fit_image_loadaddr;
>> +	size_t fit_image_size;
>>  
>>  	os = fdt_getprop(fit, node, "os", &len);
>>  	addr = fdt_getprop_u32_default_node(fit, node, 0, "entry", -1);
>> +	load_addr = fdt_getprop_u32_default_node(fit, node, 0, "load", -1);
>>  
>>  	debug("%s: processing image: addr=%x, size=%d, os=%s\n", __func__,
>>  	      addr, *p_size, os);
>> @@ -342,6 +345,22 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
>>  		if (!strcmp(os, image_os_match[i])) {
>>  			fit_image_info[i].image_start = addr;
>>  			fit_image_info[i].image_len = *p_size;
>> +			/*
>> +			 * If the 'load' property is missing in the FIT image,
>> +			 * fall back to using the actual in-memory address of
>> +			 * the FIT image data.
>> +			 */
>> +			if (load_addr == -1) {
>> +				ret = fit_image_get_data(fit, node,
>> +							 &fit_image_loadaddr,
>> +							 &fit_image_size);
>> +				if (ret < 0)
>> +					panic("Error accessing node os = %s in FIT (%d)\n",
>> +					      os, ret);
>> +				fit_image_info[i].load = (ulong)fit_image_loadaddr;
>> +			} else {
>> +				fit_image_info[i].load = load_addr;
>> +			}
>>  			debug("%s: matched image for ID %d\n", __func__, i);
>>  			break;
>>  		}
> Does the spec allow this, or is this based on the previous patch?
> Thanks.


It is based on the previous patch...

Thanks,
Beleswar

