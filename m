Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A0FD25030
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 05:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B94C839AC;
	Mon, 12 Jan 2026 06:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="chT9eyIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4845583A8F; Mon, 12 Jan 2026 06:38:03 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azhn15012013.outbound.protection.outlook.com [52.102.136.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF425839A8
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 06:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkIETOtTAN2b+X7EeSf6PtQcuJ6khIIYcfn/9IbJ0tXdECuXFraIqiILnBZvDigY/fd8L/6oKaXQ7VR7hEGALaBEDqECfNx734aQHZ2bz3bGBHmerf9eLj5vVVwOSp1Ivj1h55zNovfORfafMip2JT05TUvwLoLHGCGSO9R4Bc0hu3adasgFdJXLAWSgoSIZANKJbRoSBA0CX0unVuUJiCiMkTgQ6mxxfOVgIn7q2gzywnUV8bnEu/XCx7dxEZVNN/v/+x7iTb4QBzDQo98S98gVeLEF34lpnOdGZ4AUQZ123CCBY6aTx3l154sNSiDNKUGbqCqGdBKkOBSL2lB09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nf9vB+sihh77NubdABm2i8n7mvK0kt/nf0wcWZPzSek=;
 b=kIyM9kAKZiDIQEJAY/hrgfr+IFkaXZIqhvBgn6VYCe306lz46IK4kmcmW1+ay+eSsmA2+TfYakTWLB1KGnbKkh+EtKPOnggF2u+vmZJdDW8ynVcn6WjawddO056BfiO8XstQ6KSGfwwqdOjnLJ2c4fWSPG1wr2DO0iDP7RRvWOzWuwGGqIFausS2DIj2Gr/plUQCujqW32ljytM1PlDmt4oJku68ZlDqBam6hZ7/llnZ4o109l0wUA7HMh7OCpr80aBg6ZQi31e8phZNdBGM2lRAceYyOoqnUUXVuqKX333T+XSD5JNVw+eS0mjP3Cbgx+t0S3nYZ2g0mV61rDFtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nf9vB+sihh77NubdABm2i8n7mvK0kt/nf0wcWZPzSek=;
 b=chT9eyIW8y+wAWg2lvYOdsEkuVw2m6AUcbEalVFxwTuebKqGEtmUy70d3VpYfoZyaxS9zhZqjpFQpNeQAtN6hRcUvosiiy0thEBw5yHthtqdqhxG6B1azI+7TfRuHXqI7L3bKP1BJ23qRBCIdK6gOo2c92ovM4lYNRtTE6a1iMo=
Received: from MN2PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:160::29)
 by IA1PR10MB7166.namprd10.prod.outlook.com (2603:10b6:208:3f4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 05:37:52 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:160:cafe::fa) by MN2PR13CA0016.outlook.office365.com
 (2603:10b6:208:160::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 05:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 05:37:52 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 23:37:51 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 23:37:51 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 11 Jan 2026 23:37:51 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C5blIE4015982;
 Sun, 11 Jan 2026 23:37:47 -0600
Message-ID: <8368cabe-74f4-45c9-9712-0bc0e90224ff@ti.com>
Date: Mon, 12 Jan 2026 11:07:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <james.hilliard1@gmail.com>, <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
References: <20260109190026.58464-1-b-padhi@ti.com>
 <20260109190026.58464-3-b-padhi@ti.com>
 <20260109191054.GJ3416603@bill-the-cat>
 <48022594-212f-4f43-ba9b-0802711e88e5@ti.com>
 <39815895-5db1-4740-a060-c4050c330da4@mailbox.org>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <39815895-5db1-4740-a060-c4050c330da4@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA1PR10MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab19f54-5dc3-4fab-acc9-08de519cbadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|34020700016|36860700013|376014|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUxhNFBhSTRDM2syazNvaUZMdVo0eGNpTzRGckdIbGFkY0hhM1ZHMnRTMkZL?=
 =?utf-8?B?cnBQemVhUmZ3TDFmVnF0cjA4OS9DYzlsWlR6WTh0U2srUW1wMlpUNWVJSlRr?=
 =?utf-8?B?cnNFeExrcW9VTVUrNDVxQTlUWGQ2QWlqWS94RGRiVEZ2UEFZL2JscTU5aWlR?=
 =?utf-8?B?cEJSa0p0VTNkcHdGZ1M2T0dvRUxva05keG4rRkdBaVY1VFh5Ym5FNERYL3JV?=
 =?utf-8?B?cmRPcWwwVjJRTU43N3lGL2xBOURNOEZGemE4T1dkT051Rzk3c2IyL045S1dI?=
 =?utf-8?B?M3VSQUtKeUlpQmxOSENQVGFHR1A4SnN3a09FQWtNWjJpRVdhbWYrbEpOaEZr?=
 =?utf-8?B?L2xpdzVwZEtRcTVaNnBtUDMrUzVuK1Y2OTlWbWZLU0IybmE1MU9yZDY4TnBF?=
 =?utf-8?B?RjY4Y3lqMDlBb1ZzeisrUDluRWxGV0FkaGRJSWdUb0hFa3JGS1VWODQyYTdO?=
 =?utf-8?B?ZnJaRC9LS3I2VlFWOFJNOGV5TUU5bkpDZjh5S3NhMnQzbW5aU04xb0JqWEFy?=
 =?utf-8?B?STNmdEs0djhLUDF6OWVNb3BQSnN5YWpxS0h4d0VjQUREenB4UEExR0hlZnRW?=
 =?utf-8?B?a0FrdW9KM1FibjFHUFFWZlNEc2ZTejVZS1NJNUc5NzRCdVpUVGlrQVJiS2k0?=
 =?utf-8?B?L2tOMlgzejhrME5oWnRwYkQrUUE3RDBHNEovWjVudytDdzhHbkpWVUs4RUI3?=
 =?utf-8?B?b2xmcW9NZmIwaHB6YXJSVkxMT1FCTWw0Q2Y5RzlIVkE1Yy9wZUpxSThnRmJ0?=
 =?utf-8?B?OEZwZHdOb1piMFNaN0pGdjNlRVlySzdsbkw4NEF2Z2I5cjIxTG54MDh3cXpY?=
 =?utf-8?B?Nkk2V0JyVms2WnRwUFFPcFFJZjNoRm54TXRqZGk5MUttaUExMS9DcGV3VWps?=
 =?utf-8?B?Z21MVm5Mbnl3dkNOOGlmdDdvcG5QWS9BckxRNnBMR2Zuc0RMNm9mVTJialhy?=
 =?utf-8?B?MlpyRlprRW1Qd2w1OENya2F5UDgxRGJsWDFmY0RiV0wzZUkxRTdQaEgvMnFM?=
 =?utf-8?B?Q0lYSVZ5S1FDcFJQZnBhd0xjSzVxREJTWE1nYlZZdmMyRHJKWkFjNlVsMGNN?=
 =?utf-8?B?emNZUU9kVHRGS1hLblY1amJjV2JJaTJDZXRZTmdoRkNTbzU5Y1AxbkIyc2FQ?=
 =?utf-8?B?cUZubDFuNm4yMmw3VDA3THBGM0FrejgrMys2WnBuM0podHUyZDZnUjRuYTIr?=
 =?utf-8?B?MG9jYkRhOEdvcFd6UEV6Q1grVXRxK0g5QUVGakFkVWVxVEE4Uk5pbldjcHo3?=
 =?utf-8?B?VnpVWWtpTjlDc3pnSUl3UXBZV1dDc0JkeXdMbGNoaDgrVWhwdmpWR21TU0xt?=
 =?utf-8?B?aGliSXRhdWdSd0UrYUVSL1h1WjVwRTNQMENDMnFVaENyTC92MjV1Q0pEN0k1?=
 =?utf-8?B?MytGZ0FCb2prYmIrTEpEWTVaelpXUjYya1pwOXNLZzY1T0dNbzd4N2Q0bnM2?=
 =?utf-8?B?QzBrcVI3d2NOTC9HM3l5cnpOTEwzeHRwZVJwdVNSTENUUjhNTWN1MmV1ZFhR?=
 =?utf-8?B?NGt5dkFHM3dheTd2NUV3Zjk1QmgvelBwY2dYQjduZWRPYWRseEFtQ0NiT0dt?=
 =?utf-8?B?Z043KzhHdHB0bVpqaGhXR1NxVWJUa3E4dWNFby9WM2o2RkZPWjV2ODFuakdy?=
 =?utf-8?B?THRqNTlPVW5ZRFcwaGtnVWlzRWpxWGM0OVpHODFBVEV4Q2NKR0RHampNWlJG?=
 =?utf-8?B?bVkyVlF0R0FFZ0U3Sm42QWVRRzljaUU2dURYaWRaZFhCM3NyV2JJRmhoUVlW?=
 =?utf-8?B?bnhLODhlOExscFRCWlBTcEhXS1NzeWg0K0VjYXBobTZnMWtPcFp1bFUvdm5D?=
 =?utf-8?B?K2RDSXlCRk9BSHdhUVgvdHZoREZ0ZG1xQXI0bjRVb0I1dTIwRFkweWczSTNG?=
 =?utf-8?B?STRnY0IwNkJqNG9vMUlJL1phTGhsdUZ0M25hYkFucXhPVkFCT0ZvOHRWSjJZ?=
 =?utf-8?B?YjQ5T1l0SktQQjlWSVM2MjVJQWFpL0ZSdVp3UWlDY25sOVZMZlJjSTJTb21C?=
 =?utf-8?B?L3Niamo2R1FEc3FXTFNGRkxXTGZQYk55WCtRcXFIL2U0ODdNS1BiQThrZjRM?=
 =?utf-8?B?Tkcwdkhwemh6V0xNTkJ2NXlJQnRVTTRiUC9YMTVNd0JmTEs4V1VWVEI5SGp4?=
 =?utf-8?Q?1Ngs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(34020700016)(36860700013)(376014)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 05:37:52.3782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab19f54-5dc3-4fab-acc9-08de519cbadc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7166
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


On 10/01/26 00:58, Marek Vasut wrote:
> On 1/9/26 8:21 PM, Padhi, Beleswar wrote:
>> Hi Tom,
>>
>> On 1/10/2026 12:40 AM, Tom Rini wrote:
>>> On Sat, Jan 10, 2026 at 12:30:26AM +0530, Beleswar Padhi wrote:
>>>
>>>> The OMAP2 SPL linker script (also used for K3 platforms) currently uses
>>>> 4-byte alignment after the __u_boot_list section. Change this to 8-byte
>>>> alignment to meet the device tree specification requirement for DTB
>>>> alignment.
>>>>
>>>> However, this alignment directive only advances the location counter
>>>> without padding the actual binary output. When objcopy extracts
>>>> u-boot-spl-nodtb.bin, it includes only actual data, stopping at the last
>>>> byte of __u_boot_list (e.g., 0x41c359fc), not the aligned address (e.g.,
>>>> 0x41c35a00). When the FIT image containing device trees is concatenated
>>>> to the above SPL binary, it gets appended at the unaligned file size,
>>>> causing libfdt validation failure.
>>>>
>>>> To fix this, add an alignment directive inside the __u_boot_list section
>>>> itself. This forces the linker to include padding as part of the section
>>>> data, ensuring objcopy includes the padding bytes in the binary and the
>>>> appended FIT image starts at an 8-byte aligned boundary.
>>>>
>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>> ---
>>>>   arch/arm/mach-omap2/u-boot-spl.lds | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach- omap2/u-boot-spl.lds
>>>> index 3bb759d8a1c..081323e6599 100644
>>>> --- a/arch/arm/mach-omap2/u-boot-spl.lds
>>>> +++ b/arch/arm/mach-omap2/u-boot-spl.lds
>>>> @@ -35,9 +35,10 @@ SECTIONS
>>>>       . = ALIGN(4);
>>>>       __u_boot_list : {
>>>>           KEEP(*(SORT(__u_boot_list*)));
>>>> +        . = ALIGN(8);
>>>>       } >.sram
>>>> -    . = ALIGN(4);
>>>> +    . = ALIGN(8);
>>>>       __image_copy_end = .;
>>>>       _end = .;
>>>>       _image_binary_end = .;
>>> Do we need both of these? Shouldn't we just need the one inside the sram
>>> section with a comment that this ensures the end of the SRAM portion is
>>> 8-byte aligned?
>>
>>
>> Yes, we need only the first directive.
>
> Would that work if the __u_boot_list section is empty ? I think it won't and you would end up with possible 4-byte alignment again.


It won't work. But having the second ALIGN(8) won't fix it either. Either we
change the whole linker script to be 8-byte aligned, or we leave a comment
on the last section saying it should be 8-byte aligned for DTB concatenation.
I think the latter is a better approach. We don't necessarily need to enforce
8-byte alignment for every section of the binary.

Thanks,
Beleswar

