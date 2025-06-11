Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82969C61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 05:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6EBD82C4C;
	Wed, 11 Jun 2025 07:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ktYaylW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D3DF80050; Wed, 11 Jun 2025 07:09:16 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4550C82C44
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 07:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3138e64b42aso2561027a91.0
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 22:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749618538; x=1750223338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OAxJD/tro4tQ+LLFN6U7a59OXHxib3oVjSK6WfPOJpk=;
 b=ktYaylW+t4v8v6vxRb9fSe3ZwpmD0cCcMVZJE5cPkra7tXtCxGNW2btpL84MFOtkSH
 8PpYJgGQFcj0F87LYBNMDrRWx0h/jB+jbr3SzGvVmFxBnHnyDqJHGm0mb32f9mWupajR
 Ho6/24C0+tqjP0JA9v4hef7R72HqsC0B+soVFgq8bADADYuS5eBJCxfdfjOqOYhzZPWv
 +3AjNPLHHRuyGLbTe/z88740pzaZfQkVgR7ANRwXYNLfeOpRqZxdrUhkxCk40Vk+AXeG
 5YmWvMQKXid9E2rj0bu4pdIPCbakFmRnOGyUZNqaZkZGSvd94IjhmTsZppWfO0lbf4Yz
 7a4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749618538; x=1750223338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OAxJD/tro4tQ+LLFN6U7a59OXHxib3oVjSK6WfPOJpk=;
 b=dVe1qI/PLLKzSf9kOU4Ritx6co2pAy1sGP0O1mfS1Jyoj8h3MWU3XS18ntJwYHCFQ+
 CTM0xZdaVUXoAxWlwsKgAwn2o7P/BXwGGzgaqR8R5BeVgK5RlQjAwzm9zcTOFzXE4U7E
 NeUUpIE4De4gqW4IdSNHzTHhx3LoQNrCP1FGTifU/rAO1lEt8vQN/fzDjPDzAHcgSGeZ
 CRnMrJUwgzPyLAafhPdPBc4eZMgA8mb9Seu65IoL6OAXtbALrkvtSz/Hu+hjIHqmA7wn
 OI+4WfMBswsRxxSNKHXXVy9stcuUIfs8rPlgGdPWZsR+wF4x8XP18faGuGsij2WM8NH4
 NcmA==
X-Gm-Message-State: AOJu0YyRwmA+iKBMHqOL0dULhk416oXUk/GeCwG9Bzpm3pnUsWUwTHB8
 mcT+9cTC2NSFe2sF0kfbDYhHCQa+BzkEfOGyLsyRnccX4BZ3rFdK5HY0BBso90ym
X-Gm-Gg: ASbGncuRydyW4Oy8BNp5PGbLLsUwjYLwXgLwdXL1RUJWnAopQsondEm8aKBeKc4hfuD
 ze9X9U329aAqxUzAIasMsS4M7/KZVVoJt2CDg57YSPZwfjQvTB99276pOOERtQ88uovRVbDLQlI
 uwQpT1XowfzA//dUIHalp0k08/UAsRq+MgN9Y+ayaR2kcKFuRarkLD2q8Oz61Iw1pRQb9FCXx+2
 Yey+Vl+GkvPDhk6vZ6pMs+RzeYXsyi9VzRHSNehOSe75vFnamXDOiCosb5wlXZSFxX71qzADTgt
 IXvz3akBuKUM8nF8oNVgSqqVOexjzFUeWIsk6iGYVVv13kf6I6BOYr9FbHluLJjYpYoB
X-Google-Smtp-Source: AGHT+IESaICEowC7U1oks9k/hSmEvkiyJkfJDPMDj/n/xKnG3Ci3iviXn8WWTjShRqVIitbN8M7xfw==
X-Received: by 2002:a17:90b:53c7:b0:311:ad7f:329c with SMTP id
 98e67ed59e1d1-313af1b61a9mr3403154a91.18.1749618537927; 
 Tue, 10 Jun 2025 22:08:57 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-313b1ff1123sm462386a91.10.2025.06.10.22.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 22:08:57 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 3/4] lib: efi_loader: efi_memory.c: add efi_realloc() for
 realloc memory
Date: Wed, 11 Jun 2025 13:08:42 +0800
Message-ID: <20250611050844.210384-4-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250611050844.210384-1-paulliu@debian.org>
References: <20250611050844.210384-1-paulliu@debian.org>
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
---
 include/efi_loader.h        | 10 +++++++
 lib/efi_loader/efi_memory.c | 56 +++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

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
index 0abb1f6159a..d69bbb85efb 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -666,6 +666,62 @@ void *efi_alloc(size_t size)
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
+		return EFI_SUCCESS;
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

