Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912BDCAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 674AF836F0;
	Tue, 30 Sep 2025 02:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="1RmzchJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0085836B8; Tue, 30 Sep 2025 02:21:43 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AC183677
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trFOcBTFMqt8HQDF6ejdWtT64FNMpmrMYlThqSlVqeBGg5LLahQtyL62/kaiHLsM2eZjp1HMBFD+mffg9uaaXCldHQmDbDj03tZ0SqEUl+w3OiVlwi52+VcMBoB/GtV1TO2aXYUozFOUlCBYJaar7JovICFUVSSUtFZ2wjjifsVn1LWR5rBxTjyymY979sAdv4b3Ff1GOxgOZdjOL8TbRUKPv1X5nypXq3FPEi9FP7ePo40IOxwenmn1Ah7LRIjC3BOoTa4L+E9Pb3X5vLddUIG47HZw5RUDjDbAm65GDWQGjvvriKVwwieFNLQ+GrbUU+LVZq7l6TNKTpwcwUDFOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTNIrZcz9nqK+/iGkLDq+uMwqO3B9+nw0JvZX/al3ec=;
 b=vK9SMVIJKvW9wIDm4L5w9W67hrXhhztIwe77NA8Z+syb+bbgaJygprZJIrPDb+3qvzfpPf7dDSopcjvNEzfgnNUOOlQF9jBz/9r6vSHLeWOyUxO0th1iUY8Y134PwV4Rm5R0LkaWAKhpI7di52lxZ3H3s/LYxcI8c/ZgegNWrcnZyridgn7HLHyxkqscdgStfZIjH28cMGBa2lWjaU8cB4WG9NtgyJD2ZY0p7QFXitiqI72bAbwCyuJmCANokxy+rDU5Bsn5t253jbbMcEBihlkvf2s4sf8VD8ka/u3PlcwkYRf5eiZGUapzFBqv94OS+LzptkEVQkdULR7pDZ8htw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTNIrZcz9nqK+/iGkLDq+uMwqO3B9+nw0JvZX/al3ec=;
 b=1RmzchJMCGbgs/u9uuUsQrC2H8oq6HHAiB19tdazXsQNWnuWKaM+AyNXgY0Tqmt/v9BGk5SCj85VGFNEgBl0PYsQbNMK1Dwd3A7pVilcERriUUC2GuJgDoiHwqE6v1uQm29EmbYupw9uD/HL8eA+6cqaZbrbjSnoSAg2UICS3CJEbF+zlhLSCBPLxhb0pFPYVWiskFznlI8den2gP9naZKXEn4hBiAqph8zG7uO8HYR0V1NXkuwBc797vfnjSixrMI2ACdzW9dAjLa+g5YKB7t90R+joGUfW9JMUVCN0YtKVDPPS283LCkIPxjOSbK4EXgwHJShHtRCfWl8L7gX82Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 00:21:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:39 +0000
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
Subject: [PATCH v7 16/24] mtd: spinand: Add read retry support
Date: Tue, 30 Sep 2025 03:21:01 +0300
Message-ID: <20250930002109.3600886-17-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 9f53f583-e882-4341-63d7-08ddffb75259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X0mCPsf6PZJVSc1zeL6eC401ZlAedjlZfrhWeki8o54gA6ei9cEzI0eFow3Z?=
 =?us-ascii?Q?gDZnJG40o3cxzkheQvozbxg6ES8PMSGQZCiuK4IIkIcvZucJzt9cSQCDFANu?=
 =?us-ascii?Q?95mI9q3VqBONvjZlmnsEkG5zRt7KnlFZTxqtKf6C6umC/pgNuFuPGmkofNoR?=
 =?us-ascii?Q?m4qhENNtb40XxDpBbc9P/HAS0255RkAMpJ8jnPkDmwv73rgnhiebVmT7L1X0?=
 =?us-ascii?Q?NgoQTlfb2LhB1LK80edBqCyIHighGOotVFrpJQDaxdy8hlN/H3wdDQwJErFQ?=
 =?us-ascii?Q?uh1QI+15xnm2F8x6BvXCKRfElgIwp1iwNNmaswNByVQqCj5hXQnWwAkbgTxG?=
 =?us-ascii?Q?8DhwB7o1/zreJVUxTDOsL8ZGrECet55fZsBXN5DpWA4GKf08o4uwONNvXTXr?=
 =?us-ascii?Q?+N0m6cwvaUP4cYP/TlGfrY2t0ZnA2iAVIGGb8ofI+PK2B11k9IKXWlfMYJq7?=
 =?us-ascii?Q?sCe++Fcv2HeH5wirOSx48hendepBuvYo8P+i8Uf+QGEFUku2rHxVQiXKSPuT?=
 =?us-ascii?Q?/2Lh8sZhdvihQGLOM8jSws7TXhqJjMpd090wGXwgGRIAH+/Tcx34cq2Xavcu?=
 =?us-ascii?Q?S7UpkZ5NikhovQTHaU414jPTpgCQooVE3zUpwDLfwtqgBzsgnJILdirPhOKy?=
 =?us-ascii?Q?3/1uxG+VrkNDcfYGimBJKVsFwKaQZlkImVVOO4hALUnfcZFS2ButcLQyjdm5?=
 =?us-ascii?Q?Uztf/LfDfduEh+M9dcZceO5oyVvAnNXFAyj7WNhXroGlL3Sf2DnkNELTR573?=
 =?us-ascii?Q?QOcV3eBJAOhVY0vw9qwoRuthCpMEjvtmxjCg1jOusVRfz0aF5xd1FBt8xAIq?=
 =?us-ascii?Q?0iBRB4yLuqIGG4SnR+UGCoYilf9os0qVNFwcbY+N1eFaCh6Fyo60J1ng6a4r?=
 =?us-ascii?Q?HXXwXl01mKUAePiKzzSgiHe+qgz9bmINIlHtz0wr7x45DDagu9IAsFCviCS6?=
 =?us-ascii?Q?hsA/j+gSABsZQYYzh0RFhbJ8t9l9BN18E3XBCS1Y0Cb2NeYG/wWpt1NPGJbZ?=
 =?us-ascii?Q?y0NTp7k3yO98RtqFwOXVviQiWE8f7wwY8Mt/pdRTYRGUz4bI6iz0n6egWGQ2?=
 =?us-ascii?Q?hmCXI8eSYjULYf885Jn4WduiNE48U0dr2VgYoxzeh1RO+c9WQbXF7GRMghRB?=
 =?us-ascii?Q?1d8Qwwr8GZPZSkNPlFVIlha1BQ0Pc8I600O+yJ2PF4ttzPwumkEI+Lqv2jU9?=
 =?us-ascii?Q?8S3nMai5CzYhkUilZ1iq/2kKgfK8S+3hY7gJaaSgT5G33AQjLdp4VvbyOjL+?=
 =?us-ascii?Q?7b6DzJpqh5TpVG4M7l9aY0WqTLdol+m/U4JIKXW59XE3BQf3QvDbHkQ3JyH1?=
 =?us-ascii?Q?I8aX2o0U2a/FjuwA0XnaURQs6ZI2zvFJo6Di6MF4E1ocpLks54UqHmsjrREg?=
 =?us-ascii?Q?+90kxd4FVE0QcT1xqQJCtEhFo/IZYD6pucQ9tfjX6kWvIH4jIVq3slaHTnsO?=
 =?us-ascii?Q?+dNrsIT7HXKEbIztUiWgfCl+72kbukZRe8J17lW7PwxsAZ264QhVLpJ69/Mz?=
 =?us-ascii?Q?CinfwJTjZGVkIxVnES7xpCSODD8AeTiOddnU/a9jmipWsxm8LfyQSv7ePQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ppSNeq9IIQJ+vDoY/OTabZiwKArad+fN2XSnE3zEwIC0T2OSwBkSxSKNUEjj?=
 =?us-ascii?Q?2ApLv1hTXFaIrNZm2hSVyY0mD3IWbtXz6Cl+yICFpreweKx4kuUNS5II0X1t?=
 =?us-ascii?Q?lwFP2wULVKLl6wIFu2WNOL8jFrsf2S8llRcgQPPgcWOae6uDowCKpiB29ddI?=
 =?us-ascii?Q?0ar50umj+yhviFwJVuvcYGSzhZQKPKcd6WukaLUudOpRbinr4NSk8ZkdQmso?=
 =?us-ascii?Q?MKXTfp38yFnLZFJ6IXG0TTjYQXpzVdVmk3kDjEeZNjsRUVp+KcMdSKrx+6vN?=
 =?us-ascii?Q?kXmXe3UqKJpFtf/7Z9nXlTzu8FDvD/x0q3btqU5x3QIYPwmGv5lTM/3h/+a1?=
 =?us-ascii?Q?QB0cn9Hpk/547U0aTzf/U5/tOUqGr/43FO6pEPY6vSnSO5+auQ67+FseNuFO?=
 =?us-ascii?Q?q4eYeCvHskQ3pw6CPlKwS/1eF2X/QqpSdNLEbMmcT46c8fhLWxLP1nTHyEd2?=
 =?us-ascii?Q?XjQVgm+ZEnAVy3NKwFHe5tZUQXqdPFvCPZREgtuLL0m1t5BIz5upA86sPD9l?=
 =?us-ascii?Q?GBXmH1at/HgsHa3dD2DlUqMwrlYvOf3Lp6EP4n2z3/547X3iBv5UqG6KiHD9?=
 =?us-ascii?Q?LOFh4L89qD3UuEA+QE6DlmsabcNpO+A+TK9altdiY4Bp42jWJJrQ3P/u4GRl?=
 =?us-ascii?Q?AHDowFa/3tAvqXUGfuCJDjACeMkM1+d1zdbZacgZ0QwN8Rqlbgis+U716Z7U?=
 =?us-ascii?Q?d2HklBsmYKys8UBByXFVKaYaBKQOvjudI0Et192rEJC3zZGwHXt8HgJpdqqw?=
 =?us-ascii?Q?To1+bRxk+hyIEU+ByN4mUkJ2yEdqVoTSmsfHwOHrG0HdGI9FjsPuDDyQvPX8?=
 =?us-ascii?Q?rVRx1DC3qo06ElSQyxJD7qY4GYJKZkwFua+Cv9xWC+IRR0eYpYJmF66Tooxw?=
 =?us-ascii?Q?YBPA6ZIf1xZo24qQK4OgLaWIAwuauMasFfu7lGGjxoeIPmRBVj1CRDbNRtGe?=
 =?us-ascii?Q?UfI+bh8kkqamAM1ugSMjO8Qc8CIyYhtdxNoHijR6UnWCbw+TKmdU/7GCn3DG?=
 =?us-ascii?Q?05RJSzjI1fvHMTEdGfudXdaavHAAe049uSV5N6gY/rvLLEzXiUpIWlYjYNtx?=
 =?us-ascii?Q?O4KzNdw4E3pYhyyNndnNomQ/LMKTnHKKbeJdYUJ9mUIfFe23XZmpQU0fbNmr?=
 =?us-ascii?Q?q+Yc9qz50BPoWrXdqn/QLsO2V/6SVuWXqMEtbcVEh3JzIb9tAgTJkui84JNR?=
 =?us-ascii?Q?pixA1Lv7OWoEP2a1xO7AckSXrjrrp39l6m94UvpKew+PVqJgOf11hZXbIuSo?=
 =?us-ascii?Q?rEOUd02ya1SAmulOrLdLxnNj+IfJKIqBp4I8vhQyADZ7ISxBMCEQQapJ9611?=
 =?us-ascii?Q?V6DqjrtaLGfjrfvDM5zGesBB01qndTffIAVcqOIvESHfoYcaeLIF+YSEk+RS?=
 =?us-ascii?Q?po8LD6s2mETahCqIED1+p7VpiTR+CvZMXBiWHqgPUooDzh05U29KI5O7KHPR?=
 =?us-ascii?Q?j/OlklF+dhEYE+Mt7Cz3j3+J3Y53fiX2FFgup1WA0y5OYiyREbCGSvWtDvCK?=
 =?us-ascii?Q?O7lJANAv99no5M/CH2J1OiRADA4f0d/tK1YeEwVRgZRgVNjW/Wg0lXy9KJyX?=
 =?us-ascii?Q?uue23kYCE1aYt6f+Jdafeg12Q/22C7L78jgkR6iPROemAel0vPX/B74VJqF3?=
 =?us-ascii?Q?hi9LP6bQrU6sZSaGMJ+6C/w=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f53f583-e882-4341-63d7-08ddffb75259
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:38.3974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkYs4l3+Zvdi4p4H33Jd3/hSI1c38fnMB1anN5mMisylUVcABU83KcwU8YpKenuAER/ZBMPYukTaMdhdF2hA+y+IsfugOakcT4o4CkQTvYk=
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

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

When the host ECC fails to correct the data error of NAND device,
there's a special read for data recovery method which can be setup
by the host for the next read. There are several retry levels that
can be attempted until the lost data is recovered or definitely
assumed lost.

This is the port of linux commit
f2cb43c98010 (mtd: spinand: Add read retry support)

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 35 +++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h | 15 +++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d4777ec7c8f..33d0c27f788 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -687,11 +687,15 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct mtd_ecc_stats old_stats;
 	struct nand_io_iter iter;
 	bool disable_ecc = false;
 	bool ecc_failed = false;
+	unsigned int retry_mode = 0;
 	int ret;
 
+	old_stats = mtd->ecc_stats;
+
 	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
 		disable_ecc = true;
 
@@ -704,18 +708,43 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 		if (ret)
 			break;
 
+read_retry:
 		ret = spinand_read_page(spinand, &iter.req);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
-		if (ret == -EBADMSG)
+		if (ret == -EBADMSG && spinand->set_read_retry) {
+			if (spinand->read_retries && (++retry_mode <= spinand->read_retries)) {
+				ret = spinand->set_read_retry(spinand, retry_mode);
+				if (ret < 0) {
+					spinand->set_read_retry(spinand, 0);
+					return ret;
+				}
+
+				/* Reset ecc_stats; retry */
+				mtd->ecc_stats = old_stats;
+				goto read_retry;
+			} else {
+				/* No more retry modes; real failure */
+				ecc_failed = true;
+			}
+		} else if (ret == -EBADMSG) {
 			ecc_failed = true;
-		else
+		} else {
 			*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
+		}
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
+
+		/* Reset to retry mode 0 */
+		if (retry_mode) {
+			retry_mode = 0;
+			ret = spinand->set_read_retry(spinand, retry_mode);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (ecc_failed && !ret)
@@ -1309,6 +1338,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 		spinand->set_cont_read = table[i].set_cont_read;
+		spinand->read_retries = table[i].read_retries;
+		spinand->set_read_retry = table[i].set_read_retry;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 2f8212e4037..44c616a4acf 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -337,6 +337,8 @@ struct spinand_ecc_info {
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
  * @set_cont_read: enable/disable continuous cached reads
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: enable/disable read retry for data recovery
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -357,6 +359,9 @@ struct spinand_info {
 			     unsigned int target);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int read_retry);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -385,6 +390,10 @@ struct spinand_info {
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
+#define SPINAND_READ_RETRY(__read_retries, __set_read_retry)		\
+	.read_retries = __read_retries,					\
+	.set_read_retry = __set_read_retry
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -435,6 +444,8 @@ struct spinand_dirmap {
  *		actually relevant to enable this feature.
  * @set_cont_read: Enable/disable the continuous read feature
  * @priv: manufacturer private data
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: Enable/disable the read retry feature
  * @last_wait_status: status of the last wait operation that will be used in case
  *		      ->get_status() is not populated by the spinand device.
  */
@@ -475,6 +486,10 @@ struct spinand_device {
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int retry_mode);
 };
 
 /**
-- 
2.51.0

