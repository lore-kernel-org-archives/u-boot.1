Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A68DC369D3
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 12:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4BE820EB;
	Sun, 27 Apr 2025 14:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K7n7E9ti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1750480C93; Sun, 27 Apr 2025 13:25:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AC2E8209F
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 13:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 85F615C5AF7;
 Sun, 27 Apr 2025 11:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48902C4CEEA;
 Sun, 27 Apr 2025 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745753130;
 bh=Nrq18msGpGGDd6vp8vIOblFCni2QweQjvsraoD5p7CE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=K7n7E9tiGXehnLLghMn+90ErDEWslIQdqtAUNCaBdE3tyrMkB3UzS0iY5JNRJ/O7x
 +mSNuy6IzoPhdOuQcpsKaXCdyMoodx9/8RU60/OHL7UKiZjDJ+VByMAiHJbUr+8pMN
 GvX3GuRudHB97CINaonU9zCBi94eQuqEsKC15AI4hUwEHnSRtPWZisZEeKdBZvQttz
 qljoiIsIFJSlSCrhTGzUpOGuTE9XLrDXHZbl7LvEn1qPVGhASvUoTX0QyEug6KkUtU
 kCYP4Wyh3fPetewAEtdaJLgFO44j8GCHjLFGmTNpDR3lnhL9Wq6os/LXcakwCDNkfr
 bxVR9sEGplqLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 39045C369D3;
 Sun, 27 Apr 2025 11:25:30 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Sun, 27 Apr 2025 19:25:20 +0800
Subject: [PATCH 1/3] boot/image-android.c: Workaround androidboot
 kernel/ramdisk addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250427-android-boot-v1-1-bb6b37c9c9f1@gmail.com>
References: <20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com>
In-Reply-To: <20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745753127; l=1729;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=vW9sx6lG2KtfDbPcC1sbK8kJPmrWjFZnmu7Ce8PyjNo=;
 b=bHByYGkb/7Fv2LHiK+ydFWUOVw3eLCbWGt+x5pHfr+zLxnX+NcGtbHJj0mQ2Wrt9WScDD1rCY
 9w+YMhGt1kgAYznac2O4dAaSWHeEOq9kql1z0oyJi7lbdYWJgwDNsYz
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sun, 27 Apr 2025 14:43:01 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: George Chan <gchan9527@gmail.com>

Some vendor bootloader ignored kernel/ramdisk addr and use
their own addr. Even those addr are pointing to out-of-reach
memory block at 0, and available address start at 0x80000000.

So we also need to use our own available addr for loadaddr.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
 boot/image-android.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/boot/image-android.c b/boot/image-android.c
index 1746b018900..36822d788b0 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -12,6 +12,7 @@
 #include <asm/unaligned.h>
 #include <mapmem.h>
 #include <linux/libfdt.h>
+#include <dm/of.h>
 
 #define ANDROID_IMAGE_DEFAULT_KERNEL_ADDR	0x10008000
 #define ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR	0x11000000
@@ -281,6 +282,13 @@ static ulong android_image_get_kernel_addr(struct andr_image_data *img_data,
 	if (img_data->kernel_addr == 0 && img_data->ramdisk_addr == 0)
 		return env_get_ulong("kernel_addr_r", 16, 0);
 
+	/*
+	 * Some vendor bootloader ignore kernel and ramdisk address also
+	 * default value are out of physical mem base... so we use ours.
+	 */
+	if (img_data->kernel_addr < gd->ram_base)
+		return env_get_ulong("kernel_addr_r", 16, 0);
+
 	return img_data->kernel_addr;
 }
 
@@ -490,6 +498,8 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 		if (img_data.ramdisk_addr == 0 ||
 		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
 			*rd_data = img_data.ramdisk_ptr;
+		} else if (img_data.ramdisk_addr < gd->ram_base) {
+                        *rd_data = img_data.ramdisk_ptr;
 		} else {
 			ramdisk_ptr = img_data.ramdisk_addr;
 			*rd_data = ramdisk_ptr;

-- 
2.43.0


