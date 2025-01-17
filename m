Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A5CC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 16:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 894C88036F;
	Fri, 17 Jan 2025 17:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HXbwSeMb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4905806D8; Fri, 17 Jan 2025 17:35:56 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E75F880312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 17:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d92e457230so22684896d6.1
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737131752; x=1737736552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gG6On/LgZSKlFvvKl+g7wi/qK7VVcvI7KN/vs9PuLvQ=;
 b=HXbwSeMblQCwqw4wd/5XreiAE0fudm9zVpN2HgrYXaFl+Gj+7nuVHzQpKnMzKbQD56
 stWMTC0JvBIdQbW6ikyuGAufDd4mhFS8uCOS/I2ySHdb1+yudYNxFe++VfNm8FCr9ZDi
 BwQjslg85GcBBkM8wW9k8vr2UWgokD2uSXhn8N+aNQTLS6EWpZ/ePoA6E0dPG3k4szqr
 xC1SIIA7L2IuNOyDYtoYQLx2nkpidGXJH1CQwlz5IJjn0CQkjuazG/3F4b2QUWY3P9WL
 2gELQZFoGq1tX0M2fprsJL72ok51F1mQa12D+yg9KKX8nGcutDVXJ758iHujTwEOLpYR
 q26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737131752; x=1737736552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gG6On/LgZSKlFvvKl+g7wi/qK7VVcvI7KN/vs9PuLvQ=;
 b=rTRUKlvEyO4Porx+AcsESWVGpmQJVnHEaTfNdSDuTkWOF2fFVZymv3TkcaavOhYeCl
 fXYDFC4PEhWgddR5wA7ak+EPCCOyybrVcf3ODqS2N7FNXpdt6qAEa/KwI2Sqh+PwlBzE
 4ktCSAU5rbuCwkvzG+jJZDjW7XlC3yDBN220fGseXapkGMXeQ8jR6rmaylzLXpuj+j0X
 oUM7XPM+sr/D7MQnJhhga4Ubb09NRfxc4ofF/aw9QqAiVD153nk825mIQ8iBipfZPNVe
 n2A5vYSheEftDhZaysRJjsDU03D4hZC8fVSlLt+frkPM7tN+ajolxeDiRy6Ops3CPrhh
 QDoQ==
X-Gm-Message-State: AOJu0YyglgLq+yX9o4xLt0bYQcSDXXoT7rs6aEM5WIL8vGyphAAUzZKm
 FvK4LZU1YP2N7dN2pgjO3iKBmqK/HET8wFhHMbUStwbkMB/XnMsJXO3ryVy5cJHsGEjtcFoZMab
 nxho=
X-Gm-Gg: ASbGnctPT0SF6+6FyABt8wKcNIURw2UxQdzDCFy2k5PbZ9iSoFdjRrk3FenQBiy/+Ao
 7L+mP5nWpXfwAcn0xPvWa/rLnBWHZPz/ONyAtZXU+Rz7HFZh3tGbS/b6uUYDMuu+2WMkuUoKW8P
 tcvT2uupr2dKtGvif+mxGMCOuudYYYYWFKtRicKvA6FLrsckpseduBU6gopHAp9MyHIZMBHP0iT
 +7WVFm/cGhfhbgbBEc+e7ZtRrCUxWjdl28rp2E68cR2O8ckUwq03Bdr8AExeZ0oNPATCUL/KT5p
 WC+gAWG1Gx/0uDIkffuXZSptY21v9eAuyN/nU7taL0ok3uzTnzGmlFo=
X-Google-Smtp-Source: AGHT+IE4/NyaSTkhbpxi3aeJTH+BXwPu9qDPL+KCEGj932VB+3ngmjKJJA+GvhpxwCzoIgKfZO+kBw==
X-Received: by 2002:a05:6214:f04:b0:6d8:8f14:2f5b with SMTP id
 6a1803df08f44-6e1b215b478mr70400046d6.19.1737131752387; 
 Fri, 17 Jan 2025 08:35:52 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afce45c0sm12733946d6.103.2025.01.17.08.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 08:35:51 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Levi Yun <yeoreum.yun@arm.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v6 1/3] bloblist: add api to get blob with size
Date: Fri, 17 Jan 2025 08:35:39 -0800
Message-Id: <20250117163545.88627-1-raymond.mao@linaro.org>
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
Changes in v6
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

