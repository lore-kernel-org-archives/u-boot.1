Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E919C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13E09885DB;
	Fri, 21 Jun 2024 21:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZlPOkKVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8891B885A5; Fri, 21 Jun 2024 21:52:25 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C0048853F
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7eec09cc7f6so93441639f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999542; x=1719604342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfBAPrVQyw9HTglRcmtpn2r9tm3bxLQG3CM4EjSO9NI=;
 b=ZlPOkKVs3YL4aiytZbky3qx1ODqrK8ja8GqEowHb+OWaBOQWupmtIFe25Civ1FcWp+
 x1CJAhTocFFw26m9vJkjLSUrDjJICINT1ZuiIRb+o16UWbo6TBvqAP//6h1czvDEaoau
 aJTQqjo7zeHATjdDQqG10M6tT3yWWAiavYySY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999542; x=1719604342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfBAPrVQyw9HTglRcmtpn2r9tm3bxLQG3CM4EjSO9NI=;
 b=KT0vu/RczwJ3XjnBCdS5JMEHyOAHlrsvbHYwEt0/AhXedAE1YBLB2pviPVWwKpM2HQ
 9hE6Fa0lHHrJkCWL9WbIwsmw4lV4tQdOS7WU/aQlV4ELTC20is6D/pvA17tMKjVGBHoo
 YkglZGFDxjp0u6QdoHU8tPGxM8twf2tj7kweVYbZsH5PT82WLLCCxatu3rNuFE5kQ7JC
 bucs6DKPCqwWlnpkiTK1X5dapczPI0FPIPmYnbnY7ytIUm+Gj6em+YMqOIkxkx1O9TUC
 wUsMpsBQx7pzdXP0mpGxhQ7IPjTp2AeAQXl1yH7PHdkxjPMh98N13HvJmsgwkHo2Vgna
 7u4Q==
X-Gm-Message-State: AOJu0YwRKTfNX7h8uTqhxOu8/+eb9D+IyNhM08IqLEMmkL/YeUfSc6hj
 5kSyrqbOgzHU1uYRSn7/a7JiiHXaiTGA4A6OOWg7GpM2FvKNsGi4SOrCcr0CcbTUT4tJ3ZRAHyW
 75A==
X-Google-Smtp-Source: AGHT+IG/kXt+XZui4TCnRodbAlNpBuWRxrTSIIVs9fFC3rD4+gMw3z0BtjXZREJdYbDtiZy5Djd8WQ==
X-Received: by 2002:a05:6602:15c9:b0:7eb:906e:e3ee with SMTP id
 ca18e2360f4ac-7f13ee5c07dmr1090192939f.12.1718999542085; 
 Fri, 21 Jun 2024 12:52:22 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 15/43] am33xx: Provide a function to set up the debug UART
Date: Fri, 21 Jun 2024 13:51:36 -0600
Message-Id: <20240621195204.2675252-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

Since commit 0dba45864b2a ("arm: Init the debug UART") the debug UART is
set up in _main() before early_system_init() is called.

Add a suitable board_debug_uart_init() function to set up the UART in
SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/mach-omap2/am33xx/board.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 78c1e965c9f..84a60dedd72 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -490,9 +490,6 @@ void early_system_init(void)
 	 */
 	save_omap_boot_params();
 #endif
-#ifdef CONFIG_DEBUG_UART_OMAP
-	debug_uart_init();
-#endif
 
 #ifdef CONFIG_SPL_BUILD
 	spl_early_init();
@@ -533,3 +530,18 @@ static int am33xx_dm_post_init(void)
 	return 0;
 }
 EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, am33xx_dm_post_init);
+
+#ifdef CONFIG_DEBUG_UART_BOARD_INIT
+void board_debug_uart_init(void)
+{
+	if (u_boot_first_phase()) {
+		hw_data_init();
+		set_uart_mux_conf();
+		setup_early_clocks();
+		uart_soft_reset();
+
+		/* avoid uart gibberish by allowing the clocks to settle */
+		mdelay(50);
+	}
+}
+#endif
-- 
2.34.1

