Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F81CA1009
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 12:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92ECE83B03;
	Wed,  3 Sep 2025 14:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="bs/0MRsA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22F1083AE6; Wed,  3 Sep 2025 14:27:30 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 258C483AEF
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 14:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1341feccc4=raphael.gallais-pou@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583CGu9v020606;
 Wed, 3 Sep 2025 14:27:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 c82J73xY8kYgtJWzenvUNgtP0vMKckOsLNnvgoY5LHU=; b=bs/0MRsArOEZMmzY
 a3lM37iYwGj3bmU1GtO3Ss0Cl2iKWpnp87ed9kVQtK2wrVKF2DqdbsbmTEOj7+g4
 I66PoWz1mxpEtZI73XMzKXzNrhUwZAqTs4XzfqIFHY/ZEGU0H61XQWrLLYinAMGA
 e6qDHoejq5HceWM9oM2EPciAzG6+/wTDBUi5J2rNbFHaXECstpKTa87bNCA5FIAi
 7g/WVCEVOlq98zKkTelotHjbAryhyNQskMqAVD1sI3VEn8mzzZQmN1kwI9l/xUFY
 LPQyEDp8f8SEBe/ONz77rbRCVRuPfrglrpIJDAku5eG8wOOirKw0hL3fmhTVhLnX
 pS1NcQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48vav2ppav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 14:27:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 99A354002D;
 Wed,  3 Sep 2025 14:26:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 84E1E39C6F9;
 Wed,  3 Sep 2025 14:25:41 +0200 (CEST)
Received: from localhost (10.130.74.180) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 3 Sep
 2025 14:25:41 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Wed, 3 Sep 2025 14:25:38 +0200
Subject: [PATCH v2 4/7] video: stm32: ltdc: support new hardware version
 for STM32MP25 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250903-master-v2-4-5cdf73bff42c@foss.st.com>
References: <20250903-master-v2-0-5cdf73bff42c@foss.st.com>
In-Reply-To: <20250903-master-v2-0-5cdf73bff42c@foss.st.com>
To: Tom Rini <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Dillon Min
 <dillon.minfei@gmail.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
X-Mailer: b4 0.14.2
X-Originating-IP: [10.130.74.180]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
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

STM32MP2 SoCs feature a new version of the LTDC IP.  This new version
features a bus clock, as well as a 150MHz pad frequency.  Add its
compatible to the list of device to probe and handle quirks.  The new
hardware version features a bus clock.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 drivers/video/stm32/stm32_ltdc.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
index 0a062c8939dbe49b11aa50f5ca9701bdbe5c5b0b..efe9a00996eca0301d2a2b82074ba9690a967a73 100644
--- a/drivers/video/stm32/stm32_ltdc.c
+++ b/drivers/video/stm32/stm32_ltdc.c
@@ -262,6 +262,7 @@ static const u32 layer_regs_a2[] = {
 #define HWVER_10300 0x010300
 #define HWVER_20101 0x020101
 #define HWVER_40100 0x040100
+#define HWVER_40101 0x040101
 
 enum stm32_ltdc_pix_fmt {
 	PF_ARGB8888 = 0,	/* ARGB [32 bits] */
@@ -529,7 +530,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
 	struct udevice *bridge = NULL;
 	struct udevice *panel = NULL;
 	struct display_timing timings;
-	struct clk pclk;
+	struct clk pclk, bclk;
 	struct reset_ctl rst;
 	ulong rate;
 	int ret;
@@ -540,7 +541,21 @@ static int stm32_ltdc_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	ret = clk_get_by_index(dev, 0, &pclk);
+	ret = clk_get_by_name(dev, "bus", &bclk);
+	if (ret) {
+		if (ret != -ENODATA) {
+			dev_err(dev, "bus clock get error %d\n", ret);
+			return ret;
+		}
+	} else {
+		ret = clk_enable(&bclk);
+		if (ret) {
+			dev_err(dev, "bus clock enable error %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = clk_get_by_name(dev, "lcd", &pclk);
 	if (ret) {
 		dev_err(dev, "peripheral clock get error %d\n", ret);
 		return ret;
@@ -566,6 +581,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
 		priv->pix_fmt_hw = pix_fmt_a1;
 		break;
 	case HWVER_40100:
+	case HWVER_40101:
 		priv->layer_regs = layer_regs_a2;
 		priv->pix_fmt_hw = pix_fmt_a2;
 		break;
@@ -688,6 +704,8 @@ static int stm32_ltdc_bind(struct udevice *dev)
 
 static const struct udevice_id stm32_ltdc_ids[] = {
 	{ .compatible = "st,stm32-ltdc" },
+	{ .compatible = "st,stm32mp251-ltdc" },
+	{ .compatible = "st,stm32mp255-ltdc" },
 	{ }
 };
 

-- 
2.25.1

