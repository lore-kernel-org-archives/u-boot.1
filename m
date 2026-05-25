Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28B3CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93ED2846BD;
	Mon, 25 May 2026 04:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="aRthH4V8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D7D846BD; Mon, 25 May 2026 04:49:31 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D3AE846BD
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qws5BaB96iuEUgOQHgPi80NClH4CWCRalR8mXmXfnw3VKlrrBeTTfOsPXXIDc2oavWREKn8zRbHlUudUMx8uWblWpNoMH/2lESzlcAUH3lSP9tInHt3dyM21msMVFNjbPoca2Vu+HLSbVY9QxJWdeGTMlgQE+hN64IanMFI0NhkhplsyUjOODCGZmjZR65tefzpQI7mprEnPICWA9pm1Oqq7fhqJQewKQYIpcqbHcdLrxzMMO07nP/qoJ5QyB+TwDK9YmP4MqGheeYYtR2xw479mJdevqkUvE9mteVO12lyDsjlqOrbxZo7XlldHIyY5COSwP1oVA6joJk/M7owA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8Ksqolei0xxR2cb3EtWzQl38PUlNo+V/HtsExbPUX4=;
 b=Kaica6nyVn+SiZoDvajSJTYfFNqfyQZR7/KAO6GVnlqOTZuAtHBo2y4jreZxzgmzuXp6CABeG4v52ujarSsRojG9Ji+jPI776tuEqmFMLcdahjCKrX1rlq7onvk0bU/FljNIhXeibL1Lifq1uaZjMOG9V2+yMUYwan8K1la69H81a83wQ8KiiCsfhVkftLFDyHjg3WaOBxKXVYD5UwhIa892E8HL7uarJJEXB4tyc/sA6ZMSie6j/DOKQfj8lWAYY6PEyrwBwWZ4CnN5HPMsRo8oEcd9uuer/vo/Pes9que14NyJvhR0A+mTHCBifgacTw0rSqQZZ0j4GxWtpJBFYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Ksqolei0xxR2cb3EtWzQl38PUlNo+V/HtsExbPUX4=;
 b=aRthH4V86Fs7CNwIUSMS9zYqWlL+CWUeC+4n9OHrT60z8+zPUTHDYFg1E4USYMEa0DIz/sWWuWO06avqnMfRakliBrv8oGLMjyuAhw3HwwuN6m7/sydiVqKZ52msM+e2Yv7/s3ycVSDtN2YobXh4pfMs+05Z/CnZNe8fagol6jyhbrMaGwKZPD/aXKrwMUbm438iQrp3B/CgHHwbDIwzo6kyOZBRXe6BnzOVvqZ8IXG0CqFTxGTXzrCrVKJqYZpVJknIYDtyxtBC+LZA8QCUAcaqVi0HH8EVC4x+jjDsmU4CQfKxRNDJHRwTYfKIS+eIHzNn3zbmi0FWbQ6daLT41A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV1PR04MB9054.eurprd04.prod.outlook.com (2603:10a6:150:1d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 02:49:27 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:49:27 +0000
From: peng.fan@nxp.com
To: stefan_b@posteo.net, ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com,
 BMC-SW@aspeedtech.com, joel@jms.id.au, trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] gpio: aspeed: Use dev_read_addr_ptr()
Date: Mon, 25 May 2026 12:06:02 +0800
Message-ID: <20260525040602.2368579-2-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525040602.2368579-1-peng.fan@nxp.com>
References: <20260525040602.2368579-1-peng.fan@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0049.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV1PR04MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e40468-a0fb-4c0f-d5ad-08deba083cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|52116014|18002099003|22082099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: zdau/KrLtFDkmG/uR5Khrg6PYemOe0cF9kY8m1zsZ45zKbTSTGZvnsyi6Q8EOZlp7olIXwRBFCAd2HbdRLm4FS1svP0etmKmlnlpKOZZGy/h5J5jyccM0+KdJ+VP0SNcvG5hfw2dwxmgd8ux84pqtpS31HBwr/Y7FXpMQhxtOqzWE1Y4QI04PqxIre64AvBHgvkWozY6WQiMRiSQv0B7z+Ehoa6pepG2PZoW5bvZfPQgiRJL1FnQwwV7up2ZAhgolQpjR2tIe0w2409N/kOxcVQNVUL4NwUVZYZC5+7NUF9yo/FGx5/CPcTN6QalOC/SKitsqMEp3g/Ap5kqoe0x82EMsZ4eY82OkEmTVuTQyhRsIbCf3/9Lqgk/w/boPuv+j9pPen7G9yH3HEJnYVF7OoC467uYd2HDrmQ9UtQ+XY4hdU1prWICbML5D1TgYXVFLYsV9vmuLzBcQInJF2IKnMxfJYSyo9jbbnhLIIzWwbJ5ku8gbEVynx8Wuk186MmWFZZL1olcAS8omGNchp+iToI9/1E6ejVY1dRUf1WxhwefUpBX77B6P6D3i31jhQHT3qygr8pJ8BdmdiylDyZdTB6KLdvwFtYY7PxT7kioAalMQ3ragaydn7EDu3CDxxYXs6JOMMNr0RgAA2fo0L2+ccY6egZI7vt/MmeAQNKQLt9IOHins9oXJdVm0CtyfezWRKiK3B8PzAFja0mFOmzvn5ANUbjIileuiBqHdGJWpTxzuXhj/NugCW6QcbIKMXcG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(18002099003)(22082099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q0iCMDAs0SlfhR5SeZSezU+IJFjd13dofHCcg76a3cM3gBcHhlF5cliuamQh?=
 =?us-ascii?Q?Qj7mwt+YKkMjqfjHylEuWcHvgPXLGDOTlS/yp+SJexTLUh52NDWDTBJaz/XN?=
 =?us-ascii?Q?p4XplmGlmMYdUkgy40XEd0Hd3PoFepzHtt56u0rxGv3/9WxCcVDrTf3/ICh4?=
 =?us-ascii?Q?ysIZgEJeeQbs0EbYM6NTci9NGjyQbSajPJBLnWgXvZe4587hvYdoeqNDN/Sm?=
 =?us-ascii?Q?PzUvtw4qsdOurtBkSKt8xcrdj7Na6uXYoY/Lfu09p7z/kkDiams0J/be72FN?=
 =?us-ascii?Q?CGy4IXEnr6+tZ9boP+2cIpkIqcJyikTE0fM656NAfnAl9JnU1HzqfRXJuXKs?=
 =?us-ascii?Q?wxS2UvGklwWWXKkRupb3I/fZAKjDYuaspaol9CAvxwwCmFddO8ZO7D6ng5np?=
 =?us-ascii?Q?q4e28x15lV3gS0g0AqMBLH6t5USicQ2rf9plVp7Zy+XB5gjVjaBbIC895pg8?=
 =?us-ascii?Q?MSY1P/EFPbR69SGPEZhEBHCi+WnC1/dKEXNZz5XjUQAQ2m9c2Noll8tPzGZ3?=
 =?us-ascii?Q?kGrrsAj3sU4oZL5+BqeJCc6+3xBJ/YkTDyIrPl46BSXeX5hym6EBDf4vd6+9?=
 =?us-ascii?Q?Suq6DaZ52nZBlql+xddyoLaGJuYnqwcEa1o+UgfSqzZCXT6XQESXfBZAgL7q?=
 =?us-ascii?Q?sNKV3y+D+LRKJiySfJ7iqvdc4GwUfpkSx6nyymZ2/Yhjaf8OztfpEeXFFMBe?=
 =?us-ascii?Q?wuyxLGNpvWQW5FHMpYEklM46cnxHJjVGLFf1g9mSL6qP2WaPb/2v/tCy2jl+?=
 =?us-ascii?Q?bCQkB8XY3PoZjTFIsMiC85JcKD5D1Mn8t5CnLiKBM/PRu2FxJTc7Ou0xMc4+?=
 =?us-ascii?Q?MrSydli8Yxxvx64OGTgojHJyzDZ5yUUme5lRVvxBi/YtJ/tJUIQeJQKkf+RG?=
 =?us-ascii?Q?O/LDRcUPamPU6dZX1R6WquX48fhO4q9rI4rhhyYLCI0/VKekzGfFE9p0rLhr?=
 =?us-ascii?Q?raYxgV7MyNC60k4w0/M/NrlJ5i28GM4cS841jBG++6Ub0GS8/VwhZeMUPeq3?=
 =?us-ascii?Q?n/w4GEqZ/+WWZ4ygOXCTVsI3yEa+wNUianKC5kwmKYhtx8GfJxiFY99QIId8?=
 =?us-ascii?Q?Aa1NaKR4AMDgglaG1V8ktN1+zPQzZXTIZrRUb7VeET21Nmz+zvKaG6RtIVST?=
 =?us-ascii?Q?9qURFocXY1Gd7ovHpLZbToLs0cj9X86a+eQMwC4yHi8ZP7rDkGk7420swVf+?=
 =?us-ascii?Q?7FwkgH787RK5tTwa9prtW2LBYsD8ZdsoG+5IGoJx7lacMKYWwfoMakysJ3mx?=
 =?us-ascii?Q?r3fC6V1fHYW6b4v/SxT9RLTGRxsfVJiteSN1098v9oC0LY4UbpGKg3A+/g5I?=
 =?us-ascii?Q?/+lyN4tjY9oS6qqHGQli46jdcXjMa0QlqDDPtH/ZWy8ORDQcB2+R1MUF7Fog?=
 =?us-ascii?Q?iP0XuCUJiE74ZNp7JGeY2pNGLpi5u10vfKFnf2/X8EBhn0SueIhlbNg5A76C?=
 =?us-ascii?Q?9n/B6REDC5Bi2kPIFyZd17m1goGAb8Ok0AoNy/Brh1O2xRyWSFw9ZFpMkG63?=
 =?us-ascii?Q?Z9b4flY0X4mHbRBfy3Tc7jlg7on1/79BJcdnivMi+fxn+pLvabx3oCDhnr+i?=
 =?us-ascii?Q?4hGFFMnBHK17d/jqnWZI/LqcH1S95qRQPcvsbNmyJYh/BeHZWZjxcHQQBfb9?=
 =?us-ascii?Q?ApLfa49luLvP6bPQmYPF7L9znq2/6bYZ/wzdnt+ZTMiYC2SzxSF4u2tPsBvZ?=
 =?us-ascii?Q?KYMXKFNrvQSrBRnrgrWckHMH5FBIskvGWfbHzvTCwpbHtPqjtOP94FEatOfX?=
 =?us-ascii?Q?/mYf4H7CyA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e40468-a0fb-4c0f-d5ad-08deba083cbc
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:49:27.6216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s49ZtyskjgN/YOALlpDkljq/0yVovzqeS60BNNOv9fyeXc/JJD6PBzM8s+JAaHcCv/lhPCPbGuql0vh1+wAnmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9054
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

From: Peng Fan <peng.fan@nxp.com>

Use dev_read_addr_ptr() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/gpio-aspeed-g7.c    | 2 +-
 drivers/gpio/gpio-aspeed-sgpio.c | 6 +++---
 drivers/gpio/gpio-aspeed.c       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed-g7.c b/drivers/gpio/gpio-aspeed-g7.c
index 4607468ca05..ae330173f38 100644
--- a/drivers/gpio/gpio-aspeed-g7.c
+++ b/drivers/gpio/gpio-aspeed-g7.c
@@ -131,7 +131,7 @@ static int aspeed_gpio_probe(struct udevice *dev)
 
 	uc_priv->bank_name = dev->name;
 	ofnode_read_u32(dev_ofnode(dev), "ngpios", &uc_priv->gpio_count);
-	priv->regs = devfdt_get_addr_ptr(dev);
+	priv->regs = dev_read_addr_ptr(dev);
 
 	return 0;
 }
diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 4bbdec756f3..d6144d5706b 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -223,9 +223,9 @@ static int aspeed_sgpio_probe(struct udevice *dev)
 	ulong apb_freq;
 	int ret;
 
-	priv->base = devfdt_get_addr_ptr(dev);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -EINVAL;
 
 	priv->pdata = (const struct aspeed_sgpio_pdata *)dev_get_driver_data(dev);
 	if (!priv->pdata)
diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index c5608f4a9df..54a786c4dc0 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -275,7 +275,7 @@ static int aspeed_gpio_probe(struct udevice *dev)
 
 	uc_priv->bank_name = dev->name;
 	ofnode_read_u32(dev_ofnode(dev), "ngpios", &uc_priv->gpio_count);
-	priv->regs = devfdt_get_addr_ptr(dev);
+	priv->regs = dev_read_addr_ptr(dev);
 
 	return 0;
 }
-- 
2.51.0

