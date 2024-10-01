Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DE6CF318A
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 23:00:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5767D88ED8;
	Wed,  2 Oct 2024 01:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Cpk8YhuC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B90C88975; Wed,  2 Oct 2024 01:00:25 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F56B88E1D
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 01:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2m9OaikvBEzDWB8esDeCvSVtviGKQsYW4PUVvWfXBftT7a4ieNMcZdNe4liAJPiMDdoWw1KNC7GLZVLnJFwy3lCvf4+ozu0ccYITq823qmLWLD91uYP9G/bUcdMiT99/aldXdXuDh7STMtu9++lhLSwpkzfN7HCifBHRT8k/p1mef/NGyellr43kPL/DMPFFaL+q94qEAgZEW9gjHGdt2gXJmcxjcKpj/5FjWg/Ub7x2wFNCyobzdKpOlubgjjYkowhT1eiTFoPm6qA5q8/iMrlr0ySVg/ZghDHy52UUYhiSRpaAa8CUc9yb1wNnXYukRg7COCnye2854y5h4d3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNgibGLWuOhXjAV7gStf3yF/e8WXthdlDYtyWpMTogc=;
 b=KI9Zmi4dw7a15OKx+N10cFeuuNMc5r56SGz2/J85KA11Z5cpnNNbPHI5UsIaIMLhuwxGT4enxsoFgHcpSUBxCbo/6cug0J+D190tXjV+sgN4/VuQLwGbIf36gW3M+ay2fCudtYMATAVehU28/LR943LSvkRLNVwg2oQLkLwu9TjLyPkhZXGeiGwb719EXoIAqfQ7bQcqMbGXZuGQcPwKCuTeO7bC4uPzZmEFaqSiM37fqpGJIGWy/2nazRpMuvFJdlAuT6YlbnnHz8jtBlxwVq9O1Tt44eZVvCMV3YA3T11wSXERfchDpE6z5BbNrU+/jY/Cir5ylogwHaYF9fuXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNgibGLWuOhXjAV7gStf3yF/e8WXthdlDYtyWpMTogc=;
 b=Cpk8YhuCQ3a+Zu/NKftoVZYLuB7h5sg7SUm29BBWUm6Qi5vaeIWwBj5ZKCh9OcZmWF0q7R0dM3sD1KaO1O7t853qzzuvTW/2+C8EziYFhRCnp+w+kkJJ/7yFKgt6fDu65ABfD6p7BoQKF+YgUnbVJXwEVr60aTGQTR95yfwC1SrmP5VwtsMHoFKsGe2TfS7fiq0gc5us2V1BQMDyjY7LiO6TmFt8jKrOorYhuaqzDVJ5tJJaCvzn+MNka0tVvqEOj/6u1YZkautobDxmI1wbxlBB+oTJal+zWhN4vvfGnbDK+Q4tRuWs86Iyj7vQEzURdvGDSSAbXT0Soe97WyeCEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6271.eurprd08.prod.outlook.com (2603:10a6:102:eb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 23:00:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 23:00:19 +0000
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
Subject: [PATCH v3 1/3] cmd: mtd: add markbad command support
Date: Wed,  2 Oct 2024 02:00:09 +0300
Message-ID: <20241001230011.954429-2-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 420c8650-ebbd-438f-261a-08dce26cd260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZZGCOvkCCNdW7RmID6e3JE8vF/9IZ9ykl0yCM8WEvyrQL99bJS/NHdkBCZ6F?=
 =?us-ascii?Q?SbT3uLVyi+XMCUcxz1h2RvU+RT1M2FHwXoCuHMrMVzFAOmnrO0XxNbC32LsB?=
 =?us-ascii?Q?7gEL31y3NiE3cbjGtWWkU1UZKFfsFyJSb1WVgbO386LRfPkbQygKu01ivc6N?=
 =?us-ascii?Q?xCIoO47c3geS9FFtpY0Aqt8TcVQp2YhcDziSG7Y9K9MJBjy1tG1GpVOrF5ZM?=
 =?us-ascii?Q?jQ5SUuIpfr2/eUPVk1N9dYEMGIbcmykIaJjr2jvmScf2qEPh6ck7WLAt8pNN?=
 =?us-ascii?Q?XY+KUw/w5hxLLyz1lIkKzDlNsRf5OVSYDplFxGJHS4hxpd33MrC80bqNBgBq?=
 =?us-ascii?Q?FVLgig9ktDKfks6JC8FIJ7Jws1FuoQ4zsJc4g1oV8UiYy/gBMJj0YvXeYy3X?=
 =?us-ascii?Q?w+8LJ6f/rvE0esajJTmJxcYDkP3Rf3ZrAP2I/NoFtB1BBEyYtwhs6qbb2M+U?=
 =?us-ascii?Q?YqFFlxvzShguc9xCXdlik7PyTQdl2oPdNmxInh+pKIuSO4WOy+a8gk4Zhx49?=
 =?us-ascii?Q?4d+UU1GXpRdnSL2R1xZXGkVkkXWp5PojSdUU8YyQP3BmTTLlKax3hH00BcXh?=
 =?us-ascii?Q?bZgtoByas5D+Z166vvDAsp5+vms2tl1nOUP758jnPiWh9z8gH5cQeTMnWcUi?=
 =?us-ascii?Q?8G3hOLIcJSMDbxGd74d964TYV9RFrUv2G0MrMFD1JEW7qpAf53ELZ7KtU5B1?=
 =?us-ascii?Q?FRCyGcpChBEGPln8hOh3bysXXtbswOCNDFHnlh18wzLH3LKDPLBy35a1WAOl?=
 =?us-ascii?Q?cq0RTwV7+0Y7gzXEJmYUrQkhaWPuWotiC6Jatfn+nCDMZTcQoC80kzsVir7+?=
 =?us-ascii?Q?xpMgHc84kOVdVTuOd3TI3l9wTS8riBCHNMXCQBToDiCr+CWxOfjRJB2PaUXY?=
 =?us-ascii?Q?5cCKDJuNCTJ0/K1LgnAbyKFN4p8KX5tL/cMVPQbBCJqEOPV700PivcjCru65?=
 =?us-ascii?Q?5bQdnZAw6H0GSDiQWFv4uE1yO9kmyOMYdenOmy5yyvWBW1rzQU3pdUnTWnXo?=
 =?us-ascii?Q?438KF58aENvVbitItbrZrbx4MwK/SRN/Cc1U2jfIkCNx1UXspSRqFAF0L+Xq?=
 =?us-ascii?Q?k5ehbu6/RiFM0aeYn9no8MTqa8ef7Hiomxio6GCEqOOkURMfiXud/aDJbvtG?=
 =?us-ascii?Q?1KOcq6wMjnZhKfOovO8auOU0wvS6DYYKLcp2X31V9b7Eur3xK2JhKEpzLG/w?=
 =?us-ascii?Q?icXPYG0lOMOnggTVsNV+4JSMu0qjj7oyfmfveJRMiv1dw7AWcR/ykmzHHhwU?=
 =?us-ascii?Q?kTs/LoNnAEDEqPHihz/6KDrwyNp4pzBm1oGwVuq9CMJ2LxqzuAkLygbp7RpR?=
 =?us-ascii?Q?vuHM0dqCdkSevDBPF1BtT2BD2fkR5ClVFKv09bQ9Ml9MNEt3fWmKRP+eHBFq?=
 =?us-ascii?Q?+vS/9xs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?igiEH4ERYIm7eG7EHPRxXzp4LNeGbMSCBcst+iYX6GhdH4hJFdC70tB6JLLE?=
 =?us-ascii?Q?4ZYlCefsWdRFhXYkykGlKNoDonfQ8XNeZ4ipX/fGUZohfIPMMTwOfTfhYBKC?=
 =?us-ascii?Q?uuJaiWW7NmESJhPZUwH71pQLASE1kvzYMCofQvX6hRtJeW1fgQmE0hjkU31I?=
 =?us-ascii?Q?gBalNkwuiVNe+vD+x+8RrDlafopVQRng+wz76QU7FpRmOl9BpVf/4PGslQ5E?=
 =?us-ascii?Q?X7NAimolxfCfe11W2RJPSQkGCp3HJBZiZ34CHdI8LSHDXGyu8KlntfnS1mVL?=
 =?us-ascii?Q?DjpJ/GRyxdjjHWCFATWORGVo1eHCfDb6xJdoZhL5wGiz5DzjxJ+wcOwhep56?=
 =?us-ascii?Q?IOh5HH+oJnvjBT05+yTMH0bzHMkxnvZ+64MFS+25FXJKG3ZMgYasAfpFuOEB?=
 =?us-ascii?Q?2fhG+pX7rocMS4eIo06we7ymyujyPmavtb9Go30UgIvpx2saX29W4NpuBWzq?=
 =?us-ascii?Q?qR97XTmj+cNKdiX4E3Skrnfw/FjWeP1J648usIYk+FZqg7ETMjpy1QykMZED?=
 =?us-ascii?Q?zmolkiNas6IbF6FrIf+bIL9bd+1z9TbhMcUgBJUgvqP6s/0hveYZswgMGF4R?=
 =?us-ascii?Q?n9k2sB4cg3Kke6BJZNC7H0WeVkw0579N8fnh3t7jrdu9FUTM2vguv41r9Uj0?=
 =?us-ascii?Q?ZqtmVs+34PMg7WVLPZWZaF1mKFIiQn7BFjopSywscFRzlfOxz8as1h5xHUQC?=
 =?us-ascii?Q?7q/xGJoj1TqP/oYLASgc7OopMJgiLNxrjewDU7GCiJxpU/UIF1Q6wi0ec00D?=
 =?us-ascii?Q?UPFjYO/CM5Vk+lwlrSYmrj7irLGFo8uvDFwLFFp0pzjjITRMGoh8msZlFmqg?=
 =?us-ascii?Q?wGfc3tZNdq3C1+/+W3XZemPEJ83tMSqOd3CM5moMZ3jI906sqEoJz111t/ts?=
 =?us-ascii?Q?b1b9+JwuZLi47B5JrYq3NKljXRgFnbhObhhWE/XA5MZseSHM4d/7fmrc/7JD?=
 =?us-ascii?Q?GaS7S5aQJDDAQ0qTAMyOP+MZcXDxDJpq/Z8YRyRnRPmrdibpv4X7JmXDf5R3?=
 =?us-ascii?Q?bn7mq0l5jbdYErAPyo9ArShxzSazkbnbZ0tsFi4zvjt47HUOM17jAK5xPZOD?=
 =?us-ascii?Q?i39FB6dgG7KV3KpBcZq7jNW9XxA3jqynQSdulmXMa8m6IF0hLbEKbTrSU4o5?=
 =?us-ascii?Q?g/a459q3Wcv8rg5SRFcP2+43tFyeDK8dj1v5o5yBX/PYo+tBPGJXBVOAlQjC?=
 =?us-ascii?Q?3gMsZTSFG9LwnTmt/XQB5+PeQN5vYOABxhh1pf8Ud5D03eZcNoK6FZl7luQq?=
 =?us-ascii?Q?vovbNn3/If4BVdv5tUpIrQYjZsE1sM8f6A396ICzq+6BFYroT5BrE5jnMTDI?=
 =?us-ascii?Q?Yy7pfUfo+ojevUp04WeOsZEY3xCKTdYngey5nEpZt0Rc6C/s907L0/tu/gR4?=
 =?us-ascii?Q?cepYpHbBdqmboH9J5lhooyp/6jx1Aq43zxsA47pf0J/qUkh6wqjlaUOFutkx?=
 =?us-ascii?Q?GHwIC/sDrPmJHPUAa2sS1vuBQLs4OuFBnmL5AJS4wTN5vLvyWEL1xWBfm2eU?=
 =?us-ascii?Q?mUjGoIhuVEqWFLhKf7qtl0FBnXGcOAFtMEDBKTGOu4VGwh+CmL26OJWvopFE?=
 =?us-ascii?Q?112l39CZgYSUzxkwrweUKmmhYPFJTMmIABDcEjRhIXro1N+2ZYbccHDaeg04?=
 =?us-ascii?Q?0JNF98xBMwHCSbu/BeUByP0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 420c8650-ebbd-438f-261a-08dce26cd260
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 23:00:19.5483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9qZWCJ/p25czB8Gbp0x/aZHg5+chbWzRIcvO2iffzhnvCJu/DcdC/pjrLZyW/+HRXVsvOikDwItbXLhpMWPGaEegQ+ODkZ1Vv+RE5J5SO0=
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

This patch implements 'nand markbad' functionality for mtd command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  8 ++++++++
 cmd/mtd.c   | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5ef3c8a8748..e830b731d24 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1449,6 +1449,14 @@ config CMD_MTD_OTP
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
index 795aaa2b37d..45084d39d3a 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -691,6 +691,57 @@ out_put_mtd:
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
@@ -773,6 +824,9 @@ U_BOOT_LONGHELP(mtd,
 	"mtd otpwrite                          <name> <off> <hex string>\n"
 	"mtd otplock                           <name> <off> <size>\n"
 	"mtd otpinfo                           <name> [u|f]\n"
+#endif
+#ifdef CONFIG_CMD_MTD_MARKBAD
+	"mtd markbad                           <name>         <off> [<off> ...]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -807,5 +861,9 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 					     mtd_name_complete),
 		U_BOOT_SUBCMD_MKENT_COMPLETE(erase, 4, 0, do_mtd_erase,
 					     mtd_name_complete),
+#ifdef CONFIG_CMD_MTD_MARKBAD
+		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
+					     mtd_name_complete),
+#endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.45.2

