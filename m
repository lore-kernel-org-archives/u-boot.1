Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D444D339A0
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 16:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62A9C890A9;
	Mon, 28 Oct 2024 17:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F145890D0; Mon, 28 Oct 2024 17:56:04 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD08E89099
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 17:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peko@korsgaard.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DDB2AFF809;
 Mon, 28 Oct 2024 16:56:01 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
 (envelope-from <peko@dell.be.48ers.dk>) id 1t5T29-00CqWw-0C;
 Mon, 28 Oct 2024 17:56:01 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>
Cc: Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH] boot/image-board.c: boot_get_fpga(): pass compatible flag to
 fpga_load()
Date: Mon, 28 Oct 2024 17:55:57 +0100
Message-Id: <20241028165557.3061852-1-peter@korsgaard.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: peter@korsgaard.com
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

For E.G.  signed FPGA bitstreams, similar to how it is done for the FPGA
loading from SPL since commit 282eed50ecb7 ("fpga: pass compatible flags to
fpga_load()").

Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
 boot/image-board.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index 1757e5816d8..b726bd6b303 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -624,9 +624,10 @@ int boot_get_fpga(struct bootm_headers *images)
 	void *buf;
 	int conf_noffset;
 	int fit_img_result;
-	const char *uname, *name;
+	const char *uname, *name, *compatible;
 	int err;
 	int devnum = 0; /* TODO support multi fpga platforms */
+	int flags = 0;
 
 	if (!IS_ENABLED(CONFIG_FPGA))
 		return -ENOSYS;
@@ -674,20 +675,29 @@ int boot_get_fpga(struct bootm_headers *images)
 			return fit_img_result;
 		}
 
+		conf_noffset = fit_image_get_node(buf, uname);
+		compatible = fdt_getprop(buf, conf_noffset, "compatible", NULL);
+		if (!compatible) {
+			printf("'fpga' image without 'compatible' property\n");
+		} else {
+			if (CONFIG_IS_ENABLED(FPGA_LOAD_SECURE))
+				flags = fpga_compatible2flag(devnum, compatible);
+		}
+
 		if (!fpga_is_partial_data(devnum, img_len)) {
 			name = "full";
 			err = fpga_loadbitstream(devnum, (char *)img_data,
 						 img_len, BIT_FULL);
 			if (err)
 				err = fpga_load(devnum, (const void *)img_data,
-						img_len, BIT_FULL, 0);
+						img_len, BIT_FULL, flags);
 		} else {
 			name = "partial";
 			err = fpga_loadbitstream(devnum, (char *)img_data,
 						 img_len, BIT_PARTIAL);
 			if (err)
 				err = fpga_load(devnum, (const void *)img_data,
-						img_len, BIT_PARTIAL, 0);
+						img_len, BIT_PARTIAL, flags);
 		}
 
 		if (err)
-- 
2.39.5

