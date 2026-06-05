Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE44CD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 09:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B642848A1;
	Fri,  5 Jun 2026 11:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ETZIbeqK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 849DF848F5; Fri,  5 Jun 2026 11:49:00 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D30D8486D
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 11:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VC698/SaOgacUdH82UDu4AJJS+lE2xu7zeCBcBvrrRuDzCIF0yJ+MkCb5Fo03b58Wog0fDl8R+aIFps2fwRVDyRZPqJtia1j1pC7matiKywu0ZjfYA+0sv/zsWs+SluC7D6G1RyoqdWiFRE7jTcljDIy79O8zNC6am57cy0CCnNkxAnVnXp8U/Sv9MwwROXhwNzaEiCWiPsaavrw8TCAdtmF+e9X9ljgo+vuINEcxJG9dNZc1yY7tIJSpJq0n0LgLXOPoqBCFuNbNVWJ7imRpUn2DtKK3FM3m7vL0d3HKfKWF5zxp+cxOBKnvn/uDl5RSu8XTlfDJNHUWEKLutd+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ve1SM+JnUerCyB+vXF2G0LpdGhz2AVAmFF24JEdmZkw=;
 b=l1IaXCQWaMaEoWoY3m0+8M/Wf/Yrw+qENDhZD6HGneCXrEnQPChRNCrpUCtsNJYxhIXwTmXZ45uNtvDoD/ulDlooXW0O6FSAp8M9sr9IDpHmHqNK7IJiFwv78dnkXNyB3pP5mjScdxu5sT4fY15ivgb0kfg6iW6KgpQAJyIkDd6c452J4AYLBP64M9NPAcTeKOBH0nqqaPDQ7dhb+KOJLAyeuO4hFpYovseAmug0RNvJbEjlwmgYlWRZCw8W9c47NDlIDVpJgv2YXg3w17phoABtl9GgvBIgv5mJ+9Wh2Tfho3xixlGohEdB9cC5Lx6f+CI/yfimsPWLarFqSjZ9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve1SM+JnUerCyB+vXF2G0LpdGhz2AVAmFF24JEdmZkw=;
 b=ETZIbeqK4CFQSaDzp75GxZLICv4DyhlTA350ng4EmknoyvL51DAGvip0Y5uxSipbg5hwvM2SyUwJuPAVKtxoutN9RyUzFB+coEiDMnznjWW3wlH4388ueQ8sG8iYggPOyrPNP6l1SqD9mN+ccZ6Hn2+RVHBeg3+dmYezCt2ugcnQzhAtq66uUvZTMirF2yyoTjcmQrfbLncm9wOopzCG6EQkmPy+jgZzQyztv3TWIuPw/rFBxKRuJEDqcf0zg3uDiCLB16WPRcb4HL+SEVd0St16aM/k02ylHdty2RCdSMQ58jdY4wy4FkqoQrw2bmjYv1IFwk37izSkeSkaizjAgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com (2603:10a6:150:2d1::6)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 09:48:54 +0000
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6]) by GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 09:48:54 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH resend 1/2] cpu: imx8_cpu: Add iMX8MP UltraLite Part cpu type
Date: Fri,  5 Jun 2026 17:51:06 +0800
Message-ID: <20260605095108.3223321-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0276.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::6) To GV2PR04MB11760.eurprd04.prod.outlook.com
 (2603:10a6:150:2d1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11760:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9eae43-a020-41cc-5758-08dec2e7a7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|19092799006|42112799006|1800799024|376014|11063799006|56012099006|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: gERvYIr73Vgbdge2b846smLVwKIm0K31zeSIp0h6JTzMfY2lI+rtVHminS8UBaoChBLuOxDI3pEpP7soI+ALEZbxE1DjSgOq5Nd9k8Ri55KyHlNOvhdALjlhPRVB+CEAbuaBVRcZH6QJYAzOyCYnBeLzFXtzf4CR+m4AjyGa2+8btkZcVnNKil7w1bP8p5P2RHO2jEMhCkSCb6yh+ECL9UbiZgPAgHS8GFlpzy0H4JkaGLQmmFA9g5+5Qx7UAAbVdT/Rw/JsYNC7t7z8WJj2E5cdn9e+L4qdnonWPXPMWDe0Yvj1uZM27xo+ClbKbB4O4tgFaVb8KFXuPgFfKoGr1aJqLkrbORw2ZgBp0sJkf7tVYvXUX16xpaJYHXWCJpjHqxkEuGB+s1JLZyISYtfXISLWKMzxaQrcF0rzCRl4GlDorRYXhfUVi5FHVZlM93VYo5IODMDyuJ/1iGkXB7dbQ5HfthWYzZPVemo0aiOoC/S1QvlRo0hGg0LsopXXI6soHCexpb+phBdfyVEvrn+famfbBIbkQbEdi0+S23EpLAnX8jC4k4bta4RoISlkoBF+zFicyfxGQawd3v+ypwCEqj6tft7iQKxULgT0ieCbE2R0ayvW9g15ophnQAnQWDBXSmzZgbBMFzD+cCUDlYM4l9jcC/D5MA0YPBEPENpF0IcH6xhWEbj7OD/uTQyKCTpcuTg2Uh89Uz7HsIGE0Uh4GL2u+bWC0LxMqBd7o0+c/KQul6TwWxLzwE25XoCGxJGF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(19092799006)(42112799006)(1800799024)(376014)(11063799006)(56012099006)(38350700014)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a8oDdhaaAs4hXH2B8rbv3XtLKkMs9gtuoX0oJ5dlwiMlDYU9IOGwz3je+vAQ?=
 =?us-ascii?Q?WVavWXNl2raIdJejdmgwf57g3KPiXFejqH0zstkA/K5llOAt/u67s9WJ+0vD?=
 =?us-ascii?Q?hdZB/U0bEjVYMjlAABI4SVYjVC1Jf8rGd/0gWq02NJ80D9Jun0PWZP0iyXNl?=
 =?us-ascii?Q?MvEINUg1F4APPfDe0405yB4EDK5K2aAlYbGF4nlc2XRH/009T1SzpBBq5mnj?=
 =?us-ascii?Q?vab2Lk0TxOWFEAxW/uvSkyy1x6swS78dSQAjz1Me3AO1xA9DDxcCpJrE73Pg?=
 =?us-ascii?Q?QJ5nBY+JYEaLfPadlx1BYXUGJX/xr6BPn6CnQ+WoxsaOWJXQ6igH4w04pjRq?=
 =?us-ascii?Q?0sSiRLz973b8pnxXHHHaRqS9VDxSTnUF8Uwoydc9Vu3qNkaHztLKD9B6kr0/?=
 =?us-ascii?Q?tb4X06nlNbPIwyMmyBJGe9fBkp3HODHW9R58wYtQZVfIgYURM/EJwH8/WM7C?=
 =?us-ascii?Q?gawFl+QgDtj/8dfRrlRZnLuBVRUY3iYIX3sTH+LYv46PeG81YQv2/5OTaZuf?=
 =?us-ascii?Q?B2LpH5tt//nDT4cFgBoZWENv9tWymsaQJAQOFbA5/ZDKATFXOBGvbT4LnBK4?=
 =?us-ascii?Q?0O0miCM45qR23wZiLTT9qp++PGaI7yt5E3e6UEs7x7+7eUGQbojJi8DXECXP?=
 =?us-ascii?Q?8yqEXmXWqtfvLd118dYMDVwgZwg4ejrp19T1OhjGwt6c1LRDaaQqb86G9Rrb?=
 =?us-ascii?Q?JZDDKZgI0yBt8cmB1dlAynspVjO5vW46pinN9oKeJdokAiYEG+bi+6vOqI29?=
 =?us-ascii?Q?tOXcsHwYb+sKFLM98qQz3k5iTL3e8Md2vZd5A0AFBR0hCwnk0aQRmCzMANq+?=
 =?us-ascii?Q?+ReqXh0WksIbpOadqjT03zfAcAFvX0Yr/q7i6yE/uOkrt3gg3Mn0U1gm19iG?=
 =?us-ascii?Q?j8f52EOJswe1cRhcLG3A7QP9yvmRSDUBXsRfpF0WbAGe+BOkaEPghb5+TVbS?=
 =?us-ascii?Q?YXujV3gQvk4CbqwRzzke8fWUfnAcFOE3lWHeKWUH1lKMWhJJqlAa7juBFGFo?=
 =?us-ascii?Q?HGvh9hXWWO8eUACi9RUpDJo/pGS4EnghC4ObxmHzzG/Q+jcLUQ0UEqWrN5h2?=
 =?us-ascii?Q?wuxeyyqxxuAnmWKhFBl9ckwOwsoFo1lbLsDISs6e6XESFz4D0Oo1sHRaXbFQ?=
 =?us-ascii?Q?94A1TqmI4E3iAQ3RNGeTPNMEVUhdQ7KV8CW1ih/ZHSvmTSmXanQHthTYCLYS?=
 =?us-ascii?Q?bh4xMuz3dw1DdopDQYpY3u7zHzQYf5pD5oMTDuBCgiV+ktNMSARP3AlvAQYH?=
 =?us-ascii?Q?od/1OHjNGQxPmfqNHrn6V7t+S5zjBMgY6h+ZY2biSQhhjIBtql8EVCgxQMA4?=
 =?us-ascii?Q?KtGUFibeIHQXJomO/qyvtgHUOHGbAl9pDJJGAiYBQxv0t2PadoDpEqh7IA72?=
 =?us-ascii?Q?A+vhIJmsf4bHkiQQIBzSeMrplecxDHr7Y/ItGzg+pWl4mwviB0Uo85uAisbE?=
 =?us-ascii?Q?rSxsURMsRVCaEkJzL2/0DnVzZUB+ImHwTgqzjpKv0/l3QlNvN8kDjUyQ5wSw?=
 =?us-ascii?Q?xzrHWm06RYIkUlqa+F6BRMkKpca2Ubv4Xh0zRvhPs8YCCgU/1oty66PPQfq4?=
 =?us-ascii?Q?kEcx3xdGEYcXMFw+HlyGwcD9IoyZnSRrR/sBPh6BQxYIUEEq3gzoh2bvR6pT?=
 =?us-ascii?Q?bQ+dvpveBxS9bQ6UrF6MEogeQSG8sEIYLQbu3tUeBbFK3KxgF7vYS3zYAk8v?=
 =?us-ascii?Q?h6tIgrFUYR3iD+U9A5bpOj9/sDxIQbV72w0qhnxSQhffaDOa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9eae43-a020-41cc-5758-08dec2e7a7b1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:48:54.3798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33XWAdmztSy7bJncDRsKkAdIOo0iWfCPYrb/u67th1GufOA4E+8HOVDH3MRr4fq8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333
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

iMX8MP UltraLite part is missed in the cpu type print

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/cpu/imx8_cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 3473712a423..f93477c993b 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -69,6 +69,8 @@ static const char *get_imx_type_str(u32 imxtype)
 		return "8MP Lite[4]";	/* Quad-core Lite version of the imx8mp */
 	case MXC_CPU_IMX8MP6:
 		return "8MP[6]";	/* Quad-core version of the imx8mp, NPU fused */
+	case MXC_CPU_IMX8MPUL:
+		return "8MP UltraLite"; /* Quad-core UltraLite version of the imx8mp */
 	case MXC_CPU_IMX8MQ:
 		return "8MQ";	/* Quad-core version of the imx8mq */
 	case MXC_CPU_IMX8MQL:
-- 
2.50.1

