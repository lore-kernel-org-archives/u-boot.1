Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44178C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8E6E8419C;
	Tue,  5 Aug 2025 10:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Ai6i9hxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF45841BC; Tue,  5 Aug 2025 10:15:50 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7893B84198
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7bzEXapYiG0Bc9r5N5DFzhNtrrDo1+BQHZ85lhP/ZohfY1y7kbfOiCBvW6A6mMkGBjKMCHguKajWFtbYikZy7eUTeOmu1dmvOXHwnRCPvIcaHmjBD1pKpqWErY4hvZPYSTr6s6udjPZgt88ZHVLZnvt4g1eDqfjLPWcFPXd/HhPxTMSkKMcMyT2diEci9RnIByI+CrW1XJpCZPgnyRSeqlA4A6rLxR19QW6iSQtuPap8XmylzIihVntgp3B3oxC5V6i3xR9IHLO5UrqyFk5p64mtUFRAXotfEwxBvqmgX53dsOsKuatVIIK2trvJkYWzdrGd6m9K8O2NZSXl9zjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCfvaMzx3zIOwEb7GX5TP3CtSv0tV7JaTo+byPksC6c=;
 b=YmGs6UbYWk2HSQCOkaDZJ0KDEhGO3ogrV5xfKx3jwfCyTBwhlc2cK/mXcZrQ9W32EaMgBEMWulB8ge6H78lGCeUKDOX3ZAdZ61DMa4gErWsqIlkpcCyIC9Ev9f6eJ1p8DPPKBK2O7aB58EkcK5w33rkxSJHK9Jy8YhREB4JtMA7f8aICSTl7LnhIwchnEFJKydCOB+aDZTZzdS4FKd2/0nvlb65IQB8cMdT3EThB7jf7j2D3MrpeJH4VIVl8szDWf+cTJSezGnlV1c+eto8NMOWf1GnhRidjLE1YIVmKubhThtK7dqirpckQwO0UPTu9Kc9iWjG4LmjNUmiY64Mqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCfvaMzx3zIOwEb7GX5TP3CtSv0tV7JaTo+byPksC6c=;
 b=Ai6i9hxKmx/Rzw9BXeRRlnKMF38rCO6NW8snSmGalVCFJaFCmZpvmztNwpdr+NRC2Lcm7Dk+zvuL0/DwBw+CfHzjoa6eTo5R/95mFNrR4be75uj4a4BvHKFBKR4IuMiCMBdItBqNVcOR7W9/oJm2My+YHegY1cHO/IW0hFIDBOrDbBKlxHpblr/iSgsGMA4qJBqle1QZYvpYdAT1JQOHnpCXSpJOfAl/GlTetNV+8VI7h9BGjCjs2iC3Lmx6LlHa3hkB2LxJybv42mx0WMeric7XJTqBxADusEyaItXO6OvK32i8N/LQ+hC4S4E9YSVzF1eTWJlCuUgph+6ufLVYZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11069.eurprd08.prod.outlook.com (2603:10a6:d10:139::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:41 +0000
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
Subject: [PATCH v3 17/22] mtd: spinand: add OTP support
Date: Tue,  5 Aug 2025 11:15:06 +0300
Message-ID: <20250805081511.1482964-18-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: 172191a1-5d9b-4f77-e438-08ddd3f84478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GNuFhf5XKr4R8PmwXeUK25tU9do/d5/MalZA+jxBP+pQjTe4P31304/M3su4?=
 =?us-ascii?Q?DQWZtbIGq5uB3oY09PKhoFqF+J/JGLM0TKNUt9lFPlZpx3mSFoEnZYTuN1lj?=
 =?us-ascii?Q?T4Tj5mDBYaph+k4robUOX0JIl5zkbU9tXGpYfEMXzuydcOp78DFUXrxu2uuC?=
 =?us-ascii?Q?dNVrz/MGeNjrIZ2R0oj5TC3Wp5HjtqmA2yirwX1z+zAO6VJQ3G7vUCReSQ0/?=
 =?us-ascii?Q?vGtQ6bUZOK1WpVLaEumqEtFIiWw+ki+N5lLyEIXabZYQICHjEQ3K7YsMwPWG?=
 =?us-ascii?Q?FF1417iZb3DEFrYRLdKoqMtJz6RpTtCBQtk9Y0A7x57sakMci6SKwSy4ADvf?=
 =?us-ascii?Q?rO9L5raH3qKBRKB366nOG8Q3OjqM1lHsQLOeeN9vsrCHCwBpvbEGsriRe30E?=
 =?us-ascii?Q?wzHn3DfIgJjMJSjyvNTWRGSMWwjRHdvTi8vDugg9eJdtuJqcaKecXjNsxUOS?=
 =?us-ascii?Q?pk1XVUyYoe4Bv6n7UvvJoA2k6CtOGOuQThYgpmICCcBNp/NMyS88cpkqlfam?=
 =?us-ascii?Q?5yb+EAuQ/5ZLz6QLbUr2Q0EVZ+AutZGu6oe0TQrTMQ66rc9Ey07dWJX3sKua?=
 =?us-ascii?Q?7ZRJJt0tjPCszK1NkXbzMRafk3Ewn6U/UFLvegnZclZgMBGTe0/7agW8bWPC?=
 =?us-ascii?Q?/79K+lDYNWlcaRjSUTWyCPsD+95FZi/zDwug4Ii6MeDartJePlCyIZ7wAET+?=
 =?us-ascii?Q?sN/KI4PHKxG0FTEJi/lVwcDEuwZ3hPRw9TsaL2uvE4hJxesBon2PIPhCUiyN?=
 =?us-ascii?Q?g8NZAYUEqA0sMyt8a5hF5sM5EoZ1hkcHkQsnuc+yUNqb1JVvH2ikXKEtyGz9?=
 =?us-ascii?Q?GmfnSaAVN0wBluEt8BfYBBe+zPfxiHqn7wYtftdFgdEyMY7ktD8dCUXR5eRv?=
 =?us-ascii?Q?OwIYrOY+d1AcbNbJ/oSESBj0Dun4ROtoa8EXkcMGTaG4M1E9V6XWO0MHYGh+?=
 =?us-ascii?Q?2Fkt5zgdAKtId9rbY6Ee1f6ZmcBSHaTLuAeFdej6iXx6miVkZb+nXeK+DSnS?=
 =?us-ascii?Q?JZQLC/MNZCinsC6kO7GUVcmsUdWUSlPEykMi8xxKWj01cGunXOjGpEqPjg+X?=
 =?us-ascii?Q?9HVeOfuLx64PbLSvVaX+fLvPkt8eoV9U/DIYEVG3lRqcNRmjGbp8THuDCAr4?=
 =?us-ascii?Q?fz1l/q88T8BozQnKhIeUqpMnzLyjNi+gyZvFpaYPM7573BJ/hgqI2vCoeQZf?=
 =?us-ascii?Q?HK/miOabHyWcTEnRa9U53YLSg3RpILLFSKyn7l5QLRNTAbiFYix9oPc8ursp?=
 =?us-ascii?Q?LF/VFl76wfNgb/gv+e5MtxEyJy/e+O/ohCBlSFegeyCiWoAdJe5ev5WFkzLy?=
 =?us-ascii?Q?LeIeY3t3GC8Ow++Uh/MQ9lZ6dvS+lCAbQDqTwypO7ECDSBlxll/px30VJP6y?=
 =?us-ascii?Q?I31SZqX9FfKTmiyXEJN5qConN/QxkpyNUzC1YUPfT7XPKG9eHtKrJgZQsmkX?=
 =?us-ascii?Q?aOwUDfW/Yh/z8XARPpMQJdoYNZXRNezUlqO+owrNrFf0Koif1Djww7AEzh3d?=
 =?us-ascii?Q?OsRCXCuHy+eWHP0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rqNzk7SmwWCO4BdRcAGUJG8n3LleuCFwGFUn8ixYsReOWeydIzhLDDyNuMDQ?=
 =?us-ascii?Q?RwIxJ8nyEhDabqbRgL4Ll/VDvYkQDYVPcKffsfiUcv9+0B3ZVnLplRlL78/6?=
 =?us-ascii?Q?/CzJq0LfPH1LbIu6kNHk+VdrxFQbNxKGzdKjTQT/EY+XnYV8oKsVXY5NWDdD?=
 =?us-ascii?Q?wqykPUD28DBFOCCdloooe51n+RQJCkXHfDyDLFvfa1hzyh3TX+s5VLHdU7x9?=
 =?us-ascii?Q?OwpbVmG4EJT3S5SGeViEo7twjT5YdlsH6NkvvStfKLJBgAhWMEwnARzY75h9?=
 =?us-ascii?Q?U4Eag4d6H5bLDzrmxch85p49J8UkAkJLPewbYw8m1/ec93SK51Ug9fWY9aF8?=
 =?us-ascii?Q?q0p1tvA3hIOUZzbCsHNQuD61YXdvYxC9yo4U5te7CjR9Fwp5gFNXZ8BunNml?=
 =?us-ascii?Q?JYsc62arLGUwtoGTEt3UesYRVjFk9mn6RWTTbEI0XYBWe1PKvCZ9z4//CeKT?=
 =?us-ascii?Q?roUNIjxwTn0+oxXJVm9+NOCw+wziUpxn131qSZsW4uXujiMpyof1ZfPlnyVP?=
 =?us-ascii?Q?5FnH7E6BNflRhQRK4RF1O5Gpz5levrnYW2mOgHYhKodNBgD8HISPIDSqco1O?=
 =?us-ascii?Q?riUncjRutVkg27qYZ3OVjA914sO2x7Q3+kyf9KT8oLgsebukF8UQCK6N463R?=
 =?us-ascii?Q?RE3afquhoeGCSPb+xR9ZM0UQ2794P20XnNUUXPa7nt+T7vW1AQObpB62e4SU?=
 =?us-ascii?Q?6eallTiBzAHQaX4zx7WzBGma9QuzOet5LlFXrCPjSjg7OR9qgtQddRlLKI//?=
 =?us-ascii?Q?oguIkYy6R4w4deIomBgdA4+VdkQWfVkZx3lofdKlgtnVKKscBkYszKIut4L4?=
 =?us-ascii?Q?jlAdk7NgsyviSpBFjDMZ2SrO1tzArbkDUMiM7c9VOjkhL5C14Ne+kPYbyqKC?=
 =?us-ascii?Q?Wm/H+Dprjel0nvzvzQMsvLeqiMSSAkWpKeOGMH456zMUZww6pfZ+sRBQXgk/?=
 =?us-ascii?Q?33I2q38wOy2Sgkkr30mHR85EBXS59UV7p1v84TUJCkCm0lGC84Jr9XXznsVS?=
 =?us-ascii?Q?8ssPNQNzxNMfiF2bi5zmuuS/stzhAOr5FGV+WaaNVsBcvriMjr3GvKBZ8BYU?=
 =?us-ascii?Q?uaBykEuKtTr5q0ul36TheaW0HzSFInYSzMDVbYcyRuq+KdL+lDvzZcJhWYRo?=
 =?us-ascii?Q?lwuOI5GL7q0+Dnpq/6GZBOYyk3x1ngRM7ir6poxBvtdT7cz40knPTjew/26m?=
 =?us-ascii?Q?DIak4LTUUJle3TDixU2Nzd5NtbOvWoroaElYonmqbI/p90t1r2MpZr0HiUHl?=
 =?us-ascii?Q?z9n5B9tcVAzTXirCjhD9XABm31kq6+MfsNOBnN51AyNrMLoXmQjmD66HmhTN?=
 =?us-ascii?Q?u+gD3q6WuPpl6oSul3eX9wrKKfxfa8KlSchVeMpgtVXsG5T0mu2J9dY5ln+9?=
 =?us-ascii?Q?gRUHG0usmjF3Mp2inn41bn55ofyAkjJKuQNeurqjSK/g1VYwdGfR+fhRNL0M?=
 =?us-ascii?Q?RVuZGQs09lB3s8CKNNieAcvRz1w86wYwmGIoN+9JFPPcq/ZJxvp1P7yIK6qT?=
 =?us-ascii?Q?IckF9IO+syo9XDEIdjIENPeEtsBt7a5ST3Q1H3zULyElXt0DIxeSczEBJt/H?=
 =?us-ascii?Q?0daY3P2aTajlJwqDlyfg7yLH9uQvgLNr9usyWWt87KrQldrWsecfj41RKwf2?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 172191a1-5d9b-4f77-e438-08ddd3f84478
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:41.3397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lE/QKe/dkVnlDqUKct3ErsflKK800FHMwOO2M1dG+ytKGoUzxsrioFWozUczAP4B5mXO7LkUrs9AHs26ruFO4J/Ex29WeXEW7ok1gXamyj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11069
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

The code was ported from linux-6.15

based on a linux patch c06b1f753bea40a282f29a9383fcf36b12323108
(mtd: spinand: add OTP support)
created by Martin Kurbanov <mmkurbanov@salutedevices.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/Makefile |   3 +-
 drivers/mtd/nand/spi/core.c   |  54 ++++-
 drivers/mtd/nand/spi/otp.c    | 369 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   | 112 +++++++++++
 4 files changed, 528 insertions(+), 10 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/otp.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index d438747cf37..831760da1c9 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
+spinand-objs := core.o otp.o
+spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
 spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b3418624e3e..f16d3b0335f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -56,7 +56,7 @@ static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 	return 0;
 }
 
-static int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
+int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
 {
 	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg,
 						      spinand->scratchbuf);
@@ -531,10 +531,22 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand,
-			unsigned long initial_delay_us,
-			unsigned long poll_delay_us,
-			u8 *s)
+/**
+ * spinand_wait() - Poll memory device status
+ * @spinand: the spinand device
+ * @initial_delay_us: delay in us before starting to poll
+ * @poll_delay_us: time to sleep between reads in us
+ * @s: the pointer to variable to store the value of REG_STATUS
+ *
+ * This function polls a status register (REG_STATUS) and returns when
+ * the STATUS_READY bit is 0 or when the timeout has expired.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+int spinand_wait(struct spinand_device *spinand,
+		 unsigned long initial_delay_us,
+		 unsigned long poll_delay_us,
+		 u8 *s)
 {
 	unsigned long start, stop;
 	u8 status;
@@ -605,8 +617,16 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
 
-static int spinand_read_page(struct spinand_device *spinand,
-			     const struct nand_page_io_req *req)
+/**
+ * spinand_read_page() - Read a page
+ * @spinand: the spinand device
+ * @req: the I/O request
+ *
+ * Return: 0 or a positive number of bitflips corrected on success.
+ * A negative error code otherwise.
+ */
+int spinand_read_page(struct spinand_device *spinand,
+		      const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
@@ -636,8 +656,16 @@ static int spinand_read_page(struct spinand_device *spinand,
 	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
-static int spinand_write_page(struct spinand_device *spinand,
-			      const struct nand_page_io_req *req)
+/**
+ * spinand_write_page() - Write a page
+ * @spinand: the spinand device
+ * @req: the I/O request
+ *
+ * Return: 0 or a positive number of bitflips corrected on success.
+ * A negative error code otherwise.
+ */
+int spinand_write_page(struct spinand_device *spinand,
+		       const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
@@ -1326,6 +1354,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 		spinand->set_cont_read = table[i].set_cont_read;
+		spinand->fact_otp = &table[i].fact_otp;
+		spinand->user_otp = &table[i].user_otp;
 		spinand->read_retries = table[i].read_retries;
 		spinand->set_read_retry = table[i].set_read_retry;
 
@@ -1492,6 +1522,12 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_block_isreserved = spinand_mtd_block_isreserved;
 	mtd->_erase = spinand_mtd_erase;
 
+	if (spinand_user_otp_size(spinand) || spinand_fact_otp_size(spinand)) {
+		ret = spinand_set_mtd_otp_ops(spinand);
+		if (ret)
+			goto err_cleanup_ecc_engine;
+	}
+
 	ret = mtd_ooblayout_count_freebytes(mtd);
 	if (ret < 0)
 		goto err_cleanup_ecc_engine;
diff --git a/drivers/mtd/nand/spi/otp.c b/drivers/mtd/nand/spi/otp.c
new file mode 100644
index 00000000000..e6ef78d9464
--- /dev/null
+++ b/drivers/mtd/nand/spi/otp.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, SaluteDevices. All Rights Reserved.
+ *
+ * Author: Martin Kurbanov <mmkurbanov@salutedevices.com>
+ */
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/spinand.h>
+#ifdef __UBOOT__
+#include <spi.h>
+#include <dm/device_compat.h>
+#endif
+
+/**
+ * spinand_otp_page_size() - Get SPI-NAND OTP page size
+ * @spinand: the spinand device
+ *
+ * Return: the OTP page size.
+ */
+size_t spinand_otp_page_size(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	return nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
+}
+
+static size_t spinand_otp_size(struct spinand_device *spinand,
+			       const struct spinand_otp_layout *layout)
+{
+	return layout->npages * spinand_otp_page_size(spinand);
+}
+
+/**
+ * spinand_fact_otp_size() - Get SPI-NAND factory OTP area size
+ * @spinand: the spinand device
+ *
+ * Return: the OTP size.
+ */
+size_t spinand_fact_otp_size(struct spinand_device *spinand)
+{
+	return spinand_otp_size(spinand, &spinand->fact_otp->layout);
+}
+
+/**
+ * spinand_user_otp_size() - Get SPI-NAND user OTP area size
+ * @spinand: the spinand device
+ *
+ * Return: the OTP size.
+ */
+size_t spinand_user_otp_size(struct spinand_device *spinand)
+{
+	return spinand_otp_size(spinand, &spinand->user_otp->layout);
+}
+
+static int spinand_otp_check_bounds(struct spinand_device *spinand, loff_t ofs,
+				    size_t len,
+				    const struct spinand_otp_layout *layout)
+{
+	if (ofs < 0 || ofs + len > spinand_otp_size(spinand, layout))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int spinand_user_otp_check_bounds(struct spinand_device *spinand,
+					 loff_t ofs, size_t len)
+{
+	return spinand_otp_check_bounds(spinand, ofs, len,
+					&spinand->user_otp->layout);
+}
+
+static int spinand_otp_rw(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf, bool is_write,
+			  const struct spinand_otp_layout *layout)
+{
+	struct nand_page_io_req req = {};
+	unsigned long long page;
+	size_t copied = 0;
+	size_t otp_pagesize = spinand_otp_page_size(spinand);
+	int ret;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_otp_check_bounds(spinand, ofs, len, layout);
+	if (ret)
+		return ret;
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, CFG_OTP_ENABLE);
+	if (ret)
+		return ret;
+
+	page = ofs;
+	req.dataoffs = do_div(page, otp_pagesize);
+	req.pos.page = page + layout->start_page;
+	req.type = is_write ? NAND_PAGE_WRITE : NAND_PAGE_READ;
+	req.mode = MTD_OPS_RAW;
+	req.databuf.in = buf;
+
+	while (copied < len) {
+		req.datalen = min_t(unsigned int,
+				    otp_pagesize - req.dataoffs,
+				    len - copied);
+
+		if (is_write)
+			ret = spinand_write_page(spinand, &req);
+		else
+			ret = spinand_read_page(spinand, &req);
+
+		if (ret < 0)
+			break;
+
+		req.databuf.in += req.datalen;
+		req.pos.page++;
+		req.dataoffs = 0;
+		copied += req.datalen;
+	}
+
+	*retlen = copied;
+
+	if (spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0)) {
+		dev_warn(spinand->slave->dev,
+			 "Can not disable OTP mode\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+/**
+ * spinand_fact_otp_read() - Read from OTP area
+ * @spinand: the spinand device
+ * @ofs: the offset to read
+ * @len: the number of data bytes to read
+ * @retlen: the pointer to variable to store the number of read bytes
+ * @buf: the buffer to store the read data
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+int spinand_fact_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_otp_rw(spinand, ofs, len, retlen, buf, false,
+			      &spinand->fact_otp->layout);
+}
+
+/**
+ * spinand_user_otp_read() - Read from OTP area
+ * @spinand: the spinand device
+ * @ofs: the offset to read
+ * @len: the number of data bytes to read
+ * @retlen: the pointer to variable to store the number of read bytes
+ * @buf: the buffer to store the read data
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+int spinand_user_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_otp_rw(spinand, ofs, len, retlen, buf, false,
+			      &spinand->user_otp->layout);
+}
+
+/**
+ * spinand_user_otp_write() - Write to OTP area
+ * @spinand:  the spinand device
+ * @ofs: the offset to write to
+ * @len: the number of bytes to write
+ * @retlen: the pointer to variable to store the number of written bytes
+ * @buf: the buffer with data to write
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+int spinand_user_otp_write(struct spinand_device *spinand, loff_t ofs,
+			   size_t len, size_t *retlen, const u8 *buf)
+{
+	return spinand_otp_rw(spinand, ofs, len, retlen, (u8 *)buf, true,
+			      &spinand->user_otp->layout);
+}
+
+static int spinand_mtd_otp_info(struct mtd_info *mtd, size_t len,
+				size_t *retlen, struct otp_info *buf,
+				bool is_fact)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	int ret;
+
+	*retlen = 0;
+
+	mutex_lock(&spinand->lock);
+
+	if (is_fact)
+		ret = spinand->fact_otp->ops->info(spinand, len, buf, retlen);
+	else
+		ret = spinand->user_otp->ops->info(spinand, len, buf, retlen);
+
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+static int spinand_mtd_fact_otp_info(struct mtd_info *mtd, size_t len,
+				     size_t *retlen, struct otp_info *buf)
+{
+	return spinand_mtd_otp_info(mtd, len, retlen, buf, true);
+}
+
+static int spinand_mtd_user_otp_info(struct mtd_info *mtd, size_t len,
+				     size_t *retlen, struct otp_info *buf)
+{
+	return spinand_mtd_otp_info(mtd, len, retlen, buf, false);
+}
+
+static int spinand_mtd_otp_read(struct mtd_info *mtd, loff_t ofs, size_t len,
+				size_t *retlen, u8 *buf, bool is_fact)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	int ret;
+
+	*retlen = 0;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_otp_check_bounds(spinand, ofs, len,
+				       is_fact ? &spinand->fact_otp->layout :
+						 &spinand->user_otp->layout);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+
+	if (is_fact)
+		ret = spinand->fact_otp->ops->read(spinand, ofs, len, retlen,
+						   buf);
+	else
+		ret = spinand->user_otp->ops->read(spinand, ofs, len, retlen,
+						   buf);
+
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+static int spinand_mtd_fact_otp_read(struct mtd_info *mtd, loff_t ofs,
+				     size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_mtd_otp_read(mtd, ofs, len, retlen, buf, true);
+}
+
+static int spinand_mtd_user_otp_read(struct mtd_info *mtd, loff_t ofs,
+				     size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_mtd_otp_read(mtd, ofs, len, retlen, buf, false);
+}
+
+static int spinand_mtd_user_otp_write(struct mtd_info *mtd, loff_t ofs,
+				      size_t len, size_t *retlen, u_char *buf)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_user_otp_ops *ops = spinand->user_otp->ops;
+	int ret;
+
+	*retlen = 0;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_user_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->write(spinand, ofs, len, retlen, buf);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+#ifndef __UBOOT__
+static int spinand_mtd_user_otp_erase(struct mtd_info *mtd, loff_t ofs,
+				      size_t len)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_user_otp_ops *ops = spinand->user_otp->ops;
+	int ret;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_user_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->erase(spinand, ofs, len);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+#endif
+
+static int spinand_mtd_user_otp_lock(struct mtd_info *mtd, loff_t ofs,
+				     size_t len)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_user_otp_ops *ops = spinand->user_otp->ops;
+	int ret;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_user_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->lock(spinand, ofs, len);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+/**
+ * spinand_set_mtd_otp_ops() - Setup OTP methods
+ * @spinand: the spinand device
+ *
+ * Setup OTP methods.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+int spinand_set_mtd_otp_ops(struct spinand_device *spinand)
+{
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
+	const struct spinand_fact_otp_ops *fact_ops = spinand->fact_otp->ops;
+	const struct spinand_user_otp_ops *user_ops = spinand->user_otp->ops;
+
+	if (!user_ops && !fact_ops)
+		return -EINVAL;
+
+	if (user_ops) {
+		if (user_ops->info)
+			mtd->_get_user_prot_info = spinand_mtd_user_otp_info;
+
+		if (user_ops->read)
+			mtd->_read_user_prot_reg = spinand_mtd_user_otp_read;
+
+		if (user_ops->write)
+			mtd->_write_user_prot_reg = spinand_mtd_user_otp_write;
+
+		if (user_ops->lock)
+			mtd->_lock_user_prot_reg = spinand_mtd_user_otp_lock;
+#ifndef __UBOOT__
+		if (user_ops->erase)
+			mtd->_erase_user_prot_reg = spinand_mtd_user_otp_erase;
+#endif
+	}
+
+	if (fact_ops) {
+		if (fact_ops->info)
+			mtd->_get_fact_prot_info = spinand_mtd_fact_otp_info;
+
+		if (fact_ops->read)
+			mtd->_read_fact_prot_reg = spinand_mtd_fact_otp_read;
+	}
+
+	return 0;
+}
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 44c616a4acf..adfb5f3ffbc 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -322,6 +322,68 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
 #define SPINAND_NO_RAW_ACCESS			BIT(4)
 
+/**
+ * struct spinand_otp_layout - structure to describe the SPI NAND OTP area
+ * @npages: number of pages in the OTP
+ * @start_page: start page of the user/factory OTP area.
+ */
+struct spinand_otp_layout {
+	unsigned int npages;
+	unsigned int start_page;
+};
+
+/**
+ * struct spinand_fact_otp_ops - SPI NAND OTP methods for factory area
+ * @info: get the OTP area information
+ * @read: read from the SPI NAND OTP area
+ */
+struct spinand_fact_otp_ops {
+	int (*info)(struct spinand_device *spinand, size_t len,
+		    struct otp_info *buf, size_t *retlen);
+	int (*read)(struct spinand_device *spinand, loff_t from, size_t len,
+		    size_t *retlen, u8 *buf);
+};
+
+/**
+ * struct spinand_user_otp_ops - SPI NAND OTP methods for user area
+ * @info: get the OTP area information
+ * @lock: lock an OTP region
+ * @erase: erase an OTP region
+ * @read: read from the SPI NAND OTP area
+ * @write: write to the SPI NAND OTP area
+ */
+struct spinand_user_otp_ops {
+	int (*info)(struct spinand_device *spinand, size_t len,
+		    struct otp_info *buf, size_t *retlen);
+	int (*lock)(struct spinand_device *spinand, loff_t from, size_t len);
+	int (*erase)(struct spinand_device *spinand, loff_t from, size_t len);
+	int (*read)(struct spinand_device *spinand, loff_t from, size_t len,
+		    size_t *retlen, u8 *buf);
+	int (*write)(struct spinand_device *spinand, loff_t from, size_t len,
+		     size_t *retlen, const u8 *buf);
+};
+
+/**
+ * struct spinand_fact_otp - SPI NAND OTP grouping structure for factory area
+ * @layout: OTP region layout
+ * @ops: OTP access ops
+ */
+struct spinand_fact_otp {
+	const struct spinand_otp_layout layout;
+	const struct spinand_fact_otp_ops *ops;
+};
+
+/**
+ * struct spinand_user_otp - SPI NAND OTP grouping structure for user area
+ * @layout: OTP region layout
+ * @ops: OTP access ops
+ */
+struct spinand_user_otp {
+	const struct spinand_otp_layout layout;
+	const struct spinand_user_otp_ops *ops;
+};
+
+
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
  * @model: model name
@@ -337,6 +399,8 @@ struct spinand_ecc_info {
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
  * @set_cont_read: enable/disable continuous cached reads
+ * @fact_otp: SPI NAND factory OTP info.
+ * @user_otp: SPI NAND user OTP info.
  * @read_retries: the number of read retry modes supported
  * @set_read_retry: enable/disable read retry for data recovery
  *
@@ -359,6 +423,8 @@ struct spinand_info {
 			     unsigned int target);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	struct spinand_fact_otp fact_otp;
+	struct spinand_user_otp user_otp;
 	unsigned int read_retries;
 	int (*set_read_retry)(struct spinand_device *spinand,
 			     unsigned int read_retry);
@@ -390,6 +456,24 @@ struct spinand_info {
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
+#define SPINAND_FACT_OTP_INFO(__npages, __start_page, __ops)		\
+	.fact_otp = {							\
+		.layout = {						\
+			.npages = __npages,				\
+			.start_page = __start_page,			\
+		},							\
+		.ops = __ops,						\
+	}
+
+#define SPINAND_USER_OTP_INFO(__npages, __start_page, __ops)		\
+	.user_otp = {							\
+		.layout = {						\
+			.npages = __npages,				\
+			.start_page = __start_page,			\
+		},							\
+		.ops = __ops,						\
+	}
+
 #define SPINAND_READ_RETRY(__read_retries, __set_read_retry)		\
 	.read_retries = __read_retries,					\
 	.set_read_retry = __set_read_retry
@@ -444,6 +528,8 @@ struct spinand_dirmap {
  *		actually relevant to enable this feature.
  * @set_cont_read: Enable/disable the continuous read feature
  * @priv: manufacturer private data
+ * @fact_otp: SPI NAND factory OTP info.
+ * @user_otp: SPI NAND user OTP info.
  * @read_retries: the number of read retry modes supported
  * @set_read_retry: Enable/disable the read retry feature
  * @last_wait_status: status of the last wait operation that will be used in case
@@ -487,6 +573,9 @@ struct spinand_device {
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
 
+	const struct spinand_fact_otp *fact_otp;
+	const struct spinand_user_otp *user_otp;
+
 	unsigned int read_retries;
 	int (*set_read_retry)(struct spinand_device *spinand,
 			     unsigned int retry_mode);
@@ -571,6 +660,29 @@ int spinand_match_and_init(struct spinand_device *spinand,
 			   enum spinand_readid_method rdid_method);
 
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
+int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
 
+int spinand_wait(struct spinand_device *spinand, unsigned long initial_delay_us,
+		 unsigned long poll_delay_us, u8 *s);
+
+int spinand_read_page(struct spinand_device *spinand,
+		      const struct nand_page_io_req *req);
+
+int spinand_write_page(struct spinand_device *spinand,
+		       const struct nand_page_io_req *req);
+
+size_t spinand_otp_page_size(struct spinand_device *spinand);
+size_t spinand_fact_otp_size(struct spinand_device *spinand);
+size_t spinand_user_otp_size(struct spinand_device *spinand);
+
+int spinand_fact_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf);
+int spinand_user_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf);
+int spinand_user_otp_write(struct spinand_device *spinand, loff_t ofs,
+			   size_t len, size_t *retlen, const u8 *buf);
+
+int spinand_set_mtd_otp_ops(struct spinand_device *spinand);
+
 #endif /* __LINUX_MTD_SPINAND_H */
-- 
2.47.2

