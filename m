Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1015BECD6D3
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CBF683E23;
	Wed, 11 Feb 2026 19:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Y8mjywoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52CF283E52; Wed, 11 Feb 2026 19:23:22 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67FAA83E21
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O20EFwgi0P84GdojV07WZgSBE4FYcMN0oe4fjTbKmOEJEQheish/vflCI2RlyG5YflowLPYA6h7K0GsUov22l+8A68otwQHGguSlDfGKtHkihBL0/oDT9lYyKCxqoE3gpy+PK2C2Vmj3cPlksEiIpnYQ0Hjf/sF47V5oazlwWe6pVODDul6hAfffTs6UFLoHXEs2gqDXQ7Sl/Q+SWEpGlrnxCffhKgNsJo00tyJKACPrgUAjj2yV4HiQ3NKZ7Edrk2gF0ojMoBk/NDOwHVd7Z8GH7+JgS+i8A5VilXDnHmtUEn6xB/uQKdLBxn6woVDwd0l9MtUeH2xf1hzP4/1AbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYOUTblDMZ9XmSOzE3c3j5rSnTHggXEfLPuim7U3CuY=;
 b=o+AEEo5CP9GiJD2CA1PyLHjCgMx4wEzhMc2/IQitNQFamt7LGlcbVOSNc5r4AfZmeREJ7wcyfgoq6gUt/ikbw+vCMEhnrhUlmgfIsoRVqKNcIMu8JlMoCzcaKZ9tPTJV+wxPnCcZAmRl2RjTKqNKirM3k9RYB3PwnHBZOqLOJy4pryZnbGi69+fED3zB5J08KnIMRH2L6iAlepg6OIZaZyx3l7LaqdbEzeZzVt7DkyXcajbSFwdqi4NIiu9g/CBtW8SKVGjZF9Wug3eEoB5uMSSl4dO6rEh4bSW+Zm3jQxlr1vYgsY4PFR4xlAUg7MunoKTfCdLZAJLdo01e0zXQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYOUTblDMZ9XmSOzE3c3j5rSnTHggXEfLPuim7U3CuY=;
 b=Y8mjywoDTvOkdF4SG//dhz0C3mL+p+RhcDxp7rLSoVR3N98Yxw440xmKrhiMOifGV3TTnfEL+0cJjjNSooC4ah7U/9w01ASCMAO9+Xg0Zs6kiP0REGY33u5hNPknK2w/Mn1zW3vv3ptYdl5kDi/9db85VqI9H2N+sJOsxdmkow/mLyfQ35AzkW4K2WdaMqVbo60OnK3YAzmx3B5GDIhamQhuhg0pEzpXn9F7v8e1sfwbQi2MbOf6agxxhJMtQhpUiAe7pbS4eOsjmoHkPiz9/mUY1Hq4Df6G4HxRTXBV2EyI1GuUcjepkokV1xg5lryNDPbOsiErpEoQM+ywVEd86w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8572.eurprd08.prod.outlook.com (2603:10a6:150:84::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:23:18 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:23:18 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 09/16] net: pcs-airoha: unify code using SCU regmap helper
Date: Wed, 11 Feb 2026 21:22:23 +0300
Message-ID: <20260211182230.968921-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 780bce23-4366-4ebd-33e3-08de699aa120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b9I0IlQjoajZm2aILg3oOWnDRqEkFNHV3VRsPHwORp3pBMDe5WFhUZMp5EPb?=
 =?us-ascii?Q?oL04V0RwuFALQJqGhERQvLdhv0qKaVK+nwc9Sgd84CGPs+bprC9ruIz35YiV?=
 =?us-ascii?Q?HUKy+pasHhzwBGsVJakfrj3asIslnyu33do/5YlxsKgz6l0+9pcT3o+kZQfo?=
 =?us-ascii?Q?dUXXZ5HKnhUs/bD+tn/W8xvKgwR0oxsybeDPJJDyVZXG8Ap2fNlw7ghED8Xf?=
 =?us-ascii?Q?CIe4xjxp9s0G4jnefYSn6xw2ZJbV8HYouXOyy7tOQ6zgGU2IoWHQ71PPzJ6S?=
 =?us-ascii?Q?hz+80anoeRuxL4wXazHyMAYfk07wpDu8vlAvKJVEIDylqthBx6A/U6LgE0Md?=
 =?us-ascii?Q?Nd7pCf4y+fyI/jdZKsBa/6MtxCmFiQ8EQZz6bUTaoygihsj3yiH1sbGHXHUa?=
 =?us-ascii?Q?kkJCLppINj5UySf0bgyE/+Fi9hTiM6vzh07o621T66oowAXGRcx8dllDCkch?=
 =?us-ascii?Q?GSPt/gJktz4UNNIbnRjB9t7OYleHVvGcO86hPb8/TLxar4z+rES0LXVqx6U6?=
 =?us-ascii?Q?OhRV6zEombRdmJ1I3DDitlaj0OkDuvMU0xacMnIp+appwMb3uQj41CJjvqSu?=
 =?us-ascii?Q?UtJ+Ly1hhnrfzKA+AHgdtwU/AajWrlCaE2j+3QA+HGtbR2azQIUkvZYuBnKV?=
 =?us-ascii?Q?bx5m2MCth2L0dPGE/EANkC1XRLmZm4mDZBT9OJvsqFv7JSNOk2PX++yxRutJ?=
 =?us-ascii?Q?EenocHVQCU7IyhRh0H5ufrQEwBSJ0tDq0M7jMWuA4Qrcb7q7ajQOi+WCZEUO?=
 =?us-ascii?Q?m0qfHTg5WFWjtWsMsSq3lL4j6DaKEXio9dqWjebFXPbK0yaJOesc5wHRnMZm?=
 =?us-ascii?Q?y3imN7TgbNgNpRCSfIR/cxh/hPWbwqP9n3zicECU9K36uGRJaaSb51+DSNl/?=
 =?us-ascii?Q?d00CGdy3r9/P+d4JNDYeybZ57ZodnMgpp1LO5jXSMjD1zuyfnyAZM6qCboC6?=
 =?us-ascii?Q?jZxM9GifOM2q1pXU08v4I6j051InjJ6KCP0yu+snPIYPC18doNefwUb1OaSa?=
 =?us-ascii?Q?g70TBNgd2SUPUSqApLtlLNdxmOzsoLfca3YdS7HU4oxjxEQ3VK6n/3aCHzRA?=
 =?us-ascii?Q?EyllV3Q6vOZRySGwp6gnKFl0pciIVWGMAZbpViHa2hPRviRRIAMTSWlocKr9?=
 =?us-ascii?Q?HEskvrI29y9Bdhg7GAqKLA3dD92KO5YSIPE+4R0t0lzVdmVcq1tP0tOPJyWz?=
 =?us-ascii?Q?clhIRLM4gTwfzepQkumow0DW5F6thiab8xlqzCLuFXnguwB1X7SrvHLeHuuw?=
 =?us-ascii?Q?uKMDdTHMMGaZOtOfSEdyMf1w/Hj/FnayA2oXs6bkzv3Kc3f3VMsx1UTDU1rL?=
 =?us-ascii?Q?YWxKg0VPPDBCSMnHu3/LDS08EDmF/trBmvNACl9XAlZX1lMq0L1g4B66ZhOt?=
 =?us-ascii?Q?xLQokWRScraTQD17ecgokwNbdmtyL71iC/xcPYNkJrNdGfqXyV/2CqPaLuH4?=
 =?us-ascii?Q?kmgmwfa2xNvjBFoO/m6fCojTQH0JNBRXJ7T3rZlxGtKfif8cPF2qpokhvTQa?=
 =?us-ascii?Q?aLNvoji84shGZwKqfyBunsg1PNKREJuhIcsCMu6Eq7t3OFYtSXpOG8GtarMX?=
 =?us-ascii?Q?xIQBFuzw6xIL+KiNLMpUAYZqZ/WrSzkMU3kCQ+YimgZqAWhqhFj/jPYA/8ZD?=
 =?us-ascii?Q?JZ8mLU5YzvcWdCLOsMh5TriX3RnNAqM/D8ssQR1MLzG7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?59GhHu4MK5/Wj1RW1V8RfjSCNS+o+NZvt1J7obDtuMbMbOq46znzSliXTC0f?=
 =?us-ascii?Q?dRd7yqicipSbO09xwurJQ30fdFELKsxda0goxamFjvHBWPfDq3Q+B9VYJa+E?=
 =?us-ascii?Q?9ibiTwBFxa7yu2Ck6lyGdc1ku7LvAeVXu7bOQnkrzhFsiPrBb/b8yW6THXgD?=
 =?us-ascii?Q?lpRSc5kQn5Kg6GUY9Iu9OhIvt83e8fztnEeJ3KdF1NyDX86/3AlyzF1IlxD+?=
 =?us-ascii?Q?6HpPT7hUdLjzcZDFxyVvydsu4jcbhcIC/z0cfm9vTnyvUQEREwyINlgueTYv?=
 =?us-ascii?Q?ZCH3xCVzK/r0YpDjcgQPuj5w2z2KmEjCNgc4O4gQoDsO8qFTO2Lb26rOmKTJ?=
 =?us-ascii?Q?YTHFhR8NBSNIq6ZIvcpwDw9zofPRZEWFj+ea3szEDUdO6WEMiMxzjTM0/Qm+?=
 =?us-ascii?Q?EYFGrKOYAMzydbI+P2cnuj74p+PU7Bgx7UyNlI3uVEfiWFsDK9SE/qGXypwF?=
 =?us-ascii?Q?BrZXl2MWywkAKnR6jBN6SRAjmWH1HxfF6LgiVvYWHpqaTgwb/iSUmc0FCAvo?=
 =?us-ascii?Q?GYYAWGbhZVpjljv99c1P+6qfAYkbva/Vp1t8U6n25PpOjEtcSuGSIu/hOMXK?=
 =?us-ascii?Q?JE3eWy8doEJ70Na93izaqZ/GI3dBG5ZC/LQ8VqGXdTn1KkZUTxYxUR3w72Fi?=
 =?us-ascii?Q?D2llkXVCBxJNTTY5MD+aoQMonK6M5sfOr2CBv0Qtr0EQSUGVgO3O5gStx3eE?=
 =?us-ascii?Q?zv/FBudAXKYzO9DQf+TmJvW7GlBQ2v9GkGkaa4pWwHQwj4fJQli9xJi/Mfy+?=
 =?us-ascii?Q?Y7MMwYJQGZBt+om5oKbwpzrJcTtgRk5uT7ugM7UJzlgDrH9/mC+NDdMt2J2r?=
 =?us-ascii?Q?5o11Wj36mpMD010iz17/cdJNYavRRwov65VR4CN4tbqfFNMwB406PA6HYS6Y?=
 =?us-ascii?Q?C7PF8m6nrsAJ4BwhfSsJHG6ZkpXEiz+8V78bCaJ26v1MBaq+209M68CONquk?=
 =?us-ascii?Q?rQIvv4f5oFrc5HlnA3RBWciTMtYbT0G/uRgh4Jj7fdPA/bZXXPfGk37jR4Fe?=
 =?us-ascii?Q?qSpDR3Cu48DNOAV9F+eytnQXNhaukPCYhrRiSrw7aW9oWGQKF7sabzyo7+7v?=
 =?us-ascii?Q?uPHM/OyaLlo8Ecrnct3GOl49A8nQ2dhAl7ZmGKds0B02bG2BP1oiADpilFQo?=
 =?us-ascii?Q?4ZReaOJd0kj01FKMIBaJWNGDXbsaNAHdkMAj7Ei6h1lmgYwoNRyr3FZf91pv?=
 =?us-ascii?Q?QIPTBY3fHBzCmVik8Rbj4W9FSqjCo35MAtUHoSYND4xR9Po5LLYbS1fRN2zT?=
 =?us-ascii?Q?htI0Kum/QFUA0BAVMiR7Ka6q8+fPI/cDbw+8hPzakAV+ZrVhraUh2upKaV5w?=
 =?us-ascii?Q?JTqZUI63HzbR3q5DGbGWefH/gtJdDtxMROHY2D/oUhi/KMz/Q1lnkXaeMPpC?=
 =?us-ascii?Q?Fb2eYTrL+hNmYtCCK0cF4ZRkF/ME7rZfuUEdIRjbkEH3lRrujDySVoUELPTN?=
 =?us-ascii?Q?lFwiAIPA+AX+CwYAShL8UUWTbl+d5+plXfLAos20R2fhmHXiG32Jqok7+3AA?=
 =?us-ascii?Q?p5U/oFNoRq6Yh4vipjunrqt2RQ2foeLytxV7Ui+1YZ3/Xnk2oIS2CGDelscC?=
 =?us-ascii?Q?tklQK1lfX6Tqsp2Ycod2zKh5s4Iuq4ht5f8ZEb6F/eZsjttNVXD5hwj4cosl?=
 =?us-ascii?Q?hEh4e5jsMar7r+QJIbVQ7bXQO61H1g+XVg3rKk1/lhCPNfX9gvsnnM+/kjVr?=
 =?us-ascii?Q?loprsJwLsMpaEmSQK4ZtKkrpBdtvjbtM4jO4N2mvtRVtqAg+4URwzpXmYVhl?=
 =?us-ascii?Q?fKPijFRDWz/7ID+MJjzD2X5mSgNSH5Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 780bce23-4366-4ebd-33e3-08de699aa120
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:23:18.5067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlHYyQDWRp3tdlaratITA6WKPkpFb88lWCa0pF3uOH2vWbAS0aSgL3QO6uu01kkO7lm/wwIwxLuCah96CvtfFzRwC7VhwRdMhQ1Kbnd7i1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8572
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

Use common code to get CHIP_SCU registers instead of driver one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha/pcs-airoha-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/airoha/pcs-airoha-common.c b/drivers/net/airoha/pcs-airoha-common.c
index 8784d92a7a4..16f0dac2951 100644
--- a/drivers/net/airoha/pcs-airoha-common.c
+++ b/drivers/net/airoha/pcs-airoha-common.c
@@ -10,7 +10,7 @@
 #include <net.h>
 #include <regmap.h>
 #include <reset.h>
-#include <syscon.h>
+#include <asm/arch/scu-regmap.h>
 
 #include "pcs-airoha.h"
 
@@ -755,7 +755,7 @@ static int airoha_pcs_probe(struct udevice *dev)
 		return PTR_ERR(priv->xfi_ana);
 
 	/* SCU is used to toggle XFI or HSGMII in global SoC registers */
-	priv->scu = syscon_regmap_lookup_by_phandle(dev, "airoha,scu");
+	priv->scu = airoha_get_scu_regmap();
 	if (IS_ERR(priv->scu))
 		return PTR_ERR(priv->scu);
 
-- 
2.51.0

