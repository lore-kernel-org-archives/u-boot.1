Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F40C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E2B388548;
	Thu, 27 Jun 2024 13:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="CN+yk8nt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17418852C; Thu, 27 Jun 2024 13:27:04 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD625880A5
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLVGkStzHqwC7/DaHmGXqv9nzrfLfmy3SPWKoOBuTxsAesuVV4tJ5EYSiOBo0zUuHLbITVQZIPXFL41UPkeW9K2ZB9SD8PoZC66ycxObobOEY77iFaVjCYrHK+wFWgnBnxTI5+hZjCGPCXcS208fONbWZ6jgwG4JlS0tZFwAPjxHoBcXemQr7C7oIDS54uNPK0LtNRFurP0F9sDj1EfI5RINBtcUM4XnftyxjavAS50nef5fRwPAfeHyAe5I1mvupINYrjTAj+lT0XbacmqxDP2lxwYI+ejWJeOZM2gKFW4iQ3C1y5vREQ4Th9ezoa+uH/oXfbzHBrhTSEDie5ngrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbjZg/VvdbUZRNvj3KP6dpYfkFujT3jbDYJ3yYrJcvw=;
 b=R2u0adVt3nDzGn6B7Ult3DqFY/+QRCHxEbUqpH3E/Sz6443H1Vw6cKXT1OhwGqSz1HhpUIRVh93TgN7M0SbygfvotOHrvgZgTknHXxY88knDlva8sJdEacqf5LIMXqwO2REptfrk1kPvlBNL9ZSXGxZe9SGrU49Xu+VjQ3bBqBRsEr3SRkHYpCP1JlvwZRjOLrxsdHj4mKL437Pj3OakgwKNrwfyug0xA3I4nyNjheRXLxL6cqLuBNThdzvqM+wHJNbsPN6Xtw9hqhabnttaP/GCCduKh8HO6Yn7d4CXmDFGWFcDm3qXlQAWJ5qAy6R/ZZkt/VDBm+WZcXck+nixOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbjZg/VvdbUZRNvj3KP6dpYfkFujT3jbDYJ3yYrJcvw=;
 b=CN+yk8nt1GA/3zkPEMJrqbErb9s7qYkuNqfqN+Zwvf6rZ1ysv69JpAV0o+ZxF24tfkVo5PW7Ljr2lvpTh2NGk8cW1l3oR7I9G8p7ndRygo2xHaMz/uUvtS2zN0+lQkwK5N7RS4LsZtt/TGeub9vzBrCdUWg0lfuQ9AkVznXh4mEi/XlCMdzEMRWDPx8PP/yi3E+4LHET3zMwephpOJjCiwhHHtoP55mxnPm/DkaB0bNopLApyTxEw3Un6DfCSFHwR1D07hjpwnAN2MySFTrG4ty1Ab+ndx0V6eYvZMwZ3ZenlJPt1oKunccy11VymGIAgzZZNVQWj06u4SPtazsygg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6431.eurprd08.prod.outlook.com (2603:10a6:102:157::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 11:27:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:27:01 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Subject: [PATCH 2/3] cmd: mtd: add torture command support
Date: Thu, 27 Jun 2024 14:26:51 +0300
Message-ID: <20240627112652.99818-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627112652.99818-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627112652.99818-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 94abd3d9-1600-4525-30a6-08dc969c104a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lxxXFAMVHsrdzNYv9lYnfXCvHH49tPBurBw6nvcSyuDktvGl3gxYqhBZg9Kt?=
 =?us-ascii?Q?iDmq50k5PMQPHcDdkz5wT/7GyUmADk3J8GTsTa7/Za3b6Y1SgdRNH9cbH0xF?=
 =?us-ascii?Q?HH3CaNyoT6DV+T4tSlf8aurYyVpdOx2woPJsAawH2Chhw0jRFRzScPx5Pnc2?=
 =?us-ascii?Q?JWMpp+0Ytr9lIZLuLmciekQUZIKRe3A+taf1kZwa/aHAc95uqi+BIQW797/8?=
 =?us-ascii?Q?vM8Xa1m5ajxMqlQJFFWP8iZoPv7fM5t5CiGLdAW9KEiwJl3jRJI5CtVmgrMk?=
 =?us-ascii?Q?JC++jBz6YJkWzc6KRxeYlMPRiWGf5b5U5s88IfHOgkdTEIdBPuMj3LsDwWfj?=
 =?us-ascii?Q?mUun5tzyxzeagMGQrpAgnpWByO1fF+b08sdFrU4nrED1CiLEKxggD3YXB6kU?=
 =?us-ascii?Q?oyH9aFfDreknzTbww563zB4wTJnicsOmYspv0oTZ5W7Mvm9PQcqmAi9o2g0P?=
 =?us-ascii?Q?gDfnU1RDUfTjtw/mC8t+lka2zhQqW0zOCqI2Hcc8/vtU7q8EQi4E0f7CZoRb?=
 =?us-ascii?Q?meUF52t5M8lzIHKBCruYDzEhI4jh9klMphH3fl9lzrBrMasLEbXtcwHd4P4P?=
 =?us-ascii?Q?pNjT09ao2INBM8ceNVq7PupkCyulz7ZtTdqRbCbFTv8iIy18bBBCCrAJNM1h?=
 =?us-ascii?Q?NYXI6Iv8Ej2J+j37zXaRTMSIArFQdEkjt+70AdjJcrLqjO/go4Ea06CHFsa1?=
 =?us-ascii?Q?hp3zrlHH8JB5OdwVZdvXF4hGyOoxTixsvQ7kKCuvB3HXSAG37uJJ86n16QRn?=
 =?us-ascii?Q?xd9BIbLLk9a5DjPtgLsut6N4WFAVm1dfRbq4tTXX9f6DkZflLewSnJtTzrqO?=
 =?us-ascii?Q?hclpPlqFoB/HTOouo+s+6mO2Vg4V87AY2mtyTkulLGEGzezKEYxUchUTVPM4?=
 =?us-ascii?Q?8KTMdx+1fBH+9JjU32wxbfr5TB9LQ1ymDKUXepskEz2DETGlDFTqw1SvOnds?=
 =?us-ascii?Q?yB3Marm9PWqI5lMIAlN/gUCXfUi7i0PAOcUmiYwVdT4HXd/VGlXSdx7PZ4Vn?=
 =?us-ascii?Q?oGXmk8azxfeV7uknczB19HyiJMjpknxlLBVL2zuTOLuVZKQfu5ZpRfEL8ub6?=
 =?us-ascii?Q?GauxvZ7CenXM4OXx4hnZtLy4aCvVNu+2SfMJcy5lnmE4PpEp0rAYzb++28Lr?=
 =?us-ascii?Q?4VPCUvxIGuoSFq0Pb4eaC8dEGMhNETY7EIChV6nAtE9qyEVhShNaXNUyr7dL?=
 =?us-ascii?Q?jJtPVkhQ9xMDlClEdMgVPkbAAgZ2Gpb3GyKI5GgnLwAHXyBlQJAK50+ugMHk?=
 =?us-ascii?Q?KKO8UNixXHM/370C84rAPzDUiOO2QIzYvlbBKdju+vD19YleZkQMMo/hS4Xb?=
 =?us-ascii?Q?fcx6b2wr+a1YKPftE1iLGPwp2jpqXhN/VQbnVSXN+rxH1IBesNXnfxLOSFES?=
 =?us-ascii?Q?A8b1hneBt0XJbB2L1vLFpV4GC1Jsfd0yA3pdwLHu3oXPbqxmtmCdGkIqTWhK?=
 =?us-ascii?Q?+6MPo1CoxTg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YhubjjVqJ43ZAWQ7pZMQ9uUALm2e+XWhvGl2RO151Q6jGmkUukr6jikzixqV?=
 =?us-ascii?Q?2P/ebrWMr5J8pD9sRH3qRCgGOJm9CWyXqOH+K9Pec7P/BIc0wsdZJp4VJSwU?=
 =?us-ascii?Q?WicnHWqEXIOCLwYatmhh1eHzPmPdJSb1drta/bl/mxDG83YFtjtT76Q+f4fM?=
 =?us-ascii?Q?GmkuR3QnjNj/KVV9HUKtnkdU4yHeENRbwI+SQZdXvhRrND8LaCRK1VoiNvw3?=
 =?us-ascii?Q?OgslQUrVt0saRxCzNysILN+m4/9k+Y00tXGWvt7On0ThWUiCqxSDNUei5Idh?=
 =?us-ascii?Q?WMg7rP/L2VzVdz5LeG/BKM7HlaUGZS3QBbyRqD1zJkYJp6+2Iek09zzAVf5I?=
 =?us-ascii?Q?FGf+Ew51kGPal1p3OnMhYSajgqR//Q8tlHD9Xy9foJaYZOijOXGXyJ61g8/K?=
 =?us-ascii?Q?8SKmpu6f64FHm0NjnoCd7wYaXYRYsBtU0xSlm7miQMUXQjAq65OfVNHVoQrF?=
 =?us-ascii?Q?6/TRVLiHwXulQl1NfrDSXyDB7sB+79MSg9Rwia0pT5IQAywScXo3bVtmIuHl?=
 =?us-ascii?Q?QuUp7Cv8dDwjk9Z4eKnzf8RBgE9xuTNf1VI+QLPkUlBSmvz8CZyULfeAOPl5?=
 =?us-ascii?Q?7wJ/Kv6AtA7HcQkNxWdqiQEEgw6GpxoLV/8WwG+VIOGj1wMsYM2lYfvV3oxi?=
 =?us-ascii?Q?ZMFrMIvFW2xW/anaNjWZFClOYCpEBHtTufVnYxDRMgyfm8uLU1ap9PtK6W36?=
 =?us-ascii?Q?5PiG5D5QT8seGFijjIfmNl/dMx3Eiw1egnpT47wRu+JRQjnKkMoS+Ypd16rS?=
 =?us-ascii?Q?HGyIw5DBExj1OXN6QH6uXkAqTm/9UQ6AVCTameC7PcyqH2kIm7MhYIGKe9wQ?=
 =?us-ascii?Q?V4iqfdwZ2pieo3QLII3irIIFfcAsKFixubpOuG8DsJLzbPRKdBN2rZ4e8V4e?=
 =?us-ascii?Q?vdNJL3P6m96V5t7NwMzCjQ9BMIXpSu7U1UTPkTkn3lMNSrBrTMaAt7l3nuuW?=
 =?us-ascii?Q?qzxio/FAelQGLsGNcnpBGerkMXgH8Kav4yIchxulvV0Gh9zJiq4Bhff4DLtz?=
 =?us-ascii?Q?eYKPOdwBzLyH31b41b23u+AwBHjCXaDN7FY68Nc4UnUesrPPd12ZPU3XJSFS?=
 =?us-ascii?Q?gCHhszg7h13/o6pN3FAiUqC6PcTJU9bySAKDyRdCZfE1MhS9sG9xwGvrcLX1?=
 =?us-ascii?Q?sfHdV8damp9KOqf7Vsvq5QrEXMj70WV0kXp36SLc4NQef568xbkdYocJ37yD?=
 =?us-ascii?Q?RxG0WjVRnWJhHec8SOTZ7w0VR0uVNPEA1FA5wgOLNf7bowt3qyX9MGMpTNre?=
 =?us-ascii?Q?o9B+/VuayC/lU4HXLKvECb8WkGD9tw5rUmKke1PplecAngT2GFLbd5spB9yM?=
 =?us-ascii?Q?HFYodcmYG+fF9/N4DNgeQf9MFOprsypm2h8OVETPsEDYed1ww4xQf2/uscWa?=
 =?us-ascii?Q?0SxgNxSJFjruMakDk5Zs5+AYkLVijLiFuizEElpxngFa/nn87OrB8BncHf+f?=
 =?us-ascii?Q?lAX3GxMsmKzH1GVpCsCs2NSL/6gZeCY/LvaJmPNexC6yzWQ8sHTqxFz/PgvP?=
 =?us-ascii?Q?ijgziImtkdvWlMwS+37GvBqhjfoIPw7p2Lxii7Wp9n4l67924Q+rGO4suiil?=
 =?us-ascii?Q?3blgmwdsOQCXTMB3h8sAWw6rV0FaS55As2GhydP9wNTGO3yBnCenJxH32z06?=
 =?us-ascii?Q?kWtfxOWQfuz+hgv0p+7czJU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 94abd3d9-1600-4525-30a6-08dc969c104a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:27:01.3596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuz2kaY5ZpCc7ilnOm5rbkIu4suuJql8yo9vdQrj3lY9KpOqDtTcZFKugvcIj8XuD1jyGy6ICLmiOV7SF0rJvqRUWcI2m3qsUhilNIjWe3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6431
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
index 70c2d6a2dda..0685b598679 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1424,6 +1424,12 @@ config CMD_MTD_MARKBAD
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
index 18f00493780..df4130b90d1 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -19,6 +19,7 @@
 #include <mtd.h>
 #include <dm/devres.h>
 #include <linux/err.h>
+#include <memalign.h>
 
 #include <linux/ctype.h>
 
@@ -743,6 +744,194 @@ out_put_mtd:
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
@@ -828,6 +1017,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #ifdef CONFIG_CMD_MTD_MARKBAD
 	"mtd markbad                           <name>         <off> [<off> ...]\n"
+#endif
+#ifdef CONFIG_CMD_MTD_TORTURE
+	"mtd torture                           <name>        [<off> [<size>]]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -865,6 +1057,10 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
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
2.43.0

