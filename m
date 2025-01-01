Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB871E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18BEB803C6;
	Wed,  1 Jan 2025 23:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PRChkvRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F6CF800D7; Wed,  1 Jan 2025 23:10:58 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0D8480107
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2166360285dso147174685ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769453; x=1736374253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhxGM/1f9N0D4YMJwOKfQUhBc5m7ZkKdk1BuK4zxzvU=;
 b=PRChkvRUfa4DkDnOIpeRy2rvkVUJ+PRauFy3R85MYy+S4/V99AXdrEPnw7TSn7vjR/
 3G8g7cK3wNChaC5HP4Ve0CMFj7seJn5qYmvPnrJDQ6euH/qfmiQS9cAQFfE7+pVNAYFx
 IWMtYKIl4ojYVXvXihls44pPcukHTqgxw1EXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769453; x=1736374253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhxGM/1f9N0D4YMJwOKfQUhBc5m7ZkKdk1BuK4zxzvU=;
 b=tXBlWDQQolkAixYqTUHkLc5ZG2/SOAiPnzVNauqexmeEhVOV+RFLcXjgmeul2QNFMN
 SiNxLzYKwksJ0aAx/BrUf5fF4saxUg16ZKODpVJvTtR7s5mjWIWOBWKAZltc6Su4bwPS
 1Pui0TdxBh1GZZgAQQGFNiE2Abf08Hjd6Uw//K8LRmpz3sHK0A3CbSoJDdA88aD2f/im
 6P27s9Q84RWWkdmT13ZPITNhtEe2sv1R3a/1FxtIJ1etrD7SMWkDZGqN4paNI9W4ZuHn
 P/bLKBGExsjk7kRlwAHn13LmC/W+A8ztakou7i5fKWd2gCu6ygcen9eBnyyy5LYYM7Po
 HCtQ==
X-Gm-Message-State: AOJu0YwaGmWnkceCkSh19YujrQ7nmu36wBM2tf2qVrE5BQBJFseNxxc0
 +GdR24ei2g/bqXUE6o9inPJAZWChQzaVDH/x6KuVhmxyBEK2I+/4cF+be6IpOGkf54kLwfBruqA
 =
X-Gm-Gg: ASbGncsnmuXk9E2CHR/1vDrIgMxeUFGjlp+tA/E9wCGdMlPhBm2sniDpd28kGLbiwUE
 +GoXkV7W5yNYUGuBpQ+XOGL51IP4EwdaxzYILtT99vD2h3FFxBfp2jc4epwYAf4KxNK2y5xCTnq
 aK5pa/s+A/rCRpmfBeQl1haYNfthaYFSWG3LG3jpgj1OrCmzu8M7kAqwMpGIX4RZ/2CJTuq9gmJ
 U6bgvyBKpK77y1Vdv66MAwJMMdjZPnqot+P372e9kugxsDzXr0Bxjg=
X-Google-Smtp-Source: AGHT+IF8Bxk0uiitZQsH3fCIZM3b4R0qS5YTDuatnopvj2YTMV/pnCG1lZCiI8D3fX7tEI9rqwAMng==
X-Received: by 2002:aa7:888c:0:b0:725:f212:12e5 with SMTP id
 d2e1a72fcca58-72abded14e5mr68251815b3a.24.1735769452770; 
 Wed, 01 Jan 2025 14:10:52 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:10:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/67] abuf: Provide a constant buffer
Date: Thu,  2 Jan 2025 11:08:50 +1300
Message-ID: <20250101221003.1944600-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Add a new initialiser which can accept a constant pointer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/abuf.h  | 13 +++++++++++++
 lib/abuf.c      |  6 ++++++
 test/lib/abuf.c | 23 +++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/include/abuf.h b/include/abuf.h
index de21cefade4..62ff6499a0c 100644
--- a/include/abuf.h
+++ b/include/abuf.h
@@ -157,6 +157,19 @@ void abuf_init_move(struct abuf *abuf, void *data, size_t size);
  */
 void abuf_init_set(struct abuf *abuf, void *data, size_t size);
 
+/**
+ * abuf_init_const() - Set up a new const abuf
+ *
+ * Inits a new abuf and sets up its (unallocated) data. The only current
+ * difference between this and abuf_init_set() is the 'data' parameter is a
+ * const pointer. At some point a flag could be used to indicate const-ness.
+ *
+ * @abuf: abuf to set up
+ * @data: New contents of abuf
+ * @size: New size of abuf
+ */
+void abuf_init_const(struct abuf *abuf, const void *data, size_t size);
+
 /**
  * abuf_uninit() - Free any memory used by an abuf
  *
diff --git a/lib/abuf.c b/lib/abuf.c
index 8156177c773..61adf7fc6b1 100644
--- a/lib/abuf.c
+++ b/lib/abuf.c
@@ -119,6 +119,12 @@ void abuf_init_set(struct abuf *abuf, void *data, size_t size)
 	abuf_set(abuf, data, size);
 }
 
+void abuf_init_const(struct abuf *abuf, const void *data, size_t size)
+{
+	/* for now there is no flag indicating that the abuf data is constant */
+	abuf_init_set(abuf, (void *)data, size);
+}
+
 void abuf_init_move(struct abuf *abuf, void *data, size_t size)
 {
 	abuf_init_set(abuf, data, size);
diff --git a/test/lib/abuf.c b/test/lib/abuf.c
index 5d61f9261c6..f954ae16da1 100644
--- a/test/lib/abuf.c
+++ b/test/lib/abuf.c
@@ -46,6 +46,29 @@ static int lib_test_abuf_set(struct unit_test_state *uts)
 }
 LIB_TEST(lib_test_abuf_set, 0);
 
+/* Test abuf_init_const() */
+static int lib_test_abuf_init_const(struct unit_test_state *uts)
+{
+	struct abuf buf;
+	ulong start;
+	void *ptr;
+
+	start = ut_check_free();
+
+	ptr = map_sysmem(0x100, 0);
+
+	abuf_init_const(&buf, ptr, 10);
+	ut_asserteq_ptr(ptr, buf.data);
+	ut_asserteq(10, buf.size);
+
+	/* No memory should have been allocated */
+	ut_assertok(ut_check_delta(start));
+
+	return 0;
+}
+LIB_TEST(lib_test_abuf_init_const, 0);
+
+
 /* Test abuf_map_sysmem() and abuf_addr() */
 static int lib_test_abuf_map_sysmem(struct unit_test_state *uts)
 {
-- 
2.43.0

