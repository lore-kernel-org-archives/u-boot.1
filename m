Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A585EFD5335
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 10:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20BD083AA9;
	Fri, 27 Feb 2026 11:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AeH6abnD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C9183E7A; Fri, 27 Feb 2026 11:13:21 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azhn150100002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d91c::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E2B183642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 11:13:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kakd5IQDOwqcdufNU2cNlj/TMKiTMo7a78l/uWGLXeZXHUYgwxH4srUFWdB4Kr597iSq/JAbHBz5uNNnRmvNVQo0J9zePZTmuyvbHYqbS+gvUfm4K1cg3eEMQmu0Fd72p7a80+sW8DowfbRLorjElq9j7dTfxy2oVyFw4OngSyl4cXZu7NBjhnedgG2ciqT0ImFiVAV5lDTHVazDMIOCmuz3S+IvOUJU25b/dwf371slQOLlOrDjHZR3KXhQGEc+UryUbwV5mA07XlpLWpYlqXdW8P5jcZbzv41AVArU1zXOuqoirs3irWiREmZhqMH8ZOPFNPv3krfc/XsX3Y6bhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6WFWI0nOh9GTTo1aAc40NOtijh/Iw2ptb9zDtb2ZKU=;
 b=LwJQEH8adYr22R0TR+NhnCEnQYKHW3w4ce8Ndjtq1FXzz2COXZ+NOJov2+dR707HbbcOUMNYrOcngkrzp57kEDpC6yeIBhnRIOkRO1byIJT7wcvUxLXvREsj/r+cZfA/PgRCoH/eR2VUfV52PJlWNpxaNbXSD+HBWisst/daqHQtA6fEwK+Sr0BnkWUibebYion1nFw/6ZYc/JLxyZ3VlHOogEz/8QWAAOIOOuoVKxzB5LIkZBDZ9S4CcU7qB28WEw+29P1Q+nMRqeQX1No4Yw6oz0V1+inU8FynGRoSaSef+vyx6crRaeGF0IihhVFAP1F7j7lyvxG8G3qOT+SYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6WFWI0nOh9GTTo1aAc40NOtijh/Iw2ptb9zDtb2ZKU=;
 b=AeH6abnD+R8itvQukcNeZy/vWWhFjy2Lg05m7nAG+jjcoBnthjOoGkNVlWYs1WNrlZy1yMmMHBvRnqj++NHa0VLk2Yr14NlhsQ/aWlz2PTEG6L+odQan+AIA/JhsdYyyUCzBxuwp5nr1AZ1uy262flgFrCBrgk7bcYsuFcVk8VA=
Received: from BYAPR02CA0070.namprd02.prod.outlook.com (2603:10b6:a03:54::47)
 by LV3PR10MB7940.namprd10.prod.outlook.com (2603:10b6:408:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 10:13:14 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::12) by BYAPR02CA0070.outlook.office365.com
 (2603:10b6:a03:54::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Fri,
 27 Feb 2026 10:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 10:13:13 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 04:13:12 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 04:13:12 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 04:13:12 -0600
Received: from [172.24.18.150] (ltpw0g6znt.dhcp.ti.com [172.24.18.150])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RAD8HY3560148;
 Fri, 27 Feb 2026 04:13:08 -0600
Message-ID: <c8e7db77-5c9f-490c-a5e5-30607fde09aa@ti.com>
Date: Fri, 27 Feb 2026 15:43:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] common/memsize.c: Fix get_ram_size() original data
 restore
To: Tom Rini <trini@konsulko.com>, Stefan Eichenberger <eichest@gmail.com>
CC: Francesco Dolcini <francesco@dolcini.it>, Emanuele Ghidoli
 <ghidoliemanuele@gmail.com>, <stefan.eichenberger@toradex.com>,
 <s-k6@ti.com>, <w.egorov@phytec.de>, <emanuele.ghidoli@toradex.com>,
 <francesco.dolcini@toradex.com>, <u-boot@lists.denx.de>
References: <20250314100734.23777-1-eichest@gmail.com>
 <20260226070502.GA6701@francesco-nb> <20260226142345.GB1593142@bill-the-cat>
 <20260226160901.GA29510@francesco-nb> <aaB1DifzODCVv4SU@eichest-laptop>
 <20260226163117.GJ1593142@bill-the-cat>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20260226163117.GJ1593142@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|LV3PR10MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: de6da774-2365-49e1-7a31-08de75e8d10b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|34020700016|82310400026|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: WkG58zElV+CX27jAgHNMKhSaVjiEYVzw/iGsrqzOzQI+OHADoPpMEfxVoREWJqugd6HHTIFjjLbRyHBY8Ow48fovUjnNepQQCnoMVFVetz/YAH3H6LRncZaE72L67JpY+3SobIjmxm1fClszgcMU5xbfYgHe20IXmlhXKu+4RIfxFNto0Zkli9W555oaVox6CAgSHuK+lAhehs3wyf6mvoM27hGhfDEM1WsUouoh3V7fTocra8bYSq5wK/KVX4yQ0RyUaSIos/CQwQry/9S6NLxzAKcVp6fPQzAvssBGn4iHfcVRDRaLEEsV0r/3bOS9GQQqnmcR0mVt5QpEGKNuM74fuaYg6EP30EpqhmWzy77LKJ2p7vVjh4V9q+Vxb2ppIwe3OMkvc47QRaizmWiLhrwknP5rlarjssr5aQnRmRVwLG5RaIBV08l8dIF7bfDCnMy1tuomLmOjdkG2RnijyTnRd07nkaSfLh7pQTxrM74nqoCeRd/lCgrwXqvxzmk1TFF62Aph5qvdPqpuT9epYdAN1Y6Fk0B2bhSysa4E6wCktieO5DN6dP0v7gOtIglSC7JcW8WL7yvsR21fTtEIrJ+vxy92Pq4YK2xxT22Ji4I5IkF6hHcJ8ji2ASllKJVfDc2Ez/dgodKNnHJZaFQAzjVpowut/3kVvSC0yh0tAr4H6NCza1yPeHTPaSaKBavVKdrQyDQ6ZTuMwDjruS02XvvBMr17J17xsY8ya9PUODEP4383PWWPNXoX6WCtoTCW0IMazH/Q7ys2jUkxWi6lWYjXdV43VcZzGC1ajurkTb0=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(34020700016)(82310400026)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wYKZwKaaCHbFh8vZAgqjOKCu1B4er0jT3TfdKtnhHc9U4djcwZYC+KmZSq3P2Rj4Kv5n1gciT9m0XivUJYR5N7rIoyqBV05r+qoS3FNGdfI4S43xjD5K6dqzFjX2DHEDxqaADtNKO+gDz7abSEepDR+iTbBXzEW9SfwxUr6MsprbLa00MWRJks5B6IQgM9FLclc/hYXeIxPdRIn3LroSMfscKJvr8isNh2PNMVBRNRFWhfcvr/w42v8oMOkhzJFev/j+avLJ4YVgKQ/oY28W3jlVnI5BvPA/mIC9mlEdRFMvYaX5PhAHr3297N1ZcNOu93s3xEpJfbyq5djyHa/rbKiRWHmwgkF7gH/EymAjUxk7nbjyRmwg4TjcxZDlBbX+3pDjjcO7MiwoQpbSkQw3J2UuiU4n821oZj6fzIRm5KKUq+KIm+Njh87BPHY9zMRY
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:13:13.1875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de6da774-2365-49e1-7a31-08de75e8d10b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7940
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



On 2/26/2026 10:01 PM, Tom Rini wrote:
> On Thu, Feb 26, 2026 at 05:30:06PM +0100, Stefan Eichenberger wrote:
>> Hi Francesco and Tom,
>>
>> On Thu, Feb 26, 2026 at 05:11:49PM +0100, Francesco Dolcini wrote:
>>> +Emanuele
>>>
>>> Hello Tom,
>>>
>>> On Thu, Feb 26, 2026 at 08:23:45AM -0600, Tom Rini wrote:
>>>> On Thu, Feb 26, 2026 at 08:05:02AM +0100, Francesco Dolcini wrote:
>>>>> Hello Tom,
>>>>>
>>>>> On Fri, Mar 14, 2025 at 11:06:49AM +0100, Stefan Eichenberger wrote:
>>>>>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>>>>>
>>>>>> The get_ram_size() function fails to restore the original RAM data when
>>>>>> the data cache is enabled. This issue was observed on an AM625 R5 SPL
>>>>>> with 512MB of RAM and is a regression that became visible with
>>>>>> commit bc07851897bd ("board: ti: Pull redundant DDR functions to a common
>>>>>> location and Fixup DDR size when ECC is enabled").
>>>>>>
>>>>>> Observed boot failure messages:
>>>>>>   Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
>>>>>>   Authentication passed
>>>>>>   Starting ATF on ARM64 core...
>>>>>>
>>>>>> The system then hangs. This indicates that without a data cache flush,
>>>>>> data in the cache is not coherent with RAM, preventing the system from
>>>>>> booting. This was verified by printing the content of this address when
>>>>>> the issue occurs.
>>>>>>
>>>>>> Add a data cache flush after each restore operation to resolve this
>>>>>> issue.
>>>>>>
>>>>>> Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a common location and Fixup DDR size when ECC is enabled")
>>>>>> Fixes: 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size() when cache is enabled")
>>>>>> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>>>>
>>>>> Tom, can we merge this?
>>>>> This is the last bit to solve the regression reported here,
>>>>> https://lore.kernel.org/all/20260224152405.GD340942@francesco-nb/
>>>>
>>>> I wasn't happy with this at the time, and Stefan's last email in the
>>>> thread left me with the impression more investigation was needed and
>>>> likely something else was the root cause.
>>>
>>> I believe that this patch is needed.
>>>
>>> On AM62 what is happening is the following.
>>>
>>> We have a cortex-R5 that is the first core booting (there is also a
>>> cortex-m4, but it's not relevant for this discussion).
>>>
>>> It runs from internal memory and it configures the DDR ram
>>>
>>> We load to DDR memory various pieces of firmware (TFA, U-Boot for the
>>> cortex A53, ...)
>>>
>>> We do execute get_ram_size(), that read/write the memory, and it is
>>> supposed to restore it back the original content
>>>
>>> However when we have the cache enabled, we might miss to write back the
>>> original memory content, where the other pieces of firmware are.
>>>
>>> And after that we start the cortex A53, running in DDR, and there the
>>> memory content might not be correct, because there is no cache coherency
>>> between the cortex-A and the cortex-R. And because of that we have
>>> crashes.
>>>
>>> Stefan: any comment here? Can you help?
>>
>> I think what you wrote summarises the issue well. If I recall correctly,
>> I "fixed" the issue last time by simply calling get_ram_size() once
>> before enabling the cache. This was in commit 4164289db882e. The SPL
>> then informs U-Boot of the memory size via fdt fixup. However, something
>> has probably changed now (possibly in the R5 SPL), meaning the cache is
>> enabled earlier, so the cache is enabled again when get_ram_size() is
>> called.
>>
>> For the AMP use case, either "get_ram_size" should not be called once
>> the cache is enabled, or a similar patch to the one I proposed is
>> required.
> 
> I would lean towards the former if at all possible.
> 

Just trying to understand, what is the reasoning behind ensuring get_ram_size is
not called if cache is not enabled? Wasn't get_ram_size written with the
possibility of cache being enabled (existence of dcache_en logic); then this
patch is a valid fix right?

In parallel, I do agree we need to have a code analysis w.r.t dram_init, we are
making certain cache and dram calls spuriously making this confusing.

-- 
Thanking You
Neha Malcom Francis

