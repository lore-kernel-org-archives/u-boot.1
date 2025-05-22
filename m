Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42A7C54ED0
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 01:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C24082F63;
	Thu, 22 May 2025 03:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="htvCrlO/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71D75829F5; Thu, 22 May 2025 03:18:10 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06E0E82E7D
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 03:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b2c02e79d31so241792a12.2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 18:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747876686; x=1748481486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bkimbc0G1eX9h5DfGKuPBORAMalWiav523ma7qZ4mLI=;
 b=htvCrlO/XVZtaZm6xNdwBjcMFP4EeJVHuhZ1/baKMvdSlTtFec0Ouz/lFkEmlTQ1n8
 0VeOOakd0LuDlNeg1zMPyTbupBcEfB+T85HOA49VAB9XudDPpQUxaZ0hKthRrblnUzNl
 s6aFo5juMfKPVjTR2S/DLsbrcie462Qztkk/uoQ0Z/n2olgrDnHe5tN00mo4uTfpw3yv
 DQS0OeEkihT6rNC9tD1asRkr980toYaESMbKtSX7sHTDYwGBFBthz/VAqNj95YwZRajw
 47GPPKX8JapmerOKrKXcdTWlYSva5LbGdj6wu5OXaeh5RyZLjgRBkAkhY9j1JOn8whle
 yVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747876686; x=1748481486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bkimbc0G1eX9h5DfGKuPBORAMalWiav523ma7qZ4mLI=;
 b=EcxXOfkIgEG9OEvxHx0+4854fvlOnieOhewKUer5LU5bIVQe0q30mezpSMUmEELL4G
 7BMXNPUL+uzkbIwCsP79KrCWGu/smbZmC8RbC12LmfmXjtr4n5+d8CdQpAXFuAmPsB1m
 wXm/qagcvN7gyrlSD+J8Bj4bQxXjS3T47sS0vYxfoHojOGVX6eSxtpWUF8Z7Z94T4Kfv
 EqnuWvkpVuBZOMZb30R/hwkruvqXrCOH3ZWaD8ZDfi6rEusf5khqNtvDFuJbe6oGeHm3
 ScdsqV2+KpkmpawiO68Y8bXdY1fb3DSwcMrqTDqo+P79tyhtMmCT6otJSqZU+q4VBA0N
 7cig==
X-Gm-Message-State: AOJu0Yzps5a77T2/H0DtFy+SLpaT0tOUOA4F1DGgzI0wuzgbUPOQCJ2o
 TppxCzAd6k58vpSuD9kbemJTZHQkgErvNjV42JKBddB6yGwMhphLoAtGAtiq8A==
X-Gm-Gg: ASbGncuChRslLNja1DCcBIbSb9U4HIB6gRWvDPFhxpb+zdjjvOy/Eg/xHhwntwZ6xfo
 qjK+6/S2lxuMZRvIIJjyAHeFMR+93blE0AEN+tAtpRnW0ctvDnoL8KXcTANqCM5wDIxoQ/mQ2Pr
 4H5AABLWiQ7NL+JLEgfrBklujy6refVzqXbX9+Z/2yQGuJ3juTcNvwmZ2Ohr9nByi9mF1kRqSrE
 cCtNV7a7pUxmSY3psfPnmSUKfWAGOJiGWF1Q7DlDYfx4zTwKtnx/rqdMhsHyvz/YZXcI4SktIY0
 +Y5zsT48LLE8CLMo7fozWE+CDjyVK1wByBG1Ev0c3oafLL0=
X-Google-Smtp-Source: AGHT+IHBwEVNgQxZHKKvKihfbUTrVFxErR6TTGi8UqLvaJjsfoLUv8YLr8+yq9YzMinpSEVTiiwjpQ==
X-Received: by 2002:a17:903:4b4b:b0:224:a74:28d2 with SMTP id
 d9443c01a7336-231d452c4bbmr335429875ad.26.1747876685609; 
 Wed, 21 May 2025 18:18:05 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-231d4eb9fb6sm98663025ad.161.2025.05.21.18.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 18:18:05 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 3/4] lib: efi_loader: efi_memory.c: add efi_realloc() for
 realloc memory
Date: Thu, 22 May 2025 09:17:47 +0800
Message-ID: <20250522011749.3498970-4-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522011749.3498970-1-paulliu@debian.org>
References: <20250522011749.3498970-1-paulliu@debian.org>
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
---
 include/efi_loader.h        |  2 ++
 lib/efi_loader/efi_memory.c | 52 +++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index d0c72d0bc58..ff7ca5a0480 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -878,6 +878,8 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
 #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
 /* Allocate boot service data pool memory */
 void *efi_alloc(size_t len);
+/* Reallocate boot service data pool memory */
+void *efi_realloc(void *ptr, size_t len);
 /* Allocate pages on the specified alignment */
 void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
 /* More specific EFI memory allocator, called by EFI payloads */
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 0abb1f6159a..4c76df642dc 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -666,6 +666,58 @@ void *efi_alloc(size_t size)
 	return buf;
 }
 
+/**
+ * efi_realloc() - reallocate boot services data pool memory
+ *
+ * Reallocate memory from pool for a new size and copy the data from old one.
+ *
+ * @ptr:	pointer to old buffer
+ * @size:	number of bytes to allocate
+ * Return:	pointer to allocated memory or NULL
+ */
+void *efi_realloc(void *ptr, size_t size)
+{
+	efi_status_t ret;
+	void *new_ptr;
+	struct efi_pool_allocation *alloc;
+	u64 num_pages = efi_size_in_pages(size +
+					  sizeof(struct efi_pool_allocation));
+	size_t old_size;
+
+	if (!ptr)
+		return efi_alloc(size);
+
+	ret = efi_check_allocated((uintptr_t)ptr, true);
+	if (ret != EFI_SUCCESS)
+		return ptr;
+
+	alloc = container_of(ptr, struct efi_pool_allocation, data);
+
+	/* Check that this memory was allocated by efi_allocate_pool() */
+	if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
+	    alloc->checksum != checksum(alloc)) {
+		printf("%s: illegal realloc 0x%p\n", __func__, ptr);
+		return ptr;
+	}
+
+	/* Don't realloc. The actual size in pages is the same. */
+	if (alloc->num_pages == num_pages)
+		return ptr;
+
+	old_size = alloc->num_pages * EFI_PAGE_SIZE -
+		sizeof(struct efi_pool_allocation);
+
+	new_ptr = efi_alloc(size);
+
+	/* copy old data to new alloced buffer */
+	memcpy(new_ptr, ptr, min(size, old_size));
+
+	/* free the old buffer */
+	efi_free_pool(ptr);
+
+	return new_ptr;
+}
+
 /**
  * efi_free_pool() - free memory from pool
  *
-- 
2.39.5

