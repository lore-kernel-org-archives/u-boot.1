Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978DDCD37BE
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 03:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D18C98341A;
	Tue, 12 May 2026 05:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gutK2rff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E498394E; Tue, 12 May 2026 05:47:24 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B40983015
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 05:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSY53D88sKGTZ5Fw89qZsQ1xW7OEcalO5F07yntZ2HvOOzjXU27lDhAfcVSado9JLA3d41iXQFAgvAgBhTYgXIkJaykYleBJemMrsDNv1VtXCVu8/92IZov3ulCkqL88Zya9quybrseW8LMYvR2R9mZcYvCVu3vq5Xp3vLCOXReir7C8PbMr+MfgMOBOyd3/GQFXNFtlwAyUk5Vqkeswfh8FFgREBF69KPkyEI5ky9REuVnAwvQnNZ9CwmnmFWq3cMIMCfDP7FoY0I1+ZTlrgT4Ih6GQo61GWX7WXCkTPrykXHpd4ylDhyHdbtRSyKexLio0ZAxoLKK5kcfSYHOyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acDha3oeDga7sr2nLBUYJikagix6JiTBci6n2l7C8C4=;
 b=qLV5h3WOqJCBiNnsBv3YJPTFeXJN9dbQg7qeX9LJcht5W6GBrQJNvHBQp0xPw+MrnRGw3VdIBRJw+BiWd0/qIFJEKVDxzfsjG0K3UZ777axo/1iSc9+a4Mi6ihYQw8sVyaa+78vic6naBbh4h+HVtZCt91L1/C+DUllDT6svyuV+p46J6g+vZb4MBK9Q1pyMmtgUJuw8haIHmzMPpX2SCVCrO5V7B5Gai8foPD+L4ojsLjIc2BH5uU4VYZ+DKGLdSPHv3QPrqvDRdl6hVv2EysTKeHun7lnOUVl9/mRm/7MbruyhrUA3PUMFVprxQRHz8RMCVnQfFen19O6zyRggsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acDha3oeDga7sr2nLBUYJikagix6JiTBci6n2l7C8C4=;
 b=gutK2rffM1eTmkl4GSdqZqy9qvSJvOP7qVSjQ4ZPUH3pqvibrlc+HjTVj8uIam+p7rgVX8fdXb79ypA6Ys2PgjdxcQThQZ1J1jX8kcxJ14DZz0KID7m2EiknJhtjR8GG8zPLcCx0haycz6TujLKalHuYRXdDlenML+l8EHYyk/tLjLinIK+Hvj/64P+k3G2q4q08jkIZLqeSTrj3qTLtGIa/ErpjgJRE+XxdXOC73nMBnNeY6jqPmz2JqsqqiSS3jrO8Zs035n4iVDVKsh5pBB+h/yvg5Z3OUgi9QGt5yVgB63T1mj2kB9DwoXdjQec8RS6CtSgGgD+IlJwWpABFvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8290.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 03:47:16 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 03:47:16 +0000
From: alice.guo@oss.nxp.com
To: jerome.forissier@arm.com,
	trini@konsulko.com,
	u-boot@lists.denx.de
Cc: ye.li@nxp.com,
	tharvey@gateworks.com,
	peng.fan@nxp.com
Subject: [PATCH RESEND v3] net: fsl_enetc: Add support for i.MX952
Date: Tue, 12 May 2026 11:49:46 +0800
Message-Id: <20260512034946.1174617-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a67875-f2be-4b54-f922-08deafd928b2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|366016|56012099003|11063799003|18002099003|3023799003|38350700014;
X-Microsoft-Antispam-Message-Info: fLnL2S7uLLwlF+0p2UDNXzcdhPl2NQcwR57i78E8ymnVlbQ2URepXmR7NF5cwelj/r1Uem6Dar5mE0LLZLVNKrb04fyODlAAu7z/TTqJKkRZNP7RXAd/YvUB1FpxIeltdY2KBXwPObqPRL1/LE8ubpZY+KagsHxqFLI1rx5j7HLix1f86oI4RwezlTwR1JVmgDmCUkQOWFBQ3Gq9FlClaRsJncWsRD/kFQxysYldgYToztJdB50mT1Ydnok49VyhdM5QqmIN54EuXG5f2RBx1HidJ5azM+qyi14DEZFodgW3te6oFOFPNgAp4vgO3P5p71aV88pv22fcGy+WX7r746rzJhC4FfAFJ4xpHeQZ0NFiX8oLVAAsqOBwMx9Ijh89n+AdfcMb5EeLN6aVsMcmhw7XJ4jeSv+eLckBFPNm5nqTIuMyx0Ni/Pk5ig7THqVKQWM0nYZ+gY7eUDeKCdaMnI3oFBaT8NxKxkr96bjBqlwznoeswtlr24UGW68o/pLWJCXzgiS/L/VXegnnXUV97ngwgLkHlDtG79iLc8fPgXYlSiLXHaJBAo/WJPT4U1/KW0qyilcv+xfqUUFINq19GfsXRqoy5RwANKVtXFN03Tc+F83UBl8nuHOa7vZ/A+ojXJhqiVxTUWLgP5r8JxKrskXo1e2lzqM7VyEheKXjvrxMerk3BhKSjBEcbCZhaW/KD4Vi9qca9Y+xyA3fEIv9alpGo7L2vOxc7mMmnV32t3TiEgFYm3sqa9NYh1lVkq0A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(56012099003)(11063799003)(18002099003)(3023799003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Q9yzME7XOT2bmV96nGQVlrry1+myOtf2gjQ4+W7rRNVKkBu2Ui17gjsty0S?=
 =?us-ascii?Q?JSlq70pHndrIut43pLIhePOysnsp7a8YuiQQnrSXAuiTYmGJ8fzgEQwfP3Tz?=
 =?us-ascii?Q?mVsxEMZtCSjH//lriVeaioXWi03RmOPCNdLjUlNVl6o3fkeTuEWKo+slwSmz?=
 =?us-ascii?Q?6a/iEkoluE2tbqsB6tkA7Rx+GfnHqh80PspNN9svCY4QvDWxklWF4pxgBbmF?=
 =?us-ascii?Q?LaqNWayCsrS2kQVijOyDqgfdiVgUqeXCswnTS12qVdzKSoFH/HXUaU49z8cE?=
 =?us-ascii?Q?k4aNAjK3l5lIvXKAnkHLHfQyVTU2GGzHI911rgNhv9FSYb4WliYB4o9sXpTV?=
 =?us-ascii?Q?ZXRrScOiAKrpwwBikGdiunB3HQtChc7sZ7BN7HDlOUhYBT5ihtaGOjtIhyHO?=
 =?us-ascii?Q?br+oclqzduJLqkz0Bu4ZDXcNrF5UHVU4v4V86MuG1l1Z2gyPea1Ykyv3H0bW?=
 =?us-ascii?Q?fypwmMoaT5Ux/o/klvFVdA/ZH9iqJPalgBjOIb632IdLyiJ0QNYHSOLvv6Ss?=
 =?us-ascii?Q?C4c+JS1DraMFOzr5WlBCcwVTMhMIdFHlysxWZHyBaLm/H1xUKNu4Sts2uRuP?=
 =?us-ascii?Q?Th8c3gID0/qP+c2831cHHlI9LgALl9RyO+Z+rFp+S494+hJyifhp6VYSVh+e?=
 =?us-ascii?Q?740+xvFVagcb4zXt7kmkr1FrewozZKKqISx0RBvGJVoZRXAb/suX4MTY8gJ6?=
 =?us-ascii?Q?jxPtdP2EA/PaO2ly1io7eFbA+6Takg1hqNzhlVifSPCds32gUZt7IwyiP289?=
 =?us-ascii?Q?96qaZPk08hShbJBwbPWOazhSXsaZnusS5hdmAwYu0sDNL35hhzLr3Xccra1h?=
 =?us-ascii?Q?HLbfxCJ4ENxbkm1LxsV9Ex8EZ7D5JRKD248igXfAFH6tJd/9ipoF2KW2LHuX?=
 =?us-ascii?Q?HYM7+UEz8G9aJpRDYxFSYHbXEn9RoIaruLaMibiPu1Ik0iU7YMsp08OJIbiw?=
 =?us-ascii?Q?ASYZ6o1CuAaO5Zwp5HXI5mxPkYX9T7dllkJCm5xruMHHZX1jx5qP1OvTjv/i?=
 =?us-ascii?Q?y28dw5y6fBjrXCpTrrUHC0NmjcbeILAtUvCCopewl+yx0iqxeKVJiFaN9FHo?=
 =?us-ascii?Q?lFdtTN083pQS1hDTI6Qp7jkNmaGbMbPOJBkHvd4ZKgElWvEmPh+F02+gNMyr?=
 =?us-ascii?Q?hlL0FckJNleF3NAFPOY/jrbmgdaAV2dr86MN2eLWHw5yFB3o6+rVhyIdDVRP?=
 =?us-ascii?Q?tCrRuTu8FaVucmLkaihARr8pvO1KTu+ZdAF8r+kQilBThk0ehPsZvk4o99Yf?=
 =?us-ascii?Q?7exuQvOAsv5ARCLNb3Bjgg64y+lZR01rEUhz8UEU7UwtkuHEJXUHGvHLpg/5?=
 =?us-ascii?Q?puz+3LtQBRAxRsGz29AGQ91FT3hfekZFz5iKtsVldK3Sm1yTZMZFAQe8O2oN?=
 =?us-ascii?Q?tWrKkmKa1YaIZ2PiDVjGSUtDxJuGGgMOdYhuSx0lYhpNgNiaETBzJXOw/uOn?=
 =?us-ascii?Q?bxaFaV6kYTbS4yiYVK1YyeApPrSAkoDPoVZzGYBOAriYgOmWQuZd9j7LgyEm?=
 =?us-ascii?Q?7MjU2jWq0JmuPWH5N3MR/VmLsjzmrCUlOJYRugOfD3wvDD6qRdiEP4axIqn2?=
 =?us-ascii?Q?45WyQMqIE097+qP2xa2sTI1XEQAa41a8zbXGepefKwIW7afjkpS41pfcY9GB?=
 =?us-ascii?Q?HmFjfRBUcPTTEoJWIZ1lPSPYHI/f8TJlrGdsPxXG871PboZ+lVBaAnsYMtMd?=
 =?us-ascii?Q?nIIYyG+Arkp3C5eFZf0Z90IzJ/etzVco2AsS+RyXQeAgNFGBPX+YwPhQs1FS?=
 =?us-ascii?Q?RzZ4TLlrDw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a67875-f2be-4b54-f922-08deafd928b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 03:47:16.1104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXBoVotFagFOt2fJj/koJ/H8s2nd+IWrEm5Yu3MtqOxZhrHjI+TbzUcgPejM2EiVvsSUNaiuMpL5Q1zLV9dYFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8290
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

From: Ye Li <ye.li@nxp.com>

Extend ENETC driver to support i.MX952 platform where 2 ENETC
controllers are located on different PCIe buses.

Key changes:
- Add enetc_dev_id_imx() to derive device ID from device tree "reg"
  property for i.MX952, mapping bus_devfn values 0x0 and 0x100 to device
  IDs 0 and 1 respectively
- Implement imx952_netcmix_init() to configure MII protocol and PCS
  settings based on PHY mode parsed from device tree
- Add i.MX952 to FSL_ENETC_NETC_BLK_CTRL Kconfig dependencies

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/Kconfig                   |  4 +-
 drivers/net/fsl_enetc.c               | 28 ++++++++++-
 drivers/net/fsl_enetc_netc_blk_ctrl.c | 72 +++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 666618681df..f2e838b84de 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1018,8 +1018,8 @@ config FSL_ENETC
 config FSL_ENETC_NETC_BLK_CTRL
 	bool "NXP ENETC NETC blocks control driver"
 	depends on FSL_ENETC
-	depends on IMX95 || IMX94
-	default y if IMX95 || IMX94
+	depends on IMX95 || IMX94 || IMX952
+	default y if IMX95 || IMX94 || IMX952
 	help
 	  This driver configures Integrated Endpoint Register Block (IERB) and
 	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index b07193e4e83..f393af40e27 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -75,10 +75,36 @@ static int enetc_is_ls1028a(struct udevice *dev)
 	       pplat->vendor == PCI_VENDOR_ID_FREESCALE;
 }
 
+static int enetc_dev_id_imx(struct udevice *dev)
+{
+	if (IS_ENABLED(CONFIG_IMX952)) {
+		int bus_devfn;
+		u32 reg[5];
+		int error;
+
+		error = dev_read_u32_array(dev, "reg", reg, ARRAY_SIZE(reg));
+		if (error)
+			return error;
+
+		bus_devfn = (reg[0] >> 8) & 0xffff;
+
+		switch (bus_devfn) {
+		case 0:
+			return 0;
+		case 0x100:
+			return 1;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return PCI_DEV(pci_get_devfn(dev)) >> 3;
+}
+
 static int enetc_dev_id(struct udevice *dev)
 {
 	if (enetc_is_imx95(dev))
-		return PCI_DEV(pci_get_devfn(dev)) >> 3;
+		return enetc_dev_id_imx(dev);
 	if (enetc_is_ls1028a(dev))
 		return PCI_FUNC(pci_get_devfn(dev));
 
diff --git a/drivers/net/fsl_enetc_netc_blk_ctrl.c b/drivers/net/fsl_enetc_netc_blk_ctrl.c
index 8577bb75632..0c87d80ea5c 100644
--- a/drivers/net/fsl_enetc_netc_blk_ctrl.c
+++ b/drivers/net/fsl_enetc_netc_blk_ctrl.c
@@ -35,6 +35,7 @@
 #define  MII_PROT_RGMII			0x2
 #define  MII_PROT_SERIAL		0x3
 #define  MII_PROT(port, prot)		(((prot) & 0xf) << ((port) << 2))
+#define  MII_PROT_GET(reg, port)	(((reg) >> ((port) << 2)) & 0xf)
 
 #define IMX95_CFG_LINK_PCS_PROT(a)	(0x8 + (a) * 4)
 #define PCS_PROT_1G_SGMII		BIT(0)
@@ -97,6 +98,9 @@
 #define IMX94_TIMER1_ID			1
 #define IMX94_TIMER2_ID			2
 
+#define IMX952_ENETC0_BUS_DEVFN		0x0
+#define IMX952_ENETC1_BUS_DEVFN		0x100
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -567,6 +571,69 @@ static int netc_prb_check_error(struct netc_blk_ctrl *priv)
 	return 0;
 }
 
+static int imx952_netcmix_init(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	ofnode child, gchild;
+	phy_interface_t interface;
+	int bus_devfn, mii_proto;
+	u32 val;
+
+	/* Default setting */
+	val = MII_PROT(0, MII_PROT_RGMII) | MII_PROT(1, MII_PROT_RGMII);
+
+	/* Update the link MII protocol through parsing phy-mode */
+	dev_for_each_subnode(child, dev) {
+		if (!ofnode_is_enabled(child))
+			continue;
+
+		ofnode_for_each_subnode(gchild, child) {
+			if (!ofnode_is_enabled(gchild))
+				continue;
+
+			if (!ofnode_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
+			if (bus_devfn < 0)
+				return -EINVAL;
+
+			interface = ofnode_read_phy_mode(gchild);
+			if (interface == -1)
+				continue;
+
+			mii_proto = netc_get_link_mii_protocol(interface);
+			if (mii_proto < 0)
+				return -EINVAL;
+
+			switch (bus_devfn) {
+			case IMX952_ENETC0_BUS_DEVFN:
+				val &= ~CFG_LINK_MII_PORT_0;
+				val |= FIELD_PREP(CFG_LINK_MII_PORT_0, mii_proto);
+				break;
+			case IMX952_ENETC1_BUS_DEVFN:
+				val &= ~CFG_LINK_MII_PORT_1;
+				val |= FIELD_PREP(CFG_LINK_MII_PORT_1, mii_proto);
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (MII_PROT_GET(val, 1) == MII_PROT_SERIAL) {
+		/* Configure Link I/O variant */
+		netc_reg_write(priv->netcmix, IMX95_CFG_LINK_IO_VAR,
+			       IO_VAR(1, IO_VAR_16FF_16G_SERDES));
+		/* Configure Link 2 PCS protocol */
+		netc_reg_write(priv->netcmix, IMX95_CFG_LINK_PCS_PROT(1),
+			       PCS_PROT_2500M_SGMII);
+	}
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_MII_PROT, val);
+
+	return 0;
+}
+
 static const struct netc_devinfo imx95_devinfo = {
 	.netcmix_init = imx95_netcmix_init,
 	.ierb_init = imx95_ierb_init,
@@ -578,9 +645,14 @@ static const struct netc_devinfo imx94_devinfo = {
 	.xpcs_port_init = imx94_netc_xpcs_port_init,
 };
 
+static const struct netc_devinfo imx952_devinfo = {
+	.netcmix_init = imx952_netcmix_init,
+};
+
 static const struct udevice_id netc_blk_ctrl_match[] = {
 	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = (ulong)&imx95_devinfo },
 	{ .compatible = "nxp,imx94-netc-blk-ctrl", .data = (ulong)&imx94_devinfo },
+	{ .compatible = "nxp,imx952-netc-blk-ctrl", .data = (ulong)&imx952_devinfo },
 	{},
 };
 
-- 
2.34.1

