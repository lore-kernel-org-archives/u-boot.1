Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2C5D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4022891F9;
	Fri, 18 Oct 2024 01:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TsyMfyrA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AC0B8920C; Fri, 18 Oct 2024 01:24:47 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DF91891E2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a3b1aa0e80so6259735ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207483; x=1729812283; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvYRn+16TYsytXFWib2sowGdIfm1YBKckCHdso8xtVE=;
 b=TsyMfyrAlzqFzYi0FXhbJKeENFyK9qnI9KHrX4ifncpUKIAX75BJX+u6vIpSg0P/pY
 MzqEOnMUym/t1LL0PW6jkJQm8WX3guK4E/TjZ7ELQzbRaYbnFh7o/u+38SJK/jTT2oS8
 RYO1Qt6zHIPe1rQ/wN8Y2iUXa6rxmBVOW+SGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207483; x=1729812283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HvYRn+16TYsytXFWib2sowGdIfm1YBKckCHdso8xtVE=;
 b=jqbjToYahTzd9tlL9sRBJBOoVNUTKTKBEFUeQsTrlK5xsiwyED08EBa9sVLG5f+LXq
 hRPrqLCPOseFwXgg3f9O85mPnc870mF2Kd/VPe9jTIoaoQB0evNiujlBipNMBOdQiMrb
 OZhCbLVuiGVZhOERrydBanX2jzV5Cx16F9x7NDNJQ310Q6xPtqJXV8DmkcTWmrXWXmAq
 W036gsVUFareK0gz5NTGnlMCQI4mtecANW82LweGtZRA7IyZWJmAQaJuI5Ew8pNKJyJ/
 uWGedSMc77OgLslYvGsTnqxaEPRWExmuH175DU9/ooh7cm3HKgguecNM+WkhO2+gqfLf
 Ds4w==
X-Gm-Message-State: AOJu0YyZtmsqZRaK9zyQYihq38PW/AFGf9W4ZIST62iPtwUb811T64pE
 G/Mm1lgYIEpyX8NZ+l7gjK3TObQOVsyPZByAF5tehgW5RW29gIj7v4bpUxgWY1O3EtbMVDGHRhU
 =
X-Google-Smtp-Source: AGHT+IGtaksu0obOh8/Bd2veddGvUa5E/zQAulfmv5un9wlOnp3p5gW/lyteD2JDfVO5F45/kmvLNQ==
X-Received: by 2002:a05:6e02:1a2a:b0:3a0:b471:9651 with SMTP id
 e9e14a558f8ab-3a3f40ae445mr3946855ab.24.1729207483486; 
 Thu, 17 Oct 2024 16:24:43 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 06/34] alist: Add a function to empty the list
Date: Thu, 17 Oct 2024 17:23:45 -0600
Message-Id: <20241017232413.724808-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

Sometimes it is useful to empty the list without de-allocating any of
the memory used, e.g. when the list will be re-populated immediately
afterwards.

Add a new function for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/alist.h  |  7 +++++++
 lib/alist.c      |  5 +++++
 test/lib/alist.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/alist.h b/include/alist.h
index 0090b9c0eb1..c639e42ab7d 100644
--- a/include/alist.h
+++ b/include/alist.h
@@ -274,6 +274,13 @@ bool alist_chk_ptr(const struct alist *lst, const void *ptr);
 	     _pos < alist_end(_lst, typeof(*(_pos))); \
 	     _pos++)
 
+/**
+ * alist_empty() - Empty an alist
+ *
+ * This removes all entries from the list, without changing the allocated size
+ */
+void alist_empty(struct alist *lst);
+
 /**
  * alist_init() - Set up a new object list
  *
diff --git a/lib/alist.c b/lib/alist.c
index 1a4b4fb9c40..32cd45b0b01 100644
--- a/lib/alist.c
+++ b/lib/alist.c
@@ -41,6 +41,11 @@ void alist_uninit(struct alist *lst)
 	memset(lst, '\0', sizeof(struct alist));
 }
 
+void alist_empty(struct alist *lst)
+{
+	lst->count = 0;
+}
+
 /**
  * alist_expand_to() - Expand a list to the given size
  *
diff --git a/test/lib/alist.c b/test/lib/alist.c
index 1715a22584c..87135bb3a51 100644
--- a/test/lib/alist.c
+++ b/test/lib/alist.c
@@ -358,6 +358,16 @@ static int lib_test_alist_for_each(struct unit_test_state *uts)
 	ptr = lst.data;
 	ut_asserteq_ptr(ptr + 3, alist_end(&lst, struct my_struct));
 
+	/* empty the list and try again */
+	alist_empty(&lst);
+	ut_asserteq_ptr(ptr, alist_end(&lst, struct my_struct));
+	ut_assertnull(alist_get(&lst, 0, struct my_struct));
+
+	sum = 0;
+	alist_for_each(ptr, &lst)
+		sum += ptr->val;
+	ut_asserteq(0, sum);
+
 	alist_uninit(&lst);
 
 	/* Check for memory leaks */
@@ -366,3 +376,35 @@ static int lib_test_alist_for_each(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_test_alist_for_each, 0);
+
+/* Test alist_empty()  */
+static int lib_test_alist_empty(struct unit_test_state *uts)
+{
+	struct my_struct data;
+	struct alist lst;
+	ulong start;
+
+	start = ut_check_free();
+
+	ut_assert(alist_init_struct(&lst, struct my_struct));
+	ut_asserteq(0, lst.count);
+	data.val = 1;
+	data.other_val = 0;
+	alist_add(&lst, data);
+	ut_asserteq(1, lst.count);
+	ut_asserteq(4, lst.alloc);
+
+	alist_empty(&lst);
+	ut_asserteq(0, lst.count);
+	ut_asserteq(4, lst.alloc);
+	ut_assertnonnull(lst.data);
+	ut_asserteq(sizeof(data), lst.obj_size);
+
+	alist_uninit(&lst);
+
+	/* Check for memory leaks */
+	ut_assertok(ut_check_delta(start));
+
+	return 0;
+}
+LIB_TEST(lib_test_alist_empty, 0);
-- 
2.34.1

