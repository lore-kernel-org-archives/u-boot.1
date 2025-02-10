Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFEFC0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 03:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB5E6809A5;
	Mon, 10 Feb 2025 04:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D494807B1; Mon, 10 Feb 2025 03:59:06 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2071e.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::71e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62328803B5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 03:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8gD/o+nn5B6U/mrxuKv1225ARt4Mdh4jd/+EO+BOcEjZVRHtAbywP0AhjkcKN1xVC3Bot0JgnWLC+m1Tz8QSAyGnhzT+5HUSi51GonETpG4OQBTXLryHiwocwCSiJsQmCmtKcIGhjOlQK5ZEUKdFktLTDP4rEqrC6Uq1UHcOGQaN//CAeE0GztK7kswUkIXQs/47Xqo/PyOyVJgglkmiLgDSYgXh8xN5Qj5srEEH6X2YaJecwJyW4ylkBOKee/kEXhKTtt50zY+0dYRXNS1KZwewuCBAok1p9c5ndsTEIq+ZQZLJO8dCj+dfJiKjSSTZYCwQ+VAeGkf/Q7INB67rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Yv0FqRLFUk6e8nnL2216aUSQLFcregSoAXpL3VVeSY=;
 b=f1jeex2W9sBX5rWUVbQrQGa4qW5y+jyqS7VfF64VTW393haTgg0PejU1eSt/+CgiF+XFvi9O4JH9GQ6z/a23nJG9PgBAQuTgPls15/h+gKRg1Qyt0u5Xh8gA6HuHaJt4BdI8Hggt564AXpNF1lAxSwDrI36DH00w6IUpUaahGY/1Ync0Wi01tLms3tM2Z0CUZGZ0tqNwUw5+8uWf0MKtRoIPsQGk+FiMCXB9EG4jvbELOKvrBF99Vuk8ajzcyz8s5c58GrFabtbGkmwMz9Vwl3t5f7t6VUKD0HmvF+t/G/hBE6SZl7XJdX3hAbNJVHNlrOy9rZJv927Y8gsNsbGrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1290.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.14; Mon, 10 Feb
 2025 02:58:53 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%3]) with mapi id 15.20.8398.013; Mon, 10 Feb 2025
 02:58:53 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v3] board: starfive: Update the maintainer file for VisionFive
 2 board
Date: Mon, 10 Feb 2025 10:57:43 +0800
Message-ID: <20250210025743.22253-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::25) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1290:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0c5e63-75ac-4a21-bdfb-08dd497eda52
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: F4GOLc+TfoNxllZWVwrUKi0NcyeeC/oms1IdzQVDF+Q+KO/HL1z0qCYjqcKUQ06bvVPz7UaJdlZihg4DxnyWbavyvY+mixJlr1PL1QXBtDJEXH+PSaPobGZRcWiUFyJm3dvbNaKe8EIqbht+x0HQF30DJF9EQhf+H7cmgQNCrSYWB5wZ6jlbFYRruaGmmxoAWr8blK40hLucXgew4VwXSQSbkKLpKxXGxor7CMx/QkW2q2PdWCEuUHKg94zMt/p8T/5BHjlAImojzkL/ro0omksrE09UmjaQ9lBdh01yTJkXGegdH/gKPP2ab/3DjsXeyfjrFdqtZEnrBaVoY4Evb0ofAmH559Iu4ab97GaavLr65+NN8Zc0Gbodqsu0F+bZeku0PShvR0h15CdQmwrSePgxFD8XnWM6cOJ/vDu6KCKVWmfV7OufYrKFCj98mJnov52W/2ptDs9baD4ZappTZT+K86oSDpDVqb6Zpm1+ooHaEGz3zxJolbGXMgFYxJX6TYdGaB+AcfcpY/jLcxsnhqen4vfgRBMisr0A3jV9lq2me2d29wQBpHFWDC140ytBU8UmFkU3IrblprYWZfbNy8lDnjRSydUGg8FGNdYx484=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lwl4lXQ/rLcFPKl1zHiM0jZnKFDCITNN9RQ2rT0toOPdpKy3v+Y2vG2H0Kcj?=
 =?us-ascii?Q?9J7smKUdVJc5Qpe1sDf3ldikLQhsVZW5ooo0i+Da93NKuehQaLWuzFUJCuLb?=
 =?us-ascii?Q?V/MdhwEvIs2huvmkKktxUZBLijHlA8EjiC9ossEP/HJ0kiY6h48WGd7M9MWB?=
 =?us-ascii?Q?qZ4drSIt4FmPtGdb22Hwn62Mlct6tmZ0hjS3PVxCgIHpLXS/1pyBuEWjApc9?=
 =?us-ascii?Q?KKWyp4ToTyeJoxWBbwwOYU2JXMYIy+yGWuZhxOWpBW1sSo+y0N5SrFaZpTvs?=
 =?us-ascii?Q?Kk4UzyEp6vDdPc4pJkJ3rh2qzOB5w3cNm5Gcj/+9ef603QgIQWN1KaaieayP?=
 =?us-ascii?Q?muXfQUZ0FnKzaTHvehPyEJJMSltDQYiPQTNUsYCT2+5R9y4QU5auJIMeHmrw?=
 =?us-ascii?Q?UR3TXELULkzNaSFdzx04p9Eg6hY9LYYWVaN9ZjTwdDeR0vKgijfxV/yaMZpL?=
 =?us-ascii?Q?sgsVxRW3ZgJahbgq/bL0j99M2Wz8JJ5j+j4361lUCMhFBMsu8Dno2V2LOnXu?=
 =?us-ascii?Q?wngPKwgGqQ43TV46YGdaDe2xyV1c0sZu/dY2To29kT3TEI7TZ/3y7v2+CPI5?=
 =?us-ascii?Q?ycZhANXHB1uXEr0D76gHCyGSwWDE/q17j2aqFduo7rM4i5AcdgBc1/nykVOA?=
 =?us-ascii?Q?ic59PuTIL6yY1EL+ol3koLkdXZf+2FN6VbjufMWtpLAMIPb9EOZuJWc7WBW3?=
 =?us-ascii?Q?6vcx+jX6SsYKvrsIn9H/aGEUeM+Wt+RBJMZg4ZjNO+IsBzjssMIFMs55pe6O?=
 =?us-ascii?Q?yEUs8d8yrpqWAlf2/7QrOfJpKMK6ZmEZXIehEXp/o1m8fewcq8lFgBYwB4dl?=
 =?us-ascii?Q?CG96HKCfkE9JdlY7Wsn2P/v3/HR/N1dFX8f0F6YJ8Kj2bTPQPywnWMNoxXRT?=
 =?us-ascii?Q?MQ3aCjzNzw6Dy9+wTh2XzOPh8Aib50rg9HQiid9Aamdq0TOEcGjSZlbHxp7g?=
 =?us-ascii?Q?N7aRHXRdtnb6mx5K5JalQlRumEgx9l6NZRsnAnBT37lT6LMnEwykWARceJhv?=
 =?us-ascii?Q?Tju/OSqzj+xZhe7ca7vQ4Dzpxy6dVGugkCaaP7T58MypRiwmq12W/dl7v1Gq?=
 =?us-ascii?Q?0v7nlz5hyzt8Jkjj0H39hCn6n3lsWgugfUHYsWBKsXeFazaSUseBFQBbPWcq?=
 =?us-ascii?Q?DDwGDPvhZ4SfwORL+kdUFXaSS3wnkuSO9XFR3oPk0ky3c4RnYiXzx5MQXRst?=
 =?us-ascii?Q?sm/a9hZQy34X/zX2b7cRAYUdTyR3MrfqVwYRGtlMyTMNyX7rQIhIFgERt5zu?=
 =?us-ascii?Q?eUimYDuIFmNoPVxiahEiugeAooNmAWZHGnSaeFsTZ5eEs/SVR+j6/y2Z/17P?=
 =?us-ascii?Q?QfOhOfyjVhocrjNQv9wuJdk389HSSZXcUwE+A6s56NWbF/pOAzsebZnEPeeu?=
 =?us-ascii?Q?6GoMDw9mfvNevKvugQNJcIxA22xLLWH3NI6Xu0GmTXB1fy02DJpOhxFYNd9j?=
 =?us-ascii?Q?78NkkdTLrl1aApJkhBmt0Onfrplqq9LaWnyxV+bNfV8oKthe4QM4zXyUhQUj?=
 =?us-ascii?Q?cDdYY0HS1LrgkGISD5j7SbTlrZ7NYP0Rak4cEMSXaZrqbGs9SRLe4laTvdIU?=
 =?us-ascii?Q?nrJJWFSELTar72IPoHceU2BoulY+FC3VY/mH7Wp9/fF9FvrQ3vNyWFqmVEEU?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0c5e63-75ac-4a21-bdfb-08dd497eda52
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 02:58:53.5631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwz9vprQjQ8jVqsYnDDrMD46RAFLlIne3HggKhwXZFL7dhU+QQkE6+DV/1H2N3OLLshIM6toeLaQgPf0cheD5tcT8ah6gP7HWWS/VNPdWrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1290
X-Mailman-Approved-At: Mon, 10 Feb 2025 04:08:31 +0100
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

Update the maintainer file and mark jh7110 / visionfive2 related files
with N: patterns.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---

Changes since v2:
- Mark visionfive2 related files with N: pattern.

Changes since v1:
- Mark jh7110 related files with N: pattern.

History:
v2: https://lore.kernel.org/all/20250205025652.5171-1-hal.feng@starfivetech.com/
v1: https://lore.kernel.org/all/20250127083814.67839-1-hal.feng@starfivetech.com/

---
 board/starfive/visionfive2/MAINTAINERS | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
index d7f638f9b41..898e284ce2c 100644
--- a/board/starfive/visionfive2/MAINTAINERS
+++ b/board/starfive/visionfive2/MAINTAINERS
@@ -1,8 +1,7 @@
 STARFIVE JH7110 VISIONFIVE2 BOARD
 M:	Minda Chen <minda.chen@starfivetech.com>
+M:	Hal Feng <hal.feng@starfivetech.com>
 S:	Maintained
-F:	arch/riscv/include/asm/arch-jh7110/
-F:	board/starfive/visionfive2/
-F:	include/configs/starfive-visionfive2.h
-F:	configs/starfive_visionfive2_defconfig
-F:	drivers/pci/pcie_starfive_jh7110.c
+F:	drivers/ram/starfive/
+N:	jh7110
+N:	visionfive2

base-commit: ac3dcb0c2710c4917d93d6d2eb34dbfb00516bc2
-- 
2.43.2

