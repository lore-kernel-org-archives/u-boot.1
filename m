Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D39E7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0344986E02;
	Tue, 26 Sep 2023 16:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g4at2FaK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8448B86E01; Tue, 26 Sep 2023 16:15:41 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 613B086DDB
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79fa7e33573so229074739f.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737729; x=1696342529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aICVyKvuU5JfSIhsWdF89BOR56H3cGACEkieKv3Acq0=;
 b=g4at2FaKNTqOGID9djeSSRN7N4xassDVQ/iPD2zvJeL8NJE7BoD2btl5IBgHmNDs52
 uA98hyvrnQqKw08N9B7ReQPdNx3tNGVOnztxbweYIRVkSjE3YSz/FW7TkG5ZQj7DKn9h
 GaLUdF6ID+QSbhvx3g4LxetCLn668sUF2aQzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737729; x=1696342529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aICVyKvuU5JfSIhsWdF89BOR56H3cGACEkieKv3Acq0=;
 b=bBw/3vpfHQ61F8ekD9iVJ2OFx+aGIKqQ/9pgko9bUItDxJhqn9bSwlcHjy//ABmGq2
 8GB6sXAy4SGC+gNKy+uQo0BgimqbWEZYJZgxUZRpyQaJ6AJKN9RduZu/jDOJgR0OOy88
 WBFVkLGabL071tb2tmjttnGg44SNTjSDaAmhBppxHx+PNqMyIUxc3XqIE0guSyAzCjKC
 7tnaemBartfPijTS0VN0nb+2/Z9C0XY1rf2tlkPj/hYinT9l7gV9p0RcL2TTm7hVd/eY
 RUXGdNoIodYpeynOvsnryZHhAvvbgwzvHj6rwOmQRm+h5MTkxuIQ5KIhNctNyhbGt/QI
 ZOHw==
X-Gm-Message-State: AOJu0YyDg7z5i7ElsGkgrd/g4LZVuH+mBDuv8M+CbMUsX8/7Zn8F7jum
 vraR2NiU+1EU6BzNVO7GmFXpQdXun2m+4UJW02A=
X-Google-Smtp-Source: AGHT+IFCS6DmYZj40gjb15qz76cjYFbIO03xO0/S5aorpRIp6KjQ/LtNuH4dESgsQv1OB9WmCe4FeQ==
X-Received: by 2002:a05:6602:19d4:b0:787:8cf:fe8a with SMTP id
 ba20-20020a05660219d400b0078708cffe8amr11400820iob.2.1695737729033; 
 Tue, 26 Sep 2023 07:15:29 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 06/44] spl: Drop #ifdefs for BOARD_INIT and watchdog
Date: Tue, 26 Sep 2023 08:14:20 -0600
Message-ID: <20230926141514.2101787-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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
index 4233390d7de2..68e58c930c28 100644
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

