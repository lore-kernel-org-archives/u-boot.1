Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D3FCED24B
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 23:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C48388D5D;
	Tue,  8 Oct 2024 01:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="EMcsjMfO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6915188CC1; Tue,  8 Oct 2024 01:20:34 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA8788D7F
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 01:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxjhlwqN9jrvZlOjtVAxCFHPKcpUcSoWNyrUU5xoRdWwPobrbxLt3sfv9W2lrhLBzbjAS0P6yhyghTdombkUfGjRCtKcQnkrX1bocJnJ4W9Q7DqKVguP1Hpui9U+uzU+pD24WzvzOXGeZR9hv4cCHywIhUM0GUZRxEhW4TRXXnXQut47k/eIt3WFQVJ+8C2l68yOuOnU0ArXLMlv44x5BTbhLnzeuPg1P4gpP2QTS15wPOJeuPhdmQrgpU7gyEgbOB06Xe7PWUgW1iIXFX4EP7nsoOk/OSLoX1vWIviOboTgqNT1/5QEMKt1bjOYj87xDX4qf7O7w8/6jceJiPIVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioyAum78Z8sEyGAExEq+HC6tibiiZ0ddWTXzbKj3Yrw=;
 b=aFIe43lBr35ocL6k8HMVP2SwlbsxxFeRF4B6c/G9hy9UxWk+YnFY5ILAC0sDhQVM1HUoUXC38PBLTQZQk1Dr8sObUExUIMe8hTh7ztoAr2kLo63vaeyOpF6aNl6AI/uc0zsWQFPCLTltJzy2P5rYscLvNYRD2aU1YU4mn10Vj8NpwpObqhNwfG/EiIBACQfRRODWl1/a0j/z4Q/ObAZP1ZUS+H5plElN5Y5TYCIZqMtq9QzfytewN89hPnU4NHRjTslhtvalCh4lLIbP0vy2SuJ/8KfVfDtwPlaGmylkJdLNySfIP9K8jql3guVHZYBstsIW/jLYgsnqGu0y7x9j3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioyAum78Z8sEyGAExEq+HC6tibiiZ0ddWTXzbKj3Yrw=;
 b=EMcsjMfOkXpqz5RXfIN/qyDif+Zqr5nK1IjnZ4KusB51N0iTpuSRoZCKkz8Yhn1v2S2SXYD/4b+gxbOLD6m9ZMboxTTtbdbbgPWOcBIwTRZwUedwKz4aAS+mVPvbbydxenvZvoFs2bdhCQzeSa56+QDynkoe9MMalSzeGzgJLkTzfGNI09y2/+KiP+t/PLOJ158r23BlVpeKYKXNFLsI4LEfC7YBnEGCYPn1G2mKTfOc/zNQbpczZ5I5InTT66BSDHrbiREEUSDsleSkJs+p4v9cjV3Js9jiCqjU2EavL801gobuec7AQ14GQH59pBuE5nncFBIvuOWOFVOTg/TM9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9140.eurprd08.prod.outlook.com (2603:10a6:102:30b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 23:20:26 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 23:20:26 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Subject: [PATCH v4 2/3] cmd: mtd: add nand_write_test command support
Date: Tue,  8 Oct 2024 02:20:15 +0300
Message-ID: <20241007232016.1666523-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007232016.1666523-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241007232016.1666523-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0050.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: dd500316-9a8a-4e88-6ebb-08dce726a046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0gf9fDA7VLx4S20XnHCES891j6mVHUtbAhKfQZgYOIG0qJcBN6EwbnI3Hg2N?=
 =?us-ascii?Q?LDjSg0o9KpjCMrnRKiWqxDG5N20lTX8i954KH5AflA5++/dmzV0raFusrOCY?=
 =?us-ascii?Q?TckR/TOgqE75aYxrWBxFxLImMy++Q6AQRT9JhehojdaDkHN8R7MsDsj9xb+D?=
 =?us-ascii?Q?668G+iWKu3wv8LTp0vcdRuHawIEP9dSa60Lm4bk3/Wc3Uk/DWFTRz91S97pH?=
 =?us-ascii?Q?+wRW0LlFn3TuGhyLcQkEegMUd3UVbZ/csx6nHUJSzCnih/fSB5/TquKBLZqn?=
 =?us-ascii?Q?eX/v+ICg6ozyoG/cAqwiZQVUKrdItnRUW8T+n5guYvw7oTMjykTq7xXOFGpH?=
 =?us-ascii?Q?bJAUFgWpI3QmTP5wFYKj3+RlrAUPG9ZtscbfLibV36t7XlEsPq0YcdFodt0E?=
 =?us-ascii?Q?M6PD7gXyl59bZDHYw/wtLKOyJSOCHCzdDtfdseJA1YQhSvkFadBioyXKprCo?=
 =?us-ascii?Q?VWZVAa090lgFBHFRo5OwAU4FOdv4qQdKw1nwhazHvKDX4zsWCHqIDnuJ0txC?=
 =?us-ascii?Q?we3VVBMwFxXuZaF4D2rVeaPXnJ+Hd5M3tSJV1MmRwErb4MXYflLKr3OVDQrn?=
 =?us-ascii?Q?oBjTfWpDtuNxElY8uUxRla9yzLLq7QRX1i6VNcGZwx8DPygncBaL+QoT8O2k?=
 =?us-ascii?Q?SJDM+irYi0d8mQEz/rP/7HBXZbsfPbc1N7h7nUFaQc7dqeFNCApyoIoauv5+?=
 =?us-ascii?Q?kDTwBdiWaksycNv7LqKcpKthAtRDrTOnf7nQRuowR/9D7TXw9HidSOeXJeqX?=
 =?us-ascii?Q?Tu/Bsoz0vius+41lg9Im8kitOlP++KJMvR551h8Pd4ULN9ryeXBrCRuAZePm?=
 =?us-ascii?Q?Zrj2+OWpo1dzb0/Q9CF68XSozjzz+E7Q3O+cmH/MxuZPe1zo5fAJFRjYE7nH?=
 =?us-ascii?Q?Fl4LzBdoj87iK1VAXFea5zN5sypGDfGMwXXfSBPT+/GBD2VpxlYrTkJ8KCzh?=
 =?us-ascii?Q?MO/U8tAwzU/UkQC9YNyVY2V0HMCoBarLeDXFbjW91zdB6LVaivBCFfPgr5Pu?=
 =?us-ascii?Q?SvJCKFMafCZ8LN+WjVlF3M+Qp+DRlpKX2nFrHwb7c/CDyEPl8inFsEf1Sujd?=
 =?us-ascii?Q?bZ9R/mdyzzeTWoa6YPrrhNf5iJTWjd7hLuBVkWxFsQ46H6OiVJtLQ7z7GGxO?=
 =?us-ascii?Q?ge5WrtRxlOE5AiNq3Ifs89pTRLQ/iHN+uPBAWV88+5Z85Dz7Kn/2fO5kvmZ/?=
 =?us-ascii?Q?otGuTVvfcpdWqMYrr4PHuDvjWmuQcYg04FGCCZoA1vNQ9BMQf2TbZrP+xauH?=
 =?us-ascii?Q?oW++Lt2MknDtjgFk1sP/wuKapRqFqMr8dbwjulZvYN8wVL+sRhKgmELJ/5ZG?=
 =?us-ascii?Q?Az7B1cq7xt22HgqaA4nuUTH09GSgQ+tQm96/Fkfl56i+Wg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g5KYvfUwtB7vGUGABlTIDSasKGPoEG30Fcxg1qDXmLJOCNeTGDNk8GyVfPcu?=
 =?us-ascii?Q?ZlA6LJeJQl6rrPrX4jLhG/xAMqNcw7EowoGJe3EgbziWaT+F4kB0EmzSt/ei?=
 =?us-ascii?Q?SnljMWxr0FpeawmPtAQcHvFxcL4uaDCZCW/P9XSz4WZIgp31nAaJmZIp8rPh?=
 =?us-ascii?Q?38V94xPVXdf/pwo974KYpYxfziOUwVTZQM+v6X63TZUYhZH8R0Zzc0wu9qvr?=
 =?us-ascii?Q?6gUn0+jOQSCGeOWgeDdazqZswc3EzL57rH5kTYYzuH8DHWZ5hXfVVmqvwsM5?=
 =?us-ascii?Q?jvcHuqJOHWAEw8RdyYm+0YoIXf0kWafqG1GuAxDRHhoTG1Mgdvh4uMsk9p6Z?=
 =?us-ascii?Q?ZBoeFwlPnTr3lC09+XQbU/MReKXhfMZ+ciLkXOY7ckze8pu9pWXuEH9VZ+fR?=
 =?us-ascii?Q?yv3EKqjg3gjyUNdhhTcB/pbKHuTVJWOvJOZSsfo06mHLIfyl7+rgPPuMt/zm?=
 =?us-ascii?Q?OVog9MhU872Ko4WeRyP6E8sxU7RLmqdHoWrOWtQWy8MHKTdakDHtD4Ig2DEi?=
 =?us-ascii?Q?9RZQx+xSS+MfxMNVX8Q0+eyoIR7xThF1HgkSQyIpphsjBgpXQ3gOw8vlPNzi?=
 =?us-ascii?Q?NbmMPY38EfWNBsTLslTQ89VdN/DiMNB3jIdQ16ChhQGJLMxxbUmra3BYzolY?=
 =?us-ascii?Q?lmQ0L3t90qmig+djvSh2+AlilW/JNxaebssJFPluTNG7IpZhG/dTXVUoOkl4?=
 =?us-ascii?Q?zACROxSzDTQhiPKUNX8kxHSOUBCC7qbg7dg3etIpRLNcQhB5hlgI3l7wicdv?=
 =?us-ascii?Q?iGnqPs2CmYWt6wSBZ1b7TLS7zjF8cZR6itCkYTo77ru+hqFenBxsJSo6dF+0?=
 =?us-ascii?Q?pqItmyWc6Ai1QLaiHleMoe83A4VLfaf+R6MR0Y7SwpVXT2FxBC6gCYzWjerE?=
 =?us-ascii?Q?fZRQ6BKho9VN7MunxlpjfSmEBhhFafXGweFiVCB69c4eNRYgJ3HXPcp/aOeT?=
 =?us-ascii?Q?5wMVbcfbRM+f1OxRaHAYU3j4KLqF0n388JdF1SsAoLZD2X2+mE3Et+zk4Nnj?=
 =?us-ascii?Q?iEPzRq8Xk1bp8JhT/reQNqglmfHEaM/C8290mggpoDMFLsvuVAUFs24sjhGA?=
 =?us-ascii?Q?u5pOUtEriNpL+xcy0qYyuAP/pvXjQgSaWshz6DYEk0vSuV5y6SZ8ZxW+t+l0?=
 =?us-ascii?Q?QEZrNYkw5R8WU66MCkn7Bl4UK41QE5yJqDljCLqWYhc+JzlRVh8NgUhJkmw5?=
 =?us-ascii?Q?AoQ+Z9duAwLOE4D1WdTECucjESbO5OacFUP3tEOsMUn9OjH8pLfUptXyG3km?=
 =?us-ascii?Q?eNOMPu/RPt8GoprJS8ojkrEJEJEWgNLYfe+/KRgRs+CYy0ED2ntYr17Eqd2o?=
 =?us-ascii?Q?XZ3ax3U+ArmJeCjnSFV5sQXFdRiDVXQPuNgIPYHXg6cAu4ArC57jKPfNfWQl?=
 =?us-ascii?Q?h93eImZOu8Z1PDQlsukIzTh0ook/ucUWGJOy1gPZrJfVmUqTFKalleTGUj4O?=
 =?us-ascii?Q?9JOQLFl3uQzaXBitOfefQ/5agOnymPqK2yEzUeTLecz3nJA+n9x6r4kEhqkF?=
 =?us-ascii?Q?kZIr23tuwOl5jL1dIIJWI51FajpCaZDB3iHqdwiq7+BtslZ61O8dshdEud9z?=
 =?us-ascii?Q?DwDKSGKBV6pXVOyZh9mykg4sO9wnllB2oEyEnwvirt8c607+w1uQRNYson1I?=
 =?us-ascii?Q?LWeILrYXqigwFCwLgegzycE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dd500316-9a8a-4e88-6ebb-08dce726a046
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 23:20:26.4862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9SpqpDYPiP0UX+MfHUao6/v/NUKspu2al3jwKKoVsNiAPRzK8stgB3raJJ8+4ZwveW16mKfKx7blshlj1IYydTDrTeF43Zban95x0lZRBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9140
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
 cmd/Kconfig |  14 ++++
 cmd/mtd.c   | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 211 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 29d1929ff94..9a5ba5ccb4e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1457,6 +1457,20 @@ config CMD_MTD_MARKBAD
 
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
index ac78df75267..1c819b35e9d 100644
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
@@ -827,6 +1016,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
 	"mtd markbad                           <name>         <off> [<off> ...]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
+	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -864,6 +1056,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
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
2.45.2

