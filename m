Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9268ACCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9344C83B99;
	Sat,  1 Nov 2025 01:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hT8cxZTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AD8583B86; Sat,  1 Nov 2025 01:45:20 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C82D383B5D
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAmd8I3a2fRbwWbtM8dG/C74Vtb8l5JmWHPIvAbfGzdGDAMp7CAufOowGo69Bzq1I15QJn4X8+BUb1E1lWhaa50mFrmF9Ax9EiFgj/dgouHDABCSio69fOsIv0M2pZw5BooHI2Oe6WEl+Ou4xN2ACgBzv5fkmur1zCccWtFYWFtgRpPgkSq1IbhIN6MFgfvPmeR0r/ad+Haaa1HjNh8mVcJghCr5NmBNc4bZRYvZLlmCw3oYUv6S/RQepxbgTUrBxIqbMb+8zAKbwVhu8l5IDjt4wvM5yQc5WGcck2AmWfLIVqu5TQ+AjqZaGhbs5fuRpW4jRKxQnI5jGrrG+rRhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sSqOiv6Y3Rvlfbrv7Xvco49OvagnLO57+ZrWH3e0w8=;
 b=JQ0+X1wi7ZwCB5fB2o40iTncImGFEjoF0kyHz8SG+vVNmsYgEy3fvBlxeXbZTNEp/g1q+7XTCBy14jXAwzdKSlXjSEILoSqHAEG3iiyIfrxNVM2VcRL0HUfqPEI7dbtUirGObo83KtcODPflvCAzDasGgOeRawQ+82TZ5H6AI88xLYrBGozRWgj8lVzhr28W6knmu8d4eNNWYqcmnmmW/JwUs7iiA2RzESH0DK688kKRUEpOtiAuLo+fSQtJ3LQfpO9HhwPr4TwFI9ywOFyOR1PmSpnHIRDtw7LcUEqlRz99UWUNOwBW86q78mR1u75jqWaEqatpDO793xo5b9IfkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sSqOiv6Y3Rvlfbrv7Xvco49OvagnLO57+ZrWH3e0w8=;
 b=hT8cxZTU84T2mWECU5O5kTmIouxsRx8JzIL4n8pXSyDDAnuIWzdDd/70CMLFeWaxqV9n+zjTm/lFFv8GE0dV0Vl+h+iO7XlsPwTDG1eFJXoMsZiOyCTBI60DQw756V4Oa5pJcIlrfZUVeO1w8+IE/9UdQDJBli6mr38aAsVC2n6AZ9tg+e1Moj1gmzeLu9Dn3Ym/AwjM6by/wp1XdXJ2tTsTxoqkza3p5wREdXP4th3Lq2kmYTr7R/psurF2cWrzZQRQBn2BuPMjQMLBSz1l1NnIMAqXrRkMbKcPKWoQpfYFePXmjmKY6btSBgcUjNxMcG7uZXuZw7t3Vy9mgSJRLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9258.eurprd08.prod.outlook.com (2603:10a6:102:308::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:15 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:15 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 03/19] arm: airoha: introduce AN7581 helpers to get SCU and
 CHIP_SCU regmaps
Date: Sat,  1 Nov 2025 03:44:47 +0300
Message-ID: <20251101004503.2379529-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1b4f86-3f03-4692-7e4a-08de18dfec32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DhUprqXA/ziSTBA4Du6Tu7dMMg7m4a2eSet7QL445zCJt2/jvHQ+2QZ7ttvN?=
 =?us-ascii?Q?Efs+vP3rHHdWYUjxIe7OK+v0A0+bx8pTLFUfhmJlg42OVOb+69C2jbLwlbWP?=
 =?us-ascii?Q?al5LwtKpl6LWbkYomFJvj6XbHD8hK8MFsUMwQpOPKqhgLjm4/R/7EK7v0UB/?=
 =?us-ascii?Q?LK39V177SpUp3v9WLf+6owUqI84SPkOueG1DKWlmV730XPB7Sgtn5URwzXRK?=
 =?us-ascii?Q?hWp7SdA2dqhzosTNbRdp++7yZh0xxnnS/t+Mnf9QG/R0zpT+CGVdImCb/iPz?=
 =?us-ascii?Q?slyMFqLi+lFKPaLkePOHLTRQNxJNIdfME3vt5VRHZyZyXUaLRptfH+Z0xA5o?=
 =?us-ascii?Q?9ECAEqMiK4Y4MdI7PgRSbDgBO+Cyg0ognr2Q8eKD9ai6B4VzFGsklZ1inb6v?=
 =?us-ascii?Q?qUIFpaSiu5hNacYBIVw+/6lQ/sarJkYpMw0/CIhZu+VcicJ8dcSDPtMzpRo7?=
 =?us-ascii?Q?Ie8LQRD1yJr9EBtS/C43Xy42D3gCcVvRsuOKwEJRXTljZ5lvJIN+th2ZCcwQ?=
 =?us-ascii?Q?YIocnW56htX8xQHx4o5Db+AlTR+ovlBJibO8WI3WBEqEPGgjpqJGxuvuyal1?=
 =?us-ascii?Q?cShPZ3sqGHjZkC8wnCExoZOun/9EvTzjZDgKJkpW2MBUkqhg5mJYyQHua724?=
 =?us-ascii?Q?sJCuvcWhzerxxEZvWvFWzx8m9I7Z+xrJ1QrMrxRce6BaGBEnlAEkPmAYj3Vw?=
 =?us-ascii?Q?y6nYsjQgNPrPs+rJ82Vq7iAvwzP73BKbHDOV/KziqhunKcSkaRVtqHeXG3/A?=
 =?us-ascii?Q?41SzuXzY0LQk8qoV0O9Ygqg/wdmwk2K4oUfcPNryoKCAK1giO2PVZNDj+v85?=
 =?us-ascii?Q?ZILNjbXLRIalaPxHafuPalGO1Xb5UNBBv0CzKgRbLvM5/7m96ZsSuEPOi5wr?=
 =?us-ascii?Q?qUTOMb/EcFLlzrjKEdDMDwxw//PM+HkUs4PSKSJbudFgMpsJ9WrsRt0g92DL?=
 =?us-ascii?Q?9ky+80kxlYRNTlxNcoj8rTiqALaOWGWc0t92nDMc/Ze5UwWQfdYXQ9Bz4T9b?=
 =?us-ascii?Q?gRo7VB+WHUlUctlwOBdlealvijK6m8Q1mqY6mTpheHQtFZMgUDhVuZ6ib8c7?=
 =?us-ascii?Q?6D/2OguqhnhSd2VvPii75S7o11ljovsUkkhF0paAuW9JO3MNQ3qlcSYlRFNo?=
 =?us-ascii?Q?VXMZbC5NF2GEcE1PshnLi1Pe8Y2/uWnFWJgb/ARqWypGJdzsPW2FpqoWqrcR?=
 =?us-ascii?Q?u82hE53hUFfN/PgDLzN0edQFHlKZRZ+GC4XEIuvEuDjmXMLGXec0UBjmv3LW?=
 =?us-ascii?Q?bkqDbOFYwgw10WhhGwy72WBgIbYY/mx5JRTQwt3IBUrE8acsb/jPplSjDg1F?=
 =?us-ascii?Q?emu0PX7RvF7R9C2QHc3y/0leUgpZqhZRygK/75hKJU32+ixb9KtXfAkeUhUJ?=
 =?us-ascii?Q?LwAztH/RU9puHawCbLvPf+nmQ936BHkq8tv17EOwbSbdL48nBRfJjx9QUVLZ?=
 =?us-ascii?Q?5D/AUNlt3NivbpZ6QSoa3i9/EVNPxPMQ5l12LoJWxoIFo62iAQVo2R5+5se6?=
 =?us-ascii?Q?zrTGLWfimh/U1o0wIVUbfxwx621axvR6dWj2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TGwnZz5dq/LvFYMHNRP2Udl+5EvSOxHgC32GDpgQ83QujvPbEPz2CJcmiRBE?=
 =?us-ascii?Q?h3iEKHHBvKt6zUM8Z44Ebsh8uFbMYNpSBNNhiaiN2fDenu+nNoJMKjDXDgUp?=
 =?us-ascii?Q?uGglMxkQ7qPIAh05eIc3I8isCwYh+HrD65BXGG0WjarHkl67DqEgxCrm8AVh?=
 =?us-ascii?Q?QYb1IY/adT2EQzS+piXLXLgxOghfk8HF3+sH8NEM/gbWZAVpvbINam7AQU2G?=
 =?us-ascii?Q?u8dIM+bioHwIWYnHNa38ZDwzArv8qpx4WS44jRu5B5iKeHoPcW1C8g4/M92Y?=
 =?us-ascii?Q?lXbgcf+ZWVCZulo/mUEimnF8/Uzaa6tDkLITllygG/wRNEe+8cvN2YMchRlw?=
 =?us-ascii?Q?WfaDTQbr0wYmuP0nS8Z1Ljv9Gmg6g7r3F91VfGqidKfc7DPCnn3U6tX4yg3R?=
 =?us-ascii?Q?ZVIs5X+bcAmUAuL/VbU47101iHzE9/geNZZqdh4QiNdB2uxM4PeYfBhybRMc?=
 =?us-ascii?Q?CXkuOwV/5Sy5PmJhc/K+YxpC7XT7tRMxbecyi4irosTKvG0QrhworF4gFKTF?=
 =?us-ascii?Q?vrlT4e2ef4aSeiu+s8beQoa1oLaQsjR+QRKrxNw4/gvTOvhGAUmWi+NayBSp?=
 =?us-ascii?Q?dboqTc7rCNpdWolsV2cjFsw4TMe2Nca3kIW1aJBTeS8bxZBM359E/0RVC2fD?=
 =?us-ascii?Q?dioxUdi+0EbjxoS1Pf+YlQ9iiq8fL307QfCwr0L6mV8gm49SOpN+aiHicE9m?=
 =?us-ascii?Q?LJJUqla/BvKggArITyK/PcjVhAyuMskd+86c7mdo98uuZuGeki3FC6Pm3jkj?=
 =?us-ascii?Q?yIPZBJACvTaaDZt98xDgs9qABhRU7FBYkFSDXvgp1gQwEbVL7u+Af2w55QwS?=
 =?us-ascii?Q?0Vsr2SUH+0X6CPN1B3mBLG194BRdJ+0rq6N5FpdMGnIIUlfwMdTquWjh1/zI?=
 =?us-ascii?Q?6ZrIxUxVUkCaNJfOrIr9dxCLyhq5Gnprlea5i2Pdfzn9xWBdLqM6g/1yobVD?=
 =?us-ascii?Q?hjERZioiE/t/HQecCnrjIkkD0R03JeGgUE3I7ehy9WCZKp3lcEdWB6hV8UdT?=
 =?us-ascii?Q?ZgtJo7fh/j6ZA3SsFembip4YMXoDtpWyNqBSYo+p7hDMKR8qXb6g3kEIXPz4?=
 =?us-ascii?Q?Grptm1DHSem6969rZwYlxXKRodJGOYuzehKjmgti2JmUg7kGU9xn/nSiza/R?=
 =?us-ascii?Q?sDi2Mj0yjubPt7XBRdbWgaGFRhuULIyyrnJzdyMjMeCdWh9hs/yi4d9dWSe8?=
 =?us-ascii?Q?QzRhTuRZTBAzkYswi80qLAuKAnbpQFBLyJsWvcaPZ1vmV+kFMq0/3WhY6Fi/?=
 =?us-ascii?Q?K8JXiXaH/1AagQX1npRDxeyWaqo2ASvl2uSoyfm+ajgDxG7Dd1tS0udzolnV?=
 =?us-ascii?Q?04pNaRvFbjY7UsaQSNyzDcXoyQZIeYrVRPV/9NZG+8Vt12oz+dz3xoKNJoFo?=
 =?us-ascii?Q?C4GX/ctHPg+p8q4DZQ89+GORGl3ZUBi5XljzCBY7FJDhGMdAhBv31UWkrgx8?=
 =?us-ascii?Q?EHQyc7kZuMkjwE8tomRBVgDKCcmCLMhPCz3dZb2kumTv+jY4T7aGv1p91DTB?=
 =?us-ascii?Q?mQdX/nfwkpQVVM7wFdMDC4sAOuVx3X3PJ+zpP1Kmgrln0cBO/FpzaU3ClJ6w?=
 =?us-ascii?Q?6QnqOB99oWYtP2b2Velptyz9jpPyyjpEEdSnHqoVYEKWrWIbC9P87fsvAuUW?=
 =?us-ascii?Q?9TQy4EuZmJUB4qboW/iRM1g=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1b4f86-3f03-4692-7e4a-08de18dfec32
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:15.4681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cF4qmonx/mRX5X028DzMCdCP3JkdD5Mhn/vZIQ1hPCsSCPHlX7JCf6TEqylIxZ1tcGJPRjV9KTe0YxgBzyA/qHxCZ0aJJ1+vwiFMWHNnNDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9258
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

We need access SCU and CHIP_SCU regmaps in several places (clk-airoha,
reset-airoha, airoha_eth). Unfortunately these regmaps can't be easily
retrieved with a common code, because of different Airoha SoCs uses
a different dts structure.

To make life easy we can write a commonly named SoC specific helpers
for these tasks. This patch implements helpers for Airoha AN7581 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/include/asm/arch-airoha/scu-regmap.h | 13 ++++++++
 arch/arm/include/asm/arch-an7581              |  1 +
 arch/arm/mach-airoha/an7581/Makefile          |  1 +
 arch/arm/mach-airoha/an7581/scu-regmap.c      | 30 +++++++++++++++++++
 4 files changed, 45 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-airoha/scu-regmap.h
 create mode 120000 arch/arm/include/asm/arch-an7581
 create mode 100644 arch/arm/mach-airoha/an7581/scu-regmap.c

diff --git a/arch/arm/include/asm/arch-airoha/scu-regmap.h b/arch/arm/include/asm/arch-airoha/scu-regmap.h
new file mode 100644
index 00000000000..31fc23d8c4d
--- /dev/null
+++ b/arch/arm/include/asm/arch-airoha/scu-regmap.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#ifndef __AIROHA_SCU_REGMAP__
+#define __AIROHA_SCU_REGMAP__
+
+#include <regmap.h>
+
+struct regmap *airoha_get_scu_regmap(void);
+struct regmap *airoha_get_chip_scu_regmap(void);
+
+#endif
diff --git a/arch/arm/include/asm/arch-an7581 b/arch/arm/include/asm/arch-an7581
new file mode 120000
index 00000000000..d2317ed3bc3
--- /dev/null
+++ b/arch/arm/include/asm/arch-an7581
@@ -0,0 +1 @@
+arch-airoha
\ No newline at end of file
diff --git a/arch/arm/mach-airoha/an7581/Makefile b/arch/arm/mach-airoha/an7581/Makefile
index 886ab7e4eb9..51f978aa101 100644
--- a/arch/arm/mach-airoha/an7581/Makefile
+++ b/arch/arm/mach-airoha/an7581/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier:	GPL-2.0
 
 obj-y += init.o
+obj-y += scu-regmap.o
diff --git a/arch/arm/mach-airoha/an7581/scu-regmap.c b/arch/arm/mach-airoha/an7581/scu-regmap.c
new file mode 100644
index 00000000000..7beeaecccc1
--- /dev/null
+++ b/arch/arm/mach-airoha/an7581/scu-regmap.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <syscon.h>
+#include <linux/err.h>
+#include <asm/arch/scu-regmap.h>
+
+struct regmap *airoha_get_scu_regmap(void)
+{
+	ofnode node;
+
+	node = ofnode_by_compatible(ofnode_null(), "airoha,en7581-scu");
+	if (!ofnode_valid(node))
+		return ERR_PTR(-EINVAL);
+
+	return syscon_node_to_regmap(node);
+}
+
+struct regmap *airoha_get_chip_scu_regmap(void)
+{
+	ofnode node;
+
+	node = ofnode_by_compatible(ofnode_null(), "airoha,en7581-chip-scu");
+	if (!ofnode_valid(node))
+		return ERR_PTR(-EINVAL);
+
+	return syscon_node_to_regmap(node);
+}
-- 
2.51.0

