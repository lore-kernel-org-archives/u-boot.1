Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B757C87FDA
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 312408479F;
	Sat,  9 Aug 2025 03:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="xfyIYvAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F3CF84816; Sat,  9 Aug 2025 03:07:13 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 505E5847DE
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiOIVnzdHbNGF/U8sycb6pyEq2rygJXJHZ0ibGYkTn6ZxY9G++gIPobhJexk21nLNQN3b3GuJj7xcUHVHZp8+b2nlCGhKz16REsEa1/EWUep7zggtPMB7H8XdjqWUojtW5ztbfn48+xqDMGilGk9EUQcu6wqMB00Ma5LZ8fkSrRcQ7BZ9A7dtd/xDJKwtdDWwPJ4oo6nPiNUF3qpQn8jKvKSxHHvZfawhMw6XuRX1J9KReftNcG6FW28cB5h17sgtEf8OJbcVzGCwvmhkASUiaMSwXbZBTCegJUwEK8J8Z3pOCNbOiGEd05N/Dq4vI/GfnB+bmxDyyUTouRgtYGs5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9ipnSny3DXPG+sS7Rq1JxL53MuXqmlpSsmyBizhRCM=;
 b=VSCPXvtokq7zN+DoyJrsYowHBXwG3/UH4XpjJUM/fDOTQUW3MSu18mc47gKOuMyw8F64b705XvqZGP9FpY0ZdqLvrLu8dUlsK2hiOAO9M6RJrEgoBxCMo41XzkVtqn+Qh3ZixKzKckL2Wmm2XifEdJx6l3QQVeW+upx5QEpDbKUGnxv7c0zlHHIjWadB14N/R6ZHsZVg6dPffVu5bGak/lfQ/zRsOn9m4nkrXc5yn2i8r+YMw2bgQsG6cNn+7eC2p659mVMPu4yY1mo62P/wAYbzytFPfFEFQA3WTpOzx2cr1hTvUqx/IP/FNSC1OFROCZV5bdaxqpD0eGoAKm3qwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9ipnSny3DXPG+sS7Rq1JxL53MuXqmlpSsmyBizhRCM=;
 b=xfyIYvAHoiqI3LXuosk7dXfJnVDXLyzOi6J1Kvt3XMpZN9v9v5QIH+jbNG+nHCDCc5ULwZp5cZcu1U/i75TR0frp5HdNMbOmPBsyUi7rzCkRoEo5C8QlI9TqObcpHlCNu1TmWKMBndNtLUd7bg6D8/xRN1yN05nYxbOD9+61PveTaAY/yXxBi+2uljTSjokE4mOU2nEHlfblhkCd8IvB3x1HUskP+ScA8NSkFLKK7aGlvC3mzc6ywaZ2OG0khRl7cwXJ5fLk1nFK63S0SZMoSciQvt/ItMrMQHohANPF1QdWvERmN0rYudwJmvLwBW0yYmf4VhbO4l5LyIua1oXjVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9582.eurprd08.prod.outlook.com (2603:10a6:10:44a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:05:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 18/24] mtd: spinand: Enhance the logic when picking a
 variant
Date: Sat,  9 Aug 2025 04:04:50 +0300
Message-ID: <20250809010457.3125925-19-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc6dbe9-5bb2-405b-36b7-08ddd6e0d420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qRsGYL49SFHy+UmiSgz/bRqktMLsHK5NjOYNWOAqrsw1Zg+gBnJ1e9Uo1jjP?=
 =?us-ascii?Q?fG2A2Q8bIo+En6zj22dQKA25vwNon7t7wLlqescvTEtjsnRE20N2WxhcClvK?=
 =?us-ascii?Q?eaBU6oWYuVUsptWcy5JYdn30epptnuozq0gC4ePu8Y8iYLXVdX1TgCAa+f7J?=
 =?us-ascii?Q?VftN4U+4DTeTtQGNuMBHslvKL7FMSBGdtDNJfK9H6xheVQWdHwJaTyBq+TBM?=
 =?us-ascii?Q?hnjgVFMIXT0zer+my5oJDY6Z/fMv+49n57kUp2B0hAl9mrWwz2Ndnw+BGZ68?=
 =?us-ascii?Q?nE+H9ibHxoTEUWwwfSpYytl+LV6fx2torb7S96t3jiH1RIb3It3QFUI58BFB?=
 =?us-ascii?Q?IhNK8feL83qGIMd4D8cIJvgdnto6sndNHlFDf/E9XjcNSWDs5ydvhOVqa78P?=
 =?us-ascii?Q?5nIAWWGF6szENNH4fDd11eM1zuppBPHR+0sVMrzoB7efPMHuEm8WAnPUhJwl?=
 =?us-ascii?Q?tAPCBProEfWvNq77ySUi1kxJuCzTfowCemw8N7HUCdezRs1jvzdZNCtVSZyH?=
 =?us-ascii?Q?3U0pPNRpogUxbuzrIeh9V/Ne3K4UFH/xr6IG4LzvSEBQTe29paj1u9AxB/Z7?=
 =?us-ascii?Q?1Yv7vAhuI2cE3M/QTV3uO086Lh+otLN+3Mi1kbnK0CxeLfp5BCEtLMGwQWvg?=
 =?us-ascii?Q?7uiKpCscwdOMH2+rRNbB8cQWrjDil3bHmFfLpgqnCLcTPR9VRu9Y8+4XtchX?=
 =?us-ascii?Q?EBN+Q2g7B+xTodRprtOoJOe95Gl1elLP+RAfj2bSROc6qe0C7gTpYfVhVk5h?=
 =?us-ascii?Q?C8XwO+rYiNmqiZKpHvwffVqjQrcAA5RYIL2AkFySdCLLBOWoIFkX9OwHszUp?=
 =?us-ascii?Q?avBqaGdVmfVcvDmKtKTld0CTVZ6157mL1krTRulDkNMrTbgkSArznrYqZxxs?=
 =?us-ascii?Q?GMbxcsD11gaXCnIcyQ5yhPkzhS2O1RSAXBGpi+x13dBHhst8MVLOP0nVSqDe?=
 =?us-ascii?Q?zl8QchSfOkKe9febaBpAlaXZjGeVJ87m6YmOvPayWHjNmQkTRsS0StJKs4j4?=
 =?us-ascii?Q?gxNcIpucVAU9W4Kj/Een3QK6knSdH48sIvsz/RVcOgpYZaa8LjDLxAEMDGgt?=
 =?us-ascii?Q?hzgZLrLZInDTYQK4faCMFtEWOs4LFoFBCQMW9EkZ/AaasaCMFYsAo7iq1tWD?=
 =?us-ascii?Q?bLf1WEBew1f/tKg8JiYI8YFEsNfn4Wo50hNTtHVpI6hI4rk/nLwCTQ1Z2IpZ?=
 =?us-ascii?Q?Wa1M/NQC/x3wOiqod0vcktoYWwxMSxlyh57fHTeIs+V3L29ppO+uLEqhc9dc?=
 =?us-ascii?Q?s143ZPKl+ucILDSg1Uo4H6QiRH8sJc+MQM4o4SgzZ0i/sXA+I7WD3M9O0GYt?=
 =?us-ascii?Q?6SaSD9ie1THudyj0fBQ4eoJqi+vlkf6v8+tNTgSuzVmOaQ99t7GbfZjPZUl/?=
 =?us-ascii?Q?/EBkt7l90h5WiGloKlOoTd6Fjo3gsXjoI2YC9TxCv+uvpuwgXy8SG+vu2BT7?=
 =?us-ascii?Q?uW5XQmZg0kTkm+2VPX5ndZaaxbsvrkXDKoZcySRn0TtUFQdKczPNvG/SjNV8?=
 =?us-ascii?Q?VkkLPkAkfgb3Uok=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NHFUv+aj3fS3GT4mS19I8cnr8XHvGpXnMu/48Xk6yG9AqShqW33sk2QDXHep?=
 =?us-ascii?Q?O/Avz7E8Br6YMj8kXqUg1943REVVQ8U+l6PJKHxNIyidTaBGDWr+AQdH4Zql?=
 =?us-ascii?Q?XuFoa1P3OqyaOGAk0D6MuYVSjMYUHLfc4gB3p/2WUCpRB18DbmTSxFFJVKgZ?=
 =?us-ascii?Q?2seh2LjbPh0xH18LSR4/wVbKiO1N0EC8o8ZVTK5i2QXzq6WseKnCIuDsKfzJ?=
 =?us-ascii?Q?ihiwAjtFUUcjpMeok8+yy705yL7I1hw6uPSwXTA9p6iZJeYPsuG5fnFDmBqv?=
 =?us-ascii?Q?RtavLCyNZ8/VXjWyFnMmEaH0EU7rCg/lEdw+aXpzfEQqDr5fQTf93U4qrzHK?=
 =?us-ascii?Q?2PWYjYwS5Ue5QdEuPI6usArvYCEAoWs277/GBE+uf0W71IWq43MlAvnbfVsu?=
 =?us-ascii?Q?L2wq3LKyn5bcJdEdHcDgCU174YbnjbEPtsy8hTT5U0o3Z1rvujqG1UghW5zN?=
 =?us-ascii?Q?kQnRJufRiTNP7Rzd/KPhUkRbXaLwIQ956S72hartOlXxJ/9lbTqHjc7WPWFA?=
 =?us-ascii?Q?wvZyDkjFpIF3iO2Ieb2iplsaGPqJGCgq0KWYLs4/WkZCjAu6JoNtoIxv3ewm?=
 =?us-ascii?Q?/qQrANWzCApqB2FgdJ/hZZsJeEdvPlyZ2PMeLB03E6tNolHMzh9qNU7IiD7w?=
 =?us-ascii?Q?wm6c3ue31fWHEKyMcCcJrgpsx1TkrnUTMSNeRl85vnHxwmefvKVjC2rjCKN4?=
 =?us-ascii?Q?ubPaQgT5usVe6tzBTn85jdNiCoDjcQ7VfJojoSfU+e2TFJVhCXtHZvHAZoO0?=
 =?us-ascii?Q?Y5fOcOZKAgPmXa4HHnjsIBV5zLVgP+/mCHieyAcN+aSC9dKo9d2JeNqXaqn7?=
 =?us-ascii?Q?FtN+3Lo00iXpeDf7DvGNuUKizfyjBPHSfPh6/oVZEMGU7e54ckw4mzPSCIOy?=
 =?us-ascii?Q?8fKWUcNbkfG/oOHmnpqw1H9BcgrFZWU7/n4tGarGeJ2fyvI8XsyMHRpn+01b?=
 =?us-ascii?Q?uAnhLFSzWykR1TWMtPsr7njSAmpjwWgVVSqiIipYLUSqbjAzrKV6Y7o+jOxB?=
 =?us-ascii?Q?qhUxilKDu8amGeRAjfBw3zyq+NTLNLai8yuj5RDirEj8PmkCsOAPdpqlu3kw?=
 =?us-ascii?Q?HJrc8fyQcO95G/wEKcuCAhTNAgbglUaMfmmug7zswvJtLLnWy4lwAR0d9k3g?=
 =?us-ascii?Q?lp+vS5OC4vXcYZwgPHam9tuv2J5gZdszpNnpHSDQuhRAg9l4LxyDtFRSjpsE?=
 =?us-ascii?Q?MFaJY2J95tOJmM2sbXaWzo+jGLni4lH40TF4JlLzDL16b8P+eqxEs3Ff+Dh5?=
 =?us-ascii?Q?gKOVP6iehORtIIPwvQVmmmU2f6hOscZPw5Hw2VSf6jiChNPFYBSVVtQb7Dtf?=
 =?us-ascii?Q?RToKk8HHlckqljZdK5TkD0ysYT8Rkat4g8EdhpNg0IDJJWyYbcopkPPFknCG?=
 =?us-ascii?Q?BY6bDeh8mmRFSwwpMnzNzpVXlxxVBgob3W2URi7tN62LHM1Ok7Nn7aMcmhN+?=
 =?us-ascii?Q?aHWcBJQccFDXT/g2aOfkyrT89q0Ff17JCnG7PgYkExHUAds5zLAkiOL35fcR?=
 =?us-ascii?Q?oROQzkmN2SF/E2LXaLUIxBjo+pkVEEsk113z3ydT5/JHm9ywxGkpi5tEW5w1?=
 =?us-ascii?Q?j465gHTcBinDQY2OCVNroLehsOPIztKVritHJOdFuyYD6Abu49ACuEnPdZPn?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc6dbe9-5bb2-405b-36b7-08ddd6e0d420
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:27.7827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtB8qBgBcf+UHYYglM7dhuPfykIxMJ2mRLdojBEeCVSUgYOTwnNs3e71cpa/Qiun900WH1gvtEEg30Yk7gQZMhJatvKLam9BZtdG4BCL17U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9582
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
created by Miquel Raynal <miquel.raynal@bootlin.com>

The code was a bit restricted in the functionality since not all
required functionality is supported in the u-boot.

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

