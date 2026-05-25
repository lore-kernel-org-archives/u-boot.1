Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA070CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 03:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3147D846C0;
	Mon, 25 May 2026 05:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="YxKHhLLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81009846EB; Mon, 25 May 2026 05:07:31 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A249B846AA
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 05:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZu2kRUIRjivWclGAE1GzQPqKie6CwxwwZtBZfUiAhEa2h4J9oXneMbTletsRMeiso8zyy0mHcigI5UiN/Li3Hfh1steqmVsjq5lc6jEX8MtxQJbaQu7c8akAfZgKBcPia0yxR3JLRIysuOWBWfMf+lEpwFhKVMcKVbhb7Q3mmF+qmUcknLiAoS2t09lcBvTpQP3fY63dJBxipctiHQgg5N1EzuALn3Hgvq7YlLDwrMZczCaQR3/YwSavwKl80GfixDTXde6dDAayFv3lxVBCSwMr8Xc1J2J5cnIaM/+ZhXOZ+G/Wk4J3WF/lYsojZwBx7OvuQOA5VF17Q/qsfRPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOV/axQmJ339dC57N7O0OeAXPjjnYYoVPbOfb5QUdz0=;
 b=FKw3AZenk5LqrN3Lpug3EWmjBPqul2U8qwGqk2VSpQ7l9uYwxT7Ki1AJajNkFfo3L2sRalwKZ5kBTRGm908LbMp67ibIpP7zHZqzadxRv/DiHPF84w3ced3RKKLjWN4DlgicQFTl4BFediWvZFITKipS1XqqVkMkgJaJmHxJCPWmtsZy4Ds+YmXw1axqKZSb+R50G0L9IBxCAvRJLrOQnbtuBJs3QfowMI/YRh4Cx+BwmZTjVSHfX44AH1HnO9TpwLKb7Rtiz63Hn6zhqB6yARDGcPe6bvzqoWTaJ21/yvEoNuiSX1xTc3TlXW1J1ZT1Ls5LlhQUuU0Ku27VDYNf6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOV/axQmJ339dC57N7O0OeAXPjjnYYoVPbOfb5QUdz0=;
 b=YxKHhLLNVEHbW3RHvQD9FFzC0usWhnoOqMe9t4yNFJmolEYXOpg9AOCykmxOJoEreztXpJCCGXlaJkYm15CLiAcYOkBsGKgbivmiekPY2X+WPaiC6dNs2hEgtM1kikmO2dLD2CaZmClEVtysbnMVMOhuySopRU0APOLoTXb879WOv+g+4zIozbiGJ4qOYV+0N4FLi+KNUQ9rCu7/R2J8xJE6Btr1ZJjfvKmZlx0ypExfAGxsaY5PY5+r94MW4sJPzKrdZNeTHSCVYip+s6KIHXqsgcJLNbCa5Jc1kenk938/g5ahY5qPicBPKB+X6lW0MCJi8zuQDAMoFCiojytZwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB10829.eurprd04.prod.outlook.com (2603:10a6:800:26b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 03:07:26 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 03:07:26 +0000
From: peng.fan@nxp.com
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] remoteproc: ipu: Use dev_read_addr_x()
Date: Mon, 25 May 2026 12:24:04 +0800
Message-ID: <20260525042404.2372280-2-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525042404.2372280-1-peng.fan@nxp.com>
References: <20260525042404.2372280-1-peng.fan@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::7) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB10829:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e8cd6a-7a0f-4b33-850d-08deba0abfe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: el/5S0KYepJ83JknH/NR4vCCuhuBJVO0yZ+estn0vsyPtYXq9pl6X1v9ao1HOB7MNbW3yOcWJ8ZF1/NLBLrR2AbZ00zCzBegFhFIN/mphKGTjjEtc4IphCufzskbFxYNUhGyuHWOMnyYjtlvGNkiFBMQ5MaXlu3h2/glxYkcNaKWoYyzvEjXusojcZn459KBwdwL/IMUUnA2fs1PhC1ir11FJeOnMRzUNqrx1O2ol5WABR7PsRk6dlRuUiBSlAjbhP/lVtc5F5VnbBegsOc9lvd9JENGZWKSpdmCczfp1vhSe5l8UYDay+OZ0ATw6O3t63tscpx6DbQyqxj9fZ4IS+RG8t7nAFEjRpwFsqUVIfygKJYpq9QVy178WiOP6pZ0MAP4TMmBHDopHs6r8KHL5kFVfRizVh8k31htYLVAs2L20JRfolfiq+jaW5WP9Y71D4Q1OpbI5K4llCrAzMeoRx3aMM6ODGGrG2USjB1jdbjQcWT2XMkq9Sa+yTvcbwtTyz6ewurEs7QBix0eXg2GHJkPQllLMj5CMQFFa0iv96D+DiooPNNI3LCntJNUoh1/KqTMHFPK85Bwl8P8+faNg21WCWm3L33C8un+tJWXgz5PwPCl+71KW7wwnDGeGyXV09rVqL7R2rIva55f5UeJM/5mI6G9VTX8aqAsgshJ5HMElx+m53OVmh38eclzzHWgLu0kygMKr0xur63+NrKQA/hV2H00zx92RnvEsiyYh3+O2eceEvfXjN4TbBBdbCIm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zRF5PYGR4ArHJLc4r3uTdqprbHcc6cRlzyU1Zb188IdRQlUGiINLMA3RvPLz?=
 =?us-ascii?Q?RRB510Cml2d3F5FpHh7p5o5ja7/KB6oVXFd1zjbFzDydxDsATH1mvYdwTnax?=
 =?us-ascii?Q?UGN+dMOUtOti7yWYGfpPvZWQ36KAT2Hmd9Bwv/pfW4XGffPur3duYI30MAFM?=
 =?us-ascii?Q?E7mLsGQf70ggsn0RmUJ6BUxW3a0chRXnLWwTxyeVTlnwJeBmbPVQsOI14Dij?=
 =?us-ascii?Q?spFs2GZzljVyVrraC1ZeXx8vqZ0MUzQeke+46dHwpxXWLM3Yp0Rsn+Tzjf1Y?=
 =?us-ascii?Q?vS+lznIRukuhxVkSKFyBy9qfBV4CVgIveicjuHJeg+eAQNmQqBf1oTY6EZ/q?=
 =?us-ascii?Q?H3pMfoSSokR9aBxO//Ea/CtrqOdTzZM4A2RWzFX0iPBnhnSLppF2Z45QdeM7?=
 =?us-ascii?Q?jbnxTBac7GuTlVkYg/eq/ux2Qdr5L7Tk62cqxumyGlZHWG42PzNK0Yt/PNRl?=
 =?us-ascii?Q?oUXkvAlSgRXERfZbANpvRNB6KZ4YdMq0Jq+RVKbaWgpfM8nOIiGD1c3pmfoX?=
 =?us-ascii?Q?mk2NpCN28TTS3myvwmxefndQCn+mDZ7S0POR/EhYmFjpAEK79ns/Nm/1Akuv?=
 =?us-ascii?Q?misZcqgIa7tQkf0gXlIjADnvdRLzGq3VXmdghEqddOecqt7FZ27F/ac4XS3i?=
 =?us-ascii?Q?QMRBIUKhRD9fKnovChk41iI1bBfzqwspNBTPzY/wW2tf8Fi2gb6KkKC5YKus?=
 =?us-ascii?Q?OZGnj0o3Gs0pe4ZBucfwrPelLxxV5DFKnorytgYuyl3XmhQj+f3frBcYXBmI?=
 =?us-ascii?Q?PLI53MSh/QiyMTFD4jAE/onDaRKSyG0YJfWKEEII3znKSDvWqHQh7xc75A3a?=
 =?us-ascii?Q?hYF+8k4fFQQNWGYZG/7uUx2zhrCor7VFHKPDO5yPlEGYi9D4LzRwlPMxs1Ux?=
 =?us-ascii?Q?1CYnAmPJcPBeW049J8a/8Eydm1NmNyRlRuYaIbQzzECFickvayNA1AWTRYFq?=
 =?us-ascii?Q?5RaTwepdSXNFsooU6WgABBe2EK5E9Ft9v2rMTfrh0OPASuGXsubeTqFV+WB0?=
 =?us-ascii?Q?4d70aeRcUnCSgIK/GAwA4x+pz22lG454G6HUuTrtGR/WcraX6KT+jRNPPjPC?=
 =?us-ascii?Q?rOCd6vRutBbK8PWEdOjewsFRa2qbi1dt/UaEHlQDA8sFJQ/KPdQrnUhFiwZ0?=
 =?us-ascii?Q?fY0VT+kYsq6V9zZMa/Se4pfbp0o1oULhLkIsn+cI8b0QF+w7AZfcXBDm/2rK?=
 =?us-ascii?Q?TAK9XY7cdpEufmrZ9rLrL4UScuEKqScEsi12pXBIZ1XPBgh+jWZ32DTg5iGm?=
 =?us-ascii?Q?X1+HUzxRfKffXyXRO9EagOeEtKI1Uppf8SFOZ6WMSIR5jyk7XRXcT3ZgyUJh?=
 =?us-ascii?Q?nI9TQxQlEMbYlCuS3NaOwaVmI47Bkh4jIHVa0rE+SUpeJKuJ1O4eI5QOKkVY?=
 =?us-ascii?Q?KwnlLjugWg0QmoNK4T4wRwSghNxoldy0cMTvIt1seqNKcADP5lIQPCVx1DRW?=
 =?us-ascii?Q?QzJ/HF8wQAtlWZdWIzMSVgZB5Eta+aG8SksyC4iopNljHoOqTC2IKTAxSIEu?=
 =?us-ascii?Q?g2MFjvW5MvwStiBaSQtzd275tyPZ9X1/c5jZ0+zX4vxPa4W7N2MZ8CYn1nIB?=
 =?us-ascii?Q?1DTE43sEeeYipzE3TAYmr/KRIghRAu8wfZbyzTK6Hd5RasprnNqDSk/1saPA?=
 =?us-ascii?Q?cP2H5uw5e3Fc0YqfMsgq0g7f1oGvS6C8qO/yelbkc0HsGkTDh/tC/I+QsMR5?=
 =?us-ascii?Q?6g70gDr1rb4iiuu4awjqKq/fqtpemIE3XrCuA6Bm5hz3DXdGJZoCxcecCI5V?=
 =?us-ascii?Q?+wx+TgJ23A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e8cd6a-7a0f-4b33-850d-08deba0abfe3
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 03:07:26.7051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3UQkASLxY50qd0UCTXAi9A60Lx4VzTkQ0aOTjkWT2Q69dcJ/ZXik4im8907AMxjmMSBCpk5el/2+MUdzVOv/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10829
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

Use dev_read_addr_x() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/ipu_rproc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/ipu_rproc.c b/drivers/remoteproc/ipu_rproc.c
index 2ca78b550a7..8f0b619daf7 100644
--- a/drivers/remoteproc/ipu_rproc.c
+++ b/drivers/remoteproc/ipu_rproc.c
@@ -695,9 +695,8 @@ static int ipu_probe(struct udevice *dev)
 	priv = dev_get_priv(dev);
 
 	priv->mem.bus_addr =
-		devfdt_get_addr_size_name(dev,
-					  ipu_mem_names[0],
-					  (fdt_addr_t *)&priv->mem.size);
+		dev_read_addr_size_name(dev, ipu_mem_names[0],
+					(fdt_addr_t *)&priv->mem.size);
 
 	ret = reset_get_by_index(dev, 2, &reset);
 	if (ret < 0) {
@@ -718,7 +717,7 @@ static int ipu_probe(struct udevice *dev)
 	priv->mem.cpu_addr = map_physmem(priv->mem.bus_addr,
 					 priv->mem.size, MAP_NOCACHE);
 
-	if (devfdt_get_addr(dev) == 0x58820000)
+	if (dev_read_addr(dev) == 0x58820000)
 		priv->id = 0;
 	else
 		priv->id = 1;
-- 
2.51.0

