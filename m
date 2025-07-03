Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4A6C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 11:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4406D82F8C;
	Thu,  3 Jul 2025 13:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="LpCa4yFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 382FC82F6A; Thu,  3 Jul 2025 13:37:44 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D7A782F03
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 13:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8eHSCOd5hv2f0TsWR/lxHVx94h+CwzaeT6ymuKyykNXCttsbMtaUJev0wUCjhHvyC38nFc0uRtQw2+xaReGFMBTrWXSfJoWj7aZlRzbE3S1KUQkIaPUqOfy49TC67eiVEtZ7OJFhtGoUrgE6xu4wNi41hjaJfn3yvDhurZHrsP7qJtQzZgEFc0/ZWPJiWcCoRc0f2zb8tYQ3KveN58OrRZwkZKzHseCUNnaGZMj04MFT4ZbvybCXtXIkdEv5q+QzqENkjqN+JYpk3SLn9YJWTvVlaG1gI+R0EFChb3A50UAa6L36SDuIIcsjz9OOY8+FgjoRpBW8BE6eZp42Z99YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqpcNsG3kUCClC3PslX5XFSmbmPvq/HZ6P9orX3vQEc=;
 b=QLIGCCf1F4izND6bEB2xSH43e4Yk2zWblPIHUgD4cjbaJhxeG9h5Y6u8ZJHh038y3ygzJeYKcyaGDnTImP9W7jZDhi3WXc3E6kD0CrFS0zSJ9tirogYqpPJXc2V237PkTjmzzLuFlbWWkkdyc/wEIv3TAG8MEBruo/TE4QLny3TeQxaM/Vj+FtlMwIkqOazO3Sx2sNwTyhqlYGRLL52DdSpUlN6cOmSOmvkdCn9NyNiutlOoDNN6LfPkAQtqvtBvQKZ3mc5LJkHpYrSKjWKLpgasDDerJtCldFEqm60t0iBXlQTTzaedINeFP//Yf4s34neJCBC0Y6JoKAAc3Y3mcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqpcNsG3kUCClC3PslX5XFSmbmPvq/HZ6P9orX3vQEc=;
 b=LpCa4yFXtzFsFJmqQK2rgPUzR4PDaYoeAGgOcBbP2MGbVshQwGUu31qbdR3P3/GgbYYw1cL8UNXIPEymw2Tcgxgw/5rU2tpzxQc2Tf7u8CmpnUYdUxpo6REUSf+uZ/ChUoxUeIpQxnUSvXjWPxn4gt89z+UW+O/XF6FGZV5/yOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS2PR10MB7573.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:544::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 11:37:38 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8880.029; Thu, 3 Jul 2025
 11:37:38 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 3/3] limits.h: provide all limit macros for standard
 [u]intNN_t types
Date: Thu,  3 Jul 2025 13:37:30 +0200
Message-ID: <20250703113730.531225-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703113730.531225-1-ravi@prevas.dk>
References: <20250703113730.531225-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0012.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::31) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS2PR10MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: d30bf4fb-85cb-4365-30c0-08ddba260360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H1Eem0/RnjOwkaNByxzFukkOh1UIA8CxkkEikUQqT223TmQ5BLT5K54erRKG?=
 =?us-ascii?Q?m1sgCybeIIiJoOmaQuTe5kxsuE/TE/5KKfSmBlo3sTfWsT8YKjQ7TWBnrF0f?=
 =?us-ascii?Q?t5FskaYxcIY0cDNxgc+BQK6+PE7LFHOTw4tA7Q1er8GeoCrtmYUxiTPjBW2l?=
 =?us-ascii?Q?eE/braRKWTOHp0w+Z5DUh2gBQF/cJL5oA7M6FH7suFI0b27RfOjGpZ2TgWhk?=
 =?us-ascii?Q?G4dCPrJC9nTm8AtpHJCcA6nlyNgY0UFQ2C+4lCQ018bljyfJuZdckjP1eu1U?=
 =?us-ascii?Q?fjVxOtGZ/gVVGfunaL5lnBuIMiKXQihRKZejVQYOchhZdopGTfAa5570VGIZ?=
 =?us-ascii?Q?uYiLtHSna5oUWcLs6/hFXaCSakYcYiALUhq45ZiuY/Yr+76bF5Z6o98gLjbk?=
 =?us-ascii?Q?sk/oy2Jj/ZktBnptd4WFTTaE+WRMLCNigd3bNDbLayQi+Xog3osMQorsDkAt?=
 =?us-ascii?Q?nontCyp+dUJvWNPFqF0RHVgwA4Y4EhL1yc8ZrqKYfDr7ExcQUx+ZYVsXFr8x?=
 =?us-ascii?Q?pCVDRQlopc7a6r0wMJwyWzAmuYFA1ku4P1mZKFbLigPDzwRog9OKuQW8FfYz?=
 =?us-ascii?Q?yY89Gbe9+j4JmMZw/R9bhGsg64+O3ObugqO6+oCZGExS7LV3dVdTCXjX1RMK?=
 =?us-ascii?Q?zXGlbG/rfJBytgVTN2bT1ay7LSKev+FB2VKOdSSvXSA76O0KBu6oIvcDi6uh?=
 =?us-ascii?Q?UCl7K7mAmxnkkuxb7ze+bAFz47cSIehuGwPbfrIRX+HeoWgunTLc8XyUJKiS?=
 =?us-ascii?Q?2cU6Y/pDCYuMRIxJUmnwiA7FvyWzAPH4r5KM/aLRzHELzuxoyvxkB47r4qh+?=
 =?us-ascii?Q?eghMLIjacvQBuWLy30VzvKWvlfxX0B5LAEA2sqbKy2P9y2uONfg8nFq8gAUm?=
 =?us-ascii?Q?Vq2OA+SWb6NVynUa0WnATBGsktGk7VzOxZD2va9AVQxV8IP1TvF3s020mzIt?=
 =?us-ascii?Q?UZfNB4QmIgWtQK9Y/ESuOJ8CbloFZsdES7hK5oV9mwhjgXbgqk531Qtg6mVH?=
 =?us-ascii?Q?KeXSbQEEzaNB/4oIf5jnUBrTMvCPTXQ703UVrwjKKGBzwXcFPxz2nadZZm/c?=
 =?us-ascii?Q?kPqAM4KnhDssdCWUASzKO0H8Ob5hru6EZeOX9XJFh7jxiMOT/I7uYOTo7lhE?=
 =?us-ascii?Q?62bF5ADq6PxvGnrIoSzuDNd1Gc88z1QhfEikZnk4RJt1yeDzAma3PMcTupVH?=
 =?us-ascii?Q?WkBHBKII5fT6BUkwI4XgERM+nxrF50V8DssVavPsTlLWB4iZZZtBBLE2KbkB?=
 =?us-ascii?Q?udQZeAR0d3Q57eRHbj3K4RSVF/jL03Z0VqI/Fm0rUiZIfQT5khufsENDfK0Q?=
 =?us-ascii?Q?588IlTR2OlylWHGpV6oOOtRIDGA/yM7QOQk2+KmT5ohXDo8dedAHKpqTwydL?=
 =?us-ascii?Q?0PQRAItVNGxro7XI9rAQ0fU2N1nLmpS/+Lj9kzVErRq9aluxz3+oDG3jMDgy?=
 =?us-ascii?Q?xnmswUFvuGU8XRRRTXC63/LNkJRNwozQa8OndEF3mHx2E6NoTnyIWA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IaxnRs86tX5Y4JM2P+PQBdkQ9usfWMEAvQk4hl6pE7jWKYqz3QyTPHtyrFb8?=
 =?us-ascii?Q?q+bwXYJy9cRldDqKj24L0GYMx/3VtMt6DDuuJ1EmMHDna4Dwmdg+Yk6yuYl+?=
 =?us-ascii?Q?BgzSysV1kql0W2H1+bfjvDXKMi3qhKO/wiI3/EPlczb2EIr2t4jbjcA81atN?=
 =?us-ascii?Q?m7D21VYWcW6s7PDhofr+L6DKah+m9VrXgBzjbx/3FvBO1pBhCTa2ppjPl2mh?=
 =?us-ascii?Q?gVSUQ0hvncHkfG0WbQWewYMM3dI1wjdlK9WKf07m2B+35xosBIEjdFCXXUpo?=
 =?us-ascii?Q?vllBULNy8uOxkleGdOHOki8Byu5/zkKxBpnjKaJTv7dzjDcF+A2xieBJu/4P?=
 =?us-ascii?Q?d5mtd19kHBcA6YoL2gY+I8cUK+eKFst9JJ8wUKiDG+4XdeovUp7XDQDpk7QM?=
 =?us-ascii?Q?tCQVXGF/f8k05MlBGAxcHlLAhefB/9XR28MZtzVEDOZ+EvOc6f4H7eRXHkqv?=
 =?us-ascii?Q?bFqYqyCPLMLx+4uQMHIxxhV0u7zWvF6t1W8352q3aAzHSD5BbXsSwv8rk73E?=
 =?us-ascii?Q?ONDUOqmybOS1ns2ZL9sJN6Qy6DO/oOpi5/hQlKuUf8k773U98RXWVn4jQrjP?=
 =?us-ascii?Q?4Oxwr5wdDYJiSoFrU+bprpLMpGCVK6eNhwlCl3BRsjoplETSdcM58hqGepe8?=
 =?us-ascii?Q?W2NeY1xw/J0zT2mo4LWFOSFY1NfUF9QRlMaCCNo+XL8Jsid4oiF9f1y1hqUH?=
 =?us-ascii?Q?9jxEJF/XYYfP2rllkKhdpB0MXDqGT4hOUYc+fx57wUwGE+Nk6vCoZE9AYqCV?=
 =?us-ascii?Q?ENMHMDGGCqX3jmVkkJg/DWQFOcc0acyLdSAokD1Hl2AXJtHPmvApODLLtxgC?=
 =?us-ascii?Q?iyPm/GQJgAi7B8ordGU1WkFDD5E5C4DQVex9HwFbfbNZXZE9X9xUC8c6IHK/?=
 =?us-ascii?Q?BqxhIE+/yMCKpyP9XpDDAZZLvtoPpV5mgHfzKh5K727zg5rZ8xYdrRcQB1gJ?=
 =?us-ascii?Q?YZedKGZxoOdUYzwYFzLgMmTj4pdtPf0DCcLkzALnD7NB4vLCOw03KTiPj5D4?=
 =?us-ascii?Q?wkifchMsVV28Tvd9TMjcbNCF/QgRhpdNzHJ4OEE+fUUEfBNsiaC7ne/AgLdG?=
 =?us-ascii?Q?oJD1HgisM9XxemXJYawao4adt0c8JcCjIasp+z/nlcT6tpIYpy80LUmjL1rs?=
 =?us-ascii?Q?H3RW9Zy17exPBSnYiKUQMRfJ+zMvvlLsNPKQxtLPFqdlFPyogOjpsma87pn5?=
 =?us-ascii?Q?eYgnLWz2J6zKb8u7r/3eByAiw8iJs+Do4Ye/z//PBqd6F31AALxGmyGacykG?=
 =?us-ascii?Q?gcxF44chv1cJuq1LoscdYgg2yobk47ktaKx8NGxBof6ocgE9IxsXC6LCBptt?=
 =?us-ascii?Q?a5eC0n/RtqM78GiqRQg3OpPu8oMA/MpwDfWMGlnFWg2HQyYEhcDLB1gG9+O9?=
 =?us-ascii?Q?7TasBw5WwJD9iN43Z2d8LqtyVr8immXDVWkJeECJKtub7+AWJaYKCphMtw6G?=
 =?us-ascii?Q?VXWnTJhB2GvizDzlsV/E7nflmLhv3szMaVDHTZM7TJA/583iXhYQP9zlshDV?=
 =?us-ascii?Q?Zz2jAZwnvHIbuJxoYQ5i3zKmI6xa8+hpSwEEafkoYa0Jhsx7GbleZfLy9HA9?=
 =?us-ascii?Q?KZcvgdo/h4L4ExuSienXjoz3tHDl+UK1jVa279HQqvdntsEAlUmHK9YFEFjZ?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d30bf4fb-85cb-4365-30c0-08ddba260360
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 11:37:38.5633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Aj0B/SdwgEopgNx27JnHSVRJBZwXzmVsSkGpNG8r97ZRnUOemS8xhgAh0hEmYsLMi/IDJwbS8pleqme/zIfYWQbM90uVLsNm8FPHwPqI9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7573
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

Currently, we only have UINT32_MAX and UINT64_MAX in limits.h, and
then stdint.h and kernel.h somewhat randomly define UINT8_MAX and
INT32_MAX, respectively.

Provide a full set of definitions in terms of the min/max macros for
the types that [u]intNN_t are defined in terms of, namely the {s,u}NN
ones.

Try to avoid breaking whatever depended on getting UINT8_MAX from our
compat stdint.h by replacing it with an include of limits.h.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/limits.h       | 15 +++++++++++++--
 include/linux/kernel.h |  2 --
 include/stdint.h       |  2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/limits.h b/include/limits.h
index aa30f5dc8d8..57640a1c6d4 100644
--- a/include/limits.h
+++ b/include/limits.h
@@ -44,9 +44,20 @@
 #define S64_MAX     LLONG_MAX
 #define S64_MIN     LLONG_MIN
 
+#define UINT8_MAX   U8_MAX
+#define INT8_MAX    S8_MAX
+#define INT8_MIN    S8_MIN
+#define UINT16_MAX  U16_MAX
+#define INT16_MAX   S16_MAX
+#define INT16_MIN   S16_MIN
+#define UINT32_MAX  U32_MAX
+#define INT32_MAX   S32_MAX
+#define INT32_MIN   S32_MIN
+#define UINT64_MAX  U64_MAX
+#define INT64_MAX   S64_MAX
+#define INT64_MIN   S64_MIN
+
 #define CHAR_BIT    8
-#define UINT32_MAX  0xffffffffU
-#define UINT64_MAX  0xffffffffffffffffULL
 
 #if (defined(CONFIG_64BIT) && !defined(CONFIG_SPL_BUILD)) || \
 	(defined(CONFIG_SPL_64BIT) && defined(CONFIG_SPL_BUILD))
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d3d979834ae..e0443ecac84 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -5,8 +5,6 @@
 #include <linux/printk.h> /* for printf/pr_* utilities */
 #include <limits.h>
 
-#define INT32_MAX	S32_MAX
-
 #define STACK_MAGIC	0xdeadbeef
 
 #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
diff --git a/include/stdint.h b/include/stdint.h
index dea83c8226a..90fd2bdee08 100644
--- a/include/stdint.h
+++ b/include/stdint.h
@@ -9,6 +9,6 @@
 #ifndef __UB_STDINT_H
 #define __UB_STDINT_H
 
-#define UINT8_MAX	0xff
+#include <limits.h>
 
 #endif
-- 
2.50.0

