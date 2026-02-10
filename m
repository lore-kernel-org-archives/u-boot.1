Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C690DEA3F0A
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 05:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 215AB83CB9;
	Tue, 10 Feb 2026 06:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="ceSZgHDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC9898309A; Tue, 10 Feb 2026 06:43:54 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D08408388D
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 06:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D192910FC72; Tue, 10 Feb 2026 06:43:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1770702232; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=1TyNp5t52Lu1JW4Dzzez/aqwEpxCa5XqaOA8twfgkBo=;
 b=ceSZgHDty5BPovSZz8abpVSbHZqVNCxxIyyDf74olhWeZYgW84ZXQV50A7RtC2XsV3obbT
 aBmhjFIcdH40q2VEkABtbqU+0pARVnkv2OkqvNAZNpNPfDVBiNM7psAQckYlOKwxaZPXBf
 P+y8rpqDXb6YqpwgoPErpjverH97IO1OaanjP7fMsj3Ud5Qf8Ifc8vUB4MWjaaaWVgDFh3
 Hrw8h+r/NoS4J+KSadS7VkS29DZ9xH103JQ/ra8YtO9Hvz/l4Olj0qNSzk4RwxZWVGlQD4
 h0gECZMBorrtIW+kktCIHmEHb93GuP4l35ayrQ1o8Fibpm4uREwpxaWZHyjn5Q==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] fastboot: mmc: make boot partition offset configurable
Date: Tue, 10 Feb 2026 06:43:44 +0100
Message-Id: <20260210054345.126651-2-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260210054345.126651-1-hs@nabladev.com>
References: <20260210054345.126651-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Adrian Freihofer <adrian.freihofer@siemens.com>

i.MX8QXP rev C.0 requires boot container stored at offset 0KB
for eMMC, while i.MX8QXP pre C.0 requires boot container stored
at offset 32KB for eMMC.

To use one U-Boot binary to support different chip revisions,
introduce fb_mmc_get_boot_offset() to allow override the default
offset when writing to eMMC boot partitions.

This enables support for devices with non-standard boot partition
layouts, such as those requiring an offset for correct bootloader
placement.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---

Changes in v2:
- added Reviewed-by from Mattijs
- Used the commit message as Peng suggested (with a small
  checkpatch fix:
  WARNING: 'writting' may be misspelled - perhaps 'writing'?
- rebased to mainline
  b99da05e153 - (tag: v2026.04-rc2, origin/master, origin/HEAD) Prepare v2026.04-rc2

 drivers/fastboot/fb_block.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index 2a7e47992f8..51d1abb18c7 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -28,6 +28,11 @@
  */
 #define FASTBOOT_MAX_BLOCKS_WRITE 65536
 
+__weak lbaint_t fb_mmc_get_boot_offset(void)
+{
+	return 0;
+}
+
 struct fb_block_sparse {
 	struct blk_desc	*dev_desc;
 };
@@ -160,7 +165,8 @@ void fastboot_block_raw_erase_disk(struct blk_desc *dev_desc, const char *disk_n
 
 	debug("Start Erasing %s...\n", disk_name);
 
-	written = fb_block_write(dev_desc, 0, dev_desc->lba, NULL);
+	written = fb_block_write(dev_desc, fb_mmc_get_boot_offset(),
+				 dev_desc->lba, NULL);
 	if (written != dev_desc->lba) {
 		pr_err("Failed to erase %s\n", disk_name);
 		fastboot_response("FAIL", response, "Failed to erase %s", disk_name);
@@ -211,7 +217,8 @@ void fastboot_block_erase(const char *part_name, char *response)
 	if (fastboot_block_get_part_info(part_name, &dev_desc, &part_info, response) < 0)
 		return;
 
-	fastboot_block_raw_erase(dev_desc, &part_info, part_name, 0, response);
+	fastboot_block_raw_erase(dev_desc, &part_info, part_name,
+				 fb_mmc_get_boot_offset(), response);
 }
 
 void fastboot_block_write_raw_disk(struct blk_desc *dev_desc, const char *disk_name,
@@ -224,7 +231,7 @@ void fastboot_block_write_raw_disk(struct blk_desc *dev_desc, const char *disk_n
 	blkcnt = ((download_bytes + (dev_desc->blksz - 1)) & ~(dev_desc->blksz - 1));
 	blkcnt = lldiv(blkcnt, dev_desc->blksz);
 
-	if (blkcnt > dev_desc->lba) {
+	if ((blkcnt + fb_mmc_get_boot_offset()) > dev_desc->lba) {
 		pr_err("too large for disk: '%s'\n", disk_name);
 		fastboot_fail("too large for disk", response);
 		return;
@@ -232,7 +239,7 @@ void fastboot_block_write_raw_disk(struct blk_desc *dev_desc, const char *disk_n
 
 	printf("Flashing Raw Image\n");
 
-	blks = fb_block_write(dev_desc, 0, blkcnt, buffer);
+	blks = fb_block_write(dev_desc, fb_mmc_get_boot_offset(), blkcnt, buffer);
 
 	if (blks != blkcnt) {
 		pr_err("failed writing to %s\n", disk_name);
-- 
2.20.1

