Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E34D3C544
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589E2891FE;
	Fri, 18 Oct 2024 05:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RRo3OuC+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EEA2891D6; Fri, 18 Oct 2024 05:01:00 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEAC489185
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8377fd760b0so70925639f.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729220456; x=1729825256; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ip4+ktqZQhWruRrKpGg/HbeYFhN5SF7dwYvgmNqSl9M=;
 b=RRo3OuC+w2Gj+b8PUtxHMz8ZBughxjncdVF0MChakvEOenj7dDIfRcsbg4EJHwVhS6
 V+bu6D6uDaWsah2drTDaHRwZhuC5xdIgKHogxEp8BrSnSm6iyT0QPb2WlG0AT0K0A9YX
 AeaiL6lZgpwlKCfCuiM0FUXaPOVma74yDv9es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729220456; x=1729825256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ip4+ktqZQhWruRrKpGg/HbeYFhN5SF7dwYvgmNqSl9M=;
 b=M0+LuXcdhV741srCEAEqwPFaQQkPlF3Q3DM61hWrt9C2bfqruts18+XmKYxPglzkNP
 187OeFzC2jGqcycmdAVPs7D0X2+qa+mKRlw8vf8GV0MvPr3OwRD1bzioeG5pd5jW1YVZ
 G9E0KhLF7NjHIpUElnkBcJOFN5Cg98hBhE9Bn/ugtquYfV6DLPugiVCH+EMDhSSO4yy5
 jwJ59V6X9bUQM6O9IUNPKjogvSGom77ZeyLMdHvYDisRj1hIqODUC0+MeJI1XS9ewc6G
 r4uALNX65dBKmIjgNmcQgGkyrPkMKnOAHhWV/3pSTpZ6zQW0gR7xejtpFVNCS/FKcePX
 oL5A==
X-Gm-Message-State: AOJu0YxYqVe9XF93o8Dou7yAF8tQBgHlaVU53PuAvQYiZaSPhthxh7hf
 WsH2guUGO+ffc/jZPlo/g6pqbRyuaju+8H/ljRXOLPzg8fxBgrrKCgTP8iBgbcNUE/kymjuLVXE
 =
X-Google-Smtp-Source: AGHT+IHeKw86/hiz50DJ4vicC75w7U5iVfPwXarcj+UxeRL2lIjivNomVAVdO66zUrZ0pav4FMSCXA==
X-Received: by 2002:a05:6602:1584:b0:83a:b43b:da89 with SMTP id
 ca18e2360f4ac-83aba63ff0cmr79434939f.10.1729220456350; 
 Thu, 17 Oct 2024 20:00:56 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83e6dsm192499173.39.2024.10.17.20.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 20:00:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Ion Agorria <ion@agorria.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 8/8] membuf: Support a flag for being full
Date: Thu, 17 Oct 2024 21:00:27 -0600
Message-Id: <20241018030027.842749-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018030027.842749-1-sjg@chromium.org>
References: <20241018030027.842749-1-sjg@chromium.org>
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

At present the membuf implementation wastes a slot in the fifo so it can
detect the difference between a full and an empty buffer.

Add the option of supporting a boolean flag, if desired. For now it is
off.

The code-size penalty is non-zero, but the space penalty is small and
could be reduced on 64-bit machines by using a u32 offset for head and
tail.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/membuf.h  |  6 +++++
 lib/membuf.c      | 63 ++++++++++++++++++++++++++++++++++++++---------
 test/lib/membuf.c | 11 ++++++---
 3 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/include/membuf.h b/include/membuf.h
index 46764690f53..b495a72652b 100644
--- a/include/membuf.h
+++ b/include/membuf.h
@@ -11,6 +11,9 @@
 
 #include <stdbool.h>
 
+/* Set this to 1 to support a 'full' flag */
+#define MEMBUF_FULL	0
+
 /**
  * @struct membuf: holds the state of a membuff - it is used for input and
  * output buffers. The buffer extends from @start to (@start + @size - 1).
@@ -36,6 +39,9 @@ struct membuf {
 	char *end;		/** the end of the buffer (start + length) */
 	char *head;		/** current buffer head */
 	char *tail;		/** current buffer tail */
+#if MEMBUF_FULL
+	bool full;		/** true if full (for when head == tail) */
+#endif
 };
 
 /**
diff --git a/lib/membuf.c b/lib/membuf.c
index f38ff36cb0b..016430ae988 100644
--- a/lib/membuf.c
+++ b/lib/membuf.c
@@ -11,11 +11,28 @@
 #include <malloc.h>
 #include "membuf.h"
 
+static inline bool is_full(const struct membuf *mb)
+{
+#if MEMBUF_FULL
+	return mb->full;
+#else
+	return false;
+#endif
+}
+
+static inline void set_full(struct membuf *mb, bool full)
+{
+#if MEMBUF_FULL
+	mb->full = full;
+#endif
+}
+
 void membuf_purge(struct membuf *mb)
 {
 	/* set mb->head and mb->tail so the buffers look empty */
 	mb->head = mb->start;
 	mb->tail = mb->start;
+	set_full(mb, false);
 }
 
 static int membuf_putrawflex(struct membuf *mb, int maxlen, bool update,
@@ -36,21 +53,29 @@ static int membuf_putrawflex(struct membuf *mb, int maxlen, bool update,
 	 * if head is ahead of tail, we can write from head until the end of
 	 * the buffer
 	 */
-	if (mb->head >= mb->tail) {
+	if (mb->head >= mb->tail && !is_full(mb)) {
 		/* work out how many bytes can fit here */
-		len = mb->end - mb->head - 1;
+		len = mb->end - mb->head;
+		if (!MEMBUF_FULL)
+			len--;
 		if (maxlen >= 0 && len > maxlen)
 			len = maxlen;
 
 		/* update the head pointer to mark these bytes as written */
-		if (update)
+		if (update) {
 			mb->head += len;
+			if (mb->head == mb->end)
+				mb->head = mb->start;
+			if (len && mb->head == mb->tail)
+				set_full(mb, true);
+		}
 
 		/*
 		 * if the tail isn't at start of the buffer, then we can
 		 * write one more byte right at the end
 		 */
-		if ((maxlen < 0 || len < maxlen) && mb->tail != mb->start) {
+		if (!MEMBUF_FULL && (maxlen < 0 || len < maxlen) &&
+		    mb->tail != mb->start) {
 			len++;
 			if (update)
 				mb->head = mb->start;
@@ -59,13 +84,18 @@ static int membuf_putrawflex(struct membuf *mb, int maxlen, bool update,
 	/* otherwise now we can write until head almost reaches tail */
 	} else {
 		/* work out how many bytes can fit here */
-		len = mb->tail - mb->head - 1;
+		len = mb->tail - mb->head;
+		if (!MEMBUF_FULL)
+			len--;
 		if (maxlen >= 0 && len > maxlen)
 			len = maxlen;
 
 		/* update the head pointer to mark these bytes as written */
-		if (update)
+		if (update) {
 			mb->head += len;
+			if (MEMBUF_FULL && len && mb->head == mb->tail)
+				set_full(mb, true);
+		}
 	}
 
 	/* return the number of bytes which can be/must be written */
@@ -125,7 +155,7 @@ int membuf_getraw(struct membuf *mb, int maxlen, bool update, char **data)
 	 * and some more data between 'start' and 'head'(which we can't
 	 * return this time
 	 */
-	else if (mb->head < mb->tail) {
+	else if (is_full(mb) || mb->head < mb->tail) {
 		/* work out the amount of data */
 		*data = mb->tail;
 		len = mb->end - mb->tail;
@@ -135,6 +165,8 @@ int membuf_getraw(struct membuf *mb, int maxlen, bool update, char **data)
 			mb->tail += len;
 			if (mb->tail == mb->end)
 				mb->tail = mb->start;
+			if (len)
+				set_full(mb, false);
 		}
 	}
 
@@ -205,7 +237,7 @@ int membuf_put(struct membuf *mb, const char *buff, int length)
 
 bool membuf_isempty(struct membuf *mb)
 {
-	return mb->head == mb->tail;
+	return !is_full(mb) && mb->head == mb->tail;
 }
 
 int membuf_avail(struct membuf *mb)
@@ -230,6 +262,9 @@ int membuf_size(struct membuf *mb)
 	return mb->end - mb->start;
 }
 
+#if MEMBUF_FULL == 0
+/* This has not been updated for MEMBUF_FULL */
+
 bool membuf_makecontig(struct membuf *mb)
 {
 	int topsize, botsize;
@@ -280,11 +315,12 @@ bool membuf_makecontig(struct membuf *mb)
 	/* all ok */
 	return true;
 }
+#endif
 
 int membuf_free(struct membuf *mb)
 {
 	return mb->end == mb->start ? 0 :
-			(mb->end - mb->start) - 1 - membuf_avail(mb);
+		(mb->end - mb->start) - MEMBUF_FULL - membuf_avail(mb);
 }
 
 int membuf_readline(struct membuf *mb, char *str, int maxlen, int minch,
@@ -295,7 +331,7 @@ int membuf_readline(struct membuf *mb, char *str, int maxlen, int minch,
 	bool ok = false;
 	char *orig = str;
 
-	end = mb->head >= mb->tail ? mb->head : mb->end;
+	end = mb->head < mb->tail || is_full(mb) ? mb->end : mb->head;
 	for (len = 0, s = mb->tail; s < end && len < maxlen - 1; str++) {
 		*str = *s++;
 		len++;
@@ -303,7 +339,7 @@ int membuf_readline(struct membuf *mb, char *str, int maxlen, int minch,
 			ok = true;
 			break;
 		}
-		if (s == end && mb->tail > mb->head) {
+		if (s == end && (is_full(mb) || mb->tail > mb->head)) {
 			s = mb->start;
 			end = mb->head;
 		}
@@ -319,6 +355,8 @@ int membuf_readline(struct membuf *mb, char *str, int maxlen, int minch,
 	/* terminate the string, update the membuff and return success */
 	*str = '\0';
 	mb->tail = s == mb->end ? mb->start : s;
+	if (len)
+		set_full(mb, false);
 
 	return len;
 }
@@ -350,9 +388,10 @@ int membuf_extend_by(struct membuf *mb, int by, int max)
 	mb->head = mb->start + oldhead;
 	mb->tail = mb->start + oldtail;
 
-	if (mb->head < mb->tail) {
+	if (is_full(mb) || mb->head < mb->tail) {
 		memmove(mb->tail + by, mb->tail, orig - oldtail);
 		mb->tail += by;
+		set_full(mb, false);
 	}
 	mb->end = mb->start + size;
 
diff --git a/test/lib/membuf.c b/test/lib/membuf.c
index 3f268a422d5..f36332ff7b6 100644
--- a/test/lib/membuf.c
+++ b/test/lib/membuf.c
@@ -23,6 +23,11 @@ static void membuf_zero(struct membuf *mb)
 static int membuf_check(struct unit_test_state *uts, struct membuf *mb,
 			int value)
 {
+	/* says it is full, but can't be */
+#if MEMBUF_FULL
+	ut_assert(!(mb->full && mb->head != mb->tail));
+#endif
+
 	/* head is out of range */
 	ut_assert(!(mb->head < mb->start || mb->head >= mb->end));
 
@@ -47,7 +52,7 @@ static int lib_test_membuf_one(struct unit_test_state *uts)
 		in[i + TEST_SIZE] = in[i];
 	}
 
-	test_size = TEST_SIZE;
+	test_size = TEST_SIZE + MEMBUF_FULL;
 
 	for (i = 1; i < TEST_COUNT; i++) {
 		membuf_zero(&mb);
@@ -92,7 +97,7 @@ static int lib_test_membuf_random(struct unit_test_state *uts)
 		in[i + TEST_SIZE] = in[i];
 	}
 
-	test_size = TEST_SIZE;
+	test_size = TEST_SIZE + MEMBUF_FULL;
 
 	inptr = in;
 	outptr = in;
@@ -145,7 +150,7 @@ static int lib_test_membuf_extend(struct unit_test_state *uts)
 		in[i + TEST_SIZE] = in[i];
 	}
 
-	test_size = TEST_SIZE - 1;
+	test_size = TEST_SIZE - 1 + MEMBUF_FULL;
 
 	for (cur = 0; cur <= test_size; cur++) {
 		ut_assertok(membuf_new(&mb, TEST_SIZE));
-- 
2.34.1

