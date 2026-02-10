Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F4CEA8109
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 12:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 567FE83DDF;
	Tue, 10 Feb 2026 13:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="vs8FBxec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D14C83CEA; Tue, 10 Feb 2026 10:00:59 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 976A48309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 10:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMg250le6TnKa3DhJXbJdy3/ZRuDjtSXLfqh8OZgZDiO/wPtX5T1Od7MOQCspWKfiSKMdEytk5iNOUapVi1Ie+tEvPwvRZVGCcwp2LwrpYHT7gLOYb1mV3/tc8e3HJgTr4SPg/7MyZ3j6vNegiqfyTZu5kArwGjViBEtJgjJqb6vdeZuvFFkY8Q73SJ02yUMsvvvqBTKvqTAP4njZjswY8/vdo4wdTTls1wi+/sIhVrfcRgOCarkkGqdzw8D/1tNiHBlNhzc//VfMzuY3RTNV+DcEl/JhscTftCS6Kt+yBaZsGutLSUvtj7w4vznKRA9jsqlNRw4Pc9Fe18THngI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqQOZFNCT5FSCVQbTMxrO20l6tRo9Kz8g660J/tgnUc=;
 b=d7dVQOnM1Uguo0tqldbvIRe/zz9YpXzMmvX2PKhUNTUIwuBH+03Kbt+y+/VUIxBr3x4+lZn61rs+fiqOROMYfWklS9dz3gmswTo95adHkL1cCwvdNleVVI2wvG16TMeuMK05gxH9YC3aU+flDagbueYf+MeG9oPf7hbB8CPv0zDcR1tOe1wdRZpoHBIlEHvh5SyNxNwUbA77v8/zNy+kpJ2UmJ3cJCrwpCkhXFndaZ+ulmf5MG+xujn9YFdWyJ0XP8aNKeZ+Vzm4auIBFcjg9v/MbI2KNv6sFyiI8YPHSkBYcRTYolP6xEF1JEc462XEbqCUD+lu7FyLyksoyWXNCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqQOZFNCT5FSCVQbTMxrO20l6tRo9Kz8g660J/tgnUc=;
 b=vs8FBxecxqXIcwGAMDI5eG8CSAwOlf+eMfH+mANTcmBD5pMNGzAMWl8O8BV9D5TYPd9bmroN8cxZMel1zNPU7X7HTEXZXlKK0NCH0pYJ99OJ7IztH1P/FPMd2oLX1zW3UBxit9WRI1bQli3ypAwfTt8nhhlnYommPiWhvcGsBpuv4G+/1h1voMxJ/UaKFURNmEvEJ4YysUvn+xjUY7HItXC532WJ9RSzoQszFtVQijvWnG7d61JYvn6o/jvt/EB0ROmh4hJ0LW3l2Amm717sZeRHgCG1ks+pK8HVW4gUo1ZSpXV0Et2L3+jps9DIV1vJVo2qdO9tIZjc1fET+tRh+Q==
Received: from MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26)
 by LV3PR22MB5872.namprd22.prod.outlook.com (2603:10b6:408:26e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Tue, 10 Feb
 2026 09:00:51 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::39) by MN2PR16CA0057.outlook.office365.com
 (2603:10b6:208:234::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 09:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 09:00:51 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 0C145F882B;
 Tue, 10 Feb 2026 11:00:49 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v2 6/6] video: imx: ipuv3: use clock framework
Date: Tue, 10 Feb 2026 11:00:28 +0200
Message-Id: <20260210090029.728636-7-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260210090029.728636-1-brian.ruley@gehealthcare.com>
References: <"20260205141332.2515996-6-brian.ruley@gehealthcare.com">
 <20260210090029.728636-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|LV3PR22MB5872:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 68853ac9-6175-49ac-2d48-08de6882e407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?foMAyw73Y34MiHyxMTzIx2CEHOz9SON+yASQ9cSdRrYAEPxVwnyFAeVxnFw5?=
 =?us-ascii?Q?M08fm+ukUP5y6JCOZPbq//pZPtQxRWyaiPoPkjIC9LNRqBZAGkvRRS/sYUe6?=
 =?us-ascii?Q?ngtXNKnARgiPV71AZ2vjP80yxIvVdM4RKsTpY+ijS1Pim1ZKJCF7zDTjndhp?=
 =?us-ascii?Q?j0TMOwnl44F+P7QNKmyZuC8HxaburaHCVAMsuBpbvf88WAH8xoaPE+UI4Hxx?=
 =?us-ascii?Q?HyxwB5hrehpgiHFyAcTkds7/o6cddGE4UDm3bmMpjovdgi0jpoJLyfFE7s0h?=
 =?us-ascii?Q?2R40hYLp4dfSiWiPKZ+6c6lghytLQrMADV5+7gEW9yvfCS+l6L9e1sDTQh0V?=
 =?us-ascii?Q?RUlEMpJN0+nOLqtObrlWHGqPQQPKIkh+BbhqeZqm46369VcVDtDNvK3U6dA6?=
 =?us-ascii?Q?rI22HV7f6tXeNLB+CwyPP2HhJ7KEibQMt13xe1qwLapuk6Qz2A8pWPQ2XqXL?=
 =?us-ascii?Q?BP6N+gs3hn21MsFj8N5sb8iTJMnFBLDAFugFpcIS1kfDtHqmmi3GpukJwhvk?=
 =?us-ascii?Q?CdIbsCjeq8JChG/nPkuxL3n//JY4idnpIyUTAr/weLkFo0ce2l0MwWIz5e4N?=
 =?us-ascii?Q?RdozH8wt1MnYiKrfDK78GkA5S11h3pL1vgoWFLqtPB6uhcQQtT3d2VAddHZM?=
 =?us-ascii?Q?v95BToO+j+p8wPmwpHlr1cpe3WzWF2fwmkZuzY1zrCd8DGCrkBZuoOLTLCo8?=
 =?us-ascii?Q?7u0o2ZhTkgjHWqG847cp2tVl2vRa0bXs6Y/7Le7VwhSfMRE40CinpgEceLKw?=
 =?us-ascii?Q?F65dJdIKitfptToEduDqRF2bbpUSDu/EcxIF/rI5lwEiKLIX05EVAXDHnmRA?=
 =?us-ascii?Q?QZbOeuamMy6pPOW6tF4mOnmhtCqSXXPOKGFFl61UMoSlxdb3CIoeH9aBOAPi?=
 =?us-ascii?Q?KClQmFEjWDfm0e/E3ewfTLx1zt5dwDrtSNEi6XOUQNCJj3k64MjDNP4+BFB5?=
 =?us-ascii?Q?9sumNthz0a3t4JsakXt2L8l4hACpHY1X/mX8p10KebPKxKU/iGVehsDZ6IK4?=
 =?us-ascii?Q?0yi1EGeRxObRZTDACSDwYLHVjzcoIAT9M7wtVQu1hh/z9u5Q2N4wTV2AfmXH?=
 =?us-ascii?Q?vDeZ/SrJNhUCrcWVxVsGF2b62PgWm6jD/4eQntzWQu5gbbYhOzrWdKLA0PMr?=
 =?us-ascii?Q?xLxT1YwDrEXg+IENR8K/ngrphN0ELYOMJDYHxMkxpnKjBMhLcWafxWtW4Ri1?=
 =?us-ascii?Q?w2h45IEF2fYgTSd4PLP1qk248r4U8iZOUTroqMOO2nz3AlRfYsbcnM747KYi?=
 =?us-ascii?Q?tcIv/uNKrnwlnp45h+GSLSYI/oDjlHDX6OPoKInK9yA12Zel0bfgwt71VjiY?=
 =?us-ascii?Q?3DoE9PapVtg+WVka0pxwfbc2FFOn8yp/Bf8kCP36dIF5qNtcpUiWY+mqjhEG?=
 =?us-ascii?Q?Wj/DWUaYa2R7KpcS+AvdDshlEUsY/ADam5Ul/LpWqDCxVkZeUhzV4pkdVz5g?=
 =?us-ascii?Q?kUqG1mOGKK7sCg+cL9R1BJNDZI1WnOQOvD9zV6nsfkwxk/RELPXjxYqanauC?=
 =?us-ascii?Q?a9D3Fv03E2+i8x+OlJyuo5qbvLVMiFaPDafqXMsBLa1Tk9rTcTiQhBlyTdzQ?=
 =?us-ascii?Q?V1tTNtVCWikv1GL+N0HMihMFpjPZQpjII02s/FFv1Ri/4TPph5iQ1Um3+dxT?=
 =?us-ascii?Q?/uVYBBmw/Q0+WeNc5o3NAs/GeQ8Ti/7qt3Exdgjgm3+GHFLUZJjMiLyMgckH?=
 =?us-ascii?Q?/dMumQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KswyKTANgrA0E0vpmhav7jU7lAyxUbDooHlSW9oF9lNusfT1q18SJ+I0SQnLWvVbf05Zdkf0od9AssWzeUjOZ6yYuGvQoQkH0iXsTvt2ZoPGDf1macbZVrgj+ZROZn+jYeaY+NOJ8cmKvmtiJGAmDvpv2CLjhV4HdBLZaYqgMWkHV2bGJoAusIhP8TsmwKArlDRBzdMyVHYbuYMY3UERSVekccXFTRHSAAqcFjnn6b01qLdC9EYheQmI4H3wDZcXkbWxHdoZzF1++9cXs4sOUZKIgbbrKcpeaflXiLY9bg9h0kZOEolVfFJlquRcDAJXXBy9920WFMASgQeOeWRDAf93YIaK6ohjRkgllphNWuy9MX8uDhVGO8bESJ3psBn8zaLKoTzwTAKB6c5B9ObSEF1AYYTkZtylVVAkzr+834cZAVc8PWZWmzpJvC4dyJwV
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:00:51.2269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68853ac9-6175-49ac-2d48-08de6882e407
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB5872
X-Mailman-Approved-At: Tue, 10 Feb 2026 13:41:53 +0100
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

Clocks are now configurable via the common clock framework, however,
users have the option use the legacy clocks if desired. The intent is to
keep the changes minimal for this old SoC.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

Changes in v2:
- Removed DEBUG define that was missed

 drivers/video/imx/ipu_common.c   |  75 +++++++++++++---
 drivers/video/imx/ipu_disp.c     | 142 +++++++++++++++++++++++++------
 drivers/video/imx/mxc_ipuv3_fb.c |  17 ++++
 3 files changed, 196 insertions(+), 38 deletions(-)

diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index d994053394f..8630374a055 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -101,7 +101,18 @@ struct ipu_ch_param {
  */
 static int ipu_clk_init(struct ipu_ctx *ctx)
 {
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
 	return ipu_clk_init_legacy(ctx);
+#else
+	struct clk *clk;
+
+	clk = devm_clk_get(ctx->dev, "bus");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ctx->ipu_clk = clk;
+	return 0;
+#endif
 }
 
 /*
@@ -113,7 +124,13 @@ static int ipu_clk_init(struct ipu_ctx *ctx)
  */
 static int ipu_ldb_clk_init(struct ipu_ctx *ctx)
 {
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
 	return ipu_ldb_clk_init_legacy(ctx);
+#else
+	/* Set this in the FB driver where we know the display id */
+	ctx->ldb_clk = NULL;
+	return 0;
+#endif
 }
 
 /* Static functions */
@@ -150,6 +167,29 @@ static inline void ipu_ch_param_set_buffer(u32 ch, int buf_num,
 #define idma_mask(ch) (idma_is_valid(ch) ? (1UL << (ch & 0x1F)) : 0)
 #define idma_is_set(reg, dma) (__raw_readl(reg(dma)) & idma_mask(dma))
 
+/*
+ * Function to initialize the display clocks
+ *
+ * @param   ctx	    The ipu context for which the function is called
+ *
+ * Return:  Returns 0 on success or negative error code on error
+ */
+static int ipu_di_clk_init(struct ipu_ctx *ctx, int id)
+{
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
+	ctx->di_clk[id] = NULL;
+	return 0;
+#else
+	struct clk *clk;
+
+	clk = devm_clk_get(ctx->dev, id ? "di1" : "di0");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ctx->di_clk[id] = clk;
+	return 0;
+#endif
+}
 /*
  * Function to initialize the pixel clock
  *
@@ -159,7 +199,12 @@ static inline void ipu_ch_param_set_buffer(u32 ch, int buf_num,
  */
 static int ipu_pixel_clk_init(struct ipu_ctx *ctx, int id)
 {
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
 	return ipu_pixel_clk_init_legacy(ctx, id);
+#else
+	ctx->pixel_clk[id] = ctx->ipu_clk;
+	return 0;
+#endif
 }
 
 /*
@@ -230,33 +275,39 @@ struct ipu_ctx *ipu_probe(struct udevice *dev)
 	ipu_cpmem_base = (u32 *)(ipu_base + IPU_CPMEM_REG_BASE);
 	ipu_dc_tmpl_reg = (u32 *)(ipu_base + IPU_DC_TMPL_REG_BASE);
 
-	ret = ipu_pixel_clk_init(ctx, 0);
-	if (ret)
-		goto err;
-
-	ret = ipu_pixel_clk_init(ctx, 1);
-	if (ret)
-		goto err;
+	for (int i = 0; i <= 1; i++) {
+		ret = ipu_pixel_clk_init(ctx, i);
+		if (ret)
+			goto err;
+	}
 
 	ret = ipu_clk_init(ctx);
 	if (ret)
 		goto err;
 
-	debug("ipu_clk = %u\n", clk_get_rate(ctx->ipu_clk));
+	debug("ipu_clk = %lu\n", (ulong)clk_get_rate(ctx->ipu_clk));
 
 	ret = ipu_ldb_clk_init(ctx);
 	if (ret)
 		goto err;
 
-	debug("ldb_clk = %u\n", clk_get_rate(ctx->ldb_clk));
+	if (ctx->ldb_clk)
+		debug("ldb_clk = %lu\n", (ulong)clk_get_rate(ctx->ldb_clk));
+
 	ipu_reset();
 
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
 	clk_set_parent(ctx->pixel_clk[0], ctx->ipu_clk);
 	clk_set_parent(ctx->pixel_clk[1], ctx->ipu_clk);
+
 	clk_enable(ctx->ipu_clk);
+#endif
 
-	ctx->di_clk[0] = NULL;
-	ctx->di_clk[1] = NULL;
+	for (int i = 0; i <= 1; i++) {
+		ret = ipu_di_clk_init(ctx, i);
+		if (ret)
+			goto err;
+	}
 
 	__raw_writel(0x807FFFFF, IPU_MEM_RST);
 	while (__raw_readl(IPU_MEM_RST) & 0x80000000)
@@ -278,7 +329,9 @@ struct ipu_ctx *ipu_probe(struct udevice *dev)
 	/* Set MCU_T to divide MCU access window into 2 */
 	__raw_writel(0x00400000L | (IPU_MCU_T_DEFAULT << 18), IPU_DISP_GEN);
 
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
 	clk_disable(ctx->ipu_clk);
+#endif
 
 	return ctx;
 err:
diff --git a/drivers/video/imx/ipu_disp.c b/drivers/video/imx/ipu_disp.c
index 6a337b13af6..5e78574da9b 100644
--- a/drivers/video/imx/ipu_disp.c
+++ b/drivers/video/imx/ipu_disp.c
@@ -612,6 +612,11 @@ void ipu_dp_dc_enable(struct ipu_ctx *ctx, ipu_channel_t channel)
 	__raw_writel(reg, DC_WR_CH_CONF(dc_chan));
 
 	clk_enable(ctx->pixel_clk[di]);
+#if !CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
+	reg = __raw_readl(IPU_DISP_GEN);
+	reg |= di ? DI1_COUNTER_RELEASE : DI0_COUNTER_RELEASE;
+	__raw_writel(reg, IPU_DISP_GEN);
+#endif
 }
 
 static unsigned char dc_swap;
@@ -702,6 +707,12 @@ void ipu_dp_dc_disable(struct ipu_ctx *ctx, ipu_channel_t channel,
 
 		/* Clock is already off because it must be done quickly, but
 		   we need to fix the ref count */
+#if !CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
+		reg = __raw_readl(IPU_DISP_GEN);
+		reg &= ctx->dc_di_assignment[dc_chan] ? ~DI1_COUNTER_RELEASE :
+							~DI0_COUNTER_RELEASE;
+		__raw_writel(reg, IPU_DISP_GEN);
+#endif
 		clk_disable(ctx->pixel_clk[ctx->dc_di_assignment[dc_chan]]);
 	}
 }
@@ -765,40 +776,21 @@ static int ipu_pixfmt_to_map(u32 fmt)
  *
  * @param	sig	Bitfield of signal polarities for LCD interface.
  *
- * Return:	This function returns 0 on success or negative error code on
- *		fail.
+ * Return:	The integer portion of the divider set for the pixel clock.
  */
-
-int32_t ipu_init_sync_panel(struct ipu_di_config *di, ipu_di_signal_cfg_t sig)
+static u32 ipu_di_clk_config(struct ipu_di_config *di, ipu_di_signal_cfg_t sig)
 {
 	struct ipu_ctx *ctx = di->ctx;
 	int disp = di->disp;
-	u32 reg;
-	u32 di_gen, vsync_cnt;
-	u32 div, rounded_pixel_clk;
-	u32 h_total, v_total;
-	int map;
-	struct clk *di_parent;
-
-	debug("panel size = %d x %d\n", di->width, di->height);
-
-	if ((di->v_sync_width == 0) || (di->h_sync_width == 0))
-		return -EINVAL;
-
-	/* adapt panel to ipu restricitions */
-	if (di->v_end_width < 2) {
-		di->v_end_width = 2;
-		puts("WARNING: v_end_width (lower_margin) must be >= 2, adjusted\n");
-	}
-
-	h_total = di->width + di->h_sync_width + di->h_start_width +
-		  di->h_end_width;
-	v_total = di->height + di->v_sync_width + di->v_start_width +
-		  di->v_end_width;
+	u32 div;
 
 	/* Init clocking */
 	debug("pixel clk = %dHz\n", di->pixel_clk_rate);
 
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
+	u32 rounded_pixel_clk;
+	struct clk *di_parent;
+
 	if (sig.ext_clk) {
 		if (!(g_di1_tvout && (disp == 1))) { /*not round div for tvout*/
 			/*
@@ -830,13 +822,109 @@ int32_t ipu_init_sync_panel(struct ipu_di_config *di, ipu_di_signal_cfg_t sig)
 		if (clk_get_usecount(ctx->pixel_clk[disp]) != 0)
 			clk_set_parent(ctx->pixel_clk[disp], ctx->ipu_clk);
 	}
+
 	rounded_pixel_clk =
 		clk_round_rate(ctx->pixel_clk[disp], di->pixel_clk_rate);
 	clk_set_rate(ctx->pixel_clk[disp], rounded_pixel_clk);
-	udelay(5000);
+
 	/* Get integer portion of divider */
 	div = clk_get_rate(clk_get_parent(ctx->pixel_clk[disp])) /
 	      rounded_pixel_clk;
+#else
+	struct clk *clk;
+	u32 clkgen0, di_gen;
+	ulong id;
+
+	if (sig.ext_clk) {
+		/*
+		 * Bypass the divider, assuming synchronous mode
+		 */
+		clk = ctx->di_clk[disp];
+		div = 1;
+	} else {
+
+		ulong clk_rate = clk_get_rate(ctx->ipu_clk);
+		u32 error;
+
+		div = DIV_ROUND_CLOSEST(clk_rate, di->pixel_clk_rate);
+		div = clamp(div, 1U, 255U);
+
+		error = (clk_rate / div) / (di->pixel_clk_rate / 1000);
+
+		/*
+                 * Select IPU if the rate is within 1% of requested pixel
+                 * clock, otherwise, use the DI clock
+                 */
+		if (990 <= error && error < 1010) {
+			clk = ctx->ipu_clk;
+		} else {
+			clk = ctx->di_clk[disp];
+
+			clk_set_rate(clk, di->pixel_clk_rate);
+			div = DIV_ROUND_CLOSEST(clk_get_rate(clk),
+						di->pixel_clk_rate);
+			div = clamp(div, 1U, 255U);
+		}
+	}
+
+	clkgen0 = div << 4;
+
+	ctx->pixel_clk[disp] = clk;
+	debug("new pixel rate: %lu Hz\n", clk_get_rate(clk));
+
+	id = clk_get_id(clk);
+	__raw_writel(clkgen0, DI_BS_CLKGEN0(id));
+	__raw_writel((clkgen0 & 0xFFF0) << 12, DI_BS_CLKGEN1(id));
+
+	di_gen = __raw_readl(DI_GENERAL(id)) & ~DI_GEN_DI_CLK_EXT;
+	if (clk == ctx->di_clk[disp])
+		di_gen |= DI_GEN_DI_CLK_EXT;
+
+	__raw_writel(di_gen, DI_GENERAL(id));
+#endif
+
+	udelay(5000);
+	return div;
+}
+
+/*
+ * This function is called to initialize a synchronous LCD panel.
+ *
+ * @param	di	Pointer to display data.
+ *
+ * @param	sig	Bitfield of signal polarities for LCD interface.
+ *
+ * Return:	This function returns 0 on success or negative error code on
+ *		fail.
+ */
+int32_t ipu_init_sync_panel(struct ipu_di_config *di, ipu_di_signal_cfg_t sig)
+{
+	int disp = di->disp;
+	u32 reg;
+	u32 di_gen, vsync_cnt;
+	u32 div;
+	u32 h_total, v_total;
+	int map;
+
+	debug("panel size = %d x %d\n", di->width, di->height);
+
+	if ((di->v_sync_width == 0) || (di->h_sync_width == 0))
+		return -EINVAL;
+
+	/* adapt panel to ipu restricitions */
+	if (di->v_end_width < 2) {
+		di->v_end_width = 2;
+		puts("WARNING: v_end_width (lower_margin) must be >= 2, adjusted\n");
+	}
+
+	h_total = di->width + di->h_sync_width + di->h_start_width +
+		  di->h_end_width;
+	v_total = di->height + di->v_sync_width + di->v_start_width +
+		  di->v_end_width;
+
+	div = ipu_di_clk_config(di, sig);
+	if (div < 0)
+		return div;
 
 	ipu_di_data_wave_config(disp, SYNC_WAVE, div - 1, div - 1);
 	ipu_di_data_pin_config(disp, SYNC_WAVE, DI_PIN15, 3, 0, div * 2);
diff --git a/drivers/video/imx/mxc_ipuv3_fb.c b/drivers/video/imx/mxc_ipuv3_fb.c
index ab416fdd33c..cfc34972ad1 100644
--- a/drivers/video/imx/mxc_ipuv3_fb.c
+++ b/drivers/video/imx/mxc_ipuv3_fb.c
@@ -36,6 +36,7 @@
 #include <dm.h>
 #include <dm/devres.h>
 #include <video.h>
+#include <dt-bindings/clock/imx6qdl-clock.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -602,6 +603,22 @@ static int ipuv3_video_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
+#if !CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
+	if (of_machine_is_compatible("fsl,imx6qp"))
+		ret = clk_get_by_id(gdisp ? IMX6QDL_CLK_LDB_DI1_PODF :
+					    IMX6QDL_CLK_LDB_DI0_PODF,
+				    &ctx->ldb_clk);
+	else
+		ret = clk_get_by_id(gdisp ? IMX6QDL_CLK_LDB_DI1 :
+					    IMX6QDL_CLK_LDB_DI0,
+				    &ctx->ldb_clk);
+
+	if (ret < 0)
+		return ret;
+
+	debug("ldb_clk = %lu\n", clk_get_rate(ctx->ldb_clk));
+#endif
+
 	ret = mxcfb_probe(dev, gpixfmt, gdisp, gmode);
 	if (ret < 0)
 		return ret;
-- 
2.39.5

