Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A348E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4FC28968B;
	Wed,  4 Dec 2024 00:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="xkbylwFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1FEF89689; Wed,  4 Dec 2024 00:06:05 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7446F89667
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y122Rq5jY1Fc5yVgEKwHcTHjXGdY7en0xZYW8EYXLSP8/4t7vmkbXwiXQvl0iNhBGqFbgaizwxrpk0HTDuGWBOBcXNYYVok6ARSzYpNkQI1GV5AKRRVgZ3Vk/vtXbz/q41tgvPUyExQF+n8WpDc0Exk3iC9QLtrfup5YLeGLHgbo2yNlUGlnEROUkUOAvBcfHsdSd7EzEnGyIVoQBTYsoVDLYZzFqFOaEluiP5qqGTGAYW3IXF2/rxiEsVeB0aoQaFj+rM8jkdqZueRmAnwimL6Xt+1L4e3A5aTgZFWjq6J9MLqAQZJReIsSlcdTHvs7ShDUM3vIY2w24rHkQlEm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YG1NhDbWnbvMYuNIfL8zNJCrI8MG+IXwC78XuZ+cWS4=;
 b=JKezMSfAy08lxl7T8/IWyhpDiKyiOU6UkaitlGtWR6I/Zg9R7QDqnURXcLfpjl39i5o+PFqyGD0JNgANlD34/cGC61IWy8XOK1l0avKGOal2XL7lBgbLZqaBi9AiJNkzrpVhlGVMU1w0w3ipjT59gjMColePT+1RAoQiLv17xqnUuhFF/Nsb0RPTdMl+vdchyXvuaDWQaAMcGsB4vIsyol+1SnnOHK69oZ2dZ9vH8GpbT5Q2HLo3W/1H6X30Pj23QswdKulKjVl0wl9EQyPt1XX2N1OzFLquSnL+bxnk/1xe5TvG41fUtlUNr2x1J1YO+QPmg/xulbz2LjQegx6/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG1NhDbWnbvMYuNIfL8zNJCrI8MG+IXwC78XuZ+cWS4=;
 b=xkbylwFT9OXc4wAjYBaEn0JadAw0KMUyMk4y9pfBdqEl3zOihUqFp91V3iONj7LG59B3ZWfByssi3x686FREvQkR/SUM0t/I4+fPATVujxxBnh8a9XuGsRAzYaeLnACkY/DpoPlNHhhtRyOgku0Rm5sZyOYUZu8mLVcMcnT2WcptVi8q9rj6FHBOOrGePRHtiGcC604l+YuRxYccJARj1VkUlwum3e76TZIaaG06W0me9jNlyJC0UUn+ceDzuentRAb3643jvI5JB/usZga+txvmIN5EuQV17ggp4AbF6AGwzgWn0hF4GVNM4yfQfoOmmRi2czzqi/iyCcIgvayT0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6066.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 23:06:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:06:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND v4 2/3] cmd: mtd: add nand_write_test command support
Date: Wed,  4 Dec 2024 02:05:50 +0300
Message-ID: <20241203230551.2677602-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203230551.2677602-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241203230551.2677602-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AEF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::31d) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b34ad9c-71bb-472e-94c0-08dd13ef0e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f7HfqbxsxiamZXkGvMFbv1iuqg46VmZdfR3Ibaiw4C9HGvbxfBVGVs1AY1WF?=
 =?us-ascii?Q?WsDb4aopGdH5J4OxpfMn32Z52uorxNBTLQM2rg2JBz2vp8TFwPEBKJlNIurF?=
 =?us-ascii?Q?xekh69JSWOeLVhkBII14kKRzckV9wCYoPNU+5KiUhfk25fYFKesjGBNOI0vc?=
 =?us-ascii?Q?uNw1AQNGgWex4KTWTu74lEnGL2EowM5bvIFwrB0TEl9t72BZVr2b8RhIEM0o?=
 =?us-ascii?Q?wDH9IE1HBhmepGYRSlVJsCLJwja3goxTMPQkGCRwXXZQGchf4nqILG3K00MH?=
 =?us-ascii?Q?ua2tZB2LBpkWMES91gl+Q3HIRMomAXxYN9tJNWo9tMtVfyLVyhjbv6gxQql2?=
 =?us-ascii?Q?WJRRMb2BWsT/h4Sq5cmYpXMZezSH3906fAVWVdN4DBatnFPGUXDIQ06zmydQ?=
 =?us-ascii?Q?aatdYiXul6bTq90PSCyboLGsAMeM0JxgA4Ly4utkB2+jxTniICyX8l68FJlS?=
 =?us-ascii?Q?QvtDJH0hajUjuSTJpXMiS8e1muzw3WK3+GMendkdWo4eylmECC8g/U08mC+0?=
 =?us-ascii?Q?M+g8YPWflsF9yF1ZYF2UR8D+BraAyNv1qnuzFuiIAh6/rReMXAsjUX5JSv/v?=
 =?us-ascii?Q?cbEv8/zhxYYaJimvMDFI1aCh/8zHOX7nv4iDJAHakiT/TPxypLXI9KbJpI8Z?=
 =?us-ascii?Q?WKCJ0uSlROXw00R6vZ/MF4C8DSXbTwia4SSffG1TtvPeoIsWy/qpkZFaylZ/?=
 =?us-ascii?Q?uzCjaKYhdD51zKRe+GzDJnina+gvybjpLBPzd4SVguoDHOHHpRVb+wnyvPOS?=
 =?us-ascii?Q?HYojUg8iBZBs4UF6BPS3x7Jwadc2GFqj7YEARSYb5TraHo+iL50kaDe1mV5S?=
 =?us-ascii?Q?2ln5pVIJJWBkK0rlHVWVGs8H/Nj+KHR4ZRPYHs/S1HlmwHvigJU1boghnJn1?=
 =?us-ascii?Q?8mzzwQosE46Qn7lg1wgP4UBtzBYj82PPz1O7QW62upc3C3lD1C0PbbG/wHuo?=
 =?us-ascii?Q?A14yKX9nEhWsG8ysBV2zNfUyV1OWgjmjsVWfWLKgvBWkwUyqz/XvqT2X5Lqw?=
 =?us-ascii?Q?D9kxVedxmNdkFZ17EsfWiXjI/YRK9mjrqlNy6DEhcqyW2GD14SRr49RpvHIi?=
 =?us-ascii?Q?GwZAUZz2Y4nzQ9YH87aM3KY+ZCuLp/w9rGfkr2jiqOfnIEfu/Xko1P9ZMwB2?=
 =?us-ascii?Q?4T8Q+dru/NQ6+p53SuV5uh3MZazK+uB27+eY8QCI80aQ0oVc5bP5SEJg3UKv?=
 =?us-ascii?Q?gylv4bYJts36hGQF4c2aMiXi6mfAWxTwSnEcEBQBVZ5vQyCplnJXqlEOKaD9?=
 =?us-ascii?Q?+359F+rHYw66xvh2XlOQHX+ay7QRNe+XjheP2MC7oZO4yQ3na37UivZrVWXZ?=
 =?us-ascii?Q?fxnGLp9JY/uLFdRtkQRdkdcgg1c8Icg+VE+0d+cHT+nBXtGA7QFLBHqJ4wse?=
 =?us-ascii?Q?SRgM2OgiBZhIEzdrcPzcomcWZ8KL64S4T2XHa4NqpQBf4ci0aL9KrqCfY9fb?=
 =?us-ascii?Q?5UCTbBmA0Us=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sRJfRJxzbAo1OzVJ4iBQrzNC/a9lgMifkFv9gFNilHZ73St9disrKATbdSbP?=
 =?us-ascii?Q?Max90W5XYBn5WB41Pah/u3FCo3W0w4Ch87ZGaUd+De2vB65Y0U9JUuW2hyun?=
 =?us-ascii?Q?YNYUfiC+ns8uynnaPldpTqJcP5/1VAmK1GASVuSV4m9zuzx7ZuNdBQttw72g?=
 =?us-ascii?Q?Jxd+iWPU4ctpQ14ayaWMZkQo8Jj9+0nUu+5abxQPY+qnT0/XGrFtXMZpkyXv?=
 =?us-ascii?Q?Y/TtzeCov79imWnhMAHWpIr67s114sES4Cj8Sc5ewmE2fpKMWikI4rMZLfel?=
 =?us-ascii?Q?fcyJjMis7ZeSFlFtF1n3KRtUjXYBNckCInWQb06WhfZQ0n9UJCPQYCah3HZU?=
 =?us-ascii?Q?nnJhZRWybNZIknA61eeAFuj2q+N/EkKdAIMCjX8wvKKjKP1lq3z60+vHJIV0?=
 =?us-ascii?Q?B7M4jNnpWrxUoM3R8BczwiN+tQ0fpT0XsdWAxVpFHbSxt1CDkgEyYrlliG2/?=
 =?us-ascii?Q?FC2uMA6AtPJERTrJ/u8tEap68CCaYlkMaGKiObN0BSl3HHwGoeQjZ/SljVsV?=
 =?us-ascii?Q?5YR7cc4WZ5NdYVmkafeALs416R6lqVsXK7CXl0IONQSAprpH6tZCTNZilDoe?=
 =?us-ascii?Q?wLiSLCuBOm7gjLC+Ll062utJ0AGYeRvi3f+LKJNRMjpxymch4Pa9MjD8ItD5?=
 =?us-ascii?Q?wqb3tz3byqQso4B7juW9t1L5sLno2OLI+YMDUrlCV/lgSdf5GdOOZ6XHZvbG?=
 =?us-ascii?Q?Fstj6rbYQK/eUUzIvYy29Go+Q9lS0Tu4pIoUGQHhhF+5fIbj2yOdnlscqQIH?=
 =?us-ascii?Q?fMb9dNzWqBZqt4z8SvNt0crpG5al2UVHc/LljmWXGwuHJmekjn/RKeiE2LSg?=
 =?us-ascii?Q?bvCJ1m6VOitZJV/6eGZSJdYB6PGIxDXQBBzwqI+VYDn1/w0Rb4ItDFPgMJ2J?=
 =?us-ascii?Q?YabE9YSutfZ/yHzqsR9J5GOpYXdfVSyk04lN4qNkpj/br3Dvs2EJykZjhVik?=
 =?us-ascii?Q?Uos3go5cVje2Pu20NwiBu8Rh1NMFU+1b98m2vC4HhLLPp41G5WTRBu9RnNvv?=
 =?us-ascii?Q?VOGPchiPGVoiKmbXJhQkuYk+uZgpURYtEggx+3vf+uo6FKPX/97++AZp7U3R?=
 =?us-ascii?Q?l6V0as0OhkF3Xp8YnlAj4gGlWcQHPFvl+AjeJseWeRnEhaSTD4Mzl0J9CxVB?=
 =?us-ascii?Q?PCthVRw4D6X4nbUAAjKswpbJ5WIvZhPuaCDebOkjWwfbMVoW0L07aFkgz1ox?=
 =?us-ascii?Q?C3qIPH+RfnI2WnAU1AHY81XSu9bbCA0OaEDem5yIxhPgd08jLHEz2tG9zHLb?=
 =?us-ascii?Q?ICb4CCwr3pz7rjQ5D0VfpMs00qM3G2pCa8Wtvje3Nvz+yNpcgrbpxjKMdRW/?=
 =?us-ascii?Q?BiX4cNfPgIYopFFoIVXPW4guyrAEE+aH7zDhAgwV6uNgQdqYJSTZu5atyomX?=
 =?us-ascii?Q?I107P4zTNjtcOaloJk55Z2SjtldEl9hF7aL7obY/kYerenMc5pf27WpVFqKm?=
 =?us-ascii?Q?iaGjmhMRDJLodmAmBSiIcEMyqzGf43965B1IvIK5ibSWGpdIpQ0mNEru6E9l?=
 =?us-ascii?Q?H/VPTA4BV6cmt74OAz6X/WlzQkQEjq+wc78xeFI2JPa4HVg3qG/I2m3T76ec?=
 =?us-ascii?Q?38ei47B0VPpEfZ0fv9NNzvzuuPpBL38TWhMualVMX82YN2nUnD/t6d++tXPZ?=
 =?us-ascii?Q?t1axQx78hVkEFHYh96t7xvM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b34ad9c-71bb-472e-94c0-08dd13ef0e51
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:06:02.1721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjX1h6lK2fmenj6xZxZ7dNrpDf46dOeU4NeKGVor2uDeyYSBNtCIfBAK45N//T/dug38vvAiUUr7HAK+EojB/Fh5GFddgMh6YWvbN+UDiYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6066
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
index 6909ed476ba..778b6dca055 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1468,6 +1468,20 @@ config CMD_MTD_MARKBAD
 
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
index bf08f483c14..bcff020bfd3 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -19,6 +19,7 @@
 #include <mtd.h>
 #include <dm/devres.h>
 #include <linux/err.h>
+#include <memalign.h>
 
 #include <linux/ctype.h>
 
@@ -751,6 +752,194 @@ out_put_mtd:
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
@@ -836,6 +1025,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
 	"mtd markbad                           <name>         <off> [<off> ...]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
+	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -873,6 +1065,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
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

