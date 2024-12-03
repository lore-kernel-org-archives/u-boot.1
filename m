Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B854E77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D7788967D;
	Wed,  4 Dec 2024 00:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="1xTVnTz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E08FE8931C; Wed,  4 Dec 2024 00:06:03 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAB498964A
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfWXVo9jUaZs/TRdWJAAk12qZmTmKdfbDRdquu6uR27beuuhdEwPsPPkHaVce8Wrsc/Rmyu2R3q4YbjpIZsJ1C61AtCN6ZyGkRsRqEC4Ybg9K8qIGwnrVTXTLIgE3GB2BATyYkCNgOC3eJaQe7E7l7L9lOyaBrLa2asK2pfIX/h6iF6XAlMZ9A3KSmKj1GcJZYFQAtgjKGAZbRdbstUAbC6fuYtfOZgUMBGHH3rnqcj4++Ya1yw6SuqXo60AqLO4AHVLg2KjvIUKWWiV/1mJq3+Irz8D634tmyHHsddp1WB9n4oCdT83s6HM+kZuHbgcZMrupivWkM2gEpJyH9eTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TishTVxCGC+21RIvuNdd0Ay6cgr3Qt8qnLTquBFkN5w=;
 b=uLAaUzDppzogunt7Gc9FozCkt5f0ebr6r77DH7sIKrX8V9N616icC0jHW9VGO21r/RhfPYskqikd52BfnB1vFt97pDWJugvxVLzOiBixGCVnSRxHTumL6SC5HKKl1uYmwhLx4sfCzy6LAJlgLqho95cZuXXEGAEfTv8eznhOxIJFCyuqkXrkKxRiZ9m6LG70uhUnKWYIHy0JLQqBWrjahyUUAkPaQLP38sE97Z6zefosAXRIU6UqSWftGVeOdSiBU1FaebHtnGM0IxWXf9w498brAdL6L/QqjpTx/I9qIgCVrES3nflT2ZUM0sDk17OHPYH5GjIGDgSOKebt/NK9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TishTVxCGC+21RIvuNdd0Ay6cgr3Qt8qnLTquBFkN5w=;
 b=1xTVnTz0cRRWNi5w6H0qYJy65K7kLzWW+8U+8ESU8nCodaTy+5+wpq0vTxQTj7UoTyLFyj5sEaoY4p9aLY1WgiFPAtzfh1E8VZLkvhvJYIs8OrfFxKzJJoxQkR7U3uuZooUThlSpgOHSGYwo1h6Jca1sVsirQs2PZHahXVisw2UuXhrZkxx+LnwftkBu6gXhPFmF8DQXzX7A1tk8WU+yXYkLuApdAjO7eKfOsJd9ok9IV/m35F8psKDhnKUOFZvzIZMdjerd1makF70j5MbS/9bfsJweCfR6wHabzb7efsvvZbKDY/XjvAsaiK/k41Av15VjymbHluPGJu+LFrAbJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6066.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 23:06:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:06:00 +0000
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
Subject: [RESEND v4 1/3] cmd: mtd: add markbad command support
Date: Wed,  4 Dec 2024 02:05:49 +0300
Message-ID: <20241203230551.2677602-2-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 809bd1d0-b0d9-4595-9fd2-08dd13ef0d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hy5j83HT5BeYX4sfhFiXQ7lt3Gg7t7q5zDWW5qcK+hyrcF0yVhztuMMEHmkZ?=
 =?us-ascii?Q?wwtYi7X76XBKTGkOB9x3yedERmDetl8a4LQRYp3MFWEzecBu8/GSrK8XnlpB?=
 =?us-ascii?Q?QD4SAPYWAfAo3hZqTCKOTsazAQ8MBKXG+APWi6E4nCohNXdMy/E4h105pzIy?=
 =?us-ascii?Q?ducuFDE/pFsLc/04sUgtBfgTGEP3f740I8tfdaOY/ZJI+/OxqYSmb4uUkO/y?=
 =?us-ascii?Q?/fDi6g7p47A9Gkvp2O91UBzbfw1NwUD/diIX9g+etk5prYSIQ/m/3kxImuBY?=
 =?us-ascii?Q?UoqMjM0b9lW6udL4Vc5DZ9LoDLTENXoo8VO9elKk+MEtXNn0xbwZPzutCSCT?=
 =?us-ascii?Q?Gn+SZY8PGV86zsrC0CGr1x7BLhxxM4Cb+cg7kDY93OHiZ3PnlHHjtfGwLYvY?=
 =?us-ascii?Q?bYXkyqruwZMsGjwt7tKLmecIPlFDIV/GIYaAwknpbEqZaBRDrOsNKq8W+m77?=
 =?us-ascii?Q?ABq4mDymqR209oYV5491ACUS5puIFMXg0DMx2ZlLBNMdNFF99ACLI6e+xji5?=
 =?us-ascii?Q?cVhTW74O8uNNtkDxyvxBX0VVQtMuBMirbp7HJNPCUIrawckU+zn8ICZA7zkj?=
 =?us-ascii?Q?C8hHj/5zWev+CQwnBNT/EWmOoDjFZYajn8K7FRBGUXJVUNMoBsEPArSjo1Vs?=
 =?us-ascii?Q?kKk/uszjmk+z9Ota59FMLf8ZQG7USV41cnI1aJDBmis/icKpR9JqkrkMlCyQ?=
 =?us-ascii?Q?jI3TisAyujrvqv6OR+hGLGD1dZo8m2OgBmCTLZH/KDL4qN2wBzDNbx1tfnQT?=
 =?us-ascii?Q?8EVdzMofFkSYkYEU+31DymYndd39ruFLaOvLStDpqLSGM++qkBCz4x74EUXs?=
 =?us-ascii?Q?rJu2S1jAtQhJE2h86uXRUnB0eYAyv6z2sGufcNupzl9id3wt/3vDI0YHOA7D?=
 =?us-ascii?Q?xmMRT0R5QnmgWEpIKyxMGrcm4EiO+zv9Hfw4sYQC3B/A881XC62nVpRYTnsq?=
 =?us-ascii?Q?wlPssPf131BKA90F7HQYX6uY8xrfENqlZRxHiR1cuXpVg39s3I/KEMGmPNAv?=
 =?us-ascii?Q?jzqXQ0mR7u2qF6tEjaJNEnKzjN5ut6unFq2byIkhZEcPCMkLjxPnhyrpkGhg?=
 =?us-ascii?Q?syaXMmh/JZN4FPHLhRokKEcwd7fFCZfu8XuxTGxXAnNrhWx0+n3LGCHrgHag?=
 =?us-ascii?Q?csim0NPd7NZ3wgWYCrCLOZp4PsYuvOfUuXaPAmNErFf+W8vNFpTES6DJ9Mef?=
 =?us-ascii?Q?lIvhiGiNeKqdN8ZBr2r1tpywzlsEpmPQjZSphIepjALL+smH62naJGBt40Nc?=
 =?us-ascii?Q?hVl7AQdMJPdxqjKS4LN6YUgSLQw9zVJ0e5kN84NQSzYkjQqVE4a4utOrpxqC?=
 =?us-ascii?Q?BXrn0HPW6iyy2uXovho+F3VmlqewWL5QmCHaKJCIubB6ZhASCVOJbXagxjp9?=
 =?us-ascii?Q?rz69MxkTPtes2OMuStaR0wz/A2F8IPYooGU43anru9QdxAgeiFT2oa2phkLj?=
 =?us-ascii?Q?XN0Ztm2ouR0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r0ZzFzk5QiimKFztIGhaqwzDfbuabO9MzSgXzjg+HozEstX3QMUZ6GgS1Iry?=
 =?us-ascii?Q?u+7T2C2jlB0LES77zDloL5uXk8ZxHIpDfeaqAGNZF2ZhtCusoonKXLYH2yZj?=
 =?us-ascii?Q?MM6bXG+d+1e5QjtttbaeGJ/41dzhufRc1UzaI59ADbmQA3smVnd0EjR9WFCn?=
 =?us-ascii?Q?kP+itd3RBr5m+NCCci6H38OkrvNHHy8SrgChZtxDvtuzh9+QgsHVGi0AQngD?=
 =?us-ascii?Q?xsDX3hhRtS4SHCTYB0LCWi/9folRftXi2vpxkeBurIDekRGvccOTOuwYqHyU?=
 =?us-ascii?Q?aGKEZB2xts9ibvkfSKTCpB8avxFLxyntO9ZA/tYJhKNUgvZAeMKvdOr6ycuP?=
 =?us-ascii?Q?4S9+iQIAhI58m/bJLRt+qHRGYl2SgahUCPqndXoEhVMuOTGzAzfktPQeqsLG?=
 =?us-ascii?Q?Kl8jP49SAz1FtVXpp8J5LJzyV7hPXZKByid4PRxZHXlX6NwcM1nyfwvAhSQC?=
 =?us-ascii?Q?v3M/znK5UtVC39Og7aNaHxue23ubRBOwzU0Iio0QMe51HeLkA8P6Hcnen3Eg?=
 =?us-ascii?Q?MF8S4UYGhWUis9LMHPQBMMjVYNP/JKo3BrVF5pwQrVJvKJYWTwe3Nox/4J6e?=
 =?us-ascii?Q?ng1PZmEjZHZltRbxJbSwPIHcVad214RPB2FwqCp7stRiG0JXEmaGh0NkovUk?=
 =?us-ascii?Q?R6J4n/gBeSX9/Vby0qFQJ6yendH8WMKOcT/n+n7u+MbuTgKvQAqfurLS5zMG?=
 =?us-ascii?Q?wwuwM6ltAM98kZcwN0kRw2ONIN7mqC7kHqnOC25GFTETHMYN8LhbSOg6hG+Z?=
 =?us-ascii?Q?EzMkDcifBrRF/zYth9t1VAGiaAL2nmjg14QHxd9Pdx+7YlWrfrKnzauJdF9y?=
 =?us-ascii?Q?ku58JTmK4XAOJREKgP2hJdzrgT3yePHBpmF4ZO0PALqyG9juoGobAgetfBRE?=
 =?us-ascii?Q?37Axr40t0v5l4fVNt1vNL/cnnkeRaDhW1lRMkfD2stbtWknVT0Cg+aO9pKUy?=
 =?us-ascii?Q?9VbEaW8/fq0lM4WLccSEin2ZCfYkr8FPJmgSCOGiGC2Qhwrfh9BJ+QCqfEyL?=
 =?us-ascii?Q?NL5haPeJ5N1Cr2YSaGYslUGc4Nq8LhWRD0MepniiIUFH6koXuRu8toE/VRwB?=
 =?us-ascii?Q?nPQ5vatvJVwTomJ1Cg3rEQe/n82rRWfWb8ZbA/9b78d79qj88Rcz5swhw/so?=
 =?us-ascii?Q?SEfnra2QUA81+cPcNyUQ01ql9VLCAWarr5cWp+W8jwB2QGtSFFN9dUEUqQME?=
 =?us-ascii?Q?QzGfIxcBCbb1GnZxP6WBDpR7YD0qnsWz6Vsdw8aYLXOqrH5ZpGPbgtJ9i1xV?=
 =?us-ascii?Q?ce8oiXe5LhwK1THB2TWajTQ501Tu0qREJog4SyyK9c9lXjZhELYLIi3jrRAg?=
 =?us-ascii?Q?epcwm5gCWxKB61OE6n3SDEjW+PFbmOQ96U8zFM2Tdby/pvvWmuhq5uimCKLL?=
 =?us-ascii?Q?bJgDxOUCNjkcDJrDQThEBxItKK1aug5KSMnaaHFvR5uqeW6oC0EeZ4iehO8E?=
 =?us-ascii?Q?Skfj3cClUuBEGocmAVt8Ho7aI30TYHq1Cr9Cw8z9IGn7GNInSYEatuX83JBs?=
 =?us-ascii?Q?kV4+RBA6Yi2LbpA7AvTE+FjyyGQBWBj/XzR3sRGiCHHKsyHfAbqg+rODmoiB?=
 =?us-ascii?Q?Jv2/Oc8KgVFbdqsTBnDAV7XtfxBGZdEC2EuJoKsxKoM+33i9ct/Qk5dgVEFB?=
 =?us-ascii?Q?8FR4UITfIDgjUffN5nZpRFc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 809bd1d0-b0d9-4595-9fd2-08dd13ef0d97
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:06:00.4352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +S0SvGv9BNZBiUTBJ97MizgHJr0lNYl/GpE8j03cj5A4INKebRjldevfWhjPwe8h7LInbGzJ4iRHR7D6Los6VFK7Pwt/mNH+y4zwDLqIPTU=
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

This patch implements 'nand markbad' functionality for mtd command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  8 ++++++++
 cmd/mtd.c   | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 1d7ddb4ed36..6909ed476ba 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1460,6 +1460,14 @@ config CMD_MTD_OTP
 	help
 	  MTD commands for OTP access.
 
+config CMD_MTD_MARKBAD
+	bool "mtd markbad"
+	depends on CMD_MTD
+	help
+	  MTD markbad command support.
+
+	  This is a clone of "nand markbad" command, but for 'mtd' subsystem.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index f178d7bea61..bf08f483c14 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -700,6 +700,57 @@ out_put_mtd:
 	return ret;
 }
 
+#ifdef CONFIG_CMD_MTD_MARKBAD
+static int do_mtd_markbad(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	struct mtd_info *mtd;
+	loff_t off;
+	int ret = 0;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can have bad blocks\n");
+		goto out_put_mtd;
+	}
+
+	argc -= 2;
+	argv += 2;
+	while (argc > 0) {
+		off = hextoul(argv[0], NULL);
+		if (!mtd_is_aligned_with_block_size(mtd, off)) {
+			printf("Offset not aligned with a block (0x%x)\n",
+			       mtd->erasesize);
+			ret = CMD_RET_FAILURE;
+			goto out_put_mtd;
+		}
+
+		ret = mtd_block_markbad(mtd, off);
+		if (ret) {
+			printf("block 0x%08llx NOT marked as bad! ERROR %d\n",
+			       off, ret);
+			ret = CMD_RET_FAILURE;
+		} else {
+			printf("block 0x%08llx successfully marked as bad\n",
+			       off);
+		}
+		--argc;
+		++argv;
+	}
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
@@ -782,6 +833,9 @@ U_BOOT_LONGHELP(mtd,
 	"mtd otpwrite                          <name> <off> <hex string>\n"
 	"mtd otplock                           <name> <off> <size>\n"
 	"mtd otpinfo                           <name> [u|f]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
+	"mtd markbad                           <name>         <off> [<off> ...]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -816,5 +870,9 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 					     mtd_name_complete),
 		U_BOOT_SUBCMD_MKENT_COMPLETE(erase, 4, 0, do_mtd_erase,
 					     mtd_name_complete),
+#if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
+					     mtd_name_complete),
+#endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.45.2

