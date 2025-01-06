Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98500E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29029805D7;
	Mon,  6 Jan 2025 15:32:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ky/n4VyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9772E801E8; Mon,  6 Jan 2025 15:32:45 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AF1E801C3
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a7d7c1b190so50712235ab.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173961; x=1736778761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xE7wWiLZY1xg04zLRVXffoNKiFUDBSohytep95TEius=;
 b=Ky/n4VyTDrnPF9I17V9em48zUlhpWHydOKeWIhpiFiTR1Iy6KcxyElJCzcbgIa25g7
 Z25/Rf7TMvpMStOC1khbgUcnoQowNw7Xl05eoB1omiuY+qzQRGlYhFrALiu9jbqJX56W
 e1NtnJ2HlNrBsMeEzpDE+lEY6m5o/aOLFeIMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173961; x=1736778761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xE7wWiLZY1xg04zLRVXffoNKiFUDBSohytep95TEius=;
 b=Y9/di0ejee2gXvRqVr5aUzr7pE12GAx0kACSMZJhftJBc9x4MKd4Pv22q8SMDaXoUB
 N+9FmpJKl+EcGXLBsQzQQqbeVkBE9gvvRj/wjM3PbKROm0IqrCzeDVYhPgCzEO94nP2R
 MNUc4vPjYXoRaWMSCNp0srjagbRKTFlj8Djfy3yXHCnk5+xk8RXDwN2/rCqY/rA0U6Ff
 VJ5KpToYcgQrmGDMiN79ZWsx8huacX0DS5lhEHNSe56RHssln4fysCSkvmCEIhik2wJn
 YP2dQ7nRmlG1XMktKlIZVl/X7GsQ/QWhHCUKVuUfDyDFQ+C3+lQ3Ar451RwoQHJtPDRK
 KRiQ==
X-Gm-Message-State: AOJu0Yxv1hr0aispsSUdu9KVHpfNNjMILBZ43O49We7di0thYrQ52f3b
 czKgg57r8rX1sCQ3neMfF1VuuYPwovhT8rwdsB37eDPRs49+NL4LBRBr91GzEbw/TwWj+QmXAuU
 =
X-Gm-Gg: ASbGnctKa0s0WRk7Gp91kLhTUEQZmRypSPYY/r0hxcTzwTHm255qSqns6WyTP6xej/9
 CKIvOJxRB7Z4Oc9Nr8z5S7J6YMX+QqmiTfTsL85p8v5r7qOW+UZKlFxzlU2tMMRmpwAkepIBPhz
 toLsPWCwl2ChrjKcGZ0Rxuzao9yGgdpaFsgDQ9oqN1P8EaHskXBG8B5CkwMLOXpO5jAEilOzg6Y
 53zsRWoYCcsiKjgmJR1WEYqE6qVqzhiVuUIoLm9f1x17iROYupxg6LVHoIkFXnlVTEUpTuQKAAr
 wwn/XKQtdYFTLqxqtQ==
X-Google-Smtp-Source: AGHT+IFpXkg6ZTSN7FcJf/3g4Zdx64RjKIY2CF4dTfS4e3OFj1HstDuuEZ7GGJ8qfK6zVJEmMck7AA==
X-Received: by 2002:a05:6e02:1705:b0:3a7:e800:7d36 with SMTP id
 e9e14a558f8ab-3c2d2279c01mr476303265ab.10.1736173961156; 
 Mon, 06 Jan 2025 06:32:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:32:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/33] bloblist: add api to get blob with size
Date: Mon,  6 Jan 2025 07:31:57 -0700
Message-Id: <20250106143229.3023771-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

From: Raymond Mao <raymond.mao@linaro.org>

bloblist_find function only returns the pointer of blob data,
which is fine for those self-describing data like FDT.
But as a common scenario, an interface is needed to retrieve both
the pointer and the size of the blob data.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/bloblist.c  | 17 +++++++++++++++--
 include/bloblist.h | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index e8acfc74331..ecce3da9331 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -223,14 +223,27 @@ static int bloblist_ensurerec(uint tag, struct bloblist_rec **recp, int size,
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
+void *bloblist_get_blob(uint tag, int *size)
 {
 	struct bloblist_rec *rec;
 
 	rec = bloblist_findrec(tag);
 	if (!rec)
 		return NULL;
-	if (size && size != rec->size)
-		return NULL;
+
+	*size = rec->size;
 
 	return (void *)rec + rec_hdr_size(rec);
 }
diff --git a/include/bloblist.h b/include/bloblist.h
index 1e1ca34aa92..7d462e71914 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -251,6 +251,24 @@ static inline void *bloblist_check_magic(ulong addr)
 	return ptr;
 }
 
+#if CONFIG_IS_ENABLED(BLOBLIST)
+/**
+ * bloblist_get_blob() - Find a blob and get the size of it
+ *
+ * Searches the bloblist and returns the blob with the matching tag
+ *
+ * @tag:	Tag to search for (enum bloblist_tag_t)
+ * @size:	Size of the blob found
+ * Return: pointer to bloblist if found, or NULL if not found
+ */
+void *bloblist_get_blob(uint tag, int *size);
+#else
+static inline void *bloblist_get_blob(uint tag, int *size)
+{
+	return NULL;
+}
+#endif
+
 /**
  * bloblist_find() - Find a blob
  *
-- 
2.34.1

