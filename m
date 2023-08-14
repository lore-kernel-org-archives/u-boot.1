Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A041C04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0587869B0;
	Tue, 15 Aug 2023 00:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kOj1cmIc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E49F3869A5; Tue, 15 Aug 2023 00:41:20 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCD94869A2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-34a8bd1a7fbso9963715ab.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052877; x=1692657677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObBoaP8FnqW/z+VrmliKXw6gBuSgR19Qb1jM7zrkG8A=;
 b=kOj1cmIctCly+VtCSKIWnzXGbaS32YI2pwxqbTASJuqEYudTLbDpaVX+5lzdoGVOjA
 3VBdtnVR0PgD1i0vT5ESCCQRvCWKL0zg/gSieRAStgIMbNWihze2MPo6edouKvEj/E7m
 PxZ9eQOQh+iIy7QFkYMkC9jhhhQxVPd5XEy3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052877; x=1692657677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObBoaP8FnqW/z+VrmliKXw6gBuSgR19Qb1jM7zrkG8A=;
 b=Y0efAU3SBGD45c+p6b8hK6qTN80Tv90JMO3MZ1EgX240RmPQCPfobkUse8J/2Nu67S
 z53MsBkLw0XtX/1QGWp2xyfEjh88iRylWIGdqWKccGqbPELNZFzQtDI4vtSDU/CwmrKp
 L5zNsUINDRu9sc+819gGrUpDOIgERLblg4haepIhn711Fc7oPu/OTmrnB4pkUGsdFol2
 q0w0DOAsAfsq+4Jd4GYzmRKR6D4CN7TGFVBr97w2qMs7KbPQ/x4vDvcn9dSSiS5oTaYj
 y94bcQbjDPnVB9g+gj0SNwYMUhoGStRf39mhtES34ITRrC7NsHycq0cIRTipn+XjoyRY
 YmLw==
X-Gm-Message-State: AOJu0YwkH8HhVlsCm0I2RVRgmCnLy2bSGknDK0we1pB+y4Hx0KIPGrKI
 vekt3C1swN2bgOpM58UZw6pmQyy3bi4IiwGUrxI=
X-Google-Smtp-Source: AGHT+IFT+CIZm2SOQvx0vhbwsGfIXCV5WSe/sSGE7D61Qy3ulVgr2QoNaIjFih56B0iRGuIOjabkhg==
X-Received: by 2002:a05:6e02:d52:b0:349:86b3:c0ae with SMTP id
 h18-20020a056e020d5200b0034986b3c0aemr11866043ilj.9.1692052877545; 
 Mon, 14 Aug 2023 15:41:17 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 02/19] abuf: Allow incrementing the size
Date: Mon, 14 Aug 2023 16:40:22 -0600
Message-ID: <20230814224047.535491-3-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
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

Provide a convenience function to increment the size of the abuf.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/abuf.h  |  9 +++++++++
 lib/abuf.c      |  5 +++++
 test/lib/abuf.c | 25 +++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/abuf.h b/include/abuf.h
index 9badda64e4fa..be98ec78c860 100644
--- a/include/abuf.h
+++ b/include/abuf.h
@@ -90,6 +90,15 @@ void abuf_map_sysmem(struct abuf *abuf, ulong addr, size_t size);
  */
 bool abuf_realloc(struct abuf *abuf, size_t new_size);
 
+/**
+ * abuf_realloc_inc() - Increment abuf size by a given amount
+ *
+ * @abuf: abuf to adjust
+ * @inc: Size incrmement to use (the buffer size will be increased by this much)
+ * Return: true if OK, false if out of memory
+ */
+bool abuf_realloc_inc(struct abuf *abuf, size_t inc);
+
 /**
  * abuf_uninit_move() - Return the allocated contents and uninit the abuf
  *
diff --git a/lib/abuf.c b/lib/abuf.c
index bd270467dd45..ce2cff53dc93 100644
--- a/lib/abuf.c
+++ b/lib/abuf.c
@@ -82,6 +82,11 @@ bool abuf_realloc(struct abuf *abuf, size_t new_size)
 	}
 }
 
+bool abuf_realloc_inc(struct abuf *abuf, size_t inc)
+{
+	return abuf_realloc(abuf, abuf->size + inc);
+}
+
 void *abuf_uninit_move(struct abuf *abuf, size_t *sizep)
 {
 	void *ptr;
diff --git a/test/lib/abuf.c b/test/lib/abuf.c
index 42ee4c175526..42803b20e2a1 100644
--- a/test/lib/abuf.c
+++ b/test/lib/abuf.c
@@ -155,6 +155,31 @@ static int lib_test_abuf_realloc_size(struct unit_test_state *uts)
 }
 LIB_TEST(lib_test_abuf_realloc_size, 0);
 
+/* Test abuf_realloc_inc() */
+static int lib_test_abuf_realloc_inc(struct unit_test_state *uts)
+{
+	struct abuf buf;
+	ulong start;
+
+	start = ut_check_free();
+
+	abuf_init(&buf);
+	ut_asserteq(0, buf.size);
+	ut_asserteq(false, buf.alloced);
+
+	abuf_realloc_inc(&buf, 20);
+	ut_asserteq(20, buf.size);
+	ut_asserteq(true, buf.alloced);
+
+	abuf_uninit(&buf);
+
+	/* Check for memory leaks */
+	ut_assertok(ut_check_delta(start));
+
+	return 0;
+}
+LIB_TEST(lib_test_abuf_realloc_inc, 0);
+
 /* Test handling of buffers that are too large */
 static int lib_test_abuf_large(struct unit_test_state *uts)
 {
-- 
2.41.0.694.ge786442a9b-goog

