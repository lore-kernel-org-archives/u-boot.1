Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEE7CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF9C83C13;
	Sat,  1 Nov 2025 01:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="aWIW0y7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3728883BFE; Sat,  1 Nov 2025 01:45:32 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E04683B86
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZDpJqps4GcUXM8INuOfOA0Pax+q46pG3ubO+COXSzgHtzYBNpni5RFUAMh4OEBLCw9ZL8E5MAqi4BLZ9UvN2OkH59ztgVQKFAsEzs8kQXKTqmKFqxcWDe0nXuRwJbqqMsR+SvDJELFbFvMkWi2/uYyFYKWi1qNY6FaY+yWP1+SIJy6x5bex4x4WrKpHTmPxrYwxjrg5oIpEdqlumJMEZBW6/IBuBqfbSwp5S7BoW0kefrRxo+y9ZrvT06fluwxR6nW4YJdlHjP4WCH8O8MjoryCDyZ1Imi8n+V4hr6R3qxrFKvOzt7q92OrfZs5W8tWSRiOrikAKWPGNFvfl/MeLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pJpb6oJCcZ5n2mEn72UVth+im3UeLKqlPNOyWR5na4=;
 b=ecELHZ5PVmUwgXozOrTivBbUFIJxdaXiYGb5V/PZ1pn1B0y+5tZYSmqLG90O29fh2v0HmoYNvPLTerof2iWrJb33Gr7jn/Z0yHMYjXhyoo89X6vhb5begATS0DyhvxanPPG0d9C/W+VtO1k8+GwP6n3aXOX/eR15Q1njIPp/Hk58GuzjaoRzCII3H4lvYHTCFwKYz3Dlhfen2kn43Jcm93jRdutQ8kqzd3TdR8FAoNH4XKhG9vs3Dn6AvkcmEyDthHnC9D9cVB6SgRh7vSEUv0MxSPoPrwpqFkZQ5plPmngc1yS+11Oqy2HGRidcIxuOJ23jz9iezzF4yuNeB1xFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pJpb6oJCcZ5n2mEn72UVth+im3UeLKqlPNOyWR5na4=;
 b=aWIW0y7o1rcU4R39HlFnKvFOeo9VbieaW9BAXqpEkt+3eopoXtAX4SHSE+ExC5bJ4kQCjQ78cLmeHUM7BM9KxBnRcHLWTS8ioSIw/cNAJPMjavmMxiJOWIMGV9Im9JYBo4B212Uj5WOJ0tynoF7bOAkl75DKOZUCG2caUT3W34vl/EnZda10Q/bSz+yHnWlw/QFIGFiqEHfL8Onpf5b8igN08C7WmMKJs5sz9GguLBL4XKnLjc/jtTLSCZiSfpHAsECK4nKZeaFmU2A14T9CEKOBb+vC/fFhJVgBsIP3tAzIIjKYZEoSxzsW1NOF1awaK+LOx0oNZKNh2r+IaEml9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7586.eurprd08.prod.outlook.com (2603:10a6:20b:472::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:28 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 15/19] net: airoha: add support for airoha en7523 SoC family
Date: Sat,  1 Nov 2025 03:44:59 +0300
Message-ID: <20251101004503.2379529-16-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b50a20-977c-44be-ec9c-08de18dff405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9SogbgRVLqYcu+ORs3TaJq8REPh1F2ofay3hUv9hur0OYizGgKgPr/HVUs9a?=
 =?us-ascii?Q?NmkknQ/+5i/eGliu+05Ryd0BxQoInzsZ9Cj6n6tdZ+5tnzTU4CzmqB2mxdyr?=
 =?us-ascii?Q?K1Hd6AiJFXy8I2Ndvt8rCfQnG3TGlw997LZ8g0jVzBABFjdq8b4tgTiPZhd/?=
 =?us-ascii?Q?L6/TSE6DOu6TPs6BsSjZicboXnDCkvR/IBTcEIwuA+2wNfyiIDo7Db1uZnh5?=
 =?us-ascii?Q?eG+K41podt0muTDV13E3hnRhlcx23E3/ELtvqMyvDcvUdOvPHotKg7lAv8gX?=
 =?us-ascii?Q?c52NXLwcZ+nSn/Ve01gsxrIUiItYTgFRNTw72z0unAzW4cCFx88CtBBDEdO2?=
 =?us-ascii?Q?W50GbYeg4n/PSjsQ+tC4R+dAbAorFrJ0S/GF0ptGWlBabsVBNiXeG6x/18IF?=
 =?us-ascii?Q?1ebaA0n8+JVpljSVQEvJBHbuSNrL02/jsSGlnhaHViV7c8ELIFoL89Kla+nU?=
 =?us-ascii?Q?QK9MSPYu5XQCQnmEKGTmtD/KXM0Q9mUEYPTqK9zyuEs78Gnfa+95S3gM/XRn?=
 =?us-ascii?Q?DTRMBOYLPKC5op4PLeNmcnzZyRwJBDEExQToHmqeCwzXaGzwnfurw5FzKbS0?=
 =?us-ascii?Q?JYKcCF34lKHWQscg8XvCv/bj3tPc+XpNhd3cJyS/t7cbpI3B6STGpnzxJ8y4?=
 =?us-ascii?Q?sYnSLzUdjUPoWhbmoAX0ou02eQQVv/w37qAJIIYK2yC0dP5NBZXITOAT9AKB?=
 =?us-ascii?Q?BUk6XuGg8sYCS/HyGX9jTTuHtspLeLblYeGgNj7HQx1MRhpYYDxX58S7wPzr?=
 =?us-ascii?Q?uP0uH83kppo2yBqAvbTWnZDv6W4ResPjtSqHt6QlQHSdukYVReXwVOlT3ysb?=
 =?us-ascii?Q?uORCV7hzUkDiTJGzi2o2BckpZ1A3DmTwVAfVzyIdEL82nOoJ/5rwdxFzs+cw?=
 =?us-ascii?Q?QkHOg+3LCGnMVbk7nRzonYYSisd1b0AP+BYplK8Mj0V2anhTpTTbb5XY76fA?=
 =?us-ascii?Q?xNB4bMmhalj387xQMOYhnCtwNQvZFuTTrfA/CHC6TK5fpYIYHdu/d+XK7/US?=
 =?us-ascii?Q?UkPLHZ5sk2WZ6x8aMO0I+arJdFek0b6ec3ARTQuTgahRgvFVtuv6yJ9JjSQC?=
 =?us-ascii?Q?XjkuN5hcIMOnzn+1q3coAyBKrfnBXkFJVZPhsnGLzKZpo0x0O16CAt+kms2+?=
 =?us-ascii?Q?kajyWxSdJwqR/5pEiStBtaRjGJcK9Z6AIw7irDONFERHHr9Wge4goStrIDiG?=
 =?us-ascii?Q?z9j46GQVOItlG5bGwYir8/P7uVhMVJ8Ld6lXQ353x5qQyjpLbGMfwXmls80N?=
 =?us-ascii?Q?xzWCfGR537NGS83VWe4gyh68Dooje2qckq9BsPsXDgBGKQDRzGfM78rlMq45?=
 =?us-ascii?Q?F9vDr5rApvrDeTxdInC+JKJ94gK7xZyDG5cepXolrydurw2QYqvG1z6sHRya?=
 =?us-ascii?Q?0bM4+N9rxKfrF0qWaOyF77y57SJzykwuvQz/64A/RnCilottlz+lVH4hnXZs?=
 =?us-ascii?Q?DTcnp7nJfIupzlR/NMCRwhP8Dxssg9FrfM+yAetjbfxKqrFmeMIdfdBS+bLq?=
 =?us-ascii?Q?M4LzsWnQHW/JuQc9ZNQ0Q5QcO3D3StTLTz3G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5cRBWjUZ79FX7jfAvu5mcl/7ZYDXHTVwZKaxiarWEm6UDs+sV855ISXU8usE?=
 =?us-ascii?Q?JKx9ADOTxXzbgd+Ls+AnOQA/LdCyb4QILlNgrPOfXBVAW8aWj/QSAOMgMzc3?=
 =?us-ascii?Q?X10hvx1NoZhG55Fg642ftApKohieSEsdv5K8f+gWbWgsVzEhDlhf0PJlpQm/?=
 =?us-ascii?Q?eIwk0Qf+nxNiKWQKrtoOAmXIbs5dtw17mYESD0FMORmhi8eGphfWOXr0lCAm?=
 =?us-ascii?Q?/IC427CFJJrXvw4YM/iI+5eupH185uMn1GHMwJTEmcAUU/8QUk2qjCaA+UPu?=
 =?us-ascii?Q?2AIK7Ck9Gcz85x2ju4vyHrNklt6UYF0HmHljDCUjo0MGNbOkwNGk86bj48LD?=
 =?us-ascii?Q?obDNEqOsBo242lZRhRMiHQJOLyk1B/SRkrGjLiojuTrsIw1VBxj5poeO5LnY?=
 =?us-ascii?Q?bh3Xs9ssKP/q0e2Oa1S5VkiGGO6Mc2L2Y7Yc90SpzpoFhcrFaqUgf5eibyS2?=
 =?us-ascii?Q?iQbfN1vNryxiFgddpW/xUvC8BWU7DYTvEC0m1Wcjxloc8eq55CRCt4ovdVyv?=
 =?us-ascii?Q?XHZ7Ucg68HAd83ipVrph4XW5E52WA0kggC481vO+46ZvcT15M8Pg5w92gqGx?=
 =?us-ascii?Q?kAhPvSKsWoqldgvksZ7UBTRUiaqzmqnlyjDBaBO4lYTRlSHN6drlf/04grTD?=
 =?us-ascii?Q?HU2n1JniTYNLV75pxpFSPjGKgd+pPYuTqA4eqwFQFEBTKWNxERLfEXINu071?=
 =?us-ascii?Q?uHiU6RrdP3p1nTse6go5TEgEigAi9dAXp+fZ4zv5O6WPX3BAxyJe20ohEZZf?=
 =?us-ascii?Q?KxJAVsvDMqjj0hFR5F26ZvlQynoLkZkuDwQxe7wTKO2nQUkmRNOBshiQZPbY?=
 =?us-ascii?Q?9su1H3Cf+0P2yhbuWj5m13bO1E/cF/eZ7Xw8CmD4Q1mhxXxOVrXRNZ+GCJEy?=
 =?us-ascii?Q?ergR7GD/Kg8zoYm3GOfccHc8C9WAsdTorFhJ1TAB5nZyyFHczoJpUs3PmB9e?=
 =?us-ascii?Q?oan5cJVJ7+yV9+s0CoZn/mtjTjkMSihLlk5xqs8RUWuv/YHesGxyofFY+CV/?=
 =?us-ascii?Q?eR1YVoTZZtFjuYyjyyYRH6hav2znDOBugxCCFc6GCNQZnQSrCuwroma0DxOV?=
 =?us-ascii?Q?LOeMl8wjs2mVMrAbGMyGbafYrBbrwMKMtLLbBqeriJGz8H50eLsWe71T9qji?=
 =?us-ascii?Q?zFVwDae22cdT9LBbx2OPCKM1RLmbLRJLMuVEdwy8QSKNDpAIfTukanjGRCD+?=
 =?us-ascii?Q?Krx/RL7v5qAer0fJYMOVX+zkBrx+dIzqvwyttIAbOaTmxFDoU+QZ4l1E20nB?=
 =?us-ascii?Q?P1EDBxhio9KdZ6PzntgNPLfRJMJ3NRclrUqZmIzQxkHfs8uKS5Dfg5uOQmqp?=
 =?us-ascii?Q?Pg0OAxftQuZCdm6pgYd4JDekYE0MBIPynoZtEDrWBMpwQWdUr+OHpldwl3oB?=
 =?us-ascii?Q?VF450bWa4vtsWMysfzMCaat52VPbSls8h4QC6epjx01DY0RiPgkd7dbSc9Ok?=
 =?us-ascii?Q?KlOjW4SL1WfN30sRDtizWqlgt+voCVoVNPYTgRR1LIFDiapg3lpgdU71or/i?=
 =?us-ascii?Q?fPbFoDCamma7vzutdXWoXXedlYkdLLYPiAdAgr/nYDCSFXLbKVCZIvBZUJPR?=
 =?us-ascii?Q?RXaceuP6ZGqfgALh25t50K3f7mO3KXhrW+2d98Agy3zgDggn3DQZMMwYz6rz?=
 =?us-ascii?Q?aHPeYdAJjwiZddMc6HSm+JA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b50a20-977c-44be-ec9c-08de18dff405
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:28.5082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whWUdzsa1tsoNg6MIqnK/Z4fBylRBCKn4daLZDXA/8lREgEzVjFg/HtU/TMtUTB9equjsHkTzn18deMN4s/zI3b0deZgICv6TRxzW8zLUW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7586
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

Add support for Ethernet controller present in Airoha en7523/en7529/en7562.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 70 ++++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 62dd7f7353d..3234d875887 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -313,6 +313,25 @@ struct airoha_eth {
 	struct airoha_gdm_port *ports[AIROHA_MAX_NUM_GDM_PORTS];
 };
 
+struct airoha_eth_soc_data {
+	int num_xsi_rsts;
+	const char * const *xsi_rsts_names;
+	const char *switch_compatible;
+};
+
+static const char * const en7523_xsi_rsts_names[] = {
+	"hsi0-mac",
+	"hsi1-mac",
+	"hsi-mac",
+};
+
+static const char * const en7581_xsi_rsts_names[] = {
+	"hsi0-mac",
+	"hsi1-mac",
+	"hsi-mac",
+	"xfp-mac",
+};
+
 static u32 airoha_rr(void __iomem *base, u32 offset)
 {
 	return readl(base + offset);
@@ -679,10 +698,12 @@ static int airoha_hw_init(struct udevice *dev,
 
 static int airoha_switch_init(struct udevice *dev, struct airoha_eth *eth)
 {
+	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
 	ofnode switch_node;
 	fdt_addr_t addr;
 
-	switch_node = ofnode_by_compatible(ofnode_null(), "airoha,en7581-switch");
+	switch_node = ofnode_by_compatible(ofnode_null(),
+					   data->switch_compatible);
 	if (!ofnode_valid(switch_node))
 		return -EINVAL;
 
@@ -719,9 +740,10 @@ static int airoha_switch_init(struct udevice *dev, struct airoha_eth *eth)
 
 static int airoha_eth_probe(struct udevice *dev)
 {
+	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
 	struct airoha_eth *eth = dev_get_priv(dev);
 	struct regmap *scu_regmap;
-	int ret;
+	int i, ret;
 
 	scu_regmap = airoha_get_scu_regmap();
 	if (IS_ERR(scu_regmap))
@@ -743,11 +765,11 @@ static int airoha_eth_probe(struct udevice *dev)
 		return -ENOMEM;
 	eth->rsts.count = AIROHA_MAX_NUM_RSTS;
 
-	eth->xsi_rsts.resets = devm_kcalloc(dev, AIROHA_MAX_NUM_XSI_RSTS,
+	eth->xsi_rsts.resets = devm_kcalloc(dev, data->num_xsi_rsts,
 					    sizeof(struct reset_ctl), GFP_KERNEL);
 	if (!eth->xsi_rsts.resets)
 		return -ENOMEM;
-	eth->xsi_rsts.count = AIROHA_MAX_NUM_XSI_RSTS;
+	eth->xsi_rsts.count = data->num_xsi_rsts;
 
 	ret = reset_get_by_name(dev, "fe", &eth->rsts.resets[0]);
 	if (ret)
@@ -761,21 +783,12 @@ static int airoha_eth_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	ret = reset_get_by_name(dev, "hsi0-mac", &eth->xsi_rsts.resets[0]);
-	if (ret)
-		return ret;
-
-	ret = reset_get_by_name(dev, "hsi1-mac", &eth->xsi_rsts.resets[1]);
-	if (ret)
-		return ret;
-
-	ret = reset_get_by_name(dev, "hsi-mac", &eth->xsi_rsts.resets[2]);
-	if (ret)
-		return ret;
-
-	ret = reset_get_by_name(dev, "xfp-mac", &eth->xsi_rsts.resets[3]);
-	if (ret)
-		return ret;
+	for (i = 0; i < data->num_xsi_rsts; i++) {
+		ret = reset_get_by_name(dev, data->xsi_rsts_names[i],
+					&eth->xsi_rsts.resets[i]);
+		if (ret)
+			return ret;
+	}
 
 	ret = airoha_hw_init(dev, eth);
 	if (ret)
@@ -969,8 +982,25 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 	return 0;
 }
 
+static const struct airoha_eth_soc_data en7523_data = {
+	.xsi_rsts_names = en7523_xsi_rsts_names,
+	.num_xsi_rsts = ARRAY_SIZE(en7523_xsi_rsts_names),
+	.switch_compatible = "airoha,en7523-switch",
+};
+
+static const struct airoha_eth_soc_data en7581_data = {
+	.xsi_rsts_names = en7581_xsi_rsts_names,
+	.num_xsi_rsts = ARRAY_SIZE(en7581_xsi_rsts_names),
+	.switch_compatible = "airoha,en7581-switch",
+};
+
 static const struct udevice_id airoha_eth_ids[] = {
-	{ .compatible = "airoha,en7581-eth" },
+	{ .compatible = "airoha,en7523-eth",
+	  .data = (ulong)&en7523_data,
+	},
+	{ .compatible = "airoha,en7581-eth",
+	  .data = (ulong)&en7581_data,
+	},
 	{ }
 };
 
-- 
2.51.0

