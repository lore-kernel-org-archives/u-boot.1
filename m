Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB90ECD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 09:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B388752A;
	Thu, 28 Mar 2024 10:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="tp1xicRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A63887E9B; Thu, 28 Mar 2024 10:01:23 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0709.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F4B483CF3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRTDdlXk2x9ECx8d6jERLd3PyBuzxExrSjCpklexhhZiK3OFAwpEYPhp33f96QjPCn1H8Ix0t7wzjdhFBCAuO3DExs7yyXmC//dZk7GxgjpjJ0uYc8vk8fTxYEwycroCO/ca9b846tUZ6xjit0S2/iuzZ3oABzMnb9OsG8sk4agRn0WGuqJJbatnQ7VlhGu3aYhpdGFT40hILrhXk8UcPUkcRIXGEN+JoYtqE6LPHV3ZCn+iX5ubGTzXdY7yf1mP89YrjoAKFSB1wIDwdxextNnYV2o8gNP4rRxGAhr03C2FRdv0seGCfQF7CJl1ahZOBhS/EduISuqM2DjGV+w4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XFXyQPl/Y3wE5z97oTejSXS7PeQmMN3WUaqeH8mTpQ=;
 b=CntNNoT1CusQMqRA9kPVKwIJxD3q/mHWmGHBsgH0ansbTjpKUnAZqBvYsfny3sHMe2G5OZ188OsbHjpJkAF8HaGvsYDTtCEtGaxiJSZb5muPD5BWwlSUfhZsQvjY6BGQKm+9RcUAbW3SkpQuIR512s+i2jBnTQLlOjN3+11jMC/MpQzZw5hIbrtr0gkzn7LR3KUxbTY5a0I+jkU9oSuxuSnL59mwaJd/iEGj1v5L7XygximRzkOOkdO+vCN4uXx+lcrjUKbuWqBAw1pZtcbHYvyjK59U0wKtlUV30FgQlxBRGoh9LNggGgMECUHwlHXxKXSn3GQ/bUrgQbavT5czMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XFXyQPl/Y3wE5z97oTejSXS7PeQmMN3WUaqeH8mTpQ=;
 b=tp1xicRx9oiT7WA81B1Vys+2bDncIarfG9QH0smhXPUNRPdNsnhmtS/Dx0xqeijdgfDVFSpefdIDl7a9ISnIgBEkscum5fbhWNe8GWnVGzEwRbtlMpyLYh+HKJ78Hltt7GSBL3Itugd3b8UmvkZ3pqdIOz4cgKsSQs/akXmd5cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by PAVPR08MB9578.eurprd08.prod.outlook.com (2603:10a6:102:310::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:01:17 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 09:01:17 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] Add support for jtag disable/enable and multiboot get/set
 for zynq
Date: Thu, 28 Mar 2024 10:01:07 +0100
Message-Id: <20240328090110.14683-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|PAVPR08MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 077dabf5-218f-4660-7273-08dc4f05a0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xI+e2Asodvk552s1p20rWynz395QyoBBr9MCXZdBhmAbZNXtpdzM7GKPtn/nSrUHr5MmjF2dBCiBaTvOJclcLwtnqj6zZbNsAV3W6jXlWYFFV7WI5JvOUBC9pwLnNuhrtDT3W9kdKa7EH8h2d18tuBLyzLQ2tuRlrAaKiadc9hWK36Cfyk7ghCkkbW+NOyw1YLLwKpGb3otbqsQaiu5ca5elnaDDZXx5RhCzVw3CVbPELq34K0W8UcXF+C1lyshLKSNd8yPCC2CBc78kvpPaMp8MveY9ZN/2mOl9sxka6/LGNB61TaAxRK1/kt9TmOf4t9d7Bnonp+B0U84ZX9U8DuLauHZOyKMru/AWPCQcN0jLUkb5flOhZwRv5BdQ2Z8qYtbsdnwY2+tePbTtmH6MmnhA/SNjJf0IBRWDnWubOhenMX0TBPMt0hE6+Lef88pE58m9xwVbtMes91qoPpwNEl/UrkuSi0Ovb7Czvyt3hCm4pYjt5DHZ839vx6wNv89rV5QDOI8pIs0yJGG+l8Ai3+qZ8BRkWPDL1FVbGVVqnPA//b31Xz7QwbjA4rwDNtCCdfU3GO+UcVqzPDjOBxRkUtqLnEqijswk/zLiokrLPui6jajXXW53yJVsSm6iQbMYuGaD30hVr9Acl/vUYpDZMcmY7kEL10Lvp8jelHDnqFxrcIl8Jcdc+Y1qo65T3Dbt00DDccskq0jTLsm7bX9mRLeXV/WPC+mEAu9IbvhhV28=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q4U4r0rm7//uH0ZVgD2lCLyhJKmPJLbF0JItPzpp2OQIR3X6r5pE+rTechqn?=
 =?us-ascii?Q?q7Hq13fWdCT0koZaTwk/3C6jJTOgA81HVuinlm6DODX5PrPG46gwEDzBjmF3?=
 =?us-ascii?Q?cwGPfn23PNs9YIgj1x273kF1MUWfYZq1HIFg/abOZ6EretHHLtwu7Ub528MK?=
 =?us-ascii?Q?B0Hv9CuFPPvRUNzDo0oZj+98Zt9ACytKLeYPEvv+YgQUIrFSe0eFWRzEMIS4?=
 =?us-ascii?Q?raPFsXJQlwiA1OMCPolUIho9euutLzpU9WAokguhqLBxW7LT1njTXZz17Oaz?=
 =?us-ascii?Q?NB46fK2qmSNvRj5AyjbplRhnRs69u3F6+/NaiP24Ii+yiv0K6A0ENb4lSKMX?=
 =?us-ascii?Q?TwClILRwLaskptGBI6Dh2cp0EzhZUO7FOm423rhOvzQwghzySKIl0PGD8Y2U?=
 =?us-ascii?Q?S0dYLDKGgfM6I16632ADcjR7kAdDcyNxNDQQ+Lj2EeHxmL45qv65gP3wn59/?=
 =?us-ascii?Q?3wYaDdupssGj0ee6sbZxcIf1WNFVkbZ5/YIviE7vY0rRlA3E3GNSJF+bKwM3?=
 =?us-ascii?Q?HWLZI/orq0qfr1y0fHQ25He/DQKztTuk+O39h5IkYbVzRtM1yfXe/UZroSjK?=
 =?us-ascii?Q?o3gSFbGPWTYFyMf8D1Czsp3OMPlfkrikT/JFp94v8lXJ8CanTGArvlLwroJC?=
 =?us-ascii?Q?7SXDL9HvNI6laSyDh9VdZMhRBG/dyBn0nQj5xcICptfcsDGdm/nXnbdHTP7L?=
 =?us-ascii?Q?6CEgpovsmFQSiJbGAttK/RxB5xLkL0YYAAfRHgRgyTgFgdyAuI0smBh4kXup?=
 =?us-ascii?Q?h10O+q24HNiu8J7sLM4YmUvXLzN2nSVgEKEUQLbJEZJcUjVuhtVO9Boq/GUD?=
 =?us-ascii?Q?arqAydiql/qVs/HXCY5lhTbRp5GnoiZ0uvyTyZBD/loJU+wmiU5/oSlgemYm?=
 =?us-ascii?Q?8xbsAEWB+SoxL56btcWqrPivDVQugdBRYYWIHN9CrQU5J0UY1X3jNaImyrNu?=
 =?us-ascii?Q?6peDPsr72p19iNLAuSrY7ii1F1NGYxIOMKPoNlsOR5BrMXJsEHtocEG5CS+C?=
 =?us-ascii?Q?29ZDioc/gUkCHGss7bGUb4ogsSP2uWMp0SQgaj16/Ba7pBJ28FcivSFYewG9?=
 =?us-ascii?Q?BtofFuA+YGKL99iGCOabHm5jEJ+MX3D7Hhk5Mrcg5drIeYOMknnDQhgT+FJ5?=
 =?us-ascii?Q?089xg3oX99t2IKGHUncB4219WRwo5IdhxNIIl1PSiRzhyn039AFpgbtYcOAV?=
 =?us-ascii?Q?OXakltydH0twXn425MORxjrWA3csLYgAYCvrr5HO1d9mmXhtAnHNvTjynqsw?=
 =?us-ascii?Q?s0idOWFx8D45zejINlvlfSEKtN4Lkmx+JPVeWBcAyUZ8HS3tLhR2ZpBj8gPW?=
 =?us-ascii?Q?+aYuxu3ru8a4MYkBk4Y7IsaLp+KZ3U284ODxmRMX/yqkD4wDqvsM4sf954Yt?=
 =?us-ascii?Q?vw84tQVr7T3B5yxAdTHeuaX45sA2O19FkKRDE3DlocnL7LpsWRTfE8D0IYup?=
 =?us-ascii?Q?4TPsGs9HBtGsKqfeKQ8w6quoWFz5BRNMgFT6uTPl7AAo3F7r8deVNR50CnJ/?=
 =?us-ascii?Q?2CxldvIDnYjAdExgw8lfJGgJLftCA8VcxEuSsam06phJK3CqJD7ZX6xqn99d?=
 =?us-ascii?Q?rFN/R6WI6EJDwTFZpFpYcPcWdriJ9fWYoQ10PBaoaSf+zH5RPo37iZ2NnLRP?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077dabf5-218f-4660-7273-08dc4f05a0dd
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:01:17.3064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5QoVPwZoWFCyRpi5L0G+h68iUO2VM2ViL5EtG7gdY1JOzuVAOhSKeGl6VqiXeAO6apqff71OW1apVh6wnGzVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9578
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

From: Lukas Funke <lukas.funke@weidmueller.com>


This series adds support to enable/disable/lock the jtag interface
from u-boot. This becomes handy if secure boot is used but debugging
should be poissible for non-productions builds.

The series also adds support to get/set the multiboot register in order
to ensure a freash bootimage search after soft reset.



Stefan Herbrechtsmeier (3):
  zynq: Add get function for multi boot address register
  zynq: Add function to enable JTAG
  zynq: Add function to lock JTAG enable bits

 arch/arm/mach-zynq/cpu.c                    | 48 ++++++++++++++++++++-
 arch/arm/mach-zynq/include/mach/hardware.h  |  3 +-
 arch/arm/mach-zynq/include/mach/sys_proto.h |  4 ++
 3 files changed, 52 insertions(+), 3 deletions(-)

-- 
2.30.2

