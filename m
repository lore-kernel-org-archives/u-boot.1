Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1019BC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE01182836;
	Fri,  2 May 2025 16:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ic4jU58X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3079482757; Fri,  2 May 2025 16:47:37 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A69C8283E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-85b4170f1f5so72745039f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197253; x=1746802053; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kkdzb3Mwfu+gkmik8YXrQxZwG+bK5y5YFdicmxmbkds=;
 b=ic4jU58XvWtqG5lOF+GSmRyfnecsIkUZeTEb4mhltmheVcC+K+uys2KXC4+Bn0acHu
 jRB1ifhyo9HqC50zkdyW6fTq4odmZCf2M3fi7a5Yoikp/sAeyS6+0ho+9nQcBaadR5L6
 OaqjtxoD9bbCLP9GULMqjiBZUKIZJ3QlgBDmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197253; x=1746802053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kkdzb3Mwfu+gkmik8YXrQxZwG+bK5y5YFdicmxmbkds=;
 b=MXU1t+CVDQOlNKXVUqjGSytU8nQVE5X/zgBMEyKkL5oC9bA6XlOn6tLzTcs1bUcN5e
 zzG+0VQhXqbqAxJlyua6bgzWRptlSt7JhuupDeJBtmGCUKsjzr1UitMaNt0m6kZz1kg4
 UWq14okdUsYLoUPZR735D808GJW95gvgwQ2usLEiv56C02zAWGeLt+Jpj/rgICWd+9oi
 2jk//D3KoWHI6biXz1rReEbHIlHtEh8oX7Z2Cs3FV17aVKyfmxOFR+mGp05qoPbzoPli
 xI74v0pJWzggDem+0/D9xrP+wcGrMDkvLup9t+WVSnDux7ixWxsy50SHdE5c3BztmtIx
 Qq7Q==
X-Gm-Message-State: AOJu0YytU3ZAYKfUOwOz6XTCbNchEdjBYOs1F4V7NvcV7Az+aEJVVplx
 i7eHGloRQCEG15B7yKDyHIJldbdWJ22ViEj4RTCp9DDq4Cu06It6aCmiVARYfSf/Z4TNBIwja74
 =
X-Gm-Gg: ASbGncuth0fDmAZ68H/laAofd28D7LeX/5+O3c2aTHpm6fhqtiJldmueHdAT6ynmG8J
 Aw+GLVT6qzjPKYLjDDyGXrmGhlrUUfgs3WVeI9yebhWim7N3vBSDJA2sTnAU3mtRYka1xxbbCLC
 jE7zQrh/zMx60xdxVx5G7gW8LAR8yBdBY2cVXsXrbzyMTEX+h125DBMVh3H+Oq3TRp8MdJ8bur3
 ASz3nDouU2KQ9D5tjO+vDGId5NFwJddp/ZeBbosM0jD6OX2CMbTntGeIvC+W2xFjOypo2WvnIvC
 1Kt5EYmMCVGIfaMNoG7n2zctdVRAAkBAQ3Xrt/KrboMdzV8kQzel1YN4u2FGJ2+BQs7ggHMvwCH
 eeg==
X-Google-Smtp-Source: AGHT+IFzZXvEYIaJvznbOvKsVVrAx13H41sx85eNLe37Mi/SIXYnSx9S2TUnnD8IDAzsqz2Vdr86Rg==
X-Received: by 2002:a05:6602:3787:b0:85d:b054:6eb9 with SMTP id
 ca18e2360f4ac-866b428f116mr373968339f.14.1746197252801; 
 Fri, 02 May 2025 07:47:32 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/60] abuf: Add a function to copy a buffer
Date: Fri,  2 May 2025 08:46:03 -0600
Message-ID: <20250502144718.313633-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

It is useful to be able to copy an abuf, to allow changes while
preserving the original. Add a function for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/abuf.h  | 11 +++++++++++
 lib/abuf.c      | 14 ++++++++++++++
 test/lib/abuf.c | 23 +++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/include/abuf.h b/include/abuf.h
index 749bb188b0c..bbb3c51f334 100644
--- a/include/abuf.h
+++ b/include/abuf.h
@@ -111,6 +111,17 @@ bool abuf_realloc(struct abuf *abuf, size_t new_size);
  */
 bool abuf_realloc_inc(struct abuf *abuf, size_t inc);
 
+/**
+ * abuf_copy() - Make a copy of an abuf
+ *
+ * Creates an allocated copy of @old in @new
+ *
+ * @old: abuf to copy
+ * @new: new abuf to hold the copy (inited by this function)
+ * Return: true if OK, false if out of memory
+ */
+bool abuf_copy(const struct abuf *old, struct abuf *new);
+
 /**
  * abuf_uninit_move() - Return the allocated contents and uninit the abuf
  *
diff --git a/lib/abuf.c b/lib/abuf.c
index 3cbe320fb08..28c748acb9f 100644
--- a/lib/abuf.c
+++ b/lib/abuf.c
@@ -128,6 +128,20 @@ bool abuf_init_size(struct abuf *buf, size_t size)
 	return true;
 }
 
+bool abuf_copy(const struct abuf *old, struct abuf *copy)
+{
+	char *data;
+
+	data = malloc(old->size);
+	if (!data)
+		return false;
+	memcpy(data, old->data, old->size);
+	abuf_init_set(copy, data, old->size);
+	copy->alloced = true;
+
+	return true;
+}
+
 void abuf_init_const(struct abuf *abuf, const void *data, size_t size)
 {
 	/* for now there is no flag indicating that the abuf data is constant */
diff --git a/test/lib/abuf.c b/test/lib/abuf.c
index 916577ee3ea..c19012d2954 100644
--- a/test/lib/abuf.c
+++ b/test/lib/abuf.c
@@ -420,6 +420,29 @@ static int lib_test_abuf_init(struct unit_test_state *uts)
 }
 LIB_TEST(lib_test_abuf_init, 0);
 
+/* Test abuf_copy() */
+static int lib_test_abuf_copy(struct unit_test_state *uts)
+{
+	struct abuf buf, copy;
+	ulong start;
+
+	start = ut_check_free();
+
+	abuf_init_set(&buf, test_data, TEST_DATA_LEN);
+	ut_assert(abuf_copy(&buf, &copy));
+	ut_asserteq(buf.size, copy.size);
+	ut_assert(buf.data != copy.data);
+	ut_assert(copy.alloced);
+	abuf_uninit(&copy);
+	abuf_uninit(&buf);
+
+	/* Check for memory leaks */
+	ut_assertok(ut_check_delta(start));
+
+	return 0;
+}
+LIB_TEST(lib_test_abuf_copy, 0);
+
 /* Test abuf_init_size() */
 static int lib_test_abuf_init_size(struct unit_test_state *uts)
 {
-- 
2.43.0

