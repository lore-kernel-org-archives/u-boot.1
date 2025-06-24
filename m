Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F5AC77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 10:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FDBD82D17;
	Tue, 24 Jun 2025 12:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AGkXttNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8AFB82D21; Tue, 24 Jun 2025 12:10:33 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB27382C84
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 12:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/b8uBzJ++FyJPrTATaI9RM6/+pg9LKw7aLCv+ium1uy5uLdyIFkM25xFDXQX6mN6HqdWX94ovjNMKd6vuXbUmoh/c9YxKI3KO9rHChHJt+kufkp1wvwYN7uFPSzpas1kt6sswlGC2gzBKJzkKrny0vurgovP5uhn2+i/38pZyf5g7C54S8xoMRs4GajhxjXeFhAxxfzy3tXOw2L/W/icdwPf8nj4oFDtxPhNTJ4x+hxs/QEICdHyfCUYvgUq04u+coeEjAU9JFyqHZY+2fYOu8Uz+NxPUJKHpeqlB/t86YibHHVO3ruISN+JX9rQQqGZNMCCHmgA0EFTFG+zjZ1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x77IS18vUWyiYJm47qGZo94V+M2P3x8nLyAUA8qAjbU=;
 b=fRx5PhjU1StnbkbwYhRbFkVG1YuscnghMhUFZESZ5aliNclb7ty2kYPVaWRFcUS8MRTAPv6ngOmMQseujBIMkgggY4djKAFDX0OP9jKmQ0LXv1TyRnNb/eGakbwizlk4cFcJJs+IXO5Hq0dwjERAeksaRQRKIKlJqBOA26T/sLiIIFLjxbnykS75d0ckBIt3sYcu3ofPR3TTJAtobxzae1vhC6L40T+xw7xAvQEtm3iQH+k+6GKLZeFBNTTr3rPnU8GQ9BxNrEtVfc2OZefjqSi+5Hk0lFKTfSMIVefhhT/l/zodDXcAosYejZZRr5reKXwp1mx3h1cpkQRaEw9plA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x77IS18vUWyiYJm47qGZo94V+M2P3x8nLyAUA8qAjbU=;
 b=AGkXttNBWpwTzHmqjJ8cyapWblv23P6a16vE3sj94eVeNEku4w2+OaxQyNrp9Te+GJI7dPVgQRRHO12mCNBCHVZRMKqYgu+mYB3GmJwRSQkjMJQTVyytOk7/Ij7/+eVwxgyc8DJiKvnowiB8tcVfh+TzEAWrCydKdKbiPNGE2hSHZbLY50FHnUJyjohHJelJxVeShkmFEXeudAbSEs/j+2dM3F1EJl7PRv28xgWRa6aceq1Nd1fYs0iGXuLQrkFYcMMvc3StuEi7zkXrJgg3btrV7VdZlDGy2Wt1S4xBoH3jb0yDmzmxPgOS5AP8P6G1bmJr+eAuFiW83i0hnI+J1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA3PR04MB11250.eurprd04.prod.outlook.com (2603:10a6:102:4aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 10:10:29 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 10:10:29 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, festevam@denx.de, peng.fan@nxp.com, hs@denx.de,
 alice.guo@nxp.com, sbabic@nabladev.com, uboot-imx@nxp.com,
 eballetb@redhat.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2] tools: imx8image: Fix the value passed to dcd_skip of
 build_container()
Date: Tue, 24 Jun 2025 18:09:22 +0800
Message-ID: <20250624100922.1702045-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA3PR04MB11250:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c7f0f4-bd2c-4630-b651-08ddb307589f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z3HwYcHVS+VFq5NAwk8pgSz1ncQjojpEBZChMJOTuUItoVGAje4SPHazs+OE?=
 =?us-ascii?Q?o6CEuRt/Ys3E3CQG44z2s2PZqFD7+AV9Aq4bVWOlfMoz4MDLjc5q8KOkfnYv?=
 =?us-ascii?Q?8TrLvt2ghrVWBqWoJZ4FMXFy5Inwijf5PbzTrJsAkv++oI18jeIjcT+ZFG9d?=
 =?us-ascii?Q?nWWj0KBYtynW3Vj7vEfH+XkZ4e23vJFbsVCSa8ZiEDyIU4sYeRhZQrYohCcN?=
 =?us-ascii?Q?rxB1l5txrQYyCwFwqnPsX7atgq0Vwv8CiVHSiwdStdNlWremncMW3gSHXJdZ?=
 =?us-ascii?Q?Vfw3XyvG9w318A98Oiq53aXBnXEh5kGJv1msk3Ys6jFNP8bB9L9Jv0Kjzu1L?=
 =?us-ascii?Q?6Y3EKWOUFJaSrvoik73XXDL9MZ1YZMLcfW0+QZsRmmGSDTu/NoQye+KQHUn0?=
 =?us-ascii?Q?3MRcpsa8/PvvmmnFJxXTy7OXPdDi/tXc67zu7l+HiiSjndPFr8NcdrG8cOmu?=
 =?us-ascii?Q?aGoDx7NvMX2fzLbI6wEoBSpmMF/9XUFo1BcWOBBLct2duRIWrJPlUmHuLz5l?=
 =?us-ascii?Q?sqMEbNJwoUvFAorf/yFCohUV677+wE8dE8gHyGruPMaTeuVVp8p8X/JUbzqn?=
 =?us-ascii?Q?s9xeOoG/rzRgdYpchn8zmiS2ey2ohZn7RUGMjRH0WmKHPiUC/itw0Nrmixz1?=
 =?us-ascii?Q?+JrVpoJOuNkRmX+0HkoTJ1rTIih/JeMM2SOoG7YLjb22PLvU+wk3f0a1jBhd?=
 =?us-ascii?Q?cuVustBDNFOlKFGVEL+++xnAPLDoqayIheQdkaFGZ20asGWy4EK7F+rUPWAC?=
 =?us-ascii?Q?U72UDSDohGNKNKyNyriQ3fwgAP6iHYfuh+C3xh8OI4ENUp4CL2I7+kar955E?=
 =?us-ascii?Q?64y7zcPCiFVFXeiSWqdfEKAUCZ5YJV55ZTUJJVeKZxDM5sZUsrV/KWx/ecul?=
 =?us-ascii?Q?Y55TDIj4DkefMtGAK437nIXlWGsoD7orgYEnIuWhewLGtoYGG9Ss4hhVNqIV?=
 =?us-ascii?Q?0HcUD0QNFBrvGn/ulZ1qCoTYdBrEaH0TeVzzlwF4/aiAuoJ8GwvOOEhMqWKI?=
 =?us-ascii?Q?T6PP6HSuBwchqoDvQI82fI+fm1lsy4BMNZHWQlZgZfpbdfVaM7bMJgjz4tAo?=
 =?us-ascii?Q?aEosZlx4ejrRj0JxGd+NN2qTjDmXdCqnefcX9dx/LYDuCPWMspfhCZCMX97b?=
 =?us-ascii?Q?r9q3bMgWI8W9IBJg80rRu7AOLrYgrRnrCY5AWn09rGERmQoQq32P7qormGVu?=
 =?us-ascii?Q?B8wHMTSxiWz38afvV5J65V3o5xSOTLv/yE9L/aWf2xWxSoRkzqfkHFrpo64y?=
 =?us-ascii?Q?P7B4V/cYyM6nvx7cv4oXzaSmezoh7+Ofh7mjDkPS+2T/KY6NtoqS79sSfeBV?=
 =?us-ascii?Q?BmqJE6jyR2Zi9MPXlIZb7yasyyHolNlIGGENmHCkEmfxTTOqyMeTkOq5uUc4?=
 =?us-ascii?Q?JvCdP26kQdZmI/vFiAt0wEt0Q+op3yxQrUOUxCWiqR9HsZ603SMrX6f4nVjy?=
 =?us-ascii?Q?W+JLODifjHP/jaN0CYjlcfhnVcPSVenpcMKlHEsBQCUJcogCoJ6I2A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uTbfKDqDx2XKtx4xFJHL6ttOCUItgsBEvqIzxoWkO9v+uByyqHamvWqgXSMQ?=
 =?us-ascii?Q?FQdjZeVdlF5ERsrOwzJgOB8JETjELS5Dvu/V2Ut+6pp816W1gFJ+MXarj7Td?=
 =?us-ascii?Q?VbDe29uQOiUPkZyyy4j4cMOWIiUG+iHRtHexiDytNJIdtzt0Nqdcr0eLyyO4?=
 =?us-ascii?Q?/G0cmC6FA8mqSasIfNClML7xuBBW1xLBftyn2ggziaUUOZCPCCMQMl9NbmSv?=
 =?us-ascii?Q?iF3p4Oztzt/FZe1pAslApvcnv1/4gByWQsITFP0Vy3CPZ1I4Ppd7EBF9dCuZ?=
 =?us-ascii?Q?/FosRw0lb2oVvhYvAeG7FBlBSGtiT89VZeCt7Kj0cnoeQSEGHIWD82eVJcg1?=
 =?us-ascii?Q?QDRv3T/biG99rq4KNMyrvXrbyqKWvJWbq9rd6P1sv4n28AZMfuTzV6fEb/i/?=
 =?us-ascii?Q?UlXtj8lERcrSEmrRgO7G2zocqEzrYNNcO5npL2keucDKvcuWEELZF3+xWtaj?=
 =?us-ascii?Q?5Is2zv1LOlUxBJknacM0pgfG/05bukquWIl3ufRMESkNHk8vBhgBQovfa2Sr?=
 =?us-ascii?Q?Qz2CKzhEZrOrxUMabZRc3J/hYptXlwdNPKPPDSLWtfJDn7MWJUjX+DhkokFi?=
 =?us-ascii?Q?phvsNbSyeVQ8yedQxoOzC9+ha8dlnZy0gZASajw1bgTjMXby/a0631RSs1TT?=
 =?us-ascii?Q?FF6HuhcYmGTBJnPzzLAk2WhW6OFUy2iosdOgssk3lKzvJR4/58nGIlWP9474?=
 =?us-ascii?Q?rOrTamEAszkIWq3Z9oKOPJ01ESzOf2eZOiujlXsg3dRu4J5GUKwouLNB+a8M?=
 =?us-ascii?Q?JTtv7HF2VFHwupmTG5V2AGimEdlcWDCEJgtHzCjgeo5MyQptfST0Yu2D0X/H?=
 =?us-ascii?Q?7g6zL35JkfkuzpyjkQvQj6LWbk5WnTEoSJs/Spp9Or1u6qFEWgjejz+PCvip?=
 =?us-ascii?Q?1s+HPfYg8R6YJE5fcKWTNRMtC1g7LSJeeh/trignG/iNdqwEoqxu6BdRFJKa?=
 =?us-ascii?Q?IS+uXpOgOojDAf/IJwbLj81ZIp4umbuGaz9N15dJPwhCKzMmficRNJqSs3n8?=
 =?us-ascii?Q?pD28cyd8Stoq7jZzuj6/lQU5okL97M/rmSS9wlFgqWR6lQsXUku4AvXD0g2a?=
 =?us-ascii?Q?PTUrfEzTRlHkVYtBaSrFSCyepw9r6lAHEo6tb9zrZE7j9EAwJiyej65AHbtz?=
 =?us-ascii?Q?MZdgoJqxWhop8znWvstGmZM+h+dwviY50MioRQuH6bTyC+ToEN2T0x1kvDUy?=
 =?us-ascii?Q?mKvcawqxlmwEh26Pzy00BnnxPAZIyl9S/I8fsSilrM7zhvEcuFaKwSblJctH?=
 =?us-ascii?Q?AIqPg6dIj93el0TedSHMMz3AXPtNs8KcN+cTp22tDoOKqno0K1Iuqx3tXRUT?=
 =?us-ascii?Q?VF56eLt3qoppAO4hi2KLPEScl8LPsm/3XpsjdxXp7T1pikTNg2jjUidqY4zf?=
 =?us-ascii?Q?Z2SL0sePwsK6WOb0mnw36cwbfV4B5a8TC6gaBvpUWripEWJW5NY9vVUj99K3?=
 =?us-ascii?Q?cUixIjVz2jJYi2+yW7MAdcQEhiZTl0VjUTGIz4kEPZdW6554XMU6FBsX2LEN?=
 =?us-ascii?Q?SwC4P0+oDv4Up/kloKzieDIAPmc2QdV9pG4MUrZdEP2sCfw1cEeoNbeVRtjd?=
 =?us-ascii?Q?BqO5xSzQSEIWfq/ExkgcdhZ0goY/gm8hnMh3KaC6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c7f0f4-bd2c-4630-b651-08ddb307589f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 10:10:29.5919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W682l5sqOaeeJAQjbX69hUZyxqKrCNEfbZFap3cjs42TImUu+7963iAskcI02KwXrCQ5zgsHugW+iezYgbprng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11250
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

From: Alice Guo <alice.guo@nxp.com>

The value passed to dcd_skip of build_container() should be obtained by
parsing .cfg file, and should not be fixed to false. For i.MX8QXP, dcd
data needs to be skipped, in which case dcd_skip should be true.

Fixes: 5f28a6599f01("tools: imx8image: add i.MX95 support")

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

Changes for v2:
 - send this patch separately

 tools/imx8image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/imx8image.c b/tools/imx8image.c
index a333ded46e2..cad55fd3cf2 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -1146,7 +1146,7 @@ int imx8image_copy_image(int outfd, struct image_tool_params *mparams)
 	fprintf(stdout, "CONTAINER SW VERSION:\t0x%04x\n", sw_version);
 
 	build_container(soc, sector_size, emmc_fastboot,
-			img_sp, false, fuse_version, sw_version, outfd);
+			img_sp, dcd_skip, fuse_version, sw_version, outfd);
 
 	return 0;
 }
-- 
2.43.0

