Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1508D3C916
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F387892D4;
	Sat, 19 Oct 2024 17:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RzL7CxTk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D53CE891E6; Sat, 19 Oct 2024 17:22:37 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BAE887D1A
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a3b2499c65so10863255ab.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351354; x=1729956154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NrRcGlIEvl5SianWkpmMh9RiVJkWblfH8EROUDgyNFI=;
 b=RzL7CxTk9vEOksTIl26eR5uXVUKEed6JHV5vQQ/FwJi+nrHoR/UUrTxt4ViBDbh8Z8
 iiF68FN5dcq895SyBEtC3viLbrzsB2EDoMeHu2A3R3wRX5kXMGV4RqklxYL4Rr7teC6L
 Z8fG5s0feWkvuNyL68wQqt/mPu0JpP+nNDosM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351354; x=1729956154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NrRcGlIEvl5SianWkpmMh9RiVJkWblfH8EROUDgyNFI=;
 b=QIRKAxb5ynhh3akCxpoCYir1gTEtGUVAfIAmUAYMYfYX8vtm70os7CG4OBdhtc8gg+
 wm0gU1dhoTrn0Pxust23CTNEMUsSSz7vuhxvu4+bLOoASRK4hLK53s7zaF08CE4CzRTk
 i6eZroBLFzcHs2cH21TZ2u11vym/x9aIz2Cj8TBXhs8X3jrgIbmqkmYLoptIWkXfGtEF
 +ImoiazwyR9OGP2QvmajKjpURVOzsbrPzRfWHfrwQ3DxB6It7AwUiBTW2F8Wz/v21FYd
 MvtugRVHzJTMsO7zyg14YYy34Z8g1PRPPQew409ykZTucdSaFv6YwPU9aUBvzK4FIf2G
 exGw==
X-Gm-Message-State: AOJu0YwUoCTrtqS+tZ3X0h/QNrcPONbrA3M7r9h13PDwjbm+4k01Y3j7
 5ylwi9YFxPnCTdTGTdhbAYeMf78NDVu/7m/Uptyi+k+fud6BguufqIM9+1S8VURhbfF+U3wGSu0
 =
X-Google-Smtp-Source: AGHT+IGKup64ghEbCzsaEd7mAWC4LCiB/z0I69Dx8DODgcUaKd+15JuaCbr8r+vpymrVgpgMTJjF+w==
X-Received: by 2002:a05:6e02:18c9:b0:3a1:f549:7272 with SMTP id
 e9e14a558f8ab-3a3f40b7159mr39884675ab.23.1729351354086; 
 Sat, 19 Oct 2024 08:22:34 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 05/31] alist: Add for-loop helpers
Date: Sat, 19 Oct 2024 09:21:45 -0600
Message-Id: <20241019152211.1014896-6-sjg@chromium.org>
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

Add some macros which permit easy iteration through an alist, similar to
those provided by the 'list' implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/alist.h  | 50 ++++++++++++++++++++++++++++++++
 lib/alist.c      |  7 +++++
 test/lib/alist.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)

diff --git a/include/alist.h b/include/alist.h
index 97523af37a6..0090b9c0eb1 100644
--- a/include/alist.h
+++ b/include/alist.h
@@ -224,6 +224,56 @@ bool alist_expand_by(struct alist *lst, uint inc_by);
  */
 const void *alist_next_ptrd(const struct alist *lst, const void *ptr);
 
+/**
+ * alist_chk_ptr() - Check whether a pointer is within a list
+ *
+ * Checks if the pointer points to an existing element of the list. The pointer
+ * must point to the start of an element, either in the list, or just outside of
+ * it. This function is only useful for handling for() loops
+ *
+ * Return: true if @ptr is within the list (0..count-1), else false
+ */
+bool alist_chk_ptr(const struct alist *lst, const void *ptr);
+
+/**
+ * alist_start() - Get the start of the list (first element)
+ *
+ * Note that this will always return ->data even if it is not NULL
+ *
+ * Usage:
+ *	const struct my_struct *obj;    # 'const' is optional
+ *
+ *	alist_start(&lst, struct my_struct)
+ */
+#define alist_start(_lst, _struct) \
+	((_struct *)(_lst)->data)
+
+/**
+ * alist_end() - Get the end of the list (just after last element)
+ *
+ * Usage:
+ *	const struct my_struct *obj;    # 'const' is optional
+ *
+ *	alist_end(&lst, struct my_struct)
+ */
+#define alist_end(_lst, _struct) \
+	((_struct *)(_lst)->data + (_lst)->count)
+
+/**
+ * alist_for_each() - Iterate over an alist (with constant pointer)
+ *
+ * Use as:
+ *	const struct my_struct *obj;    # 'const' is optional
+ *
+ *	alist_for_each(obj, &lst) {
+ *		obj->...
+ *	}
+ */
+#define alist_for_each(_pos, _lst) \
+	for (_pos = alist_start(_lst, typeof(*(_pos))); \
+	     _pos < alist_end(_lst, typeof(*(_pos))); \
+	     _pos++)
+
 /**
  * alist_init() - Set up a new object list
  *
diff --git a/lib/alist.c b/lib/alist.c
index 7730fe0d473..1a4b4fb9c40 100644
--- a/lib/alist.c
+++ b/lib/alist.c
@@ -118,6 +118,13 @@ int alist_calc_index(const struct alist *lst, const void *ptr)
 	return index;
 }
 
+bool alist_chk_ptr(const struct alist *lst, const void *ptr)
+{
+	int index = alist_calc_index(lst, ptr);
+
+	return index >= 0 && index < lst->count;
+}
+
 const void *alist_next_ptrd(const struct alist *lst, const void *ptr)
 {
 	int index = alist_calc_index(lst, ptr);
diff --git a/test/lib/alist.c b/test/lib/alist.c
index 96092affec9..1715a22584c 100644
--- a/test/lib/alist.c
+++ b/test/lib/alist.c
@@ -292,3 +292,77 @@ static int lib_test_alist_next(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_test_alist_next, 0);
+
+/* Test alist_for_each()  */
+static int lib_test_alist_for_each(struct unit_test_state *uts)
+{
+	const struct my_struct *ptr;
+	struct my_struct data, *ptr2;
+	struct alist lst;
+	ulong start;
+	int sum;
+
+	start = ut_check_free();
+
+	ut_assert(alist_init_struct(&lst, struct my_struct));
+	ut_asserteq_ptr(NULL, alist_end(&lst, struct my_struct));
+
+	sum = 0;
+	alist_for_each(ptr, &lst)
+		sum++;
+	ut_asserteq(0, sum);
+
+	alist_for_each(ptr, &lst)
+		sum++;
+	ut_asserteq(0, sum);
+
+	/* add three items */
+	data.val = 1;
+	data.other_val = 0;
+	alist_add(&lst, data);
+
+	ptr = lst.data;
+	ut_asserteq_ptr(ptr + 1, alist_end(&lst, struct my_struct));
+
+	data.val = 2;
+	alist_add(&lst, data);
+	ut_asserteq_ptr(ptr + 2, alist_end(&lst, struct my_struct));
+
+	data.val = 3;
+	alist_add(&lst, data);
+	ut_asserteq_ptr(ptr + 3, alist_end(&lst, struct my_struct));
+
+	/* check alist_chk_ptr() */
+	ut_asserteq(true, alist_chk_ptr(&lst, ptr + 2));
+	ut_asserteq(false, alist_chk_ptr(&lst, ptr + 3));
+	ut_asserteq(false, alist_chk_ptr(&lst, ptr + 4));
+	ut_asserteq(true, alist_chk_ptr(&lst, ptr));
+	ut_asserteq(false, alist_chk_ptr(&lst, ptr - 1));
+
+	/* sum all items */
+	sum = 0;
+	alist_for_each(ptr, &lst)
+		sum += ptr->val;
+	ut_asserteq(6, sum);
+
+	/* increment all items */
+	alist_for_each(ptr2, &lst)
+		ptr2->val += 1;
+
+	/* sum all items again */
+	sum = 0;
+	alist_for_each(ptr, &lst)
+		sum += ptr->val;
+	ut_asserteq(9, sum);
+
+	ptr = lst.data;
+	ut_asserteq_ptr(ptr + 3, alist_end(&lst, struct my_struct));
+
+	alist_uninit(&lst);
+
+	/* Check for memory leaks */
+	ut_assertok(ut_check_delta(start));
+
+	return 0;
+}
+LIB_TEST(lib_test_alist_for_each, 0);
-- 
2.34.1

