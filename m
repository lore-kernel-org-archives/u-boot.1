Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA73CF3180
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 20:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3FEB892D0;
	Tue,  1 Oct 2024 22:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Lk9FpIqw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3F4F892CF; Tue,  1 Oct 2024 22:45:01 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0539189221
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 22:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlHLGZOOginKBdtSHwls31ilcEI8Ot/AdaBLJ8m3hiP1Y8az83ndJg3WkxYq/nehbcsRLRQg9PHvtSLrESv2YoP2Hi5VMtEOMXEgC4LfLbuOCFjdkJsw+1VU+dMjs4ntm4izuUW8ybZ+4ccN6Pf1xrHGV0/Igit2jP2X3DQUFEqS0af/0h66XI5himRYcTIaPoWo5VMWrCUQY+vHaA0QsxKTgTW7AiPOZgkwTproT4SLMCWWielCQpNawlXkFgaqnUnABOpGkpWeef/uUMcybJscOIvMG8EZrvzrKGw0Jga1Qvx3wZGym++Uycx6IlJ6hWGnmAsqJbmC0iCRckjaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIpKMrgieRd0uiFaGsLMiQL9c4w2nS6s4iimFPcCk4U=;
 b=UGkPo7Or6UxxR/zIGF3kTMocEQMtrd056H0aMOtdpqizRohX9g4wrzOBe0r96/c4V3/TJn986Qny8Cfw3GreO29g6bnTQfJrRUwW/6cYPr1WZ8VKokq2nQp3XON9p+UjRzKfVwdlCuZeFDH3HV72h1PpNh0RlmX5BCGJMETyZnrsYV7CMVi6TFkP91b+00FWWHoxTJ+9pf/UWRvhC+YuAsao4+pVcDL5pQHGklvuhv++T8i+YRCRYjZpB0hSPQASLX/jHo1830YrOBuN+a0PrmxafHSaM7KkRkaQEmtwU5dDBFqNhBv312ZdhRA5e/ZOKiORl7kTxdvRcihsqgIxnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIpKMrgieRd0uiFaGsLMiQL9c4w2nS6s4iimFPcCk4U=;
 b=Lk9FpIqwIPh/NGCaZFl6P1pnP7hwNzrKblxX/S7mkhMLKlCm7RvGJ4lPO6GCFMheP4DjarRc+P8iMZqp/040eVqjDcLkRogFp8FyNHtLUfwWmsI8cXTK8Ewj0jKA5/wm5WjiGUWTf8yhovXL5wzapZurWGWIm0H7sSsT3YDlbyScB3Uf1K7fClXki0Mpz40rGGUsrsWEdawQN2mBB+Xco/i+tS32DpYX/Zh15TPdJYHgS7IbcglVmM8fB9twzkL5HPA6swS78H9lr6Bm+10KKSWUFoaKTG79jAy6nozFMCIruSQyfm4m1XDLtgD0DuK0T+8B5mPquRL1Q1mjdsIfDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7812.eurprd08.prod.outlook.com (2603:10a6:10:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 20:44:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 20:44:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 William Zhang <william.zhang@broadcom.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 04/10] mtd: spinand: simulate behavior of linux's
 function spinand_wait()
Date: Tue,  1 Oct 2024 23:44:36 +0300
Message-ID: <20241001204444.917238-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B5E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: a45ebf1a-8c6e-49b0-10c4-08dce259e93e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nBfX3Qo6KHfHhS0lJEMeFu6FpuKjHNtcgYeTsIBcwirVtf6XDZ5zj9K/tG+M?=
 =?us-ascii?Q?EJhcdKrFVFi88+QFFGH74ecO9TY02Kak7yccMZH0i7oIW8RhmeGBqmb/lxJF?=
 =?us-ascii?Q?tnc8KpVQrulo7C+75Tr2ze5muYRtwqUXLSvWWG7r0ZL81UIHHEZtd8OzHjzf?=
 =?us-ascii?Q?7kc/zkJ1QqkXHXVP8/wkuabHOoKqccabbwlqObNAMj+F2brF8hcyNItFr6uF?=
 =?us-ascii?Q?YB7ecelp2RpvgTDzr3fyCHnk9Iu5sUMv+SACEQNZZb+67ksOi7TKJEz+GGtn?=
 =?us-ascii?Q?IsOqt8hDMZYgLUbJx9RQLK8Woy8Xr5j2C/GSA8Lk7OwsaIhgL2QQSRWD4SG3?=
 =?us-ascii?Q?nuckxROeYYsa9Xfb6asEHUKlvK4wbbQwh4nIqTtViblIWf9THuLf2FqvMbat?=
 =?us-ascii?Q?OvvYzicOxCs54aq4bRlf+RLS9+41CBtCRx+Yybst/zYeiHO5HD5ZOf8fxi5J?=
 =?us-ascii?Q?Cj40CXTIDJ8SBeMJNzIp0kMARHltsbELtJTDRQCxgBkVu/rM81LSkCB0oq+Z?=
 =?us-ascii?Q?73POn1MV3U+oawZ1LMU8JslKWy798gtxaBxTO5sa8FMJvG+Jb7w8NNOn7Wfv?=
 =?us-ascii?Q?28FDTwpy6twNVwTEGkZ62Py04Wg+xjGucXjMV1dVcgjMxAlbdd8lFRvC45lC?=
 =?us-ascii?Q?aL3mpKe/yzXBrFgH4LRYl8/ODYCJTXN+ZDYD4kpUPB0RlyETyMdIGYBA/X0r?=
 =?us-ascii?Q?CeILAeIXGaHFFLG4SJpN/ZRO8whcZA6IIn6AM29vvdIgGiD/bpR/C/0T7eTq?=
 =?us-ascii?Q?TlENQ5YvqZfMX/pzAWZU2a2vSa/XHH4WJP8uDs9szqIAXabd2UkcIbiIkC/u?=
 =?us-ascii?Q?QYZk3VYgDc56KKpAju4VRcrPdpVBNhcgImeNklSG4CcIV+ESGHkJcD0gS1Z3?=
 =?us-ascii?Q?rGcjF9vPjVJ+61FloQUcQjNuEwsjLWqDC/EPuiKwE+w0FyszYN3ntahtH99N?=
 =?us-ascii?Q?/3taxjSxSAHw+Ruy7lpMSEO0r7neju3wAhTulHHVPp2kcspknmakge2Gpgjt?=
 =?us-ascii?Q?IZvaoexY8glad0GERImVhnEUAxW1x3Au2slZ5hsDXOtcrUf6tlNkx/KhxIzi?=
 =?us-ascii?Q?FpMYLUYFC1BSjB7hldUsaHc+fKJ4UwcbGTumARCjHX0A9ZTkynmsGfg3xo0+?=
 =?us-ascii?Q?RKT4jGqm3nl2fi5KMxmGeYqI53kknqGAo6ogvqF3YnaZKUevSrHcHUuYAK6u?=
 =?us-ascii?Q?wZMclTf38Sxg7Jlt5wPgVl80IcqNJ6Sow+Q1iOxEHhkngZ8ZOlu0r80LsFDM?=
 =?us-ascii?Q?tImXTaz5kP7FAKqTx1aq8lo/IeqRqh4ZZR7D/2IwKS+JrcpuB0Mfqe/7N5UU?=
 =?us-ascii?Q?xLq6poGMalGoiqut4QWbgNJR+2T5m/RpDU2d/hecvTHYpMxOFgVZ2gzCCTcv?=
 =?us-ascii?Q?CRW4ijk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ur04r4Mtl91MM9NJr1RHYcvJxL+SYFZ0unif4PC2QAVZcxp4n9g+21Mgh3wq?=
 =?us-ascii?Q?BmlLuVl7gED3nJUVk56D/HhgdQuTI7pZuGEAzH+Mg/Rj8I0WYtJwf6tTDCRV?=
 =?us-ascii?Q?lLuM+YytVj/nPB8k+aRNJf0/fS3qC29nmBUEzhBxuIb12AU1vw0Sw1wlPUrJ?=
 =?us-ascii?Q?N5jn0dO+uD9GFawbIqDhH6gWhTGqWScSPDXdYAo9jcxlKGt6HV1jl0TFs9xj?=
 =?us-ascii?Q?9jqKqLATKd6Z7OCmt6dL9s1qcYj6q9lNSycWLjTcwin3vOX/4z0ai6DIbcbD?=
 =?us-ascii?Q?FL5dYJk/zVkBKH6EvVi9NUgczL8VuC80CQ9ShievmdGE/x5T1zvO0wME1mWD?=
 =?us-ascii?Q?alpGgumNkAODuubhWizpnMUtfhWxs3r1B8xSQPN7FkAlbO7kA2QigSAGYFDA?=
 =?us-ascii?Q?Ou9L6IoZF+NT9rd6o5zB+0ofTIQIDdL3ohsX/kdw+gIS7qMhYbhoY3wsVmeC?=
 =?us-ascii?Q?zddYnmiAfRwdXfzyy17R5BIyoJlalYU0zxNh1Cgxtly5cpByiMbMtv5/6yaN?=
 =?us-ascii?Q?hL5ZdTjiyVGdsNZnWUXNgQZRImwtPmv/W9xQfSUu7C19LdPeoMetPalgzC9f?=
 =?us-ascii?Q?W/hqWV+GOqN3BsN6kSORy7m9cobGF0APi6/XHMsr7WtD5t6dA147Wjz07n9A?=
 =?us-ascii?Q?IleRNHuh/wewdpIxDTknGFdqkRed4OTbqC3Plq8Odv1Qg8cEP/BX76nWVM9p?=
 =?us-ascii?Q?L2hS1rR0P+TTxeE5A8EUmFqLvxMS5gGgNHP00LNC5P+AZhzFOkIcfYvDqKf5?=
 =?us-ascii?Q?EDmAF1Tat4vdm9I7ChPtkAN5lgBtM4bYaTzpkFI0Wz94Ae2s95UUWPu4/j5Y?=
 =?us-ascii?Q?tPpWvOzaTpyFVL7N9s1bDpc3XrDpLhpDhmrTVFs9q1JBThrF3mWGJvRpnLpv?=
 =?us-ascii?Q?9nzamKtnpz7N+1H3jlxy9FfhTdlTHZNAKOC7gLaCCekV6YOXW6lYfOAdd7f9?=
 =?us-ascii?Q?Tf+NqZ93ki/jxf0h1fQFF2vXGOiKNKQJHtEIfygNbXjJlt5dnlnsAMojM+M+?=
 =?us-ascii?Q?vK6VcBYjuMpkS2+1LTzaI+/zUjDwUwT1Dthky4L6TcENk+YFVsHT0z4zlsDq?=
 =?us-ascii?Q?Zrl8vxrg4zdH/neT8k15FSobBQbIVjyDCMoifJ+3RPuULqiDneIHrnheUr8F?=
 =?us-ascii?Q?520D09MPQdxuNRSch/SNQ1HAFwcFyfE45qqMbu80LLAtDYpQndWkZfihRhh/?=
 =?us-ascii?Q?N09Nr/+qFYXehBzUb+q4es5lnh0d0znLuMk5tOeHhrIUSRbo7+sll9wMUP4f?=
 =?us-ascii?Q?y0rQ+Ck96RamN4PGebQxzo2DFGfmYMKksYT2LrGUqyMKo3hGhnGKEwv2EMQZ?=
 =?us-ascii?Q?1eei7e5K5dgHvgNcom7vTni4Oxav9pZ8WMOSLJVNshCEbPlWdtdsNXQkXwaH?=
 =?us-ascii?Q?m09YEUJUwy8UqY0A0I3DsM6E4+jqBCyY4JS4vuNN5YVaFEJR1K815+7YNiG4?=
 =?us-ascii?Q?4iBZghSdS/iugNZlTrJrHaiCmi/FWsszxKbl6qRUttyGlNArnKsfDvC/ggfC?=
 =?us-ascii?Q?1ItKcyAX+LRNrgfLjmC10byP0k7BhDcx3cxGdklDX+scxpoN5Z8+lJgOWBsA?=
 =?us-ascii?Q?wspxWgx+6O0sPTgvRikqQhWBol1mp6x50AAB/0dbv4GziUF2aihyiLP/RSvQ?=
 =?us-ascii?Q?H5bfyRa0Mwc7LopXYzWyVCA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a45ebf1a-8c6e-49b0-10c4-08dce259e93e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:44:57.4348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXqu7ZS/Dae3ICkT7xoHybOFSygDS7vGKlsJ0NMmDUG71jPJXluplWYbKeDS57r5HUezCoHKEdZuayKtzPDlwVjc6/hEVYiIcqJozi4JWVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7812
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
index 62779dd3e51..a10605487f3 100644
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
index 5934b7604cc..b701d25f73d 100644
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
2.45.2

