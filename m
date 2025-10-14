Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B45CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 11:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42BD1831D6;
	Tue, 14 Oct 2025 13:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HkzWFPyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A36B831D5; Tue, 14 Oct 2025 13:19:14 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 585B5802C1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 13:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCAbWdNw66UeTItCRu7zKWErBttchCtJSDb+crWZijfGyGSckHFWzFo2+b1fz+1l7JlLXrU5Un2B3N4FBPjVkq4pn+GCGoC3BJZpF1CTu9T3stpDjx1OEhyfQJYcbcmLHpLTBe1y1XRrVnEKMlQeNT869kUQARLF4lipDr4QeuzF1KOXTvTe6jDbOHcCPXO7jTrdgOgX6jfX1To3V9S6uoLnU9kBx3Ejibm407PLXmVhBhGWXOFbCZ92O3MV45lisNOTzYGGYM0fCo+XT4ya0ZUZoBOpEUtHhrhUEc3rUcXFR/3HHPPpyIhKcFUKBral/uEuXkCXKt+UJXefB1MYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ex0UENAaP5Oid3BmwCUH2u2C6W5C9UVRlZ1RcM1ycKk=;
 b=U72HYDWYbxoatTZQDwnhSZ2LckZZsJKV1+sgVHLq/lTlWJGHoyIZv89DHSknUDRfDaYNdmwHvyMXPRE/ZNt/uIrjk7v5kxMzO3GYzRbwXFjgzx14+ZMzzNLid0sbQQcyX3ZVGXzkwjmgTdWMTSJwqoiO3rpj7BJDyOONWuHYlGcSKDY92hNvP86UrfBmtH2CCvp6tGQySki4cc05Z/5lAkB86INHK3WQmpTPHQWF8GaZfos5xIk4Dtpljdp76DlOF8f5S/6nX/foUvImcMIXoEYOtISXpCh65Bs7dGu7JytGmjHHbdzw0mJC4ojCkgEQMy652Uf1ttk78K4sV3c25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex0UENAaP5Oid3BmwCUH2u2C6W5C9UVRlZ1RcM1ycKk=;
 b=HkzWFPyL214Xu6CJmN0prOBHkM0CNS8gEkILuGSZ5lDZhE84KT8kDdMGQSTxdB56NwNb2hsW9eWv3gve5+2f5NyUgVubU2eUHy1MsjWP8pizVencKrADcs/tDCkI6VQSTDA+nWeUgT66KFKt3Ss3087nE+OPOOZwsUTT+iUFqYzqHu+JBnRE1Hj6Z4LT+AtEWTdD6LFiVvgCfyDyY60rq274ojqZii9UEYTbkRQWr3lqLpOBzBTKLuvy9XCcN3MUp29hNFaAp1eBiq6MCSzlDYbSMadVmoY7yqRAzcdVl/nA6qmEQpzTQOXe4zsswmEuV7ALK3B4ioNoFwh7C3hqzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8128.eurprd04.prod.outlook.com (2603:10a6:102:1c8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 11:19:10 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 11:19:10 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de, uboot-imx@nxp.com, trini@konsulko.com,
 sbabic@nabladev.com, festevam@gmail.com, jagan@amarulasolutions.com
Cc: ye.li@nxp.com, alice.guo@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com,
 sjg@chromium.org, mkorpershoek@kernel.org, marek.vasut@mailbox.org
Subject: [PATCH v1 3/4] imx94_evk: Get ownership of XSPI control registers
 protected by GMID in SPL
Date: Tue, 14 Oct 2025 19:17:55 +0800
Message-ID: <20251014111756.446456-4-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014111756.446456-1-alice.guo@oss.nxp.com>
References: <20251014111756.446456-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAXPR04MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d768fb7-29f2-4179-d0ac-08de0b137edd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?90qfEuMy6KyaoxrP/KUSc/BiXVQqKg+B+xzRi6V/G2vBoYg8lZYhxOg7aitn?=
 =?us-ascii?Q?wxOmnI2Lllso+a6WryCxg0hgm+8XrQo1pYQEc0M6vr3rF5xqlPaRpOlI6RYJ?=
 =?us-ascii?Q?Ab+yfEMVWz6mIBFFMnPndVr9ju9FwxLCgns8m3dadtrKP94V+PsI9VF0HK3A?=
 =?us-ascii?Q?kw/MDU40zxk4HTdbEi4fctsVefR9sWjgwZSCqzqLbUuJpXaOzVrlAejTn5Hp?=
 =?us-ascii?Q?v63HhpHUIu+f0XC+BZSfHmyNqSXjOWyQGw1Bb5uDpSrgFldeYoCw2YyNwevz?=
 =?us-ascii?Q?MNo+7+Fq2Gx0ztgvOGgFT5uUaFDNpm0QnMYFyj27TSx+rJG6PVlGRj+LWh4s?=
 =?us-ascii?Q?9Ah5I0ypWbx3KRA8zLpQqOawhhsdFyGNvFesn39RLvWcMbjJIcKdrTOSfKaR?=
 =?us-ascii?Q?rdMB10nZiRdB1wDqvtvSE89UlHCTNYwkMzKqD0bWQrZkI9Jr2JddkLxxD3M/?=
 =?us-ascii?Q?471RIUnS5jeH/wLmYsiPI0lQZs/fNcpLT27g5yrbBx1R4VKxIb8TU0KW/OCT?=
 =?us-ascii?Q?5wGSy+en9WcO9PxhszFvAoDXiHsxdERGw4d2A9E+4XRkoJa47L4zZs9ea6Z4?=
 =?us-ascii?Q?MDv+KZwAZG1JUMk1HSDiVTYrX7B3l34mVfAhwREo+yg56KX8DDcAwMlLMru2?=
 =?us-ascii?Q?Ics0F4rf0fs4fZhg9bhwGzYAvjc40znwft4KWPpMTH8RlUIrxbmp7M+skV8A?=
 =?us-ascii?Q?KJsYwsEFd51sqWjBK10dlLUTodZUgceeqBVmX9lpbI7Gowx9+W6uQegN2bY6?=
 =?us-ascii?Q?J0nKrTqH6/DZBgzIveMP1m40m4K38VnTyOfCRGVEhGHzHOBKTjM5qoirBgRs?=
 =?us-ascii?Q?SaakS2eCh6ZQMwewOC9XMSdlsVeqosX55Kz8p6iBskRYv9e/s/tl+Wx7KO4I?=
 =?us-ascii?Q?hL+znY+VIcUPEcbZ++IUFFDQfr78Va4rebyymIWQ9x8UgNZ2pzl5yJwPrtyM?=
 =?us-ascii?Q?e71RpVKjbBdnyRMJJt5ZA3UHj9KBSVSun96rpeBDt03IQpzcB3V/y8Q1T5N0?=
 =?us-ascii?Q?f5nj2yn2pwdIaFffFHZD/8G5N02T5kv3l1e3ZSmXqUISiDPWbrQF7iq2mnqx?=
 =?us-ascii?Q?Ghw6VzCNDPVSWiCot4HAR6v9tVqw8Ca0vGj9loJJHbRD08o/syr3GwKW64bl?=
 =?us-ascii?Q?K4LTEGba0XOrZSiZC0Nze15kBPFFcEob1uBfZqDYufitXm1Z+ReEGMji9NiG?=
 =?us-ascii?Q?LAQF4gBTAJbQzCfIqpFok3BQBTkPV5Okix1tb4akOWflKQ2oOuluIkrGj6ra?=
 =?us-ascii?Q?9M441dH6KLgjX9qEaL1YD4GvI+95ZGJvfsaFR9ogh3c/jdus1663xYIcNsdM?=
 =?us-ascii?Q?gJUZL5mTdiFyaZKCofmuIfTBfajNTT5lDz2BASz0rX5CIswBbudEMs6s1bCz?=
 =?us-ascii?Q?vZMMfxCdFORQ1o712jCds5OTvmdoSMOGcLtCbNBB0WnGDsOQBvIy+ttHfR7G?=
 =?us-ascii?Q?6F3H9Y1GSvC9GwPs8HgxsmofOA9TXnvKyzm/xxmcF9tPCw2vUbIlTdoaNJ1v?=
 =?us-ascii?Q?4gCd4cBzJnR+CXhDSXHeQygOX6QYKFRZ9vQd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HIzFbepzL026H1gxuUmfD8CYHQS1Nnq7L+zBUEaJPPHPrgkavCP/yKTMjGin?=
 =?us-ascii?Q?0gHGHgYYiJwK7PYYOuz7A0m9YlLoxzeY7lgbF0QxeKPQbSoqd2nc2/pO+YqD?=
 =?us-ascii?Q?yE7p8YM4slsW/juTNj6kPFWQjt0+n1ZRehucxjmhKU8Duo9VgczUpAJ/XQR0?=
 =?us-ascii?Q?ySp6vR3sb0CDndJ6zsdI+PKNqaDssirvCISsZOJkQITRfY3026ToK45uhF4F?=
 =?us-ascii?Q?JZdP2Hi4QJUqzbDpdFQy5YfkIOdLdTCw7mruJFW9GLa07XSnahNgwjypS/Nh?=
 =?us-ascii?Q?40M89TD1V0yR3PoDTfKFQeqQDzJH8/toSR29N+BunF4hwW5Ej82DgXPqm12Z?=
 =?us-ascii?Q?DimC9QPwVtAzxOQx6W4/HL44rNzCc9/vWOveTxIdpQLvWdmF5eLPDjh3VLio?=
 =?us-ascii?Q?Md192C8z06/o8/jbIsXwn7Utctjbu0lRsPwaVoj9uAe9ZYz1Lt5ARkJGLWhI?=
 =?us-ascii?Q?BH3RGYD8xkhtoxtuJIte9vNBfQb5AyRJJxp4v0zDvOgFEgA+GZH2n645IQjq?=
 =?us-ascii?Q?vQfDmgDM5AWaEEALykR9DHSnpQdG5nwRu/h12siHoJgVIRrFVleztehC57To?=
 =?us-ascii?Q?FvVI6kxmMHruQuQRoDsqqeI+48mngYTPKJFmlMc6uglrWVdPDuT6uVaBbmfk?=
 =?us-ascii?Q?aFB+8YZKFZYGLsZC16Pff+RxsEhXiOjjeMVDvi1ST2a41rrCMutFMaM6T0p5?=
 =?us-ascii?Q?U25b/XNhHqL43zLzvVUq1qAXl9+arHndcKU6RIjh93no4XYxPMb3clnfeusE?=
 =?us-ascii?Q?IeNrjrhlBxt96p8mRTKgVGcZyPW4Q8icCdE6Ta8mTFZwGdDZOuiGKnEzIBUf?=
 =?us-ascii?Q?VP3XhRH6bU02QDhh1XscNjNBObOAUqoecfdcAil5ytxDLNRlAq1RZdpwAQQa?=
 =?us-ascii?Q?k59cwRUJeyQWNXZLwV8IOFK87ZrZQrMdh2sztRX+o9UNN5NUmqLnZCOZA4GQ?=
 =?us-ascii?Q?DEt40G79wFHjmwYhs0xhkD3JctQnWsHMQ9F97q9mlbugN8g0vqkUfzpGe3NP?=
 =?us-ascii?Q?HRgX3ILONi+qD3o1sc8CleoOdM7itqjOqrt8f4vK+Z2+kcxikvSsqFaECKbP?=
 =?us-ascii?Q?84QPEuwlwB0o0icp8uXlCnUArIgLwzA8eztKRbUSD6GFr+a0FzxaAdnE17xE?=
 =?us-ascii?Q?x4t9jBV09xIhzzqc2rf3hqXxc+36VjmGBnEMYsCyiHoOQsMnYqDQMf7sGHfu?=
 =?us-ascii?Q?v3JySBC56rQ8qTv3G7EkeeuwkWGiN5YomgP7/0G7S+Pf6RG0ZMiqPl/Znext?=
 =?us-ascii?Q?YaEauBDYtqn/wlYI/YigsH6FF1daSIFH3U5L48OicoYRQ/FHQfy0PMLwSJK8?=
 =?us-ascii?Q?sO2ayTwLg4ro2//Hsjhn/zyTpgLfkG4rJk+JbfT6Wco1VXsWLnIIDwYyziis?=
 =?us-ascii?Q?M5npMytLKGGC1by7XJQ+/D/ly+p8OhwWGvg40mIP01psdZ0xzWwINnexX9op?=
 =?us-ascii?Q?Qa1lS+T+FYDzOfcBIf03L+CRPPhdOUrliw/R1cuFLQJit1aBZh/+hg6Ecf+M?=
 =?us-ascii?Q?X26lr0YEJhMchlgnHkcuzLcxkBz69ei8pakaVh8m3iVWGKFTdOEDYdmH6pYg?=
 =?us-ascii?Q?n8IMCHk5UMOflD0WEFup7Kt3jYhd6uJsRwXXzC7/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d768fb7-29f2-4179-d0ac-08de0b137edd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 11:19:09.8682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyTlIl28x7Fl9aeeJp7XVKKvb1kC+adY39syoTw7FALb3x9WmpXOajUbnnSA4Q6md+RGdY2HwGzmi9iXxP0RbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8128
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

To gain access to certain registers that are protected by GMID, the SPL
must release XSPI ownership to the current core.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 board/freescale/imx94_evk/spl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/board/freescale/imx94_evk/spl.c b/board/freescale/imx94_evk/spl.c
index 341b165b3c8..f4529fb5fb2 100644
--- a/board/freescale/imx94_evk/spl.c
+++ b/board/freescale/imx94_evk/spl.c
@@ -45,6 +45,16 @@ void spl_board_init(void)
 		printf("Fail to start RNG: %d\n", ret);
 }
 
+static void xspi_nor_reset(void)
+{
+	int ret;
+	u32 resp = 0;
+
+	ret = ele_set_gmid(&resp);
+	if (ret)
+		printf("Fail to set GMID: %d, resp 0x%x\n", ret, resp);
+}
+
 /* SCMI support by default */
 void board_init_f(ulong dummy)
 {
@@ -77,5 +87,7 @@ void board_init_f(ulong dummy)
 
 	get_reset_reason(true, false);
 
+	xspi_nor_reset();
+
 	board_init_r(NULL, 0);
 }
-- 
2.43.0

