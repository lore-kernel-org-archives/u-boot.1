Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E9BD6ACDC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 12:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9513083E23;
	Thu, 18 Dec 2025 13:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="g1qnbVB/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B721783BA1; Thu, 18 Dec 2025 09:33:45 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C85D383CAA
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:33:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdq5IdXbyUDAFA16fqRHy2qBZ/TBp6AL5hwWx3bpMlGL4J8SxoF3fKmBT0EuZMzRvYIrdS7LGvbTw9zdym2S1NQyag63B6S8LZRFdC31Uam4HNoo+0urZ/Vni1B4hG1lkF4CWD86RwG67yp4zGLfRsNHjsrzhKdPkyfz6GH9NageoUdtBD01E7J7Y+f9OFnNVAk77AQU7CSKr9neoTVVBbcNwPKd4pJiNFpBiZ/uqjiySctP8yHcm9oouRABEGRt/9lwzKA8IObHsfQbuZ0in/QB7d5tgPYKrcETfpmsh9SP0APwI8LFsVJ8LA1mGXRpx7dGWQM1yYF2OcIVvrvXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgvBQfkr+owBiYIGoIfoEqkeR5ZvKE2IjMwEAPJTqLg=;
 b=EKLiP/r4DdaR7xmX3I70ejstBTViAow+r2HgIs+FFoMHLgKZZR/+XP/4RQNw8g4zvRGlRWvog97GIwYk8jpwUvgLi6e47lSNJPKbNj9jR7t8HsTSHMeWz4RB2/rL/V8YQaT4vOIwPu8azqoBZgjKaS3ZFfZF/xri5bXJycS2U/rgaSFXou0q1gILxKejvBP3wt9bfB/HhcEiSHAVF8yAJ0h70nRy/F+MCbcoCg9rbQBoUPh3r/7Pp/4HyWJH2fGRS5qQ1Mf5Wj+Fty5GeTYQ/Yd4M5S/kE3oAGXmafw94bMhjGZAgS8gnOeVLhS3P+pDC7aC7nl653WuBJ8HCElHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgvBQfkr+owBiYIGoIfoEqkeR5ZvKE2IjMwEAPJTqLg=;
 b=g1qnbVB/IegR4UrAHVjD4WMuHZDUf4uk6ubEIevaJRE75gul+AoqE4dt63Ukh7HbH4QoE3QG+TogBEQcScqwfBurQaBFZae+B3gRyaxZep0CPJHdenQbdidcp0lmhWdrTBHQK3Jki0KiIw1N+jMzKxo0yX+PQE2FbK15DglO6GpaRnXZHrl174we1h7GSzdaceP/hRtbaVGDiRBIBtmS4o3iIHu/UW38Vk0WOWbs37QxSp47pHBaYT/XNOTUYax+JXtU4ZjGwVRqE6vH5z54Atanm/Pqhlny6l2Dr6uIv0Z0P+lBJ3sYz45nQp11QvOyRsazHCdzIJ9NzbAWvU1YYQ==
Received: from MW4PR04CA0327.namprd04.prod.outlook.com (2603:10b6:303:82::32)
 by EA2PR22MB4754.namprd22.prod.outlook.com (2603:10b6:303:259::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 08:33:33 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::86) by MW4PR04CA0327.outlook.office365.com
 (2603:10b6:303:82::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 08:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 08:33:32 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id D6C88F2E64;
 Thu, 18 Dec 2025 10:33:29 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v1 2/7] video: imx: ipuv3: apply clang-format
Date: Thu, 18 Dec 2025 10:33:21 +0200
Message-Id: <20251218083326.644326-3-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
References: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|EA2PR22MB4754:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fbf534e3-35f7-4752-ad26-08de3e10214e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z5SsJL+k3by4xk2YIJbk9aU605BacLNylgFR++LAofu7dQ8kVvV63OiXgaSU?=
 =?us-ascii?Q?u4Wq5jLCjAu3nYpmbT93brJYoPcQU+T0/NUcslyrLs/STz56jJZW42XwXFDC?=
 =?us-ascii?Q?jVHc6O24xi7/0AjxuRpXi+KBJBmavY+rLsYVYcxKk1yf3qB1NtrtUs1s84nR?=
 =?us-ascii?Q?xguTcECWi9VqEG+kXrYeYe4YDePQZAixOAIW+MuG2XdoEK0W2OdCHYbVFpyb?=
 =?us-ascii?Q?jp81jRMteX7XtTeun3sWRe11wc69+83vU4ufY9BgX4lSfjaHtYvu2JRPmfPG?=
 =?us-ascii?Q?h+VBA7ejGjiZdB8Bh8r/u4VPWZOS0UsKztx+lJp7MLzyKZWrg7zaMx7e/FNs?=
 =?us-ascii?Q?fPHzg6iwCL/SVqHscUHuoHEaYx5owREpW9Tq8+RAAuNVXsTEwkoL8gGVTWtN?=
 =?us-ascii?Q?cbTdNqtT2QJ+iKQDN3VKeZy52cCQ8rAW2H7Q7VithbTy3VIwTrjd8scdhm37?=
 =?us-ascii?Q?HT0Cm7fz864CPO4ZpgtIApIRdxVyjLA8aPxoyfaDudWjXWPSHD/pIx7j52ZJ?=
 =?us-ascii?Q?Fr4eMjBxk+LIDapvvcMt2B0zRXY/SXAnLW4MDDsfrmWjLJ2EqDfT3bdCJfZ8?=
 =?us-ascii?Q?/VWABxM60B/BBZSnAXbZrMqj4IvZQ9yVGDBBt5LuSPrdrP+GtR60QNTWJRSm?=
 =?us-ascii?Q?p292uL8cXrmrnX3kkFzqPhyFv1H9RIX2Au+nrxR131j+ArHh4li2LopUZul2?=
 =?us-ascii?Q?R8etO0ucqILJyimS4okVALuZ6zpakZRgOlzck8xqXVNYRWJepOZHZMW6ejci?=
 =?us-ascii?Q?d6nOzpoRhY/s6tUkxux3GnNAK27mUPCzTc4zsQ6NckyYyF7FmdG7gjM+Ft6p?=
 =?us-ascii?Q?geq3F6vaDY+pay4Kh9fn4uyhPh3rGTHas9Cm2HA2XCEtB1nqSUxmhhwkNHE3?=
 =?us-ascii?Q?wce5KNvAzCQIqOYHP8cyU2EEsPdXvwuD3PlmI74BFZ3PdBkLY5i3Y4y9RY+Z?=
 =?us-ascii?Q?bb8hyurpMEQj6rdXFmcc+Ms4rICEkINEFDZqjX5Fl05zc0ho3rxK/5jvuZVj?=
 =?us-ascii?Q?+fxujXM6Ad+SDXlM+6RGdCJ+owJYLL5ih/HJJwXb5abFBQUqY7JyiMejz+sO?=
 =?us-ascii?Q?FIL1S0P3xTQ/jqDr7qlKFKaO+7wfdquLWcBxCL/hNxpnZ9F389Jl6m3rzVaC?=
 =?us-ascii?Q?D/Fo5SNw4I0XvJpeh/LzYpjOii91onOZ7MYArZan2omBEMCKV2stMPOqk7jz?=
 =?us-ascii?Q?SPfGFrgolNMW+QTirjBUAqGQUn7lRYadtzUj/lgcr9uCkG30s8QwYF3Wikmj?=
 =?us-ascii?Q?vAYRBsJG9WKwg+iqRN2uhKNv9eTZ0K4A2sDNol3K1cSvTIJI5CYtyPyRnyo9?=
 =?us-ascii?Q?anIpkj4F45CxK5bQDFFRi1v8glJW+OliCVHpQQvnu0FiVI7z/NSrQyn1WG8W?=
 =?us-ascii?Q?1C1/IdmD5NaRJ+XCHdbim8IEyVejO08XET696YwvOGvAJCjIuyh7gLlWUqBD?=
 =?us-ascii?Q?/144H0YWfDDS7/ERd+Ul5FoPuZKsPF6mRdWpeMj0fKyOY7lJqatFdg/vmnlf?=
 =?us-ascii?Q?XzPJzDpxTr+6cJwea1kAnW9LlkUvK6TLYg8ZL9anTtSSrsXhngoaQz6Jd3Hs?=
 =?us-ascii?Q?g9EqXvHRhWwiMlOYLhk=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:33:32.9017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf534e3-35f7-4752-ad26-08de3e10214e
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB4754
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

Bring the code into compliance with U-Boot's coding style guidelines for
upcoming changes. Sort includes to tidy things up and apply
{ RemoveBracesLLVM: true } to remove unnecessary blocks.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

 drivers/video/imx/ipu.h          |  91 ++---
 drivers/video/imx/ipu_common.c   | 483 +++++++++++------------
 drivers/video/imx/ipu_disp.c     | 645 +++++++++++++++----------------
 drivers/video/imx/ipu_regs.h     | 266 +++++++------
 drivers/video/imx/mxc_ipuv3_fb.c | 163 ++++----
 5 files changed, 770 insertions(+), 878 deletions(-)

diff --git a/drivers/video/imx/ipu.h b/drivers/video/imx/ipu.h
index 93bc97e6300..58f68b6b9cf 100644
--- a/drivers/video/imx/ipu.h
+++ b/drivers/video/imx/ipu.h
@@ -13,11 +13,11 @@
 #ifndef __ASM_ARCH_IPU_H__
 #define __ASM_ARCH_IPU_H__
 
-#include <linux/types.h>
 #include <ipu_pixfmt.h>
+#include <linux/types.h>
 
-#define IDMA_CHAN_INVALID	0xFF
-#define HIGH_RESOLUTION_WIDTH	1024
+#define IDMA_CHAN_INVALID 0xFF
+#define HIGH_RESOLUTION_WIDTH 1024
 
 struct clk {
 	const char *name;
@@ -39,30 +39,30 @@ struct clk {
 	 * Function ptr to recalculate the clock's rate based on parent
 	 * clock's rate
 	 */
-	void (*recalc) (struct clk *);
+	void (*recalc)(struct clk *);
 	/*
 	 * Function ptr to set the clock to a new rate. The rate must match a
 	 * supported rate returned from round_rate. Leave blank if clock is not
 	* programmable
 	 */
-	int (*set_rate) (struct clk *, unsigned long);
+	int (*set_rate)(struct clk *, unsigned long);
 	/*
 	 * Function ptr to round the requested clock rate to the nearest
 	 * supported rate that is less than or equal to the requested rate.
 	 */
-	unsigned long (*round_rate) (struct clk *, unsigned long);
+	unsigned long (*round_rate)(struct clk *, unsigned long);
 	/*
 	 * Function ptr to enable the clock. Leave blank if clock can not
 	 * be gated.
 	 */
-	int (*enable) (struct clk *);
+	int (*enable)(struct clk *);
 	/*
 	 * Function ptr to disable the clock. Leave blank if clock can not
 	 * be gated.
 	 */
-	void (*disable) (struct clk *);
+	void (*disable)(struct clk *);
 	/* Function ptr to set the parent clock of the clock. */
-	int (*set_parent) (struct clk *, struct clk *);
+	int (*set_parent)(struct clk *, struct clk *);
 };
 
 /*
@@ -77,18 +77,18 @@ typedef enum {
  * IPU Driver channels definitions.
  * Note these are different from IDMA channels
  */
-#define IPU_MAX_CH	32
+#define IPU_MAX_CH 32
 #define _MAKE_CHAN(num, v_in, g_in, a_in, out) \
 	((num << 24) | (v_in << 18) | (g_in << 12) | (a_in << 6) | out)
-#define _MAKE_ALT_CHAN(ch)		(ch | (IPU_MAX_CH << 24))
-#define IPU_CHAN_ID(ch)			(ch >> 24)
-#define IPU_CHAN_ALT(ch)		(ch & 0x02000000)
-#define IPU_CHAN_ALPHA_IN_DMA(ch)	((uint32_t) (ch >> 6) & 0x3F)
-#define IPU_CHAN_GRAPH_IN_DMA(ch)	((uint32_t) (ch >> 12) & 0x3F)
-#define IPU_CHAN_VIDEO_IN_DMA(ch)	((uint32_t) (ch >> 18) & 0x3F)
-#define IPU_CHAN_OUT_DMA(ch)		((uint32_t) (ch & 0x3F))
+#define _MAKE_ALT_CHAN(ch) (ch | (IPU_MAX_CH << 24))
+#define IPU_CHAN_ID(ch) (ch >> 24)
+#define IPU_CHAN_ALT(ch) (ch & 0x02000000)
+#define IPU_CHAN_ALPHA_IN_DMA(ch) ((uint32_t)(ch >> 6) & 0x3F)
+#define IPU_CHAN_GRAPH_IN_DMA(ch) ((uint32_t)(ch >> 12) & 0x3F)
+#define IPU_CHAN_VIDEO_IN_DMA(ch) ((uint32_t)(ch >> 18) & 0x3F)
+#define IPU_CHAN_OUT_DMA(ch) ((uint32_t)(ch & 0x3F))
 #define NO_DMA 0x3F
-#define ALT	1
+#define ALT 1
 
 /*
  * Enumeration of IPU logical channels. An IPU logical channel is defined as a
@@ -118,16 +118,16 @@ typedef enum {
  * Enumeration of types of buffers for a logical channel.
  */
 typedef enum {
-	IPU_OUTPUT_BUFFER = 0,	/*< Buffer for output from IPU */
-	IPU_ALPHA_IN_BUFFER = 1,	/*< Buffer for input to IPU */
-	IPU_GRAPH_IN_BUFFER = 2,	/*< Buffer for input to IPU */
-	IPU_VIDEO_IN_BUFFER = 3,	/*< Buffer for input to IPU */
+	IPU_OUTPUT_BUFFER = 0, /*< Buffer for output from IPU */
+	IPU_ALPHA_IN_BUFFER = 1, /*< Buffer for input to IPU */
+	IPU_GRAPH_IN_BUFFER = 2, /*< Buffer for input to IPU */
+	IPU_VIDEO_IN_BUFFER = 3, /*< Buffer for input to IPU */
 	IPU_INPUT_BUFFER = IPU_VIDEO_IN_BUFFER,
 	IPU_SEC_INPUT_BUFFER = IPU_GRAPH_IN_BUFFER,
 } ipu_buffer_t;
 
-#define IPU_PANEL_SERIAL		1
-#define IPU_PANEL_PARALLEL		2
+#define IPU_PANEL_SERIAL 1
+#define IPU_PANEL_PARALLEL 2
 
 struct ipu_channel {
 	u8 video_in_dma;
@@ -185,45 +185,38 @@ enum ipu_irq_line {
  * Bitfield of Display Interface signal polarities.
  */
 typedef struct {
-	unsigned datamask_en:1;
-	unsigned ext_clk:1;
-	unsigned interlaced:1;
-	unsigned odd_field_first:1;
-	unsigned clksel_en:1;
-	unsigned clkidle_en:1;
-	unsigned data_pol:1;	/* true = inverted */
-	unsigned clk_pol:1;	/* true = rising edge */
-	unsigned enable_pol:1;
-	unsigned Hsync_pol:1;	/* true = active high */
-	unsigned Vsync_pol:1;
+	unsigned datamask_en : 1;
+	unsigned ext_clk : 1;
+	unsigned interlaced : 1;
+	unsigned odd_field_first : 1;
+	unsigned clksel_en : 1;
+	unsigned clkidle_en : 1;
+	unsigned data_pol : 1; /* true = inverted */
+	unsigned clk_pol : 1; /* true = rising edge */
+	unsigned enable_pol : 1;
+	unsigned Hsync_pol : 1; /* true = active high */
+	unsigned Vsync_pol : 1;
 } ipu_di_signal_cfg_t;
 
-typedef enum {
-	RGB,
-	YCbCr,
-	YUV
-} ipu_color_space_t;
+typedef enum { RGB, YCbCr, YUV } ipu_color_space_t;
 
 /* Common IPU API */
 int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params);
 void ipu_uninit_channel(ipu_channel_t channel);
 
 int32_t ipu_init_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
-				uint32_t pixel_fmt,
-				uint16_t width, uint16_t height,
-				uint32_t stride,
+				uint32_t pixel_fmt, uint16_t width,
+				uint16_t height, uint32_t stride,
 				dma_addr_t phyaddr_0, dma_addr_t phyaddr_1,
 				uint32_t u_offset, uint32_t v_offset);
 
 void ipu_clear_buffer_ready(ipu_channel_t channel, ipu_buffer_t type,
-		uint32_t bufNum);
+			    uint32_t bufNum);
 int32_t ipu_enable_channel(ipu_channel_t channel);
 int32_t ipu_disable_channel(ipu_channel_t channel);
 
-int32_t ipu_init_sync_panel(int disp,
-			    uint32_t pixel_clk,
-			    uint16_t width, uint16_t height,
-			    uint32_t pixel_fmt,
+int32_t ipu_init_sync_panel(int disp, uint32_t pixel_clk, uint16_t width,
+			    uint16_t height, uint32_t pixel_fmt,
 			    uint16_t h_start_width, uint16_t h_sync_width,
 			    uint16_t h_end_width, uint16_t v_start_width,
 			    uint16_t v_sync_width, uint16_t v_end_width,
@@ -256,7 +249,7 @@ void ipu_dc_init(int dc_chan, int di, unsigned char interlaced);
 void ipu_dc_uninit(int dc_chan);
 void ipu_dp_dc_enable(ipu_channel_t channel);
 int ipu_dp_init(ipu_channel_t channel, uint32_t in_pixel_fmt,
-		 uint32_t out_pixel_fmt);
+		uint32_t out_pixel_fmt);
 void ipu_dp_uninit(ipu_channel_t channel);
 void ipu_dp_dc_disable(ipu_channel_t channel, unsigned char swap);
 ipu_color_space_t format_to_colorspace(uint32_t fmt);
diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index 61a3fe1e83b..72421aa5a03 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -11,19 +11,19 @@
  */
 
 /* #define DEBUG */
+#include "ipu.h"
+#include "ipu_regs.h"
+#include <asm/arch/crm_regs.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/io.h>
 #include <config.h>
-#include <log.h>
+#include <div64.h>
 #include <linux/delay.h>
-#include <linux/types.h>
 #include <linux/err.h>
-#include <asm/io.h>
 #include <linux/errno.h>
-#include <asm/arch/imx-regs.h>
-#include <asm/arch/crm_regs.h>
-#include <asm/arch/sys_proto.h>
-#include <div64.h>
-#include "ipu.h"
-#include "ipu_regs.h"
+#include <linux/types.h>
+#include <log.h>
 
 extern struct mxc_ccm_reg *mxc_ccm;
 extern u32 *ipu_cpmem_base;
@@ -39,61 +39,63 @@ struct ipu_ch_param {
 
 #define ipu_ch_param_addr(ch) (((struct ipu_ch_param *)ipu_cpmem_base) + (ch))
 
-#define _param_word(base, w) \
-	(((struct ipu_ch_param *)(base))->word[(w)].data)
-
-#define ipu_ch_param_set_field(base, w, bit, size, v) { \
-	int i = (bit) / 32; \
-	int off = (bit) % 32; \
-	_param_word(base, w)[i] |= (v) << off; \
-	if (((bit) + (size) - 1) / 32 > i) { \
-		_param_word(base, w)[i + 1] |= (v) >> (off ? (32 - off) : 0); \
-	} \
-}
+#define _param_word(base, w) (((struct ipu_ch_param *)(base))->word[(w)].data)
+
+#define ipu_ch_param_set_field(base, w, bit, size, v)                          \
+	{                                                                      \
+		int i = (bit) / 32;                                            \
+		int off = (bit) % 32;                                          \
+		_param_word(base, w)[i] |= (v) << off;                         \
+		if (((bit) + (size) - 1) / 32 > i) {                           \
+			_param_word(base, w)[i + 1] |= (v) >>                  \
+						       (off ? (32 - off) : 0); \
+		}                                                              \
+	}
 
-#define ipu_ch_param_mod_field(base, w, bit, size, v) { \
-	int i = (bit) / 32; \
-	int off = (bit) % 32; \
-	u32 mask = (1UL << size) - 1; \
-	u32 temp = _param_word(base, w)[i]; \
-	temp &= ~(mask << off); \
-	_param_word(base, w)[i] = temp | (v) << off; \
-	if (((bit) + (size) - 1) / 32 > i) { \
-		temp = _param_word(base, w)[i + 1]; \
-		temp &= ~(mask >> (32 - off)); \
-		_param_word(base, w)[i + 1] = \
-			temp | ((v) >> (off ? (32 - off) : 0)); \
-	} \
-}
+#define ipu_ch_param_mod_field(base, w, bit, size, v)                   \
+	{                                                               \
+		int i = (bit) / 32;                                     \
+		int off = (bit) % 32;                                   \
+		u32 mask = (1UL << size) - 1;                           \
+		u32 temp = _param_word(base, w)[i];                     \
+		temp &= ~(mask << off);                                 \
+		_param_word(base, w)[i] = temp | (v) << off;            \
+		if (((bit) + (size) - 1) / 32 > i) {                    \
+			temp = _param_word(base, w)[i + 1];             \
+			temp &= ~(mask >> (32 - off));                  \
+			_param_word(base, w)[i + 1] =                   \
+				temp | ((v) >> (off ? (32 - off) : 0)); \
+		}                                                       \
+	}
 
-#define ipu_ch_param_read_field(base, w, bit, size) ({ \
-	u32 temp2; \
-	int i = (bit) / 32; \
-	int off = (bit) % 32; \
-	u32 mask = (1UL << size) - 1; \
-	u32 temp1 = _param_word(base, w)[i]; \
-	temp1 = mask & (temp1 >> off); \
-	if (((bit)+(size) - 1) / 32 > i) { \
-		temp2 = _param_word(base, w)[i + 1]; \
-		temp2 &= mask >> (off ? (32 - off) : 0); \
-		temp1 |= temp2 << (off ? (32 - off) : 0); \
-	} \
-	temp1; \
-})
-
-#define IPU_SW_RST_TOUT_USEC	(10000)
-
-#define IPUV3_CLK_MX51		133000000
-#define IPUV3_CLK_MX53		200000000
-#define IPUV3_CLK_MX6Q		264000000
-#define IPUV3_CLK_MX6DL		198000000
+#define ipu_ch_param_read_field(base, w, bit, size)               \
+	({                                                        \
+		u32 temp2;                                        \
+		int i = (bit) / 32;                               \
+		int off = (bit) % 32;                             \
+		u32 mask = (1UL << size) - 1;                     \
+		u32 temp1 = _param_word(base, w)[i];              \
+		temp1 = mask & (temp1 >> off);                    \
+		if (((bit) + (size) - 1) / 32 > i) {              \
+			temp2 = _param_word(base, w)[i + 1];      \
+			temp2 &= mask >> (off ? (32 - off) : 0);  \
+			temp1 |= temp2 << (off ? (32 - off) : 0); \
+		}                                                 \
+		temp1;                                            \
+	})
+
+#define IPU_SW_RST_TOUT_USEC (10000)
+
+#define IPUV3_CLK_MX51 133000000
+#define IPUV3_CLK_MX53 200000000
+#define IPUV3_CLK_MX6Q 264000000
+#define IPUV3_CLK_MX6DL 198000000
 
 void clk_enable(struct clk *clk)
 {
 	if (clk) {
-		if (clk->usecount++ == 0) {
+		if (clk->usecount++ == 0)
 			clk->enable(clk);
-		}
 	}
 }
 
@@ -207,12 +209,12 @@ static void clk_ipu_disable(struct clk *clk)
 static struct clk ipu_clk = {
 	.name = "ipu_clk",
 #if defined(CONFIG_MX51) || defined(CONFIG_MX53)
-	.enable_reg = (u32 *)(CCM_BASE_ADDR +
-		offsetof(struct mxc_ccm_reg, CCGR5)),
+	.enable_reg =
+		(u32 *)(CCM_BASE_ADDR + offsetof(struct mxc_ccm_reg, CCGR5)),
 	.enable_shift = MXC_CCM_CCGR5_IPU_OFFSET,
 #else
-	.enable_reg = (u32 *)(CCM_BASE_ADDR +
-		offsetof(struct mxc_ccm_reg, CCGR3)),
+	.enable_reg =
+		(u32 *)(CCM_BASE_ADDR + offsetof(struct mxc_ccm_reg, CCGR3)),
 	.enable_shift = MXC_CCM_CCGR3_IPU1_IPU_DI0_OFFSET,
 #endif
 	.enable = clk_ipu_enable,
@@ -257,7 +259,7 @@ static inline void ipu_ch_param_set_high_priority(uint32_t ch)
 
 static inline uint32_t channel_2_dma(ipu_channel_t ch, ipu_buffer_t type)
 {
-	return ((uint32_t) ch >> (6 * type)) & 0x3F;
+	return ((uint32_t)ch >> (6 * type)) & 0x3F;
 };
 
 /* Either DP BG or DP FG can be graphic window */
@@ -272,15 +274,15 @@ static inline int ipu_is_dmfc_chan(uint32_t dma_chan)
 }
 
 static inline void ipu_ch_param_set_buffer(uint32_t ch, int bufNum,
-					    dma_addr_t phyaddr)
+					   dma_addr_t phyaddr)
 {
 	ipu_ch_param_mod_field(ipu_ch_param_addr(ch), 1, 29 * bufNum, 29,
 			       phyaddr / 8);
 };
 
-#define idma_is_valid(ch)	(ch != NO_DMA)
-#define idma_mask(ch)		(idma_is_valid(ch) ? (1UL << (ch & 0x1F)) : 0)
-#define idma_is_set(reg, dma)	(__raw_readl(reg(dma)) & idma_mask(dma))
+#define idma_is_valid(ch) (ch != NO_DMA)
+#define idma_mask(ch) (idma_is_valid(ch) ? (1UL << (ch & 0x1F)) : 0)
+#define idma_is_set(reg, dma) (__raw_readl(reg(dma)) & idma_mask(dma))
 
 static void ipu_pixel_clk_recalc(struct clk *clk)
 {
@@ -288,8 +290,8 @@ static void ipu_pixel_clk_recalc(struct clk *clk)
 	u64 final_rate = (unsigned long long)clk->parent->rate * 16;
 
 	div = __raw_readl(DI_BS_CLKGEN0(clk->id));
-	debug("read BS_CLKGEN0 div:%d, final_rate:%lld, prate:%ld\n",
-	      div, final_rate, clk->parent->rate);
+	debug("read BS_CLKGEN0 div:%d, final_rate:%lld, prate:%ld\n", div,
+	      final_rate, clk->parent->rate);
 
 	clk->rate = 0;
 	if (div != 0) {
@@ -299,7 +301,7 @@ static void ipu_pixel_clk_recalc(struct clk *clk)
 }
 
 static unsigned long ipu_pixel_clk_round_rate(struct clk *clk,
-	unsigned long rate)
+					      unsigned long rate)
 {
 	u64 div, final_rate;
 	u32 remainder;
@@ -315,7 +317,7 @@ static unsigned long ipu_pixel_clk_round_rate(struct clk *clk,
 	/* Round the divider value */
 	if (remainder > (rate / 2))
 		div++;
-	if (div < 0x10)            /* Min DI disp clock divider is 1 */
+	if (div < 0x10) /* Min DI disp clock divider is 1 */
 		div = 0x10;
 	if (div & ~0xFEF)
 		div &= 0xFF8;
@@ -381,7 +383,6 @@ static void ipu_pixel_clk_disable(struct clk *clk)
 	u32 disp_gen = __raw_readl(IPU_DISP_GEN);
 	disp_gen &= clk->id ? ~DI1_COUNTER_RELEASE : ~DI0_COUNTER_RELEASE;
 	__raw_writel(disp_gen, IPU_DISP_GEN);
-
 }
 
 static int ipu_pixel_clk_set_parent(struct clk *clk, struct clk *parent)
@@ -402,26 +403,26 @@ static int ipu_pixel_clk_set_parent(struct clk *clk, struct clk *parent)
 
 static struct clk pixel_clk[] = {
 	{
-	.name = "pixel_clk",
-	.id = 0,
-	.recalc = ipu_pixel_clk_recalc,
-	.set_rate = ipu_pixel_clk_set_rate,
-	.round_rate = ipu_pixel_clk_round_rate,
-	.set_parent = ipu_pixel_clk_set_parent,
-	.enable = ipu_pixel_clk_enable,
-	.disable = ipu_pixel_clk_disable,
-	.usecount = 0,
+		.name = "pixel_clk",
+		.id = 0,
+		.recalc = ipu_pixel_clk_recalc,
+		.set_rate = ipu_pixel_clk_set_rate,
+		.round_rate = ipu_pixel_clk_round_rate,
+		.set_parent = ipu_pixel_clk_set_parent,
+		.enable = ipu_pixel_clk_enable,
+		.disable = ipu_pixel_clk_disable,
+		.usecount = 0,
 	},
 	{
-	.name = "pixel_clk",
-	.id = 1,
-	.recalc = ipu_pixel_clk_recalc,
-	.set_rate = ipu_pixel_clk_set_rate,
-	.round_rate = ipu_pixel_clk_round_rate,
-	.set_parent = ipu_pixel_clk_set_parent,
-	.enable = ipu_pixel_clk_enable,
-	.disable = ipu_pixel_clk_disable,
-	.usecount = 0,
+		.name = "pixel_clk",
+		.id = 1,
+		.recalc = ipu_pixel_clk_recalc,
+		.set_rate = ipu_pixel_clk_set_rate,
+		.round_rate = ipu_pixel_clk_round_rate,
+		.set_parent = ipu_pixel_clk_set_parent,
+		.enable = ipu_pixel_clk_enable,
+		.disable = ipu_pixel_clk_disable,
+		.usecount = 0,
 	},
 };
 
@@ -455,7 +456,7 @@ static void ipu_reset(void)
  * @param	dev	The device structure for the IPU passed in by the
  *			driver framework.
  *
- * Return:      Returns 0 on success or negative error code on error
+ * Return:	Returns 0 on success or negative error code on error
  */
 int ipu_probe(void)
 {
@@ -466,11 +467,11 @@ int ipu_probe(void)
 	u32 *reg_hsc_mcd = (u32 *)MIPI_HSC_BASE_ADDR;
 	u32 *reg_hsc_mxt_conf = (u32 *)(MIPI_HSC_BASE_ADDR + 0x800);
 
-	 __raw_writel(0xF00, reg_hsc_mcd);
+	__raw_writel(0xF00, reg_hsc_mcd);
 
 	/* CSI mode reserved*/
 	temp = __raw_readl(reg_hsc_mxt_conf);
-	 __raw_writel(temp | 0x0FF, reg_hsc_mxt_conf);
+	__raw_writel(temp | 0x0FF, reg_hsc_mxt_conf);
 
 	temp = __raw_readl(reg_hsc_mxt_conf);
 	__raw_writel(temp | 0x10000, reg_hsc_mxt_conf);
@@ -532,47 +533,34 @@ void ipu_dump_registers(void)
 {
 	debug("IPU_CONF = \t0x%08X\n", __raw_readl(IPU_CONF));
 	debug("IDMAC_CONF = \t0x%08X\n", __raw_readl(IDMAC_CONF));
-	debug("IDMAC_CHA_EN1 = \t0x%08X\n",
-	       __raw_readl(IDMAC_CHA_EN(0)));
-	debug("IDMAC_CHA_EN2 = \t0x%08X\n",
-	       __raw_readl(IDMAC_CHA_EN(32)));
-	debug("IDMAC_CHA_PRI1 = \t0x%08X\n",
-	       __raw_readl(IDMAC_CHA_PRI(0)));
-	debug("IDMAC_CHA_PRI2 = \t0x%08X\n",
-	       __raw_readl(IDMAC_CHA_PRI(32)));
+	debug("IDMAC_CHA_EN1 = \t0x%08X\n", __raw_readl(IDMAC_CHA_EN(0)));
+	debug("IDMAC_CHA_EN2 = \t0x%08X\n", __raw_readl(IDMAC_CHA_EN(32)));
+	debug("IDMAC_CHA_PRI1 = \t0x%08X\n", __raw_readl(IDMAC_CHA_PRI(0)));
+	debug("IDMAC_CHA_PRI2 = \t0x%08X\n", __raw_readl(IDMAC_CHA_PRI(32)));
 	debug("IPU_CHA_DB_MODE_SEL0 = \t0x%08X\n",
-	       __raw_readl(IPU_CHA_DB_MODE_SEL(0)));
+	      __raw_readl(IPU_CHA_DB_MODE_SEL(0)));
 	debug("IPU_CHA_DB_MODE_SEL1 = \t0x%08X\n",
-	       __raw_readl(IPU_CHA_DB_MODE_SEL(32)));
-	debug("DMFC_WR_CHAN = \t0x%08X\n",
-	       __raw_readl(DMFC_WR_CHAN));
-	debug("DMFC_WR_CHAN_DEF = \t0x%08X\n",
-	       __raw_readl(DMFC_WR_CHAN_DEF));
-	debug("DMFC_DP_CHAN = \t0x%08X\n",
-	       __raw_readl(DMFC_DP_CHAN));
-	debug("DMFC_DP_CHAN_DEF = \t0x%08X\n",
-	       __raw_readl(DMFC_DP_CHAN_DEF));
-	debug("DMFC_IC_CTRL = \t0x%08X\n",
-	       __raw_readl(DMFC_IC_CTRL));
-	debug("IPU_FS_PROC_FLOW1 = \t0x%08X\n",
-	       __raw_readl(IPU_FS_PROC_FLOW1));
-	debug("IPU_FS_PROC_FLOW2 = \t0x%08X\n",
-	       __raw_readl(IPU_FS_PROC_FLOW2));
-	debug("IPU_FS_PROC_FLOW3 = \t0x%08X\n",
-	       __raw_readl(IPU_FS_PROC_FLOW3));
-	debug("IPU_FS_DISP_FLOW1 = \t0x%08X\n",
-	       __raw_readl(IPU_FS_DISP_FLOW1));
+	      __raw_readl(IPU_CHA_DB_MODE_SEL(32)));
+	debug("DMFC_WR_CHAN = \t0x%08X\n", __raw_readl(DMFC_WR_CHAN));
+	debug("DMFC_WR_CHAN_DEF = \t0x%08X\n", __raw_readl(DMFC_WR_CHAN_DEF));
+	debug("DMFC_DP_CHAN = \t0x%08X\n", __raw_readl(DMFC_DP_CHAN));
+	debug("DMFC_DP_CHAN_DEF = \t0x%08X\n", __raw_readl(DMFC_DP_CHAN_DEF));
+	debug("DMFC_IC_CTRL = \t0x%08X\n", __raw_readl(DMFC_IC_CTRL));
+	debug("IPU_FS_PROC_FLOW1 = \t0x%08X\n", __raw_readl(IPU_FS_PROC_FLOW1));
+	debug("IPU_FS_PROC_FLOW2 = \t0x%08X\n", __raw_readl(IPU_FS_PROC_FLOW2));
+	debug("IPU_FS_PROC_FLOW3 = \t0x%08X\n", __raw_readl(IPU_FS_PROC_FLOW3));
+	debug("IPU_FS_DISP_FLOW1 = \t0x%08X\n", __raw_readl(IPU_FS_DISP_FLOW1));
 }
 
 /*
  * This function is called to initialize a logical IPU channel.
  *
- * @param       channel Input parameter for the logical channel ID to init.
+ * @param	channel Input parameter for the logical channel ID to init.
  *
- * @param       params  Input parameter containing union of channel
- *                      initialization parameters.
+ * @param	params	Input parameter containing union of channel
+ *			initialization parameters.
  *
- * Return:      Returns 0 on success or negative error code on fail
+ * Return:	Returns 0 on success or negative error code on fail
  */
 int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params)
 {
@@ -588,7 +576,7 @@ int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params)
 
 	if (g_channel_init_mask & (1L << IPU_CHAN_ID(channel))) {
 		printf("Warning: channel already initialized %d\n",
-			IPU_CHAN_ID(channel));
+		       IPU_CHAN_ID(channel));
 	}
 
 	ipu_conf = __raw_readl(IPU_CONF);
@@ -602,7 +590,7 @@ int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params)
 
 		g_dc_di_assignment[1] = params->mem_dc_sync.di;
 		ipu_dc_init(1, params->mem_dc_sync.di,
-			     params->mem_dc_sync.interlaced);
+			    params->mem_dc_sync.interlaced);
 		ipu_di_use_count[params->mem_dc_sync.di]++;
 		ipu_dc_use_count++;
 		ipu_dmfc_use_count++;
@@ -615,9 +603,9 @@ int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params)
 
 		g_dc_di_assignment[5] = params->mem_dp_bg_sync.di;
 		ipu_dp_init(channel, params->mem_dp_bg_sync.in_pixel_fmt,
-			     params->mem_dp_bg_sync.out_pixel_fmt);
+			    params->mem_dp_bg_sync.out_pixel_fmt);
 		ipu_dc_init(5, params->mem_dp_bg_sync.di,
-			     params->mem_dp_bg_sync.interlaced);
+			    params->mem_dp_bg_sync.interlaced);
 		ipu_di_use_count[params->mem_dp_bg_sync.di]++;
 		ipu_dc_use_count++;
 		ipu_dp_use_count++;
@@ -625,7 +613,7 @@ int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params)
 		break;
 	case MEM_FG_SYNC:
 		ipu_dp_init(channel, params->mem_dp_fg_sync.in_pixel_fmt,
-			     params->mem_dp_fg_sync.out_pixel_fmt);
+			    params->mem_dp_fg_sync.out_pixel_fmt);
 
 		ipu_dc_use_count++;
 		ipu_dp_use_count++;
@@ -644,12 +632,10 @@ int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params)
 		ipu_conf |= IPU_CONF_DP_EN;
 	if (ipu_dmfc_use_count == 1)
 		ipu_conf |= IPU_CONF_DMFC_EN;
-	if (ipu_di_use_count[0] == 1) {
+	if (ipu_di_use_count[0] == 1)
 		ipu_conf |= IPU_CONF_DI0_EN;
-	}
-	if (ipu_di_use_count[1] == 1) {
+	if (ipu_di_use_count[1] == 1)
 		ipu_conf |= IPU_CONF_DI1_EN;
-	}
 
 	__raw_writel(ipu_conf, IPU_CONF);
 
@@ -660,7 +646,7 @@ err:
 /*
  * This function is called to uninitialize a logical IPU channel.
  *
- * @param       channel Input parameter for the logical channel ID to uninit.
+ * @param	channel Input parameter for the logical channel ID to uninit.
  */
 void ipu_uninit_channel(ipu_channel_t channel)
 {
@@ -670,7 +656,7 @@ void ipu_uninit_channel(ipu_channel_t channel)
 
 	if ((g_channel_init_mask & (1L << IPU_CHAN_ID(channel))) == 0) {
 		debug("Channel already uninitialized %d\n",
-			IPU_CHAN_ID(channel));
+		      IPU_CHAN_ID(channel));
 		return;
 	}
 
@@ -683,9 +669,8 @@ void ipu_uninit_channel(ipu_channel_t channel)
 
 	if (idma_is_set(IDMAC_CHA_EN, in_dma) ||
 	    idma_is_set(IDMAC_CHA_EN, out_dma)) {
-		printf(
-			"Channel %d is not disabled, disable first\n",
-			IPU_CHAN_ID(channel));
+		printf("Channel %d is not disabled, disable first\n",
+		       IPU_CHAN_ID(channel));
 		return;
 	}
 
@@ -730,12 +715,10 @@ void ipu_uninit_channel(ipu_channel_t channel)
 		ipu_conf &= ~IPU_CONF_DP_EN;
 	if (ipu_dmfc_use_count == 0)
 		ipu_conf &= ~IPU_CONF_DMFC_EN;
-	if (ipu_di_use_count[0] == 0) {
+	if (ipu_di_use_count[0] == 0)
 		ipu_conf &= ~IPU_CONF_DI0_EN;
-	}
-	if (ipu_di_use_count[1] == 0) {
+	if (ipu_di_use_count[1] == 0)
 		ipu_conf &= ~IPU_CONF_DI1_EN;
-	}
 
 	__raw_writel(ipu_conf, IPU_CONF);
 
@@ -743,7 +726,6 @@ void ipu_uninit_channel(ipu_channel_t channel)
 		clk_disable(g_ipu_clk);
 		g_ipu_clk_enabled = 0;
 	}
-
 }
 
 static inline void ipu_ch_param_dump(int ch)
@@ -751,49 +733,49 @@ static inline void ipu_ch_param_dump(int ch)
 #ifdef DEBUG
 	struct ipu_ch_param *p = ipu_ch_param_addr(ch);
 	debug("ch %d word 0 - %08X %08X %08X %08X %08X\n", ch,
-		 p->word[0].data[0], p->word[0].data[1], p->word[0].data[2],
-		 p->word[0].data[3], p->word[0].data[4]);
+	      p->word[0].data[0], p->word[0].data[1], p->word[0].data[2],
+	      p->word[0].data[3], p->word[0].data[4]);
 	debug("ch %d word 1 - %08X %08X %08X %08X %08X\n", ch,
-		 p->word[1].data[0], p->word[1].data[1], p->word[1].data[2],
-		 p->word[1].data[3], p->word[1].data[4]);
+	      p->word[1].data[0], p->word[1].data[1], p->word[1].data[2],
+	      p->word[1].data[3], p->word[1].data[4]);
 	debug("PFS 0x%x, ",
-		 ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 85, 4));
+	      ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 85, 4));
 	debug("BPP 0x%x, ",
-		 ipu_ch_param_read_field(ipu_ch_param_addr(ch), 0, 107, 3));
+	      ipu_ch_param_read_field(ipu_ch_param_addr(ch), 0, 107, 3));
 	debug("NPB 0x%x\n",
-		 ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 78, 7));
+	      ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 78, 7));
 
 	debug("FW %d, ",
-		 ipu_ch_param_read_field(ipu_ch_param_addr(ch), 0, 125, 13));
+	      ipu_ch_param_read_field(ipu_ch_param_addr(ch), 0, 125, 13));
 	debug("FH %d, ",
-		 ipu_ch_param_read_field(ipu_ch_param_addr(ch), 0, 138, 12));
+	      ipu_ch_param_read_field(ipu_ch_param_addr(ch), 0, 138, 12));
 	debug("Stride %d\n",
-		 ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 102, 14));
+	      ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 102, 14));
 
 	debug("Width0 %d+1, ",
-		 ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 116, 3));
+	      ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 116, 3));
 	debug("Width1 %d+1, ",
-		 ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 119, 3));
+	      ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 119, 3));
 	debug("Width2 %d+1, ",
-		 ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 122, 3));
+	      ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 122, 3));
 	debug("Width3 %d+1, ",
-		 ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 125, 3));
+	      ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 125, 3));
 	debug("Offset0 %d, ",
-		 ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 128, 5));
+	      ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 128, 5));
 	debug("Offset1 %d, ",
-		 ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 133, 5));
+	      ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 133, 5));
 	debug("Offset2 %d, ",
-		 ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 138, 5));
+	      ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 138, 5));
 	debug("Offset3 %d\n",
-		 ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 143, 5));
+	      ipu_ch_param_read_field(ipu_ch_param_addr(ch), 1, 143, 5));
 #endif
 }
 
 static inline void ipu_ch_params_set_packing(struct ipu_ch_param *p,
-					      int red_width, int red_offset,
-					      int green_width, int green_offset,
-					      int blue_width, int blue_offset,
-					      int alpha_width, int alpha_offset)
+					     int red_width, int red_offset,
+					     int green_width, int green_offset,
+					     int blue_width, int blue_offset,
+					     int alpha_width, int alpha_offset)
 {
 	/* Setup red width and offset */
 	ipu_ch_param_set_field(p, 1, 116, 3, red_width - 1);
@@ -809,11 +791,9 @@ static inline void ipu_ch_params_set_packing(struct ipu_ch_param *p,
 	ipu_ch_param_set_field(p, 1, 143, 5, alpha_offset);
 }
 
-static void ipu_ch_param_init(int ch,
-			      uint32_t pixel_fmt, uint32_t width,
-			      uint32_t height, uint32_t stride,
-			      uint32_t u, uint32_t v,
-			      uint32_t uv_stride, dma_addr_t addr0,
+static void ipu_ch_param_init(int ch, uint32_t pixel_fmt, uint32_t width,
+			      uint32_t height, uint32_t stride, uint32_t u,
+			      uint32_t v, uint32_t uv_stride, dma_addr_t addr0,
 			      dma_addr_t addr1)
 {
 	uint32_t u_offset = 0;
@@ -838,71 +818,71 @@ static void ipu_ch_param_init(int ch,
 	switch (pixel_fmt) {
 	case IPU_PIX_FMT_GENERIC:
 		/*Represents 8-bit Generic data */
-		ipu_ch_param_set_field(&params, 0, 107, 3, 5);	/* bits/pixel */
-		ipu_ch_param_set_field(&params, 1, 85, 4, 6);	/* pix format */
-		ipu_ch_param_set_field(&params, 1, 78, 7, 63);	/* burst size */
+		ipu_ch_param_set_field(&params, 0, 107, 3, 5); /* bits/pixel */
+		ipu_ch_param_set_field(&params, 1, 85, 4, 6); /* pix format */
+		ipu_ch_param_set_field(&params, 1, 78, 7, 63); /* burst size */
 
 		break;
 	case IPU_PIX_FMT_GENERIC_32:
 		/*Represents 32-bit Generic data */
 		break;
 	case IPU_PIX_FMT_RGB565:
-		ipu_ch_param_set_field(&params, 0, 107, 3, 3);	/* bits/pixel */
-		ipu_ch_param_set_field(&params, 1, 85, 4, 7);	/* pix format */
-		ipu_ch_param_set_field(&params, 1, 78, 7, 15);	/* burst size */
+		ipu_ch_param_set_field(&params, 0, 107, 3, 3); /* bits/pixel */
+		ipu_ch_param_set_field(&params, 1, 85, 4, 7); /* pix format */
+		ipu_ch_param_set_field(&params, 1, 78, 7, 15); /* burst size */
 
 		ipu_ch_params_set_packing(&params, 5, 0, 6, 5, 5, 11, 8, 16);
 		break;
 	case IPU_PIX_FMT_BGR24:
-		ipu_ch_param_set_field(&params, 0, 107, 3, 1);	/* bits/pixel */
-		ipu_ch_param_set_field(&params, 1, 85, 4, 7);	/* pix format */
-		ipu_ch_param_set_field(&params, 1, 78, 7, 19);	/* burst size */
+		ipu_ch_param_set_field(&params, 0, 107, 3, 1); /* bits/pixel */
+		ipu_ch_param_set_field(&params, 1, 85, 4, 7); /* pix format */
+		ipu_ch_param_set_field(&params, 1, 78, 7, 19); /* burst size */
 
 		ipu_ch_params_set_packing(&params, 8, 0, 8, 8, 8, 16, 8, 24);
 		break;
 	case IPU_PIX_FMT_RGB24:
 	case IPU_PIX_FMT_YUV444:
-		ipu_ch_param_set_field(&params, 0, 107, 3, 1);	/* bits/pixel */
-		ipu_ch_param_set_field(&params, 1, 85, 4, 7);	/* pix format */
-		ipu_ch_param_set_field(&params, 1, 78, 7, 19);	/* burst size */
+		ipu_ch_param_set_field(&params, 0, 107, 3, 1); /* bits/pixel */
+		ipu_ch_param_set_field(&params, 1, 85, 4, 7); /* pix format */
+		ipu_ch_param_set_field(&params, 1, 78, 7, 19); /* burst size */
 
 		ipu_ch_params_set_packing(&params, 8, 16, 8, 8, 8, 0, 8, 24);
 		break;
 	case IPU_PIX_FMT_BGRA32:
 	case IPU_PIX_FMT_BGR32:
-		ipu_ch_param_set_field(&params, 0, 107, 3, 0);	/* bits/pixel */
-		ipu_ch_param_set_field(&params, 1, 85, 4, 7);	/* pix format */
-		ipu_ch_param_set_field(&params, 1, 78, 7, 15);	/* burst size */
+		ipu_ch_param_set_field(&params, 0, 107, 3, 0); /* bits/pixel */
+		ipu_ch_param_set_field(&params, 1, 85, 4, 7); /* pix format */
+		ipu_ch_param_set_field(&params, 1, 78, 7, 15); /* burst size */
 
 		ipu_ch_params_set_packing(&params, 8, 8, 8, 16, 8, 24, 8, 0);
 		break;
 	case IPU_PIX_FMT_RGBA32:
 	case IPU_PIX_FMT_RGB32:
-		ipu_ch_param_set_field(&params, 0, 107, 3, 0);	/* bits/pixel */
-		ipu_ch_param_set_field(&params, 1, 85, 4, 7);	/* pix format */
-		ipu_ch_param_set_field(&params, 1, 78, 7, 15);	/* burst size */
+		ipu_ch_param_set_field(&params, 0, 107, 3, 0); /* bits/pixel */
+		ipu_ch_param_set_field(&params, 1, 85, 4, 7); /* pix format */
+		ipu_ch_param_set_field(&params, 1, 78, 7, 15); /* burst size */
 
 		ipu_ch_params_set_packing(&params, 8, 24, 8, 16, 8, 8, 8, 0);
 		break;
 	case IPU_PIX_FMT_ABGR32:
-		ipu_ch_param_set_field(&params, 0, 107, 3, 0);	/* bits/pixel */
-		ipu_ch_param_set_field(&params, 1, 85, 4, 7);	/* pix format */
+		ipu_ch_param_set_field(&params, 0, 107, 3, 0); /* bits/pixel */
+		ipu_ch_param_set_field(&params, 1, 85, 4, 7); /* pix format */
 
 		ipu_ch_params_set_packing(&params, 8, 0, 8, 8, 8, 16, 8, 24);
 		break;
 	case IPU_PIX_FMT_UYVY:
-		ipu_ch_param_set_field(&params, 0, 107, 3, 3);	/* bits/pixel */
-		ipu_ch_param_set_field(&params, 1, 85, 4, 0xA);	/* pix format */
-		ipu_ch_param_set_field(&params, 1, 78, 7, 15);	/* burst size */
+		ipu_ch_param_set_field(&params, 0, 107, 3, 3); /* bits/pixel */
+		ipu_ch_param_set_field(&params, 1, 85, 4, 0xA); /* pix format */
+		ipu_ch_param_set_field(&params, 1, 78, 7, 15); /* burst size */
 		break;
 	case IPU_PIX_FMT_YUYV:
-		ipu_ch_param_set_field(&params, 0, 107, 3, 3);	/* bits/pixel */
-		ipu_ch_param_set_field(&params, 1, 85, 4, 0x8);	/* pix format */
-		ipu_ch_param_set_field(&params, 1, 78, 7, 31);	/* burst size */
+		ipu_ch_param_set_field(&params, 0, 107, 3, 3); /* bits/pixel */
+		ipu_ch_param_set_field(&params, 1, 85, 4, 0x8); /* pix format */
+		ipu_ch_param_set_field(&params, 1, 78, 7, 31); /* burst size */
 		break;
 	case IPU_PIX_FMT_YUV420P2:
 	case IPU_PIX_FMT_YUV420P:
-		ipu_ch_param_set_field(&params, 1, 85, 4, 2);	/* pix format */
+		ipu_ch_param_set_field(&params, 1, 85, 4, 2); /* pix format */
 
 		if (uv_stride < stride / 2)
 			uv_stride = stride / 2;
@@ -912,15 +892,15 @@ static void ipu_ch_param_init(int ch,
 		/* burst size */
 		if ((ch == 8) || (ch == 9) || (ch == 10)) {
 			ipu_ch_param_set_field(&params, 1, 78, 7, 15);
-			uv_stride = uv_stride*2;
+			uv_stride = uv_stride * 2;
 		} else {
 			ipu_ch_param_set_field(&params, 1, 78, 7, 31);
 		}
 		break;
 	case IPU_PIX_FMT_YVU422P:
 		/* BPP & pixel format */
-		ipu_ch_param_set_field(&params, 1, 85, 4, 1);	/* pix format */
-		ipu_ch_param_set_field(&params, 1, 78, 7, 31);	/* burst size */
+		ipu_ch_param_set_field(&params, 1, 85, 4, 1); /* pix format */
+		ipu_ch_param_set_field(&params, 1, 78, 7, 31); /* burst size */
 
 		if (uv_stride < stride / 2)
 			uv_stride = stride / 2;
@@ -930,8 +910,8 @@ static void ipu_ch_param_init(int ch,
 		break;
 	case IPU_PIX_FMT_YUV422P:
 		/* BPP & pixel format */
-		ipu_ch_param_set_field(&params, 1, 85, 4, 1);	/* pix format */
-		ipu_ch_param_set_field(&params, 1, 78, 7, 31);	/* burst size */
+		ipu_ch_param_set_field(&params, 1, 85, 4, 1); /* pix format */
+		ipu_ch_param_set_field(&params, 1, 78, 7, 31); /* burst size */
 
 		if (uv_stride < stride / 2)
 			uv_stride = stride / 2;
@@ -941,8 +921,8 @@ static void ipu_ch_param_init(int ch,
 		break;
 	case IPU_PIX_FMT_NV12:
 		/* BPP & pixel format */
-		ipu_ch_param_set_field(&params, 1, 85, 4, 4);	/* pix format */
-		ipu_ch_param_set_field(&params, 1, 78, 7, 31);	/* burst size */
+		ipu_ch_param_set_field(&params, 1, 85, 4, 4); /* pix format */
+		ipu_ch_param_set_field(&params, 1, 78, 7, 31); /* burst size */
 		uv_stride = stride;
 		u_offset = (u == 0) ? stride * height : u;
 		break;
@@ -961,9 +941,9 @@ static void ipu_ch_param_init(int ch,
 	}
 
 	/* UBO and VBO are 22-bit */
-	if (u_offset/8 > 0x3fffff)
+	if (u_offset / 8 > 0x3fffff)
 		puts("The value of U offset exceeds IPU limitation\n");
-	if (v_offset/8 > 0x3fffff)
+	if (v_offset / 8 > 0x3fffff)
 		puts("The value of V offset exceeds IPU limitation\n");
 
 	ipu_ch_param_set_field(&params, 0, 46, 22, u_offset / 8);
@@ -976,38 +956,37 @@ static void ipu_ch_param_init(int ch,
 /*
  * This function is called to initialize a buffer for logical IPU channel.
  *
- * @param       channel         Input parameter for the logical channel ID.
+ * @param	channel		Input parameter for the logical channel ID.
  *
- * @param       type            Input parameter which buffer to initialize.
+ * @param	type		Input parameter which buffer to initialize.
  *
- * @param       pixel_fmt       Input parameter for pixel format of buffer.
- *                              Pixel format is a FOURCC ASCII code.
+ * @param	pixel_fmt	Input parameter for pixel format of buffer.
+ *				Pixel format is a FOURCC ASCII code.
  *
- * @param       width           Input parameter for width of buffer in pixels.
+ * @param	width		Input parameter for width of buffer in pixels.
  *
- * @param       height          Input parameter for height of buffer in pixels.
+ * @param	height		Input parameter for height of buffer in pixels.
  *
- * @param       stride          Input parameter for stride length of buffer
- *                              in pixels.
+ * @param	stride		Input parameter for stride length of buffer
+ *				in pixels.
  *
- * @param       phyaddr_0       Input parameter buffer 0 physical address.
+ * @param	phyaddr_0	Input parameter buffer 0 physical address.
  *
- * @param       phyaddr_1       Input parameter buffer 1 physical address.
- *                              Setting this to a value other than NULL enables
- *                              double buffering mode.
+ * @param	phyaddr_1	Input parameter buffer 1 physical address.
+ *				Setting this to a value other than NULL enables
+ *				double buffering mode.
  *
- * @param       u		private u offset for additional cropping,
+ * @param	u		private u offset for additional cropping,
  *				zero if not used.
  *
- * @param       v		private v offset for additional cropping,
+ * @param	v		private v offset for additional cropping,
  *				zero if not used.
  *
- * Return:      Returns 0 on success or negative error code on fail
+ * Return:	Returns 0 on success or negative error code on fail
  */
 int32_t ipu_init_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
-				uint32_t pixel_fmt,
-				uint16_t width, uint16_t height,
-				uint32_t stride,
+				uint32_t pixel_fmt, uint16_t width,
+				uint16_t height, uint32_t stride,
 				dma_addr_t phyaddr_0, dma_addr_t phyaddr_1,
 				uint32_t u, uint32_t v)
 {
@@ -1022,17 +1001,15 @@ int32_t ipu_init_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
 		stride = width * bytes_per_pixel(pixel_fmt);
 
 	if (stride % 4) {
-		printf(
-			"Stride not 32-bit aligned, stride = %d\n", stride);
+		printf("Stride not 32-bit aligned, stride = %d\n", stride);
 		return -EINVAL;
 	}
 	/* Build parameter memory data for DMA channel */
 	ipu_ch_param_init(dma_chan, pixel_fmt, width, height, stride, u, v, 0,
-			   phyaddr_0, phyaddr_1);
+			  phyaddr_0, phyaddr_1);
 
-	if (ipu_is_dmfc_chan(dma_chan)) {
+	if (ipu_is_dmfc_chan(dma_chan))
 		ipu_dmfc_set_wait4eot(dma_chan, width);
-	}
 
 	if (idma_is_set(IDMAC_CHA_PRI, dma_chan))
 		ipu_ch_param_set_high_priority(dma_chan);
@@ -1055,10 +1032,10 @@ int32_t ipu_init_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
 /*
  * This function enables a logical channel.
  *
- * @param       channel         Input parameter for the logical channel ID.
+ * @param	channel		Input parameter for the logical channel ID.
  *
- * Return:      This function returns 0 on success or negative error code on
- *              fail.
+ * Return:	This function returns 0 on success or negative error code on
+ *		fail.
  */
 int32_t ipu_enable_channel(ipu_channel_t channel)
 {
@@ -1068,7 +1045,7 @@ int32_t ipu_enable_channel(ipu_channel_t channel)
 
 	if (g_channel_enable_mask & (1L << IPU_CHAN_ID(channel))) {
 		printf("Warning: channel already enabled %d\n",
-			IPU_CHAN_ID(channel));
+		       IPU_CHAN_ID(channel));
 	}
 
 	/* Get input and output dma channels */
@@ -1096,16 +1073,16 @@ int32_t ipu_enable_channel(ipu_channel_t channel)
 /*
  * This function clear buffer ready for a logical channel.
  *
- * @param       channel         Input parameter for the logical channel ID.
+ * @param	channel		Input parameter for the logical channel ID.
  *
- * @param       type            Input parameter which buffer to clear.
+ * @param	type		Input parameter which buffer to clear.
  *
- * @param       bufNum          Input parameter for which buffer number clear
+ * @param	bufNum		Input parameter for which buffer number clear
  *				ready state.
  *
  */
 void ipu_clear_buffer_ready(ipu_channel_t channel, ipu_buffer_t type,
-		uint32_t bufNum)
+			    uint32_t bufNum)
 {
 	uint32_t dma_ch = channel_2_dma(channel, type);
 
@@ -1116,13 +1093,10 @@ void ipu_clear_buffer_ready(ipu_channel_t channel, ipu_buffer_t type,
 	if (bufNum == 0) {
 		if (idma_is_set(IPU_CHA_BUF0_RDY, dma_ch)) {
 			__raw_writel(idma_mask(dma_ch),
-					IPU_CHA_BUF0_RDY(dma_ch));
-		}
-	} else {
-		if (idma_is_set(IPU_CHA_BUF1_RDY, dma_ch)) {
-			__raw_writel(idma_mask(dma_ch),
-					IPU_CHA_BUF1_RDY(dma_ch));
+				     IPU_CHA_BUF0_RDY(dma_ch));
 		}
+	} else if (idma_is_set(IPU_CHA_BUF1_RDY, dma_ch)) {
+		__raw_writel(idma_mask(dma_ch), IPU_CHA_BUF1_RDY(dma_ch));
 	}
 	__raw_writel(0x0, IPU_GPR); /* write one to set */
 }
@@ -1130,13 +1104,13 @@ void ipu_clear_buffer_ready(ipu_channel_t channel, ipu_buffer_t type,
 /*
  * This function disables a logical channel.
  *
- * @param       channel         Input parameter for the logical channel ID.
+ * @param	channel		Input parameter for the logical channel ID.
  *
- * @param       wait_for_stop   Flag to set whether to wait for channel end
- *                              of frame or return immediately.
+ * @param	wait_for_stop	Flag to set whether to wait for channel end
+ *				of frame or return immediately.
  *
- * Return:      This function returns 0 on success or negative error code on
- *              fail.
+ * Return:	This function returns 0 on success or negative error code on
+ *		fail.
  */
 int32_t ipu_disable_channel(ipu_channel_t channel)
 {
@@ -1145,8 +1119,7 @@ int32_t ipu_disable_channel(ipu_channel_t channel)
 	uint32_t out_dma;
 
 	if ((g_channel_enable_mask & (1L << IPU_CHAN_ID(channel))) == 0) {
-		debug("Channel already disabled %d\n",
-			IPU_CHAN_ID(channel));
+		debug("Channel already disabled %d\n", IPU_CHAN_ID(channel));
 		return 0;
 	}
 
@@ -1154,10 +1127,8 @@ int32_t ipu_disable_channel(ipu_channel_t channel)
 	out_dma = channel_2_dma(channel, IPU_OUTPUT_BUFFER);
 	in_dma = channel_2_dma(channel, IPU_VIDEO_IN_BUFFER);
 
-	if ((idma_is_valid(in_dma) &&
-		!idma_is_set(IDMAC_CHA_EN, in_dma))
-		&& (idma_is_valid(out_dma) &&
-		!idma_is_set(IDMAC_CHA_EN, out_dma)))
+	if ((idma_is_valid(in_dma) && !idma_is_set(IDMAC_CHA_EN, in_dma)) &&
+	    (idma_is_valid(out_dma) && !idma_is_set(IDMAC_CHA_EN, out_dma)))
 		return -EINVAL;
 
 	if ((channel == MEM_BG_SYNC) || (channel == MEM_FG_SYNC) ||
@@ -1195,7 +1166,7 @@ int32_t ipu_disable_channel(ipu_channel_t channel)
 uint32_t bytes_per_pixel(uint32_t fmt)
 {
 	switch (fmt) {
-	case IPU_PIX_FMT_GENERIC:	/*generic data */
+	case IPU_PIX_FMT_GENERIC: /*generic data */
 	case IPU_PIX_FMT_RGB332:
 	case IPU_PIX_FMT_YUV420P:
 	case IPU_PIX_FMT_YUV422P:
@@ -1210,7 +1181,7 @@ uint32_t bytes_per_pixel(uint32_t fmt)
 	case IPU_PIX_FMT_RGB24:
 		return 3;
 		break;
-	case IPU_PIX_FMT_GENERIC_32:	/*generic data */
+	case IPU_PIX_FMT_GENERIC_32: /*generic data */
 	case IPU_PIX_FMT_BGR32:
 	case IPU_PIX_FMT_BGRA32:
 	case IPU_PIX_FMT_RGB32:
diff --git a/drivers/video/imx/ipu_disp.c b/drivers/video/imx/ipu_disp.c
index aaba7d135a4..178442a2bca 100644
--- a/drivers/video/imx/ipu_disp.c
+++ b/drivers/video/imx/ipu_disp.c
@@ -12,24 +12,17 @@
 
 /* #define DEBUG */
 
-#include <log.h>
-#include <linux/delay.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <asm/io.h>
-#include <asm/arch/imx-regs.h>
-#include <asm/arch/sys_proto.h>
 #include "ipu.h"
 #include "ipu_regs.h"
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <log.h>
 
-enum csc_type_t {
-	RGB2YUV = 0,
-	YUV2RGB,
-	RGB2RGB,
-	YUV2YUV,
-	CSC_NONE,
-	CSC_NUM
-};
+enum csc_type_t { RGB2YUV = 0, YUV2RGB, RGB2RGB, YUV2YUV, CSC_NONE, CSC_NUM };
 
 struct dp_csc_param_t {
 	int mode;
@@ -39,9 +32,9 @@ struct dp_csc_param_t {
 #define SYNC_WAVE 0
 
 /* DC display ID assignments */
-#define DC_DISP_ID_SYNC(di)	(di)
-#define DC_DISP_ID_SERIAL	2
-#define DC_DISP_ID_ASYNC	3
+#define DC_DISP_ID_SYNC(di) (di)
+#define DC_DISP_ID_SERIAL 2
+#define DC_DISP_ID_ASYNC 3
 
 int dmfc_type_setup;
 static int dmfc_size_28, dmfc_size_29, dmfc_size_24, dmfc_size_27, dmfc_size_23;
@@ -177,18 +170,17 @@ void ipu_dmfc_set_wait4eot(int dma_chan, int width)
 	__raw_writel(dmfc_gen1, DMFC_GENERAL1);
 }
 
-static void ipu_di_data_wave_config(int di,
-				     int wave_gen,
-				     int access_size, int component_size)
+static void ipu_di_data_wave_config(int di, int wave_gen, int access_size,
+				    int component_size)
 {
 	u32 reg;
 	reg = (access_size << DI_DW_GEN_ACCESS_SIZE_OFFSET) |
-	    (component_size << DI_DW_GEN_COMPONENT_SIZE_OFFSET);
+	      (component_size << DI_DW_GEN_COMPONENT_SIZE_OFFSET);
 	__raw_writel(reg, DI_DW_GEN(di, wave_gen));
 }
 
 static void ipu_di_data_pin_config(int di, int wave_gen, int di_pin, int set,
-				    int up, int down)
+				   int up, int down)
 {
 	u32 reg;
 
@@ -200,29 +192,29 @@ static void ipu_di_data_pin_config(int di, int wave_gen, int di_pin, int set,
 	__raw_writel((down << 16) | up, DI_DW_SET(di, wave_gen, set));
 }
 
-static void ipu_di_sync_config(int di, int wave_gen,
-				int run_count, int run_src,
-				int offset_count, int offset_src,
-				int repeat_count, int cnt_clr_src,
-				int cnt_polarity_gen_en,
-				int cnt_polarity_clr_src,
-				int cnt_polarity_trigger_src,
-				int cnt_up, int cnt_down)
+static void ipu_di_sync_config(int di, int wave_gen, int run_count, int run_src,
+			       int offset_count, int offset_src,
+			       int repeat_count, int cnt_clr_src,
+			       int cnt_polarity_gen_en,
+			       int cnt_polarity_clr_src,
+			       int cnt_polarity_trigger_src, int cnt_up,
+			       int cnt_down)
 {
 	u32 reg;
 
 	if ((run_count >= 0x1000) || (offset_count >= 0x1000) ||
-		(repeat_count >= 0x1000) ||
-		(cnt_up >= 0x400) || (cnt_down >= 0x400)) {
+	    (repeat_count >= 0x1000) || (cnt_up >= 0x400) ||
+	    (cnt_down >= 0x400)) {
 		printf("DI%d counters out of range.\n", di);
 		return;
 	}
 
-	reg = (run_count << 19) | (++run_src << 16) |
-	    (offset_count << 3) | ++offset_src;
+	reg = (run_count << 19) | (++run_src << 16) | (offset_count << 3) |
+	      ++offset_src;
 	__raw_writel(reg, DI_SW_GEN0(di, wave_gen));
 	reg = (cnt_polarity_gen_en << 29) | (++cnt_clr_src << 25) |
-	    (++cnt_polarity_trigger_src << 12) | (++cnt_polarity_clr_src << 9);
+	      (++cnt_polarity_trigger_src << 12) |
+	      (++cnt_polarity_clr_src << 9);
 	reg |= (cnt_down << 16) | cnt_up;
 	if (repeat_count == 0) {
 		/* Enable auto reload */
@@ -259,7 +251,7 @@ static void ipu_dc_map_clear(int map)
 }
 
 static void ipu_dc_write_tmpl(int word, u32 opcode, u32 operand, int map,
-			       int wave, int glue, int sync)
+			      int wave, int glue, int sync)
 {
 	u32 reg;
 	int stop = 1;
@@ -292,11 +284,9 @@ static void ipu_dc_link_event(int chan, int event, int addr, int priority)
  * V = R *  2.000 + G * -1.672 + B * -.328 + 512.250.;
  */
 static const int rgb2ycbcr_coeff[5][3] = {
-	{0x4D, 0x96, 0x1D},
-	{0x3D5, 0x3AB, 0x80},
-	{0x80, 0x395, 0x3EB},
-	{0x0000, 0x0200, 0x0200},	/* B0, B1, B2 */
-	{0x2, 0x2, 0x2},	/* S0, S1, S2 */
+	{ 0x4D, 0x96, 0x1D },	{ 0x3D5, 0x3AB, 0x80 },
+	{ 0x80, 0x395, 0x3EB }, { 0x0000, 0x0200, 0x0200 }, /* B0, B1, B2 */
+	{ 0x2, 0x2, 0x2 }, /* S0, S1, S2 */
 };
 
 /* R = (1.164 * (Y - 16)) + (1.596 * (Cr - 128));
@@ -304,11 +294,9 @@ static const int rgb2ycbcr_coeff[5][3] = {
  * B = (1.164 * (Y - 16)) + (2.017 * (Cb - 128);
  */
 static const int ycbcr2rgb_coeff[5][3] = {
-	{0x095, 0x000, 0x0CC},
-	{0x095, 0x3CE, 0x398},
-	{0x095, 0x0FF, 0x000},
-	{0x3E42, 0x010A, 0x3DD6},	/*B0,B1,B2 */
-	{0x1, 0x1, 0x1},	/*S0,S1,S2 */
+	{ 0x095, 0x000, 0x0CC }, { 0x095, 0x3CE, 0x398 },
+	{ 0x095, 0x0FF, 0x000 }, { 0x3E42, 0x010A, 0x3DD6 }, /*B0,B1,B2 */
+	{ 0x1, 0x1, 0x1 }, /*S0,S1,S2 */
 };
 
 #define mask_a(a) ((u32)(a) & 0x3FF)
@@ -337,48 +325,38 @@ static int rgb_to_yuv(int n, int red, int green, int blue)
  * Column is for FG:	RGB2YUV YUV2RGB RGB2RGB YUV2YUV CSC_NONE
  */
 static struct dp_csc_param_t dp_csc_array[CSC_NUM][CSC_NUM] = {
-	{
-		{DP_COM_CONF_CSC_DEF_BOTH, &rgb2ycbcr_coeff},
-		{0, 0},
-		{0, 0},
-		{DP_COM_CONF_CSC_DEF_BG, &rgb2ycbcr_coeff},
-		{DP_COM_CONF_CSC_DEF_BG, &rgb2ycbcr_coeff}
-	},
-	{
-		{0, 0},
-		{DP_COM_CONF_CSC_DEF_BOTH, &ycbcr2rgb_coeff},
-		{DP_COM_CONF_CSC_DEF_BG, &ycbcr2rgb_coeff},
-		{0, 0},
-		{DP_COM_CONF_CSC_DEF_BG, &ycbcr2rgb_coeff}
-	},
-	{
-		{0, 0},
-		{DP_COM_CONF_CSC_DEF_FG, &ycbcr2rgb_coeff},
-		{0, 0},
-		{0, 0},
-		{0, 0}
-	},
-	{
-		{DP_COM_CONF_CSC_DEF_FG, &rgb2ycbcr_coeff},
-		{0, 0},
-		{0, 0},
-		{0, 0},
-		{0, 0}
-	},
-	{
-		{DP_COM_CONF_CSC_DEF_FG, &rgb2ycbcr_coeff},
-		{DP_COM_CONF_CSC_DEF_FG, &ycbcr2rgb_coeff},
-		{0, 0},
-		{0, 0},
-		{0, 0}
-	}
+	{ { DP_COM_CONF_CSC_DEF_BOTH, &rgb2ycbcr_coeff },
+	  { 0, 0 },
+	  { 0, 0 },
+	  { DP_COM_CONF_CSC_DEF_BG, &rgb2ycbcr_coeff },
+	  { DP_COM_CONF_CSC_DEF_BG, &rgb2ycbcr_coeff } },
+	{ { 0, 0 },
+	  { DP_COM_CONF_CSC_DEF_BOTH, &ycbcr2rgb_coeff },
+	  { DP_COM_CONF_CSC_DEF_BG, &ycbcr2rgb_coeff },
+	  { 0, 0 },
+	  { DP_COM_CONF_CSC_DEF_BG, &ycbcr2rgb_coeff } },
+	{ { 0, 0 },
+	  { DP_COM_CONF_CSC_DEF_FG, &ycbcr2rgb_coeff },
+	  { 0, 0 },
+	  { 0, 0 },
+	  { 0, 0 } },
+	{ { DP_COM_CONF_CSC_DEF_FG, &rgb2ycbcr_coeff },
+	  { 0, 0 },
+	  { 0, 0 },
+	  { 0, 0 },
+	  { 0, 0 } },
+	{ { DP_COM_CONF_CSC_DEF_FG, &rgb2ycbcr_coeff },
+	  { DP_COM_CONF_CSC_DEF_FG, &ycbcr2rgb_coeff },
+	  { 0, 0 },
+	  { 0, 0 },
+	  { 0, 0 } }
 };
 
 static enum csc_type_t fg_csc_type = CSC_NONE, bg_csc_type = CSC_NONE;
 static int color_key_4rgb = 1;
 
 static void ipu_dp_csc_setup(int dp, struct dp_csc_param_t dp_csc_param,
-			unsigned char srm_mode_update)
+			     unsigned char srm_mode_update)
 {
 	u32 reg;
 	const int (*coeff)[5][3];
@@ -394,19 +372,25 @@ static void ipu_dp_csc_setup(int dp, struct dp_csc_param_t dp_csc_param,
 
 	if (coeff) {
 		__raw_writel(mask_a((*coeff)[0][0]) |
-				(mask_a((*coeff)[0][1]) << 16), DP_CSC_A_0());
+				     (mask_a((*coeff)[0][1]) << 16),
+			     DP_CSC_A_0());
 		__raw_writel(mask_a((*coeff)[0][2]) |
-				(mask_a((*coeff)[1][0]) << 16), DP_CSC_A_1());
+				     (mask_a((*coeff)[1][0]) << 16),
+			     DP_CSC_A_1());
 		__raw_writel(mask_a((*coeff)[1][1]) |
-				(mask_a((*coeff)[1][2]) << 16), DP_CSC_A_2());
+				     (mask_a((*coeff)[1][2]) << 16),
+			     DP_CSC_A_2());
 		__raw_writel(mask_a((*coeff)[2][0]) |
-				(mask_a((*coeff)[2][1]) << 16), DP_CSC_A_3());
+				     (mask_a((*coeff)[2][1]) << 16),
+			     DP_CSC_A_3());
 		__raw_writel(mask_a((*coeff)[2][2]) |
-				(mask_b((*coeff)[3][0]) << 16) |
-				((*coeff)[4][0] << 30), DP_CSC_0());
+				     (mask_b((*coeff)[3][0]) << 16) |
+				     ((*coeff)[4][0] << 30),
+			     DP_CSC_0());
 		__raw_writel(mask_b((*coeff)[3][1]) | ((*coeff)[4][1] << 14) |
-				(mask_b((*coeff)[3][2]) << 16) |
-				((*coeff)[4][2] << 30), DP_CSC_1());
+				     (mask_b((*coeff)[3][2]) << 16) |
+				     ((*coeff)[4][2] << 30),
+			     DP_CSC_1());
 	}
 
 	if (srm_mode_update) {
@@ -416,7 +400,7 @@ static void ipu_dp_csc_setup(int dp, struct dp_csc_param_t dp_csc_param,
 }
 
 int ipu_dp_init(ipu_channel_t channel, uint32_t in_pixel_fmt,
-		 uint32_t out_pixel_fmt)
+		uint32_t out_pixel_fmt)
 {
 	int in_fmt, out_fmt;
 	int dp;
@@ -440,45 +424,41 @@ int ipu_dp_init(ipu_channel_t channel, uint32_t in_pixel_fmt,
 	out_fmt = format_to_colorspace(out_pixel_fmt);
 
 	if (partial) {
-		if (in_fmt == RGB) {
+		if (in_fmt == RGB)
 			if (out_fmt == RGB)
 				fg_csc_type = RGB2RGB;
 			else
 				fg_csc_type = RGB2YUV;
-		} else {
-			if (out_fmt == RGB)
-				fg_csc_type = YUV2RGB;
-			else
-				fg_csc_type = YUV2YUV;
-		}
+		else if (out_fmt == RGB)
+			fg_csc_type = YUV2RGB;
+		else
+			fg_csc_type = YUV2YUV;
 	} else {
-		if (in_fmt == RGB) {
+		if (in_fmt == RGB)
 			if (out_fmt == RGB)
 				bg_csc_type = RGB2RGB;
 			else
 				bg_csc_type = RGB2YUV;
-		} else {
-			if (out_fmt == RGB)
-				bg_csc_type = YUV2RGB;
-			else
-				bg_csc_type = YUV2YUV;
-		}
+		else if (out_fmt == RGB)
+			bg_csc_type = YUV2RGB;
+		else
+			bg_csc_type = YUV2YUV;
 	}
 
 	/* Transform color key from rgb to yuv if CSC is enabled */
 	reg = __raw_readl(DP_COM_CONF());
 	if (color_key_4rgb && (reg & DP_COM_CONF_GWCKE) &&
-		(((fg_csc_type == RGB2YUV) && (bg_csc_type == YUV2YUV)) ||
-		((fg_csc_type == YUV2YUV) && (bg_csc_type == RGB2YUV)) ||
-		((fg_csc_type == YUV2YUV) && (bg_csc_type == YUV2YUV)) ||
-		((fg_csc_type == YUV2RGB) && (bg_csc_type == YUV2RGB)))) {
+	    (((fg_csc_type == RGB2YUV) && (bg_csc_type == YUV2YUV)) ||
+	     ((fg_csc_type == YUV2YUV) && (bg_csc_type == RGB2YUV)) ||
+	     ((fg_csc_type == YUV2YUV) && (bg_csc_type == YUV2YUV)) ||
+	     ((fg_csc_type == YUV2RGB) && (bg_csc_type == YUV2RGB)))) {
 		int red, green, blue;
 		int y, u, v;
 		uint32_t color_key = __raw_readl(DP_GRAPH_WIND_CTRL()) &
-			0xFFFFFFL;
+				     0xFFFFFFL;
 
 		debug("_ipu_dp_init color key 0x%x need change to yuv fmt!\n",
-			color_key);
+		      color_key);
 
 		red = (color_key >> 16) & 0xFF;
 		green = (color_key >> 8) & 0xFF;
@@ -494,7 +474,7 @@ int ipu_dp_init(ipu_channel_t channel, uint32_t in_pixel_fmt,
 		color_key_4rgb = 0;
 
 		debug("_ipu_dp_init color key change to yuv fmt 0x%x!\n",
-			color_key);
+		      color_key);
 	}
 
 	ipu_dp_csc_setup(dp, dp_csc_array[bg_csc_type][fg_csc_type], 1);
@@ -537,18 +517,14 @@ void ipu_dc_init(int dc_chan, int di, unsigned char interlaced)
 			ipu_dc_link_event(dc_chan, DC_EVT_NL, 0, 3);
 			ipu_dc_link_event(dc_chan, DC_EVT_EOL, 0, 2);
 			ipu_dc_link_event(dc_chan, DC_EVT_NEW_DATA, 0, 1);
+		} else if (di) {
+			ipu_dc_link_event(dc_chan, DC_EVT_NL, 2, 3);
+			ipu_dc_link_event(dc_chan, DC_EVT_EOL, 3, 2);
+			ipu_dc_link_event(dc_chan, DC_EVT_NEW_DATA, 4, 1);
 		} else {
-			if (di) {
-				ipu_dc_link_event(dc_chan, DC_EVT_NL, 2, 3);
-				ipu_dc_link_event(dc_chan, DC_EVT_EOL, 3, 2);
-				ipu_dc_link_event(dc_chan, DC_EVT_NEW_DATA,
-					4, 1);
-			} else {
-				ipu_dc_link_event(dc_chan, DC_EVT_NL, 5, 3);
-				ipu_dc_link_event(dc_chan, DC_EVT_EOL, 6, 2);
-				ipu_dc_link_event(dc_chan, DC_EVT_NEW_DATA,
-					7, 1);
-			}
+			ipu_dc_link_event(dc_chan, DC_EVT_NL, 5, 3);
+			ipu_dc_link_event(dc_chan, DC_EVT_EOL, 6, 2);
+			ipu_dc_link_event(dc_chan, DC_EVT_NEW_DATA, 7, 1);
 		}
 		ipu_dc_link_event(dc_chan, DC_EVT_NF, 0, 0);
 		ipu_dc_link_event(dc_chan, DC_EVT_NFIELD, 0, 0);
@@ -685,16 +661,16 @@ void ipu_dp_dc_disable(ipu_channel_t channel, unsigned char swap)
 		 * this check is useful for tv overlay.
 		 */
 		if (g_dc_di_assignment[dc_chan] == 0)
-			while ((__raw_readl(DC_STAT) & 0x00000002)
-			       != 0x00000002) {
+			while ((__raw_readl(DC_STAT) & 0x00000002) !=
+			       0x00000002) {
 				udelay(2000);
 				timeout -= 2;
 				if (timeout <= 0)
 					break;
 			}
 		else if (g_dc_di_assignment[dc_chan] == 1)
-			while ((__raw_readl(DC_STAT) & 0x00000020)
-			       != 0x00000020) {
+			while ((__raw_readl(DC_STAT) & 0x00000020) !=
+			       0x00000020) {
 				udelay(2000);
 				timeout -= 2;
 				if (timeout <= 0)
@@ -791,43 +767,42 @@ static int ipu_pixfmt_to_map(uint32_t fmt)
 /*
  * This function is called to initialize a synchronous LCD panel.
  *
- * @param       disp            The DI the panel is attached to.
+ * @param	disp		The DI the panel is attached to.
  *
- * @param       pixel_clk       Desired pixel clock frequency in Hz.
+ * @param	pixel_clk	Desired pixel clock frequency in Hz.
  *
- * @param       pixel_fmt       Input parameter for pixel format of buffer.
- *                              Pixel format is a FOURCC ASCII code.
+ * @param	pixel_fmt	Input parameter for pixel format of buffer.
+ *				Pixel format is a FOURCC ASCII code.
  *
- * @param       width           The width of panel in pixels.
+ * @param	width		The width of panel in pixels.
  *
- * @param       height          The height of panel in pixels.
+ * @param	height		The height of panel in pixels.
  *
- * @param       hStartWidth     The number of pixel clocks between the HSYNC
- *                              signal pulse and the start of valid data.
+ * @param	hStartWidth	The number of pixel clocks between the HSYNC
+ *				signal pulse and the start of valid data.
  *
- * @param       hSyncWidth      The width of the HSYNC signal in units of pixel
- *                              clocks.
+ * @param	hSyncWidth	The width of the HSYNC signal in units of pixel
+ *				clocks.
  *
- * @param       hEndWidth       The number of pixel clocks between the end of
- *                              valid data and the HSYNC signal for next line.
+ * @param	hEndWidth	The number of pixel clocks between the end of
+ *				valid data and the HSYNC signal for next line.
  *
- * @param       vStartWidth     The number of lines between the VSYNC
- *                              signal pulse and the start of valid data.
+ * @param	vStartWidth	The number of lines between the VSYNC
+ *				signal pulse and the start of valid data.
  *
- * @param       vSyncWidth      The width of the VSYNC signal in units of lines
+ * @param	vSyncWidth	The width of the VSYNC signal in units of lines
  *
- * @param       vEndWidth       The number of lines between the end of valid
- *                              data and the VSYNC signal for next frame.
+ * @param	vEndWidth	The number of lines between the end of valid
+ *				data and the VSYNC signal for next frame.
  *
- * @param       sig             Bitfield of signal polarities for LCD interface.
+ * @param	sig		Bitfield of signal polarities for LCD interface.
  *
- * Return:      This function returns 0 on success or negative error code on
- *              fail.
+ * Return:	This function returns 0 on success or negative error code on
+ *		fail.
  */
 
-int32_t ipu_init_sync_panel(int disp, uint32_t pixel_clk,
-			    uint16_t width, uint16_t height,
-			    uint32_t pixel_fmt,
+int32_t ipu_init_sync_panel(int disp, uint32_t pixel_clk, uint16_t width,
+			    uint16_t height, uint32_t pixel_fmt,
 			    uint16_t h_start_width, uint16_t h_sync_width,
 			    uint16_t h_end_width, uint16_t v_start_width,
 			    uint16_t v_sync_width, uint16_t v_end_width,
@@ -864,22 +839,21 @@ int32_t ipu_init_sync_panel(int disp, uint32_t pixel_clk,
 			 * of the pixel clock.
 			 */
 			if ((clk_get_usecount(g_pixel_clk[0]) == 0) &&
-				(clk_get_usecount(g_pixel_clk[1]) == 0)) {
+			    (clk_get_usecount(g_pixel_clk[1]) == 0)) {
 				di_parent = clk_get_parent(g_di_clk[disp]);
-				rounded_pixel_clk =
-					clk_round_rate(g_pixel_clk[disp],
-						pixel_clk);
-				div  = clk_get_rate(di_parent) /
-					rounded_pixel_clk;
+				rounded_pixel_clk = clk_round_rate(
+					g_pixel_clk[disp], pixel_clk);
+				div = clk_get_rate(di_parent) /
+				      rounded_pixel_clk;
 				if (div % 2)
 					div++;
-				if (clk_get_rate(di_parent) != div *
-					rounded_pixel_clk)
+				if (clk_get_rate(di_parent) !=
+				    div * rounded_pixel_clk)
 					clk_set_rate(di_parent,
-						div * rounded_pixel_clk);
+						     div * rounded_pixel_clk);
 				udelay(10000);
 				clk_set_rate(g_di_clk[disp],
-					2 * rounded_pixel_clk);
+					     2 * rounded_pixel_clk);
 				udelay(10000);
 			}
 		}
@@ -893,7 +867,7 @@ int32_t ipu_init_sync_panel(int disp, uint32_t pixel_clk,
 	udelay(5000);
 	/* Get integer portion of divider */
 	div = clk_get_rate(clk_get_parent(g_pixel_clk[disp])) /
-		rounded_pixel_clk;
+	      rounded_pixel_clk;
 
 	ipu_di_data_wave_config(disp, SYNC_WAVE, div - 1, div - 1);
 	ipu_di_data_pin_config(disp, SYNC_WAVE, DI_PIN15, 3, 0, div * 2);
@@ -908,162 +882,153 @@ int32_t ipu_init_sync_panel(int disp, uint32_t pixel_clk,
 
 	if (sig.interlaced) {
 		/* Setup internal HSYNC waveform */
-		ipu_di_sync_config(
-				disp,		/* display */
-				1,		/* counter */
-				h_total / 2 - 1,/* run count */
-				DI_SYNC_CLK,	/* run_resolution */
-				0,		/* offset */
-				DI_SYNC_NONE,	/* offset resolution */
-				0,		/* repeat count */
-				DI_SYNC_NONE,	/* CNT_CLR_SEL */
-				0,		/* CNT_POLARITY_GEN_EN */
-				DI_SYNC_NONE,	/* CNT_POLARITY_CLR_SEL */
-				DI_SYNC_NONE,	/* CNT_POLARITY_TRIGGER_SEL */
-				0,		/* COUNT UP */
-				0		/* COUNT DOWN */
-				);
+		ipu_di_sync_config(disp, /* display */
+				   1, /* counter */
+				   h_total / 2 - 1, /* run count */
+				   DI_SYNC_CLK, /* run_resolution */
+				   0, /* offset */
+				   DI_SYNC_NONE, /* offset resolution */
+				   0, /* repeat count */
+				   DI_SYNC_NONE, /* CNT_CLR_SEL */
+				   0, /* CNT_POLARITY_GEN_EN */
+				   DI_SYNC_NONE, /* CNT_POLARITY_CLR_SEL */
+				   DI_SYNC_NONE, /* CNT_POLARITY_TRIGGER_SEL */
+				   0, /* COUNT UP */
+				   0 /* COUNT DOWN */
+		);
 
 		/* Field 1 VSYNC waveform */
-		ipu_di_sync_config(
-				disp,		/* display */
-				2,		/* counter */
-				h_total - 1,	/* run count */
-				DI_SYNC_CLK,	/* run_resolution */
-				0,		/* offset */
-				DI_SYNC_NONE,	/* offset resolution */
-				0,		/* repeat count */
-				DI_SYNC_NONE,	/* CNT_CLR_SEL */
-				0,		/* CNT_POLARITY_GEN_EN */
-				DI_SYNC_NONE,	/* CNT_POLARITY_CLR_SEL */
-				DI_SYNC_NONE,	/* CNT_POLARITY_TRIGGER_SEL */
-				0,		/* COUNT UP */
-				4		/* COUNT DOWN */
-				);
+		ipu_di_sync_config(disp, /* display */
+				   2, /* counter */
+				   h_total - 1, /* run count */
+				   DI_SYNC_CLK, /* run_resolution */
+				   0, /* offset */
+				   DI_SYNC_NONE, /* offset resolution */
+				   0, /* repeat count */
+				   DI_SYNC_NONE, /* CNT_CLR_SEL */
+				   0, /* CNT_POLARITY_GEN_EN */
+				   DI_SYNC_NONE, /* CNT_POLARITY_CLR_SEL */
+				   DI_SYNC_NONE, /* CNT_POLARITY_TRIGGER_SEL */
+				   0, /* COUNT UP */
+				   4 /* COUNT DOWN */
+		);
 
 		/* Setup internal HSYNC waveform */
-		ipu_di_sync_config(
-				disp,		/* display */
-				3,		/* counter */
-				v_total * 2 - 1,/* run count */
-				DI_SYNC_INT_HSYNC,	/* run_resolution */
-				1,		/* offset */
-				DI_SYNC_INT_HSYNC,	/* offset resolution */
-				0,		/* repeat count */
-				DI_SYNC_NONE,	/* CNT_CLR_SEL */
-				0,		/* CNT_POLARITY_GEN_EN */
-				DI_SYNC_NONE,	/* CNT_POLARITY_CLR_SEL */
-				DI_SYNC_NONE,	/* CNT_POLARITY_TRIGGER_SEL */
-				0,		/* COUNT UP */
-				4		/* COUNT DOWN */
-				);
+		ipu_di_sync_config(disp, /* display */
+				   3, /* counter */
+				   v_total * 2 - 1, /* run count */
+				   DI_SYNC_INT_HSYNC, /* run_resolution */
+				   1, /* offset */
+				   DI_SYNC_INT_HSYNC, /* offset resolution */
+				   0, /* repeat count */
+				   DI_SYNC_NONE, /* CNT_CLR_SEL */
+				   0, /* CNT_POLARITY_GEN_EN */
+				   DI_SYNC_NONE, /* CNT_POLARITY_CLR_SEL */
+				   DI_SYNC_NONE, /* CNT_POLARITY_TRIGGER_SEL */
+				   0, /* COUNT UP */
+				   4 /* COUNT DOWN */
+		);
 
 		/* Active Field ? */
-		ipu_di_sync_config(
-				disp,		/* display */
-				4,		/* counter */
-				v_total / 2 - 1,/* run count */
-				DI_SYNC_HSYNC,	/* run_resolution */
-				v_start_width,	/*  offset */
-				DI_SYNC_HSYNC,	/* offset resolution */
-				2,		/* repeat count */
-				DI_SYNC_VSYNC,	/* CNT_CLR_SEL */
-				0,		/* CNT_POLARITY_GEN_EN */
-				DI_SYNC_NONE,	/* CNT_POLARITY_CLR_SEL */
-				DI_SYNC_NONE,	/* CNT_POLARITY_TRIGGER_SEL */
-				0,		/* COUNT UP */
-				0		/* COUNT DOWN */
-				);
+		ipu_di_sync_config(disp, /* display */
+				   4, /* counter */
+				   v_total / 2 - 1, /* run count */
+				   DI_SYNC_HSYNC, /* run_resolution */
+				   v_start_width, /*  offset */
+				   DI_SYNC_HSYNC, /* offset resolution */
+				   2, /* repeat count */
+				   DI_SYNC_VSYNC, /* CNT_CLR_SEL */
+				   0, /* CNT_POLARITY_GEN_EN */
+				   DI_SYNC_NONE, /* CNT_POLARITY_CLR_SEL */
+				   DI_SYNC_NONE, /* CNT_POLARITY_TRIGGER_SEL */
+				   0, /* COUNT UP */
+				   0 /* COUNT DOWN */
+		);
 
 		/* Active Line */
-		ipu_di_sync_config(
-				disp,		/* display */
-				5,		/* counter */
-				0,		/* run count */
-				DI_SYNC_HSYNC,	/* run_resolution */
-				0,		/*  offset */
-				DI_SYNC_NONE,	/* offset resolution */
-				height / 2,	/* repeat count */
-				4,		/* CNT_CLR_SEL */
-				0,		/* CNT_POLARITY_GEN_EN */
-				DI_SYNC_NONE,	/* CNT_POLARITY_CLR_SEL */
-				DI_SYNC_NONE,	/* CNT_POLARITY_TRIGGER_SEL */
-				0,		/* COUNT UP */
-				0		/* COUNT DOWN */
-				);
+		ipu_di_sync_config(disp, /* display */
+				   5, /* counter */
+				   0, /* run count */
+				   DI_SYNC_HSYNC, /* run_resolution */
+				   0, /*  offset */
+				   DI_SYNC_NONE, /* offset resolution */
+				   height / 2, /* repeat count */
+				   4, /* CNT_CLR_SEL */
+				   0, /* CNT_POLARITY_GEN_EN */
+				   DI_SYNC_NONE, /* CNT_POLARITY_CLR_SEL */
+				   DI_SYNC_NONE, /* CNT_POLARITY_TRIGGER_SEL */
+				   0, /* COUNT UP */
+				   0 /* COUNT DOWN */
+		);
 
 		/* Field 0 VSYNC waveform */
-		ipu_di_sync_config(
-				disp,		/* display */
-				6,		/* counter */
-				v_total - 1,	/* run count */
-				DI_SYNC_HSYNC,	/* run_resolution */
-				0,		/* offset */
-				DI_SYNC_NONE,	/* offset resolution */
-				0,		/* repeat count */
-				DI_SYNC_NONE,	/* CNT_CLR_SEL  */
-				0,		/* CNT_POLARITY_GEN_EN */
-				DI_SYNC_NONE,	/* CNT_POLARITY_CLR_SEL */
-				DI_SYNC_NONE,	/* CNT_POLARITY_TRIGGER_SEL */
-				0,		/* COUNT UP */
-				0		/* COUNT DOWN */
-				);
+		ipu_di_sync_config(disp, /* display */
+				   6, /* counter */
+				   v_total - 1, /* run count */
+				   DI_SYNC_HSYNC, /* run_resolution */
+				   0, /* offset */
+				   DI_SYNC_NONE, /* offset resolution */
+				   0, /* repeat count */
+				   DI_SYNC_NONE, /* CNT_CLR_SEL  */
+				   0, /* CNT_POLARITY_GEN_EN */
+				   DI_SYNC_NONE, /* CNT_POLARITY_CLR_SEL */
+				   DI_SYNC_NONE, /* CNT_POLARITY_TRIGGER_SEL */
+				   0, /* COUNT UP */
+				   0 /* COUNT DOWN */
+		);
 
 		/* DC VSYNC waveform */
 		vsync_cnt = 7;
-		ipu_di_sync_config(
-				disp,		/* display */
-				7,		/* counter */
-				v_total / 2 - 1,/* run count */
-				DI_SYNC_HSYNC,	/* run_resolution  */
-				9,		/* offset  */
-				DI_SYNC_HSYNC,	/* offset resolution */
-				2,		/* repeat count */
-				DI_SYNC_VSYNC,	/* CNT_CLR_SEL */
-				0,		/* CNT_POLARITY_GEN_EN */
-				DI_SYNC_NONE,	/* CNT_POLARITY_CLR_SEL */
-				DI_SYNC_NONE,	/* CNT_POLARITY_TRIGGER_SEL */
-				0,		/* COUNT UP */
-				0		/* COUNT DOWN */
-				);
+		ipu_di_sync_config(disp, /* display */
+				   7, /* counter */
+				   v_total / 2 - 1, /* run count */
+				   DI_SYNC_HSYNC, /* run_resolution  */
+				   9, /* offset  */
+				   DI_SYNC_HSYNC, /* offset resolution */
+				   2, /* repeat count */
+				   DI_SYNC_VSYNC, /* CNT_CLR_SEL */
+				   0, /* CNT_POLARITY_GEN_EN */
+				   DI_SYNC_NONE, /* CNT_POLARITY_CLR_SEL */
+				   DI_SYNC_NONE, /* CNT_POLARITY_TRIGGER_SEL */
+				   0, /* COUNT UP */
+				   0 /* COUNT DOWN */
+		);
 
 		/* active pixel waveform */
-		ipu_di_sync_config(
-				disp,		/* display */
-				8,		/* counter */
-				0,		/* run count  */
-				DI_SYNC_CLK,	/* run_resolution */
-				h_start_width,	/* offset  */
-				DI_SYNC_CLK,	/* offset resolution */
-				width,		/* repeat count  */
-				5,		/* CNT_CLR_SEL  */
-				0,		/* CNT_POLARITY_GEN_EN  */
-				DI_SYNC_NONE,	/* CNT_POLARITY_CLR_SEL */
-				DI_SYNC_NONE,	/* CNT_POLARITY_TRIGGER_SEL  */
-				0,		/* COUNT UP  */
-				0		/* COUNT DOWN */
-				);
-
-		ipu_di_sync_config(
-				disp,		/* display */
-				9,		/* counter */
-				v_total - 1,	/* run count */
-				DI_SYNC_INT_HSYNC,/* run_resolution */
-				v_total / 2,	/* offset  */
-				DI_SYNC_INT_HSYNC,/* offset resolution  */
-				0,		/* repeat count */
-				DI_SYNC_HSYNC,	/* CNT_CLR_SEL */
-				0,		/* CNT_POLARITY_GEN_EN  */
-				DI_SYNC_NONE,	/* CNT_POLARITY_CLR_SEL  */
-				DI_SYNC_NONE,	/* CNT_POLARITY_TRIGGER_SEL */
-				0,		/* COUNT UP */
-				4		/* COUNT DOWN */
-				);
+		ipu_di_sync_config(disp, /* display */
+				   8, /* counter */
+				   0, /* run count  */
+				   DI_SYNC_CLK, /* run_resolution */
+				   h_start_width, /* offset  */
+				   DI_SYNC_CLK, /* offset resolution */
+				   width, /* repeat count  */
+				   5, /* CNT_CLR_SEL  */
+				   0, /* CNT_POLARITY_GEN_EN  */
+				   DI_SYNC_NONE, /* CNT_POLARITY_CLR_SEL */
+				   DI_SYNC_NONE, /* CNT_POLARITY_TRIGGER_SEL  */
+				   0, /* COUNT UP  */
+				   0 /* COUNT DOWN */
+		);
+
+		ipu_di_sync_config(disp, /* display */
+				   9, /* counter */
+				   v_total - 1, /* run count */
+				   DI_SYNC_INT_HSYNC, /* run_resolution */
+				   v_total / 2, /* offset  */
+				   DI_SYNC_INT_HSYNC, /* offset resolution  */
+				   0, /* repeat count */
+				   DI_SYNC_HSYNC, /* CNT_CLR_SEL */
+				   0, /* CNT_POLARITY_GEN_EN  */
+				   DI_SYNC_NONE, /* CNT_POLARITY_CLR_SEL  */
+				   DI_SYNC_NONE, /* CNT_POLARITY_TRIGGER_SEL */
+				   0, /* COUNT UP */
+				   4 /* COUNT DOWN */
+		);
 
 		/* set gentime select and tag sel */
 		reg = __raw_readl(DI_SW_GEN1(disp, 9));
 		reg &= 0x1FFFFFFF;
-		reg |= (3 - 1)<<29 | 0x00008000;
+		reg |= (3 - 1) << 29 | 0x00008000;
 		__raw_writel(reg, DI_SW_GEN1(disp, 9));
 
 		__raw_writel(v_total / 2 - 1, DI_SCR_CONF(disp));
@@ -1074,34 +1039,32 @@ int32_t ipu_init_sync_panel(int disp, uint32_t pixel_clk,
 		di_gen |= DI_GEN_POLARITY_8;
 	} else {
 		/* Setup internal HSYNC waveform */
-		ipu_di_sync_config(disp, 1, h_total - 1, DI_SYNC_CLK,
-				0, DI_SYNC_NONE, 0, DI_SYNC_NONE,
-				0, DI_SYNC_NONE,
-				DI_SYNC_NONE, 0, 0);
+		ipu_di_sync_config(disp, 1, h_total - 1, DI_SYNC_CLK, 0,
+				   DI_SYNC_NONE, 0, DI_SYNC_NONE, 0,
+				   DI_SYNC_NONE, DI_SYNC_NONE, 0, 0);
 
 		/* Setup external (delayed) HSYNC waveform */
 		ipu_di_sync_config(disp, DI_SYNC_HSYNC, h_total - 1,
-				DI_SYNC_CLK, div * v_to_h_sync, DI_SYNC_CLK,
-				0, DI_SYNC_NONE, 1, DI_SYNC_NONE,
-				DI_SYNC_CLK, 0, h_sync_width * 2);
+				   DI_SYNC_CLK, div * v_to_h_sync, DI_SYNC_CLK,
+				   0, DI_SYNC_NONE, 1, DI_SYNC_NONE,
+				   DI_SYNC_CLK, 0, h_sync_width * 2);
 		/* Setup VSYNC waveform */
 		vsync_cnt = DI_SYNC_VSYNC;
 		ipu_di_sync_config(disp, DI_SYNC_VSYNC, v_total - 1,
-				DI_SYNC_INT_HSYNC, 0, DI_SYNC_NONE, 0,
-				DI_SYNC_NONE, 1, DI_SYNC_NONE,
-				DI_SYNC_INT_HSYNC, 0, v_sync_width * 2);
+				   DI_SYNC_INT_HSYNC, 0, DI_SYNC_NONE, 0,
+				   DI_SYNC_NONE, 1, DI_SYNC_NONE,
+				   DI_SYNC_INT_HSYNC, 0, v_sync_width * 2);
 		__raw_writel(v_total - 1, DI_SCR_CONF(disp));
 
 		/* Setup active data waveform to sync with DC */
 		ipu_di_sync_config(disp, 4, 0, DI_SYNC_HSYNC,
-				v_sync_width + v_start_width, DI_SYNC_HSYNC,
-				height,
-				DI_SYNC_VSYNC, 0, DI_SYNC_NONE,
-				DI_SYNC_NONE, 0, 0);
+				   v_sync_width + v_start_width, DI_SYNC_HSYNC,
+				   height, DI_SYNC_VSYNC, 0, DI_SYNC_NONE,
+				   DI_SYNC_NONE, 0, 0);
 		ipu_di_sync_config(disp, 5, 0, DI_SYNC_CLK,
-				h_sync_width + h_start_width, DI_SYNC_CLK,
-				width, 4, 0, DI_SYNC_NONE, DI_SYNC_NONE, 0,
-				0);
+				   h_sync_width + h_start_width, DI_SYNC_CLK,
+				   width, 4, 0, DI_SYNC_NONE, DI_SYNC_NONE, 0,
+				   0);
 
 		/* reset all unused counters */
 		__raw_writel(0, DI_SW_GEN0(disp, 6));
@@ -1121,13 +1084,13 @@ int32_t ipu_init_sync_panel(int disp, uint32_t pixel_clk,
 
 		/* Init template microcode */
 		if (disp) {
-		   ipu_dc_write_tmpl(2, WROD(0), 0, map, SYNC_WAVE, 8, 5);
-		   ipu_dc_write_tmpl(3, WROD(0), 0, map, SYNC_WAVE, 4, 5);
-		   ipu_dc_write_tmpl(4, WROD(0), 0, map, SYNC_WAVE, 0, 5);
+			ipu_dc_write_tmpl(2, WROD(0), 0, map, SYNC_WAVE, 8, 5);
+			ipu_dc_write_tmpl(3, WROD(0), 0, map, SYNC_WAVE, 4, 5);
+			ipu_dc_write_tmpl(4, WROD(0), 0, map, SYNC_WAVE, 0, 5);
 		} else {
-		   ipu_dc_write_tmpl(5, WROD(0), 0, map, SYNC_WAVE, 8, 5);
-		   ipu_dc_write_tmpl(6, WROD(0), 0, map, SYNC_WAVE, 4, 5);
-		   ipu_dc_write_tmpl(7, WROD(0), 0, map, SYNC_WAVE, 0, 5);
+			ipu_dc_write_tmpl(5, WROD(0), 0, map, SYNC_WAVE, 8, 5);
+			ipu_dc_write_tmpl(6, WROD(0), 0, map, SYNC_WAVE, 4, 5);
+			ipu_dc_write_tmpl(7, WROD(0), 0, map, SYNC_WAVE, 0, 5);
 		}
 
 		if (sig.Hsync_pol)
@@ -1137,13 +1100,12 @@ int32_t ipu_init_sync_panel(int disp, uint32_t pixel_clk,
 
 		if (!sig.clk_pol)
 			di_gen |= DI_GEN_POL_CLK;
-
 	}
 
 	__raw_writel(di_gen, DI_GENERAL(disp));
 
-	__raw_writel((--vsync_cnt << DI_VSYNC_SEL_OFFSET) |
-			0x00000002, DI_SYNC_AS_GEN(disp));
+	__raw_writel((--vsync_cnt << DI_VSYNC_SEL_OFFSET) | 0x00000002,
+		     DI_SYNC_AS_GEN(disp));
 
 	reg = __raw_readl(DI_POL(disp));
 	reg &= ~(DI_POL_DRDY_DATA_POLARITY | DI_POL_DRDY_POLARITY_15);
@@ -1165,12 +1127,12 @@ int32_t ipu_init_sync_panel(int disp, uint32_t pixel_clk,
  *
  * @param	channel		IPUv3 DP channel
  *
- * @param       enable          Boolean to enable or disable global alpha
- *                              blending. If disabled, local blending is used.
+ * @param	enable		Boolean to enable or disable global alpha
+ *				blending. If disabled, local blending is used.
  *
- * @param       alpha           Global alpha value.
+ * @param	alpha		Global alpha value.
  *
- * Return:      Returns 0 on success or negative error code on fail
+ * Return:	Returns 0 on success or negative error code on fail
  */
 int32_t ipu_disp_set_global_alpha(ipu_channel_t channel, unsigned char enable,
 				  uint8_t alpha)
@@ -1180,8 +1142,8 @@ int32_t ipu_disp_set_global_alpha(ipu_channel_t channel, unsigned char enable,
 	unsigned char bg_chan;
 
 	if (!((channel == MEM_BG_SYNC || channel == MEM_FG_SYNC) ||
-		(channel == MEM_BG_ASYNC0 || channel == MEM_FG_ASYNC0) ||
-		(channel == MEM_BG_ASYNC1 || channel == MEM_FG_ASYNC1)))
+	      (channel == MEM_BG_ASYNC0 || channel == MEM_FG_ASYNC0) ||
+	      (channel == MEM_BG_ASYNC1 || channel == MEM_FG_ASYNC1)))
 		return -EINVAL;
 
 	if (channel == MEM_BG_SYNC || channel == MEM_BG_ASYNC0 ||
@@ -1200,7 +1162,7 @@ int32_t ipu_disp_set_global_alpha(ipu_channel_t channel, unsigned char enable,
 
 	if (enable) {
 		reg = __raw_readl(DP_GRAPH_WIND_CTRL()) & 0x00FFFFFFL;
-		__raw_writel(reg | ((uint32_t) alpha << 24),
+		__raw_writel(reg | ((uint32_t)alpha << 24),
 			     DP_GRAPH_WIND_CTRL());
 
 		reg = __raw_readl(DP_COM_CONF());
@@ -1219,13 +1181,13 @@ int32_t ipu_disp_set_global_alpha(ipu_channel_t channel, unsigned char enable,
 /*
  * This function sets the transparent color key for SDC graphic plane.
  *
- * @param       channel         Input parameter for the logical channel ID.
+ * @param	channel		Input parameter for the logical channel ID.
  *
- * @param       enable          Boolean to enable or disable color key
+ * @param	enable		Boolean to enable or disable color key
  *
- * @param       colorKey        24-bit RGB color for transparent color key.
+ * @param	colorKey	24-bit RGB color for transparent color key.
  *
- * Return:      Returns 0 on success or negative error code on fail
+ * Return:	Returns 0 on success or negative error code on fail
  */
 int32_t ipu_disp_set_color_key(ipu_channel_t channel, unsigned char enable,
 			       uint32_t color_key)
@@ -1235,17 +1197,16 @@ int32_t ipu_disp_set_color_key(ipu_channel_t channel, unsigned char enable,
 	int red, green, blue;
 
 	if (!((channel == MEM_BG_SYNC || channel == MEM_FG_SYNC) ||
-		(channel == MEM_BG_ASYNC0 || channel == MEM_FG_ASYNC0) ||
-		(channel == MEM_BG_ASYNC1 || channel == MEM_FG_ASYNC1)))
+	      (channel == MEM_BG_ASYNC0 || channel == MEM_FG_ASYNC0) ||
+	      (channel == MEM_BG_ASYNC1 || channel == MEM_FG_ASYNC1)))
 		return -EINVAL;
 
 	color_key_4rgb = 1;
 	/* Transform color key from rgb to yuv if CSC is enabled */
 	if (((fg_csc_type == RGB2YUV) && (bg_csc_type == YUV2YUV)) ||
-		((fg_csc_type == YUV2YUV) && (bg_csc_type == RGB2YUV)) ||
-		((fg_csc_type == YUV2YUV) && (bg_csc_type == YUV2YUV)) ||
-		((fg_csc_type == YUV2RGB) && (bg_csc_type == YUV2RGB))) {
-
+	    ((fg_csc_type == YUV2YUV) && (bg_csc_type == RGB2YUV)) ||
+	    ((fg_csc_type == YUV2YUV) && (bg_csc_type == YUV2YUV)) ||
+	    ((fg_csc_type == YUV2RGB) && (bg_csc_type == YUV2RGB))) {
 		debug("color key 0x%x need change to yuv fmt\n", color_key);
 
 		red = (color_key >> 16) & 0xFF;
diff --git a/drivers/video/imx/ipu_regs.h b/drivers/video/imx/ipu_regs.h
index 8d6ec4845f4..8e57a2add69 100644
--- a/drivers/video/imx/ipu_regs.h
+++ b/drivers/video/imx/ipu_regs.h
@@ -13,69 +13,71 @@
 #ifndef __IPU_REGS_INCLUDED__
 #define __IPU_REGS_INCLUDED__
 
-#define IPU_DISP0_BASE		0x00000000
-#define IPU_MCU_T_DEFAULT	8
-#define IPU_DISP1_BASE		(IPU_MCU_T_DEFAULT << 25)
-#define IPU_CM_REG_BASE		0x00000000
-#define IPU_STAT_REG_BASE	0x00000200
-#define IPU_IDMAC_REG_BASE	0x00008000
-#define IPU_ISP_REG_BASE	0x00010000
-#define IPU_DP_REG_BASE		0x00018000
-#define IPU_IC_REG_BASE		0x00020000
-#define IPU_IRT_REG_BASE	0x00028000
-#define IPU_CSI0_REG_BASE	0x00030000
-#define IPU_CSI1_REG_BASE	0x00038000
-#define IPU_DI0_REG_BASE	0x00040000
-#define IPU_DI1_REG_BASE	0x00048000
-#define IPU_SMFC_REG_BASE	0x00050000
-#define IPU_DC_REG_BASE		0x00058000
-#define IPU_DMFC_REG_BASE	0x00060000
-#define IPU_VDI_REG_BASE	0x00680000
+#include <asm/arch/imx-regs.h>
+
+#define IPU_DISP0_BASE 0x00000000
+#define IPU_MCU_T_DEFAULT 8
+#define IPU_DISP1_BASE (IPU_MCU_T_DEFAULT << 25)
+#define IPU_CM_REG_BASE 0x00000000
+#define IPU_STAT_REG_BASE 0x00000200
+#define IPU_IDMAC_REG_BASE 0x00008000
+#define IPU_ISP_REG_BASE 0x00010000
+#define IPU_DP_REG_BASE 0x00018000
+#define IPU_IC_REG_BASE 0x00020000
+#define IPU_IRT_REG_BASE 0x00028000
+#define IPU_CSI0_REG_BASE 0x00030000
+#define IPU_CSI1_REG_BASE 0x00038000
+#define IPU_DI0_REG_BASE 0x00040000
+#define IPU_DI1_REG_BASE 0x00048000
+#define IPU_SMFC_REG_BASE 0x00050000
+#define IPU_DC_REG_BASE 0x00058000
+#define IPU_DMFC_REG_BASE 0x00060000
+#define IPU_VDI_REG_BASE 0x00680000
 #if defined(CONFIG_MX51) || defined(CONFIG_MX53)
-#define IPU_CPMEM_REG_BASE	0x01000000
-#define IPU_LUT_REG_BASE	0x01020000
-#define IPU_SRM_REG_BASE	0x01040000
-#define IPU_TPM_REG_BASE	0x01060000
-#define IPU_DC_TMPL_REG_BASE	0x01080000
-#define IPU_ISP_TBPR_REG_BASE	0x010C0000
+#define IPU_CPMEM_REG_BASE 0x01000000
+#define IPU_LUT_REG_BASE 0x01020000
+#define IPU_SRM_REG_BASE 0x01040000
+#define IPU_TPM_REG_BASE 0x01060000
+#define IPU_DC_TMPL_REG_BASE 0x01080000
+#define IPU_ISP_TBPR_REG_BASE 0x010C0000
 #elif defined(CONFIG_MX6)
-#define IPU_CPMEM_REG_BASE	0x00100000
-#define IPU_LUT_REG_BASE	0x00120000
-#define IPU_SRM_REG_BASE	0x00140000
-#define IPU_TPM_REG_BASE	0x00160000
-#define IPU_DC_TMPL_REG_BASE	0x00180000
-#define IPU_ISP_TBPR_REG_BASE	0x001C0000
+#define IPU_CPMEM_REG_BASE 0x00100000
+#define IPU_LUT_REG_BASE 0x00120000
+#define IPU_SRM_REG_BASE 0x00140000
+#define IPU_TPM_REG_BASE 0x00160000
+#define IPU_DC_TMPL_REG_BASE 0x00180000
+#define IPU_ISP_TBPR_REG_BASE 0x001C0000
 #endif
 
-#define IPU_CTRL_BASE_ADDR	(IPU_SOC_BASE_ADDR + IPU_SOC_OFFSET)
+#define IPU_CTRL_BASE_ADDR (IPU_SOC_BASE_ADDR + IPU_SOC_OFFSET)
 
 extern u32 *ipu_dc_tmpl_reg;
 
-#define DC_EVT_NF		0
-#define DC_EVT_NL		1
-#define DC_EVT_EOF		2
-#define DC_EVT_NFIELD		3
-#define DC_EVT_EOL		4
-#define DC_EVT_EOFIELD		5
-#define DC_EVT_NEW_ADDR		6
-#define DC_EVT_NEW_CHAN		7
-#define DC_EVT_NEW_DATA		8
-
-#define DC_EVT_NEW_ADDR_W_0	0
-#define DC_EVT_NEW_ADDR_W_1	1
-#define DC_EVT_NEW_CHAN_W_0	2
-#define DC_EVT_NEW_CHAN_W_1	3
-#define DC_EVT_NEW_DATA_W_0	4
-#define DC_EVT_NEW_DATA_W_1	5
-#define DC_EVT_NEW_ADDR_R_0	6
-#define DC_EVT_NEW_ADDR_R_1	7
-#define DC_EVT_NEW_CHAN_R_0	8
-#define DC_EVT_NEW_CHAN_R_1	9
-#define DC_EVT_NEW_DATA_R_0	10
-#define DC_EVT_NEW_DATA_R_1	11
+#define DC_EVT_NF 0
+#define DC_EVT_NL 1
+#define DC_EVT_EOF 2
+#define DC_EVT_NFIELD 3
+#define DC_EVT_EOL 4
+#define DC_EVT_EOFIELD 5
+#define DC_EVT_NEW_ADDR 6
+#define DC_EVT_NEW_CHAN 7
+#define DC_EVT_NEW_DATA 8
+
+#define DC_EVT_NEW_ADDR_W_0 0
+#define DC_EVT_NEW_ADDR_W_1 1
+#define DC_EVT_NEW_CHAN_W_0 2
+#define DC_EVT_NEW_CHAN_W_1 3
+#define DC_EVT_NEW_DATA_W_0 4
+#define DC_EVT_NEW_DATA_W_1 5
+#define DC_EVT_NEW_ADDR_R_0 6
+#define DC_EVT_NEW_ADDR_R_1 7
+#define DC_EVT_NEW_CHAN_R_0 8
+#define DC_EVT_NEW_CHAN_R_1 9
+#define DC_EVT_NEW_DATA_R_0 10
+#define DC_EVT_NEW_DATA_R_1 11
 
 /* Software reset for ipu */
-#define SW_IPU_RST	8
+#define SW_IPU_RST 8
 
 enum {
 	IPU_CONF_DP_EN = 0x00000020,
@@ -296,67 +298,63 @@ struct ipu_dmfc {
 	u32 stat;
 };
 
-#define IPU_CM_REG		((struct ipu_cm *)(IPU_CTRL_BASE_ADDR + \
-				IPU_CM_REG_BASE))
-#define IPU_CONF		(&IPU_CM_REG->conf)
-#define IPU_SRM_PRI1		(&IPU_CM_REG->srm_pri1)
-#define IPU_SRM_PRI2		(&IPU_CM_REG->srm_pri2)
-#define IPU_FS_PROC_FLOW1	(&IPU_CM_REG->fs_proc_flow[0])
-#define IPU_FS_PROC_FLOW2	(&IPU_CM_REG->fs_proc_flow[1])
-#define IPU_FS_PROC_FLOW3	(&IPU_CM_REG->fs_proc_flow[2])
-#define IPU_FS_DISP_FLOW1	(&IPU_CM_REG->fs_disp_flow[0])
-#define IPU_DISP_GEN		(&IPU_CM_REG->disp_gen)
-#define IPU_MEM_RST		(&IPU_CM_REG->mem_rst)
-#define IPU_GPR			(&IPU_CM_REG->gpr)
-#define IPU_CHA_DB_MODE_SEL(ch)	(&IPU_CM_REG->ch_db_mode_sel[ch / 32])
-
-#define IPU_STAT		((struct ipu_stat *)(IPU_CTRL_BASE_ADDR + \
-				IPU_STAT_REG_BASE))
-#define IPU_INT_STAT(n)		(&IPU_STAT->int_stat[(n) - 1])
-#define IPU_CHA_CUR_BUF(ch)	(&IPU_STAT->cur_buf[ch / 32])
-#define IPU_CHA_BUF0_RDY(ch)	(&IPU_STAT->ch_buf0_rdy[ch / 32])
-#define IPU_CHA_BUF1_RDY(ch)	(&IPU_STAT->ch_buf1_rdy[ch / 32])
-#define IPUIRQ_2_STATREG(irq)	(IPU_INT_STAT(1) + ((irq) / 32))
-#define IPUIRQ_2_MASK(irq)	(1UL << ((irq) & 0x1F))
-
-#define IPU_INT_CTRL(n)		(&IPU_CM_REG->int_ctrl[(n) - 1])
-
-#define IDMAC_REG		((struct ipu_idmac *)(IPU_CTRL_BASE_ADDR + \
-				IPU_IDMAC_REG_BASE))
-#define IDMAC_CONF		(&IDMAC_REG->conf)
-#define IDMAC_CHA_EN(ch)	(&IDMAC_REG->ch_en[ch / 32])
-#define IDMAC_CHA_PRI(ch)	(&IDMAC_REG->ch_pri[ch / 32])
-
-#define DI_REG(di)		((struct ipu_di *)(IPU_CTRL_BASE_ADDR + \
-				((di == 1) ? IPU_DI1_REG_BASE : \
-				IPU_DI0_REG_BASE)))
-#define DI_GENERAL(di)		(&DI_REG(di)->general)
-#define DI_BS_CLKGEN0(di)	(&DI_REG(di)->bs_clkgen0)
-#define DI_BS_CLKGEN1(di)	(&DI_REG(di)->bs_clkgen1)
-
-#define DI_SW_GEN0(di, gen)	(&DI_REG(di)->sw_gen0[gen - 1])
-#define DI_SW_GEN1(di, gen)	(&DI_REG(di)->sw_gen1[gen - 1])
-#define DI_STP_REP(di, gen)	(&DI_REG(di)->stp_rep[(gen - 1) / 2])
-#define DI_STP_REP9(di)		(&DI_REG(di)->stp_rep9)
-#define DI_SYNC_AS_GEN(di)	(&DI_REG(di)->sync_as)
-#define DI_DW_GEN(di, gen)	(&DI_REG(di)->dw_gen[gen])
-#define DI_DW_SET(di, gen, set)	(&DI_REG(di)->dw_set[gen + 12 * set])
-#define DI_POL(di)		(&DI_REG(di)->pol)
-#define DI_SCR_CONF(di)		(&DI_REG(di)->scr_conf)
-
-#define DMFC_REG		((struct ipu_dmfc *)(IPU_CTRL_BASE_ADDR + \
-				IPU_DMFC_REG_BASE))
-#define DMFC_WR_CHAN		(&DMFC_REG->wr_chan)
-#define DMFC_WR_CHAN_DEF	(&DMFC_REG->wr_chan_def)
-#define DMFC_DP_CHAN		(&DMFC_REG->dp_chan)
-#define DMFC_DP_CHAN_DEF	(&DMFC_REG->dp_chan_def)
-#define DMFC_GENERAL1		(&DMFC_REG->general[0])
-#define DMFC_IC_CTRL		(&DMFC_REG->ic_ctrl)
-
-#define DC_REG			((struct ipu_dc *)(IPU_CTRL_BASE_ADDR + \
-				IPU_DC_REG_BASE))
-#define DC_MAP_CONF_PTR(n)	(&DC_REG->dc_map_ptr[n / 2])
-#define DC_MAP_CONF_VAL(n)	(&DC_REG->dc_map_val[n / 2])
+#define IPU_CM_REG ((struct ipu_cm *)(IPU_CTRL_BASE_ADDR + IPU_CM_REG_BASE))
+#define IPU_CONF (&IPU_CM_REG->conf)
+#define IPU_SRM_PRI1 (&IPU_CM_REG->srm_pri1)
+#define IPU_SRM_PRI2 (&IPU_CM_REG->srm_pri2)
+#define IPU_FS_PROC_FLOW1 (&IPU_CM_REG->fs_proc_flow[0])
+#define IPU_FS_PROC_FLOW2 (&IPU_CM_REG->fs_proc_flow[1])
+#define IPU_FS_PROC_FLOW3 (&IPU_CM_REG->fs_proc_flow[2])
+#define IPU_FS_DISP_FLOW1 (&IPU_CM_REG->fs_disp_flow[0])
+#define IPU_DISP_GEN (&IPU_CM_REG->disp_gen)
+#define IPU_MEM_RST (&IPU_CM_REG->mem_rst)
+#define IPU_GPR (&IPU_CM_REG->gpr)
+#define IPU_CHA_DB_MODE_SEL(ch) (&IPU_CM_REG->ch_db_mode_sel[ch / 32])
+
+#define IPU_STAT ((struct ipu_stat *)(IPU_CTRL_BASE_ADDR + IPU_STAT_REG_BASE))
+#define IPU_INT_STAT(n) (&IPU_STAT->int_stat[(n) - 1])
+#define IPU_CHA_CUR_BUF(ch) (&IPU_STAT->cur_buf[ch / 32])
+#define IPU_CHA_BUF0_RDY(ch) (&IPU_STAT->ch_buf0_rdy[ch / 32])
+#define IPU_CHA_BUF1_RDY(ch) (&IPU_STAT->ch_buf1_rdy[ch / 32])
+#define IPUIRQ_2_STATREG(irq) (IPU_INT_STAT(1) + ((irq) / 32))
+#define IPUIRQ_2_MASK(irq) (1UL << ((irq) & 0x1F))
+
+#define IPU_INT_CTRL(n) (&IPU_CM_REG->int_ctrl[(n) - 1])
+
+#define IDMAC_REG \
+	((struct ipu_idmac *)(IPU_CTRL_BASE_ADDR + IPU_IDMAC_REG_BASE))
+#define IDMAC_CONF (&IDMAC_REG->conf)
+#define IDMAC_CHA_EN(ch) (&IDMAC_REG->ch_en[ch / 32])
+#define IDMAC_CHA_PRI(ch) (&IDMAC_REG->ch_pri[ch / 32])
+
+#define DI_REG(di)                              \
+	((struct ipu_di *)(IPU_CTRL_BASE_ADDR + \
+			   ((di == 1) ? IPU_DI1_REG_BASE : IPU_DI0_REG_BASE)))
+#define DI_GENERAL(di) (&DI_REG(di)->general)
+#define DI_BS_CLKGEN0(di) (&DI_REG(di)->bs_clkgen0)
+#define DI_BS_CLKGEN1(di) (&DI_REG(di)->bs_clkgen1)
+
+#define DI_SW_GEN0(di, gen) (&DI_REG(di)->sw_gen0[gen - 1])
+#define DI_SW_GEN1(di, gen) (&DI_REG(di)->sw_gen1[gen - 1])
+#define DI_STP_REP(di, gen) (&DI_REG(di)->stp_rep[(gen - 1) / 2])
+#define DI_STP_REP9(di) (&DI_REG(di)->stp_rep9)
+#define DI_SYNC_AS_GEN(di) (&DI_REG(di)->sync_as)
+#define DI_DW_GEN(di, gen) (&DI_REG(di)->dw_gen[gen])
+#define DI_DW_SET(di, gen, set) (&DI_REG(di)->dw_set[gen + 12 * set])
+#define DI_POL(di) (&DI_REG(di)->pol)
+#define DI_SCR_CONF(di) (&DI_REG(di)->scr_conf)
+
+#define DMFC_REG ((struct ipu_dmfc *)(IPU_CTRL_BASE_ADDR + IPU_DMFC_REG_BASE))
+#define DMFC_WR_CHAN (&DMFC_REG->wr_chan)
+#define DMFC_WR_CHAN_DEF (&DMFC_REG->wr_chan_def)
+#define DMFC_DP_CHAN (&DMFC_REG->dp_chan)
+#define DMFC_DP_CHAN_DEF (&DMFC_REG->dp_chan_def)
+#define DMFC_GENERAL1 (&DMFC_REG->general[0])
+#define DMFC_IC_CTRL (&DMFC_REG->ic_ctrl)
+
+#define DC_REG ((struct ipu_dc *)(IPU_CTRL_BASE_ADDR + IPU_DC_REG_BASE))
+#define DC_MAP_CONF_PTR(n) (&DC_REG->dc_map_ptr[n / 2])
+#define DC_MAP_CONF_VAL(n) (&DC_REG->dc_map_val[n / 2])
 
 static inline struct ipu_dc_ch *dc_ch_offset(int ch)
 {
@@ -376,38 +374,36 @@ static inline struct ipu_dc_ch *dc_ch_offset(int ch)
 		printf("%s: invalid channel %d\n", __func__, ch);
 		return NULL;
 	}
-
 }
 
-#define DC_RL_CH(ch, evt)	(&dc_ch_offset(ch)->rl[evt / 2])
+#define DC_RL_CH(ch, evt) (&dc_ch_offset(ch)->rl[evt / 2])
 
-#define DC_WR_CH_CONF(ch)	(&dc_ch_offset(ch)->wr_ch_conf)
-#define DC_WR_CH_ADDR(ch)	(&dc_ch_offset(ch)->wr_ch_addr)
+#define DC_WR_CH_CONF(ch) (&dc_ch_offset(ch)->wr_ch_conf)
+#define DC_WR_CH_ADDR(ch) (&dc_ch_offset(ch)->wr_ch_addr)
 
-#define DC_WR_CH_CONF_1		DC_WR_CH_CONF(1)
-#define DC_WR_CH_CONF_5		DC_WR_CH_CONF(5)
+#define DC_WR_CH_CONF_1 DC_WR_CH_CONF(1)
+#define DC_WR_CH_CONF_5 DC_WR_CH_CONF(5)
 
-#define DC_GEN			(&DC_REG->gen)
-#define DC_DISP_CONF2(disp)	(&DC_REG->disp_conf2[disp])
-#define DC_STAT			(&DC_REG->stat)
+#define DC_GEN (&DC_REG->gen)
+#define DC_DISP_CONF2(disp) (&DC_REG->disp_conf2[disp])
+#define DC_STAT (&DC_REG->stat)
 
 #define DP_SYNC 0
 #define DP_ASYNC0 0x60
 #define DP_ASYNC1 0xBC
 
-#define DP_REG			((struct ipu_dp *)(IPU_CTRL_BASE_ADDR + \
-				IPU_DP_REG_BASE))
-#define DP_COM_CONF()		(&DP_REG->com_conf_sync)
-#define DP_GRAPH_WIND_CTRL()	(&DP_REG->graph_wind_ctrl_sync)
-#define DP_CSC_A_0()		(&DP_REG->csca_sync[0])
-#define DP_CSC_A_1()		(&DP_REG->csca_sync[1])
-#define DP_CSC_A_2()		(&DP_REG->csca_sync[2])
-#define DP_CSC_A_3()		(&DP_REG->csca_sync[3])
+#define DP_REG ((struct ipu_dp *)(IPU_CTRL_BASE_ADDR + IPU_DP_REG_BASE))
+#define DP_COM_CONF() (&DP_REG->com_conf_sync)
+#define DP_GRAPH_WIND_CTRL() (&DP_REG->graph_wind_ctrl_sync)
+#define DP_CSC_A_0() (&DP_REG->csca_sync[0])
+#define DP_CSC_A_1() (&DP_REG->csca_sync[1])
+#define DP_CSC_A_2() (&DP_REG->csca_sync[2])
+#define DP_CSC_A_3() (&DP_REG->csca_sync[3])
 
-#define DP_CSC_0()		(&DP_REG->csc_sync[0])
-#define DP_CSC_1()		(&DP_REG->csc_sync[1])
+#define DP_CSC_0() (&DP_REG->csc_sync[0])
+#define DP_CSC_1() (&DP_REG->csc_sync[1])
 
 /* DC template opcodes */
-#define WROD(lf)		(0x18 | (lf << 1))
+#define WROD(lf) (0x18 | (lf << 1))
 
 #endif
diff --git a/drivers/video/imx/mxc_ipuv3_fb.c b/drivers/video/imx/mxc_ipuv3_fb.c
index fdeb3cabea7..6b81d522041 100644
--- a/drivers/video/imx/mxc_ipuv3_fb.c
+++ b/drivers/video/imx/mxc_ipuv3_fb.c
@@ -10,23 +10,23 @@
  * (C) Copyright 2004-2010 Freescale Semiconductor, Inc.
  */
 
-#include <log.h>
-#include <part.h>
+#include "../videomodes.h"
+#include "display.h"
+#include "ipu.h"
+#include "ipu_regs.h"
+#include "mxcfb.h"
 #include <asm/cache.h>
-#include <linux/errno.h>
 #include <asm/global_data.h>
-#include <linux/string.h>
-#include <linux/list.h>
-#include <linux/fb.h>
 #include <asm/io.h>
 #include <asm/mach-imx/video.h>
+#include <linux/errno.h>
+#include <linux/fb.h>
+#include <linux/list.h>
+#include <linux/string.h>
+#include <log.h>
 #include <malloc.h>
-#include "../videomodes.h"
-#include "ipu.h"
-#include "mxcfb.h"
-#include "ipu_regs.h"
-#include "display.h"
 #include <panel.h>
+#include <part.h>
 
 #include <dm.h>
 #include <video.h>
@@ -41,7 +41,7 @@ static uint8_t gdisp;
 static uint32_t gpixfmt;
 
 static void fb_videomode_to_var(struct fb_var_screeninfo *var,
-			 const struct fb_videomode *mode)
+				const struct fb_videomode *mode)
 {
 	var->xres = mode->xres;
 	var->yres = mode->yres;
@@ -82,12 +82,7 @@ struct mxcfb_info {
 	u32 pseudo_palette[16];
 };
 
-enum {
-	BOTH_ON,
-	SRC_ON,
-	TGT_ON,
-	BOTH_OFF
-};
+enum { BOTH_ON, SRC_ON, TGT_ON, BOTH_OFF };
 
 static unsigned long default_bpp = 16;
 static unsigned char g_dp_in_use;
@@ -132,16 +127,11 @@ static int setup_disp_channel1(struct fb_info *fbi)
 	 */
 	if (fbi->var.vmode & FB_VMODE_INTERLACED) {
 		params.mem_dp_bg_sync.interlaced = 1;
-		params.mem_dp_bg_sync.out_pixel_fmt =
-			IPU_PIX_FMT_YUV444;
+		params.mem_dp_bg_sync.out_pixel_fmt = IPU_PIX_FMT_YUV444;
+	} else if (mxc_fbi->ipu_di_pix_fmt) {
+		params.mem_dp_bg_sync.out_pixel_fmt = mxc_fbi->ipu_di_pix_fmt;
 	} else {
-		if (mxc_fbi->ipu_di_pix_fmt) {
-			params.mem_dp_bg_sync.out_pixel_fmt =
-				mxc_fbi->ipu_di_pix_fmt;
-		} else {
-			params.mem_dp_bg_sync.out_pixel_fmt =
-				IPU_PIX_FMT_RGB666;
-		}
+		params.mem_dp_bg_sync.out_pixel_fmt = IPU_PIX_FMT_RGB666;
 	}
 	params.mem_dp_bg_sync.in_pixel_fmt = bpp_to_pixfmt(fbi);
 	if (mxc_fbi->alpha_chan_en)
@@ -163,24 +153,16 @@ static int setup_disp_channel2(struct fb_info *fbi)
 
 	fbi->var.xoffset = fbi->var.yoffset = 0;
 
-	debug("%s: %x %d %d %d %lx %lx\n",
-		__func__,
-		mxc_fbi->ipu_ch,
-		fbi->var.xres,
-		fbi->var.yres,
-		fbi->fix.line_length,
-		fbi->fix.smem_start,
-		fbi->fix.smem_start +
-		(fbi->fix.line_length * fbi->var.yres));
-
-	retval = ipu_init_channel_buffer(mxc_fbi->ipu_ch, IPU_INPUT_BUFFER,
-					 bpp_to_pixfmt(fbi),
-					 fbi->var.xres, fbi->var.yres,
-					 fbi->fix.line_length,
-					 fbi->fix.smem_start +
-					 (fbi->fix.line_length * fbi->var.yres),
-					 fbi->fix.smem_start,
-					 0, 0);
+	debug("%s: %x %d %d %d %lx %lx\n", __func__, mxc_fbi->ipu_ch,
+	      fbi->var.xres, fbi->var.yres, fbi->fix.line_length,
+	      fbi->fix.smem_start,
+	      fbi->fix.smem_start + (fbi->fix.line_length * fbi->var.yres));
+
+	retval = ipu_init_channel_buffer(
+		mxc_fbi->ipu_ch, IPU_INPUT_BUFFER, bpp_to_pixfmt(fbi),
+		fbi->var.xres, fbi->var.yres, fbi->fix.line_length,
+		fbi->fix.smem_start + (fbi->fix.line_length * fbi->var.yres),
+		fbi->fix.smem_start, 0, 0);
 	if (retval)
 		printf("ipu_init_channel_buffer error %d\n", retval);
 
@@ -190,7 +172,7 @@ static int setup_disp_channel2(struct fb_info *fbi)
 /*
  * Set framebuffer parameters and change the operating mode.
  *
- * @param       info     framebuffer information pointer
+ * @param	info	 framebuffer information pointer
  */
 static int mxcfb_set_par(struct fb_info *fbi)
 {
@@ -245,15 +227,11 @@ static int mxcfb_set_par(struct fb_info *fbi)
 
 	if (ipu_init_sync_panel(mxc_fbi->ipu_di,
 				(PICOS2KHZ(fbi->var.pixclock)) * 1000UL,
-				fbi->var.xres, fbi->var.yres,
-				out_pixel_fmt,
-				fbi->var.left_margin,
-				fbi->var.hsync_len,
-				fbi->var.right_margin,
-				fbi->var.upper_margin,
-				fbi->var.vsync_len,
-				fbi->var.lower_margin,
-				0, sig_cfg) != 0) {
+				fbi->var.xres, fbi->var.yres, out_pixel_fmt,
+				fbi->var.left_margin, fbi->var.hsync_len,
+				fbi->var.right_margin, fbi->var.upper_margin,
+				fbi->var.vsync_len, fbi->var.lower_margin, 0,
+				sig_cfg) != 0) {
 		puts("mxcfb: Error initializing panel.\n");
 		return -EINVAL;
 	}
@@ -271,9 +249,9 @@ static int mxcfb_set_par(struct fb_info *fbi)
 /*
  * Check framebuffer variable parameters and adjust to valid values.
  *
- * @param       var      framebuffer variable parameters
+ * @param	var	 framebuffer variable parameters
  *
- * @param       info     framebuffer information pointer
+ * @param	info	 framebuffer information pointer
  */
 static int mxcfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
@@ -362,13 +340,13 @@ static int mxcfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	if (var->pixclock < 1000) {
 		htotal = var->xres + var->right_margin + var->hsync_len +
-		    var->left_margin;
+			 var->left_margin;
 		vtotal = var->yres + var->lower_margin + var->vsync_len +
-		    var->upper_margin;
+			 var->upper_margin;
 		var->pixclock = (vtotal * htotal * 6UL) / 100UL;
 		var->pixclock = KHZ2PICOS(var->pixclock);
 		printf("pixclock set for 60Hz refresh = %u ps\n",
-			var->pixclock);
+		       var->pixclock);
 	}
 
 	var->height = -1;
@@ -384,8 +362,8 @@ static int mxcfb_map_video_memory(struct fb_info *fbi)
 	struct video_uc_plat *plat = dev_get_uclass_plat(mxc_fbi->udev);
 
 	if (fbi->fix.smem_len < fbi->var.yres_virtual * fbi->fix.line_length) {
-		fbi->fix.smem_len = fbi->var.yres_virtual *
-				    fbi->fix.line_length;
+		fbi->fix.smem_len =
+			fbi->var.yres_virtual * fbi->fix.line_length;
 	}
 	fbi->fix.smem_len = roundup(fbi->fix.smem_len, ARCH_DMA_MINALIGN);
 
@@ -400,7 +378,7 @@ static int mxcfb_map_video_memory(struct fb_info *fbi)
 	}
 
 	debug("allocated fb @ paddr=0x%08X, size=%d.\n",
-		(uint32_t) fbi->fix.smem_start, fbi->fix.smem_len);
+	      (uint32_t)fbi->fix.smem_start, fbi->fix.smem_len);
 
 	fbi->screen_size = fbi->fix.smem_len;
 
@@ -422,10 +400,10 @@ static int mxcfb_unmap_video_memory(struct fb_info *fbi)
  * Initializes the framebuffer information pointer. After allocating
  * sufficient memory for the framebuffer structure, the fields are
  * filled with custom information passed in from the configurable
- * structures.  This includes information such as bits per pixel,
+ * structures.	This includes information such as bits per pixel,
  * color maps, screen width/height and RGBA offsets.
  *
- * Return:      Framebuffer structure initialized with our information
+ * Return:	Framebuffer structure initialized with our information
  */
 static struct fb_info *mxcfb_init_fbinfo(void)
 {
@@ -434,15 +412,10 @@ static struct fb_info *mxcfb_init_fbinfo(void)
 	struct fb_info *fbi;
 	struct mxcfb_info *mxcfbi;
 	char *p;
-	int size = sizeof(struct mxcfb_info) + PADDING +
-		sizeof(struct fb_info);
-
-	debug("%s: %d %d %d %d\n",
-		__func__,
-		PADDING,
-		size,
-		sizeof(struct mxcfb_info),
-		sizeof(struct fb_info));
+	int size = sizeof(struct mxcfb_info) + PADDING + sizeof(struct fb_info);
+
+	debug("%s: %d %d %d %d\n", __func__, PADDING, size,
+	      sizeof(struct mxcfb_info), sizeof(struct fb_info));
 	/*
 	 * Allocate sufficient memory for the fb structure
 	 */
@@ -458,7 +431,7 @@ static struct fb_info *mxcfb_init_fbinfo(void)
 
 	mxcfbi = (struct mxcfb_info *)fbi->par;
 	debug("Framebuffer structures at: fbi=0x%x mxcfbi=0x%x\n",
-		(unsigned int)fbi, (unsigned int)mxcfbi);
+	      (unsigned int)fbi, (unsigned int)mxcfbi);
 
 	fbi->var.activate = FB_ACTIVATE_NOW;
 
@@ -476,10 +449,10 @@ extern struct clk *g_ipu_clk;
  * this routine: Framebuffer initialization, Memory allocation and
  * mapping, Framebuffer registration, IPU initialization.
  *
- * Return:      Appropriate error code to the kernel common code
+ * Return:	Appropriate error code to the kernel common code
  */
-static int mxcfb_probe(struct udevice *dev, u32 interface_pix_fmt,
-		       uint8_t disp, struct fb_videomode const *mode)
+static int mxcfb_probe(struct udevice *dev, u32 interface_pix_fmt, uint8_t disp,
+		       struct fb_videomode const *mode)
 {
 	struct fb_info *fbi;
 	struct mxcfb_info *mxcfbi;
@@ -519,8 +492,8 @@ static int mxcfb_probe(struct udevice *dev, u32 interface_pix_fmt,
 	mxcfbi->ipu_di_pix_fmt = interface_pix_fmt;
 	fb_videomode_to_var(&fbi->var, mode);
 	fbi->var.bits_per_pixel = 16;
-	fbi->fix.line_length = fbi->var.xres_virtual *
-			       (fbi->var.bits_per_pixel / 8);
+	fbi->fix.line_length =
+		fbi->var.xres_virtual * (fbi->var.bits_per_pixel / 8);
 	fbi->fix.smem_len = fbi->var.yres_virtual * fbi->fix.line_length;
 
 	mxcfb_check_var(&fbi->var, fbi);
@@ -563,8 +536,7 @@ void ipuv3_fb_shutdown(void)
 	}
 }
 
-int ipuv3_fb_init(struct fb_videomode const *mode,
-		  uint8_t disp,
+int ipuv3_fb_init(struct fb_videomode const *mode, uint8_t disp,
 		  uint32_t pixfmt)
 {
 	gmode = mode;
@@ -576,9 +548,9 @@ int ipuv3_fb_init(struct fb_videomode const *mode,
 
 enum {
 	/* Maximum display size we support */
-	LCD_MAX_WIDTH		= 1920,
-	LCD_MAX_HEIGHT		= 1080,
-	LCD_MAX_LOG2_BPP	= VIDEO_BPP16,
+	LCD_MAX_WIDTH = 1920,
+	LCD_MAX_HEIGHT = 1080,
+	LCD_MAX_LOG2_BPP = VIDEO_BPP16,
 };
 
 static int ipuv3_video_probe(struct udevice *dev)
@@ -591,8 +563,8 @@ static int ipuv3_video_probe(struct udevice *dev)
 	u32 fb_start, fb_end;
 	int ret;
 
-	debug("%s() plat: base 0x%lx, size 0x%x\n",
-	      __func__, plat->base, plat->size);
+	debug("%s() plat: base 0x%lx, size 0x%x\n", __func__, plat->base,
+	      plat->size);
 
 	ret = ipu_probe();
 	if (ret)
@@ -644,8 +616,7 @@ static int ipuv3_video_bind(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
-	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-		     (1 << VIDEO_BPP32) / 8;
+	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT * (1 << VIDEO_BPP32) / 8;
 
 	return 0;
 }
@@ -657,15 +628,15 @@ static const struct udevice_id ipuv3_video_ids[] = {
 #ifdef CONFIG_ARCH_MX5
 	{ .compatible = "fsl,imx53-ipu" },
 #endif
-	{ }
+	{}
 };
 
 U_BOOT_DRIVER(fsl_imx6q_ipu) = {
-	.name	= "fsl_imx6q_ipu",
-	.id	= UCLASS_VIDEO,
+	.name = "fsl_imx6q_ipu",
+	.id = UCLASS_VIDEO,
 	.of_match = ipuv3_video_ids,
-	.bind	= ipuv3_video_bind,
-	.probe	= ipuv3_video_probe,
-	.priv_auto	= sizeof(struct ipuv3_video_priv),
-	.flags	= DM_FLAG_PRE_RELOC,
+	.bind = ipuv3_video_bind,
+	.probe = ipuv3_video_probe,
+	.priv_auto = sizeof(struct ipuv3_video_priv),
+	.flags = DM_FLAG_PRE_RELOC,
 };
-- 
2.39.5

