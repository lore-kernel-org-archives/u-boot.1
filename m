Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0604C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 047D68406A;
	Tue,  5 Aug 2025 00:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="gyG1iwuH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5225840B3; Tue,  5 Aug 2025 00:11:54 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B530D84005
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z10dIpbVAPlmVkqsLdMUnBTy0RU7QUyJdwLvo0WWmwm/U7QePXQHrB/2EqvSYHGVNVjNP3KBKgQDp/YCUDbKjbTejxvy3NuzMBW6Myk+W+j48g7c/M5Xa0FE0RzJqyEPEKpddjDyAEi6gpqkmGdt38jix6WgOAU8Y+2WsSyjr4hKzCoZTEntCFNK829nXi9BvLWqlmTFXttmjel60Y8E0fzBsP1EmxUm6vsCnlQ7mTXxzddsXrP6uK/rafPP95KG+uXZFCkAt3qdWNCCRJPjF3EZxMN2xZ6j03Gvf95ncF7gSOVCRaPDNifl1BVbttUb92jH2pXbyLSRxtAc9dnyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlGn8I/v7QpZ9A0R0I4e1Ag1KQ5nvGrzOb+Hxs+M0pg=;
 b=d0Mn93dI+RpTu0QK0A6LiDR/vWBiAPFTfalDo+FH9DDBjpKCgVhZzdhmm7MGqSpOO9qPqyFpA/1tHp7pGhTgOxZg2SvnXWvvR2o42QQmJUDCOe96CKuhTJYx3jvqv0uJWveHVZwOOyR8QGPkEJkEet7kPRnvqo+EschYbrlydU2g2zhM9E5+qr3f9847ShZgtyuKACP7OWMlFqdMe5D+Rg81ooZY6UhWwyoNNE2yXHFVtZ23h7Pd6pUhqar000OXmZ/oqbC49ybSauZTT84PFPwKZyr9gRutL/w6XvZG4CJlCQsGoOnv/l9fhlfgWU2c1Pbqr9lRA8QWwKdmxAKPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlGn8I/v7QpZ9A0R0I4e1Ag1KQ5nvGrzOb+Hxs+M0pg=;
 b=gyG1iwuHLMTcbo67C46YZ1d2qKwfcdgWHHmGAX1sXzdLgch9JsTNmTnmR9Nm10IMe+Qzi1XjJIR5JrBOwHXvIqKkeXRc2ffQPuI/R5emARIhE2XKohp9FvIeJ7d3s+D7iAzKgTVLikzsVQorH/jP3NmEOvPa3u7b0a/0DM9G2xlYaHWGFKvVqFd6UXcWNPfRFNTewhpk9Ll50IVMd7D0jan4wn8mu5N36ch6eNf3obft0ltJXSMo10Ubv7dsz4LmfVohV8KOsw6qLFwX5toxWzQRSbG6LF8940hw03NZ97HtagAfi6QnvySTr3a/xmIBcOPyWDD61SGaAZEqPm3IzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:48 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:48 +0000
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
Subject: [PATCH v2 14/22] drivers: mtd: spi-nand: Introduce a way to avoid raw
 access
Date: Tue,  5 Aug 2025 01:11:14 +0300
Message-ID: <20250804221122.1420516-15-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e04a64-47e1-40b3-b466-08ddd3a3e829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PLsKmkySA9W4QHeYBGh1jmaN+JxXSe+tYLMlg5s3K0wZka8lKNtoGA3SMVT6?=
 =?us-ascii?Q?gag8IgOUoEATqrWnfwwH5O/PLwJuvyZNmkI+a3snuU6rGFrnk5qD3SQ4RKV8?=
 =?us-ascii?Q?guRW6FnR0nRCmkadg1aFxY+6y93mk3PO6VrgNI+LB8y7bQdqidIr9vjr8jhI?=
 =?us-ascii?Q?toGg37SclPknf1hR8g5TOKnhWt458WII+c/gf5QoUM8SYXGzS6flIHW1bsAT?=
 =?us-ascii?Q?VZiZI3sxd9nDPRXAeg8h7LwwQBHup7csbrf0Hu29BrZZEj1E1dNDtz7R7r+Z?=
 =?us-ascii?Q?F0Gti7nKEEISAJSgA+RPnlZJsFJRPUNrnkYv5NkjbMk01BqvdQn2c96cp7dA?=
 =?us-ascii?Q?hQZU5f+9DDfn6mZBuqkfG6hh1m8Kfy28e3WBM0Rtzx/dnu16Z9Ib03a3GS4x?=
 =?us-ascii?Q?pCGpE+qZiyaR8gSz/H/+nkKFWRqhE26d2DKfbihPYIWaDPfRLtbtg1OnjUL8?=
 =?us-ascii?Q?pOQB24sMGs9tcy+H8je871S7+NxugWGCuEo/1qZajK29AgzT8SfyZY6ix+r7?=
 =?us-ascii?Q?cVGyzW1znJRb89Sim8ic2jDx0P+OLulxSJGPYxmYHdl0YtuNBt9XwcfGSnwI?=
 =?us-ascii?Q?juqyHMRG2QnfpumdMNh5Bkez3VU6v9jrSVKYLJdTziL7FJWy6bJDmenEMSJk?=
 =?us-ascii?Q?5aOuAElX4l9IrbyGsHsKv+ZfKcUaIATLFUEQEh1cxsCBNidL5cPBVOrEAb2R?=
 =?us-ascii?Q?2qzZ5bpdYMJNR4opBm6bJexYZNIkKpAy+4+EEVPXs8sbCUEsoCrk26YH19EZ?=
 =?us-ascii?Q?7Av1UbyGsFH0vIOzne4pNgYcEP5ctXrwRR24ArKbpIoXKwGsbGzV9X1yOsmD?=
 =?us-ascii?Q?xCY+AQtRg6jQ1OyB+HCU1QTEdrhJCx2t6HT7Nj3D/WvG8NjwnYuBSPb8/fdo?=
 =?us-ascii?Q?X+dLxdLEPNDaUfZddDDT0YXODnjiBIYWlx5zrFn3szT4HAeOUBj9ogF/oUfm?=
 =?us-ascii?Q?vvJkOUStlyYJgfKbzjMXz+gv0RFZPlU4mgHHex3hkKPHMRB+konuxAVQh1RF?=
 =?us-ascii?Q?Bd6ZoOybhZM+SYcSExQu+F1lXJ0sMyc294+IhPyyGdf+FRtxVyHGHwIfMrOd?=
 =?us-ascii?Q?iSOroi8e7xumzLmuvFZuNiHSlVD3GwJ7nTc8mAB2/X8K3ivmtH+GL5g4ahh0?=
 =?us-ascii?Q?J+NkBdX2f0GA1rBOvy3Vw74ZmIqXQR56mVesV5dYbHLrjaXwA+YbuH33RhS5?=
 =?us-ascii?Q?rVYAL+YzZGyW7nC1Qu8ncm1ZZcKasYENDahSBPPZFpo8snHC+mGo3jiTLz91?=
 =?us-ascii?Q?LUOsspoRo4Jzmxw1QAYFe1nxikkPPog8vhou/Gzjou29QTsAEEyunsMVY8TM?=
 =?us-ascii?Q?g7/7T+iFH9xEnrhcL9mlR3D0Q0JuxF934l5xbW59b/uvTXDXb976gP/BbWzY?=
 =?us-ascii?Q?c1w0qrQ+qsOpcBWsF/pD3xJ8pz11ckJdISqayWgKDg+9M9dQ0jYj3v4vb0SR?=
 =?us-ascii?Q?8hhRssuUpy/g77vxzowT0lUu90K4xeHDlbInEfYhJbdXmTzfjBV/MLFiXv5Q?=
 =?us-ascii?Q?9YsShZHAI1WviDw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r0I4RrW7w7Vocm9Ygg6MOLf9/2VBP9+C64h3EvPPbitUGtlbNFblGrDYcJ9v?=
 =?us-ascii?Q?IjsaHK0Jc98WflyH9kjTP8D57FT9m4CA0UbtLuY14SsuELWMaYeaZcd0GpIO?=
 =?us-ascii?Q?lMKOPJsEysxebX7CjrW3eBPegP+eNvuLpqDb7f13OjWx6FRIVpavqoE/koWL?=
 =?us-ascii?Q?Susiawq6e/4ShAAzGDetZMwBz3W3dGO3TdNooJ80yH9MatnzmzQ6Etst1yDh?=
 =?us-ascii?Q?5GxZqPVzrK7xJjl6BrsDjryok2gNl2p7GKm5GAa492+QlPjG5rRfx35tPghL?=
 =?us-ascii?Q?osIa948Xu1n41KfLJ8y/hbOFgIs3FMJ1Pn3gE9oM7qKrK7GckVkz2M9uyJ+J?=
 =?us-ascii?Q?lOmUlYNQkfixa2iE4W5ogXPTk7ILVb8I5Sw5CGIH8XvNXmYmq5LpTvlafm0I?=
 =?us-ascii?Q?G3XCInYIfjFJDD089qIfTZmc8W5rtYf6UtxW//kmaRgoeEZ83dGjwzC94Q60?=
 =?us-ascii?Q?ihUBsWeEDUTfwvzEqmtO380aAMSUCfBvR+nrtv2tfFGPnrRORv/YwK3pshXy?=
 =?us-ascii?Q?6kiJ1hugh5mSXVGmtczPZfDtpvm8pEr8J2T84stcDI2H195Gr+wX4cAkrjnm?=
 =?us-ascii?Q?/heJVpjevne2tPZTheuIicLCgoexfOWIrYvKLzXUTXbXMDPbTNXr9Sd4X+ri?=
 =?us-ascii?Q?zcD+45TZBrrGLgtdoBZ0m7TvLHvk/lKxVzL6ZfOhFKWvci5Ey6NChoFWoWp2?=
 =?us-ascii?Q?cVfIan1WxSbj7qjcvh/tuuAJMh8Xz38BSnpe7mYqbEt3YHVPfF7gxAThoRCI?=
 =?us-ascii?Q?G+efEld79WkZ/8V+yDE5M8V7AGDDU5SX518ahHXTPA5OE6Cw/Wvre8NpDA+d?=
 =?us-ascii?Q?dpklihzJ8HF3l4ZzbG/9ywZJLUClJy2DAEh1/MZ5bUepELAFRmYuqrL0hJZZ?=
 =?us-ascii?Q?u8Dp9tAiFIUd5xeb0HoTYz63msaqNDh7vwyehCUXy38ayDU8e3nYiFeZ07YH?=
 =?us-ascii?Q?hD+H+p0PYjb8c9r9jNsINT4tD2siocpgcTKVxNcx4wCLl/hzAhBX9c2SQiu7?=
 =?us-ascii?Q?9qFoz5xQgQvgAzGu4dgIgSEelvilGfTIpBTjj6RQJbwsem3VTJ0ek/CJ6Vo/?=
 =?us-ascii?Q?/uw3uCWwE/ZnkHarL/kQIjiEakRgp5Lxnkv3UUCH2hMznjV7HQwppCWAPmgy?=
 =?us-ascii?Q?rZ31179Orag7WcDjPThJUq2+UIeWpf/X6+pv1nwbECq52iZRxuR39IGHjwPY?=
 =?us-ascii?Q?tRVCwY0jSwQ8yhNgBWjDLB42siVjrITqpSdATpymyn9JYMOydQOCqoObalFB?=
 =?us-ascii?Q?KhH0UzzOSSSDJgsNiGZSh4sBSlXiyVXBebHY6MHyEWTebPunhKYmUvmFLqP0?=
 =?us-ascii?Q?ixmJCCyg6on64OASFAj6cEWU1rOAAHQMYe0xQcCNRyUYX5lgc/QAkKzg3sEI?=
 =?us-ascii?Q?Cj+k+oMXgikIqD/iHAs9dRemJAthLvVaEM1U+ee3SpDR7O+md7s/x7RyJyuE?=
 =?us-ascii?Q?kt2atph/SLl2rS3aKBczXUQL4dWV2ZRj1cbmzaJINUKgMDrpmXZLl9/GqaBU?=
 =?us-ascii?Q?CsqfKLqJv1bgS366uaEc4drI4HPqNtXE3beNeFe/VmGfJxQOKP8vrbBbI5re?=
 =?us-ascii?Q?tt8d7z8yfTwz5U8WtEB0NxC3KYAkSqFoL5GJHN6WyzEMekyFnXX3yc/UrxKM?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e04a64-47e1-40b3-b466-08ddd3a3e829
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:48.6552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+DijG8eBoFqPZ/qFmqmluVQYmJ9zdA+DoTZgMA7xK7K0dL+Z+DJK0He/pijiApJiL6bGy0ICpY7Lb9qrYzyPIAXtCREe8+TotagZMwwy0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7771
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

SkyHigh spinand device has ECC enable bit in configuration register but
it must be always enabled. If ECC is disabled, read and write ops
results in undetermined state. For such devices, a way to avoid raw
access is needed.

Introduce SPINAND_NO_RAW_ACCESS flag to advertise the device does not
support raw access. In such devices, the on-die ECC engine ops returns
error to I/O request in raw mode.

Checking and marking BBM need to be cared as special case, by adding
fallback mechanism that tries read/write OOB with ECC enabled.

This is a port of linux commit 6d9d6ab3a82af50e36e13e7bc8e2d1b970e39f79
(mtd: spinand: Introduce a way to avoid raw access)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 22 ++++++++++++++++++++--
 include/linux/mtd/spinand.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9f150eb8585..a8fb3177f8a 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -298,6 +298,9 @@ static int spinand_ondie_ecc_prepare_io_req(struct nand_device *nand,
 	struct spinand_device *spinand = nand_to_spinand(nand);
 	bool enable = (req->mode != MTD_OPS_RAW);
 
+	if (!enable && spinand->flags & SPINAND_NO_RAW_ACCESS)
+		return -EOPNOTSUPP;
+
 	memset(spinand->oobbuf, 0xff, nanddev_per_page_oobsize(nand));
 
 	/* Only enable or disable the engine */
@@ -737,9 +740,17 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 		.oobbuf.in = marker,
 		.mode = MTD_OPS_RAW,
 	};
+	int ret;
 
 	spinand_select_target(spinand, pos->target);
-	spinand_read_page(spinand, &req);
+
+	ret = spinand_read_page(spinand, &req);
+	if (ret == -EOPNOTSUPP) {
+		/* Retry with ECC in case raw access is not supported */
+		req.mode = MTD_OPS_PLACE_OOB;
+		spinand_read_page(spinand, &req);
+	}
+
 	if (marker[0] != 0xff || marker[1] != 0xff)
 		return true;
 
@@ -783,7 +794,14 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	return spinand_write_page(spinand, &req);
+	ret = spinand_write_page(spinand, &req);
+	if (ret == -EOPNOTSUPP) {
+		/* Retry with ECC in case raw access is not supported */
+		req.mode = MTD_OPS_PLACE_OOB;
+		ret = spinand_write_page(spinand, &req);
+	}
+
+	return ret;
 }
 
 static int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index fb3a2e5d909..63626c9c27c 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -320,6 +320,7 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_CR_FEAT_BIT			BIT(1)
 #define SPINAND_HAS_PROG_PLANE_SELECT_BIT	BIT(2)
 #define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
+#define SPINAND_NO_RAW_ACCESS			BIT(4)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.47.2

