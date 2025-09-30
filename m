Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887EDCAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5589836C8;
	Tue, 30 Sep 2025 02:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="VzWHoMbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A5E836B4; Tue, 30 Sep 2025 02:21:41 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7773383653
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEUBwsT+Y1dWxd6o/Pxx/9KU6XFr1yBcmUFTdzzbXI9AqYOcmwuCVaKCyCh6AuPhAVeAJXuhWpah2jO8ny2kLAmLxg/ezMXTYQd46h9MRI9wUsyt6Ger/L84m/m2qi2OKoUHZyJXUuyecXG4H1zYEa7fq2gyLvRCuUpYwSul2Vv0C8Za6nWBWss/t88S/rHwNwmWfg4SjKGYifD0iCH4Rl93hYS3/kE/PO6ZNTHbwSVlltyGJ2mj3HE6Ys0jQPSpBVaCtMbu0aWurHFrBbRFse4mVjxncFnrBNnVRwx44tsXj87zzTMYbCDvTuKhb4bXQwjR0KnyHN1YmUb+RbDKrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJLrIXolFxP7/FYyWDMDU/p3eOzQ17QWLLzE23u4eLo=;
 b=uYYGUgqMQptcn6q//VBZIZ6OGolZL5AoadMCXXsPcgu4ecwc2os+bSbgQHow/VUdk/mdKonDnx7LFp3frgaDapW5JQzdTeaEb9W+u1vnytG+8Yd14cGx3K2VhfdVUC4LGgSV1vtye1kH8iKTaw5Yv9SIJzCX79K0oAdKmdaK2QqNqn0zUu6/97BhHTXOaJCwXWICK7P8h+s92/s+VKjZ1Rm2t4i15PMTL3AQYPslGYeb6AOStewQqW3woRRP7sI1yvUmA9BwFjWKRi1dzGF7bFKDWjXOV+PG6suMu4bSvT+de/J0XeYzF/ULjmPcGoCvimw3fZ6UWAaNIP0MQANFvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJLrIXolFxP7/FYyWDMDU/p3eOzQ17QWLLzE23u4eLo=;
 b=VzWHoMbb4m1TbmeMuCdY7b2HYG1nOr0yuGW5itdywL1knzm2e6rcC/Ag9G+HNbOhtT2ESmia5wPUXIUWRtmg7vTFNlBa9PpPLkXGjFpZEY2H0sSkLMWNfZGRPtDMw0HfY27Hnb3UfRUzWUMnW16jg9hKc/41Rpm3//EjOeTgYOSsYnGWdfYR0wk9y4EaQIa62TDwhzreSYJng4ZNBZiXvsOdKziT6YhNISFdX8bvdosblTLX+oo9SHjGykb0u6BIyaSqAU3kMMXLcQp2XGjS/XyJhFqByotGtBcUfuuYuBzhDaAMnLSMX9QbXJlhvlILD91QJN9cfGGocNNmew+M/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 00:21:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:37 +0000
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
 Andreas Gnau <andreas.gnau@iopsys.eu>, Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v7 11/24] mtd: spinand: set bitflip_threshold to 75% of ECC
 strength
Date: Tue, 30 Sep 2025 03:20:56 +0300
Message-ID: <20250930002109.3600886-12-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3b4316-d571-4709-c2d0-08ddffb74e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sCaCK+nJcdZGohZDET4/fYukMuZwITzbZRQ/TFqUsY+gp7eL6tdEwzLtoVj1?=
 =?us-ascii?Q?n0r9tszUFzy5JIerCUUkQfZdFDrfFL+ALdD1BVQb188uRZqYNCeaDXASWbYA?=
 =?us-ascii?Q?vJvzaoTkRTNLI77MD3c7zQ1oragfM3BzXmBJm1FfOay8OE2GIAcrPp5fWLFX?=
 =?us-ascii?Q?1W4ixeTunEM83rPLmuQRDK+I1AAmDI86WjEiFpgEOF1NswOh9Tqyjggyooj1?=
 =?us-ascii?Q?BP0J14oWK9pK3xNELc+mRZZ37jW0Q4hXgw7WmReoXmubbuGQiyfEEbR3f5lp?=
 =?us-ascii?Q?ftDCZ9+1WMMCx7TrOdDxgSomrKo/G3m/WOIu0iYGpKGeQcPF/uDzAORtp4//?=
 =?us-ascii?Q?hWsC7Gif7u2yovmNsAUYOW4aV+a4E31xp9/53dgh5ga6DbHOSHXh4OezB/WG?=
 =?us-ascii?Q?uvBhsrl1PAfZTKg8Rk9+/uVNwXXrXErHkZ6gT+sL/dwPcOAA46zyVIedNIpn?=
 =?us-ascii?Q?BGFXgvee6gJAuMCn0kc6vxHEWSz6quIVuvK77Bo+N9tK3o/wJcOLZtlkpQrr?=
 =?us-ascii?Q?YXUUKazzrXlf62GAoVCgLm5V562OoKY8FOpIPcZbG12wrSAU6yZTZrHP3P9t?=
 =?us-ascii?Q?0WYaAwZEV2zsrlc6sLoRNnXuVofdWWyZa+7q7xMAgiFmAl4Z48m/W6sbgSEs?=
 =?us-ascii?Q?X3zqh3dW3JHbkvPr7MvRjtXVRbMUiWnHlIt9bm7ttHCpIaDK4vd34urOsJTx?=
 =?us-ascii?Q?Y2EF9esHKRNaLxuV/5gk6ziIOMY/VzZcx+s/yKO5yOyfTzKqXW5bBBAJn3NC?=
 =?us-ascii?Q?83fO0fwqJ0+0Kq1zgVqlCc4xVWSvEWheEEYhx48YrR0E1dLrE59kZufVDoRC?=
 =?us-ascii?Q?fQiGi/286Lmqgp+2IwPpocvGOISg+Gtbeu41tVXYyXmupf5OFAJ9fXJgCfQa?=
 =?us-ascii?Q?qhYzuwsFqni5ofDZsBqOZLtFjPNPMpDezvpuI1kapdXSK4Zasrf9RFu4WhIO?=
 =?us-ascii?Q?fcTeKIDnJK93HKgvVdaz21uMmRl6/QyF/yqxevpBov+W4z1rlxgpk/JU1rTf?=
 =?us-ascii?Q?kBn1I/pzZNTNy8/UNLpWn+uA2hPF6cTZJmTj/UcqhPddb9xwAbbl7ek4a/pJ?=
 =?us-ascii?Q?gNhssU8NXcf8jkEfYF8OQSdhmGRNM4omeEFAumLYxh9swvXU63T0Mfbyonj5?=
 =?us-ascii?Q?Tf2uzyJYNv/IwF4kX2DWE0szxTHrm17Yb8bib33HRPrTe5KGHKrbB7IKLPsH?=
 =?us-ascii?Q?9uqz9taOlIOsQtMiVxsU8dw+/BpfSrlw0N5f3BzhGv90viJ6eSMgdbYUAxJC?=
 =?us-ascii?Q?/2us5dFPLHZmaZUvklto5wkHIoPITrugKriKGH+qKkr93C5liVUBePLWOM2B?=
 =?us-ascii?Q?+gmiFKgiNKcYu8Q7W/S6By0+S7LPew2qekBgpdFLdrTecnDLi6l0LOO1mlHy?=
 =?us-ascii?Q?skHUTYqdrj25Hxs2T9sT5GXaOfhrAvJMEvQludupuy4OQaJrsfqkbxgHyXOy?=
 =?us-ascii?Q?8gofWRAotFTpXZCOI5AhMI/xRCWarOWKSo/3/EuFFffIPS12tKDErUyCkb/8?=
 =?us-ascii?Q?oAhViRRWcgO6wcE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NNKHkDwnS6RzpOoXBryJUjk0mby5vWWbzJKdDqElSqoJrYAGXlTgrB8owuXZ?=
 =?us-ascii?Q?jgMMPy/A4MI7FF37+sAMgB+kfwyZh08mZw6RWWStzPbsYwFSF7bkDU3Wp51/?=
 =?us-ascii?Q?BuPq7hWjlHkSKzq5+vwqzWQ2VoR9urBP6mKKgDE3ziCFkfILV+YIM9YuIJsd?=
 =?us-ascii?Q?QAp1SAQODpkQuUVoAje3as/ePMuJikVGyAab21D/2/wHLsPxgBsGF2/9R2SH?=
 =?us-ascii?Q?AYrJhfHEgjMWXA6yHMRj9QypDuRQgCk8TRojaQEvKaKPw5kqsfJSB+kX4sIG?=
 =?us-ascii?Q?ZFCKf2qOh1InE7Il1Jz8VFgFqsiajox1glSj2uLg4Z7rjpPUKWBef0Mg7yXd?=
 =?us-ascii?Q?ptrs65x47RmtL6lbtahMsY8miEonSC/Un6/FkesI7AZigOccFwxYuW3xt/1z?=
 =?us-ascii?Q?sy/VCGsh2rjjWZbnsNw1Mfigf58OnVJm6kFYI0qW7uQ05eh3ZHYtlU75uAMC?=
 =?us-ascii?Q?38s1F/NJTN+kuj/ahrMcDEOyTDKbo1Y9siU1Uu2x2/lTFFj/OINkqYZw4k9/?=
 =?us-ascii?Q?yI7sf0D5EL4AxV7HH3LwLzPq+36t7gvhZGxDDZ9M7yAY9MwZrFefvSuxDvOx?=
 =?us-ascii?Q?bJ65yAerKJOa9hBuNulPzYbCRvZL1aelOZ/mZPo//Dx3r0KRcMs4N9CVNeLR?=
 =?us-ascii?Q?Nw+/TMhp2lkf/4CE7xxF6/FefSV45o5hUvsXnffiefPjyW+BJBxZmdBnOyzM?=
 =?us-ascii?Q?Gk5Hw0rSmE7XXNM3Hb3jACZZzxiLtNbzvsl0tWWSCYr/DnzlRracUW0RDtz7?=
 =?us-ascii?Q?quhp+FExJjmxwqrEOdHVM/evszqUj2iG2dY5/91zrwA0WCKaM4hTsB3fRihJ?=
 =?us-ascii?Q?GIZGKF8valrdnrn6XpV9H3inIDEoubk5I7ZeJDVhuXTZKQ1+S0nrdgREmax+?=
 =?us-ascii?Q?GLKDAcwU8DF+VpWTws52mRRdYKZgM92ChjnECWKJ/AizvOHnc951LCHpTOm5?=
 =?us-ascii?Q?vBdeygq3AeJQF/T2TqAbu+LsMoaF0sywBBuO/bY8jAKZ0pY2xL+WjOp8Blhk?=
 =?us-ascii?Q?qH771g6Zc/hbM2IaynPBCxJefJCXgXTc/ZbnmpuMYN3JvHbdh/fYwgZFRMXC?=
 =?us-ascii?Q?7wYkYCl8/UUENtdkbkRnugT0IXRxntSzj7cDfn843wwZylKFUPm4ha7RCAqL?=
 =?us-ascii?Q?rZBR4EF6wtXUtuZT1r9g8VlSNp9ukIFOMkl/z8wcjMFijvUcrtH204TgEeJ0?=
 =?us-ascii?Q?o8yI5ry3GsBxp4/6oeNbwpDxLySopfbSIxHFxM6SnsXc+9/3f8BPfevBntwQ?=
 =?us-ascii?Q?rxQ7qOA0sObQxxq8gt7r+psaljWaEzroiOlF3m+Mdlk7NnJ0nBAOpZKVfYDf?=
 =?us-ascii?Q?1Xevvuwq7HsCLG+HJ+A3+iTebng0ZyRDzH0n599FOCderD25SR0bI+lZi7BW?=
 =?us-ascii?Q?QcXvosI6j9Y82rCxPAzB2Lu5j1qxbrFpiwTJzZgdcQswEh8PJ2EP+NvzxIf0?=
 =?us-ascii?Q?ET6ovS6EAhMYW1580t1/88/SX7Yc0mPo6+z6aj4IRIVb3f4OTHxeH3WAM3s7?=
 =?us-ascii?Q?j+yIP2IZCF8Q1J2ts0obMzAQcACPUNGhuwhR715k2YNXIrktsnNgQZmhSX5q?=
 =?us-ascii?Q?T3VE5V1a2I6XfYPk8doYZRhPRxXeNOjxs1bvZLCq+rVQHg+u/5r1uxwh597F?=
 =?us-ascii?Q?GmY3FrwjfWO+dbC4x7jsRKc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3b4316-d571-4709-c2d0-08ddffb74e94
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:32.0774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKgnZw85iyrhYl0NtG1+37WJMPPWIxnsjp8hTb+PNNJMDh8L5ZCaQCVuVmh5b4HQYhvuDGqHsfGnq/LCYJFz7T67E4pQdHE5qBruzvu6ctg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11512
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

From: Daniel Golle <daniel@makrotopia.org>

Reporting an unclean read from SPI-NAND only when the maximum number
of correctable bitflip errors has been hit seems a bit late.
UBI LEB scrubbing, which depends on the lower MTD device reporting
correctable bitflips, then only kicks in when it's almost too late.

Set bitflip_threshold to 75% of the ECC strength, which is also the
default for raw NAND.

This is a port of linux commit
1824520e7477 (mtd: spinand: set bitflip_threshold to 75% of ECC strength)

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/2117e387260b0a96f95b8e1652ff79e0e2d71d53.1723427450.git.daniel@makrotopia.org
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
---
 drivers/mtd/nand/spi/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b5daab21743..2a2ab664c2c 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1291,6 +1291,7 @@ static int spinand_init(struct spinand_device *spinand)
 	/* Propagate ECC information to mtd_info */
 	mtd->ecc_strength = nanddev_get_ecc_conf(nand)->strength;
 	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
+	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
 
 	ret = spinand_create_dirmaps(spinand);
 	if (ret) {
-- 
2.51.0

