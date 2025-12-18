Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB2ED6ACDC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 12:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BEF283DBF;
	Thu, 18 Dec 2025 13:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="VTkYHAjo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB0AB83D6C; Thu, 18 Dec 2025 09:33:39 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 969C683BA1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DydtU0y8BaqJ95MUjOSN5qvJwInSYFziyRUCv5gLb1yZm3GrH1JCwTTotfshZauKQbERTyq0PzvNO7HU5X8bSEaJ/8IiTM5BaHzt5vL2V2OuroI13JzAvOyPY6JybsFYsAo6UozNGwmeTKOdvY/aTFwkWJkI3yFAxGNIyufvE/h/ewrBQE/xFMoHabNJrbC1ztXQWY7k5zSjyIjl8o15DtiaqNg7KqWC9LBARHjwKlShZ4M2NQK7afX/BS23dr8m2r+/VMSMyGFJ6vLgTgViz0iSySHUvwS9Eq8KfEAtHJ4u2/gbhcCKoIc5fQiaeJEKMGwUlGcFybFBXgSmawEUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9USeFbDmdEe7+5BJKpIyQIK2bHmqQsW0yTOAAxaIy8=;
 b=OXXQDsKEBvyIqZVekboidkclwQhO/JSXKpwtnnzjAbbRnvSUcCp9+PN5Aa5QVbT+vTbgsjrEwcnn2OF+rYoSRBsDZB4B571bPaa9+1CPfZP1jgJ5hM9KbLTH0NgkiZKH7h2hewzg5CbrGMhlbzSoXQ4Qw6svzfvBsblzjhizsNehoBfoR2VW7qUwhpRDUT7isftu8PvwOqb+l+zUGXGyXyfLN1yLSuEWo7hJGT7C1ZghdQEka/iaYsD02SSjUSf809HkUoPsWOZVhPW/MPLxCmexfiLZcZiXpQm5GDSitteS52in0mP29Rr5vOrzuNzUCShHh5yfzdzBwQMGVJ+klQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9USeFbDmdEe7+5BJKpIyQIK2bHmqQsW0yTOAAxaIy8=;
 b=VTkYHAjoPg0BPWkCFetP7o6RIjkqeeI5rOgAK7KHkCv20kEy2ILu5oNZMHjWEwfgjAXlXGqqQ7EsnE3OJkJWdnHcO0New2zVVaAx8JA+RQUnJBDly0PkB0n7wv+kgAIE8xSwSmtRJx8hGlMmofaFl+lSC4dDTOhNUbOxnNVSnJFYM3/Nbtgif1UACaq8d0w2vtRaLzJlrJs8ngbbDjYA8ieNNpDXBz9s3M9UI1PNvGDM2tGA3oiaje7Dw443qjjzY75MjJNdoGMYxeosxgTySN7BhFt8q8XvBGXOKpXB59R15SNPHQPRkeur9c7XJ9/O7DRmft7t6LpgEcAHsHC49w==
Received: from SA9PR13CA0145.namprd13.prod.outlook.com (2603:10b6:806:27::30)
 by CH4PR22MB5718.namprd22.prod.outlook.com (2603:10b6:610:224::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 08:33:33 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::e7) by SA9PR13CA0145.outlook.office365.com
 (2603:10b6:806:27::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Thu,
 18 Dec 2025 08:33:33 +0000
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
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 08:33:33 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 26479D9C01;
 Thu, 18 Dec 2025 10:33:31 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v1 4/7] video: imx: ipuv3: fix camel cases
Date: Thu, 18 Dec 2025 10:33:23 +0200
Message-Id: <20251218083326.644326-5-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
References: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|CH4PR22MB5718:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e23703b6-aa3b-4915-662f-08de3e102189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?baRzGvRNbG0/fBjFZpdfm5crOWuQyhHURCOf75U6IHtCpGLrHMqcyi5NXfrV?=
 =?us-ascii?Q?oRZcodPakvFZkoSJ0aXPCudaknhqUovhUOwt119kvf2zd7377qJSBAD5wjia?=
 =?us-ascii?Q?SizprHYYt+rLbNmMiIDQCFGb7FQqehyezWAhzcV5oNJp6tTuDmplUqWOwzF/?=
 =?us-ascii?Q?ijUpZrk7GmsaNnCYs8qpumf4edKmnzhXcsFkDDhc8aeT5wMfg4sVdgWmOG/A?=
 =?us-ascii?Q?EiJjKXwRqJDsBkwwv9oQtYAxmXjnG6j6jptGem4tgw0/Po1kJ2RY3AavWcw1?=
 =?us-ascii?Q?zp8WPYMfbc+V4lRvdlXHroTKGL3oFkrFg9557XCUXcS+7uusES45mVBYpM0h?=
 =?us-ascii?Q?M5UoHk0oeiO0frhD2udAGmT7vyJD2OBNnBI27/EHj0+n4VIDXD3ipwoEp8H1?=
 =?us-ascii?Q?hCsCyO6NZpzE/MaNdDmImPuEpsgot9LHkqNP/NHYIUg2+nHtllegwkOe03Og?=
 =?us-ascii?Q?aK7sv0f2Z+kdgVINhpTSePu7mfa5BhwD/YLffDZ9KvLPWAkBjmWB5EuSZqrQ?=
 =?us-ascii?Q?FrSQLLp6y98H6DvI/Vvr52rCpRLc2x+BVmLIl1Bpv3fLIS2Vvlz1NXbmeRHq?=
 =?us-ascii?Q?PY4U5QKqMU3Dcp8mAQZ0Moni/Emj35IeUKIsTwJx+37xtxwaogRjnLHZl5Fe?=
 =?us-ascii?Q?M+bJDAzIAV9dpgqGoWY9H5vAAO6vjG3VqUPPtyRHmpSxpzletzIQ7JfNh1s2?=
 =?us-ascii?Q?OFgvRU+Q2IT27GJQy0U495363phJOen0S5yvcDKoNopanQXl4uYYteBKfTWO?=
 =?us-ascii?Q?nUu3/FzwClOmkftV/LVNXj4fcWAFAsQl1ZCKxewXwcjjczxrqzlS9gsdvSFU?=
 =?us-ascii?Q?OE/vuSW3JdtsBNv4GYPhzRnAbCVY/RutvqQF4AmfO95xuTBQ9Zke3yIUV2+D?=
 =?us-ascii?Q?BLID+funh7O209TJPBY8otWCq7NHkoGpO6yDkgfXd0aXDQFnHlU2sW7rZmpz?=
 =?us-ascii?Q?GpR2UO+tONyMJkXwYwsW+XGMEaGqpDFDOjOk/NP8mK0lounkdyB32UhCwQNd?=
 =?us-ascii?Q?88/Hf7I5np7DCodJwI3rXvR9UOTK+Mn258yQkO2wO7eUuavqfjD0G9Ei4mMi?=
 =?us-ascii?Q?w1+9JWq6pMiFKhl55QpwX4IxuPE06zqBe8JIJ8vWC1shZzup0TCvaTtqbZYU?=
 =?us-ascii?Q?BffrQqMTufBzHNrGP8Q5W1kwb5zCMCFSatKp4HbZN5ZhkBMn6kwqhLPgY2ID?=
 =?us-ascii?Q?a13BCEjqqMls+N9c83dZcheERWZMFmR47ZoD+Xo4COsOfPR1VCHO6iV2/iOm?=
 =?us-ascii?Q?AjsEVkjOIAd/l8mtaqHwKvtic+hlBABdPOj+gboarOyWRKYrwDVu15asi7G2?=
 =?us-ascii?Q?OWbUY2gYVhbqdsgkvxxDXUWbSHm3NrYifx5eavh9ER1Cc9x6vNDJkZXWFEyV?=
 =?us-ascii?Q?M5wde1l0/SXNirzrmbGAfb785x3XBtEh4vCwzD09gIxUh9tCEdH8gWhwpVeQ?=
 =?us-ascii?Q?M/5cPKHDH1+vnEjXuQLf40mgQ7uvvjAkBotnLRRkWnIJ8N9YTZcCuzs9R6MI?=
 =?us-ascii?Q?kAaj4sKyHE5eibEinf99ny35hqd9rogzfseE+gVlGA19R1lAWlSHp4G2QTob?=
 =?us-ascii?Q?6hoP6HbEvndMrPdhjqY=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:33:33.3725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e23703b6-aa3b-4915-662f-08de3e102189
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR22MB5718
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

U-Boot style specifies to use snake case and checkpatch nudge to check
them every time.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

 drivers/video/imx/ipu.h          | 10 +++++-----
 drivers/video/imx/ipu_common.c   | 12 ++++++------
 drivers/video/imx/ipu_disp.c     |  6 +++---
 drivers/video/imx/mxc_ipuv3_fb.c |  4 ++--
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/video/imx/ipu.h b/drivers/video/imx/ipu.h
index 83cd0d8470e..16e103cf541 100644
--- a/drivers/video/imx/ipu.h
+++ b/drivers/video/imx/ipu.h
@@ -194,11 +194,11 @@ typedef struct {
 	unsigned data_pol : 1; /* true = inverted */
 	unsigned clk_pol : 1; /* true = rising edge */
 	unsigned enable_pol : 1;
-	unsigned Hsync_pol : 1; /* true = active high */
-	unsigned Vsync_pol : 1;
+	unsigned hsync_pol : 1; /* true = active high */
+	unsigned vsync_pol : 1;
 } ipu_di_signal_cfg_t;
 
-typedef enum { RGB, YCbCr, YUV } ipu_color_space_t;
+typedef enum { RGB, YCBCR, YUV } ipu_color_space_t;
 
 /* Common IPU API */
 int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params);
@@ -211,7 +211,7 @@ int32_t ipu_init_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
 				u32 v_offset);
 
 void ipu_clear_buffer_ready(ipu_channel_t channel, ipu_buffer_t type,
-			    u32 bufNum);
+			    u32 buf_num);
 int32_t ipu_enable_channel(ipu_channel_t channel);
 int32_t ipu_disable_channel(ipu_channel_t channel);
 
@@ -224,7 +224,7 @@ int32_t ipu_init_sync_panel(int disp, u32 pixel_clk, u16 width, u16 height,
 int32_t ipu_disp_set_global_alpha(ipu_channel_t channel, unsigned char enable,
 				  u8 alpha);
 int32_t ipu_disp_set_color_key(ipu_channel_t channel, unsigned char enable,
-			       u32 colorKey);
+			       u32 color_key);
 
 u32 bytes_per_pixel(u32 fmt);
 
diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index 78bff87097e..6ce44e42349 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -273,10 +273,10 @@ static inline int ipu_is_dmfc_chan(u32 dma_chan)
 	return ((dma_chan >= 23) && (dma_chan <= 29));
 }
 
-static inline void ipu_ch_param_set_buffer(u32 ch, int bufNum,
+static inline void ipu_ch_param_set_buffer(u32 ch, int buf_num,
 					   dma_addr_t phyaddr)
 {
-	ipu_ch_param_mod_field(ipu_ch_param_addr(ch), 1, 29 * bufNum, 29,
+	ipu_ch_param_mod_field(ipu_ch_param_addr(ch), 1, 29 * buf_num, 29,
 			       phyaddr / 8);
 };
 
@@ -1075,12 +1075,12 @@ int32_t ipu_enable_channel(ipu_channel_t channel)
  *
  * @param	type		Input parameter which buffer to clear.
  *
- * @param	bufNum		Input parameter for which buffer number clear
+ * @param	buf_num		 Input parameter for which buffer number clear
  *				ready state.
  *
  */
 void ipu_clear_buffer_ready(ipu_channel_t channel, ipu_buffer_t type,
-			    u32 bufNum)
+			    u32 buf_num)
 {
 	u32 dma_ch = channel_2_dma(channel, type);
 
@@ -1088,7 +1088,7 @@ void ipu_clear_buffer_ready(ipu_channel_t channel, ipu_buffer_t type,
 		return;
 
 	__raw_writel(0xF0000000, IPU_GPR); /* write one to clear */
-	if (bufNum == 0) {
+	if (buf_num == 0) {
 		if (idma_is_set(IPU_CHA_BUF0_RDY, dma_ch)) {
 			__raw_writel(idma_mask(dma_ch),
 				     IPU_CHA_BUF0_RDY(dma_ch));
@@ -1212,7 +1212,7 @@ ipu_color_space_t format_to_colorspace(u32 fmt)
 		break;
 
 	default:
-		return YCbCr;
+		return YCBCR;
 		break;
 	}
 	return RGB;
diff --git a/drivers/video/imx/ipu_disp.c b/drivers/video/imx/ipu_disp.c
index af6daec7f64..89dead372cd 100644
--- a/drivers/video/imx/ipu_disp.c
+++ b/drivers/video/imx/ipu_disp.c
@@ -1090,9 +1090,9 @@ int32_t ipu_init_sync_panel(int disp, u32 pixel_clk, u16 width, u16 height,
 			ipu_dc_write_tmpl(7, WROD(0), 0, map, SYNC_WAVE, 0, 5);
 		}
 
-		if (sig.Hsync_pol)
+		if (sig.hsync_pol)
 			di_gen |= DI_GEN_POLARITY_2;
-		if (sig.Vsync_pol)
+		if (sig.vsync_pol)
 			di_gen |= DI_GEN_POLARITY_3;
 
 		if (!sig.clk_pol)
@@ -1181,7 +1181,7 @@ int32_t ipu_disp_set_global_alpha(ipu_channel_t channel, unsigned char enable,
  *
  * @param	enable		Boolean to enable or disable color key
  *
- * @param	colorKey	24-bit RGB color for transparent color key.
+ * @param	color_key	 24-bit RGB color for transparent color key.
  *
  * Return:	Returns 0 on success or negative error code on fail
  */
diff --git a/drivers/video/imx/mxc_ipuv3_fb.c b/drivers/video/imx/mxc_ipuv3_fb.c
index 6c271490ba1..fb9d364d23a 100644
--- a/drivers/video/imx/mxc_ipuv3_fb.c
+++ b/drivers/video/imx/mxc_ipuv3_fb.c
@@ -211,9 +211,9 @@ static int mxcfb_set_par(struct fb_info *fbi)
 	if ((fbi->var.sync & FB_SYNC_EXT) || ext_clk_used)
 		sig_cfg.ext_clk = 1;
 	if (fbi->var.sync & FB_SYNC_HOR_HIGH_ACT)
-		sig_cfg.Hsync_pol = 1;
+		sig_cfg.hsync_pol = 1;
 	if (fbi->var.sync & FB_SYNC_VERT_HIGH_ACT)
-		sig_cfg.Vsync_pol = 1;
+		sig_cfg.vsync_pol = 1;
 	if (!(fbi->var.sync & FB_SYNC_CLK_LAT_FALL))
 		sig_cfg.clk_pol = 1;
 	if (fbi->var.sync & FB_SYNC_DATA_INVERT)
-- 
2.39.5

