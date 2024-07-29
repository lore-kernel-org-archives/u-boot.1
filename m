Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F016CC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 21:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BD7E884CA;
	Mon, 29 Jul 2024 23:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="izrhjv94";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5DD088791; Mon, 29 Jul 2024 23:37:05 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BABB387702
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 23:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3B81561C3A;
 Mon, 29 Jul 2024 21:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A08FC32786;
 Mon, 29 Jul 2024 21:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722289021;
 bh=hVFuMCu1N9F/QjRU9vnSjMhAGWpecOqiqoui1NH6gM8=;
 h=From:To:Cc:Subject:Date:From;
 b=izrhjv9439oUVxTv2egtgxKIklJQOwKBSo6ZihWTtkrrTDMAC2508akqXdVD7vCxg
 x/JsPUGXkvCoxqkRvsEAg6lIxUc+JBwQrp/j0wahHkh79upkEwTU4E825aHeq+myjW
 zyK1gQcA4OZSuOCGsYO893ss0gJNDBjCOXOVaY+lThgJGj5kI0Ge4jRik0K5x943Zm
 zhujk0XCgXne26iNM3lro4G9hs3quRv6dpcMiPotwtH6ZVl6Qcyhqi/PqpJq3q9ftN
 t+Nms9f4xdcgm/TXV8s1ne/SWdSrL9OvY+Hk3JiZoxhVJjfUdI4eVxCkIP54ge68OV
 YyFptcQ7RiD8Q==
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2] boot: android: fix booting without a ramdisk
Date: Mon, 29 Jul 2024 23:36:57 +0200
Message-Id: <20240729213657.2550935-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
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

android_image_get_ramdisk() will return an error if there is no ramdisk.
Using the android image without a ramdisk worked until commit
1ce8e10f3b4b ("image: Fix up ANDROID_BOOT_IMAGE ramdisk code") because
the return code wasn't checked until then. Return -ENOENT in case
there is no ramdisk and translate that into -ENOPKG in the calling
code, which will then indicate "no ramdisk" to its caller
(boot_get_ramdisk()).

This way, we can get rid of the "*rd_data = *rd_len = 0;" in the error
path, too.

With this, I'm able to boot a linux kernel using fastboot again:

  fastboot --base 0x41000000 --header-version 2 --dtb /path/to/dtb \
  --cmdline "root=/dev/mmcblk0p1 rootwait" boot path/to/Image

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 boot/image-android.c | 7 +++----
 boot/image-board.c   | 4 +++-
 include/image.h      | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 09c7a44e058..774565fd1fe 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -393,10 +393,9 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 	if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
 		return -EINVAL;
 
-	if (!img_data.ramdisk_size) {
-		*rd_data = *rd_len = 0;
-		return -1;
-	}
+	if (!img_data.ramdisk_size)
+		return -ENOENT;
+
 	if (img_data.header_version > 2) {
 		ramdisk_ptr = img_data.ramdisk_addr;
 		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
diff --git a/boot/image-board.c b/boot/image-board.c
index f2124013046..eca1b1d2bff 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -427,7 +427,9 @@ static int select_ramdisk(struct bootm_headers *images, const char *select, u8 a
 				unmap_sysmem(ptr);
 			}
 
-			if (ret)
+			if (ret == -ENOENT)
+				return -ENOPKG;
+			else if (ret)
 				return ret;
 			done = true;
 		}
diff --git a/include/image.h b/include/image.h
index dd4042d1bd9..2ab17075287 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1858,7 +1858,7 @@ int android_image_get_kernel(const void *hdr,
  * @vendor_boot_img : Pointer to vendor boot image header
  * @rd_data:	Pointer to a ulong variable, will hold ramdisk address
  * @rd_len:	Pointer to a ulong variable, will hold ramdisk length
- * Return: 0 if succeeded, -1 if ramdisk size is 0
+ * Return: 0 if OK, -ENOPKG if no ramdisk, -EINVAL if invalid image
  */
 int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 			      ulong *rd_data, ulong *rd_len);
-- 
2.39.2

