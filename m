Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5793CCA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 13:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A811182C84;
	Tue, 12 Aug 2025 15:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="wjTptqlC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A4E983321; Tue, 12 Aug 2025 15:57:00 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3563182BA7
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 15:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=03194c3c15=christophe.kerello@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDjM6f014773;
 Tue, 12 Aug 2025 15:56:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=mPn7csvi5NJImZ2F0j2HDy
 Xo0kBRjq8kOg22l6hbHW4=; b=wjTptqlCyP2hyEG+F6MWWope3Ki2eBWrTSbEpd
 0hTYsGiMrtG8Papm5ahlsaYDkHOA8Hc03Mq7cReq3eER7uaEqWgqIpF7b2Oo3AOX
 xtYNK6L1aZ2jLlPjZjixbVa9thBeE/Nx0dvrLIJuMKI5pHv/fxpYxdn7OQKeIFXz
 pnBIwDAHojroNAP/apswP5DjiWP5BjYfnRyoVY2h545HCcDkKMzxzC+m43PSao25
 uExconrgK8yxuhASFADTdmyHEdYRXxaOyYIhS7gkwEgIll/ZZiX36KvAmsBhJ/lD
 6ai6/u6WV4OY7OgWV2L9O8efropYWbB/QnMhWyrKNURDdRXg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48efw4rr00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Aug 2025 15:56:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D034040051;
 Tue, 12 Aug 2025 15:56:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A18CC78C476;
 Tue, 12 Aug 2025 15:55:40 +0200 (CEST)
Received: from localhost (10.48.87.65) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 15:55:40 +0200
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice CHOTARD
 <patrice.chotard@foss.st.com>, Christophe Kerello
 <christophe.kerello@foss.st.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mmc: stm32_sdmmc2: avoid infinite while loop
Date: Tue, 12 Aug 2025 15:55:26 +0200
Message-ID: <20250812135526.268574-1-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.65]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
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

Avoid unlimited while loop by adding a timeout. The timeout is
calculated based on a minimal throughput of 256 KB/s.
The timeout is set at least to 2 seconds.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---

 drivers/mmc/stm32_sdmmc2.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/stm32_sdmmc2.c b/drivers/mmc/stm32_sdmmc2.c
index 9483fb57daf..122690aef3e 100644
--- a/drivers/mmc/stm32_sdmmc2.c
+++ b/drivers/mmc/stm32_sdmmc2.c
@@ -385,15 +385,29 @@ static int stm32_sdmmc2_end_data(struct udevice *dev,
 	u32 mask = SDMMC_STA_DCRCFAIL | SDMMC_STA_DTIMEOUT |
 		   SDMMC_STA_IDMATE | SDMMC_STA_DATAEND;
 	u32 status;
+	unsigned long timeout_msecs = ctx->data_length >> 8;
+	unsigned long start_timeout;
+
+	/* At least, a timeout of 2 seconds is set */
+	if (timeout_msecs < 2000)
+		timeout_msecs = 2000;
 
 	if (data->flags & MMC_DATA_READ)
 		mask |= SDMMC_STA_RXOVERR;
 	else
 		mask |= SDMMC_STA_TXUNDERR;
 
+	start_timeout = get_timer(0);
 	status = readl(plat->base + SDMMC_STA);
-	while (!(status & mask))
+	while (!(status & mask)) {
+		if (get_timer(start_timeout) > timeout_msecs) {
+			ctx->dpsm_abort = true;
+			return -ETIMEDOUT;
+		}
+
+		schedule();
 		status = readl(plat->base + SDMMC_STA);
+	}
 
 	/*
 	 * Need invalidate the dcache again to avoid any
-- 
2.25.1

base-commit: d1d54857dc618f8c080dbb87de5218e6c330b0d4
branch: SDMMC-avoid-infinite-loop
