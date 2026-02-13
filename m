Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E0DEDF160
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 13:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CC9283E23;
	Fri, 13 Feb 2026 14:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="xToDhIsX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B38080FA1; Fri, 13 Feb 2026 09:50:15 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B1383015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daDopgK+dk+AuUKJFptuej1oL9ricYPeZavdMYKXmayuRKwSjv0/Is6WeZDKCb1FTyWum/X0zJmYLtuUuBgg/Oi/tfXktgoeGq+X5hyt2ZnTBgnhNjBE2SHOGPnK+RPaWf4Lt4CdGRd37fTwAUnrmxG5r4TGEdcl2jGC/bwD2WhE/nC91dYPBECsqr04oqYt6UuMeASqTDctVDtyLBkdIOTlrX2O9LEetKUX9YBAbta+x51ohi8HFI5xYxM6/HIHn3KeD7MPNhyGROM9t/eiwptyC2L/XvXOeVCC5vXkJOq6ypp+LdfjDNKoYdXp0Yn3mX5L7SvHZlHEMOgNyXkpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6nnvtU1kvWtApGu7/jR0K1sJFvB92r11Fi/6/8bwWw=;
 b=LqRRx1A98/aiRD9K/zA56BDw4x3/OYCpBEQex9O50N+ZZSd3Aqq2jbbXpoWAxImctV+aOmQxMR8Z9mBuwrAgNyXslNPnXfv/BNQb4NlIZB+dFu507NAbDzjiDBWi97eFqExzMezs3zTQhS0X+XxejDz+204r3cJAxvkcN9znhqUW4TrgZfmAcQ5BF+4WYQEv3B17xJsBI1s8q5gMZU7OKf8voVRzvZmw1RtOLgsEmP0jlki1sibjdfeEpag3U2bLziRk7eqrbOW3/+KAf9wXhewukXFdVs6tQ/8BHEe+mP1HOeK8R6/BlVb5PefVAe1k2NKuOjvq57vkucCkCi1JWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6nnvtU1kvWtApGu7/jR0K1sJFvB92r11Fi/6/8bwWw=;
 b=xToDhIsXijiR0b7Yt1LoVuEzA22uCe3O/E4BSSRY2VkJ9Ggu3Ghqys1y4iF0WaRZHgkNAhlQ5bsIZrFaaLvn9XunAB6y1OplisiYVhXddh+TLgU6RaM2N7hRtCrQSh/ZiaFJlJe+i+ynwQmHemtc3ZbTTj40Md0rsEBIJN5+oeMOsSq+iAXsF7Tgz2NlyZuifp1mZ5J01nl0lq8DC6DadoJcK4/iDXoJIhgMc8QcEL16fNBlo/1ndiefnR91U8yV1HYv/vVTR78WdKasr1X/kvsHit7Md/A92GGi/oPV4yqwbd7x3vbZnalFkd6r9Vg76rcDsYcFmF961wPs4Qsepw==
Received: from CH2PR15CA0028.namprd15.prod.outlook.com (2603:10b6:610:51::38)
 by EA2PR22MB4730.namprd22.prod.outlook.com (2603:10b6:303:25e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 13 Feb
 2026 08:50:08 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::4f) by CH2PR15CA0028.outlook.office365.com
 (2603:10b6:610:51::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend
 Transport; Fri, 13 Feb 2026 08:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 08:50:08 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id A9228DBCE0;
 Fri, 13 Feb 2026 10:50:06 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v3 6/6] video: imx: ipuv3: use clock framework
Date: Fri, 13 Feb 2026 10:49:55 +0200
Message-Id: <20260213084956.1031000-7-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260213084956.1031000-1-brian.ruley@gehealthcare.com>
References: <"aYtUi1WdLPLEnv2X@zoo11.em.health.ge.com">
 <20260213084956.1031000-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|EA2PR22MB4730:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 26f20ac9-2ed8-4ae3-e76f-08de6adce3f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u6+w4uNf1fTtarAtnjSwgD7SpIhNTd3snuWjOZRBJYhrKsjQvIVY5pyUSpDm?=
 =?us-ascii?Q?gHLsUKma6reFXx4U6URW3lWX0iQ5ZxHwxIv+KEKkPGA9Ys2H5RwSyKGvmN67?=
 =?us-ascii?Q?jYwprTGWmc5yNGNtvBm2Lr+/Ki+zbw2hY0ZwHBwIdkbA4y4ribZAoxMk/rFr?=
 =?us-ascii?Q?jmb1vFPJ34e0Bedvwm72Q8sv2gOm6m8Ixn1xpa2LRYEYrDofi1yiAlTW8Pbn?=
 =?us-ascii?Q?WdU6Gh1fRGmyAjLNkyzh6KmQyJYOIkJ/lAJvdQzaJPeWnFMddIqUcjloUdMV?=
 =?us-ascii?Q?+SONXO3Y/aXOS/4HhQ2JbzZpJJ7JlYuMeemO/2MkZf2hxj1nIVb13dVFr5Qg?=
 =?us-ascii?Q?LreWwauoDpcehxJP7FgziZVCVX7X8I5xCKtjJIkeZBCPq8bhx0L5pve7ALbx?=
 =?us-ascii?Q?Gd2ToZXyfih43pX9wFjRR/IEodj4T/13nWIWLFjmLrr3AWTdu0Olg0+71RLF?=
 =?us-ascii?Q?EnH3p7kCV5WKDWxY7iCAI4lDXiea0n7pu7YyHgxqaQzjsWmqGvTPC0zXgQ3l?=
 =?us-ascii?Q?fIdp150dBHIPDNmOGqDlTLStgLPzyFflyveIL59de15TRyoeqEFsQnhNtBfH?=
 =?us-ascii?Q?xGtLF6XdqubzVZM1bMUb/PunRgvWGabx/PYU2o9UWl8nnRJR0bT9iDQNXG6s?=
 =?us-ascii?Q?cq1e8F6Zbo1KJIXNyj3cHLf8qRiXgcd6h8jeDjFrkF19lW3eBzgRK5MXW3dJ?=
 =?us-ascii?Q?xx85f4Rr6YRdQ/hqheaNIxyrSVnt3UmFKrtz2G4cVghsPx3vh1Y0S4Oo5Cqt?=
 =?us-ascii?Q?UuZ3xqb7mAudxS7dysDsj7xtPVrssR326xjBdzhMnxMuIP7QdetKrCenibeV?=
 =?us-ascii?Q?N/vt4ItXByjZA2scHQFbSxX3IvNKrd8odq2PLUTCLOzDDpWCFGOfWAzfm00b?=
 =?us-ascii?Q?U2Rxg0DiZUzuuf5sMuTRaBlSlxp95sOqo2C6TTcObijDQZAbb2iBu2WA2Vvn?=
 =?us-ascii?Q?TPDUtZD7RJUAJ5uHDvknRFRHA313W2zEBj6GSqGdRICqakqe0rqAw2AWAfK9?=
 =?us-ascii?Q?WCpl2hup05RW1kNjRCUHwGeTWHoFfYwuU9pFxkidtLqtr9041YcICcSHIWsB?=
 =?us-ascii?Q?WvLq5EpJsU75C+O2Ya6kjpb6eROyk//Ukdna1m5K0M+kv2JHpmHaSoT4GqLi?=
 =?us-ascii?Q?mZXSGY5J2GPhMhrDe8CQ14xNx/E1MqFEm1NfV40flT4y89ByWGcrnukVUnCy?=
 =?us-ascii?Q?oTxuub4CxMeEJCRFICO1fSB4xlmLgdYsakQyudd+ZYRvZ2AKd0lTtjMzWx89?=
 =?us-ascii?Q?aX+EVK/vcA96YPiKNBMX+vIIIVImzhzTrH1VkoyGQ/kFz+Fl7WZkTERnSjDk?=
 =?us-ascii?Q?X7Eiju4BjBqWeotVtTGaNMfZMT22l/zURoka6882w1I3nTkatiXwpVt57LIC?=
 =?us-ascii?Q?9bCNIOz0pBxR2jsFJimnrIq+ALixf7QPpE8WcSc1Sp11xaX7V9GJARMN51VX?=
 =?us-ascii?Q?b98Uk+ISGsfRLQeUnakDvBxGHp/dAr3kxQhiWDTOlAs6E0EBfD3BGdnbgewe?=
 =?us-ascii?Q?gcLoN6Gm8VP1HTw8qNhkFgVkAiD2wthGfld532Ny6PBwH3mOcLwzwF77M8NP?=
 =?us-ascii?Q?a6gSpAuWHeEv7QdlBJwduxmDQxezyrwBySz3NGuEoWPevT6gdqsMlzSt9FyO?=
 =?us-ascii?Q?pRuDiUbjN+pu0BjTQiaWIayXslozE96edMTlyHLzKKwS3gXNt0z/j3uZQKfI?=
 =?us-ascii?Q?o77Mcw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DJIQ1/o460u7h+Q3sy7ZL9SBdNpvJW33cVjGCK/bFTMxtEq7d0cenw1V3tm8RAbdQlwXuQjVDER47emPBfyumqHtA+EHwGcfp2gcFVmmm0QGaNAmpRi0bk5PwVMu1+GLg6N3kPeqf7f6YJnZX6qlo8Nys4a1aaicN9531uHnLQm6fPLeGw8WNHOAbngnIo/Y1dutSAQah7OtfCEzKCn0p7KnFIX479VsmFvcjJ3Xjl3jTCFup7HsNlDt2K6o1KUUTf3dTrriKkJgK7rT6nOUfN2isudp2mJaoN1Snw1c3CX5UXWrH9dJLjp7hgLHtRC43dSS/SxdeWVgApJQmIoPnWiAXrPZs6EWWgkthT/E2AWy8g6GajA5OyXCMG1k6/YpFP3ywVifydV+d2iw5epE43aq9PPdyVPEQZBjiHrcIc69UIuYR6Dq6SC4JKt2QQZi
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 08:50:08.2187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f20ac9-2ed8-4ae3-e76f-08de6adce3f9
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB4730
X-Mailman-Approved-At: Fri, 13 Feb 2026 14:24:08 +0100
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

(no changes since v2)

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

