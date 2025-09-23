Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7765CCAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 13:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 680788361E;
	Tue, 23 Sep 2025 15:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vo28rWAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6889A833E9; Tue, 23 Sep 2025 15:09:24 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D152835EA
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 15:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ND9Hl61456298;
 Tue, 23 Sep 2025 08:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758632957;
 bh=m8WUV2E32ap05+i67YIlXKV0OKdJuMe0dGo7HECeMos=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=vo28rWARXkB54O12ovcjuvjyxUg+XFE3CRqGS/29Yv0QTuhdkhrtcL62P1ouUozhv
 IEB86RWRFyI1YVlUauSzYzLHyoqoIwgTWKp0FTq/Kcrsy7brFmeMUjzgwn4mwk+v2o
 Tm3HRFLINcgQRP1XQXv677qTBUjgO2Pl4cjrbQp4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ND9Hpf1992897
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 23 Sep 2025 08:09:17 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 08:09:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 08:09:16 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ND9FPH083835;
 Tue, 23 Sep 2025 08:09:16 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 7/8] spl: nand: refactor spl_nand_load_image for falcon mode
Date: Tue, 23 Sep 2025 18:38:59 +0530
Message-ID: <20250923130901.705124-8-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923130901.705124-1-anshuld@ti.com>
References: <20250923130901.705124-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

This patch moves the falcon mode handling logic out of
spl_ubi_load_image to spl_ubi_load_image_os, this allows for cleaner
handling for fallback to U-Boot in case falcon mode fails.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_nand.c | 87 +++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 37 deletions(-)

diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 22883f4e8b9..8993e304c26 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -75,6 +75,52 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 	return spl_load(spl_image, bootdev, &load, 0, offset);
 }
 
+#if CONFIG_IS_ENABLED(OS_BOOT)
+static int spl_nand_load_image_os(struct spl_image_info *spl_image,
+				  struct spl_boot_device *bootdev)
+{
+	int *src, *dst, err;
+	struct legacy_img_hdr *header = spl_get_load_buffer(0, sizeof(*header));
+
+	/* load linux */
+	nand_spl_load_image(CONFIG_SYS_NAND_SPL_KERNEL_OFFS, sizeof(*header),
+			    (void *)header);
+	err = spl_parse_image_header(spl_image, bootdev, header);
+	if (err)
+		return err;
+
+	if (header->ih_os != IH_OS_LINUX)
+		return -EINVAL;
+
+	/* happy - was a linux */
+	err = nand_spl_load_image(CONFIG_SYS_NAND_SPL_KERNEL_OFFS,
+				  spl_image->size,
+				  (void *)spl_image->load_addr);
+	nand_deselect();
+
+	if (err)
+		return err;
+
+	/*
+	 * load parameter image load to temp position since nand_spl_load_image
+	 * reads a whole block which is typically larger than
+	 * CONFIG_CMD_SPL_WRITE_SIZE therefore may overwrite following sections
+	 * like BSS
+	 */
+	nand_spl_load_image(CONFIG_CMD_SPL_NAND_OFS, CONFIG_CMD_SPL_WRITE_SIZE,
+			    (void *)CONFIG_TEXT_BASE);
+	/* copy to destintion */
+	for (dst = (int *)CONFIG_SPL_PAYLOAD_ARGS_ADDR,
+	    src = (int *)CONFIG_TEXT_BASE;
+	     src < (int *)(CONFIG_TEXT_BASE + CONFIG_CMD_SPL_WRITE_SIZE);
+	     src++, dst++) {
+		writel(readl(src), dst);
+	}
+
+	return 0;
+}
+#endif
+
 static int spl_nand_load_image(struct spl_image_info *spl_image,
 			       struct spl_boot_device *bootdev)
 {
@@ -89,43 +135,9 @@ static int spl_nand_load_image(struct spl_image_info *spl_image,
 
 #if CONFIG_IS_ENABLED(OS_BOOT)
 	if (!spl_start_uboot()) {
-		int *src, *dst;
-		struct legacy_img_hdr *header =
-			spl_get_load_buffer(0, sizeof(*header));
-
-		/*
-		 * load parameter image
-		 * load to temp position since nand_spl_load_image reads
-		 * a whole block which is typically larger than
-		 * CONFIG_CMD_SPL_WRITE_SIZE therefore may overwrite
-		 * following sections like BSS
-		 */
-		nand_spl_load_image(CONFIG_CMD_SPL_NAND_OFS,
-			CONFIG_CMD_SPL_WRITE_SIZE,
-			(void *)CONFIG_TEXT_BASE);
-		/* copy to destintion */
-		for (dst = (int *)CONFIG_SPL_PAYLOAD_ARGS_ADDR,
-		     src = (int *)CONFIG_TEXT_BASE;
-			src < (int *)(CONFIG_TEXT_BASE +
-				      CONFIG_CMD_SPL_WRITE_SIZE);
-		     src++, dst++) {
-			writel(readl(src), dst);
-		}
-
-		/* load linux */
-		nand_spl_load_image(CONFIG_SYS_NAND_SPL_KERNEL_OFFS,
-			sizeof(*header), (void *)header);
-		err = spl_parse_image_header(spl_image, bootdev, header);
-		if (err)
-			return err;
-		if (header->ih_os == IH_OS_LINUX) {
-			/* happy - was a linux */
-			err = nand_spl_load_image(
-				CONFIG_SYS_NAND_SPL_KERNEL_OFFS,
-				spl_image->size,
-				(void *)spl_image->load_addr);
-			nand_deselect();
-			return err;
+		err = spl_nand_load_image_os(spl_image, bootdev);
+		if (!err)
+			return 0;
 		} else {
 			puts("The Expected Linux image was not "
 				"found. Please check your NAND "
@@ -134,6 +146,7 @@ static int spl_nand_load_image(struct spl_image_info *spl_image,
 		}
 	}
 #endif
+
 #ifdef CONFIG_NAND_ENV_DST
 	spl_nand_load_element(spl_image, bootdev, CONFIG_ENV_OFFSET);
 #ifdef CONFIG_ENV_OFFSET_REDUND
-- 
2.51.0

