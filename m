Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5B1D6ACEE
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 12:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF04B83E16;
	Thu, 18 Dec 2025 13:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="mdp0Oxvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4945983D6C; Thu, 18 Dec 2025 09:33:44 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C5483D3D
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cemwL4x0C64mnMDu18hjZlhxAQLytR7B5vWDvua3T8BgAhAYHqakxxPxbG4i/iecnG0GFSwz03pHM3QeLNyrNEm596+heh80SyVr8YVuyQqHvLtIaWESbRIq4wWrXHS8sECf/eX6TYaN7OPXmlR9sUDPzv8Tbhut8T4nYsxlcyMrTJxt/d0gWhCANq6h/PShpbWDTFHA0+HbujbGAuh2uCCxnEIZvhmJCctJWI277ZyV0nNt1WexDstzIud/AlEbA5bxM3XuvzH7CtANGIuYcWpbIrI0NF16Ex04T+sV3XJSuQ+ZCeV45e1y/IHhVAm/JWwiHnOXKbHQOhPsWBWC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJ3LmQqT+h9pATejcGSTHDDNqsYNnJCChY9Cv04WgE4=;
 b=OJcoElmKCZvVHsB+pGemd10T2I2UBfQ89Q9GJeH1HwCgdke3DtKsYVfyeIcUVXX7IGJOLZ/aXht3424I9xDTm305vWNNtuIh7A1E3riJ9hp/GwpGHjiK+RvwTEdAaksgPyTzWkFnBWkJekVAFHJqFjXW0E3EgOkki/6wfvHvjve7EkICUIkIUUrV1Oj7a3W8xiVaxODkFHLanmH2OuGlOXgf44ysqJitm1mv4/hC6+LoqxhAXNZOr3gD9naRiNi8bBRqmV54OzLB4Mzi5Og8b59vee3WLs5kzDQr57tz8+oVRLCnbI2nE/rs1ZvT7K8GwEeMl/xCMdlYqQj/CXkdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ3LmQqT+h9pATejcGSTHDDNqsYNnJCChY9Cv04WgE4=;
 b=mdp0Oxvjbu5t1ncJZWmq9IIdOILuu0RfOkL4Ynzh7kQ22O0KIOU+XXMO6dQtdIQQB0OqQ7VMrOPRF/9QaPVTCmQT3iE+ev/mmPusyZbIhvYLUBbOKqImLPRL2ov6JP2M2FU4wbHkeYh/zezUU6C1RwMx9zzmNbVwJHJeknPT9HNRPxkYZSUH5UvMvk2da/LMiouZOyGAeG7goDnleHLVwVkqSSLUPB2xpJHO12jeLJYTLVboxNjnTFow+yADPpcnLT/ywYeDLWT2hdmRlUBtDb3b5h7RUMPm9O1f91CjmYyMjuXvttJFrTG2YmsbiiGLm177f51gSEoB/0yk1f6qGg==
Received: from SA9PR13CA0133.namprd13.prod.outlook.com (2603:10b6:806:27::18)
 by CH3PR22MB5545.namprd22.prod.outlook.com (2603:10b6:610:1e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 08:33:35 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::4a) by SA9PR13CA0133.outlook.office365.com
 (2603:10b6:806:27::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Thu,
 18 Dec 2025 08:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 08:33:35 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id F0020D9C01;
 Thu, 18 Dec 2025 10:33:32 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 David Zang <davidzangcs@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v1 7/7] video: imx: ipuv3: refactor to use dm-managed state
Date: Thu, 18 Dec 2025 10:33:26 +0200
Message-Id: <20251218083326.644326-8-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
References: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|CH3PR22MB5545:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 55aa55ed-1241-4640-8384-08de3e10228d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6VIA12YkaPLHaKX4uaETS64VrpjrK/lWylliLMIRd4LOgYOnsEN7yNNXUuks?=
 =?us-ascii?Q?2hYUzt/XtzZzLGi1RqFkJF50fQ86bY+4c099FruHMrLO8cRSBl0COnQ0HW2a?=
 =?us-ascii?Q?COWkeIurV8zttmL7G5MvxSoqy/vhVBO5LlVVrqXcvhpo1Oam+f0XmFV6dz5Y?=
 =?us-ascii?Q?S7y8lf2Dwi3PW3K4pOBi8xE/ssdgMtWt6c0NqMBeasAzOZP0YyBZb8NNX/qS?=
 =?us-ascii?Q?omFrqLd+KS34n4SxhFiKukw2x9Hcx5wXtE4jo2nhlgZva9R73+kVIU/DyZmJ?=
 =?us-ascii?Q?9+6hagToKXGzhoWLMCyr24BRT6sESpCpFd5b6PKxbggz1sXjF86Ttt4OnzqV?=
 =?us-ascii?Q?gsQbxxScI96Q5dwsHERYHSSp5+oWw/NB4tgK69BujiyVdLbSzZNYcEzB40Rs?=
 =?us-ascii?Q?uVaJa38aW/z+V79UCA0BnSRsF/i32DnQDgC12Exr+M//JoIEs/FVZdIpamir?=
 =?us-ascii?Q?WXdVZ67Ccz3p0uJOwJoYfeOvGKA/qQ9wHVIDMow16kUDZE/yZIUCCPbFarnq?=
 =?us-ascii?Q?X/Rtz1SohSrfbMiMXd4W1Qrv2vfLfc5Tc2ICAa37riWRJksmveLT0S8qObMd?=
 =?us-ascii?Q?TX24ivpeZjirRq8Ixn4vQAsW/BPf44ayiumBzL4aFOUh7wVNtQKLYNEzPZeO?=
 =?us-ascii?Q?z4KAuXha8zcIczsaUc+BeISYRsUID3q5AbLs3g0Pv+JCcUV+2S5C5Ui3MgIH?=
 =?us-ascii?Q?VyJ4otXAh/D1By86IrXxqvxbtUvOHHzhrUuz31y/+mMwHMbGSIHVfCdOcA7c?=
 =?us-ascii?Q?tKZ7SH3eZW7VBHdY3joQCL0/3r0tmWKa//f4GdtwH5KYNTSAajOu5U46zdhY?=
 =?us-ascii?Q?xSlUF7o1voNQM3x7uX4aumbTFKeedecaTWESspuZXBEYa4cLPnR68nz34hiS?=
 =?us-ascii?Q?5A8OnYPnV93kkBW6tVdGPFcsezYoPPR7ps/lFMFGBiONjWfTKCH+QkxcjFL3?=
 =?us-ascii?Q?wLqhdhByPQKwqGFtj9PhgNHDOhUfZa1iUPS5nDe508LCjVk4e+ja/TBoZ8b0?=
 =?us-ascii?Q?UmXgSo86L26B9uS9T863/sjzOlmzIIiil13wZBVyMSJd4z9mBT+iuVPRhSk8?=
 =?us-ascii?Q?5llJsGir8TnvJQWUEwQRfp1vRfj4MUfrFNo1nmDMH0rixQfovfCV9ZX6Aow/?=
 =?us-ascii?Q?Aaov+qdD8LyrPdXMvbE78tyo+hZEHp3hjnfh30YR/9HMyh9o79yCmgz+uDBw?=
 =?us-ascii?Q?FT6lxI26y4A8gMW+L4Mhv7CHg3Srd9pTDCDzkK9xxM4chIA1NDcd5FOxaDN2?=
 =?us-ascii?Q?jHbDrhgx/oAbkReh/XZR5Pi0U9yG1KbaqNwxAgV3L7ydJmHc5sVDH17mFa/U?=
 =?us-ascii?Q?a7qK2vJnBW64RdkSfIThsTOPlWaUKbuBfzU9dm74MCjZC/Ped6/UKFWoQHG0?=
 =?us-ascii?Q?0tdhhCbcqxIknUNMv1P8QWaStcJnCaIVb8g/Xpup9KwA3WfEpCOI0X99mzCj?=
 =?us-ascii?Q?iS2UXgMwJXbiM0acRGl8kVXn4aoqrL8TpRLspjEkubaEJGzpFPdtgOwTs62F?=
 =?us-ascii?Q?tE07kc0gou3I0lpkr7oJ47RhGORFadD/6WnV2Q03tG+dM+7nDqs9hbmDi+yU?=
 =?us-ascii?Q?URvv6HC0AwDh3qzqIXQ=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:33:35.1319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55aa55ed-1241-4640-8384-08de3e10228d
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR22MB5545
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

Get rid of most globals that are spread around between TU's and place
them in their own structs managed by dm. Device state is now owned by
each driver instance. This design mirrors the Linux IPUv3 driver
architecture.

This work is done in preparation to migrate the driver to the clock
framework. While not the primary intent, this change also enables
multiple IPU instances to exist contemporarily.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

 arch/arm/mach-imx/cpu.c          |   8 +-
 drivers/video/imx/ipu.h          |  97 +++++++--
 drivers/video/imx/ipu_common.c   | 361 +++++++++++++++++++------------
 drivers/video/imx/ipu_disp.c     | 145 +++++--------
 drivers/video/imx/mxc_ipuv3_fb.c | 103 +++++----
 include/ipu_pixfmt.h             |   3 +-
 6 files changed, 434 insertions(+), 283 deletions(-)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index cc215b771ef..2aa9d9c9666 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -285,10 +285,10 @@ u32 get_ahb_clk(void)
 
 void arch_preboot_os(void)
 {
-#if defined(CONFIG_IMX_AHCI)
 	struct udevice *dev;
 	int rc;
 
+#if defined(CONFIG_IMX_AHCI)
 	rc = uclass_find_device(UCLASS_AHCI, 0, &dev);
 	if (!rc && dev) {
 		rc = device_remove(dev, DM_REMOVE_NORMAL);
@@ -308,7 +308,11 @@ void arch_preboot_os(void)
 #endif
 #if defined(CONFIG_VIDEO_IPUV3)
 	/* disable video before launching O/S */
-	ipuv3_fb_shutdown();
+	rc = uclass_find_first_device(UCLASS_VIDEO, &dev);
+	while (!rc && dev) {
+		ipuv3_fb_shutdown(dev);
+		uclass_find_next_device(&dev);
+	}
 #endif
 #if defined(CONFIG_VIDEO_MXS) && !defined(CONFIG_VIDEO)
 	lcdif_power_down();
diff --git a/drivers/video/imx/ipu.h b/drivers/video/imx/ipu.h
index f7d9d809529..62827dc480d 100644
--- a/drivers/video/imx/ipu.h
+++ b/drivers/video/imx/ipu.h
@@ -1,5 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
+ * Code fixes:
+ *
+ * (C) Copyright 2025
+ * Brian Ruley, GE HealthCare, brian.ruley@gehealthcare.com
+ *
  * Porting to u-boot:
  *
  * (C) Copyright 2010
@@ -19,9 +24,14 @@
 #define IDMA_CHAN_INVALID 0xFF
 #define HIGH_RESOLUTION_WIDTH 1024
 
+struct ipu_ctx;
+struct ipu_di_config;
+
 struct clk {
 	const char *name;
 	int id;
+	/* The IPU context of this clock */
+	struct ipu_ctx *ctx;
 	/* Source clock this clk depends on */
 	struct clk *parent;
 	/* Secondary clock to enable/disable with this clock */
@@ -65,6 +75,69 @@ struct clk {
 	int (*set_parent)(struct clk *clk, struct clk *parent);
 };
 
+struct udevice;
+
+/*
+ * Per-IPU context used by ipu_common to manage clocks and channel state.
+ * Lifetime is owned by the IPU DM driver
+ */
+struct ipu_ctx {
+	struct udevice *dev;
+	int dev_id;
+
+	struct clk *ipu_clk;
+	struct clk *ldb_clk;
+	unsigned char ipu_clk_enabled;
+	struct clk *di_clk[2];
+	struct clk *pixel_clk[2];
+
+	u8 dc_di_assignment[10];
+	u32 channel_init_mask;
+	u32 channel_enable_mask;
+
+	int ipu_dc_use_count;
+	int ipu_dp_use_count;
+	int ipu_dmfc_use_count;
+	int ipu_di_use_count[2];
+};
+
+/**
+ * @disp:	    The DI the panel is attached to.
+ * @pixel_clk_rate: Desired pixel clock frequency in Hz.
+ * @pixel_fmt:	    Input parameter for pixel format of buffer.
+ *		    Pixel format is a FOURCC ASCII code.
+ * @width:	    The width of panel in pixels.
+ * @height:	    The height of panel in pixels.
+ * @h_start_width:  The number of pixel clocks between the HSYNC
+ *		    signal pulse and the start of valid data.
+ * @h_sync_width:   The width of the HSYNC signal in units of pixel
+ *		    clocks.
+ * @h_end_width:    The number of pixel clocks between the end of
+ *		    valid data and the HSYNC signal for next line.
+ * @v_start_width:  The number of lines between the VSYNC
+ *		    signal pulse and the start of valid data.
+ * @v_sync_width:   The width of the VSYNC signal in units of lines
+ * @v_end_width:    The number of lines between the end of valid
+ *		    data and the VSYNC signal for next frame.
+ * @ctx:	    The IPU context of the display.
+ */
+struct ipu_di_config {
+	int disp;
+	u32 pixel_clk_rate;
+	u32 pixel_fmt;
+	u16 width;
+	u16 height;
+	u16 h_start_width;
+	u16 h_sync_width;
+	u16 h_end_width;
+	u16 v_start_width;
+	u16 v_sync_width;
+	u16 v_end_width;
+	u32 v_to_h_sync;
+
+	struct ipu_ctx *ctx;
+};
+
 /*
  * Enumeration of Synchronous (Memory-less) panel types
  */
@@ -201,8 +274,9 @@ typedef struct {
 typedef enum { RGB, YCBCR, YUV } ipu_color_space_t;
 
 /* Common IPU API */
-int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params);
-void ipu_uninit_channel(ipu_channel_t channel);
+int32_t ipu_init_channel(struct ipu_ctx *ctx, ipu_channel_t channel,
+			 ipu_channel_params_t *params);
+void ipu_uninit_channel(struct ipu_ctx *ctx, ipu_channel_t channel);
 
 int32_t ipu_init_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
 				u32 pixel_fmt, u16 width, u16 height,
@@ -212,14 +286,10 @@ int32_t ipu_init_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
 
 void ipu_clear_buffer_ready(ipu_channel_t channel, ipu_buffer_t type,
 			    u32 buf_num);
-int32_t ipu_enable_channel(ipu_channel_t channel);
-int32_t ipu_disable_channel(ipu_channel_t channel);
+int32_t ipu_enable_channel(struct ipu_ctx *ctx, ipu_channel_t channel);
+int32_t ipu_disable_channel(struct ipu_ctx *ctx, ipu_channel_t channel);
 
-int32_t ipu_init_sync_panel(int disp, u32 pixel_clk, u16 width, u16 height,
-			    u32 pixel_fmt, u16 h_start_width, u16 h_sync_width,
-			    u16 h_end_width, u16 v_start_width,
-			    u16 v_sync_width, u16 v_end_width, u32 v_to_h_sync,
-			    ipu_di_signal_cfg_t sig);
+int32_t ipu_init_sync_panel(struct ipu_di_config *di, ipu_di_signal_cfg_t sig);
 
 int32_t ipu_disp_set_global_alpha(ipu_channel_t channel, unsigned char enable,
 				  u8 alpha);
@@ -238,17 +308,18 @@ int clk_get_usecount(struct clk *clk);
 struct clk *clk_get_parent(struct clk *clk);
 
 void ipu_dump_registers(void);
-int ipu_probe(void);
-bool ipu_clk_enabled(void);
+struct ipu_ctx *ipu_probe(struct udevice *dev);
+bool ipu_clk_enabled(struct ipu_ctx *ctx);
 
 void ipu_dmfc_init(int dmfc_type, int first);
 void ipu_init_dc_mappings(void);
 void ipu_dmfc_set_wait4eot(int dma_chan, int width);
 void ipu_dc_init(int dc_chan, int di, unsigned char interlaced);
 void ipu_dc_uninit(int dc_chan);
-void ipu_dp_dc_enable(ipu_channel_t channel);
+void ipu_dp_dc_enable(struct ipu_ctx *ctx, ipu_channel_t channel);
 int ipu_dp_init(ipu_channel_t channel, u32 in_pixel_fmt, u32 out_pixel_fmt);
 void ipu_dp_uninit(ipu_channel_t channel);
-void ipu_dp_dc_disable(ipu_channel_t channel, unsigned char swap);
+void ipu_dp_dc_disable(struct ipu_ctx *ctx, ipu_channel_t channel,
+		       unsigned char swap);
 ipu_color_space_t format_to_colorspace(u32 fmt);
 #endif
diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index 4ca81d48a5f..ac3e90a9f3d 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -1,5 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
+ * Code fixes:
+ *
+ * (C) Copyright 2025
+ * Brian Ruley, GE HealthCare, brian.ruley@gehealthcare.com
+ *
  * Porting to u-boot:
  *
  * (C) Copyright 2010
@@ -10,7 +15,6 @@
  * (C) Copyright 2005-2010 Freescale Semiconductor, Inc.
  */
 
-/* #define DEBUG */
 #include "ipu.h"
 #include "ipu_regs.h"
 #include <asm/arch/crm_regs.h>
@@ -19,6 +23,8 @@
 #include <asm/io.h>
 #include <config.h>
 #include <div64.h>
+#include <dm.h>
+#include <dm/devres.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -206,46 +212,76 @@ static void clk_ipu_disable(struct clk *clk)
 #endif
 }
 
-static struct clk ipu_clk = {
-	.name = "ipu_clk",
+/*
+ * Function to initialize the ipu clock
+ *
+ * @param   ctx	    The ipu context for which the function is called
+ *
+ * Return:  Returns 0 on success or negative error code on error
+ */
+static int ipu_clk_init(struct ipu_ctx *ctx)
+{
+	struct clk *ipu_clk;
+
+	ipu_clk = devm_kzalloc(ctx->dev, sizeof(*ipu_clk), GFP_KERNEL);
+	if (!ipu_clk)
+		return -ENOMEM;
+
+	ipu_clk->name = "ipu_clk";
+	ipu_clk->ctx = ctx;
 #if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
-	.enable_reg =
-		(u32 *)(CCM_BASE_ADDR + offsetof(struct mxc_ccm_reg, CCGR5)),
-	.enable_shift = MXC_CCM_CCGR5_IPU_OFFSET,
+	ipu_clk->enable_reg =
+		(u32 *)(CCM_BASE_ADDR + offsetof(struct mxc_ccm_reg, CCGR5));
+	ipu_clk->enable_shift = MXC_CCM_CCGR5_IPU_OFFSET;
 #else
-	.enable_reg =
-		(u32 *)(CCM_BASE_ADDR + offsetof(struct mxc_ccm_reg, CCGR3)),
-	.enable_shift = MXC_CCM_CCGR3_IPU1_IPU_DI0_OFFSET,
+	ipu_clk->enable_reg =
+		(u32 *)(CCM_BASE_ADDR + offsetof(struct mxc_ccm_reg, CCGR3));
+	ipu_clk->enable_shift = MXC_CCM_CCGR3_IPU1_IPU_DI0_OFFSET;
 #endif
-	.enable = clk_ipu_enable,
-	.disable = clk_ipu_disable,
-	.usecount = 0,
+
+	ipu_clk->enable = clk_ipu_enable;
+	ipu_clk->disable = clk_ipu_disable;
+	ipu_clk->usecount = 0;
+
+#if CONFIG_IS_ENABLED(MX51)
+	ipu_clk->rate = IPUV3_CLK_MX51;
+#elif CONFIG_IS_ENABLED(MX53)
+	ipu_clk->rate = IPUV3_CLK_MX53;
+#else
+	ipu_clk->rate = is_mx6sdl() ? IPUV3_CLK_MX6DL : IPUV3_CLK_MX6Q;
+#endif
+
+	ctx->ipu_clk = ipu_clk;
+	return 0;
 };
 
 #if !defined CFG_SYS_LDB_CLOCK
 #define CFG_SYS_LDB_CLOCK 65000000
 #endif
 
-static struct clk ldb_clk = {
-	.name = "ldb_clk",
-	.rate = CFG_SYS_LDB_CLOCK,
-	.usecount = 0,
-};
+/*
+ * Function to initialize the ldb dummy clock
+ *
+ * @param   ctx	    The ipu context for which the function is called
+ *
+ * Return:  Returns 0 on success or negative error code on error
+ */
+static int ipu_ldb_clk_init(struct ipu_ctx *ctx)
+{
+	struct clk *ldb_clk;
+
+	ldb_clk = devm_kzalloc(ctx->dev, sizeof(*ldb_clk), GFP_KERNEL);
+	if (!ldb_clk)
+		return -ENOMEM;
 
-/* Globals */
-struct clk *g_ipu_clk;
-struct clk *g_ldb_clk;
-unsigned char g_ipu_clk_enabled;
-struct clk *g_di_clk[2];
-struct clk *g_pixel_clk[2];
-unsigned char g_dc_di_assignment[10];
-u32 g_channel_init_mask;
-u32 g_channel_enable_mask;
-
-static int ipu_dc_use_count;
-static int ipu_dp_use_count;
-static int ipu_dmfc_use_count;
-static int ipu_di_use_count[2];
+	ldb_clk->name = "ldb_clk";
+	ldb_clk->ctx = ctx;
+	ldb_clk->rate = CFG_SYS_LDB_CLOCK;
+	ldb_clk->usecount = 0;
+
+	ctx->ldb_clk = ldb_clk;
+	return 0;
+};
 
 u32 *ipu_cpmem_base;
 u32 *ipu_dc_tmpl_reg;
@@ -388,10 +424,11 @@ static void ipu_pixel_clk_disable(struct clk *clk)
 static int ipu_pixel_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	u32 di_gen = __raw_readl(DI_GENERAL(clk->id));
+	struct ipu_ctx *ctx = clk->ctx;
 
-	if (parent == g_ipu_clk)
+	if (parent == ctx->ipu_clk)
 		di_gen &= ~DI_GEN_DI_CLK_EXT;
-	else if (!IS_ERR(g_di_clk[clk->id]) && parent == g_ldb_clk)
+	else if (!IS_ERR(ctx->di_clk[clk->id]) && parent == ctx->ldb_clk)
 		di_gen |= DI_GEN_DI_CLK_EXT;
 	else
 		return -EINVAL;
@@ -401,29 +438,34 @@ static int ipu_pixel_clk_set_parent(struct clk *clk, struct clk *parent)
 	return 0;
 }
 
-static struct clk pixel_clk[] = {
-	{
-		.name = "pixel_clk",
-		.id = 0,
-		.recalc = ipu_pixel_clk_recalc,
-		.set_rate = ipu_pixel_clk_set_rate,
-		.round_rate = ipu_pixel_clk_round_rate,
-		.set_parent = ipu_pixel_clk_set_parent,
-		.enable = ipu_pixel_clk_enable,
-		.disable = ipu_pixel_clk_disable,
-		.usecount = 0,
-	},
-	{
-		.name = "pixel_clk",
-		.id = 1,
-		.recalc = ipu_pixel_clk_recalc,
-		.set_rate = ipu_pixel_clk_set_rate,
-		.round_rate = ipu_pixel_clk_round_rate,
-		.set_parent = ipu_pixel_clk_set_parent,
-		.enable = ipu_pixel_clk_enable,
-		.disable = ipu_pixel_clk_disable,
-		.usecount = 0,
-	},
+/*
+ * Function to initialize the pixel clock
+ *
+ * @param   ctx	    The ipu context for which the function is called
+ *
+ * Return:  Returns 0 on success or negative error code on error
+ */
+static int ipu_pixel_clk_init(struct ipu_ctx *ctx, int id)
+{
+	struct clk *pixel_clk;
+
+	pixel_clk = devm_kzalloc(ctx->dev, sizeof(*pixel_clk), GFP_KERNEL);
+	if (!pixel_clk)
+		return -ENOMEM;
+
+	pixel_clk->name = "pixel_clk";
+	pixel_clk->id = id;
+	pixel_clk->ctx = ctx;
+	pixel_clk->recalc = ipu_pixel_clk_recalc;
+	pixel_clk->set_rate = ipu_pixel_clk_set_rate;
+	pixel_clk->round_rate = ipu_pixel_clk_round_rate;
+	pixel_clk->set_parent = ipu_pixel_clk_set_parent;
+	pixel_clk->enable = ipu_pixel_clk_enable;
+	pixel_clk->disable = ipu_pixel_clk_disable;
+	pixel_clk->usecount = 0;
+
+	ctx->pixel_clk[id] = pixel_clk;
+	return 0;
 };
 
 /*
@@ -456,11 +498,24 @@ static void ipu_reset(void)
  * @param	dev	The device structure for the IPU passed in by the
  *			driver framework.
  *
- * Return:	Returns 0 on success or negative error code on error
+ * Return:	Returns pointer to IPU context on success or pointer error code
+ *		on error
  */
-int ipu_probe(void)
+struct ipu_ctx *ipu_probe(struct udevice *dev)
 {
 	unsigned long ipu_base;
+	struct ipu_ctx *ctx;
+	int ret = 0;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ctx->dev = dev;
+	ctx->dev_id = dev_seq(dev);
+
 #if defined CONFIG_MX51
 	u32 temp;
 
@@ -481,29 +536,33 @@ int ipu_probe(void)
 	ipu_cpmem_base = (u32 *)(ipu_base + IPU_CPMEM_REG_BASE);
 	ipu_dc_tmpl_reg = (u32 *)(ipu_base + IPU_DC_TMPL_REG_BASE);
 
-	g_pixel_clk[0] = &pixel_clk[0];
-	g_pixel_clk[1] = &pixel_clk[1];
+	ret = ipu_pixel_clk_init(ctx, 0);
+	if (ret)
+		goto err;
 
-	g_ipu_clk = &ipu_clk;
-#if CONFIG_IS_ENABLED(MX51)
-	g_ipu_clk->rate = IPUV3_CLK_MX51;
-#elif CONFIG_IS_ENABLED(MX53)
-	g_ipu_clk->rate = IPUV3_CLK_MX53;
-#else
-	g_ipu_clk->rate = is_mx6sdl() ? IPUV3_CLK_MX6DL : IPUV3_CLK_MX6Q;
-#endif
+	ret = ipu_pixel_clk_init(ctx, 1);
+	if (ret)
+		goto err;
+
+	ret = ipu_clk_init(ctx);
+	if (ret)
+		goto err;
+
+	debug("ipu_clk = %u\n", clk_get_rate(ctx->ipu_clk));
+
+	ret = ipu_ldb_clk_init(ctx);
+	if (ret)
+		goto err;
 
-	debug("ipu_clk = %u\n", clk_get_rate(g_ipu_clk));
-	g_ldb_clk = &ldb_clk;
-	debug("ldb_clk = %u\n", clk_get_rate(g_ldb_clk));
+	debug("ldb_clk = %u\n", clk_get_rate(ctx->ldb_clk));
 	ipu_reset();
 
-	clk_set_parent(g_pixel_clk[0], g_ipu_clk);
-	clk_set_parent(g_pixel_clk[1], g_ipu_clk);
-	clk_enable(g_ipu_clk);
+	clk_set_parent(ctx->pixel_clk[0], ctx->ipu_clk);
+	clk_set_parent(ctx->pixel_clk[1], ctx->ipu_clk);
+	clk_enable(ctx->ipu_clk);
 
-	g_di_clk[0] = NULL;
-	g_di_clk[1] = NULL;
+	ctx->di_clk[0] = NULL;
+	ctx->di_clk[1] = NULL;
 
 	__raw_writel(0x807FFFFF, IPU_MEM_RST);
 	while (__raw_readl(IPU_MEM_RST) & 0x80000000)
@@ -525,9 +584,11 @@ int ipu_probe(void)
 	/* Set MCU_T to divide MCU access window into 2 */
 	__raw_writel(0x00400000L | (IPU_MCU_T_DEFAULT << 18), IPU_DISP_GEN);
 
-	clk_disable(g_ipu_clk);
+	clk_disable(ctx->ipu_clk);
 
-	return 0;
+	return ctx;
+err:
+	return ERR_PTR(ret);
 }
 
 void ipu_dump_registers(void)
@@ -556,26 +617,32 @@ void ipu_dump_registers(void)
 /*
  * This function is called to initialize a logical IPU channel.
  *
- * @param	channel Input parameter for the logical channel ID to init.
+ * @param   ctx		The ipu context for which the function is called
+ *
+ * @param   channel	Input parameter for the logical channel ID to init.
  *
- * @param	params	Input parameter containing union of channel
+ * @param   params	Input parameter containing union of channel
  *			initialization parameters.
  *
- * Return:	Returns 0 on success or negative error code on fail
+ * Return:  Returns 0 on success or negative error code on fail
  */
-int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params)
+int32_t ipu_init_channel(struct ipu_ctx *ctx, ipu_channel_t channel,
+			 ipu_channel_params_t *params)
 {
+	struct clk *ipu_clk = ctx->ipu_clk;
+	u8 *dc_di_assignment = ctx->dc_di_assignment;
+	u32 *channel_init_mask = &ctx->channel_init_mask;
 	int ret = 0;
 	u32 ipu_conf;
 
 	debug("init channel = %d\n", IPU_CHAN_ID(channel));
 
-	if (g_ipu_clk_enabled == 0) {
-		g_ipu_clk_enabled = 1;
-		clk_enable(g_ipu_clk);
+	if (ctx->ipu_clk_enabled == 0) {
+		ctx->ipu_clk_enabled = 1;
+		clk_enable(ipu_clk);
 	}
 
-	if (g_channel_init_mask & (1L << IPU_CHAN_ID(channel))) {
+	if (*channel_init_mask & (1L << IPU_CHAN_ID(channel))) {
 		printf("Warning: channel already initialized %d\n",
 		       IPU_CHAN_ID(channel));
 	}
@@ -589,12 +656,12 @@ int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params)
 			goto err;
 		}
 
-		g_dc_di_assignment[1] = params->mem_dc_sync.di;
+		dc_di_assignment[1] = params->mem_dc_sync.di;
 		ipu_dc_init(1, params->mem_dc_sync.di,
 			    params->mem_dc_sync.interlaced);
-		ipu_di_use_count[params->mem_dc_sync.di]++;
-		ipu_dc_use_count++;
-		ipu_dmfc_use_count++;
+		ctx->ipu_di_use_count[params->mem_dc_sync.di]++;
+		ctx->ipu_dc_use_count++;
+		ctx->ipu_dmfc_use_count++;
 		break;
 	case MEM_BG_SYNC:
 		if (params->mem_dp_bg_sync.di > 1) {
@@ -602,23 +669,23 @@ int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params)
 			goto err;
 		}
 
-		g_dc_di_assignment[5] = params->mem_dp_bg_sync.di;
+		dc_di_assignment[5] = params->mem_dp_bg_sync.di;
 		ipu_dp_init(channel, params->mem_dp_bg_sync.in_pixel_fmt,
 			    params->mem_dp_bg_sync.out_pixel_fmt);
 		ipu_dc_init(5, params->mem_dp_bg_sync.di,
 			    params->mem_dp_bg_sync.interlaced);
-		ipu_di_use_count[params->mem_dp_bg_sync.di]++;
-		ipu_dc_use_count++;
-		ipu_dp_use_count++;
-		ipu_dmfc_use_count++;
+		ctx->ipu_di_use_count[params->mem_dp_bg_sync.di]++;
+		ctx->ipu_dc_use_count++;
+		ctx->ipu_dp_use_count++;
+		ctx->ipu_dmfc_use_count++;
 		break;
 	case MEM_FG_SYNC:
 		ipu_dp_init(channel, params->mem_dp_fg_sync.in_pixel_fmt,
 			    params->mem_dp_fg_sync.out_pixel_fmt);
 
-		ipu_dc_use_count++;
-		ipu_dp_use_count++;
-		ipu_dmfc_use_count++;
+		ctx->ipu_dc_use_count++;
+		ctx->ipu_dp_use_count++;
+		ctx->ipu_dmfc_use_count++;
 		break;
 	default:
 		printf("Missing channel initialization\n");
@@ -626,16 +693,16 @@ int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params)
 	}
 
 	/* Enable IPU sub module */
-	g_channel_init_mask |= 1L << IPU_CHAN_ID(channel);
-	if (ipu_dc_use_count == 1)
+	*channel_init_mask |= 1L << IPU_CHAN_ID(channel);
+	if (ctx->ipu_dc_use_count == 1)
 		ipu_conf |= IPU_CONF_DC_EN;
-	if (ipu_dp_use_count == 1)
+	if (ctx->ipu_dp_use_count == 1)
 		ipu_conf |= IPU_CONF_DP_EN;
-	if (ipu_dmfc_use_count == 1)
+	if (ctx->ipu_dmfc_use_count == 1)
 		ipu_conf |= IPU_CONF_DMFC_EN;
-	if (ipu_di_use_count[0] == 1)
+	if (ctx->ipu_di_use_count[0] == 1)
 		ipu_conf |= IPU_CONF_DI0_EN;
-	if (ipu_di_use_count[1] == 1)
+	if (ctx->ipu_di_use_count[1] == 1)
 		ipu_conf |= IPU_CONF_DI1_EN;
 
 	__raw_writel(ipu_conf, IPU_CONF);
@@ -647,15 +714,19 @@ err:
 /*
  * This function is called to uninitialize a logical IPU channel.
  *
+ * @param   ctx		The ipu context for which the function is called
+ *
  * @param	channel Input parameter for the logical channel ID to uninit.
  */
-void ipu_uninit_channel(ipu_channel_t channel)
+void ipu_uninit_channel(struct ipu_ctx *ctx, ipu_channel_t channel)
 {
+	u8 *dc_di_assignment = ctx->dc_di_assignment;
+	u32 *channel_init_mask = &ctx->channel_init_mask;
 	u32 reg;
 	u32 in_dma, out_dma = 0;
 	u32 ipu_conf;
 
-	if ((g_channel_init_mask & (1L << IPU_CHAN_ID(channel))) == 0) {
+	if ((*channel_init_mask & (1L << IPU_CHAN_ID(channel))) == 0) {
 		debug("Channel already uninitialized %d\n",
 		      IPU_CHAN_ID(channel));
 		return;
@@ -686,46 +757,46 @@ void ipu_uninit_channel(ipu_channel_t channel)
 	switch (channel) {
 	case MEM_DC_SYNC:
 		ipu_dc_uninit(1);
-		ipu_di_use_count[g_dc_di_assignment[1]]--;
-		ipu_dc_use_count--;
-		ipu_dmfc_use_count--;
+		ctx->ipu_di_use_count[dc_di_assignment[1]]--;
+		ctx->ipu_dc_use_count--;
+		ctx->ipu_dmfc_use_count--;
 		break;
 	case MEM_BG_SYNC:
 		ipu_dp_uninit(channel);
 		ipu_dc_uninit(5);
-		ipu_di_use_count[g_dc_di_assignment[5]]--;
-		ipu_dc_use_count--;
-		ipu_dp_use_count--;
-		ipu_dmfc_use_count--;
+		ctx->ipu_di_use_count[dc_di_assignment[5]]--;
+		ctx->ipu_dc_use_count--;
+		ctx->ipu_dp_use_count--;
+		ctx->ipu_dmfc_use_count--;
 		break;
 	case MEM_FG_SYNC:
 		ipu_dp_uninit(channel);
-		ipu_dc_use_count--;
-		ipu_dp_use_count--;
-		ipu_dmfc_use_count--;
+		ctx->ipu_dc_use_count--;
+		ctx->ipu_dp_use_count--;
+		ctx->ipu_dmfc_use_count--;
 		break;
 	default:
 		break;
 	}
 
-	g_channel_init_mask &= ~(1L << IPU_CHAN_ID(channel));
+	*channel_init_mask &= ~(1L << IPU_CHAN_ID(channel));
 
-	if (ipu_dc_use_count == 0)
+	if (ctx->ipu_dc_use_count == 0)
 		ipu_conf &= ~IPU_CONF_DC_EN;
-	if (ipu_dp_use_count == 0)
+	if (ctx->ipu_dp_use_count == 0)
 		ipu_conf &= ~IPU_CONF_DP_EN;
-	if (ipu_dmfc_use_count == 0)
+	if (ctx->ipu_dmfc_use_count == 0)
 		ipu_conf &= ~IPU_CONF_DMFC_EN;
-	if (ipu_di_use_count[0] == 0)
+	if (ctx->ipu_di_use_count[0] == 0)
 		ipu_conf &= ~IPU_CONF_DI0_EN;
-	if (ipu_di_use_count[1] == 0)
+	if (ctx->ipu_di_use_count[1] == 0)
 		ipu_conf &= ~IPU_CONF_DI1_EN;
 
 	__raw_writel(ipu_conf, IPU_CONF);
 
 	if (ipu_conf == 0) {
-		clk_disable(g_ipu_clk);
-		g_ipu_clk_enabled = 0;
+		clk_disable(ctx->ipu_clk);
+		ctx->ipu_clk_enabled = 0;
 	}
 }
 
@@ -1031,18 +1102,21 @@ int32_t ipu_init_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
 /*
  * This function enables a logical channel.
  *
- * @param	channel		Input parameter for the logical channel ID.
+ * @param   ctx		The ipu context for which the function is called
  *
- * Return:	This function returns 0 on success or negative error code on
- *		fail.
+ * @param   channel	Input parameter for the logical channel ID.
+ *
+ * Return:  This function returns 0 on success or negative error code on
+ *	    fail.
  */
-int32_t ipu_enable_channel(ipu_channel_t channel)
+int32_t ipu_enable_channel(struct ipu_ctx *ctx, ipu_channel_t channel)
 {
+	u32 *channel_enable_mask = &ctx->channel_enable_mask;
 	u32 reg;
 	u32 in_dma;
 	u32 out_dma;
 
-	if (g_channel_enable_mask & (1L << IPU_CHAN_ID(channel))) {
+	if (*channel_enable_mask & (1L << IPU_CHAN_ID(channel))) {
 		printf("Warning: channel already enabled %d\n",
 		       IPU_CHAN_ID(channel));
 	}
@@ -1062,9 +1136,9 @@ int32_t ipu_enable_channel(ipu_channel_t channel)
 
 	if ((channel == MEM_DC_SYNC) || (channel == MEM_BG_SYNC) ||
 	    (channel == MEM_FG_SYNC))
-		ipu_dp_dc_enable(channel);
+		ipu_dp_dc_enable(ctx, channel);
 
-	g_channel_enable_mask |= 1L << IPU_CHAN_ID(channel);
+	*channel_enable_mask |= 1L << IPU_CHAN_ID(channel);
 
 	return 0;
 }
@@ -1103,21 +1177,24 @@ void ipu_clear_buffer_ready(ipu_channel_t channel, ipu_buffer_t type,
 /*
  * This function disables a logical channel.
  *
- * @param	channel		Input parameter for the logical channel ID.
+ * @param   ctx		    The ipu context for which the function is called
+ *
+ * @param   channel	    Input parameter for the logical channel ID.
  *
- * @param	wait_for_stop	Flag to set whether to wait for channel end
- *				of frame or return immediately.
+ * @param   wait_for_stop   Flag to set whether to wait for channel end
+ *			    of frame or return immediately.
  *
- * Return:	This function returns 0 on success or negative error code on
- *		fail.
+ * Return:  This function returns 0 on success or negative error code on
+ *	    fail.
  */
-int32_t ipu_disable_channel(ipu_channel_t channel)
+int32_t ipu_disable_channel(struct ipu_ctx *ctx, ipu_channel_t channel)
 {
+	u32 *channel_enable_mask = &ctx->channel_enable_mask;
 	u32 reg;
 	u32 in_dma;
 	u32 out_dma;
 
-	if ((g_channel_enable_mask & (1L << IPU_CHAN_ID(channel))) == 0) {
+	if ((*channel_enable_mask & (1L << IPU_CHAN_ID(channel))) == 0) {
 		debug("Channel already disabled %d\n", IPU_CHAN_ID(channel));
 		return 0;
 	}
@@ -1132,7 +1209,7 @@ int32_t ipu_disable_channel(ipu_channel_t channel)
 
 	if ((channel == MEM_BG_SYNC) || (channel == MEM_FG_SYNC) ||
 	    (channel == MEM_DC_SYNC)) {
-		ipu_dp_dc_disable(channel, 0);
+		ipu_dp_dc_disable(ctx, channel, 0);
 	}
 
 	/* Disable DMA channel(s) */
@@ -1147,7 +1224,7 @@ int32_t ipu_disable_channel(ipu_channel_t channel)
 		__raw_writel(idma_mask(out_dma), IPU_CHA_CUR_BUF(out_dma));
 	}
 
-	g_channel_enable_mask &= ~(1L << IPU_CHAN_ID(channel));
+	*channel_enable_mask &= ~(1L << IPU_CHAN_ID(channel));
 
 	/* Set channel buffers NOT to be ready */
 	if (idma_is_valid(in_dma)) {
@@ -1219,7 +1296,7 @@ ipu_color_space_t format_to_colorspace(u32 fmt)
 	return RGB;
 }
 
-bool ipu_clk_enabled(void)
+bool ipu_clk_enabled(struct ipu_ctx *ctx)
 {
-	return g_ipu_clk_enabled;
+	return ctx->ipu_clk_enabled;
 }
diff --git a/drivers/video/imx/ipu_disp.c b/drivers/video/imx/ipu_disp.c
index 89dead372cd..6a337b13af6 100644
--- a/drivers/video/imx/ipu_disp.c
+++ b/drivers/video/imx/ipu_disp.c
@@ -1,5 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
+ * Code fixes:
+ *
+ * (C) Copyright 2025
+ * Brian Ruley, GE HealthCare, brian.ruley@gehealthcare.com
+ *
  * Porting to u-boot:
  *
  * (C) Copyright 2010
@@ -10,8 +15,6 @@
  * (C) Copyright 2005-2010 Freescale Semiconductor, Inc.
  */
 
-/* #define DEBUG */
-
 #include "ipu.h"
 #include "ipu_regs.h"
 #include <asm/arch/imx-regs.h>
@@ -40,14 +43,6 @@ int dmfc_type_setup;
 static int dmfc_size_28, dmfc_size_29, dmfc_size_24, dmfc_size_27, dmfc_size_23;
 int g_di1_tvout;
 
-extern struct clk *g_ipu_clk;
-extern struct clk *g_ldb_clk;
-extern struct clk *g_di_clk[2];
-extern struct clk *g_pixel_clk[2];
-
-extern unsigned char g_ipu_clk_enabled;
-extern unsigned char g_dc_di_assignment[];
-
 void ipu_dmfc_init(int dmfc_type, int first)
 {
 	u32 dmfc_wr_chan, dmfc_dp_chan;
@@ -579,7 +574,7 @@ void ipu_dc_uninit(int dc_chan)
 	}
 }
 
-void ipu_dp_dc_enable(ipu_channel_t channel)
+void ipu_dp_dc_enable(struct ipu_ctx *ctx, ipu_channel_t channel)
 {
 	int di;
 	u32 reg;
@@ -602,7 +597,7 @@ void ipu_dp_dc_enable(ipu_channel_t channel)
 		return;
 	}
 
-	di = g_dc_di_assignment[dc_chan];
+	di = ctx->dc_di_assignment[dc_chan];
 
 	/* Make sure other DC sync channel is not assigned same DI */
 	reg = __raw_readl(DC_WR_CH_CONF(6 - dc_chan));
@@ -616,12 +611,13 @@ void ipu_dp_dc_enable(ipu_channel_t channel)
 	reg |= 4 << DC_WR_CH_CONF_PROG_TYPE_OFFSET;
 	__raw_writel(reg, DC_WR_CH_CONF(dc_chan));
 
-	clk_enable(g_pixel_clk[di]);
+	clk_enable(ctx->pixel_clk[di]);
 }
 
 static unsigned char dc_swap;
 
-void ipu_dp_dc_disable(ipu_channel_t channel, unsigned char swap)
+void ipu_dp_dc_disable(struct ipu_ctx *ctx, ipu_channel_t channel,
+		       unsigned char swap)
 {
 	u32 reg;
 	u32 csc;
@@ -658,7 +654,7 @@ void ipu_dp_dc_disable(ipu_channel_t channel, unsigned char swap)
 		 * Wait for DC triple buffer to empty,
 		 * this check is useful for tv overlay.
 		 */
-		if (g_dc_di_assignment[dc_chan] == 0)
+		if (ctx->dc_di_assignment[dc_chan] == 0)
 			while ((__raw_readl(DC_STAT) & 0x00000002) !=
 			       0x00000002) {
 				udelay(2000);
@@ -666,7 +662,7 @@ void ipu_dp_dc_disable(ipu_channel_t channel, unsigned char swap)
 				if (timeout <= 0)
 					break;
 			}
-		else if (g_dc_di_assignment[dc_chan] == 1)
+		else if (ctx->dc_di_assignment[dc_chan] == 1)
 			while ((__raw_readl(DC_STAT) & 0x00000020) !=
 			       0x00000020) {
 				udelay(2000);
@@ -698,7 +694,7 @@ void ipu_dp_dc_disable(ipu_channel_t channel, unsigned char swap)
 		__raw_writel(reg, DC_WR_CH_CONF(dc_chan));
 
 		reg = __raw_readl(IPU_DISP_GEN);
-		if (g_dc_di_assignment[dc_chan])
+		if (ctx->dc_di_assignment[dc_chan])
 			reg &= ~DI1_COUNTER_RELEASE;
 		else
 			reg &= ~DI0_COUNTER_RELEASE;
@@ -706,7 +702,7 @@ void ipu_dp_dc_disable(ipu_channel_t channel, unsigned char swap)
 
 		/* Clock is already off because it must be done quickly, but
 		   we need to fix the ref count */
-		clk_disable(g_pixel_clk[g_dc_di_assignment[dc_chan]]);
+		clk_disable(ctx->pixel_clk[ctx->dc_di_assignment[dc_chan]]);
 	}
 }
 
@@ -765,46 +761,18 @@ static int ipu_pixfmt_to_map(u32 fmt)
 /*
  * This function is called to initialize a synchronous LCD panel.
  *
- * @param	disp		The DI the panel is attached to.
- *
- * @param	pixel_clk	Desired pixel clock frequency in Hz.
- *
- * @param	pixel_fmt	Input parameter for pixel format of buffer.
- *				Pixel format is a FOURCC ASCII code.
- *
- * @param	width		The width of panel in pixels.
- *
- * @param	height		The height of panel in pixels.
+ * @param	di	Pointer to display data.
  *
- * @param	hStartWidth	The number of pixel clocks between the HSYNC
- *				signal pulse and the start of valid data.
- *
- * @param	hSyncWidth	The width of the HSYNC signal in units of pixel
- *				clocks.
- *
- * @param	hEndWidth	The number of pixel clocks between the end of
- *				valid data and the HSYNC signal for next line.
- *
- * @param	vStartWidth	The number of lines between the VSYNC
- *				signal pulse and the start of valid data.
- *
- * @param	vSyncWidth	The width of the VSYNC signal in units of lines
- *
- * @param	vEndWidth	The number of lines between the end of valid
- *				data and the VSYNC signal for next frame.
- *
- * @param	sig		Bitfield of signal polarities for LCD interface.
+ * @param	sig	Bitfield of signal polarities for LCD interface.
  *
  * Return:	This function returns 0 on success or negative error code on
  *		fail.
  */
 
-int32_t ipu_init_sync_panel(int disp, u32 pixel_clk, u16 width, u16 height,
-			    u32 pixel_fmt, u16 h_start_width, u16 h_sync_width,
-			    u16 h_end_width, u16 v_start_width,
-			    u16 v_sync_width, u16 v_end_width, u32 v_to_h_sync,
-			    ipu_di_signal_cfg_t sig)
+int32_t ipu_init_sync_panel(struct ipu_di_config *di, ipu_di_signal_cfg_t sig)
 {
+	struct ipu_ctx *ctx = di->ctx;
+	int disp = di->disp;
 	u32 reg;
 	u32 di_gen, vsync_cnt;
 	u32 div, rounded_pixel_clk;
@@ -812,22 +780,24 @@ int32_t ipu_init_sync_panel(int disp, u32 pixel_clk, u16 width, u16 height,
 	int map;
 	struct clk *di_parent;
 
-	debug("panel size = %d x %d\n", width, height);
+	debug("panel size = %d x %d\n", di->width, di->height);
 
-	if ((v_sync_width == 0) || (h_sync_width == 0))
+	if ((di->v_sync_width == 0) || (di->h_sync_width == 0))
 		return -EINVAL;
 
 	/* adapt panel to ipu restricitions */
-	if (v_end_width < 2) {
-		v_end_width = 2;
+	if (di->v_end_width < 2) {
+		di->v_end_width = 2;
 		puts("WARNING: v_end_width (lower_margin) must be >= 2, adjusted\n");
 	}
 
-	h_total = width + h_sync_width + h_start_width + h_end_width;
-	v_total = height + v_sync_width + v_start_width + v_end_width;
+	h_total = di->width + di->h_sync_width + di->h_start_width +
+		  di->h_end_width;
+	v_total = di->height + di->v_sync_width + di->v_start_width +
+		  di->v_end_width;
 
 	/* Init clocking */
-	debug("pixel clk = %dHz\n", pixel_clk);
+	debug("pixel clk = %dHz\n", di->pixel_clk_rate);
 
 	if (sig.ext_clk) {
 		if (!(g_di1_tvout && (disp == 1))) { /*not round div for tvout*/
@@ -835,11 +805,12 @@ int32_t ipu_init_sync_panel(int disp, u32 pixel_clk, u16 width, u16 height,
 			 * Set the  PLL to be an even multiple
 			 * of the pixel clock.
 			 */
-			if ((clk_get_usecount(g_pixel_clk[0]) == 0) &&
-			    (clk_get_usecount(g_pixel_clk[1]) == 0)) {
-				di_parent = clk_get_parent(g_di_clk[disp]);
-				rounded_pixel_clk = clk_round_rate(
-					g_pixel_clk[disp], pixel_clk);
+			if ((clk_get_usecount(ctx->pixel_clk[0]) == 0) &&
+			    (clk_get_usecount(ctx->pixel_clk[1]) == 0)) {
+				di_parent = clk_get_parent(ctx->di_clk[disp]);
+				rounded_pixel_clk =
+					clk_round_rate(ctx->pixel_clk[disp],
+						       di->pixel_clk_rate);
 				div = clk_get_rate(di_parent) /
 				      rounded_pixel_clk;
 				if (div % 2)
@@ -849,27 +820,28 @@ int32_t ipu_init_sync_panel(int disp, u32 pixel_clk, u16 width, u16 height,
 					clk_set_rate(di_parent,
 						     div * rounded_pixel_clk);
 				udelay(10000);
-				clk_set_rate(g_di_clk[disp],
+				clk_set_rate(ctx->di_clk[disp],
 					     2 * rounded_pixel_clk);
 				udelay(10000);
 			}
 		}
-		clk_set_parent(g_pixel_clk[disp], g_ldb_clk);
+		clk_set_parent(ctx->pixel_clk[disp], ctx->ldb_clk);
 	} else {
-		if (clk_get_usecount(g_pixel_clk[disp]) != 0)
-			clk_set_parent(g_pixel_clk[disp], g_ipu_clk);
+		if (clk_get_usecount(ctx->pixel_clk[disp]) != 0)
+			clk_set_parent(ctx->pixel_clk[disp], ctx->ipu_clk);
 	}
-	rounded_pixel_clk = clk_round_rate(g_pixel_clk[disp], pixel_clk);
-	clk_set_rate(g_pixel_clk[disp], rounded_pixel_clk);
+	rounded_pixel_clk =
+		clk_round_rate(ctx->pixel_clk[disp], di->pixel_clk_rate);
+	clk_set_rate(ctx->pixel_clk[disp], rounded_pixel_clk);
 	udelay(5000);
 	/* Get integer portion of divider */
-	div = clk_get_rate(clk_get_parent(g_pixel_clk[disp])) /
+	div = clk_get_rate(clk_get_parent(ctx->pixel_clk[disp])) /
 	      rounded_pixel_clk;
 
 	ipu_di_data_wave_config(disp, SYNC_WAVE, div - 1, div - 1);
 	ipu_di_data_pin_config(disp, SYNC_WAVE, DI_PIN15, 3, 0, div * 2);
 
-	map = ipu_pixfmt_to_map(pixel_fmt);
+	map = ipu_pixfmt_to_map(di->pixel_fmt);
 	if (map < 0) {
 		debug("IPU_DISP: No MAP\n");
 		return -EINVAL;
@@ -931,7 +903,7 @@ int32_t ipu_init_sync_panel(int disp, u32 pixel_clk, u16 width, u16 height,
 				   4, /* counter */
 				   v_total / 2 - 1, /* run count */
 				   DI_SYNC_HSYNC, /* run_resolution */
-				   v_start_width, /*  offset */
+				   di->v_start_width, /*  offset */
 				   DI_SYNC_HSYNC, /* offset resolution */
 				   2, /* repeat count */
 				   DI_SYNC_VSYNC, /* CNT_CLR_SEL */
@@ -949,7 +921,7 @@ int32_t ipu_init_sync_panel(int disp, u32 pixel_clk, u16 width, u16 height,
 				   DI_SYNC_HSYNC, /* run_resolution */
 				   0, /*  offset */
 				   DI_SYNC_NONE, /* offset resolution */
-				   height / 2, /* repeat count */
+				   di->height / 2, /* repeat count */
 				   4, /* CNT_CLR_SEL */
 				   0, /* CNT_POLARITY_GEN_EN */
 				   DI_SYNC_NONE, /* CNT_POLARITY_CLR_SEL */
@@ -996,9 +968,9 @@ int32_t ipu_init_sync_panel(int disp, u32 pixel_clk, u16 width, u16 height,
 				   8, /* counter */
 				   0, /* run count  */
 				   DI_SYNC_CLK, /* run_resolution */
-				   h_start_width, /* offset  */
+				   di->h_start_width, /* offset  */
 				   DI_SYNC_CLK, /* offset resolution */
-				   width, /* repeat count  */
+				   di->width, /* repeat count  */
 				   5, /* CNT_CLR_SEL  */
 				   0, /* CNT_POLARITY_GEN_EN  */
 				   DI_SYNC_NONE, /* CNT_POLARITY_CLR_SEL */
@@ -1042,26 +1014,27 @@ int32_t ipu_init_sync_panel(int disp, u32 pixel_clk, u16 width, u16 height,
 
 		/* Setup external (delayed) HSYNC waveform */
 		ipu_di_sync_config(disp, DI_SYNC_HSYNC, h_total - 1,
-				   DI_SYNC_CLK, div * v_to_h_sync, DI_SYNC_CLK,
-				   0, DI_SYNC_NONE, 1, DI_SYNC_NONE,
-				   DI_SYNC_CLK, 0, h_sync_width * 2);
+				   DI_SYNC_CLK, div * di->v_to_h_sync,
+				   DI_SYNC_CLK, 0, DI_SYNC_NONE, 1,
+				   DI_SYNC_NONE, DI_SYNC_CLK, 0,
+				   di->h_sync_width * 2);
 		/* Setup VSYNC waveform */
 		vsync_cnt = DI_SYNC_VSYNC;
 		ipu_di_sync_config(disp, DI_SYNC_VSYNC, v_total - 1,
 				   DI_SYNC_INT_HSYNC, 0, DI_SYNC_NONE, 0,
 				   DI_SYNC_NONE, 1, DI_SYNC_NONE,
-				   DI_SYNC_INT_HSYNC, 0, v_sync_width * 2);
+				   DI_SYNC_INT_HSYNC, 0, di->v_sync_width * 2);
 		__raw_writel(v_total - 1, DI_SCR_CONF(disp));
 
 		/* Setup active data waveform to sync with DC */
 		ipu_di_sync_config(disp, 4, 0, DI_SYNC_HSYNC,
-				   v_sync_width + v_start_width, DI_SYNC_HSYNC,
-				   height, DI_SYNC_VSYNC, 0, DI_SYNC_NONE,
-				   DI_SYNC_NONE, 0, 0);
+				   di->v_sync_width + di->v_start_width,
+				   DI_SYNC_HSYNC, di->height, DI_SYNC_VSYNC, 0,
+				   DI_SYNC_NONE, DI_SYNC_NONE, 0, 0);
 		ipu_di_sync_config(disp, 5, 0, DI_SYNC_CLK,
-				   h_sync_width + h_start_width, DI_SYNC_CLK,
-				   width, 4, 0, DI_SYNC_NONE, DI_SYNC_NONE, 0,
-				   0);
+				   di->h_sync_width + di->h_start_width,
+				   DI_SYNC_CLK, di->width, 4, 0, DI_SYNC_NONE,
+				   DI_SYNC_NONE, 0, 0);
 
 		/* reset all unused counters */
 		__raw_writel(0, DI_SW_GEN0(disp, 6));
@@ -1112,7 +1085,7 @@ int32_t ipu_init_sync_panel(int disp, u32 pixel_clk, u16 width, u16 height,
 		reg |= DI_POL_DRDY_DATA_POLARITY;
 	__raw_writel(reg, DI_POL(disp));
 
-	__raw_writel(width, DC_DISP_CONF2(DC_DISP_ID_SYNC(disp)));
+	__raw_writel(di->width, DC_DISP_CONF2(DC_DISP_ID_SYNC(disp)));
 
 	return 0;
 }
diff --git a/drivers/video/imx/mxc_ipuv3_fb.c b/drivers/video/imx/mxc_ipuv3_fb.c
index fb9d364d23a..ab416fdd33c 100644
--- a/drivers/video/imx/mxc_ipuv3_fb.c
+++ b/drivers/video/imx/mxc_ipuv3_fb.c
@@ -1,5 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
+ * Code fixes:
+ *
+ * (C) Copyright 2025
+ * Brian Ruley, GE HealthCare, brian.ruley@gehealthcare.com
+ *
  * Porting to u-boot:
  *
  * (C) Copyright 2010
@@ -19,16 +24,17 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/video.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/fb.h>
 #include <linux/list.h>
 #include <linux/string.h>
 #include <log.h>
-#include <malloc.h>
 #include <panel.h>
 #include <part.h>
 
 #include <dm.h>
+#include <dm/devres.h>
 #include <video.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -60,6 +66,11 @@ static void fb_videomode_to_var(struct fb_var_screeninfo *var,
 	var->vmode = mode->vmode & FB_VMODE_MASK;
 }
 
+struct ipuv3_video_priv {
+	struct ipu_ctx *ctx;
+	ulong regs;
+};
+
 /*
  * Structure containing the MXC specific framebuffer information.
  */
@@ -67,7 +78,7 @@ struct mxcfb_info {
 	struct udevice *udev;
 	int blank;
 	ipu_channel_t ipu_ch;
-	int ipu_di;
+	struct ipu_di_config *di;
 	u32 ipu_di_pix_fmt;
 	unsigned char overlay;
 	unsigned char alpha_chan_en;
@@ -80,6 +91,8 @@ struct mxcfb_info {
 	u32 cur_ipu_alpha_buf;
 
 	u32 pseudo_palette[16];
+
+	struct ipu_ctx *ctx;
 };
 
 enum { BOTH_ON, SRC_ON, TGT_ON, BOTH_OFF };
@@ -118,7 +131,7 @@ static int setup_disp_channel1(struct fb_info *fbi)
 	struct mxcfb_info *mxc_fbi = (struct mxcfb_info *)fbi->par;
 
 	memset(&params, 0, sizeof(params));
-	params.mem_dp_bg_sync.di = mxc_fbi->ipu_di;
+	params.mem_dp_bg_sync.di = mxc_fbi->di->disp;
 
 	debug("%s called\n", __func__);
 	/*
@@ -137,9 +150,7 @@ static int setup_disp_channel1(struct fb_info *fbi)
 	if (mxc_fbi->alpha_chan_en)
 		params.mem_dp_bg_sync.alpha_chan_en = 1;
 
-	ipu_init_channel(mxc_fbi->ipu_ch, &params);
-
-	return 0;
+	return ipu_init_channel(mxc_fbi->ctx, mxc_fbi->ipu_ch, &params);
 }
 
 static int setup_disp_channel2(struct fb_info *fbi)
@@ -182,8 +193,8 @@ static int mxcfb_set_par(struct fb_info *fbi)
 	struct mxcfb_info *mxc_fbi = (struct mxcfb_info *)fbi->par;
 	u32 out_pixel_fmt;
 
-	ipu_disable_channel(mxc_fbi->ipu_ch);
-	ipu_uninit_channel(mxc_fbi->ipu_ch);
+	ipu_disable_channel(mxc_fbi->ctx, mxc_fbi->ipu_ch);
+	ipu_uninit_channel(mxc_fbi->ctx, mxc_fbi->ipu_ch);
 
 	mem_len = fbi->var.yres_virtual * fbi->fix.line_length;
 	if (!fbi->fix.smem_start || (mem_len > fbi->fix.smem_len)) {
@@ -225,13 +236,19 @@ static int mxcfb_set_par(struct fb_info *fbi)
 
 	debug("pixclock = %lu Hz\n", PICOS2KHZ(fbi->var.pixclock) * 1000UL);
 
-	if (ipu_init_sync_panel(mxc_fbi->ipu_di,
-				(PICOS2KHZ(fbi->var.pixclock)) * 1000UL,
-				fbi->var.xres, fbi->var.yres, out_pixel_fmt,
-				fbi->var.left_margin, fbi->var.hsync_len,
-				fbi->var.right_margin, fbi->var.upper_margin,
-				fbi->var.vsync_len, fbi->var.lower_margin, 0,
-				sig_cfg) != 0) {
+	mxc_fbi->di->pixel_clk_rate = (PICOS2KHZ(fbi->var.pixclock)) * 1000UL;
+	mxc_fbi->di->pixel_fmt = out_pixel_fmt;
+	mxc_fbi->di->width = fbi->var.xres;
+	mxc_fbi->di->height = fbi->var.yres;
+	mxc_fbi->di->h_start_width = fbi->var.left_margin;
+	mxc_fbi->di->h_sync_width = fbi->var.hsync_len;
+	mxc_fbi->di->h_end_width = fbi->var.right_margin;
+	mxc_fbi->di->v_start_width = fbi->var.upper_margin;
+	mxc_fbi->di->v_sync_width = fbi->var.vsync_len;
+	mxc_fbi->di->v_end_width = fbi->var.lower_margin;
+	mxc_fbi->di->v_to_h_sync = 0;
+
+	if (ipu_init_sync_panel(mxc_fbi->di, sig_cfg) != 0) {
 		puts("mxcfb: Error initializing panel.\n");
 		return -EINVAL;
 	}
@@ -241,7 +258,7 @@ static int mxcfb_set_par(struct fb_info *fbi)
 		return retval;
 
 	if (mxc_fbi->blank == FB_BLANK_UNBLANK)
-		ipu_enable_channel(mxc_fbi->ipu_ch);
+		ipu_enable_channel(mxc_fbi->ctx, mxc_fbi->ipu_ch);
 
 	return retval;
 }
@@ -403,9 +420,12 @@ static int mxcfb_unmap_video_memory(struct fb_info *fbi)
  * structures.	This includes information such as bits per pixel,
  * color maps, screen width/height and RGBA offsets.
  *
+ * @param	dev	The device structure for the IPU passed in by the
+ *			driver framework.
+ *
  * Return:	Framebuffer structure initialized with our information
  */
-static struct fb_info *mxcfb_init_fbinfo(void)
+static struct fb_info *mxcfb_init_fbinfo(struct udevice *dev)
 {
 #define BYTES_PER_LONG 4
 #define PADDING (BYTES_PER_LONG - (sizeof(struct fb_info) % BYTES_PER_LONG))
@@ -419,13 +439,10 @@ static struct fb_info *mxcfb_init_fbinfo(void)
 	/*
 	 * Allocate sufficient memory for the fb structure
 	 */
-
-	p = malloc(size);
+	p = devm_kzalloc(dev, size, GFP_KERNEL);
 	if (!p)
 		return NULL;
 
-	memset(p, 0, size);
-
 	fbi = (struct fb_info *)p;
 	fbi->par = p + sizeof(struct fb_info) + PADDING;
 
@@ -441,8 +458,6 @@ static struct fb_info *mxcfb_init_fbinfo(void)
 	return fbi;
 }
 
-extern struct clk *g_ipu_clk;
-
 /*
  * Probe routine for the framebuffer driver. It is called during the
  * driver binding process. The following functions are performed in
@@ -454,13 +469,15 @@ extern struct clk *g_ipu_clk;
 static int mxcfb_probe(struct udevice *dev, u32 interface_pix_fmt, u8 disp,
 		       struct fb_videomode const *mode)
 {
+	struct ipuv3_video_priv *ipu_priv = dev_get_priv(dev);
+	struct ipu_ctx *ctx = ipu_priv->ctx;
 	struct fb_info *fbi;
 	struct mxcfb_info *mxcfbi;
 
 	/*
 	 * Initialize FB structures
 	 */
-	fbi = mxcfb_init_fbinfo();
+	fbi = mxcfb_init_fbinfo(dev);
 	if (!fbi)
 		return -ENOMEM;
 
@@ -474,18 +491,24 @@ static int mxcfb_probe(struct udevice *dev, u32 interface_pix_fmt, u8 disp,
 		mxcfbi->blank = FB_BLANK_POWERDOWN;
 	}
 
-	mxcfbi->ipu_di = disp;
+	mxcfbi->di = devm_kzalloc(ctx->dev, sizeof(*mxcfbi->di), GFP_KERNEL);
+	if (!mxcfbi->di)
+		return -ENOMEM;
+
+	mxcfbi->di->disp = disp;
+	mxcfbi->di->ctx = ctx;
+	mxcfbi->ctx = ctx;
 	mxcfbi->udev = dev;
 
-	if (!ipu_clk_enabled())
-		clk_enable(g_ipu_clk);
+	if (!ipu_clk_enabled(ctx))
+		clk_enable(ctx->ipu_clk);
 
 	ipu_disp_set_global_alpha(mxcfbi->ipu_ch, 1, 0x80);
 	ipu_disp_set_color_key(mxcfbi->ipu_ch, 0, 0);
 
 	g_dp_in_use = 1;
 
-	mxcfb_info[mxcfbi->ipu_di] = fbi;
+	mxcfb_info[mxcfbi->di->disp] = fbi;
 
 	/* Need dummy values until real panel is configured */
 
@@ -514,20 +537,22 @@ static int mxcfb_probe(struct udevice *dev, u32 interface_pix_fmt, u8 disp,
 	return 0;
 }
 
-void ipuv3_fb_shutdown(void)
+void ipuv3_fb_shutdown(struct udevice *dev)
 {
 	int i;
 	struct ipu_stat *stat = (struct ipu_stat *)IPU_STAT;
+	struct ipuv3_video_priv *ipu_priv = dev_get_priv(dev);
+	struct ipu_ctx *ctx = ipu_priv->ctx;
 
-	if (!ipu_clk_enabled())
+	if (!ipu_clk_enabled(ctx))
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(mxcfb_info); i++) {
 		struct fb_info *fbi = mxcfb_info[i];
 		if (fbi) {
 			struct mxcfb_info *mxc_fbi = fbi->par;
-			ipu_disable_channel(mxc_fbi->ipu_ch);
-			ipu_uninit_channel(mxc_fbi->ipu_ch);
+			ipu_disable_channel(ctx, mxc_fbi->ipu_ch);
+			ipu_uninit_channel(ctx, mxc_fbi->ipu_ch);
 		}
 	}
 	for (i = 0; i < ARRAY_SIZE(stat->int_stat); i++) {
@@ -556,18 +581,22 @@ static int ipuv3_video_probe(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct ipuv3_video_priv *ipu_priv = dev_get_priv(dev);
 #if defined(CONFIG_DISPLAY)
 	struct udevice *disp_dev;
 #endif
+	struct ipu_ctx *ctx;
 	u32 fb_start, fb_end;
 	int ret;
 
 	debug("%s() plat: base 0x%lx, size 0x%x\n", __func__, plat->base,
 	      plat->size);
 
-	ret = ipu_probe();
-	if (ret)
-		return ret;
+	ctx = ipu_probe(dev);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ipu_priv->ctx = ctx;
 
 	ret = ipu_displays_init();
 	if (ret < 0)
@@ -607,10 +636,6 @@ static int ipuv3_video_probe(struct udevice *dev)
 	return 0;
 }
 
-struct ipuv3_video_priv {
-	ulong regs;
-};
-
 static int ipuv3_video_bind(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
diff --git a/include/ipu_pixfmt.h b/include/ipu_pixfmt.h
index 866ead0ec71..a485d713805 100644
--- a/include/ipu_pixfmt.h
+++ b/include/ipu_pixfmt.h
@@ -11,6 +11,7 @@
 #ifndef __IPU_PIXFMT_H__
 #define __IPU_PIXFMT_H__
 
+#include <dm/device.h>
 #include <linux/list.h>
 #include <linux/fb.h>
 
@@ -62,6 +63,6 @@
 int ipuv3_fb_init(struct fb_videomode const *mode,
 		  uint8_t disp,
 		  uint32_t pixfmt);
-void ipuv3_fb_shutdown(void);
+void ipuv3_fb_shutdown(struct udevice *dev);
 
 #endif
-- 
2.39.5

