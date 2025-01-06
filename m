Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101BBE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB03A80628;
	Mon,  6 Jan 2025 15:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ofqMED2n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E567F801E8; Mon,  6 Jan 2025 15:32:59 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5407805F5
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a9c9f2a569so112915075ab.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173975; x=1736778775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7JFgCrToVg22a995j6Msg/ZskH9tM1+YM/octxERp0=;
 b=ofqMED2nLC7xgPFXJbEipsjMUrIg0fDyHQ3oUKSmRQzpEuaU2ftlDuDQsAajXicUXm
 nAFEUW+Q4sqNkJJewOrVNBn7OHieMjV2HpvHhRfTLHG5WOQppRKH0wg3VA1UQEWV0qoD
 173DBO7bjqyf/Xf84tteRDFCXlaQyfg84EKiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173975; x=1736778775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G7JFgCrToVg22a995j6Msg/ZskH9tM1+YM/octxERp0=;
 b=iceC972WpH/gbXpyYaPgtsNSwRd9hRNhrPKwQpP9rJkkuc1mVpEKiR29K8hTcza71g
 tppV0GTCI3JCqPtEQubyQzE+f9NFZu5u8jF9c6zj5DzqnR5tHf1zMzk997Hb8LzZotwS
 H1hKiFxD+UBwbYtXVn5wgnGKmS+T4y3GrO7u8fEcEYzpkZEhN/UbVRyd67oc8HDmvjL8
 G91ItsB7VCzxZLP+VjNTC6p+M8nGqi7gNP4AcUnURliy2CClFMmP5I01n1DSF1G9BkQR
 GOs7Ekzujlbss6HTqxOvK/igvbcmEsLfZX/TKDXRub+PRufXslVXHeBXCrvXcNX8yp5m
 5Gww==
X-Gm-Message-State: AOJu0Ywdf0QzZfj/GG7gvQahvGCx3X1x2fQFm28WeVUDMYOHvxincvgb
 oYrSxaKZq+uyu2ZesszdPpwain084GwRVEZVR+d/vaUNnGa8DyUENef5Ino/pn0R8SKpIQ9LoSY
 =
X-Gm-Gg: ASbGncsMm8NafvSr/R7mQ40SStKRfdBjWO1uGDCYCoQ+pzWfiaF1d+M0pXIGaOqxGxR
 AUi9pyqI/d73PnOJ/ra/HkWbXFZ6zQEELNnsLIsdSY+PT3gdPMQ/hNEghPIhvC1/robjX1OT/Pm
 cyykfMOnTL0BtDhIax/rvAy9MBPwx2geF4jFdC6V+88MJXSDVpRALTJy4x2OPWpn0Rvzsjzf4fC
 G14AqWcHAz6Ye0HhnvI+2iKdnWps36N9d/eGz8W1OTSD00yVum3PanoMfFlwJZlaDA0blG96p1L
 GZRFSHJ+dnNOCc+TqA==
X-Google-Smtp-Source: AGHT+IG9fkui2F5igMbmv2GS0GPRWnyYF/+iMuaAjNDrtK23nUNbattzUWeuEnBVcKWLZFFDQco8nA==
X-Received: by 2002:a05:6e02:20ca:b0:3a7:7ec0:a3dc with SMTP id
 e9e14a558f8ab-3c2d2d52a7fmr478833315ab.14.1736173974900; 
 Mon, 06 Jan 2025 06:32:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:32:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/33] abuf: Provide a constant buffer
Date: Mon,  6 Jan 2025 07:32:02 -0700
Message-Id: <20250106143229.3023771-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

(no changes since v1)

 include/abuf.h  | 13 +++++++++++++
 lib/abuf.c      |  6 ++++++
 test/lib/abuf.c | 22 ++++++++++++++++++++++
 3 files changed, 41 insertions(+)

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
index 5d61f9261c6..b38690fe1a9 100644
--- a/test/lib/abuf.c
+++ b/test/lib/abuf.c
@@ -46,6 +46,28 @@ static int lib_test_abuf_set(struct unit_test_state *uts)
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
 /* Test abuf_map_sysmem() and abuf_addr() */
 static int lib_test_abuf_map_sysmem(struct unit_test_state *uts)
 {
-- 
2.34.1

