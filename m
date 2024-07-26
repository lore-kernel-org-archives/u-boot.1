Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26658C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 23:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FDFD885A8;
	Sat, 27 Jul 2024 01:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MZg5k+LJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB8A885BF; Sat, 27 Jul 2024 01:00:47 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967B98851E
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 01:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B919BCE1349;
 Fri, 26 Jul 2024 23:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D53C32782;
 Fri, 26 Jul 2024 23:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722034842;
 bh=dzjWvTAGYDX/XuaDpHhUSZ9zBimYYY7IyiVGIdIj87c=;
 h=From:To:Cc:Subject:Date:From;
 b=MZg5k+LJJzoTHX9XnJLWkm+hzS7lxdcyLl2ASSJsUKAkS9uONGs9J++E1VRehwzre
 O16BoFYPfZym7G+mKlVKpsWTNSScGvmwvCSEjqXtbBb2/1uhTmrhj4H1Tjk/a46Y/i
 p+hKL020rJfYfetlXGIqahrPeVicxTv6Q1HRXb+5Mzgh+uRLmdLjKV1VRYHDVsHRFb
 YwhQA3Sj6HKJPYAG8Iyo8nHuzVFJrL+WKVjEzDNLN9dmL6kskpJFfY4cKuHjYU1OxR
 mG7Xns4JL6rofZLL5i+5k8n0M8RbPo8sYYUq3/QbUZRNdkwjSzRLKnaKueEaRmNg8o
 o6QmmP4d5KIXg==
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] boot: android: fix booting without a ramdisk
Date: Sat, 27 Jul 2024 01:00:35 +0200
Message-Id: <20240726230035.2339680-1-mwalle@kernel.org>
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
that return code wasn't checked. Now that it is checked, don't return an
error in the (valid) case that there is no ramdisk in the image.

With this, I'm able to boot a linux kernel using fastboot again:

  fastboot --base 0x41000000 --header-version 2 --dtb /path/to/dtb \
  --cmdline "root=/dev/mmcblk0p1 rootwait" boot path/to/Image

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 boot/image-android.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 09c7a44e058..0900579ee8c 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -395,7 +395,7 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 
 	if (!img_data.ramdisk_size) {
 		*rd_data = *rd_len = 0;
-		return -1;
+		return 0;
 	}
 	if (img_data.header_version > 2) {
 		ramdisk_ptr = img_data.ramdisk_addr;
-- 
2.39.2

