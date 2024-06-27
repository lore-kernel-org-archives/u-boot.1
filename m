Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7216EC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E816887AD2;
	Thu, 27 Jun 2024 13:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="xBFPzhPx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CEFB8852C; Thu, 27 Jun 2024 13:27:04 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC9CD87AD2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7tuqZ592zLEZA2SCR2E3itfXXwkr5flsJ8jm77YHk15qc83S6Zd3z3iAR6p0Ij0/TsLpl1e74BUgEY8Ras3kz6zy/53/irmJuaJUeZARvCpANkkG63neuAyK5IMmCKL2j+FI6MaiqdEtr6VSafVS/cIm2Rxt7gcq2Mg2exp4SrDPkL7IABog9mJ5okYuUhlCvVmnvIF8DOj+wJnOgFVG3Qp2ilKfIeLgmEZmI6jXXdnOgHhoWQ6l2bMtKkQ9+23RZIsldDCbzTFvI87MO0rPCqynXFvM7sjWl04Sfg9Klk69DoS+NiY3X9ZYsGLJzfQWstgHdw2XIkQ4Jb/76Zolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuxfmHWenjVEUkqI0ZFks2xajb3YU376d+R5XBJAEF0=;
 b=PnbHkx0h9k5pOGXFoq9dzrspYFDYBSDDWXJju59RVKpyLdutcH1tk7OaYMm0n78/ornqCJpzg8SRIqMPbJxSd3J5mJM4NGeeGdpKrwRY4keNOuwU4LnQPFHEnTkqvQ86wUgFT//OjCKkyQ2CmewURrN13vXHPfyZmvwGt3f+vf5qzyiR2Hi/cECQ6XgHV+EvynV7WFljBbPVbd0gZ3HAkIHroewNiJnFBRSmGsbKZoCRTVOWmu/jLwpVuCbMpEBF00ldcmpVpw7PMGJ4qjJr37ZX3dLu3q4Z5cvpfsRjsKImUtQdB8Dd8DIwGC6ktjOQSVtRQiJLuP+hjDcWi5TMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuxfmHWenjVEUkqI0ZFks2xajb3YU376d+R5XBJAEF0=;
 b=xBFPzhPxBNX0m+SaybJ7sCqC5dLVwUS+A3VyBw8R5k9MiSWGTqBjKVKjgA3u72O6koycLViQodUdH+VCmfLUlHaNYdlOjILQoLe4HYKKzeQ0ZEM9HuwgGQP3BDMqril4C+iCJavFilRi9+FDvgdowlzupnpLQXykf89UEp6tomq2wSqUxcSj/2KgY2FOd/TchAErL7i/waZxHT2yhqK8IY0r2P/OEgJB2m4fQZeoNeWnWykprIIVwbrjwrZJbcZDT7Fe/Tj/r6pjfRSRz04/JnFJqHwU9D4vvfZJ9t7P5hRt8+px2jR5f46PNMD5/Gg23fZ2C6HpEJqQ2qQn/A42pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6431.eurprd08.prod.outlook.com (2603:10a6:102:157::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 11:27:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:27:00 +0000
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
Subject: [PATCH 1/3] cmd: mtd: add markbad command support
Date: Thu, 27 Jun 2024 14:26:50 +0300
Message-ID: <20240627112652.99818-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d12302-83e0-494e-ae6d-08dc969c0f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FgvAJYPVu/8be1dp1GS26W+k77knm86QvgukCMkvdERjqtjeLWVucqAGH6jf?=
 =?us-ascii?Q?Mhk2672K7xETJXEiXoh/LpghSjN9Ue9NkZf4NO4TfWRNpUkkg20pdBZxv4EC?=
 =?us-ascii?Q?5IRkcDDH8Q/l3vgX8n7/uU0kML5LF7cYhaH9Pf56KhG3tr3Z85odr1+Ugf9H?=
 =?us-ascii?Q?VR3D8RL0sZFGsKqcpRuGBdRfjLMThM6QEiGpDga0lKTwRSGsp4pXLfRNOZrf?=
 =?us-ascii?Q?3X0MmJIIxy9/zEmIWqxGua0GVtJVXVCqStc77cesq1POy08R6Ng70pcPcAhB?=
 =?us-ascii?Q?1XRMvO7sjtMy/YHEK0sI8VCiUam0FA3mwWsTI3reW4g5QY3vJvo6Ffl7emyX?=
 =?us-ascii?Q?sFDu5E3H7ICEewWptR4dUaM7LmEfJZL4fU2KJbhHrz8SXKjDh6ScJhupbojM?=
 =?us-ascii?Q?W3zAO/UdO68A1zVlAO8zohYxIOtApkce2NL971HDvpHLLOvyRD5n2asJrCpT?=
 =?us-ascii?Q?TTgC6R0g+6CtVk/wBCEiFsNMAlI+i7JTay9X3Ht50Nid3MW7kD3aH58DPhSi?=
 =?us-ascii?Q?Zi0g8V6hZlp/n1KkCcmF95fyCXb+1dtz5QkNOLM8ufFNt4mu0cPfUKoNF1wu?=
 =?us-ascii?Q?pZWsCIvBy8FXg1GldOjzAGVIQ9f+ISRiogMhpLE4yV5tCqcenRqL7Y5/MuhA?=
 =?us-ascii?Q?NqKgiCjeq9XLyMtUizGaRurBef5JJo9+qnkWjduTjCbna8lg/hthO0uFb2IA?=
 =?us-ascii?Q?Dk5UywzUQGB42r1dSEhV8QHtwbNhcy4SXqBFyYYqxLWfXWZv7tMey/IJSreG?=
 =?us-ascii?Q?oKW56nL2ZZQsmgJ/HekALDGSuJ57xku0XkdDcNZjZmme8GKH/O3/mzgdx1HC?=
 =?us-ascii?Q?GddKx8otgUiUScyqCmI1lqvHbaCIWtrleEUhYzn/9nf5ROvBq1tqqirgfPCr?=
 =?us-ascii?Q?MMATb/enbtqZ1YbfkRXtMoWo2GZbEOD5eN9kOf+4o5wS7sS+9oshov7XL+C1?=
 =?us-ascii?Q?ylb8do4LO2zL9VwjrgQEIHtBgmbNoX1jJIUNo9+S6i96WKDdlyFMKLQG5EkO?=
 =?us-ascii?Q?d2FDIWpB8zBI8OywFH2/1ipYh9+ZMM2zlzJG3joA6eXU+06aGg+CZOaaP92Y?=
 =?us-ascii?Q?7f3HF7XJfCOLUKZIqdcVES2SaZEhbAEcc9IL98EYytOF1Ufh6Z7TfVM395BB?=
 =?us-ascii?Q?W/VHCz/xbK+7lzNOGFavGbic07bVmOCI7ykAFJutMb/1gUlf3rvLrlN+sGus?=
 =?us-ascii?Q?l8kmYbYivx6y4FcUXUpeZbUonNyeoq6oqtwaGixysmRJ0aPEsnGLllGLhBnU?=
 =?us-ascii?Q?nOrI7jSb7r7vnt+yrh9LUGEopIR+LmFmyntAxmZXusXv3x/CNxZ8ra2I7ZYX?=
 =?us-ascii?Q?zqAOSUX0o+bFaGkinufqbFTuORpZfgSgbaNB+M1PAoi3Pmb8m//hsdgH0PNE?=
 =?us-ascii?Q?laf0b9+WjnUTIISE7FhFAzl8lqqM70s1oSfJT8KRXlmsK5G6ODhnroyozssX?=
 =?us-ascii?Q?ehl6naA3Z3k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9NlExFtB7trWLSejBucWI0kTe/OEyNnKFRZOnqUBGAZpf3tp+t9ePdub0eSW?=
 =?us-ascii?Q?qrzDgfAktr87AWeEfQMefLdsv7egHFRpc5cSSHIrg0iH7DeuuVb5Kc5hr5Nq?=
 =?us-ascii?Q?i2CHmfB+gKd3pr3PNml/moHvse4KvA0wNaLyPXrcbl5ZMzNBpSydNSf6L+wb?=
 =?us-ascii?Q?Vcob9oBh5LdEMqEmN1hprr0XFzI7t/uXutKTZAK/aoMWspAR8oNUZFVBOHDM?=
 =?us-ascii?Q?QEBuUtR04c+8heGG6dM/A9wSxE2JHmGtD6hJq+bK5z+gY3e9GuK4r+Wzaqof?=
 =?us-ascii?Q?DzGz9lBvdTl6ROKhvnRsc2dMyNpdfkabya553mRpBJhwCP/FchaRIDQdCHpR?=
 =?us-ascii?Q?OEN1DAc82X9itXuZVwPkGcuALHs7TfNeoprIbtRoFEPHB9N3tGkXnCmdlw7p?=
 =?us-ascii?Q?cZvSCXnM23zrlgYiUHq4SVxjYfiP1jJEQ81DRiH+L8Rj5g0ohI4u267S7kie?=
 =?us-ascii?Q?eVsA8/2P+H/Iw62dqEdSL6HFyq25lipKoyoxZclbuqTUpDb7I7ZlIsGE41JJ?=
 =?us-ascii?Q?4cAcehnPwnjibIAW+j2fuqX6ZiV7rX2HrJ+3vRfvk2W4or8CyipKHkJrdZNi?=
 =?us-ascii?Q?9VTMMGrMtYOqFzcB6iI2DsRp6EWSMklhKdUN9BarteikE/JxrhpzjwsJLkpk?=
 =?us-ascii?Q?xnaPpPjV8OfgVcqG21E8Zay1mv+J58YdhAUVWGaUDCZ+rZmXaX5YhJ5izNar?=
 =?us-ascii?Q?6qeqhmiOMYNnfSnaK9Sd1UCKS1OQyhZCXZWvHY1IDvIDNlx9PjAFBD+8hpL0?=
 =?us-ascii?Q?4lyFb4rcJs/5IlXLUiRu05LpwZLxHVYUc9X/zzHLwSYsJrE7M5rq0Y/tPHg5?=
 =?us-ascii?Q?IP5q78lhya7cWGlMiRCmriROzgzxMXTxOXJNHQKDlDRNyHZDiR4MdQxbFRGV?=
 =?us-ascii?Q?Z2/PrTwR8sW264VO7JJVf5saNEtR3oiwfEq+XzMFKDmZkcnSSkT6zantwj7p?=
 =?us-ascii?Q?1i6HsZT8kvzkc8qvgVKYtAj8zIdik/SJ7MBkHi4VwlJ+51tlOVPep7UwWqxF?=
 =?us-ascii?Q?plKexa38/Lyy/OoWQJIqvaS1jyYbCvqXtWi1vSXLZ3J4Cajh/vFyJ3N8syci?=
 =?us-ascii?Q?vEAvPjIfVMN24GC6zysUcM7P4M4D8cntiQHSmxW+PGUVG5FMhnyQ0/4pEkSs?=
 =?us-ascii?Q?P5qn7klKc3LRg+JSknfaW04VY4XKNFz8rQ+UKGyUJ1gRbXrn0Om54XyGn23p?=
 =?us-ascii?Q?UBFk8c/xyIUbzBIvmLopWvxaldCIpO/wrPFkvHSRvx0A18Jw6CoPLJ8qY1/K?=
 =?us-ascii?Q?m2BupkDYULunJHmLnrubec1ax+bIYAIUZEFqOpGv1qETxpXzuVt/vN7TXtdX?=
 =?us-ascii?Q?kYW+Bqj0IMUcBJnXskr+HIGoPFFx6XkG1pxhrZ2VDQXEzvR3dgT1o60kCxrm?=
 =?us-ascii?Q?NUijO31pd21Kqb5Uk+KPd7MXL7cUBctafjPV5m0cp/CZfUNMMv9pi1yuMHUQ?=
 =?us-ascii?Q?lS2y0xLIn46YhpOWGQACZijj3dRX8LcdVYVGF0ajmIBwIN2Z9io5AL6etMoO?=
 =?us-ascii?Q?KVJRd1y3vfotu3tJtx/5jK7qxxHC8jGUtRzydaVIREIOyShVmPyGTaActZ3t?=
 =?us-ascii?Q?PBDv4/Srb0bP0NFZrtvhiAfbk1ezpVApzyhy6Ynlxx1MJQs0LhqpzP59irhV?=
 =?us-ascii?Q?M1Mg6VWnjEw3WIVQO2ofoYY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d12302-83e0-494e-ae6d-08dc969c0f9e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:27:00.2564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6CoDs+wE+uuuCLRlITQ3zs2gHFHUuZvxw7i5M+MIbZyU7iwERvKSk2hgGYwY4gj/MDqie/LLf9X1Jh+vqmLexZJfakJC9fE3N5x+4RCHo8=
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

This patch implements 'nand markbad' functionality for mtd command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  6 ++++++
 cmd/mtd.c   | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 6834bbd82f3..70c2d6a2dda 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1418,6 +1418,12 @@ config CMD_MTD_OTP
 	help
 	  MTD commands for OTP access.
 
+config CMD_MTD_MARKBAD
+	bool "mtd markbad"
+	depends on CMD_MTD
+	help
+	  MTD markbad command support.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 9189f45cabd..18f00493780 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -692,6 +692,57 @@ out_put_mtd:
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
@@ -774,6 +825,9 @@ U_BOOT_LONGHELP(mtd,
 	"mtd otpwrite                          <name> <off> <hex string>\n"
 	"mtd otplock                           <name> <off> <size>\n"
 	"mtd otpinfo                           <name> [u|f]\n"
+#endif
+#ifdef CONFIG_CMD_MTD_MARKBAD
+	"mtd markbad                           <name>         <off> [<off> ...]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -808,5 +862,9 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
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
2.43.0

