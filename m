Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D63C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3098288E7A;
	Wed, 21 Aug 2024 18:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A53Dib7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D78788E5F; Wed, 21 Aug 2024 18:20:02 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F25FA88E2F
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-70944d76a04so586609a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257198; x=1724861998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPi/VIayIRLzCwpRCGHKMiXIYAafogmhaCd7qKqTz2I=;
 b=A53Dib7S4XChIuFKBHHV5GUE72IloshEgrfmbIOpH0xBAgSu92w5w1A/oF+EhWmkRe
 iUSVRW1dbsOu5xl9qbNWawpJx7GaLZ5HJ0nRIK1QUViJEsx0fPE6MV6LoQUwbtG37OX0
 8bjXYHcOXsamYKZifdqBEznJS3vuZgIFZ8gxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257198; x=1724861998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bPi/VIayIRLzCwpRCGHKMiXIYAafogmhaCd7qKqTz2I=;
 b=n50xpE0RwO8wBRhPuRlniXjAJ5Cwex1lJ/K35l8aiNdluqA2deUSXBbHDScu51m1sc
 uWQdEGBN39AZ0tMmh9jd8RtrSKq5xzdVTuLVkpxhR8YIcuWsp6vGOr3itwqQ1f2BA3yi
 W6A/62+aqwvloMZnZN1W6QNfMaofdLgozpR1Qw5F1Vai7Lsp+uunHIE7CYexwRL9wPlf
 xWrWBFFlts04Y6d/03piBpvwgBmZPRrItIPLB5cpvrLgyHXx8Wseop5ubXe3iuBXNIui
 9inpW7qIe8ajWGIBelisWqeWsUCawn8YXvGo2/IBUK7uUvMVjFkbegG8sboJjztJLjEk
 libg==
X-Gm-Message-State: AOJu0YwCpAFfXPyphxIieYCFDieK7xBlsc6C29vc55nsdwGyPH5uZsiD
 Ke+eFRRUzPdkmXDgYLgyZuYlTbeBgYkqODU4Zv4bX8JP4xYKDsg+gnhGz0gIJ3LsMtBRfyETBQw
 =
X-Google-Smtp-Source: AGHT+IHShZ2SCOQ5B14ZzBRq/Cdj0Xtfr66rKkz+znqVodQZXGq8C6x2ELW1Xl7TqSebwzfgg/5Ohg==
X-Received: by 2002:a05:6830:911:b0:703:7888:3e9f with SMTP id
 46e09a7af769-70e01b96ca9mr67814a34.9.1724257198550; 
 Wed, 21 Aug 2024 09:19:58 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 25/35] global_data: log: Reorder and shrink fields
Date: Wed, 21 Aug 2024 10:19:17 -0600
Message-Id: <20240821161927.695717-26-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

(no changes since v1)

 include/asm-generic/global_data.h | 43 +++++++++++++++----------------
 test/log/log_test.c               |  6 ++---
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 06523cab522..253dd21d880 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -339,6 +339,16 @@ struct global_data {
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
@@ -353,44 +363,33 @@ struct global_data {
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

