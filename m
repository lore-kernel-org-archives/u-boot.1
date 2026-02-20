Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177EBC5516E
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4594283A5E;
	Fri, 20 Feb 2026 10:47:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MyrDgqWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8987983AC5; Fri, 20 Feb 2026 10:47:51 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC76783A41
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLDE6kupV9hzARmkXiQhCz2XwJAplLhSe32J2dQ9nsNjXcWPlZYsl3jPUvBYP2ysDyyAnUkiBeNCgsuuWy7d/Ic+dSIqlsPyJFu3XAADVpxpzHntkndSPaxEKxsqwVr/FmNsJT4BptJFCHrxNBG8dt7Ujb0aFbIaGTulkQw+opY2gyy4mPZlA03S6tc6igJ9yHgRsTPKSVGGlH8/Q7UXtKmgxZFyvqXPuUDtiBUEy0lp6UDgZr/v+WhCPrx3AqdQOWxyj3KIAg4QTTHwG7cWOw1qI5vHR+9q4KLp7ZML2dxjehg+PdBC+BHvS+q3lD6jVlBrLAVgE5QksmRzcRlW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ctu1TsiLFmWWqOsYFOdnYTFHgX5ahgpLyNVQgkYBoQ=;
 b=TiGBUu0LPG7U9sQrBqF0IywvN7Lt6kvMhQSEe977mSjRIvWFDqtSMVYAu7QYTyJ0dqepiZCP/mEqIheYfQ46Mb2RFnSL0L883RtTV/ISo3J5iSkpBjejiepXC8CVnwAEqv2EQYMZYDJ7L6PILFc9JDvvrQTl3XMczcFaInBobOqFsq+SoMxSUnC/4bCfBli+B2mpMj048iAirH28IL2CORQ+0cd3VArXlASKARZR9Ri0Kb85UJYEKBqi85lziML6UmAauF5Zu8WQnDP8iyXqKrh1x5OCrJ5lY/BE/KDSJ+bs8UUgk4SPrIw7PyfvLB2vHeTWxNpod72ii7PMdeaRGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ctu1TsiLFmWWqOsYFOdnYTFHgX5ahgpLyNVQgkYBoQ=;
 b=MyrDgqWEAw4E7OkhTCKTtMLCtEllx56XlNuGiRmK95CRMKJ1eJPhFlBJD43HBsjMWndEmoW1//gB7+UeEfwVOyHc8uYWvk3d0FxHbAdu9K3m8ZLhmfumTYb3rDfCVs9N727WexAzZcT7YD2JzAHg7hvuzPXuNqHr8hwP3FAQwx0=
Received: from SJ0PR03CA0366.namprd03.prod.outlook.com (2603:10b6:a03:3a1::11)
 by CH3PR10MB7530.namprd10.prod.outlook.com (2603:10b6:610:155::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:47:41 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::b7) by SJ0PR03CA0366.outlook.office365.com
 (2603:10b6:a03:3a1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 09:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 09:47:40 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 03:47:40 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 03:47:40 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 20 Feb 2026 03:47:40 -0600
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61K9lb5l3662018;
 Fri, 20 Feb 2026 03:47:38 -0600
Message-ID: <aaf3f58d-05f9-4b4c-913d-18fe2935279f@ti.com>
Date: Fri, 20 Feb 2026 15:17:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: j722s_evm_a53_defconfig: Allow configurability
 of MMCSD speeds
To: "Kumar, Udit" <u-kumar1@ti.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <gehariprasath@ti.com>
References: <20260220072515.143720-1-m-shah@ti.com>
 <08cfa2f8-8fd5-4e82-91f1-7e73d80b8406@ti.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <08cfa2f8-8fd5-4e82-91f1-7e73d80b8406@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|CH3PR10MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a88e6d2-b729-43ed-3934-08de706516c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QllVbXRxYlZZUGxBTFVuQkZBYWtRY0JlcmdMT2RCaWFZWmNINlFEbWFyWlJW?=
 =?utf-8?B?R3JYZ2pyS1VPcTZXS0x1a2xNWXI4Q1NNOVVrbTh3RTVtc045Y1FoYUhqeGVX?=
 =?utf-8?B?dDk3RXBBaTl3SXhtVlY3UWg4ekVjM2ZYbFVPaVFNV1pxWmN0ak5OQWR6U0NJ?=
 =?utf-8?B?UFBROUc1bU1iS3NndWo1R1B5cWowMGRXckxsTnpxOUIzSjByVzBwTndNei93?=
 =?utf-8?B?RU1ndnVhVlhTOFRuTWtWUC94QW80UmI5SWdRRkF2WUtraU8yNDNoZGN4Tzk1?=
 =?utf-8?B?TXB5VC9TYzJMOFFYT1pmYzkwNEZMRzBNR0ZTV0NrdGNMaDNldTVnQkRMdDhS?=
 =?utf-8?B?Q0tOamJHUDI4UkRiUEVDRTYzcmFtZWVFRDZMbklrOGV5b2NVclN3cm55U2JO?=
 =?utf-8?B?dU5QOXRaNzlQZ1FjS040Y1lhSjl0SW9tMDEvQVY0TUduRTY1bStBWmZ0eHZI?=
 =?utf-8?B?dmdHclVqUi91VWZOc3hCY29oK012NW4zK3A4bkdIU2RSZ1JKc2VZZ1U3VW9n?=
 =?utf-8?B?MkRTQ2dkejNPM1RFWEM2ZmJqRjBXaDlKdGlvTERxNFBEbDlBbkJIcmMrRnp0?=
 =?utf-8?B?SmxNTDFwanFsOTl5YzZqazk3b20yT2t5ckM4VGU5Ty9hWmJFMDRVNkJpMndh?=
 =?utf-8?B?UW9NYUNHaUV1Ym5tem4ySStRVG9hbnF6c1RWdnk4NTlUVXlGMkpDOGNhVnJF?=
 =?utf-8?B?YzVvMjNVMVZFSk9wQlJ4ekhIYzVkWnhabzNHZUszZGhzdjdTTm1YV3lmSTNt?=
 =?utf-8?B?VU5ZZ2hobnNIQnVXOXVOeUQxcU5tb1BVRGJKbjhYa0tMVHhCOW9xWS9NV2Fx?=
 =?utf-8?B?ZitTL1NGSk1RRnJ3NGxwU0FFYlI3RTI0MUZ2OFhQSDJONGlUcndlbTRMWG5q?=
 =?utf-8?B?R1pWbXFRT3dENUFHWTJDSDB5MG1zU3dkck1DbmxHdW12Zy9lK0R5Y0VXRUh1?=
 =?utf-8?B?ZXVtOThzVlB4ZFZGRVdqckVYSWs5RHZOWVFwZVpxY213Z0JUclhCWTlWZ3Nt?=
 =?utf-8?B?d1UxVysrOTFYR0xYUUE3bEpoTGJjZVRCUGhpaFd1Z203b2habHRpRXdTaTB6?=
 =?utf-8?B?cFdvZ1dPMmMvc1NidDQ2aDRyTXZHZkZvWEVTNTAvNkFVR3M0YXJQcHVialVY?=
 =?utf-8?B?d1l6ZHVuVjdjbFlxZFZKUFFydTJrMzV3V09aSUlGbVpYa2dQREd3c083NVlD?=
 =?utf-8?B?RHFsV3JxdzlIWTkydGg3ZnZnNjdQdHdCbHFkbThYQlJEbi94bk9jZUxxdFBs?=
 =?utf-8?B?Um04aXBFU3oyNCtFTlJKOGJSYkd5RFZ2OHFNa3BpVWxNUksyNFpONmF1OWwv?=
 =?utf-8?B?TEw3c25OdTR5NFdoZDl1Q3pxZDZwcUZIdlVwZ2JFMnR3b0d2VzdQT0NQYWho?=
 =?utf-8?B?RUxZOXg0R2hFeElBTTJRN252TkhYOVpocnZRL2FLS21KWXEyVlNLckNJRUYv?=
 =?utf-8?B?MkNOL2JETiswalpxZXg5VTZtemJxT2VxR2RNcGpDTVNMYWVQYUlubGp1N3Np?=
 =?utf-8?B?VEhOeG11YmtLbkp6MmxqVVVHdTNscW9qTDVWSHpKYjBHdmQ1clRZcjJ2RDZU?=
 =?utf-8?B?WllJK0xmVmN4OVV6Tncwb2VMa3JtUlFaNUMyZEFpTDFDbHNCUTVKSDBNZmxL?=
 =?utf-8?B?WGkwQ2luaHJlQWJBRWd4NEJvRXh2emxQUDI0cGlQR3VNYTlCL1F2WWJDWEIx?=
 =?utf-8?B?dmU4b1AvdUk0eStmY2h3ZlFTV1VFNFNqMWp6LzlzdUNiV2hCR1lWbEJ6QlJ0?=
 =?utf-8?B?OW9ScU9IaUtHSmdFTHVyM3loZEdJOTRnVDkwUTZvUHVLSlMySWxRbEx0Rk81?=
 =?utf-8?B?ekhuVFBjUm9lSHN5SHphS2xnWGV2alhmMFE1YmxESVVBR2JtbkRSaldVWkhk?=
 =?utf-8?B?UWJLWXBoWGhsMHMyUEVnWDQzbFFya3NvVVhHcG1qV1BNcmNIU1hkcGl4c1Zh?=
 =?utf-8?B?SWZlRGRKV29kRHEzRDQwclRWNmU4OG9zTTN4b1JBSzFBdEd0d1BoNGpuV3o3?=
 =?utf-8?B?b2hBb3RxWVpjRkJLZU9KTEV5bm1IL0JPdnRIcm9Ra29mN3dBWDg4dXh5UVBZ?=
 =?utf-8?B?ZkxOK2wrdytIN0dVZ2VXN2VjdG41NWhVYkl2eGxXcW9ZY3lodElHK1c0YzAw?=
 =?utf-8?B?L2lIcmhuVWpBSkdvb0Y3aWJBZytnWS9OMnNVam80VWtjd3FwTFM0UmZRRk5W?=
 =?utf-8?B?S3c9PQ==?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Xb6NfVE7YqWKvnyw2VVO59mwkJAaT4F+48h9qu7C7K4hF2UqeuRXSruGipkY3LbR8ud9kFOs2MNdMoUPApXtczLSkEfFsqgh+76WpZafNRRzsb5Iee1vkGBIz/UF+EnjXy9b2HH0ysd9ldxyOh+Eg6FYkh8G2AtKpxu9qNFY4CJ08bgK9WCoipYzNivndNuLiPBZOd2ZHZ3h/irCzp6qFrMragezCcS+1ApIZdO7sOs997zhPLW8lpx9YdN1llxrbMnYBOpJLrH/blAeZrTwdht9DxgxfAduwJzK2Xu4EcoQ6l0gYFW0OiHOQ5AgB6LE5hbrecDFLvQseAmPLHXAzF7pojg6KnrAm9Au1SCb6eQ7Uvukp9Yt1LdtRNSW/1qlCHpGXE3lVuT3cC2RplgmNosDj6zFAft8DbshkMez33yvVoG5sn+jIniQIf6EDm9
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 09:47:40.8200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a88e6d2-b729-43ed-3934-08de706516c9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7530
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


On 20/02/26 14:05, Kumar, Udit wrote:
>
> On 2/20/2026 12:55 PM, Moteen Shah wrote:
>> Add config to allow UHS support, in turn allowing to select
>> UHS speed modes for the SD card
>>
>> Signed-off-by: Moteen Shah <m-shah@ti.com>
>> ---
>> Test logs: 
>> https://gist.github.com/Jamm02/e8b8b8c95cb62a7145d73f7ef50b2d8e
>>
>>   configs/j722s_evm_a53_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/j722s_evm_a53_defconfig 
>> b/configs/j722s_evm_a53_defconfig
>> index e84670c75ed..24ee293c803 100644
>> --- a/configs/j722s_evm_a53_defconfig
>> +++ b/configs/j722s_evm_a53_defconfig
>> @@ -107,6 +107,7 @@ CONFIG_MMC_SDHCI=y
>>   CONFIG_MMC_SDHCI_ADMA=y
>>   CONFIG_SPL_MMC_SDHCI_ADMA=y
>>   CONFIG_MMC_SDHCI_AM654=y
>> +CONFIG_MMC_UHS_SUPPORT=y
>
>
> you may need at A72/SPL stage as well, 

Other J7 boards already have this config enabled in the a72 stage.
>
> and do you think , R5/SPL will need this too ?

Any of the K3 devices does not enables this in R5 SPL, though we do have 
HS400 enabled in the R5 stage.
Adding the config should result in a little performance gain I think.

Regards,
Moteen

>
>
>>   CONFIG_MTD=y
>>   CONFIG_DM_MTD=y
>>   CONFIG_MTD_SPI_NAND=y
