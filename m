Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1B8E77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B2980657;
	Sat, 11 Jan 2025 01:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OtxOcVcI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C91E80628; Sat, 11 Jan 2025 01:00:51 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56F218060C
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a813899384so7956995ab.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553647; x=1737158447; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERfXSd7YiSS++3qmVhLnAmzOxsWyZRoAxr+Zqcuuf+c=;
 b=OtxOcVcIp3fko1zUcI1Xjo/WzGvwxriUQGg52eO4wHPAVrda7ROpWNXtB3R6r/aHmO
 QGuc1YJQGIxxT4FAFNPu4lNEGWo32ZhRIqYbi2N91+/0nR2r4NU0jD6xhpaBH0rop8G6
 tBRI1VT+VIMP1KwEM/zrkY7K/nxgBQwE/7H3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553647; x=1737158447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ERfXSd7YiSS++3qmVhLnAmzOxsWyZRoAxr+Zqcuuf+c=;
 b=AT0wKmvaDTBRLI2bcc9ckml0IIbCHlHxysVjemq5UfxSbCTWePunls5n66FXaQEwOg
 HdgYg/n4tBndmQmiPvn685PogxOvQqgwzmnulOZB3tIZ1B4JHY/KD+eUCSoRdHQRS8B1
 3Q6s0Z0k8os2XUyfu989bLP6g9I524X5TJk+K36jJQbVs59JZVn8AKtENYoopDR4fA+/
 pFJD0tF4PWCE9VjPF/37ypVHDc5utmQjpyELyJNZDm5xp1N4AuKOKCi9llJu0wc8PpZL
 W1MaOCGtRBQrfUZIR9LJyzkiWmlRH9lJp1qZMbS6cAzsT7+kqsJQLlATcdSoIPWR+Udc
 z3RQ==
X-Gm-Message-State: AOJu0YyYR2ZlmZDEQnevALv8ZWF4XX+i2UdiUxzN8JJSGVnmXC3rtxLE
 NCbV+JRhbi0A+vIa4yjuKALaNF9ouEeROr9qmNEnxrn3PYa+4bT6CJSNHmQ/OLLG/PvQHmUPAxs
 =
X-Gm-Gg: ASbGncvq3XaKsrPN+B5xWEAXPF3/eHoqpoPBx2oz5sFCFj4erTrO2LGNtCZsw9dS1v4
 UThUVSaYHdnz1exywcn7OMnKionNCdoBKEnT86vdgOPjNkAes/9rdwLEGFcGG7aLiuMIzKl1BZk
 rPC6aJXz6sYPu7IX0pyZw52AhG8Q0poUPBhVa4MkkwkG6DQUVrYYyYHG53JHbvVxYfxkEplHX0Y
 ZCtBR4iyBV5MLv2Ei/MEUcRCcrn4EuhGkuVzUY7oifz7r1C5WuaouPYBdcVdO5Oiea5Yjl2kpCw
 YgIRt/0AoWRCEChEKQ==
X-Google-Smtp-Source: AGHT+IHC+dvT4+BRlJNaQ3x/Jm/ODnpdyxHD3OVo+YGOaGHwrhihsmMmtI5nAR0ONJeoCyy5hOdJpQ==
X-Received: by 2002:a92:c5ce:0:b0:3ce:5a89:33c3 with SMTP id
 e9e14a558f8ab-3ce5a893564mr21864735ab.16.1736553647545; 
 Fri, 10 Jan 2025 16:00:47 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:00:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 02/30] abuf: Provide a way to get the buffer address
Date: Fri, 10 Jan 2025 17:00:01 -0700
Message-Id: <20250111000029.245022-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

In many cases it is useful to get the address of a buffer, e.g. when
booting from it. Add a function to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/abuf.h  | 8 ++++++++
 lib/abuf.c      | 6 ++++++
 test/lib/abuf.c | 4 +++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/abuf.h b/include/abuf.h
index be98ec78c86..76e314b9a47 100644
--- a/include/abuf.h
+++ b/include/abuf.h
@@ -42,6 +42,14 @@ static inline size_t abuf_size(const struct abuf *abuf)
 	return abuf->size;
 }
 
+/**
+ * abuf_addr() - Get the address of a buffer's data
+ *
+ * @abuf: Buffer to check
+ * Return: address of buffer
+ */
+ulong abuf_addr(const struct abuf *abuf);
+
 /**
  * abuf_set() - set the (unallocated) data in a buffer
  *
diff --git a/lib/abuf.c b/lib/abuf.c
index 937c3df351e..8156177c773 100644
--- a/lib/abuf.c
+++ b/lib/abuf.c
@@ -26,6 +26,12 @@ void abuf_map_sysmem(struct abuf *abuf, ulong addr, size_t size)
 {
 	abuf_set(abuf, map_sysmem(addr, size), size);
 }
+
+ulong abuf_addr(const struct abuf *abuf)
+{
+	return map_to_sysmem(abuf->data);
+}
+
 #else
 /* copied from lib/string.c for convenience */
 static char *memdup(const void *src, size_t len)
diff --git a/test/lib/abuf.c b/test/lib/abuf.c
index 7c0481ab610..5d61f9261c6 100644
--- a/test/lib/abuf.c
+++ b/test/lib/abuf.c
@@ -46,7 +46,7 @@ static int lib_test_abuf_set(struct unit_test_state *uts)
 }
 LIB_TEST(lib_test_abuf_set, 0);
 
-/* Test abuf_map_sysmem() */
+/* Test abuf_map_sysmem() and abuf_addr() */
 static int lib_test_abuf_map_sysmem(struct unit_test_state *uts)
 {
 	struct abuf buf;
@@ -60,6 +60,8 @@ static int lib_test_abuf_map_sysmem(struct unit_test_state *uts)
 	ut_asserteq(TEST_DATA_LEN, buf.size);
 	ut_asserteq(false, buf.alloced);
 
+	ut_asserteq(addr, abuf_addr(&buf));
+
 	return 0;
 }
 LIB_TEST(lib_test_abuf_map_sysmem, 0);
-- 
2.34.1

