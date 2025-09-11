Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84B4CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34ECA833ED;
	Thu, 11 Sep 2025 14:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="VzjLy0rW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BF7D8331B; Thu, 11 Sep 2025 11:59:13 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CFFA8331F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 11:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVDipw+/ZzczPx6aCb4xz+yrznwa8CJEA25x9Wm7blyJz4r54HGvOmEvLJDh6whzJJHQ6ZpoByXxW2sqWGOI6lkqVhg7YeyR0nyih3go2cdgzjzz2C/jgU/EVYUG35G77z93u8tfWXVUuHnENQrUs5AJiTa9OAm9hJ8wmUvRDcmnQP5QJzG59GZBlWdUfCnmY0BrRHZYfNy5Fa+7tR2/AOqrQztnADsHvI3hAM5hSzAkzvEhUA7CQGhi2KigosE6Jhe5TPOffGeoSxsZins4O397w/xSTKvZJ2q3pdh1BDhybZxHMeEQW8on575qPkHGQe3B89vv6tpW6DRQafhLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0BnfwUsl+RAkZlt7i58YBuUkwo8S3UMPyQIlZV1pE0=;
 b=RWE1aVMiM37Tix6sXcySl9hAVUewnlDI48Zk6r7wP25CxAP81IHx82execmquLeNal87+T3METQwCprrg5gnj8OvRp8K4X6WgD22rBgma7gVpmTU8tkmsEs/Ze68owdjzqaYQHgyslNKjdArEbLXRCXmluZkuJEcyWIwqZxhH1jglK9rWmT5IcSvI2MX9+Tk/6IUiSupdubl/4xOLvzVrdOGnc2s8aJvchnY8nNsHWgTHdrkLGPJtKFlh02MF6qQUwz90/s8TohNC/NgXwBB5sYXXsVGvrogNDpcbeIAUwuq6SPHxkRldki348/1BRhuygg+jc2A9Nf1WnjaSJsIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0BnfwUsl+RAkZlt7i58YBuUkwo8S3UMPyQIlZV1pE0=;
 b=VzjLy0rWqILz1CNx39tTkJErL780oowIlRCFmZt0WcAWCTYiaJqZoGQ4L3fHoc9SYzmHoPgoQWvQYGgD07Em1qItniZIMsPSm1DhK5m+OXB8ko/G2zzIqXKFRR7nt2P5Uq3XJuXoOm9rgAp3VoZX1nk/O4gYtiqnQz1OaHPnvSNLUaUFcprwEx0F57VC4TD7U5M5kVjve+SxAu7cil17ikbcnxehhXrntBo6dRsOiM/4auwRdOqaJdZzupaOv/rtvCRnNQUPbcXolVTm7KTAD5GXSklBJp3Ocou2QWnlOXFgdBWdCJDJP2xMebb9EWFGBDnXntvW4XVTrEuN5zf9gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DBAPR04MB7464.eurprd04.prod.outlook.com (2603:10a6:10:1a8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 09:59:09 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 09:59:07 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com, sumit.garg@linaro.org
Subject: [PATCH 1/8] pci: dw: Fix wrong register used for PCI_COMMAND
Date: Thu, 11 Sep 2025 17:58:34 +0800
Message-Id: <20250911095841.3659022-2-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911095841.3659022-1-ye.li@nxp.com>
References: <20250911095841.3659022-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DBAPR04MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb7d0cd-141f-4e6c-fbe9-08ddf119d89b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|42112799006|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qzZN4kgfd+h+bzomECghk2e0Rp4FtVQUUXr4GOQvmMryUKt14aStPkz0etlM?=
 =?us-ascii?Q?/YQGQFy1kWFJdtECHGDgj2c9GZMYi22TKlygeXUEqbbrLL3Hbs3XReMeTO48?=
 =?us-ascii?Q?dAi2tRzYzzW2HzoqvjT6SnO/nhg4kBQYuRtqqjqLbIble6oIVk/BRC3Axlm5?=
 =?us-ascii?Q?XTQgvlCpQYH2mT4bCiWi0Z7E4+JziIYZQ43isCP/H1d61vOEkn/vU8M2KpVX?=
 =?us-ascii?Q?PHDRxzsG5q2Yj1vgKAiHVsgqmom/MPLRbMmfcO76lTWApI1BBd2lE1M+Bhcl?=
 =?us-ascii?Q?Sy2o04ehIfjI/YoZd9WtKocmJ58vTjmlhSp9uxUmyxsIKVxUDUg/TEkVFRrn?=
 =?us-ascii?Q?/+kqBcK/l0kEwHLnGGQ+lilc/frGzFWzWV4HYXUhFHJ/GrlQJAEYzlQk5UdJ?=
 =?us-ascii?Q?gy/cjf3PauSQljZ0AG+nVoECkY5jMurDruCC4WulY0+4lxvZzugCm+1T37VX?=
 =?us-ascii?Q?MyZxX8KxzYmY9LeeYA5zlAFUKvv4oAuCC3/3WRiEpTMEIrpAR1EdLE8x8kc1?=
 =?us-ascii?Q?B+RpMlYStZlzQSqf6gm7BiWLKfCPkmwMlf4J9WxcMd32pH8CquEjYbYzcO9q?=
 =?us-ascii?Q?otcOzZZSiwMK5csmJMLzuSivZVWYt5JmJIw84ZMuN4M6i8u1KcBsbuqV7yMj?=
 =?us-ascii?Q?HN04lOYxODvkb/OZE9dLFM8INTwUplvkg28X7i3Z353tq20NNNqqHaegoTtW?=
 =?us-ascii?Q?LmTXrfpYsIr0MAbc4mUL5V5MhyXwtMVQ/m5s/TXoirdoEHuGk19+iW2bBeoH?=
 =?us-ascii?Q?JJCmWbij2jEJCVT8/JPk49ufm6VNr0Q3oMswAhnjvi31DdjB1OrRwgDWOpJw?=
 =?us-ascii?Q?c0R4SuOO8exdxju6JO4tZ2c2OTspNDxqQe2TGdchAGU/eVO1lu5jmPs2EvC1?=
 =?us-ascii?Q?6ImFLs7AISlw89VXuNlaBPaRo41iOeeB8Ytj03bMY6f/ZCEzwifSRKfceZSW?=
 =?us-ascii?Q?lqVvDIt9Y9EvDBkTLBDpUMGrU4kvdoRX+9L+lhRKT5Ri9S2640zMqRN0hqam?=
 =?us-ascii?Q?SpZEeoKr1OhsQkd5GvggNoQAnTQnVCoagvxhouAl2ABoQdeGCrxvkkt2JXw5?=
 =?us-ascii?Q?pkdxhKpRb49q54nqDhUQCwbV0ifseCSGGRiJSNn1+4oRowPikybbrZet7l16?=
 =?us-ascii?Q?FSWGF2/ehF+k458f5VPXEG+sWvUfI/eavYuXUE3Ig7SNmLi7uovJYrL+ttGh?=
 =?us-ascii?Q?j3mM6cXzAGEGYAUoEBeOuYp4j/xxsFoFF9smYOqVP3TZkNn37Hmq9FcJsc9c?=
 =?us-ascii?Q?4ScrrI5WF2/T+POosKWCaZcetku2twsrUI7n3V+f/QtJTiEvCAiQOFdeHVK0?=
 =?us-ascii?Q?x12N3CfM2JDyBcD2Vai9jgK7VEYLD8P7mKPY+XHfmKK0a1TNP4idcsdrp82m?=
 =?us-ascii?Q?5bp7QlsyhobV1sbc32gRXhC0ysQICU25MYuXDpwUn2d6K2Z1Cn8BtjMjWhkP?=
 =?us-ascii?Q?PvOlOSDGQDvcy1WBUQxDR0SPpvC2AKrKze35/HtmtmYav607/+n9J6vZuE2e?=
 =?us-ascii?Q?v9WH+i99qZOvsjs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(42112799006)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ByQuciON8nrp7v3+747aY9cDLQXoi43Z3RfHtYjQ6V5IQ/rr8CAsY5tCs9BD?=
 =?us-ascii?Q?Eh/U0tdhi11zgvlyis5Ch9rQ1FKpeEhKoeoRxYLceg8vUhf+xpNxP4temjNg?=
 =?us-ascii?Q?949JigJVyHI9E43T++CIp7El6KEx9T3PT7dF20Osr5ODf4pTtmrC60sRFxij?=
 =?us-ascii?Q?iowAwmWQecabowZDgcSHLPyAEjk0xcPZ52Vm7KcOQL9h9A7fcUuwaEPevl1s?=
 =?us-ascii?Q?7FFVj67EKxu7IqtWErv5RlHQ6FQ3nNlZoE/YidTQ2ZFJrjbH09cETKMl6E2m?=
 =?us-ascii?Q?8AAXgYqO0euYfWnlv9Weq2iEdTyLaOC5mfytp6gkCmvS74s114orHWvYSMiF?=
 =?us-ascii?Q?6O/2nnUO12M14iHff7Jz1G8lAbX0z+X6+FetFItXxcaoIeCObwsvH+btz8dv?=
 =?us-ascii?Q?ibqDCBaBX/tUikzXfInqBFqDVISt+HIzWswlZUJjpeBzn6bDtROVDy3YBOfq?=
 =?us-ascii?Q?1z6M6CT2Zd3BTkLFZgfPj3c9pa+BCc0Q3/9cIAgDaODp9tj5QdPMR0pm1JUg?=
 =?us-ascii?Q?Jp8QyNPMxKJh7GfqmeHMMgBQDZKhLAUP1GXuCWpcRJV3QJ8ETUHI9AWhVR6d?=
 =?us-ascii?Q?oeWpntVcEdeLRO37TzL1tPWFeb2XQ78TF77EPzuepNMUpG/cQc2c2OnhPJzg?=
 =?us-ascii?Q?0TbGT6dY1MbsZ6g0TERhFvtchCNF7LkhCEiqy41bjqUKdzOdpodsY6++DjOv?=
 =?us-ascii?Q?AV658BtUNFRDZbRDgXb+1yayZxswZ7VuC0H7MXZnhRbHaAGRQMdx5aUIXG4R?=
 =?us-ascii?Q?LyfxZmu6EIRygnK68gOQAGHx7eVg2PG+R5Oc+Thw2qbuh/0nOIriY/sAferu?=
 =?us-ascii?Q?FgYd8u1b/WpImrV8AmL7G1E+epons0Cdv/eQTbgBYIopq0/a6l6ds+PpVd84?=
 =?us-ascii?Q?h9i7oA7hNuIhjamc2d3gqwqXoXXsqmiCHY/ld8l8THOqmWeDiY1oxP0qsrVH?=
 =?us-ascii?Q?/SScRuTJ70m78Of5g6WceNcnyPpgaS6zN1ZK1tA8aimBP01FcXcG5WpfJk1v?=
 =?us-ascii?Q?ESGkFr7MPEMFZcEXB8rb9h36qZegiOwPD6hlK/oqhruVgg8PflU1BTUhYucN?=
 =?us-ascii?Q?j61Ilp5YR8klrOnsQH8MPmNhiSWqtQcVNmnABYTGUlDbBkL9aXtJZSIh9/bD?=
 =?us-ascii?Q?4sqsEiOoJxi1cnpN1JXnElfS8jrNONzCk6ltAJ1IQdfCrlLdPScDWl8vzgaY?=
 =?us-ascii?Q?vLr2/c7irWUcqXn1SBEUbK95CrmMBAh8fp0dM2UEpzszJ3+feCIDUamsv2UQ?=
 =?us-ascii?Q?etKnuYzc6boKnUJYkCMKx6x9jPTOH6uXu8ZS45l+RyK321mJT2an7zCduc7J?=
 =?us-ascii?Q?iE9VQwxpOVoNQ1KxEULDOrBYBe3XIGm9E32O/zy1rsOrAQrA7WqxeF7FEDsW?=
 =?us-ascii?Q?WLOOXSQmHFfeUkeI5cnLoKZsSwRXCEewvk0xuUAg2M+n8CCqAm54OVmAW/a3?=
 =?us-ascii?Q?3l3cKSHgAVu4dYZ2hCZrhsMeOAsKrg6jnL5wakutWsLHh97tFXMp+XCsVtnA?=
 =?us-ascii?Q?D5EaHpQ0F6Rb/GGH5NQLR38hya12zz+d/E7oAEJN7Ufcyr6tcqV2EhFSEz+3?=
 =?us-ascii?Q?NMRmTrOyG9LxUqTI2VM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb7d0cd-141f-4e6c-fbe9-08ddf119d89b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:59:07.0655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jH4EfkKDjZiDLm7pbXxXZ4/SK94kdTybjH7tGc65RtfEpTpVmDkH82D/hwPoLv6H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7464
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

Wirting to command register should use PCI_COMMAND not PCI_PRIMARY_BUS

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/pci/pcie_dw_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie_dw_common.c b/drivers/pci/pcie_dw_common.c
index c4cad019373e..4113a9f03cfc 100644
--- a/drivers/pci/pcie_dw_common.c
+++ b/drivers/pci/pcie_dw_common.c
@@ -7,7 +7,6 @@
  *
  * Copyright (C) 2018 Texas Instruments, Inc
  */
-
 #include <dm.h>
 #include <log.h>
 #include <pci.h>
@@ -385,7 +384,7 @@ void pcie_dw_setup_host(struct pcie_dw *pci)
 			0xffffff, 0x00ff0100);
 
 	/* setup command register */
-	clrsetbits_le32(pci->dbi_base + PCI_PRIMARY_BUS,
+	clrsetbits_le32(pci->dbi_base + PCI_COMMAND,
 			0xffff,
 			PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
 			PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
-- 
2.7.4

