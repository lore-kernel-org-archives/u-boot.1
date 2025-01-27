Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA68C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 14:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F059A8128D;
	Mon, 27 Jan 2025 15:49:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x1Io96Cz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0927D81292; Mon, 27 Jan 2025 15:49:53 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B2C81276
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6edb82f85so671615385a.3
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 06:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737989389; x=1738594189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FAMSE0MLO28CCn61m/rq0uAq643eMoW5RLziCxWo4b0=;
 b=x1Io96CzA3aGjoTExtoGuBC9JvjibLg3OaOJqddHjDcZwccK+EkPcCFfKCA8sy7XWd
 oviO1grv4nxJTt2ZnRKAlfFAcsuUHonSHqs2SGuy/Ab3rFENQRHUswO+n1GalM9sxD6K
 JYsumUNNzpDIAorx+PKXOl3AVF2qoD0A8DGT5x+8DExKkPZJ55ppeejpetrT8HvV0SIB
 jwE+YgS9FWI6J/haZ4A6CVZvmpXF7e0iN6CVT83lqVAIkTRL3nLFrvbMNcucIgiz5nev
 AKW0+pf+OPhgSbUrjYehPvk0hv8LXhFkiihFBmA2sjyk/zKyGyhnmLyE2L/LAelVBH3U
 4kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737989389; x=1738594189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FAMSE0MLO28CCn61m/rq0uAq643eMoW5RLziCxWo4b0=;
 b=H/YFPRZ7K9/T+OrDwRujTlsIK3N23OTOQyTULdfvrglf166pgTEGwk7Zopcm8Qis7A
 1bUCyggEZT/9qy3mmMipaf1rCs2Ai+CTnwlme+UhN7lleglwkNHZ099A4xdxnFI0HrnJ
 wpps2+adm7RJeCL0E6kaC7CEQFLDDARs2nqStPs7innZN41IQ6M/cej6sycOJR4/6xtd
 qdGcyi4JByuL/BIQ6WX8XmVlOzrSrNhJb/cF3So/uzot5VC1ayZ5UopOS65gbffGh/V9
 dECzcXHH5OGwptQ9fSBmDERMCEQkXb+/OfvCKDyfZXS4BNPOpGYiXQ2hG1jUKO+OvnPt
 DG2w==
X-Gm-Message-State: AOJu0YxywxIe2oGtr4t0VVaXC0ymIfmXz4MIa2qxcGLxtQAUIkc5PP2F
 b6syv7ewVuGtWyP1fV/0Y3ItO0Qu4jLkZpRdQsOU5teU8eozjucOor1L9JVG2Pz2Yp11DV3+uaz
 KUuM=
X-Gm-Gg: ASbGnctj8lvUOoyaTp/Jif3/LIPEOpFiAjuqnjfG9hjBbFX9qFzFNWOXRKgAkgVyC5B
 wP24UOq0Sjf66NgTW4xwXYz8KHfnlA3rWOvlP6bYCuyUHPSSIYqfXWWowMxvbiOF42++cRm1DLb
 Ut+9vTLpatwvJzSjsJ8SqXMpKs7ZNKs4z1xRX3RGQCPSg0F/MpdYDXcZGOtvmk4CQEzhPQS1yEp
 dSHs5r4WfudkruT0bYuErapyvAEngeGC0mhvyIkYZ5JPDIKD0thKUnJWq3ivghFjFMLEI7pXc7Z
 wuqB0+izXmEmu73+du0RssK2qibw8pr2H47vJnoMyQzGTzy/ux71EMnYn+0HyClc9W/QP+PfVhs
 NuXg=
X-Google-Smtp-Source: AGHT+IFi7egkl5VuMh6eHXQVw42Qj+JqHmC/cgfcq7D6YFdoRCrGpFfVJg+PLMFDFWXaR6u43aJ2yw==
X-Received: by 2002:a05:620a:15b:b0:7be:7f67:3475 with SMTP id
 af79cd13be357-7be7f6734e2mr3600353885a.50.1737989389202; 
 Mon, 27 Jan 2025 06:49:49 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9aeedc7esm397345985a.70.2025.01.27.06.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 06:49:48 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v7 1/3] bloblist: add api to get blob with size
Date: Mon, 27 Jan 2025 06:49:34 -0800
Message-Id: <20250127144941.645544-1-raymond.mao@linaro.org>
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
Changes in v7
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

