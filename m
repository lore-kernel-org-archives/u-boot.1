Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9303CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4180842BC;
	Fri, 10 Oct 2025 14:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="kYTGS2O3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87470842D0; Fri, 10 Oct 2025 14:41:29 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B8DE83F91
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIxMCijaOHUA6gLeqAWvXxaDlAwfsVa/VOpFEiUSOLYQtCziUlzvU0ug+xypTbNAUAANNpGdE0+GHwjT8ksVUb/jXfIW+gI0UVovx2KfxoJdVbl8Gs295LGb6zlBWaKTPEWL3RYtXAD0uXq+SVsXukSfdBUGM3kcQP3TUUBhJ9wwbGX2MWyxKwUbCcQlQ380Aum+ZoktGy2ZHjNxEnuh1+WnopVtP6aaxVadJ5EyYiODlm/Hogn/6h7uRWGAuxm77TOCYGJUrxd/lrVKLT3I7StCJQN2PM9iK/7TKmYU2e1sYipZTciKpUxCBP7UFH1v6v0Z/XCtVRDjKrAatu2/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb1FTk4IPBk2iW3mYJLpE2jc3wdVXWLUGcepsyK7DhI=;
 b=RlAz7WaV9TKdIix0VRh2c4WHXYMmLrr2Boi7FlcXZshJDmVQpG/o+z+WnrbR34YiCM1P3oNL8RnzaLTc6bSxAl45dzFtvWGSoLp7z60fwPQZXfuJsXeudX0FThfsWs3WtwXTIAfyTBtGg25jsKkcRhQSHJi49C1axCHFlw6t7UllARE2Qsd57auTy1SotSfLjlGVYC51jdNphnFkDoLvBdbq7UMn262pTJf/WUuzQBaIrxWuvkkq5F/UGO18Cb3Z73gNa3nCeadFD6LnQWTTuqxsSbU7SYyTxm6I+ncBaCSLKTlvXsRiCeyVcd5E8XJB3/Ea3V1ZJaZdqRcYwbhKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb1FTk4IPBk2iW3mYJLpE2jc3wdVXWLUGcepsyK7DhI=;
 b=kYTGS2O3a2bljhZqAYAFRUfdbZxvsFBVmxTTbRRwGkZzMOYfXwv3pZqgQPZUVuj2Dt9D6GV/g+j8+BG+iiFnOChY7XukTkR5Lx04QxhUUlXdaFixZSPR8Q2cWDJtCHLpjWscFxrEt3C3ZvlLQIot9vW85+b7yvGnlzIG/OvUpDgRmhVLHOAN6WLZDqm4VJtDxakErWY/yMw0Nk2uaBT3f4t5CHpMB4DoJ5E3D1cmf3nKiBg+jXoEQdBFcsc8ttx06Pj5PWKkttRUY3B39x97b0+UEjAwUcvfal4k+EV3nk1X0tcVQddMQzCdiQ+IitYqo3y3/CTSBrB7oYVh3mJfAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6259.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 12:41:26 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:41:26 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 2/5] cmd: mtd: add nand_write_test command support
Date: Fri, 10 Oct 2025 15:41:12 +0300
Message-ID: <20251010124115.1545865-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010124115.1545865-1-mikhail.kshevetskiy@iopsys.eu>
References: <ef29354f-7d9d-4d28-b3f4-b31291e11dcb@gmx.de>
 <20251010124115.1545865-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007577.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3f8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 295e2c47-8720-42f1-b9e3-08de07fa53a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OUgst6hIvLawm2iOzw5jKDdHSDOzO79Cu02AePtKV7lyho4SLboFLfsTrYPQ?=
 =?us-ascii?Q?R9RnFb64b97/7+YIsu+9vUkrbfcNEmOxHM7Qg4HaEGQZiWt3qMh6Iv7+hCvs?=
 =?us-ascii?Q?u8sjYujoPcnKjUBCjfbBX17YPhuJx1Nb2gWtA5HZpNa6XDZmugMkyg7kQsmA?=
 =?us-ascii?Q?0Mgsy8WX4Dq36NVmSTPJJgQCpfVRj1hG6W+pZKulGDxjwsavWxe+kLVEeqQX?=
 =?us-ascii?Q?85l2aZYs3L6DPbZV47kvDjuTAFhMyDOd4XQ+fsGxUrMssyaijWqDiUnlLg7Z?=
 =?us-ascii?Q?oaLBt9rVBGDSAFDAdFK5PexlSc5b4i4ddS+ZbUI8V3FYDZZ+3WbffeCVWcTW?=
 =?us-ascii?Q?GB44YyDfolCmgG2llAQNV9Xz+uzpgrY+aJRwPon6CcgGo8uSyodYSo0t+LdJ?=
 =?us-ascii?Q?MBAfe9q0Hyg3ihSFBj5QqQRloBSTk/pKqPW3dXS0/gfprm0KPjMXi/2bwwJL?=
 =?us-ascii?Q?kHC4saCIPetxAK7kTsdDHky8T2hMfXW+U3KU8AMIicNZtJ+TacyfY+R7PbIc?=
 =?us-ascii?Q?EpaOdicyp8vFNeM1u42SKv0ITCo7sBiOyk099O7bWnbgrzhh0j4iWdEAYEeB?=
 =?us-ascii?Q?Kk2WTZyNOZq03dM02aHXnGGvikx65+ck49a2tAiJIWn0MLnjCEU0B34DHZbL?=
 =?us-ascii?Q?5B0ASExRnb7kYYKnDecY/+9JlH1lTleNL0LC4mfgZ4gUmSiIOs1mv4NAM0wy?=
 =?us-ascii?Q?tkhpyG6yy7g43V8BXvpCoxc7+1eZjQ8B5knW1+hs1xg16y8Cy4IZZgdxK6FG?=
 =?us-ascii?Q?3l84Z4/R0ixqqpbKvjQwFM2tJtu2VT8oF2lgnf/74JLyngaznPB1yO6+F3B8?=
 =?us-ascii?Q?PJxAmnEP+EoMyk1SHb1CJcfur1Sefh3fKB45Ah6eeX5G7qayXNuMJV7D44aN?=
 =?us-ascii?Q?x12EO8JvjgjJpyXItg1JRNZA3nJvWj+vw6JNBAHevwqd4CfXzobrtOgzV9+3?=
 =?us-ascii?Q?JwcYD+dOlTwoG/fnL10CCiMt6rakLT3C6UfzeVO0twbv+4LMfY+iPu63gIkZ?=
 =?us-ascii?Q?+b1+dytMP77W0KPZKnZhecziPraVDlnVe/K0EH8Ng44a0LNTayV0wryuWPMJ?=
 =?us-ascii?Q?NZuo9c7US4pfMOt/3eSkPmHuKGi19MtB4GNlhsls2Z3A4J5nHMcrXyC9CBPD?=
 =?us-ascii?Q?1K3pNxYSS+Dxnwfklp1BLpFIun1+7l7JQ6itqTvJjWecRQw/euokw6DbEar1?=
 =?us-ascii?Q?RtcwVQntKSpluUz5eeSVps4WTbtPaEMOSOqiFP+npE3/igNaBJWqiZFhqH75?=
 =?us-ascii?Q?1i9My+8zUvw7Zxqld3Uz55T4hIDcfnjraLJb05gaAlvj6uH1NGQlNFhtrSQQ?=
 =?us-ascii?Q?wCuUf9P/WeU0u/z/ctyur0cnO7q8srPFAdd0ueF/9GYlAbre+oBK5dspx76C?=
 =?us-ascii?Q?azJYcV9pvP8h3YEY25MZCwguGHwmll847RRaFEZHzWep4uDul5VvMnQp/KON?=
 =?us-ascii?Q?Il0ZjGfp/OjeBNk6+uOqH0LeH85ghPTt0/9g0+lEVif1wWahjjpIyVaSYUSe?=
 =?us-ascii?Q?gs3GtUDnhvS4qg96W1P2RCOeAlbNgHIzswcmbjcKSsm5b/w0fftUugkK0A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yTl5epjQmpEx/wF8aWGuy78qLEBMBGLqABO1YuvqcL8exKPk3QGZbDUU0I5z?=
 =?us-ascii?Q?ukvpUzW30KZNMoMrEblGZ1c98FOuCS5wOUvyrptlE0TbVXly9bcn3n4JSdFn?=
 =?us-ascii?Q?/K7EjnJs2qKT3+mBQcPSyoJ9TNZCZndImkS99F85UlJjOc9MLM+tiAGAPB2I?=
 =?us-ascii?Q?8SwLa86CJy8uwpTfsS0ME1dH/9PDY5PvQbCZDwJzJZkydiL1gP7eIZNz3UCD?=
 =?us-ascii?Q?t232br3KiRFIUDb5Tr5oH3ifb96sgqNIJXIQytaw11mHxmTON+KJcnNy3OBH?=
 =?us-ascii?Q?uv0673MJL0aI2NMgFx6rkuye7Q5dWyc9SJT3iE5hSwwE7PJoSUX1/5fQ0g45?=
 =?us-ascii?Q?FQGUYkqZZn+gXUepS1bPmAdscO0qafmvOa19ilgUUcFVUz8wv1Zze+codB4K?=
 =?us-ascii?Q?+UD/CdNbfrdMIJpMO/JClvxSuN9PgGdTjLhzyUAzbC9HvbvDKNVcs/x0qp6O?=
 =?us-ascii?Q?Y91SZt7QB2XsuLBzIqn0t9MdsyHPaym4ZAcXD72nmtoQU2Xmw+zdWxd4OzVF?=
 =?us-ascii?Q?ZDQXxEPwVPgNccx5PuZSJz/+IisUKT8BiVhdjjz1l/KOjB3dX9HZ+RedoUCF?=
 =?us-ascii?Q?FsYFqcWqR3hWVhH/wuSP2vsdx+OXtEQ2q7yXYvkh5Vsj0enYciLJc3FeOHPr?=
 =?us-ascii?Q?KmFe29snTk/mJ82qtmcgZRal80HgJmgbq5R6gEkoSIy1Wcivq+fSHHRmMl8O?=
 =?us-ascii?Q?jcPbI/9C9OnBDrv9zMMYw00vqQW5B6nyvspW8mnoC3G85ikMe0jRHW1iu4ba?=
 =?us-ascii?Q?UfN/Hix/Fw9JMmu9SkGAOeLUYf//IGYi0moO7Edhx27qNh4ZaoIFIymK6QfV?=
 =?us-ascii?Q?Rw1Iez/falvdQAVB4CGqnfISAjvnvvmJDMz4spTMvlePE+1ixlp71092IoIr?=
 =?us-ascii?Q?APW2N9BOqJ2z6Whnq43gHVAiT6B6Adw/86ONz3HDumMuC2A29lNrr3m/udGu?=
 =?us-ascii?Q?ANhaLjd6U+ERerbBE0sSLx248Mz7UTx5QPyUvfKgLetkG+lsPl+2KGStwJ7m?=
 =?us-ascii?Q?y8Fj48DXhAyR/RjWqovKhR9UYk4kzYWOCyfdHFZ9tqCGjRQSsnUSsNY7WAsP?=
 =?us-ascii?Q?ZgQH48kMx6gcrsxdAStx7rRUniusT0Fh51prUyxd4+ylEL1Q1W3ImBCktgJU?=
 =?us-ascii?Q?SseSOxxbYggWIM2OO3OHRYFLR6D6NKxMqwRy6He3ixf2/Ncgzy1JsSA84HYy?=
 =?us-ascii?Q?W4IJvx4wn/CMuuFAXnr+sg4znUqL+z/hdQSTzLIcMLeo2PI1mptGpHXz+uQf?=
 =?us-ascii?Q?Gdsv8dR11VXzIZ2lhIBUcRAUEwGIfZ8UJ1ZuewvH8OyJIPppC7hF1lAuOHux?=
 =?us-ascii?Q?3NdVsfPQGnPqPQVzmhe9swxDjmKhe1LNDxEsFyMniwcji5xuRFTT8SMjnKDT?=
 =?us-ascii?Q?rfm9FETap2zsTq3AH82cL0j8NpvlYsSNs4tknDTYl0v89UD+7Jhj2T4474Cv?=
 =?us-ascii?Q?jGdBEg9BTd13T9yKWErQKgAsmZ40HqDDi1xSX+KcKXZ+Z06M81EpOE8aXQBr?=
 =?us-ascii?Q?MiO7+yUnR2nOcAZLDcNuQGQALhVmEw0++9LVS+a51NYF1cA8QzXNnYWiPb/G?=
 =?us-ascii?Q?+SvBOoPVnlNjHBiLo5kwhcIJqzNbGRqarFHAmP/qH5ACPkXX+qrLJOZq6TvZ?=
 =?us-ascii?Q?qttquRaQH14fJBpejARSogY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 295e2c47-8720-42f1-b9e3-08de07fa53a5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:41:26.2081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvCSnRutaA6hFAeEIfR4i2+xPgUd413wWTMW+XrGvKvpevqfTWgxNREQy4FXLy/pb69+xMsrgHZfqqAmk5W/c0Z2WIpFqd9NBVuEr2KINQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6259
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

