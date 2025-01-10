Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E185E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 21:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BB8C800D0;
	Fri, 10 Jan 2025 22:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NKAD6tGV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B2E801F5; Fri, 10 Jan 2025 22:56:50 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F8480050
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 22:56:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6ef047e9bso227331485a.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 13:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736546207; x=1737151007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SfO/NB2lbWAPnyEWemikr3mnDVxO0vJeD8sVbPT+N/s=;
 b=NKAD6tGV46rfsfa0X6VZxt20LT/sgPuC62zJXjPD0ItwGuS+SeD6WGmPjaUj1IEMkC
 SfHrDmATANES1uNUNzP85St7ym7yFH0qsEUTl10vGk0BgbMTxhMiaqO/F9PfthchluSc
 197JRUOu16nQZj8+l/tG2o30V1IUdCsfKZX/ZUANvMm+wI80INqp4E338RuXTS+vlQY+
 gRpsAUvpB+NPejeit1exf604yyoKhhaCLbcTpSW2tcC76SJLV+20YspOsbkcOUy0/uZF
 prw1jt466zhZxqgTW+DS9cAFFcU35UV35vzquUVxG50+injPJLXxfNRnmS6zUFEVjHct
 t49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736546207; x=1737151007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SfO/NB2lbWAPnyEWemikr3mnDVxO0vJeD8sVbPT+N/s=;
 b=WlO35tWWy28yh3Y/v3apdtNqKNq7R3zL4JQk60HTXbZxAYD3lHwJ3LX2PZZ26rxaDc
 8eCliAfsT+dYty5pGFL0CNQE7yMVTt9jypKzk7JRvUDnnZWt+za7dtPfs5TWFixmrVCi
 VKTZ1PlnycMnWHA2SBQiAmv11p4zWQmDZEd0NmdzOHJEBgvBkvoQKilHxZCKwIVqy9M3
 wd8QavCbrsmkFBAN4XU1xCYjqRlASlruBaFpRscQKS3N/1lJnV+f+fohJk/31XmeOsqX
 S87lEBnJc0mygVsKLEQu9VatX3O8FAy81cFP0dMEFHTRRp2oo9JZQKfBhD3YcHG/AC6J
 Fd2w==
X-Gm-Message-State: AOJu0YzO9TzVFsxHSVDjlBL7cxFh2ME5iKV/LoQAQoHdHUu6LDZ7TS6I
 OCDCfItvYUhDdrdr/2Nr/fZ6iuxZ3NEzUueJoG6fPSIs78rqNaNWzeCpdwbgqT7mmDfreWHpk4y
 2Vas=
X-Gm-Gg: ASbGncvO3JWqoIr2OCS1MBpwQoO5Tkv6RV516XCosv+ht4vN1YQGu9g4mb0YJYt+3Ey
 nygoR6bthFwIdLzoemESQCHTiR1kAx1O4ZLrqVNuo28ruYIOXU/aeDBxwKcsXaYMokVcEgTN4i3
 OQ4e8F8uZZ8ZMlFoNRWq8dxTK+/fQerYj31jJ7drcsDOULRrKIrylPjJG4aTdayZX0PMyf3fjBJ
 N3ZXlz+xaHHcHGc+5SagJLSI82Ka+APtLMSmC0EIK8CA47JDb7T+8sUbR8lylMQnFXmE6S3iNOc
 9pBv8Vk+RUdq48ExLCHJM778BEPZSqfAf4EMaLLmTw+cwQw3rRi8nBw=
X-Google-Smtp-Source: AGHT+IFQeV6FQtb/1x2DCS1G9al0e+IzPfuRcVjMbzNbWsvaujc2gW71VzOOpYZl1C1kx5irevbbeQ==
X-Received: by 2002:a05:620a:254d:b0:7a8:554:c368 with SMTP id
 af79cd13be357-7bce11af046mr1194928185a.6.1736546206867; 
 Fri, 10 Jan 2025 13:56:46 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad85f6bdsm13839496d6.17.2025.01.10.13.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 13:56:46 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: [PATCH v4 1/3] bloblist: add api to get blob with size
Date: Fri, 10 Jan 2025 13:56:33 -0800
Message-Id: <20250110215640.892539-1-raymond.mao@linaro.org>
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

