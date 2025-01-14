Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ECDE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 15:20:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 920338060C;
	Tue, 14 Jan 2025 16:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WAtJ7IUt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51E0E80657; Tue, 14 Jan 2025 16:20:48 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F34448022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 16:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b6e5c74cb7so413101885a.2
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 07:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736868044; x=1737472844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hVKgFWo4ETNIMccxI2mNkYDX1ULV7UiU34qksN64QXs=;
 b=WAtJ7IUtVIZsU4Z1rD1tRrWKsH/UPZwNQmr3ApNREawOoWQb6LaOn7AhIo+nTcSSN+
 6nA4qj0nHHIAXjiUzKPegUhWACzKiTGcrI31ia5EE1GZNRZiIEYmoIRSRWtwIgBLZvr8
 fy9hd6g6ld6lXCH8IBTBdkLkqi/QfdJSWU1MfV1Bbc9EDbmFrbnWOiWTYnRYXDuVIM7I
 jg1NB1vAhdmZG5I2dLiYDz7Ts7y25xNWb2cEtGCuvIVuMY5y7GC7lCub2wsBbTKEud1y
 CH6kpLStAeibu78MJ3QyM6z5tkJ91MTNCXM2tLq3ew4bd2m0wpOE+rN4tMHqCdQTigoP
 qnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736868044; x=1737472844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hVKgFWo4ETNIMccxI2mNkYDX1ULV7UiU34qksN64QXs=;
 b=UctDq9yiU3AUe2apDL5Tvo5mof1E3kWT0kC4/qkQdLxWAjd31A0Y8YkpX7sfFnS2Fe
 C/6p6hbp7oRzsZk/Z9YcBULAjHXkrElGQKGcxh7BUtEY3Lx59cDctxIzD+c+w53/VEER
 Fa0e3foqPXqX6v35Ju/vDrzMkGfqctYK7WnqLxHBvtmG6ee32Y7yRUAvEkYB+mu2jJDR
 xUOOEZidE2ZaEpjtKH+kxledk1p73ORa9cJlWD1NG6or+xVjN5MBc++XLvel2li1Tw8r
 0j+lCr3XFrRiiFc/nY5uhPllcpLzH9K7bj+gdWuvLJpys8fHrHVXXILa7W5v02NmP4Mo
 z9hw==
X-Gm-Message-State: AOJu0YwtuBnAPh02CaGNhq1g6tCueWtm/F4mgjbVFFQdoij34+sPN6yD
 znEgevkMpc35HJN9A+f/MsJ+LlmyeUm7oeDHCEOnCCm/ImtKunwcVzk+qmT9D/Aj/GGYgJxSO9V
 Ivs4=
X-Gm-Gg: ASbGncvhyJtanzBZbRo1aHn/FXVKxWp9bmCVAp0jYHwticjTnL3JSs5/jjWxU9SnFsi
 ODTmoEcd+pFUCjtofhQytSxwsW0HTaQ6S8kjCk/4+lXEtZ+hGL7wtK7JXwdaq5HCUDZyyUsD5pm
 hhKZOsf/ZUkabNuOrlWWdMufZWVcQxKS+pJThGq7Qc2gdrbnVh+tMTt5mRINWrHHmUw795Oekdh
 NuuYic0EXL0W/vI/RdJae2whnCTayhwUqYjLnXBkzsScHUBMzSFtR9saHcWmY69AZYdzm4Xr2Y3
 KSI6A5LFwd9QztEXDWm246voKpxrcyJiDg7qUqDeFkBOgvymB4ehR7U=
X-Google-Smtp-Source: AGHT+IHyKas/RFGnvt5A6HS7WHmPoCtyvSc2ZJ63LblEmMfBv7OR1jkFB/amnZaNEIs2beD4Nli27g==
X-Received: by 2002:a05:620a:4589:b0:7b6:a793:4223 with SMTP id
 af79cd13be357-7bcd976088bmr3874923285a.24.1736868044626; 
 Tue, 14 Jan 2025 07:20:44 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3281697sm613736885a.67.2025.01.14.07.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 07:20:44 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v5 1/3] bloblist: add api to get blob with size
Date: Tue, 14 Jan 2025 07:20:16 -0800
Message-Id: <20250114152022.933662-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

bloblist_find function only returns the pointer of blob data,
which is fine for those self-describing data like FDT.
But as a common scenario, an interface is needed to retrieve both
the pointer and the size of the blob data.

Add a few ut test cases for the new api.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Rename function argument.
- Add ut tests.
Changes in v3
- None.
Changes in v4
- None.
Changes in v5
- None.

 common/bloblist.c      | 17 +++++++++++++++--
 include/bloblist.h     | 18 ++++++++++++++++++
 test/common/bloblist.c |  4 ++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 110bb9dc44..ab48a3cdb9 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -222,14 +222,27 @@ static int bloblist_ensurerec(uint tag, struct bloblist_rec **recp, int size,
 }
 
 void *bloblist_find(uint tag, int size)
+{
+	void *blob = NULL;
+	int blob_size;
+
+	blob = bloblist_get_blob(tag, &blob_size);
+
+	if (size && size != blob_size)
+		return NULL;
+
+	return blob;
+}
+
+void *bloblist_get_blob(uint tag, int *sizep)
 {
 	struct bloblist_rec *rec;
 
 	rec = bloblist_findrec(tag);
 	if (!rec)
 		return NULL;
-	if (size && size != rec->size)
-		return NULL;
+
+	*sizep = rec->size;
 
 	return (void *)rec + rec_hdr_size(rec);
 }
diff --git a/include/bloblist.h b/include/bloblist.h
index f999391f74..52ba0ddcf8 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -250,6 +250,24 @@ static inline void *bloblist_check_magic(ulong addr)
 	return ptr;
 }
 
+#if CONFIG_IS_ENABLED(BLOBLIST)
+/**
+ * bloblist_get_blob() - Find a blob and get the size of it
+ *
+ * Searches the bloblist and returns the blob with the matching tag
+ *
+ * @tag:	Tag to search for (enum bloblist_tag_t)
+ * @sizep:	Size of the blob found
+ * Return: pointer to bloblist if found, or NULL if not found
+ */
+void *bloblist_get_blob(uint tag, int *sizep);
+#else
+static inline void *bloblist_get_blob(uint tag, int *sizep)
+{
+	return NULL;
+}
+#endif
+
 /**
  * bloblist_find() - Find a blob
  *
diff --git a/test/common/bloblist.c b/test/common/bloblist.c
index 4bca62110a..324127596f 100644
--- a/test/common/bloblist.c
+++ b/test/common/bloblist.c
@@ -98,10 +98,12 @@ static int bloblist_test_blob(struct unit_test_state *uts)
 	struct bloblist_hdr *hdr;
 	struct bloblist_rec *rec, *rec2;
 	char *data;
+	int size = 0;
 
 	/* At the start there should be no records */
 	hdr = clear_bloblist();
 	ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
+	ut_assertnull(bloblist_get_blob(TEST_TAG, &size));
 	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	ut_asserteq(sizeof(struct bloblist_hdr), bloblist_get_size());
 	ut_asserteq(TEST_BLOBLIST_SIZE, bloblist_get_total_size());
@@ -114,6 +116,8 @@ static int bloblist_test_blob(struct unit_test_state *uts)
 	ut_asserteq_addr(rec + 1, data);
 	data = bloblist_find(TEST_TAG, TEST_SIZE);
 	ut_asserteq_addr(rec + 1, data);
+	ut_asserteq_addr(bloblist_get_blob(TEST_TAG, &size), data);
+	ut_asserteq(size, TEST_SIZE);
 
 	/* Check the data is zeroed */
 	ut_assertok(check_zero(data, TEST_SIZE));
-- 
2.25.1

