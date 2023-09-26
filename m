Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C42AE7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E86CA86DD8;
	Tue, 26 Sep 2023 16:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kfrmip92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E13AA86DEB; Tue, 26 Sep 2023 16:15:50 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6342486E08
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79fa387fb96so249934139f.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737741; x=1696342541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oNZ/rC1d4uYF9bMkPQ1GaRq9yc1K++MbQ8rjcrJJ9KY=;
 b=kfrmip92IUjEDP4fju4T+awq//XUjvT8top3iP1PiAmeLLjUIQS1UncytHmQlHIQTi
 jGSe9i+QVTxt+Xe/CQX2MvYo/pm6hRCSSJFrhZGcTXmefJxN1sJmvL6s2cGn3CcYrNCP
 60oYSCFqBQt4MrNkFbr7j3Qvfc8Yt6kgIPDS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737741; x=1696342541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oNZ/rC1d4uYF9bMkPQ1GaRq9yc1K++MbQ8rjcrJJ9KY=;
 b=thicotTu0YKnWPKQ1xqNQ2WQ0T+OEY+C47PVaDKaJGs7nKgYSklS+wejIhMrejkk5L
 SzIxSTnZthw/K6ZQQCY5pDV+mm7PMd4vdF7i8yNKc9AaAqGL7r+pwhKDTJzrhlaISMzL
 Z1RHIE9BlXnfWKTmTVm1QSlSvYzzGKkudou0AXZDyirLhrTN/ZmxdS1cChdw/PAXQFWJ
 LqHzJjhlcwLc3pNyZSOkGTJcro/y2atmOVOEYoVTP7iJBvbukRcyoXvUXvoubVuh3U4i
 0Nh1084O7dnQV1810JRU18KTGEKokQurL4Jg+Y3R/3H5MT9HgTL7NQfDxvQ8PDNAu9fK
 xJ7Q==
X-Gm-Message-State: AOJu0YwpZJURWtn5NMI7azsswXksi7nkKN71KTtiFhAhoyalRYPgP8/u
 tWW5gUkWcWSbHnxfdJidZir5x1fE9kQLwc0Lz94=
X-Google-Smtp-Source: AGHT+IGYblu3dh4VEWMB7K8lhESDjlv2JabLZ5ItTI9tf+ItxAmgBdpZC1Hjob6kevBPS0yfzRfVLQ==
X-Received: by 2002:a5d:9c17:0:b0:798:d82b:7b02 with SMTP id
 23-20020a5d9c17000000b00798d82b7b02mr11396077ioe.4.1695737741762; 
 Tue, 26 Sep 2023 07:15:41 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 18/44] spl: Remove #ifdefs with BOOTSTAGE
Date: Tue, 26 Sep 2023 08:14:32 -0600
Message-ID: <20230926141514.2101787-19-sjg@chromium.org>
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

This feature has some helpers in its header file so that its functions
resolve to nothing when the feature is disabled. Add a few more and use
these to simplify the code.

With this there are no more #ifdefs in board_init_r()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Take account of CONFIG_BOOTSTAGE_STASH for stashing, to avoid size inc

 common/bootstage.c  | 14 ++++++++++++++
 common/spl/spl.c    | 15 +++------------
 include/bootstage.h | 22 ++++++++++++++++++++++
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/common/bootstage.c b/common/bootstage.c
index 326c40f1561f..a68d883c684c 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -502,6 +502,20 @@ int bootstage_unstash(const void *base, int size)
 	return 0;
 }
 
+int _bootstage_stash_default(void)
+{
+	return bootstage_stash(map_sysmem(CONFIG_BOOTSTAGE_STASH_ADDR, 0),
+			       CONFIG_BOOTSTAGE_STASH_SIZE);
+}
+
+int _bootstage_unstash_default(void)
+{
+	const void *stash = map_sysmem(CONFIG_BOOTSTAGE_STASH_ADDR,
+				       CONFIG_BOOTSTAGE_STASH_SIZE);
+
+	return bootstage_unstash(stash, CONFIG_BOOTSTAGE_STASH_SIZE);
+}
+
 int bootstage_get_size(void)
 {
 	struct bootstage_data *data = gd->bootstage;
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 2c36caa856fa..e8044b821635 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -542,17 +542,11 @@ static int spl_common_init(bool setup_malloc)
 		      ret);
 		return ret;
 	}
-#ifdef CONFIG_BOOTSTAGE_STASH
 	if (!u_boot_first_phase()) {
-		const void *stash = map_sysmem(CONFIG_BOOTSTAGE_STASH_ADDR,
-					       CONFIG_BOOTSTAGE_STASH_SIZE);
-
-		ret = bootstage_unstash(stash, CONFIG_BOOTSTAGE_STASH_SIZE);
+		ret = bootstage_unstash_default();
 		if (ret)
-			debug("%s: Failed to unstash bootstage: ret=%d\n",
-			      __func__, ret);
+			log_debug("Failed to unstash bootstage: ret=%d\n", ret);
 	}
-#endif /* CONFIG_BOOTSTAGE_STASH */
 	bootstage_mark_name(get_bootstage_id(true),
 			    spl_phase_name(spl_phase()));
 #if CONFIG_IS_ENABLED(LOG)
@@ -870,12 +864,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		      gd_malloc_ptr(), gd_malloc_ptr() / 1024);
 
 	bootstage_mark_name(get_bootstage_id(false), "end phase");
-#ifdef CONFIG_BOOTSTAGE_STASH
-	ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
-			      CONFIG_BOOTSTAGE_STASH_SIZE);
+	ret = bootstage_stash_default();
 	if (ret)
 		debug("Failed to stash bootstage: err=%d\n", ret);
-#endif
 
 	if (IS_ENABLED(CONFIG_SPL_VIDEO_REMOVE)) {
 		struct udevice *dev;
diff --git a/include/bootstage.h b/include/bootstage.h
index 685939ccffc0..f9376c320c96 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -244,6 +244,8 @@ void show_boot_progress(int val);
 
 #ifdef ENABLE_BOOTSTAGE
 
+#include <mapmem.h>
+
 /* This is the full bootstage implementation */
 
 /**
@@ -452,6 +454,26 @@ static inline int bootstage_init(bool first)
 
 #endif /* ENABLE_BOOTSTAGE */
 
+/* helpers for SPL */
+int _bootstage_stash_default(void);
+int _bootstage_unstash_default(void);
+
+static inline int bootstage_stash_default(void)
+{
+	if (CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH))
+		return _bootstage_stash_default();
+
+	return 0;
+}
+
+static inline int bootstage_unstash_default(void)
+{
+	if (CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH))
+		return _bootstage_unstash_default();
+
+	return 0;
+}
+
 /* Helper macro for adding a bootstage to a line of code */
 #define BOOTSTAGE_MARKER()	\
 		bootstage_mark_code(__FILE__, __func__, __LINE__)
-- 
2.42.0.515.g380fc7ccd1-goog

