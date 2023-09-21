Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F743CD493C
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F187E86A26;
	Thu, 21 Sep 2023 03:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jPWSQMdv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C2586D91; Thu, 21 Sep 2023 03:58:00 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E53786D83
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7927611c54bso19609039f.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261473; x=1695866273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BFzSItGDxkpfjOdxUglVy/5ZiMFOgMjwXZ+onDRqB48=;
 b=jPWSQMdvtdatakkPtaFzeCs5jkV89SkMkndRtrMewTY0EnnzkYq2JeWz3CIN7G+UU6
 hQoDiPqC402eZ6FWdovOeu941AAdPzq2ZehJ8EQHL36HOD/eWQSzdJPvgsQLAqnKE84l
 RSP6Wc6qLJJbbp1dWF/raCcK6zbUIbKdi1fxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261473; x=1695866273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFzSItGDxkpfjOdxUglVy/5ZiMFOgMjwXZ+onDRqB48=;
 b=Z9Mo6JIsHtduTV5I4gh7qz/WjOsbGNF6Xd9keffDznmBdLE2lNeEugN0YxjhsTL9O7
 jUqAqpr6gOv8+l/NHafn2PfSGeI+TBpbxkGxvkLyOYHeRy+6OFumArvwLY+63DZ2IYHx
 0tGdJBHUrg1j7Hk60e/QKB3Ld30WDnkq3G0VzcqUjskU7SzdzwNQkXG6J/CK0e3xS9+U
 4Nuw+IogghfQG0RguMGJx5r7wB9vzPmSYAxbXp16v3n5h7aUm+K4E1ngxlIUSIolZbAf
 DeZaMrYB9p9qjfMcL5ls67zP0qHxAIuH7NajbfnxsMW6wsME2VvgZ5YdLdpCmWklyepl
 pZZA==
X-Gm-Message-State: AOJu0Ywf11stEpXAF6Mr0yzZg1fDin+b7STY+wjZNB83QzJo8bk9EGYA
 kbf5JS8MbzDMAegxmHtdtqcS9sOysW2V2FQ70dg=
X-Google-Smtp-Source: AGHT+IH/g9tekgJFE23yv5I2m1IBjbQM3QAFyWwIw6Nxg4aUIsXlplQvA9ZygGtGuqTCPQbuXBoODw==
X-Received: by 2002:a6b:6a09:0:b0:792:9406:a453 with SMTP id
 x9-20020a6b6a09000000b007929406a453mr4398146iog.14.1695261473306; 
 Wed, 20 Sep 2023 18:57:53 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v2 10/32] spl: Remove #ifdefs with BOOTSTAGE
Date: Wed, 20 Sep 2023 19:56:59 -0600
Message-ID: <20230921015730.1511373-11-sjg@chromium.org>
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

This feature has some helpers in its header file so that its functions
resolve to nothing when the feature is disabled. Add a few more and use
these to simplify the code.

With this there are no more #ifdefs in board_init_r()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c    | 15 +++------------
 include/bootstage.h | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 5f57b51ca2d1..8541bef00466 100644
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
index 685939ccffc0..38388afc259b 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -244,6 +244,8 @@ void show_boot_progress(int val);
 
 #ifdef ENABLE_BOOTSTAGE
 
+#include <mapmem.h>
+
 /* This is the full bootstage implementation */
 
 /**
@@ -364,6 +366,20 @@ int bootstage_stash(void *base, int size);
  */
 int bootstage_unstash(const void *base, int size);
 
+static inline int bootstage_stash_default(void)
+{
+	return bootstage_stash(map_sysmem(CONFIG_BOOTSTAGE_STASH_ADDR, 0),
+			       CONFIG_BOOTSTAGE_STASH_SIZE);
+}
+
+static inline int bootstage_unstash_default(void)
+{
+	const void *stash = map_sysmem(CONFIG_BOOTSTAGE_STASH_ADDR,
+				       CONFIG_BOOTSTAGE_STASH_SIZE);
+
+	return bootstage_unstash(stash, CONFIG_BOOTSTAGE_STASH_SIZE);
+}
+
 /**
  * bootstage_get_size() - Get the size of the bootstage data
  *
@@ -440,6 +456,16 @@ static inline int bootstage_unstash(const void *base, int size)
 	return 0;	/* Pretend to succeed */
 }
 
+static inline int bootstage_stash_default(void)
+{
+	return 0;	/* Pretend to succeed */
+}
+
+static inline int bootstage_unstash_default(void)
+{
+	return 0;	/* Pretend to succeed */
+}
+
 static inline int bootstage_get_size(void)
 {
 	return 0;
-- 
2.42.0.515.g380fc7ccd1-goog

