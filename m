Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02B6C3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 22:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A845E8874A;
	Thu, 11 Jul 2024 00:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="qHVnL0oH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A4D88729; Wed, 10 Jul 2024 23:37:48 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03olkn20800.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2e0d::800])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64E2D8847B
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 23:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVC0/fsci3GOFoQNjOL45cdlJpxuW1d/UhCv+E9jzxUu+spyaNRMVCNsgn5K6Uql7Jg7TdBNXvg9Mr0hI79ioqdKbA7QES/S91lTUHE8n8Wf8JFdLhEIgDWUO/7rUPejGe98V0JOOjV4IQfv3j1PAaSUJSb+Oi1pqWnW6r3yU0/IU9UrZZ+hcB4YRFHJtBf0xix6TWDMOl/al068JDp7DFVdbW5YZf3hzp046Vpq9xLfOZI2xgcahduXxfcTrqJPs++sFRhJwUKqvi3rZNX3682t7QP17/yZfkgaEBB23KMEX9ad7xmlsjHvLzlrGZcUrIApmmV1+0oGIGFErNCi7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+qmviFJQapkt6dVlLRmuj3seK0VkqrIIvWvOLaDzBY=;
 b=dhlTylJXVsRvML3+cWM/NjHVWF7h2dertYLvU3I0epLmyHe61vL1Zfl7syo53r6MP+X3+NJzd0KnerqHkRTkPhsNk2BWfrUpymdANMquivho5isquuIVlCmd6vnAQmzuznfBmGwIUU5wwLpx77l0x/FG1p+qyWe1JksRDY4ld7KLzxWnrKiaIuUn5PZUfBp8bCKDqbFdaisOzV/u/utQuGGHg2Ir6KhKWr4DrYulo6nexixjGhW1se4SruAvjNH0YKbEG49bKcXqSYryD8Lt3a1vf9O3jj/Yj1M3cPkw9W1X/gYt2QJmOYVr3w/BAhgLe2XU1xKyxx8J93zdeq5yrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+qmviFJQapkt6dVlLRmuj3seK0VkqrIIvWvOLaDzBY=;
 b=qHVnL0oHCILFDe5GKnTNH/IDvEhQvYbE9eyb/8jEaEm9QYSEvKLgr1MQS9xCmZXL3T2moWmI7tG/WW0PnERFFjpTVN7+WhkU0vfnZyJsa90jclD8HYlmCyaE0bcWqrsGyP/mHlvTiaKDVE7NpfvAW4cflqsPcM4KD/HbvOBdD9KXFJz/N2uWB8hf1DJUtna4m6DV5KSyqUy/ViQVO5YJhb6vLnKNNz1eKSRhWHlu5QArMFuhbqpeQaGDjmTIjS8dXLKaS+LI4oct4aRJmqR/HEki+Ffv0BLKnQXhwpOUVrhu19mWWnc03WJCwOY8k4B2o772MBllxopIoNN11boN3Q==
Received: from PAWP194MB2055.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:337::6)
 by PR3P194MB1527.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 21:37:45 +0000
Received: from PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
 ([fe80::3a33:7614:4563:6c99]) by PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
 ([fe80::3a33:7614:4563:6c99%6]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 21:37:45 +0000
From: Francois Berder <fberder@outlook.fr>
To: u-boot@lists.denx.de
Cc: Shengzhou.Liu@nxp.com, trini@konsulko.com,
 Francois Berder <fberder@outlook.fr>
Subject: [PATCH] board: freescale: Replace invalid usage of sprintf by strcat
Date: Wed, 10 Jul 2024 23:37:35 +0200
Message-ID: <PAWP194MB2055C82705BDFCD5C0C4DF8EDAA42@PAWP194MB2055.EURP194.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [TwIrC+ZtOkfBIZCU62lQIZyLMD9dXqhR7+LL0T2lCVs=]
X-ClientProxiedBy: DU6P191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::26) To PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:102:337::6)
X-Microsoft-Original-Message-ID: <20240710213735.1154171-1-fberder@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWP194MB2055:EE_|PR3P194MB1527:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e83ce31-9979-4366-b700-08dca12888e2
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info: tBWmngAMWQ757ULdaxsiRzN+0fc0yQNuqjEd0KOWBJLbk2qokh9Rv/bkJbv7Y3kGCtcD1Z5nehPgquSqaoodb8k4u6FsMFXfY8IjZ/Ob8PR5DvDb6slWauD4dsotX0zuX7+9dLqfvCMUzPQnYKdIhsCfl3Kbn5FiY/AstEBsWLTl6mWawoQw0DDr6uJ78yjV39yRGsFaG1JnuDm6+o/wasL+wzXBc5i8lqyAAxTVwoFFl2acua/6CSaQ/sGTStXl3HKTKxbzfghZN0Lj+92NFcxnqpM9LwHLNgtHmDy+QEwX046ZLOXfTOg0NRLwvW9Gg2wTAKul6klHitvP3DrCCYVaAzZCjo8Sty5zgwNlK1elD/+GePSiw6AQwsOiHtUyzVawMQM1YO2TfZUSMvFHblQOkYR5L49zHy6OKFDwCmUOKqGCaPhotHMp14OP/X21UKk/m4yzveQhacFbGOcR73hL0dOKOWpkBKWTgtbNqSS7+olNs271H+NKctyPwwUHyV/tfNgB8FO9sLHJMMoSXJvjS6moNENyj/Q5hzvzQnF2oDauN24w8sik5FmWMw4pTQePZqennCf8jIWKy9NOGSo4PfDmZLsIZftnGLdAc2nLgWVDeKVEezo8A0+e6Qld8w6JrUmEJPSlb4ljASJmbAAWJno7OwyH3GxcCrYPM0w=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ClW4KrAvPPfFtiP6585tz7iFJ1C/gGIHFOG0dga4hPFeiIEZCkUQbKRkhUN?=
 =?us-ascii?Q?DpnygDktPM3HF5is6xGxzJoXHwdtthgYxElpyeBkVdphH+N8pR/75NN4L8Ym?=
 =?us-ascii?Q?82t1YyyZm7kHWsh3xkerFeZeU9MoaDiO0stbl5gzWqV1c5AGGUdxNRZEN03K?=
 =?us-ascii?Q?RIdCuNYaC9G7nelqA9NX8ybjx3PODK0V1fR2S/AhzVuXOpfRVlcrZCHUtUUf?=
 =?us-ascii?Q?TUjTK+eyJFUprbMLSFDXAdz7+Z/JUYfIdnRGh65s8KEoDcucNoaEkAbtAADd?=
 =?us-ascii?Q?t2I8vDwDImt0ckZB5HNgBYDpeqE8TG4COwH1SKBqXaXeLhfYcPe5aDfDEdRe?=
 =?us-ascii?Q?0LKzLoOKC5oe6BR+xQstVZ0jdcxg+r8bjhWonKhdr6ieOj7R5yX4GXbqxoJG?=
 =?us-ascii?Q?JdFiW8DqwcE0liRresnG7TeiDH0wV9kGaGc42qGbi1m/EX7mpuD9rFT05rlc?=
 =?us-ascii?Q?hhWH8bxu6ksqMd7HpceWXSZLsZDQGE8G93rCyPc/qpnBgyyQfaS8RpEiRgrI?=
 =?us-ascii?Q?cPlxt7dxMseImlt3H/lZmUB0AcUczpDLt2nj2heDEWEiC340sy9HoV94eh5Y?=
 =?us-ascii?Q?6qtx/2+MXfDhK11mXoqE5N8F4aZPaybbI7LliR3liSGqEdaopH7q4OVfc++1?=
 =?us-ascii?Q?B0w8A6c5uqWKDTrtb6oxj54GvkE88D+SB1YdfeJ2x678MtIXx42a4Gv9NOxc?=
 =?us-ascii?Q?6xgZAHtirJ+BHqCbDFwc+8+C1IWkPZNzp4c0hxTNUEBBNDUeOZqBLKFFACPX?=
 =?us-ascii?Q?5unaXQc+hA433GeyUSbU8bXvyto11hDmx/zTLsCEnQhZTqM6aujaCMeK+efz?=
 =?us-ascii?Q?/We9PAr2NprXChsaEQ/FlXfVbl+3mp8O50w6vmHn0F12CrY/5qQFP1fkRO3D?=
 =?us-ascii?Q?Pjkj7aZkCbb0AhorZWCGeM6vm5pPDfXH0VbmBN/Sn4YQ4k48Iqj4QWlIJ4Dp?=
 =?us-ascii?Q?mNOAcKS6wSv5N6W8Duuhx4GR7QVgbZek9ilk6lrpHclLJNkfjPOMupQKrjCe?=
 =?us-ascii?Q?45c2Oqhga2BP7qL9KcQ7UYKQn3U+sv2NQ2awtenRdMocAWqh00KLmPAkmj3W?=
 =?us-ascii?Q?430GGy7JfZBuSyCzUSRflxr6GzpYS5EuJzvoVO+ks2/52tVZECkEXPTlWJmk?=
 =?us-ascii?Q?QEhZxrGBBCsJ/xqz8ykU/Snp4GCCMO6xK+B1EyGRiNdkawlBhzYXAJf01Qo5?=
 =?us-ascii?Q?boUFvSKXmTmAszMRJbvCfDYCOYNKTItC18bS6yJDdK9zYr2BWz9HUm2yMEw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-43ca8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e83ce31-9979-4366-b700-08dca12888e2
X-MS-Exchange-CrossTenant-AuthSource: PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 21:37:45.2174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P194MB1527
X-Mailman-Approved-At: Thu, 11 Jul 2024 00:51:03 +0200
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

buf was used as destination and as parameter to sprintf
which triggers an undefined behaviour.
This commit removes this usage of sprintf and uses strcat
to append strings to buf variable.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 board/freescale/t208xqds/eth_t208xqds.c | 40 ++++++++++++-------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/board/freescale/t208xqds/eth_t208xqds.c b/board/freescale/t208xqds/eth_t208xqds.c
index 9f299227e2..b55078c8fe 100644
--- a/board/freescale/t208xqds/eth_t208xqds.c
+++ b/board/freescale/t208xqds/eth_t208xqds.c
@@ -210,8 +210,8 @@ void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
 				fdt_set_phy_handle(fdt, compat, addr,
 						   "phy_1gkx1");
 				fdt_status_okay_by_alias(fdt, "1gkx_pcs_mdio1");
-				sprintf(buf, "%s%s%s", buf, "lane-c,",
-						(char *)lane_mode[0]);
+				strcat(buf, "lane-c,");
+				strcat(buf, (char *)lane_mode[0]);
 				out_be32(&srds_regs->srdspccr1, srds1_pccr1 |
 					 PCCR1_SGMIIH_KX_MASK);
 				break;
@@ -222,8 +222,8 @@ void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
 				fdt_set_phy_handle(fdt, compat, addr,
 						   "phy_1gkx2");
 				fdt_status_okay_by_alias(fdt, "1gkx_pcs_mdio2");
-				sprintf(buf, "%s%s%s", buf, "lane-d,",
-						(char *)lane_mode[0]);
+				strcat(buf, "lane-d,");
+				strcat(buf, (char *)lane_mode[0]);
 				out_be32(&srds_regs->srdspccr1, srds1_pccr1 |
 					 PCCR1_SGMIIG_KX_MASK);
 				break;
@@ -234,8 +234,8 @@ void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
 				fdt_set_phy_handle(fdt, compat, addr,
 						   "phy_1gkx9");
 				fdt_status_okay_by_alias(fdt, "1gkx_pcs_mdio9");
-				sprintf(buf, "%s%s%s", buf, "lane-a,",
-						(char *)lane_mode[0]);
+				strcat(buf, "lane-a,");
+				strcat(buf, (char *)lane_mode[0]);
 				out_be32(&srds_regs->srdspccr1, srds1_pccr1 |
 					 PCCR1_SGMIIE_KX_MASK);
 				break;
@@ -247,8 +247,8 @@ void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
 						   "phy_1gkx10");
 				fdt_status_okay_by_alias(fdt,
 							 "1gkx_pcs_mdio10");
-				sprintf(buf, "%s%s%s", buf, "lane-b,",
-						(char *)lane_mode[0]);
+				strcat(buf, "lane-b,");
+				strcat(buf, (char *)lane_mode[0]);
 				out_be32(&srds_regs->srdspccr1, srds1_pccr1 |
 					 PCCR1_SGMIIF_KX_MASK);
 				break;
@@ -269,8 +269,8 @@ void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
 				fdt_set_phy_handle(fdt, compat, addr,
 						   "phy_1gkx5");
 				fdt_status_okay_by_alias(fdt, "1gkx_pcs_mdio5");
-				sprintf(buf, "%s%s%s", buf, "lane-g,",
-						(char *)lane_mode[0]);
+				strcat(buf, "lane-g,");
+				strcat(buf, (char *)lane_mode[0]);
 				out_be32(&srds_regs->srdspccr1, srds1_pccr1 |
 					 PCCR1_SGMIIC_KX_MASK);
 				break;
@@ -281,8 +281,8 @@ void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
 				fdt_set_phy_handle(fdt, compat, addr,
 						   "phy_1gkx6");
 				fdt_status_okay_by_alias(fdt, "1gkx_pcs_mdio6");
-				sprintf(buf, "%s%s%s", buf, "lane-h,",
-						(char *)lane_mode[0]);
+				strcat(buf, "lane-h,");
+				strcat(buf, (char *)lane_mode[0]);
 				out_be32(&srds_regs->srdspccr1, srds1_pccr1 |
 					 PCCR1_SGMIID_KX_MASK);
 				break;
@@ -328,8 +328,8 @@ void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
 				fdt_set_phy_handle(fdt, compat, addr,
 						"phy_xfi9");
 				fdt_status_okay_by_alias(fdt, "xfi_pcs_mdio9");
-				sprintf(buf, "%s%s%s", buf, "lane-a,",
-						(char *)lane_mode[1]);
+				strcat(buf, "lane-a,");
+				strcat(buf, (char *)lane_mode[1]);
 			}
 				break;
 			case FM1_10GEC2:
@@ -339,8 +339,8 @@ void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
 				fdt_set_phy_handle(fdt, compat, addr,
 						"phy_xfi10");
 				fdt_status_okay_by_alias(fdt, "xfi_pcs_mdio10");
-				sprintf(buf, "%s%s%s", buf, "lane-b,",
-						(char *)lane_mode[1]);
+				strcat(buf, "lane-b,");
+				strcat(buf, (char *)lane_mode[1]);
 			}
 				break;
 			case FM1_10GEC3:
@@ -350,8 +350,8 @@ void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
 				fdt_set_phy_handle(fdt, compat, addr,
 						"phy_xfi1");
 				fdt_status_okay_by_alias(fdt, "xfi_pcs_mdio1");
-				sprintf(buf, "%s%s%s", buf, "lane-c,",
-						(char *)lane_mode[1]);
+				strcat(buf, "lane-c,");
+				strcat(buf, (char *)lane_mode[1]);
 			}
 				break;
 			case FM1_10GEC4:
@@ -361,8 +361,8 @@ void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
 				fdt_set_phy_handle(fdt, compat, addr,
 						"phy_xfi2");
 				fdt_status_okay_by_alias(fdt, "xfi_pcs_mdio2");
-				sprintf(buf, "%s%s%s", buf, "lane-d,",
-						(char *)lane_mode[1]);
+				strcat(buf, "lane-d,");
+				strcat(buf, (char *)lane_mode[1]);
 			}
 				break;
 			default:
-- 
2.34.1

