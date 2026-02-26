Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5822FD9E23
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3235F83E61;
	Fri, 27 Feb 2026 00:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IExHRYIb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 374A783E81; Fri, 27 Feb 2026 00:10:05 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D05483AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=praneeth@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiKOgpGj1KrauwrrEdB+divK9h4kcOigRPyi9WvIlGNdt5XhSJVZ3OVmJWN7I2n35oULfwo+bKlJkdtWmZSf05DpeS0RiYYzoSGo0LUGqWD2qTowOYdsu9ghZNKzDADAAeKqcRCgfRH3JmZpK/63X9jYxO6fBGzg12xZtvVfAQ7Tchq/Upd5N+valbrI8wqK4Ao4IR3SVVtszgHh9oARie0sCNEx7iRLxRHTyFbyjZk3qfPWdu5wfuhKG0n3qL+705DyK1iR0BXwbfJW4AuiFI7kd806Xm94OxyIoDRle9imChjWaTfJgJTJyUcqqIO1hVBpFgmYcXpIhgWOtnawbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsxoIuRtfyvNiQgy3QJXUFrOhG7ICk9ozU4NPplqhT0=;
 b=l+PNgJNrtIdKz7d15a6DjHHw+x4QPK+xHPhqnFOhsWYITnhSkWWrez60f6WReKrlVscN02wfe8tcqnn4zb3U8RQ1PrnN00MCZ11hREEbn57Y3P0QlWO1U1O5/++KoFtfg0rq7CaiWQBiWNO7WhgVsa4n9+MIBiWL439wKjAWDeqnvHdTwU8YTfL8NoYV5xq5XaXPFpWMj+q3CC35SDAYJdDnBdA1rS5XXYktVMvdRmKuXxtHSLegYF2hEv9Ol0tpBrNs10ROPEm6nXSFoujrr7sjWzazMgqKEdOrAWwcXRZ1vjJnjTFahH5liyy8yxvv87T3iJzCUJpMnQ+ytLmz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsxoIuRtfyvNiQgy3QJXUFrOhG7ICk9ozU4NPplqhT0=;
 b=IExHRYIbL+zhW6Ym6ix5F06G9qj75abG7WFJMbDJXDDWr9NsKwT/gho/+STeVWEEWO14caT+Cjjf8Yh6ARS2aCtyeg1oNjOjVAqt4dUC6uPpwqfQPRzvXhdFkEs6n+wY/ITKreI/nkqt46oaROT3m8slVhVz6sYz0Lc5GQ91MAg=
Received: from SA0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:806:130::20)
 by DS7PR10MB7324.namprd10.prod.outlook.com (2603:10b6:8:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 23:09:55 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::14) by SA0PR13CA0015.outlook.office365.com
 (2603:10b6:806:130::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.0 via Frontend Transport; Thu,
 26 Feb 2026 23:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 23:09:54 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 17:09:53 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 17:09:53 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 17:09:53 -0600
Received: from [10.249.32.53] ([10.249.32.53])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61QN9r4H2684037;
 Thu, 26 Feb 2026 17:09:53 -0600
Message-ID: <9768e26d-e645-4ae9-bf51-bf184ebe671f@ti.com>
Date: Thu, 26 Feb 2026 17:09:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Update AM62AX and J722S CPSW PKTDMA Resource Sharing
From: "Bajjuri, Praneeth" <praneeth@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 "Shilwant, Chirag" <c-shilwant@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
References: <20260224120557.1476390-1-s-vadapalli@ti.com>
 <e052a1e6-2aa4-4ecf-acab-87e5491d5f93@ti.com>
Content-Language: en-US
In-Reply-To: <e052a1e6-2aa4-4ecf-acab-87e5491d5f93@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DS7PR10MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: ebea2066-b8ba-472e-c0db-08de758c26ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|34020700016|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: rdJGR8liRKs/nY+U4Iueknm+gUkm5tAZCAa4h0iJVNa3cSeGp65uy7G8DelvTlimCJSZx3v6q0vCQLQu03hk3Cg1sm09SjTLWOywAOGqoFcw2GHhP0Lqu3UdmeqATUishAhKvNRWPEh7DJ6hWFDpI4q36LOQI5k8e0sLDbWq5Sz9AQLpEnqp4g3SbvguT3KRexZFsWLQXzkVW2YaLtpMLARQYTj0lUJQZYXjAFDglzmfokto9HtNiWd0+5oCC/EK111neUfMQ0wd83v5ew1aHHEPg+DmXSwxybbYulHRoI7L4FKkV6moXgKXCm751MzHmIWHqE35TUAbwlveiSf4KO2OBBGZRcdSXgKo5iV7goiXvVG0+dhHVITaUeemTLUbKONtZPZCxBaQTLVJaSO64o91Zer/05rYhU+p0HQVbcL1oUAS+iFVoUMIohc2cJPEFMyYA8VHCG9K1cqIE0FsDnrWm6lfW5arVuV12TMX8kk9YMV/q3UOIrBO383JfceLbH2SKUy2EeUgFZy/CG/Fbs+NoVs9HTDrDtSW1VSzXag80lDeLn4sg/ZVVbjzLAeR//3qiPsBfAzPA9UKoQYBx3XNmjkOw6shEFID3WjmNRRehZUGW4vt5vOMjdF8n+R3q8ydnUV4yohwj7/sHkKD/WhbFQfsNvxZtWxWK+7cvXpQVwlWmxyigjUQrJTjPsLXMLEUSSGhgMMaAqTTSlL0VnOL8fRZp579+QZO89X+wRzORy566yl5imJZDBLtm8xobgZBuur/qE1zBYhohYx6Ul948P/W/fbyBFB1GQ/k0eI=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(34020700016)(36860700013)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZxFz8WPeFfG9ksoYdrQFM7tB4DIhVNWNLHVp8R8HY/8OqSlBLXAArw4n5WUQDbWxGmPf7MnOQn8BXjDuYsNSsmhPo1QKCqALIr568YhSaZrIJFoE9UbLP+69H2w5f3b5w1u+YSQD7VqIymMi16R1qMUyTrrfNTLMT2br/QtNHTvgD8aPgqAiaeeHAMAF/XBiXpsMJLeMsWAkUuo2sB6MPHx3hleJQCcdVsQoX7/2yDMQqV+Yo0eZJdJNEc0I2vLiurym3yK95AhvS1ta4ueAj2eCk/cYDo5NqQRcExqKmwcqPEqwq7hBJPm2uNW5IFglVuLVJY3Ng6mtgLpn6KQSX0M4w/Yj7QpGoOv0sO+ENUL/l41iMl3ZgMGEVcXrehgwxtI5PvM/RA6DWxCE6Y3JyFCBkFnyXpaaFodB368RIvFEpaZNTmKMG8ZNXyg5E+wI
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 23:09:54.1236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebea2066-b8ba-472e-c0db-08de758c26ea
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7324
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



On 2/26/2026 5:08 PM, Bajjuri, Praneeth wrote:
> 
> 
> On 2/24/2026 6:04 AM, Siddharth Vadapalli wrote:
>> Hello,
>>
>> This series updates the resource sharing for CPSW PKTDMA resources
>> of the AM62AX and J722S SoCs while maintaining backward compatibility.
>>
>> Series is based on commit
>> 4f70106beaf Prepare v2026.04-rc3
>> of the master branch of U-Boot.
>>
>> The updated resource sharing changes made by this series have been 
>> validated
>> with Linux running on the A53 cores of both AM62AX and J722S SoCs 
>> verifying
>> Ethernet functionality.
> 
> Chirag to comment if this is critical for 11.02 Release 62A release.
> 
> Siddharth, Is there a jira bug tracker for this ?
> 

Tom, U-boot ML,

Apologies ,

Please ignore the comment above. Was tracking the same fixes for a 
backport LTS baseline.


> 
>> Test Logs:
>> 1. AM62A7-SK:
>> https://gist.github.com/Siddharth-Vadapalli-at-TI/ecc69e5d9cd3f09ca767bc2108ce1d0d
>> 2. J722S-EVM:
>> https://gist.github.com/Siddharth-Vadapalli-at-TI/d5b3509d548be194fbafb41480a6c15e
>>
>> Regards,
>> Siddharth.
>>
>> Siddharth Vadapalli (2):
>>    board: ti: am62ax: tifs-rm-cfg/rm-cfg: Update DMA resource sharing for
>>      CPSW
>>    board: ti: j722s: tifs-rm-cfg/rm-cfg: Update DMA resource sharing for
>>      CPSW
>>
>>   board/ti/am62ax/rm-cfg.yaml      |  74 ++++++++++++++----
>>   board/ti/am62ax/tifs-rm-cfg.yaml | 112 ++++++++++++++++++++--------
>>   board/ti/j722s/rm-cfg.yaml       | 124 +++++++++++++++++++------------
>>   board/ti/j722s/tifs-rm-cfg.yaml  | 104 +++++++++++++++++---------
>>   4 files changed, 291 insertions(+), 123 deletions(-)
>>
