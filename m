Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BF7C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 03:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80AEC82F42;
	Tue,  1 Jul 2025 05:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dVP1wyuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BB582E5A; Tue,  1 Jul 2025 05:49:50 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FED18006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 05:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so1543522f8f.2
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751341778; x=1751946578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydNmL5Gk1TuCL7/qVzPwHMAwrmFgsuXUQqMEZZL11K8=;
 b=dVP1wyuFEkhYOKUcovsX3Qb9IHXUlx4so+Xg5+VNeWPJoPTTKFCiluVYA0NylKhJiR
 8TYm5QyPvBvekNUmtAH+VErTW5CJTo3yr+YeAVP6RxocvhwBMVEaRFvHiI7pNbjFkdjS
 VKBrX1rNjbj5GcMXSn8i9/nXn5e13CZ8+5OdRFMtHPG74UxIEeTAh+ySQ3nx4+SXoxs0
 ooyF70VS0SHiV58KckH2SB8hMOy1xVNoCwLUHF4BFeJEuTRYB/71QOfMYGPCs1uzn5qK
 SRQ4GgpJNVj49B+o67imHkIphLaq4dUgRM3+WWBtgZhSs6lCfxv0XMNEJIfN2Qulv1u8
 ks0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751341778; x=1751946578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ydNmL5Gk1TuCL7/qVzPwHMAwrmFgsuXUQqMEZZL11K8=;
 b=g0aHIaHrulNPHzz2zA5mrff1Or54u9VyAUUsSmUd4C3qfSbn3rBjrZUpcomjuEGIbR
 g4WvNWclr0kMovIEYCWhcgPVwWyNNpygkUFYoFIX55ubcPHAjWTaNwLM2SBZyZUeTxik
 JmCq9B85Np0ValWMLiRhCsltFTn4ebkx/D2L+3Lo+//xUgrOjVp8B7FcKbOgPTF54A50
 htC56JotBenDsyfyowHb73+cu8TIQ3mLwEmBxMqEHVz4TDp4SgMixK2iVVK/CBm6jEAD
 4BHt8YZjQUv1DJ7pwT7xtrBRX9w6bqKIcz3YCTf1Oca0hUBVI2Hu/QOUjThfY9t9xIKJ
 rIcA==
X-Gm-Message-State: AOJu0YzA8Im2UEmehYF+C5Lfl8+vQQf80yPFrD8oFL1AyRQ4u/3UQAIk
 0caUGRXVegIRF9SHrGD4RuvmfS7Q4PnyDQvqhIIg6PFqf+prqaWFweLdy+rDcazU35c=
X-Gm-Gg: ASbGnctejS4PPfLiyu8DkV9UBS4KQuwVnKgJ4mijKWiXpoPMT0kcrI6oXvSWyJZkeuA
 wxnQn8HxPaXz5eyrv7ZiCS7p6LZucluK/VIsdmeCxExX0tm2nslW3BF5+ko2BWrm+IofhTxPImP
 4/qfIFKvksJpPcrWKQ08KOW+y+JKWD0aHMCsxhDW70FqFhOObhWVIo7NtHWPbhS7XhMEi86z92C
 PnVeBbfzQO5wFEAk8RFpJvr2735cklUNhxgpeEcRJX5cjJPPJlnzQ/qZ06RpX6mUPDbAR7BX9YT
 yLGbFWemV6FdP9VYmV9gisKSX8oQuV2+sGV+REWQvgV/IZ2GbzZbCOQX/I0Lbw==
X-Google-Smtp-Source: AGHT+IFDR9gQZJbQfbQreLREZ+rMiwyduEOmzMXPayDPOC78wU6yRqJTAvBU6BfPlnEiFgHJb9BFeQ==
X-Received: by 2002:a05:6000:5c4:b0:3a5:3b93:be4b with SMTP id
 ffacd0b85a97d-3a8f54a0395mr14458961f8f.25.1751341778143; 
 Mon, 30 Jun 2025 20:49:38 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3fe24esm152367695e9.23.2025.06.30.20.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 20:49:37 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 3/6] lib: efi_loader: efi_memory.c: add efi_realloc() for
 realloc memory
Date: Tue,  1 Jul 2025 04:49:23 +0100
Message-Id: <20250701034926.83536-4-paulliu@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701034926.83536-1-paulliu@debian.org>
References: <20250701034926.83536-1-paulliu@debian.org>
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

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

Add efi_realloc() for realloc memory that previously alloc by efi_alloc().

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
V4: Fix efi_realloc return failure code.
V6: Return error status when efi_alloc failed.
---
 include/efi_loader.h        | 10 +++++++
 lib/efi_loader/efi_memory.c | 58 +++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index d0c72d0bc58..13ca2ec9a4e 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -878,6 +878,16 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
 #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
 /* Allocate boot service data pool memory */
 void *efi_alloc(size_t len);
+/**
+ * efi_realloc() - reallocate boot services data pool memory
+ *
+ * Reallocate memory from pool for a new size and copy the data from old one.
+ *
+ * @ptr:	pointer to the buffer
+ * @size:	number of bytes to allocate
+ * Return:	EFI status to indicate success or not
+ */
+efi_status_t efi_realloc(void **ptr, size_t len);
 /* Allocate pages on the specified alignment */
 void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
 /* More specific EFI memory allocator, called by EFI payloads */
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 0abb1f6159a..1570e300570 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -666,6 +666,64 @@ void *efi_alloc(size_t size)
 	return buf;
 }
 
+/**
+ * efi_realloc() - reallocate boot services data pool memory
+ *
+ * Reallocate memory from pool for a new size and copy the data from old one.
+ *
+ * @ptr:	pointer to old buffer
+ * @size:	number of bytes to allocate
+ * Return:	EFI status to indicate success or not
+ */
+efi_status_t efi_realloc(void **ptr, size_t size)
+{
+	efi_status_t ret;
+	void *new_ptr;
+	struct efi_pool_allocation *alloc;
+	u64 num_pages = efi_size_in_pages(size +
+					  sizeof(struct efi_pool_allocation));
+	size_t old_size;
+
+	if (!*ptr) {
+		*ptr = efi_alloc(size);
+		if (*ptr)
+			return EFI_SUCCESS;
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+	ret = efi_check_allocated((uintptr_t)*ptr, true);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	alloc = container_of(*ptr, struct efi_pool_allocation, data);
+
+	/* Check that this memory was allocated by efi_allocate_pool() */
+	if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
+	    alloc->checksum != checksum(alloc)) {
+		printf("%s: illegal realloc 0x%p\n", __func__, *ptr);
+		return EFI_INVALID_PARAMETER;
+	}
+
+	/* Don't realloc. The actual size in pages is the same. */
+	if (alloc->num_pages == num_pages)
+		return EFI_SUCCESS;
+
+	old_size = alloc->num_pages * EFI_PAGE_SIZE -
+		sizeof(struct efi_pool_allocation);
+
+	new_ptr = efi_alloc(size);
+
+	/* copy old data to new alloced buffer */
+	memcpy(new_ptr, *ptr, min(size, old_size));
+
+	/* free the old buffer */
+	efi_free_pool(*ptr);
+
+	*ptr = new_ptr;
+
+	return EFI_SUCCESS;
+}
+
 /**
  * efi_free_pool() - free memory from pool
  *
-- 
2.39.5

