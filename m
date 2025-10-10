Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB815CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E4A28410C;
	Fri, 10 Oct 2025 14:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="avasxhgb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4F7F84241; Fri, 10 Oct 2025 14:04:43 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2614A84209
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Id/ufP75yJAQKJyaS06NnmWTbAWSuwxWTEsxqEjBUttBAoSXlucNFUeEmvcFsg/0mbmC6F+Lpy5Q0M7ouXR7o80/QvE10hh8Tuu48J/eHi5EZ9ZAenWT27idFOGqT2IGksmxCM+0Vsl3Co4Nx9sIdxyO1VEuxHGoIKh3GWluBOZZWFSR8wPoQGp2AfI2/M60S7aN9VHvSOKruMaZLI2PWM9quQ0d6RMLGPalJab1VK29/jxYqYr8uU7AUD9g3WjxICCHmcvJpv2Ggq2o7swBVH7mwSIIhW9q3qx0xTA48iE4PwswAAp/QNbioiOoDaEcUStSjUYMNTPQukThtZCUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb1FTk4IPBk2iW3mYJLpE2jc3wdVXWLUGcepsyK7DhI=;
 b=Vj6XHhSvxB3lrr1bOoCYiESRRBgzDheY2XQ4DplPsZjnqg8rizFNuNoGPHGoia2RE4VtuwuiIv/C4TJipT+r8MEaJLQv22PHRDlkFv9ty3IG778YFc/pqDkLv33COyptLzajyt3qEtHSEKur/uXUmaA1PgHcvao0ctIGh/oh95cxR5rWJWqNu2DSPhFVifC/rsJMFaD/PMCA5DgpQVQthb/R6IRrPYNDXAGO5W7RDBV8M6UqSozbb8oj4xv16sNiAX3Pwk7847Q7aYm+UaSwgEK1cpc6aqpZJ4v6dC7Ly/cF8F79gtNKaXnotGxy3kVzX78feeBPQC7JzqADaHHZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb1FTk4IPBk2iW3mYJLpE2jc3wdVXWLUGcepsyK7DhI=;
 b=avasxhgb1JY8nbFE1SZLSkwxQCBNu+9oeKWMN4Kvrc3lwkyYSJWtRF/N8z5zaPq6q3Km04QU25Fm2ZONCqofqoT2kqrJu6dNWfSUBamZQQ/y3piaF/xkPyK3fXf4T5y3oF7kYN69PjXkFoLB5ehSpeEf7IwGEu6zHxzMGF6L4xZrLHaekfqgwXQn3Kwx7S7W6Ad3VGs6bI5w2y/1vFlYnzy93smbln9Q4GKlbRsT4F7C1PC/eg428nthXE6MQBVpZFVje026lQwDG1szDvlscXIdtmFl5cHhljqrqEVZQySGC/BQDGz3MKIy75OffVM1wgpf8/sz/bWXBF6wvucdlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6650.eurprd08.prod.outlook.com (2603:10a6:10:26d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 12:04:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:04:38 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 2/5] cmd: mtd: add nand_write_test command support
Date: Fri, 10 Oct 2025 15:04:25 +0300
Message-ID: <20251010120429.1532370-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010120429.1532370-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010120429.1532370-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e73b78-1265-49bf-f3d5-08de07f52ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X4938tVUgBR98MsKx9lrXhHI+qmVPsOpek5fBlde9oDSdm8GGuLAr47JFsc0?=
 =?us-ascii?Q?r4OG9nTMchLKJ/hJeZ0TnWDtLWWGpu97v/HHH3NcaTyZPobDAZeRiBWtEQmr?=
 =?us-ascii?Q?vgEoKmUBG7uT5oC8oqPvudEdgOzuKbpo8iItX5d/j/GQWcskjIjT38wQJ5CD?=
 =?us-ascii?Q?MTHjeAa5iKWQyCwSuHkj7zdt/D+V1Ml3in7tW3WwQ9f8RvNPhJvB1NqrF0Si?=
 =?us-ascii?Q?9fOhQXPd0YXTTFHsJRr8ykxzajMbwG+aB33J/ZHNfFI0DS66efMCVj0jODgB?=
 =?us-ascii?Q?Oha9eJIqUysd1vyvOnUWbxvH17f1ypIH2npqZpUDW5h4N9cpfxwXsHHwbUtw?=
 =?us-ascii?Q?9Jg/s48Jde/a00Nw0pWBsPZA4UuOCocN1L4Ccp4k3SX/LUSHNqDUex/FCFdC?=
 =?us-ascii?Q?s2qm4Z4t1XxeIH7ro4t8YUgAT8g+5nV5rDH2pd2EFOrQJsBa8QEeI3Qu1Hsj?=
 =?us-ascii?Q?SuBUYl0S6QJk0YpC8EpvZlerGeWoRsMEnPVEROASnIi6g1/qptGYAI3/2Yma?=
 =?us-ascii?Q?pKcGC8MVlBgh2xzS3J66RyO3Bakp0fQPRXx7h7TLAodMrR735mKhMv/JC2kn?=
 =?us-ascii?Q?ae0eoZ4VFZZrIhXa0mm+eiUZFP70yHjJ+XxrIdGRHXS8Ab/aiEp0PpEljfry?=
 =?us-ascii?Q?Q5WdCd0v5Tu2FFoMVw1iMWeorEGGP+Ow45QYBepDtvgpdo8NMrW8C5IzwSzN?=
 =?us-ascii?Q?4UX0kyGPS6ZIHaV47eI2uPruemofXd3kCKb/FdLxLkhbe1cNUadre7dup1U6?=
 =?us-ascii?Q?+TQLIU2mZxnJJy8IYTntQebvpa/Xr+Qc4+flc7sCOa7cJpwUyZu5fN/Ugtqx?=
 =?us-ascii?Q?M6i1BgbiRHSWfleS7bUl/d7fqJdCftJat41J7QVmOPFVCT6Ymu0UZK+gBaHE?=
 =?us-ascii?Q?bBebOSfTUDlupnoPlMtnVF2FQYlkrtmR3X0C0LfEysuqU725cw3CKBwP7ssz?=
 =?us-ascii?Q?LUDyxOEfJChjI9V31Vm6YOprcOJ/OigG+hndrOrm1om9Pjq//tez4tTdDHGr?=
 =?us-ascii?Q?1fX2SzpThLJtLbKn56LMgiQS4L+SIeg0XAp5wzG4rruYFSTJ3DM8O8EXY8d2?=
 =?us-ascii?Q?X8TeHoQY0JDR6Mo0hnELW5nZUzcxB+X8CQ57KZ4+Rrzdjz9ftH379zBSxpQj?=
 =?us-ascii?Q?9e5sEk93g2h7rAsLtA7HL9ih+6KoVfPKa+Q6QRAmuKHH70t+rRJysD8yZzWH?=
 =?us-ascii?Q?SPamRjVYJI8JgDl4hsxiUTjsStAV368yDEDbDdDpc5X5FMaAU7KJx+ZHDGoY?=
 =?us-ascii?Q?wh/coO/jsXNIwpvtJdXeaSAGAPVFSZZdaichuCCazEvL3kGaozN/MTkdcHr6?=
 =?us-ascii?Q?ihO5n2p2fmiIAWFqgChSDDCinrHUiEHMV6gos2o1/mQh631pJU0D+XKgdnwP?=
 =?us-ascii?Q?99y9spCKm6riabXRJY0CZqSmAcCZ/NjoX1i/XQt47WAZvgm+ErMWKUrTqd1Q?=
 =?us-ascii?Q?LtHWfl0B6SrEomMTax9K3EyyZzHvtAECFSweKPE5UJfY/akbvNQND8oeZCWM?=
 =?us-ascii?Q?jiNs3TGnhJ4TXsNOeGWHjCLQfqcoq0X+MBkKy0T/wjBu7buqtE8/jDPf6w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/f/OfwKj8tQ/y5IJZJ3z8sidSCXasNqu2/y0UPDXMGUzr6wJlKEgeGCjiNm2?=
 =?us-ascii?Q?VFRk8BOv/yKngFgcalUAwJtQ95Um4bZf7ARK8eP0bS3p8ZMHaPLguav9PrgQ?=
 =?us-ascii?Q?d3/5aHfAGcs7mXwH515qh+dWbOEh6AKshjZJBXRMbMVzT3h+4E/kKtOAJBTn?=
 =?us-ascii?Q?kWhPp9Fd5oYvr5yOWqFG+9rIHj3C+3VNYZawlbqAMp/GreTn+n4HZDgcxwMY?=
 =?us-ascii?Q?nILknCBOnX7tV+hqKuwi0jXS+vWx/iQOl3aw5LdBXnK4RpAS6vjmdQ2pssPN?=
 =?us-ascii?Q?hOFYV7uMmuh/IAToEn0QUXCVQYy6HDDk6ukUPRQQZcpU2DTUcOR6QKq/EL2o?=
 =?us-ascii?Q?gPRttnyg+tHYqAukA0yZfyAcOujLnu2Qms37XFky7oWUovX03X0HHty0j9Zo?=
 =?us-ascii?Q?+/Z7SbqS87XDDNShDD39ZgVqvRvlI9vVLEPBb4UNYL9a3uVGYPZMHCdupM4/?=
 =?us-ascii?Q?xHALCeIrbn+hYOO6ImO2cX2LxwdVlx01I3o9HZtp5LErWSp6bm40sE9762Cq?=
 =?us-ascii?Q?4xTsK6Kcmh+/yMe3ftbSEcOq+YLQxw1i/JECY1HxhAtjx/OxQ98w2777nj6x?=
 =?us-ascii?Q?Ms2ulzpJgYBjOdlQq+EkSAi5D2xyKpuoCEPgtYTxbX28x74/R+SqwdUnteVY?=
 =?us-ascii?Q?kQemeM/DmASd1Y0DTBDeVKZ8bHKhZ0yd2wWk6uzoUY9gQbDSeTcpOT0GUl47?=
 =?us-ascii?Q?qs498Wvrz4Z1JpvCAVaKcYWSTYFBh0CWPmp3W3mCxk1H4k/wfu/Rmo5RRQW1?=
 =?us-ascii?Q?mqItPo6JTgP74WXOQZCdMs8Vx56u5jLhkeWq4ocFL9wBTZVe4KdhikHUnY7D?=
 =?us-ascii?Q?4Ob9Dp/xL3WGniPwZtXk21lDWr9mK+BCHxptg3uioqN1l24hCW+bXXptaUR1?=
 =?us-ascii?Q?bIq1mi4XuIwFjl1KTksoBsMWZ3yFBQ9A8afthuhZhyDYWCL0SXRsjiD0ghja?=
 =?us-ascii?Q?r5o1Px3HQ9B8sG4yow8AbmWJ1nAzdHCM67E2Atr81OJ4+BusTbiaMei8JC1i?=
 =?us-ascii?Q?fB47RXOkeyKvrRkz9mxJgXRK2D5qNM9lGkW5IbPHnKJ0PjaocyqXJlHagONl?=
 =?us-ascii?Q?n+tzADSj6z6wz3OHiw9rnwfMYgdEQMdm4dSM94Guff+g38yTYsnnu3ncGhb6?=
 =?us-ascii?Q?6ya+P8wDL0fJ0R678UlvvAc4aMjCPy/RgXFvph3+eyG638l49HMPWh3dB5RH?=
 =?us-ascii?Q?2pzO9IUsYCdkmC9GqqSIi7G2HhHd4SAAe0nQkq8TEwNA0YsmHqpKKH+ooJQt?=
 =?us-ascii?Q?38M0dQdDkOBs1gf48R8/3mwTymEbNPuVjbfuuBisswtE/FHy0TLjKEjZsLE7?=
 =?us-ascii?Q?NDB0dSWkhEQl4USIxL9hM7zTZSzYiklvSPbHcCcweZfYo4ujFtahPReFWuXo?=
 =?us-ascii?Q?d5DRetrOfkFeUeqyB9KsdZJEMN1y1XVxjf4ykncmhPbKyCxAeGgllc9/XPjE?=
 =?us-ascii?Q?JfOsCyBTm0abovuOxXixSRxylf2CRQifKscI62Vv13Bb5rhUF3PrWgRhJtd3?=
 =?us-ascii?Q?QylGB+ciWuErOKRAuSpQXI1q3FC5BSBQ70w34rMpXeaQ/OniXRfsB8q1u7oH?=
 =?us-ascii?Q?IztLcdGv89JWFgZ7N29PYRtfVgoOqNHS9IZ+8iHEKSyuwvq4cRJYydt4+Spf?=
 =?us-ascii?Q?au9PO+4JtSWX6xhRi+klEUI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e73b78-1265-49bf-f3d5-08de07f52ff3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:04:38.8023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSbEHAEk9S7L16Lg0nX5bE8MOJV/ZU6CXERxjOr8Qp2vzULElHEN1mTxmxaI0Teqjx+XtAXT6A97tQakFF1YT0OvMvzzI/5dyTMxF7GxCwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6650
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
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/Kconfig |  14 ++++
 cmd/mtd.c   | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 211 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 3ba3af82fed..809da34e963 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1521,6 +1521,20 @@ config CMD_MTD_MARKBAD
 
 	  This is a clone of "nand markbad" command, but for 'mtd' subsystem.
 
+config CMD_MTD_NAND_WRITE_TEST
+	bool "mtd nand_write_test (destructive)"
+	depends on CMD_MTD
+	help
+	  MTD nand_write_test command support.
+
+	  Writes blocks of NAND flash with different patterns.
+	  This is useful to determine if a block that caused a write error
+	  is still good or should be marked as bad.
+
+	  This is a clone of "nand torture" command, but for 'mtd' subsystem.
+
+	  WARNING: This test will destroy any data on blocks being tested.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 95e4be9863d..4d69c7b4915 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -20,6 +20,7 @@
 #include <time.h>
 #include <dm/devres.h>
 #include <linux/err.h>
+#include <memalign.h>
 
 #include <linux/ctype.h>
 
@@ -762,6 +763,194 @@ out_put_mtd:
 }
 #endif
 
+#ifdef CONFIG_CMD_MTD_NAND_WRITE_TEST
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
+ * nand_write_test:
+ *
+ * Writes a block of NAND flash with different patterns.
+ * This is useful to determine if a block that caused a write error is still
+ * good or should be marked as bad.
+ *
+ * @param mtd nand mtd instance
+ * @param offset offset in flash
+ * Return: 0 if the block is still good
+ */
+static int nand_write_test(struct mtd_info *mtd, loff_t offset)
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
+static int do_nand_write_test(struct cmd_tbl *cmdtp, int flag, int argc,
+			      char *const argv[])
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
+	printf("\nNAND write test: device '%s' offset 0x%llx size 0x%llx (block size 0x%x)\n",
+	       mtd->name, off, len, mtd->erasesize);
+	while (len > 0) {
+		printf("\r  block at %llx ", off);
+		if (mtd_block_isbad(mtd, off)) {
+			printf("marked bad, skipping\n");
+		} else {
+			ret = nand_write_test(mtd, off);
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
@@ -847,6 +1036,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
 	"mtd markbad                           <name>         <off> [<off> ...]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
+	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -884,6 +1076,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 #if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
 		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
 					     mtd_name_complete),
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_write_test, 4, 0,
+					     do_nand_write_test,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.51.0

