Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D85D3B7E5
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 12:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D94AA83E23;
	Mon, 29 Dec 2025 13:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="So9kF6ko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C92C783DAE; Mon, 29 Dec 2025 11:49:00 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF0483DC9
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 11:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nj8YDSTGNtlTTZ3YK5uiu0goYVriEiXqY/IP1+iADBBg2RgGW5iDVx4yBsskVpjXt31lOz02XLjv2V2ZxnqdFTkdc8rSOG4xv2/PC0nK5zVS8LPWSznKeEPgif5MjbA4qI8BDxq6m/cMw6fJVJMsJ422jXMmik+WSuQP9R2dpXwFHGRhuqO0Uyhobb6c0FWHnyLymGckP2S7WBqHjcB2V92MjvmJLzPoicMxkRZH04WS2ZoCFvcyIhMexmfoW+k4eUGlGjWd6Uqkelu5Y21UXnkiFuiughXyNNYVDzOyBZzpIuHzY+NiPr3sYf6eTzPW5mOe6k1WQgAAJHPacbMlzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZKIQv4lFjqbikIPXaBq7c6P9Wqi1gzsjtlw0ptZX6s=;
 b=N/wFw33UkK+FiVX9MpDWkw16i5z8CmijyiJf5LfKeAlhjTX+MqggRjtPIkl8vuw3W5E/jWX83NtwPp8/lfVCtY6B26RWQM/JPUP0tWhv1jJKmvGqSl4EFyqKQGRkLuUwV3HSIM+dQDB8C/IbtiXqDi+IgMC7reS6bjVIKmAulMmZ0Yq8k15pbYzfkBujhv+yqi5X7i05Ime3rcgbG+7kR2JYPlLEvKH5TIRwNJRjRD9vstsL991g6eof7aEAXkMhFoCg0I+N7sjaXuTE2hHRZz04zgkcEvnydP+lAn1P6iEm09v2XA25DFbRdlXVyXY/vUiVy4vfF3oc0E/fkwKbpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZKIQv4lFjqbikIPXaBq7c6P9Wqi1gzsjtlw0ptZX6s=;
 b=So9kF6koQ7Hm/k/kCGqJ83qBf6B8si9/WAFbFulbvoePhjeEjKFl2bfhZ5OS43jH1axbo+Iszv/6zn/yUyGkD3Oial+FB7EVVP+/lSbmgiVmFDD2fW/I512Kl/svlsrcb6CPKZdukjhB9REXDsMdJBv/6A49gx/Bs8tGCqlA+5guPYr2CyOmpqzvSYosOje632ldQrQ1vA3yPqnepTsXIs8p27gGrRh3voSexDq/Q9wnLjBUx5wsBTctPfwnteYSaf32qRQiDVFXAFl26qz7cF/3BDpD9WQHyJ3wMuxejEsIB49ZiHzbFmqmmT+VGiL0tHbujq6UWCuzoaHEKe52SA==
Received: from DS7PR05CA0032.namprd05.prod.outlook.com (2603:10b6:8:2f::31) by
 CYYPR22MB4350.namprd22.prod.outlook.com (2603:10b6:930:c7::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.14; Mon, 29 Dec 2025 10:48:51 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::18) by DS7PR05CA0032.outlook.office365.com
 (2603:10b6:8:2f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon,
 29 Dec 2025 10:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 10:48:51 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id C1F02F2E66;
 Mon, 29 Dec 2025 12:48:48 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v2 3/7] video: imx: ipuv3: prefer kernel types
Date: Mon, 29 Dec 2025 12:48:03 +0200
Message-Id: <20251229104807.3104-4-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251229104807.3104-1-brian.ruley@gehealthcare.com>
References: <"CAOMZO5DOUE2PexcBcVcg3vYTo5eV=LT3=S9cSBosLCyir8Kw5g@mail.gmail.com">
 <20251229104807.3104-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|CYYPR22MB4350:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5fceefcb-7d9d-47b4-084f-08de46c7da83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Du/mERaYFvu/KXQYmBYfnj4IYKDAesiwIIxcwlUPNssoj4jg/PJggvcCqetk?=
 =?us-ascii?Q?FVVyZ7gG4lXlgBLPlxlLhFJelpnyyS4mjmJoSnFBqgCId4fF6NNwlPon4OdD?=
 =?us-ascii?Q?nKQqqH3IIh/VghEFUrcAsbyOWpBZecWzOXWXN6n554uKxYHE8y8gZW04d8a9?=
 =?us-ascii?Q?0UVPRkwu+pf0B9DvBBaNZQo+RcYylFPteH9wGWkMzP0FmFNZiPfWPWAROwBf?=
 =?us-ascii?Q?uyYvafj8WiNr/lks38jAJf/Codp7NrgH6Bpo/guRfmn/ObqwjMz4lt+mrBA0?=
 =?us-ascii?Q?2q1GBeCpHahwBkeiFiYw79mffrr2ZlOBLj6EgJTdv8E5Xv60kEJQuTDZb5H/?=
 =?us-ascii?Q?9GLRYSEBCmrjDVVQ2Xm60NoZAUjP1JLTqU8JzfeIbls4Hx83yreOdindFtxB?=
 =?us-ascii?Q?imFMYStyhSbEIjrAVLamwSm6NjHZFkzCh4hElJpEkkbEddj9W+s4jdElL+Fn?=
 =?us-ascii?Q?QyaEFPmNPJUfuDQj8VczqcIrzggPyVYjTNcYHbz43BP3p3p1A0V77CRXPNHa?=
 =?us-ascii?Q?qX4PrNPE21wrV5xhuzXNjgTvnJDNzWcZ37FbZJsyC8cFD4EVyI+qs1XKfHmB?=
 =?us-ascii?Q?L3sb8nJuKMA61YuNRHkbcMg2wVOtu+8CO893hqQZT0XhxBlebyTW4yy06ZkL?=
 =?us-ascii?Q?9dwbk3WgUOjUFYq1q2AdJ+clX7aIZy7jIEHpheBFaUcO1x7FcUZY1Uk+9Hjq?=
 =?us-ascii?Q?+xKfsSJtwSzHio4FTynAVjFwaZZtLFcxeS2HVnqoEvzirFQrHPaO71tK+L2p?=
 =?us-ascii?Q?L+GigG1aT/fx+s09x6y3gj6HspQYXgfqvg6cpdtxjcF1QwbbKzjV5dYrqlEI?=
 =?us-ascii?Q?Fpgc24tzXim+JKpK8eLmgrQ9t9JgHmYf2in9IRzqAnotoIBjq6WllpCuFdMP?=
 =?us-ascii?Q?LOBIgmg1ssnktAPIG5hWx5YZTjxxpf9o1zfQXK0S05O2YzOixFGlrjabUF2+?=
 =?us-ascii?Q?M+qN/Ul6Wxj40lqIbu1B7CWEdllMx6THS5oQSPUdvzi7ktQNFw6O0adrFwZd?=
 =?us-ascii?Q?DeBO/5Fm0G78Nq2OSwiXYUGbwgEPAiAowmsn8OmQvAfnCE0pi0XH62ljBaWj?=
 =?us-ascii?Q?i0TrsPh4KpzP38+K1drpEPWzhZ3IJj6LQl54qyaS7Adop+Zv5pjvvVEsV4tq?=
 =?us-ascii?Q?tVN4W1WB3sHLTKitc3u50jC9822o10TLoCWqpCA9GA70k4ImU2RK9x/u2hPT?=
 =?us-ascii?Q?3oeaFVNarJAuNcIKfJiXwFkKKWgfEe4X/5QXMx3OtokxXqcKAXZFpbmOOxGI?=
 =?us-ascii?Q?NRo51+lep+RjVK9JEmi1lxRR0IlPAFHSBH6tzMl1jIyW6YjG7I6JTYiBcNSn?=
 =?us-ascii?Q?XsFmURG5M6TJaWq6V7h22/eRPu1+vWmj212hO1vLinzjeT9DKBdOp4gcBXoM?=
 =?us-ascii?Q?wTcmXGoQnRez7EKY7oPJLCrVtVR4NuI2yjK2ZRredknuWz6Q1NnXVlCm36O1?=
 =?us-ascii?Q?rKpj91V2Q/MWy72dqrO5x5RvHL2Q6tdi1CjC0aIIb8h8u2yirJrtWw/S8uJM?=
 =?us-ascii?Q?3tD7HHoX2v+tcZqmelFhRzWIiomMo2j24nlydi+8uaDzMaeqO2mpW1SHLqtr?=
 =?us-ascii?Q?RupNgbHM8dandcw0AOA=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 10:48:51.0159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fceefcb-7d9d-47b4-084f-08de46c7da83
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR22MB4350
X-Mailman-Approved-At: Mon, 29 Dec 2025 13:40:49 +0100
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

(no changes since v1)

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

