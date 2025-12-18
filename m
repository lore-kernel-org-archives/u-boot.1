Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B52D6ACF7
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 12:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D303C83DE4;
	Thu, 18 Dec 2025 13:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="u7n3P+0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A161083D6C; Thu, 18 Dec 2025 09:33:40 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F06C83CF3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=no+rwhKqaCmV12Xc0LIrSVQzrxnhR4LXnejZ5xXM0useVobsmrEO27Fc+BUOsGqXKU5IuBPEUjbMgF5bBdtzJ7wA0b5T3Lja3MfSUYacSBW3dmYvprtCfZE4xTGJXQf1Di9bL3rfdJOcleKIqlfqq6i5Z5CaLhZAn31CT2egg4+f5AKANmT+Tzr4F4iXmM9q5VFVTAOwpBACL1FZfWdRrcEnf2MMlKGpdb7hcRNcPjCq9+taVES68rTTAiJNN4syY8gzSzcLI1CPWA2uXlP21/+FTVJnLzUW8i9SuTcdOfS9Ed11MSrwOzqB0B8GEadbUlUbavey9JuVJTHh2vZ50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A/k9rx/vQyOjIByX7CG8JZMZYD27rSALidg88LxrsE=;
 b=yiIWNl4umTGrh2Yw6tzppsOd6Zkw5YzMIrIaxmejOHDLKFEkEDwNK2fZ5H18SllW056GwRQ36P01QNXSUqyqQbvF6s6QquJPLCjkbuGD3UEJOKe3D/fMkQR/DMfNMahlNWIx39VKck1r0pdBEGJhXQjUtPr92np7zUmp2VKRwJADttITvOjCH8ezLXshsZTJfLFMxDfgv3j0BZhgSBil6OhmEDBR0A0Zxd5HmrIWrC20b6m1rJbX/qhV2YDacFOb5ylzcesMbzcdZcOZoIjrODlskELe7MA4TDUIPGsX27a2sG41XYZS60cJBF0IY19X4MNvDgo8t2/ImGKF0LYjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A/k9rx/vQyOjIByX7CG8JZMZYD27rSALidg88LxrsE=;
 b=u7n3P+0GdOJYfiVWNuOLpJ7v9yucDv8TFwYZj4Anwdm5Y11JNs+wq4DE9nOWwwru7ZNjAu4Nu7sOPN8mAyQE1MbApLwSzxZ+PrP24v1+5jfjz8ocl40lDa1HVCnyLJgARlaJRqYfeHJs0A7j/ihMTgR5fQeCKvRNjJ7mNNv+EQHa5LlnZMaA0BnF/mcl1cGK645coVPCyrQYQXilNdooaufRfmI6s9+27txv+8w34zkZMvepHor9deNLeh9F/JpiOF8sk+IyBC5TaKS2dIVDXlPmd5cRp3aCvoVVatmNk8wCYD8Q1/hs1x6fXC9OXwKGbVYXXzhguMNa2qkn3e2/5g==
Received: from DS7P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::7) by
 IA2PR22MB5650.namprd22.prod.outlook.com (2603:10b6:208:4b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 08:33:33 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::1a) by DS7P220CA0005.outlook.office365.com
 (2603:10b6:8:1ca::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 08:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 08:33:32 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 7B800F2E66;
 Thu, 18 Dec 2025 10:33:30 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v1 3/7] video: imx: ipuv3: prefer kernel types
Date: Thu, 18 Dec 2025 10:33:22 +0200
Message-Id: <20251218083326.644326-4-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
References: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|IA2PR22MB5650:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a0cd8d3-215f-4d46-9b10-08de3e102119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ieNgkDu0RuMHOBxt45KXDZa5MyksRV/WBM5ff7IBVXU/6N2m3VmhJV1s6toe?=
 =?us-ascii?Q?RKP1Lzng8PK2eITq0ls4KgoFAkVGyrxJ0l17RMz8J9zZnhBUMkKQvBtLY9tq?=
 =?us-ascii?Q?HG5PFd4U/8gmHPaBQEzqmbJiDnxIoHByuLnmOLspYSFw9AhnbzEtixbKOHbM?=
 =?us-ascii?Q?Gz3G19OfLP5ycE8ZGgqASjMy003scKbITousg381bwJYNJB1zO9PE8vfbsMJ?=
 =?us-ascii?Q?MW5qu2XHpr/vuZZJhTP6tBstToKgnbiXtv6j8aIY0peyGKOGDJ8rUrv4TLCm?=
 =?us-ascii?Q?6DutL2IoLFMCGnGpO5MlBfLFPyDvdysy5cZVIaO9ShJLtvyBZTQQz4kpkiny?=
 =?us-ascii?Q?hiJJ0LNzK4OAflrnaXeJF6ngX9lzte9w3jtIOzw2zB110gTopTQ5XMW3fqtX?=
 =?us-ascii?Q?UenKDoOyyxKWVb505WDAoLVoVKr5fjXiFOTU2dhxHM6CES/1knn5i/eYFvUN?=
 =?us-ascii?Q?hVF20ATzJgLHiEXfxLMlm7VELwiEgv+p9B8O3wDX1ojBgznAR4bXTJ0lHFgu?=
 =?us-ascii?Q?Zh4DxWef+H8Emib3sDFsPXQfM2sraucJBlNHqSQMP96g8bu3SkVvOMmlXN+h?=
 =?us-ascii?Q?eG1dueKlslGQ2R7w+1hGlle+0jnQNaPIGAV/uCEUyz2M/ikalU/JdTStMJCP?=
 =?us-ascii?Q?8DTg0pSxdgImDzRLKi2RjiGvtLM7H8Ng8kBmNfZtLl7OToVVqxNs6F9Nm0cQ?=
 =?us-ascii?Q?6zvkUv+a8keT3aTEnrkUcYcZOEuZat/npHB37CusmZpxq1fSmDTMJWhE1inX?=
 =?us-ascii?Q?YiKdZDoLyGINswkDTJW5ftkwKyp9FUZUkQcZNGOxU8NNN93OvRKOidOeH14s?=
 =?us-ascii?Q?kntQNyFJeKT4iz9vPbjEMt4DiRx4MqcUTqeRIM72mnOCtzgeW9eoHatO5YYD?=
 =?us-ascii?Q?u+kq16jh2nmz6iUGANVkNoEsQ5VygEeI+Q5X01Fca3wrLDIcxtqt3JM6D7aq?=
 =?us-ascii?Q?m0mEmMd7NM4IiPVKBYqbOj1MeGLiXvKGwmkzMmGaVj4UyfrXoagdF9e6igyF?=
 =?us-ascii?Q?8uKjv2Ve6MFcdzc3yW6mzd4LNSqKHQ4evYCJxyL8a1nivTVFGNlIGah8H56o?=
 =?us-ascii?Q?MQHNmioFICplWSedy4ix3P8XDHob9X7xkyNjyi1AqxG/UJ5vymbw+Z1Fm/C4?=
 =?us-ascii?Q?cFHXW9dU5I4qeeB9lI5G1DlMjJOSDKyN8065zErbmb4gQU5WAQZHXPX83R4d?=
 =?us-ascii?Q?Qt2FIjesqzFZFLbKMGZlY99W6CgglksuOCTexpvmWkwOOptrV/IgJldTEUaa?=
 =?us-ascii?Q?vYMtuePhOCZHRHhoV6BDBb+U2CurKYaaaFc6+51msT5vV8WFeOTcDGTbW5Gn?=
 =?us-ascii?Q?TTmL+v1pCmn/zpGjihZMulPDcwN71uGzvFZY+ARonPQJ8TaieIXgi8anuZey?=
 =?us-ascii?Q?+Q54zq+mZfcXaldOnaLoM2gbmyzBc/gKwqGrPbZOVStjCsP98c79uTV5yVrl?=
 =?us-ascii?Q?h8LaLyWXA3Cb+oy9koQpuT9O4tglTVzv1FHAZ791an2et+8G2scz375dqoI5?=
 =?us-ascii?Q?hTZXqnBi3bISfMMu9b54N3zzqe7Mk5lFCPM14pXiO9ceK7YO+6y1OzccVJ7s?=
 =?us-ascii?Q?hc9kI5JiCkz+Z02Rdmo=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:33:32.7058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0cd8d3-215f-4d46-9b10-08de3e102119
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR22MB5650
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:13:44 +0100
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

Conform with U-Boot guidelines and pass checkpatch checks for upcoming
changes.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

 drivers/video/imx/ipu.h          | 58 +++++++++++++-------------
 drivers/video/imx/ipu_common.c   | 70 ++++++++++++++++----------------
 drivers/video/imx/ipu_disp.c     | 50 +++++++++++------------
 drivers/video/imx/mxc_ipuv3_fb.c | 23 +++++------
 4 files changed, 96 insertions(+), 105 deletions(-)

diff --git a/drivers/video/imx/ipu.h b/drivers/video/imx/ipu.h
index 58f68b6b9cf..83cd0d8470e 100644
--- a/drivers/video/imx/ipu.h
+++ b/drivers/video/imx/ipu.h
@@ -83,10 +83,10 @@ typedef enum {
 #define _MAKE_ALT_CHAN(ch) (ch | (IPU_MAX_CH << 24))
 #define IPU_CHAN_ID(ch) (ch >> 24)
 #define IPU_CHAN_ALT(ch) (ch & 0x02000000)
-#define IPU_CHAN_ALPHA_IN_DMA(ch) ((uint32_t)(ch >> 6) & 0x3F)
-#define IPU_CHAN_GRAPH_IN_DMA(ch) ((uint32_t)(ch >> 12) & 0x3F)
-#define IPU_CHAN_VIDEO_IN_DMA(ch) ((uint32_t)(ch >> 18) & 0x3F)
-#define IPU_CHAN_OUT_DMA(ch) ((uint32_t)(ch & 0x3F))
+#define IPU_CHAN_ALPHA_IN_DMA(ch) ((u32)(ch >> 6) & 0x3F)
+#define IPU_CHAN_GRAPH_IN_DMA(ch) ((u32)(ch >> 12) & 0x3F)
+#define IPU_CHAN_VIDEO_IN_DMA(ch) ((u32)(ch >> 18) & 0x3F)
+#define IPU_CHAN_OUT_DMA(ch) ((u32)(ch & 0x3F))
 #define NO_DMA 0x3F
 #define ALT 1
 
@@ -148,27 +148,27 @@ enum ipu_dmfc_type {
  */
 typedef union {
 	struct {
-		uint32_t di;
+		u32 di;
 		unsigned char interlaced;
 	} mem_dc_sync;
 	struct {
-		uint32_t temp;
+		u32 temp;
 	} mem_sdc_fg;
 	struct {
-		uint32_t di;
+		u32 di;
 		unsigned char interlaced;
-		uint32_t in_pixel_fmt;
-		uint32_t out_pixel_fmt;
+		u32 in_pixel_fmt;
+		u32 out_pixel_fmt;
 		unsigned char alpha_chan_en;
 	} mem_dp_bg_sync;
 	struct {
-		uint32_t temp;
+		u32 temp;
 	} mem_sdc_bg;
 	struct {
-		uint32_t di;
+		u32 di;
 		unsigned char interlaced;
-		uint32_t in_pixel_fmt;
-		uint32_t out_pixel_fmt;
+		u32 in_pixel_fmt;
+		u32 out_pixel_fmt;
 		unsigned char alpha_chan_en;
 	} mem_dp_fg_sync;
 } ipu_channel_params_t;
@@ -205,29 +205,28 @@ int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params);
 void ipu_uninit_channel(ipu_channel_t channel);
 
 int32_t ipu_init_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
-				uint32_t pixel_fmt, uint16_t width,
-				uint16_t height, uint32_t stride,
-				dma_addr_t phyaddr_0, dma_addr_t phyaddr_1,
-				uint32_t u_offset, uint32_t v_offset);
+				u32 pixel_fmt, u16 width, u16 height,
+				u32 stride, dma_addr_t phyaddr_0,
+				dma_addr_t phyaddr_1, u32 u_offset,
+				u32 v_offset);
 
 void ipu_clear_buffer_ready(ipu_channel_t channel, ipu_buffer_t type,
-			    uint32_t bufNum);
+			    u32 bufNum);
 int32_t ipu_enable_channel(ipu_channel_t channel);
 int32_t ipu_disable_channel(ipu_channel_t channel);
 
-int32_t ipu_init_sync_panel(int disp, uint32_t pixel_clk, uint16_t width,
-			    uint16_t height, uint32_t pixel_fmt,
-			    uint16_t h_start_width, uint16_t h_sync_width,
-			    uint16_t h_end_width, uint16_t v_start_width,
-			    uint16_t v_sync_width, uint16_t v_end_width,
-			    uint32_t v_to_h_sync, ipu_di_signal_cfg_t sig);
+int32_t ipu_init_sync_panel(int disp, u32 pixel_clk, u16 width, u16 height,
+			    u32 pixel_fmt, u16 h_start_width, u16 h_sync_width,
+			    u16 h_end_width, u16 v_start_width,
+			    u16 v_sync_width, u16 v_end_width, u32 v_to_h_sync,
+			    ipu_di_signal_cfg_t sig);
 
 int32_t ipu_disp_set_global_alpha(ipu_channel_t channel, unsigned char enable,
-				  uint8_t alpha);
+				  u8 alpha);
 int32_t ipu_disp_set_color_key(ipu_channel_t channel, unsigned char enable,
-			       uint32_t colorKey);
+			       u32 colorKey);
 
-uint32_t bytes_per_pixel(uint32_t fmt);
+u32 bytes_per_pixel(u32 fmt);
 
 void clk_enable(struct clk *clk);
 void clk_disable(struct clk *clk);
@@ -248,9 +247,8 @@ void ipu_dmfc_set_wait4eot(int dma_chan, int width);
 void ipu_dc_init(int dc_chan, int di, unsigned char interlaced);
 void ipu_dc_uninit(int dc_chan);
 void ipu_dp_dc_enable(ipu_channel_t channel);
-int ipu_dp_init(ipu_channel_t channel, uint32_t in_pixel_fmt,
-		uint32_t out_pixel_fmt);
+int ipu_dp_init(ipu_channel_t channel, u32 in_pixel_fmt, u32 out_pixel_fmt);
 void ipu_dp_uninit(ipu_channel_t channel);
 void ipu_dp_dc_disable(ipu_channel_t channel, unsigned char swap);
-ipu_color_space_t format_to_colorspace(uint32_t fmt);
+ipu_color_space_t format_to_colorspace(u32 fmt);
 #endif
diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index 72421aa5a03..78bff87097e 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -29,8 +29,8 @@ extern struct mxc_ccm_reg *mxc_ccm;
 extern u32 *ipu_cpmem_base;
 
 struct ipu_ch_param_word {
-	uint32_t data[5];
-	uint32_t res[3];
+	u32 data[5];
+	u32 res[3];
 };
 
 struct ipu_ch_param {
@@ -239,8 +239,8 @@ unsigned char g_ipu_clk_enabled;
 struct clk *g_di_clk[2];
 struct clk *g_pixel_clk[2];
 unsigned char g_dc_di_assignment[10];
-uint32_t g_channel_init_mask;
-uint32_t g_channel_enable_mask;
+u32 g_channel_init_mask;
+u32 g_channel_enable_mask;
 
 static int ipu_dc_use_count;
 static int ipu_dp_use_count;
@@ -252,28 +252,28 @@ u32 *ipu_dc_tmpl_reg;
 
 /* Static functions */
 
-static inline void ipu_ch_param_set_high_priority(uint32_t ch)
+static inline void ipu_ch_param_set_high_priority(u32 ch)
 {
 	ipu_ch_param_mod_field(ipu_ch_param_addr(ch), 1, 93, 2, 1);
 };
 
-static inline uint32_t channel_2_dma(ipu_channel_t ch, ipu_buffer_t type)
+static inline u32 channel_2_dma(ipu_channel_t ch, ipu_buffer_t type)
 {
-	return ((uint32_t)ch >> (6 * type)) & 0x3F;
+	return ((u32)ch >> (6 * type)) & 0x3F;
 };
 
 /* Either DP BG or DP FG can be graphic window */
-static inline int ipu_is_dp_graphic_chan(uint32_t dma_chan)
+static inline int ipu_is_dp_graphic_chan(u32 dma_chan)
 {
 	return (dma_chan == 23 || dma_chan == 27);
 }
 
-static inline int ipu_is_dmfc_chan(uint32_t dma_chan)
+static inline int ipu_is_dmfc_chan(u32 dma_chan)
 {
 	return ((dma_chan >= 23) && (dma_chan <= 29));
 }
 
-static inline void ipu_ch_param_set_buffer(uint32_t ch, int bufNum,
+static inline void ipu_ch_param_set_buffer(u32 ch, int bufNum,
 					   dma_addr_t phyaddr)
 {
 	ipu_ch_param_mod_field(ipu_ch_param_addr(ch), 1, 29 * bufNum, 29,
@@ -565,7 +565,7 @@ void ipu_dump_registers(void)
 int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params)
 {
 	int ret = 0;
-	uint32_t ipu_conf;
+	u32 ipu_conf;
 
 	debug("init channel = %d\n", IPU_CHAN_ID(channel));
 
@@ -650,9 +650,9 @@ err:
  */
 void ipu_uninit_channel(ipu_channel_t channel)
 {
-	uint32_t reg;
-	uint32_t in_dma, out_dma = 0;
-	uint32_t ipu_conf;
+	u32 reg;
+	u32 in_dma, out_dma = 0;
+	u32 ipu_conf;
 
 	if ((g_channel_init_mask & (1L << IPU_CHAN_ID(channel))) == 0) {
 		debug("Channel already uninitialized %d\n",
@@ -791,13 +791,12 @@ static inline void ipu_ch_params_set_packing(struct ipu_ch_param *p,
 	ipu_ch_param_set_field(p, 1, 143, 5, alpha_offset);
 }
 
-static void ipu_ch_param_init(int ch, uint32_t pixel_fmt, uint32_t width,
-			      uint32_t height, uint32_t stride, uint32_t u,
-			      uint32_t v, uint32_t uv_stride, dma_addr_t addr0,
-			      dma_addr_t addr1)
+static void ipu_ch_param_init(int ch, u32 pixel_fmt, u32 width, u32 height,
+			      u32 stride, u32 u, u32 v, u32 uv_stride,
+			      dma_addr_t addr0, dma_addr_t addr1)
 {
-	uint32_t u_offset = 0;
-	uint32_t v_offset = 0;
+	u32 u_offset = 0;
+	u32 v_offset = 0;
 	struct ipu_ch_param params;
 
 	memset(&params, 0, sizeof(params));
@@ -985,13 +984,12 @@ static void ipu_ch_param_init(int ch, uint32_t pixel_fmt, uint32_t width,
  * Return:	Returns 0 on success or negative error code on fail
  */
 int32_t ipu_init_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
-				uint32_t pixel_fmt, uint16_t width,
-				uint16_t height, uint32_t stride,
-				dma_addr_t phyaddr_0, dma_addr_t phyaddr_1,
-				uint32_t u, uint32_t v)
+				u32 pixel_fmt, u16 width, u16 height,
+				u32 stride, dma_addr_t phyaddr_0,
+				dma_addr_t phyaddr_1, u32 u, u32 v)
 {
-	uint32_t reg;
-	uint32_t dma_chan;
+	u32 reg;
+	u32 dma_chan;
 
 	dma_chan = channel_2_dma(channel, type);
 	if (!idma_is_valid(dma_chan))
@@ -1039,9 +1037,9 @@ int32_t ipu_init_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
  */
 int32_t ipu_enable_channel(ipu_channel_t channel)
 {
-	uint32_t reg;
-	uint32_t in_dma;
-	uint32_t out_dma;
+	u32 reg;
+	u32 in_dma;
+	u32 out_dma;
 
 	if (g_channel_enable_mask & (1L << IPU_CHAN_ID(channel))) {
 		printf("Warning: channel already enabled %d\n",
@@ -1082,9 +1080,9 @@ int32_t ipu_enable_channel(ipu_channel_t channel)
  *
  */
 void ipu_clear_buffer_ready(ipu_channel_t channel, ipu_buffer_t type,
-			    uint32_t bufNum)
+			    u32 bufNum)
 {
-	uint32_t dma_ch = channel_2_dma(channel, type);
+	u32 dma_ch = channel_2_dma(channel, type);
 
 	if (!idma_is_valid(dma_ch))
 		return;
@@ -1114,9 +1112,9 @@ void ipu_clear_buffer_ready(ipu_channel_t channel, ipu_buffer_t type,
  */
 int32_t ipu_disable_channel(ipu_channel_t channel)
 {
-	uint32_t reg;
-	uint32_t in_dma;
-	uint32_t out_dma;
+	u32 reg;
+	u32 in_dma;
+	u32 out_dma;
 
 	if ((g_channel_enable_mask & (1L << IPU_CHAN_ID(channel))) == 0) {
 		debug("Channel already disabled %d\n", IPU_CHAN_ID(channel));
@@ -1163,7 +1161,7 @@ int32_t ipu_disable_channel(ipu_channel_t channel)
 	return 0;
 }
 
-uint32_t bytes_per_pixel(uint32_t fmt)
+u32 bytes_per_pixel(u32 fmt)
 {
 	switch (fmt) {
 	case IPU_PIX_FMT_GENERIC: /*generic data */
@@ -1196,7 +1194,7 @@ uint32_t bytes_per_pixel(uint32_t fmt)
 	return 0;
 }
 
-ipu_color_space_t format_to_colorspace(uint32_t fmt)
+ipu_color_space_t format_to_colorspace(u32 fmt)
 {
 	switch (fmt) {
 	case IPU_PIX_FMT_RGB666:
diff --git a/drivers/video/imx/ipu_disp.c b/drivers/video/imx/ipu_disp.c
index 178442a2bca..af6daec7f64 100644
--- a/drivers/video/imx/ipu_disp.c
+++ b/drivers/video/imx/ipu_disp.c
@@ -399,13 +399,12 @@ static void ipu_dp_csc_setup(int dp, struct dp_csc_param_t dp_csc_param,
 	}
 }
 
-int ipu_dp_init(ipu_channel_t channel, uint32_t in_pixel_fmt,
-		uint32_t out_pixel_fmt)
+int ipu_dp_init(ipu_channel_t channel, u32 in_pixel_fmt, u32 out_pixel_fmt)
 {
 	int in_fmt, out_fmt;
 	int dp;
 	int partial = 0;
-	uint32_t reg;
+	u32 reg;
 
 	if (channel == MEM_FG_SYNC) {
 		dp = DP_SYNC;
@@ -454,8 +453,7 @@ int ipu_dp_init(ipu_channel_t channel, uint32_t in_pixel_fmt,
 	     ((fg_csc_type == YUV2RGB) && (bg_csc_type == YUV2RGB)))) {
 		int red, green, blue;
 		int y, u, v;
-		uint32_t color_key = __raw_readl(DP_GRAPH_WIND_CTRL()) &
-				     0xFFFFFFL;
+		u32 color_key = __raw_readl(DP_GRAPH_WIND_CTRL()) & 0xFFFFFFL;
 
 		debug("_ipu_dp_init color key 0x%x need change to yuv fmt!\n",
 		      color_key);
@@ -584,8 +582,8 @@ void ipu_dc_uninit(int dc_chan)
 void ipu_dp_dc_enable(ipu_channel_t channel)
 {
 	int di;
-	uint32_t reg;
-	uint32_t dc_chan;
+	u32 reg;
+	u32 dc_chan;
 
 	if (channel == MEM_DC_SYNC)
 		dc_chan = 1;
@@ -625,9 +623,9 @@ static unsigned char dc_swap;
 
 void ipu_dp_dc_disable(ipu_channel_t channel, unsigned char swap)
 {
-	uint32_t reg;
-	uint32_t csc;
-	uint32_t dc_chan = 0;
+	u32 reg;
+	u32 csc;
+	u32 dc_chan = 0;
 	int timeout = 50;
 	int irq = 0;
 
@@ -745,7 +743,7 @@ void ipu_init_dc_mappings(void)
 	ipu_dc_map_config(4, 2, 21, 0xFC);
 }
 
-static int ipu_pixfmt_to_map(uint32_t fmt)
+static int ipu_pixfmt_to_map(u32 fmt)
 {
 	switch (fmt) {
 	case IPU_PIX_FMT_GENERIC:
@@ -801,17 +799,16 @@ static int ipu_pixfmt_to_map(uint32_t fmt)
  *		fail.
  */
 
-int32_t ipu_init_sync_panel(int disp, uint32_t pixel_clk, uint16_t width,
-			    uint16_t height, uint32_t pixel_fmt,
-			    uint16_t h_start_width, uint16_t h_sync_width,
-			    uint16_t h_end_width, uint16_t v_start_width,
-			    uint16_t v_sync_width, uint16_t v_end_width,
-			    uint32_t v_to_h_sync, ipu_di_signal_cfg_t sig)
+int32_t ipu_init_sync_panel(int disp, u32 pixel_clk, u16 width, u16 height,
+			    u32 pixel_fmt, u16 h_start_width, u16 h_sync_width,
+			    u16 h_end_width, u16 v_start_width,
+			    u16 v_sync_width, u16 v_end_width, u32 v_to_h_sync,
+			    ipu_di_signal_cfg_t sig)
 {
-	uint32_t reg;
-	uint32_t di_gen, vsync_cnt;
-	uint32_t div, rounded_pixel_clk;
-	uint32_t h_total, v_total;
+	u32 reg;
+	u32 di_gen, vsync_cnt;
+	u32 div, rounded_pixel_clk;
+	u32 h_total, v_total;
 	int map;
 	struct clk *di_parent;
 
@@ -1135,9 +1132,9 @@ int32_t ipu_init_sync_panel(int disp, uint32_t pixel_clk, uint16_t width,
  * Return:	Returns 0 on success or negative error code on fail
  */
 int32_t ipu_disp_set_global_alpha(ipu_channel_t channel, unsigned char enable,
-				  uint8_t alpha)
+				  u8 alpha)
 {
-	uint32_t reg;
+	u32 reg;
 
 	unsigned char bg_chan;
 
@@ -1162,8 +1159,7 @@ int32_t ipu_disp_set_global_alpha(ipu_channel_t channel, unsigned char enable,
 
 	if (enable) {
 		reg = __raw_readl(DP_GRAPH_WIND_CTRL()) & 0x00FFFFFFL;
-		__raw_writel(reg | ((uint32_t)alpha << 24),
-			     DP_GRAPH_WIND_CTRL());
+		__raw_writel(reg | ((u32)alpha << 24), DP_GRAPH_WIND_CTRL());
 
 		reg = __raw_readl(DP_COM_CONF());
 		__raw_writel(reg | DP_COM_CONF_GWAM, DP_COM_CONF());
@@ -1190,9 +1186,9 @@ int32_t ipu_disp_set_global_alpha(ipu_channel_t channel, unsigned char enable,
  * Return:	Returns 0 on success or negative error code on fail
  */
 int32_t ipu_disp_set_color_key(ipu_channel_t channel, unsigned char enable,
-			       uint32_t color_key)
+			       u32 color_key)
 {
-	uint32_t reg;
+	u32 reg;
 	int y, u, v;
 	int red, green, blue;
 
diff --git a/drivers/video/imx/mxc_ipuv3_fb.c b/drivers/video/imx/mxc_ipuv3_fb.c
index 6b81d522041..6c271490ba1 100644
--- a/drivers/video/imx/mxc_ipuv3_fb.c
+++ b/drivers/video/imx/mxc_ipuv3_fb.c
@@ -37,8 +37,8 @@ static int mxcfb_map_video_memory(struct fb_info *fbi);
 static int mxcfb_unmap_video_memory(struct fb_info *fbi);
 
 static struct fb_videomode const *gmode;
-static uint8_t gdisp;
-static uint32_t gpixfmt;
+static u8 gdisp;
+static u32 gpixfmt;
 
 static void fb_videomode_to_var(struct fb_var_screeninfo *var,
 				const struct fb_videomode *mode)
@@ -75,9 +75,9 @@ struct mxcfb_info {
 	dma_addr_t alpha_phy_addr1;
 	void *alpha_virt_addr0;
 	void *alpha_virt_addr1;
-	uint32_t alpha_mem_len;
-	uint32_t cur_ipu_buf;
-	uint32_t cur_ipu_alpha_buf;
+	u32 alpha_mem_len;
+	u32 cur_ipu_buf;
+	u32 cur_ipu_alpha_buf;
 
 	u32 pseudo_palette[16];
 };
@@ -89,9 +89,9 @@ static unsigned char g_dp_in_use;
 static struct fb_info *mxcfb_info[3];
 static int ext_clk_used;
 
-static uint32_t bpp_to_pixfmt(struct fb_info *fbi)
+static u32 bpp_to_pixfmt(struct fb_info *fbi)
 {
-	uint32_t pixfmt = 0;
+	u32 pixfmt = 0;
 
 	debug("bpp_to_pixfmt: %d\n", fbi->var.bits_per_pixel);
 
@@ -180,7 +180,7 @@ static int mxcfb_set_par(struct fb_info *fbi)
 	u32 mem_len;
 	ipu_di_signal_cfg_t sig_cfg;
 	struct mxcfb_info *mxc_fbi = (struct mxcfb_info *)fbi->par;
-	uint32_t out_pixel_fmt;
+	u32 out_pixel_fmt;
 
 	ipu_disable_channel(mxc_fbi->ipu_ch);
 	ipu_uninit_channel(mxc_fbi->ipu_ch);
@@ -378,7 +378,7 @@ static int mxcfb_map_video_memory(struct fb_info *fbi)
 	}
 
 	debug("allocated fb @ paddr=0x%08X, size=%d.\n",
-	      (uint32_t)fbi->fix.smem_start, fbi->fix.smem_len);
+	      (u32)fbi->fix.smem_start, fbi->fix.smem_len);
 
 	fbi->screen_size = fbi->fix.smem_len;
 
@@ -451,7 +451,7 @@ extern struct clk *g_ipu_clk;
  *
  * Return:	Appropriate error code to the kernel common code
  */
-static int mxcfb_probe(struct udevice *dev, u32 interface_pix_fmt, uint8_t disp,
+static int mxcfb_probe(struct udevice *dev, u32 interface_pix_fmt, u8 disp,
 		       struct fb_videomode const *mode)
 {
 	struct fb_info *fbi;
@@ -536,8 +536,7 @@ void ipuv3_fb_shutdown(void)
 	}
 }
 
-int ipuv3_fb_init(struct fb_videomode const *mode, uint8_t disp,
-		  uint32_t pixfmt)
+int ipuv3_fb_init(struct fb_videomode const *mode, u8 disp, u32 pixfmt)
 {
 	gmode = mode;
 	gdisp = disp;
-- 
2.39.5

