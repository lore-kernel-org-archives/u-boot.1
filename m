Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32607E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81E3C801E8;
	Tue,  7 Jan 2025 16:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HL0RsWYp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 950CF801FD; Tue,  7 Jan 2025 16:03:09 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4C03801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6dd01781b56so88173586d6.0
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736262185; x=1736866985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hxrz1xRp3g2gnax5XsesdN855Uq5lhnb1HKnOS9w1GY=;
 b=HL0RsWYp6+QfdDZjJwKVfOUV5iBbe4wdHXIq0WKLAthj3qtwDorZLjPga2gZPOAQhf
 I7YEFOl6U6Q6fmOLzsxS/3FnBFENTzw75LkSjhv78W9i3t04uk8QpsZijeOZNpi4CNJ/
 coPnVf42Db/TEUVPjz2nfLsZ0+kglrhUGdAGUDmY2Y+CVStAsQjhOLcM5J2yeUMy6lPG
 k0JEjHQpyXVzHNA2/0Qdd8LkbTf09nQSNm9Yc1dbPQOc9x6zJ+gUp33Wxx8bIgRLH3tV
 I4Ah3D09uwGdT7OLhbk3xqDlGd7kqbUsi+PmwKz9BsNMfKOctNH8LxxqMZeukKPal89L
 Zz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736262185; x=1736866985;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hxrz1xRp3g2gnax5XsesdN855Uq5lhnb1HKnOS9w1GY=;
 b=FefgEftXK5d2sIbLxH3JCj+eg/EuwhwQuVcKVX98Be5kg69kBK0uCt9mp8LnFEsZg5
 4JaQwDKdPry2U0BK+VLE1UULgCpeqpADSRWMviU9LZhi2+ig/M+sfkB5CRHMR2q4mt9H
 HLSA2SdL2c9dithLuhFTK0hChDps48DBW3CK5qNtQ7AT6CYdS+tdodsXAnAAXFY/mcp+
 NwLuGnsNwRM/CXIqH3N8rEG9HPtG7TVf3Z+e2GuzoSH+LKEd3xL32F5MQFYYGxG/JdpN
 b9hpXsimjcxBrfb177iJOCt77aRC+T/StqGpCf3nBxkxAlgs8/0PHBgpEdFj/TL8fZp4
 8eBg==
X-Gm-Message-State: AOJu0YxOrh2QV/hR0ggyuHQJ/bByADbgGOD69paZYjdPEwoKV9LOx7TH
 ExrRpe+yWj1T3+vf/fDtRJESu/J2l7ltJZHvMPu6pWoODU1hbMZX89ghuXg5AX/Cd+JzqqSZwXm
 f
X-Gm-Gg: ASbGncuCerhUJIZuERG02jYei9z4glfoPn31Pl0XJiFJrW5Fngyh9MEKfUkwa6vvNDJ
 NXHDlYmhl0N4BvqvBvCPPDk15m+wp+0ZjMQuT5QklJKMLoZnyzz5SU6U6Imf0c+9YDueZGJYR0T
 oPjM9OE5Gcq4UVzbwcUV4QESCy/0+4k37K9EYYvUeg5TKUu6zkFidKvfF6ptj/li1pyRF7Ttxcu
 iztYabIYlb5pABQpW1C/VFkMyT+JwhCbpZRmq4VDBmfKEC99aRwLvglz1roOHitVyXvRGHTWadA
 VMYAo/Z7x9yDZg9j0+zjhKxSIgouXU2v347OQMSuusmsw2rbnReE9bs=
X-Google-Smtp-Source: AGHT+IFlybbbu9JkgzEDKtIabbdH8uXDfE0f5ulDu57+u7yYd9diE8v69GFncsIKq9hjZSnvsofdMg==
X-Received: by 2002:ad4:5b83:0:b0:6d8:850a:4d6a with SMTP id
 6a1803df08f44-6dd2332ee4dmr812225436d6.1.1736262185242; 
 Tue, 07 Jan 2025 07:03:05 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d422asm180967096d6.105.2025.01.07.07.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 07:03:04 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: [PATCH v2 1/2] bloblist: add api to get blob with size
Date: Tue,  7 Jan 2025 07:02:54 -0800
Message-Id: <20250107150258.813289-1-raymond.mao@linaro.org>
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
---
Changes in v2
- Rename function argument.
- Add ut tests.

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

