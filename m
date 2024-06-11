Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8685EC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6742D88710;
	Tue, 11 Jun 2024 22:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VhkO7lwE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAC4688710; Tue, 11 Jun 2024 22:02:29 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68C4E88730
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-375b27243e5so7425215ab.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136146; x=1718740946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rY6UgbnF9suBfeM5Xzr1xoZtJR9Dlhn8vfJ4cBYgtak=;
 b=VhkO7lwEl5zstIaUQEEkJO02Pm1fjf6DKjilluQXewt/ql5TmuzdoFiy1P9GK1ruQ3
 ClCqSk5Fx4gqfND57tPPx/chxsMH8635EO5Iv6+9mMLowK8GGRDY2BBiNl1fVedF/ZsL
 BMOuIIV5OVvMH3JfWrMQqSrDZ49qGGFkyEAPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136146; x=1718740946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rY6UgbnF9suBfeM5Xzr1xoZtJR9Dlhn8vfJ4cBYgtak=;
 b=TC5ns6wlykwhddOghtxgUfrAErTAhSG/r4Wr15c4sDjhGRmjxE97xc4ZwjHZPg9EOd
 KrWQD+8Ew4Q8LVwZkBK9/xmnS7Ieb73Cy6OpM4jvwscnb5IQww2uRU2+P+sw1r03E7e+
 pkt0yofx1B1uEydWrzmbjDVTXSOOvHOFEup6vP8YKbyTHY6gnnu6CBCFfQGOKfVYJGfO
 DGOZwHS8eQT5CCyucMLoH4UM4tmOfSdcpaLmtKlfjg1JUHcb+AJ73myqftRjgN0poq5h
 d5tUn3w6PEmq/NG5ukWg0KS62EebR1DKPxF8MsbT0SHASCVeqD3zGqdnzS1l+n/BqJMT
 Zblw==
X-Gm-Message-State: AOJu0Yy7IVdNx8LKBIu9AYF8x+txHtss2MCd9Mhlfgeyqvl7Cbxo80Ks
 2H5b1ygI0RljMnD+QKB5X7v+8AL0F9Z790uielBViccsXGVmofmEcGX8FbwcUrGrc9ZHcLzN6UA
 4Fg==
X-Google-Smtp-Source: AGHT+IGE0BlKa3FFwhyOfkm0Luh1nEXsonesW0Gt+raBc0blR2625jUgl2ve3RkYwKTI5VjAavWduA==
X-Received: by 2002:a05:6e02:20ed:b0:375:a7ee:dffc with SMTP id
 e9e14a558f8ab-375a7eee1ebmr65549515ab.11.1718136146105; 
 Tue, 11 Jun 2024 13:02:26 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Nishanth Menon <nm@ti.com>, Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH 15/42] am33xx: Provide a function to set up the debug UART
Date: Tue, 11 Jun 2024 14:01:29 -0600
Message-Id: <20240611200156.2245525-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

