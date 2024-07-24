Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E6DC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE6788A09;
	Wed, 24 Jul 2024 17:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CUNk2Pro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1E06889FC; Wed, 24 Jul 2024 17:10:03 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB96388962
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-389ccd2f0abso27271235ab.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833799; x=1722438599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhRBOKpCF7Mo25Z892caRORII9rAwZYniL+mbT2TBxg=;
 b=CUNk2ProyiybgjgEOBE1LlQ0iodCqoo9K2YwFeagwpnSqk3SpZ3LgMwECnuWAya61L
 0KSbvHz5/XARSSakMYRJR95xdK+1KQgS/2ommRSxYvQUzl8ybEdUb4GZZXqZd5K96dQy
 BpF2zRMxsl7AbNDWnTv59NY81F4NPCyFnWTTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833799; x=1722438599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IhRBOKpCF7Mo25Z892caRORII9rAwZYniL+mbT2TBxg=;
 b=EuBfRcLXFZQByI4jgAUzxGmxgtJuzu6x4o+NTCf4i1D4MfL3hs7PhJPMPJXxasexYW
 I0Gn4+bi0ndcGdMEyz6jnhAxJ3Xk0Pi2UlaoVfqY/7cXQjpgysmZdQrAQOjUBr4Hfi2a
 lHd2wPNykKUOnmnrmXjzbSOT4ymGPIEy5OfcmXKfLdlZe7q+2lB3H/tI30W8mwYMcV3j
 fePr+PjZVwtTm2sGSNUxUohp3Po+Uc4N9cZL2MUt+HK1XDQ//YN9dkdJIL+3cbG01eVg
 4M0s+Jo0VdRZqD8CLQy4coo1gqlnbqJCnrNKMcTj/1asvPl73nogHsAqurblsjCbxbwv
 9HNw==
X-Gm-Message-State: AOJu0YziEv/JNbkKf/II70OjkYYIkAEzEGMNsQTqLHO+Ue88gZFXhTJO
 lEw63TF9ybXJ4R8m0U0UyH+WLoMTFuV08dV4eYv5ddtDm/DyeMfKWsdu7ELZ4A9lW0n1ozuvygI
 =
X-Google-Smtp-Source: AGHT+IHRMLKq5raWx58NxpSumu5OgR50DkPe4vTuXKcMVKMFB7JxVlaTanCaRZksrjiwA1Dy7Th3Bw==
X-Received: by 2002:a05:6e02:19c5:b0:374:ada1:295a with SMTP id
 e9e14a558f8ab-398e5a41ae4mr177982865ab.16.1721833799483; 
 Wed, 24 Jul 2024 08:09:59 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH 25/35] global_data: log: Reorder and shrink fields
Date: Wed, 24 Jul 2024 09:09:12 -0600
Message-Id: <20240724150922.2343249-26-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

Some of the logging fields are larger than they need to be. Shrink them
and adjust the ordering to improve alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/asm-generic/global_data.h | 43 +++++++++++++++----------------
 test/log/log_test.c               |  6 ++---
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index c8699c9e963..6ec80a2ccdf 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -338,6 +338,16 @@ struct global_data {
 	struct bootstage_data *bootstage;
 #endif
 #ifdef CONFIG_LOG
+	/**
+	 * @log_head: list of logging devices
+	 */
+	struct list_head log_head;
+	/**
+	 * @log_fmt: bit mask for logging format
+	 *
+	 * The @log_fmt bit mask selects the fields to be shown in log messages.
+	 * &enum log_fmt defines the bits of the bit mask.
+	 */
 	/**
 	 * @log_drop_count: number of dropped log messages
 	 *
@@ -352,44 +362,33 @@ struct global_data {
 	 * For logging devices without filters @default_log_level defines the
 	 * logging level, cf. &enum log_level_t.
 	 */
-	int default_log_level;
-	/**
-	 * @log_head: list of logging devices
-	 */
-	struct list_head log_head;
-	/**
-	 * @log_fmt: bit mask for logging format
-	 *
-	 * The @log_fmt bit mask selects the fields to be shown in log messages.
-	 * &enum log_fmt defines the bits of the bit mask.
-	 */
-	int log_fmt;
-
-	/**
-	 * @processing_msg: a log message is being processed
-	 *
-	 * This flag is used to suppress the creation of additional messages
-	 * while another message is being processed.
-	 */
-	bool processing_msg;
+	char default_log_level;
+	char log_fmt;
 	/**
 	 * @logc_prev: logging category of previous message
 	 *
 	 * This value is used as logging category for continuation messages.
 	 */
-	int logc_prev;
+	unsigned char logc_prev;
 	/**
 	 * @logl_prev: logging level of the previous message
 	 *
 	 * This value is used as logging level for continuation messages.
 	 */
-	int logl_prev;
+	unsigned char logl_prev;
 	/**
 	 * @log_cont: Previous log line did not finished wtih \n
 	 *
 	 * This allows for chained log messages on the same line
 	 */
 	bool log_cont;
+	/**
+	 * @processing_msg: a log message is being processed
+	 *
+	 * This flag is used to suppress the creation of additional messages
+	 * while another message is being processed.
+	 */
+	bool processing_msg;
 #endif
 #if CONFIG_IS_ENABLED(BLOBLIST)
 	/**
diff --git a/test/log/log_test.c b/test/log/log_test.c
index 855353a9c40..2ccc187916f 100644
--- a/test/log/log_test.c
+++ b/test/log/log_test.c
@@ -379,9 +379,9 @@ int log_test_level_deny(struct unit_test_state *uts)
 
 	ut_assertok(console_record_reset_enable());
 	log_run();
-	check_log_entries_flags_levels(EXPECT_LOG | EXPECT_DIRECT | EXPECT_FORCE,
-				       LOGL_WARNING + 1,
-				       min(gd->default_log_level, LOGL_INFO));
+	check_log_entries_flags_levels(
+		EXPECT_LOG | EXPECT_DIRECT | EXPECT_FORCE,
+		LOGL_WARNING + 1, min((int)gd->default_log_level, LOGL_INFO));
 
 	ut_assertok(log_remove_filter("console", filt1));
 	ut_assertok(log_remove_filter("console", filt2));
-- 
2.34.1

