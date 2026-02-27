Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5976FD7F91
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 10:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B07883AA9;
	Fri, 27 Feb 2026 11:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S4swu1F8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB21283D1A; Fri, 27 Feb 2026 11:54:49 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azhn15010054.outbound.protection.outlook.com [52.102.136.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 617A183642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 11:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjI1U15BPUF2t/5hLclpcL0JLtpiGK12ANLiBA+P3GgCtj5KAJHaC+wXKulD4ua0KsrYrFrqXqCfSKxUonXFQiYeapHcCyZAt3+GRtYQs0qZaJWuj/jm+v2BMFC7moTwbtaD37ija7CC8+4R2HxFbSMliJoEMOFi6ZTM6sVt08PMeDg9o+BGN2mzZIF1bciuwUzyV+i448jmiGILGFjWXYg0Zlm9fLMXl5l8xTIzXjbxYmXmdR+lSq3ZlZRDXQAoxT17BGxCmsAEaVX/SSxisjGq1NFcF0mUFlNrj5tQfCR3hoccCbXHcRLCwCYCz344MzN49xi0SdylOi3xtHB/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiH64pXl89kHj77HB0Ou3ACnA9ZXZrMtwCxZISA9EZU=;
 b=DoFdZjq9WIt1s+0SXbCYp24nMa9x6t/pdYDeUTIXwTeozRy66xepfLUh2S0vclGu86ZHRotcROGDZ7e0o9JHC1ljlwZia9fkohpOlOn4+YkcUvkO+N6BIAVWPZhjed3/A55k9wcRF5fqNSXviLtuym6dgskB89m53gumTU54C36ouVDPzo7Tr4VvmwxHy/tQ8lh4Uv6kwXmK2oykjiiO5kBhE/m4EyKBklHDX7lomQwa6cyI8RtqFPjUBuzlKKdO6jfNH0h3G334eFR+L3knKfUwWYyfzSLcO53Asc+j1PoDLqCPfUJ11FDxxT/BrE3H483jgN9ifmnF6g4dGGI7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiH64pXl89kHj77HB0Ou3ACnA9ZXZrMtwCxZISA9EZU=;
 b=S4swu1F8zlT0AJOktQasz+YxdG3HiMiZknyLcL+rolDsGENArXd9BJHnkGMOWMq1tDTrclUovgD+w+PwNsQAPP66Rt+VgbiHqNpe6JOfmyJMDBSuy9xYaxlgtGI73hcKLldxhLnLpOSgJxbRB6EtfD5E36CTiSlNbKKYSC2sgv0=
Received: from CH5P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::26)
 by SAWPR10MB997789.namprd10.prod.outlook.com (2603:10b6:806:4e4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 10:54:43 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::26) by CH5P223CA0012.outlook.office365.com
 (2603:10b6:610:1f3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Fri,
 27 Feb 2026 10:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 10:54:41 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 04:54:39 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 04:54:39 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 04:54:39 -0600
Received: from [10.24.51.125] (ltd1nqfk3.dhcp.ti.com [10.24.51.125])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RAsbaC3613567;
 Fri, 27 Feb 2026 04:54:38 -0600
Message-ID: <6c7588a2-254b-4e26-9174-925b1c66619c@ti.com>
Date: Fri, 27 Feb 2026 16:24:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FIT Verification
To: "Francis, Neha" <n-francis@ti.com>, Nagabhushan D
 <nagabhushand34@gmail.com>, Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
References: <CAA-ybFQ=DbZzcGq_=HLFx_Gp_D1YKj=oKYXtD0HKPuVYcQyyoQ@mail.gmail.com>
 <CAFLszTisAAQJb53Z9bifbMd9fQL-1iXnmbsyZMRDovAYYF87oQ@mail.gmail.com>
 <dfd8356a-2e93-47e3-883b-9605173a1db0@ti.com>
Content-Language: en-US
From: "Chawdhry, Manorit" <m-chawdhry@ti.com>
In-Reply-To: <dfd8356a-2e93-47e3-883b-9605173a1db0@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SAWPR10MB997789:EE_
X-MS-Office365-Filtering-Correlation-Id: f9af9559-6e6b-4e06-757e-08de75ee9c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|34020700016|82310400026|1800799024|376014|12100799066;
X-Microsoft-Antispam-Message-Info: 9WNMNWooFSepEXUIpj67cMv1gdVuPXD4YckrjbnBEzn6zDo7SqKg9cBVcSAHW6kw1qnZauecdM7qD1BfCTiRz5VbXpectJ6JaQo6/cgnZVzn2QCIUUfEbTjLjfAUBbF+v5iWs2CMPgWVlDIp2Ci1jbSwl/TsicxZHcNvDjSmRGO0lxFsgUSZuoz4re95ApUefkJYoWaj61bmQQYlzRdCdw4j7ko8bwX2XH7hUn5mJ3Qbfi3GzN5n6+9Z3dsLoUp84ET6hwJyhhcPB4IbInTixm3lNl1cXrTKaAQhmZNBr3pU/2av7CJ++ZJgNiTOawQKsx2olCHyaWFhRzjwHzqtJcM7Hu15msEQoSaQjle9doOjrUYRivCtvHJ3IP30Q7lHqjWl9wIyhKNRkTtJkSefjzMNAPxoG+awHfBPbbrNFaV1zggwOfTK9kCpGfVaZhnRGejofIYUqA82mZhsfq8dom0aF+kxqLoqSmN0f7pSz3p79hwVyfSHiZXFxF1oNS7vXf2O1KEIZQDgIXrRZqpVkCc6zm+9MHP69+LGKA//dlNnXXfQzdYqBkzEzXzCYar2j6JbLd/AxHYm5RwT3t4gmBXkUMw+Cyp5yQR275FZ3QYG2lCBBJlctHB5lLC0TapUyz4U0U9ouXBvIQJBKnypzFldGeSCikFo7XFjKgiOf0esYmr1igom5pfyQZkX7EpF69WlqNwWTJJ1LaOi2Ljz1PgQmGjz8T+mLNyL1akiBC6zYWAysR1EcukzyBysMbG9q/V4ClChnqqS7xnNovcXh81DwLs8WeaXk/aBv0fBLAI=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(34020700016)(82310400026)(1800799024)(376014)(12100799066);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +MrZUHsakqa32eYJMxf74OKAKZRVZ+Tj/ABhPn6GKpuSEE3tbZNK3NICIThdXEnPHOEmnstIwoFYmEWh5Z8rwGRGLad5SW1zG2XrHxQ05hpb4ryDnz3OV9v5hBJRqkH2BhBxqazByo902h1BYkbSbKuYvM/RcaL6FX5p8DpSbgmAXuq2Nbfc/Mh8Zo+tWSwk1DGGjCh9zQg/YQZXVS4xu4EwvoQjMCWbTKGT9UvalTIjoaqrXki6Ba+v5IuxHFJMY5c6N1PvT7t8GdugoH07TIpJqt5jkTwiHVUW0UzYGKfnseDaXfGbHZCIKiXKMHysr7wM+GJIWyH5vC8X7vvej+EH+2mgWDjUIc5RX6IparKNKyx9SukM/TBp4o2hQ4SttbzPlUwkUbYFrc63f6aSRnhBjk6vJT7NZUT6VOqsPekzR/mCj7NlkxvSQUlJeenI
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:54:41.5161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9af9559-6e6b-4e06-757e-08de75ee9c2d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR10MB997789
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

Hi Neha, Nagabhushan,

On 2/27/2026 4:00 PM, Francis, Neha wrote:
> Hi Nagabhushan
> 
> + Manorit do correct me if I'm wrong
> 
> On 2/27/2026 5:14 AM, Simon Glass wrote:
>> +Neha Malcom Francis
>>
>> Hi,
>>
>> On Wed, 25 Feb 2026 at 01:54, Nagabhushan D <nagabhushand34@gmail.com> wrote:
>>>
>>> Hi Team,
>>> I am a recent graduate working in Embedded stream. Currently exploring secure booting on TI boards. I went through some of the writings on github - https://github.com/ARM-software/u-boot/blob/master/doc/uImage.FIT/signature.txt and other sources by TI. I would like to get few confusions cleared by this mail and thanks for take some time for this.
> 
> I'm linking a couple of links [0] and [1] that should clear up everything if you
> haven't stumbled upon them already.
> 
>>>
>>> 1. Can I try out only fitImage verification with hs fs boards only?
>>
>> Neha may know about that one.
> 
> No, both GP/HS can enforce fitImage auth (check FIT_SIGNATURE_ENFORCE)
> 

FIT_SIGNATURE_ENFORCE is something that wasn't upstreamed.. it's 
something internally that we had tried to flow flush it and just left it 
at an RFC stage [2]

But to answer yes, all the keys and everything is contains within U-boot 
so regardless of HS/GP or whatever device, it should work fine if you 
follow the guide.

>>
>>> 2. Can I try it with ti dummy keys or any other way to know if the flow/fit signing is correct?
>>
>> There are tests which check signature verification using sandbox,
>> which might be the easiest way to try it out. See test_fit.py
> 
> Yes sandbox testing would work, as well as building with the TI dummy key.
> 
>>
>> Regards,
>> Simon
> 
> [0]
> https://software-dl.ti.com/processor-sdk-linux/esd/AM62AX/latest/exports/docs/linux/Foundational_Components_Kernel_Users_Guide.html#creating-the-kernel-fitimage-for-high-security-device-gp-devices
> (this is our SDK doc, just in case you need more help to follow along, more or
> less the same as what the upstream docs talk about)
> 
> [1] https://docs.u-boot.org/en/latest/board/ti/k3.html#fit-signature-signing
> 

[2]: 
https://lore.kernel.org/u-boot/20240111-b4-upstream-fit-signature-enforce-v1-1-2b91be31866e@ti.com/

Regards,
Manorit
