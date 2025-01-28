Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BE8C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 09:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAAC481BC0;
	Tue, 28 Jan 2025 10:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=studiofuga.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7F2381CC5; Tue, 28 Jan 2025 10:10:31 +0100 (CET)
Received: from localhost (unknown [151.82.255.30])
 by phobos.denx.de (Postfix) with ESMTP id EF97C8197D
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 10:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=studiofuga.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=happycactus@localhost
Received: by localhost (Postfix, from userid 1000)
 id 629C0DC532A; Tue, 28 Jan 2025 10:10:29 +0100 (CET)
From: Federico Fuga <fuga@studiofuga.com>
To: u-boot@lists.denx.de
Cc: Federico Fuga <fuga@studiofuga.com>
Subject: [PATCH] Fix fastboot handling of partitions when no slots are
 supported
Date: Tue, 28 Jan 2025 10:09:58 +0100
Message-ID: <20250128090958.400146-1-fuga@studiofuga.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The fastboot module has a bug that prevents some command to work
properly on devices that haven't an Android-like partition scheme, that
is, just one spl and one kernel partition, instead of the redundant
scheme with _a and _b slots.

This is the schema of our NAND storage (board is based on an AllWinner
A33 sunxi chip):

=> mtdparts

device nand0 <1c03000.nand>, # parts = 4
 #: name         size            net size        offset          mask_flags
 0: spl          0x00020000      0x00020000      0x00000000      0
 1: uboot        0x00100000      0x00100000      0x00020000      0
 2: kernel_a     0x00400000      0x00400000      0x00120000      0
 3: ubi          0x07ae0000      0x079e0000 (!)  0x00520000      0

active partition: nand0,0 - (spl) 0x00020000 @ 0x00000000

This happens when we try to erase the spl partition using fastboot:

$ fastboot erase spl
Erasing 'spl_a'               FAILED (remote: 'invalid NAND device')
fastboot: error: Command failed

The error occurs because getvars fails to handle the error returned by
nand layer when a partition cannot be found.

Indeed, getvar_get_part_info returns what is returned by
fastboot_nand_get_part_info (0 on success, 1 on failure) but it should
return -ENODEV or -EINVAL instead. Since the cause of failure is not
returned by the nand function, I decided to return -EINVAL to make it
simple.

Signed-off-by: Federico Fuga <fuga@studiofuga.com>
---
 drivers/fastboot/fb_getvar.c | 5 ++++-
 drivers/fastboot/fb_nand.c   | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index 9c2ce65a4e..816ed8a621 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -121,8 +121,11 @@ static int getvar_get_part_info(const char *part_name, char *response,
 			*size = disk_part.size * disk_part.blksz;
 	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND)) {
 		r = fastboot_nand_get_part_info(part_name, &part_info, response);
-		if (r >= 0 && size)
+		if (r == 0 && size) {
 			*size = part_info->size;
+		} else {
+			r = -EINVAL;
+		}
 	} else {
 		fastboot_fail("this storage is not supported in bootloader", response);
 		r = -ENODEV;
diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
index afc64fd528..9e2f7c0189 100644
--- a/drivers/fastboot/fb_nand.c
+++ b/drivers/fastboot/fb_nand.c
@@ -151,7 +151,7 @@ static lbaint_t fb_nand_sparse_reserve(struct sparse_storage *info,
  *
  * @part_name: Named device to lookup
  * @part_info: Pointer to returned part_info pointer
- * @response: Pointer to fastboot response buffer
+ * @response: 0 on success, 1 otherwise
  */
 int fastboot_nand_get_part_info(const char *part_name,
 				struct part_info **part_info, char *response)
-- 
2.48.1

