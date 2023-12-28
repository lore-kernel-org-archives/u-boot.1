Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94858C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 09:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28208879DC;
	Thu, 28 Dec 2023 10:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IvzIR9Gc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86BB2879D4; Thu, 28 Dec 2023 10:03:05 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC5187509
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 10:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2cca5e7b390so53551091fa.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 01:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703754182; x=1704358982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CKQ5bqrxmvZF0BN2ybdCYuR+/Wf9nXbyVM/Z5pRChE=;
 b=IvzIR9GcvQ0FKJUkuIb/eRGsVWUJjWcSxhaErzHQZvXqFIz6XPFfVxZZKMInT3lgZ6
 KK7CHy2cz7AGIc40sGi355Bs05HZFt8sQ4PKpX55MYnHyaFi/71VoSJ969UDdzstwhvx
 TSiB6OZ03EynkSrkJw1ivdhszD52bdhAHGjGAhd9ms1tQmF6G4rpxyW3vkySlXTY2/fD
 xzVhb3TvT6fV3dlIFIV5jWAeDg69hO/ADOxDrLwsbe8/oDs8S5XcUGLa8c6sCNXFeNv9
 XVICaYPjddJdlO4E+BLmc0Xec1r/AYLqakzlMq7Vp2dV7LI5PFI4SyCGnVAgczKEB+5y
 3BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703754182; x=1704358982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7CKQ5bqrxmvZF0BN2ybdCYuR+/Wf9nXbyVM/Z5pRChE=;
 b=fn+XMNaPmXINYqvKZsqBc54Z30dddkZ5OHPzBNzGfLzwf7GXefmWjYSjSIKHGVz+bI
 HEBnaOepEJgKUIx/miqsL7a7VbPpwOjyfDVkJ8Xo6XVHSe0bGYWAuPvizRsq0jEL5jUu
 0nKNhsmojXgCt8Q9iTTLPSiuXHZRobpW/Y/eZI+ZvuD2jWaAgXEzkCD6BFropDnVPPo2
 DCOzGhSQn1ESTGKlCjLH0s7k64/SqAUv1/6Ij1Aw7aHq00gGITHiqh7LkPYB+iFrqdxn
 VZ+8vdxPpePT7E6zebbnyHo4vU1OayZLdtnSAoh+J+zIHuYsGEIT7jMv/gNM5Xu+IDct
 892A==
X-Gm-Message-State: AOJu0Yym6cBL74g62fKe9b+JuzuLvtMBn9fGNmQ+73K7y/p1dj4m9aqV
 mqg9Xun8JLIyU/JDHzFdays=
X-Google-Smtp-Source: AGHT+IFQxD0pbcJCG7AmDRVGl6DYwc9mDF9s4NN0PvBBDKuEJncHlzIVteAtzc/+CqyujwInpscEpA==
X-Received: by 2002:a2e:8606:0:b0:2cc:6bbf:ea95 with SMTP id
 a6-20020a2e8606000000b002cc6bbfea95mr3896705lji.62.1703754182378; 
 Thu, 28 Dec 2023 01:03:02 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 n18-20020a2ebd12000000b002ccabe13852sm2475708ljq.85.2023.12.28.01.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 01:03:02 -0800 (PST)
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
Subject: [PATCH v5 3/5] common: console: introduce overflow and isempty calls
Date: Thu, 28 Dec 2023 11:02:38 +0200
Message-Id: <20231228090240.18011-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228090240.18011-1-clamor95@gmail.com>
References: <20231228090240.18011-1-clamor95@gmail.com>
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
index 1ffda49c87..833da61733 100644
--- a/common/console.c
+++ b/common/console.c
@@ -821,6 +821,8 @@ int console_record_init(void)
 	ret = membuff_new((struct membuff *)&gd->console_in,
 			  CONFIG_CONSOLE_RECORD_IN_SIZE);
 
+	gd->flags |= GD_FLG_RECORD;
+
 	return ret;
 }
 
@@ -839,11 +841,13 @@ int console_record_reset_enable(void)
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
@@ -853,6 +857,11 @@ int console_record_avail(void)
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
index e29817e57b..21466d51a9 100644
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
index 628e9dc980..2a3bb8133a 100644
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

