Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C3FF357AD
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 14:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E6CC83F14;
	Tue, 24 Feb 2026 15:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KtrDhiRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C50BB83F2E; Tue, 24 Feb 2026 15:26:38 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A974A83DEB
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d4c7d04890so5153328a34.3
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771943195; x=1772547995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5Bi/3QaOykRuSeEHLUoi+/UJOhp8gba2j2Uj3sWK10=;
 b=KtrDhiRgdbEa7lpMuKGt/9R4zTT+aalMK5l5nJlKI4/Vie5/V7pP2Dz0S+LqAOPluz
 KWWJRmThRTpKzV4qn2v+P9LC8eODiSNWBBbHU59zoJPqDcVVZXVjMF7niVQDNfch54fs
 DvMKAeEEjEnyB+Ng/9ahfu8IBSX5+AVCSCQwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943195; x=1772547995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b5Bi/3QaOykRuSeEHLUoi+/UJOhp8gba2j2Uj3sWK10=;
 b=fURflXLtqlZXHQYRAEPwz/Dg0VI0Ininj1qisix6fwLxgTbqfFxdAu7NPdMFKQnUxz
 KSIYiQ7CyfvPWxdFy48mJQpG02jvOIsohjiFPqg7xpHvD6XfIlXw3QXY/REKELsuu5Dn
 WXTLHrRqNoF5e3UmzHm0vqNYhjqNy1oU+Q8+zM6auRGBA9IADERH/8CzUqLjHoDZao9G
 xq0a4cu14OYGpyDwJF8+5E4GSQPl7R9V58LTkCZfrYJi3Uc+EvisMxyEzfVUfPC7EFkx
 zzy3I0k/nTKi4epjOqHPcJeT5HTl42neO2auLq0lPOYeG/IyKLZeA/xmW82KH6P2Y4P1
 nyLA==
X-Gm-Message-State: AOJu0YwUbR6mhvR9Ny9FweN02TUlPCnj5dwKaWM9Sf4dPhXLqGAAeCWa
 4bON6HKTjK7Hix+OLrW3x2D6zsmmev7IS+QeheDCKsKarRmfGi7W18fI0hiybzxJA9pt8XlL+Bq
 MJ1E=
X-Gm-Gg: AZuq6aJL4dzEzp6NCLR7m7C97Zrd3Jwsfktpwd2Dl2Mm1sN6JQTCDhXk7k9DuarEkBq
 YoMs8KDfkLjkTNYqi8Ye5wwXvsjR376pBoAUwi7M+JLIz68qZYBInm+Y9cRdY55UjuyWfTDo62/
 MRM2F9VbrI60AJ6uSvT1WhU4HGrk7wdG1hXSLW2C8kKnjCaPHiXAcYcIqtLUwnA4MtRoGj/KMgV
 8xop9FVwVSoTMB7AtC/pcd1D791k7DD9M+t9wAdJ86JCoi1vVHR5ZZBUdVTGy6kTfH8Yr6ec1Th
 tUZSy/Bw3pLqad8iBs2NsMjCv5RFFK4/ei96lWEhOw4YGueAXA1iYUc09oUM6xc+AvDrUE43EJi
 aMSsQImY6JOg8P0U6TMCfG3DmZQbnD/sF+0uIBrSRaWdgw4UMwwbEHdAWr1pfVlqBm+bm7AW7j4
 zhGChTxQV9/lBMH3hNJ6CR1f2BGXxTVA==
X-Received: by 2002:a05:6870:e196:b0:409:794e:fdb with SMTP id
 586e51a60fabf-4157b138496mr7658965fac.36.1771943194729; 
 Tue, 24 Feb 2026 06:26:34 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd5e168sm10199478fac.4.2026.02.24.06.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:26:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 8/9] riscv: Call bootm_final()
Date: Tue, 24 Feb 2026 07:25:50 -0700
Message-ID: <20260224142553.1608883-9-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224142553.1608883-1-simon.glass@canonical.com>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
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

Make use of this function, adding some pieces needed by RISC-V

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v2:
- Drop the EFI_LOADER change

 arch/riscv/lib/bootm.c | 18 +-----------------
 boot/bootm_final.c     |  9 ++++++++-
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index c6a008a4559..bd47275b52e 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -32,23 +32,7 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 static void announce_and_cleanup(int fake)
 {
-	printf("\nStarting kernel ...%s\n\n", fake ?
-		"(fake run for tracing)" : "");
-	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
-#ifdef CONFIG_BOOTSTAGE_FDT
-	bootstage_fdt_add_report();
-#endif
-#if CONFIG_IS_ENABLED(BOOTSTAGE_REPORT)
-	bootstage_report();
-#endif
-
-	/*
-	 * Call remove function of all devices with a removal flag set.
-	 * This may be useful for last-stage operations, like cancelling
-	 * of DMA operation or releasing device internal buffers.
-	 */
-	dm_remove_devices_active();
-
+	bootm_final(fake);
 	cleanup_before_linux();
 }
 
diff --git a/boot/bootm_final.c b/boot/bootm_final.c
index 7077702d8c7..7f069877d06 100644
--- a/boot/bootm_final.c
+++ b/boot/bootm_final.c
@@ -7,17 +7,24 @@
 
 #include <bootm.h>
 #include <bootstage.h>
+#include <usb.h>
 #include <dm/root.h>
 
 void bootm_final(enum bootm_final_t flags)
 {
-	printf("\nStarting kernel ...\n\n");
+	printf("\nStarting kernel ...%s\n\n", flags & BOOTM_FINAL_FAKE ?
+		"(fake run for tracing)" : "");
 
 	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
 
+	if (IS_ENABLED(CONFIG_BOOTSTAGE_FDT) && IS_ENABLED(CONFIG_CMD_FDT))
+		bootstage_fdt_add_report();
 	if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
 		bootstage_report();
 
+	if (IS_ENABLED(CONFIG_USB_DEVICE))
+		udc_disconnect();
+
 	/*
 	 * Call remove function of all devices with a removal flag set.
 	 * This may be useful for last-stage operations, like cancelling
-- 
2.43.0

