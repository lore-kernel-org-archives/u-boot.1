Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035A7CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5189E84040;
	Fri, 10 Oct 2025 13:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="eifAvldh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B72B83837; Fri, 10 Oct 2025 13:58:40 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4591483F4B
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XI67uXoAlkR+w3roRiwNM8x25zYE0APOMgAgFeDS43QMbHA5yzeMZadZijBXIJ2zj0LkAAgceCcgJQE9RSszLQXINjB6k4S1eMgG1fpicHstKYp3LPATaNDp7qOfkYOOzQ/wAXov7AMk00T6nG1N0bmJP161K52bcw5n4ZYdf/CsTK2cR8BzR2gnRR8Jy7o05E7B0yLQqVImtE1/8r71tYO4DHbI65rEznKnZqj1z+qbQbO5D00MP5WCKTpuWIL2k9+7Rjhg3fQPhLjOhzhazQV0/1fCdfLfBDt0IJnPJ2BeSUeFKniH9e/jg00MssKtKq5P114uFdVZalHyo+r7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggsuynechNzz0LNDU0Vi1nEMIJvEAcF2pgkI8sh5qvQ=;
 b=Rj/PgB+kIPWsecF/R+TUq82P1FEp8BwU6B9N7S2c4Dd+4iix+DPDXZOIZ7NN/qL22xE1xXQQXHRmOcWlPioDx+8U70OwT+WClYQloH78cjNSSQuag6V3PGw1eH99OwIdycdI7ESlXYuxIFnqqFK7oBjtePN3jRhCZKkIFSEjAlbCB/7uCNR4EpmB8c/eoW8p8p0Dl0uQIcHdHT25ibhREGAke5Bd4MdCq3I9ckmZImNsTqvDcMEbaWasZRiPQpY7+lyegLKqQfrXxTi1XK/5mqVaMRXdNBVA3okP9xs/NPR//7jjGlfo6ST+2cpYZ9Fop6MmoRc8UpsbnpHcM2whXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggsuynechNzz0LNDU0Vi1nEMIJvEAcF2pgkI8sh5qvQ=;
 b=eifAvldh0MU00dc6yHzp8XTPUqGrUYoOs0waEr1EJpKkGSLTV6qysvdSNsBPFThR81+vtv1Wtkmc/BIJoxdHvTo3U3vBVs3X9Izd69N1M2H0Hjk/vkbVF/DUrWAve2j/cZ4OCaq2E3XBLDPGcEyTy0x50h5gLN9SJvh0+lbUJbZNaZeBo2wXoHGP7/Wl4dFo6IZUvoNHzSbDaf/UVsljlK3n7kfpN4rjnw8uSnDLQCQpx6UszhOGPenbpkhCo+HJJD6XlulDlh6YVPnVfFiJJyh0LtVeAiNNQs/kdcQcFKEe81iC2kL/7PHXaJirdNd15yReADxdJCQoZh8xDy0vXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8464.eurprd08.prod.outlook.com (2603:10a6:150:b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v7 01/24] spi: spi-mem: Extend SPI MEM ops to match
 Linux 6.16
Date: Fri, 10 Oct 2025 14:58:02 +0300
Message-ID: <20251010115825.1531775-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 473dd873-ff9f-4c1f-6f00-08de07f456eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4NA+0pWUAx0RofZzugva+5siyUS0i8zZcGIiwc6/uxd/M8jyVQLv2QF5tkZM?=
 =?us-ascii?Q?zUHFSTfXPKEPEDKJVfjeKHiPJwIZowq2TYtwd8vFaKULIxBsF6oJ65CKi+wc?=
 =?us-ascii?Q?6wYbDKn/jZe50VKqnt/t/3Gl/L67aD9WLLNf7OCoNVLOQtNfgxdFFmxfhYq8?=
 =?us-ascii?Q?M3eWv9I0RRmdumypR76QG6X3WXVbfIsKUi7DjxI3QStKS2ZZx7GiIkuBL75b?=
 =?us-ascii?Q?tC3gXIVTrY1lP5smL/o7T7cAIgfr0BCuk7rwewN+cJUfA6V/MJTvenxA+o4e?=
 =?us-ascii?Q?IKV9onAJVz7foJl0PlcaYi970O57r53K5TF5UA43h9E/5hlW3/3F11a4XAhJ?=
 =?us-ascii?Q?XUBC0xGmPQfyd5d9RzevBQUBuvrZTiF69/5IrXNo+l3pkIQ/OG64iRaujc+J?=
 =?us-ascii?Q?NGddlhiGvZYNddjABIGOPp17T25iq61N4vCAreoaZYkgdnmV3dXLWzslYGaa?=
 =?us-ascii?Q?dpJsEFWdRBhvsbrDA/RCL/1mUoyXTNG4PQqvvvNbXbtwOJv7uCR1Kvi88X7Z?=
 =?us-ascii?Q?E471ie4BDgnnTD8hs8Cht1FsBGyXvlw3nHw5/MqHGfpv/aOR3JHlwT40V75w?=
 =?us-ascii?Q?0gQhHSU+XZ6G2HiYAtTp5BRS1vEDbTRBZCQN7HDNGHEhVy6b4z4pIIB8hgEO?=
 =?us-ascii?Q?XlKxulG0idqUXoffj5WzQnTa269mZ7BqDw7FGDh1iHrpiAnkK3VauS+rsEmG?=
 =?us-ascii?Q?LEKfqmkleWDsj0w8SL3wCA2KmFGdyafNfTxS8fB+y4R4sVPxo0Ms5PwO5RGC?=
 =?us-ascii?Q?8wvFd9ABl7d8r1Ad9RwWgFCKO0v3K5A3xYsYlvsHtj2eU5doT+g6wgtb7TUE?=
 =?us-ascii?Q?UBDtCL0GPLbuRJ/LGUuow1IcytSnxh0u1/LQt9gfeztG9fFaUVOzRTZiQXnK?=
 =?us-ascii?Q?21orHW7WKuNs/9wrk355vA/zpZi1GG7lJYP2cAmnjqf++uXsqmwh4eGGbkkQ?=
 =?us-ascii?Q?fEkrlu4N0oFgfUQV6/uz33gNeTLqCARq6hZMd0X9XBTNWlaI+4AruFMR4OGC?=
 =?us-ascii?Q?P/CQ+o6CxxmRf2B1L2d/ISNaGDs8xyu0qutnrEa6jaVxI1HomTZbMXwK0EIm?=
 =?us-ascii?Q?xK/wlkAmvrqCaKaJaWrFPeDdKfzt5n3nwXXnBp14IwaIPDWzieqivhM/HwxE?=
 =?us-ascii?Q?IhBVHgvA/yttjIeHSCYsb+YTYV/9vNuLi9BZuSA5gGHP8cPRB7dBtoNaGyCg?=
 =?us-ascii?Q?Y7CG8A9li6kb80xUZUOwoXtbYlBhTgrWgt7kcBpE34XvtH2CPpENYL3HgapC?=
 =?us-ascii?Q?G3DcoPRUXBMya97ceq3qFSbhG0ozBqiTaXJNMfRwPy/MF5IXt3MQzh5MZkUF?=
 =?us-ascii?Q?Yfy15cfHWRvyvQZrrTYSLsUSdXhqrlHZ9fPjHbW8zOYx1nNIo+OxqEiTFpRy?=
 =?us-ascii?Q?BcHaxymgniEksuYPCZ6wfnYR14Y0wwCcD7PqplcvlKt03twPvmQsmC9xVGXR?=
 =?us-ascii?Q?v2btPNdJKg1lGheEFJC+SgEtd4b0CGRcFWJgWKMsusd64QpRgAzapIT9mtjl?=
 =?us-ascii?Q?jvWhiGtqQVwypU6IN/4clYs6I9eZtutwZtBlA5WrtN2Cx2WBqenxBixRaw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?muZe7TOLSjV3KHnztF5xDp8cGIXaMXr/YQL2M21sU1XoniO8r3vtOoel2lAe?=
 =?us-ascii?Q?4ONeSFg+X/uQw9JoLvAS8Jco5EYY0acMzfR13QhclFrEH+1OKDaRSLw2PYLP?=
 =?us-ascii?Q?wjX3YdCwosPMjwj9pWR10N1rTCocXG37DF+CfEsbPp3LWTY1XK/WY4p0r96e?=
 =?us-ascii?Q?VWmsma6UyzGnYLx9w+WsY1vnBqrt4HPpqeZcUCmTSMVJNV9A2uDeunHAcfTt?=
 =?us-ascii?Q?3lrSwSGPWyfC2fZ8ytcJ37BoQ1+2INuj07c76P9pjhy7yJHxo3aNV7fFCzsT?=
 =?us-ascii?Q?UlxmweQPuun3wdKTM8nq99hhQWDvP8ZVoOpHBhLqWHwlGcdhOu1C9DiswxYd?=
 =?us-ascii?Q?iKM7vQGiM+/QsXOgPtS7v2M/Ehv3C75MJ0iBogUB2rl2kUQA0xaqHL/TvBBe?=
 =?us-ascii?Q?F96Rky8yoeYY79b4W6VIid9Tf7dVi5XG37lzKdmJeToZAbd18p6UallucoL2?=
 =?us-ascii?Q?x3JTOSaViLRLS8YcL+egFPCDJEq9mF0+PoXxTLgWjrSi+dQ+RfqSYcucyLaN?=
 =?us-ascii?Q?87Ij1SGULw/dWHjxm95sFGDf9HResyD2PKjuwoPnLdN9K9yC5zNQsbDDaVMn?=
 =?us-ascii?Q?mKczjVZMv/HCG+Vk7M5e/pE2+wRoH2zhoRxwl2YHZeidLp+8tTCZM6VlMFNy?=
 =?us-ascii?Q?1kzQ5V2IfrZkzgltZ0dF5nDGw7CVaZ4sghMVcCxWzLKcG6lpRJl8exzvNRil?=
 =?us-ascii?Q?u1e1rpV7p9y2gJ9M1NnZmyYJS0dem6b4taExINl9LcajKl9viy5bapXQ7+Yu?=
 =?us-ascii?Q?JIScHpDixjLhNLm+soQrnZqn4gUQtBpj0AhV2FMDK7UHK8DA/XYhT4VbxtTO?=
 =?us-ascii?Q?QK94KcBNHwVES8rkBRk+mjNUtCOU9li0y3F5Zbc9b3hKfG1jSgN58IUHxt36?=
 =?us-ascii?Q?5RVYqRmJMqrfff4z7IQ5W2H2FueUfvW9BBm0zAd3NXkqeDU500dV2KfWppXU?=
 =?us-ascii?Q?vkO36ToN5MPuf5c3vBng9KK1NO9yX0YcQD7taKzkW8qojLbSdlMi7rgOobIO?=
 =?us-ascii?Q?+QWUOSfbbSeuBVD4lYHpS9OckDMHJtRt34QR4lFAzil2rssqdH1zJXwSaH1L?=
 =?us-ascii?Q?NA2lXXOhaNivY3tN32I31aLfrDj0+9IDntyAEIfZTL8A5aH2O9m2QPLXXdmw?=
 =?us-ascii?Q?D1PqPc0WXgBO5VJJFqVgDfvUGVgfRvwnlLW3KEm4MMWtnqzHydfrtSnndGUE?=
 =?us-ascii?Q?Tj1P2Jjz4HiBe6bdifD7NY24xxho8c/608LZCDhQ8kVfwEd6WqNOAl/RfJ7n?=
 =?us-ascii?Q?FK0dAV1sPd/zCr+sXs56x51u+J0r6oejNTVMHtCNnZaeMPDmufNt1ekWHHth?=
 =?us-ascii?Q?IeIg3SMTzoBEMDefRBYCgbR3VP9dgjt66scrlaMkhv4wEvyjyViCI6JgUbag?=
 =?us-ascii?Q?63WUEz0dPQtf9r+Tf1SmqCfsOA03xxjv5M/PUdDSBla3Hx4ig4iUkcUM2yGO?=
 =?us-ascii?Q?z8BnYwPZx0jyopoCy8b8eFlXD/2AXU6JHbqR1i0allWcdlQmdEArxT2xn2kI?=
 =?us-ascii?Q?dTEY7IGJHQzFYQ3FEvCN0N94PZjNefH+AI8Zt1EmmbC5oVNOQ1/TOw3I2FGt?=
 =?us-ascii?Q?it0tdFnrdiqQHLi42hETJB8CPUFp2J3YjWyJzTAzc8KMOAUWW2SlUqb+JWIg?=
 =?us-ascii?Q?KzN2XFd8b+ViPpbPFpq+YPI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 473dd873-ff9f-4c1f-6f00-08de07f456eb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:34.7691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RY3JM9FKErOTXoEQo8VoIBqPFLP48Xq4+0UvtjjhqKGeZgqv9A5sB/1C6eCD2NA3edTPsMYDwxXGt+hB0YnYbnHz8lfOvb2MGfWSHPmP5tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8464
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

This pulls in multiple changes from the Linux kernel in order to keep
the code in sync. This also fixes octal mode support.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/spi/spi-mem.c | 13 +++---
 include/spi-mem.h     | 92 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 90 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 3579b7d7db5..6f06650384c 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -120,18 +120,21 @@ static int spi_check_buswidth_req(struct spi_slave *slave, u8 buswidth, bool tx)
 		return 0;
 
 	case 2:
-		if ((tx && (mode & (SPI_TX_DUAL | SPI_TX_QUAD))) ||
-		    (!tx && (mode & (SPI_RX_DUAL | SPI_RX_QUAD))))
+		if ((tx &&
+		     (mode & (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx &&
+		     (mode & (SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL))))
 			return 0;
 
 		break;
 
 	case 4:
-		if ((tx && (mode & SPI_TX_QUAD)) ||
-		    (!tx && (mode & SPI_RX_QUAD)))
+		if ((tx && (mode & (SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx && (mode & (SPI_RX_QUAD | SPI_RX_OCTAL))))
 			return 0;
 
 		break;
+
 	case 8:
 		if ((tx && (mode & SPI_TX_OCTAL)) ||
 		    (!tx && (mode & SPI_RX_OCTAL)))
@@ -300,7 +303,7 @@ int spi_mem_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
 		 * read path) and expect the core to use the regular SPI
 		 * interface in other cases.
 		 */
-		if (!ret || ret != -ENOTSUPP) {
+		if (!ret || (ret != -ENOTSUPP && ret != -EOPNOTSUPP)) {
 			spi_release_bus(slave);
 			return ret;
 		}
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 2eb05a2e5bc..e68e2b50e85 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -17,16 +17,32 @@ struct udevice;
 
 #define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
 	{							\
+		.nbytes = 1,					\
 		.buswidth = __buswidth,				\
 		.opcode = __opcode,				\
+	}
+
+#define SPI_MEM_DTR_OP_CMD(__opcode, __buswidth)		\
+	{							\
 		.nbytes = 1,					\
+		.opcode = __opcode,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
+	{							\
+		.nbytes = __nbytes,				\
+		.buswidth = __buswidth,				\
+		.val = __val,					\
+	}
+
+#define SPI_MEM_DTR_OP_ADDR(__nbytes, __val, __buswidth)	\
 	{							\
 		.nbytes = __nbytes,				\
 		.val = __val,					\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_NO_ADDR	{ }
@@ -37,22 +53,47 @@ struct udevice;
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_DTR_OP_DUMMY(__nbytes, __buswidth)		\
+	{							\
+		.nbytes = __nbytes,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_DUMMY	{ }
 
 #define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
+	{							\
+		.buswidth = __buswidth,				\
+		.dir = SPI_MEM_DATA_IN,				\
+		.nbytes = __nbytes,				\
+		.buf.in = __buf,				\
+	}
+
+#define SPI_MEM_DTR_OP_DATA_IN(__nbytes, __buf, __buswidth)	\
 	{							\
 		.dir = SPI_MEM_DATA_IN,				\
 		.nbytes = __nbytes,				\
 		.buf.in = __buf,				\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
+	{							\
+		.buswidth = __buswidth,				\
+		.dir = SPI_MEM_DATA_OUT,			\
+		.nbytes = __nbytes,				\
+		.buf.out = __buf,				\
+	}
+
+#define SPI_MEM_DTR_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
 	{							\
 		.dir = SPI_MEM_DATA_OUT,			\
 		.nbytes = __nbytes,				\
 		.buf.out = __buf,				\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_NO_DATA	{ }
@@ -62,7 +103,7 @@ struct udevice;
  *			   transfer from the controller perspective
  * @SPI_MEM_NO_DATA: no data transferred
  * @SPI_MEM_DATA_IN: data coming from the SPI memory
- * @SPI_MEM_DATA_OUT: data sent the SPI memory
+ * @SPI_MEM_DATA_OUT: data sent to the SPI memory
  */
 enum spi_mem_data_dir {
 	SPI_MEM_NO_DATA,
@@ -70,6 +111,9 @@ enum spi_mem_data_dir {
 	SPI_MEM_DATA_OUT,
 };
 
+#define SPI_MEM_OP_MAX_FREQ(__freq)				\
+	.max_freq = __freq
+
 /**
  * struct spi_mem_op - describes a SPI memory operation
  * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
@@ -80,26 +124,35 @@ enum spi_mem_data_dir {
  * @addr.nbytes: number of address bytes to send. Can be zero if the operation
  *		 does not need to send an address
  * @addr.buswidth: number of IO lines used to transmit the address cycles
+ * @addr.dtr: whether the address should be sent in DTR mode or not
  * @addr.val: address value. This value is always sent MSB first on the bus.
  *	      Note that only @addr.nbytes are taken into account in this
  *	      address value, so users should make sure the value fits in the
  *	      assigned number of bytes.
- * @addr.dtr: whether the address should be sent in DTR mode or not
  * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
  *		  be zero if the operation does not require dummy bytes
  * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
  * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
+ * @data.ecc: whether error correction is required or not
+ * @data.swap16: whether the byte order of 16-bit words is swapped when read
+ *		 or written in Octal DTR mode compared to STR mode.
  * @data.dir: direction of the transfer
- * @data.buf.in: input buffer
- * @data.buf.out: output buffer
+ * @data.nbytes: number of data bytes to send/receive. Can be zero if the
+ *		 operation does not involve transferring data
+ * @data.buf.in: input buffer (must be DMA-able)
+ * @data.buf.out: output buffer (must be DMA-able)
+ * @max_freq: frequency limitation wrt this operation. 0 means there is no
+ *	      specific constraint and the highest achievable frequency can be
+ *	      attempted.
  */
 struct spi_mem_op {
 	struct {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 		u16 opcode;
 	} cmd;
 
@@ -107,6 +160,7 @@ struct spi_mem_op {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 		u64 val;
 	} addr;
 
@@ -114,28 +168,35 @@ struct spi_mem_op {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 	} dummy;
 
 	struct {
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 ecc : 1;
+		u8 swap16 : 1;
+		u8 __pad : 5;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
-		/* buf.{in,out} must be DMA-able. */
 		union {
 			void *in;
 			const void *out;
 		} buf;
 	} data;
+
+	unsigned int max_freq;
 };
 
-#define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
+#define SPI_MEM_OP(__cmd, __addr, __dummy, __data, ...)		\
 	{							\
 		.cmd = __cmd,					\
 		.addr = __addr,					\
 		.dummy = __dummy,				\
 		.data = __data,					\
+		__VA_ARGS__					\
 	}
+
 /**
  * struct spi_mem_dirmap_info - Direct mapping information
  * @op_tmpl: operation template that should be used by the direct mapping when
@@ -143,7 +204,7 @@ struct spi_mem_op {
  * @offset: absolute offset this direct mapping is pointing to
  * @length: length in byte of this direct mapping
  *
- * This information is used by the controller specific implementation to know
+ * These information are used by the controller specific implementation to know
  * the portion of memory that is directly mapped and the spi_mem_op that should
  * be used to access the device.
  * A direct mapping is only valid for one direction (read or write) and this
@@ -223,10 +284,12 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
 /**
  * struct spi_controller_mem_ops - SPI memory operations
  * @adjust_op_size: shrink the data xfer of an operation to match controller's
- *		    limitations (can be alignment of max RX/TX size
+ *		    limitations (can be alignment or max RX/TX size
  *		    limitations)
  * @supports_op: check if an operation is supported by the controller
  * @exec_op: execute a SPI memory operation
+ *           not all driver provides supports_op(), so it can return -EOPNOTSUPP
+ *           if the op is not supported by the driver/controller
  * @dirmap_create: create a direct mapping descriptor that can later be used to
  *		   access the memory device. This method is optional
  * @dirmap_destroy: destroy a memory descriptor previous created by
@@ -300,13 +363,16 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 					  const struct spi_mem_op *op,
 					  struct sg_table *sg);
+
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op);
 #else
 static inline int
 spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 				   const struct spi_mem_op *op,
 				   struct sg_table *sg)
 {
-	return -ENOSYS;
+	return -ENOTSUPP;
 }
 
 static inline void
@@ -315,6 +381,13 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 				     struct sg_table *sg)
 {
 }
+
+static inline
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	return false;
+}
 #endif /* CONFIG_SPI_MEM */
 #endif /* __UBOOT__ */
 
@@ -337,7 +410,6 @@ ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 			    u64 offs, size_t len, void *buf);
 ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 			     u64 offs, size_t len, const void *buf);
-
 #ifndef __UBOOT__
 int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 				       struct module *owner);
-- 
2.51.0

