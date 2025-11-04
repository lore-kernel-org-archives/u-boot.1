Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E60CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 23:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8305283700;
	Wed,  5 Nov 2025 00:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tFF+npEN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABA2683990; Wed,  5 Nov 2025 00:22:15 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B66058334F
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 00:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B9E504089F; 
 Tue,  4 Nov 2025 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762298532;
 bh=AwqHYBPemWm0GTNooMzifvkiLxB63vdFpqcxDvxMbYo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=tFF+npENhpHmSA0tRJItoT7WqzTV88sOhORdWpvhto9+r9yrtEit3eDlMLlRfqRr2
 lwMpElyl73bOmF5EdGNv0Ep7ZVQOkOE3BaCNuLek4eVg4+DVrM7M9VWkz592AXaxxn
 Q8z6hKiBFmonEMNZfWNLO2E7+PY6DEWGmjQG44gIgXE0VQjhaKE8ZJlmHzMJZoNbh/
 KOs7MAGiUlZ73VLUj0I5Wjb3U7u6Cs/Omrn7VPVOMoO7TyhvNXMoZ0MEvvedc/HkFG
 sjyKCi8kXrB9Tcqn+LiV6SDKYUuxed1Pyw/f1GsYlJGm4DvYxbpXOQgzM0y2hYZdKU
 MnNu52aEXW2fCTO0+kfJ9O3B8yUokQUnTeWpIwcd4WUXrDAYrMLILEw9EYA0ueXtcQ
 zFztuZwZ/h459jriG7x9gAhWQBLHyEZSW/6LqVPqnTwGyrX1jLVvqnsAEshz9WLz/Y
 1GzifdM4hxbtAC55ajxaCq6/vgMnwqxrQdOC6UF3JixKJQyJfD2lkohhrcgRV5hSzV
 sbEJDLPYIoaR1rBNWMRS9D1D3xdGuCESBbby4CAozdSU9ljlqYjib6jWnOC3Y+ReB1
 355Wa31v9z3C23Y2kfbIS7dYm5IrgpkUATDwBV2T+AVU5ESFUVBxa50rrT+jbW1hbj
 y1OcSt03KFHFd4z/liLowjFA=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_driver: don't leak name in
 efi_bl_create_block_device()
Date: Wed,  5 Nov 2025 00:22:09 +0100
Message-ID: <20251104232209.75544-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

In case of an error always free variable name.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_driver/efi_block_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_driver/efi_block_device.c b/lib/efi_driver/efi_block_device.c
index c389b1920a8..7ce6a45a5f3 100644
--- a/lib/efi_driver/efi_block_device.c
+++ b/lib/efi_driver/efi_block_device.c
@@ -146,7 +146,6 @@ efi_bl_create_block_device(efi_handle_t handle, void *interface)
 			       devnum, io->media->block_size,
 			       (lbaint_t)io->media->last_block, &bdev)) {
 		ret = EFI_OUT_OF_RESOURCES;
-		free(name);
 		goto err;
 	}
 
@@ -171,6 +170,7 @@ err:
 	efi_unlink_dev(handle);
 	if (bdev)
 		device_unbind(bdev);
+	free(name);
 
 	return ret;
 }
-- 
2.51.0

