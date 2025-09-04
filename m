Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B11CA1015
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 14:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A243083BB1;
	Thu,  4 Sep 2025 16:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="aUiu2o4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A28783B7F; Thu,  4 Sep 2025 16:50:43 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0EA783B95
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 16:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riR4Zhu7zfguWDtVzfWAsP9r8AAU3CfnoHy+HVm4UC0aZJjSmytzhYMrvQvXVwJEhl1W/gEIKOvWxez35sVRgIT9jRNGAfzshCWYB3ODyKwhjCQ7w/HdyqfJ9QKMZ9lGjh2pQC/BbbS0P/L9v/ilzL9SyEwFzyiP0n2QVOrREk4ulYbWc+pzUkuI8MWhU8H5EGHXxjNg/EsoMv9m4bPJaFGi2lwWC4o8SjwMxP3UnzaT2Fhe7rRxoda6crrb0QgNJF1TVGJoLzLwePMq9nu+NhcZ0ZQYSj5VlKs+QLQ2BQrT3gLQY5GUiRR9NusHIBoYHdareUWR7LryuwxhHJ9XRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeDXW7yk98sAh/f0dBSzgtlcqB/5ecGlCG/n7NJMXU0=;
 b=JGLI9M2aE1BTRfV1PiNg7hX/asJHUu55qxcZjS+WIQhN5lGUDW4hqMw7FBI4nuYDZOmLnN8uIp7Z6QeniKLqL/tE0kCXfv6XchjUuhqBvb3dwhOiz9aUdDan21cW+ABeZ8J/ELkMRw1uULW/4r0gYtYlwTMkhpt+9N6i3U/9KDXtQbCJlhcywzFK8gjnHff6GjkqaxxIuaksDXK8St49/PL3f0GRTbtdJneJa8uaVyX5NCEG3R3bBBDHC6RdSyD8h9KbQh0AsN040Y2BhJmqPyokaqMe6ozx42b2Coj9y8lKhP8cPGfnn3gp9UfSrCsRLJp50PKO2TWK9yYBtA3rig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeDXW7yk98sAh/f0dBSzgtlcqB/5ecGlCG/n7NJMXU0=;
 b=aUiu2o4UeRrDHRfLT7K37NzJEVtdVGgn1DlHe/bUB6fi915bngnk61iHXwa+cDYvNGGrtvXkKMgfwzWJjUCz7dS+iBU7FY2XsbNwxsdV/ACQM6ZsFaACsZdgQRLTgdQzy2JbWVSODGy4z5ane4lctnONMfGXUMBvD4U3WO9uVv58CRCxaOOMFvJhZpBxx4QKAeXjz3E1V5w1DCigKOTR17osDGSL42NqjiIvIRyMhx2L0s87M88YcLoW21PSVaWy7362TjvkOF/sLh+FYx2qNX3DpGn+dWHsMxwZJJNrGcwi6+If/m6LcXOyIQN4AGfM52VwOTC27VbwJO3AOSPg3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5568.eurprd08.prod.outlook.com (2603:10a6:800:1a8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:50:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:50:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 3/3] cmd: mtd: add nand_read_test command support
Date: Thu,  4 Sep 2025 17:50:23 +0300
Message-ID: <20250904145023.659922-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904145023.659922-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250904145023.659922-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VE1PR08MB5568:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ec399e-4cd7-43ac-486b-08ddebc26868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UHmKN0pQfcoxe6vAqgOGdzj74GRlLRPebwBGHmWMgLzBI4WBK+QB+fbYiRhq?=
 =?us-ascii?Q?Zs++kKQH7H+DIf8TsMV1K6eTX66gcfea+C5VzEqBS2loC6GOuyfTdjqIg93o?=
 =?us-ascii?Q?ecas7ydI4hlmDGu6o/nYHXifCJThj/IdL7IFxZi+bFQhNlKIJWyas+3Yec8w?=
 =?us-ascii?Q?CnpO4Gz+tW3zXl/MfNwnbt4AL4csvycZwwJDg/o2SubJOgZ/fbbeOMZeryMi?=
 =?us-ascii?Q?5xpLqPvVtRCTCqu+YuTZ9GnYlYshx71LPwHJbiVm7e9oQpZvKtI3P+5CP4WP?=
 =?us-ascii?Q?+Vztg97F8Zx9hV7jgIApM+ALV/OgehlmuETt0M1wF2ohoTvrAWLEzkEQYQBM?=
 =?us-ascii?Q?ncH1Hp1GCnJZ+6YZawQYOD8HMUYo/SEwiIzgOiJrHZzwRPi0qZmgSGnpo5BJ?=
 =?us-ascii?Q?o5uA67L1U1bPTmhOTXoE7vyYhxjlKyTxyCGrGrdlr+V4t3DenDVKaqK25Lue?=
 =?us-ascii?Q?dsNR9H/K+vIvOD5iWef2SxRLpY4mDGE5/GauAFka++PLAvWeO7VLEjK6LOwl?=
 =?us-ascii?Q?dRI7jua+LYMp7f9zbFFvN05gZATQlZKplM3ceG/sgMXXLOS5H+tms8HtzUX0?=
 =?us-ascii?Q?gLPU2G7vJKb2UyCaEBq7WM/mP3GsTQrntpUIiecXlPy+14pAVWEwonxiiSh0?=
 =?us-ascii?Q?xVnoHHi7VbRKhq1ubzbO6Kn7rDvCAl4aZodfonmKSaKzQ99eMICCY+igBAja?=
 =?us-ascii?Q?7jmXUaHYAAJWYI24xMyQ64bXpuz9p50lZecHCQxdL/4io2p3zUcWUdKGOP+J?=
 =?us-ascii?Q?1TiqDxjxXCnJeTywHKIfLW4cWPYdYDQAXuYAMIdElveJoDjHV3tdbjlSKnVn?=
 =?us-ascii?Q?6nwM1uXiOFh5xPfQYWvoxhRe/5mg7ys8/n4JH6UXdeoHxUBLtg+124DIXtus?=
 =?us-ascii?Q?VltNZOvUBki43emMy9iWlDGDyh6RkCHuKyXyCw/jrypn5CYg5y+OvjfRmhDG?=
 =?us-ascii?Q?Pb2JXh0mmtMQ3D458GpFWC0hS9ItD+iE6u4MYriCFZcSoP3jCkQjrkEB5S0f?=
 =?us-ascii?Q?qJU2ufe2COHJ/3jv0INKI0ba0ISlMQYhe2enf3GsVPVmL9QkHNmhuBrLvhup?=
 =?us-ascii?Q?2U7skDTt1wAo1FHKjgQ7skXgaCIOO/r9Bf+uTYCBXNeg/r+hgereFtTNoilQ?=
 =?us-ascii?Q?32tm13ol/owZOpBT8XOo4buwzovF5IsPHzsqgYQOGIpiGTy6OWvrKcRfEAa2?=
 =?us-ascii?Q?8Kev9AwVf6njrVBrw8Xl+Bg4Lyp9CHxh9XJz+Db1ncMFvsTwkcoP2YsP1L5S?=
 =?us-ascii?Q?RTSf8bgughtRTg22JMq5U7iyne6H1paLEFjOcxdriYFBlP9S21qfjJc9tMW5?=
 =?us-ascii?Q?qdHG8+LcJAPyg8eYzPs4HuFKtzs7g1tsrSkbiGmHW6JePku4EOwLCFPgjBZw?=
 =?us-ascii?Q?8GbaONL+6908PEx+l+okpRZsfWQAtlFiO9zdjp71/noOVw6n1opUSWWsCyUA?=
 =?us-ascii?Q?StcsOaLIioYSDxyaIgHDCJfvHUfaE+vdD33JKzFFlWhuigiiREpNhTWVFJdK?=
 =?us-ascii?Q?b6O08kUaCouJ9iU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F1+eoOI2wfHAmzO5jtnq6nF1ITXdeFPX6v9PqvfIk2ztm1r1RtXBdRXftMgr?=
 =?us-ascii?Q?Q26WQcDQK6nMhXNJ0NWqM3XZsZj3GBN7VpWxSN9w2pZvIyQbvJj+u3uk9da+?=
 =?us-ascii?Q?bzPRQqgslth2YqQKX6sOHRMS9ROY18j8Sq9E2Zg6IYvNVJyT2V52jeN14qBt?=
 =?us-ascii?Q?FrLgXISA7SfCL2pSBUTKHJUNNYNqQ3Ty72lZEOzbRyS66/d8mgX3HxZGRtey?=
 =?us-ascii?Q?aGGkHvbeDQmYh8XhnsyyebOxHU0yhuGJQAdkG9C53cQ6hpF8T0x+WczP3/xH?=
 =?us-ascii?Q?7+/qsDf3xJSFl1Bkbp3U6he7+Cr/jpSkvwPk9+IKssYePK6YbfBpO683UNRy?=
 =?us-ascii?Q?Rly4a7RYKEXqJiz9HrKAyOWoaKQEurDvu+x12ve5nznUcBzBTgfvqqUd6Bha?=
 =?us-ascii?Q?1PBbPaOHV1CsDMyJHgTi+fXNFUaGJHXhKMYVc8W3qV5SyTYIr7SB1j7EpNaC?=
 =?us-ascii?Q?9KdMHkp7hZi9XRSg7UK9D0suX21NQ+G2Ignh4rS69577lel2nOkUtN4apYXY?=
 =?us-ascii?Q?PMQauDYSFrVueRNzL+vCkU6axO7lEtTLDkcQgdZUehamluQN7tQAGCqrxj46?=
 =?us-ascii?Q?+uibZOIapeVUoAEwCCStEF25ce0DZT5SYKFS/LXd0Ed6kuz2Y2gSraeFFCfS?=
 =?us-ascii?Q?cvAsWUNIp/D7R1vZGLP2WvAljrzroadCUd1j8DbJSrk1hQgyAfzUD4fXfaCP?=
 =?us-ascii?Q?hf0ieYchyHvdUam8VPgaEDHEeHqQG1OrNgjPtalHNptc2nUaTJy8kT1Ab+b0?=
 =?us-ascii?Q?JOcbw5rgEW+4gKzLdzOw9ZBe4U+HZ3AX4UHK6tRVJm8+EcZjrbIpKxuEiVFn?=
 =?us-ascii?Q?lTizn64KnAQv3T1w3ITN93fxl71CwjcTVAA2bwFm0rolThePS3m0PD9WrgCK?=
 =?us-ascii?Q?A864xxvq7z3Up5PHEyWF9Nkcn83W1DhdJWvfSgCJ838gS3JujDxbzBC3Dug7?=
 =?us-ascii?Q?2Z5WMJW5RjAlyOsTLg97A9//D0G2jO9p7H62mIud6AbyWvf/DKl/2QW+t2AJ?=
 =?us-ascii?Q?nLoJogouOUrnL90qOYKcYENE8O4zVMwK89gTIc+/DZMnah4/lNF+5Ab9WZki?=
 =?us-ascii?Q?cguo5QNCFJAaFlTZgfVzPJSBfvSRZJnibbvJf2yfjlf3YrOxsvQ3GUtxHc2J?=
 =?us-ascii?Q?byFK2OZLV0MSlRVtKUKZUz94w3+HAzKJVSkqb8aw60ZVeVRt5acq3WVfD/5U?=
 =?us-ascii?Q?sGdwa5hg7fyCTqulxJzByB3NNbX2q9nqnM8ZMYqB5e744TsB85lLatRYWD0z?=
 =?us-ascii?Q?CPvmklZTi9ILeg2bGgQWz6YGUZhhwEmWKJ9bwR9KvRxZ1eDvmQ0XEwga1+Xp?=
 =?us-ascii?Q?AsWAZ955ZLl01MnDWNpJoele8clJdLkVluZH/kpP3DJGcb/BPmldCoh16FUt?=
 =?us-ascii?Q?/wspUn7TnEgZKJSZjWU37MzivXsCKS4FvMKNRTiW7P868YH1yteO2+mzoupQ?=
 =?us-ascii?Q?a2zJKyFSYt2/HHNlL9BtVquW2yokafetSnuAUGrLI25/9nUDFdGgcbBwKJCH?=
 =?us-ascii?Q?4X5BrG+Ps3yS7VyfmvEXp08x2SjbqWjK8ni+X+qsZDMFYyStmhGwnVncPDxv?=
 =?us-ascii?Q?8HJGoCE+LG8EPQbkWPGaZKJmJnICokEHk6zzh3Q9y8r/Aut8MjfOHDxz21jQ?=
 =?us-ascii?Q?Dx23B7SeL2QpWXFdy7yyhh4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ec399e-4cd7-43ac-486b-08ddebc26868
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:50:36.7713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Yuz5uchKW+ArJ4DRho5Y+IE2XISnTE/g9/oUzYcAVjUX6D78nENR3gFOlbGbYwGAzhKF5n2/3QomjkudtQWsbjIJSBE0Umz97ltvnvCqhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5568
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

This patch implements read-only test of nand flash devices.

Test reads blocks of NAND flash in normal and raw modes and compares
results. The following statuses can be returned for a block:
 * non-ecc reading failed,
 * ecc reading failed,
 * block is bad,
 * bitflips is above maximum,
 * actual number of biflips above reported one,
 * bitflips reached it maximum value,
 * block is ok.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  16 +++++
 cmd/mtd.c   | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 213 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index cd1a664f34f..21d6db57628 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1533,6 +1533,22 @@ config CMD_MTD_NAND_WRITE_TEST
 
 	  WARNING: This test will destroy any data on blocks being tested.
 
+config CMD_MTD_NAND_READ_TEST
+	bool "mtd nand_read_test"
+	depends on CMD_MTD
+	help
+	  MTD nand_read_test command support.
+
+	  Reads blocks of NAND flash in normal and raw modes and compares results.
+	  The following statuses can be returned for a block:
+	    * non-ecc reading failed,
+	    * ecc reading failed,
+	    * block is bad,
+	    * bitflips is above maximum,
+	    * actual number of biflips above reported one,
+	    * bitflips reached it maximum value,
+	    * block is ok.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 4d69c7b4915..cee3a7e43ef 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -951,6 +951,195 @@ out_put_mtd:
 }
 #endif
 
+#ifdef CONFIG_CMD_MTD_NAND_READ_TEST
+enum nand_read_status {
+	NAND_READ_STATUS_UNKNOWN = 0,
+	NAND_READ_STATUS_NONECC_READ_FAIL,
+	NAND_READ_STATUS_ECC_READ_FAIL,
+	NAND_READ_STATUS_BAD_BLOCK,
+	NAND_READ_STATUS_BITFLIP_ABOVE_MAX,
+	NAND_READ_STATUS_BITFLIP_MISMATCH,
+	NAND_READ_STATUS_BITFLIP_MAX,
+	NAND_READ_STATUS_OK,
+};
+
+static enum nand_read_status nand_read_block_check(struct mtd_info *mtd,
+						   loff_t off, size_t blocksize)
+{
+	struct mtd_oob_ops	ops = {};
+	u_char			*buf;
+	int			i, d, ret, len, pos, cnt, max;
+
+	if (blocksize % mtd->writesize != 0) {
+		printf("\r  block at 0x%llx: bad block size\n", off);
+		return NAND_READ_STATUS_UNKNOWN;
+	}
+
+	buf = malloc_cache_aligned(2 * blocksize);
+	if (buf == NULL) {
+		printf("\r  block at 0x%llx: can't allocate memory\n", off);
+		return NAND_READ_STATUS_UNKNOWN;
+	}
+
+	ops.mode = MTD_OPS_RAW;
+	ops.len = blocksize;
+	ops.datbuf = buf;
+	ops.ooblen = 0;
+	ops.oobbuf = NULL;
+
+	if (mtd->_read_oob)
+		ret = mtd->_read_oob(mtd, off, &ops);
+	else
+		ret = mtd->_read(mtd, off, ops.len, &ops.retlen, ops.datbuf);
+
+	if (ret != 0) {
+		free(buf);
+		printf("\r  block at 0x%llx: non-ecc reading error %d\n",
+		       off, ret);
+		return NAND_READ_STATUS_NONECC_READ_FAIL;
+	}
+
+	ops.mode = MTD_OPS_AUTO_OOB;
+	ops.datbuf = buf + blocksize;
+
+	if (mtd->_read_oob)
+		ret = mtd->_read_oob(mtd, off, &ops);
+	else
+		ret = mtd->_read(mtd, off, ops.len, &ops.retlen, ops.datbuf);
+
+	if (ret == -EBADMSG) {
+		free(buf);
+		printf("\r  block at 0x%llx: bad block\n", off);
+		return NAND_READ_STATUS_BAD_BLOCK;
+	}
+
+	if (ret < 0) {
+		free(buf);
+		printf("\r  block at 0x%llx: ecc reading error %d\n", off, ret);
+		return NAND_READ_STATUS_ECC_READ_FAIL;
+	}
+
+	if (mtd->ecc_strength == 0) {
+		free(buf);
+		return NAND_READ_STATUS_OK;
+	}
+
+	if (ret > mtd->ecc_strength) {
+		free(buf);
+		printf("\r  block at 0x%llx: returned bit-flips value %d "
+		       "is above maximum value %d\n",
+		       off, ret, mtd->ecc_strength);
+		return NAND_READ_STATUS_BITFLIP_ABOVE_MAX;
+	}
+
+	max = 0;
+	pos = 0;
+	len = blocksize;
+	while (len > 0) {
+		cnt = 0;
+		for (i = 0; i < mtd->ecc_step_size; i++) {
+			d = buf[pos + i] ^ buf[blocksize + pos + i];
+			if (d == 0)
+				continue;
+
+			while (d > 0) {
+				d &= (d - 1);
+				cnt++;
+			}
+		}
+		if (cnt > max)
+			max = cnt;
+
+		len -= mtd->ecc_step_size;
+		pos += mtd->ecc_step_size;
+	}
+
+	free(buf);
+
+	if (max > ret) {
+		printf("\r  block at 0x%llx: bitflip mismatch, "
+		       "read %d but actual %d\n", off, ret, max);
+		return NAND_READ_STATUS_BITFLIP_MISMATCH;
+	}
+
+	if (ret == mtd->ecc_strength) {
+		printf("\r  block at 0x%llx: max bitflip reached, "
+		       "block is unreliable\n", off);
+		return NAND_READ_STATUS_BITFLIP_MAX;
+	}
+
+	return NAND_READ_STATUS_OK;
+}
+
+static int do_mtd_nand_read_test(struct cmd_tbl *cmdtp, int flag, int argc,
+				 char *const argv[])
+{
+	struct mtd_info		*mtd;
+	u64			off, blocks;
+	int			stat[NAND_READ_STATUS_OK + 1];
+	enum nand_read_status	ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can be checked\n");
+		goto out_put_mtd;
+	}
+
+	blocks = mtd->size;
+	do_div(blocks, mtd->erasesize);
+
+	printf("ECC strength:     %d\n",   mtd->ecc_strength);
+	printf("ECC step size:    %d\n",   mtd->ecc_step_size);
+	printf("Erase block size: 0x%x\n", mtd->erasesize);
+	printf("Total blocks:     %lld\n", blocks);
+
+	printf("\nworking...\n");
+	memset(stat, 0, sizeof(stat));
+	for (off = 0; off < mtd->size; off += mtd->erasesize) {
+		ret = nand_read_block_check(mtd, off, mtd->erasesize);
+		stat[ret]++;
+
+		switch (ret) {
+		case NAND_READ_STATUS_BAD_BLOCK:
+		case NAND_READ_STATUS_BITFLIP_MAX:
+			if (!mtd_block_isbad(mtd, off))
+				printf("\r  block at 0x%llx: should be marked "
+				       "as BAD\n", off);
+			break;
+
+		case NAND_READ_STATUS_OK:
+			if (mtd_block_isbad(mtd, off))
+				printf("\r  block at 0x%llx: marked as BAD, but "
+				       "probably is GOOD\n", off);
+			break;
+
+		default:
+			break;
+		}
+	}
+
+out_put_mtd:
+	put_mtd_device(mtd);
+	printf("\n");
+	printf("results:\n");
+	printf("  Good blocks:            %d\n", stat[NAND_READ_STATUS_OK]);
+	printf("  Physically bad blocks:  %d\n", stat[NAND_READ_STATUS_BAD_BLOCK]);
+	printf("  Unreliable blocks:      %d\n", stat[NAND_READ_STATUS_BITFLIP_MAX]);
+	printf("  Non checked blocks:     %d\n", stat[NAND_READ_STATUS_UNKNOWN]);
+	printf("  Failed to check blocks: %d\n", stat[NAND_READ_STATUS_NONECC_READ_FAIL] +
+						 stat[NAND_READ_STATUS_ECC_READ_FAIL]);
+	printf("  Suspictious blocks:     %d\n", stat[NAND_READ_STATUS_BITFLIP_ABOVE_MAX] +
+						 stat[NAND_READ_STATUS_BITFLIP_MISMATCH]);
+	return CMD_RET_SUCCESS;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -1039,6 +1228,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
 	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
+	"mtd nand_read_test                    <name>\n"
 #endif
 	"\n"
 	"With:\n"
@@ -1081,6 +1273,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_write_test, 4, 0,
 					     do_nand_write_test,
 					     mtd_name_complete),
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_read_test, 2, 0,
+					     do_mtd_nand_read_test,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.50.1

