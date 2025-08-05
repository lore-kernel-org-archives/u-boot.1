Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14464C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C96AC84179;
	Tue,  5 Aug 2025 10:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="lOw2vHJs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB8538414E; Tue,  5 Aug 2025 10:15:34 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5AA28304F
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGYmsDJO9oAYLLgeOrixqKWjfgQTNBqYtuyQtT5ydmgW7SCs2keHYwPTbQlFJCo3DZNLj2UsMNi/moYXmMHqj1exLP98RZm1s2Xv2jx04srKppxWTwdXKiJt0tirSs6rudrSGjo+23SewFGXokLeC/msDRROTO7f/ef6+NnaoNONsbXJWBktcyX2MhrghYdydRtp4VZNBcVQWQm9wIrJrHiBFII1ibNHuYw02SaW3jsgaAsTH/xBU1GsEsvlenPFgJjHBzS0PEdqzQPD7dX9t86W/g0qwwzyqDveCWm7uoxMfh3LvHh6PLlWQmG+g4ifQEGACXxaex5a4bbuZVgo5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpbXnn6DY20jJOtBeiQ5nd2dW0hUh87EMimBLfaBjVk=;
 b=mnF9HP6LFNJkoclCYG2vNYWGndrStfXPJiCjZ6PcnEYj+3UWyVWZZg5Zw6fgkNS5dLtrlUkgqvHGcySziG2RrKmXlTieEFoeB1uLs/WzbAmoIvtG1gLBpsUHhOoIXLF0jtsP8xE28HGlI97GoOK+82A90U5GDW7jqYNTh830RfbP8s1WVf8llzZdiEUppL2Uphs3Kmp+bmRhU9LfGSQdwfFDW499pPIMGSHAq/HUKMet+ww1hwFXNqVJBAhDaHSi9l37L2/89tSsd89FIOH7kMbssJLf9b/7Y6jeKmdMqCdbWJ8MFuMb6ODR9Xc7fbafBK5M1SzM9kEpLXXAHq7/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpbXnn6DY20jJOtBeiQ5nd2dW0hUh87EMimBLfaBjVk=;
 b=lOw2vHJsO13SNHyisinGwg+sbVDM9SmTwqVIlFISQp26La4gOFhY4zLg9qEFGRcviUyaV++WerL/anN8Pb/w/GMgkZeb5qqjPFFIRQ2t7ZI1tGCtNW8urhsuHeLyBSjzlSYfjjrQcTsmIQsLf7I+ZOwurQzx99gjGIMm5SAYGXF5VbuSmJY5fduv2UzbPdw+iPe4tsO0gz5f/DbS065ePZwRJXwTmOzqeNwRE2Gzh/KcpQU289BBM5hz92QkPZ0Uj9t9P3SBxSm0PV+HyZBd/7X+oYClFUhhHCYwpkIrMUaAFGW9C91u5FgwJQpRAybKsx51gIwzuu5upCBcNy7Tyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6698.eurprd08.prod.outlook.com (2603:10a6:10:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:26 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 05/22] mtd: spinand: simulate behavior of linux's function
 spinand_wait()
Date: Tue,  5 Aug 2025 11:14:54 +0300
Message-ID: <20250805081511.1482964-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:15::48) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: a710a7ed-9c1d-4c57-8d41-08ddd3f83b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gx4+RLjUc/6hfjnOG8Mn4sJSYiZlSAMpjfUtBKnMhC2I2N/AfUbYcENLZwKs?=
 =?us-ascii?Q?L4TLAgJ7P8FjVuBoSBHSuniOfrQ5j/uThFM+GiwMMNJKNWzPV+QFQaAYN5qZ?=
 =?us-ascii?Q?aZbv/3eA00HQvLnF+qZ0Zixnb9JvGmDP/yXl4lav4oa3gWCWGw4XZdmKi0BE?=
 =?us-ascii?Q?myFCe5OmyGQfQTpx+VvR45C9mUkdYeH+m0wMzIqm+kSTYXIDmB555xBZmXYR?=
 =?us-ascii?Q?SSbEarWeC2A270dX0y5K2lf3OW+4HbD01odV/GbEy8sHnduYzTwxL3J/1OsA?=
 =?us-ascii?Q?ZmEC38F7HaQu0mhaoqNObxh9n48Ljx7AN7wXwGSjl6dPHCYkMB59HcndOVwE?=
 =?us-ascii?Q?kANvp3Q+XohyiDs6OID7rr3D5JqA3NNQE4V9/0lkhay124JN2nbpOeRijL4Q?=
 =?us-ascii?Q?iO+YaonsZHVO8Mb9rw1Lzpo3AX4Y19yvXHesOYG7Syc2pBY/t8agB6/THHbP?=
 =?us-ascii?Q?YmTMnfkyXZ7I9cf3ha37oQQlF9wHCu/DOyhck5sz/ZcUQ/3KzU7+WdDIOpdK?=
 =?us-ascii?Q?0Z8mbNWF5tKv0iJZNkYA+ebR/UFCKrQ3r3XXXgNRJdUYPt2vrObdLRb1AQZM?=
 =?us-ascii?Q?de0vR+M4uEzoe/V+0Oom7CgcR91SgRGjnn6CIH0gTtm4vDupIMzVDUSy9/ei?=
 =?us-ascii?Q?u/8ellNSmssa2S+5/lsGsd5Z68zB1dU5dMREw5ACzjBVyoDTl4Xo31baVFiy?=
 =?us-ascii?Q?/4BakTN9n+hpMmWoRsnkEroOFTcgcnUP1WamYfaboappC+eGQW5sx7OIb4ZX?=
 =?us-ascii?Q?kI8O0ZdXBOLFg2m7Wegx/Kqj9Tz/mKIbTN+BaHs9f1s0ShcUlUJHwDzFhTvc?=
 =?us-ascii?Q?t79N1BEBDMTcZOdQNJPh64MReGZLuqcjV3OCAgfa70P/dOUqS1kfUrjZfSb/?=
 =?us-ascii?Q?WO1GKFY3Oq4pdmHCs5GXmOxgWQbYz5bQbqZfWr4ATEUP99uRZ3ZmHQl/WNGI?=
 =?us-ascii?Q?2BPfqPUF/3O6StIeBmukXe//6bdReswHk3OpfW9PtxShihgK43LvUtfTy+1k?=
 =?us-ascii?Q?QMaiYa3CFUj3ObPOt0jJctcKBaL92nNklVCEwHlGALmc6PMaKxFhbeBomr9L?=
 =?us-ascii?Q?0Q+/7QpbsE3UGxMh56uJy3yLT9zS7zKmkwqg7xC8dkUeokpluuVuChoAdrnS?=
 =?us-ascii?Q?SalJKYMmOQXyEOg2x0R8DQZ15KaejsKxBuCoBVrANNHoXyBldIrMnXjbYpri?=
 =?us-ascii?Q?16VEfbUSY37TtwjSpJ/fLUJgjtFSVk095EypJcyqKFZBtxMz8mRnVrQAsIn+?=
 =?us-ascii?Q?Php3smhjmQ8g68cjw2PjOrWeb6jyr6v1vCV0krsDQvIPSK4uYVC4BnfQkFlE?=
 =?us-ascii?Q?SnBbwwjpqMHSGzTvQ62efRV/orO9pkWKxQTRoenGPiMBCzsPik8DbsYcucVW?=
 =?us-ascii?Q?5rF+PfxCUcxCb5zh7ZT2GL0aiHCvAuSIXpbUg+K6gGqRkWzzOIgs0pEmjk52?=
 =?us-ascii?Q?zkmzbHpqEoDSXQIFfaMeaqBbRR8xDMVSfjMIUEoJtQHGMRqr4oBOyWukiaRe?=
 =?us-ascii?Q?1mWhAHvVXulCHqI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a+KQJtkjK/t2fLU7VG++6dD+AJ6ABJMPdYfzvOdsOiBfHRHpX26Kor9Js7uL?=
 =?us-ascii?Q?pOIhDHRzYgxfM1SYxlpyPZRF8Ha3m/KqbZz7IUWBt7z/06DS9nXwG/e2zt8e?=
 =?us-ascii?Q?guswkSRdmZVlVw/IeEP6Q/GgMoEoooxl4O5n2rJXT1AdmBxoySwjE5fWBHLo?=
 =?us-ascii?Q?bkxu2hjTZ6QBni902pb3wMEsZeLA9XzuaM7kOvfI32SzIJbMzdRRMk7yo7yn?=
 =?us-ascii?Q?06a7JKV/BldHUvwRnMFfpkI3FB+h2DTVy/BmYUKUykpCK5ctLuuGAnrSvugK?=
 =?us-ascii?Q?NO+XBsYfgv6/QQYws16SVsLl5jzGswXtgsSMGmiK0qbf96ZdTppKWDAyVkDL?=
 =?us-ascii?Q?EwaJ3hs50F2N2eJe4t2jF9yUdE4mPAcgbQx2H9VgtlBrSWZ1CYdYk+1o3F+K?=
 =?us-ascii?Q?UYh5XfeZZXpz/XKi+SBDbSXiZx5t5wdq6JjPPGIZRqjLan+pj98fAjqPkJUa?=
 =?us-ascii?Q?McqzC+ddQ62OjgNnkbPb4+Vm0cYZKgo1rdHvQoBq+8PjeWgKoP9HGk1n+asC?=
 =?us-ascii?Q?9JcJErqpC3NvNj71n0sbGAFnxEIe78kEDrEXeKJi3p3Rug76yraX1jOjVbdH?=
 =?us-ascii?Q?KYbWCMcf0NRn2ISgSvwitGkQFAqrcWoLMgWfoue/H6COR5gGjnXTn9zdhDGz?=
 =?us-ascii?Q?l3PnONDNnFgkIjoxMwxa2qSmkuxrhe8ZoRZIC38qxqfb3Ory5O3KxZfNSsQm?=
 =?us-ascii?Q?dvKT0dxGHF2Gx51XHBJAXuK6AAiit4KdXkR2awgoRCPnryaXUAAPFD8Vdgbe?=
 =?us-ascii?Q?ji8Y/lIrsJiCoCjEXKa4ClSU8gaC9cUO0B6kVM6qL7q1Q7nj/0jpcC9qoB4W?=
 =?us-ascii?Q?wFnwYMjyu+gPsRAUJAd7gBwLWi7XoiWBuV8bflV09mqOzLjWSxkJxpx1y6hq?=
 =?us-ascii?Q?Ir39Hnn7HOPqueAEAZdIL6qEY5ALwOFzng6a0hHaHrLCwCuVZNd9SAZRwcKB?=
 =?us-ascii?Q?JkXWIme5oA8GJFETq98lkNIykqhL/+rh4KWx32mVDTib52SJqRuh87hf+pYz?=
 =?us-ascii?Q?MdLPeeEAWJL7WECay/XzAR0+wucyEWYe1+SVznEdPzcWc6uYtM1LssAFdAV3?=
 =?us-ascii?Q?JXozDPPu0djDCSQWOF33rPpSud40z85kaQ8Nq3GvKyc+JdAFFQHxnp9Kh367?=
 =?us-ascii?Q?TObwbyIS+epf0V2+/S09Jw3FHsxcOz1smgZML+PmQ+rBq0Kn4jcxcxXolWix?=
 =?us-ascii?Q?pcXfh1F0vTk9/qwM95eHye7iqq4w4xMU5vLEA1wC1CPEmkMQCF7ZGnsNmzDM?=
 =?us-ascii?Q?5mzwymc4gNxLFBfyRPgcnfib4nycwWtIDz8lpzzuHiNUL7p+RQmnbKIE1Col?=
 =?us-ascii?Q?brggY5cSNSH+fS39YU2QbZtg9+MrJrHZGIprBrsOKVIe0DH6B4wnvsDtzn4+?=
 =?us-ascii?Q?V6OJYSJ7A46oDKON1O+5xyIbG1rFbLX12XABOQqWejmMmbM7zSaP3qM+eO0J?=
 =?us-ascii?Q?NnqzGvJClbnLXlqHxhA0CQtg8TnqVbzIuPWy8LRychOE5vnrBZHa8wJYA1Xm?=
 =?us-ascii?Q?PCvWJ19N4vJwvVi1dYMHml92+OuJ1AkCRva06QRPTZVMcdO1VaPi69c+LVtX?=
 =?us-ascii?Q?F0WW55uO2Q0RsFbzKB0bGHM5yILO8RK2G9sDqwKaU5dAPPWBRIHKjME5xIuD?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a710a7ed-9c1d-4c57-8d41-08ddd3f83b99
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:26.3875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbgvzZ3BOadkQmKvaG5WXh0/KliceZIXGX6my6ZGetkX80rp2HiC78hpbIME+ThuSZWYId+m/civmrOTPvTFJ9TQ+VUlEDAImuUajPymkVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6698
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

also call schedule() to allow periodic actions

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 ++++++++++++++++++++++++++++-------
 include/linux/mtd/spinand.h | 22 ++++++++++++++++++++++
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 34e5ac33c63..f99568050fb 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -32,6 +32,7 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
+#include <linux/delay.h>
 #endif
 
 struct spinand_plat {
@@ -362,21 +363,29 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand, u8 *s)
+static int spinand_wait(struct spinand_device *spinand,
+			unsigned long initial_delay_us,
+			unsigned long poll_delay_us,
+			u8 *s)
 {
 	unsigned long start, stop;
 	u8 status;
 	int ret;
 
+	udelay(initial_delay_us);
 	start = get_timer(0);
-	stop = 400;
+	stop = SPINAND_WAITRDY_TIMEOUT_MS;
 	do {
+		schedule();
+
 		ret = spinand_read_status(spinand, &status);
 		if (ret)
 			return ret;
 
 		if (!(status & STATUS_BUSY))
 			goto out;
+
+		udelay(poll_delay_us);
 	} while (get_timer(start) < stop);
 
 	/*
@@ -418,7 +427,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	return spinand_wait(spinand, NULL);
+	return spinand_wait(spinand,
+			    SPINAND_RESET_INITIAL_DELAY_US,
+			    SPINAND_RESET_POLL_DELAY_US,
+			    NULL);
 }
 
 static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
@@ -466,7 +478,10 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US,
+			   &status);
 	if (ret < 0)
 		return ret;
 
@@ -498,9 +513,12 @@ static int spinand_write_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_WRITE_INITIAL_DELAY_US,
+			   SPINAND_WRITE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_PROG_FAILED))
-		ret = -EIO;
+		return -EIO;
 
 	return ret;
 }
@@ -702,7 +720,10 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_ERASE_INITIAL_DELAY_US,
+			   SPINAND_ERASE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 163269313f6..ba6c2ba149d 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -176,6 +176,28 @@ struct spinand_op;
 struct spinand_device;
 
 #define SPINAND_MAX_ID_LEN	4
+/*
+ * For erase, write and read operation, we got the following timings :
+ * tBERS (erase) 1ms to 4ms
+ * tPROG 300us to 400us
+ * tREAD 25us to 100us
+ * In order to minimize latency, the min value is divided by 4 for the
+ * initial delay, and dividing by 20 for the poll delay.
+ * For reset, 5us/10us/500us if the device is respectively
+ * reading/programming/erasing when the RESET occurs. Since we always
+ * issue a RESET when the device is IDLE, 5us is selected for both initial
+ * and poll delay.
+ */
+#define SPINAND_READ_INITIAL_DELAY_US	6
+#define SPINAND_READ_POLL_DELAY_US	5
+#define SPINAND_RESET_INITIAL_DELAY_US	5
+#define SPINAND_RESET_POLL_DELAY_US	5
+#define SPINAND_WRITE_INITIAL_DELAY_US	75
+#define SPINAND_WRITE_POLL_DELAY_US	15
+#define SPINAND_ERASE_INITIAL_DELAY_US	250
+#define SPINAND_ERASE_POLL_DELAY_US	50
+
+#define SPINAND_WAITRDY_TIMEOUT_MS	400
 
 /**
  * struct spinand_id - SPI NAND id structure
-- 
2.47.2

