Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECCFCAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC928362A;
	Tue, 30 Sep 2025 02:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="0WWmtJ/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 991AC8382A; Tue, 30 Sep 2025 02:21:53 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0CAC8362C
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AB28/wcDKdRkKmltc6Kx4Ji7uhAjKsd11DRZD1Rww205HhDj6VBAo8sK5dRTt2J05pW6h0rWnN8DYJX3J6rqkRIvrQEj2xT9cXi7cAhj6qLEf+jVJrfdfiVtEg/5pLj7szEs12FSAQ2Z9h33Ag5WFzbUqzV1+/PErGzaW54flETPQvzt/UjC9EsDqO4CPLlkW3g9PldL14herf8eYN0yyGQoMtjR8AKf6noVmmNti1+QZHTjbKOvn1FFFSXN0s9hS32MNQwPcY2zpXiO030LdhGRbjv8hVgqFlIXTVCxl+0Yb5OoHTPK352Te1PMgF310Q03KW//YZNY9OsH2RT5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOY3FsMECbeRpUOWsiTmdMVoT3FSpNO6hNYp4hai4UY=;
 b=cEv2ub81jJIi+FPXfi2EOvrfWBY/CCG7WT7FGs+4OqJT43bA1Md4Bz8JYCR+4hXVqNxhyVrpkKNa/hmJcx7kme+Jb5t6871TQel8ylGY0yCnpaL4TijhdUCTgGxLbRgi4bF0QTUt94nmyTqLx7T4RMYrf/mfCGoatlV3aqSlyXaznim8gINDBANYzO5PeGsXmtzxsqUqGYgwkPKo9ed+opYLqCi0HQ8O0BTDse7pBitGtOOY/OFYGc1xr6fFX1MHdmPJFrMbgO69tHF9NZIotxSxEBZdRf7UGnosWO2S6i9UYeEwHPZ3rTJmx66fS/joR3jcjS+x7gAkLbWVe3KJCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOY3FsMECbeRpUOWsiTmdMVoT3FSpNO6hNYp4hai4UY=;
 b=0WWmtJ/ng5Bm4AIciyOzeXocaVU5fxzZVfnSHSJ5B51eNXXJ4tGUwCKuA78ttG/t9RT8NMb9wmjSfuOwv7D5PuuhhKqCoNyneJteGTvRtb3sN09L1cbvbmWISRnORSO7ttkFCMvdlvhW8vgnMM5/X/MYvFSV3e0QwyAlojB9LkmrkjsPmwPY1WA7k4sm2mrTST7iYixFi5woRVrabwjXDeAfNG5qQHmFVQDSAQFOj9daHhSb66y9GJ7kVeT1qbC2oHdj4THNLyPes/i4uy7nfl/Fx3UmBP8CeKCP2hTFIm4uxp6bzk5ZlFIO4FbcvDJrUBls2WsXO1NHVAiJ0PO7vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9417.eurprd08.prod.outlook.com (2603:10a6:10:420::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 00:21:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:47 +0000
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
Subject: [PATCH v7 23/24] mtd: spinand: try a regular dirmap if creating a
 dirmap for continuous reading fails
Date: Tue, 30 Sep 2025 03:21:08 +0300
Message-ID: <20250930002109.3600886-24-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b624fc-52a4-4b06-6970-08ddffb757ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l96tOIuS36VcG4lZsRnZ656NjajeF6/R24N17bahaBPIC11I1yo8l3956EXz?=
 =?us-ascii?Q?wJuz4c9+7BFrvAWcy4sLfYAufCVXuD7BlqnckjO1EEpWU3R29aCi3eNB7+kc?=
 =?us-ascii?Q?4IWpDDHyI74Pfz8sepg18Cog9JrgWoTgqjL4ydrqTDvhX9zK5eMVrygCiPL7?=
 =?us-ascii?Q?pTDzRIy5EaE3OXhxnTDMIprOuXIP1Vkv8h/YVOF5Fkv6jMUi5EXzdYgKvYvu?=
 =?us-ascii?Q?X5ZkgmoK5AkHsHs8FsD7IXr6X1BShFlmvP6n+ZAW7/e5itk5vmOPhrkl72iR?=
 =?us-ascii?Q?Nfb8DkVR2MQeC/E2BbmEPryDqiKVxtNLTbjssV00+ZAMbuEmpBy+j1lUBkK8?=
 =?us-ascii?Q?9ZSiZGzl4Qf8NzsDSeteAMrGR5lixuT/bEQgSpilO9LU47FxZFhFEencwA4E?=
 =?us-ascii?Q?5Gyft10rxy3sChRE8iisiumJjtB2UnJPhqfZonET3WH48i3z9vDvC4ogp/BJ?=
 =?us-ascii?Q?7T/ahgazrLAj3b4FB5wKbYqtTgZIyZVmCgs204P3fxW+zaCfF0MQ1N5UraXV?=
 =?us-ascii?Q?CAoQRLgJfrW2OAeF55jvP0bO1JGPKmx8ak3inqNZ3rOjJWbM3zntX72UO8B4?=
 =?us-ascii?Q?T7yyH1Y6OFjPBtaCvtDQMvDDS1JQS23a88BFQEh+jkk0uBxJHqEk8qYJq0JS?=
 =?us-ascii?Q?B0DvMYHlanIGqzFH7wS8qxvOL9HPMSaz9f6ELrvJUWRLLTX9oI8hAabb9T3M?=
 =?us-ascii?Q?E5F6Ek/I2p3ynWxqlDmgXNVasQVyqG1Kxf4qtdM+7T3Chd6Xbqwh9YhsSR6c?=
 =?us-ascii?Q?MoJ24GEu0cfkztLYDI9zytqYPblpQ5yVQYfuIl/BawKEVIi9SOuHiqj7KpfV?=
 =?us-ascii?Q?iPWK50Q5Apl23MHxWerNAJCTvXI+PNwUZnyu0HdG4w0q/p4LT/S4g8lLzUFV?=
 =?us-ascii?Q?zlMaSuTyu35puU4yr1qboRFDU3I1B2rptONBQMmMNzZpiH5/V1e4p3bnjeu3?=
 =?us-ascii?Q?IEoJjQ0aFkyj3R7hshqRSIFpwLM3gJwxzj/EgaX1BZZb1MZFSMWjSOTjFMY3?=
 =?us-ascii?Q?8cYPxmv2CzkMWZvVHDcxYWG3addZgT69GSM4vxxQsZ4lR4y1tdmLJB/fkHzc?=
 =?us-ascii?Q?NACya6Ecc/nGd/NFB1PW/31k4FRPvBCVjvxInYb1HM49JP7LmZMNc7eNrfAE?=
 =?us-ascii?Q?2j9KKF+OAMzfJp7Td+X1nn1fecmS0psS2zIGVotqfyyMU1O64TCMP3LkQitx?=
 =?us-ascii?Q?EBDzsktAILcxAFdfEVWRwBMsILF23bu8EvavPvSqCeLcYRd0JDT2WFtBEMiB?=
 =?us-ascii?Q?6FcOQRiuS6TNo4sFtsMgtJewIhsWobXO0t7nNmDUo0smfb1NYYZ7reQduS+f?=
 =?us-ascii?Q?pmsR1Wealwar+uFVPXYxvC9OC0m4EkVrTK8IOFzksA/PYKF+DtC+vl7zPgyN?=
 =?us-ascii?Q?Vatt5B5r4/ExjfQQmEckaVcDvMfCmQv8k8ItQKXm7gqgW5Db8gbW4iQ5rHf/?=
 =?us-ascii?Q?hZla3JujgcpRZpL9DFL5qpCMAeZmNgMiZnzn77Tq8ppgDpWxMZvEMZwLYX/8?=
 =?us-ascii?Q?UNEBZuXAxHmLNYKI5FFcjIbar5ZloXtXRMs71koTlgTowa+ZX51vy87C8A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A9fdZ0oeKcqB/wf0E/qC9OofKF3zslfQxHKEn956sHoVaihE+Z513030zwbK?=
 =?us-ascii?Q?qrhBOqqmGMqvKAMceD5DNojh349UhDfZvZMGjdwKWO4mVYCDog3LUEu0v0+C?=
 =?us-ascii?Q?HZrvI9l8uWQhC276N0h1f3HSJSdRPwuR4D0M7QPWXnUwXeMk1Ux+YuwXRZpk?=
 =?us-ascii?Q?0u9Nb1jCl9DIq+FulC85XXqa4DZhXmW/vyZlzXD0U7zDBYSGFQ4TVPJ9Ij0I?=
 =?us-ascii?Q?jRtRe0/PT7ujuTsUILuHndFqfttFOmmRu5e+9SrsB05T8ytUCDpjCpQH9LZX?=
 =?us-ascii?Q?OzAMgJe2z/lUt4+2LaFB3lXxA7XSXVPL+LEUWCcgNwn005WhaCMJh4cGYwX9?=
 =?us-ascii?Q?GjJwAb8OgvRt2KiO/9YU/cgBfKp93LFFLluseBjV3d9qqUYhW+NYZxDcrXdm?=
 =?us-ascii?Q?FTCmydgkAII4FdzAo8KH87ReqxbhfFjeys+7gtnwvqJEx+fW/881+O9PNKUq?=
 =?us-ascii?Q?pQuN219BpFs9TdesedLMsIaBjBiOeSw5xSEpt73xO42W9dmrT//lvMF/EqRo?=
 =?us-ascii?Q?5C0/Gi0IdwKMLwMliEw2HiaLRv6w0UIf43AvaJjSPGpjhBYFmgpzKQBhHAsX?=
 =?us-ascii?Q?6j7pECVwICkker8SusrUF0r0al2sCbDVeJLPj/8bxj1ypSjrCWJLVafmngve?=
 =?us-ascii?Q?xSKTorBgxlNShFT6R6nJtX0fkUSyDSJ/O/FgNlTMJXetC5gTkkfPfeWWd3sV?=
 =?us-ascii?Q?3zRjuKmorvLe0Qh1PX6bOMvpmaE06QdH/7xNdC4D2RUCIWOvfyO/xNFViJOj?=
 =?us-ascii?Q?wjzGDQAf93Z0dHGGI8TIH0g8m9xsPX00ykUYrXG0GMFdJZ/PjJCIjTnodRX5?=
 =?us-ascii?Q?GLNMvzXjJ8gjeNFMUneMqRo5+NlknrFCIEGP5IyINt+Ws7IIXEIS1GEnZKUp?=
 =?us-ascii?Q?MrhwdwMpgsw8bQYAcCqQYqCmEHjQLTQkz4cBGZL6cZERjRaY80+YSvPor+1U?=
 =?us-ascii?Q?iiBlm54BjiKQdUHIfy4R8uUmzQabwEB3izjdC6vC+T+TxxRPLf2xOuSYJf5d?=
 =?us-ascii?Q?wmgkjrqaa1cmLw4K5hRVDvk2WLv73F3HuZCRZaCO5rsMhua0y2W86blNYn8K?=
 =?us-ascii?Q?eF0nM68xEjo9ZnC0/vbMK4YLhHW0AzxNJ7A/V/6uH6LYKcFiQN78IIZpq7Dx?=
 =?us-ascii?Q?uOsoaNsOzg+xv0gu8E6AtNu1iay27RZI39p0CK/SGsu6/isWth2V8nhBXnpS?=
 =?us-ascii?Q?WJc7FCaGa1xJ+c3/c+dsRGEGJUEe6EUG+0R8lbmWOyLqysqEV+EKgc5CHOo7?=
 =?us-ascii?Q?wmAEyN8YClz++EuXEatSlIEhrBnltHSIIJm1GQBVcK0Zos55dd5zQFO5xVRm?=
 =?us-ascii?Q?2tVHDo9CcEWlngyDmwVtMJuCmLKlWBH7xgB2gI/yS9E5P0nhOIFGs608GJmi?=
 =?us-ascii?Q?v2XX+/ZPAdpfPbZv+o3GvlKK5648IJ8tM3NpM0u8DKV+ws/Ka/VCOhoD5x2E?=
 =?us-ascii?Q?Suy5TyUE6OA199AqqrEIzO3lJ9+LqdbvDpZKuZ5O9BDWSDNHozBnV1LSZ36G?=
 =?us-ascii?Q?B1yeKIlz4BG2lVNDlySzYWYWlHiT2VMAJ9k6gXqtqsF0tXcIGHhUn1eFQuov?=
 =?us-ascii?Q?lC3AOa1PRvddkTIY+SAjUMpjB7KieeXYzMTDEUKimffibQi8afkpVVgirFuR?=
 =?us-ascii?Q?v801+ZjF+V4NWydef8798H0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b624fc-52a4-4b06-6970-08ddffb757ae
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:47.3426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KbtCT+nszEBfI+OZ5kdOJa/abBJPTheiWgffQugRmv/641bCF7zDSXZ7QqRE8F2kMgiXtZM6rehnKA2pFyuBUvtam7vkUMVq69BrathXp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9417
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

Continuous reading may result in multiple flash pages reading in one
operation. Typically only one flash page has read/written (a little bit
more than 2-4 Kb), but continuous reading requires the spi controller
to read up to 512 Kb in one operation without toggling CS in beetween.

Roughly speaking spi controllers can be divided on 2 categories:
 * spi controllers without dirmap acceleration support
 * spi controllers with dirmap acceleration support

Firt of them will have issues with continuous reading if restriction on
the transfer length is implemented in the adjust_op_size() handler.
Second group often supports acceleration of single page only reading.
Thus enabling of continuous reading can break flash reading.

This patch tries to create dirmap for continuous reading first and
fallback to regular reading if spi controller refuses to create it.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 69dbdd60a6a..68a03ddee8b 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1114,6 +1114,37 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static struct spi_mem_dirmap_desc *spinand_create_rdesc(
+					struct spinand_device *spinand,
+					struct spi_mem_dirmap_info *info)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct spi_mem_dirmap_desc *desc = NULL;
+
+	if (spinand->cont_read_possible) {
+		/*
+		 * spi controller may return an error if info->length is
+		 * too large
+		 */
+		info->length = nanddev_eraseblock_size(nand);
+		desc = spi_mem_dirmap_create(spinand->slave, info);
+	}
+
+	if (IS_ERR_OR_NULL(desc)) {
+		/*
+		 * continuous reading is not supported by flash or
+		 * its spi controller, use regular reading
+		 */
+		spinand->cont_read_possible = false;
+
+		info->length = nanddev_page_size(nand) +
+			       nanddev_per_page_oobsize(nand);
+		desc = spi_mem_dirmap_create(spinand->slave, info);
+	}
+
+	return desc;
+}
+
 static int spinand_create_dirmap(struct spinand_device *spinand,
 				 unsigned int plane)
 {
@@ -1132,10 +1163,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
-	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc)) {
 		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
 		return PTR_ERR(desc);
-- 
2.51.0

