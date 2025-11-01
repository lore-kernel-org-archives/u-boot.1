Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CCBCCF9FE
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95A1183C04;
	Sat,  1 Nov 2025 01:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jJY6D7OU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50E1983B64; Sat,  1 Nov 2025 01:45:34 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DEC283B87
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2RUdIJJ+pMYRx7qgH4C2BdkiR8Td8d9r310iv8I/vkV0O4kSSBBsKSszGG1Fb2CbOSjkOaFpZ/tZgI8EA78SpnkY4Vw9CXi19gK+v8DiMgKYECgbCIKWB0h/8f0Dj7TP34TnHBKcsFJiSw3dxYD56EySqO0KAzKDD3O6oOKunf1fAEbcvY/HjLu86J0APVGxkNCXNi9gnHITaXGLfRQ+QLa6c+H3vukTxT+Ypyt/tv77SI0j3ufuhsLrPXy3bgYCm1zAAPg24ap4EOiRtGoULcaz3CJz6kawBjeLmhdeNXWV1ClfDAgB1+HgCjiPK68hGbBEF29aD27pSFOHJWKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAERoqmRk0hMyhAyTxyzy/gVrXfYERhx4oqmaze/nzs=;
 b=HnuqMgWzOIlp9YsithfT/LjjT+3hUbmNrrVobSuNcsPlXaLJEZbHaZQBTR5yDmW0+BWqFAtX2JgyMpIbYhpFt3qWkC0gKn6i7CEQOrL3eSRgmiyeK2zJ0aGmy3Kk9+luAwEA0VzSJ7GgDmHrED/hJoP0f+hg7kXn4FQL74RKUOKTvG/h54FM5xeYu4UkxKBgFXLqhEeP0TWy2u31v50iubOYgMx07ub6WVEZqCQ2TdFtUc14Q5pyokSDlVJCTQxffxaMy7waifEm5EgNszvXBurWPh6nT2NF2CnMU5cTpylKCSXoUtNmRDFOU96EXn6NNfLELXg3CPbTT6BwdCNKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAERoqmRk0hMyhAyTxyzy/gVrXfYERhx4oqmaze/nzs=;
 b=jJY6D7OUCuYFFp2Ja0qFWg8g+btmZLPWB7dYVjPOrzYw1jPUFot+1FBu8IU6fpb9LrmKzkBOATcj+Eua+aKKiyNptr2wdMVNcwnTNd2JLndU0WxuR6pg5Ir9xqm6zEna5UoKe+Z/ZRVwTnIEEbQJmHl3Lm3t1zU8gwEDLN1OLp+IiluW01qbIISOXp6MW8NXDUSseqsIuJ5/XgjvlYZY3vRN+drTQyRJHoU8KzVQsMqaqF+vzNwi7LNGqN3Iiv8uII7U/sJ7+sCTY7vNggybaEFR7ENv2NKcIvFmfSs+1zO6RSIoh7kPm3e655bY8C+crd+Vte6yXqloHuVfnqavbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7586.eurprd08.prod.outlook.com (2603:10a6:20b:472::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 14/19] net: airoha: unify code using SCU regmap helper
Date: Sat,  1 Nov 2025 03:44:58 +0300
Message-ID: <20251101004503.2379529-15-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 4a590172-5d65-4959-1b13-08de18dff35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5c5ymgEcoF8IY3Ns1NmqtH9RzAWAJp1dccbbH88bpzWDYIdxfk046mnKCT02?=
 =?us-ascii?Q?KIFcO35uG0XBvdXofSnxrFW5Op98qpOiqzlLwX9ELpy17u9pu9+oTwkfsFn1?=
 =?us-ascii?Q?bytk8PmY1rWbRg3PnSJvfOBKoEpv0uj+m9wWtGLoV7vqLBvZWsSgQEkWMHrB?=
 =?us-ascii?Q?CnHKrjLdbCcwE0oLBVmMamxFZhJZZcO11dUANoNdPGMyblJ8rU3S4cnX9xA6?=
 =?us-ascii?Q?H95VwuXowXNou1dyVbA2YTx/tScgbO5KTNTlPS+UKF+DOUwD/2Y3JWKaf0ux?=
 =?us-ascii?Q?8JSHJsyil/We/Udj/s+CDb7Uw+2CSuRl0+NpQShuZ/ilEdex0w9ClidolyfM?=
 =?us-ascii?Q?Fa1aBtXKnU09XMwgyHF1twCbxGmBlxEdUTec9Yp4fe5YSZMEtf1SV53QMupq?=
 =?us-ascii?Q?vSR5uFT29AqkNC8WoqYACb7XO8OTV4b3WK6np3MDDEJQ5OXt18mLmqtUtsZN?=
 =?us-ascii?Q?9Spve5SAMYSL+tSlScsxjpG05MsPKcmerxVpvEwSCPRurB6nC0ZPZx1qp/O9?=
 =?us-ascii?Q?Pzoz8jetajurutQi5pKx0Tp7YciMGE5IqqfmxzUEYfh2oOws8cY7JTcQzTxA?=
 =?us-ascii?Q?s6jsXUpRW4rgpISvxYwXbZwbl1eCKyTtq5qyk+tbUXhyBHsBE11XuvJTflEt?=
 =?us-ascii?Q?qlAt485t1Y/0qu9k5Nivq5LGefeURtXsGwBx5kua1/y8QhHGohME38xIS0uz?=
 =?us-ascii?Q?WHRTB2TD58AqzxAAL3J4USpOrAaKdui927Za5nCIdKe91sxAJrllxPRlSjbA?=
 =?us-ascii?Q?TXX5Dvu+pZHhcQE6oxLQG4jLJi8gVA3E0HOz0FIaEL34FxV3V94oy+MUwIfu?=
 =?us-ascii?Q?EHvq6Pi9EF2Yp0k19tEXC3KwY/onBaVS8uP+WAHT3hufHO3MsrOhLPLMfVAG?=
 =?us-ascii?Q?kUi2JXj2/ptav5A9V0bXsO6jUZgpbzvTQ/018eoMVYEgUw8IzvuvVB74wjZq?=
 =?us-ascii?Q?mYu0TjKBSXffM2fLzlhfWuKJGLzI4UDTFqebbxK7rA1pO8LfELOMIQBKLE1W?=
 =?us-ascii?Q?duRwLsBt2po4uu9/W0q+bZNi/dny1n/BJgBQiD80DQpFSXfgTAyRQ0aFoLxA?=
 =?us-ascii?Q?tX6pN/5o7juzv5ICj2lNp83p2GwxBlwfSuixFd9e6EEr9ycCliNBsPXDfw9S?=
 =?us-ascii?Q?QM51YuZ+74mdla0HhHJ1nA9UQOzWuZRrdUOg7teSI8PclZePzQRYvWO5xwti?=
 =?us-ascii?Q?UW5J1vjOjaGwTYjUacAPwkbvb0IYNaNDmM4lLwAc3iUkYDAdHbYb1bf4aLYR?=
 =?us-ascii?Q?q001d0fL6IOEVmJ5z3Un8T4u7uvcANsCcv4SgF6LULgM4aOTHWkfaUktMIF+?=
 =?us-ascii?Q?d+WRZDuTwVcBkbXguVrU3CmFoyJ5uzK27K4UiEgIfwC3VIKXB2kDe6UOFm8p?=
 =?us-ascii?Q?G8Kei4QdivkObZBsWCZmoK7XH/17UbETTyjw3r1+XOnHCBBJvCSbwD0hTClU?=
 =?us-ascii?Q?Dj4LvonJnF8ZJH/945TeX6ivjbfLvvXxjoiJPxbFQTr7UJ8bZv/0jfxhPzWT?=
 =?us-ascii?Q?c6QTMr9FRmYlWG16n+HuIe7uFAoLYpdWI9mj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dWmXRSaXmmq6j8mk46N4mmJdgv8iSsGbd/xhzxrB9iynQYrJxJhY5VTWU7vG?=
 =?us-ascii?Q?/cQ5wKn2nw/BG9wQ98sSnEReN2Lg9u2CYpFNwtrRJhPrJT9jzlYmC8vtopa/?=
 =?us-ascii?Q?Z0CKN5lMoLddMvOjZYazp5PdOjMuCzla1oIWUeGx63Fe/Gu4wTjCQzrffW7X?=
 =?us-ascii?Q?xauRifzOp2gJpqSscosKOAa+1Dy3eThfVEF1PIy9s0+8qA/pRpWc+Dg7AUkY?=
 =?us-ascii?Q?GyLF4aVqaSQyi773qFxNZruRwyT772vTn8Ae0Wjbfy17jUDoOVo3MGjfGvDa?=
 =?us-ascii?Q?J4Im4OvE4w4MmOCO8V1kd1a1sJDnpByPZCW40Nlcd/2C8oSXvQXf3hhXqkfU?=
 =?us-ascii?Q?ssQ2IEne+N8iccjkVS4mJzh8+VkIkvNPrr+d5WrqxF7jMWcjjOSpHS792Ic2?=
 =?us-ascii?Q?39gOH1D4bahNwtb2beizqdOlsR1Skq/jfF4t5DdyP62gfPF5Nj1+D76CYMFa?=
 =?us-ascii?Q?IvzxRCURobtwd10mclgrOfW1ynNHg+xlI2QT3vSmuJhM8vp8JpAGlJ/4X0To?=
 =?us-ascii?Q?grlxf2yMN2yRoVjmG0nFrn70ygegLkOMbCt4dfE4FhqLEyvyP0GHur/cujry?=
 =?us-ascii?Q?Q4mX1wxf0ITxuULKK3ttuObu6nhnrtIQCrgK2uAk9xtYFgZ3mLBTFUPAtPEd?=
 =?us-ascii?Q?EmoMAAeSjEShCtMl3Esp6IhXN02d8Dnq/BcKds112AjorWOp2HRSafpYIqi8?=
 =?us-ascii?Q?DeqLZvTtEIHkCLEE/rKuH1pIE6cXD9x5HJvrQEv7eiKmUS7H2/e5kdD222fn?=
 =?us-ascii?Q?EtAQtGJ+9H1yOnLA3AU5ip4BHReQcHiQxDzDAT3XlWYHq0gJqcwxVkVSfrRR?=
 =?us-ascii?Q?lU4oyPzjsHQsRKBx5hR2YjL7FMPrAuEAEGhIr0eVt91SPcZOsZCWZy313gEL?=
 =?us-ascii?Q?OReA8QV4MWa9TBLwAqKGWF9h0da/ABrltwlTSoKPBohkzq2u5qmGVuyuwa4j?=
 =?us-ascii?Q?xXo48HUBBsZQHK+kqeIIFC20embiRt3HF8ZXKRKQaCKLczrpNRg8impeYs0O?=
 =?us-ascii?Q?AOfc7a3P1phKMyQoHwbE21LkENHmBG2QF4Vg7plfd32wJDl3F6fqhvJp2zOL?=
 =?us-ascii?Q?6319TsWZUYAknZKGruL7fTfCiR4oucpSciu0+H0Supz5dEmGPoRkpgdIy+V7?=
 =?us-ascii?Q?3hOn4JyNg6+qhU9DJl1jOSxCY9TAdHe1F3nn0TihOvCRClLQ4YlgYCeR4Prc?=
 =?us-ascii?Q?cIxyPtanXxlp4YtQcWkmm5E5ia15r2+iGnK+swPrDsiOTAhd+R5Mct3SBOT1?=
 =?us-ascii?Q?g4DlaglyukdrgaUI65iPJTyFCZr20h6F0SvCyTXeygrFgwiwahOpqSDCL+d7?=
 =?us-ascii?Q?6XdyzIERJRjPV9Wy8uMDJoeGWGepJOyfY647zBl421SWz4+06w56HX+nmpT/?=
 =?us-ascii?Q?XA9y4arikmvf0XT5zZFW+i/BK2Vzi7yPmJsU727DREpq1NlvCzvZvt5YkwNx?=
 =?us-ascii?Q?Bjtq8jZQbvr08M5Fg5THMz/l6nYuV+bQotrhLM+Kh668W6eINrxcRR6TrLY3?=
 =?us-ascii?Q?ARPbmCR8r/79UJ9kXP5JLwZObMN1Yu5YyxndphhCI7qw85h6IkTHj8RWuxTt?=
 =?us-ascii?Q?4raU2ZLtwbRsIDuQ3x9FUJvcEaSHkIhcRVttpif1VqfWiEnBX5eZ1rY+e/qB?=
 =?us-ascii?Q?lmX5k86MW5Xy7j/Vxkjgv2o=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a590172-5d65-4959-1b13-08de18dff35f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:27.4789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KL+AhYOXzZdPxgUMIJcu+w9ErymMa31zCu/V0EPk2QJB/ausEAHErstU/4lBPVE85AAblgMFYnh91twjeKcJ0YzcWDf0rhllPH242wIzNU0=
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

This allow us remove some an7581/an7583 specific code and use a common
code instead.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 19c3d60044c..62dd7f7353d 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/time.h>
+#include <asm/arch/scu-regmap.h>
 
 #define AIROHA_MAX_NUM_GDM_PORTS	1
 #define AIROHA_MAX_NUM_QDMA		1
@@ -720,14 +721,9 @@ static int airoha_eth_probe(struct udevice *dev)
 {
 	struct airoha_eth *eth = dev_get_priv(dev);
 	struct regmap *scu_regmap;
-	ofnode scu_node;
 	int ret;
 
-	scu_node = ofnode_by_compatible(ofnode_null(), "airoha,en7581-scu");
-	if (!ofnode_valid(scu_node))
-		return -EINVAL;
-
-	scu_regmap = syscon_node_to_regmap(scu_node);
+	scu_regmap = airoha_get_scu_regmap();
 	if (IS_ERR(scu_regmap))
 		return PTR_ERR(scu_regmap);
 
-- 
2.51.0

