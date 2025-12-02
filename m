Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED50AD116F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 13:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 035D783E40;
	Tue,  2 Dec 2025 14:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d+OjCueu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 209AD83E57; Tue,  2 Dec 2025 14:17:23 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E2DD83CAA
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 14:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOETpAOQtaRWnlGHLSlgz5q3O5dbcqVbhh3nM8Ebd7RWRpBryLOC1d1ZdMpEVGnOXdRr+E4Hh8R/re371bneKG/WbTznh7ggboaL7DeWpTFqX851zd7DAfWc7R+nJFpHb6HCTuYKuw4/VNuiwmLy+6QUWftzN5toU6aTg65MKeHib979wBflHhs01mn2VIrtjSmrQuMIlEe3N6id44kuMiIz8vcIuB3foMwUuEbjsp/Rs8N04K19y3bWbbMwIyJYNetHFlP29FTO3GlSUEmSeOiiBqCnNsxv6WzWMfhupZn5/kb0a3+W3dNT79MbttusEGvpd6InCq7OxZI7qYyhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78xQ296fj3mHVq9TsD0AwFMHbbv6uWNV5clPhl4N7Pg=;
 b=tqUH3/9jeKy10fsLPzs36XQjS2a2mTiHIvkoUmzAYpEsA4im6uXteHEYCmYg+lSe4bdn4NDFqYnVze2/JNP1PLOlvypYorrLNruV6jWHic2Df4NScIozhiMpP+HM5aGLJeigLZw/F1owiSwgs4LMVOD7slDS4B8MqBf/JZolJk7cyUYIffAwV5igrYV9Cas036cANFBjioCCepRI0msu3wz+Cs6Zou0ifFmqhZdt3REgC9kEhym/rFROcQFB8yhglP6lvD4gasRFHgZ+2/zurRDt2PS/MWgl0c6d05Q+hIA4D51UWeYORQA0fMs4WKNw+Z50b8krRsu0ClznbkhY0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78xQ296fj3mHVq9TsD0AwFMHbbv6uWNV5clPhl4N7Pg=;
 b=d+OjCueuyFRFyEI3eopmkK94Pd1bGv+ZgXHuoAsh23XZE5w2wjVD/z2SnaAiKZ+OFyc4UcvXjwtQPa6SYfO44kLg9P4NMTTJg2GHzRZrZbHVRgqPxQUvynftzfvK31ISILpLLoVrr3Wgruvq8F2dgN3EsqJ95mAdQQJtTWi3PKQ=
Received: from PH7PR17CA0054.namprd17.prod.outlook.com (2603:10b6:510:325::18)
 by IA1PR10MB6267.namprd10.prod.outlook.com (2603:10b6:208:3a1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 13:17:17 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::8a) by PH7PR17CA0054.outlook.office365.com
 (2603:10b6:510:325::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 13:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 13:17:15 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 07:17:10 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 07:17:10 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 2 Dec 2025 07:17:09 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B2DH9312299885;
 Tue, 2 Dec 2025 07:17:09 -0600
Message-ID: <1e980f3c-5955-47c1-81d4-f758dfa2d09c@ti.com>
Date: Tue, 2 Dec 2025 07:17:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
To: Beleswar Prasad Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20251128150455.3279166-1-b-padhi@ti.com>
 <c5f858f8-0eb3-4ff0-bc7b-6286a43c93da@ti.com>
 <52e73f71-6c4d-4630-88f4-81de3fedaf83@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <52e73f71-6c4d-4630-88f4-81de3fedaf83@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|IA1PR10MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2f4cd0-06b7-4f16-e421-08de31a51cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlZCUlBPNVNmUGI1azRiZDZtdzRwU2JCKzI5ZFI2L0IzMUFnbmMxQTU5UlFq?=
 =?utf-8?B?VjZHUWdmWDNadEZXbHhkYlN0T3JHcm5JSG5QT2tZL2xvdzc5S3h5Ukxya2tL?=
 =?utf-8?B?dWZIWUJVQUVnVTU2ZnAyUitIdm5mTEZOK2loaGxsNHRjcXlaOVl4NHZrWmZh?=
 =?utf-8?B?MkZ0VkdjYnhLZktCYVJaUDY1MTdrazcvU2Z1enFxajR4YTI4OVF4T21XeFRn?=
 =?utf-8?B?Y05rQlFjaEhNL25EbW9Dc0FDWE1hMFo3SzFMWDg3cW5VT29tQnpWSXVvSEJi?=
 =?utf-8?B?WkFpVXd3Sy83dWlRREJObHJDZUpFeXFFRW54SWsyUWRsWElLTnkyRTJLclZm?=
 =?utf-8?B?ekhCWDNUTWEvMEdmcEVDdXJEanlaOEk4cFQ2WUloMFdiUERveXY1UFpyMGox?=
 =?utf-8?B?UGo5YmE4MUFBZzdJUm9td2gwZlZ3QkVlMVdSclpBbHNldkVaZ1RPb1hNeEhS?=
 =?utf-8?B?SFJTVDI0WFdQRmtoNjlzSlZyNWk5YWpsbmJLMkZIYWlJeTV6OXJlQTFIUU1o?=
 =?utf-8?B?TWEvR1ByNXc4R2tLWW5NdjFUb0tFTHE0UzMvbFlmVkQyVW55RmpnTGl1NVV6?=
 =?utf-8?B?Znl0bDBjRTNLc2txL2E1eElkaE8xWG9aRHkzcnhwamV3ZDlJL2JlMmxUbzFy?=
 =?utf-8?B?aEY2TEpTYkVrMnJjVjBjMjdMQ2t0NmxoRE9JRG1xOC9FbnYzYmxTekdWMjhX?=
 =?utf-8?B?R3NHc3A1TnFKYjN3UDl3Ymo2WERBdFBNeFhmVGNxdXkrY3NkZUx0cm1jUm9n?=
 =?utf-8?B?TjN0S0VBRlU1UFZrb3RlK1paUDA2R0FBOS9rNVZ4dXd1US9IaStrL0g3SnNG?=
 =?utf-8?B?RzJGT0FqZURYSVI2a0dPSG12dmR6bkZxaUdDRU9PTmZJWGRpZlNGZXFCcHVD?=
 =?utf-8?B?c0M4NitpRVRxMXVCL0VMZWN1dWlDM1FySUZUME5oNkllNUo0WnN2RnMzOUYr?=
 =?utf-8?B?T1FhRzRaMGxFc2JCOUV4UHdUTFNxWG1XUEhONE9rY0tKUEhtR045SVgyY2x6?=
 =?utf-8?B?UkJybE1rdGszdVhvRzBmV29xOEt2WHVxSVJ3eW5wUVBCNThaejBXb0M5dThW?=
 =?utf-8?B?SW1KazF4VGJyamxqRnEwV2p2WWdiSFJidFZYZWJkWkhlQVphcVZ3SUNkWmh6?=
 =?utf-8?B?TER4Mis5ZDBDNGpVaEpiaXowV2dKYjREVDF2MkI5R1U0ZU5mYlM0OHRoRS9i?=
 =?utf-8?B?SVl5dVFqcXg2K0IvMXJkY2xwM0prS2w4Tk9zenA1VWlPUjRCQVd2SXZBSFN6?=
 =?utf-8?B?VjZKeUg5TGpqWklRcm9KbFdubjBONnl6T1FnSU9kdHZBTEpNQzNHQ2dCamR5?=
 =?utf-8?B?cEkvdmlJRytNcmVxMkRpam1lbitmTmw4bnVTcmhzVDNBNzEzdUV3Sk9vQ09w?=
 =?utf-8?B?WDJ4ZStPalpoRUJtclEvQVc2NDZVREgvOWd3bUpXY1Jpd1o4dG5nZHYvMk9i?=
 =?utf-8?B?d25US281NjhGd2dEeVpkKzZMcWZFTWMwdUdJdGhwdHhMU2xBRjZ6U1BJRXdy?=
 =?utf-8?B?ZERpSGNZTGkwU0d5Q0FaMHNkcW0xZXliaXNEUksyQzh1UUdwRGpwcjVBanVw?=
 =?utf-8?B?MlYyZGxvUkIwU1ljNEl0cERnaUk2blBLMm5TZkRKc1JaLy8zT2Nyd01MT1NP?=
 =?utf-8?B?U3dPQVhQVnA3dWxsRTVhWjZKYU5QU1VFRnRIaHE5NnhURnkzZnczdm00WUxO?=
 =?utf-8?B?eVBWWkJNSXo0Y3FEUldKeEMvY2UvRUVQTHRDa2hlSEJiS1M0K0JORm04UWRT?=
 =?utf-8?B?K0FNNEFSbEY1RURuVmtrR2NLdEM1a3ZFcUlQelpZUUJxYkdSS2wzbkFPUE84?=
 =?utf-8?B?RFk0TXd2YnpHVFdtNkkvZURaaVZMUGZ6SUtsQUJ6VkJKTGNKWTNjWXpGejdu?=
 =?utf-8?B?REkyVWVGY2JuYTRRVHE1MVF6czhodnhzWSt0UkhDTjVVR3BST3JqZWI0T3hy?=
 =?utf-8?B?R2NaQmlwbFhWb29wZFdXclJiWG95MUJNMXBCMThQNllqaUJuUXYzbkFJbDNQ?=
 =?utf-8?B?QmpZSFZxLzNFaFExcERIRWF3UUVaY0NOV3RVTXBiSkZTdmc1QWk4bnFZSWFu?=
 =?utf-8?Q?Cww9BQ?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 13:17:15.3615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2f4cd0-06b7-4f16-e421-08de31a51cb9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6267
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

On 12/1/25 11:56 PM, Beleswar Prasad Padhi wrote:
> 
> On 02/12/25 00:58, Andrew Davis wrote:
>> On 11/28/25 9:04 AM, Beleswar Padhi wrote:
>>> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
>>> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
>>> top 37 MB is used by PPA and is firewalled. This results in an exception
>>> and the boot fails.
>>>
>>> Introduce a new defconfig for AM571x HS platforms and set
>>> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (aligned to 2MB
>>> as per page size for ARM32) for the same.
>>>
>>
>> This "SYS_MEM_TOP_HIDE" looks new, for other OMAP-class HS devices we
>> use "CFG_PRAM"[0], seems these two configs do the same thing, could probably
>> combine them in some way..
>>
>> As CFG_PRAM is set based on TI_SECURE_EMIF_TOTAL_REGION_SIZE which is 32MB
> 
> 
> CFG_PRAM is only set if TI_SECURE_EMIF_REGION_START is not set, but we
> have it set it to 0xbdb00000 in the am57xx_hs_evm_defconfig.
> 
> https://github.com/u-boot/u-boot/blob/master/include/configs/ti_omap5_common.h#L75-L81
> 
>> for all other AM57x, why is this needed only for AM571?
> 
> 
> Other AM57x boards have >1 GiB DDR. So, the top of DDR space does not
> intersect with the firewalled EMIF region (0xbdb00000). Only in case of
> AM571x, the top of DDR collides with firewalled region, so boot fails while
> doing reloc.
> 

Is there some way to detect this at runtime? Nothing prevents any of the
AM57x SoCs being used on boards with 1GB DDR (although they also might use
a different defconfig). How do we deal with this for K3 devices? Some use
an OP-TEE address aligned at 512MB and I'm sure one of them have that amount
of DDR.

>> We build for all
>> the AM57x with one defconfig, so this new defconfig will go unused. Just set
>> the default CFG_PRAM size to 64MB (same as AM43x),
> 
> 
> I am guessing all AM43x devices have the same amount of memory unlike
> AM57x devices? If we set CFG_PRAM to 38MB by default, won't we lose out
> that memory on other devices which do not face this limitation?
> 

We only really supported "officially" the AM437x-EVM. But our over-focus
on just our EVMs caused us to make assumptions that would later make
it difficult to add support for customer boards. Assuming DDR size was
one such assumption, and should a customer board have the "wrong" DDR
size things like this would break.

So instead of making another one-off fix to get one of our EVMs working,
I'm trying to think of a way we can make this work automatically for any
combination of DDR size and firewalled region.

Andrew

> Thanks,
> Beleswar
> 
>> should be enough for all
>> and doesn't hurt to have more than needed reserved to be safe.
>>
>> Andrew
>>
>> [0] https://github.com/u-boot/u-boot/blob/master/include/configs/am43xx_evm.h#L153
>>
>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>> ---
>>> Fix boot for TI AM571x HS EVM board
>>> v2: Changelog:
>>> 1. Drop [PATCH v1 2/2] in v2 series. There is no need to add reserved
>>> memory node in DT as it is done by U-Boot as part of FDT fixups
>>> https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-common.c#L72-L107
>>> 2. Add entry in MAINTAINERS for new config.
>>> 3. Update commit message to use memory size in MB than raw hex bytes
>>>
>>> Link to v1:
>>> https://lore.kernel.org/all/20251128064353.1295063-1-b-padhi@ti.com/
>>>
>>> Test logs:
>>> https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66
>>>
>>>    MAINTAINERS                     | 1 +
>>>    configs/am571x_hs_evm_defconfig | 3 +++
>>>    2 files changed, 4 insertions(+)
>>>    create mode 100644 configs/am571x_hs_evm_defconfig
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index b43dae882b3..e5d564cd760 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1780,6 +1780,7 @@ F:    configs/am335x_hs_evm_spi_defconfig
>>>    F:    configs/am335x_hs_evm_uart_defconfig
>>>    F:    configs/am43xx_hs_evm_defconfig
>>>    F:    configs/am43xx_hs_evm_qspi_defconfig
>>> +F:    configs/am571x_hs_evm_defconfig
>>>    F:    configs/am57xx_hs_evm_defconfig
>>>    F:    configs/am57xx_hs_evm_usb_defconfig
>>>    F:    configs/dra7xx_hs_evm_defconfig
>>> diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_defconfig
>>> new file mode 100644
>>> index 00000000000..7e44ee5221a
>>> --- /dev/null
>>> +++ b/configs/am571x_hs_evm_defconfig
>>> @@ -0,0 +1,3 @@
>>> +#include <configs/am57xx_hs_evm_defconfig>
>>> +
>>> +CONFIG_SYS_MEM_TOP_HIDE=0x2600000
>>

