Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1300BC3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B6D880FDE;
	Thu,  1 May 2025 15:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DJidIucu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E65D80FDE; Thu,  1 May 2025 15:37:37 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC6C809A5
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3d948ce7d9dso3481995ab.2
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106653; x=1746711453; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WcYof3VEOzArYo9t/ObUZ7tugbfWVR4YnR8+HBIBh0o=;
 b=DJidIucuUS95ObQ2oH9AxjK2CSiHIuwNWPx2C5fLN3R1nPMClIt+IqAne6uVRo/Rz0
 04q3DL0CuI9ZFGzRoPg8BO+7xwsdrw9uLnfEbF7Jm98CatgbAFmRY81BsgxLayxLX3FV
 blbO5qvX4dnwEWuEiK+QEOe4zfQjbz9p/2PbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106653; x=1746711453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WcYof3VEOzArYo9t/ObUZ7tugbfWVR4YnR8+HBIBh0o=;
 b=T4q4fCmVSp1jeL71aP8aCjexNKU4KpiGlQ7lBdpCIAgk/JMN38rbzj1vINbkwllvzp
 FQ/LVKOGL1U4p10WfhuohlBBHLU7zeWYhUIS+ZSr14AwppUmzZC+2oCduu36rd07ky2e
 nWFowvABaoAmkbRaco3dD4ktvBM7NPZZGVBQ2aLm/gj/Rrg3HiRq25XX9xQ/mFdFRUqO
 Ht8XHlbpOrGUjNWOQCXWsTv40f7UpRmKVxn64tO6Br8Uw+79DbIpRwETR8AXAD0NDC1g
 187KnuYiR1WBL/fzINeUAPN0i2YDotI9SYtghpaZWMpuOrBpaYv9S8bcHOvWm4RunGY7
 9qBg==
X-Gm-Message-State: AOJu0YzJ6FrRXGCdnGprvq66Z2WEnUWgwgGaVXRoyWnfZ1GmMt9BKfBq
 ivHHK/AGz72PZQShbCVzsGACiSQepGzbTmVwyYkqTxJ40T+c31T9l9U6e0fEYIOO9I95zifNP3M
 =
X-Gm-Gg: ASbGnctokRJPYsm2LtP+cfZWuqix21/Df9gt6FgbaL6h66hGu/nYx6RhAoFegZWCKSi
 OcMAYDgGczlBMDCAblPYZAZLwsOCDTzQPF8fZNEZsNOOcciAhMogCXScMFA390QNB8kBFkXTfNp
 KvpFWSye7jusUyA/+EFsSxD7JDXptVSBWwA/KC0d/W1s6Ov37iGAe6ZhXEyW/CxbHG5czzk2Yba
 4KSeLCa/lv+3aHv0MNqjObmoJYMPp+HBV1mC5hIwe/joPwl/q/OXmC1HnFt5NH61v/SEyni3r6w
 NJHRl1s9kFuZXBygK1ydSt6bhOFJOYVo7UgxXmYVF62OFPBVJgDq2v1ZtbxjIvDroIVDK84PP0S
 QSQ==
X-Google-Smtp-Source: AGHT+IGDmJv+tti5FeFskPUEYn6gb/Sf+ScG6gGvjw0ktzRp/hhVhUvNehRXHy8qpwZ40evnxFaKhA==
X-Received: by 2002:a05:6e02:1a6c:b0:3d4:2a4e:1272 with SMTP id
 e9e14a558f8ab-3d9703ba1b1mr30522145ab.19.1746106653218; 
 Thu, 01 May 2025 06:37:33 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/18] abuf: Add a helper for initing and allocating a
 buffer
Date: Thu,  1 May 2025 07:37:01 -0600
Message-ID: <20250501133726.2627373-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501133726.2627373-1-sjg@chromium.org>
References: <20250501133726.2627373-1-sjg@chromium.org>
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

This construct appears in various places. Reduce code size by adding a
function for it.

It inits the abuf, then allocates it to the requested size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch with a helper for initing and allocating a buffer

 boot/cedit.c          |  3 +--
 boot/scene.c          |  3 +--
 boot/scene_textline.c |  3 +--
 include/abuf.h        | 11 +++++++++++
 lib/abuf.c            |  9 +++++++++
 lib/of_live.c         |  3 +--
 test/lib/abuf.c       | 22 ++++++++++++++++++++++
 7 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index d69290c172e..4e80875828b 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -449,8 +449,7 @@ int cedit_write_settings(struct expo *exp, struct abuf *buf)
 	void *fdt;
 	int ret;
 
-	abuf_init(buf);
-	if (!abuf_realloc(buf, CEDIT_SIZE_INC))
+	if (!abuf_init_size(buf, CEDIT_SIZE_INC))
 		return log_msg_ret("buf", -ENOMEM);
 
 	fdt = abuf_data(buf);
diff --git a/boot/scene.c b/boot/scene.c
index 3290a40222a..9034aeeecf2 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -31,8 +31,7 @@ int scene_new(struct expo *exp, const char *name, uint id, struct scene **scnp)
 		return log_msg_ret("name", -ENOMEM);
 	}
 
-	abuf_init(&scn->buf);
-	if (!abuf_realloc(&scn->buf, EXPO_MAX_CHARS + 1)) {
+	if (!abuf_init_size(&scn->buf, EXPO_MAX_CHARS + 1)) {
 		free(scn->name);
 		free(scn);
 		return log_msg_ret("buf", -ENOMEM);
diff --git a/boot/scene_textline.c b/boot/scene_textline.c
index 6adef7cc173..90642a3f03d 100644
--- a/boot/scene_textline.c
+++ b/boot/scene_textline.c
@@ -31,8 +31,7 @@ int scene_textline(struct scene *scn, const char *name, uint id, uint max_chars,
 			    (struct scene_obj **)&tline);
 	if (ret < 0)
 		return log_msg_ret("obj", -ENOMEM);
-	abuf_init(&tline->buf);
-	if (!abuf_realloc(&tline->buf, max_chars + 1))
+	if (!abuf_init_size(&tline->buf, max_chars + 1))
 		return log_msg_ret("buf", -ENOMEM);
 	buf = abuf_data(&tline->buf);
 	*buf = '\0';
diff --git a/include/abuf.h b/include/abuf.h
index 62ff6499a0c..749bb188b0c 100644
--- a/include/abuf.h
+++ b/include/abuf.h
@@ -170,6 +170,17 @@ void abuf_init_set(struct abuf *abuf, void *data, size_t size);
  */
 void abuf_init_const(struct abuf *abuf, const void *data, size_t size);
 
+/**
+ * abuf_init_size() - Set up an allocated abuf
+ *
+ * Init a new abuf and allocate its size.
+ *
+ * @abuf: abuf to set up
+ * @data: New contents of abuf
+ * @size: New size of abuf
+ */
+bool abuf_init_size(struct abuf *buf, size_t size);
+
 /**
  * abuf_uninit() - Free any memory used by an abuf
  *
diff --git a/lib/abuf.c b/lib/abuf.c
index 61adf7fc6b1..3cbe320fb08 100644
--- a/lib/abuf.c
+++ b/lib/abuf.c
@@ -119,6 +119,15 @@ void abuf_init_set(struct abuf *abuf, void *data, size_t size)
 	abuf_set(abuf, data, size);
 }
 
+bool abuf_init_size(struct abuf *buf, size_t size)
+{
+	abuf_init(buf);
+	if (!abuf_realloc(buf, size))
+		return false;
+
+	return true;
+}
+
 void abuf_init_const(struct abuf *abuf, const void *data, size_t size)
 {
 	/* for now there is no flag indicating that the abuf data is constant */
diff --git a/lib/of_live.c b/lib/of_live.c
index bc8c73c6f36..470a687047b 100644
--- a/lib/of_live.c
+++ b/lib/of_live.c
@@ -448,8 +448,7 @@ int of_live_flatten(const struct device_node *root, struct abuf *buf)
 {
 	int ret;
 
-	abuf_init(buf);
-	if (!abuf_realloc(buf, BUF_STEP))
+	if (!abuf_init_size(buf, BUF_STEP))
 		return log_msg_ret("ini", -ENOMEM);
 
 	ret = fdt_create(abuf_data(buf), abuf_size(buf));
diff --git a/test/lib/abuf.c b/test/lib/abuf.c
index b38690fe1a9..916577ee3ea 100644
--- a/test/lib/abuf.c
+++ b/test/lib/abuf.c
@@ -419,3 +419,25 @@ static int lib_test_abuf_init(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_test_abuf_init, 0);
+
+/* Test abuf_init_size() */
+static int lib_test_abuf_init_size(struct unit_test_state *uts)
+{
+	struct abuf buf;
+	ulong start;
+
+	start = ut_check_free();
+
+	ut_assert(abuf_init_size(&buf, TEST_DATA_LEN));
+	ut_assertnonnull(buf.data);
+	ut_asserteq(TEST_DATA_LEN, buf.size);
+	ut_asserteq(true, buf.alloced);
+	abuf_uninit(&buf);
+
+	/* Check for memory leaks */
+	ut_assertok(ut_check_delta(start));
+
+	return 0;
+	return 0;
+}
+LIB_TEST(lib_test_abuf_init_size, 0);
-- 
2.43.0

