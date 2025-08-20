Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EDBCA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 17:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14EF8830F6;
	Wed, 20 Aug 2025 19:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZPWFVMD9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73B0782B07; Wed, 20 Aug 2025 18:20:25 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 876D68006D
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 18:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=03278829c7=raphael.gallais-pou@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KFbNxx030449;
 Wed, 20 Aug 2025 18:20:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 okok4HqrJ8mkJ8BiLV7B4uO0WzvLZbZm8GZmc8peOqs=; b=ZPWFVMD9RuxoilFL
 GISuH0ZnqmwzQpWKBlJ+cRtELz6qRmjig6oXtRzapgLYwd8cUaM7G2KlY3IDLDtL
 kH2uefEBMs1TUbu534vPQkWcaKhkbVwHHkFwYfk+FAf4KQBwCmHzleOVLnidWepY
 hCv5tU6AG28dGVa+g+x+e8Sms7ZJ/si2KUoy27CDXNNbmjH5nthWA9eQQPATD0Di
 iVkr9vlpwQDFmqCAPF1jfeTAvui0l3iIAPEkFtf7KvsYCq7CTNtnMz7Hv4F4H9Xz
 8dMcNd+c1RkJunoFds/f446BosSQlkehjZi40/PrYtWnnrasybOcNwcMpY5kKvZO
 6SPKyg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n81wjjuc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 18:20:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 10FB74002D;
 Wed, 20 Aug 2025 18:19:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7D6E772B816;
 Wed, 20 Aug 2025 18:18:57 +0200 (CEST)
Received: from localhost (10.252.7.99) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 18:18:57 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Wed, 20 Aug 2025 18:17:41 +0200
Subject: [PATCH 2/8] video: simple_panel: add support for "panel-lvds" display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250820-master-v1-2-fc76f18ab2fd@foss.st.com>
References: <20250820-master-v1-0-fc76f18ab2fd@foss.st.com>
In-Reply-To: <20250820-master-v1-0-fc76f18ab2fd@foss.st.com>
To: Tom Rini <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Dillon Min
 <dillon.minfei@gmail.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
X-Mailer: b4 0.14.2
X-Originating-IP: [10.252.7.99]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Mailman-Approved-At: Wed, 20 Aug 2025 19:14:09 +0200
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

Add the compatible "panel-lvds" for simple-panel driver in U-Boot.  In
Linux this compatible is managed by the driver
drivers/gpu/drm/panel/panel-lvds.c but in U-Boot the specific LVDS
features (bus_format/bus_flags) are not supported.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 drivers/video/simple_panel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
index b6c5b058b2e967bbbd47ab3c3ce5ca52c7804409..0f23df701bc3c40ea49380bbfa3743ee592d8bd3 100644
--- a/drivers/video/simple_panel.c
+++ b/drivers/video/simple_panel.c
@@ -191,6 +191,7 @@ static const struct mipi_dsi_panel_plat panasonic_vvx10f004b00 = {
 
 static const struct udevice_id simple_panel_ids[] = {
 	{ .compatible = "simple-panel" },
+	{ .compatible = "panel-lvds" },
 	{ .compatible = "auo,b133xtn01" },
 	{ .compatible = "auo,b116xw03" },
 	{ .compatible = "auo,b133htn01" },

-- 
2.25.1

