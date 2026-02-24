Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9818BEF5862
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2120B83642;
	Tue, 24 Feb 2026 17:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZC7s0WPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D89083981; Tue, 24 Feb 2026 17:52:43 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB75782BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:52:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wD8nr6OE2XnOrkTH1cOnn7ov95Kr/x060hWrwpIQmJwfLlR6Phb96MAHrvQ1FJ0kio9QluWL3bz2/9cXNFq4GXpxU+Q3SGLCNA/OJSn5fDRbrRppQKnq1RXTqab7H7IZUlEzUtyHY4NdW/DZfb8wTdvHyxqPnvF1YV0yRKOo/aSvfViokyKT5BKSRt9FJY1qggVyl8noteAxpFqVVgM1P5jOo393DmN97d1IIWXb1fede3CIGy3otZP6GwzydDiLxSGPo03xVkAP00r9HPPSMxCumwI9kyhbrJ47ZPgSBL1U8+vd/giyht9rp9PDtIX7GMUgSDs9uQvza9sOz27TyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vsSV1GiaSSrIS6yyotZyVgqgWAYZASa91Hq5/6iMxg=;
 b=HUdm0KOl5gWjrDdNA/kY8onT/13K/M5hDkI1I81CuuHyjgGF6snXBlA/wtoW2rBh0irM/TBqp2Fd3JyRouirI5hXbSKURM7ldAWjgOxXpcGWOiWJ6B/Y8m/VKE7D2ENfCGhwehuq2TN2PNDlKgfERoVKl96Apv8EV4JlYvC1Dybj+oVz6X1qpg1I+nXMv3pM6sYfJsDQXjEKH3af1DouHW61U4iyfKQ96OU/0s5AeZURW2tu+f2Xs1+wdhn9KfO2yJBVH8PO7CV1SNjpWUYfRedMCXzezqZYchZ8qjZyxViaOqfy54IlehcwyeQh7wbfflUyD/aQDAtsxsRhO9gA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vsSV1GiaSSrIS6yyotZyVgqgWAYZASa91Hq5/6iMxg=;
 b=ZC7s0WPU3XWPZlgVyWa+yj6/zoNkoy36EVY98pVGoq31lrBJj+lGH3Jb9SrorlBwQHMYk6DpWCtk5VfWIAn/7EspIgsOznDelJwswIpshufHQ4Bj/qROli01hjBfbL+LVXgjFKvGq+Xb1rNyuy10hseVkWTjdElwCI+yNBfA9KLWHf5loF9NHW6HD1zKKx+3ejWLIeLyIrqNJGDqf9xzsxy6z2fZXjmRMfs0knkLgIgE8crX4+r8HlZbRh7Ab2P+dLWVqSDsCztgloZrr2TD8SPpNOjCcOp8mZTeo+ZwksCfqJuICqCKy19fLRPIGoUMrqWMJJHxDIgT82/o8xe4ig==
Received: from PAZP264CA0070.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fd::13)
 by DB9PR10MB6691.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:52:36 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:102:1fd:cafe::b5) by PAZP264CA0070.outlook.office365.com
 (2603:10a6:102:1fd::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 16:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 24 Feb 2026 16:52:35 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:54:46 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:52:29 +0100
Message-ID: <91be3123-bce5-42e0-9ad6-889b3fabbf3d@foss.st.com>
Date: Tue, 24 Feb 2026 17:52:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ARM: stm32mp: Add STM32MP21 support for RIFSC bus
 driver
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>
References: <20260210-upstream_rifsc_update-v1-0-74c813fa4862@foss.st.com>
 <20260210-upstream_rifsc_update-v1-1-74c813fa4862@foss.st.com>
 <8122b9fc-6aaf-45d2-9682-d62197074572@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <8122b9fc-6aaf-45d2-9682-d62197074572@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F95:EE_|DB9PR10MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 0770c005-5c16-4052-3e6f-08de73c51cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlQzQzlIQ3BVWHBtUUkweG9yZjVsdXQwbzZCVjBMN1NZOTEwbHM3THVTZlJI?=
 =?utf-8?B?TDg2OHhZdXRZYmwwSjJMUUtoeFdKUk9sWjh4aWNZRWplaGt0REpTalpvS09U?=
 =?utf-8?B?RHJ6TkZTZis0QnlhalRmdnNKSnVUNldCbnBBR0J2VFJPb3ZrUWpMdSs4RnRU?=
 =?utf-8?B?QXVUaUdBR3ZoQURyV3hoSjdudUx1TzJUQXNTZHI5eWkvNUYwRU5HcnJLVlBp?=
 =?utf-8?B?blFyYzdlWW16eUYrWStQVmNQSVlUQW9zY0lveDFSMnBmQkhBdGhyMVhwNXB3?=
 =?utf-8?B?am1tdy9xMnh6QUFEVjRYanlOWTZsRFpYZ2pENDNpM0J0UWNIWS9DTGhIRWpx?=
 =?utf-8?B?eXJ1SzhLVjlSWDZhYVk2dWRicVVKcUdTR2dLZ1RVK0ZEWkZFRkFOanFZc1cv?=
 =?utf-8?B?WGhDc2xvd1E4Z3hwZHQrMUlDeWpwL1djWUttNy9FT1VBclpKRTNVMU9abm9i?=
 =?utf-8?B?ZmhTRXkrUzEyY0tsOWI2U1Z0Z0VFMkR1SGpaYjlWTW1GL1BqM2Jwd3BFcUlO?=
 =?utf-8?B?MlNaYncvVW1TYmRXdE5lcmhhSklFbURuUFdLSTZUQ1MwV3kwdDNCVlZocTJn?=
 =?utf-8?B?WGh6OFppcWRROW02dFN5Sy9aU3ljUC8yWXF3dUZWUG0zSW1STStQUXJ4UHAw?=
 =?utf-8?B?N25TY2JGL1RyMVIveVd5Z3lDaU1QbTNKcHpQUk5aeXZZYnowSXhIWW0vNzZz?=
 =?utf-8?B?TjRCdDFuNEZEUFhuMXdLSGh0Q2VzUXRXUlB0RnptcVg3d3NDUnB5MnNCNkFJ?=
 =?utf-8?B?c2ZTZFlxQUZSdlZxU3BtRFhXKzhndUc3cWMzWThiL201OUJ1Mk9OeVNUcUNl?=
 =?utf-8?B?Y1FTcVF5aXFMdWRIbE91KzJqZWhCSWR5WTdOVHVXWnVNOUFwQWVHU1Q5cWYr?=
 =?utf-8?B?M2o3dHBWUFQ0VVJNeUhRdWppSGdYWmtHdUtkWkRlV2J3VmdJZzJjdXNOK1Z6?=
 =?utf-8?B?a2tiZEREaWdSR1lPOFl3SFIxU09sd3FmKzJJM1UzNG5xZ1RSd0ZRVmEvWjBN?=
 =?utf-8?B?aUdsZHpmUElNa2YrWVRhMkZyN2NPWFYrUC9Jb21RaWNJYzRUT2RnQ2ZkbWx1?=
 =?utf-8?B?WFZsbXI5L0hwL2VsRU9lT1RsakxBK2FieVRxRTg5VzBURmpaZWwvYmQ1YjRG?=
 =?utf-8?B?U3pUclFLODcycmRlalFpY3NOVCtOVG16TnFHTjlaSWF3clFRczRQNENmdFAx?=
 =?utf-8?B?emYzSlBCQWx1Rk9GbVF2VGxJN2R1M0NLaU9OK1lZeHJ4OUpkWEhZWU1NR1ll?=
 =?utf-8?B?ckNsYXVGY2laT0lkUjlVVFdhZ215RVU0WW00OUhidmpiVWxWbkNhdzhEZG9n?=
 =?utf-8?B?c21kS1BiNGxFVDN6SXFxWXU2YS9xTkZCMmRPMjVnRzUyRkpEMWl2TnlibFUw?=
 =?utf-8?B?MlVjM2JvNGhXMXNHUmR2bE5QWmNKaVI0OXJQZmhnK0QwSDl1SGdpWTZaWXFu?=
 =?utf-8?B?ckVueXY4TGgrbDRwMThXZnd4Rzl2WjJ3Uk50WEd0RXpibCtZZGQ4cS8zbGpp?=
 =?utf-8?B?SEs1Y0VuL3JEcE1xS1dxdEpvUHlDVW9KTlErR1hhTUhkT0d3MnRIOGVFOS9G?=
 =?utf-8?B?VzlkR2o5dEtPdzRsbHFpOTlWN210QUF2Qlg5dFIzUnlvYjVKcG8zcXhldHFt?=
 =?utf-8?B?ZGRpRC9HQVNJUjNOVjhibmZTdHVmdTh3VTF3Wm8vSGw0ZTFhcWlmVis0WUxE?=
 =?utf-8?B?WVhYYi9TajBKSUVKdzRmSk01OWZZYlN6c3lUU1NnTEI5bDNPN3g1MytVOFUz?=
 =?utf-8?B?T2FjRFpNSExMMGJkVkM3akVwVWRMVU9SWDIrMnY1TExHL1REZEVydWpmdkxt?=
 =?utf-8?B?bEg2Q2VJUHN3QllYYVVTR1lQaGhNek9qZ3Z1Q2JDN05qclhGWE83OWJwaWVm?=
 =?utf-8?B?NVZiQ2Y1WnFoV214RUF3NU1pQU5ERnFyaUk0bG5RUngyZnQ0R2dCZkV5VnE3?=
 =?utf-8?B?QmZKMzl2OUFVWklpc3NXajNRODNpRVpBeHZ2UVhNd1dTMGtzWThSZVBzVEpz?=
 =?utf-8?B?YnpucUpHaU5Zd28xeG53UjY4MVB1R0FTLzJrWEVON0ViYmF0b1NaNWRCL00w?=
 =?utf-8?B?bHFHLzhCc0FyNVd6UkZORmpkQnpaWVd3b2xRWlYwL1J2ZUJTSkJGNWR5YStm?=
 =?utf-8?B?UkxxTStiK2VzZk5Fa3JUMVJQNzc4Z0tadUVHalIxMkNNRk96ekJubDcycFdK?=
 =?utf-8?B?dEpQWFhUUmVXNkM5eDdwYTFyMUM1MTNmNEppbGpqQldyN3BpaFZHMWhBY2xs?=
 =?utf-8?B?V0NoMEtvRUxoRG90RDRKK1hlU0hBPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8CmrsAYv/zIB6Gn7so9+4sORun6fmJMjNx1yfKj/EmFRPCkp4yT3cJtM1buhAoog/2dopooGgVASeiGVf4EacN+zSx/7D343Ur2xyIs6wtgw7grKIAzo7Cq/LSzXzTTYclOIC9igfE+SiGI/KaFIDVbKQCi0i6VbOqojLpXb0LTVIGhP7uqemX4FHnE9rqL8Icx688kP1pq46jU2RVa+TlbWPdlEuQ+xUNFSCaDxbnbd4sYUswMA/ESSe5vs4N9RdcjmfDLy0Knv16fjtWhRiWOrkmKXiprkJ9iAaA3HJDDzQ+TbPkIH295T/mS2bSb75ozujFgyISFEbD5Ef2ldmOHl7vhkdKRhX6fsE/xTjB5RVP3MzUHOG3v481XQ8pNCwuyOEwRFnDIvdPbxX6B66Soi7Fn6JPDZbBEC4cDmzNeusPOe0LPi7W2TDwb9Slmu
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:52:35.9763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0770c005-5c16-4052-3e6f-08de73c51cb5
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6691
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



On 2/24/26 11:26, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/10/26 11:26, Patrice Chotard wrote:
>> Add "st,stm32mp21-rifsc" compatible for STM32MP21 support.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/mach-stm32mp/stm32mp2/rifsc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
>> index f8f67af4449..cf8026088f3 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
>> @@ -367,6 +367,7 @@ static int stm32_rifsc_remove(struct udevice *bus)
>>   }
>>     static const struct udevice_id stm32_rifsc_ids[] = {
>> +    { .compatible = "st,stm32mp21-rifsc" },
>>       { .compatible = "st,stm32mp25-rifsc" },
>>       {},
>>   };
>>
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 

Applied to u-boot-stm32/master

Thanks
Patrice
