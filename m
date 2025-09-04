Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC55CA1015
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 14:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E6283B83;
	Thu,  4 Sep 2025 16:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ylf0HwTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A45283B9B; Thu,  4 Sep 2025 16:50:38 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A1D583B7F
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 16:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1OGcjos3K5+f4YRyY65oEWmaRqOFl8E6tJjBij8tLngjkR8zlk38/QB8hdaIsg4j5KkjWmM1xbLRnQoFtegX2gc9OUtX3QC/hJiWh0poK7efund7VS1saWSmm2yDP6XD81bD2pZIWWI9Oh4ykWLk7RZC8496WQfc5tOnrHptO0S9Ye2D4GYKqQKHppBzjPKmMOhBrTLip5AKw7JrmVRhjYLpqcHgzaSsVtvK1Lnv2uw+WCddiuFpWhd9Kpt5H9D/xgwoCSExQGDjkzNVVaoU4FpoOAVBldn53j2ECoDu7HW3+DHd14u9Qe/1hcDD+UCW1sTZ1vQ5+7+WrDr2nhvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEEVdTvpfT4SpelTu87k70jBrnskkkwUY/2HCdGZxCk=;
 b=egbulfN2+CENJ4oDuT3KJS1YxxR/0tYufWh1IjAZudF3+7WyS66ncm3+9tFKQKJ9UZJxfNLmtkjgwuyrQavzzp7/3fcMcyFPjl/3OH/agbnvHpX/BahL/3YMmSRPDSxHfkrcqnC0eXXw5pD2C8owohCuv9M8Ou3o6FZbBysmhgyX71AzIp4B34lhESGNIxf08vHp9OlXwE+VgeHMPsb9GkEeYS4bvalpR/++zL+xCElcU+mHXgCuxqhIu4F4HWwlq3GGgshKIFtos7BcYe8EZnqyA7SuZvkVDuvOLLQpcnkjH22MKdpulz+n2YQZYm9pd3syzOulwZwke0sX6L3Qag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEEVdTvpfT4SpelTu87k70jBrnskkkwUY/2HCdGZxCk=;
 b=ylf0HwTvC5EdRPNThYZOVpaRjJ6FpYbGYYEakWPj6Ndla2w6aX5dYKEdNQ52JMF10KnC9nraG6dNtrB5qtbUQs3eljJrk5uqGZ/3H5Lfj5hz/ZTcS+crxLrSVfh9yTuw4IY6ZH6hY4Eu6ntxMxrRq4euuDTkw3rHksqgg5+qRxMKU4geyjXG+1g7aWQxZO2lQ6B+VBJokLwC2HImjYHTbN1xevuqs6yD0IpfTgbNwMoieMuM3tERTkMwmFneWYQ0WPTmMX63yclHfUkAalQfJmCkJEQBHuEnIVuv+lq2cK7HCoYYelMzYg7ReeXRCf8hPXRDmnHMF2bOsH92iiTNiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7582.eurprd08.prod.outlook.com (2603:10a6:10:306::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:50:33 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:50:33 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 1/3] cmd: mtd: add markbad command support
Date: Thu,  4 Sep 2025 17:50:21 +0300
Message-ID: <20250904145023.659922-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904145023.659922-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250904145023.659922-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 97803806-e437-417e-9e51-08ddebc26656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RvjK+ad1f4MDyTLZv3djwTTfngzfj5WmeCQAKOaLSYNOL97BUxSGSKO/vY/k?=
 =?us-ascii?Q?a6jyFXqiJxAui8w82SdOM0jcLhGv+jH7748KCeCoXNFHQcr6Tsb1aMOcOZ8Z?=
 =?us-ascii?Q?pzPswANT2KDN0gJO7417rAM5Xo25SxRtxsHMRbOgPFVG4t9EzfGo0W7J68Z3?=
 =?us-ascii?Q?JvI398LauR9MleUbyP3et1v23P5X7i5LifPbtqEkSfaIkBInkjxuMN6idop1?=
 =?us-ascii?Q?73sDDXqcFKpAhBA8/rwAHwgD6DOhElVa+TN92AZCzhH2GEPPPU+eTt6+7Tq1?=
 =?us-ascii?Q?VjSAUvkbJsxjTGqx9ciL86bEDK8RKi2fTJnBJij+wcbag8/euiQlqyytVdTv?=
 =?us-ascii?Q?41WrOlintiQpeMpi6UV83bcGv/0gSF7YzFL0xulkp1aktCseOXfo6Y968aRH?=
 =?us-ascii?Q?vuGuVuMkiXZVXOuEEAX0j5sSl7Sfzb4h6/Tybci0AQKJiv9+DJq7y9/2pURE?=
 =?us-ascii?Q?o6W7DOtGXw90JLunzWMnkzyyo8guxjOSYnr15XM5a6psRSzlzoHaEvU5r7no?=
 =?us-ascii?Q?xodLi9wF1+qV1mvvFx2GKiJbWW5O5lKKMtNk66JTTt2EmJ+l4ae8MfuWI6Vu?=
 =?us-ascii?Q?bXjODtAEUwn9Zu7xRvEvEiuRVli2k4BXFn/L+pqvjYNe2MwU/YLcXloc6dii?=
 =?us-ascii?Q?w3EED9iv4I/dtHo80+5BYXa7NGD0ssm7E/t7Ger4QtS+uZzycPRmosO0GGOA?=
 =?us-ascii?Q?AmPpnjvYWQwEa0xI+cW5JzDMgswqeC9GTBq9qAnufAZC+grAr+pZjR61Ym8Y?=
 =?us-ascii?Q?uPphtCIxcjqRLmqn2miqCX3eU6bGSzUIyPELVVOKReSiCbQrXZPn0V9Gkuqa?=
 =?us-ascii?Q?vHfp8AIDk/4R6xNhL34FE8Banvynq5qz+w1lQJzLtY9DlE5PMg+jhJ3M3Msc?=
 =?us-ascii?Q?vxV/GPZWrzQq1bO66hgssaB/I0xB93J6B/nG3lK6GsWvI+V7cDpBjTmbV4hS?=
 =?us-ascii?Q?adb60De4KQ8LCZLNdKrLJxKZQoyIZgJr0xFjMpYpJy8U6cWAZmTtEdVK+vJT?=
 =?us-ascii?Q?5q2g/mI3s2JQj6w1dHVOqeq9Gx5NmTEL5FitR2pg2xBSnG+HP/vxzvKbF0RZ?=
 =?us-ascii?Q?n1kxImjEjKO1OYpK/Pys+fOiYCNjszp1cw04zcPeyb9Iaw7zZn5MzA86pHGY?=
 =?us-ascii?Q?0OVkdwVrcRWkT3vO4ya82qKMQBuioRHbJgnFNCmOk+dqHhWkTEsNwLmxWP0A?=
 =?us-ascii?Q?6ROSbafLmUi9FkdzfK9aZ0bR/CzagG9b9oz84L+cAOIDu2D5jWdnOF3FcC10?=
 =?us-ascii?Q?9MgdzdhusfPoksKaqgY9yiNpLJSYQaUffAJZGo/P+Lo2kparfDMz+qnl/i53?=
 =?us-ascii?Q?wlzkJNnVDkhRrbcbNa0teenB9gAHXKAqOeY/7GVn95Q1672He0eFC8Xu/M8R?=
 =?us-ascii?Q?AfMjmWJ8KbRf+SKZuTonUnyKkgXTduJkCqqwn5H2RXnEFILSfir6Gf/92yl7?=
 =?us-ascii?Q?+LyI4HlOspAmk+9Rb0IJSVp3pVy5h3tRVky6qwCFnCRjZO0GJYfyo+fDG1yx?=
 =?us-ascii?Q?a8niqMTZnJ5Nan4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KJCY+3oYl8jl8edMIeHTCA49NKjdWTHVaU2dOLSOqYfzQdtuBN5ao7nxjBW2?=
 =?us-ascii?Q?ttNhPci7qiz6ElH6NKucCObLM8NqymLUINZDBf63n6lQwOze5xhdRzuhRkNt?=
 =?us-ascii?Q?n9PV98qivRArAH8bpafRz4K27OPojdEFMR0J7h+W8KeigKJMD+lv/SnLtyby?=
 =?us-ascii?Q?7Mif+yirZlvo3hUV21shrbCglr8PrlMSVHJc51KdR2XmYIJBCkTPTU4mUgYH?=
 =?us-ascii?Q?HEXaj5L3SiAA8PLctK2PRTHSvt9gjmSs/GRdFchn/DPEOQWu3zhwuj8JEwF6?=
 =?us-ascii?Q?SAAX9OYH6z+uoVL+rKoGFeOPlznLpQiAKo8MIKq7HyNCGehijyZujTw157D5?=
 =?us-ascii?Q?kbkVT10I/id1n2TMizh4Wk/tK/6RxajmSx6LtIsEbS3yngBfoZH6a4HKi5BO?=
 =?us-ascii?Q?snjv7RBC6PyHXxb9vJBb/lGNsZymHFnz4FDwKMfyyavaVyd4WQUsr4oUTiwy?=
 =?us-ascii?Q?mVSpWB/TaOo4fFCKapp6IEG1FLCz5LA00e1ft1Atp706beWZhS6tLrGU3LhO?=
 =?us-ascii?Q?In4BKZbcH5/+iS5YMgahj35zUcr/JeJNnP9XMEYSZUGd8/Q9l5C+oeYybHGP?=
 =?us-ascii?Q?Edv7YN25KfjVSHsVheFo0Nh3y5/El3+308sKqS3g8lRtJFxyFHzfGjWoPNiH?=
 =?us-ascii?Q?o+IjupgTbcMvm3XuwlgNYz3s0r8g4bp4muAUuED1/ig8Fe3n4tLyt/X1/gpf?=
 =?us-ascii?Q?8El3RWNdF3B/lj9TguNZN+7SMD7fvhjf9QzZXe4FvBz4O1KKl8gkPiHwFGGK?=
 =?us-ascii?Q?VnuND0yyIabMnWxnmdwVbq1HQnW1UYaiZChYmcxImDdZndIQpge6TnVQjoDZ?=
 =?us-ascii?Q?tfAO6TuxXuhwS+eu3ttNxjM9h/f0sKE7Ie+qe+/9Wa3SJaneRPmmH/+gpEji?=
 =?us-ascii?Q?UchLa9s9G59hqHdibfQxaXFXwQM4yDrpduFEG6BYlBjmc/uggxAPGLbszwas?=
 =?us-ascii?Q?YibZZCdVtqNMZiYbxMQb0jvpGpvQvLmSRA+oT8p/QMxWNdYP8EyPTOhQg7mw?=
 =?us-ascii?Q?BaoesvLaiVIn9f++4aFc3b95jjYZcZNDW2/eUfkWn0RhKUTKtQSk3RuH7VyL?=
 =?us-ascii?Q?Bj4vmcIOSjWQGNw801c5uMD2PSRXsMdRjbGpm7SFGFKgd2/+eNVisqsauv0f?=
 =?us-ascii?Q?RJ5cmHPW5cKo4J7LPGSV2zRfBcfnDtZV3871abNWDchpsPh2KPuEQI5ypoj9?=
 =?us-ascii?Q?gWCtNjPm6bbrE9Knm0n1qF+OfsdL63EJSPhLnAOSsVw71hyFK5NaVYfY3Xwu?=
 =?us-ascii?Q?wBg0qxjN17sDJI7glLI84IQBIFkCnC9O7Apl4IVfaRJmHuP6Qd+bkcRLlo30?=
 =?us-ascii?Q?Xb4sEppi2ne7ywo06zMtm8jQAqTJJsYEoBmMz57tEWlikyXe31KkdzuSLTJo?=
 =?us-ascii?Q?ZFNIM47cRpbdrbZrOgi3RuJH9Lw5L2UA97YtWeAdTOws2hvWC94Vzx6LDEkF?=
 =?us-ascii?Q?EujBsGa29+3vyNs4Gcf6juVZoYXnXNQ9hKkgHbHpuBm9ybJaIbwzS5S02ouC?=
 =?us-ascii?Q?5o+FDjOWQ6oKAe/EPM1OtHJk5G8n6+rmoV1jnQ+3pBIENyJZC0FyfAOoXuqC?=
 =?us-ascii?Q?R2iyunxHlICGezeSZfXBTyaWw4W42nRWDhjxuRdkXe8NfE+G+ajRFE5eGO25?=
 =?us-ascii?Q?ijISvxjTBgoWiwl7BLMRUd8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 97803806-e437-417e-9e51-08ddebc26656
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:50:33.2644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVigtqLmVcsd48LpzBLBfMwbuP7SVkE5zIKun3M1BENIMmQYNvl6Q3w6/Ygg/vo4hYtPkwlDKWmSNmm9LxfbMvqyCokX6KOOq6UvoKlq1iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7582
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
index 29de857ba7c..8f2a35d780b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1511,6 +1511,14 @@ config CMD_MTD_OTP
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
index 2520b89eed2..95e4be9863d 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -711,6 +711,57 @@ out_put_mtd:
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
@@ -793,6 +844,9 @@ U_BOOT_LONGHELP(mtd,
 	"mtd otpwrite                          <name> <off> <hex string>\n"
 	"mtd otplock                           <name> <off> <size>\n"
 	"mtd otpinfo                           <name> [u|f]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
+	"mtd markbad                           <name>         <off> [<off> ...]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -827,5 +881,9 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
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
2.50.1

