Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B863CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A17A483BDF;
	Sat,  1 Nov 2025 01:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="QmPQIswK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A280F83B87; Sat,  1 Nov 2025 01:45:27 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D24D83B71
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIi0/Lka+dIwjhyegsnUdLrDgOOvNMOXWX6l+s66+mmjPBSP3WMSwMIwTkFz730dcV0ix6wSUy/ECp75O4poLfYV5ZetFB2eGsw2sLkRnu5Qz0ONZnxPpuvx6n8CNNXj1jm3tKznPVIedNzeioNCQ7VVNzd5HRU3CkHEg0NXt4L4jGEX2xYqWc0sddjpsI3cwes2lxn0THqzAkUUrGDS5wIim6NZmN32jTIw17cnr6ItpoclWLtWbBqLg6FjwJIotborC6B4/6TsFODKVr25hKL3PojJAqWX/MqPa79ejsCbJOf1dTV1i0Rg0WvGbJk32396TK+3xaxNfJhQorSjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoL3GCHccJu5wtdioP9CTC+2bX03dFeucFVJGiD4zWU=;
 b=yXIsjEWRoBlVI12oFrnUQKNChEtBOxQuYj3CbG6CZInmCICiKOpoW6GyHvPQl6WVcxzZCp2gLyay0VCGACIwaMiyefZzGzfJpzUwO6VR2CQQqL3nLedMm2GkLY0F9cX3/Zee4+247aVe0UmZacGX0wLcPbJFeyPeBeYqjDxP23sv6lSZQkOxLtK0o4ybLFJf+Ispy31OdPAcwcQ8VzPR6XQ2qtnZ59PzBVhSHUg/IchRiEm7e7EdwS1DGrEH6pHwrNreD/dZx13432uKb8DVUaw8pVsd3WUiF9vcv7TSGU0absFrHLHwuOT8+12R2AFPrAHOlLFOrAILA5Gphhruhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoL3GCHccJu5wtdioP9CTC+2bX03dFeucFVJGiD4zWU=;
 b=QmPQIswKplqqlANt8TmAnHiYCvJSTwY7MWp33h5KTvR5u4scjYaevReij5Bcxg3RdSzcC+X0EsuWLYohPgPgynw9J1TYYFvms57j93ma9gV6IH049e+EgNDNGH9LyA39303Eur3d60r98zLHILL8hhCBKZWXJaiCQ+5pX3IEJjwvpKhCqdxwEqxedEq7H4VZ8JpV8xF2ySQM9wItYR/xhdQupuqRoS8EjVh4kNL+8NwtkYvZYYHl8ZJnli5NxDeZON3gGbMGF/NAnIY+CxdaM3MZ+V1l/egPl7rK3B9TRP2vYab6wBR8/eiV76BBa8gkBkSDh9J4qII7PEj5y2UdKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9258.eurprd08.prod.outlook.com (2603:10a6:102:308::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 08/19] reset: airoha: convert to regmap API
Date: Sat,  1 Nov 2025 03:44:52 +0300
Message-ID: <20251101004503.2379529-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 389aa87e-4adf-4d53-2738-08de18dfef7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D6uHG3j2I9G5CqgVwwzQdzQpCWwX6Akd9qlS4SWIKL4i8jNEMKvlKNZ8/oQb?=
 =?us-ascii?Q?9H3lDtzReD/1BNVTphmBe5XE+o4PYTYFQXOxkYc6SmV8KOv+XjA9/rcaOzJE?=
 =?us-ascii?Q?mgMuCicZPgcMES7yPNKmRqEgyKrU8uy6mWp7xyq+TfjBTCIYKQ4Rar+5GBEx?=
 =?us-ascii?Q?DkpZ2qJ6ENPkWfj12gvJVEiArWpcKzrumjEd3971obZdnFLYzljLxRE8T/ah?=
 =?us-ascii?Q?qQk7LOhmnZW3zJ9nktfpX52Ych+ialNzhF5stGRQQtS/VUHo+Lx1Ytup5swu?=
 =?us-ascii?Q?uVup8TMua3J0e9yVxy/jYpdNAB6m89+Ogfw0G8YySOj5rmAqnwK9pfOZVXk/?=
 =?us-ascii?Q?ooGFgzd4shjelG9eQ04hNGUbXjntrY8qpcy7Yjq8BJWgOztUrCgF5BCJ0DNm?=
 =?us-ascii?Q?mjdraYXVwuI8J11UN9jN3in3HvtqFYsrsdAFnhq9+wCmqAC0YyjwtgOT8wcU?=
 =?us-ascii?Q?puAg/iImfbFIAu8bf2lgwtu4LwQeYgiJIy9QRvgk8QAn6zNaiI86Tf6Q9jqC?=
 =?us-ascii?Q?DxwA8bBiQUpnWS4LHX54gvEXT5z3KNoZBNCxkbhELK2GYUG1YjoQP+6NC9+0?=
 =?us-ascii?Q?0KPVzYUCV7jhOKhPW6n3Mi3H2meWbf2spRt4Mcor4DTk2QErohohPe0Bjmfb?=
 =?us-ascii?Q?qlXotrHUAHeXLgq0eq6fgts+qvsR4ADSKXNFKGVfD9lvWonPAyCH7Z8LRvUa?=
 =?us-ascii?Q?zJe63sVmQSC6dG4zn2rDjqKeecAJZxru+wkFRV2wz7oje+qxyKt/Isu9f+e0?=
 =?us-ascii?Q?msKNmjrsmT4reQ04PI7rBvh31CGTNufSHnSbM/cRcKOoEjZUXIDTdW0U/k21?=
 =?us-ascii?Q?bdr1ldV+c62L4jNkiG6eaZjnheDvkdwcZ1fgTx582m+NPlTzmufGAABthhqX?=
 =?us-ascii?Q?ovRZ3ypEBgYof/TW/skSqBBxE6RS+Dl5XqnDb6shDa3IuLNOruRUg2WJWULe?=
 =?us-ascii?Q?vbbASl8H4qODEscJjeB/4BZUBxhA9GrJ7cEiJG5N3u1KcZ9lNgIh4LxI++05?=
 =?us-ascii?Q?45Rv70yoMLLtVzBv+kf8X+GG26Po+li8Azotgdw/ZHIbft9IyLBECZKUPqTq?=
 =?us-ascii?Q?Xmvrj7C2kR/S49UaVcUCR/CO6tr1BIPrACBD1RftwYAdnFUqL8Jqu3SDHG/0?=
 =?us-ascii?Q?Ac3J8dn70hGpF9UDqWKst3cqPLFi9hWm7C4+RHVd8tVOqQ15xgsVhQV7ZL+V?=
 =?us-ascii?Q?mnha7RFwJLkLbYxz6uriemeHklWxW1x+mDDnN/K0ue/VMbGMOEIRBTd8hBBh?=
 =?us-ascii?Q?Thvmh0H4hOj2Kb5CTv9tKxCvA8Qr4rBKwdHg4EQEiNO7qwgm5DC0GrjSRzXt?=
 =?us-ascii?Q?3oaIetdsyTnyVCOE8lBGFliVAw9UAeJOCULKFyYDEldHkgGwOVqN9FCGjk88?=
 =?us-ascii?Q?d42RAp+DAE/Uy7KWDy4vkhPzRjmFb6P2cyIW8K3fBAXeXdV9S1uYBIRAtms2?=
 =?us-ascii?Q?dM7rAnt08mc15VtxSOwK3x5AQV5BcO9dJVSwgS/bFkBtgf7+eMxyhW71e4rX?=
 =?us-ascii?Q?2dr5on76hp1r9BXpDFoQQjb/ID+TjJg1KWe8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xgXPt29mH3aGJ8a/MFTjpd6gRlYk0jICiA4CHHM8jZ/GUxudXdxlI6H+R5O1?=
 =?us-ascii?Q?Q/GHUsx+eX/e54J6ov1JsoRjQP2etvfUovEwB+blWK/fzbtijwQahNnCapgi?=
 =?us-ascii?Q?TEjpr5R2+fXjWlYWpHZLBrdV4dnlfxhqZcQpZXvNLnxGQSVScvaBQimXXWTY?=
 =?us-ascii?Q?v7UMvR3y9kSjs5C+J1YQ1ud8MEWbILY8fYWgeZZSyrIOHlNI/v0nEcdAKlNb?=
 =?us-ascii?Q?uGVZomteP774lO7QgaKdVpnxBwNbHF3Dfsk8zubclI2Rytwg7Rnprso7UR5+?=
 =?us-ascii?Q?elyyLALpZSW/dx5cJ6MHagW1uzpigtS+xC25JhxLO82YJLko95U0Zj27ujMb?=
 =?us-ascii?Q?YxSW/9WhbYQ56sM1MzLgNjhDkN8TPx8q2wJvuCq+1+WoWeMtEd7ldSX4TalG?=
 =?us-ascii?Q?YCS4QA/x3bwpCA9ka7GDPBb0Dk08SxlzbBiBJXz4B4nLf5+5r+CSzL+Ry88O?=
 =?us-ascii?Q?pbG5VdXkHBUu/qhO4sat9d07hOJjqSUnTJ2IduzirhywwiDcYqngH+HxEbvb?=
 =?us-ascii?Q?bTQl9D6CUc//ERO5I6WE8mv1qbwYtLzkV0p2XhgS9EBS0j4wToJK/af5y9EO?=
 =?us-ascii?Q?ifFvIkxltwdY0GGl480UNLhzEbrMbLyjbzRp6czOuG18PgvFwEkAB257sMHU?=
 =?us-ascii?Q?jF31fJj6PkqiwBX9gdXypKbvzc+MsPBCtlTeUJ7ERKSe4tk4x3+F11Kjlf+y?=
 =?us-ascii?Q?xZ/dd6NHqttkcNHCiQBjpbCrAXmlCNT5UQrSHbBZ6AuVL704ntz2IAO+i50m?=
 =?us-ascii?Q?hPxmbcwqHyWCJ2yzW1ZJTowW5KcHxItjc5UV48ZwSQBOv1YOwmC9QhtTde3O?=
 =?us-ascii?Q?ebVwYu5zC9mu9ghEHK88yzDmsAP9+U6DgOUZb7WVUj0trLCDdLHbJb7oVrpB?=
 =?us-ascii?Q?7hv48wpBGSuzGeZqPXHa+5F2yr0izZ/fOf3t2qK9r6t1vw77e5RHKq+E9G3b?=
 =?us-ascii?Q?/4n/jkEghpD0BGgOHq2I1t8qIf39GEKZL2DHtbI3ffMBqtKCVWTgZzt0u4qV?=
 =?us-ascii?Q?EJyFRUx/vdzNKWlGpW5hALUlSC9y+lMLVav2l2fb17v6j4TRKTGbgGM0Kl7m?=
 =?us-ascii?Q?X5h0MW3oxQcWn/J4WezAcOVPwgEfcUpkffWnLUO3IFKPVQixoB7fB2HxnHH3?=
 =?us-ascii?Q?B+EAOSuzKA43LxRSdBytVpu/YHZck9/VBapb6gufm2QXGwJRTeLxzK+SXJiw?=
 =?us-ascii?Q?tNRNGV2tQDz11PxoRJJ2svGvRSszEcrpgoDpcJoVbFgfYsZTQT/KORZXrh1k?=
 =?us-ascii?Q?yObKnvNEg0B58CCDC8KZmBJyrbdHq4WOK0+tWduxm2gVXdU4YYZzk2SARBJ8?=
 =?us-ascii?Q?Gw6zIqfeiG/hOrn45szDBwJjtCioV5n20J+b1rv0YYWB3CoIqcqvm8UrP+Xx?=
 =?us-ascii?Q?vBP54vnP3MpZwmFlDoEcnbjGlBKZgaq1tyJO5+qH+YrIBVB1qEo0lnd+rs9b?=
 =?us-ascii?Q?rwkblKMP8IkyRMRPii6ocT9Cy6oy8uJMGnJRrAtxGjua+jGRC27LVTRER/hb?=
 =?us-ascii?Q?6OnSWWUtU39d/dmjKCASTFpE1K8phl8E3oQltOanhJlu8gXKwJUXRj84YoTb?=
 =?us-ascii?Q?Yb4iVCksFR4fLJWBNJHcXubiDqqw0b8mN1qs7xdLaFZS9cFZQsofGB2icZEV?=
 =?us-ascii?Q?puaoLxkWHm9F355S2DO/d/M=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 389aa87e-4adf-4d53-2738-08de18dfef7e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:20.9277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2bjZkbBV9vspmaK8Zv7gQFf9IoX54Hq8uP3+tS3LS6bowRL83xEG1ViuateqJD6Y1BUd1blfuxkkpD+nP8vr4VtWQ3bGowb54fcbsmOPG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9258
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

From: Christian Marangi <ansuelsmth@gmail.com>

In preparation for support for Airoha AN7583, convert the driver to
regmap API. This is needed as Airoha AN7583 will use syscon to access
reset registers.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/reset/reset-airoha.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/reset/reset-airoha.c b/drivers/reset/reset-airoha.c
index e878af6167c..a618bf62b4d 100644
--- a/drivers/reset/reset-airoha.c
+++ b/drivers/reset/reset-airoha.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <linux/io.h>
 #include <reset-uclass.h>
+#include <regmap.h>
 
 #include <dt-bindings/reset/airoha,en7581-reset.h>
 
@@ -21,7 +22,7 @@
 struct airoha_reset_priv {
 	const u16 *bank_ofs;
 	const u16 *idx_map;
-	void __iomem *base;
+	struct regmap *map;
 };
 
 static const u16 en7581_rst_ofs[] = {
@@ -90,17 +91,11 @@ static const u16 en7581_rst_map[] = {
 static int airoha_reset_update(struct airoha_reset_priv *priv,
 			       unsigned long id, bool assert)
 {
-	void __iomem *addr = priv->base + priv->bank_ofs[id / RST_NR_PER_BANK];
-	u32 val;
-
-	val = readl(addr);
-	if (assert)
-		val |= BIT(id % RST_NR_PER_BANK);
-	else
-		val &= ~BIT(id % RST_NR_PER_BANK);
-	writel(val, addr);
+	u16 offset = priv->bank_ofs[id / RST_NR_PER_BANK];
 
-	return 0;
+	return regmap_update_bits(priv->map, offset,
+				  BIT(id % RST_NR_PER_BANK),
+				  assert ? BIT(id % RST_NR_PER_BANK) : 0);
 }
 
 static int airoha_reset_assert(struct reset_ctl *reset_ctl)
@@ -123,11 +118,16 @@ static int airoha_reset_status(struct reset_ctl *reset_ctl)
 {
 	struct airoha_reset_priv *priv = dev_get_priv(reset_ctl->dev);
 	int id = reset_ctl->id;
-	void __iomem *addr;
+	u16 offset;
+	u32 val;
+	int ret;
 
-	addr = priv->base + priv->bank_ofs[id / RST_NR_PER_BANK];
+	offset = priv->bank_ofs[id / RST_NR_PER_BANK];
+	ret = regmap_read(priv->map, offset, &val);
+	if (ret)
+		return ret;
 
-	return !!(readl(addr) & BIT(id % RST_NR_PER_BANK));
+	return !!(val & BIT(id % RST_NR_PER_BANK));
 }
 
 static int airoha_reset_xlate(struct reset_ctl *reset_ctl,
@@ -153,10 +153,11 @@ static struct reset_ops airoha_reset_ops = {
 static int airoha_reset_probe(struct udevice *dev)
 {
 	struct airoha_reset_priv *priv = dev_get_priv(dev);
+	int ret;
 
-	priv->base = dev_remap_addr(dev);
-	if (!priv->base)
-		return -ENOMEM;
+	ret = regmap_init_mem(dev_ofnode(dev), &priv->map);
+	if (ret)
+		return ret;
 
 	priv->bank_ofs = en7581_rst_ofs;
 	priv->idx_map = en7581_rst_map;
-- 
2.51.0

