Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCBECCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 10:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2550583759;
	Mon,  6 Oct 2025 12:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IMnCZNBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C51EF835D0; Mon,  6 Oct 2025 12:11:17 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A6B836CE
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 12:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 596ABC5u3526642;
 Mon, 6 Oct 2025 05:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759745472;
 bh=/CpcEN18W1bI040vFodiXEDL4duBMIUwIc3CZO3Lfhk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=IMnCZNBTOx447CupJnlOSyue2lgKuYekIYDCdRa37mUt0q9Fso9FS+V0oKxVg0wnt
 G+x1pWe5EWEtbjn0SWZLjxrcs+Whyx8s9pHnT9S0HNZ3EA0nToyxpjNcmQaSH+Lk/f
 Ba9m3TYsPY4zyVaq++FaXvqwl8aXAIzSCmeOGxyk=
Received: from DLEE203.ent.ti.com (dlee203.ent.ti.com [157.170.170.78])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 596ABCGb4044754
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Oct 2025 05:11:12 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Oct
 2025 05:11:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 05:11:11 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 596ABArq3511822;
 Mon, 6 Oct 2025 05:11:11 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH -next v3 6/7] spl: nand: refactor spl_nand_load_image for
 falcon mode
Date: Mon, 6 Oct 2025 15:40:54 +0530
Message-ID: <20251006101057.4172248-7-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006101057.4172248-1-anshuld@ti.com>
References: <20251006101057.4172248-1-anshuld@ti.com>
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
 common/spl/spl_nand.c | 95 +++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 43 deletions(-)

diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 22883f4e8b9..f37baefb372 100644
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
@@ -89,51 +135,14 @@ static int spl_nand_load_image(struct spl_image_info *spl_image,
 
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
-		} else {
-			puts("The Expected Linux image was not "
-				"found. Please check your NAND "
-				"configuration.\n");
-			puts("Trying to start u-boot now...\n");
-		}
+		err = spl_nand_load_image_os(spl_image, bootdev);
+		if (!err)
+			return 0;
+		printf("%s: Failed in falcon boot: %d, fallback to U-Boot",
+		       __func__, err);
 	}
 #endif
+
 #ifdef CONFIG_NAND_ENV_DST
 	spl_nand_load_element(spl_image, bootdev, CONFIG_ENV_OFFSET);
 #ifdef CONFIG_ENV_OFFSET_REDUND
-- 
2.51.0

