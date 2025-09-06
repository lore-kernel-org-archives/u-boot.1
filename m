Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D77CAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B2518350A;
	Tue, 16 Sep 2025 11:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wLvWHPZ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70B9D835B3; Tue, 16 Sep 2025 11:45:56 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C8DE83071
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7FsCPJQMhd3v26+iqUQIakwr41UmmvOPbmUJQonqj0qnawfQ7osMc5VmwKdD9NvZP4Ii7Ml/T12uI3QYYcrCyG+ZT6KUOQ/J2nrrRyFXg2idTayKGS5T5rUSAzcyHsZnKBFcnwkZFW7tdKXwPuh7TdS0hL7c/8XZkFRg5VOeP6bpDBSBQikeDPBZsoXZI4ZK6OdRLmzvjDzdJNL4xnMHr+jXYgEY3f1N1upo/FVj22sZ6JC798fltRDi7j1cW/TlLNxMzxBLuDOKv/gV8u/5C5zcH6Ezg7kxetWRlCsvq6g7I8Npa0rVaTNkmpNjtZi0H5KfPocrsrxvrJRnIQnGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyB5jxAf62MztGblKrhBPOnFjBmQbphmDB9/L/qr/Uw=;
 b=wd/FNXxiaYAVwZ8QHyE0VDPkRj+v5nHg9nhWpgBNvIgwM0zDI+ncZmIt5nYEPa0HT5ygTRudrvoIe3JMBltbsomNFaVz04B/292yX1ji0vKrsP0gys5t2+LqHols1Wl9Eq0ceARYiF2wS3WZQVtIFmOJy6M+m5iy1nJKf2zFwcRiNeHjYmnVjGlJszL6QJb3yVNqA+tj1l5eAE0NMp/w6o3x3K65x44J5YxNEr6Pbv1RwgJzZs2ZjaJp0Pv5oqZpdweJe7f/fW1zXjSTVv3vRpLAyPCgJtD7gdQ7buA988sHP2COSQ5FusG3J9xRhoFjDlkOY7EpSqmO+Ut4FZb+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyB5jxAf62MztGblKrhBPOnFjBmQbphmDB9/L/qr/Uw=;
 b=wLvWHPZ9ZgxdYzuLoicTJk9+xRKZBt64P1PHneA+M5zyFyQ9KWLyZ0bI7dYnTGlfxPvhbrhuvF2zYvLzuVn4nLS1nI70XfKot4co2Bzrnj4oINGcMWUCzsHxvr4B2AIFEtvmazl5URqoC3evk8QlxIPkt1qw1GIyvwVgTCvvcq6qYdwiii2Hf4Hdj7Pl+FZ6ixnh22kyaNs2crMWScFh1MuuY2g/yPoXSLXY1dP6AIdYx74YeroDuz153bHzxWBzsVVc6hw9wiD+VgN8sYRUjUNaCVxoLSQXZQMbBOyJjmb6oQQRKvwKqqy3xNFtR3W1Jdyb1PfTyTn6PG+BF44iSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB9391.eurprd04.prod.outlook.com (2603:10a6:102:2aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 09:45:50 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:45:50 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: [v2 09/12] imx: ele_ahab: Implement display_life_cycle() for i.MX95
Date: Sun,  7 Sep 2025 04:37:39 +0800
Message-ID: <20250906203743.3352805-10-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
References: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5bd106-f13b-4fb1-1aa4-08ddf505d1ec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XrHEJ1uSZchYZr9CDea98k5ujQz2zErTb4c2KuV58siX/m+PUXJ/QpAuIEGY?=
 =?us-ascii?Q?OkOTnHt5WImasHtKVnLioUeig/780SW8yrZ5Xvzo4bhyFrIOFTFc41N5esqK?=
 =?us-ascii?Q?D0RnN5WK7VJFFLeWAJOh+VycJObelYjm6WPBzVdGVNQ9LPbSpwvt/IRBaxxj?=
 =?us-ascii?Q?ycKDwGdm0vOZS8rSHlh+IIL6krPjvHJsJbeKqzqy4hdRBRZP/e0mY9xR1Xxv?=
 =?us-ascii?Q?9dE/7N887Uxr9oJqAiMTtK/b6r5DC6MfjBwnfi4RY70eaIVFQdOTpHyTsFhl?=
 =?us-ascii?Q?POFpZSa953LfQVGzlpvKN1eBYVIfL6dlWHGC6pyQtMYhaBFI7BYriKvtXDg7?=
 =?us-ascii?Q?JLqBtOeX8A/6uYj35LROniHjeL09ZHdQPdQyZ+WZNsjPMhX50YA4nNKwakcY?=
 =?us-ascii?Q?2kZOa/5gOHF/T7TNmOKawJeNEA13J0i3HdOkGZYjHmFD5gE1YpthpTmNyt7z?=
 =?us-ascii?Q?HPQTneV4p0Jg8L4XQAPCU2WcpUvBTEJNbgAHDwGUCSq0aYORMy78UHnWbuM0?=
 =?us-ascii?Q?lc2kk4Qkg/My308q4ahgpqXtfbffQuVwrG201kmU8a2bbx/DuWV5KIe2hcD2?=
 =?us-ascii?Q?D2mwkGf99zYH940efNETKWuGWwblwF6fJMtOom1BsSB1vie/b+e/hf9aN6VK?=
 =?us-ascii?Q?RKBs32AuCi9snqt59RePGfKsKuQkDXS+folGJhM5gLoPAh/wWTXYn/IIdcbz?=
 =?us-ascii?Q?LRCvJtvbiqHx6DGmFNn/SbNzsG6GWFUOXPKXhL4nF8AkjvlEKNwU8PtBxgvT?=
 =?us-ascii?Q?SNO5dYIwPHOiwd9D8+u+ZBMuGRTzCWVBBXG+14HXce/3YkqEfzbJ5aA1f7q1?=
 =?us-ascii?Q?yMlEa1wzx4TTM6YvaIYbUDkutPYwvY46bfecH10BwzNiWqlJm4x2kiCMO+pV?=
 =?us-ascii?Q?xySCASakqEe0/ATpcv+lDZBLM/n8Kut+laHiYrGTP2vwL9RzHS0wVG0zZiil?=
 =?us-ascii?Q?iigTQxLmaeVaWMWOPolzSRjeB3DeS9iGptaM+syUfg6/N7hO346YKxvrgf6X?=
 =?us-ascii?Q?fYlSuHcINomzkt3iKpMgmOE+NkCQqmvjalmZT/MGHIaiEeR/6urMIMs3hEhn?=
 =?us-ascii?Q?Nu6nLPerEhQxfaUdpelacQTPd+gVDdqD5kWgZOBu6e2ICDGoWmisaaTsr57N?=
 =?us-ascii?Q?haHKlPLuRoAmZCuIlc9cJbeCPw+HpvTSOXhC2cTDwiJuPhjUd80PvMUzME7f?=
 =?us-ascii?Q?fMJWwx1rUpxK/YFoTBMAxmOPSuosYGgCdHheVkeClKsOCbcm2xemxHjbTgiL?=
 =?us-ascii?Q?kXt7UypPnbsguB627EoleHEoQcw5oHMaGIbvxroVT+hZPd+S5eklbOx3rp5D?=
 =?us-ascii?Q?3TQ38dTOEA8dxzDQ02bZumR259xTTndY/GVqImsWxSb/u+RriiY3LTEdFoI/?=
 =?us-ascii?Q?gryAqxz0TykfT8b3jAMTRJr695kjG1MrP/RHtQyBVf6oxhlj2YOYUj552Jqz?=
 =?us-ascii?Q?NwHRFvdBepdpCQcEQK6nzF2t+WsRUhFxLNuPopbnA9jNTELlKAXOXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?krPqPRDeEhdotV3GZ7c34B7lp7pVKqgL/yZVFr8DBZnz/1Q4x9v89Yu9Avry?=
 =?us-ascii?Q?c1tEJ9jIcZhbgkaoat9tqSyLaAqsFXj8X1awL+cfm29dn/zzEdmwOw3cSIxH?=
 =?us-ascii?Q?3ttosEApka70bVrV57gC4YskL8b4Lfz0KYFWjfWG9jweVSMt9lYy2BzxFVxF?=
 =?us-ascii?Q?11Grvj3AwOQe8WkStBl+Wj+Hq3TifneJeny1X22fg+vqlK9TrXP5+4HAkGYP?=
 =?us-ascii?Q?CL2+L51yP30iQqmxmWQF3kM4hvU1nn7tuW5weFc/So1xxba8FnwuMTgTNKZM?=
 =?us-ascii?Q?qjmgRHZBlkLpKUTmxdP8mydSfWjt3VjhD8bXUT3Eo9MWA/v3pyVzp248G/QM?=
 =?us-ascii?Q?ZJCSkQYpU3u/xcwL1dam1Bq6XjgjboxFqm+LX+tJNd1vB3Y4Eqlmgln0XVvT?=
 =?us-ascii?Q?pp1hrBzo1MutgpP+YWBFwbOIIw8+ltSNkpIjnvuUlgGSFPyQ485Q4Nim3EH3?=
 =?us-ascii?Q?dMnTgllya0p0z3sl5o51Zjgw1FNSguM2/GMTejy1fTvh9E7QVMRLfzCaLV7i?=
 =?us-ascii?Q?kMllf6BBlRkZQaKmU8xEYiJgiC+94Q1pss5etJ+HPsyy/vNaf6CKTmKrtOyL?=
 =?us-ascii?Q?p9QqTOJpcq8qX9SUIv3nNEVuTGdipOi0Ui13bB4de5774JJuj+MOuEwV4Cta?=
 =?us-ascii?Q?Zb+IhkgdVnjDaH6VzjEeeDLKGvht+ADUtimoCDGAUKwFNYGUIva9tj6Hq2xM?=
 =?us-ascii?Q?gQCGRkcdW5nFpTV5G9F/rvdyik8y/jGMtWWZEUiL19bn9uzY+rLLE2eoglZB?=
 =?us-ascii?Q?/nHHtSDs8E4CAReQk2bfZWX9JgoZPGXaFZbRwDgEyhBM0FIImqC/xLXeB7A6?=
 =?us-ascii?Q?FA1wC7fiERKQrcSSSpOYE7zdTueAzoSjcWmVM8H2kk6PcDoorT4FXUtAZEp4?=
 =?us-ascii?Q?bmLs5EJv/vHVELhL8pc4/CsapNF+evXLCVlPJq4FFuQyAJdWW/C+E6Hfryal?=
 =?us-ascii?Q?Nr9od4QQ+UmNIxihwZUP1SwF3yLFLU4dXtDN0bL/+fxaTRyKDDc2j8ebco3f?=
 =?us-ascii?Q?Re0cFQQIIWFzURzqMC+doTFGm+Jq/3JIeFgzestIidUGMCDLxQ5ytZuuhQBL?=
 =?us-ascii?Q?Fyp39Ra8CVEESOO86+SXxmSjWDr0c/WsQrvk9Vve1xJUGjxxhidx8yi6JQn9?=
 =?us-ascii?Q?7amaKl0CeZth/Ht4c6KGvwdMzRTOsNcvQ69vMKgc0NKHVhMZueNNRe1BHFtv?=
 =?us-ascii?Q?Bjwy3erFJcFr1i3iM2es7YQBUSDuPcU1+Y5Fxy8aT1krmckAkgli1ozoNPFG?=
 =?us-ascii?Q?wAqnb0RRxlTWXRdcmsdBPgpjhERiBYVbrFahuSEfyAXF4ef+A7gVxwnlWImJ?=
 =?us-ascii?Q?aoKEAkmaKfKq9KNJyswJkOl/swFHnepzwsMUXedbisvd1G7FAFrOE8III7WM?=
 =?us-ascii?Q?bbPdqKRAr+UBeaYfHo4eZxMm+BIv4Mj8rDsNmRjgthQRDyxd3SK3pB5y6HrF?=
 =?us-ascii?Q?yHO7pYvJfwqKQKkHW6AjaPJjdFTrJzFdneWCGDN0IZXt1T7dXlbx8I5/t8Z0?=
 =?us-ascii?Q?0Dgzg39mAY9E3doOnCEd0CuIEbzgODu9iReVMd0gmTdM4ZOUJN6IhA0vFYil?=
 =?us-ascii?Q?1GEPkPglEDbdyfIPMv76YUqHuOHaOu5sFBdz7rlG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5bd106-f13b-4fb1-1aa4-08ddf505d1ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:45:50.4201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgiTnmHEkx88MewQm3AweWsPvmYO4lX1KHafGRhn4/H3JOc5mI1iOyaWGL0hJ5CpydNbPwH8LhwKLOKx/i1uoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9391
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

From: Ye Li <ye.li@nxp.com>

The register reflects lifecycle and some lifecycle-derived state of
i.MX95 has new offset address and layout, so display_life_cycle() is
added specifically for it.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/ele_ahab.c | 55 ++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 647daeb6562..39aba65d29e 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -411,6 +411,54 @@ static int do_authenticate(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+#if IS_ENABLED(CONFIG_IMX95)
+#define FSB_LC_OFFSET 0x414
+#define LC_OEM_OPEN 0x10
+static void display_life_cycle(u32 lc)
+{
+	printf("Lifecycle: 0x%08X, ", lc);
+	switch (lc) {
+	case 0x1:
+		printf("BLANK\n\n");
+		break;
+	case 0x2:
+		printf("FAB Default\n\n");
+		break;
+	case 0x4:
+		printf("FAB\n\n");
+		break;
+	case 0x8:
+		printf("NXP Provisioned\n\n");
+		break;
+	case 0x10:
+		printf("OEM Open\n\n");
+		break;
+	case 0x20:
+		printf("OEM secure world closed\n\n");
+		break;
+	case 0x40:
+		printf("OEM closed\n\n");
+		break;
+	case 0x80:
+		printf("OEM Locked\n\n");
+		break;
+	case 0x100:
+		printf("Field Return OEM\n\n");
+		break;
+	case 0x200:
+		printf("Field Return NXP\n\n");
+		break;
+	case 0x400:
+		printf("BRICKED\n\n");
+		break;
+	default:
+		printf("Unknown\n\n");
+		break;
+	}
+}
+#else
+#define FSB_LC_OFFSET 0x41c
+#define LC_OEM_OPEN 0x8
 static void display_life_cycle(u32 lc)
 {
 	printf("Lifecycle: 0x%08X, ", lc);
@@ -447,6 +495,7 @@ static void display_life_cycle(u32 lc)
 		break;
 	}
 }
+#endif
 
 static int confirm_close(void)
 {
@@ -474,10 +523,10 @@ static int do_ahab_close(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!confirm_close())
 		return -EACCES;
 
-	lc = readl(FSB_BASE_ADDR + 0x41c);
+	lc = readl(FSB_BASE_ADDR + FSB_LC_OFFSET);
 	lc &= 0x3ff;
 
-	if (lc != 0x8) {
+	if (lc != LC_OEM_OPEN) {
 		puts("Current lifecycle is NOT OEM open, can't move to OEM closed\n");
 		display_life_cycle(lc);
 		return -EPERM;
@@ -540,7 +589,7 @@ static int do_ahab_status(struct cmd_tbl *cmdtp, int flag, int argc, char *const
 	u32 cnt = AHAB_MAX_EVENTS;
 	int ret;
 
-	lc = readl(FSB_BASE_ADDR + 0x41c);
+	lc = readl(FSB_BASE_ADDR + FSB_LC_OFFSET);
 	lc &= 0x3ff;
 
 	display_life_cycle(lc);
-- 
2.43.0

