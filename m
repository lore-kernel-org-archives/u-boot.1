Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0280DEA3F38
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 10:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E65C83CE3;
	Tue, 10 Feb 2026 11:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="e5BSWusW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D6DB8341A; Tue, 10 Feb 2026 11:26:16 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 119F683CBD
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 11:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nefG1cY2+XzFnpzDtTSIUzwkZtI1A2wbppmZmR1CtnKjgP/ZppMke81anbe7pX//OEP76euFGFryR58ZuMXebk5Huo+903JtnIBdp21Kbt67BXiA8cyZzv2NkvtvGIHbGTXutc+v2+qghZDJKO0a6tmeEpBGaC1zIROnh2v6q4vwvvSAl6ouDcnWQ64+nMuqOQzDvrs17nvL/5QzESY8eqB9FuLLrYNmbVophllFwqywuV+mGxyqW/t9e8sQGklOLmIuGy/jGR3+EeGcU/pqMtEAE03U+CFhhotT7cj3SOKveigjBUjqHPub857U2/w3tHnSc6kpJKdB/Br/sZCoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9A7CJszrJfEzrsMqPOsSH1v/OPuygt4wmU5dgfPVFU=;
 b=jXbMiCZ0OF8OnLCeQ48YQ/PHYhlD1yV/1yRp4PotUWIL3FWpu9mIWLjGDbRTsEpWowGIEAQfwsNxyHYXiv2StXgXOZ5yKStxIheGlDv5FGTaylJ2VPiVD1Mih73hJ+w4bt70vlFmTQ2D89QuE/f317BqJ0IqZq+JqeV7xAR2ebS2JrNHbxHV3kOHHJh5wM2zxESqfA0A6rzNBcIK9KPo2BThLxxNVMyhLiSRCfmIaOUcQ1JCaXJangj+Ol3F3p3x6r4IKO1INZ1z73l0wE50Y4N1P9b+dLOYJcahhe8rhTbQnno04g8gkHjTWBTmWDGroXLy9PNkZfnlr/kQ/Tmpiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9A7CJszrJfEzrsMqPOsSH1v/OPuygt4wmU5dgfPVFU=;
 b=e5BSWusWHqP/KMrGYHd/C5ErgqZXlXJEe6k92fXvOuTaMaJjlfko/Kbus9WDQ0S1EeBeWcDb0ZD8ezRhK56DQDmvOe5QLs9EkjJ3g08QQZlyWrs3OKO/IuHkcCE6SvcVQ5Beam8t0Xf7yMT5LErz4sv5psZ3pe1gntYfDg/RFdBLia/BWTq7z6KfXAzAv7AMTjrFV62Me3jxvRla+UdNsi6PH7w59E2w6sQx+2wpNcL7CI7Hm/FdrDVp2XEzLMoRNt7RuRpokfvrqP73TZPSaCHN61Q4EFhp2mund+2t5cZUQxckZHuY++KunVdSa9uinkWV2zzFyy8sMIaATq5Zlg==
Received: from DUZPR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::18) by AS2PR10MB6872.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5f8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 10:26:10 +0000
Received: from DU6PEPF00009526.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::3f) by DUZPR01CA0040.outlook.office365.com
 (2603:10a6:10:468::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 10:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF00009526.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 10:26:10 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 10 Feb
 2026 11:28:00 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 10 Feb
 2026 11:26:09 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/4] ARM: stm32mp: RIFSC bus driver update
Date: Tue, 10 Feb 2026 11:26:01 +0100
Message-ID: <20260210-upstream_rifsc_update-v1-0-74c813fa4862@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALkHi2kC/x3MMQqAMAxA0atIZgttByleRURqjJpBLYmKULy7x
 fEN/2dQEiaFtsogdLPysRe4ugJc476Q4akYvPWN9c6aK+kpFLdBeFYcrjTFkwyG4JAQcQwRSpu
 EZn7+b9e/7wdTFxYUZwAAAA==
X-Change-ID: 20260210-upstream_rifsc_update-c881cecccb8a
To: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009526:EE_|AS2PR10MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 126f2548-1d1c-41fc-622e-08de688ecf44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHNiWllodjJpajcyMkZYMFVpbXdSOXJmNklnLzdZV0t4bWphaFBGeG9haUx5?=
 =?utf-8?B?blQ1OHcvK2pWV3VMWUd6SFExcHpHS3JseWQ1ZWc3dTl0amErdGlEY1NRNXdu?=
 =?utf-8?B?bWFMNC9IdHhQT3FpMnM5cnY3VVFIUjN3UjUvNEU0QzBoc2NSTTdEYTZ0My9v?=
 =?utf-8?B?YzYzRGZVdEJuMGtIR0VTUzRyUTZoYVUrczZhblVLU0JBMTB5UTJ3MzBMRUpB?=
 =?utf-8?B?b1AxQ0J2dTVPR1dHTnh1OVZ2eVYxb1pnajYxSW5NMEhOWG5EaWVQWjlMMzJX?=
 =?utf-8?B?UDIwazhJU2M1UzBHcVd0OWhYWlgzSXp6cU1aaWlDSkVLMW9IcVVBaU4vc1lx?=
 =?utf-8?B?UUlQRnFhZTNrZXBic1Nzbm9EUCthTjQ1bEhUTmhzSUQycVcvUWZ5Y0NLSjdX?=
 =?utf-8?B?dTVZa1hCNkdOWXh4MTJiUldkaDJDeEVhSk11cjFGYzUvQ1NJU0wwMS9XNmtR?=
 =?utf-8?B?YnJtc1JsT0VyT2IvdDRYa0JtUXQrbXdNYWRTL3lzMDlKdytIWUxNaFpCRlVI?=
 =?utf-8?B?Ky94YlZ5d3NLQUJSQTV3TS8xeXZ2MFRrZXhtQUlUT3dzTjhHVXpOaGtSeExm?=
 =?utf-8?B?TWUraUpDdzFidmRwL3p3ZG1GeWFleTBEVVRURDlTOS8rNUZBQmo2WE9GOWRs?=
 =?utf-8?B?djlhWHRPWFJpS1IzMVM2dlM2a0VuZ2QrblAvSXlLd2NGQk9sb3lpN01pMDlW?=
 =?utf-8?B?N3pWc2w2RDhpN0pPSE5DUml6MUgzTzNsV2ltZy9GN3NySWN0TUk3dTA2NUIr?=
 =?utf-8?B?M29rR3RFOW1PbkFqRzZZVG91ZFZZT2tiM1h4QWVNMVI5QlI4QUVVL0hmQWQ4?=
 =?utf-8?B?anV3amMxV205R1lNUExRcHRvYVgvcnAvY05iMTlYMjQ3L3JheXpZNWRacGs0?=
 =?utf-8?B?WDJ2bU1rbTdSKytzaUxpL1BLdXd3c1ZCNkZidkxnVW53am1Id0draE03QTM4?=
 =?utf-8?B?d3ZPVWo5bm9pSTI5eE5iOHdxeFREakxmTzgxM0d6QTJuc3VJTjgrR0VnT1FY?=
 =?utf-8?B?NXFCWkRDdm9ITXNzWThFZHVEZDJ6QTZJcU9XWU5HaVh4WDJXYk1YZCtyaktw?=
 =?utf-8?B?WUZWeVltd25kcTVYRGVBOTk4WEpKZGNjU2dBbkkzN3lYd2REMUxxRDEwcHhH?=
 =?utf-8?B?NG5JZHd0VnFrZTdtTERISk9UVjNxRWFTUVY5TFBoQi8zeVlOSXNCZkVHNFpu?=
 =?utf-8?B?OGFLRWRRZjQweE9jVkpieXovZGJNSllsUkR6em93NHV5bjhDaC9uRkpyNDA4?=
 =?utf-8?B?R00xVXpZNFc4Y2lHeGhVbHNyK1JGK0c5WFV6ZEtIS2pyQXVMaGQzWnRoUHR6?=
 =?utf-8?B?ZDg2dWtuL0JSangyeEJYVFhhYktGeCtSeTg5K1cwN0FRb3kyS3hnNEFkNkI4?=
 =?utf-8?B?RnQ0dXUrcXlodXVKSTNEVUNqalNrT3oxbkhoRGhZWnpzQTdDRGNNczJzS0o1?=
 =?utf-8?B?elFTeWtScG5MblV6ZkF4NHlQWWF2emFIS3BzRHpPcFhYWE41dGdoSnZpbHBr?=
 =?utf-8?B?SGpMTFk0MTlBU0orZXpZWmRDMWNsVU5ZNktCZ296R0JISlhYTVM5TDlyRkQy?=
 =?utf-8?B?bFQ5L0p2S1JrTjk5QjBqcmsrRkIrZUUyWXVXdzNnZ0FyeHdCUmZNeHpxOHU1?=
 =?utf-8?B?WHJQbDZxME1CVHpYOVFkS2JYb21DNVcwZFlCSTdmTkNMRDJZLzUvS1ZreGJE?=
 =?utf-8?B?V0VTTkpHdEp2KzJmM1BYUlVPV1F2Y0VjbWN4dGRqdUFXY0ZKN1hIYjNHVlhQ?=
 =?utf-8?B?WHZBOW5OMnlIVUQ5QWZhUlpIblhkK2srbHpuR2ZNQVh1NnI5V1M5Z2hENlll?=
 =?utf-8?B?WGszWVZsMjB4dWpqcmtZY3FqaWlhcTFDejB4Sks4Rk9KSWRnK1lxRTFrdDk1?=
 =?utf-8?B?MnRmV0YwSjJrV05xUkFJVkdrNGIwU00zVVY3ZXlobUhGU21BVy9ZVGNUdkJ3?=
 =?utf-8?B?TUVBTUJkM0FNRTJ1QjJXTWVCVWhmQzBoMm5jZFlNdUd3R3F3UWxDc3RUeUlT?=
 =?utf-8?B?ZWdUZjlHdlB5eVZwVW5rVnpNTWZoazI3Ym16M1ZTejZJMU5zbHo2NnpKWCtv?=
 =?utf-8?B?bFVzc01ocEU2WWhydnV6cnBhQThhWktTUDc3RE0zdU5XN2Y0bHV5NzJQeE9J?=
 =?utf-8?B?NGtCRnBLVm9XcGwrUW9JOGtTbDNXR3BNVWZycXRCckVZNkgvenJmRC82ME5y?=
 =?utf-8?B?MUpoQm0rbVRXeXYybVl0VStMV3lROFJENWt3dzEwZUlha0poTkRTN1cxYlpa?=
 =?utf-8?B?SW9zWGpEak1Xa0ZuR1ExaFR6MWFRPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Kl4gEU2jZFtak1oLy3k8tqW3EqjCXPATLebykoqaNmJHS3BTE0OVmyJAidhyiA5aSkXFHG5Znw/hxskPUyBZmUCGIRpK9Jol+Yp0O1INhg32NF41/wMAZGPd3Bp/vmGy1QnOOrBbU9zhTN36EU8t18KJmQRHCXV4lo9zKgDyHtYATtLibKFQlR4X+b7S0PHVvJiuujkBJGedVxVhNexekdS78HyvX4R9098q4kGCvCs3lbJ4Ht3lXuaiTji/l/5l7GklqUfy9LeFnld1Qhv9VkmeHfGI+AcnEkRVuew1lotchtg8CEFroCsvVpgyqa+ci+ZcbO45JLzV0q2b1iQhzTbjvjmYVezAcAF7Tv29g3lWjpcs/FSOK98c2x2PXkNjVgJYTZ/wKxxDCsVuGHFWFl0EF6OdYygNJYD/Cvvxlbnx5Aw8iFre0l5V9g0jW9uQ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:26:10.4103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 126f2548-1d1c-41fc-622e-08de688ecf44
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6872
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

This series brings the following RIFSC bus driver update:
 - Add STM321MP21 support
 - Fix CID and semaphore check
 - Check secure state first
 - do not acquire RIFSC semaphore if CID filtering is disabled

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Gatien Chevallier (3):
      ARM: stm32mp: Do not acquire RIFSC semaphore if CID filtering is disabled
      ARM: stm32mp: Fix CID and semaphore check
      ARM: stm32mp: Check secure state first

Patrice Chotard (1):
      ARM: stm32mp: Add STM32MP21 support for RIFSC bus driver

 arch/arm/mach-stm32mp/stm32mp2/rifsc.c | 37 +++++++++++-----------------------
 1 file changed, 12 insertions(+), 25 deletions(-)
---
base-commit: b99da05e1538b8fa153322da82917af2aa27e1d6
change-id: 20260210-upstream_rifsc_update-c881cecccb8a

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>

