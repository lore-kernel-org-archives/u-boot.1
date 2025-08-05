Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C10AC87FD2
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7490841D6;
	Tue,  5 Aug 2025 10:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="OfymCYMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85F7D84144; Tue,  5 Aug 2025 10:15:44 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E25B84154
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVc1JJ4DGXgZ2ujAShFqNx5S+PoLgCyROYb1vT/1UJ/7VSzOQZkH91ZAqOvL0yN8evcthyn0pKTxtNTLq2tghZrCnDwbbs8pUTU35rGaHXwq4VV2WZHDDcKmNBaXutHyo2PmzIgloXssIW/G20f0SggVwVcI+IpbQ3JTQhnqXAgf64INMs2QZuj7JVDpVCNsPwqwtNYj3/nZ6GlrNbhX2wQSlugIpJLWMdk1zIIOVkTnZdgS7E7FhtVlJF6eKYH2R78X9N00paKoARD0obdAQlr4N7lEQJArnl78WYxuABCWfwBvkX8UsoBpQmPqXU0ts0bPet71575uV7HoDLRZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joe3FTpTyfHftH0nZKovFP4Po8Wwcg4QHNndEk6K+gM=;
 b=TIVipmSfJAN7uFObpMGYICVhiykxG4WUcI0o1JXOHK+AV9UUR8o/FssRa0bP/GMdU18Mul5xHKK6LtB1GxQQeSEaeF7vWm6nOYzPpMCmqlZIV5rIpqOE4F5KwejBwoXV9+XlIEzvON14p6l/m1FJGpT8PJfnq8EcqCC6vAfc39V1qZ22ctvcrU0doI3L9ogz619CxM9dtJlqVczrGI+xuEIfFvJbS5BY3iLjqmE+80c/+ay8fS2psRkfDWJYyq0e4dTzBHED/1HzhStIZ+evU2oKbC9Zm1OqOsBDH93K9ENYbduC2gdllKTtW2rcQiJxdI3LY3Gko9nK8EYILVNWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joe3FTpTyfHftH0nZKovFP4Po8Wwcg4QHNndEk6K+gM=;
 b=OfymCYMfqS5WtJ7NmiQ9Z/+nSpXfGAZeYGnbOYY0dprHBPBx+L9kORpfM2mpuxzCH2xBh+UVeIvG2JmcCtXP4jZ4ZBzZjiDKcWXzYt5PC10Cd+EOrfnKBD7rI5QAGLFihRDbMavxuW8BuUQ6lx6gSrNMriWZaebloMrxOkMG7mwhFP/x6NOEGlCtNb1SkGg5r3T+VyDgS+e9kZZFPRk5ebCnszmnKKSykkmoBnSd93gFTVmZTwP2zkgQKwVItbvOUS/GR1422xDZS50v24m0/hgHxa7eT9f2blT09KBxcWwFzCrAit+ETElfkbhp8bLsOQP1k+bp5na1OAADIdKM0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6698.eurprd08.prod.outlook.com (2603:10a6:10:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:30 +0000
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
Subject: [PATCH v3 08/22] mtd: spinand: minor refactoring
Date: Tue,  5 Aug 2025 11:14:57 +0300
Message-ID: <20250805081511.1482964-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 7f8bf566-b78d-4c25-c174-08ddd3f83dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D0grMoJljHLR7CCuuLIHyRWhKJ563A+HikjKLp4ydG/S0uJ8cbdTSIgmSi1P?=
 =?us-ascii?Q?M7YvujacFht0rSHWirjaxPiWN+RW9Sp2gEJOM4aQiYlsfL4j19HHB6ny/cW6?=
 =?us-ascii?Q?JfhaZFPWp2BoLjW3Ov/HF8MpNtHCC692f4GTzvcXomtNwAY6DQ0y9M6Rz2fH?=
 =?us-ascii?Q?+hfIefV8y7v1KPk8CCByaPayiTsXcRNlSftePHqaFMfbE9BBB+9Bha+HWCxq?=
 =?us-ascii?Q?9nH/EWLlc5IvXxfj0XlETzEyl1ye8Km2RmlZd5yeOMU0mRfCyOcBAvjoDKXY?=
 =?us-ascii?Q?6fHCRUw1co/uwLa4frzO7vTIZQ+KFvZD/RtBriJFi1oizQOnG2xuoxxTwykj?=
 =?us-ascii?Q?GPsGc2Fo/51msLx3vgCOPyTh4bhNMCprzvmbzWn9RYk0Yax0ztZsf0DLojmc?=
 =?us-ascii?Q?dIBl6nWS8DQzKlymXAn5PkO25Gua0M7MIPrDg2Xv5ysp94JRNhTzBm7tdJxz?=
 =?us-ascii?Q?e/fNb0rndheSJWg5LubNS7ORLcvnEZoCj62M8Q6br72xzW+M0ZHmR/m85FWf?=
 =?us-ascii?Q?6PH38rXdyWTUAFKYIGZEcN9vcAV2YSVN00fD7ddIc7Xzmv0zT8PBxKgj0cdC?=
 =?us-ascii?Q?FQFYzOYSU/A1yrLFEKebg2VYVKB+uvO5nMjTKaUMP0tdGqh7Hnol5EIWVfmn?=
 =?us-ascii?Q?50vxN2mAZJwWQxXA4MUnG/QOksryJPk09Wu/X21zxGmyhoU3rJJpyyHSk2Fy?=
 =?us-ascii?Q?PZxXX0l2WyB97eMgeawzmkFD2L7vdJirHe6pBLpuKT0+67w5JwNnLLokezJt?=
 =?us-ascii?Q?Jbn+6jMegQ7ygAoI9yTNcdSj1iNcijN66fzq3IjYT9JaVhpKKyWuKpljaMly?=
 =?us-ascii?Q?O8WsERZeMqrjcl+o2KncYk2GHn49NIRUJnCceqLMX57jzW6n6CiH9omcXC9u?=
 =?us-ascii?Q?3sEFwFInX4S8B9mJVt2PSWY1GuB7LcOPsrt5qfqDx3HhYhq9bKiua3d5fCjB?=
 =?us-ascii?Q?00ldpIOiqbAcFqdA85o/O8WUh9mjjlNUoppWIncGuktxArcHuw2a0IfxwiVr?=
 =?us-ascii?Q?UBc+jGXea/YZ26TL0j+lnQzznKiRUCTtPJBX3/DsGYJ807Gi5tWOdSVF0K/d?=
 =?us-ascii?Q?i111rWaVQTaGzELN7SyNWcszXePGglx183ye0ybXHj3CfCrE5pnTJR2Wra7v?=
 =?us-ascii?Q?6bKch9gqpVnVLUT4dpK3j2p6+lHAf5gatk88y1QiFTo5lZrb9AXx4advv+h9?=
 =?us-ascii?Q?FsFNpMRl9/Y26FqZjEigSHMBj08ehczoZp0jko9pjBXVxh2a+yTPzPHlxryg?=
 =?us-ascii?Q?qMFwWqXfJSNyyIveciACaNm5LFJza0MFt98V6+xJYbk4GQ2HqGrq03eR/s7n?=
 =?us-ascii?Q?UuLyozsiqf23zpv1iaT6nO4hEbcSjcQfDu7uHuDhiGCIF7ATPRGzTRw4fu5c?=
 =?us-ascii?Q?cCTy1yowDZK4eJoDMHGMU2w72C44c1Pj1wFsYlddrDCl8I+geDivaPp0G/BH?=
 =?us-ascii?Q?iYQSJjT1L26ZMibRP5iwyBUsQPf9V3eGPpX6iBLas08714HFrNAcYv23uIFp?=
 =?us-ascii?Q?0mQYg01eDuePggw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDq6qTPSFdVdXJKyNS88wfYTtfe60cc2+Ka4gWZ3A5hBonGa+Jm/S9v0bOoF?=
 =?us-ascii?Q?rkirYdTBHWMtzsykFnLmPoqqP+a/wmLaKHQmZ/ATcaqyBMVfc1v1dnXrFuPI?=
 =?us-ascii?Q?7aVECNTJo1okJ4mPcHqsFt2rg4XBInsy0OzHl11nll4fvUzD724BEceLJv0U?=
 =?us-ascii?Q?Tq4nULCpzwIVVU+jpyinkN8LV+n9YpTZ4lxEajiEFW+xAwNzB/lW/bEhxFL7?=
 =?us-ascii?Q?cHZzuIOheXvwGr6mcPIHPH6kI+GgINz3qyY06ejrg5UqIRuwGnKDLaMjyQQE?=
 =?us-ascii?Q?97RNWtgixzP02AqGw1kLZiM9ctECUD6L0TRPoFXSiaQjfcVH3HaLoPyNtDXy?=
 =?us-ascii?Q?i/oR6+AWZTRhhnHSSeHwxH7QXF5le+5Mng2NkAMP51m4RuByhWkgo4s6OHot?=
 =?us-ascii?Q?vETqwyZlt8tBKSQ8xOQlJ3bYUbU0Me6aNH4C92ma7krv/P0Bb94k1lZGobd1?=
 =?us-ascii?Q?80+Mw6R2aFSzRQvzU+/Wzqj+nBJQ0n34JSHGb0icCLRnZ+8JUQH/su1IjLJp?=
 =?us-ascii?Q?1HwtgCZzRhgjxnDzV4VUkMF290qEiMEPHP/D/If3vPs1kUP6afJ68266tACt?=
 =?us-ascii?Q?A3NajgV0LVITKVxUstwIq7p5InYuRjXKFLoPK/baCOUJ+8+8AFes2hFCvMyd?=
 =?us-ascii?Q?/aRlhV4xbynmRKDogCY6MHqwdEEElAPKMnSleP0XlzRsSCe0TDkOxE2wBoCL?=
 =?us-ascii?Q?tgxpLAOwxkjpt0kIqWX8uNqsoKTDFi+LoNhTNMa0PjNI3e3oGlW+ehIzcwaR?=
 =?us-ascii?Q?hiuNB4SFtLLbJtuBjJYHqZGLVNVE31GXWZaAkFRamF+4CAMN+BXumITKRPgP?=
 =?us-ascii?Q?aPmVbDh3VN9DXRqx4Ur+xrrtmbgB4w9BQY5F7tQ+2JxPE7Qj29jxvlc5mv7Y?=
 =?us-ascii?Q?6Z+jLFF09/HsKLz9FYdlz+OI7eyHidEtXmiwdTjLZIXn0aU0MYKb1yJCD6Ft?=
 =?us-ascii?Q?9jNsfioOvWRLhSJwSCvHnED2WdHupILYeEmACtGd1chRFLrHD99kmqhNUM8l?=
 =?us-ascii?Q?1kRy4/QGCSYKCr8CM0lvbgux31FUkLYtzJQePMA7MbQS/DPecq1tm5EVlCQa?=
 =?us-ascii?Q?XoBuZqOc3YL19ZDBhNPowl27puX5pJObZU42QXwFbiBdb9YipXDKzNzZxkr3?=
 =?us-ascii?Q?RvcUSx8VYefDxyIT7cuxwIiFVHNWVMsLbXy2YCoZk9+4/ojGjZ4JhB8v9i6t?=
 =?us-ascii?Q?w8QjEXRybvo9DOWZ3EcLMdCWt1YWds4x+47DD8f1Fw6bJhYpGeg1+ImibJUI?=
 =?us-ascii?Q?BeGv4xylO5KqnD0ffDYTdkGgSU49aoRFQH8t5fs55QxXRpul5Bo2fq2cE0IR?=
 =?us-ascii?Q?2Cl/zLTR1edpXLDAd6iyeU4Nfw+fjVx0dmDrwIB0bJot2pP4oNNjp6ARYn4R?=
 =?us-ascii?Q?VTC8MMD9yPpT9LlP1xCmt4ssWAoPJIisc+0lpYZdbgPWWPvwXZX5nNMQG2B5?=
 =?us-ascii?Q?dlgC1uJw/H+PfZVmFMczhY1rQUefaqXO2P1muULtqiue0WS47Ty3SNbURYIV?=
 =?us-ascii?Q?2S9wcht+yAIkb+377Z8e6Z5CwT65cWXhVKtgdGvoS0fJt9ORTxmCSqgFo/2I?=
 =?us-ascii?Q?x1mfHpvVOJ6+UTvq6eVhp/bUyRZX8zMcK8aus2PxhNr4zvhCkmu+8TwE5U5G?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8bf566-b78d-4c25-c174-08ddd3f83dc3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:30.0181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgDygmHoMBzEZ7keRNjAH87gyWrid1YXWHv0FX+eNdl/JxDK0defY0U/KaE55adNpJWOVRX1cB6ID4OYRpGVn1J4sbtPU5jFfvUj5H4zMbQ=
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

No functional changes, just some refactoring to match better linux
kernel driver.

changes:
 * move spinand configuration reading out from spinand_init_cfg_cache()
   to separate function spinand_read_cfg()
 * move spinand flash initialization to separate function
   spinand_init_flash()
 * move direct mapping initialization to the end of spinand_init()

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 112 ++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 098ed0c4cd2..df59d3d23ce 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -160,20 +160,12 @@ int spinand_select_target(struct spinand_device *spinand, unsigned int target)
 	return 0;
 }
 
-static int spinand_init_cfg_cache(struct spinand_device *spinand)
+static int spinand_read_cfg(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct udevice *dev = spinand->slave->dev;
 	unsigned int target;
 	int ret;
 
-	spinand->cfg_cache = devm_kzalloc(dev,
-					  sizeof(*spinand->cfg_cache) *
-					  nand->memorg.ntargets,
-					  GFP_KERNEL);
-	if (!spinand->cfg_cache)
-		return -ENOMEM;
-
 	for (target = 0; target < nand->memorg.ntargets; target++) {
 		ret = spinand_select_target(spinand, target);
 		if (ret)
@@ -192,6 +184,21 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_init_cfg_cache(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct udevice *dev = spinand->slave->dev;
+
+	spinand->cfg_cache = devm_kcalloc(dev,
+					  nand->memorg.ntargets,
+					  sizeof(*spinand->cfg_cache),
+					  GFP_KERNEL);
+	if (!spinand->cfg_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
 	bool enable = false;
@@ -1091,11 +1098,55 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
 	.rfree = spinand_noecc_ooblayout_free,
 };
 
+static int spinand_init_flash(struct spinand_device *spinand)
+{
+	struct udevice *dev = spinand->slave->dev;
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int ret, i;
+
+	ret = spinand_read_cfg(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_init_quad_enable(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
+	if (ret)
+		return ret;
+
+	ret = spinand_manufacturer_init(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to initialize the SPI NAND chip (err = %d)\n",
+			ret);
+		return ret;
+	}
+
+	/* After power up, all blocks are locked, so unlock them here. */
+	for (i = 0; i < nand->memorg.ntargets; i++) {
+		ret = spinand_select_target(spinand, i);
+		if (ret)
+			break;
+
+		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		spinand_manufacturer_cleanup(spinand);
+
+	return ret;
+}
+
 static int spinand_init(struct spinand_device *spinand)
 {
+	struct udevice *dev = spinand->slave->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	int ret, i;
+	int ret;
 
 	/*
 	 * We need a scratch buffer because the spi_mem interface requires that
@@ -1128,41 +1179,10 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_init_quad_enable(spinand);
+	ret = spinand_init_flash(spinand);
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
-	if (ret)
-		goto err_free_bufs;
-
-	ret = spinand_manufacturer_init(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to initialize the SPI NAND chip (err = %d)\n",
-			ret);
-		goto err_free_bufs;
-	}
-
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_manuf_cleanup;
-	}
-
-	/* After power up, all blocks are locked, so unlock them here. */
-	for (i = 0; i < nand->memorg.ntargets; i++) {
-		ret = spinand_select_target(spinand, i);
-		if (ret)
-			goto err_manuf_cleanup;
-
-		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
-		if (ret)
-			goto err_manuf_cleanup;
-	}
-
 	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);
 	if (ret)
 		goto err_manuf_cleanup;
@@ -1189,6 +1209,14 @@ static int spinand_init(struct spinand_device *spinand)
 
 	mtd->oobavail = ret;
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_cleanup_nanddev;
+	}
+
 	return 0;
 
 err_cleanup_nanddev:
-- 
2.47.2

