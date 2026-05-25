Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA1ACD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E35BD8465D;
	Mon, 25 May 2026 04:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="hclH5F41";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 471DE84832; Mon, 25 May 2026 04:46:26 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 712A8841D7
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heGis5gyF7utxrBzKA1ctwpqU8OlZ7pNkEw/n/wmCyTFZLOd4weXFJsmtA7cVeWw3TirYavSAzzn/9CRaQwURoM7bexdQ+Q/UrihNGrR0sgotD8GeDeITcpODJ6EnyWJQxNUq3DGxQXLXLwuQRhLYWiI8/TsBNhHaX+1CY0C9Ohc5aE7TUDobSMe2hKmUwGPOCka+rqtjNWHGeJJUzw2SBRJcK2QnMOucUjh2o8i8SZqdAB8e3+KXhCECPgT9LfGYb8LxDShIVN7IPPXEL8eba86X7EDoPuQVTCA9A9pKdhpgMQ72G4VAEAsuE1dwEOH00GCQDZNTstgyUbZQiHBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+ALUjbhI0RHGC8/iX2r4RCQDfPaZv5qQxakaVqv8i0=;
 b=UQ5HQo4RlxidnefU34eOT/5oyDWGSjpks6FkWLqO0WNiA1gEFMn6vkpXR+ZmYHSRcRJEZ8tKJSUi2X28G3sJe1BybgK26Pt06ui1dcliWQmG/dbWnPsx6tKKt0fbg2qmREHC19ydNg/UGwt93J0qvN+U7LPw9sHFSlUuUrWEayI9PXRBCyf/pIy1MajDw2TKnX36MccB8jNuy8GcBGIRCvzqxWAoJQBenech/z6DYDII/LVj10pqfbAzjjVbtbPQ5Il92zzVzP/RP2KSn8wd53xfHL6hfOSvq0SiuxRAMXzqvt8fBOZYRraqKfQ9znSzpEyiq7OpeOTYNYqXkG8nGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+ALUjbhI0RHGC8/iX2r4RCQDfPaZv5qQxakaVqv8i0=;
 b=hclH5F416G0LNhBvEmw90jNNPCaWoV0dt7P1pA59FBZxjBr3RYKaNmc4Z75IFkfo1DcKLQ1QkIlJ4FrEmBr/MOy1j+maPbJmU7+cBTsXfKeVB+bzvmYll1DiTBLmSQWAuVr+6ICjUTh/0z2clv0/MQbT5VV8Y7RK+s2W6HqkIMg3Zx0eWthqnW5tyHujXKtB967whxpdgVfu6bND+gtu6IdZIk90uIca3lKBTQMd7rxs5RMgaagJx1zvjelQA3MzykPrKpDyt47K8espv/o3z+hC3AiScFfN8mDQ43dNP/rDT1puvcwD5L5vldTfXC1WdhYD9VGt8ShTq2ViaGTu1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PAWPR04MB11707.eurprd04.prod.outlook.com (2603:10a6:102:509::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 02:46:22 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:46:22 +0000
From: peng.fan@nxp.com
To: stefan_b@posteo.net,
	hs@nabladev.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] i2c: nx: Use dev_read_addr_ptr()
Date: Mon, 25 May 2026 12:03:02 +0800
Message-ID: <20260525040303.2367825-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::17) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PAWPR04MB11707:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4f5e6f-866f-45ba-a440-08deba07ce73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|56012099003|18002099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: 74kCtP7DVVEGhyHhJwlg9dEW40H5mMAQ44EBMyRofcbrzGJMQ4jYGITVdjQMQEzObg7Mb3bEF34jivjKrUdlc+XjSvb681XLcuaHy9Hjj12Bv+kRrkuWshUCxWHbO8aQRp7Y32Oa0zSygcEC9m/zKR7LOgBqvVVIRWmLWBJkZo8Z+MxuyJTzX98MwJIZqpKHhq52pxME2Th78eT+PBYpVYYd2PkRK917KscYFnBtrktacKZ+s1V0tNj4BHV+I4KNmTS0hdpeROQcPyojOfQWXSZmKmht2aYtFTlPu0Z8bTiHqKPFgga3FdqksnD8q0WsDPNluWHNtHe1xYiZ4olFQ5jCIDwMfH/2BoDyfuEbsZgp4oahVJOZX4rl4RRFKaPAyyW/QT+WZUS1Z8qA1EjqifM5+Kg/fUEW9cUpsAAIwibIh0vhqX8O+CB7ZCukQPgWgD9BBK+tOpdtEhADdHlAs/o4Wz/ETzRuIHgJKaswC+VSI3nV8zMNex59tg6v5dbh1YEnks9cd0hvyUoMcx82qKbaeroytaPpnUEO9g3Ya86bclm2CXMPmcD9UYykK7ElnHxYenAfYKkHG8hrfSWa8B+cpNuVffdL3vyeoqXolbWD3GJqFDBpTSfjZGHo0RODhJp0N/mPIyaL6nWwNRzZ/LD4DRi3VHrlI9LuZYjYXUjEPMcSwY1SDUvxRVU5IZ6hEUivIMZxk5NipEXmFNECDFA6vUQQFcneif5ftYwjePF5dT5mqls1CO1qMMU1ggDW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(56012099003)(18002099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jK0laQCowTkTU0kICJHxTGYDEo+I2mUcxbquP5FxQGBxKrvWgoYLOqQK/0gk?=
 =?us-ascii?Q?OV+dHMAixKUXiNW+xK8STmYBN8QgRuqq0sax7vhQFsCcV4Fiibr8AV4JEG8K?=
 =?us-ascii?Q?6KptHI096iP4p6mts5tDcjaP/s+wjiU78amyixcX/qICgfhz/ucZ74zsBLxS?=
 =?us-ascii?Q?lYcYZ9ZE9ZhmB/mrg86pMYHrFZmFbXrhQTgjfCtp+LhiFv2ryuz+GAKTxP6O?=
 =?us-ascii?Q?Eo0m7V9PLBuTbRGVrcSoqYNI4zNBIAasQAi2uEg8FCQmSgHdH3YdZQnZorx+?=
 =?us-ascii?Q?mFgbTtPsRdtQWUhZOeHU1KoX8K94OD/bkqcuiFlqDDXDsU+t4NM+KTfRpioE?=
 =?us-ascii?Q?Hd7kXVH3PGGqnpcW0BohUHkHsKxCHuCLKwC5vzPPIXTFNpVB1BpPuUsNudjS?=
 =?us-ascii?Q?Z/2D7oiAFbFpejfKt3gwYHvV0LlkqT+yknk9nITZfLbNuWYc4/x+g86iUEsG?=
 =?us-ascii?Q?6qyBlwunQ+jQ1VJhbcw0dbSaXyoqrqNKNyNHc4DAmoBc8rNfTJcF0K6IKcWu?=
 =?us-ascii?Q?aqzNS95YD3Zb3W8s9NVXwgLO7UQUY+p48zzNeO9kkm+ituZAVoX9V73tIG/W?=
 =?us-ascii?Q?czOFkn269ZjNpORrU3tRiFVsHRCf62TBzuB5jWMNKZa8i1+S5q5874fWL3Ey?=
 =?us-ascii?Q?zmjiraCiN4nVzLCd0p1usv13oIai1CqCqnMb54w10RRMmNszNMjJnRQKGhWS?=
 =?us-ascii?Q?NhaY2hrn6/27sI+R36SUWEEfFEO9ZpnXqOK7ioN6uVfKI+jr/RYov0JI456+?=
 =?us-ascii?Q?H6SPcNtbtYy15tBcrJ4366lxdfjL/cVPNotuzEkXG3GqwpWJj4JsHc+aRQ2h?=
 =?us-ascii?Q?xK0bqUnfa2V9B1zafvCgoB6vitPyd1Ic7c/J4uBIKeVrQdYAdR5VVI3imi+h?=
 =?us-ascii?Q?QOpoltqLchgsgl0Ugy3b9tf9bltS/ZlIdB370BvPcWYEHPUIUUKScvxSOgW5?=
 =?us-ascii?Q?GUvesz3BS9nD9MgF3wIqfnUTACykDoW0m5i7r7CvbQjQW9nL9IOwrRKCupeV?=
 =?us-ascii?Q?6mFnS99rjviqYDcIEZ/1d3de0BbGaXwYbraUXo4D5IECzKe/c/iFfsBtj+iz?=
 =?us-ascii?Q?Bn/rgOK023qaAWSnAYjmyYmGTu6Ff9ftiTRgdNrCgyKkPiAAsDPdSKtVrz4v?=
 =?us-ascii?Q?LpYE0oquQqSnSZXPPz6jp+zhTg0vI/tDyyks+Dq5uDueuRJqoCfm/oFsO+2V?=
 =?us-ascii?Q?n0pIrmFkCYZAXragJEtEncXlUCfZ7qYBrcUcZUEoyXn3KUsTPbML1QdYPKvS?=
 =?us-ascii?Q?eOlm6e0+WbXJMEfdz+K1pZoRZEVuwnT4KAdh7DAp7/PrWluB218vGlo04vnA?=
 =?us-ascii?Q?xspHVr2mfWtqU4DxzqDbEsWBQL+fgIAusJe4a3uUYe2tVeWWQvMuzUCE+QyI?=
 =?us-ascii?Q?2NLvvs27CC72Ttvnxwp1dS8kzoeqohrd7nLXIL+gZySeqoUbMMBWEAJHRGaU?=
 =?us-ascii?Q?L3KREHJS/saXEHmQAaAv5Hej/IQOTrnBGW5iyvpOINUHdqtryqvx4d/Y28vP?=
 =?us-ascii?Q?7j5mH2PR0NZ011dXn9CMQgoFgrxFRwxyjuj0PQNakkkdijqRiCKCTlAwcPy3?=
 =?us-ascii?Q?5Y/Q7CYY+PseqisoB1qKsml1qC5x3AuAR7cPMkr1kGQVxauUqXceCbjVc5Je?=
 =?us-ascii?Q?P1/Slb6IAKMsZmKMhzU3KP6AjeHxJWfg7qitUsMtSGQOX/wrue++XmCK1pna?=
 =?us-ascii?Q?4oj0Y8YE7jr0e1Qi9+9gHHThtaTRLNI27izjobmz1lUuMG0FU8gNfPjUokzM?=
 =?us-ascii?Q?ZjCd7TdVuA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4f5e6f-866f-45ba-a440-08deba07ce73
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:46:22.6569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoeyovxW5+5fQJ8NjQ9J2vX7MHrs+HLKEul4w3FFfiQzFfwJdRElj1UTF4tzEOcAi2kxeFD5qIEFBuPBhiuz+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11707
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

Use dev_read_addr_ptr() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/i2c/nx_i2c.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/nx_i2c.c b/drivers/i2c/nx_i2c.c
index 706b7adefe8..ab3f1cc30cf 100644
--- a/drivers/i2c/nx_i2c.c
+++ b/drivers/i2c/nx_i2c.c
@@ -230,12 +230,13 @@ static void i2c_process_node(struct udevice *dev)
 static int nx_i2c_probe(struct udevice *dev)
 {
 	struct nx_i2c_bus *bus = dev_get_priv(dev);
-	fdt_addr_t addr;
+	void __iomem *addr;
 
 	/* get regs = i2c base address */
-	addr = devfdt_get_addr(dev);
-	if (addr == FDT_ADDR_T_NONE)
+	addr = dev_read_addr_ptr(dev);
+	if (!addr)
 		return -EINVAL;
+
 	bus->regs = (struct nx_i2c_regs *)addr;
 
 	bus->bus_num = dev_seq(dev);
-- 
2.51.0

