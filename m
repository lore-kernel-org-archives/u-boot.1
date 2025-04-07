Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56071C3600C
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 01:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D8EB82CBA;
	Mon,  7 Apr 2025 03:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E86DU9LN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1596582C96; Mon,  7 Apr 2025 03:36:10 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B518782CA6
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 03:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-227a8cdd241so42958975ad.3
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 18:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743989765; x=1744594565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfM19mMnnFSoQtkQSlwsplHW7P9rKEdhFhq/p9hFjLo=;
 b=E86DU9LNZxLwK65/MvTjlUVzNwfErbvdZlz8C8SCRFWoIUq+7kxeeLDLmxqaSp3Lyl
 hgXtixjUrEzZ9DJPCtfc/7sxfejJO5kqwpenE+jUADsYSNpFCAjfne8SiduSleTCW77F
 XKFNYg+oBjKooD15VzunIzU06N5quIWXbN8+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743989765; x=1744594565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wfM19mMnnFSoQtkQSlwsplHW7P9rKEdhFhq/p9hFjLo=;
 b=j93UQsSg0OaoGOlhBZQBRlc7012NoMNA5kySeARFy0IRjZtsLlUx2RaGUXddj+8cd2
 +gDskPsZQ08X4UPiDKEUqYa8na+3KBoBkbI6AfDvNSIZ3EhkyOQuxjyAnucTQfFP1ODj
 UP8ZuuBTEyu2KSrj3XuNLc0T2E3UIGPe5k3gf/5eSrwrjlir7Gp0IfO9P1krIxgOnDQr
 y1wzvfKdOiOJn5LBF+qkb7YBJPNeT/gEyIb1zj0FK+RPjRuF4b5vOJGkhwRhyPSqUABf
 GlmnbsezYzHaDPh6VaCkXle02PnBwP7gpBnjScxv1wZX8ewIQVgR3zr1us0/yHLgGJxt
 EivA==
X-Gm-Message-State: AOJu0YxeLiNEU0e1/8DUCpsK/OLastcw1Ww5you3HLJ8pn8xR+XjVdB8
 X+6W/vETQA6h0lpBTDqKOR8GodGcQ++BYitV5pEEsURFq2eoKzsoT98jeyUGZPXz8yKinGKjuA4
 1GA==
X-Gm-Gg: ASbGncsatiyZhspa5d55bRkU0+JuFIwFkeL/CtN5lRVIPZ9e5qmKXxwyAobfm7llnVb
 UozpeJlnTYDc+vpDQocjPomHWP5f1ynnmZZny8iOL5vqVrRI8UCw+OADQZ1leokMgzaythqeqrt
 J54k0MXyfBiEdozprIuELQ4j+NMvQUo5dbxnfKpYC0NSaHAX0THiIIYICvPxw+I1SoKL5TgSMuY
 2ll91vhgeKmJOb9Qij8u9jsJ4GwmiR+pGjUYw/X7+t0/F86MjOjbs09Gt2GxdHYUn31mJrg+mEN
 HHAVfuD3Q3WH+Ydwd+B6JLRJxL8S9WJb/WYQ7toWiXcYSp0m
X-Google-Smtp-Source: AGHT+IHLECp+ohOGDgi/bTTEYCavF8OSoH/BQfWCuU2LPHEiJfGvobREqHLIXJCg7OGKCl1Izr+y+g==
X-Received: by 2002:a17:902:e805:b0:223:501c:7581 with SMTP id
 d9443c01a7336-22a95511e49mr99449625ad.16.1743989765654; 
 Sun, 06 Apr 2025 18:36:05 -0700 (PDT)
Received: from chromium.org ([161.29.84.47]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785adad8sm69535765ad.35.2025.04.06.18.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 18:36:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 neil.armstrong@linaro.org, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rick Chen <rick@andestech.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 4/4] dm: core: Rename dm_remove_devices_active()
Date: Mon,  7 Apr 2025 13:35:10 +1200
Message-ID: <20250407013513.638110-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407013513.638110-1-sjg@chromium.org>
References: <20250407013513.638110-1-sjg@chromium.org>
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

This function doesn't have a great name, since we talk of devices being
active once they are probed.

Rename it to dm_remove_dma_devices().

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
---

(no changes since v1)

 arch/arm/lib/bootm.c          | 4 ++--
 arch/riscv/lib/bootm.c        | 2 +-
 arch/x86/lib/bootm.c          | 2 +-
 drivers/core/root.c           | 2 +-
 include/dm/root.h             | 6 +++---
 lib/efi_loader/efi_boottime.c | 2 +-
 test/dm/core.c                | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 688c2f3f29b..ef859a2cd4c 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -74,10 +74,10 @@ static void announce_and_cleanup(int fake)
 	 * Call remove function of all devices with a removal flag set.
 	 * This may be useful for last-stage operations, like cancelling
 	 * of DMA operation or releasing device internal buffers.
-	 * dm_remove_devices_active() ensures that vital devices are removed in
+	 * dm_remove_dma_devices() ensures that vital devices are removed in
 	 * a second round.
 	 */
-	dm_remove_devices_active();
+	dm_remove_dma_devices();
 
 	cleanup_before_linux();
 }
diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index 76c610bcee0..9aecaafef43 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -57,7 +57,7 @@ static void announce_and_cleanup(int fake)
 	 * This may be useful for last-stage operations, like cancelling
 	 * of DMA operation or releasing device internal buffers.
 	 */
-	dm_remove_devices_active();
+	dm_remove_dma_devices();
 
 	cleanup_before_linux();
 }
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 3c420b00936..91e8de4e1ad 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -50,7 +50,7 @@ void bootm_announce_and_cleanup(void)
 	 * This may be useful for last-stage operations, like cancelling
 	 * of DMA operation or releasing device internal buffers.
 	 */
-	dm_remove_devices_active();
+	dm_remove_dma_devices();
 }
 
 #if defined(CONFIG_OF_LIBFDT) && !defined(CONFIG_OF_NO_KERNEL)
diff --git a/drivers/core/root.c b/drivers/core/root.c
index c7fb58285ca..101cc4d43fa 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -148,7 +148,7 @@ int dm_remove_devices_flags(uint flags)
 	return 0;
 }
 
-void dm_remove_devices_active(void)
+void dm_remove_dma_devices(void)
 {
 	/* Remove non-vital devices first */
 	device_remove(dm_root(), DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_VITAL);
diff --git a/include/dm/root.h b/include/dm/root.h
index 5651b868c8b..39a069cd465 100644
--- a/include/dm/root.h
+++ b/include/dm/root.h
@@ -169,16 +169,16 @@ int dm_uninit(void);
 int dm_remove_devices_flags(uint flags);
 
 /**
- * dm_remove_devices_active - Call remove function of all active drivers heeding
+ * dm_remove_dma_devices - Call remove function of all active drivers heeding
  *                            device dependencies as far as know, i.e. removing
  *                            devices marked with DM_FLAG_VITAL last.
  *
  * All active devices will be removed
  */
-void dm_remove_devices_active(void);
+void dm_remove_dma_devices(void);
 #else
 static inline int dm_remove_devices_flags(uint flags) { return 0; }
-static inline void dm_remove_devices_active(void) { }
+static inline void dm_remove_dma_devices(void) { }
 #endif
 
 /**
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index e525662f82f..8f78fcdf7c8 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2281,7 +2281,7 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 		if (IS_ENABLED(CONFIG_USB_DEVICE))
 			udc_disconnect();
 		board_quiesce_devices();
-		dm_remove_devices_active();
+		dm_remove_dma_devices();
 	}
 
 out:
diff --git a/test/dm/core.c b/test/dm/core.c
index 959b834576f..1194e3250b5 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -1057,7 +1057,7 @@ static int dm_test_remove_active(struct unit_test_state *uts)
 	ut_asserteq(true, device_active(dma_vital));
 
 	/* Remove active devices in an ordered way */
-	dm_remove_devices_active();
+	dm_remove_dma_devices();
 
 	/* Check that all devices are inactive right now */
 	ut_asserteq(true, device_active(normal));
-- 
2.43.0

