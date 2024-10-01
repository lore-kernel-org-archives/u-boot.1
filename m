Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9743CF3189
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 23:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C323288ECB;
	Wed,  2 Oct 2024 01:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="v/H+LXBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C74288EE8; Wed,  2 Oct 2024 01:00:26 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B84C988EB7
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 01:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlVW3LcVRMMCOaVqpUg4DFRKJn5WNpCNa416fSb+FIvK4QNJ+FwAgykOb7EmTgnD5J1UjFuD6bDSrmEsdtbOzUi4w6J2A9npExySr01N3G2DOPN3PduS85C+dIkEbgj3QON6aRFD99xD8oI7qYa+nMKkfB3JdgQVLoDNU0GXBtEmI3MntUd9Owskddeb+4QDs3zZy1TtSSV7W2luElu/uuP8NznCsKcn61ebz1LkfiMuLG65WI8Z8pWjbweuCCtVTjTQA/JIkhacBZygHHce/LMHTsAtTSU3IXJq5P5MdjF8te9ZcBFbassLdVwySVljKsqEfUT5rUlTVWO5MBk5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDKFWOVsGTrbvCDHPRXcbfSD3JZBxJMCSuTJTRyeNes=;
 b=o9QILSv9UsjstuqT36FOQWcMTATwOAAzUfd9Ew4p8Pa6N4bcL4Wdb4WVcnOw4tP4kxexSxfrNAP+jYxfdQC3S+YEOJEZXm0IhAZLmAa9hd3LjR54IKRJJbrpBiKJe9GIegcG6CwpMXcepC4A9gmmJR3+ofK5wQNDqiNnf1pvl5Ojq6T7sgylPTaVFpFLQWv2Ujjk8THUH/g6rez3nxiVnlcIorp0m+GkqzjlqslFHleHQ33BY0HT9/J1Hi2/0T0+qddvi24H53jM1jP6p+NCBm0Or2/dB9PuLcqgerqsaqA5oivHUxDc2c2O0pWfGz/llVvwG6bo7+vp6CGhHZAyHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDKFWOVsGTrbvCDHPRXcbfSD3JZBxJMCSuTJTRyeNes=;
 b=v/H+LXBZgP9d/NDIq/SBvsxNfvcKCSgRCmfg3uw6GSji2MDo5nWYP/bTEK/EmxJopQPKSPvrkm27HV33g8tKUsKPEzalKiszzdhY80A5eBrVQrnmpGxe00No1q8f4zsy75iPKCUAEWqOUhJ8O0SpjGcoTTiQkNJ+Tw3jnUEFAUKTaY0LbTvha1RfL40+x5sFnZVZBZW+FXzQUCOijjDItQxb9vQ2ZokaDbjqNnRQ+9rmztGdzUkclvo3EUiGKW77scC3VHLqQuRpVb1dkv0Zju3zaber3Ev9wzdVv0MHaW3+J7lRTk+e3t9eRbWcG62vrqoJ1OgkkFh6nOYVfcQadg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6271.eurprd08.prod.outlook.com (2603:10a6:102:eb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 23:00:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 23:00:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v3 2/3] cmd: mtd: add nand_write_test command support
Date: Wed,  2 Oct 2024 02:00:10 +0300
Message-ID: <20241001230011.954429-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001230011.954429-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001230011.954429-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BBE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: e382399c-665c-4798-813f-08dce26cd2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xtok8ze23MS+bXCCVtd53Rxn2WipLtMiBJwD1NSMB3ogoLCLLOu9YzTdkEFw?=
 =?us-ascii?Q?9/H9wV37AjJYg2GN+pdS12aV6bUELYnVt3Zst07kHOFDrB1LPpNxh6p3iBi0?=
 =?us-ascii?Q?+9bprNuwUUJQGEIHzWsYpP7U/QklLg7HQj/o9Lmm+LLZVa6ospELsXDusIVs?=
 =?us-ascii?Q?xEFRfksYkcYsFTPCwV1HrpL0mkVB0QcrdrG1JZEXfk8qsEV2WI/W+iNyUCdh?=
 =?us-ascii?Q?KoVoXSFBEXBTvC8SgEKzgETTpP8Hc5pbGMBlItfu1ytoYGUt34Ix8d5ARZ2K?=
 =?us-ascii?Q?1+LKdC/fO51YOkn0WdJ7AWKuG2XnsL3px7zscXk2fF0j5cszphEAOQ31btMg?=
 =?us-ascii?Q?0SPPvtZn7fH4zghJR2n7FsWVBbgIJ96/6TskiUcziGMyU5PHZE8ZLlHetizD?=
 =?us-ascii?Q?xfsLEBDX3ZoeURENpxYSIlrg0vcqtdGRk+rdosKWN7JnnTI1zFqFeNGK23XA?=
 =?us-ascii?Q?nMpnhA3Lzu/Q7tlJT3rqaSsqSCTu5AWWUT4KCDqWpRY/6Gc8N0CRyJvXg/J5?=
 =?us-ascii?Q?Z7c9z06GPi2Tq8ZrdBEGBHl0otwnl+CSRzRCiGtq0vmgu6mZ5FMbeW3ojPDK?=
 =?us-ascii?Q?SZ4sesPzevSaSqkZBsgOH0h5UDgbpiFSKgX0thaFNsKBgoFNDxjq8E2stVK7?=
 =?us-ascii?Q?BwkrpvtV/8+XRAXrG8j7Dq5wlfJqju3mNENB0TtPZYwmI6/zT+IG8RtLlDiN?=
 =?us-ascii?Q?D5wGo8clLLsWPa7jehc3gtJpS/ecaF8WEtw3uMXbvhi2pbKCDtNPf7XRc5Sb?=
 =?us-ascii?Q?ZkwokQ612eMliyX5ai+Hw3cRDxmBO7e6FU01iHcGgoEeJqU9edjLTYRrM1Tr?=
 =?us-ascii?Q?VQMq8un2Jb7+Ax7C/rlvI/qpzIGj9PxetUEIa9RU0/sqEtFjPZeYYorpcBKz?=
 =?us-ascii?Q?qYCm9QZOuotbUcNIxooZcqgIole25505qydA/p2058g8MQlT/Lf7r0cm48S7?=
 =?us-ascii?Q?E7iL6hJm1DFgcl4wZlhHb3JZpiDxlbZtDGJ6aWH6lqAfiPUnSyDOloHyytkZ?=
 =?us-ascii?Q?Ahwa+o3A3J6ff/3RmYWyqRZk3nuNgZNI9q+NZC8u+5HQBlVnLbFHV3gnXQjJ?=
 =?us-ascii?Q?fE6Ax3uCTeRIFkfKk/ic2nn4Dp8XedS5OvjDBYSv+nrNy19zJH/a0l502GWc?=
 =?us-ascii?Q?zf9I5WGjDS8aUIvAykR0saB9BOMw3n0iIb1s3CTjFODPGlsTcr7TuISiAGMw?=
 =?us-ascii?Q?a8r8wwBBG1mH9FpzLKCvQBVnJjJNlDeCejtbEUhWB9J/co85Pcp0eXnicqvf?=
 =?us-ascii?Q?Fk5GRQVnt9UzlNpUir98P8SD1b2sU2inypXo4UnAXJME/GF0HhLEvCjKFJKz?=
 =?us-ascii?Q?kZ8FTtxgJdqG9hQhtl033c6AvUREqpdYgA7153WYK+HYxw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+z4SQAN00yac9juo5hxWGd5rLijkx9nQ456jpYcJKrC5ZhlBT2QNhFU5k9+E?=
 =?us-ascii?Q?fO9k2zNAa4jTuWljNo9pdFYDE3RaRB6iw0jmrxfWBrLSM9EC3tURxmXUKyHI?=
 =?us-ascii?Q?w5x57rega7mY7pKxu/qbo6gxZng5HAgjVXArW05pji0YS/kdn7TIeH+BO9jR?=
 =?us-ascii?Q?2VH7kGmKSUXxuP04FXTKKM5rggqWqIYfeik+fooTTl7/CWOKh37Qh8J/Yj+v?=
 =?us-ascii?Q?/RdDg6W66rasgpP5YYo2mcXBjjpDqgxg19B+OjDKkk0CHkv6kkWt8g7j5lPZ?=
 =?us-ascii?Q?wTX2Yhm3U5ViaBlwRoxKq8vIIpw0N/9hoCD/Zo2f0zS8J8mUpfrKRGWqzz3u?=
 =?us-ascii?Q?ll2DA7CwTtnxHAACf+B8IhDfg8BJc6TIR4LN2E7XCor5v75VDRrLs3ZY6K2m?=
 =?us-ascii?Q?GlTYP8V6N7x8lvgOWvO3QNXn4/DEUlXWt3eWqvRSGsOUOXcqQ2MfJENCfpJ2?=
 =?us-ascii?Q?LF+ms0TnfU8FnUsWMHCWnDWKBsWSfbo1VdNNKJC7uXkrgP5/20WJAxeGTgVB?=
 =?us-ascii?Q?QN0LNcatAKnRl+XwLjSGxnydwsvhhDid1r3nQagR7hwsHXfdMpk/coKqZgWJ?=
 =?us-ascii?Q?j8zT9FTkbqMjg4EQ/XU8ZKTDG6gXXqMd6qUDA9O6LBI6n7mu6EW4Wlfo3mkb?=
 =?us-ascii?Q?eYcYn3MtZCEFClAaNDBnaDkCVmWCGj1JkCoKSDJDMDcPPT8a4sH8GnNOSTFZ?=
 =?us-ascii?Q?NVm5x7AUhbqEMqmU12TBaiCltH0SJ2MW4P0mT+BrRFZv7nQHhjPo9NGKEoNa?=
 =?us-ascii?Q?ZrI/aECx+G9iQ299WrbPHOhJI0bdEE8j0Ry04yBUj5GS1W+NhuiLh8gz96qH?=
 =?us-ascii?Q?6o40O93/1iEfNCtxSF/QxAo82SIF7oikPiYJoHnKYJyOQyFdDBcPc/x5Lfib?=
 =?us-ascii?Q?UZL1eEa15MOsmGRAXa0qQ+vimD+O2rBeeGcfxT4gC0EijrqE6cFEdei/1zWp?=
 =?us-ascii?Q?ZQCuswq6NZOpp2nh0DlVfnTNskeD6Y5PndKu6p0rzSYhKoXS90D6/NYjnjib?=
 =?us-ascii?Q?jInGChVVjNRA17/BqWfIgo4mSZANmw5i1YqRL3Ylpm39Swpg4mWCM1aA9c68?=
 =?us-ascii?Q?NOi5Evf4knHeUCjzlalIeeYG45FPsBYdjsAjIft1qiu7kU09B0ltuGs6P+sn?=
 =?us-ascii?Q?yPw0eUuczT3GRTV1Kkh44PxFUzaQEv6DKezz+7PsCZdpu8mwBw2XFbKPJ/kE?=
 =?us-ascii?Q?F3DcdZW/H4S/EzaPppTOG1ZhfpTCMlYDzpeSmLW++lGS+leB3me8wX36jQE4?=
 =?us-ascii?Q?5t2rrl50tlLw/Otbo7sohFJLtMZRlF0Dh1C0LW2Z9Tf9fiORk95IzeXVsON+?=
 =?us-ascii?Q?emy0+WIdWcO1o7cpRCml9SfmqOWAAbkovRuDRQtUJhFnS4ZYs1AwHrvUl5aq?=
 =?us-ascii?Q?AQXpwwD22k92oUFxW381Ak9wR4LPnDS0D9fL5kVqvd2z8DBEVxkeVy5cIXyW?=
 =?us-ascii?Q?hai+PUFrKS1cc23W6hNZnb7UKMRM+k30gEZQsM/wbQ9vZy/HyH41cPI0M2J9?=
 =?us-ascii?Q?VAXYbqzm8mHNKamYvwIrl7mO1FKrPnuQGvEN8fmyYdM0SimtgkYSvhCnt88B?=
 =?us-ascii?Q?3qq514kctXS5FyqveENZ/22ecwc/8gzE3pgUY0W3npPF+ESh8zWANhVtjWhm?=
 =?us-ascii?Q?U9dtbQXAphG0qA1CDbKGaXk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e382399c-665c-4798-813f-08dce26cd2fd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 23:00:20.5309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bf3f6lJMPd0md+XkZOAJBM1nOmQXTt60k4Up0XeCBjyIrw1dENO7RaFvOgEJSBf4LAaQcabOLdfFHxddRiwGFZpNmwqLhYZmD2r0z3lZ4kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6271
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
index e830b731d24..ea0491d3155 100644
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
index 45084d39d3a..739a8a52cbd 100644
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
+	printf("\nNAND torture: device '%s' offset 0x%llx size 0x%llx (block size 0x%x)\n",
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
 #ifdef CONFIG_CMD_MTD_MARKBAD
 	"mtd markbad                           <name>         <off> [<off> ...]\n"
+#endif
+#ifdef CONFIG_CMD_MTD_TORTURE
+	"mtd torture                           <name>        [<off> [<size>]]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -864,6 +1056,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 #ifdef CONFIG_CMD_MTD_MARKBAD
 		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
 					     mtd_name_complete),
+#endif
+#ifdef CONFIG_CMD_MTD_NAND_WRITE_TEST
+		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_write_test, 4, 0,
+					     do_nand_write_test,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.45.2

