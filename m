Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28310CDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 07:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2481B84704;
	Thu, 25 Jun 2026 09:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="WbvbJeYX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14F4A847C8; Thu, 25 Jun 2026 09:05:13 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 062F180398
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 09:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3HNJrQwtA5jTEUol3yAVXBdj2BHWYVKUz3d47Q5+u6oe43czyNF3N/3ASg1ls5VfOLm12LJJRNBagw6Pi9wiQJti5aGghh7/vSJi0TyfalbmHdrXRW7O/vQGRFEQVax5wLVoik+ZygGsXtVvN6SNqwIRBmXEsm+jClGmNiQ87WK3fxeQWDiE0xblbistlitK4vmIYNLlT9sg1+KukXqKx2g1HEZHqw4TQPJDUGefdrlIiD6OzNpGt2jVp5/LHRh/IiTI84awT6RKhkVhZALECrrC2WrUkj1EEVs/P4I4TsWDBddmGPgxFMtEFHgqTK9G9ZavLlfC21ORHmce3RxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxB32K75D0qxkPzdSkHwLlXjtcmEKom7xsXgExk3ekA=;
 b=RXLuj/B6xVY3qxQaJ0PFrplaDVuIWctMOJlUo3E4+V93NlyoSM8F6q0lEV9k3cjA7ZRSGYR5Yec+wgK6xlb4hKoMdbWzfZvWEu0k9CRS3bvOogwpjXEQmtii7v1wTuH8OEMOQsrW2whN61y2Bkn9aBpVRj6j3afmatrhH/UbF+dxycOzhzN1ZZR23vVJUYz0pA0Q4FyKS1s7ttHUUTnm0+68hvWuih9tCuo9QaaKx8jLSQVVFLq3m4ndyKwTaNqQmkM/UodFSknVlowNQQp51G1ejr/6T2W4ABgRnmMhjYDpZxFG6y7+q8oIPFNDH8/ZC53OxLQxF4xSneNmjyVoKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxB32K75D0qxkPzdSkHwLlXjtcmEKom7xsXgExk3ekA=;
 b=WbvbJeYXhJkvJLw/XaIslPiURtVW3Ybh0zkMlrvS0i3vxTvAjaU018ipcYXNq+8VHX6n7iRDSAuBMt+GQMjoWU9YF+qCCJVr6bAv9+X/Zkh2gV1QHGwcMP9zRVTx/5xdREkad11hQtkQHGC1Hla1Ctu5goXr785hSVTBQMnR4bwuk2p09g3yappMq+zOIZgovLPZNlHATykpdWTksfUK9NIRPFFAiIN94EwOM4wUFJnputD4jlTNw/wj3VS6B7TaRltG30CUtbNjTPQBR9CjFH+iaMoFvtUpBxh0uV8JWliRB1GALBF6n4h7KvsNWZJznftOmoV/GfrrQfB5KucoMg==
Received: from DUZPR01CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::12) by GV1PR10MB6681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:82::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 07:05:05 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:3c2:cafe::33) by DUZPR01CA0069.outlook.office365.com
 (2603:10a6:10:3c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 07:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 07:05:05 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 25 Jun
 2026 09:09:45 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 25 Jun
 2026 09:05:04 +0200
Message-ID: <778a5f76-e7f2-4ac4-80e2-691a706edbfa@foss.st.com>
Date: Thu, 25 Jun 2026 09:05:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Move schedule() in
 sleep_thread()
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
References: <20260622-move_schedule-v1-1-4b5dac252b70@foss.st.com>
 <56316a7d-d30a-48c4-ba07-f0fcd9b5adff@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <56316a7d-d30a-48c4-ba07-f0fcd9b5adff@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0F:EE_|GV1PR10MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: ed77a059-ee95-4433-8cea-08ded288158f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 0zMMpPwQHd2PsSdSqKDtCHvQsU8UVlqOwAo+M+gjyzsqRh8hQNochf3i/bHy2zYRzaeiU46qMbiLudgYwPEa7PB9QUNT/sZabvRp0QxBb61/0gaC3sdaD/2xQ+TRxx5jpSN6Ws4xMMfE3nnDDX4mPwIdiEjV69dhxRdJ1VPCBVItvTyG5/u8Djf5WBUfXCJFRBoO8wHc8gMMpiADBUIhO/TOcBQQ9WyhdN3PB8OmM5IC8gjz3mDeyh2B7tXGEvhr4WabaRVR5remR1et3xQjv0Ndsuzgwr2O+MG13V+5ix/mjm34ArrL7sa5iDTs+u30I/GCWCIrrTJc9E4AWwYq6mS63NsLwbzsgG01dzAG+Clf09vDY3EACPR1xyR+IShRiwHrEM0vthaPPrjp4IprbPUGj/txSqQYws69BVkO7fQThkqqn3Fp1ozYenhEz8HFBfMoIx0p0q1fjxeUeBLxFP7G1zbhASLUVcZCy8qPXbyy60qnJ25rdMI+px8Lhu+GbiXPWQ7Et8AOI+DiJy2r9BOV6oUr65O10cq9TIa6ZVTT7rM9Rm4tLOx8eWMUC9wApyddb+uCQGznhKgIEBoQiqNZOIs1+5iEEwtAK2eZfEuhgiIpoI158BiXS0jx1MEQPyEjrrJC3fDGGMz8JYvQUFB3hqOVSpiQOOu9i4JEe2QUj1vkmnf/MRzOTTMV83MrusCNDS5VHMOjtrXZD07KvQ==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZzLyVIpmrby5vBrpZrxFkvX6tgFdGAwJsmOGhY//MertDiXX1hEKoDmMlS6sxVHUcBFuWBfYu6gwb6HSILeSBgDTJSNFv9Zglzh+XSO38osMt0iJb74dmsgbgeXe1mE6GQHhgGrB+pKqFyGF2mPnTRJDasEG0BuHdDRyfk+xc8fMkpHlHe37AK34wNRrJAJ5Dp+ZytzwhoMFH0U70PXvLsBrHgWRUauH5DtYLHhIER6J2WcDcqieECow55xEMiCUjx16Gh2BHO+Tm7adc4x9LrsE6XI+ZXTqywlVpe0vQg2TbFurfb5AIkwmNSyIoAV7o4H9U/PT6lqd3rhU0CRKpHY8xda+QQU4wugd1rvn6cbWN4KgI2cF1R/MQIypq2OOrzaf6npAj3qv+WPbE9aYRjNVUmdC3R9QFB5BURRkD57Krc5D+Rm04lss7M5fEO4r
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:05:05.1101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed77a059-ee95-4433-8cea-08ded288158f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6681
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



On 6/22/26 20:22, Marek Vasut wrote:
> On 6/22/26 7:18 PM, Patrice Chotard wrote:
>> Move schedule() in order to call it only every 10 loop iteration
>> to avoid useless overhead.
> This really needs more info here. What problem are you solving ? What overhead do you observe ? Why is that a problem ?

Hi Marek

Yes sorry.
I will submit a v2 with the following commit message :

On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
it may take a while to get the control back on the console, 
sometimes around 1 second.

By moving schedule() in order to call it only every 10 loop iteration
it increases the CTRL+C reactivity.

Thanks
Patrice
