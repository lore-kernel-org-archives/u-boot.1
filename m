Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F63BC52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD3B889FF;
	Wed, 14 Aug 2024 12:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="AV2AxiyI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A140F889D3; Wed, 14 Aug 2024 12:24:47 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9031D889AA
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfWfCBr+rcWi583gu6Cs84A8fbZtr4sI64fYHwzFSd8I+EcFZ+hRWFMmLBjYV7MC10s0mgCPXsMNTdHYrju3mqIM6yCiuiDDvxqSduYZFg9xeOq7qmMHdlyYk7BRUTMgn36nMrySScwY879alBJXv2j09Nxi25ayLEK9L9J1/wGy3/K/w9U7f8f/pFtjy4fN5t3aGgUZzZhDZPkdV6hPjR+TGQBY9/wsw+W6yFOantXhGdYEv/6ejORofo1Oi0uDPXNafjMIa8h/jKetIb21VHIWZAhuOj0/0E8zqA1CRPA5NLD7KJRNDSFH/WCY27FfNUVCejbOvp6oGv1knu0Xww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d3KkDaW775IMmGfkKZVsxAUMUwmiquC842Y2bw/f9c=;
 b=Jg0q7Ub4bnsCzuGcY6XiLSAUUThYIYBj4LGFmZvG4VvjTo9WO5FtrOdHu8yUcMJzT4hEHroV/aT2A3slY1xGuB8DMHE0FGmeC8UGFCz7o1U9ToG1BeVf2E2iVUIHT8Mx+vpFSEzqSUjTOsxIVMHGsazMC5KjLkbCdE1AJXne//Gdx95KWCGMFNP3As8+l0YuK3axmLKz85tXDzTUBiUQp9ahkjVvwjl3w7aqASLpudLgF6g1QYIzfrm5XIR38uwIgu19rJBVkDktJL5x1kRe/QgUIT2pQgu9RPcDEWCEocJ+xmdYuq8uEGaFZqj+uqNeCx+jhSXwLUFEiSiyMeD6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d3KkDaW775IMmGfkKZVsxAUMUwmiquC842Y2bw/f9c=;
 b=AV2AxiyIieex7VqHpeR3V+el0VCKy6w+xUcY8FKpQBHXbfOZ/s9zuAEf9kSqjSC/gP6a5z57teR0K9Q9M2ZArLxoOFfSg3+GR4MDuTIutXq4UIGBJ0e4kDj8ATbIpY3QnTPBZ6P1HbgTVwkk6Cjs4r6KRZRQSTMLmxtVvmWS+ZvDd5QxHz34KIIn/irfa/mYfNpaQZK+hauNVBfdMxn1+YstlEZTeaP/7BPrPkcsSRzc5bbDHsNFbNbpiG3mF0DkFsf/IN9HAz3ucWNQ1WOdJSBn4RBiuh1xCdZIXbfEnSZWsMY674mI6l3rLumjmxnX8aDeeQdtuYZbaDiz6Hfy7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8491.eurprd08.prod.outlook.com (2603:10a6:20b:566::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Wed, 14 Aug
 2024 10:24:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:24:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v2 2/3] cmd: mtd: add torture command support
Date: Wed, 14 Aug 2024 14:24:27 +0400
Message-Id: <20240814102428.1347425-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814102428.1347425-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814102428.1347425-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0307.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 026107d6-d200-420b-0eec-08dcbc4b5075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|1800799024|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eKY6KtQFr7xekvhxl+/3yz5RahHt1ZDFSm5zy4+yzBtZ4jqfWbsNVPbnh6iN?=
 =?us-ascii?Q?6+uGzGtF3BXhBXjZ4yRZSMEEOZS0PaKY+FeVKDp0pqM++ocHlmVLZl1b7Lr9?=
 =?us-ascii?Q?NLKXAV/YV8FuKa8hMN3qCT+D6iZ1Wy9VlKTSQNMkAaSFdtRDWpD51e5uN4Oy?=
 =?us-ascii?Q?FBklMpXGjwONDTzysKO4Sd15Nj5kh+y1gBDTW3QC3f+vv7MzddsLw/PyAE8b?=
 =?us-ascii?Q?w2a2AdJ5LtW5qeWnpF42/YrE/YJdCg26Guo7ppoWimBluBROdL/WpeTwb+ib?=
 =?us-ascii?Q?mwdOePcjWW2zGeO2F8awH7vttQEhMsWT4omeAcaJjjlFANu+zxUqV1/Ay1k7?=
 =?us-ascii?Q?iPh6qhmdA5cJQAZTEHl3/xO2n0ZzFagUWoo0viTYoQMbqeqiJQycjxEwUgQx?=
 =?us-ascii?Q?IKr5RTUR4+6WJhF+0C7L1s9xDU2uqnrG+bR7GUEZ/akWsJX5PZ8xl3sxNa4T?=
 =?us-ascii?Q?hxFy1n3v4lK1V6CCq4O083UFxELAy3PPxSJPM5fMjZg88WgnkOtXl1coyLtm?=
 =?us-ascii?Q?m37AZhA250kqHx6mBN1tqG2VHP8IzVwY8Sh85fB2ljZYd3tuhrEQvi90V2GR?=
 =?us-ascii?Q?rewBiW71rkyNsFXRawBO+KJ82dXHN5s4tvgYwosX48dfGYZtGBIXvLJ9xVnp?=
 =?us-ascii?Q?55uub89Q3/LthkacVOc+PHDpJVknZ15A/aRvLgQh/S2ToM9903xHQuWhSB99?=
 =?us-ascii?Q?zbYyCUCXuWt9rZrIDXmoFXjcxy2RH/jnV2Cpk9oloGLB3ED1k2ya13+XotPR?=
 =?us-ascii?Q?hI/P6ZLwVWj5U2FtFGLrt/gOi/Cc9OnGA2IBtZ1N1Pu57SebOepnMriM/0/y?=
 =?us-ascii?Q?+xYXru8jAldRzfaLM97kDHtzBzNWyGGnYh9TFDCTs6fnA9G3BT9BDKFE/oRd?=
 =?us-ascii?Q?2NSySpYvnlpG3xv/89kvGi+VsHDksiZVgpk0I3l5/RasOBh9NhT02QzTtjeC?=
 =?us-ascii?Q?PPcgGGKTAvWWCMDaKo2Lg/6JvRYCpGz3JagFU709018/VIhaCxYkV5o8uMoW?=
 =?us-ascii?Q?eqf0KQlAwHG5u+FjZuIkHaL7TTYmamIj4ODFLtrY5gQxpp9e12TjyfVBetaW?=
 =?us-ascii?Q?JPHBjelnfvhZPR1dI0PuBye/KE0FoPEKzrpCsURKPOoBMhEQHPx7WteleCGq?=
 =?us-ascii?Q?ZPXTvjRhd0SZFIbuqZ2jfX3yqAoLTmCe6lg/mnl20bGaZTDJDB1+JmGxvQr9?=
 =?us-ascii?Q?0ybZt0ZAraGfMjgsbv/PkncZH7t8LsZlBYeHYtcWB/vHcEEREnbWE66eLLHB?=
 =?us-ascii?Q?MDYpZWP4brCUWrrhBPVTwnSs/kfvcjOcomiHoiT6rPk0FBnAvd8IiuRIQErH?=
 =?us-ascii?Q?+uCpDLVAchrGL/v7Fjn9fIL0wpdDPBpqjQojqwPEHuKeyng0OZ7/xM+EhZkG?=
 =?us-ascii?Q?KyRttYcKPdzOPUibd2zneIySisLqhiVGDr5PKTTQ8AtTRfwLavmD04m238GW?=
 =?us-ascii?Q?VWdK32Vd2qU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eAkfBjXzgoGxw0VwArcR1zI9Kh5ErecrnycJ6Twjah9nBLKMA5YARVt/rETo?=
 =?us-ascii?Q?n78RLfTEngp3tkfUExdu7DqwZMSeDgeodmkRukg/PM3xuFPcMMgIxqq/cyGh?=
 =?us-ascii?Q?iZJAgDG+FsWtTYE57Um8MYJ9C0982TK/c/78DUuj48qZDRskxRFwnTWbXANC?=
 =?us-ascii?Q?Ejl/OJez6Emcq4oQkIdetK4xPAPexoxTZn+jKaIW9SJFRsl2oxijakkbNsCG?=
 =?us-ascii?Q?SnDfu489nuokafdryT6Ys3gKPGdqAGFSImsbV6PRgAshcnbOi+izVSJK9nP+?=
 =?us-ascii?Q?g8RRy7v1ny7ReadUat5b7zGVDX93L24s4j/hrlE1RJxQWKInSy8ss4Jyb3dc?=
 =?us-ascii?Q?FLBFJy/s1AzzVyoL2I1E54tjLmYWaQvb0skZXpCFc/3zr8Lpa4iuEBdocAeG?=
 =?us-ascii?Q?WCYHEtgOhQQDyczIEWPP+ZBrMiYkQ0dmCi+sh5tPZ+2cfVWluW3cPyvqMvpe?=
 =?us-ascii?Q?37XosOybbpMI4tgHalJTxFYI5GbNwpvbPYvNBdhxojnhf3UM2XUdISCtzAuN?=
 =?us-ascii?Q?5M43GSicKyzXKX+O8WbwGiZOGGgtuu5z6XyDCPTQvCYTiRFF4ft8UdOsbfQa?=
 =?us-ascii?Q?YCiZXNUCEpJeNW4gz+He4RMQ5IxtPnQoJqrPpqP05essSIGbkw4/uevxUKzF?=
 =?us-ascii?Q?g/oaov01d31WOljD91TYoqNA6R6GpqHcPEAg1LmcyrPsMgLnQI7p44JCJ1O+?=
 =?us-ascii?Q?U0mMtuJHyj7iiYW0sVRblsXRLdIjEJW2lvB2OgoCzsm2JCALumU2eDVMwaKP?=
 =?us-ascii?Q?3/WkygnPEX4a4mntsu1lNPBWGUWYTiuYZly4U3ivHddrpxwQIlk2HcQy6IYD?=
 =?us-ascii?Q?oZZRXHhY6uIkqXwHQ68wk4Dr4EeIyYy82rTjzaT9I8wvVWPzR/2lyCLRcVHA?=
 =?us-ascii?Q?thGKCDr5U+8TD0KUtiYZOazEGFpS7XtWTkWfyBr9qgFdjB5WMAg6G7h0Q7w6?=
 =?us-ascii?Q?p3VOrRf1wqepVZM5rXgouW44Rbk0Vkvp7TeB/QAwR6Cc/w3HxmMPr1gGHRzr?=
 =?us-ascii?Q?e8g84e9/qS/r4uQWrWEIj6BBUHFDAR4KIm6Fg8YtZ+NyD3h25Xp+7Y5zmj2A?=
 =?us-ascii?Q?hJAmeIxDicK6+sSaqhZk1eRh44bbSxVsDGqggYA7PQnlyaqk9ZQx1LfrvMVl?=
 =?us-ascii?Q?xOrVpiuhcTAyJlbdKhPdM5JT45C6FVMZ8KPNNaHe9635ACidU4JrkY6rgVaw?=
 =?us-ascii?Q?kldtuURZebhJ9qYSW5dblndRlNUoYjUkldmLGbyrY3hhG982ppIAnN3XmtQ6?=
 =?us-ascii?Q?SXMLXqSUzdydT5fYd9UqvNzDPGPw1+mkRQy3nC2rwxT+fTHSsD0e9I6BY6dP?=
 =?us-ascii?Q?Djn3AROLe7rpFoa5WZUDrz83YifxtjpMUFMZI/UsY1xcvKuGjuJ8tANqpcpw?=
 =?us-ascii?Q?cRWqUH+glaXySF2z4RDc2InXEFfYL8iPZb4P3rWrhNQLB6GUpw0inQ2yhvwR?=
 =?us-ascii?Q?FY6Il6jhUwB6eTebn2UIXfpp00tcGTcK8Alr+L3YESM2nq0r/2AnhbpvLpT/?=
 =?us-ascii?Q?zJQwFBCFh0gSiZMqrPutOVodUoisQGJSPWJJeg00p3oi3AmZQ5z1AWsKbg9H?=
 =?us-ascii?Q?67G4tboS860FIgwMUNlwmBrC7SN4QeEaInNaMOa0iE3GZHTBepBYmEO6sD7y?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 026107d6-d200-420b-0eec-08dcbc4b5075
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:24:44.0296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5+zbnXXMnddhgDLXoUA6jEmAFeZ+K8lQq7felfgEt/IDSqkcESVKL86ms3Ll0jbmIVlDa9CSv61kO/LJpinPDvnchCctBsyMVNhfPIqKts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8491
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch implements 'nand torture' functionality for mtd command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |   6 ++
 cmd/mtd.c   | 196 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 202 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 53ebafcb610..698e0e697f2 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1439,6 +1439,12 @@ config CMD_MTD_MARKBAD
 	help
 	  MTD markbad command support.
 
+config CMD_MTD_TORTURE
+	bool "mtd torture"
+	depends on CMD_MTD
+	help
+	  MTD torture command support.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 45084d39d3a..69ddfe1d9c6 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -18,6 +18,7 @@
 #include <mtd.h>
 #include <dm/devres.h>
 #include <linux/err.h>
+#include <memalign.h>
 
 #include <linux/ctype.h>
 
@@ -742,6 +743,194 @@ out_put_mtd:
 }
 #endif
 
+#ifdef CONFIG_CMD_MTD_TORTURE
+/**
+ * nand_check_pattern:
+ *
+ * Check if buffer contains only a certain byte pattern.
+ *
+ * @param buf buffer to check
+ * @param patt the pattern to check
+ * @param size buffer size in bytes
+ * Return: 1 if there are only patt bytes in buf
+ *         0 if something else was found
+ */
+static int nand_check_pattern(const u_char *buf, u_char patt, int size)
+{
+	int i;
+
+	for (i = 0; i < size; i++)
+		if (buf[i] != patt)
+			return 0;
+	return 1;
+}
+
+/**
+ * nand_torture:
+ *
+ * Torture a block of NAND flash.
+ * This is useful to determine if a block that caused a write error is still
+ * good or should be marked as bad.
+ *
+ * @param mtd nand mtd instance
+ * @param offset offset in flash
+ * Return: 0 if the block is still good
+ */
+static int nand_torture(struct mtd_info *mtd, loff_t offset)
+{
+	u_char patterns[] = {0xa5, 0x5a, 0x00};
+	struct erase_info instr = {
+		.mtd = mtd,
+		.addr = offset,
+		.len = mtd->erasesize,
+	};
+	size_t retlen;
+	int err, ret = -1, i, patt_count;
+	u_char *buf;
+
+	if ((offset & (mtd->erasesize - 1)) != 0) {
+		puts("Attempt to torture a block at a non block-aligned offset\n");
+		return -EINVAL;
+	}
+
+	if (offset + mtd->erasesize > mtd->size) {
+		puts("Attempt to torture a block outside the flash area\n");
+		return -EINVAL;
+	}
+
+	patt_count = ARRAY_SIZE(patterns);
+
+	buf = malloc_cache_aligned(mtd->erasesize);
+	if (buf == NULL) {
+		puts("Out of memory for erase block buffer\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < patt_count; i++) {
+		err = mtd_erase(mtd, &instr);
+		if (err) {
+			printf("%s: erase() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		/* Make sure the block contains only 0xff bytes */
+		err = mtd_read(mtd, offset, mtd->erasesize, &retlen, buf);
+		if ((err && err != -EUCLEAN) || retlen != mtd->erasesize) {
+			printf("%s: read() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = nand_check_pattern(buf, 0xff, mtd->erasesize);
+		if (!err) {
+			printf("Erased block at 0x%llx, but a non-0xff byte was found\n",
+			       offset);
+			ret = -EIO;
+			goto out;
+		}
+
+		/* Write a pattern and check it */
+		memset(buf, patterns[i], mtd->erasesize);
+		err = mtd_write(mtd, offset, mtd->erasesize, &retlen, buf);
+		if (err || retlen != mtd->erasesize) {
+			printf("%s: write() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = mtd_read(mtd, offset, mtd->erasesize, &retlen, buf);
+		if ((err && err != -EUCLEAN) || retlen != mtd->erasesize) {
+			printf("%s: read() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = nand_check_pattern(buf, patterns[i], mtd->erasesize);
+		if (!err) {
+			printf("Pattern 0x%.2x checking failed for block at "
+			       "0x%llx\n", patterns[i], offset);
+			ret = -EIO;
+			goto out;
+		}
+	}
+
+	ret = 0;
+
+out:
+	free(buf);
+	return ret;
+}
+
+static int do_mtd_torture(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	struct mtd_info *mtd;
+	loff_t off, len;
+	int ret = 0;
+	unsigned int failed = 0, passed = 0;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can be tortured\n");
+		goto out_put_mtd;
+	}
+
+	argc -= 2;
+	argv += 2;
+
+	off = argc > 0 ? hextoul(argv[0], NULL) : 0;
+	len = argc > 1 ? hextoul(argv[1], NULL) : mtd->size;
+
+	if (!mtd_is_aligned_with_block_size(mtd, off)) {
+		printf("Offset not aligned with a block (0x%x)\n",
+		       mtd->erasesize);
+		ret = CMD_RET_FAILURE;
+		goto out_put_mtd;
+	}
+
+	if (!mtd_is_aligned_with_block_size(mtd, len)) {
+		printf("Size not a multiple of a block (0x%x)\n",
+		       mtd->erasesize);
+		ret = CMD_RET_FAILURE;
+		goto out_put_mtd;
+	}
+
+	printf("\nNAND torture: device '%s' offset 0x%llx size 0x%llx (block size 0x%x)\n",
+	       mtd->name, off, len, mtd->erasesize);
+	while (len > 0) {
+		printf("\r  block at %llx ", off);
+		if (mtd_block_isbad(mtd, off)) {
+			printf("marked bad, skipping\n");
+		} else {
+			ret = nand_torture(mtd, off);
+			if (ret) {
+				failed++;
+				printf("failed\n");
+			} else {
+				passed++;
+			}
+		}
+		off += mtd->erasesize;
+		len -= mtd->erasesize;
+	}
+	printf("\n Passed: %u, failed: %u\n", passed, failed);
+	if (failed != 0)
+		ret = CMD_RET_FAILURE;
+
+out_put_mtd:
+	put_mtd_device(mtd);
+
+	return ret;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -827,6 +1016,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #ifdef CONFIG_CMD_MTD_MARKBAD
 	"mtd markbad                           <name>         <off> [<off> ...]\n"
+#endif
+#ifdef CONFIG_CMD_MTD_TORTURE
+	"mtd torture                           <name>        [<off> [<size>]]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -864,6 +1056,10 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 #ifdef CONFIG_CMD_MTD_MARKBAD
 		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
 					     mtd_name_complete),
+#endif
+#ifdef CONFIG_CMD_MTD_TORTURE
+		U_BOOT_SUBCMD_MKENT_COMPLETE(torture, 4, 0, do_mtd_torture,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.39.2

