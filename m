Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD13DD3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3464A892BA;
	Sat, 19 Oct 2024 17:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VW72Xvyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C8178857C; Sat, 19 Oct 2024 17:22:36 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD6858857C
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a3aeb19ea2so11813685ab.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351352; x=1729956152; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inUdQRulOrbHEYpHck8z79rkwITDmA33fHAXe/coi7s=;
 b=VW72XvyqHUkNs4OycSoEpyFcu/7xmxSabpjNmJfQkTN23aNGYCtCi6b0nwqN3bk0Zs
 ce2Tz2pE8aEgAJ5fRkxZ9KgkwScO+407x/6hNarNQP0kO3cW+rKu9nkoLlH7PAFb1sTa
 STYcgEiUTcVdbj/DnPn2CeJz13tvWv25AKF9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351352; x=1729956152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=inUdQRulOrbHEYpHck8z79rkwITDmA33fHAXe/coi7s=;
 b=vyIPCIxHiMYm9hJi5R2Uohp5B+vQ73ct6mVWHV75m02PbtCvHKkQ2Nwel5eLGwe9D1
 ct9fze2tBjyoEBreQorhnZRB7XO9W179b0z4IOcaKDpA53LE8ApQVzwokCG1QM7p8uXo
 Xnq3BRWjR4SYl8XM3i4EcDVurAp8vNNr5EAkrcF8CPTibrGZIhLpfWOCO8MJ6rvAXgDN
 4/8tZdC76RPxbmn9gzM3ZkQhRd9KCYgoq5wO5qmz2fJ6EwwoXLL4eOFi2nS8P599BC0q
 LWczwXG2B0rNnrARVkjpmuQ68k+2tAYNaokvBj2XgzXrTREmWC3j9PxWsEspXL+1hYwj
 BQxw==
X-Gm-Message-State: AOJu0YxLhiFKrdnhizPzF0L1oSXCwV4tMq0FMzHLrsPzRjPiOOJ9eVWZ
 myt4esdmwA9Lv0e7WC3YUZz4wg0Usj/z/3sXbATZf7+Nqx9CbhASWODkJ98heG3WbJAgI+2+GmA
 =
X-Google-Smtp-Source: AGHT+IEZLKg9yVfCSyAwyjDuYBPViluBwUt4sRzw544BpYavOwZJ9VvI/XjthKMBrcBOfcPpJxm6xA==
X-Received: by 2002:a05:6e02:16cf:b0:3a3:c07e:e21b with SMTP id
 e9e14a558f8ab-3a3f40500afmr52593725ab.1.1729351352499; 
 Sat, 19 Oct 2024 08:22:32 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 04/31] alist: Add a way to get the next element
Date: Sat, 19 Oct 2024 09:21:44 -0600
Message-Id: <20241019152211.1014896-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

Add a new function which returns the next element after the one
provided, if it exists in the list.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/alist.h  | 34 +++++++++++++++++++++++++++++++
 lib/alist.c      | 21 +++++++++++++++++++
 test/lib/alist.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/include/alist.h b/include/alist.h
index 2c78ede201e..97523af37a6 100644
--- a/include/alist.h
+++ b/include/alist.h
@@ -71,6 +71,21 @@ static inline bool alist_has(struct alist *lst, uint index)
 	return index < lst->count;
 }
 
+/**
+ * alist_calc_index() - Calculate the index of an item in the list
+ *
+ * The returned element number will be -1 if the list is empty or the pointer
+ * pointers to before the list starts.
+ *
+ * If the pointer points to after the last item, the calculated element-number
+ * will be returned, even though it is greater than lst->count
+ *
+ * @lst: alist to check
+ * @ptr: pointer to check
+ * Return: element number of the pointer
+ */
+int alist_calc_index(const struct alist *lst, const void *ptr);
+
 /**
  * alist_err() - Check if the alist is still valid
  *
@@ -190,6 +205,25 @@ bool alist_expand_by(struct alist *lst, uint inc_by);
 #define alist_add(_lst, _obj)	\
 	((typeof(_obj) *)alist_add_ptr(_lst, &(_obj)))
 
+/** get next entry as a constant */
+#define alist_next(_lst, _objp)	\
+	((const typeof(_objp))alist_next_ptrd(_lst, _objp))
+
+/** get next entry, which can be written to */
+#define alist_nextw(_lst, _objp)	\
+	((typeof(_objp))alist_next_ptrd(_lst, _objp))
+
+/**
+ * alist_next_ptrd() - Get a pointer to the next list element
+ *
+ * This returns NULL if the requested element is beyond lst->count
+ *
+ * @lst: List to check
+ * @ptr: Pointer to current element (must be valid)
+ * Return: Pointer to next element, or NULL if @ptr is the last
+ */
+const void *alist_next_ptrd(const struct alist *lst, const void *ptr);
+
 /**
  * alist_init() - Set up a new object list
  *
diff --git a/lib/alist.c b/lib/alist.c
index b7928cad520..7730fe0d473 100644
--- a/lib/alist.c
+++ b/lib/alist.c
@@ -106,6 +106,27 @@ const void *alist_get_ptr(const struct alist *lst, uint index)
 	return lst->data + index * lst->obj_size;
 }
 
+int alist_calc_index(const struct alist *lst, const void *ptr)
+{
+	uint index;
+
+	if (!lst->count || ptr < lst->data)
+		return -1;
+
+	index = (ptr - lst->data) / lst->obj_size;
+
+	return index;
+}
+
+const void *alist_next_ptrd(const struct alist *lst, const void *ptr)
+{
+	int index = alist_calc_index(lst, ptr);
+
+	assert(index != -1);
+
+	return alist_get_ptr(lst, index + 1);
+}
+
 void *alist_ensure_ptr(struct alist *lst, uint index)
 {
 	uint minsize = index + 1;
diff --git a/test/lib/alist.c b/test/lib/alist.c
index d41845c7e6c..96092affec9 100644
--- a/test/lib/alist.c
+++ b/test/lib/alist.c
@@ -240,3 +240,55 @@ static int lib_test_alist_add(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_test_alist_add, 0);
+
+/* Test alist_next()  */
+static int lib_test_alist_next(struct unit_test_state *uts)
+{
+	const struct my_struct *ptr;
+	struct my_struct data, *ptr2;
+	struct alist lst;
+	ulong start;
+
+	start = ut_check_free();
+
+	ut_assert(alist_init_struct(&lst, struct my_struct));
+	data.val = 123;
+	data.other_val = 0;
+	alist_add(&lst, data);
+
+	data.val = 321;
+	alist_add(&lst, data);
+
+	data.val = 789;
+	alist_add(&lst, data);
+
+	ptr = alist_get(&lst, 0, struct my_struct);
+	ut_assertnonnull(ptr);
+	ut_asserteq(123, ptr->val);
+
+	ptr = alist_next(&lst, ptr);
+	ut_assertnonnull(ptr);
+	ut_asserteq(321, ptr->val);
+
+	ptr2 = (struct my_struct *)ptr;
+	ptr2 = alist_nextw(&lst, ptr2);
+	ut_assertnonnull(ptr2);
+
+	ptr = alist_next(&lst, ptr);
+	ut_assertnonnull(ptr);
+	ut_asserteq(789, ptr->val);
+	ut_asserteq_ptr(ptr, ptr2);
+	ptr2->val = 89;
+	ut_asserteq(89, ptr->val);
+
+	ptr = alist_next(&lst, ptr);
+	ut_assertnull(ptr);
+
+	alist_uninit(&lst);
+
+	/* Check for memory leaks */
+	ut_assertok(ut_check_delta(start));
+
+	return 0;
+}
+LIB_TEST(lib_test_alist_next, 0);
-- 
2.34.1

