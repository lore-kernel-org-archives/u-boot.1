Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E574ACA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6C3683087;
	Mon, 18 Aug 2025 12:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="AunkBYKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43250831BB; Mon, 18 Aug 2025 12:06:59 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCD5882998
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVpKKnf1pV9f+Hm3nOvmAhPnKM0rEqKq0PUdpIPp/IkJuesOYT0LWi13p+Wc+jD1I/7P3xr9kul2Am18D8Zd5bhwNNuyrWf8TIWSoK0Q7cKYr9YKgJjJfUqhgKsgA4iASIVKASz9u80CmJd1pG5pwLjsd//Xn5aDqUwPRc87Dubwsv6nL1lEdP+Ww0tq0EHQur3lycAsindIUT8mUoigEnNXKz7B288UtKVEWHLKyqgIGv1GsKKnamCqElwGq37EQKbIjis9SYyw3RypBWAT3kS+6iqWf5tm7RoTLU0kLyaEZx6fZEQv50zAGRLesr0vwt1bU4BiPThXws9sdgejwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2cAmCVbdcRfnvfMSx1C5B0SOKGXKwGBsDMZNxbzR3g=;
 b=liYa8TXOs4/5uac4mlykQPtAAEIM3kt3x9LCF4ItpBWR84Y4R2FP5RCmf49I585hTBM0NRBdkimb9Q0aEqWD9cimhNrKJAgSiWz6NSdFGwGnj6qlaZIxvQIYpKiI0I5hssCzkIxzUUXNzP3LKzVgAKXx/+q6EAuz6Y+WnkoQyf+KTnhPx1EtLibS0xPPxa5ijg/LjqXyb2DdbkDh0ljPPCoUqeGrztShOgn4HNHuYeDTSEINyJ8fq5YhSkWPWMyskXUyStUC0wh5SAysrnL0VrG3L7LrWKkfyc8plchRhR3X5SZTWkerM4SOVIVHXdMxlseKX/dv2KtG24XaZgjQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2cAmCVbdcRfnvfMSx1C5B0SOKGXKwGBsDMZNxbzR3g=;
 b=AunkBYKQZj/0FgnkjjY35iwl43o8eVHOACfXGAPM9FgWvU4B6sYLtZejA6m56X5bDSn29ceFa8hDPEfDy8B6kEmy/tBKQ87lyuFIAVceCVoOot20bVYEhR9cVIuLPnLt7TbjIbsk1sljSeta8pwRSlPaLQmvI2Wciy5I+oE2ddcDu20qWyKs1WQ51xtOXt3Ch77AJ11guhNV6QFt1WWeI2j/q0w/KEWScHA8rDh/ShO2ULBOmpTNKrGBAksKe0SFWR5Vfj851oza4IlZ0kuqQ0yAD6wZW1IDmaH9pNycw3DtrHDJWVEIpV6E27zzrQqwCuf2rZd7ItwB9n4WQuA6QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB9892.eurprd08.prod.outlook.com (2603:10a6:102:342::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:54 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 20/21] mtd: spinand: Add a ->configure_chip() hook
Date: Mon, 18 Aug 2025 13:06:12 +0300
Message-ID: <20250818100614.432931-21-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB9892:EE_
X-MS-Office365-Filtering-Correlation-Id: 188a6970-8297-4a1f-0b61-08ddde3ef559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/ER7Z+FUKFnNpxz3W64GR75ivHdRN9P4BCJhkrRERe9FLA8OUaCoWkCbsPR5?=
 =?us-ascii?Q?fBR5yK/c4p2/aC9cD+FpCZeIP3EieBRds05wyZM9tVAhcRYl2n3lwd6G+Nvp?=
 =?us-ascii?Q?xBQWYRDILf5PPDjMG8IWLXESfv/GecLQOM1FPEBLnzzZzokJPTzsjXPozmVE?=
 =?us-ascii?Q?nKOHhy5hJmtBLCbfScNMyn+JGU2mWFeF7uKWhktPcD1bCzdLzPlZvyZG55rR?=
 =?us-ascii?Q?R3cyPtwXDPvMFRJwldqIhesRR8Y8FDfIRNVYpYlBcmn9NyynhY+13lG+9pkK?=
 =?us-ascii?Q?/GtxW+uEx63pqSPfOKT0uoOxv1JEGujh26GLYeSHApoKQx9bnt3lUGSFmBP5?=
 =?us-ascii?Q?VqywJP+5AQeu76EjZWxH+EULJtrIgRYZnNAl3Y7wA27kopF1Ab/zZvZ/xKlp?=
 =?us-ascii?Q?47iiROnpR+JfFi0A5EeGCvZUcyFaSuMO9Oyuz4b41zWxdxeeWSumCmWCyaJC?=
 =?us-ascii?Q?zeq3GxdnkLpmsZl9LSDKxDdkM0lQidOKlMHu4f56VG+P2lIRBg14X0pbqJys?=
 =?us-ascii?Q?4g3cN4JMnSmHVFlT/o4wWlTQecrw4WxPGm/mBlJxgO4L6fgEtF+ec5tO3fUh?=
 =?us-ascii?Q?I5jUbEDy7HPesS/R4C6CUlt/dI+Chk3jfIpMBDIrAa4qqe07P4oxhtsKnaEZ?=
 =?us-ascii?Q?hTvewSPFPTKcmo3UsAKMsnCoRGjqVinuZJ2BlKhW/4Pr+jCMGxUlmRqcqNDT?=
 =?us-ascii?Q?KmDJ0qJS6ejY4g6eu3wqmdJVIiCc5/s5RvXkRfYh8cgoKLH1rUl37VqDNUFT?=
 =?us-ascii?Q?/6FZwTSp/umIuQ3dGZgq/zt8tYDCWRqCEZ2rY/Vs9EhFdqiYDkq40/m7Z7d2?=
 =?us-ascii?Q?ETVeh9CVPzxIQSTBpdly6kOWi1Q4/MyoevV2fO1sQPJ/SNvOL54f6jVeaYO8?=
 =?us-ascii?Q?SWg079RCo+LBR/5+ocPaXSMwMtMuZg8eziOC+HOHgpneOWLkvc2xF5DjaCl+?=
 =?us-ascii?Q?cRJXI/jktxqgo+f8RShXe16AoJbErjQcbaZZuBbljMLMNOqneyeajkqyFljb?=
 =?us-ascii?Q?a6SXR16bIXcuF+GQQ/aqbA/NBjGroe1iZWo5OwCBU9fXAhNSfXtr9qgpKgwR?=
 =?us-ascii?Q?m+NzgeLMUEoSDlxFH7XTOpZDhbZKk5OAGF89pq1KLmTgbOqhBeIEdARtdHFb?=
 =?us-ascii?Q?uYl2/O5Wk1ir77WqsV1JRMsFwCYNZopTSPhFUQ2oUdPMsERHb1yBSIpwNo6i?=
 =?us-ascii?Q?uqwe9pNpLuhatIgwbzjlD0bdSwwY7j0oa/K4IjvKdjUyID92zV4h0/gl8o8T?=
 =?us-ascii?Q?uxA/MMfbWqk0hdHQ9cKSS8drVU8q9ewsVgK4flNN0ULF2wty+PtNJaPCsLax?=
 =?us-ascii?Q?4ueXM4WimnJs4dVBxFK5PFy1XWbUZxoVQ50XS17uLYF33ihLJ4jhKrARQOeo?=
 =?us-ascii?Q?LKcMqVaP9uSI934iD/M4KarjApj8IBiiMewhv9iZCc+2JPA8kwqbSdnzcTJ5?=
 =?us-ascii?Q?L9GQ2/nLXqcA7SfBfsq/4U3z0GXzt3lG+ET4gKGJN6KVLiHs0qPRsKSPWZJz?=
 =?us-ascii?Q?bM+iEnRZ4QP9pME=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b5pNxBe3KkdUDssIFg4seFQBaXqRckoK72zNCmwj72iGWSyu0pZJmsvzbDGT?=
 =?us-ascii?Q?oQ/Ms4BuJ5466MPByyptq4++kgW4IbCc0rPcHtApXUmcWpTm/3CpQTpUxnDd?=
 =?us-ascii?Q?S0R7j6VLDlnL8HWIj51e25tD4GkJpNtrIERaKbe4nl/fmwThfR6YXbs/1yWk?=
 =?us-ascii?Q?zNX4+hKhOQbaHBjfOV7FnvryoIBIAdhfGcIdGy77scC5L1mbkwYlMaCH6OOF?=
 =?us-ascii?Q?DGVPnRgLvkJY+wADEYlNrnjd6wW3ychAtNhYf/4TkRoFsZiORn/xZnCyQFeB?=
 =?us-ascii?Q?FlukSpjrZU/T66rEeG+A7pgc2RA6wnTDjGwRfZM+aFMZ1e0p7NU43u6EedsU?=
 =?us-ascii?Q?HBGjZiYCjpgA5x0dqAesJaw/1GvzqLFRURrlf+lkY+T8DRdkXbQbfDRcgwqi?=
 =?us-ascii?Q?Y4qdgpF96KmqInoBMkDjvCxvdf4c9PSNHseeQDJ/vi+WuAsoTkw4uUt7M+0H?=
 =?us-ascii?Q?6j5/m+XFs3nW/NASnxtFIDMqzE+ojhn4nROjW5iAVPwNfDrmtBpRjnvCZ92h?=
 =?us-ascii?Q?AIVwcisfIGRJTEzRhsRdiEyjICNLNq7dJsbbG5M2mSkll4S8l5bySZ3mYnr2?=
 =?us-ascii?Q?BQzVo1umW4n2FZiKPRVEbvsp3SdU7RZe9zlaYyF1jM57QEl8PpWjF35NFC6E?=
 =?us-ascii?Q?3zP4cmeiJjdSKb0e5r2jXmWo2xj6WqD+9yNxwpXZ71HL7m44XmG0pitw4teS?=
 =?us-ascii?Q?HVSqxEvJUPra8ecrCgXiznduy+w94UEPL91aU6lpSCiLScWxMHqXZyZfuqm4?=
 =?us-ascii?Q?JKEQSnb8S8MeG7ZSj1GZ8Q37YWc9QpDmWgDy89589sNrUnYlbr5FHSbFBV1O?=
 =?us-ascii?Q?DS2sEFE2q/xBgig0CATti5GbcUBgvFjQ6FCa+cJf2ZoFXxMIidC93wTCFQ5Z?=
 =?us-ascii?Q?l17oWqDs27nmjLQQfB0QkdBQoJgOvrKbllUzZxvZlaQXPb6RRZjPZH4eH3vJ?=
 =?us-ascii?Q?J98Y9llmbPd3eHmP2QH/barxmG/w60KqD+IYQKcf6+qfllsS92qSgIK16Frx?=
 =?us-ascii?Q?TYQntw/hiEalW1zD64M36RwaqEK7xkwTx5HSnQL0toJwt5z1KdwF21IpDLBp?=
 =?us-ascii?Q?JYq3ydHb74PEcI4PYaR7aiFtEZkmEijVXD/FL4EiSFeSD3YxzMbw0OpNMPhr?=
 =?us-ascii?Q?aBNxcs0BTd7AiXov5wUyUjjFdrtB4nkU24V1AGBa2jfmwRMMW6O01gHJLIeX?=
 =?us-ascii?Q?W4DDIKJSeUaK2r2EXQawcmUBJmoAz1k4hC0HcCRG+7s7/YZnctpSlVe+Kg00?=
 =?us-ascii?Q?sz3e4UJMlgRxENKaOLdcbp9Qm+QQtgDTjFgXq6q4xCj322zbDd0W4WYmTtiI?=
 =?us-ascii?Q?zl4G22/ZDGVmTtFSzbahRbSrgIcL6xKfq6SDvQ5/+N3/LClUZ5Nr3WJRVHbn?=
 =?us-ascii?Q?hl/i7581frKKtdUSFTAbvd7SbYUwBP1/DsSsC6kPCUXE7cT5kqHtcLOrP4Xm?=
 =?us-ascii?Q?N22tV3vjukikaPNMcJ5sad1HpDvJb0GADAT41RK3qqYZY/7TZyD5R2vJP6fU?=
 =?us-ascii?Q?KTYRWRhHYaS6uSmIwBgKvPAxg3XjWw2wGHcl0S0vJsgPlubaqXcrFWd/SRtk?=
 =?us-ascii?Q?z0HRYtJGePQCaPL/Aeyfh6JcG1bwm416FObfvmU/u1uBgdRxWol6p1jhXw3A?=
 =?us-ascii?Q?l90ElbPFfdzXyd9dG3jPgYU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 188a6970-8297-4a1f-0b61-08ddde3ef559
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:54.3906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPNqPXq555pBvZsGU3sCoyStJBjO2+wJJc11wicsi5x3Y2q0n/HTNzVjWKc4Uu5TYbvnML9z1iZeI0R3+63Ju5tazBEZ21/LYr2GQRtLke8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9892
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

There is already a manufacturer hook, which is manufacturer specific but
not chip specific. We no longer have access to the actual NAND identity
at this stage so let's add a per-chip configuration hook to align the
chip configuration (if any) with the core's setting.

This is a port of linux commit
da55809ebb45 ("mtd: spinand: Add a ->configure_chip() hook")

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
---
 drivers/mtd/nand/spi/core.c | 16 ++++++++++++++--
 include/linux/mtd/spinand.h |  7 +++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3e21a06dd0f..25e7a38a874 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1251,8 +1251,19 @@ static int spinand_id_detect(struct spinand_device *spinand)
 
 static int spinand_manufacturer_init(struct spinand_device *spinand)
 {
-	if (spinand->manufacturer->ops->init)
-		return spinand->manufacturer->ops->init(spinand);
+	int ret;
+
+	if (spinand->manufacturer->ops->init) {
+		ret = spinand->manufacturer->ops->init(spinand);
+		if (ret)
+			return ret;
+	}
+
+	if (spinand->configure_chip) {
+		ret = spinand->configure_chip(spinand);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -1363,6 +1374,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->configure_chip = table[i].configure_chip;
 		spinand->set_cont_read = table[i].set_cont_read;
 		spinand->fact_otp = &table[i].fact_otp;
 		spinand->user_otp = &table[i].user_otp;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index adfb5f3ffbc..94f324741e0 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -398,6 +398,7 @@ struct spinand_user_otp {
  * @op_variants.update_cache: variants of the update-cache operation
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
+ * @configure_chip: Align the chip configuration with the core settings
  * @set_cont_read: enable/disable continuous cached reads
  * @fact_otp: SPI NAND factory OTP info.
  * @user_otp: SPI NAND user OTP info.
@@ -421,6 +422,7 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	int (*configure_chip)(struct spinand_device *spinand);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
 	struct spinand_fact_otp fact_otp;
@@ -453,6 +455,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
+#define SPINAND_CONFIGURE_CHIP(__configure_chip)			\
+	.configure_chip = __configure_chip
+
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
@@ -521,6 +526,7 @@ struct spinand_dirmap {
  *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
+ * @configure_chip: Align the chip configuration with the core settings
  * @cont_read_possible: Field filled by the core once the whole system
  *		configuration is known to tell whether continuous reads are
  *		suitable to use or not in general with this chip/configuration.
@@ -569,6 +575,7 @@ struct spinand_device {
 
 	u8 last_wait_status;
 
+	int (*configure_chip)(struct spinand_device *spinand);
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
-- 
2.50.1

