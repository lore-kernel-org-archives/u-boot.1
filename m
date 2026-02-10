Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0C0EB26F5
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 18:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBACD83A5A;
	Tue, 10 Feb 2026 19:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J2rrm3GE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D7AF83DEC; Tue, 10 Feb 2026 19:18:09 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 999AB802C1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 19:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNYjeiRpsdCPdGk4EQlCBAEY/HTzsw+AlI/8LurDy6J3R8X7z26loWHGxZlkOuIIcPOHFyNr64enuSWGSsI+qAiW62nI+qevtgIu2QEs1GhUofQcFThj/z6K2z1skD9YAZGUtgVKzl10LOrGaShwMNHtlufMuS8WSI9yDFhwHKmZLLN41RsdoKXsv78FaLtqRRngKdk4rmxE+L2uMy3+IP6XiUlbmKxVHZblGJwgCW3SGMHVxw32lDE/X29E2SmtBkm4XXs1pa7ph90dF+Bg5O5DUX5CcW8mWwCK9iZkPWMvPAdBrBdJCmvKLjEzVr1awe6t5Kfl+F/QsxHkET6UFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpcF7OoDak2uSQTyFtRInOp+m46KG57Sp7kNkpfTZuI=;
 b=D+MhHjAo9HsAqEcvBCBPtfV9iC5knP6NrypycCaFm5vAVst+hZPKRG/dADSdtm0RSLOU/lh5Bv4vcnwCi8GhHWjQS3V8zS+jGgDvUTaO8JqhrH1IyGeYyRhjOod3V1fKRMWO7MXJ1j+4gIayIZNw/AmvgoG/6oQXJdM8nce/bChQen5OtAZCP5SANsQb1mHzVVSd/VusPP6xRvB7KLw6I/RlOEYuHQH6Ze+VolDradrYLLQcs22W0iw/FoVs5PBtv92yaZyXWnvk+bt6cBBSr8Wwwa9aXim/6kkST9DhPhUnvBAnoi1O7RZapfPdz0xCSUkszqgjiGZzkl1XRtkCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpcF7OoDak2uSQTyFtRInOp+m46KG57Sp7kNkpfTZuI=;
 b=J2rrm3GEblFWAzlyPqhH4Hu8vdgZzEco8tO5ohWVSi5zrSAvOOBnLE4n/eUw445ZM4HV4jHAgPAewXUrku6myqoGedB2I5UNm6mOFaIriLMnsyXtAr9Lblg+gasZ1GzuzhUh1PPxS0wbVQq3EpNRV+ZremMnt2LKySVDbgKyvBU=
Received: from PH0PR07CA0011.namprd07.prod.outlook.com (2603:10b6:510:5::16)
 by PH0PR10MB4645.namprd10.prod.outlook.com (2603:10b6:510:31::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 18:18:02 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:510:5:cafe::d4) by PH0PR07CA0011.outlook.office365.com
 (2603:10b6:510:5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 18:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Tue, 10 Feb 2026 18:18:00 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 12:17:52 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 12:17:51 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Feb 2026 12:17:51 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 61AIHnZL3998340; Tue, 10 Feb 2026 12:17:50 -0600
Message-ID: <6f2fde68-e68c-4be6-a1ce-b000dd22c054@ti.com>
Date: Tue, 10 Feb 2026 23:47:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Update DDR Configurations
To: Tom Rini <trini@konsulko.com>
CC: <vigneshr@ti.com>, <bb@ti.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>, <s-k6@ti.com>
References: <20260203063529.1551907-1-s-k6@ti.com>
 <141c6627-6ceb-4bd7-871c-d2828887e28c@ti.com>
 <20260210180814.GB2728096@bill-the-cat>
 <20a153b5-3691-4517-bd81-b8f1968310e1@ti.com>
 <20260210181508.GC2728096@bill-the-cat>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20260210181508.GC2728096@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|PH0PR10MB4645:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a27090-9dc6-424d-dfc2-08de68d0b984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djJiSUxwdUZVQXQ4blFhVWppbTJqSnRvb3E5cVl1bHBlTEdranRsaUNVd2hE?=
 =?utf-8?B?aEI1NngvMyttTGdWakNFbElUSEVSMllHSXQrWkc5Nmt2czJsa1pNcXN3MStJ?=
 =?utf-8?B?TXppeDV5VHAzbm9heiswNVB6TE1vcUtPNVpkTzBpcFgraWZSOHllZ3NjTXk4?=
 =?utf-8?B?YUdHZDY4aEdjaUZyM3lHYXJtQWRUc1lQM3FRcDJTaFI3ZUlwWi8xT1B5aU5N?=
 =?utf-8?B?MERveWtYYmhrL2ZZdzJrblVTdnBtaWZIK0l3OU1nTXZRdkV1TzFHaTdtdHln?=
 =?utf-8?B?NitrVEF4UzBkK1hJRjRzYkZtc0lUVDhkNzlnUEZhbUFQY0ZOaVZvbi9lSk41?=
 =?utf-8?B?T0h3cmIyZTViT0RJWS9pck5TWFlQMGp2ZHQ3K3gzY29vSng1RlJjRktQQjNJ?=
 =?utf-8?B?Vm1ySDhlRDVZQmNEVUxGSERhNlo0QkY2RjMxdjc2dVlnT0dIa3R2dHdZRDg5?=
 =?utf-8?B?eUcxK3lTNTVoYVAwSTJmWUJZNUdZWU5pWWdEMCswdXNjV3JzMmFTTzZDRmxo?=
 =?utf-8?B?YTBWc1NnQyszQzhHQlppR0RPcmtiVm1LTU9qWmtJY2hsYTdhbnJlRlppaEpX?=
 =?utf-8?B?bXFkQkQ3VkU5dVhza2ovczhEWGZqVUp2dTNQQ0p1UDI0d0dsUEt2YSswQUJ6?=
 =?utf-8?B?ZUhVZ1FhMmJGZW5ldmQvWVNFOXNockFHUlo1cWJvMk9aRTd5cjJWWE1QMEIv?=
 =?utf-8?B?UXA3RmZNMFk0S0VyNTZSSDNqaitZMGxkcXlyUHR0Z3BxVmZXVlArRWpGbXN4?=
 =?utf-8?B?QlkzSXVQbCtlN2Fjc3EwYzVyV0ZCT3NIemFRcGdaMFd0VmtWbGJsS2RSNTM5?=
 =?utf-8?B?UDM3MnQ1Wi9rcGltbm1Sb1g0eHVZTWpIT2Zuamp5R29vSDFDVVdEVm5PMVNZ?=
 =?utf-8?B?MVRERFBhQ0FPcnFqMml1di9wVEtjcmxraGxKdjBkeTltaFpIaG9iL2t3QWV2?=
 =?utf-8?B?NHJ5Z0lLRWJzOHEvdldzSXVQK01GZm9PSG1uWmdPS2N1bzFNbHA3U0dDSWdp?=
 =?utf-8?B?eHVERWRXdyttbE1kZjVZLytLNENKWFB3WmIyb1EyTXFMdTNCbC9CajAweVV5?=
 =?utf-8?B?K3ZUallNdmJjbW5acjl2WWIvUnZYTytYUkowMXlsN1FKUE1TMG92MnM1Sm00?=
 =?utf-8?B?MzREb1BNcWwvZkJxV20rOFYwWTNNOEMwd1lOZHVEeldCcnpuVDVpNEl1bEND?=
 =?utf-8?B?bVU2R0c4M1JxOWxsNUJ4S2xEUkl2K3V4NUFkTGp2NDREZzNqSlM3YUh2WDE0?=
 =?utf-8?B?TGFNSkFwZFFtV052RDBNSVhOVGgxOTBvOGZTM3NTQ0prV2x5NG5GRCtTYlIv?=
 =?utf-8?B?ZFpUMzQzajdEODU2ZFcvVEMrREJnZ3hJSmswU20vMVdWMHMxRXdRQWpWQ3JP?=
 =?utf-8?B?aVRESWVKWWczK3MvVnlVWTFBOFkydWF6L29JTDU0ZXRLdEt0WE0yZmwvS3lC?=
 =?utf-8?B?eWlJK1E1MUp1WkwxWDliQ010ajg2dWNnSUNadk9DNTBtNkZXSHBwTUdOMEJo?=
 =?utf-8?B?NExZK29JTlJUR1NGMlVWZlZsVXpCNkxtcHRaSzdwbytmNEJwTVd0YTlEdzZz?=
 =?utf-8?B?RzBmM0dDYjZJakRUZExVZ0YrZUtma0lodGFXdzh4WUtxcVN5VHluVFJEckhT?=
 =?utf-8?B?ajg3OVdQVVBNeVhkVE4yZWx2WG53Q1RsOVhvU3FBK0dKL01jTkJMQTNNUlRR?=
 =?utf-8?B?Mnl4MnZtWHhGcENqNklpclVmOTZsclc3Wkk2eXEzSlZWSVgzeS9PZ1U5Umdm?=
 =?utf-8?B?VVd0SndKN3EvYmhFYUd5SWxsbHBEQ3A3Y2FRem9SdC9QdktGQldSeFJDWkw1?=
 =?utf-8?B?NGhKOHZaeFFQTHpQZUJsZmptTHVtS2l6MzE3VXlzZFRobUVoRnphZnNzdEll?=
 =?utf-8?B?TjNJOGlmYnNKeklBZ3BmM0VtTFNOZXJSTGx4aFYyVEx3MEZCTjBXWjRWaFFz?=
 =?utf-8?B?U2N6RElqRWN4c2NmVHc4aGZBOWU0bk9ES2xuaUZZbS92V3RWYWxnSUhDTTBJ?=
 =?utf-8?B?dkZGdzBxTU5zKzFiUVh4dzY2MG9xQkRyQVRxczlvMTlHU29YTW1Ya0U4V1Na?=
 =?utf-8?B?bU15aVJjOU55VkZHOENsRjRvU084V2ZFQzlzYXhjOUtBbHMzS29IWjdxSE4v?=
 =?utf-8?B?Vjc3K2NQczloRHM1aHgwYUFXL2RPZTloSWY4TEVsNVR0UE9yN0xLV08rZzlt?=
 =?utf-8?B?SGM3SzZNRi9hVDIzWkVvUlVRU0VqdE1VeW14NDBJWlJyYm1oV0x5dVFQS2l2?=
 =?utf-8?B?RE5RRlBpVWJVa0tBQnc4TDFJYWNBPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JIBqa6c5tu5dHKdRwnAcS6T25pKRM9Q4sbWbMKCcmVSW32KEMVJsacgZqVd+BVFvU55mH1ceYfMGoiHCu56L5BCh8ksWlkNtSuLJJoo87/QQ4jKkFXofwBQXU0rCjiTlYyccM/cy9Oiz3KFSZiiCaBF5/1Ky1VqiLYVd7wNhsThJz4zzBkjpmY5Pke1yi5D5R9kA6oKI8GcmnSD7kI0KEFpYjKlk/sfFoOj+lxvXzXKxaK8+Dcu4qzAgZICgYnCqK0EusRzrKys9XYImns+6ek9WXl/MOgIXZdVEw1TKMUxFi3kNEHqbdqYba2QbUTVnaS4qlI1ahGcHPxTPKTvY+7r5FX0izZY4ESad+xGc7Yt8qaH6KzIxZnHaLXpmmp0I2J+JIddMDgPi6/AYBPiZm0sPYnIJ+3Er/RJ99eTMzvzvbLwKDT1Ft0lDU0I/qM8b
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 18:18:00.6867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a27090-9dc6-424d-dfc2-08de68d0b984
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4645
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



On 10/02/26 23:45, Tom Rini wrote:
> On Tue, Feb 10, 2026 at 11:42:34PM +0530, Santhosh Kumar K wrote:
>>
>>
>> On 10/02/26 23:38, Tom Rini wrote:
>>> On Tue, Feb 10, 2026 at 11:35:02PM +0530, Santhosh Kumar K wrote:
>>>> Hello Tom,
>>>>
>>>> On 03/02/26 12:05, Santhosh Kumar K wrote:
>>>>> This series updates the DDR Configurations according to the SysConfig DDR
>>>>> Configuration tool v0.10.32 for the following devices [1]
>>>>>     - AM64x EVM
>>>>>     - AM62x SK
>>>>>     - AM62x LP SK
>>>>>     - AM62Ax SK
>>>>>     - AM62Px SK
>>>>>
>>>>> Testing:
>>>>> memtester - 50% of memory for 10 loops - PASSED
>>>>>
>>>>> [1] https://dev.ti.com/tirex/content/Processor_DDR_Config_0.10.32.0000/docs/REVISION_HISTORY.html
>>>>
>>>> Gentle Ping!
>>>
>>> Is this required for v2026.04 or is v2026.07 fine? Thanks.
>>
>> It'll be good if they go in v2026.04 as these are some critical DDR
>> fixes.
> 
> I'll pick it up soon then, and this is a reminder that detailed cover
> letters help. Not just that you updated to the current tool output but
> that there's critical fixes or what-have-you with this update.

Sure, noted!

Thanks,
Santhosh.

> 

