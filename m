Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5326C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4F2183F60;
	Fri, 11 Apr 2025 10:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tokuYOsm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56C0683F5C; Fri, 11 Apr 2025 10:10:26 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6197483EDC
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCZoVJ0/9wEdMtD7AQ7LYYGja9Y9QLFlzsZba38pBoLxo+A/Ejlzen8/by5JPICcUav8k0EufSi8zKJBNqfJMKslUG66D8qyvt7UIfE1pz6CbZar+Op2b9hYUli/GVxSJtOvz/XdTN5GvDuzMDEkOORWjoW++u9NLUm/uMEkTashyZ5kuOld0DlhEiZmgpccqwHxDIa7m7Qgwu59Ar6m+VI0FaNuf703qJF84CjUF3ZSXUBF+CNMwNAzcE4c3r+11MD2OJ1QjsWXGVpKqnr7z9QWjptruy4OLjFk3SBwYuB4XU9j0jSeUlGTMeMFeTrfi8RwFeEaix3rYu//stlV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr0nYc8estEHNhBqFJth91VPv9nu0E8BoQy6v8DqQL4=;
 b=vSf6LrzdAKWC8dCNmrdx3MKhavqVpSb0k+3Oy5aUtqXDSjX6wvZsXGOhQDQGD2rjLp/gMOIBvQrR3M2N0lziiLQrmA7Mk0jzw41cs2h61TadgPAMhq3Os9pxK8dTPrBeRbb9ja7NXjIfDHEYLlylZrlDZE3y6aqF6C/c6g8Mb0iwvdxPrVhESJLgNGnyuezwE4RCKSxa/Cc9Zeb8RNu48zUKsaJnDi85b51np/e2LFZYru9OiK4SbPix6y6KXXSkV8w7qv7EKr+ktDT+ZtNGabxz/rCtEcYrhsHZmxZmuYcslmvv+fwArTRW75Z0WqJXrZew477u6LexUNs7jMXJFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr0nYc8estEHNhBqFJth91VPv9nu0E8BoQy6v8DqQL4=;
 b=tokuYOsmxk1AmZM3vMLDFbnqKf8PEAjBbBE0D0Dj6qoMiSdZBb9jdDXhHt0osWWk31ejFExL+dE9KrgKzXSyVz6MnE3YR23BAQvifbVjnJYZeZP0rhiF4MUKIbbtZvjk/qCWrTlBABesJxjfLttpXwiWlfnKKOgQvaVM1mrX1YCv1KKIG3edwwC8T8kX3aQf9TRt1Lskv/x064zidspDWZ4fKIsZTjr1BpxRsQWvEDhAkqyA8B1dBbMdGdABigBsm/paJJhfeEL5H3S12gDgfLlG2jRlpr/DMwan8URJJhPhbV8bda9wTPvUQxkXS6wSz6eAlj+ZuTL9Ooxyv9/p9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:10:22 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:10:22 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 06/20] clk: scmi: add the command CLOCK_PARENT_SET
Date: Fri, 11 Apr 2025 16:06:49 +0800
Message-ID: <20250411080707.602371-7-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: ac40a921-124a-4d9f-cb79-08dd78d04e62
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hIZ1jf1ZPoyx8c3wTtWndj6jQaliP9OW6RrQomeX7dpvpNgOQGEmz4kLrZPp?=
 =?us-ascii?Q?1/hB0gAsGKJqNiKcMr5Fmwd4w04pVZD7Jqret2DohZOAf/xl+BJ+xJuRKR4T?=
 =?us-ascii?Q?7j1lXadFxAYn5L3ctMYtn5YWr0VZm3uUuY4b69OXW8V4+UKDK0cKwlJfdzv5?=
 =?us-ascii?Q?GZXGskQVnKnHkDphLXaJ+9JbZ33sKaxaz4xl5939123ylZ7Ks3Gbxqn2+N7j?=
 =?us-ascii?Q?gXAZUlPcKej0jTxhBquh1bRCuYMBI6NyiBDfmNY4FyM1VZXgv6A5wkHo+TLn?=
 =?us-ascii?Q?poxQ8PwxEfClXr+eVYaJPiKPGnduWqghyPmINh6czJTkfqUwI9E2x8gwfA0i?=
 =?us-ascii?Q?q6bGQvKEYjimPI63u2cRnFesC9ZzvrUkwenxOMxpSaedOiJRBKuxUsT/XTMS?=
 =?us-ascii?Q?O1rRnabw+Trybf8fDMU05ZbRhbPRqH2bwe7HBXC4tPiKIZlSYh8PeSxKXXVN?=
 =?us-ascii?Q?vIwZCAWgP4wQRbzwaI0nxGVKchSi15+t2s6YiglV34kp5/Sm1O6UVJPO8/pW?=
 =?us-ascii?Q?72oMVwyUzwMhm+QDCM40e3McgmBeHpc4BQeD1BRyFiFg3A6tDLuXFq0u6I9/?=
 =?us-ascii?Q?x22/eLCFYRH4hu+jmUsBYUQXsNruevy5IZgDrKW6a3mXwoiyLTHK4Y0UGuTo?=
 =?us-ascii?Q?RKFWIVVyR+hE8DsIa30lLN0k58KpA5bzsNPueWp0LHY5d27uuH/0aGfbu27e?=
 =?us-ascii?Q?RYwkQMw4z2mXkFapG2s7NdU3zx2Y9Gh9ggdh+QOh2XrArudl8khyOtD5NOnM?=
 =?us-ascii?Q?1SgBcGCEB/1pSydIoTCe3C//yoXDSaPiVB557Lym2wHL4FNG03ASH6OQa7JH?=
 =?us-ascii?Q?IsSO/PVppA1+V+J90HPwLcyHFCNOyoPl8AQF27wLiKHrHCsdgOCMdnDIO0d1?=
 =?us-ascii?Q?FfI53Gjn6u6wrdeRxms3AMt7BFnv/ni1+ggLMODZbxqXKuDSL6P853l21xbR?=
 =?us-ascii?Q?HfBgTIqToDYH8ihZMNFWHeEF413hjN/fF2GNY/ptX19TLiGfLL2H6Ru9qtw2?=
 =?us-ascii?Q?IoYPsdg2ie/szD5diEKuIRRKhhZuDPQDXindLmCBKAEBtQwachLDQxa/qGST?=
 =?us-ascii?Q?Hp0TPZPKJvBaABHetLZSgl6RSzKUvYelBhhj2zmkYycFhtsSnDSHcZ5tb0SZ?=
 =?us-ascii?Q?XTXBEaLJIqay7MaA7UxNwK3BReSoVSTGaa/98gseXwdS7H8JaQt1ol8G6pc+?=
 =?us-ascii?Q?H5lWwUDaiUF79JkddSwNiVKvSzXBEwiXOhYanFBjwzDEN1Un8Mj/cH9PNaRr?=
 =?us-ascii?Q?90WsmOUhTP/lsoqRVuN1nBR0s76W4XnrUtMLw+ddOkxoFhOFIfuwdRTaJrO9?=
 =?us-ascii?Q?8cvgYzLhPi1Q1qnz2SoC7foGX3GhGNCYaTOIDYSvaDKGYFChy54r1ga29vVc?=
 =?us-ascii?Q?3EY8wWSOOm4F301xegGLqGC5fxMP0FdemXIv+rqXEosTxFx0m3IYif4Ywz5L?=
 =?us-ascii?Q?jjJuKvO8gan1Fnr5etBVgVq3gq+d0BPJqkuyLpFed5hdfeXLCjOwlg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bc67QQ7aPCptCg9TpYg/LBvBh07h47aoT3QtvR8SP3HKwYviNS90iME2y84M?=
 =?us-ascii?Q?GPZIxwkaAuSQ0FqsUAy/KpZUEI0JudBldB/v7d7MVvG4fV1nCH8rsKxMLVK/?=
 =?us-ascii?Q?u91atvBi4XYA/9XcjuwGXMurbfipIno3zY8S3NH6B9M75Igy+mJxxj3S828V?=
 =?us-ascii?Q?VYZ72CKeQZCQLCVQGh0+kakoB2+VBL1TVg3csfRM8++LteSThT6WbOOqzbrY?=
 =?us-ascii?Q?HWQgojIuDsVEjVc3yZ1I68Gz47tCsuHyRUeev6kOufZJXujDyx45ETdHzIM9?=
 =?us-ascii?Q?ygBG2aZHV3G/bf8Eea9Kdf9OvBV5CGvhyfz1JjBNb6oTtbJhkiXulN2qkb35?=
 =?us-ascii?Q?R6BckzVEQ7WI+XFNtsN/PUJ4lRPwuJ2p2L1y5DJUdVXrXbrD5fof910elxxZ?=
 =?us-ascii?Q?N3WOkO0HC5Q91k1jJlTHqwfkMFolSNvKRg+jrLrDK5Dttnpw82GoVbZpFeyg?=
 =?us-ascii?Q?unmEFEcg5FIVG9tRzpHOaHhAd5dNKhpN9dp/rb52olOBecdFcTU0xUme0Ip0?=
 =?us-ascii?Q?O9TY4zxOC+xzCUZOspJq0J+EnjTeduPrDk5F4yfxgf0bKAUXX94h6vyicHJ8?=
 =?us-ascii?Q?dhtkdTnh/ZijiCfYz0iBIe0qeh87Vrf2B9KuCbsLajCo2J6aRVJt0iGWOZ8D?=
 =?us-ascii?Q?yjAJkFAAI7e72wecm2rusptqwJVtFLe2TQ5ZwSz2y1SDCojbcp4AZ7rCQZKW?=
 =?us-ascii?Q?7jml8IHuxRkHb49cuF9Gi3foTs8n5L/bnM6ZeWMfjXqOpOEaGVT5tGeuOx+p?=
 =?us-ascii?Q?Uj88QzXAuCzZxs3qh1USLcHkKaUb7IKdKBUl4cGJhWPGIx3IriTdKyL1Utj4?=
 =?us-ascii?Q?aKTw1A3OJMA5S30ys5sxaaK2YadZFadkF6GB7JQxiD5hBV17+t9te/iGEWJd?=
 =?us-ascii?Q?1gNgAmt0cyxs0dkckG2Tt5nhwNJaKugxr00RawaK0ZGs3rv4NN6qDT4zrkzK?=
 =?us-ascii?Q?08KE1hHZKe58+7GmIyd30dYPnV/tMeSuyqxh+s/4x79RwU3wzGW8jz4q/GVY?=
 =?us-ascii?Q?EElk9brpzIYriO9bZcb7v8K4I/sal7zBjWp5eYNd9aodn+U9VzIXC+Pnyovd?=
 =?us-ascii?Q?gDh3vx83lLXVhaiycK+P7tXJ7FMTSma0p2ojWSow8koMA8OmTaqvLBTDbYAg?=
 =?us-ascii?Q?QZp4eqKR9GVaJ1DhJCzxvD2GNfos4x1+PpUXxKwHYJDOZrpWCgXm6GKRNJPW?=
 =?us-ascii?Q?v7vVx0/JnrDFUul/TZOEmhmqWkaluqtryl3USTmTGCiz9YoZOSg21SzK2SAB?=
 =?us-ascii?Q?QbPX+KuHp7sc9qdb/Tv3d8haETLLwDpbn6rU8uR4lXOP/WBkvSw0tKSO6e8d?=
 =?us-ascii?Q?FarBEVJml6N8Cpzv7vWZ+KXm8b2KRsJISKm7glroXg0I1bsSG3BB+b+SSm8F?=
 =?us-ascii?Q?GHXLghrXKJkFZeNSBDQJfelytxRQC1dEs6/4UrlDPlIqcv9X5X944hEJFtGa?=
 =?us-ascii?Q?hqRHaKcu3waePo/BaXYwhP2zXnCXBluza3+C08D98YhSgXusRmbC1wZOJfYq?=
 =?us-ascii?Q?UOs22QVYXTsug6eE6vZWuSLa+Hmg7jD5UMHtiOZWeiqKxZsRQxW16pGbEnTX?=
 =?us-ascii?Q?pbsnZVFfrUYAtBt9OB3VVRae3WQTZSSm40/pkhtH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac40a921-124a-4d9f-cb79-08dd78d04e62
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:10:22.2923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8ottw2+OAXSwMrVW55snj//hQ0FxV44agSv/LF9YEnt6tYtTMJ458pWOWbi6mr2bSy+GkPBTIbfzX/blUPDUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606
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

From: Peng Fan <peng.fan@nxp.com>

This patch adds the command CLOCK_PARENT_SET that can be used to set the
parent of a clock. ARM SCMI Version 3.2 supports to change the parent of
a clock device.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 drivers/clk/clk_scmi.c   | 20 ++++++++++++++++++++
 include/scmi_protocols.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index b8d40cc9653..af5e8679003 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -179,11 +179,31 @@ static int scmi_clk_probe(struct udevice *dev)
 	return 0;
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct scmi_clk_parent_set_in in = {
+		.clock_id = clk->id,
+		.parent_clk = parent->id,
+	};
+	struct scmi_clk_parent_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_PARENT_SET,
+					  in, out);
+	int ret;
+
+	ret = devm_scmi_process_msg(clk->dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	return scmi_to_linux_errno(out.status);
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
 	.get_rate = scmi_clk_get_rate,
 	.set_rate = scmi_clk_set_rate,
+	.set_parent = scmi_clk_set_parent,
 };
 
 U_BOOT_DRIVER(scmi_clock) = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 34f272c448c..342a65ae7f4 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -737,6 +737,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
+	SCMI_CLOCK_PARENT_SET = 0xD,
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -839,6 +840,24 @@ struct scmi_clk_rate_set_out {
 	s32 status;
 };
 
+/**
+ * struct scmi_clk_parent_state_in - Message payload for CLOCK_PARENT_SET command
+ * @clock_id:		SCMI clock ID
+ * @parent_clk:		SCMI clock ID
+ */
+struct scmi_clk_parent_set_in {
+	u32 clock_id;
+	u32 parent_clk;
+};
+
+/**
+ * struct scmi_clk_parent_set_out - Response payload for CLOCK_PARENT_SET command
+ * @status:	SCMI command status
+ */
+struct scmi_clk_parent_set_out {
+	s32 status;
+};
+
 /*
  * SCMI Reset Domain Protocol
  */
-- 
2.43.0

