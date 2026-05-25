Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFF7CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 723E4846AA;
	Mon, 25 May 2026 04:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="QjcknM1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C26D846BD; Mon, 25 May 2026 04:51:08 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6367E846A7
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoSmG50OtMwof2maOsOaCsnu5bPtqxTlfWadGNwS4/CkqnDPiPB3+ibShSXIXAqVqUF0pXIaMRgOFMtSp0mVLuicQWq7ThB6P1EiobDAZsi54XxT2NSi9fl/yXA/Wr/6r9ELlMha/rlidLp3CxNlOAL3dpEpniDu0VFvz5vDgmNWeX+t66W4XJvursjXKBzww8n8k/8RNfrmzbM8Or7pl8sqGKwJLJeKg6aVdMBI/uuP8rRgr2eyaXHtbxPBhCxDHdjyFG7wBZZ1JVRF/U//VR1MdD1z65T5gnJopCJPRqkg9phveZWqUbl94AmLIjPt6spQiRd3SMDAI+R1GV30kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk6S+8VqWgPyh6ClDycANMaQ/2TLCotn3yyE3wRtPe4=;
 b=N4bbs+lj34JKSjEk3bD9ZPGk1q/CJDHQ/y2wHbWPJXKGmq1xS7oqQTZIKKMAs6gTkNPOF4uJr2UBeXAeLdbZyiHRNEd0z0JVvRWFzfYZ2P22/Fw0ryWjZ6D8AlYGTz/H9ENwlFk9Cp24iNowms1pmjjcBjKdVWhqxH3QOK3YzO21gjhVU8t1BCWwmUxUhEXtaVLG/R/KIWdFJ4ntaUdjo4ZvMuwgTP2Q4/hnJhBUucYBriTIu6EprN+0dfwe9FXU0xeoBhkMOnGt8xWUL70ut4cZml76KNQR+Pz0tQJhPycUbdkwznD8B2pAhD9E+/kzCtRtXWJDuD5k5oisNPepdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk6S+8VqWgPyh6ClDycANMaQ/2TLCotn3yyE3wRtPe4=;
 b=QjcknM1T3UEAsOA9R2YBrZ/yKUo0BlLRrwCx49y4fQXunzTQdu8hDcipSD/VuAmocqyqNIVGM8kFtGS4f4ZYJ0Btt9O01lNAXKVe9t9kaxwoQSEcNC/sqxbSNCbzhW7WZVEPWquZ0TThkeB48FRoK8Uykwn6XOeSYj6waVEL0jZMgo23ppLdp8h8X0WQDyuD9FUMlz59XSy1GltSUZKRG20IJ7ZF6bumfR9C4t0TvpsRr86p8R6G1wKsg31I0j3RFLkOB72jlLH0Wu10L+xT5pP9gcRD6uuLN5/IxwgpOpB2oxM72i6V8GnQIHoCQfrcWCxg3Yuy45xCpySwyEAQ2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV1PR04MB10656.eurprd04.prod.outlook.com (2603:10a6:150:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 02:51:03 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:51:03 +0000
From: peng.fan@nxp.com
To: ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com,
 BMC-SW@aspeedtech.com, joel@jms.id.au
Cc: trini@konsulko.com,
	u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] ram: aspeed: Use dev_read_addr_x() API
Date: Mon, 25 May 2026 12:07:41 +0800
Message-ID: <20260525040741.2369146-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0239.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::15) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV1PR04MB10656:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a5bd33-913b-4e4a-bcc0-08deba0875e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|52116014|11063799006|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: vJTeKaP1SyuQv7o9nPUyZitvC9pE1K+utOk4S86FBi93EbZM+DLmPGHtFxniYc+Wwe8ozWVlbK16N3M+fSIVjTJNx10oO3xODBkPv/X5a+isVeHjD3Wup6oSx7XlDQD1thT0mQk0pJ/SDx8vV2pSud9Y6Ju5HvNWh6bAE637ShQji6T6ey9FvvblZ0wsoC+ey2K4T360aSGJcMFXqTFa8Gsmx49IK4VrMiPgqBUr3GdBHuutgxJ+gcC8njK8rS0RJZHBTv0pjo4jLdsMKUG5yk/uLQXAuaVn1XoAtyShXDNoUyoFM0U1VugrZ8oKEqY4henV0Is2N4kPLChp9dQwdAB2/nfB5wnSnPxm1oBS32DF9nQv0Qdlh1+fnCg3KkNZH3lpMv7oy7eYfjuxAMXL00p2NnpKgXZDCs1jCOFDRpymfRWp2jXvDxOhXiXx6gjp+V9D2IpATXK3clm9786dDqHuz29zTr6FffOD6KE1zv0DwlIBuRoMK01TOXaxE/ikk7XwiLYb9A4Fra/VBCA5X70m3idwSeP0B8qksOdvVJH+dAfXz2QlgKS0zlAbeacd7lAGGUwEN5kylLTRMHIAvBdbo0Q9qsHzt+bUBfrEcKzxjMQMa1z64uctNok3sa1cRhgkgYOgDesvF+q9mWPU85S5F28Sw/mcKcf43HriRCS65fMRBIHzNmv88ZDqGP0r0zkXgkRP78xLM9nukOAuW0DBDb6VQeTaAlRR40iKatQkcwHvxBfO9Lw5Pv3z4cuD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(11063799006)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CDIAHF0bp//kguW8ZzrM6seuZaWOoXu5pk0PRzkwIgWpXIqjzqDEfm2QC5f8?=
 =?us-ascii?Q?nVNYF5VFYeQYznb65ZEuQUDo3FBkGH3xoRscNA/QcinxI0U9B87CiOeD7dHD?=
 =?us-ascii?Q?3Jfu41KL5qTDO0ufsj1LCBjrldB6TRHCbXKxu85A4gRdMXUplgDjasV7FC+7?=
 =?us-ascii?Q?eeXAnc40ITK4c0RqNP+jBA8MFKbV2csKCP0MFyA2aLLZ6e+Eghnjpx1gR8KC?=
 =?us-ascii?Q?+9Ituaskq2Kpx8DcfXzFblVqYvduIdAAF4XVqnndTqFFEYrBC1L5C6RfZbr4?=
 =?us-ascii?Q?SF5hrCz1+rMQW7GFlGYa1aq5zxcmbtPtwHIDGdBODQZknFNNiYyFgQPAVt4j?=
 =?us-ascii?Q?5MY6YDUeGd7MBMgSgzysmPEeg7yP9dXttOGYX/CnfMaz39+Deg5Vhqvu8UtT?=
 =?us-ascii?Q?dFX73JiBw+QIWz5cl8tQklqFhWqTKK50i4Y95chTAR7vtedwH8L0nX7L+APi?=
 =?us-ascii?Q?zUTSJCUrjMOPqnfwYz8BJbDi8svH+DBBdhrXkxG4CcZAFOfXVH/rGQxttHkY?=
 =?us-ascii?Q?yUEqaCfEIgldheRYX4EPjTnIBv76jcQ/5k1p6ZJaKhZIPQz9QYazy87SvbnJ?=
 =?us-ascii?Q?TVoixvoTX4ElnKMb0p3cUc6yXnAiaTzhG1Vfzbgsp9JqRkB1lCDojl5MwXWr?=
 =?us-ascii?Q?ZmWYn6KbRzl5xPA8yxOF2gfcY/b+jS+hMgruoQAeJHE7vdByx5Mvpu73Q6pa?=
 =?us-ascii?Q?WxEHcu3ML71EGFGgs44vsl7TNtgv5Arzdw/XNwzAArlYD69A902g2+JC8d69?=
 =?us-ascii?Q?qeN5zUM1mie8sNZAvuFUgv1p/fyogfLKbeu7Q21sNgtZb9hisSx3RQkJT83r?=
 =?us-ascii?Q?rmdeIKICLCl2+3mzLKUSU83ZWTWW8zf26qQLwltuVZPdQhD0hdzo39HIwJ8k?=
 =?us-ascii?Q?moESJwXCEjakgWJdSHgwAZE0uGHz1/MtUh26rEUIG7WyuUN78ZeN8MzOkcgl?=
 =?us-ascii?Q?zwc7vRmmF30O2LwIV73Kqb+rbpUebRCl3EBsKFySPKYy1seniDsX1HreCIxj?=
 =?us-ascii?Q?gwzXeaYHfz8ZQxRwvEIwj1uVcttGqns9axD95nCPZH7pH3Q3mL+KccwcE33j?=
 =?us-ascii?Q?3IUbdobgKxeQ+LeiGl5e16VeRUkxERGcSEc1N5YgEj2eTSqFw33vXA4ZlZfm?=
 =?us-ascii?Q?snxMct+Jx9K7Tv37nfPN3u5+uMnY6BxU4VnJ2YjiQ9MTTm2Pl2IltULRQMj9?=
 =?us-ascii?Q?jjkucoY/xwRwYsD3JVR06xFL24fA/O3z6zomgeXTHhqfQGQGuxkzl1n308dg?=
 =?us-ascii?Q?HmCGrTjSMjxtnMMRvL3/jCfviwBkFfb6HJkAfvTvbwgldJqjMq6y+fyn6ZPM?=
 =?us-ascii?Q?pt9vSL4nQ0sS7eHOFM5pL9f8rX3nBSX3yZHiF6gLIiO6WzehNMCF4Z9ymLrK?=
 =?us-ascii?Q?eBe8nzRPlqk5L6HP0f9rV1BwZ3jw2bSui9qXYwHJWP3VAmuVuQCbb44BXN4D?=
 =?us-ascii?Q?E0oOZwvqA8uxgZaSqCkpci/HDL3hYKIOiChZytiuSSdOgIspobTOdMtKmtX3?=
 =?us-ascii?Q?FKsaaUH/MUAmw1R6gPFMCXzQ7zXOS9lPBg94iQI80azu+JnFrAhOUpJw8IFm?=
 =?us-ascii?Q?qduM2UTtdwiJC7ntdlknn8jXe+qpR2XfW5XyfHBi/+vSR0e2ZhLC2Yf4SMVo?=
 =?us-ascii?Q?rD723THAndzHO5lwehPREFAH8zbIpdy+pX+guI+/Swkx7ar1hSbzGFVQL8zg?=
 =?us-ascii?Q?i5B3wfw/YEi+gPeXeRuVHMqIzuPFvLiDTf/eOVOH0a5Yr8m7mCPFG3/rTS93?=
 =?us-ascii?Q?LbwiV9drmQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a5bd33-913b-4e4a-bcc0-08deba0875e3
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:51:03.5184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NH50OEgdJYxNRgCTfnc1E3wmDA8AZwhkkqZMwkG6VkHuzImRgi8OxgZyVs88DtP0/cWXWcBcfHyTuisJF1Tevw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10656
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

Use dev_read_addr_ptr() and dev_read_addr_index_ptr() which support both
live device tree and flat DT backends, avoiding direct dependency on
devfdt_* helpers.

While at here, also use ofnode_read_s32_default() to replace
fdtdec_get_int().

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/ram/aspeed/sdram_ast2600.c | 15 +++++++--------
 drivers/ram/aspeed/sdram_ast2700.c |  4 ++--
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/ram/aspeed/sdram_ast2600.c b/drivers/ram/aspeed/sdram_ast2600.c
index 55e80fba3dc..2cf9296468d 100644
--- a/drivers/ram/aspeed/sdram_ast2600.c
+++ b/drivers/ram/aspeed/sdram_ast2600.c
@@ -1076,10 +1076,10 @@ static int ast2600_sdrammc_probe(struct udevice *dev)
 		return ret;
 	}
 
-	priv->scu = devfdt_get_addr_ptr(clk_dev);
-	if (IS_ERR(priv->scu)) {
+	priv->scu = dev_read_addr_ptr(clk_dev);
+	if (!priv->scu) {
 		debug("%s(): can't get SCU\n", __func__);
-		return PTR_ERR(priv->scu);
+		return -ENODEV;
 	}
 
 	if (readl(&priv->scu->dram_hdshk) & SCU_DRAM_HDSHK_RDY) {
@@ -1136,12 +1136,11 @@ static int ast2600_sdrammc_of_to_plat(struct udevice *dev)
 {
 	struct dram_info *priv = dev_get_priv(dev);
 
-	priv->regs = (void *)(uintptr_t)devfdt_get_addr_index(dev, 0);
-	priv->phy_setting = (void *)(uintptr_t)devfdt_get_addr_index(dev, 1);
-	priv->phy_status = (void *)(uintptr_t)devfdt_get_addr_index(dev, 2);
+	priv->regs = (void *)(uintptr_t)dev_read_addr_index(dev, 0);
+	priv->phy_setting = (void *)(uintptr_t)dev_read_addr_index(dev, 1);
+	priv->phy_status = (void *)(uintptr_t)dev_read_addr_index(dev, 2);
 
-	priv->clock_rate = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
-					  "clock-frequency", 0);
+	priv->clock_rate = ofnode_read_s32_default(dev_ofnode(dev), "clock-frequency", 0);
 	if (!priv->clock_rate) {
 		debug("DDR Clock Rate not defined\n");
 		return -EINVAL;
diff --git a/drivers/ram/aspeed/sdram_ast2700.c b/drivers/ram/aspeed/sdram_ast2700.c
index 4a019c4edb1..00974da52bb 100644
--- a/drivers/ram/aspeed/sdram_ast2700.c
+++ b/drivers/ram/aspeed/sdram_ast2700.c
@@ -956,13 +956,13 @@ static int ast2700_sdrammc_of_to_plat(struct udevice *dev)
 	ofnode node;
 	int rc;
 
-	sdrammc->regs = (struct sdrammc_regs *)devfdt_get_addr_index(dev, 0);
+	sdrammc->regs = (struct sdrammc_regs *)dev_read_addr_index(dev, 0);
 	if (sdrammc->regs == (void *)FDT_ADDR_T_NONE) {
 		debug("cannot map DRAM register\n");
 		return -ENODEV;
 	}
 
-	sdrammc->phy = (void *)devfdt_get_addr_index(dev, 1);
+	sdrammc->phy = (void *)dev_read_addr_index(dev, 1);
 	if (sdrammc->phy == (void *)FDT_ADDR_T_NONE) {
 		debug("cannot map PHY memory\n");
 		return -ENODEV;
-- 
2.51.0

