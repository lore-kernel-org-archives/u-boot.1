Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E25ECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E25C88E3E;
	Tue, 10 Sep 2024 00:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="dS40ulnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6BFE88C31; Tue, 10 Sep 2024 00:21:33 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFBF88E37
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6Hjbq0K7HXYiUDkHRNqAcPkBEfxzXQMF2hYHfJ8HBfz99i+0Vzj4aXDJa7htpgIRzyv0JkylMz2a4QiQ3QdkbLSkXaKBUFN9sjWxW1y8qhyLlxe9sSg1P7TSrjmJT2Em4LiawjT9wr7tRykM1P90FpAUioab5Q+gSqNbO4hJrcV7eG5SBmbWhs83amVAn3J9j7dOR2iTJ9WiSLdRpA+xpS771dTXWS+B1Tc4DiCJ9dIE58P6ISlDM/iwY1fHKl5wg3EBobjaY3GMi5vLUH3xAMUAw0I7n5Si1LycQKA4fas+ZVR/pOe02Hh22ZabxAxL0PDi/WimBO9QHc8u0LipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMrTDapzjW/EeW4hYlQ04nRmaXXlkQpfYJ0jn+0RPwo=;
 b=yH/VmCBhIM6ihiptnVObvn8UadurVW0W8I2fOpPEViJSwAmExMmNuz9UhHpvuFHjXXAVAulL9vEFwRTymeI5lVUpJmPmT+YiflDc2Dx7HIiESMHoL/HvpNJsem8VIlm68uiF6Py97JmmeYaP5R+wuhSBJ4KAPdTtu7WWeZG2HwPhXXTo79ZI7Hkgpaa9nvMrZQ5QIvWxM3esoOztvCSBPpo4WKHu02u2abqgy0ise3HrnDP4EIIknrxaJoA46KiuFy2CcRGZcJlS22XGHHey2QbE5LqGB5nDe7Pod44BGA9rAMOsaXiXAAmgv9OUncQ2IvJxdC9qRM2pMVGiiTFiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMrTDapzjW/EeW4hYlQ04nRmaXXlkQpfYJ0jn+0RPwo=;
 b=dS40ulnCb3qP0MDqso2HOeMZyce0wIQbbivwElDJR80PCUU73AWFm8IB9OEmvCYqNokxGilJW0YgqqFPWrfAcUVLO+IdDuoUhKg4QMXQcGylJHI8oroX6CGciLRnE6VaQXlOSdHzWFe5oT4TPDIo5TNzP8v2TBbW+i3StybOd/TKJw9kmxigbxxSJuEYUjNfPybNwTEsY+bi9VaW4fWwcc92Lv/40jtZMCxS7IKFd0yLXzsZnuSwBrsYwRv/CSG1xM2yfX93l6E7zs8YIK6MD24MlV+iuljLfPMsCDo5DZ4RV1pCeUZXWQ5Hfj0qWuu35MgG2f3ceZMevlZQxeCOGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9935.eurprd08.prod.outlook.com (2603:10a6:10:401::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:21:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:21:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v2 2/3] cmd: mtd: add torture command support
Date: Tue, 10 Sep 2024 01:21:11 +0300
Message-ID: <20240909222113.2562703-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222113.2562703-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222113.2562703-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7356f3-821c-4dcc-89b1-08dcd11dbd33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6pMRm+DJdq2Z2jCr1Sfjr89f9x+gSn2eKNyRroVLB0LvVSmBe9trz4z6JLjm?=
 =?us-ascii?Q?3xY+lcIkArs8Vhj3HyqBLRUEb9vvDsdvwGIpQlXIM02jsBV8Xyp1eq7YmItu?=
 =?us-ascii?Q?vZCfVr3452KQe8jIG4pjqk+V9rCU03f5UYTq+oNz3Mjf9c4HoCunOZLIXJS9?=
 =?us-ascii?Q?n01+1Wi3V73L2iJ5gshADaxFUMAJns/v+PSo43GNjSDRNXDY7Qu+lG34dURS?=
 =?us-ascii?Q?YoC4AVjrAgZlOw//oaC/gm4nxq1oa3qu5D7kZtLS6T7xauMC7syEZliOsDuI?=
 =?us-ascii?Q?aH/nAHVW9GKEHqxvxr5SmRisiRwl8BJMcgh5fB5welE3Gs2QxliWAeqsy+JK?=
 =?us-ascii?Q?kzKmNGUAlTYZrnSfyV7QSpnzQ6lHDAzkGulgGj5SuResHsnWrgz9NFz2bdfM?=
 =?us-ascii?Q?8H+316LesdjyQmDuYaue/yx4/jNxpn+vOZ1jjq9SnhY0s5oXKKtdgu5c0k6H?=
 =?us-ascii?Q?ZJ1BegILlVFtMnlJxoFBXW8+5YcsVSpSXXCfMyBm2nW1UZD4f4rmGT3RwV1j?=
 =?us-ascii?Q?Nel+EJkWjrPAnTc7z8WiQtZF3V5Ax5MQIIzw55WAq6Y2RzoNEWACRcKh8HBA?=
 =?us-ascii?Q?2sdRlRHZ4mCmjXKcg0FfG0ftfb1yuPGK0yJmQrEhn0CwYgNJ+R4PUsyIPCJE?=
 =?us-ascii?Q?5GGT+SMqurU/jpzgqa4E0g8uYxty5ARpmKjzFADpNgdIfevbPejIcaH/BaGZ?=
 =?us-ascii?Q?afPuSI1sNl8/WzuaABBH1SiyNsqvYjVTB4CIFGJG+xUUfQ9CZF4QeZzu8wMI?=
 =?us-ascii?Q?+/FB89xGRhFy5OCcnVwroAu348bpEsnLjnW/ZGV3DnLKlG/h5oP3EBZWyzZi?=
 =?us-ascii?Q?I9HcXRsX4i8/sz5wpvMn+O3P1Ood2OdbszJQQMaLgvYhm+WY9644fIGppLZ5?=
 =?us-ascii?Q?UiRYz1sCjv5xOMl0yCz9isxGmYLrANzhDe7ep8iwTyFQOW9AvgMYR3hy8mNo?=
 =?us-ascii?Q?khKLnVKFH9coGr59nhFHhpvUCnY4cCzqGcE0bh3aKWKRbLZP7R81GxGq0OoM?=
 =?us-ascii?Q?ylI0yu6KuU3Qn2xX0+ytJs2WFj/yfP15khW+M3pEyBdA6EA/BrE1eI/TTvhE?=
 =?us-ascii?Q?Zjj40tcqNVTpnwU2Yx0hzWDq4HFjtx5d9sHKbTR1v4SZe9gCUhiAAOnpDk2K?=
 =?us-ascii?Q?SL5NnThSqO5EMFr89Co4VeoR/gFgdd+0fsuDpNYSuv2+xh+K6kyTkwUzafkt?=
 =?us-ascii?Q?CyxFBsqd8wVqkv+Fpp2AAc4YqjeQhSu+7qEXYiWcchCIH0O8ydBbe+gIPgqc?=
 =?us-ascii?Q?OyWaRQjPVAXNMIar87oWiFWTs/JW7q9NLu14KlQZ2iTXjYAa/ruuDppOD/cC?=
 =?us-ascii?Q?wyqCtLb0Uh51dkO3Fc5R8fRK0HrrjDp97ACP/KQlueq3HKQHnWMKJTxtxWOW?=
 =?us-ascii?Q?fJ6KqtJ2a2PZKvvzlm93H9KUx6UOh0fvAYfWXuKyIVn0nHHIHv2+0EVMASbC?=
 =?us-ascii?Q?rDdzs0I/M3Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R+J67QAqbsyImzhA7TU9LvutZkNinWTH8Q3TzFfPLqGRLIIR+S73IIq6Ef0t?=
 =?us-ascii?Q?+8w/meuZsQQ6XKrZkasbfKbI5dVnsVC0acKttYSK5Qdxns7o0HE7rbQ1tt1G?=
 =?us-ascii?Q?3YTzV4XSYfwJQzBK4hFZosdlSdlKIyRFu67YV0PFjDf/WUJW/5MFUr1nxfzB?=
 =?us-ascii?Q?2CTjtj5kf8D0TaRbXqBiIBJ4gAIn6rMqYpngVTdgUIxYGdancJU8XQn59AFJ?=
 =?us-ascii?Q?Zmor1BXBakoTJeXvIujlZ/WGFSCIHQAq+nj8BXf3rc8jN8uQDgaRC8+QGHD5?=
 =?us-ascii?Q?evxwbkmw67GYKc85mpuwGSFwHo5Zfu6wtdYgUgcCcaHWRSTAyiV1D9CI4CcG?=
 =?us-ascii?Q?MSn5825GRKNGC4ZtqqKSZDdRWpyr9JpSE1M+upXlFd0TU3noVSHhEycUTy7G?=
 =?us-ascii?Q?JboUVm9gzWOwTfch+ORSblwrV12So4folxOpIx7J3AtBOL0CsdRUovRbfT8S?=
 =?us-ascii?Q?d+/eT54ySgLJ/5YeOdqwvgHMuGFgJwdbai8lJVMr329LwkKyLn62oDSGBf5g?=
 =?us-ascii?Q?F8KdFTbwWZ86UoGLaYVSZmT7otDsGaveJXoRE1MjcfFeXAnSgeBigkvcGVU6?=
 =?us-ascii?Q?XCIQsp6AeCVal/ZIDn3tTatxLDsqrIK9ukQplJKuyfKThpFVVu5ZPir+jFv5?=
 =?us-ascii?Q?vlCLN8cLn8rdQF5uV4vzjTBSeDR3hBHV/1NFjjg25yWQF/Q5b7riV3OhVDU+?=
 =?us-ascii?Q?LzPp9d5ZKVkz2vy16nJ4ig1fjHlSrASqSWjAoXPVi0lCWdkgHKijqHsNZZLz?=
 =?us-ascii?Q?o8e0loJNVA+RDZmRGAmc2NiX682Q4w5u10U0PE6ko0PuGu76OqTMsbzM57NR?=
 =?us-ascii?Q?ciDit5/j4jySO5oTUbfyN9QFCocbInmWxEu6QrQHKrqATK7Lta1617FrU4xP?=
 =?us-ascii?Q?JOwpV/JJA/sdUKeq532IUpC6EXoeFufc123TN0SCOMxUkCIXJi95MbcrPDO1?=
 =?us-ascii?Q?8RoVQqWeqWilnbE5OXmKYwIYtk/aE/67v6V9IrWYiRI6MomWQoRVXndrO4JY?=
 =?us-ascii?Q?hzNcy0hWs1Wz8rfgM8FR+xdzLSivhHv9uyXC7Y2isEkQY031+XnHLyxqPuC0?=
 =?us-ascii?Q?l9lAlG6BTCbvz9asota9fuuvhJxUmVzaewo+ZD2uMifEAciH6gbq8MpHVKw5?=
 =?us-ascii?Q?+D46bidm7oDOC4vIjK+7r6xWYLhYXQwZ+xCg0E84B5wFx2QaRBzPZUWj83L3?=
 =?us-ascii?Q?wrRUppHXH8Js4tzpWa/ckVWIb6Bb8DHvq0M5smgUN44FkSi/3KuLzY2uGuZ+?=
 =?us-ascii?Q?FY7YVrqK+s697+TP6FI+GN3JhXr8mf8wLxwoFT9creObTzSDxpkogmwzGyi3?=
 =?us-ascii?Q?BesCpJgz6Hq3FghLYUn3ONOxbMu5/eHTnRyRehJLfSFB3xGyfsxN03pVl6/0?=
 =?us-ascii?Q?b5mqL4nvIlqsK+w6BOFXUKT64SeGqpuWkwNtWdrdnNdSh2BY+23jLKzH/G++?=
 =?us-ascii?Q?+m8s+9QDMa0zhFqpOqfgzrEw7TZLCusRI4qKgtkJOwEPtTGkHNjmDsXAXFhs?=
 =?us-ascii?Q?hLFqSijteo/RiqosG8OXPo8OS4R0x9H8GA9IdE9hxmyWpIg+0yvRMFe7TbnK?=
 =?us-ascii?Q?cjIRNlbWjzzuxosfApML0sxXl8OJpbiivV0mr18xFoMKjh4iloT/iSP6bqaO?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7356f3-821c-4dcc-89b1-08dcd11dbd33
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:21:23.9652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHDeFza+7LbraFlT2bDgPZCnT0QjIlBln2rDdADWwq+G97+QVAjbjl3bMdsQ6mPkFTO/OYo7avYMounzk5zpPByKw3rosvKPTkc81EdsfBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9935
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
2.45.2

