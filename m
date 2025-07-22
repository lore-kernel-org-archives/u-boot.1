Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B15CC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35ED4838E5;
	Tue, 22 Jul 2025 13:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ReTsZg5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91D26838AB; Tue, 22 Jul 2025 13:42:21 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C8F5838DD
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRGkQtYAb3Xfopn8IAmj2eoDlW/W0IhIAsHVDg0DQy9E49L8FP16i2ozbrTTUBs8J+5TAmOh7R730r5h5MkHzVt6s5cBqBgp0IxKZcpaeQdWYausNEfU9/zxGS4xMMRbJkHogRZuIw6q4HfLb344pfdG/ZqVuJbAYfH6M/Ql+Nc83VeTgV8mYKDfiZUsHL0pRRsZV9fawShYOrQzv3k6HfyRJxIWvJXn0YZxWrAm2OUj7pXgQW3sk5kKKMMaSd761fKF0D+jGiWCEW4Gms+FWU2JD/+atDjJwnqXBrbYxn8hM0VhCpiKaUYb56E2i1tqCHYmn3dumPp5APx4oj53lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmBvzpv+nhSYHiO7t9NoFmiD6hs9R3wxs+pJUmi+wSQ=;
 b=qmyPXDKvL3jFQiNGHSITnHU18EQ947DzRWzOtQuJeeXsUQ2oHEyOe5lh/m0QxLyuwZkPlm5y472ph2VOH9ZD4UmPH7nBZjc0BkIURcm5SCZJ7veDR9NrqWqJdHVYoGFoXbJyCAejuxZfnJL1b/OwdBwtsgrA53WUw+hIlI+gWPRnxqzN/YAx0gCu5snYpp3kkFe5KZSzkivccKrUWZSIuU3oYCqfgBOYajwpondPFegvjvIWfwPc4tn6w4htm/8lhbElW2ZWpsZhiUn0tM98upPyfW81uh3KgFfHAk9sIUFaO03GQY4Q4Mat/E93rZ3TT4JiBcrKiRke9mochxj7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmBvzpv+nhSYHiO7t9NoFmiD6hs9R3wxs+pJUmi+wSQ=;
 b=ReTsZg5f51ylTdFzdUx+AVUF/zhrzmsNCa0asiu0qRoDPxXL8w24kPYzeRlDcGvDHFCUdcH15IVrL5GEDSVjv0Rop6YPAWkyUFW6K34nj36XjeKFmqHvaaZy5rYPzLzUUzylGqlB3SG/TZ7Pae+Yo2IFjrf4NSGGs9gJXTYurnlr7XE9YjjBLLW/w9zCHtUw7Rciol877efWGWlC8DsbAhny1c+2TTuqDp+jKK+BQrIZCU+O9IYyaRMAk6965Gm+MNB7FaN2UYEWGJBqMk09oOfNmbZIylw2SR5mZFvrrZPDaoTQKAv+RPQxJYUfZPVTdqIzFNVUTqE5PNVf2AdF0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9908.eurprd08.prod.outlook.com (2603:10a6:20b:562::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:42:15 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:42:15 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 18/19] mtd: spinand: Enhance the logic when picking a variant
Date: Tue, 22 Jul 2025 14:41:34 +0300
Message-ID: <20250722114135.768998-19-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa41a47-22ef-41e8-058d-08ddc914ce1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?or7krcn9BnMY31dq11girE0qharwhdTz9itT7WVM8Beb9ZKkTju3RbfPmF3Y?=
 =?us-ascii?Q?BhsCd84NBisguBGKT3pEFIVq6UgeKVKYqUtlMcE+HmRr8TmwZPKKQoxNwoif?=
 =?us-ascii?Q?j3dYQq1pVwZoDvxPZlSLlp/GY6ulT7xgxQD3/3tH+Wg4q/i+1suo+VS1WqWC?=
 =?us-ascii?Q?AyayOdUks+C+6qoPV4QMLKtbMCyr3tzz9S4hhT8Y52StEVpanlHFVWH3IKS/?=
 =?us-ascii?Q?mgUP7bjCt3wbMwKbqWxjSfb1EKUnjSfq4FXwsJR3ZljfauYR04RSCryuM2Bi?=
 =?us-ascii?Q?Wgy/K/N55IUmwctS1nrWaIaziziih5PhJet7DeCcLsT9C0siryhZnhcNhbG9?=
 =?us-ascii?Q?PSzvkl1+jSpVGUKfu5o6p/ypHVw0VXDP7Gvn5z1e72p1/Y7ZXatY5RIhCBvI?=
 =?us-ascii?Q?SEmbA4SDCcGaX1CB97BEC18tcpVokgmDIygUK6e3c8miR2FYv1PLVgecjJTd?=
 =?us-ascii?Q?KPgcvJriIsVB4ebKPJp4a2u8zBG5t5CgqJ4biQX0dw0QjRtMxTI5pAsjqCMg?=
 =?us-ascii?Q?1NJEO4ieFaJP2y/bBe/ZzO2wDcEmj4kpXNJd7qB7jiYGf18iA6K8+Cz+yjw0?=
 =?us-ascii?Q?HoAoIEQhja1yJKb6q/n39h7vJTYHha6HapG7Y4bAa7XE+pVRUmxnLhEVFre+?=
 =?us-ascii?Q?lzQI2IqFS72X3UUdInAVoti8CB7GvwEOA2RnkuVzSatgZRX07JxlRpUI2yha?=
 =?us-ascii?Q?a4iAeO4/6IItxiwwvfelqC5RQI1zQSP02DY8dCq6TUfvoQ6lMARKqfV42cTa?=
 =?us-ascii?Q?mBRKsSvEVhRv2iQuROTn3KAkoCokn1o4iwUinT4vUSWhxTa7gZ9gUiFi/pI6?=
 =?us-ascii?Q?keHUv6kvTSmuDPOCUG9Vz5F6SqT66Vxpu24giJZj4HrQUxyVWjDMJ2OT/baB?=
 =?us-ascii?Q?UCqwzAoAOXSeu1Mf/yCKPCI7K+Ag1HPeK+oFscynSIIkeNl5BT1RP41DkwLY?=
 =?us-ascii?Q?Um2xmAPnb8ehiZh1K9NIgNzSC7om0B0AXukWnJO6rW2JmdkrSi/AjB0YHC5G?=
 =?us-ascii?Q?TLMUKQIjrlbPIay4cZJG5/QdtavgRcPOg11wEZGJlzI3FfY3ed9pZ4SiVir8?=
 =?us-ascii?Q?Mr5JW839rwA38U/UGvcHe9HLdNTTHVAI3tOzsUF3jknFVC3huDGGEVMdp0Jt?=
 =?us-ascii?Q?kPfMKnKiuy/Ivnzc2XD5tTdLH6riIoWCLWeEE1e4RxjDJJx6980J4DlU5U96?=
 =?us-ascii?Q?8bq1BwdPqtA+biW4JftOXRsmQhUL3oZvaiiZjmkwIiZgN+u6E6dBN2PGcQZO?=
 =?us-ascii?Q?Yo2oQJHA05jvNZRQZrqPMS97f59c9J3GwDVXpbgUXWhIAoBQBPITp4+41mtA?=
 =?us-ascii?Q?WHIY04aP/9wXK9/ZgNN/4IiHWK/rzU+M8UjAaKGWhU0PJ6Vt2O92dEksSqT5?=
 =?us-ascii?Q?VCGDfjliDJNWXZWp+OInmpx7o5AYwwpgx4rAEhFD1wappZLL+M7TlXP4lOBj?=
 =?us-ascii?Q?imShMgoc44zPeMlvhJUgm8G4NShJGEAcyumH3kbed8mwcQdmqeCGJ0Qo1QjG?=
 =?us-ascii?Q?20EFr9Rjii0fr5E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gkXsc2/+bjEKvwwSLpyBEtiQ55YdvpfTOO/lezS2bmkmUSfPZoYIYtIE/ijJ?=
 =?us-ascii?Q?7kZ02J8OJQKiDMRxBC2SXkgevEQKmunEk6glpgno4CcFO2fAGaAvblvX2amC?=
 =?us-ascii?Q?Zou3ESOitrEDOHGK9FLst/7C46Oeb3tCeXC/EPo/O+z2e5H5k94Y79nSGzB+?=
 =?us-ascii?Q?Jmcskfs+c0wrldONm4Jya6NUJALAT3TXnz2qN4xea7rMWdR9cAR6SSntCBVr?=
 =?us-ascii?Q?QxwCcKGgLczoq59te5DXnNnUwLzQ3Ea/MM2ZrnE6DZRdB33pgF8I7IdkMse4?=
 =?us-ascii?Q?bWcuQoWjxiZ5yUhcyOOshoAulQHOJT2PmPIc2IG+Yq2lPBmRgqR5EoAyKM/M?=
 =?us-ascii?Q?c4jvfii5Bh0hPkQgnAc0TBbEixncRsjnq5t2VuFefu5orl4j7vQrvPNgccBG?=
 =?us-ascii?Q?+wM7+C02OfHneONve0ZHw0nfARFLf+TG0Qo0oF8urPKtioQenquKJFouEsmp?=
 =?us-ascii?Q?YXyi26OVw3Nca1PnDYYZHeApwFkhgerXoimQh7szr9P8a0pZlWM9TJjUg6qh?=
 =?us-ascii?Q?gHTlqplttHzUqt+Oih+04kTeBPhjAIOlfI+4TUwYnGjtcHJLlQzzcIfRVMeT?=
 =?us-ascii?Q?93+l93A8JdGxlGPQ8jWzTcYCnIIlCFt0RQJnBzd7duHWV70RCWDs+OgoPyBX?=
 =?us-ascii?Q?6M3+tocyfH2cjp1cNKD9cHdtCSEdj2IPpFzbasxvusE5zZjOuwZm1dJZX0YD?=
 =?us-ascii?Q?/476YD3cDYmyCZEPoqwblm4KhdgoWcspyrzt9+wSOPLsJVRFy42rxwmbGLex?=
 =?us-ascii?Q?UfPDC1LeuRhCMcHfw+uIMlECr/EK+nFj9DbMsEakb1DKEOA/AHhxOoZ0Wf58?=
 =?us-ascii?Q?0g5/sP/H5mHpOVKzYFQYbmCVsiDBik1bnjqDxOrsYRDJoZlU6weMEvbmFFXf?=
 =?us-ascii?Q?3N5MbVJbSCsSjO/FAiflEqbokkVbVNiWcPNDZElX1ZYiq3h/xPLUYGTZyMhA?=
 =?us-ascii?Q?9Z8W2QEVNPDvXpP6ISE+WQ+Ca9sPGGCXZlI182NuiEXN4FCZaNFtEgcqO90K?=
 =?us-ascii?Q?RTTeNZkR04QdL999oEHEuDdZEErlZJGLPH0ccaWE6v739jjysLWujPMsLSR9?=
 =?us-ascii?Q?t5AORL/M0g+SD3DU0ezPw6XLymqT8IGUo+HPCnUV5M4+/JMU2EEcoEzbzSv6?=
 =?us-ascii?Q?k4NnZHKFcaEyJlaGsKCJjvOks6lKmtLujqics4+sC2pIQMMlvH5hJxRoAMUc?=
 =?us-ascii?Q?t+D90A3+qavyDtXddv1lLqwqgSp/4ShJi6MbSzfL6o1xI7g8gixDQbBBZ8ad?=
 =?us-ascii?Q?q8PDECCCPLlnRz5wgVf+QwF4LmcC8iV3+DvZgzcVGIOkF59zK9rSsu4u9JZk?=
 =?us-ascii?Q?SFvNFxs2J6G9aj4AeWP+XpRnOssKhzHh8IP8w3mwENvHLNh5SM4Od8Wn4LrS?=
 =?us-ascii?Q?Ae/DRG+/pBILOgC9NDWX8AkgY6FwLqBsbLNJOJgkujpj7vE20u0SF9yu6Nar?=
 =?us-ascii?Q?qOEQ0UftQImcl3PnYlK5kS3u6ry9pwHtGaH9F7Qd8hv9Hs7Y7b7wa+Rlwopj?=
 =?us-ascii?Q?NIkPosi07Vs5K3virXvc15pj3me9w8oPfvhGnC1KQ1DerWUNtkLXVDX2pbz4?=
 =?us-ascii?Q?2uHeuI09PjXrvG3POP8eKKN5K0iAlsFTS0dy5ryCHCF/gPA8YGkf06Bw45NZ?=
 =?us-ascii?Q?qFUMrDHbambgmoV6J+MqfgI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa41a47-22ef-41e8-058d-08ddc914ce1c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:42:15.3333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHnXRGPHus++uMd4YLCkk5yQ29rR78SK1uo1P4W0RMGmxxQ63bV+l9702V+O9w/OWdjo6pekX8OdTN0bwweb5C4qxwHPl7qL2OY+xEOtsNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9908
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

Currently the best variant picked in the first one in the list provided
in the manufacturer driver. This worked well while all operations where
performed at the same speed, but with the introduction of DTR transfers
this no longer works correctly.

Let's continue iterating over all the alternatives, even if we find a
match, keeping a reference over the theoretically fastest
operation. Only at the end we can tell which variant is the best.

This logic happening only once at boot.

The patch is based on linux commit 666c299be696f02c3354da104295fb94b8f65d25
(mtd: spinand: Enhance the logic when picking a variant)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 13 ++++++++++---
 drivers/spi/spi-mem.c       | 32 ++++++++++++++++++++++++++++++++
 include/spi-mem.h           |  1 +
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f16d3b0335f..daf6efb87d8 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1266,10 +1266,13 @@ spinand_select_op_variant(struct spinand_device *spinand,
 			  const struct spinand_op_variants *variants)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
+	const struct spi_mem_op *best_variant = NULL;
+	u64 best_op_duration_ns = ULLONG_MAX;
 	unsigned int i;
 
 	for (i = 0; i < variants->nops; i++) {
 		struct spi_mem_op op = variants->ops[i];
+		u64 op_duration_ns = 0;
 		unsigned int nbytes;
 		int ret;
 
@@ -1286,13 +1289,17 @@ spinand_select_op_variant(struct spinand_device *spinand,
 				break;
 
 			nbytes -= op.data.nbytes;
+
+			op_duration_ns += spi_mem_calc_op_duration(&op);
 		}
 
-		if (!nbytes)
-			return &variants->ops[i];
+		if (!nbytes && op_duration_ns < best_op_duration_ns) {
+			best_op_duration_ns = op_duration_ns;
+			best_variant = &variants->ops[i];
+		}
 	}
 
-	return NULL;
+	return best_variant;
 }
 
 static int spinand_setup_slave(struct spinand_device *spinand,
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 6f06650384c..db44a7b26eb 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -499,6 +499,38 @@ int spi_mem_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
 
+/**
+ * spi_mem_calc_op_duration() - Derives the theoretical length (in cpu cycles)
+ *				of an operation. This helps finding the best
+ *				variant among a list of possible choices.
+ * @op: the operation to benchmark
+ *
+ * Some chips have per-op frequency limitations, PCBs usually have their own
+ * limitations as well, and controllers can support dual, quad or even octal
+ * modes, sometimes in DTR. All these combinations make it impossible to
+ * statically list the best combination for all situations. If we want something
+ * accurate, all these combinations should be rated (eg. with a time estimate)
+ * and the best pick should be taken based on these calculations.
+ *
+ * Returns a estimate for the time this op would take.
+ */
+u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
+{
+	u64 ncycles = 0;
+
+	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
+	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
+
+	/* Dummy bytes are optional for some SPI flash memory operations */
+	if (op->dummy.nbytes)
+		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+
+	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);
+
+	return ncycles;
+}
+EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/spi-mem.h b/include/spi-mem.h
index e68e2b50e85..36281a62f77 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -392,6 +392,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 #endif /* __UBOOT__ */
 
 int spi_mem_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op);
+u64 spi_mem_calc_op_duration(struct spi_mem_op *op);
 
 bool spi_mem_supports_op(struct spi_slave *slave, const struct spi_mem_op *op);
 bool spi_mem_dtr_supports_op(struct spi_slave *slave,
-- 
2.47.2

