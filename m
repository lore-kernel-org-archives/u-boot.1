Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97213EF5862
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 150ED83EF5;
	Tue, 24 Feb 2026 17:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="iul4Ld1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89DFE83EA6; Tue, 24 Feb 2026 17:49:02 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 043C783EC9
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJqvjGO9bZKvA7jVGuVXsfJWl/mVg2zdW7NtOkY3bIgumUT8gDofEG/EtQz61u818ZwWaYHCAIABUyOnwoNZJUbaaZcVdrATayQnKtapZgLwn8XEQPCkRgglrpKC1QJfl+82pHKeGloGNHaqWfIxifKU1NUfVHqzx5T4v3dJYDRrhnsUdVo3Oqaaqneuhoxnr+vnpR90rU5E7gshwql/VBC/EVvqTP100Lts1BN9PVPNAM8JUYrweU9nSxZbCAzhf5dfeDK7igHwkI+71JDXgUgjFXrR3Su7fnbCLsxUAa+oaBPptYpezHREg66fNhAb5ifgxE0SaBuHkJ5YvHfWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YkNAJ20lde8JRsygqDX6iN9xLelSaR1BIRRpaGqZ9A=;
 b=kLK8c+hX2aThUvh/4BgH8+ar9kSi5ifj13vArERZmTGjoVTxqOJ8vO4yXzN3UmlPBfnEDaq/YD49LMKcQpjGNtwb6aEl6uJ71QFH4btKl5g9pWCqJBt//3yb3c1rIaUYoD7mu2lH3WIiShHGvpb0gqSl8UDujgw/RPPd1KLGcUNmZOgPG8NbZ182/IhHdIbrKIfAyursa8eTbc08Awl5WU2fynJ6H6tWYrBi+tx4aHQOhP43H4qa9TZtNbWDCwf9fSbylPf7IN+5aT5Mt3KuTKg03pRqoaAANSUwYPgnVceGBdKy/UUaLDJBN+smWLQtNnXjBJ28jQlaQObyTSI70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YkNAJ20lde8JRsygqDX6iN9xLelSaR1BIRRpaGqZ9A=;
 b=iul4Ld1njf9G6pM8kBU4InwX1BVIAmvuGo21cLDOqR0wSvPDO52QGoKzUPxQ9fnNbpZbPpNCNAN70pHiV6XzD7tTEPKMgAK5n13esSokgLNNLEFZmgo8BOfUVgb32oRPZmLFa6BXidZ47Ws7P3YG7pSBX+ziXzC3CWGjeFr5PxKxup3Ty7Zeu/TBMUkvxKsIHHMOjN15SD+UwQZKH9CBvRblMX2+OkgPRISC1K3zXDZv2xk8O+snHiKNq1x/Ct4JKv6P7xKKPgVl4RJBuTdu6cvQFENp7sT2yNA9eMdjlWRcndn0LBEWV1H7XwuDOmdOMBpfGmXjTDm2H+2W8HHn2Q==
Received: from DU7P194CA0026.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::23)
 by DB9PR10MB7316.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:460::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:48:46 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::94) by DU7P194CA0026.outlook.office365.com
 (2603:10a6:10:553::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 16:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 24 Feb 2026 16:48:46 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:50:36 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:48:28 +0100
Message-ID: <3983c67f-970f-43f3-bc6f-a9b0071332c1@foss.st.com>
Date: Tue, 24 Feb 2026 17:48:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] stm32mp: cmd_stm32key: add support of OTP key format 2
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Thomas Bourgoin
 <thomas.bourgoin@foss.st.com>, Gwenael Treuveur
 <gwenael.treuveur@foss.st.com>, Lionel Debieve <lionel.debieve@foss.st.com>,
 Yann Gautier <yann.gautier@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@st.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yannick Fertre
 <yannick.fertre@foss.st.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
References: <20260204-upstream_update_stm32_cmdkey-c-v1-0-d95374395840@foss.st.com>
 <20260204-upstream_update_stm32_cmdkey-c-v1-2-d95374395840@foss.st.com>
 <3018e618-a28d-459f-b77e-4a0f37d369d3@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <3018e618-a28d-459f-b77e-4a0f37d369d3@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EF:EE_|DB9PR10MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2de3dd-4baf-4154-d215-08de73c493ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWNpS3dIcUZLbzYxWGxwTDRCTnVtVm14MkZDOVZGV24xUTBqL0VnU2o4Y1g4?=
 =?utf-8?B?aWYyVmxENm9mczRBYTBPTURaZGJISzh3RHQ3bW9GSEs4UXdXYWw1aDFEQ0Iy?=
 =?utf-8?B?YlRKckNkTDF0clZQVXFtcDdUV0p1Wlk0cW1wNG41cURYOUZPRTBqKy9PRTUy?=
 =?utf-8?B?alhVWlZTZEFZYldmUEdJNU82Q3hNQnZXYlFLS2U2WEhuZTNpWVc5NmJpTm1G?=
 =?utf-8?B?OWd1VXhUNnFnTGZIaDZIT25DT01TMXZYZEhSajh5OTd3RUFmOGZ1bU1iMXlF?=
 =?utf-8?B?ZUQ3Y0x2cVVaTENSM01FU00rZDl5cUJzRU5CMElCQ1NiRDV4WGNmaEZsN1Rw?=
 =?utf-8?B?TXluMFlwRUZyN1VnbHVmL1lGK1p5VFVHR3BZU05rZDZJM25yVW9yWWZaSG81?=
 =?utf-8?B?YTRGK09uVWFvWTJVQVNhUWtKbjlHVHV4UWhBYkhhNUtyUDcyWStlU0lNYnZD?=
 =?utf-8?B?U1JVV1RIbDhsMG1abWdKYTdEd2JkdU9RQjhVbk9XRGY5VERWTkovUmtTMjAv?=
 =?utf-8?B?NDhsbmtNMHBmNWZvNkZteFM3NSt4anZpQU1wYkQ3M01waUNoRUNBeVdzeFBQ?=
 =?utf-8?B?dTlNQ0t5dFhZMGc0Tk9vUkx0QjhsR2FIWW5VeXpid0NXTFNDWk9ack1oa1h0?=
 =?utf-8?B?SHc3VUZGN3ZBU2YvV0FqUmVGdlVyZEVVSllmZ093Q3hWMEx3VDdpTHdLU1ZF?=
 =?utf-8?B?dHIveVo2TVl3RW1PQUZYN3ZtTExKOHBoUEgzemt6S3JCL3BNN2d0SVl0QXFp?=
 =?utf-8?B?aTRsWnZLUC9XdW83UGFWYzlMMXNyR3FoOTExRXRmcGRqZHhlTis1MkNXYnFi?=
 =?utf-8?B?Ri95aE4ydHZIU0ZqRzQ1YlYwQ0JQaUNjMU5KM3BBR05keEpJUDk3ZHlPUFM2?=
 =?utf-8?B?N01qLzJid0N0VElrdWZ3OFZ2eEZtNVRCSkJNZ29lL3VPMU84bThlSkRaQWZz?=
 =?utf-8?B?U3lGRm8zOFgyT3pRQmp0VWxXVmJqNVNRaUxQTkNuTEdVaGVYclJDaDRuTWdO?=
 =?utf-8?B?RjZUWVF2N0VncWV1SEhRN2FuY3BSb3RxZE5DeStWL3E5V0FlRmxCQ205NEMz?=
 =?utf-8?B?QXJqYy9sbU1BOUFnNzBpZ3lDTGZraCtld05JYmlSUHMrdDBQM05DSG5QdEN3?=
 =?utf-8?B?VXl5eU45b2tvY0ltV3V3OFBTK2FWempaQldIcXhqOTFJYS9oaWM1My8yN0RV?=
 =?utf-8?B?M2hjbSs0ZTF4WkdhMHcvL0djbVhCaWpQL1J4YW1ldmZKbWpzTU1SRFR5aHVk?=
 =?utf-8?B?MFBLZkR3ZTZodEsxTUtjM2l0SVpWRllxNHRlNlZMRGgzR2tRTmI2aDkxM0Q4?=
 =?utf-8?B?eE1jR1VvelJhenVQckQzK3NvZnh0bDZ3VEc1NUp1d09qZmNUZVZ0ZEpVczhE?=
 =?utf-8?B?a0xKbmJ1TitZcGVVMTk4K3RrZUJMeW9FTUpNcjF0ZXBTUytURmdQZHV4cEY2?=
 =?utf-8?B?QXE1blJnb0hNU1htUnlLVkUyUmtEeXpUbHUwczFKZVpyaWhmTDBPS2FOMWwy?=
 =?utf-8?B?WFU4VHhlTFYxQzNtTzhVY2NOWWU1RW4xR0ZyMmdLZGNER0tHUW5Cc0dpRmor?=
 =?utf-8?B?cy95d0JiSzByWVd3WTJGeWZhWnJqN2FPdnp2OVoyT3VqMmVVMEFWbHRsZGpv?=
 =?utf-8?B?a0xPVFZubFRMUGF6c1FYSGR1bHdSR2ZiZFRvUExQT1R6ZmVxZDJsK2ZZU2Zr?=
 =?utf-8?B?c2xZK0Z1cmszclluYmIrWElBcG1BU3dxVVZvQzdoNWpXVnd0cG1ySEFYWmNj?=
 =?utf-8?B?WlZVRmc4bEk5aHZIakdjRFI0Q3dLVG1IVXF1SXpIenZtVkVRQXZWRkZrbWNp?=
 =?utf-8?B?dEpMT3RMV2FiKzJ2RkgwdUh4STJBaWFZOGNxL3pRakRsYlhRZXRTeHdONGtL?=
 =?utf-8?B?Mm84Qi90T2RZT3FtdnF4UU41TlVDOVRCNmxyMHpEUHBTVm5hMHBVV3pGVDZv?=
 =?utf-8?B?NG5ycTBzV2hiUXNtQktMU2ZvdVhsUGM4RCtYQUEyZEJVczBsKzlBZnF5dVdj?=
 =?utf-8?B?NUVZUDVMWnNkTzY1bGsvWDYwRnhra21DZjM4MFpYVlVMeDIrd2VjVGoyZ2xN?=
 =?utf-8?B?bXY4QWRnM1ZsSVc1Q1Btbm5QTlQwZ3lDcHV5Q1lDTXp0K3ZpQmFoR041SFZB?=
 =?utf-8?B?eGNCUFJjalRjanZ2NDV1THZxamVuZ2U1VXI1YXlKZlJpaG44Vm1UYW1ldlB0?=
 =?utf-8?B?Y3ZhVWlpdVAvZWlOMkh5aFppbkN6WVd3ZkdWaXNzUisxVmpFNGt2S1lwYjBT?=
 =?utf-8?B?N2FSckRXVFJHYUF5SHJYZm9pSG1RPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZnXBMj40ovql7L7Ihh6NBiR2Hn4DMG+pz6BORDZK6YBB/4NBFb4fYajVY5BcMMIi4inU5WNJ14r41FgN8iPXsgWMzenVjYJEEdKT+yAe4p2erJXZrjsOEgqMaXe3ReM4QRfhncD9zv71c+81miZLo9GXmrblWcuC2sz0p4P7sIg0kQaotY33O21//r5HLB1wH6LQ2k4Chzg1qMHfyhR4krnjKlp4B/fYZP3yBw0rtGoCPOmVU63ltmqDZr1cqDtPXK+pSMq8IuTwAVI+3UpnPW0MQD2Kw6qo3ycNxeEZ48jwVqq7Ri7A8GY6kqAzCqPJAOeK8WnwEK08mpuWmttE3stETeucnxWgLuKnHzkCxkXytfhYgPTK+LbpTim0HWalAheBbzi9HmgzDDlZoY2ooZDmIl4DsJUD+w2dggLPar8xlLBGPl6MGjq8cI5gGIwp
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:48:46.1340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2de3dd-4baf-4154-d215-08de73c493ba
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7316
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



On 2/24/26 10:13, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/4/26 11:20, Patrice Chotard wrote:
>> From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
>>
>> Add support of OTP key format 2 used by OP-TEE.
>> Key formats are describes in the STM32MPUs references manuals
>> section OTP mapping.
>>
>> Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/mach-stm32mp/cmd_stm32key.c | 35 +++++++++++++++++++++++++++++++++--
>>   1 file changed, 33 insertions(+), 2 deletions(-)
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
