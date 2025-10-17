Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F88CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 19:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3EA2838CC;
	Fri, 17 Oct 2025 21:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WFHWNv3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A68A838C8; Fri, 17 Oct 2025 21:33:36 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4996B838BB
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 21:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59HJXUBm2345191;
 Fri, 17 Oct 2025 14:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760729610;
 bh=mpA2X8+ftXBfvaKQS3ZnDPOaIT4AuRaYJRN8Pwch2iA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=WFHWNv3jP9Z8NzMqc5T3PbSqQCJegate7hrCow485GeLqVBl0b3iHWc20gojmnmYL
 jSIH3Dtt66dyLBgV6IFrjXhZZRlTmhVSszxqOffOTh1APvdEIWYA05BHhOM86R+/QH
 99pvB0X1DtZdBllA2KjMrOl0R4huq7k+MzibFjD4=
Received: from DLEE204.ent.ti.com (dlee204.ent.ti.com [157.170.170.84])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59HJXUqe2644585
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Oct 2025 14:33:30 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 14:33:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 14:33:30 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59HJXTYQ1801647;
 Fri, 17 Oct 2025 14:33:29 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v4 5/7] spl: nor: refactor spl_nor_load_image for falcon mode
Date: Sat, 18 Oct 2025 01:03:10 +0530
Message-ID: <20251017193318.4124997-6-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017193318.4124997-1-anshuld@ti.com>
References: <20251017193318.4124997-1-anshuld@ti.com>
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
spl_nor_load_image to spl_nor_load_image_os, this allows for cleaner
handling for fallback to U-Boot in case falcon mode fails.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_nor.c | 103 ++++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index 1021d933999..c349a4c7bc3 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -25,66 +25,79 @@ unsigned long __weak spl_nor_get_uboot_base(void)
 	return CFG_SYS_UBOOT_BASE;
 }
 
-static int spl_nor_load_image(struct spl_image_info *spl_image,
-			      struct spl_boot_device *bootdev)
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT)
+static int spl_nor_load_image_os(struct spl_image_info *spl_image,
+				 struct spl_boot_device *bootdev)
 {
-	struct spl_load_info load;
-
 	/*
-	 * Loading of the payload to SDRAM is done with skipping of
-	 * the mkimage header in this SPL NOR driver
+	 * Load Linux from its location in NOR flash to its defined
+	 * location in SDRAM
 	 */
-	spl_image->flags |= SPL_COPY_PAYLOAD_ONLY;
+	const struct legacy_img_hdr *header =
+		(const struct legacy_img_hdr *)CONFIG_SYS_OS_BASE;
+	struct spl_load_info load;
 
-#if CONFIG_IS_ENABLED(OS_BOOT)
-	if (!spl_start_uboot()) {
-		/*
-		 * Load Linux from its location in NOR flash to its defined
-		 * location in SDRAM
-		 */
-		const struct legacy_img_hdr *header =
-			(const struct legacy_img_hdr *)CONFIG_SYS_OS_BASE;
 #ifdef CONFIG_SPL_LOAD_FIT
-		if (image_get_magic(header) == FDT_MAGIC) {
-			int ret;
+	if (image_get_magic(header) == FDT_MAGIC) {
+		int ret;
 
-			debug("Found FIT\n");
-			spl_load_init(&load, spl_nor_load_read, NULL, 1);
+		debug("Found FIT\n");
+		spl_load_init(&load, spl_nor_load_read, NULL, 1);
 
-			ret = spl_load_simple_fit(spl_image, &load,
-						  CONFIG_SYS_OS_BASE,
-						  (void *)header);
+		ret = spl_load_simple_fit(spl_image, &load, CONFIG_SYS_OS_BASE,
+					  (void *)header);
 
 #if defined CONFIG_SPL_PAYLOAD_ARGS_ADDR && defined CONFIG_CMD_SPL_NOR_OFS
-			memcpy((void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR,
-			       (void *)CONFIG_CMD_SPL_NOR_OFS,
-			       CONFIG_CMD_SPL_WRITE_SIZE);
+		memcpy((void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR,
+		       (void *)CONFIG_CMD_SPL_NOR_OFS,
+		       CONFIG_CMD_SPL_WRITE_SIZE);
 #endif
-			return ret;
-		}
+		return ret;
+	}
 #endif
-		if (image_get_os(header) == IH_OS_LINUX) {
-			/* happy - was a Linux */
-			int ret;
-
-			ret = spl_parse_image_header(spl_image, bootdev, header);
-			if (ret)
-				return ret;
-
-			memcpy((void *)spl_image->load_addr,
-			       (void *)(CONFIG_SYS_OS_BASE +
-					sizeof(struct legacy_img_hdr)),
-			       spl_image->size);
+	if (image_get_os(header) != IH_OS_LINUX)
+		return -EINVAL;
+
+	/* happy - was a Linux */
+	int ret;
+
+	ret = spl_parse_image_header(spl_image, bootdev, header);
+	if (ret)
+		return ret;
+
+	memcpy((void *)spl_image->load_addr,
+	       (void *)(CONFIG_SYS_OS_BASE + sizeof(struct legacy_img_hdr)),
+	       spl_image->size);
+
 #ifdef CONFIG_SPL_PAYLOAD_ARGS_ADDR
-			spl_image->arg = (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR;
+	spl_image->arg = (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR;
 #endif
 
+	return 0;
+}
+#endif
+
+static int spl_nor_load_image(struct spl_image_info *spl_image,
+			      struct spl_boot_device *bootdev)
+{
+	struct spl_load_info load;
+
+	/*
+	 * Loading of the payload to SDRAM is done with skipping of
+	 * the mkimage header in this SPL NOR driver
+	 */
+	spl_image->flags |= SPL_COPY_PAYLOAD_ONLY;
+
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT)
+	int err;
+
+	if (!spl_start_uboot()) {
+		err = spl_nor_load_image_os(spl_image, bootdev);
+		if (!err)
 			return 0;
-		} else {
-			puts("The Expected Linux image was not found.\n"
-			     "Please check your NOR configuration.\n"
-			     "Trying to start u-boot now...\n");
-		}
+
+		printf("%s: Failed in falcon boot: %d, fallback to U-Boot",
+		       __func__, err);
 	}
 #endif
 
-- 
2.51.0

