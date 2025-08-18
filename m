Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13971CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90D0882BCD;
	Mon, 18 Aug 2025 12:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="LJ3wWzW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B749F8206E; Mon, 18 Aug 2025 12:06:36 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 730EC801BE
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIUj8oslfBHDU/PBNVmiE/BrlE/m7Yl6i7Mn0971sVX/qkpZROs8DHztUZVwHAFWpW2SIuk9SF1i/k/HV2DFBJXjCHDyxQ7XD875vA9ZyMyUU7Fp0/rdpJUUMP9eNNLJW9upRityCfTPJP3B6OaZLMl4PKxoIkotG88pKZCZAWsbBgkNMEUDZDK+2+h6HfEcqIVOq6VznC1YxHmCuL8Vgjj4TxHkNzxcbXSiSdUK2X351/atrmFLe9hm8CYQVtliA6Ch72bLZBXF3iREjYz3xLKA+WM04Fy5WQZzWh9q89DSQLUsaT8unY0j+peQ4/ldu6//c79sH50Fgsfa+DFQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD9jvpJjO0f2GmImSQaJIkkjnQxG4I7Rq8AICxZjflc=;
 b=s+UGeC8NSG4KhXfZvdxSgSpSX1VwegYImQjWdD+G7siarUeeRUH+W19vsFcxz5eacccKPzrZVkR3JtfCKOOM8OkNbqJicVd+Wtq5Ko9epmNbiP4s3+47tagxkVNUBslew/b+PgrXzP6WmU0Lfpf4s0m93UiQtSHAwcn70t8gbP7hwJZHEEmnUELxsXCzQYmCPOkIwTvWLIGu30KgAoriOuMll8CuHeCoMSdFTVtHXC6XagL4b+1z+/jHTXTiHWkTauKeuf4sUKmsR2/UbEIIf0U36cZblhxT+Qv48uw9yDOG9hpHVHKNT9IrPGS6Z347tQv6VRAUvHNbXzS507ZF6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD9jvpJjO0f2GmImSQaJIkkjnQxG4I7Rq8AICxZjflc=;
 b=LJ3wWzW4Pq/AYqoeH2J3c4cByfzoYTqGhmWX4o4HqzXRsMy2q0zK6tpeoImKcb6csrVXCQ1SXLHmSxZW1+zrmz1B7z2vRcd/Hj+yErbActWrNFQWahpHS1q0DjJR75nLmvGaaP8uRDSTSHbEJXpg+IxwgVcvWMxNd2RojlN/EygwMRSGC+mmwitjNK1T48CvHyqRprTx2kQReIG7sEMBCAJjCeaAkDfHsZTs2p/rUGhcxjHt766wla6U+SPlMDoQvtp0f3DNDCOYY8ZbzrwgBYfAlJZLtZQERwUeXyVdpftRF91Vlz/gAwNRnuFiuUhoMkugINQwi/EirhvkzK273g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:33 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:33 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 06/21] mtd: spinand: Make use of spinand_to_[mtd/nand]()
 helpers
Date: Mon, 18 Aug 2025 13:05:58 +0300
Message-ID: <20250818100614.432931-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 313e5e20-e400-44b3-3683-08ddde3ee89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TLn4cx/r1YHo6zjzpsxUEclOfsrklhrNzm90T/WbPx285fgBS2T1Qf7woEXF?=
 =?us-ascii?Q?OcHlIH+hi/3XgPVSzQ+wSsxWMAppco81o72ZN/FV8Na194++O7yc3HH+O0/B?=
 =?us-ascii?Q?HxMCx+idAS1M2/pL6m2UAeLRZpg6/2tKDI4pdr3s2XU8Y4GMA86EtoxXeSGA?=
 =?us-ascii?Q?Lj8AKoJWJ5ujqkWHYesomuXMRgEclTsHBszPSAMn+BPrlJUaOJIVWVaqV9X7?=
 =?us-ascii?Q?+gY3AABAVisvGa7KdOiKI6g5im85LrIsZwJU+0Oei3pfrJwZMb2NaqwHwm1v?=
 =?us-ascii?Q?S/59+rXIPMLa/xTRSe36Jh67jG7Nk8GSzB6LEs7VL7KuAtp530ms/u4ZHydF?=
 =?us-ascii?Q?49zO3hngrTZM2P8BV64kkwmmn857pCBBTseuXz7q64fBd86P5X9BxTs0+yJ3?=
 =?us-ascii?Q?ErdhNBVk8uykQDif9axwvE+i38NlY6EgRL1aLHS2IQUwV+gYUS60Y1UQTuYG?=
 =?us-ascii?Q?BuNkeuN8B745gTXbyxpBygmDQnGZHuY57GB2n8OUvY/HEVDgSOu6JTxX1niP?=
 =?us-ascii?Q?7h1Cl1sWUpUGaneLszM0iGobnmFF6GFzSDaViDOzjxnglR+EMhu92/Ui37VK?=
 =?us-ascii?Q?h+si3r5cDNn+lG8vgAgVkQw3R7My/D/WT2qrJOqSDJXdc/3Fc4F2pX+p4zVj?=
 =?us-ascii?Q?dcwAeVXERKp/02D1QpLhtK4wqOzXWa5LIcgevxWReeh4y64mS4Wxb435XawU?=
 =?us-ascii?Q?wf/lGiV75Vax5FitqnD/m/GsFmzDJ8MgvNAhj/wer287EzaAwnZ0att6oPmI?=
 =?us-ascii?Q?baaFRvLvh3Pl8T0ngnoCoI2dfwmNoUL3XHPv0j78qMymbldpdOXCw+8YBFlJ?=
 =?us-ascii?Q?1N7BxI9Llt59jH5JRpTfefw/tH1b/A4TcEnbqBOQjy2W4akmWiFCY1TXqIez?=
 =?us-ascii?Q?v1lNbU4aaMJO19hbKUYgAM/fVhy+XtIz+QMGq/gpmMchXtmhVFRlN7WDxzRU?=
 =?us-ascii?Q?apb/9L6X5Ch7xlGuG/vAwnLelX6cZ0gdhraC1KnzbT8EYxrFbFF8QPeTpFFs?=
 =?us-ascii?Q?arvigUUBgzVm5CGsq6S8MxhwB0pymr2LCDfteHiqyICpHr0qAnzwRJMfeepN?=
 =?us-ascii?Q?RkFrdZDx011d+lZblV/YNACpC9DiEjGB2jW4DdrUUWlDAU4JaJa0wJRcLJnM?=
 =?us-ascii?Q?tp72lDn36BpsknSmtH9a6UITt0RGnTfFpyAFOn3o7BTTDOSawhT7s6M/wIoX?=
 =?us-ascii?Q?ZKEerHPPRbT96IR1bq7NDOwQqR6fECtVEvps67+G3+rNYvd30OAKWudDi+VR?=
 =?us-ascii?Q?l/k0OO+W2cxgtmYUeth9HFypXXZtR1ohy81cUKxI45lJBFImZ49jcv67aBR+?=
 =?us-ascii?Q?c9Q+YszOXN2pgwAsxBokdFkRct3VQZYQWHNRSFzkxHu5gDmqbmw1ZlXLr1T0?=
 =?us-ascii?Q?w6uyWX0Iwi1AxMJTn2E4Mo1ub5qfedy/63Bmse7KBA9RKpnqv8aa7ZbZ4Kpt?=
 =?us-ascii?Q?D2NUpU5N6jmbF7ExoqHIzprKODHkCTWSsdhh5CBwZQJI6ZX24ZOuNu+RFphT?=
 =?us-ascii?Q?vDNTvApeev9Sn3Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k75OslCt7kpYXTXgjlGOEFUu1xJn4bMg2qAcD9uc6Qm9UJ+zjgl6MSX1i/ve?=
 =?us-ascii?Q?uPJzB/n2B+SNd9PTiuhj+/mXA9F5WdJJpl8OS19lWItlVbZXbSV1DUc2nJ9u?=
 =?us-ascii?Q?blOUfZpv3o/gxbiZDpHIcfPPBspVCq2XolZwCyQwor/pH23Lb8rfYxOtwxM1?=
 =?us-ascii?Q?QWEISILdKSJJ/4vfgw2jcKmnV5MZes8IlbFjyDHZ/xxWRaR2G1JaS38W+SOq?=
 =?us-ascii?Q?HfbdQLl3HdCHJoukbCzTJGUhLmMbKy12YnG7kXAAqMf0uQmbLCfKyZJAjSPa?=
 =?us-ascii?Q?5oXlqbzAvS1WM4X0HfcoiFUGHIHkNjmghtXD3D08K1+eKiahpBDB0sE3HkF3?=
 =?us-ascii?Q?WEmhITTy/O7StNOlRMOjP10QfWtvshCss57XSyAIl7/7YwRnnlpiiGj/RZSl?=
 =?us-ascii?Q?GuAd5DUaVDjuDW01nGL0onVIgVPeirefYXnauDuLUVOAwtJ2WKm8gOm4DEk0?=
 =?us-ascii?Q?8tH7WshYBGdosnuM0PX+rYxk39Q3EBRdj1OQu38QY5uF4+ftYy1YTXde0QuU?=
 =?us-ascii?Q?I6Qb+7AoyUkDp2tUaIOwF98T8tpSwdAwzrnUqQeTk6Lxv6JQo+wZf2Y2L/sF?=
 =?us-ascii?Q?E4eWsso+heQOvziWbvYBRdMNRTLDj7K7N/9CpKaW7k9FnFP+0hT+ld0M1GzX?=
 =?us-ascii?Q?3ZdJPrdUCmeq0PJGnW/qj0Lnw1OS00d+zU5rJaqNv0QQW1LoSyYtAWz7kzue?=
 =?us-ascii?Q?y2XBDL1uREw+X9rKzUa9OZ7v5TlbUTLlTCGrC9uyb7ZDlhG3jeRIvJgok1xO?=
 =?us-ascii?Q?PlbPgjeyng4cWMneKdbCdhj7I1kb1gKOrNKhj8szaTbDdqHrn9oovELhgN4+?=
 =?us-ascii?Q?KS8qpFnlg0sMXZihEhhuX2DzD9A5GuZn6QKbddkF7H4oPB1k06f/4VJ+CmZo?=
 =?us-ascii?Q?ogEciT4o2HuK+PZzlBQhdIMeHDM3uFEtpJOM895Pc9FRZeb/PTrV+BJwQ5MF?=
 =?us-ascii?Q?iuCSCjyck0GztiY8B4peE8PiHvIY+BPlqYX9wYdiTv/uL51Vf6THhIenboUY?=
 =?us-ascii?Q?0x4eSVgxa9/UyIB+IP93duj2e4MjJF59a6ub0oUI1aEJBVLsREInjbeHFvQt?=
 =?us-ascii?Q?PYTvZNsQVniNFu8W10MdL7mSKw/ZBsGlCu9rLwJlPjT1c+XJRvZXKG495DWP?=
 =?us-ascii?Q?jgmqWfIrkoVCpx5h6z0xm1ResOsCX7QVVD86uFcVciLyYhVMhlrxflxo1rgB?=
 =?us-ascii?Q?l0NackW3MBNgWJNAskrYzx0nkRxYTU/52mIY6EgSoyTmkmlltPSLTif4hJzL?=
 =?us-ascii?Q?6W2ufv5c0Q+/F/i0XwnWmlClQDUbx5Isphbjzpv3jfdZMiXbcHKjfNJn6ggf?=
 =?us-ascii?Q?s2Aspm5Oz4hzhdQQolkISbVYd3ZzEdJgJaCKkpPFFaefzjL7I8KIAhzxRZjn?=
 =?us-ascii?Q?rT/clSGIZtFQBmizzROQzNjoNjRockfNUshPyNQJtNu2XMwiHdQieQMRLJd7?=
 =?us-ascii?Q?xgmEVnO9V6FeV+fxiQcq2G4YkNjvRSMIMQhRvscSbTLcv+ET7gvNq9E7M+uD?=
 =?us-ascii?Q?BRTxCZawCXYMOeWRRqNheMMeq453F/wh6kzF/2sU0MFOkvYZ2RRC5y6woYvC?=
 =?us-ascii?Q?KERnYA8Xz2laDVpLnik31T+WNcNqGZL8BAo6VB60DxmfVhN8k6dWKR29uCtb?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 313e5e20-e400-44b3-3683-08ddde3ee89e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:33.1265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBLh/JgW23gOhZZXY4+1Dmi6W7X1mo+O+XyH3pYgdcM1gt53KZW6JrBKK4c52d6NZ/2GnpvqPf8CpqixtJGT4kuICDyRwGQM3TbK0f6SBUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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

Use spinand_to_nand() and spinand_to_mtd() helpers instead of
nanddev_to_mtd() and direct access to spinand structure fields.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3b612bec274..4e8d7444bd6 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -236,7 +236,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
@@ -294,7 +294,7 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *wdesc;
 	unsigned int nbytes, column = 0;
 	void *buf = spinand->databuf;
@@ -356,7 +356,7 @@ static int spinand_program_op(struct spinand_device *spinand,
 static int spinand_erase_op(struct spinand_device *spinand,
 			    const struct nand_pos *pos)
 {
-	struct nand_device *nand = &spinand->base;
+	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, pos);
 	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
 
-- 
2.50.1

