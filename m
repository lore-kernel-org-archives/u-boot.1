Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEBCC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE72841B7;
	Tue,  5 Aug 2025 10:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="kKdBQyNa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 544C7833C7; Tue,  5 Aug 2025 10:15:41 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 217DD8309E
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3J84WKjUO7FxX9mZBHUg5yyX8gMv8R+FEb2CNEKKycV0H66+q8QWcyNiVpyYR02EFgd1tEa81iJv5C6JtkMmrTshXBRyaWtMmZfa10OcCGmMs79+qRnxCaDBNpRbbPQhHi292IVTg85+1tTR+ZyT2HsQM7HRBsepPDh7OKGUauTSGihnrfeeAcZ8SpD2SJSPIZl/6vzIK67tYDSKy1izvbvvdS+XKopX54UilQFNtGRRP9/ZbccdA1LIcfDzwpzOynHVGA2nzxv9nqbe1N2WsRfnCHqaIX292MyUe84AuPFWRDOmvenRad0rWu0lFbEI8CZVfFexuPUcCSP0AW0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClqqYus+ope/DnGpg9dOvW1x0XEITuNo5flucOgjikE=;
 b=Fb7jBfEsGAB7IR1bgRhFPZbe/yoYGdVERgOVr2pQ9NMjRZOK1VVtRPpKXZIVbcn7YpTP4c7uctd8lqDdTZzr72KJmjztm+wfgX2+x+/AjDsAz4dcxJgZ4qYCtUl73ThbEO6H8WeJlHFmGQ1W3FmfAWK9Ru2fwkVe5pAXQTBYjWEWartqbxeUi9aLcodsMzZXMLvCwYsP0q46N9fxyBh/DfBpKmfUdKb8B8rewuc/TWQyVeoBt9Ww5aerS9cNoKRRDs662T9qahBBZb1CUpOtS3qHzeeEdg4L1H8tYpv5PotQJQA2pMttzORm8zMy0gaqJvdz76xWav0/aj9uQyGHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClqqYus+ope/DnGpg9dOvW1x0XEITuNo5flucOgjikE=;
 b=kKdBQyNae5RWFvT2qpu3q5nzXO5oMTqtAvz8lvEVE7TnroaFWc6gKDhJb0Vr4waUUPLFCTbGa+QroJO1aQowINaB9OxonBXptrjHnxGFoToMzU1l2skKs9FpFK63EtjlhTxXato90bXx88gy3uukNz7nKuCct8RKCFbzsy0qlV4LOWpYiPvUpvbmfNcpXDf3BBn3RZfDydr91SY3uK4rSHmBPw0SlxC24wR57pL5rGPK1eqbYnUElCgSnrCSzcbWWzsIAo56/CeTjKp5ypm+qZPmVmt9nxxq+93q1mePfQsph6rTYx+ABDb76IfeagsWsZDGs/JuUEg8YtEsYn0whw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6698.eurprd08.prod.outlook.com (2603:10a6:10:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 10/22] mtd: spinand: sync code with linux-6.10
Date: Tue,  5 Aug 2025 11:14:59 +0300
Message-ID: <20250805081511.1482964-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:15::48) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: c20481ec-e004-405d-360a-08ddd3f83f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uiZW6sZkvoYD4SImqSSyb1fgo5/D/GNe6mGL/AiOPBO/JVSsOLJ+gIdO6otO?=
 =?us-ascii?Q?kRPC81GugFHJCVOqStAMPYMYPYvpLwwD8UjDWApLTpCogy21AgQGRJC/3uZ8?=
 =?us-ascii?Q?zZVIqTjnZwM910KZyaQi9LDm9stqb6tnf0zbBez5acN8Yba09rTsgVwfVyRo?=
 =?us-ascii?Q?7Xa7p9QssKRTSKomSjihK711zFMClRAlqNTIb63xyigXumcg8UeMxFtTqZHt?=
 =?us-ascii?Q?LhyePXcKX2EzNLAWhnc6yJ8712jcDtIZmV7IG6WE8lqeFENS5IeYMrgr1/VI?=
 =?us-ascii?Q?zHQbBLfRFVrENlaXBWlQPZtUXqIbYYdXc++/5QEEUHDdFSsInORE8IxAsheY?=
 =?us-ascii?Q?iTxufyaAG4QnU02v5Z9vJ1zZuc8xeESwZz1KoRBrQPkb6CFAnGIalVG0Qgj8?=
 =?us-ascii?Q?KHN+dpUuiQ9s6Bhwf09ovAyv2jfABmiVvUlbFpK9hwCU98zqFOoXg6cYzV6a?=
 =?us-ascii?Q?23T8Z8hyCTyYlaR8RoSqofP4hPkIew9h6+uOGY1sjFA756CJjV9v4WYjj50h?=
 =?us-ascii?Q?UwoYTdWVlw8lxdUjYR64Ufd1MoJPc7dI3NQh8l3o6LCnyQBWysMQ0Ooq5OWx?=
 =?us-ascii?Q?1hy5H7y3hJstfRmzqtpsVEJ4sO5iygQyEP6psAjCSixYUe8kFaLnjP9+z8Jy?=
 =?us-ascii?Q?uHIX72uQLU2JVghCk9XHRLILN1LZDYUTMLTjcb2PHzpsSHgrYKVajeOUmvFk?=
 =?us-ascii?Q?5xyZ+Nq2htlBjSyaNfi6MPkL4aWjI/Y4KS/rLYMUQjIJfTLMZTbdIiYVtmff?=
 =?us-ascii?Q?mNY+bsaWCQsFwE+To1y+5FMn872rDdyNXV90ID10LEPfgaFV/UBaWl3/uJ0I?=
 =?us-ascii?Q?nnZS7gDz5XzeYN88C4Ler/3hKg0cBOHrbQrIuLeCJAmjPazrUJfrAxmZ2Qui?=
 =?us-ascii?Q?f6pPkXhd4b2pVcyMBCWplKthybzSr9bHY3Vh8c1nusBFFXGq0n6Ffas0/3YK?=
 =?us-ascii?Q?/s4h3ndOODzdjrzMgCMuserq5MAnypVsnBJyASYYA7MF0NxfaSzsdadJUW/7?=
 =?us-ascii?Q?WBtgQQU8t5j78DthE9OFaUSadl3QHHQbDT4D8j+4/iTcvBRk0YEjIdnAd/WT?=
 =?us-ascii?Q?wM93U/GknNAhweOiDIncjXybGBpeugH4T0csetSG3KGKSJrVIvLjMOlUA1dY?=
 =?us-ascii?Q?EkLgeiLwRUoRITgArqdF6cXLwQMx68JilxdM1B4fyA/2s5uAsZTLmSfWfNE0?=
 =?us-ascii?Q?E+xB5Bei478X6cuPR5CAz9wJtfDE1tKxL5XUOCZKAf3nsCjqA+I3bLSbYfwc?=
 =?us-ascii?Q?OpaUgji8BIc3dSZ9h8eo0KrqxSkT9z4BH/YpbSpERGOGryODN144lPIk9Qx2?=
 =?us-ascii?Q?YvUPXneHG4MhPNVjnGdet4VWTpZJsxaT4+npIpFOBCP7MTCvcELSWxrsny+P?=
 =?us-ascii?Q?KYK1QwWrDW7adNZvD/yTqXcn1cBcl/YsC1nl9atUaYmwYglmS/vhZ/pq2lLg?=
 =?us-ascii?Q?hq7hkl4dqkzWUaG23CLCQdgVZ/8EHOrCxbyEXFyLADZ7C+8Ur9/cyPNhZK5t?=
 =?us-ascii?Q?shulbaTNOrPL4aQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M4JCBlCBpTtVeKYb75gfuSFcWn33vXUusZvcSAlK6FGbr4etpOTqBWf3D0Jx?=
 =?us-ascii?Q?nXZnFgwu1wBe7B95GN67J9htBVJehGKrv1cpBndG5vcgNBgmrOuKSmyR43qF?=
 =?us-ascii?Q?MZh8xiyzGdI9uVCkhdXbe3pIljNjAS6/QFLpZxcbuOHLHz8fijwMbWKkFveX?=
 =?us-ascii?Q?K5UOA6MgaQ6X0XK48P73VQZl0YrMSVj9DI5U6fL5MoIKSMcNngKMFzevOp/o?=
 =?us-ascii?Q?K6lxekrGc+rFESq2ntUxWSNLaGe2fLcmpmzviVjrXp9jutk+oeh1uGugH3vb?=
 =?us-ascii?Q?ss433yFtQ44Zf6VGVKmLX+FUsvcBAbwW9py6lw7HewrTngC7YvdU/BmEPQyc?=
 =?us-ascii?Q?OLbMOmgfmNME18l4cgHHLnsPAWrf4xdXcK7G3jj6UGq6HbcvKtbYGKQAzbMU?=
 =?us-ascii?Q?DPV8Ph7z0VQSnu6xIhEwFsQDTxpsnQbg9WNWUklnoJCYnckC9XKOjlVbvOBu?=
 =?us-ascii?Q?t//dVM/z1Mil5NAFNxUmv3Ua+AzYq2AcmBxPJyDSDraOs6V0k0sfG3wHDDZ3?=
 =?us-ascii?Q?INsqY4WGdZA2tk/AHcRMSmhCS79KXZ6cFY7u/dGoXpdat/uqm2tXebKLPTB9?=
 =?us-ascii?Q?bhqWRbBj36Pc5xc0Hr6fh02lHGF34L9+GTVRFHz4HiHiBjMXVakEmpCTy91u?=
 =?us-ascii?Q?moldj/ydX9hgZ4NISAd7VIWTB+h1gLwYMxGhNgLF59kKu/Eq7nRz9hrQ2kuE?=
 =?us-ascii?Q?N05qOC34tZo5LIeiMlJ0R2S+pwNQnvYGNGa9NPgnsHDxpw0182p6nL2djaN1?=
 =?us-ascii?Q?aQ8G+Ku0jIYftY2VYXG9m0ifJvr5gmpH277ED30WcxweHs0MyKpTzNNivvYz?=
 =?us-ascii?Q?pPg83wQhJIK86E/ayUDOD51HLilNxtvoidAucQzQa1VhKAqvaxaDYbiaZlHD?=
 =?us-ascii?Q?10Xvcwb7ckNKu0FPnqalBHacPBH9TjPS0Wei9mMptI4y6SuLs47jFf9l/93v?=
 =?us-ascii?Q?ZdsVWQzePbb+0GC2vaPLLtieoJc5/UcCEIK8S1IlQQIxEIqr9AcIT6GBCnhI?=
 =?us-ascii?Q?IyKIvLAOSFfTBYT4vgYIn1k5JHWHEfDayciOsqFl3rT7sn103iSFDR+Ifoo0?=
 =?us-ascii?Q?/XSPdWWSj10oKgUQwlvC8rAgUeTv9B7xgGsiyqktF2NmaKiMbO3isXsSixrV?=
 =?us-ascii?Q?ZDfADecApRcHAbhEQabtTszuS4FGBAIPD0nppREFo3XVQgjMHE5g+2uBXzSo?=
 =?us-ascii?Q?ng1VIuPIBtz40b74KVXrGggAM4yBPiz2BKcf+CHn4zc0R960wRefJaRqNCV0?=
 =?us-ascii?Q?II+H+3Ce6wDZ3id9VAUQHqiujYZyjdmhsONmYvreg3mN1R4cxtNae3kwz/X7?=
 =?us-ascii?Q?+kNwLLRk8VFmGcTN63gLDlkR65UUAY5r6az7p0i+tKy1hI+ukXHPkdaviyWF?=
 =?us-ascii?Q?T3BhuGumKw/ed2ubqfYWgJ+8IvXrWJadgTDiYUu1XhNd+TNNL7ZP5KmfqOS1?=
 =?us-ascii?Q?Y2WhnxaSXcn6+uODinjKMD7pUa4LsViFDL/tZfI34GoJ5R6sxye4ou85tfkP?=
 =?us-ascii?Q?3VaXkFvOxcD9xfJncEEVf2w6CYub6A8q1r4PdpOeRquUfmNSW0F6z4pKuJ7p?=
 =?us-ascii?Q?RqnAQwE+JBhcixSZs6V5u/mUEKVclf7lLs3CiapCI//bixUHVV+IorSUky6a?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c20481ec-e004-405d-360a-08ddd3f83f40
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:32.5912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uf8Rt0rqozleM+lhggxJ+slFLgB2L9d1Fa7XMZ+TQ17JtUMMJbVFL8g37OkAmn+jC+pO9QSEQNUAIRClYCqkWj4pXP2PQQUn+LQtAdQbkzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6698
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

This makes u-boot spinand driver almost the same as spinand driver
from linux-6.10. The only major difference is support of ECC engines.
The linux driver supports different ECC engines while u-boot driver
uses on-die ecc only.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/Makefile         |   4 +-
 drivers/mtd/nand/spi/alliancememory.c | 155 ++++++++++++++++++++++++++
 drivers/mtd/nand/spi/ato.c            |  84 ++++++++++++++
 drivers/mtd/nand/spi/core.c           | 151 +++++++++++++++++++------
 drivers/mtd/nand/spi/esmt.c           |  16 ++-
 drivers/mtd/nand/spi/foresee.c        |  97 ++++++++++++++++
 drivers/mtd/nand/spi/gigadevice.c     |   6 +-
 drivers/mtd/nand/spi/macronix.c       |  32 +++++-
 drivers/mtd/nand/spi/micron.c         |   2 +-
 drivers/mtd/nand/spi/toshiba.c        |  43 ++++++-
 drivers/mtd/nand/spi/winbond.c        |  55 ++++++++-
 include/linux/mtd/nand.h              |  23 ++++
 include/linux/mtd/spinand.h           |  10 +-
 13 files changed, 619 insertions(+), 59 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c
 create mode 100644 drivers/mtd/nand/spi/foresee.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 65b836b34ca..d438747cf37 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-spinand-objs := core.o esmt.o gigadevice.o macronix.o micron.o paragon.o
-spinand-objs += toshiba.o winbond.o xtx.o
+spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
+spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/alliancememory.c b/drivers/mtd/nand/spi/alliancememory.c
new file mode 100644
index 00000000000..e29e4cc77ec
--- /dev/null
+++ b/drivers/mtd/nand/spi/alliancememory.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Mario Kicherer <dev@kicherer.org>
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_ALLIANCEMEMORY	0x52
+
+#define AM_STATUS_ECC_BITMASK		(3 << 4)
+
+#define AM_STATUS_ECC_NONE_DETECTED	(0 << 4)
+#define AM_STATUS_ECC_CORRECTED		(1 << 4)
+#define AM_STATUS_ECC_ERRORED		(2 << 4)
+#define AM_STATUS_ECC_MAX_CORRECTED	(3 << 4)
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+			   SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int am_get_eccsize(struct mtd_info *mtd)
+{
+	if (mtd->oobsize == 64)
+		return 0x20;
+	else if (mtd->oobsize == 128)
+		return 0x38;
+	else if (mtd->oobsize == 256)
+		return 0x70;
+	else
+		return -EINVAL;
+}
+
+static int am_ooblayout_ecc(struct mtd_info *mtd, int section,
+			    struct mtd_oob_region *region)
+{
+	int ecc_bytes;
+
+	ecc_bytes = am_get_eccsize(mtd);
+	if (ecc_bytes < 0)
+		return ecc_bytes;
+
+	region->offset = mtd->oobsize - ecc_bytes;
+	region->length = ecc_bytes;
+
+	return 0;
+}
+
+static int am_ooblayout_free(struct mtd_info *mtd, int section,
+			     struct mtd_oob_region *region)
+{
+	int ecc_bytes;
+
+	if (section)
+		return -ERANGE;
+
+	ecc_bytes = am_get_eccsize(mtd);
+	if (ecc_bytes < 0)
+		return ecc_bytes;
+
+	/*
+	 * It is unclear how many bytes are used for the bad block marker. We
+	 * reserve the common two bytes here.
+	 *
+	 * The free area in this kind of flash is divided into chunks where the
+	 * first 4 bytes of each chunk are unprotected. The number of chunks
+	 * depends on the specific model. The models with 4096+256 bytes pages
+	 * have 8 chunks, the others 4 chunks.
+	 */
+
+	region->offset = 2;
+	region->length = mtd->oobsize - 2 - ecc_bytes;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops am_ooblayout = {
+	.ecc = am_ooblayout_ecc,
+	.rfree = am_ooblayout_free,
+};
+
+static int am_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	switch (status & AM_STATUS_ECC_BITMASK) {
+	case AM_STATUS_ECC_NONE_DETECTED:
+		return 0;
+
+	case AM_STATUS_ECC_CORRECTED:
+		/*
+		 * use oobsize to determine the flash model and the maximum of
+		 * correctable errors and return maximum - 1 by convention
+		 */
+		if (spinand->base.mtd->oobsize == 64)
+			return 3;
+		else
+			return 7;
+
+	case AM_STATUS_ECC_ERRORED:
+		return -EBADMSG;
+
+	case AM_STATUS_ECC_MAX_CORRECTED:
+		/*
+		 * use oobsize to determine the flash model and the maximum of
+		 * correctable errors
+		 */
+		if (spinand->base.mtd->oobsize == 64)
+			return 4;
+		else
+			return 8;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct spinand_info alliancememory_spinand_table[] = {
+	SPINAND_INFO("AS5F34G04SND",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2f),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&am_ooblayout,
+				     am_ecc_get_status)),
+};
+
+static const struct spinand_manufacturer_ops alliancememory_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer alliancememory_spinand_manufacturer = {
+	.id = SPINAND_MFR_ALLIANCEMEMORY,
+	.name = "AllianceMemory",
+	.chips = alliancememory_spinand_table,
+	.nchips = ARRAY_SIZE(alliancememory_spinand_table),
+	.ops = &alliancememory_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
new file mode 100644
index 00000000000..f0d4436cf45
--- /dev/null
+++ b/drivers/mtd/nand/spi/ato.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Aidan MacDonald
+ *
+ * Author: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_ATO		0x9b
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int ato25d1ga_ooblayout_ecc(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 8;
+	region->length = 8;
+	return 0;
+}
+
+static int ato25d1ga_ooblayout_free(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	if (section) {
+		region->offset = (16 * section);
+		region->length = 8;
+	} else {
+		/* first byte of section 0 is reserved for the BBM */
+		region->offset = 1;
+		region->length = 7;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops ato25d1ga_ooblayout = {
+	.ecc = ato25d1ga_ooblayout_ecc,
+	.rfree = ato25d1ga_ooblayout_free,
+};
+
+static const struct spinand_info ato_spinand_table[] = {
+	SPINAND_INFO("ATO25D1GA",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x12),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&ato25d1ga_ooblayout, NULL)),
+};
+
+static const struct spinand_manufacturer_ops ato_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer ato_spinand_manufacturer = {
+	.id = SPINAND_MFR_ATO,
+	.name = "ATO",
+	.chips = ato_spinand_table,
+	.nchips = ARRAY_SIZE(ato_spinand_table),
+	.ops = &ato_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a6353b37e7f..b4795927277 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -239,7 +239,7 @@ static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
 		 * fixed, so let's return the maximum possible value so that
 		 * wear-leveling layers move the data immediately.
 		 */
-		return nand->eccreq.strength;
+		return nanddev_get_ecc_conf(nand)->strength;
 
 	case STATUS_ECC_UNCOR_ERROR:
 		return -EBADMSG;
@@ -275,6 +275,66 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
 	.rfree = spinand_noecc_ooblayout_free,
 };
 
+static int spinand_ondie_ecc_init_ctx(struct nand_device *nand)
+{
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+
+	if (spinand->eccinfo.ooblayout)
+		mtd_set_ooblayout(mtd, spinand->eccinfo.ooblayout);
+	else
+		mtd_set_ooblayout(mtd, &spinand_noecc_ooblayout);
+
+	return 0;
+}
+
+static void spinand_ondie_ecc_cleanup_ctx(struct nand_device *nand)
+{
+}
+
+static int spinand_ondie_ecc_prepare_io_req(struct nand_device *nand,
+					    struct nand_page_io_req *req)
+{
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	bool enable = (req->mode != MTD_OPS_RAW);
+
+	memset(spinand->oobbuf, 0xff, nanddev_per_page_oobsize(nand));
+
+	/* Only enable or disable the engine */
+	return spinand_ecc_enable(spinand, enable);
+}
+
+static int spinand_ondie_ecc_finish_io_req(struct nand_device *nand,
+					   struct nand_page_io_req *req)
+{
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
+	int ret;
+
+	if (req->mode == MTD_OPS_RAW)
+		return 0;
+
+	/* Nothing to do when finishing a page write */
+	if (req->type == NAND_PAGE_WRITE)
+		return 0;
+
+	/* Finish a page read: check the status, report errors/bitflips */
+	ret = spinand_check_ecc_status(spinand, spinand->last_wait_status);
+	if (ret == -EBADMSG)
+		mtd->ecc_stats.failed++;
+	else if (ret > 0)
+		mtd->ecc_stats.corrected += ret;
+
+	return ret;
+}
+
+static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
+{
+	struct spinand_device *spinand = nand_to_spinand(nand);
+
+	spinand->last_wait_status = status;
+}
+
 static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
@@ -317,7 +377,10 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		}
 	}
 
-	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
+	if (req->mode == MTD_OPS_RAW)
+		rdesc = spinand->dirmaps[req->pos.plane].rdesc;
+	else
+		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
@@ -366,9 +429,12 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	 * must fill the page cache entirely even if we only want to program
 	 * the data portion of the page, otherwise we might corrupt the BBM or
 	 * user data previously programmed in OOB area.
+	 *
+	 * Only reset the data buffer manually, the OOB buffer is prepared by
+	 * ECC engines ->prepare_io_req() callback.
 	 */
 	nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
-	memset(spinand->databuf, 0xff, nbytes);
+	memset(spinand->databuf, 0xff, nanddev_page_size(nand));
 
 	if (req->datalen)
 		memcpy(spinand->databuf + req->dataoffs, req->databuf.out,
@@ -385,7 +451,10 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 			       req->ooblen);
 	}
 
-	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
+	if (req->mode == MTD_OPS_RAW)
+		wdesc = spinand->dirmaps[req->pos.plane].wdesc;
+	else
+		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
@@ -498,12 +567,16 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 }
 
 static int spinand_read_page(struct spinand_device *spinand,
-			     const struct nand_page_io_req *req,
-			     bool ecc_enabled)
+			     const struct nand_page_io_req *req)
 {
+	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
 	int ret;
 
+	ret = spinand_ondie_ecc_prepare_io_req(nand, (struct nand_page_io_req *)req);
+	if (ret)
+		return ret;
+
 	ret = spinand_load_page_op(spinand, req);
 	if (ret)
 		return ret;
@@ -515,22 +588,26 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret < 0)
 		return ret;
 
+	spinand_ondie_ecc_save_status(nand, status);
+
 	ret = spinand_read_from_cache_op(spinand, req);
 	if (ret)
 		return ret;
 
-	if (!ecc_enabled)
-		return 0;
-
-	return spinand_check_ecc_status(spinand, status);
+	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
 static int spinand_write_page(struct spinand_device *spinand,
 			      const struct nand_page_io_req *req)
 {
+	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
 	int ret;
 
+	ret = spinand_ondie_ecc_prepare_io_req(nand, (struct nand_page_io_req *)req);
+	if (ret)
+		return ret;
+
 	ret = spinand_write_enable_op(spinand);
 	if (ret)
 		return ret;
@@ -550,7 +627,7 @@ static int spinand_write_page(struct spinand_device *spinand,
 	if (!ret && (status & STATUS_PROG_FAILED))
 		return -EIO;
 
-	return ret;
+	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
 static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
@@ -580,21 +657,14 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, !disable_ecc);
-		if (ret)
-			break;
-
-		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
+		ret = spinand_read_page(spinand, &iter.req);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
-		if (ret == -EBADMSG) {
+		if (ret == -EBADMSG)
 			ecc_failed = true;
-			mtd->ecc_stats.failed++;
-		} else {
-			mtd->ecc_stats.corrected += ret;
+		else
 			max_bitflips = max_t(unsigned int, max_bitflips, ret);
-		}
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
@@ -635,10 +705,6 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, !disable_ecc);
-		if (ret)
-			break;
-
 		ret = spinand_write_page(spinand, &iter.req);
 		if (ret)
 			break;
@@ -667,7 +733,7 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 	};
 
 	spinand_select_target(spinand, pos->target);
-	spinand_read_page(spinand, &req, false);
+	spinand_read_page(spinand, &req);
 	if (marker[0] != 0xff || marker[1] != 0xff)
 		return true;
 
@@ -835,6 +901,9 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].rdesc = desc;
 
+	spinand->dirmaps[plane].wdesc_ecc = spinand->dirmaps[plane].wdesc;
+	spinand->dirmaps[plane].rdesc_ecc = spinand->dirmaps[plane].rdesc;
+
 	return 0;
 }
 
@@ -866,13 +935,16 @@ static const struct nand_ops spinand_ops = {
 };
 
 static const struct spinand_manufacturer *spinand_manufacturers[] = {
+	&alliancememory_spinand_manufacturer,
+	&ato_spinand_manufacturer,
+	&esmt_c8_spinand_manufacturer,
+	&foresee_spinand_manufacturer,
 	&gigadevice_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&paragon_spinand_manufacturer,
 	&toshiba_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
-	&esmt_c8_spinand_manufacturer,
 	&xtx_spinand_manufacturer,
 };
 
@@ -900,7 +972,7 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
 		spinand->manufacturer = manufacturer;
 		return 0;
 	}
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static int spinand_id_detect(struct spinand_device *spinand)
@@ -1034,7 +1106,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 			return ret;
 
 		nand->memorg = table[i].memorg;
-		nand->eccreq = table[i].eccreq;
+		nanddev_set_ecc_requirements(nand, &table[i].eccreq);
 		spinand->eccinfo = table[i].eccinfo;
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
@@ -1186,6 +1258,11 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_manuf_cleanup;
 
+	spinand_ecc_enable(spinand, false);
+	ret = spinand_ondie_ecc_init_ctx(nand);
+	if (ret)
+		goto err_cleanup_nanddev;
+
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
@@ -1193,27 +1270,29 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_block_isreserved = spinand_mtd_block_isreserved;
 	mtd->_erase = spinand_mtd_erase;
 
-	if (spinand->eccinfo.ooblayout)
-		mtd_set_ooblayout(mtd, spinand->eccinfo.ooblayout);
-	else
-		mtd_set_ooblayout(mtd, &spinand_noecc_ooblayout);
-
 	ret = mtd_ooblayout_count_freebytes(mtd);
 	if (ret < 0)
-		goto err_cleanup_nanddev;
+		goto err_cleanup_ecc_engine;
 
 	mtd->oobavail = ret;
 
+	/* Propagate ECC information to mtd_info */
+	mtd->ecc_strength = nanddev_get_ecc_conf(nand)->strength;
+	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
+
 	ret = spinand_create_dirmaps(spinand);
 	if (ret) {
 		dev_err(dev,
 			"Failed to create direct mappings for read/write operations (err = %d)\n",
 			ret);
-		goto err_cleanup_nanddev;
+		goto err_cleanup_ecc_engine;
 	}
 
 	return 0;
 
+err_cleanup_ecc_engine:
+	spinand_ondie_ecc_cleanup_ctx(nand);
+
 err_cleanup_nanddev:
 	nanddev_cleanup(nand);
 
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 7e07b26827a..23be098b885 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -106,7 +106,8 @@ static const struct mtd_ooblayout_ops f50l1g41lb_ooblayout = {
 
 static const struct spinand_info esmt_c8_spinand_table[] = {
 	SPINAND_INFO("F50L1G41LB",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01, 0x7f,
+				0x7f, 0x7f),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -115,7 +116,8 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
 	SPINAND_INFO("F50D1G41LB",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11, 0x7f,
+				0x7f, 0x7f),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -123,6 +125,16 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+	SPINAND_INFO("F50D2G41KA",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51, 0x7f,
+				0x7f, 0x7f),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
 };
 
 static const struct spinand_manufacturer_ops esmt_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
new file mode 100644
index 00000000000..6229c959b2c
--- /dev/null
+++ b/drivers/mtd/nand/spi/foresee.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023, SberDevices. All Rights Reserved.
+ *
+ * Author: Martin Kurbanov <mmkurbanov@salutedevices.com>
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_FORESEE		0xCD
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int f35sqa002g_ooblayout_ecc(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int f35sqa002g_ooblayout_free(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* Reserve 2 bytes for the BBM. */
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops f35sqa002g_ooblayout = {
+	.ecc = f35sqa002g_ooblayout_ecc,
+	.rfree = f35sqa002g_ooblayout_free,
+};
+
+static int f35sqa002g_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		return nanddev_get_ecc_conf(nand)->strength;
+
+	default:
+		break;
+	}
+
+	/* More than 1-bit error was detected in one or more sectors and
+	 * cannot be corrected.
+	 */
+	return -EBADMSG;
+}
+
+static const struct spinand_info foresee_spinand_table[] = {
+	SPINAND_INFO("F35SQA002G",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x72, 0x72),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
+				     f35sqa002g_ecc_get_status)),
+};
+
+static const struct spinand_manufacturer_ops foresee_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer foresee_spinand_manufacturer = {
+	.id = SPINAND_MFR_FORESEE,
+	.name = "FORESEE",
+	.chips = foresee_spinand_table,
+	.nchips = ARRAY_SIZE(foresee_spinand_table),
+	.ops = &foresee_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index fe8c76acac6..f3608a13d8e 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -190,7 +190,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
 {
 	u8 status2;
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
-						      &status2);
+						      spinand->scratchbuf);
 	int ret;
 
 	switch (status & STATUS_ECC_MASK) {
@@ -211,6 +211,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
 		 * report the maximum of 4 in this case
 		 */
 		/* bits sorted this way (3...0): ECCS1,ECCS0,ECCSE1,ECCSE0 */
+		status2 = *(spinand->scratchbuf);
 		return ((status & STATUS_ECC_MASK) >> 2) |
 			((status2 & STATUS_ECC_MASK) >> 4);
 
@@ -232,7 +233,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
 {
 	u8 status2;
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
-						      &status2);
+						      spinand->scratchbuf);
 	int ret;
 
 	switch (status & STATUS_ECC_MASK) {
@@ -252,6 +253,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
 		 * 1 ... 4 bits are flipped (and corrected)
 		 */
 		/* bits sorted this way (1...0): ECCSE1, ECCSE0 */
+		status2 = *(spinand->scratchbuf);
 		return ((status2 & STATUS_ECC_MASK) >> 4) + 1;
 
 	case STATUS_ECC_UNCOR_ERROR:
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 86bffc2800b..c2a7aa2da96 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -23,7 +23,7 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
-		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
@@ -86,11 +86,13 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 		 * in order to avoid forcing the wear-leveling layer to move
 		 * data around if it's not necessary.
 		 */
-		if (mx35lf1ge4ab_get_eccsr(spinand, &eccsr))
-			return nand->eccreq.strength;
+		if (mx35lf1ge4ab_get_eccsr(spinand, spinand->scratchbuf))
+			return nanddev_get_ecc_conf(nand)->strength;
 
-		if (WARN_ON(eccsr > nand->eccreq.strength || !eccsr))
-			return nand->eccreq.strength;
+		eccsr = *spinand->scratchbuf;
+		if (WARN_ON(eccsr > nanddev_get_ecc_conf(nand)->strength ||
+			    !eccsr))
+			return nanddev_get_ecc_conf(nand)->strength;
 
 		return eccsr;
 
@@ -300,6 +302,26 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 
+	SPINAND_INFO("MX31LF2GE4BC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2e),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX3UF2GE4BC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops macronix_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index b538213ed8e..01c177facfb 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -14,7 +14,7 @@
 
 #define SPINAND_MFR_MICRON		0x2c
 
-#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
+#define MICRON_STATUS_ECC_MASK		GENMASK(6, 4)
 #define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
 #define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index b9908e79271..bf7da57de13 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -76,7 +76,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -93,12 +93,12 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		 * data around if it's not necessary.
 		 */
 		if (spi_mem_exec_op(spinand->slave, &op))
-			return nand->eccreq.strength;
+			return nanddev_get_ecc_conf(nand)->strength;
 
-		mbf >>= 4;
+		mbf = *(spinand->scratchbuf) >> 4;
 
-		if (WARN_ON(mbf > nand->eccreq.strength || !mbf))
-			return nand->eccreq.strength;
+		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
+			return nanddev_get_ecc_conf(nand)->strength;
 
 		return mbf;
 
@@ -269,6 +269,39 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 1Gb (1st generation) */
+	SPINAND_INFO("TC58NYG0S3HBAI4",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xA1),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 4Gb (1st generation) */
+	SPINAND_INFO("TH58NYG2S3HBAI4",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xAC),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 2, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 8Gb (1st generation) */
+	SPINAND_INFO("TH58NYG3S0HBAI6",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xA3),
+		     NAND_MEMORG(1, 4096, 256, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops toshiba_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 16abf89dbbf..fc3e3855d41 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -114,7 +114,7 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -131,12 +131,12 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 		 * data around if it's not necessary.
 		 */
 		if (spi_mem_exec_op(spinand->slave, &op))
-			return nand->eccreq.strength;
+			return nanddev_get_ecc_conf(nand)->strength;
 
-		mbf >>= 4;
+		mbf = *(spinand->scratchbuf) >> 4;
 
-		if (WARN_ON(mbf > nand->eccreq.strength || !mbf))
-			return nand->eccreq.strength;
+		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
+			return nanddev_get_ecc_conf(nand)->strength;
 
 		return mbf;
 
@@ -176,6 +176,51 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N01JW",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbc, 0x21),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N02JWZEIF",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbf, 0x22),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 2, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N512GW",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x20),
+		     NAND_MEMORG(1, 2048, 64, 64, 512, 10, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N02KWZEIR",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x22),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N01GWZEIG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x21),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
 	SPINAND_INFO("W25N04KV",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
 		     NAND_MEMORG(1, 2048, 128, 64, 4096, 40, 2, 1, 1),
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 0afdaed5715..910ef56ed0c 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -370,6 +370,29 @@ nanddev_get_memorg(struct nand_device *nand)
 	return &nand->memorg;
 }
 
+/**
+ * nanddev_get_ecc_conf() - Extract the ECC configuration from a NAND device
+ * @nand: NAND device
+ */
+static inline const struct nand_ecc_req *
+nanddev_get_ecc_conf(struct nand_device *nand)
+{
+	return &nand->eccreq;
+}
+
+/**
+ * nanddev_set_ecc_requirements() - Assign the ECC requirements of a NAND
+ *                                  device
+ * @nand: NAND device
+ * @reqs: Requirements
+ */
+static inline void
+nanddev_set_ecc_requirements(struct nand_device *nand,
+			     const struct nand_ecc_req *reqs)
+{
+	nand->eccreq = *reqs;
+}
+
 int nanddev_init(struct nand_device *nand, const struct nand_ops *ops,
 		 struct module *owner);
 void nanddev_cleanup(struct nand_device *nand);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index ba6c2ba149d..011861dd059 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -266,13 +266,16 @@ struct spinand_manufacturer {
 };
 
 /* SPI NAND manufacturers */
+extern const struct spinand_manufacturer alliancememory_spinand_manufacturer;
+extern const struct spinand_manufacturer ato_spinand_manufacturer;
+extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
+extern const struct spinand_manufacturer foresee_spinand_manufacturer;
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
 extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
-extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
 extern const struct spinand_manufacturer xtx_spinand_manufacturer;
 
 /**
@@ -388,6 +391,8 @@ struct spinand_info {
 struct spinand_dirmap {
 	struct spi_mem_dirmap_desc *wdesc;
 	struct spi_mem_dirmap_desc *rdesc;
+	struct spi_mem_dirmap_desc *wdesc_ecc;
+	struct spi_mem_dirmap_desc *rdesc_ecc;
 };
 
 /**
@@ -415,6 +420,8 @@ struct spinand_dirmap {
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
  * @priv: manufacturer private data
+ * @last_wait_status: status of the last wait operation that will be used in case
+ *		      ->get_status() is not populated by the spinand device.
  */
 struct spinand_device {
 	struct nand_device base;
@@ -447,6 +454,7 @@ struct spinand_device {
 	u8 *scratchbuf;
 	const struct spinand_manufacturer *manufacturer;
 	void *priv;
+	u8 last_wait_status;
 };
 
 /**
-- 
2.47.2

