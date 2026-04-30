Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE27FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F7184660;
	Thu, 30 Apr 2026 10:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q/Y7QEfQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B762184662; Thu, 30 Apr 2026 10:23:20 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9411784662
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsZ5uZuYKOpv1sT7x0UHG2dgFbiG1uVy1G1sBwwpJr3Y1e5whKLpY28q+6NlEZpq3Isk3KbCECORGiK3cUAk2ewBEVAtkKzShuTzf002qPZ68OGAYMYWy6xnDjD8onDt3ihLa5pulC7VfJZNiaekWexXrYYqTpkf+WqjtT8b2XI7I/Is8nAYmuYQKGYit5c5UQ1L5J8Hm9MCwrFnqUsuF6bMg3dcsnfSGOepHv0eIY6cX2sCZn17wsalgcflg6p5w6I2+G3vHp1BKC5qhUH1ZtnYah/rTYD8kJCbt4XiAvuCsR6BK2E5Od5TdqIIXOYrVOhoZwOm9nGFIBXJOli8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd6Mh90JW451ZlQebqvLW69je7I4DHy1JlRyMWAa0gQ=;
 b=LIktkZ+zLPq+cMgrILuWsU7f4PgHfNdoz3JRQwnxaQ8L3awwklEJc3vVyP+NkWhuW5vU+eR4lYmF6AwlB7Kr0nuJwIcf7D8WPiHMJwTLzHUDRwY+sRj52b5qTqr20mwb4NvgC9ORw10k/HXCw+tvlGL2PfQXoON9K8Tf5VvV+AFRhFyBfJsbcDqJ2VokbTUOpU9+5buv8Vlscjzpl7pD1Ft/m9RI4p5Oq82BVlelu78haJfYBJBUmfWMoXTZZWWwsNWZM1vN56SXu/VpsMBMEVt4Ni5hy8qtA5mAll0DsVRCauPhdm/vmLNvv/UMr2Zt/YzdCjAm0q/O2sYDMxi7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd6Mh90JW451ZlQebqvLW69je7I4DHy1JlRyMWAa0gQ=;
 b=q/Y7QEfQNAdbbxSOrGBkM4G98IWqjoOVMMOgBhInsT4jqhmn76geSoazZp1cdJ70DBATFjtPkT8sXs63QThsBLPgseGw2XxgloTbuIkPGWvStzX3XGWpqsIjukQYqpPa8NmHRXU4/wquULM+U9CHVhmxMTRKrc1TBzjLbUTusMmSMeBtmSi2ZOVIqG1p7ySHwmbJIoTA56wiSSoMGdVVn3KXGRJE5qfQE2gMSrFvL6bk13jyQu5TT6Q8aX/hcqN0jYo0OFe4Jwu7a3nRQILd/6ookTEw8+tQ4FQ9bbpafFqrEViEc/gITiYU6Zm5vYf9jnXP4/juau93CMleXS2gsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 08:23:15 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 08:23:15 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, fedor.ross@ifm.com, marex@nabladev.com,
 joao.goncalves@toradex.com, ravi@prevas.dk, ping.bai@nxp.com,
 ji.luo@nxp.com, qijian.guo@nxp.com
Subject: [PATCH v4 2/4] arm: mach-imx: Add command to expose QB functionality
Date: Thu, 30 Apr 2026 11:33:31 +0300
Message-ID: <bcdf8d29f12cf8bfee1f9351bd4cf45de966732f.1777536451.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777536451.git.simona.toaca@nxp.com>
References: <cover.1777536451.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::27) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|DB8PR04MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e465624-b87d-4fe3-844d-08dea691b9c8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: P9BxQKJwyjCHyuW26P/wVZJhiWGwSuzvE/kbiqAZHil8QIRPuiAjNwFTZnE/Zi8aaUBAWZvEpwFWsW/0WN/XiF1GWxR/b8ejOrO39oIEmcb6gW3CG5BaekyakJ95ZRtpqSGDMvHXt4TRptbqSQfvDf661SoPrFB6ZpjaiMCfVrAI52D2l7kJIYI6FZbEvhbVafjhFwH7vLKkKLRQLCb9ZPKD8HvTNFCgUcWNKuREfoiBz8QPXkmsfHdzfFdqFcQ+YKwbsoIylgxNeO93NzJ0aRd6+A8awwYoynKb9NVsn+b41Y1U6JBQorqoB0wsiSDvdaII0vUCWr0pHY2/cwjQ2GTGpGRbQDLE/lTx9+J0S5Syu5dJxq2lo1T3VNqAv2A6jtew2U+4EhxhqN8yM+zomdphV4XG9ROgl7+p7BQYLVpoqZRqSkBlBzQcau7FikQO6IyP7ns9TXl+p9TGfSxVrrBfYwPSJ7KlTOtn2tudgVDAVoHZGwIjFr9l2C0VniZxrWyO8/ZB6R2D8YINvy83zEj8Q6gMoyMHw5t4Kr8yVpq3QnrL/HlnjWUYuNDiR0buh6iALv132VlturjPfSZo6SB35wFjSa0UzpXqoXmqS/c+HVizGE3DnHdeV/d2pgKiNJBoPNTyOpl5zeDW5GwMvPBAmch2gZzyML8wSaKZI+5fnCv0dca3DdHrYsI9IPSt2QaAbdulBahC6xWimkMHYgI8OX5pcIKNf5+LDoMfygo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3MUjeMXqEx2I013rLI7/LXtLUcDYIAlpVYOHOJsyPR/za9hYZKCGqMsT6JtM?=
 =?us-ascii?Q?rwyWfOUvf2FB0PcdiVTGKL4y2+dcq/aphllb3iTyE9JYKaBZAfDYziL1A4t5?=
 =?us-ascii?Q?HUH03gR/VBWQjBgGRa2DmlVJ/kX+4btRUNR8ND1w0eegYYvHX697xDYLwLd3?=
 =?us-ascii?Q?SNZyNKMTSTfDSDsl6XhzuOF9iw2faabb50zNyivnFgNR7tqupRSbkQMAM/4l?=
 =?us-ascii?Q?D91MK66Xka9EkRuxL7jtsBZaLoR8cC4y4cCSLW5s20pHJSYwz8u9zDzIvJn/?=
 =?us-ascii?Q?JSuzHvlyQaCXgh+MXFGC24A1Ty1STBJGxDsDv/PTHXY5Xf4xbJQGzu1KET1F?=
 =?us-ascii?Q?TftdwzvMGzwSgA7h9MsnazZul8UORbOWRDBci8cKDtZG9z+McTK1T/jQMYPE?=
 =?us-ascii?Q?ch7I7T9Y+Z3iwJ6mbBI3b8vuG70/z4uoQlUnue9Jg6XgXhF9cuC/qEfP7HmW?=
 =?us-ascii?Q?EBEEngjuYiAjgSjrKsl8ZwQakblpgDlxphy+1kCmSgQzV21LoKQWu5KfkrE5?=
 =?us-ascii?Q?R3raYx1Wuunb7hnRUwPbOKNclouZTdBb5cJLsGdozxqXS4M+83EHAZjXGghQ?=
 =?us-ascii?Q?bHakQdWbBDe4dB08Eca+unotBBhzwymcvpnCgCKR05dkl11XFoMQbL67N8e1?=
 =?us-ascii?Q?irCP+QU+p0GmUz87SXq+cY5WB5o9Br+QKTYO+Lnw7VnvH1jnSE62Vv7vhXqk?=
 =?us-ascii?Q?RR1t9Zohq0dDrbciI0/wdNpnoQSRxoEAgujW1tEWHLx1qREzZaf3se8QxUiV?=
 =?us-ascii?Q?uEJq+FUui4yk7s8tQEE4hLsH8IqXVvI/IcmJaufL/O/xc5Wc2PoVBDemBwNW?=
 =?us-ascii?Q?vo5Kg/HI/0Qo8hU9lSd16IRZczaAAsu72STl64F44k+DdK+W3LpdY/8bnPQo?=
 =?us-ascii?Q?zmTXpoIB4hbwimTv/yQJtZ8cvfRDA5not5W6GGA63qGsYEzGRjWhpG1ZoHTU?=
 =?us-ascii?Q?6cW62ChJ44kFLe74+zhr44Rj2tIpKic2GENLPmjncdNP/3xwjLsttoJLewd/?=
 =?us-ascii?Q?SuRKf27YNl8XoUjDMg3j/L7BRnvtA7kr4Bo46pv+eemrzguQ/Nd/SCdpViMg?=
 =?us-ascii?Q?kHTac4jpqmj9fCR6Hnui+aeOZqiFpLOg4f5Fu5b4rOqPTsbdxpf1KRssJrnE?=
 =?us-ascii?Q?YjEMS332GFpqtuZ7UC02IOhmgHEVm++TU67XbroaLky84KHJqCQzDX0LEK9R?=
 =?us-ascii?Q?aBoSBnPOr2lDkfqM+oAPatqXNhYnjFHIK9w04BrnVe0IdCUkt9BHgNUzU4GD?=
 =?us-ascii?Q?lWQC+BSxXwmNloUkHx5XL3TrSe/lY+YPAthekDWpmsOHX3QHdPWAjrjfm/0d?=
 =?us-ascii?Q?XvDCnFe0GCzon9j/A4ThJ3NOo+fJEVlBfStlhENiU+q7Teov2gNP1qgKvTbO?=
 =?us-ascii?Q?N8e8Eopfni9gfrZi6yueElsWypzly1ctd2Ec5dSeciYEnxTDBTc+WTsfAYUS?=
 =?us-ascii?Q?6ukm7E8zWimGrQCKu10FE9oVgXg/MglMbAIYrjg13NvM6blOQCj+8AWoWHNu?=
 =?us-ascii?Q?tHVoTiFg9/A7SqdvtI69D4fva/f0TZS/pdgkGR69S9VudHwTwPb5ZrxzmlPF?=
 =?us-ascii?Q?oKHTs6iSw0s2TTcKwRGjb7bgMyZE4FZJhVM+HC7hnB/OG7EfwcDVVRa/e1/H?=
 =?us-ascii?Q?1hry02sMPLgTHdoIStfe0/7Ga/ggaBsdlJ6A+Q46y5qs29o0x3NCVL7aaDg2?=
 =?us-ascii?Q?m+ZgQ8AhQOULnvGbk9/DCmwAdKuKW2uN8xcOamogXIrue0BAN92CsppySN99?=
 =?us-ascii?Q?vfPJq7UhlA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e465624-b87d-4fe3-844d-08dea691b9c8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 08:23:15.2837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IXSEIgOs+IqjWYME2APrTwaDnIkN3KZDu1aT2UWhUTwStThDyPJ4B+T3nwbwl1SfFKY6nqTk9ShsaZjPCS/9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7036
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

From: Simona Toaca <simona.toaca@nxp.com>

This command exposes 3 methods:
- check -> checks if the data in volatile memory is valid
	   (integrity check)
- save  -> saves the data to non-volatile memory and
	   erases the data in volatile memory
- erase	-> erases the data in non-volatile memory

cmd_qb can be used either directly in the U-Boot console
or in an uuu script to save the QB data during flashing.
It supports specifying a different boot medium than the
current boot device for saving the data.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 arch/arm/mach-imx/Kconfig  |  11 ++++
 arch/arm/mach-imx/Makefile |   1 +
 arch/arm/mach-imx/cmd_qb.c | 102 +++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 arch/arm/mach-imx/cmd_qb.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index bb62a0cf2f6..a40baf24631 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -80,6 +80,17 @@ config IMX_QB
 	  memory to non-volatile storage. OEI uses the saved data to
 	  run Quickboot flow and skip re-training the DDR PHY.
 
+config CMD_IMX_QB
+	bool "Support the 'qb' command"
+	default y
+	depends on IMX_QB
+	help
+	  Enable qb command to write/erase DDR quick boot training
+	  data to/from a chosen boot device. Using 'qb save/erase'
+	  without arguments implies using the current boot device's
+	  first bootable partition (e.g. boot0 for eMMC). For use in
+	  uuu scripts, the boot device must be specified explicitly.
+
 config CMD_BMODE
 	bool "Support the 'bmode' command"
 	default y
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index bf6820de655..43febc10460 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -80,6 +80,7 @@ endif
 ifneq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_CMD_BMODE) += cmd_bmode.o
 obj-$(CONFIG_CMD_HDMIDETECT) += cmd_hdmidet.o
+obj-$(CONFIG_CMD_IMX_QB) += cmd_qb.o
 obj-$(CONFIG_CMD_DEKBLOB) += cmd_dek.o
 obj-$(CONFIG_CMD_NANDBCB) += cmd_nandbcb.o
 endif
diff --git a/arch/arm/mach-imx/cmd_qb.c b/arch/arm/mach-imx/cmd_qb.c
new file mode 100644
index 00000000000..633d83d3abd
--- /dev/null
+++ b/arch/arm/mach-imx/cmd_qb.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0+
+/**
+ * Copyright 2024-2026 NXP
+ */
+#include <command.h>
+#include <spl.h>
+#include <stdlib.h>
+
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <asm/mach-imx/qb.h>
+
+static void parse_qb_args(int argc, char * const argv[],
+			  const char **ifname, const char **dev)
+{
+	/* qb save/erase -> use boot device */
+	if (argc < 2) {
+		*ifname = "auto";
+		return;
+	}
+
+	*ifname = argv[1];
+
+	if (argc == 3)
+		*dev = argv[2];
+}
+
+static int do_qb(struct cmd_tbl *cmdtp, int flag, int argc,
+		 char * const argv[], bool save)
+{
+	const char *ifname, *dev;
+
+	parse_qb_args(argc, argv, &ifname, &dev);
+
+	if (imx_qb(ifname, dev, save))
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+static int do_qb_check(struct cmd_tbl *cmdtp, int flag,
+		       int argc, char * const argv[])
+{
+	return imx_qb_check() ? CMD_RET_SUCCESS : CMD_RET_FAILURE;
+}
+
+static int do_qb_save(struct cmd_tbl *cmdtp, int flag,
+		      int argc, char * const argv[])
+{
+	return do_qb(cmdtp, flag, argc, argv, true);
+}
+
+static int do_qb_erase(struct cmd_tbl *cmdtp, int flag,
+		       int argc, char * const argv[])
+{
+	return do_qb(cmdtp, flag, argc, argv, false);
+}
+
+static struct cmd_tbl cmd_qb[] = {
+	U_BOOT_CMD_MKENT(check, 1, 1, do_qb_check, "", ""),
+	U_BOOT_CMD_MKENT(save,  3, 1, do_qb_save,  "", ""),
+	U_BOOT_CMD_MKENT(erase, 3, 1, do_qb_erase, "", ""),
+};
+
+static int do_qbops(struct cmd_tbl *cmdtp, int flag, int argc,
+		    char *const argv[])
+{
+	struct cmd_tbl *cp;
+
+	cp = find_cmd_tbl(argv[1], cmd_qb, ARRAY_SIZE(cmd_qb));
+
+	/* Drop the qb command */
+	argc--;
+	argv++;
+
+	if (!cp) {
+		printf("qb: %s: command not found\n", argv[0] ? argv[0] : " ");
+		return CMD_RET_USAGE;
+	}
+
+	if (argc > cp->maxargs) {
+		printf("qb %s: too many arguments: %d > %d\n", cp->name,
+		       argc - 1, cp->maxargs - 1);
+		return CMD_RET_USAGE;
+	}
+
+	if (flag == CMD_FLAG_REPEAT && !cmd_is_repeatable(cp)) {
+		printf("qb %s: repeat flag set but command is not repeatable\n",
+		       cp->name);
+		return CMD_RET_SUCCESS;
+	}
+
+	return cp->cmd(cmdtp, flag, argc, argv);
+}
+
+U_BOOT_CMD(
+	qb, 4, 1, do_qbops,
+	"DDR Quick Boot sub system",
+	"check - check if quick boot data is stored in mem by training flow\n"
+	"qb save [interface] [dev]  - save quick boot data in NVM => trigger quick boot flow\n"
+	"qb erase [interface] [dev] - erase quick boot data from NVM => trigger training flow\n"
+);
-- 
2.43.0

