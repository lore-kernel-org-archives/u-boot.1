Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764ADCF6BE0
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 00:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C3628405A;
	Wed,  7 Jan 2026 01:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fy4U8qn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C35548405C; Wed,  7 Jan 2026 01:32:47 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6294A8405A
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 01:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-65cf050a5cdso134061eaf.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 16:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767745963; x=1768350763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYnwIg/rrcMXUbtP3sSoAFXQoJYRW34y9An+kX5ypBs=;
 b=fy4U8qn5OHdWrGAuB/cDBM4T7WfnjWGBGdEdwzoGmgOE9wcfHYU/+Sc4KF9ZC5fLNa
 /KZWDHjYlD4havYQWPnkFL+muehyi1eM0/kqH90zU1rt0XZLLPDt1xRzMCsC6h9NPe/n
 k1mr6xjaNByafibW1i53k/BE72YCc4G/fb5OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767745963; x=1768350763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fYnwIg/rrcMXUbtP3sSoAFXQoJYRW34y9An+kX5ypBs=;
 b=cZETJ9U9ScwZG6yTxi5mAspAQIJY7kiRTkoTNZS/8pxYC7PndbZTip1z9rHXbQwacv
 Vr9jclCWdMLZB1h8Qovhs9v8cyq6xTgwOSpx4Mbca1WOA9/6yDuFxuX6WkgXMTek3CcA
 C+HpreBfl6NMbmPrnm9WsboY8fdUPE/YBViiMY+fYiyzN1eyWvpWuM1nL5Hh/tLhp5RI
 CT+X+WofOyKkxGpJkeI2Sj3rsOun2BYyjgajatHNsfqhmJbwY5ENh/KjlNH1LuQpmgYa
 XP9uBWnIp/VrF/vDC88l2bVIiahkARb58lQSWbJs6hNQZWb08lJoaTxhg7wDGxd9RY8C
 11ig==
X-Gm-Message-State: AOJu0YxWotgyPXEEU8gNwrmRfwr+SdFxfbe3clj3wMGVAs+/Bza+X2F8
 xgPgsCVvY+e2dVjE2sEYYjl4OOoTNsIaohNGdFuZtFikmlcb5UQ6fhGSVnDHUmRiC/LI1uglQ8K
 Rh9o=
X-Gm-Gg: AY/fxX5z5K6SVb88pmrjyEZGVC19dgmHu9TWAnNBe/ffeuNdDLDf0TlzsE8tXUPwDz+
 aVHLFQ59fTbMjuZXTJJfHYFJg4a3Wq4u2EN3f6Rx+8DCBG0dsAS7D1M144WmNQQ1ojSllyYJmH/
 vBEgI+CJT1eLNfPmNMLcnp6fS2YaID1IRufs6sa6qgfKKizx9sUglwVUfFXzI2ymUSorTAZZhSu
 1JinmxpSWkteTh/udEQMqpn13YR7Uzz+fdMJ9qcKQtpBSGK4BGLjxjN/qMyBjHkNNyFmuXBfy0j
 sN9sLiAZkmJGAwhn9tyegswVA2n2gBMRg0rEJ6rtSicpqaIG2DDjC99QzTblQVSwbawQuhu0hnr
 G/cYRZHLWshwCMzb9LrKj1Qic3i6XvFUCkRBWxnJFWrXlRbKN7dGIVcMwWExGJTodjyjuceuuSF
 fEGJNRTZPWdIdi8puFNfdDTC+NXl0=
X-Google-Smtp-Source: AGHT+IFXuTHx4Vole9JtqM28H+ts6P0ue/3P//tWIr0+9MyVbgnRWXVY1cFXdr6qioxZ5bgS3pNYkg==
X-Received: by 2002:a05:6820:162c:b0:659:9a49:8ee9 with SMTP id
 006d021491bc7-65f54691975mr495630eaf.29.1767745963549; 
 Tue, 06 Jan 2026 16:32:43 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ab2d00sm1631458eaf.0.2026.01.06.16.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 16:32:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Simon Glass <simon.glass@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leo <ycliang@andestech.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Rick Chen <rick@andestech.com>,
 Yao Zi <me@ziyao.cc>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH 08/10] riscv: Call bootm_final()
Date: Tue,  6 Jan 2026 17:31:25 -0700
Message-ID: <20260107003131.3064800-9-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107003131.3064800-1-simon.glass@canonical.com>
References: <20260107003131.3064800-1-simon.glass@canonical.com>
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

From: Simon Glass <sjg@chromium.org>

Make use of this function, adding some pieces needed by RISC-V

Drop the udc_disconnect() from EFI_LOADER since it is now done in
bootm_final()

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 arch/riscv/lib/bootm.c        | 22 +---------------------
 boot/bootm_final.c            |  9 ++++++++-
 lib/efi_loader/efi_boottime.c |  2 --
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index 35403e03ab0..bd47275b52e 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -32,27 +32,7 @@ DECLARE_GLOBAL_DATA_PTR;
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
-#ifdef CONFIG_USB_DEVICE
-	udc_disconnect();
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
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 13d0d4dbe88..0bc66ee61a8 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2238,8 +2238,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 
 	if (!efi_st_keep_devices) {
 		bootm_disable_interrupts();
-		if (IS_ENABLED(CONFIG_DM_ETH))
-			eth_halt();
 		board_quiesce_devices();
 		bootm_final(0);
 	}
-- 
2.43.0

