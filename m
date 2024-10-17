Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31E8D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 271DA891F5;
	Fri, 18 Oct 2024 01:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c6z8E6NW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BE92891EA; Fri, 18 Oct 2024 01:24:48 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12CCA891FC
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83aae6aba1aso61008539f.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207484; x=1729812284; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaCn0wL2Lzg2yoNuc3yyJy6NUrBkyVra8xsebhLU9ZM=;
 b=c6z8E6NWK2DZBL2MtdIyjBCMjp+jr9ccrxi6tU5Oex5R8ditNNke44VjP17rN+du3a
 FChLmZHHyA+/8h0JGhYNBhMMsoO28AcRADVwSXlLndmZCGp/GPDFei/hLkBwIBx/RKp1
 DgfNKNVEAY0Gb6tQP4lQozneHj255FkfWcYZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207484; x=1729812284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaCn0wL2Lzg2yoNuc3yyJy6NUrBkyVra8xsebhLU9ZM=;
 b=uuN/ZozxBvdQIYsUWA7vGSKailGj1QaY1bqtvlrr+rZX2Fpuhb+RNZfIjbxk9LFm5i
 9Y1qiTpu/5pwUlAikGSeEc5OQOFaOigEVH7s1Tt7jS2w1Pk7BBUYfdN9gSwq5K4y946Z
 NbS7eJOuvLHLcEuFz2mDj828vtUjiaszb3xPPfx4afqPu8PLMDzjliSIhI2IfCcgK8JA
 fPcen7cjCDWQs9vi6NRK0kQIWtM3GEmdf7EDbry6Zh7qmbcVtCJm8jfCskwkNGSbq5Vj
 Pg8ZrY2rm7ZaIqOvD2L1JJu61wcQvvC2n2VlL5ME8WNIRJaPiz7pVDmB1jjJPvGNpYeS
 FYHQ==
X-Gm-Message-State: AOJu0YzhekmBj/XzGCJuITMZZuwXMsOFXjAu1poRZrBssKKxjqVYXYP1
 ST7crXev3JiD9ISk2y5JG4f2/SbLv1rQ/9jvBsZNvc4UMN/eHTyqO9h4OiBRxNp6IHZL90WxdO4
 =
X-Google-Smtp-Source: AGHT+IEfTXsGQelglRuL4f9Ln7vtdI5yeXOeLVlunKVdawWxoQWJkX+s9amc2oEf6msv4PvDjaI3Lw==
X-Received: by 2002:a05:6e02:1445:b0:3a0:4db0:ddbf with SMTP id
 e9e14a558f8ab-3a3f40543bcmr3339345ab.8.1729207484438; 
 Thu, 17 Oct 2024 16:24:44 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 07/34] alist: Add a way to efficiently filter an alist
Date: Thu, 17 Oct 2024 17:23:46 -0600
Message-Id: <20241017232413.724808-8-sjg@chromium.org>
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

Unlike linked lists, it is inefficient to remove items from an alist,
particularly if it is large. If most items need to be removed, then the
time-complexity approaches O(n2).

Provide a way to do this efficiently, by working through the alist once
and copying elements down.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/alist.h  | 30 +++++++++++++++++
 lib/alist.c      |  8 +++++
 test/lib/alist.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)

diff --git a/include/alist.h b/include/alist.h
index c639e42ab7d..b00d9ea97d6 100644
--- a/include/alist.h
+++ b/include/alist.h
@@ -274,6 +274,36 @@ bool alist_chk_ptr(const struct alist *lst, const void *ptr);
 	     _pos < alist_end(_lst, typeof(*(_pos))); \
 	     _pos++)
 
+/**
+ * alist_for_each_filter() - version which sets up a 'from' pointer too
+ *
+ * This is used for filtering out information in the list. It works by iterating
+ * through the list, copying elements down over the top of elements to be
+ * deleted.
+ *
+ * In this example, 'from' iterates through the list from start to end,, 'to'
+ * also begins at the start, but only increments if the element at 'from' should
+ * be kept. This provides an O(n) filtering operation. Note that
+ * alist_update_end() must be called after the loop, to update the count.
+ *
+ *	alist_for_each_filter(from, to, &lst) {
+ *		if (from->val != 2)
+ *			*to++ = *from;
+ *	}
+ *	alist_update_end(&lst, to);
+ */
+#define alist_for_each_filter(_pos, _from, _lst) \
+	for (_pos = _from = alist_start(_lst, typeof(*(_pos))); \
+	     _pos < alist_end(_lst, typeof(*(_pos))); \
+	     _pos++)
+
+/**
+ * alist_update_end() - Set the element count based on a given pointer
+ *
+ * Set the given element as the final one
+ */
+void alist_update_end(struct alist *lst, const void *end);
+
 /**
  * alist_empty() - Empty an alist
  *
diff --git a/lib/alist.c b/lib/alist.c
index 32cd45b0b01..4ce651f5c45 100644
--- a/lib/alist.c
+++ b/lib/alist.c
@@ -123,6 +123,14 @@ int alist_calc_index(const struct alist *lst, const void *ptr)
 	return index;
 }
 
+void alist_update_end(struct alist *lst, const void *ptr)
+{
+	int index;
+
+	index = alist_calc_index(lst, ptr);
+	lst->count = index == -1 ? 0 : index;
+}
+
 bool alist_chk_ptr(const struct alist *lst, const void *ptr)
 {
 	int index = alist_calc_index(lst, ptr);
diff --git a/test/lib/alist.c b/test/lib/alist.c
index 87135bb3a51..0bf24578d2e 100644
--- a/test/lib/alist.c
+++ b/test/lib/alist.c
@@ -408,3 +408,88 @@ static int lib_test_alist_empty(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_test_alist_empty, 0);
+
+static int lib_test_alist_filter(struct unit_test_state *uts)
+{
+	struct my_struct *from, *to, *ptr;
+	struct my_struct data;
+	struct alist lst;
+	ulong start;
+	int count;
+
+	start = ut_check_free();
+
+	ut_assert(alist_init_struct(&lst, struct my_struct));
+	data.val = 1;
+	data.other_val = 0;
+	alist_add(&lst, data);
+
+	data.val = 2;
+	alist_add(&lst, data);
+
+	data.val = 3;
+	alist_add(&lst, data);
+	ptr = lst.data;
+
+	/* filter out all values except 2 */
+	alist_for_each_filter(from, to, &lst) {
+		if (from->val != 2)
+			*to++ = *from;
+	}
+	alist_update_end(&lst, to);
+
+	ut_asserteq(2, lst.count);
+	ut_assertnonnull(lst.data);
+
+	ut_asserteq(1, alist_get(&lst, 0, struct my_struct)->val);
+	ut_asserteq(3, alist_get(&lst, 1, struct my_struct)->val);
+	ut_asserteq_ptr(ptr + 3, from);
+	ut_asserteq_ptr(ptr + 2, to);
+
+	/* filter out nothing */
+	alist_for_each_filter(from, to, &lst) {
+		if (from->val != 2)
+			*to++ = *from;
+	}
+	alist_update_end(&lst, to);
+	ut_asserteq_ptr(ptr + 2, from);
+	ut_asserteq_ptr(ptr + 2, to);
+
+	ut_asserteq(2, lst.count);
+	ut_assertnonnull(lst.data);
+
+	ut_asserteq(1, alist_get(&lst, 0, struct my_struct)->val);
+	ut_asserteq(3, alist_get(&lst, 1, struct my_struct)->val);
+
+	/* filter out everything */
+	alist_for_each_filter(from, to, &lst) {
+		if (from->val == 2)
+			*to++ = *from;
+	}
+	alist_update_end(&lst, to);
+	ut_asserteq_ptr(ptr + 2, from);
+	ut_asserteq_ptr(ptr, to);
+
+	/* filter out everything (nop) */
+	count = 0;
+	alist_for_each_filter(from, to, &lst) {
+		if (from->val == 2)
+			*to++ = *from;
+		count++;
+	}
+	alist_update_end(&lst, to);
+	ut_asserteq_ptr(ptr, from);
+	ut_asserteq_ptr(ptr, to);
+	ut_asserteq(0, count);
+
+	ut_asserteq(0, lst.count);
+	ut_assertnonnull(lst.data);
+
+	alist_uninit(&lst);
+
+	/* Check for memory leaks */
+	ut_assertok(ut_check_delta(start));
+
+	return 0;
+}
+LIB_TEST(lib_test_alist_filter, 0);
-- 
2.34.1

