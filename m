Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5956C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 04:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E2F8894C;
	Wed, 31 Jul 2024 06:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ix7KYNvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB938894C; Wed, 31 Jul 2024 06:26:08 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 864E787BF4
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVrXvTCK5A7YlZVgJvcplNLSPyAMkwemrukQmQ/2u6VzufSAfiF9UsACIu9G3UI+VIPxr2QtgDrHlDwN8l2pWJoEAD2PaD2e3apvVyE10LjpU09ZHAfXgfIF6X7SSdcB7M2NI776qY4sMsxwVY1868R435j43KSIw+BBj/w6v6CLgKfusP9bbJHYmgPAchRhYRtitte9e4LutoLj4IGayfvCeDP23J9nPT3g4/1j70KRnZmxBsro7t2cbmI0IJAlrbCTIQDptLF8kmDc+sK8dwzsm1GkTSAWkHIhIevuYo2tYso95ZVIxsJhl8VAyGynymajwtIwILzl0ky/BmvkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d3KkDaW775IMmGfkKZVsxAUMUwmiquC842Y2bw/f9c=;
 b=YAmy5QIRSsjStQet6XAaU6/SYHspjOItBqDKHb79mvnZwHyxkjdt8PABKvxEKjeVbCF7kTJ/RMzLrInX2XVZ7ji7IML3B95l4fWNuBOmReYAQoaA7my2xw0mWDP67WaSbS+D3j0H6WYCcN3diKiHMiqhoh2PbbGhciykS73rYRNAfGmCwz63sElpcqwj0Usu29CQvl5n4J0vNnZjqZShUS1t1hTGwWY/RVu4OCysN/OW7ANolTH1vtFSN7SJZJzGjR20dMTS5QOsQbhJZZ3fu0HsTrA3njJc6HKuzvph+kDlR7MxUkH9myL9G6QIR4xoaWPC42HFWdcKMVWhkhZkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d3KkDaW775IMmGfkKZVsxAUMUwmiquC842Y2bw/f9c=;
 b=ix7KYNvJZCZwtKQVZtyDewmIqPVDpB3nIPYWQvoyjBqpLoPR4ZaC6ZF7MF99H5wc5Tt5UsAAnAiT3JMDsmE0ExbxWC0RneFC8mgjfH0+6swbX9LVOqF1+vdA7RLrf53cfbNIdx2XUxH0zmzA1+4dniewMInr/Nq1vmGxM3II2XI0TCdD0CXBW9HOHsx6NE6ZcJsXHKR4bEm8OGeVSWaTEYFmtCrQ/IAdSivFacbB9cI5Oxofn6DOFdRKt9WzsaxBopb1Hyos40Yb/UtIGnhjhpLGo8NYIWVeqiDfL+xLay8jLFiIvi3QL7Jns96egwCW3EA6a/wmZ981/6PuJxDbPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com (2603:10a6:10:384::19)
 by AM9PR08MB6209.eurprd08.prod.outlook.com (2603:10a6:20b:283::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 04:26:04 +0000
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f]) by DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 04:26:04 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 2/3] cmd: mtd: add torture command support
Date: Wed, 31 Jul 2024 08:25:51 +0400
Message-Id: <20240731042552.3840459-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731042552.3840459-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731042552.3840459-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::9) To DB4PR08MB8125.eurprd08.prod.outlook.com
 (2603:10a6:10:384::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB8125:EE_|AM9PR08MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5db096-3084-47f9-df42-08dcb118e422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|52116014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/ENauW9gUcLxvm2ASHR5tKCrspAcyUrE18s9tnOhohAgCYYBP9sunHMNLjyP?=
 =?us-ascii?Q?TiqNs2jdQq76w1tfzhBqE4UIL/XlXDvRcbp/4C8jQEuR8R/9aKgN29/eiLw3?=
 =?us-ascii?Q?DopcUgHIgrK424DoRUNn0Z5xnA4DlyCm0z0Z5NXZd96yjJEaP37NhYT8CFj0?=
 =?us-ascii?Q?Vz8hbKrF283MgvCm+Uii+0utZ4dWCFPJ7Jc9MUjsPnwdx3LFtG0YxTWVb2is?=
 =?us-ascii?Q?9+sw6/vqxyfzJiKlkcqkEyw3+BWattlBNuztYk39P3I//vK4B48Hm+SsBcSL?=
 =?us-ascii?Q?z2Zbbhek3Rf2tZegA4yfweqAzLSEvQ5RqcrjSbIRLux9EVO9xsa4B+9j6Q3O?=
 =?us-ascii?Q?YUlVb0KozNGAu8aDQCnQOUoP/9nqJTGjcM39tqt0gyqrhFU3II3tsKAd56Q5?=
 =?us-ascii?Q?NFA1fe780l4CVXrCEXbFm877EJQxCstMbURKAaLbmHcaYMolwGzGEMEhL4xa?=
 =?us-ascii?Q?eSF6Mr3s0votS34sb2W5IC9Wz0ro7bAF5COZ6TAw9sgXxDWa/OGh073W2chU?=
 =?us-ascii?Q?GC8QCrfG9rtx/8IxR/V+wMZ+tmoL/u4scMrU51oiIE9BKiew+gNky3BLyvRq?=
 =?us-ascii?Q?RqHLgFyUuTLVry050ds+HndgN8utOzkWgxTXbgSp+JZh7Ewo/w4x/J8FdfqX?=
 =?us-ascii?Q?rDp0AkOO+PI/xKWwth5mO8PMdt6uLCxer3AjxvcgYGNPmVPG8D00pzE/dO8U?=
 =?us-ascii?Q?Auz5dFRe7sd3jqtZc4rLQSxTJsZq3eX/JJf9zjrcJaOnCAPfxvMeD7HkKNeN?=
 =?us-ascii?Q?M9+RfAFy+853/LTGVciXREMQyHNZwLVJs+vSyxmtaWW8jG2KDAD82AkxPEi4?=
 =?us-ascii?Q?CbR++heJG+l/1KiSNR1MNAYnifFD4JYvU9zzx9udw3swynP69NJ0qRIaSqTv?=
 =?us-ascii?Q?WFR5XxXRJJFDrlMPxuMp03jU9SvqwCQ5sm2Zg/W7YeEaBA2vIrR5+YjWF3Dv?=
 =?us-ascii?Q?WauDHBHQOKAN7tqmAQ+LSInPVy8TCuVRLaaetp1INw00RQoKttjFMnsQ7txO?=
 =?us-ascii?Q?+RkgKm7EXLCpI7sm37/V6Fw9A4O3893T7H/nR9Kwpel/Lz5lKLK3aORC8vst?=
 =?us-ascii?Q?HymDNaxB+3N+gqMzqbC59NAaT64F0Baoq6prBO6WFFnrT2OJirFxyuAHed6t?=
 =?us-ascii?Q?plHqdqKUrqFDT7Mr4vJBg8rdA05ezBNXHYoLaRGKRvba9c7D1gvARJlACt1C?=
 =?us-ascii?Q?qPmaGh1OZIWxubtWN2eUdDll39DPTkAy4L5oO+SthZo5eGqLfJkGifFsFXnx?=
 =?us-ascii?Q?cJcba/GE296Pi3aZZfAEle0/dNGkIASe5qofKaAZgX6XeW/OMlRUSkJYK++S?=
 =?us-ascii?Q?br0ajVPjMM0uVE6brR0xoVxYFVSnJSe4NTOJjBRpz7y5WPqO8Yf+Uhi5i3Dq?=
 =?us-ascii?Q?ybuOvAHCK7ZdO2oe7rguQLfVCgyNzPJ6IjJBN0F2WtigH2RdKjNskpZ+s8/H?=
 =?us-ascii?Q?X1b9Yo/Esb0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB4PR08MB8125.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vW28EayFEcGVqpiVF/EXWb1a7w0DBcL8aAzTDODvIhnKzre/aAiEdnszRUTO?=
 =?us-ascii?Q?HSKg6rkPiPMo14eSj3BfXEqobXGYJpAGQCS5iLmlvl5VLXaIihSjDDPuxy65?=
 =?us-ascii?Q?gcGLoCI/VhurcN2sllgBS6D/w5S5zqRjzAXFv7G0DfoU9DwI5CUpt/VSkKBq?=
 =?us-ascii?Q?Qxa4ig7OmMCtNBnFTGCmgIdrbOskN10QxnNCL5cXCtQE8Z9i7bsA6UJ4whkQ?=
 =?us-ascii?Q?JnzBPxxnj9pJsasWruTEuGGI35UjEdxV07Cpbya+LAWGa/jcQbIf8caro6ho?=
 =?us-ascii?Q?a9BkxU9FOGnl5EksPh5WHCosqo4+cJMStXkG/gtfZ4CBTDP6lvSvWzGYMsdy?=
 =?us-ascii?Q?azJWO9ouyCJSgd3vLFWz8VaTyYvjQ6hffVbqWvD7tGFYSJckOmtN4TuxyQGy?=
 =?us-ascii?Q?Vu+G0Qa+ltezHBmrKx+igwJMTLz9V2nwr5uu/DeAuM718JA7C0jZdmHNGbhl?=
 =?us-ascii?Q?pENNrWfeyXd5BYA/i1IwkQk56FkaNzNFjaL67fMVXGSGattnZ/C03JusZrJx?=
 =?us-ascii?Q?AueGC+OWjuU+8aanVXctX+Zdox5hwSQgCKLP0s8HXS1oUVAsrTmF1rgqrJtB?=
 =?us-ascii?Q?NBk0ZJJT+Hyx7PswYbdSthpd2FbRPfbxOf65XRjzPRtaLkfICgUCCQnNjDrs?=
 =?us-ascii?Q?kANDa/P3wqAphDCAXbxOHK2OWMYR5HJhK1VnAVd+Kj72dFrD6GOqDQHYWO9L?=
 =?us-ascii?Q?OuP9VDwvrG4xeOVXss/n/9rwM6FfxnCkCK/55eMtyJosO+7VoSnFqXEXKcJ3?=
 =?us-ascii?Q?pOraAJEl7/8vCQB3Z22H34w+4qD15rDQ+cYbf+r/fTKZWWElZixFnXlH/1Md?=
 =?us-ascii?Q?P34LUCexZOlkZqAJgtU23miEUcjPAIM8IcR4LOjDJMRN4e8lAaRa2OjMGco7?=
 =?us-ascii?Q?rRc5HQUVkVp51ROrSBn6wiR5Hhbe3fvjjaR5EyItmdNhKRtOAvd66QtPWKf0?=
 =?us-ascii?Q?J5qA4oevoLcmhzTGXML0EWLuIGmsp2UimVPBdwe6jbM+fS7B73XLldZEMW2H?=
 =?us-ascii?Q?sr5UBn48uNTYzCjfjufHTGGkfF6pdEO7B0hwEiov96oVhCvwHLvCJekeOp+7?=
 =?us-ascii?Q?NtifABvmyKr33Bh+Qnv5EWXVubgVV6H9XtPIjlFUW+w3IKkEREB12+p5yTIq?=
 =?us-ascii?Q?1lrQTKq2HFIaYss6vGpYV7t6Dcms++eO/lpFrd7w1dHnorhMOBxsmM87+CBJ?=
 =?us-ascii?Q?TQ2yzR2AtMaf3vDRq92H/hM50JgZYUnGID4fFEu2cUSxqLW88RrDJxbCp9/B?=
 =?us-ascii?Q?G/IqbX3jBCUwKvuSnaB7/CSFUb/JhBe+rx4Zd3L3JOGY6G2p4EJHPw1Dy/RH?=
 =?us-ascii?Q?tQKff/bjgOir2Kkxjl/Qor74zA8dq+Yc2HtXVafBR238zYI+mPEOnuP1vpr+?=
 =?us-ascii?Q?cu/e6wLePvxNX3SLGZ34gp5bhfRMJllHnRJVjREVW/GVx5hMmJW09SlQe0KL?=
 =?us-ascii?Q?L4sKWuTSAae8SMaxCnGRCkhSKm/UTi4Cqfe2Etc97Z6dLHW9xojlU4BTxWiL?=
 =?us-ascii?Q?Dwp3iGPcJXbi32DXWjig50MrN2Xc3uBgGU1CECXFWGBB8KFfVpeTxDoXIi7l?=
 =?us-ascii?Q?iPpqUpWPBkVTuUo4aVBThloDgqYX6tUD7ZAVQtfjf9OuUoXCr8lZ8tECp64p?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5db096-3084-47f9-df42-08dcb118e422
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB8125.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 04:26:04.5802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3H1IjM3YO5nk34xLXK7FuW073Tr4oMpygeyH32prQ5r+P4Eo2DA33AbVb+Pf4N+qaClXu9KOcBMj34DSAu5XrNyTCojpxmCG83CiKP/A848=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6209
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

