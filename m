Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBEECD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E57484659;
	Tue, 26 May 2026 08:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SVrQGES3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C5783EF9; Tue, 26 May 2026 08:29:44 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F2C083FF5
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt/6NRVgwfctmyQHosASObUWznZGtq1ll1ni/SaY7TbCFnICcRiEAstQ7dxvLd+0RvAJK5tFSLawxIgKGOov+qnB5bB6N8vBRvbcxDeNrW3bDlrvaa0nuxenE6LNDJYNGvgZl7u6O5wAODBi9e70tt/nLFLvZRfsrc7XGnMO930hhKBbxmAF/rYswusxrWyJsTEskR2PwU6fbrw///9Lqw2T5t99HMqogAEnZyXqfMjkbRbxwLbEze/tMMqPfOUmMLrh6PW3qhp9g+GnYa9UEgIUldGw0Et75RkloTN2Xuxp9XrlhhrtDyzoCiMvqzZ719gEiLsDK/5KU1/sm3IfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rKsn3iw6k+Tq8wjM70T5rKE/BRnN2EEZrP/Wiww7FA=;
 b=cJfjI8XTOnKw/o70z9L9GWviAq73zvLpSw3f09HCEI1co0scganKNR2NnXG+/IK9sPlQx/vEv3A+WpbIFuZh6aI/rB4tTg4IDUXIgD452onnI9/IqwTVlsb9faWrhYaKMwR+LNd53yokowIIuDmdmk0g5XDODS7LlAZPLD4zh9k6mVOqxIBrcnDM0XBONoiPFtRO3inIyr5QqhAJ3tXpP6+pR38RWQ/HkoYn3JLYnPad6IYjHcQQYwDWAmFzfI09KlsfenY7gvdLgmJxMGuuoV1VXoip9+KewA2aw563QoiURI82SYPel2gawo214pBJ8eBWlNVbzQRXhgWvnToV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rKsn3iw6k+Tq8wjM70T5rKE/BRnN2EEZrP/Wiww7FA=;
 b=SVrQGES3dgNknZ05u/US9vaDaYQ/px3NpikMcMvOI9Lf3148GVOdSniJmwvr1iRHwqJ4+owCiiXwNnsHRh6G/UA9WrPzsv0mHNGu2ZEILnVaFmhU+lcOErOfq2qWJIkW93e29BNICOvT+EwV7Hk1PxAADg0hEF5djMu+YkkYV0mU8XUA3vxUuL2PzH4AZFzWlePW68K4tar2w+QCzPuoDxiuYZQM8bBnxRMu+/IMshL0k+Ns4ZXyS7FZscWRUt7hP4vJMb+/6w3sXovqsxKNZAgpZM5t2uOQ10Cm9RR+b6HS9MWl80RT4mFEa8SpyroH0IEcjuqwy7scSxsGOWmj7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU4PR04MB10497.eurprd04.prod.outlook.com (2603:10a6:10:56d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:29:35 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:29:35 +0000
From: peng.fan@nxp.com
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] ata: mtk_ahci: Use dev_remap_addr_index() and ofnode API
Date: Tue, 26 May 2026 15:46:15 +0800
Message-ID: <20260526074616.2800003-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0188.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DU4PR04MB10497:EE_
X-MS-Office365-Filtering-Correlation-Id: 098a8049-9be4-4a47-cf7e-08debaf0277c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|19092799006|11063799006|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: Ueqc+98PEbYqi1QqA2WEHQhSrKJUDOKabtTkjJSirDjcDk20OZcH/iZPyzv54b9HixaJsiLPKVcCIrLBFHA/1uAdI6aWzrCE8M+0kl7nFE3Ic/KSLqOAfcOlkR2INwgrykeRn+sfCpObzBxy/jTt8bH58NvOu8qQJmf1Iz3p3XEaXRgOZ6qW2xmGA6nyYjDGY2oLNT1DCcs87gbLODOc2q2gyLAV4mYoIzUaZ5X62LOCijmL+XlULdAEL0oqkIRjcUpbSAFkTJaZ2Doxt2vdK2R5a4l80oyYBOHMX0c2TM9CTMzrll7WT97Z6bPsZMRHrKPLLfpkI8K4FyVzqNLI04RU5QbDtxbd5QzkH+MEIw7ZFxb0QB0OJnK3G++EQvaYdJ1f20AB81JQlH93B0iBezcYYMkgeMReec2nNEaTTvDL8bEeNAH/Z3p6eMd/NDehJcgyMPpKqwnrRwj5HB++k/2uaozB+HpCq6y3p4Z3385qgQtBdN60oDMd/RDP7a+//fxF3lhlzF1dHVr/SpuIvpFN6OFaaVrb3LQfTayTOUbmcaYRwHbXMJuD2IJOT5WwM4ozqfzBqEUbGJNInlQ2Yg5a3aVBYaq6NG2siWkJH6ADb44PiFA78NxI061MOcXtVyhKIxQJeE1kn3AJILC+EEKjnX98dbQhoxg7Ubf6IddIZ6dckcupA+cD83EDiJDlpRUGx5BG8qagSZWL+fXproPVuDGX4lkhdELnJYOyBXkVCH228uWbSBGVaYrq7PGx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(11063799006)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VxJtuPKStoPVpFpDGcr7ctWzIX+DV0GSjGdY83q627yJ7fmegn1uh5EA0f5E?=
 =?us-ascii?Q?fSL+cDbp1lNdoSZBOBkO3lfWOOUMjVqxKI+yxfTqw6WiGJNBa6vSLjrNUerV?=
 =?us-ascii?Q?gSCrhpbZKHrlV+fwIu6WaLJNvgKAViZAK5CaHK0f7pctjvHM4jFrakJrDFJU?=
 =?us-ascii?Q?w3ahjBJ23erGFtxixhTEJb3AnIPROLRXlbtn43ixX8Skjr2nM5jNR03SBO2H?=
 =?us-ascii?Q?Akc+lVDkEgksjvP7kuziYv8T2ZFOHiSAiCAm83kb5GCGPYrUlXz4/XEZZ1Jn?=
 =?us-ascii?Q?vuyoZrAuJlwGn9vIuw24igIrWlCkJ27oZakHH4vCG0hiLPRX0HdMYlOmxPpb?=
 =?us-ascii?Q?L0QpjB0p9MwCGG3y4sn5YWXvLxO/gR4oHoh95gYfrZkk+yzwmdrWps/km0G1?=
 =?us-ascii?Q?xI8xmsnWbS9rD39nmHBfSZrt9aCSu4KIMKjLCP4I0P0Cc6hrh4m0jQ8MSca6?=
 =?us-ascii?Q?d2MGTn81sg/v4dGwjDOK2N7ZuM9M/YlNhGnBlxeIbF+4Wid3iHGhuWfvV1Bj?=
 =?us-ascii?Q?TAhIkiGmV/ZAojkGvaIix98ypdgEGEPkkpBxUCobyhbxFWA7SGXvBTkc1lgJ?=
 =?us-ascii?Q?KkzXaGc9qVoobYs+84HVPLTicT2o4szmUR4Tx4B1d8wGxMvJwKwPLcUBKBTn?=
 =?us-ascii?Q?FcTq3YvAOuHaWtXUoRH7KufHTr38lezoEDKOyP7tZcO4xaYNGnKdkzjMD5Xi?=
 =?us-ascii?Q?ZjEJr19VczCwS+SsPadWzRgz8AIfIwR22RQnhADLTqrk5gsKFIOF2FkgXtE+?=
 =?us-ascii?Q?11Rmzgrhj7ZMNDko14ygPtS7prSXP7mjHT2CGLlGhwT3+LugPUYJdLmh+Fzu?=
 =?us-ascii?Q?1b6p8uI6uqN9lbBzlp5C8zLYlF70bfPbvW7Hj55PdW6Ey+7EZy1PQj58sk9u?=
 =?us-ascii?Q?QEYkm/dqjZ4XQmuwKyCIoDHLQ1u63MWwFrlmvSIn+lzVq6oejTV45HxSIeQU?=
 =?us-ascii?Q?J1GiqqZvLPXRY8hIEri9eFOlXb6vLpbL0rPII/gBQKAGhnXitktMi5h4o/NO?=
 =?us-ascii?Q?+NpI5d/qmfeQ7qwfG7k+tb5rBw8mmpduVWKyEGJXI+IhyrZo9jTzElfTV+Jk?=
 =?us-ascii?Q?s6u4UIjhuULFfehKhcipzK/37FA61OUdRzJJx86lNv0BIQZRasLS1JzVrV0I?=
 =?us-ascii?Q?1BR7VZUnxRBnt6U6j261WFFm5gksz7qD1IAyU+y4jXK7OA/0467ze9q/sh03?=
 =?us-ascii?Q?MFqSJnShHH7GlIKsQx/p6a2EBT/3dwpftoiVTUzgOxdEcDy4ey7RlJKTvDbs?=
 =?us-ascii?Q?/YzABgQlsNv/lIcSwp7uDv96PVnHVH3GR9WVsIwnc4QNl+ii6BMiAk+Zkm7s?=
 =?us-ascii?Q?tRNSUaCouDWHMMiInPze/YInPMUTDyGMAEj/VWBsQ0UbSaQdWgvRRz3WKens?=
 =?us-ascii?Q?UN5YHR5mkUH0x23PkDrnNuxzET3FIE6jfWM9xHGd5msu7EpHVPjS5CQgXyMO?=
 =?us-ascii?Q?3UirmOem/oRr7jDHkC3dquJ9FKTdP5RTwJFcUf1apNouoFR6rl15jqvpxbt5?=
 =?us-ascii?Q?nsKNAD48aWkiaZ5OB8do+uQWDoxoGM9UDVLrqwny+e3Y1RyEwwmATbtf/5je?=
 =?us-ascii?Q?sfzzVacyHV+D5/SSdSTYy0ttb6wyjphVAjh/YyWklE3gtCucIPz84xH1RYWw?=
 =?us-ascii?Q?UVraI1sr9ihJK9dIkgOsE0pMQusyw+q4vw6aQehH0y3tcbYH/Pozqz819ptT?=
 =?us-ascii?Q?6kbVJcfR7JJqiIG907pVbzB03vMeT9J0JvsHhXKdNYoAfhfwMzsEn/R8N+Uz?=
 =?us-ascii?Q?MjI8rMftPQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098a8049-9be4-4a47-cf7e-08debaf0277c
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:29:35.4167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4p68hYHVOfdRaecVoFoimn9a3uNcCmqhbMVo8er3uMuNTrSF4/WD5EC2HRopOvHGM7TiX7YffWWypmr0YvC4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10497
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

Use dev_remap_addr_index() instead of devfdt_remap_addr_index() to map the
controller registers, removing the dependency on FDT-specific helpers.

Replace the direct fdt_get_property() lookup combined with dev_of_offset()
by dev_read_prop().

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/ata/mtk_ahci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/mtk_ahci.c b/drivers/ata/mtk_ahci.c
index 53aabee0a5e..1d4245ee635 100644
--- a/drivers/ata/mtk_ahci.c
+++ b/drivers/ata/mtk_ahci.c
@@ -45,7 +45,9 @@ static int mtk_ahci_of_to_plat(struct udevice *dev)
 {
 	struct mtk_ahci_priv *priv = dev_get_priv(dev);
 
-	priv->base = devfdt_remap_addr_index(dev, 0);
+	priv->base = dev_remap_addr_index(dev, 0);
+	if (!priv->base)
+		return -EINVAL;
 
 	return 0;
 }
@@ -54,11 +56,9 @@ static int mtk_ahci_parse_property(struct ahci_uc_priv *hpriv,
 				   struct udevice *dev)
 {
 	struct mtk_ahci_priv *plat = dev_get_priv(dev);
-	const void *fdt = gd->fdt_blob;
 
 	/* enable SATA function if needed */
-	if (fdt_get_property(fdt, dev_of_offset(dev),
-			     "mediatek,phy-mode", NULL)) {
+	if (dev_read_prop(dev, "mediatek,phy-mode", NULL)) {
 		plat->mode = syscon_regmap_lookup_by_phandle(dev,
 						"mediatek,phy-mode");
 		if (IS_ERR(plat->mode)) {
@@ -69,8 +69,8 @@ static int mtk_ahci_parse_property(struct ahci_uc_priv *hpriv,
 				   SYS_CFG_SATA_MSK, SYS_CFG_SATA_EN);
 	}
 
-	ofnode_read_u32(dev_ofnode(dev), "ports-implemented",
-			&hpriv->port_map);
+	dev_read_u32(dev, "ports-implemented", &hpriv->port_map);
+
 	return 0;
 }
 
-- 
2.51.0

