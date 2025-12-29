Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCD3D3B7E5
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 12:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01F6D83DEC;
	Mon, 29 Dec 2025 13:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="LXUrHQpi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A1B8838FA; Mon, 29 Dec 2025 11:48:59 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E27BB83DA7
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 11:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7R3OIYP10Kar1TYTWk8NRqqelrW6/1qRm9/KlsO5r73RdkmstRNZMQ+n2A+7lClpTcd9tEddhG6uFjWvLO26va9B16cn+aA9c2u5zCzAbiKMSXXHDxQuornnECe82f2kMrDNeW5/3e/wpzg1st4pxa1Ia+AqlmV5C3eRuoOBl2iTIYouAvpeG/rq1371EJuh81juwnpbYDS/TddP+fT/8rc85r8jjqLnS7aF2oefN7ZRSfBMYiEg4wyVI7hOZCkftSYi6qbp4Z9lEu/9xbN/2Ypc8+2IOngN7yAbcmjQMbwK4MLY3hdMqZf4fZ48Gk/cOR3DUe/iuZ0/nIcnHMOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNA2AAtw76lJKvPuisVlvmceGhTCkPS3nezhduK3dew=;
 b=Qv3TvaDs/MJgF5PApoCNUK4K6lAyQxvYEGcIZaBYYiBSiRjovoA6eNUy4g8NNtfLHjPv8ltgKOjlwCWWNvDXS3tW944wzYIiSN66LbDteH/dV7rIsyarucqmwK1oBM+3M7SIgadmCQNu9lwBINXqUI/cixBVzFAB2CWKcuzFAq4Ps34xXIhiGQtO08X2CMjsPsHcOneX72GqZiAs45eaebaJvKKw9qJxphTuuvv7GKyqcz+Vwd22MfZfAMMCqX/0IgBCc8ITvkZbhhdse3T4xrjmpk8ZUazA7epMYKoDlC5mOKf86VWDXV8WlEJUBQFZB0QUWq0pZlP2ykyWz8t0Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNA2AAtw76lJKvPuisVlvmceGhTCkPS3nezhduK3dew=;
 b=LXUrHQpiSMe76yMNZSZqPxU3KS6hwcNrKzZTErord5QWEd6xc4cq0uFeLspYt3CaKWLF9gTgCrgdPhgcGUNsJfMGS7+M6iZVOJM2YYs0lbBNHl3NH4IBua6HvlljpdEYpcUF2Ji9UGEuuEeGYyu+haFl16wNNucoxYlFmAFla0dzquOYv9sIK4rG0lryJWXC6xZOIJ40SWlR3H4xEByygRWO0VmJcnl9x0CUOBXtegix+rzOIusGZaVmJWqe9RVh6YH/ocIA3VKOvUrCETNTj5Z2QAhrHV/UcUMhjsV78hxHAh8ypkn53cRbFGhwntFAM8vEbc0P1hqbi3HALF88yw==
Received: from PH7P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::24)
 by LV8PR22MB5045.namprd22.prod.outlook.com (2603:10b6:408:1cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Mon, 29 Dec
 2025 10:48:52 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::c9) by PH7P220CA0040.outlook.office365.com
 (2603:10b6:510:32b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 10:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 10:48:51 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 659E0DBCE0;
 Mon, 29 Dec 2025 12:48:49 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v2 4/7] video: imx: ipuv3: fix camel cases
Date: Mon, 29 Dec 2025 12:48:04 +0200
Message-Id: <20251229104807.3104-5-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251229104807.3104-1-brian.ruley@gehealthcare.com>
References: <"CAOMZO5DOUE2PexcBcVcg3vYTo5eV=LT3=S9cSBosLCyir8Kw5g@mail.gmail.com">
 <20251229104807.3104-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|LV8PR22MB5045:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c762432f-e8c8-4379-6c20-08de46c7dadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZXNZAXV/LItEB6lWNgg3gmf1sVeJRAz7jTUQ4ptjHdMNAr4tXQnNBSs2PKF4?=
 =?us-ascii?Q?frjQFppsVtwou4cBOLSV48I5h6nyE5GZ3eJpXatusMPfCR6lvToDnHcWb4gY?=
 =?us-ascii?Q?6io3NMyWHBtLDOoI9Baa6YpmuIl29kMnINlEM+AqJ6mJQX2LnON1nKbeboeL?=
 =?us-ascii?Q?BK86J2SJUo8jrWFVeCBdT408gOYpn7ju5Ak/tTR/H1IV/O6Q7qgElUOqau5P?=
 =?us-ascii?Q?dsu5DtNsQHowBp3yXrb4t+CXbj43f6tS4yOMReXNyy0JMy5ybDntsirMb4Le?=
 =?us-ascii?Q?lgTnxkHkvSR52NBHvdxxUurTAooIqPPcFbYU3nEFjeGbyGKxNCemzeYDk/S2?=
 =?us-ascii?Q?eehZekQ9U3bdpmaZ01kYwyRzopYzupunaU+AiXL2ghK/k1fAyCnh4UmTk9qs?=
 =?us-ascii?Q?h7SCxughTn0wbiESkVSOl36b2TT9YycOHa+e4mAwfv9uDv06zBQC9HFHihb3?=
 =?us-ascii?Q?N9FcCHbQxEix1rK/nplD3VToRdHKhVRxquxpNmSM19MFeMeiHMzZi3q17yHx?=
 =?us-ascii?Q?gVe8puBs4+Rwlw4Ef6566TnzpccMeyiZ8BIdR9VgEPoAL0S1mEow5M/Ln+t7?=
 =?us-ascii?Q?eMxpTUnV/6Nhq6KisJXvS+mOcD1MG+hMevIYywNwXDsyQLwSPENiDDItGFb7?=
 =?us-ascii?Q?LdiBAm8uvkbivlwmrdJJ7a+WtM7fBLyc1IfPSM5UTv1lJvRdKIowyHraJ/fr?=
 =?us-ascii?Q?jXadWB2pVgmOuS4wERaUSQxc5rnOr2zHgpFT+kEtPZ/jB/sMU0Jc1bfGWJfm?=
 =?us-ascii?Q?WdjKEGU87CAiyC7zCu7nAobI3c8pa/5FYo081ucPUPPKqt5fa56x0q2AYG99?=
 =?us-ascii?Q?5cxxZe4YKagAer7Z+EZ8IYG6xjmJUfXYfK6kXy0m89/zsjEtWZZeYbK/u5jB?=
 =?us-ascii?Q?JqzGqZN74DMUoVE92SpUlCnGxpa11p1BZ9kVyiCZRTByBhldyuxUoF91fbOB?=
 =?us-ascii?Q?DN8PLbmQ1F4FSB773OEeOuiICjwMsNk546MBQNYa8gOQv/lRjSK/GQ71U+Y/?=
 =?us-ascii?Q?DTsCL0q7bQgh8uW6H+PmyQy8Im/kTeKxcACwTYDVQnNBg1oc4+t8WVfl+8PS?=
 =?us-ascii?Q?5LHIUtCK9jvbPNaNPUF9sko6ahxEZrti4RbAizFKkGvbqzmlhgPEjKnNJ87R?=
 =?us-ascii?Q?fr4+e3spF8FqY71LWh6TIoCQSAYL4v87k9dvf7rG2qlzTaJkNAbkboJ45fga?=
 =?us-ascii?Q?VEMs4o68DM4hZmWTNdgLI5Y4mJtHL0BkTSg5yDUoSF0bEvC8pgGLQDL8UG7v?=
 =?us-ascii?Q?L3ZgbTFG7HntgU3KW3TcLeCqHbLVnBQQa8xPOQ7/nlH9JwuIBMPPevDpvuUb?=
 =?us-ascii?Q?arVsb3qOdkVRHaCh2KiL4YykE+lkLpAl9TDIOKC5yoS8IlgAwW2PVsyk2Paj?=
 =?us-ascii?Q?NxlR/EqrqMM6U57McJczQHjl66HU7pLDqi1hlJSqMna1aHaKd73Lcu5uH2mz?=
 =?us-ascii?Q?I8/OZ3TwrconnkXMTmrK/V3z/UaB7lWrxHoWB/nzchj4hC1UlpiaBzkGKqyt?=
 =?us-ascii?Q?H2XD4qn5Btcwt5jrhr9nlJyaA9HBxaBmdqqEMmul4NK+qz9EE21K8C0B3Buq?=
 =?us-ascii?Q?2vd5wfoXQaFBdSF62iw=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 10:48:51.5244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c762432f-e8c8-4379-6c20-08de46c7dadb
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5045
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

U-Boot style specifies to use snake case and checkpatch nudge to check
them every time.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

(no changes since v1)

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

