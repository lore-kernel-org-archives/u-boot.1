Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E932CFD364
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21A3983F85;
	Tue, 25 Nov 2025 09:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="r43rCqbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 358D783F7D; Tue, 25 Nov 2025 09:13:36 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6440F83F7F
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 09:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRYEeMYxIFergsL4iL9nTiwbCwan3YQ7YRgdkTl0+snO2aP50Q/X/9Y0API54nJUvZNLYaQlwW6vHNoBGo1VxK2xUx9e+N2RqrCUoMEeIK5cqxrM1QXHzvR5cYRg2KQfTqLnztlh3gKcXXNr43Xm1Ymj9te+oAqorlTsn9P+49flbnCs3ESwJKq06L1Zqbt7Rrf5JBNdsuhrjvxVG6eW+TQCgSUp47ApyHN0EEfGMbrI8tWjV0MEni2VFUG7hmnUi1bfL4AA3rleAULI17n9vKwybqEJen6wlwHpP3fRfWOPpXlUuGYS6CYB8TTSAlxmAEtwEnpo3bKLWv5SPCBTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxNi39vIz5UWkc/HWOXcFuYXhHyDGpsetyDCPJAGUSo=;
 b=Sx1iXEVumKc63nJaBy0Nt8JcmsTknkusd8sLLhKL3wGYid2V6CkjBkhKazexIMeI0swaDbSK4D18o42GEyNYQwB9Wu7mExP9uKoj1iQJzxmrxoYHSspNUAtxY32MWRKGDLAF3v8a6UsxAlhPgQhaziXPIEOcuqGsMFbZLI1K5z8A8t0Bu9CwvpFD8Rg+jXRWlvd2PIPJHMSe0YFVQpVGZS5+qKq9ab5NVLlfYjffjAjiJUBhSIUHEgDAZtw7B5FTsI2E+hs5vknOQhSqChL8YSutR8RBe5gI7r0I3LYorCE56cflgrtfDWvh7wvoGwvUeUjj6mxEp8LomSORjOvhPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxNi39vIz5UWkc/HWOXcFuYXhHyDGpsetyDCPJAGUSo=;
 b=r43rCqbwqi1KGOOkDCDXifqm7dZg37rZsOiRczxa9gQyUNZnaGKDgIO1AupuoeC2kYQLCq9JuYTUBKvDviB8h13NFiWByybVzwo633NvjMDNYVSlmg9RLDxJQx3gQy9NXIGWz8ozX3MutfMOhP+gt/uF3J0wo69XC7bYUd7N2F4XtzN1q1szHEZ+oHQfR40Nn1VM5jLCYrG6XSNSwrgApXfHERbqYx76y6fmW6pQoJQJ4Cl/KQ6RntX+z9CGyXxVaDIVQFDpkJS+0dgLWKqWIbGlC1uL7SOhReM73GsGgmBmnnFpcM0OmRzEvDV+3D4dI8f+1S2HBHz2MtG8MqDlyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by DS7PR03MB5447.namprd03.prod.outlook.com (2603:10b6:5:2c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 08:13:29 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 08:13:29 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Brian Sune <briansune@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 4/8] mmc: socfpga_dw_mmc: Restore legacy clkmgr address
 retrieval
Date: Tue, 25 Nov 2025 00:13:12 -0800
Message-ID: <20251125081316.17329-5-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|DS7PR03MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ac643e-7ec2-4227-9ad7-08de2bfa8441
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QOht9E0dnvJEToIJZoXO8W9DD3XaOD+B59dTq6z+4hMapX1KpV5MkarfLOYt?=
 =?us-ascii?Q?F69PqnAHhorFsenZ7eAxI6beAmn7uluYzLn+km5pnOQkwVY/HXIYcg8m/Q6W?=
 =?us-ascii?Q?9b0GUcuRxsG9T/ufp3KJLHO5BjCcIs2BpMJSdMUiIRpQaoq2IY5Hr74+NjLS?=
 =?us-ascii?Q?VwV8EbKhNbLyb2n/deZrzOvD/4exjQgFxauONf179z4FhE572AUa45zS0e2z?=
 =?us-ascii?Q?e+InSq/9aA+fN3WfC2dCzib7LfvoYeGYRQkUE+yEKDes43FJ14ena5/4ZCjf?=
 =?us-ascii?Q?BS6UYu5i4BEoQkAU9N3DgZ9tZpnGVatyhHEId8cWfu1bLu94HsJKndl2ZF3h?=
 =?us-ascii?Q?XCzXICdhN2EUthfQqXPwpqBFI+JMt3ChAIBilhl67NlM5kZ9EAmZkWcPSNHU?=
 =?us-ascii?Q?FrV+oAJ/dQsl+1aj6B0MZlQcpBoLxe63401xR1Efmt6yjVxqMixm/450MPGe?=
 =?us-ascii?Q?I9rQsTW499pHvkgD+V3MAo/TyZgsFmiRJ9j5zZSqiU6tsbrRsz57fUvFVXTG?=
 =?us-ascii?Q?Uj3E49QlObbfex0nTjgn6jGCTjRFBLqkOvCfvIEnuTQZr7jKM8jyaFe4eM3r?=
 =?us-ascii?Q?AsOkVB8nH5/XpLac1iNP5HWFaNdmeoKojUWiZQoU97xZVjsaOQ2nKtBjXaWQ?=
 =?us-ascii?Q?6REG0XhIwS8p9Mky7b1vTYSxoiM5IvG9gR22M3VCEE5vX7H/y6p26itKXiAN?=
 =?us-ascii?Q?t1WZOLThjGJMnsytvilJ28JGNAej0i6lbLObCQAP30itLAQqEEXMfWfRdXzC?=
 =?us-ascii?Q?X0Q1ekUpRtB5Unf7PdtNoJ8DuVUAu9HdFQ0aATYnPIQbFlup2PnQQjzR78XE?=
 =?us-ascii?Q?xnGM7jgDmJnelCWpY33KauAWYVXrCzxsBIRXoF97Hwek6fBEG7Lz6mNpgyaN?=
 =?us-ascii?Q?2NHCLrOCBCnjWug/2SBkf16NGCybV/CSSZQy1diMk4QV7Dr3YZBR3lfyUbnW?=
 =?us-ascii?Q?PHHMtJUZZNOYUsc7LbPkHGJ4cxD66HZM4u5BA0iI2NdChRnfwoBr6xTdjQgz?=
 =?us-ascii?Q?cllef0nQE2aEoJFTC/UA1idbfWltaUwnueb2lrcZU6wFlboWGASCJIk9pWh9?=
 =?us-ascii?Q?uZCs/GXeHRBiG2Qq8Kt4h0hdAfHpkjlKFag8JXvRoPzwXnMqkCmbJTGlLca7?=
 =?us-ascii?Q?LnkCFI2u1wkAZZDqW+srV4mtH4Sw78+6eUyE7oD7MlmvMoLQUyxpQumF50ZS?=
 =?us-ascii?Q?bfzGOTOZOP8ILgi78rK8vRvj08trnlGazZllB/Akz7tBaM1+gy9iwr/wp4ti?=
 =?us-ascii?Q?2NbkOW6u7Lq5kVHTWVxNRm2oW/F8dlHZCUkEbGb+dWWZDuCv5muyOYMNPYqV?=
 =?us-ascii?Q?Bj5+v2746RwauEx7ZdF1h5KlKirlKMOzoYe/qsrHiEMsID0SS+li+DsXdzZT?=
 =?us-ascii?Q?paIkudnK4cbS/OXx4JtoHf9P2PTy1xUA6UhjT9sxFdCjO6ySvq+6c2aNoxZs?=
 =?us-ascii?Q?tIt5NCfQttAR4cute9TEOieeRbKRyu1z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yA45/4OJo0moWczRjVBklYD9EwKerS3WUj+JCwJEL/Wisqebs5zeqSSc+lZl?=
 =?us-ascii?Q?GSWU/9OeCor4bhI+uKCsEILx4RAf28RoAATL+jjaivvAqzn91wki74ocWlK8?=
 =?us-ascii?Q?UxSDBjtaPW2Ptk1WuUR+WsRd5f1X98F2QaQEsC/38EV87qb02ben/RaF7EiC?=
 =?us-ascii?Q?NHUAnElRvsT/ORu8fQWTfYjbvjYG1e6WD6ewABpNDG6UYU7cJ6aQKkKpIRpY?=
 =?us-ascii?Q?97DrCH5H/TcvS35xS1nqCIaOg2lB45Sub9fP/wWzxiUPXO3AfrarPSFLvbBn?=
 =?us-ascii?Q?urAFhuvS0WIChRy8IdkX0ZDhuKba2aET//pRlXSFg/+VXpD6LNvlWid/CkQl?=
 =?us-ascii?Q?vp1wiFPyQc+U9ya2qpZzF/zTOxuQKDyJKoTybJJi0CYlLhS9UY70Sppi+eLR?=
 =?us-ascii?Q?wpuoQ5w+druAmeMG1/orT1A3gr6c/GE+wfkZn1MhhLPG4e7lSq1hYzWydbMk?=
 =?us-ascii?Q?oGbtxy/n73L4Qg5LnizcT940XwOpN3p2E50J9bACrl3nbFj13QMXDhbzH6Ig?=
 =?us-ascii?Q?Qnmtu2v6TBpbTrqsLuPNKPu6YtyVo0OkZ+UoWY77zGMKk282q0hFHRt2JEe0?=
 =?us-ascii?Q?4oD+1+c3gLkdM2UEnjdFRt8wF3L7Rq6OcsDqwV3nkBwc/5VQYLumsUhjxjOl?=
 =?us-ascii?Q?2JoXIy69UINIrZkleuNRm31X+lGNvKVX3rfJ9cVZ1M9TYyOwLUuq4YjCY8Uz?=
 =?us-ascii?Q?FsbRx9LUFEuYu1znh84gz1taZJPmDxcI05IMG9Ij+txN8RBu4Hj3ckqwyG85?=
 =?us-ascii?Q?KV8OrdFdEWQRQ1+HjJ8kZYanN+jDl+TX40y93F9o4yoVTPKDHv38/msqiEEx?=
 =?us-ascii?Q?Czxh0ALpKiYPgK0EaZK2dcn4Nyn9TjtnfYrLXyvfIG2C2gNwJD2/zxa+uJFZ?=
 =?us-ascii?Q?nfEKNduCdXhwDdY/F3zkiRP1xoGlUR2llMCeKGeEH5wQZm2SWISnaBO98JP6?=
 =?us-ascii?Q?H+BhPl4V/stOMoM+3H9Amgn33dGcYc3cTmxk/U/H6/FvkLb0EPPfOJf2HQca?=
 =?us-ascii?Q?6sTfOMotdGbklce6G9m4SSzzYZ9pNamg9PND1PMZYRXgeV0rJA7E8VOjzr8v?=
 =?us-ascii?Q?y279/MEcAV2jxkL+igaMmZWfSHoNdb5O2/eJVX3vi+I5BgIj4/Zr4N8HmeOj?=
 =?us-ascii?Q?qERUeUGamuHPvMKGc2IbWCBnxL+pk77WRO3GRGpYNZvX8fSg6k+/1vNq+e/T?=
 =?us-ascii?Q?dncczLVw6SG3a6aKfABMCPeN4Uiug3XmlUB2mnPsqm5sG9voFe0Wyu3BDN9Z?=
 =?us-ascii?Q?KpB/DES+eGxPncD0VBM4ggM/wYYq8pUoBGnylBfI2ncx1HawD1urNBYAiXzc?=
 =?us-ascii?Q?WGVr2+CQbQneLu003Os0Rd54VktxwEGDbTlWuMNs32ixnlS8+CCzer01VDQI?=
 =?us-ascii?Q?Qhhh++B8nMDJ8I7UYdshp1OwWexM5sGUB+z45FKjB0FhFWGWWI97bvJXQNI/?=
 =?us-ascii?Q?X9HAIX5cwJLD1Cl4GycVheCFwpPGBcGFvZRD2ZrRckrTbD8TxPs535nGBqvZ?=
 =?us-ascii?Q?DoiTf/yqevXM1o9SlBJvkOwaYW679Kim4myurwLk2oBMgi4lpNfu48VKpkPc?=
 =?us-ascii?Q?CdvSNJQjq9t0E+hdN5ESCDJjtQi1rhpFBWQRvkceVQ0cqBh2uDZW2r4o4xve?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ac643e-7ec2-4227-9ad7-08de2bfa8441
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:13:29.4728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5zGC1vr8OdAWHbhKVkVT8NHtXCD/vTXGVx8dQixo3gHS6oHfxvn6Ht93ityMT8m2J4ouS7LbW/khw/3nz1lmLtygkHXsFkqwNUPJpU3R0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5447
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Restore legacy implementation of retrieving clkmgr base address from
mach-socfpga/misc.c driver for our legacy devices.

Excluding Agilex7/7M from this implementation as these devices' clock
driver is already following clock driver model and is supporting
enable/disable APIs.

The legacy devices' clock driver will have to be refactored to support
driver model which enables us to support enable/disable APIs for these
devices.

Fixes: ab27182cac8f ("mmc: socfpga_dw_mmc: Enable/disable SDMMC clock via API")

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/mmc/socfpga_dw_mmc.c | 46 +++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
index db4e0129c2e..6219284df3e 100644
--- a/drivers/mmc/socfpga_dw_mmc.c
+++ b/drivers/mmc/socfpga_dw_mmc.c
@@ -58,17 +58,24 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
 	u32 sdmmc_mask = ((priv->smplsel & 0x7) << SYSMGR_SDMMC_SMPLSEL_SHIFT) |
 			 ((priv->drvsel & 0x7) << SYSMGR_SDMMC_DRVSEL_SHIFT);
 
-	ret = clk_get_by_name(priv->dev, "ciu", &priv->mmc_clk_ciu);
-	if (ret) {
-		debug("%s: Failed to get SDMMC clock from dts\n", __func__);
-		return ret;
-	}
-
-	/* Disable SDMMC clock. */
-	ret = clk_disable(&priv->mmc_clk_ciu);
-	if (ret) {
-		printf("%s: Failed to disable SDMMC clock\n", __func__);
-		return ret;
+	if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
+	    !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)) {
+		/* Disable SDMMC clock. */
+		clrbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_PERPLL_EN,
+			     CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
+	} else {
+		ret = clk_get_by_name(priv->dev, "ciu", &priv->mmc_clk_ciu);
+		if (ret) {
+			debug("%s: Failed to get SDMMC clock from dts\n", __func__);
+			return ret;
+		}
+
+		/* Disable SDMMC clock. */
+		ret = clk_disable(&priv->mmc_clk_ciu);
+		if (ret) {
+			printf("%s: Failed to disable SDMMC clock\n", __func__);
+			return ret;
+		}
 	}
 
 	debug("%s: drvsel %d smplsel %d\n", __func__,
@@ -88,11 +95,18 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
 		readl(socfpga_get_sysmgr_addr() + SYSMGR_SDMMC));
 #endif
 
-	/* Enable SDMMC clock */
-	ret = clk_enable(&priv->mmc_clk_ciu);
-	if (ret) {
-		printf("%s: Failed to enable SDMMC clock\n", __func__);
-		return ret;
+	if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
+	    !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)) {
+		/* Enable SDMMC clock */
+		setbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_PERPLL_EN,
+			     CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
+	} else {
+		/* Enable SDMMC clock */
+		ret = clk_enable(&priv->mmc_clk_ciu);
+		if (ret) {
+			printf("%s: Failed to enable SDMMC clock\n", __func__);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.43.7

