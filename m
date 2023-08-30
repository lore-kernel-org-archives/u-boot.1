Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3442C83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AFDE865A3;
	Wed, 30 Aug 2023 20:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lOq1Ugy2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F45D865A5; Wed, 30 Aug 2023 20:06:00 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB45D8655C
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-79277cfc73bso2149639f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418746; x=1694023546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcrKaxqpQ7198y+xBPjPfYduNZhI1ySLSv0acMUIyXY=;
 b=lOq1Ugy21PUMaqutSeAhWBFUaoIAp9/jIGzbaclxnj4IyCJoEMDOshK82GB7Ntxqqy
 meRRlQh9z8qdARjBUrfIw9IV0j3tqDJgObCrbRtVYp5LF4wjulNF/kHrcJwGVzBgslii
 ZaVV62o5gx7YqBTtfhqppR3mctsoHXl8qDvFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418746; x=1694023546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DcrKaxqpQ7198y+xBPjPfYduNZhI1ySLSv0acMUIyXY=;
 b=XNJw1l9aV8QYSNDydH1VZh9DaQxk6pyl5Q9zeiVBY4G3iqEnQQZSrWtTp/NRr7/Oz4
 M8qDNJhpBEpZp3yvSGXY0brWazBkbh1dcAcCdencC1v4oMq7PPPgQOSdG3gPWoXkebeH
 VFgTW2+W3j8v99EeMfKMB1Ru866yWlXUO85QurG5dinX1pXhbPwl09BSlV1uVImtfsNS
 gevHwn4nalK89Ya7zXuSRoWnDOKpadXQXdr+UWRLHHdI5Rm/f1LO2Sk7tU689MrG6+zm
 3jlDHDthsnaU75nPhNTIfXf/AubIdRX2imYjWCflpi9w9HMoDk2gz3T4mF9tb9TF9mMX
 2unQ==
X-Gm-Message-State: AOJu0YwXgh00uUdklPh5kGlju4nPF5t04ZW+xW6VI3LI6wX0Zv79vD+1
 dLoZQ6vet7+fqmaTQCJe8cr73+nOgZkPbe92URY=
X-Google-Smtp-Source: AGHT+IHkGj3o4HFH0CEXIgRUC3SOXfzDdQYlGqqyAFFxE1nUCFc19fMcTFj7Nb2gIGv9FsQ0oonahw==
X-Received: by 2002:a05:6602:1b14:b0:790:d813:2d38 with SMTP id
 dk20-20020a0566021b1400b00790d8132d38mr3146995iob.11.1693418746442; 
 Wed, 30 Aug 2023 11:05:46 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH 10/32] spl: Remove #ifdefs with BOOTSTAGE
Date: Wed, 30 Aug 2023 12:04:41 -0600
Message-ID: <20230830180524.315916-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

 common/spl/spl.c    | 15 +++------------
 include/bootstage.h | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index f5cef81000c..3e3e13057f1 100644
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
@@ -882,12 +876,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
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
index 685939ccffc..38388afc259 100644
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
2.42.0.rc2.253.gd59a3bf2b4-goog

