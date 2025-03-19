Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BF0C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 11:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E4F819B1;
	Wed, 19 Mar 2025 12:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hP9yX2Q2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F68D810F2; Wed, 19 Mar 2025 12:59:32 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 519B981101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 12:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so3648351f8f.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742385569; x=1742990369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYWd2PmEOERIpf1DzasOzSQqK4l15Wnm4OJyBqNzPy4=;
 b=hP9yX2Q2Lkef65QwbFkRyIaX15Yi4/vJS6sF5py256Uivn2CWNqkECstSdggGbqdQ8
 r4MeUPlDLFQemHF+Fdsbxf0zy9VWmHqrp88ReLU/GwCwRwoQec7/6K4Q75Q5TI0+Hl5c
 3lpQ43Lbu6KQmLdRibpGXQYcCF6L8ZZL7iImw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742385569; x=1742990369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sYWd2PmEOERIpf1DzasOzSQqK4l15Wnm4OJyBqNzPy4=;
 b=dH0IoQ/1iZeSa8OWOcpT5vAty0jBU8B3OQmU6oh53hkNZ25fMWRD+d3ssDWzCMm2yN
 RkqXpQj4U61LPMoMnSyLkuwCr+0tbdFTbW64YNVGlwtW64UFKX1jsY7YuhKe9PWcyXvo
 QscCicrc/1gzPnB1Rnepaa6PsBBiV6OSJ4sv/CaJrIZMfqhxykSyF13QCvsggbndaRaT
 gEN27Onr047Het0d4UctX1HZvJ+q6AfdyhIz8BkietTKFcb5UBdvWgXrnv8NFVnhniEY
 qp47UNXFdlcgDoUDDM4ZrJXJQ3NbWgxl6YKrjVk/HZWsTAaadRRIQyKiZsebdvERRsT6
 WA6g==
X-Gm-Message-State: AOJu0Yx6BPYhduhQWmWEzdiw80vnlwa4p1ljev3wWq3dTAkwNyuzpfwX
 OBaBTKuBqhguDrqgBBB1l2xH5a5Y5oyMNQUu44cfLtLwbUgJSV9/NzfhERxCUoyWILl7asgy1ma
 Mcg==
X-Gm-Gg: ASbGncvpOFogYXi/UzodcM928WsuLRcXMgvlFFg5RD7fQPjc78BxOdfrgwUNlJMnprM
 QLNJi7MCzJpU5RHIMZtx5Lj1JJF/Gnxp9kw/P4g7noVSxRdbFFj5WsVk8K7pRwKfDLWI8ai3aXY
 YZjzCfsmUAcSRfE60rTBVSN4ltqJcMeMsIyDqfsqRpHvRlWb6/QJNF2DPuAKcy8a0uJ4yjE/Xyi
 QodpMhYu4+fJtASDmwXAGGBscB8nM7ZL+7Y/okgt8DuaEwKTUOOwKidVPd6K7Bsdv2FXhFnU73a
 ju+0jNGEf7KBvsO49BXlSxbSBu3IHniIjKdxkDZUsKJ2qZ0MZFwA
X-Google-Smtp-Source: AGHT+IFk+iLFkgVmAigagSq9MuDjIFdReXgMyBu2Pn+RdADcCCEjZz9vB8RimmuLwcy1SpmgY8+MXw==
X-Received: by 2002:a05:6000:2cd:b0:391:2fe3:24ec with SMTP id
 ffacd0b85a97d-399739bc8c0mr2551922f8f.14.1742385569181; 
 Wed, 19 Mar 2025 04:59:29 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ea16csm20606906f8f.82.2025.03.19.04.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 04:59:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/6] abuf: Add a function to copy a buffer
Date: Wed, 19 Mar 2025 12:59:03 +0100
Message-ID: <20250319115911.2204045-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319115911.2204045-1-sjg@chromium.org>
References: <20250319115911.2204045-1-sjg@chromium.org>
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

 include/abuf.h  | 11 +++++++++++
 lib/abuf.c      | 14 ++++++++++++++
 test/lib/abuf.c | 23 +++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/include/abuf.h b/include/abuf.h
index 62ff6499a0c..64189a4e32c 100644
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
index 61adf7fc6b1..503f5004ff8 100644
--- a/lib/abuf.c
+++ b/lib/abuf.c
@@ -119,6 +119,20 @@ void abuf_init_set(struct abuf *abuf, void *data, size_t size)
 	abuf_set(abuf, data, size);
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
index b38690fe1a9..fa6b007248c 100644
--- a/test/lib/abuf.c
+++ b/test/lib/abuf.c
@@ -419,3 +419,26 @@ static int lib_test_abuf_init(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_test_abuf_init, 0);
+
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
-- 
2.43.0

