Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66421EA794C
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 01:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07B383015;
	Thu,  5 Feb 2026 02:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="okj8EmMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A8B8341A; Thu,  5 Feb 2026 02:11:23 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B6A8063E
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 02:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5TkeInQtT6f7e4eFEBlGf1CvDq2p3AyATkXj5Id84ops53An0g9OSGrWZQCpaetUUcfkOy/uxUZ86XkaKVuPKsHFuthgYS3YEVvGsOw0pPpDnUkBniCXcw4AJmaJ4OD1CrQgMI5BH9rJsaGOa9floAdOIcDdmwEiYxpeAShTkcMgn3fA2SuYOaAwDfCFTSWP+3pOVI35E9Kry1oBp+K+nzmpiT2Mcw1KyJaBCUe76qlEasES1Kpc/Wpr11JQGllON7x9DNVTdZnYReK0Ri7UagS06lXTj1gcSj+7WqCO/v6Ln7C5CXt6xZEk/sLY1g9uRclj6jEACLKQw8iHY5GHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L82Jt7C9Wo3QmLHhzpqrIG0NlJJwKYm5LG28cZimrLw=;
 b=DiXWSZmIfKEUWm8vKaRz7cUjnOOoIz+U4cXN89cYyvZnYQWox1QCfxoXYJ8YBYS8QSYf4p99NqbHKgJ6mG39F9KqIxc5cx6i0oGgrurV3ajV4vsnmL7Bq4A+KceNIH1Q5fim+zWqSLHuBzmn3dVUiBYliwYyukWIcdmB03h8V9JnwcQCYk2+/yWJz5twIw07RhSSgLziIgQwm2WF2Ua+9rWvLBCK3iYs0bSGEdLy9unawwyw28UX3ejkOWQ/xSNp6aiOcgXPgFRqWVNMTIyZ/BKEsigslozG8oByodlQDmwtTlJ9AZl3noIyEvCzQ7n1aRTZrgK4r3Fyt1QuTmQi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L82Jt7C9Wo3QmLHhzpqrIG0NlJJwKYm5LG28cZimrLw=;
 b=okj8EmMc+veNKKJp6dwMTWN5wGq1GR1Nc380kI0xNi8CS71yN1SCyJ0NFJvmzqBMm5pRdOQ6OPiSglbd+lPhyCn2SUgD4nAoTtrcb7MQihMa29L/wk4i4MCVgjeBgaumiW+eE8Mw4WKtSr6Wf+H7X7GZjPhqUhbaXgldzZLqZnY=
Received: from BN9PR03CA0554.namprd03.prod.outlook.com (2603:10b6:408:138::19)
 by IA0PR10MB7381.namprd10.prod.outlook.com (2603:10b6:208:442::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 01:11:17 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::10) by BN9PR03CA0554.outlook.office365.com
 (2603:10b6:408:138::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 01:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 01:11:16 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 19:11:03 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 19:11:03 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 19:11:03 -0600
Received: from [10.249.139.123] ([10.249.139.123])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6151B0fj2503470;
 Wed, 4 Feb 2026 19:11:01 -0600
Message-ID: <26f52e6f-d936-4180-8405-d30de803fc09@ti.com>
Date: Thu, 5 Feb 2026 06:41:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: cdns3: use VBUS Valid to determine role for dr_mode
 OTG
To: Marek Vasut <marek.vasut@mailbox.org>, <trini@konsulko.com>,
 <minda.chen@starfivetech.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
References: <20260204121245.2105523-1-s-vadapalli@ti.com>
 <4267b260-9479-44b4-bbeb-521738845be1@mailbox.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <4267b260-9479-44b4-bbeb-521738845be1@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|IA0PR10MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: da894913-b802-44c5-6b8a-08de64537680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmlERjYwcTRNeDIwd0hqSld2ajJPVHBCbDBCZzlXbFo2cjhidFk0d0t4cEZK?=
 =?utf-8?B?RzhHOTczWlF6NDcvVHloQ1ZGNFRwaHpVbmJpWDZIajNNdk9aMFJuRjVBYXlV?=
 =?utf-8?B?eERORDJpTThGQURDSm5lZG9aQkE1dUJGeXZ4RlhHaVJzcjhtZHJUQ1BwbFNQ?=
 =?utf-8?B?akZsNnI2OUpHVmdjeEVEUzFNOVc4K0p0eEZIM0ROTkgwTGFnRHJmZzR4UVNk?=
 =?utf-8?B?dlBKMUh3SWhzdHhxamh0WWJHek1hZm9SY1NJMmVQSFZMTXJORENibTM3K2Y4?=
 =?utf-8?B?QlpjWXFFc29NVTRmSTd2MnFEYnFMTHlJQVlzZlBBQlFyUVA4S3M0dVBqSVlM?=
 =?utf-8?B?SlRRdDJSUXowcitoVXRNWDc1Qm1WWmp6SUl1ZFRyZnJsdVc5UWFubFJBUTBM?=
 =?utf-8?B?RXN0M3Z3MjRKckpzUnRKWkhYd3YrMUJMR2k1Y3hJelBmVTJ4ZU9EK1ZkcEov?=
 =?utf-8?B?SFIwOHJmQm9PbkRDR0dhdlV0MlJiT3Y3Ym1uMlFPTkJmaDdLYzhGM0MvbGtm?=
 =?utf-8?B?QXJiMUNLamNRNTdWUW9CRy9ZM21OTCtNUHRtN2dkaUNyZGR1WEFQSWJHMFU4?=
 =?utf-8?B?Rk1qamNreGVOS3NGOXZsNG03dzhEbzU1UzE3VlpVVzRKeVNiMFA2YzZuUEhM?=
 =?utf-8?B?Z29XUStTOGVma3hISUhob1cwNTVaa3NMcnQxS1FaVUljTUgzYWpia05CWU5m?=
 =?utf-8?B?QlRoNEJ4SThEMkRlWFg3a3dMRlA1dklvMS9JKzJBQTNmbW9VWi83R1hWcmt1?=
 =?utf-8?B?OUNIdGtHRVJTczdJd293TVdWcDBOUDdOc0NnTUsvekJCUTlZNElFbUVBc09G?=
 =?utf-8?B?eGlFVXRBS1p3RENZQURtTHhaVGxrckJuc2xkemVJTXVGMG0xUDQ1RXlqZnVV?=
 =?utf-8?B?T3FxVW90NmRsNzNkdFdXZGRCWkJobmplVWNWZHQwL0lhRzlpMFBrK3RWZU0y?=
 =?utf-8?B?K1BiM1lPbUNzT1pzbWwrZXEzcmRkZEwyTWtzaytOUERZcndWc3ZiblpyRlU1?=
 =?utf-8?B?alA1c1JFVGdzYUN2dmNrNDdKTm5JNzdPTjZmQVBCRWFrdjFaT0xCcU9lNThv?=
 =?utf-8?B?QThXU0I0RUUwTUIvZUJyM2ZjN2lmcHAzb0FEMXdZZXBYTTN1U3RMcVhnOWNE?=
 =?utf-8?B?WGw4U1VlVlJHa254WlBldGh2bVNVKzZiM3JkRGpNUUYwcjVvdjBlV004am9B?=
 =?utf-8?B?UFdQaVVkMVI0blNzMGdlSjRtV051QmUyUEEwWFNTN3RwR3dQbjBaWXVHMS9H?=
 =?utf-8?B?L3ByUC82ME1pTlVYdVlaNFJFbXp1THI1UWVEa0k2bm54cDBOQjhNb0o4cndi?=
 =?utf-8?B?d2ZrOVNhdW1hMmlUWnMxYmk5V0Q4YXV0RW95SGhubzh4Q3gvYklVaWdNSzRD?=
 =?utf-8?B?d2dZVDJhYjZwWjFCZlV6ZHdYb214QStxSktEaFIrNlJCcTcvLys2Rkc1eVlQ?=
 =?utf-8?B?cUpScUQrZEVMYmU5VWtRYUhqbzM0VU1CQmcrbnV0WUFIT01Sam9rTjVzKytv?=
 =?utf-8?B?RjV2L29kT2haYzZ3ZTdOVjJZMXdGaFRSSGJJVWtYTHl6Z0dTN0l2czJoNmN5?=
 =?utf-8?B?cXRLQk02aXFUSWxSSmt5QXM3ZTUyOERSVDVpMWVLdmZCblNXTkNRVHV3OEhy?=
 =?utf-8?B?Lzk4R2Zyeis3N2RZZWw2SURqMk9KZFN1bHlzRVdtNDl0azRSMU54WkdOQWx3?=
 =?utf-8?B?d0dvREgyN1V4bEZHd1VORTlnMU5JRGlUcVdRSnUvTkRmRHJKek02dTlQbm9t?=
 =?utf-8?B?enpLc0FRTm9QTVU2Ymd5dTl4Q05LYWVNNHQ0bXJUV1pSTkx2Z01kV0k3OExJ?=
 =?utf-8?B?SlpkM0NHRS9mcm1MUkVJdkdVWFVLMldlWTBvTU5DcCt3cjZSN1lUMjVtOG5z?=
 =?utf-8?B?N1ZzbWhkNFIzRlg5ZEJhR1RqcStwQnBYbWl5dHVhTGltd2pkbG9SVmRnOUcz?=
 =?utf-8?B?ei9rckVVdmR0T2hRa05mUkNGdy9pTXBZTnZzaW43RU5nK0c5WjFPSzhpcXVL?=
 =?utf-8?B?anZxMWplVGgvbnprMDR0bm9xNzdEQ3N2UUJJdHpDcnBpYkxNUVBmTVZrSUxT?=
 =?utf-8?B?U2g3LzlJRTd4THVTWEZnbjNNbUgxRkNWcG9MR3hwZlQrLzR4dTVOQ3d3MURs?=
 =?utf-8?B?T3NyditsZDRjL00rdEgrWG4yOXpRbmxqb0h0anJ2WEh4SXh5SGdrVDZaTlA1?=
 =?utf-8?Q?25ErvEqEw+5k4HrTVDBkYyY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C+ZoYvmPq27ryqHMEd0YDr1uj/jA6p1RxWGOYaTi7Lwmu+19hR2M81nEnaL1SyuXvCri0DqpR+ZZs+zekET50cXZBbnPaxIZsowjlSgz2twnFrZKGTS/xz9LPcSygzRCuzIOk8PmD84wfKbOWFWmmfnQ8CzwXYrJ+16XpOWp4qg/7YDFp4UWf0DM1+BBOH0faBL9IxNdcowy4zv6zjqpdXtTD85f9oeJXKO5AexBTdZB5vvyWFJvPODzKQ1qK5hfH64OU6e1ZYfN+6SzwybCS+rgcJ4oK9BCm6hiALpMPqrsdzAv9cB+y8eDja1weWkquC+RGGMA/X6Uma/BT2P49r+VU7tAOS+I5/CgxlUR6tM2nQtaFCVXZ2c+gQhJr0iLp4YVyDmxVywbuvt0ajtuRdSbMmIogoCet1MhpAfZiJ+AlPWY34FRM0Wcv2YBKXBZ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 01:11:16.5226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da894913-b802-44c5-6b8a-08de64537680
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7381
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

On 04/02/26 7:39 PM, Marek Vasut wrote:
> On 2/4/26 1:12 PM, Siddharth Vadapalli wrote:
>> The cdns3_bind() function is responsible for identifying the appropriate
>> driver to bind to the USB Controller's device-tree node. If the 
>> device-tree
>> node has the 'dr_mode' property set to 'otg', the existing approach fails
>> to bind a driver, leading to loss of functionality.
>>
>> To address this, use the VBUS Valid field of the OTG Status register to
>> determine the role as follows:
>> - If VBUS Valid field is set, it indicates that a USB Host is supplying
>>    power and the Controller should assume the Peripheral role.
>> - If VBUS Valid field is clear, it indicates the absence of a USB Host 
>> and
>>    the Controller should assume the Host role.
>>
>> Additionally, when 'dr_mode' happens to be 'otg' and the STRAP settings
>> are not specified, use VBUS Valid to determine the role in 
>> cdns3_drd_init()
>> and assign it to cdns->dr_mode.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>
>> Hello,
>>
>> This patch is based on commit
>> a8d982e1f17 x86: cpu: Fix crash on FTRACE enabled builds
>> of the master branch of U-Boot.
>>
>> Patch has been tested in the context of USB DFU boot on the J784S4 SoC
>> with a Cadence USB 3.0 Controller. Since the Linux device-tree for the
>> J784S4-EVM specifies the 'dr_mode' as OTG, due to reuse of Linux
>> device-tree by U-Boot, the 'dr_mode' of 'otg' causes USB DFU Boot to 
>> fail.
>> While one approach to fix it is to update 'dr_mode' to 'peripheral' in
>> the 'k3-j784s4-u-boot.dtsi' file as a HACK, it doesn't scale to other
>> SoCs and all of their 'u-boot.dtsi' files will have to be udpated as 
>> well.
>> While I am providing Texas Instruments SoCs as an example, I presume that
>> SoCs from other vendors are also affected by the 'dr_mode' being 'otg'.
>> This patch addresses the issue by using the VBUS Valid bit of the OTG
>> status register to override 'dr_mode' from 'otg' to a deterministic role
>> to enable functionality.
>>
>> The USB DFU Boot Logs for the R5 SPL stage on J784S4 SoC with the current
>> U-Boot master as of commit
>> a8d982e1f17 x86: cpu: Fix crash on FTRACE enabled builds
>> are:
>> https://gist.github.com/Siddharth-Vadapalli-at-TI/ 
>> b910f326b6c9fad760190bd299ae3ff3
>> and the logs indicate that USB DFU Boot fails. The failure is 
>> specifically
>> due to 'dr_mode' being 'otg' and the cdns3_bind() function failing to 
>> bind
>> the device-tree node to the peripheral driver required for DFU Boot.
>>
>> The USB DFU Boot Logs for the R5 SPL stage with just this patch applied
>> while leaving 'dr_mode' at its existing value of 'otg' are:
>> https://gist.github.com/Siddharth-Vadapalli-at- 
>> TI/033b9772b6ab105b96806adf890848fe
>>
>> Regards,
>> Siddharth.
>>
>>   drivers/usb/cdns3/core.c | 53 ++++++++++++++++++++++++++++++++++++++++
>>   drivers/usb/cdns3/drd.c  | 11 +++++++++
>>   2 files changed, 64 insertions(+)
>>
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index 4434dc15bec..b7be5c48fc9 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -392,6 +392,55 @@ static const struct udevice_id cdns3_ids[] = {
>>       { },
>>   };
>> +/*
>> + * The VBUS Valid Bit in the OTG Status register can be used to 
>> determine
>> + * the role. When VBUS Valid is set, it indicates that a USB Host is 
>> supplying
>> + * power, so the Controller should assume the PERIPHERAL role. If it 
>> isn't set,
>> + * it indicates the absence of a USB Host, so the Controller should 
>> assume the
>> + * HOST role. If the OTG Status register is inaccessible, return OTG 
>> role.
>> + */
>> +static enum usb_dr_mode cdns3_get_otg_mode(ofnode node)
>> +{
>> +    struct cdns3 cdns, *cdnsp;
>> +    void __iomem *otg_regs;
>> +    fdt_addr_t otg_addr;
>> +    int otg_reg_index;
>> +    int vbus;
>> +
>> +    otg_reg_index = ofnode_stringlist_search(node, "reg-names", "otg");
>> +    if (otg_reg_index < 0)
>> +        return USB_DR_MODE_OTG;
> This is wrong, the function should return error and possibly mode via 
> function parameter , do not conflate return value and mode please .

Regarding returning an error, the patch maintains status quo for the 
case where we are unable to read the USB OTG Status register. Please 
refer to the following diff in the patch:


	@@ -413,6 +462,10 @@ int cdns3_bind(struct udevice *parent)
  		if (dr_mode == USB_DR_MODE_UNKNOWN)
  			dr_mode = usb_get_dr_mode(dev_ofnode(parent));

	+	/* Use VBUS Valid to determine role */
	+	if (dr_mode == USB_DR_MODE_OTG)
	+		dr_mode = cdns3_get_otg_mode(node);
	+
  		switch (dr_mode) {
	 #if defined(CONFIG_SPL_USB_HOST) || \
  		(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))

Only if the 'dr_mode' is already 'OTG', the newly added function 
cdns3_get_otg_mode() is invoked. In case cdns3_get_otg_mode() cannot 
determine the mode (otg status register cannot be read), we return otg 
mode to maintain existing behavior, following which, the code will use 
the CONFIGS to determine the role.

Returning an error will alter existing behavior rather than extending it 
for enhancing functionality.

Regarding passing the mode via a function parameter, I could do so, but 
I followed the implementation of other functions such as
	usb_get_dr_mode()
which 'returns' the mode rather than using a function parameter to fill 
in the mode.

Please let me know what you think.

Regards,
Siddharth.

