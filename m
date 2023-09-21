Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DD0CD493C
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E8A386D88;
	Thu, 21 Sep 2023 03:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QLqAsGvr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 861CC86D6E; Thu, 21 Sep 2023 03:57:56 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4EC86D69
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7ab5331f462so176502241.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261468; x=1695866268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7HYfE66roCGx39jewp+tcbLjTYrsGi/hltTaNk7c/sU=;
 b=QLqAsGvr9NCukg928Q+TEMRVzR6aoMT9mqXUP39TR1L6qC9lwrW+MWR+8d6/VRg2/k
 fu2o+HLCnHUj4AXUjPV4XKvaLxSRNHIsjwj0z0i31hS59Hoy7XPEHrPGd53dX3q7K5+p
 5GagEwlEtQXBG69f+W7opoinVhU7B40L92sMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261468; x=1695866268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7HYfE66roCGx39jewp+tcbLjTYrsGi/hltTaNk7c/sU=;
 b=cFKhhfs161r7nelVpE4cr0yWVl1I+LaNud6uSn4cAsWqIu3QsocYDU8zf4PHdCsvZU
 1vjIJr0m3hVeLFdsjIFPINfK7A5a/b8oHAXMTZwVeVjn8Cl50I5MumqBWH1jGRjauWUR
 T3XC72HAnGdFQNh0LXNPF3ofI5hWK7jCQ1GvJeiHNPoDAEF6MOotz/Bbmr4DQCAIimbW
 beJDTVNT3ZuGc0c8GYiURg4BJqripg+TZYUMAqawUKOXVUcDjiWxQJIVD9yNfXVzabxY
 rOmAxNAwfjOYt/JUBTh1Q9hwE1IT/4L/Yr8VTo5iatnqoFEXt0K5MQ1s8AZDJ4NlSEhy
 n+zA==
X-Gm-Message-State: AOJu0Yw95TE25o8laPoH4BS+zTLSbm3Fs/L+5VQdNiFgPfyburZBUbfJ
 D2DoqnE6k6E05UfmtepiWPDzPoZGJYQohaMBAoM=
X-Google-Smtp-Source: AGHT+IEaZN79tfl9QMjoSUSq/ctWHTcfjR4G0T+6wN1Dy9z9joGMlXD8k8tKhbEYp0aaTtW0mi0ucw==
X-Received: by 2002:a05:6102:4bc4:b0:452:b574:3c9a with SMTP id
 id4-20020a0561024bc400b00452b5743c9amr931417vsb.26.1695261467809; 
 Wed, 20 Sep 2023 18:57:47 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Ovidiu Panait <ovpanait@gmail.com>, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 06/32] spl: Drop #ifdefs for BOARD_INIT and watchdog
Date: Wed, 20 Sep 2023 19:56:55 -0600
Message-ID: <20230921015730.1511373-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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

Avoid using the preprocessor for these checks.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 10 ++++------
 include/spl.h    |  8 ++++++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 80a3a3f1516e..9870e9a65468 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -782,13 +782,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		}
 	}
 
-#if CONFIG_IS_ENABLED(BOARD_INIT)
-	spl_board_init();
-#endif
+	if (CONFIG_IS_ENABLED(BOARD_INIT))
+		spl_board_init();
 
-#if defined(CONFIG_SPL_WATCHDOG) && CONFIG_IS_ENABLED(WDT)
-	initr_watchdog();
-#endif
+	if (IS_ENABLED(CONFIG_SPL_WATCHDOG) && CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
 
 	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CONFIG_IS_ENABLED(HANDOFF) ||
 	    IS_ENABLED(CONFIG_SPL_ATF))
diff --git a/include/spl.h b/include/spl.h
index 92bcaa90a4af..d16cea3ea50b 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -707,9 +707,13 @@ int spl_early_init(void);
  */
 int spl_init(void);
 
-#ifdef CONFIG_SPL_BOARD_INIT
+/*
+ * spl_board_init() - Do board-specific init in SPL
+ *
+ * If xPL_BOARD_INIT is enabled, this is called from board_init_r() before
+ * jumping to the next phase.
+ */
 void spl_board_init(void);
-#endif
 
 /**
  * spl_was_boot_source() - check if U-Boot booted from SPL
-- 
2.42.0.515.g380fc7ccd1-goog

