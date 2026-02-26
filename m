Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E31FD9E1E
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E6083E61;
	Fri, 27 Feb 2026 00:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="txwOi40p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F23383E63; Fri, 27 Feb 2026 00:08:36 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B5D183AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=praneeth@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lawon8vJn5q4Q1paakUG6E6iN/nfj/ObCZj0l0LqDE0yc1KrZPwSKyflZEBj51smdZl1vaUgb80l7+KzO2M/0+AIGCtXBwGwJkxx9fWPQp2hk1KVNtVE8H0lKPbjmaPt4CEslvage66vdXRclcfiCMoctI0IAfEtjL0FRLZLu5j0LSxFI6WUlEFbVp/mJpffo/Zvjc/oKB76onnikE8aFqwV9Z9ynbtGcF6Xrlk9zGOCDO5lIVgAAs/RHuoqL4DsXCITTYaYiWmTsQAbDW7+lPna0gAfJSCskv7PclAV5vZuteTGcoRi7GBkYfyGL1em8E8SpZbeLokMAjXozH3lPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+8RKwoMHtSCDKyDmpgmDLxXpoFYMrycqMMUpRWCdM8=;
 b=EeoX4k05nWjhBY2nbEkuFA762Slxueq6Spp/SscKEDxP4UBc3tIhVIPfWJmKQvSoEnNOfS4Rdqa+XBqWiX8Q9CzX+0yZwD073hBiwCxZCse6JGeQUjoHQW+B8PTcWddRJKTpTdQ4ayCR7M4SSrLxHpFkI3iWdGF65U21NVHbX2yX0ZVeQX9cigjA0NrvWatE2mRvRTB3tVprOVZno4nNGH9HV29OIbDBzn8wWt9Fo9dcWDS7yufGpCppEn7EcvRwECY8UH4KRLMl4KtqzkzlnJM0HACg2vFceYKfdtenxi1bmHfkG1wWDDiHCRMu9japMA1r2ZojakgKXZ1bJ72C7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+8RKwoMHtSCDKyDmpgmDLxXpoFYMrycqMMUpRWCdM8=;
 b=txwOi40pFUhVCrvluqCNQOzvylDSmUnB3JOQTuHz6y3kZXrYCnqjvrHiaEN9n0JjMa3C2Mw0MZrmqvPmQtddFyfoM3SMyeNCFv0uRFSioAB0s7H3HDy5sFlHIiNHbi2IFxGrh0lMzXQIQni9KxpxCmRtfUUTj6F+R/wcIMhr4bw=
Received: from CYXP220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::9) by
 DS0PR10MB7978.namprd10.prod.outlook.com (2603:10b6:8:1aa::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.13; Thu, 26 Feb 2026 23:08:29 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:ee:cafe::88) by CYXP220CA0005.outlook.office365.com
 (2603:10b6:930:ee::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 23:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Thu, 26 Feb 2026 23:08:29 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 17:08:29 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 17:08:29 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 17:08:29 -0600
Received: from [10.249.32.53] ([10.249.32.53])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61QN8Slt3169496;
 Thu, 26 Feb 2026 17:08:28 -0600
Message-ID: <e052a1e6-2aa4-4ecf-acab-87e5491d5f93@ti.com>
Date: Thu, 26 Feb 2026 17:08:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Update AM62AX and J722S CPSW PKTDMA Resource Sharing
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 "Shilwant, Chirag" <c-shilwant@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
References: <20260224120557.1476390-1-s-vadapalli@ti.com>
Content-Language: en-US
From: "Bajjuri, Praneeth" <praneeth@ti.com>
In-Reply-To: <20260224120557.1476390-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS0PR10MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c85939-26e1-4e4d-80c7-08de758bf48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: +v6pJGc6c9tFuFlEJqOul9iYKlBJMNUoZO1k69zZHoOE5pm4X9rrfpAp7O44yibWmXj0N1YZhvjF+PgVHoQ/x7BjhRh/Dsb6qWSyE9sAEiboPB3MAnXjaJlrxGTGURR9pArBuOSFwun97P8WPA35en6qoNRF89734aHFo1fGxZskscZBho7jCL2HYKwZOt91JLm9KayCxXJBtOVv041XiBb+P9ysrbuA9X041rrOW/18FVEysNEbQU6bU3E1yTeG0swLWwkemFPEVCWo81uhyW28wlCc0j2CjqGjMJ5pP28oaqx9oX6aNU+dAvtuIqZTdu3UOn9fg+1Dh3/ERDN1LnIeOrlj54N9rh0B/vvbeAbbMDLpzSwDQSLJp1+fpjpZtRiISIK+nEeZKHOLsPjxzwHmYAq8ChEOVgrHihZfVg2MBfapZgcDSaAJZWm32hsxe9MvWzXbIgOHHlNX8tgHCEC1HEIb4XYD5Dd6ZFmW0LDe9JCpMOctGtBOXXEThmKp3NoiQ0Ew48L6WLdTPewBJwSoTrca0ooSxy0H9plmtj88s8qJn6iD3kdweQXWQZxqaTtJiTEjsyPUQ57mGkM6JijIcN3kAprCHgxRm+g1F+O9fuwmodtzLlhNxOf7kWD7LAiZ80R9P03UlGnTkiW57qqB4ZJ64kGldsBffLsjnKbX8Y5si0D311di8/w6m8g4mlUtReVx3wkvCxGD57SZ3EKY0HvzqDEhUWmHxDffpaaXFxexclIHV3pLYSEyFfr7IfExosnuhG/xYJ6a+3t2sggiE5uiTfyZ/njBln3QMes=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(34020700016)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mrBy3EupADVPoJS6J+C60HCj9toPcdtIVVTm526SxBU9xVZblYYeNYKbMsMzToKg9t0HlCJvkBMZtrB4yQS7n3bUOY28MebEAx2doTkBih3Z4LSOa1H2G2Prx2TEyrqaJGRkfvNSxJGuzXCT26CzxxclsCVQyOhLdC4ZgsPS+6CxLF1docp9aUYeQzk2ahAf2l/KXUsQ7hyJlWJig6okjAelA9ojXQ/1OC7iYhCtaXKi5dYs87brgFZqp9bOHzvkTnZteL9FwgTxCllYLlZMoFVruJnuvwMWAv33kZHwlLaybzoNrvTcLx4fTBV6MBOVAoiAEWKnlnZ15nccshntzCiUBVbJ9XDF5+HlP4TCR4J1LBGL6iw1IASnAENxXroPJUx7MEg8QtuZ1gp+kRBDSMjysw1BgNN1CHnFViPhwqT/BvNn1JtMdEQxJeQoEdkg
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 23:08:29.6272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c85939-26e1-4e4d-80c7-08de758bf48f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7978
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



On 2/24/2026 6:04 AM, Siddharth Vadapalli wrote:
> Hello,
> 
> This series updates the resource sharing for CPSW PKTDMA resources
> of the AM62AX and J722S SoCs while maintaining backward compatibility.
> 
> Series is based on commit
> 4f70106beaf Prepare v2026.04-rc3
> of the master branch of U-Boot.
> 
> The updated resource sharing changes made by this series have been validated
> with Linux running on the A53 cores of both AM62AX and J722S SoCs verifying
> Ethernet functionality.

Chirag to comment if this is critical for 11.02 Release 62A release.

Siddharth, Is there a jira bug tracker for this ?


> Test Logs:
> 1. AM62A7-SK:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/ecc69e5d9cd3f09ca767bc2108ce1d0d
> 2. J722S-EVM:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/d5b3509d548be194fbafb41480a6c15e
> 
> Regards,
> Siddharth.
> 
> Siddharth Vadapalli (2):
>    board: ti: am62ax: tifs-rm-cfg/rm-cfg: Update DMA resource sharing for
>      CPSW
>    board: ti: j722s: tifs-rm-cfg/rm-cfg: Update DMA resource sharing for
>      CPSW
> 
>   board/ti/am62ax/rm-cfg.yaml      |  74 ++++++++++++++----
>   board/ti/am62ax/tifs-rm-cfg.yaml | 112 ++++++++++++++++++++--------
>   board/ti/j722s/rm-cfg.yaml       | 124 +++++++++++++++++++------------
>   board/ti/j722s/tifs-rm-cfg.yaml  | 104 +++++++++++++++++---------
>   4 files changed, 291 insertions(+), 123 deletions(-)
> 
