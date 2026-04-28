Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C401FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 10:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1FD484690;
	Tue, 28 Apr 2026 12:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Qpq8epPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B05884699; Tue, 28 Apr 2026 12:56:48 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B9B84683
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 12:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytWMBvfHGRu6/WtE6eg4OcUUI7Rxv+08OLZXBu09TSYta299PnlSfitW4CJ3gSvUoTE3XgbjWu0cODQbBDy+tBkXv0UlFcTOMbO/nW3t4F1rj6FAgH6n7COV3lMmfvWe+7+aqbsjuB5VWF25zzwnzDTLEqdP0whgsH5RzFGBQWODGQuwX7OdO6f2NU+P58UcITlXnuqUQB2ugq3Zf4bgpwueDpP+hXsLgIOZiYea5erGThORR0cDR9obcoJYHKLrAk/5yBLxFYKzDU3btagQfypovQD50d52LNh3r/qig5gQebwLMXu9Zwjdk/+4QXMyfBJJONhY2VO5PU2BdQfaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3P67j1SBJ36jZJ9uX5xoxRanqDgInmCW3uBroMx+sY=;
 b=tm3ckc4T2MTxaHzKQMTuboAU4Ksp78LUN5o1Zr6UeNSolIu4Xu81g75i2SMfW2Z/AUgChP2LIqFb7XxXbvC1pJLN72Nz/XsHQJZaPgFjOwBpLasfjchDG+F3h5+JcH19mZKQMregXtsE6AGOS7meWkHEHypIUgZ/e1Dks4sXLz2qoPS48TPE/HDcZZkMyx48i/9Tvrf5vv1eiSCrgJ80reXGw+YJ1u6gSxuJ3Q8W/JXE3/sBxnxjep1dcSO3tP3j8kKIYrOg6Nr3YNu1EzhMLK3x0ye26v07+goj0tZPPLIAtRlR8wZVd1Y2k0puv8G+8jzoxTtRb1BQ+JxglRLYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3P67j1SBJ36jZJ9uX5xoxRanqDgInmCW3uBroMx+sY=;
 b=Qpq8epPtzipubX1D4LZNdscA83QKRQcvFPivy05SLJyzuJUV/ZJoxHv4oSGdWAdguQUBJjMP7zGH50tJT05q/J3juI/t62dNnJBYDzQkxSUJtjTIA4jt85I80Zs2S+WQXISbsWLcIOG3pCjsQ/1Qdw9zVLfauN4gRnANx4v64jw=
Received: from BN9PR03CA0071.namprd03.prod.outlook.com (2603:10b6:408:fc::16)
 by DM3PR10MB7927.namprd10.prod.outlook.com (2603:10b6:0:42::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.26; Tue, 28 Apr 2026 10:56:41 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::a) by BN9PR03CA0071.outlook.office365.com
 (2603:10b6:408:fc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 10:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:56:40 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 05:56:36 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 05:56:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 05:56:35 -0500
Received: from [10.24.50.162] (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63SAuWVq808952;
 Tue, 28 Apr 2026 05:56:33 -0500
Message-ID: <9863b81f-e6ad-41cb-8e02-4f22377d0137@ti.com>
Date: Tue, 28 Apr 2026 16:26:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] spl: Use FIT data address as fallback when
 'load' property is absent
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-2-b-padhi@ti.com>
 <20260427195405.GL41863@bill-the-cat>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20260427195405.GL41863@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|DM3PR10MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: bf82443f-92ba-4bf3-dbed-08dea514d3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kgrZgC/0xoc6id5x0DzG+YqMZBKUjJlRPUJEXCNq50ikSlujDqP4NFxNOyqqjDRwb8x8kqwqUnr2pXuSelbMMcUVwrzw4pkJoqCojC5lJ5z+YR8I27bQAQXXwjzj9JiKYptxpY5mbxy1FAOYkf9gFMH/cuqcKJhxmTULvvFLbjY6exUXzqdGDNDtgFqKRdZR3kg2/toqyi2yu5PyehMsS4UIxZ9dMKyHQeWHXr6WVmJYHxYZeeRVdLoQeLuI9sJpj6oWmU3gczwAWfHGqVd0rZcHlFEUD+YVIsT+IP8fYMQsD7DKtpEf7auB2ayfxM+m116RZk4qTJ5hbHl15udB9Ph0mpykTtFUg9iRDVlPPCeg15Poj5lUoTkNe3BLLxWpizfetNNL5U5o1aj0yO757gjnjI33kWkwXJk2VfTk7mlGgrjuQT6t54+juMzQ03lLEgk2Tz+fCPkdFV3w5C5ubNm/+hboxZmV4+YjR1E6GKHcD3P30oXi2P56j1YUEt8JKwZtYakebeytPcNYYMcgQt/dOGZD2/2z3VcDVyLSQRH5UuVlSFBIHlWg4BaQ8gaBjOuL18VmRVSbAW6bSVESk6Wasy0E9pfxwYO8D46qLH9UImiyRMwX69uQT4YKgokdKgZpwB0e72SL8GtHYDUC2xhEFWPHEw6Xq/J1Kmrbl+2Ffk6O+ONuuaU4gJ0JcKmNMbBY4vrGdp2nmpmRqi92Q0GhdSYm+/9DToSO/gQY6b0IHI2yndb638m9DjxnbMSY9cCtrQOxQKmDWtJSXxYxj639yIGzDE5Zu1Ktkt2vmVs=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 68KC/UA9FlHNZCfBbMDbZf53GSZPvByUgLh4AoZ8Dlp5ojpPwKc1jYJHlA8ELu/XxblisgTpwLoiUsvg3EVkpDtVbDS0e3Mq4/zDrN773nh96ftukT/gu9t6+8a2UhvPl9izOxJE94nL8tZqyb3IN2xS4AqVXRmfGoW6xwwmp3A9pec85bqJ/ljtybw87SUQWvo9C2kfCRftC66OLZDd2Z4b96A/AbMFJ188Z3vYhss+y/aoU2r1NFS+damtd47Ert/wGmRU6TAz5s0mHIlfyhhuQSG0xHM/k5ACi9aFo99Zk7wfhAfVnzck54wCVObjDsmKuIyWNIyuKEMWuCkNHgxG1Szjv71e9r0GSg5TlQDniEHnYzzDBIFXDSW7zxmMq1aPrpcSf85gK+/PMu+SxTPCNeF+n7S88P001IbheMRHGBERoGaU05/WA8/C7hjS
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:56:40.6347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf82443f-92ba-4bf3-dbed-08dea514d3fb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7927
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

Hi Tom,

On 28/04/26 01:24, Tom Rini wrote:
> On Sat, Apr 25, 2026 at 09:07:32AM +0530, Beleswar Padhi wrote:
>> In cases where the 'load' property is not defined in a FIT image node,
>> fallback to using the data address returned by `fit_image_get_data()`.
>> This enables FIT images to omit the 'load' property during FIT creation.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>> Cc: Simon Glass <sjg@chromium.org>
>>
>> v4: Changelog:
>> 1. None
>>
>> Link to v3:
>> https://lore.kernel.org/all/20251231173621.1069988-2-b-padhi@ti.com/
>>
>> v3: Changelog:
>> 1. None
>>
>> Link to v2:
>> https://lore.kernel.org/all/20250506104202.16741-3-b-padhi@ti.com/
>>
>> v2: Changelog:
>> 1. New patch. Add support to load images without 'load' property.
>>
>>  common/spl/spl_fit.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
>> index 46ebcabe56a..87d01b8b8e6 100644
>> --- a/common/spl/spl_fit.c
>> +++ b/common/spl/spl_fit.c
>> @@ -799,6 +799,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
>>  {
>>  	struct spl_image_info image_info;
>>  	struct spl_fit_info ctx;
>> +	const void *fit_image_loadaddr;
>> +	size_t fit_image_size;
>>  	int node = -1;
>>  	int ret;
>>  	int index = 0;
>> @@ -889,7 +891,19 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
>>  		if (firmware_node == node)
>>  			continue;
>>  
>> -		image_info.load_addr = 0;
>> +		/*
>> +		 * If the 'load' property is not present in the image node,
>> +		 * use the FIT image's data address as the fallback load
>> +		 * address. This allows flexibility in omitting the load address
>> +		 * during FIT creation time.
>> +		 */
>> +		ret = fit_image_get_data(ctx.fit, node,
>> +					 &fit_image_loadaddr, &fit_image_size);
>> +		if (ret < 0)
>> +			panic("Error accessing node = %d in FIT (%d)\n", node,
>> +			      ret);
>> +
>> +		image_info.load_addr = (ulong)fit_image_loadaddr;
>>  		ret = load_simple_fit(info, offset, &ctx, node, &image_info);
>>  		if (ret < 0 && ret != -EBADSLT) {
>>  			printf("%s: can't load image loadables index %d (ret = %d)\n",
> I guess the real question here is, does the spec allow this to be
> omitted like that?


Could you please point me to the spec? I could not find it.

Thanks,
Beleswar

