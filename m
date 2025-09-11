Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECC5CAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC974835D8;
	Thu, 11 Sep 2025 14:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ebZi6Ivv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01ED4833AD; Thu, 11 Sep 2025 12:57:00 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19CC7833BF
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qoi34omV4M2c2EB5JuK7oi/7dUYH19p1xD1yEDOm4RWko1DYJAcR4uGd/lDZ0NZIJM5shbLkFZu/yyj/Q/EYrcl46Mst+ojybxQUHk8+0NdLtAIZ1SalHGx+QNutX+k6KfWfw3SrOwIrsLH/SqgKBReZCh/7ZFE19mDJFm+1XETcj+LB5XMJniCrvgnueVe13F0OzcZ28w+e1QFaC5MEYEwM2Swsi7y3tiFq387peBhtAIxYTU2LWDtn3DxhgIEdT4Pc9J0j0pUMoRuYYVBNC9nGg+gtlz22+tiJZUvI9YTycmPnuvzVx5XxVqk38SmgMf1IM1T3YTeM4ZP82RJWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8INOndMWRjK2sKFX0V3gM/cmu45nApV0lyZSmiYsIqk=;
 b=yodlXEgki4d9hdEkqOtgZ3gmpaEqKmpjoTb//1Zfwr8Cm9FsdOBC/HBFh5Zua5ES5RMthq80XIER4aZ0VTC6zkVe3m+AnNMCVTTVbImqOoS3AdWf969OdHUzSqgozi+700m8UWes0/8pu18dq3KR5zpZTXn4ghXsrVONzD8vsgYQ69EmI7blCRH/QvSF2vdzQCfEHKBoAjbFtBqKQv+Fr6+wZni2vsdWidqvMKmxGP6Zla1CwTfKlj3RnUypTvlu6SoLxQrzVdBm5jFVWhFq1wZE0ZXfFwqEJWRmy7vnrHOZe9VgQc0IFV5wix5p5jOGOjq2reOLWpoQPoez6fSeDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8INOndMWRjK2sKFX0V3gM/cmu45nApV0lyZSmiYsIqk=;
 b=ebZi6IvvJa7UG+rh8WsJlzvjIPRUsl0nADZH+Vy24Px7nR2kHqnPkH67kVnD07OgOzN/spDa4skinrK3GflPjLIYhxbFDWpEiVvxPabsGGlPdsgE+izI5RjWmMUz2B3mmMv1Rq+DcyB3l+alJdfUpVYwoMr8SHYrN4ET/J5IFg7uYM+2/uP+M6vHBgaTl1dAt10Yo+goNHDjjEe94zsxg/SJo7i/JbO6tG8C1OuRLmB9nRNTGlESt3pXtGpPMcLjgtjU9tONEXEStMg1DXD6/ojFKn+JRZTwiCz6c8RYwSldf633CDbrb8H+u+Qx4l4X37K7ir60xySJfDeA+/JSgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GV4PR04MB11752.eurprd04.prod.outlook.com (2603:10a6:150:2dc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 10:56:56 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 10:56:56 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com
Subject: [RESEND PATCH 8/8] imx95_evk: Enable PCI host controller on iMX95
 19x19 EVK
Date: Thu, 11 Sep 2025 18:56:11 +0800
Message-Id: <20250911105611.3664965-9-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911105611.3664965-1-ye.li@nxp.com>
References: <20250911105611.3664965-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|GV4PR04MB11752:EE_
X-MS-Office365-Filtering-Correlation-Id: daf5180f-f27b-4991-09df-08ddf121ec7b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KpL2dW56WhYieIG/Qael9fm9CnjwMcwA+Fm/vnYun+Zlqs1nILRYvgCAnpqx?=
 =?us-ascii?Q?+55F2XePaYNPYLq6PwTyl1GZUGr5uSttvOrbuhYC7FyZ5tJcMx7nXZzn5Ixl?=
 =?us-ascii?Q?/O7GYBZkFdhgtfthBPBYkSPx3aYIu5fZvT6oNPiFNC+XEFX+jFsQWwG0ZyGH?=
 =?us-ascii?Q?Ud32DCwM80Nw7aRi+8lpfk5OncVMWgclkGxg5VtdWYomeANXU6xma6ogq48C?=
 =?us-ascii?Q?t7lP9Eu6u76WCsjk7sr/EjPPbRuQJWNPEV0XpKMRUdMtLlWegLkL0JElxI3O?=
 =?us-ascii?Q?pXWOcJG1BsVgzWev2fPjViUIJtgLT9e1TadDlKfAdM6Y9fWoS8x3z6FaRevs?=
 =?us-ascii?Q?AtVUiKS+tAXMqkHnH9K9nIEYXGjJP7Z/luEaiF2VUHWFryCRrrJWjgQCBkyd?=
 =?us-ascii?Q?6C5JPBInzAh7XQqTUKWsSeDHb5OhM8E89K8yqIK5XZcXYEOp0VliIDIMQcHq?=
 =?us-ascii?Q?oeh/X88dRzhxP4fWKfs6KAUQz6xUgKysmdCciVXWXM5uB51lEW1oiva3KwtC?=
 =?us-ascii?Q?Gg3ktXdBk+R3fQXT904y1jggGT5jtEerebdW2xPf7rt/e3onGW2gf7Q4xIOI?=
 =?us-ascii?Q?WdR2JiIBEHykIrkb/c/IlDVzc7ZDeOVnFL2OtflKZ5eesDiDaY5IQQ+QsHaR?=
 =?us-ascii?Q?jwAgQwhVuQjHnt9MNEgJSNL7d5J12sHu14JbOgn5muCIFQe24ejVNFzhwBDJ?=
 =?us-ascii?Q?FvK7HkecX/8xXOQfP+Ya/rav7AfMYRx/LzjC3CUmxjj3mjmNeJ6YKQpEbIY8?=
 =?us-ascii?Q?dV46uFDWjHH0Zh6SaNpirbI6MiIzxiqWW1vSdsaqO53D7r2++JLejF8Jgplu?=
 =?us-ascii?Q?2iHkTBH+Eh0MKuWbfIMv0JiG726nen2Lo9WUrGbASMWuBbDeMfbu7wusbiXB?=
 =?us-ascii?Q?zISLWbiVNq9Wemq+qy9fL/SGN1Cx+jlpfcuvG1G7SvLugX2JEPzlRBRugHR5?=
 =?us-ascii?Q?EDkpzTLTcuqYiSwG39oIwJC6xkO7RMcu77njebv6DuaVgk1QzTdk8YtHJEX3?=
 =?us-ascii?Q?oWXvFdCrht2DgLoC/IPY1Mf99VCgow4BCQR0erwOlMRcFioUt7md2zTJlS8I?=
 =?us-ascii?Q?X+NrNB4lnTnJ6fBGUlGDvuboUg5nX9HSQzt7eT7FCWyg8xSh6hVH1wJLfjv9?=
 =?us-ascii?Q?ucbtXUBC53KcJGA3lnlMlsZKE7WTG54koWkdID4HLqqLxKJgndOkFvDtZA5t?=
 =?us-ascii?Q?tZHZNQramlClbAR5udXBZl4b2wCqOEO9nbLMEMEwjXTmnG3XzNEHtaRGWB8W?=
 =?us-ascii?Q?RzB7bdKQs6HTJg50OjLnNvhPmlzCjkeNCLiQGDOmY5IvgYtIhFGjVvqEWkvq?=
 =?us-ascii?Q?Ei/NyXDXkNym6kEVKU2eUbo3iFIORUkclKIGNMpuLRDwMlnnyZNKSK436Kpq?=
 =?us-ascii?Q?6w1gRLIB2f1EMx8lqWlI3v73Hx9vQlhUEWPwwEHTUAmERwyJBRGzvNR91RtS?=
 =?us-ascii?Q?oaOer7G92KH73Y6X/JlQGr7guKcso+hbi7tzNaqspItsnU+O1IcE+nR3MyeZ?=
 =?us-ascii?Q?L/oyHntybV2fgeA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qGrq0VNWjgiDdYkMR80BqIrbchN2dicc2FbF0URQjC+xM2V9B4HYKxYbBBbU?=
 =?us-ascii?Q?RtUuBGYUqUWrfMsQ94hczdKSFETFTcaoyDNlG8xPMaaVdiDhKh8UT2CdCbPk?=
 =?us-ascii?Q?+4J2Yial7qj0+FQ2ZmMg3+ssvrpYZBNiWOJsAYHg51IdZtJD9gw0NBhG/b8d?=
 =?us-ascii?Q?PXjQRzF5OwIhJBeR9yEYcoKn8fe7QW3rOukOOmODXSxOcs6ETRWVOFQTUarp?=
 =?us-ascii?Q?T2ezEzMRGONzpZM6r5bXYM9/iAcarrG4W3nEQ+ggX3VaI9JpK2m3wMHyP3UL?=
 =?us-ascii?Q?efu4jVBn4Ay6X4663zXLTziinR8LnPiDqi1ZZly/BesvAGLcWCrmCZcuvjxd?=
 =?us-ascii?Q?ScBgsXXpH1YGw3UXx4JMRDWmX78CwyN8Zcv4Vky5mhdLDqY2yWerkr5lX37f?=
 =?us-ascii?Q?uxxsjLDEjCLAvMVpO7rZBBUbwErKW6MijsfGGgB/hNFZf2CzlxBoj8hQUjFR?=
 =?us-ascii?Q?MYHvC6AkJXHMrB2wf0jvSSArYXnytkYx3ewslgE6YaDCl9gWCwbQykiy6o0N?=
 =?us-ascii?Q?YbDrgf30iCGX6wgH7MxvjYjfa5zgd40TZsyHe7B6bYMnAJY+FLeqnukbY+ek?=
 =?us-ascii?Q?uDvBKS+mOY9Ih7a7PmE9rd8iJ+WoGuVMbLxSYN/9YU6XKzNg+iMsjLlJEQRa?=
 =?us-ascii?Q?gE6Hznl0K8YFmFZ642J+dRoXMHetkxxtCUfjd3piD8N+ujrE8fLSKmpOGtui?=
 =?us-ascii?Q?wv32fyN1L/6Fj2j4EOnpqChdzrP3krP4Wg0WevG/H/gI8bVul/nPSLg6xEfZ?=
 =?us-ascii?Q?/obOYR/VVYAZAXLQaGaj9Ptw9pOC8Kuhk7NneKO7qs0pCgVGtjVMuyBnIiNv?=
 =?us-ascii?Q?z6yF6cSsYRfJXMprofyC93O0w2kq0YdjknquEXjFHzLruXq39dRaG4sOwv6F?=
 =?us-ascii?Q?sdAR9pPSp3cObb0SDFpB5rbtxAiO0nmO1PpJM89pj6RtawXZBWwydNjUSIO2?=
 =?us-ascii?Q?lgrPaDz/jm9l2LzKHFb9f1UPbl68z7lz+J78/yqZ9LsWLRp15XO1hFwTwQIL?=
 =?us-ascii?Q?F9/K5irczzbOKknYNi9JagbRGXevnlw5EIQq1wy6B7Jk9eO9CBVRSxCHJX8J?=
 =?us-ascii?Q?Yhea/piH/5T19UO4rQfag7Y5z9aShlbWklDk+110T3ZBCjxi2Xh+U+Ldl1hB?=
 =?us-ascii?Q?tpVaSP+wclNnZ7rTWXG/Ho/j6z3S1t9/plmLu9dq0AAmK/C+pGHPIbpPSXIE?=
 =?us-ascii?Q?r5hQZxnkzLqSScL7YuSoylQ0l4XizVop2c1zPwM4Ac0lBrrYc6a5KdAsGrdM?=
 =?us-ascii?Q?ARyHZqOLv7NRR0kZcynR1lhTYGqko740m6EzT+YouLA6Nu/LczAl50088eGa?=
 =?us-ascii?Q?u9FZRTUGT0OS13eWUYg+UVl0Y72nHTjtbiEJo6U07yYBU9P/l3HrWMVOq/UF?=
 =?us-ascii?Q?pv1HUF2OUC52mNIKN1jlbK3+kYzE1wV1LONEdP8pUPtnASnRvQA69kcamxTh?=
 =?us-ascii?Q?EYzFM1M8pGmycYk8Q8tfBp6ufbtkhs4II4/FWy8MDuhl/J4afctmR24zer/B?=
 =?us-ascii?Q?Z48vEqgiUg5aR8zt1L0Kn9WL+fbSYChRxJ56v1PKAWiKr4ZocN9eRN/JzEkz?=
 =?us-ascii?Q?WSWWh3AEfb/zu8R9Kynh5KrgkT1Q+NW6TE8fifSr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf5180f-f27b-4991-09df-08ddf121ec7b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 10:56:56.3313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OtXs5t5WF+CxkfIARQNdg+KEXEZv46x+6GT8Q3KL71oG4PqSLuB8EJsHF60oRgY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11752
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

Enable DW IMX PCI driver and iMX95 BLKCTRL clock driver in defconfig,
so PCI controller can work.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 configs/imx95_19x19_evk_defconfig | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
index 73818a82627..f0a31dbda7b 100644
--- a/configs/imx95_19x19_evk_defconfig
+++ b/configs/imx95_19x19_evk_defconfig
@@ -94,15 +94,12 @@ CONFIG_ETHPRIME="eth0"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_SPL_DM=y
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
 CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_SPL_CLK_CCF=y
-CONFIG_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_SPL_CLK_SCMI=y
+CONFIG_CLK_IMX95_BLKCTRL=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_SPL_FIRMWARE=y
@@ -130,13 +127,13 @@ CONFIG_DM_MDIO=y
 CONFIG_MII=y
 CONFIG_FSL_ENETC=y
 CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PCIE_DW_IMX=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX_SCMI=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_SCMI_POWER_DOMAIN=y
-CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
-- 
2.37.1

