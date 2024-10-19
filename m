Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E6AD3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3424188FB5;
	Sat, 19 Oct 2024 17:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m9RYp9aC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44876892C6; Sat, 19 Oct 2024 17:22:40 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18F2F87D1A
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-83aad99d6bfso118458739f.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351355; x=1729956155; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEDg/+C+3oNZjM4MMmKPoE0TZukoU+pim9G3Kgo2gRU=;
 b=m9RYp9aCEBCa0B0G1OJUtcVZ/i0WBQYNol7QgaWqAVCIHfLM9LLkKBFso1PcjXpdDn
 lDg7129BLGgxD0Bxj3/M95bf3Z5HCSAw7WffwaJiHBXA4FhcpDMIngyeOGGBXGiqhSJH
 QbXcV+2cK8Ean/1JX0vhk451g/fxnsT1JltHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351355; x=1729956155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEDg/+C+3oNZjM4MMmKPoE0TZukoU+pim9G3Kgo2gRU=;
 b=lwtPUxUn6W2rvtnUJolnCrZyvjEuYD+54oUqaAjLId0aRRxFgcOH5RoDN5RBQo3nvt
 9lt53Wydwdjd7smR2LwPNCUsKfNI92WV/Nc5YGxo6440TYTSEty5EAOf9hfy+skvNc2J
 vnh5Z1NIOhhIgKNUMJYpQ/n3JXtIxurb24dwTdN/4oL80xG4VrRNUs1Um6sfj74JQ27d
 CfE65pYL0RLtoPHqK5urbdJgER+MaJt0miqHSKzvi/qUnSPcm2PyP/D8bLKM5I6IrKvv
 C0Ozs50Le6tWYnXORFIETR/SMXSbEKeZFnYnZhdboxtuayuqKOV9NbmH006QBuGwap6y
 ZWhA==
X-Gm-Message-State: AOJu0Yzw/COizFBv3PtoQqOxdAJLlM02HNumU5cJz5U4t2BJIgT0hOcW
 ACgrYrl9Qo1eDuEVXkHJFXdtf1fkRftOQ9imKH0g23M4jAxSJTrSyGt/h3YuQuFf2nHDKGi/qbc
 =
X-Google-Smtp-Source: AGHT+IGrj/aWkyKYfCGIwQ+ON29D1CkPMBZFsXi0so3Xa/Cp19xURuct16oZkwKFONkAqzoIaodkgQ==
X-Received: by 2002:a05:6e02:1c8f:b0:3a3:afa3:5155 with SMTP id
 e9e14a558f8ab-3a3f40ba404mr52875785ab.25.1729351355294; 
 Sat, 19 Oct 2024 08:22:35 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 06/31] alist: Add a function to empty the list
Date: Sat, 19 Oct 2024 09:21:46 -0600
Message-Id: <20241019152211.1014896-7-sjg@chromium.org>
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

Sometimes it is useful to empty the list without de-allocating any of
the memory used, e.g. when the list will be re-populated immediately
afterwards.

Add a new function for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

