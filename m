Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792B8CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 13:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F46D835EA;
	Tue, 23 Sep 2025 15:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="okslbiLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4636835FE; Tue, 23 Sep 2025 15:09:21 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7883683510
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 15:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ND9FKO994181;
 Tue, 23 Sep 2025 08:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758632955;
 bh=54Xv3Kt72zRNuBYyuoDa0XoQkyHdP4vPkBAoNYOAsyo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=okslbiLhnLJa7O0rsupqYiWjp2u4AXd6uRfpqFSEvliORLqIib1WlmBQX/b2nwSC3
 nwb9i4qrVYBHz7REG9jAdEZ7gAIArGCFzHHfAqO1GNxV0lRjMLqHm4O2LmGvwZzw1U
 XNUpdjzKdwhz9rgkQQ/AoPftUVOvHVxPQPguXQAI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ND9Fkc1992887
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 23 Sep 2025 08:09:15 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 08:09:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 08:09:15 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ND9D9F083821;
 Tue, 23 Sep 2025 08:09:14 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 6/8] spl: nor: refactor spl_nor_load_image for falcon mode
Date: Tue, 23 Sep 2025 18:38:58 +0530
Message-ID: <20250923130901.705124-7-anshuld@ti.com>
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
spl_nor_load_image to spl_nor_load_image_os, this allows for cleaner
handling for fallback to U-Boot in case falcon mode fails.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_nor.c | 94 +++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index 1021d933999..e999dcc4fcf 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -25,60 +25,74 @@ unsigned long __weak spl_nor_get_uboot_base(void)
 	return CFG_SYS_UBOOT_BASE;
 }
 
-static int spl_nor_load_image(struct spl_image_info *spl_image,
-			      struct spl_boot_device *bootdev)
+#if CONFIG_IS_ENABLED(OS_BOOT)
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
+	int err;
+	struct spl_load_info load;
+
+	/*
+	 * Loading of the payload to SDRAM is done with skipping of
+	 * the mkimage header in this SPL NOR driver
+	 */
+	spl_image->flags |= SPL_COPY_PAYLOAD_ONLY;
+
+#if CONFIG_IS_ENABLED(OS_BOOT)
+	if (!spl_start_uboot()) {
+		err = spl_nor_load_image_os(spl_image, bootdev);
+		if (!err)
 			return 0;
 		} else {
 			puts("The Expected Linux image was not found.\n"
-- 
2.51.0

