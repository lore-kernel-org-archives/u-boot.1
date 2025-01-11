Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22BBE7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDE6280613;
	Sat, 11 Jan 2025 01:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CFBN5IH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F30BF80690; Sat, 11 Jan 2025 01:01:00 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E270480628
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a8ed4c8647so15359235ab.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553653; x=1737158453; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7JFgCrToVg22a995j6Msg/ZskH9tM1+YM/octxERp0=;
 b=CFBN5IH21WDX1N4mG2lUoIp1Iw6pDZzeHAcioeOke3sALbOqq13LcAjiQ5NB8DIHEB
 xyu4Dt3gBpXGMJ6OvRDaeanjFbfvUR6iuLzbu+kFjahfIs23ydC0qGmnHhHPlQmDMYFc
 jELLfSwFyqx2XqQaetHhr3ah+GBgQWaxicouk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553653; x=1737158453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G7JFgCrToVg22a995j6Msg/ZskH9tM1+YM/octxERp0=;
 b=FW0hUMoOtvSAQV10kBf0Dmqn4XsdAJl9TuusDOcaLgGFj0A7ngpoZYN2lT1UbOf42W
 jZ/X3SmgZE0e9gzZEw3FT36uZuVbPG+Uyw9smxGWOaPwz2ti/JJ5/uep+KtQtbk8aMa+
 LDOBZskoxIUwXN2XRJAU+kdwXrkGSbu7D5KsgSgxN/dk95anXCMEhIE4O1Q26eo4BAHJ
 puxqz6357ldWtj/vKiElce1LQ4aFA84TzUH1b2F2Lmg0rw84tloYJzcK2L7AK2BNr3CA
 IFj8/uO5/4N5q446fJkjGc2v0aFsS3C8flq0s3OXMbE8GPlhSmIvlBux4eS4tNPVgFNs
 1Lyg==
X-Gm-Message-State: AOJu0YxAyHXN3P6TGQJS9OcP2DTU3BgyySkFVBoi131buVXS0O7pEcIp
 +p2W1Zc9hFMFxYA8lLHT6s6sql4hJxtLHXF06ClOT9phy1ARVZZc/l/p7jIOVbAd/JAmyzd7dnA
 =
X-Gm-Gg: ASbGncurHcGatFFi3lMpeJxmWgBc/RH9/w8x6GC8GnXjITBLgwKHP8ZuKKHpcsnWdMJ
 zY28JeOeeUTbV2GUcyDnFnP+MLUt9X81PkewjEhZgvS4V2bDlRlFxhxmuL0TYBAKeQVwl2wAfpd
 DqbiELtgIhmv7gpCZPgKjeNftNWTNuMRfNva2LzpGvMNzuBSF9zymecwNojZGIXIIDP4zdwNC47
 RDvkhdeMmeWWrEISEvw7zJ3KGmPdeGEZ34EQUD4tw389JBHvx+h2dgAiPfkPR+bjsldDR0endzj
 RPZCg5kDr6dATKJfNg==
X-Google-Smtp-Source: AGHT+IFRq/pkqBNcaQo48D6lyYR10neNoC4WbImhrjuI516nvQ7qja1JYM3h0GSKcITd3iUdNEViiQ==
X-Received: by 2002:a05:6e02:1a2c:b0:3ab:8f76:bcfd with SMTP id
 e9e14a558f8ab-3ce3a96530amr104258195ab.20.1736553653120; 
 Fri, 10 Jan 2025 16:00:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:00:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 04/30] abuf: Provide a constant buffer
Date: Fri, 10 Jan 2025 17:00:03 -0700
Message-Id: <20250111000029.245022-5-sjg@chromium.org>
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

