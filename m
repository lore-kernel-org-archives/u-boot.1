Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB0FECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C831C88E45;
	Tue, 10 Sep 2024 00:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="fFxe7gRj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE32388E37; Tue, 10 Sep 2024 00:21:33 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::723])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88E3288E39
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofAU0T7tP64l8wtB/+UftIg+rf2ghmRwCs+MI+tUwDZT7ms1X2VRILC7nx1Z6aCxEFo0Yd4gQO6F3Et/blr0vq1PbQ4awmvJdTyUHxgtthz9EoqGSgO+mvDnUXm3UhoE2YUXusezDpWGyNRru5J2evm1+2mQrPi9E0/Xqybq/insO3n4MdioWi6X3T281/uwzvgGBHAL5Ht8QlYk+Hs9An6gJx6lSxNWAyq7tY/S/WAuJ1S6Qx5Dqq16mq5WZGhYa7U5U3bss98Q02DtTBF2zbDdHEFQGZuzXWCBCQRFoBF4Bjv7OLO59NNvTGXOQlo8fYkyMNL4EVA/paiw6poJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RP+Ihep4Cdq2TccyENMklkZON6Ql8pUh0zVeVuiWkN0=;
 b=RECsyEEVTm8ZaqNuGGpnXYaaAnWslTXVaQWNHYLb+cvrHytrrMU5mUTy4+QQi5ODvx8bztAx2QbNZxNo8YN46tshB2LcZOZF/0VTmNPAFsSJztBYAjVpd8KK6DIBq+KIYbDlVCj7uVbWhCCouxBSvq8HycxjRKP+cogjzcKgtS7nWToi58Pr1sVXHiQNLrRQFKLnBnoi3GgIYMrMgks+6XfmZOjV4oysfxKfNibXH+HKSztk1uoNWyLTtXvf2bZI1KuQxD+HMkWH8seZuoDD0WkeJeXAZR4kb3K8T4JHwF1Wji3HJw/stZaVLHzKU+JyM4NOaY2KUMefqXaKOaMYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP+Ihep4Cdq2TccyENMklkZON6Ql8pUh0zVeVuiWkN0=;
 b=fFxe7gRjp6ApWsLqSMK7kzcMwBdEdWf5yM8xzMmzKpaqfb9SBpuQs1Abmx9fhBhA5/+0JIPwwRRm1X0DgAbLr7krEKRQoh+obuo6Cuz4pyWkAd5hrp5MftGZYy/nlbdAXlgS2LqoVAsDgcrA6jvYYOojaH+I9fH12wChm2GmyN0dq4GGkFJ0jFy5bMN0jp1YX/pf08wjt9RLnIVaVvdwwR5VLigc18AA+OsC98B/PtWK4c+Hm6rhcOflB7MPUaJjRGuayQuvHKwF5mT5NZjaLmy2h5Lst7TV08Ai7c0O0oggZvIxh2sZZpbtMy3Uj6PhbfYdcYhoYIv08/SYgz/O0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9935.eurprd08.prod.outlook.com (2603:10a6:10:401::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:21:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:21:25 +0000
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
Subject: [RESEND PATCH v2 3/3] cmd: mtd: add nandtest command support
Date: Tue, 10 Sep 2024 01:21:12 +0300
Message-ID: <20240909222113.2562703-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: da109a09-7396-47a9-4c19-08dcd11dbdef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3aMoFCXzlyDI0G8TmxAun+NKTn9RX0TfrhzCQfeM61zf+835Q1eR5iOQmCas?=
 =?us-ascii?Q?EdJhVJxhEYfIz4U61yxltLmjL1/+/ZywI/RkVwYFmuw1Zmh9d1JKiG9nnUgZ?=
 =?us-ascii?Q?AWRq7VQ5P7Njp1iQgZQjAn2+M3K1ZFk3UP4lvAufglkX+w+JQ+9iSmwypoIY?=
 =?us-ascii?Q?z/GUOUcc4wOkTRM8f8RPzUK/QZOTwFIU00rd0JPblxNpX9XwpJ4ym257A/2l?=
 =?us-ascii?Q?VZIJXoO173ARTCxfZlgSWrmDgrSthg/RaJ8gwYSUaj3pnoLUYtdfk1yvuPY4?=
 =?us-ascii?Q?dpzcUv7C2EQmpBUE5JS9PqFmLIbeusyOvWdIj6Q3rrTU4sQDpSzFwO1H+tL9?=
 =?us-ascii?Q?E1RzrtTkS4PHvpjUWiWATbUCq5ytwdMHp42selN0uhFLmpgMMr1jhmiEhtqD?=
 =?us-ascii?Q?vTQsPQIyLsGkyzag5fOeMEFyXMJO2phOW4IMUSyh6XPjz9pw5Cm6/qzcEH8i?=
 =?us-ascii?Q?Cg/2jwMTO3NqoWyyhi3MT2omOGKwhjY/mKN8zOLg+qMUdPWg4K55LLGGkEYj?=
 =?us-ascii?Q?AUcXWvNHK9IKo8rsI2x6Y3fs38ALvb6EgYKlmdpFl6bheDxEDDeLac/wmml+?=
 =?us-ascii?Q?q7yBYPsEK1KB5ehT3Oa5VOuOaLGiEZFEZRAoragZncjEM8RRhxlKC75y+7WG?=
 =?us-ascii?Q?d5D21Ex2KofMCet7hlUCwx/0iQDzpJ0SQiu3ddBiG7sqhEfHY1SiQR+uyx7Q?=
 =?us-ascii?Q?Gp7CKukW1zHej8X8SKmwu1ax9/ANiUORDyN3A/EMrYsclt+QBzhHYeOXs/yf?=
 =?us-ascii?Q?et5RYcY0LTahYzuZGBN6ylbFsyKOLk3w41h+BNVAyFeEvGjS2MvCmYj6o3ZF?=
 =?us-ascii?Q?LlihK2DhMndZSBeHxVNA+z7WmO2gdW/LWqm+PvP3VJ827KAugapOnDgERK2h?=
 =?us-ascii?Q?Vv2AIpcS7BD1TvYWMLB3YwWrHcet1DBX1Xzsdb10jYbND+Dl5wR2nPi92bGU?=
 =?us-ascii?Q?GTguv0IUhExHI72WfwEz5pnta04OCnGsdUEqk3slKDog+gXisaB+WmKRADHX?=
 =?us-ascii?Q?mYVUPTXoa9YKaPgR49Cb3VFX8Ajaeji3FmSF4fODk9n+zcRztsD7LtYKFDdp?=
 =?us-ascii?Q?cztDmOAdjWdOGXdVCPxXSrGgLlsQdnLWwmg06yh2yQVUmOGk5jaTld6NcAme?=
 =?us-ascii?Q?AyOyYwRf+C21Bq2H3vOO/k/LjbMHFUhn4mnruw0762X41UcTbCpO3tJ4Rim3?=
 =?us-ascii?Q?8Pem2EPNuQIfodZx+GThxuPSzZrKplBYqQPSsb1T0BmFJJm2N3c+jvfCC8F5?=
 =?us-ascii?Q?32eYGNaG1WdEVALXxdlSk3HK2s11ZijOy+GhW6B8/lcVqua+mlUqCZfx1ioE?=
 =?us-ascii?Q?EpP6o6P89zwZ80fYEm8bPK5TMMipsgOwm6gjJ2siNi0EQ7KnFTAOoHAHqEkn?=
 =?us-ascii?Q?tn8WGwqyBhERBQ6VTXczwVit5KF0ggEYJ9rlPH7Ax3WAKaV/fBtf0BpY7WuM?=
 =?us-ascii?Q?c/rwPrKbTQU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cwsWVBLuOJ0GDK7KmqK1LnVh+JQBAI7osuZTZxTny3TxAquSwb91LolrtjJd?=
 =?us-ascii?Q?Jbl5wL3lTnZcwS+4Uj/PrQUfnTUWwRk9X7f7QOJFqD6Q7wM/C+VuY7k5Oazl?=
 =?us-ascii?Q?kV5hIu6V1G01zY8ZMB50Y3YmFvEtV6YLA3U3T8b3cc3NpaXZYdSHV4P+y1Zm?=
 =?us-ascii?Q?naZlQJzvy5lcmgHH6SgiVPb8fhXbwwr2+Q8NHFsnGXXhoKvl/CeuaGHB51bP?=
 =?us-ascii?Q?93ubrw9cydDcMscstU/j4ZY7i0RzTq4QroGv1V8slXLCYwdBA9i48zqlyO2G?=
 =?us-ascii?Q?6rFMQod0Gy1XOOV13iw/QuE66YXOa9HPaygp50iafEuBsTmp/ksCPersZZQF?=
 =?us-ascii?Q?Fp2r5SFP+5yIuqsL9Lelh6vLL2ksjgAcTocCDVrVLfz+IPfF8MFdxg0uOkFs?=
 =?us-ascii?Q?zgHg517QXmhlR2vkz0+BG1bnj7Bexyil13EQsG3cLCABhPq3qdYNikb9xhmc?=
 =?us-ascii?Q?yExqxgq78nBc0WGSwypbot67AlwOADJt74PmwAjLaVqCckZfQLFL5xcwkXZV?=
 =?us-ascii?Q?3p0dlQR4EMM6IvUgKNE6G9D022RACRxbsSqds39nYv5OJJqmYJpDnKqCIovA?=
 =?us-ascii?Q?JT3hCaoxDWIRNyxIgL0+gmZY9RYN9Y6y6qub2hljRBrJe1x+3CRcaKDgEnUa?=
 =?us-ascii?Q?VGKF3duQs0/QDvuWEBmi7hsNk9EwMdtNtJsc36ixL/Jjozr0A2ytY+OgMZ31?=
 =?us-ascii?Q?40qxwwy0eisqrPq5oodkC3qmmz+64SO8Pzdk+Jo4IjURR/5Dq4aGStXfgMxL?=
 =?us-ascii?Q?djutTNvgd8b8pTo8kJ/3QdXFQmdXzCdLta2sGBvglOscM2raaOX/bxHcXmF3?=
 =?us-ascii?Q?Zv3vzc12+FGr28oWLHtZB0SL0GD5KqZ8HaKAVD8wrM5dD3uKhV/vJ4hmRsgq?=
 =?us-ascii?Q?KAkyQAvRfwYX4HJTZoduWeLC+/CebLrmRdRUeFfPb6NGPvqERwSgowW3Vecw?=
 =?us-ascii?Q?HtM95rN3GMED7BHAS3boSszDv3Ipjk3l8Z8Biv0vQXkJH6G2uQf0gncaq0xP?=
 =?us-ascii?Q?FWAnX3ATUdTZOdzY60bV+hmT98C2qkEDTR1w/xMik2TkXQf83pTvg1knOUDR?=
 =?us-ascii?Q?CpC6Ms68KiI3BcCyx+lmVzGnu5DPE7dtbX5KGA0XDw4fMopr8u7Y8j28iv/F?=
 =?us-ascii?Q?fmAFdqtrd5Fg7eaer4g0xBlcYpRjCiWv/AbSLrrIEAKvSk4B3P17oLfrn0kE?=
 =?us-ascii?Q?PLPV005qOSr2gOB6Kv47l/KA80Jnct03BGrgr+dvTKlJvimAyVg+BGYK9ZEZ?=
 =?us-ascii?Q?8/SUlPWjWtkSeBQhl7OqMDpq6YBk2r73BWeBsQRfA+mabiUoKaaEI4t6x9u+?=
 =?us-ascii?Q?g1af+Hg0z1zOKD6cLHweDfXNjn2eweCxEoz/uHlFMDE5MbfySxjHGvoafffg?=
 =?us-ascii?Q?ItjYQ3eTXTYtIpB+1KPmlGSqkzXd7FulVbhJwVKq6/lLglRs0rm5iD0sLRbk?=
 =?us-ascii?Q?FUObdEeeaaFqwUbmstX/bekCl3lgG6YUPLxUuJqi+0Jcqq/HB6tNLNObnLQe?=
 =?us-ascii?Q?ZQaPJmx9xR+JSsbeOiR9zMO3kRiy5RTIe6nokKBHmBccYfuZIdowUP54qRd5?=
 =?us-ascii?Q?XSV0R7lceNt4SEe7rQwbWVNmtt+IVJhsCMu4XynfaBQjQPfPExJWSbzxm1oH?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: da109a09-7396-47a9-4c19-08dcd11dbdef
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:21:25.1763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N75tckVzy9b5tdYDTpJGSpf0LnWlyX+5rKx9+wOjq6A6PSDgE6Y7r5ETVByajmbSa3q6Y/+RHWAqAeLNgGzG+x6V5P+lFVmXZgUZgfLnTQQ=
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

This patch implements readonly test of nand flashes.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |   6 ++
 cmd/mtd.c   | 203 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 209 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 698e0e697f2..db5113e016b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1445,6 +1445,12 @@ config CMD_MTD_TORTURE
 	help
 	  MTD torture command support.
 
+config CMD_MTD_NANDTEST
+	bool "mtd nandtest"
+	depends on CMD_MTD
+	help
+	  MTD nandtest command support.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 69ddfe1d9c6..4a380dcaf83 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -931,6 +931,202 @@ out_put_mtd:
 }
 #endif
 
+#ifdef CONFIG_CMD_MTD_NANDTEST
+enum nandtest_status {
+	NANDTEST_STATUS_UNKNOWN = 0,
+	NANDTEST_STATUS_NONECC_READ_FAIL,
+	NANDTEST_STATUS_ECC_READ_FAIL,
+	NANDTEST_STATUS_BAD_BLOCK,
+	NANDTEST_STATUS_BITFLIP_ABOVE_MAX,
+	NANDTEST_STATUS_BITFLIP_MISMATCH,
+	NANDTEST_STATUS_BITFLIP_MAX,
+	NANDTEST_STATUS_OK,
+};
+
+static enum nandtest_status nandtest_block_check(struct mtd_info *mtd,
+						 loff_t off, size_t blocksize)
+{
+	struct mtd_oob_ops	ops = {};
+	u_char			*buf;
+	int			i, d, ret, len, pos, cnt, max;
+
+	if (blocksize % mtd->writesize != 0) {
+		printf("\r  block at %llx: bad block size\n", off);
+		return NANDTEST_STATUS_UNKNOWN;
+	}
+
+	buf = malloc_cache_aligned(2 * blocksize);
+	if (buf == NULL) {
+		printf("\r  block at %llx: can't allocate memory\n", off);
+		return NANDTEST_STATUS_UNKNOWN;
+	}
+
+	ops.mode = MTD_OPS_RAW;
+	ops.len = blocksize;
+	ops.datbuf = buf;
+	ops.ooblen = 0;
+	ops.oobbuf = NULL;
+
+	if (mtd->_read_oob)
+		ret = mtd->_read_oob(mtd, off, &ops);
+	else
+		ret = mtd->_read(mtd, off, ops.len, &ops.retlen, ops.datbuf);
+
+	if (ret != 0) {
+		free(buf);
+		printf("\r  block at %llx: non-ecc reading error %d\n",
+		       off, ret);
+		return NANDTEST_STATUS_NONECC_READ_FAIL;
+	}
+
+	ops.mode = MTD_OPS_AUTO_OOB;
+	ops.datbuf = buf + blocksize;
+
+	if (mtd->_read_oob)
+		ret = mtd->_read_oob(mtd, off, &ops);
+	else
+		ret = mtd->_read(mtd, off, ops.len, &ops.retlen, ops.datbuf);
+
+	if (ret == -EBADMSG) {
+		free(buf);
+		printf("\r  block at %llx: bad block\n", off);
+		return NANDTEST_STATUS_BAD_BLOCK;
+	}
+
+	if (ret < 0) {
+		free(buf);
+		printf("\r  block at %llx: ecc reading error %d\n", off, ret);
+		return NANDTEST_STATUS_ECC_READ_FAIL;
+	}
+
+	if (mtd->ecc_strength == 0) {
+		free(buf);
+		return NANDTEST_STATUS_OK;
+	}
+
+	if (ret > mtd->ecc_strength) {
+		free(buf);
+		printf("\r  block at %llx: returned bit-flips value %d "
+		       "is above maximum value %d\n",
+		       off, ret, mtd->ecc_strength);
+		return NANDTEST_STATUS_BITFLIP_ABOVE_MAX;
+	}
+
+	max = 0;
+	pos = 0;
+	len = blocksize;
+	while (len > 0) {
+		cnt = 0;
+		for (i = 0; i < mtd->ecc_step_size; i++) {
+			d = buf[pos + i] ^ buf[blocksize + pos + i];
+			if (d == 0)
+				continue;
+
+			while (d > 0) {
+				d &= (d - 1);
+				cnt++;
+			}
+		}
+		if (cnt > max)
+			max = cnt;
+
+		len -= mtd->ecc_step_size;
+		pos += mtd->ecc_step_size;
+	}
+
+	free(buf);
+
+	if (max > ret) {
+		printf("\r  block at %llx: bitflip mismatch, "
+		       "read %d but actual %d\n", off, ret, max);
+		return NANDTEST_STATUS_BITFLIP_MISMATCH;
+	}
+
+	if (ret == mtd->ecc_strength) {
+		printf("\r  block at %llx: max bitflip reached, "
+		       "block is unreliable\n", off);
+		return NANDTEST_STATUS_BITFLIP_MAX;
+	}
+
+	return NANDTEST_STATUS_OK;
+}
+
+static int do_mtd_nandtest(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	struct mtd_info		*mtd;
+	loff_t			off, len;
+	int			stat[NANDTEST_STATUS_OK + 1];
+	enum nandtest_status	ret;
+	size_t			block_size;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can be checked\n");
+		goto out_put_mtd;
+	}
+
+	off = 0;
+	len = mtd->size;
+	block_size = mtd->erasesize;
+
+	printf("ECC strength:     %d\n",   mtd->ecc_strength);
+	printf("ECC step size:    %d\n",   mtd->ecc_step_size);
+	printf("Erase block size: 0x%x\n", mtd->erasesize);
+	printf("Total blocks:     %d\n",   (u32)len / mtd->erasesize);
+
+	memset(stat, 0, sizeof(stat));
+	while (len > 0) {
+		if (mtd_is_aligned_with_block_size(mtd, off))
+			printf("\r  block at %llx ", off);
+
+		ret = nandtest_block_check(mtd, off, block_size);
+		stat[ret]++;
+
+		switch (ret) {
+		case NANDTEST_STATUS_BAD_BLOCK:
+		case NANDTEST_STATUS_BITFLIP_MAX:
+			if (!mtd_block_isbad(mtd, off))
+				printf("\r  block at %llx: should be marked "
+				       "as BAD\n", off);
+			break;
+
+		case NANDTEST_STATUS_OK:
+			if (mtd_block_isbad(mtd, off))
+				printf("\r  block at %llx: marked as BAD, but "
+				       "probably is GOOD\n", off);
+			break;
+
+		default:
+			break;
+		}
+
+		off += block_size;
+		len -= block_size;
+	}
+
+out_put_mtd:
+	put_mtd_device(mtd);
+	printf("\n");
+	printf("results:\n");
+	printf("  Good blocks:            %d\n", stat[NANDTEST_STATUS_OK]);
+	printf("  Physically bad blocks:  %d\n", stat[NANDTEST_STATUS_BAD_BLOCK]);
+	printf("  Unreliable blocks:      %d\n", stat[NANDTEST_STATUS_BITFLIP_MAX]);
+	printf("  Non checked blocks:     %d\n", stat[NANDTEST_STATUS_UNKNOWN]);
+	printf("  Failed to check blocks: %d\n", stat[NANDTEST_STATUS_NONECC_READ_FAIL] +
+						 stat[NANDTEST_STATUS_ECC_READ_FAIL]);
+	printf("  Suspictious blocks:     %d\n", stat[NANDTEST_STATUS_BITFLIP_ABOVE_MAX] +
+						 stat[NANDTEST_STATUS_BITFLIP_MISMATCH]);
+	return CMD_RET_SUCCESS;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -1019,6 +1215,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #ifdef CONFIG_CMD_MTD_TORTURE
 	"mtd torture                           <name>        [<off> [<size>]]\n"
+#endif
+#ifdef CONFIG_CMD_MTD_NANDTEST
+	"mtd nandtest                          <name>\n"
 #endif
 	"\n"
 	"With:\n"
@@ -1060,6 +1259,10 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 #ifdef CONFIG_CMD_MTD_TORTURE
 		U_BOOT_SUBCMD_MKENT_COMPLETE(torture, 4, 0, do_mtd_torture,
 					     mtd_name_complete),
+#endif
+#ifdef CONFIG_CMD_MTD_NANDTEST
+		U_BOOT_SUBCMD_MKENT_COMPLETE(nandtest, 2, 0, do_mtd_nandtest,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.45.2

