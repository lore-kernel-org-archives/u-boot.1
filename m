Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA71C61D85
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 11:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D11C1875F2;
	Thu, 23 Nov 2023 12:02:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KAVNbWnX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41E118763D; Thu, 23 Nov 2023 12:02:50 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 484058760D
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 12:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c83d37a492so9304651fa.3
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 03:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700737367; x=1701342167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rMAWzmusYUDsZk7ci6JrKCxjHNZYVX0mwEluINib7U=;
 b=KAVNbWnXh7KN/r7bh4HfZ/p0ptLIE3TZoOpdaXUHD0KOzV5RsDr60BlRumpA73Bb4M
 HnRKeqnRwGiL195PN7oOlHwO6fxkSUpNtVJU4etjbzPQTxplCWcbZoMnP3YOPK5CpPgJ
 w3W8IfjQzG/HgzCZf/IFfjb58xHfY+oy8PBQpJPlGADSbBUfbFqLIytoff1Si7TsWziB
 zJTmLhXyqAhHE91hAHQQlHXv4I2f2Yrc43YMib8j3mTD1ElMzT03SdDXS8WFZzhDb1Kp
 5rvLOTTyAXRg7ZHNQfMg8UMdSJqDaii6rsCh749/1O1fz8FD8z4RnsQRWyBAtc0nfi/G
 Yukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700737367; x=1701342167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rMAWzmusYUDsZk7ci6JrKCxjHNZYVX0mwEluINib7U=;
 b=f31fbW2zl9+pDLkzOON0V/H02hSulVpyDATfAsLoWCCnREG09UcMZVMazgW0LgiH4N
 7rBhu3dCQ6LxAugGH6lBX6IdnsrPp90h5lrG10m/HhcgMsw48FgPrOnUPX0wcNftpv67
 Sh4raTUi9ZWZ9RJqS58ngD8bv5vFBzDhN0cveJ3mcHPHHEd1YWtjLOoHO/KHaXLAyw/m
 H3g8U+a5rryPOzYj+GF3vc9iw45KaVnYBVSflVZ4pP/2AeIt2X3St8cTlYdvzWheqW95
 0hsoN4ned5XRfiKZzBiAcdmICQfTgjpXBxYeDwnO0ciFexSdbs4FvP0MgF0n9IX4itvY
 fjUQ==
X-Gm-Message-State: AOJu0YxAMqPdxY36a5PQqqiCLn31SbRsLT+ZgrI+XeuBzE8qELPAOxLq
 QDAtAV/qutweFZtcM+atGSc=
X-Google-Smtp-Source: AGHT+IGHvbP8vTL2YRydEAAZHJkrQARF2PEmybcpsy8QTuVACwGzcKqR+9R+5xRZvajKK20qJoPN8w==
X-Received: by 2002:a19:4359:0:b0:508:11f5:8953 with SMTP id
 m25-20020a194359000000b0050811f58953mr3437295lfj.26.1700737367272; 
 Thu, 23 Nov 2023 03:02:47 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac254a7000000b0050ab61a09f3sm156857lfk.104.2023.11.23.03.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 03:02:47 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 3/5] common: console: introduce overflow and isempty calls
Date: Thu, 23 Nov 2023 13:02:20 +0200
Message-Id: <20231123110222.15116-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231123110222.15116-1-clamor95@gmail.com>
References: <20231123110222.15116-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

Separate record overflow logic and add console_record_isempty
as available calls don't serve to know output has been read
fully with readline's.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 common/console.c  | 15 ++++++++++++---
 include/console.h | 26 ++++++++++++++++++++++++++
 test/ut.c         |  9 ++++-----
 3 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/common/console.c b/common/console.c
index 98c3ee6ca6..8a869b137e 100644
--- a/common/console.c
+++ b/common/console.c
@@ -818,6 +818,8 @@ int console_record_init(void)
 	ret = membuff_new((struct membuff *)&gd->console_in,
 			  CONFIG_CONSOLE_RECORD_IN_SIZE);
 
+	gd->flags |= GD_FLG_RECORD;
+
 	return ret;
 }
 
@@ -836,11 +838,13 @@ int console_record_reset_enable(void)
 	return 0;
 }
 
-int console_record_readline(char *str, int maxlen)
+bool console_record_overflow(void)
 {
-	if (gd->flags & GD_FLG_RECORD_OVF)
-		return -ENOSPC;
+	return gd->flags & GD_FLG_RECORD_OVF ? true : false;
+}
 
+int console_record_readline(char *str, int maxlen)
+{
 	return membuff_readline((struct membuff *)&gd->console_out, str,
 				maxlen, '\0');
 }
@@ -850,6 +854,11 @@ int console_record_avail(void)
 	return membuff_avail((struct membuff *)&gd->console_out);
 }
 
+bool console_record_isempty(void)
+{
+	return membuff_isempty((struct membuff *)&gd->console_out);
+}
+
 int console_in_puts(const char *str)
 {
 	return membuff_put((struct membuff *)&gd->console_in, str, strlen(str));
diff --git a/include/console.h b/include/console.h
index ceb733b5cb..d949d29c13 100644
--- a/include/console.h
+++ b/include/console.h
@@ -64,6 +64,13 @@ void console_record_reset(void);
  */
 int console_record_reset_enable(void);
 
+/**
+ * console_record_overflow() - returns state of buffers overflow
+ *
+ * Return: true if the console buffer was overflowed
+ */
+bool console_record_overflow(void);
+
 /**
  * console_record_readline() - Read a line from the console output
  *
@@ -84,6 +91,13 @@ int console_record_readline(char *str, int maxlen);
  */
 int console_record_avail(void);
 
+/**
+ * console_record_isempty() - Returns if console output is empty
+ *
+ * Return: true if empty
+ */
+bool console_record_isempty(void);
+
 /**
  * console_in_puts() - Write a string to the console input buffer
  *
@@ -113,6 +127,12 @@ static inline int console_record_reset_enable(void)
 	return -ENOSYS;
 }
 
+static inline bool console_record_overflow(void)
+{
+	/* No overflow */
+	return false;
+}
+
 static inline int console_record_readline(char *str, int maxlen)
 {
 	/* Nothing to read */
@@ -131,6 +151,12 @@ static inline int console_in_puts(const char *str)
 	return 0;
 }
 
+static inline bool console_record_isempty(void)
+{
+	/* Always empty */
+	return true;
+}
+
 #endif /* !CONFIG_CONSOLE_RECORD */
 
 /**
diff --git a/test/ut.c b/test/ut.c
index 28da417686..d202644a15 100644
--- a/test/ut.c
+++ b/test/ut.c
@@ -53,15 +53,14 @@ long ut_check_delta(ulong last)
 
 static int readline_check(struct unit_test_state *uts)
 {
-	int ret;
-
-	ret = console_record_readline(uts->actual_str, sizeof(uts->actual_str));
-	if (ret == -ENOSPC) {
+	if (console_record_overflow()) {
 		ut_fail(uts, __FILE__, __LINE__, __func__,
 			"Console record buffer too small - increase CONFIG_CONSOLE_RECORD_OUT_SIZE");
-		return ret;
+		return -ENOSPC;
 	}
 
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+
 	return 0;
 }
 
-- 
2.40.1

