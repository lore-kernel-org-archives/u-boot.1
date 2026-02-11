Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4342ECD6EA
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 20:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D031F83A47;
	Wed, 11 Feb 2026 21:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JOohHTEO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7502483B30; Wed, 11 Feb 2026 21:14:35 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A02338367F
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 21:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHZzUw8vYTXBnWLqpB3NNhiyPaqqWxnAHXifxsvoQxLPLI5IS6Wl6bxd1sERRKe6iQKutNePIFX2BGypzoqwJOCI5xi8TGrQyZrCHgBu0QVW6qT37TWS+5z184qFbiHhYGN+PwQ7lzPdYad344Qs0+y8rLR64An/dPIU7Xy46EbNGkeA4V1Jm0RifQ/np3q6adOWRZ/GDJbQfGUggMUWWKd+qrYM91DrMptDP382a0RiteSy/ScpqvDqQrKLwrS4u9OT5JFIV2MjZ/Ca4TqWjPjRZBx6DJOgw6At5DWJbyU1coeQSJjid+qvua/iiudLSfLdDOrPbT+nxegAreIM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpZG8UjInb2igeFVSpHP+rCLN+gE0CaXXygh53LpItc=;
 b=U7z8yTEz2fM6ptHwsdQBnI2qmeZDekXmyiNGUOKeSPt1GKEpmY4rPsRvRQ6+cCIZAHbE1JpGBmw84BGy3SXClviCe2hUA8oefBwesYCMyFhMO0FmDOWZxZxjHedfIhrEGBlwc09FMFJ+apxyiovkHumzIw9NvEYUz4JS0BUzXEeyJWGKunUakOI71dv+rEWJRmGPMYyVxVJsblM9XVERlkOYegpUOkB8mohNe1s8y1/VFTyffIPpUG0ow6P/P2oS/NVi1lYutb1we7g9aJRAaVfWieFoa4jVeA4d61MxyXHd2GS+Uq0lxOyjrVNP20xvPSPOnGO3Vne1eHUrMkNXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpZG8UjInb2igeFVSpHP+rCLN+gE0CaXXygh53LpItc=;
 b=JOohHTEOcMArMDdvpk9/oT+h9fKcESGaMD2uEmq1jsEn3vo1lswmk+JcWJCoOq8yJJC2jvTuU+nqAzkMQA+M/KvUi9iVur9oWUJdq90iIFUsdZCusiEgfzPBF+jorgI7kzMX+Eo4UMRafwHGgA8IIvjUCfQOQ330LcrAg1RzZqY=
Received: from SA9PR13CA0044.namprd13.prod.outlook.com (2603:10b6:806:22::19)
 by BLAPR10MB5137.namprd10.prod.outlook.com (2603:10b6:208:306::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Wed, 11 Feb
 2026 20:14:29 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::1c) by SA9PR13CA0044.outlook.office365.com
 (2603:10b6:806:22::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Wed,
 11 Feb 2026 20:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 20:14:27 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 14:14:26 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 14:14:26 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 14:14:26 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 61BKENjJ2239530; Wed, 11 Feb 2026 14:14:24 -0600
Message-ID: <18724e8f-9c49-4cdf-9ee8-19656bca9e76@ti.com>
Date: Thu, 12 Feb 2026 01:44:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Update DDR Configurations
To: Francesco Dolcini <francesco@dolcini.it>
CC: Tom Rini <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>,
 <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
References: <20260203063529.1551907-1-s-k6@ti.com>
 <141c6627-6ceb-4bd7-871c-d2828887e28c@ti.com>
 <20260210180814.GB2728096@bill-the-cat>
 <20a153b5-3691-4517-bd81-b8f1968310e1@ti.com>
 <20260210195448.GA18714@francesco-nb>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20260210195448.GA18714@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|BLAPR10MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: 994f83b1-bc33-4859-71f0-08de69aa285b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjVpcHNTSmY4SHErb3ZpWm1ZZWZibEh4eGYrTFZFdVQ1cHR6Q1ZlWXl2RnlF?=
 =?utf-8?B?VlJjU0xJNVlXaStvNll2L1hackVkdnFWOGFIdkMyQXNlMnlHNzNTblNNTGYr?=
 =?utf-8?B?d1lxb0M0LzFjbE5hYnVlUmJXeU8yOXdCQjZrYVE5cnJBRnZNd3p0c3NpSkZS?=
 =?utf-8?B?MDNWbVBoTW5WYjM3SVJrczVjMWUyWHNCbHhFVmQ4V0crSS9SalVMcmJjLzIy?=
 =?utf-8?B?T29Nbk1kMGpxZm5BN1YzQXhvKzlIcytqL3cydkhhQTBaU254YTZ3L0Vmbkg3?=
 =?utf-8?B?TUVlZ0M4bmdtRU1LVi9tT09jZUkyNWdNMjdRTGhsVXd2UGJSUEdOV0V2azAy?=
 =?utf-8?B?TG1aRlozYUFJcjhOSGVCREJwL3dEK29LK0U4cDk3emhmTXJGUnptbmZIVWl5?=
 =?utf-8?B?K2d1cFJyZFdXeGpGbkFBMmQyTGwraUNUdTFyN1NlRFFkeEdLeld0SlJhcW1o?=
 =?utf-8?B?cGU3UnRRR0FVYlYwNmwreVc1Wm52NlZ2MXdtdmp0aFhjaWxlTjNkQVZRSWpl?=
 =?utf-8?B?Ylh4cE90ZFpSWTVJV1BNbC9EaXJiZ3J0c0lnMXlFWVppS1RqcUtOT1VjQU5I?=
 =?utf-8?B?MmhrZUE3bldGNkVYYjkzc0xXRFpwVU9VNTdqcjBBQUhjcmh6YWNPZlJLcmtI?=
 =?utf-8?B?MWthdHZ1aHg3NVdEcmJTWkJDckRjTTJHMFdOeGZtamp1L2JpUEtPOFhuMWky?=
 =?utf-8?B?eDJrL1FUSUliRGRSSWEwaWdSRDY5eVFDdFRwYXFoem54UmlrM01vUC9ZR3dE?=
 =?utf-8?B?R0o5dEFsSWpGMnc2VVBaWjVkQTFyNDJ3cG5zUDZtZ3lpU2RiUWlnVDRVTCtI?=
 =?utf-8?B?VFZuQWNrY0VsQ1lMYWxERmRlL3dBMGtyOUxmSC9GTi80LzJLUG4ySDdneU1B?=
 =?utf-8?B?MytqTTk2VlVoWUR3TXAxRXduWHVjalcrVFNITHJYMVlGdHpndzQzQTlIWGh1?=
 =?utf-8?B?bndQL0hhbTdSYnI3TUxVL1ZBTW1SNjhwWmpWbWNIUThDMW01YStJMWN6SFU3?=
 =?utf-8?B?ZTI0K09pOHlxemVoTmlGMjdTS3ZmU1ZJRlJJWDFyNmk0ZEJ1ZjNZS05ueGFz?=
 =?utf-8?B?TFdkbjJETE9INDFyNHdVSUQzc3hsc3B0QlpEU3pyTjBwZ2JsRHVBSlJnRnAv?=
 =?utf-8?B?ejZnVHpzdjNTcXFIdGM1VzdVbmVXeXZPcHkrZFp6RStYRTVybTNLamE0ZkRl?=
 =?utf-8?B?by9ZM0tIOGRMVmFhYVhWSFVuME5LckdrdktXRFVDQmJ5ekVhd1FyUUc3ajFG?=
 =?utf-8?B?bEpNc1NpQVRTUDlWa2xTWXhsTkU3NkRMeFRTeDdwY2t4bktDY1VCdWkya1pD?=
 =?utf-8?B?V1NhWnpBOU1najZQcDl4WkVMdDgxN2JjanY1OEJoUVBGeXViQjlRNmFCeE5M?=
 =?utf-8?B?L0Vzc0JuTGNtcUk2M3pNai9kMlllb3NHL3JUZjVKd1lmQ0dDSmhtLzVydEMv?=
 =?utf-8?B?cTd2Qmxld1BrRnlCYzFBSEFEaWMwTmlPNnBzWVgySzd1amxrOTQyTll5Rk0v?=
 =?utf-8?B?eCtNWS90R1JUdEt0M0NFN2ZncGRsVENDWlE1b0ZDaUxta041cG5jWUIzUHdw?=
 =?utf-8?B?TG5PeVJLbFhmQ2lqM21MSGZhOS82ZVFaSVVXL2ZZU0Ftc0VIMVBCdUF0cU1S?=
 =?utf-8?B?TTE3RTV1T1pqV3k5T3NoWCs1THdlUUJFcEdmZ2NvVFVSd01IaytDMjBNMCtN?=
 =?utf-8?B?TER1MjQvK3E4N21KVFBGK1gxaWZZZUxCNXpPOHh6UGdPcHBzbnEvM3JsQ0NR?=
 =?utf-8?B?MVpCKzVLTUxUZEUxNU4xVU0zUlk4R0FZQ0hlSWl1dUphazFaQXI2MnZHcTR1?=
 =?utf-8?B?YUhkd0ZWZElhc0pGSnpsZXROSXZwK0JQS2JtaTNQeFBhK25PSWJsZkhsbnlG?=
 =?utf-8?B?TEZIVjIyWkpDeHBsYTF4U2g3WncvUUg5M3Vrdjk0US9oWHc0YXg0aHNwZGNz?=
 =?utf-8?B?Uks4YlYzUHJUb3BLRUdHSWlWZ0JiaUY4bG5CejBHTXdOUkFQTExCTDc3YWFD?=
 =?utf-8?B?Y1JDK2ZpQVhodmRLUzZJcjh6UCtiV3QwY21QSlREVTZGLzlUOHBHc2dhYXIy?=
 =?utf-8?B?K3ppTWxCZmZnMEFkUDRsWjZMQm9waFR0YVA5WC9kS0dDZHRiMExoTWRqUHg5?=
 =?utf-8?B?d0FhZHVlUERTQ2ZEdmROZDNvL3E2S0E2R3ZMTEcwa1FBaXB3VkdFU0FQY3Qv?=
 =?utf-8?B?RGhhSm5ZVTJ5dWh3UktSNjIyMVppTGJ2cFdTS0JSY3pWOUl3MjJvMjVNc2lT?=
 =?utf-8?B?QndSOFgzUDNqM2JGdllyTDFHUUFnPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kXO8r6WKxbBdu942leks7AzvDRP60sQQ0XKvDrD8Tlq+tbqtSs/m8pS7+QU46c72pNM6OLO9zpPh0Cz3LvrZW6DCazNok8GoRaO54xpEn7Zn2alNmlTmJc8NTfZhfwbPs8MCk7b3arl+3iWVCAL0sah3BqdCICdHGXf6zi+lU+l4r/Xl8lnERLD4CRH/2cUmri9Wa/d4N3WRXRVdXf6m9Ge0l566i+hGES8/OoZcUC63iCcVkcHFHGuq5Kes16G10STU1NLzf57xwIbTspqRikN7fDTcvG4hW5WKd4NtKuoXmtCzKpvYSVv0sszlps5ji/LdAHxR2zSWqSxbPe5jVOHWaJdSusNJH9pBhy1HPuv99mbX7+HOEpEhrajZ3Am2H0/NTHCsy0zeKRCnAIoWRCcF9ExNRLkQBxOGbvcdiS38fDx8zGoqJU6JX/AkcDk/
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 20:14:27.4904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 994f83b1-bc33-4859-71f0-08de69aa285b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5137
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

Hello Francesco,

On 11/02/26 01:24, Francesco Dolcini wrote:
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
> Would you mind sharing what are the critical fixes? I have seen the tool
> changelog, but it would be important to have more details on the actual
> impact of those changes. It is solving instabilities of memory errors?
> If yes, in which situation? And why?

So far, I haven't seen any boot failures or memory errors (maybe haven't
hit the corner cases yet). However, some key fixes include correcting
the CA VREF calibration ranges, fixing SoC ODT FSP handling, and
disabling CA Parity by default to avoid unsupported configurations.

Plus, we added a new feature:
Support for temperature-based dynamic refresh rate.

Thanks,
Santhosh.

> 
> Francesco
> 
> 

