Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAEBC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A65841DF;
	Tue,  5 Aug 2025 10:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="gfUBgydo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F7D84181; Tue,  5 Aug 2025 10:15:48 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5995984191
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZD6h7oULYQKrjLEpqXRFGk4Cn3QHIYYN2aL1QDcXV5XQglDNfFz0p0eDY6iPMXwO4ZYp20KpMWM5NaL4aoU/usmw9v4/WnzWIH7kFq4/MP/9Ks6AtjGp31rDliNlvXpXuWix13JO4eUto2NoS5XUCNKuARSOwgFPmSMLC/93a9MeSGAMJu3Zv6OLLPlbmrlbwwXmQW5GUmsQfuMpT/I2NWT15fdO7OmLV7cui8PNIPnemPtzuczyfDl5psSM6z0HeJjyxEA2C4Do3EThjI3ROVYnIy4rnseoGnj9i8q55kpdPN2erGQCvfO5S6a4YMlC8gvUVIvtbCIsZE6fJh/clw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBwmidDiCw3hl6wlxUCTn5dHyz0IZTdivXW9wk57W+g=;
 b=xz0WuLST+P64ccBr5F2/xYan2Cj9oqk889Js5hAkMcay1EfNOnqFnzMBlhJXQuSpRM3YmQrgtozUlZIoMiat7INCyi+8Pz3A7aV1+FFYaMHC73DFikINiFw8Chge3H4sajFC3T1PWWl/xYaeOIpVpQp3YOqPytQMVN4GGmfoPkW/56avW18KA/R5/ilmCRXb8QWLAtQRg2hP/tRa7sohjE540PUOp4J9lcUgHJiELgJXTLFSdPVaFZK1Z9vx5YhJtN6QrIh+rtqqNTa/t72hBRD4Ljqk6ubsdHGOIwe/nhTpSedGj/oEyT7r/n2fkRg2q94Fgm5ZPbFo9DehK05Avw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBwmidDiCw3hl6wlxUCTn5dHyz0IZTdivXW9wk57W+g=;
 b=gfUBgydoG/gFuYvP0pCR5CrPMUIT4bilwj6lvfwWKi3DEvYnrdgBz+QeX9jx+kSx4V1RqL2ul4dtOwAmP3Rfrp5bAmywDz/TauGfwxfE0QCuU1C+6C9EzV3Z1jkuv41F1+KImEnr169GhBcVoPKSn8OQuIve63p1xRu5if/ReXwXEJ6wO0hOYx1i1IOIyeziQrccY2637LhP7bPXx0/EG6Mdffu/RiCHJ8VEdMfbVbh3tzjho6e3tHQA08TQ8VXU1RdwcgnWveq8SgycbFVz+w3Xti8L7ecnWSa+oSBI+hSiGi0G+v+0tH8uyo4ck4HRvCzUJIXfRjI57ItTX9kDdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11069.eurprd08.prod.outlook.com (2603:10a6:d10:139::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:43 +0000
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
Subject: [PATCH v3 18/22] mtd: spinand: Enhance the logic when picking a
 variant
Date: Tue,  5 Aug 2025 11:15:07 +0300
Message-ID: <20250805081511.1482964-19-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 1ec00a5d-d49b-450f-297b-08ddd3f8454b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ENWm1l5p5xGHyC5oWMTmLN4SnPCTOEfV6FVgrMSgHKMg7MyqcFkUjE4YS40E?=
 =?us-ascii?Q?IeNrWtKP3MiTV0B6x0KzG5ordMgdIFukW7ef6kIp+f3HSLegOPbDy4LoZz2b?=
 =?us-ascii?Q?SgxNy1nweXeZvm+rf18+Xu63SZavbc4XRBuRU1GsOHBeKkL9K07kTph0JEoX?=
 =?us-ascii?Q?lec9ilpYwHyyUFi9ehQr2pwz6u+OxrIk5VuHI2bn1sjiynstgaz2kIzQUfTP?=
 =?us-ascii?Q?zLD5a1ENXgGlSeq1xlmo2PcQxxPZLLWx3AhG/Ds8uE0rqecyksQHyTRTsIwn?=
 =?us-ascii?Q?VhQVbUi1mE/yLKuhhc81cdS6pHtMiFyJvI1lABOmtNDnK/HAXWAO0JqTSJqo?=
 =?us-ascii?Q?Se5qeCstsKSxqCTTakeoz5y/y1SXVCkzpYpdhl3NFJgLfmCSvlXFqq+CLMD0?=
 =?us-ascii?Q?bmIxm+Jc47FWB0w1ihf8/LM0uoKGuru3ZTLtWFuY6n0SNvDUn6Wz9hVIkTAk?=
 =?us-ascii?Q?il7qPLsT5LVb/scWTikxRTsw16ylBASd7uyMbPq6GJleUwn/FWg5nVa9N1nY?=
 =?us-ascii?Q?gMrtNXuIPtg/Zh44S/qSyRi2CC1BrzGAlUIZ3soJimiF7Ct7+XIVjscclDw0?=
 =?us-ascii?Q?Qy7FQhOg9VRnb7fQmLYRrG9E/FOthwIlAyY9KGkKaBO/17t8APu+BOAFPbiA?=
 =?us-ascii?Q?3FwQGq0HS9aT+XmL8zvhLErHUzc1q1WHK9mY+qBT3jKf9ysLvV5EK9QiDZTr?=
 =?us-ascii?Q?CHnuTWZ8qjJQcU2OQc7wh6g5qYpLlfn9y8BK6vwCzetlQuMBOyeeW54dduvp?=
 =?us-ascii?Q?ixbmYrfB3ayNXySDC1xjwGutbCqqGlAMXmMfXS7/7Muy2YBp7Fb+tPUhHvSx?=
 =?us-ascii?Q?TO5OEQ+Vav4bQ5PV40+PZ0ff2dYUfiC0gMGMd55lGwTAVTdEWl0R4U07AVnH?=
 =?us-ascii?Q?ZNcoYYKIXU7n8WBMMclYQbw9wkyVE1PhPia0u8wlKLOPxXY1+sNVdftwYwLM?=
 =?us-ascii?Q?qWOMxroEkeJPSBO5yrIGkvSjSb3GFOpksnQJAYMAXRlgNqql33dke28frxbd?=
 =?us-ascii?Q?AGzehilAMcJuzc9aBiOAJ8cZuUU+BbfhqTXgDgAhgiEM0QYa8m5wr6VUn590?=
 =?us-ascii?Q?b7Pf8pyaYjsUOKRspQq/+9NlaUtW9QciXAE7W2NCSgqA2FvwUZrOAtsniR8L?=
 =?us-ascii?Q?5iuj5oMIqytXzkbbqqoGU+rCK1QYlwzjGkQSUbOEi/5f8fyTc6F6oVdmNZam?=
 =?us-ascii?Q?Lk5C/HZH74FRxgEIrpjwJCk/uLJDR6TuwnN7eDAIa2lRsFxLeBItNpTac3mi?=
 =?us-ascii?Q?CIptYlIkJW8X8jR+ppdRnin0GGwj2Zc+FnHttKoTR9Fm2BtUSCJMa7v5frYq?=
 =?us-ascii?Q?dRyMOVQUvQJArlM+tnrgacb8py6RdqecWfRixkor3bEUC0+dZ5McmnjG7TcG?=
 =?us-ascii?Q?xw1b6JNWWJjuTxSdIj6uRofdmrTjlKH+xh9LqL3mkF2wKAgSrcHheaSNwvRK?=
 =?us-ascii?Q?kjfXcE5thTF/p3TdSiffQttUl+1HMd0WWSwqLEiuHnN5qQU/l4LTURJq/zj2?=
 =?us-ascii?Q?6r4WjRUy2pSDWw8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BLPcq3v9AIMA+7+x/i/qmgiEAPBspk78odUOr3RbqwslrjiHcFbXLOes3sI/?=
 =?us-ascii?Q?HSDbXkDIfMI0UbHCCCzqye2DLJo3GBS5S2V72UWR0naoqKtkpU+9qdA2t3cG?=
 =?us-ascii?Q?MI++73tJT9EdtxB+R/jsyh9EqziRxvlGGc/LDcr3BP8BkoBLlo/42btPY+hA?=
 =?us-ascii?Q?byEI66oGKdhVJ9bF4uJUaMAWaYY0Cysr1P7zvgyE+33rvZ53781DmRYZUDBk?=
 =?us-ascii?Q?necQ8kJjolKtJTsKmCKbdPk4t5W+18LBxtuLNeaYYySoXQeOAQR98L38O4lA?=
 =?us-ascii?Q?UGOHulGtiHi/woKXGIxWQUB6TmQvxhQsYNyB+PRJ5qot+MXYKFBuu622R6Np?=
 =?us-ascii?Q?H+vV03CwfgsRG50CZ+s1X6MdlZTBpxWzKy0ZnkYJ25L0p6qx9tV3eUXwH9B5?=
 =?us-ascii?Q?NPB2i/CdG7RneagTBLJ6sn96FMfuv119t/n69XbQVvM1XYqFTXVyoJTFaGNb?=
 =?us-ascii?Q?/nyxAuDWvy7HbX/2c4F8J1pVNC7uaANPMY6cUynh0Wg8BUsEo36Y+R8NVhVB?=
 =?us-ascii?Q?LzMbxbIJq1AKPD0w6knYOFdtU6MPBzKLYgww7KUtpi/fJWAvhdCxeaDcSijO?=
 =?us-ascii?Q?2NKThZPnTQl8w2CzZByCntz3+jgkzPCNhlJxG5wowaH0zH4Ga7RbXS6ycrKP?=
 =?us-ascii?Q?QVXlJ+dQG07naxbj3eovg77813u4I85BgqKlbDG6px1X0BhjXju+Ojpxx6bh?=
 =?us-ascii?Q?cONyDZo6LrqY3o1tnwr0xNmNbMyMb7jSJDse3EMx5J/o3A8uV2hGv97Utu8l?=
 =?us-ascii?Q?CBx6lr61DB8ogo887+rHv0JK0Dondaab9D084NTmfYWbM0PF6d8e+K9ZUa06?=
 =?us-ascii?Q?wxyziVxsGIRMIr0EajVMOVvc+wJ/+aJARmBSUMmVC1vhHOxuzQscjwlSl7bN?=
 =?us-ascii?Q?ybtggFrJd/2dDwhd97tRN/XUoiQltgaBQmaVc4diaWl380/+4sUPS3rYF5qy?=
 =?us-ascii?Q?BAyBmnrlDHtOAgNV1OEtkqV/TlLHVb9YMvYelNrhcCTDP2FGnYWV0y93yRDW?=
 =?us-ascii?Q?hM7J9FM+EqxMMQvLWh2GhUvA1ChIdSr8B5MHzFC3E6+dxET2G7REgus51ExG?=
 =?us-ascii?Q?iknaPd8kKaWaLzZjFzRuRPjkQ0ST+uxnNWa5+Y9BDyZjrgNsn3U3dZ3cWR43?=
 =?us-ascii?Q?HkwwAbOpthh6PL3Pwfmuztnb5oj99bgO6FS35z84Vj/JQY2CGOQBzdyWmtdc?=
 =?us-ascii?Q?OJkYhYxcFmP9O0/XcFy79dwiD8MIypxwdJP1WKKA3PZFGzT09sqUsHN/T0CB?=
 =?us-ascii?Q?WYj9Pdz9zOXrKcF2bm1J9GUOXunwsCfoiMM+8Qw/xwVO8w1ohiIqqY5JAiYs?=
 =?us-ascii?Q?9/IIJ4Z+2cWUiHN8/9g4QwfQD1mt2TRa6IRSK/VU81ckzfFJvwLH3KZ6iuGV?=
 =?us-ascii?Q?OcnTkJhy5wE9JVZ/CB8WmL8/0/WMltA0XAjVMJ6dQYKOjgsqq4hHZRLIFaaZ?=
 =?us-ascii?Q?wCPR6xJ724jgg00eT7O7nadArtPgW+oQyQICNdqGpnwv0dNRghDd4zcpMyHn?=
 =?us-ascii?Q?dQlulAVpSSQnJNTE+zTNutDKVPFIZUdfHJALhw0xo5m6h+jfjH0PPalRBexA?=
 =?us-ascii?Q?nne55SnqItACt/u/hy1aaURvtmgjAPrQJ8MskxxNtN0zPa5el4B5ZzemFVIl?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec00a5d-d49b-450f-297b-08ddd3f8454b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:42.6631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oILrIB3zacBdN66xTmMJtGsnNM1x1JCjGiuA0oZu44FlPZBZE3x3qDMmkagP2lf84Pybd/I+LoRy//zBT7z4Vh3nmdyQ+g7h8IZgykWCEGw=
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

