Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BEDCE7D19
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 12:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D71891A6;
	Tue,  1 Oct 2024 14:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GRFqYbCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41224891B8; Tue,  1 Oct 2024 14:04:42 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48193891B3
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKFGOr52+ZaGW8+Ftunk1uQdiRmYIMLHzBA1pNmPuXI8vp0JoDWkD/csDRj7ikGXs/jQo2MyfYAb1GCV6JJ/kE/egh8wrEuhgMV5MPNl8UyR34vKFnr3tbWa1cYZxhvP2zpL39MmWP/T7sPy1Ry1uccvqTW0GeCv56k2/FJRZ1zrA3AiThCwEbTyMkjOHe2ITzI9E9/7hahN6oudHPDhb1S0UBvezoeL+LNqNiNVOJXE9AmnSRtxQOMKJBaHEe7OoUN6eFEX6HNq9QcnHgRVtk6Sb4SYG2N2Pc5JyV/GfWFW6JvmYSfiLquBlF3tDV9hfoX8G/Pk5L851RC3EdHI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP/qCxaygz1VPRTALrNxf9sAE0jcPMsVLF4UwxpoETs=;
 b=l03mMZ+u9jrUIH2y9g1rM9ud549zdw/BFHVDnhtoMHud12ZuFu/5C/+yus1j8VeJ7WR4QMqvvhTiQ2upnwumHghjbfTgmNPeSJcDHJj35anhNPizpjd1pS9z82SzJq+7JnFT8tCgvo9DCd5c4GdAfCNyh9RSsHKJy+wJxjcbUE93ps3mDC2jXDIFZkhMlcs5Dq0zY+Mw3KWMCNfGX3AjX063WbGO6CjrxCLfhXXOcgclBmGzds/j5JKHuwXM5di4AISCP0NjRaRO8w3ZUCCiXANcW1Pyo8/+tLPW8irKB2xfjeUGdetlHYiBJrTsUqbgC05P6KRgqbRk06jI0WBNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP/qCxaygz1VPRTALrNxf9sAE0jcPMsVLF4UwxpoETs=;
 b=GRFqYbCRaA0XDmcXwYhb2vVwNTZJSwAebtHqjuqym0S7Wj9dmy3dR4M5CKL3KGinrfBGFPKMvsCNJkb3EeaM7uv8re4ibHfOEZ5TM+EkPBJ/JNNhp+vgipD+DZtINftEtOmbmZtTXsitVxZMZhpkMM27Xik99AyFB1hJ4Gc7/3Cpv14hDVJH33XngYjSsv6p5LlvIiuENvP1YVQHlz2nGf5THzTZbIOufS1QOwhpSPBDEc3xJ7rDbpYlrf5tDETiD7WNSEmtkFRZx72pPagoY2/4zy0Bdsk92iRZLOs1tfWSxa7gRdevm9DjF1IKjUQFby+Swo8gRw3F0y9mNTxOCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8533.eurprd04.prod.outlook.com (2603:10a6:10:2d4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 1 Oct
 2024 12:04:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Tue, 1 Oct 2024
 12:04:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com,
	Ye Li <ye.li@nxp.com>
Subject: [PATCH V2 4/5] mmc: fsl_esdhc_imx: Avoid resource leak
Date: Tue,  1 Oct 2024 21:07:56 +0800
Message-Id: <20241001130758.9810-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241001130758.9810-1-peng.fan@oss.nxp.com>
References: <20241001130758.9810-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: 90293004-ee30-42be-738d-08dce21137b9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0AYVzzsKB9Y8N+CvCuQdcXFQbFp2tp++n92PpglHizBiFvUydVGyyyjcLBZJ?=
 =?us-ascii?Q?PB/oz9TaxSYVLA13WMBpXnhT2SD0BG47tjtgJjUPB/FfFWiEBy0NscSgPBPd?=
 =?us-ascii?Q?D+C6R3Ev9gX3g69tkiY8mZqBhSUZZfKpRhl3NHodJar1mNU55aSf4SLFx4Jy?=
 =?us-ascii?Q?iuVCz4bEJHnDtrbM6rp+Fyf/gimf3PYNEEg/AbmVSpWznuSYNOCJ+SKPsDFr?=
 =?us-ascii?Q?gCjXfRGAhu1l9YS+BGs6Pf2NQpP60PGZBuyiZe2RHQj7LyvEVs7CV2C8GRsV?=
 =?us-ascii?Q?d4FD+24/GOpjwQjRkOIToviQYt5Tpa9YyWo0VKmPrcSiLnvkRwJ7RJ1p48ig?=
 =?us-ascii?Q?bA2TTtCOBXBX0LHzwfMHt6zyxZ2lgvksbkyqggja4HTBPsivqkHRJCvL6AOY?=
 =?us-ascii?Q?FGDvYETfWz28fE3ZOHr3xT0v27pnA6/09Owdck3zWiSUmT6n8KPAXuKLT5jm?=
 =?us-ascii?Q?ODc59RTGTjIl0gEm3VN24Sib5z7CFMyu7zFS8YeLf7bQ6/xZwRvrEHlDNdbi?=
 =?us-ascii?Q?PPvgTWWzmc5DFTo51Kv2kJMFhfvY4yoAJKH8eI/KNaAOVcfN/8Eqn906Kkvr?=
 =?us-ascii?Q?Gud0bLkyKAjes0nIT10Ah3ATcQqylMSSrhTDiwyWctPvobO1CJzRE04fOZkE?=
 =?us-ascii?Q?fm5l2LNK+z7+19yKLaTBtjPMtstjEOjQNpk0gBaAHgCQ5DB+/V+gtE4NL/V/?=
 =?us-ascii?Q?lP1jjtpx0Lm1FlQKsfzLghXCgxcoQ50/X2xSD4LgoAkPsu2FGDTwYAB/lnkG?=
 =?us-ascii?Q?T7fe6PyGOVyJWelMkfkQop0H+egviGTPnyTha9FJkiVnkFX6oDCD/MAgMjBR?=
 =?us-ascii?Q?ja14nJVoMIdBp3eehImvSqKLKDRFF4oWu0/jLTaPlwAYs82qlHVdsCZkazOV?=
 =?us-ascii?Q?GkLBASwB3kZrOlrLmhGe3P0UZ6ZUxLO423m2l/dbNfMVmrgxB4EdmThitg3N?=
 =?us-ascii?Q?91BKE77a6yBCduSWx8XLBaeB8bD69P6UEyBkJYNxBwlBhv3zqKYDy4eVFtDy?=
 =?us-ascii?Q?YdnsjSOrFitvJlruh0i88EGRKVlTSohhCDZ29+8RP9ZhLXRSEvirUiWUXvBj?=
 =?us-ascii?Q?vIThfXXB8R9AN7BXIxrRkcEKDx8SiSLGihnA+Q7+qMT7oKRq6k6IsxUIRcFw?=
 =?us-ascii?Q?1lh37wbZKBm1VJO5DspP1VJWFEeaTT7SDCBsSLo/rpN2irnIRej7NsByfn8V?=
 =?us-ascii?Q?EGt3CfHbgOJnQK9nPYLyDnhuxqrdLLiidnNzixE/ivMBtW3JO06wcOKmwugZ?=
 =?us-ascii?Q?QmCo6/Aiw/rB7horBt4rvOwnsAFuKI1hsOqCxAH5gjxwkmNGPV/IwjS8ykOP?=
 =?us-ascii?Q?H1KY8HssJDbcGb+sO7WR9qiMbIPb2OEVZ6ku0j8sfHgf1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V34AJMblm3eZGIrwNX1RTcuSWYzVjUV0QLHkIw0cCZdTQb5QnS4z7jn83OPO?=
 =?us-ascii?Q?suICeM8Ln474zlnxIwBVwk6WoTJfyg+8UnSTjTRSarhkVlEPzT+P/vHSCh0c?=
 =?us-ascii?Q?XPYMxaFLdaM/+wlfGL+RZAhMmaxgt/781ckSCOqRIdpEkmkgTY+RdBM23eN+?=
 =?us-ascii?Q?6xEsnQ7SIowcumK0L9fj9dk2xnHe/fQA/7orQGh2V9MfxM9eTzi2vBoTIkXh?=
 =?us-ascii?Q?1qHnJ/kZGqMj7fEX5iscghs5um54hsX+S+JpYL27gGSlKt/713q2faq5V+DW?=
 =?us-ascii?Q?orcC3NtHbWDbwtw9waFFwY/tatcQq7Kon1xuQpOIF7/rw3E7vtPochGhRvMz?=
 =?us-ascii?Q?Ut8hgOnhrhNAQwep1zW2yearwzA29L6kGVBkgQSDYCzSqVx4nMPTnjFRGSsS?=
 =?us-ascii?Q?GTyutf5YzyYpT+fqWMnq6SlFWrayNijfz/CD6Gf52JvpF5NcFlA3IplS374A?=
 =?us-ascii?Q?ZaSGEkLVGjbc3MyoBAU2jvn9ikSuLp7wjHxDzXp3APmerIvFAdnUtT0uLPrZ?=
 =?us-ascii?Q?4kD9WXrlFYhAOYPYjkIzcjjf14tstt1IYJrz8QLANMOfNjO3OSada/ca027T?=
 =?us-ascii?Q?pCJGFqXXq7PWdrUi+C6mu+FFDx9GXRMaQUpTdzOp9MFgbWsl3u+37fn/oLDp?=
 =?us-ascii?Q?z4QCaXh5ObBf0Yt3ygoGHFL4pRiBQTCBDhzjIzF+ACzZ4NYgEQYuLPaks8hi?=
 =?us-ascii?Q?7kS1YdxgUTcxJYeqNYXqFjfn45QRiLXQVj1d09l8VtIkcoJqXnVuNLqPQMyB?=
 =?us-ascii?Q?PKnOgf4YaR1J57uDQ4QmmNxA8lRjIJWxMNDTErC7vQhAJFTV/0nrIM+mf8PC?=
 =?us-ascii?Q?w8NA4rIZKwHIkdIa0u3YV/Hb+1WcPFWAkYgzBGWjmX00cSCkj0UgWBHccL4B?=
 =?us-ascii?Q?BqsqToEknGPM5h8KMICbP7gESZjvzkzcn+LoxNh1Za0MJWX9kYP31EbAXpsl?=
 =?us-ascii?Q?ai6M25VOniUgAAMG2TvDLw6R9QoF1Ml4J9GL5dFZjWsx5lSPeNfX1nWAnEgN?=
 =?us-ascii?Q?9xd1BonmFAmbreraA59GHmk4njRGRfF29BLizjff2T+pKTdqJ+1l4XI1A73x?=
 =?us-ascii?Q?yHOKNgK8mlWVvvOs/Kp7/FHTf2vfkwIyoHGXJ81t0fzzMN0YgOVjDvHemSWf?=
 =?us-ascii?Q?PIc1czhSEhOEJanHtirI62WTRfZ3xuNuEt33KuITs1sOgnmboTzg62VKvWcw?=
 =?us-ascii?Q?ZLDxRZJxJjGi55jj43I52oyRdOjfuMdlB+V+QXKBu08KEVzLuBWCAfB7fWMW?=
 =?us-ascii?Q?TIBCWSrM+BOASwsCn/jMXPQgmfvBs/7R+NojCn4wV3LvlDNSCsICvlFeIqvY?=
 =?us-ascii?Q?Z9wcjByE2HSnw3CtZkfhpkSmBTTJANcCkWx64N96jCqN3DiT83m2CuYRj0BR?=
 =?us-ascii?Q?qGaDHK9548lrDwZDqKBDmDx9PNkKLtCVnAyp3LbsgeSlpTGc9HjPRGoStQDP?=
 =?us-ascii?Q?uo9Ihn1CktU5jn6owScXQpTLl1GEEtmRIkR6dXN7DtXseYgQbLrqaycpvgNM?=
 =?us-ascii?Q?AETW0XssZ0C18bXnYEL3N5arLSwcnfYxYHzBfYyJByTXAci/ajaLv8/p9hN2?=
 =?us-ascii?Q?AffI1eCfk+iFGhsVzatKeCyzZbrClAhshJzk6Cyf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90293004-ee30-42be-738d-08dce21137b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:04:36.0187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWtKhhkHarPyUyD004ZNok9y1R4N3wwzj04pKj8KKCVP3xAMLEYom1tl58q3rM2VQGn6AfMZxaYNF57PXaZ6cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8533
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

The memory of priv and plat are leaked if max_bus_width is wrong.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 None

 drivers/mmc/fsl_esdhc_imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index a3defe952b2..debfc78b7f0 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -1327,6 +1327,8 @@ int fsl_esdhc_initialize(struct bd_info *bis, struct fsl_esdhc_cfg *cfg)
 		break;
 	default:
 		printf("invalid max bus width %u\n", cfg->max_bus_width);
+		free(plat);
+		free(priv);
 		return -EINVAL;
 	}
 
-- 
2.35.3

