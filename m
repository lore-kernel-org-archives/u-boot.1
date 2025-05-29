Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFB0C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 04:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD9EC835A5;
	Thu, 29 May 2025 06:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fepik/v8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3983E83641; Thu, 29 May 2025 06:05:44 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3BB38354B
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 06:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-311ef4fb43dso359429a91.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 21:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748491540; x=1749096340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OAxJD/tro4tQ+LLFN6U7a59OXHxib3oVjSK6WfPOJpk=;
 b=fepik/v84yibxdYIVSM8XT9/Til9YK5yYH7FV1GoQuh8DiM41FeB9O3puoxmRywstC
 r0pm9Fj2G8l9YYQzPoVPfvAi3f7TEffNtzSOOd/eJi2pLU18fs1Vj8WNbMJqPiblML5+
 qlstCqxaQ7VINoFR1SoURnXL6gKhe2valEWmwvdPjzCt51ingFF64qrt8Sf0upCbl+u/
 4QUmIrVef+l5av7pwbbqRDU4U2suF4mF7xS+rtI+ef+ao/cAVdqwqvdlSKpiK2P4vIg8
 wUoZyuQ81gDQuC8FMc7FQHvbZ049PLy3XihYASVI5HoqKoMONgHbzUvDRtDYNsm1C/Xw
 pibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748491540; x=1749096340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OAxJD/tro4tQ+LLFN6U7a59OXHxib3oVjSK6WfPOJpk=;
 b=Ok+ljNZ0u0qspeYccLC2KpphusnX2bwgbrqFMNYjpgcIq8NzI132y8HF8nIWN3Foaa
 nPH2Q+3H/FtXipCc6+Qh7+8gYB49FdWHYvwmY+ZtAtOWE440q0nT0bIjAuAWTJIMDPGU
 smFhw0oVvRtKQewEQun/v7CctPxoIYyWm6waFi1xQrqUu2zVQXhodcwl4BzGdsMBMZCG
 QwsagtZImXidO2EIClT47CgfZM8wVKtciwM8H4blwhyvs68PPXK/f7DsEfW6cJOp9+ru
 KsY+65KKwabcMr6L4FasICtQscPeZds3LY7lylXFD4BVVvVXl/S+MfGhqb00qZtnlJjP
 LKFg==
X-Gm-Message-State: AOJu0Yx8m9QZI2sFac3pYYGhUloeH9uUtQ371YDUBJ/th+Cu5QakhVPS
 P+ZRmfGB6z4ExTYU/Q7gwEIs2B7JteygNDLHurAG0GEg37lBlZSvmlG21pjSEzqA
X-Gm-Gg: ASbGncsm5moPiIvr95cWvMVSXq5WjWtlTHJpXOoRAj2XUPryp5WKsG6P93h/h5CdqSJ
 rCrSQFfOrb0COM/jfLo1DphKwLF6BVi+bKqyZMQso3O5Unbb34L9tY7wwgd9XEyrAjgYeaaLWUZ
 CTnrN01FQ4VzwPAw/+9kdXZ9XZUkvczxiCra0lPODxdT4HQNoL9sB3+zQF4fXYKYrL5NHS+85ox
 L0GbdHPSxS7tgATRbdczQ+5lDRIB/9yDxw148kBSdS0OSkKRIgMrw1cCdak9Pa1GNWGh2hts4Ir
 uns2xtQpokud3uU3lC/QHgNcyXcefHf+7WpaRpELqvkVb3M=
X-Google-Smtp-Source: AGHT+IGNDoe1S+jjKEmvIRVRU+P/r0c0P+0weuU3OsETZlWK8y9DLBtgLiXhUfSTqUpi6usIsqaxLg==
X-Received: by 2002:a17:90b:224e:b0:311:df4b:4b7a with SMTP id
 98e67ed59e1d1-311df4b4dcemr8154307a91.29.1748491539750; 
 Wed, 28 May 2025 21:05:39 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3121b71deafsm504158a91.16.2025.05.28.21.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 21:05:39 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 3/4] lib: efi_loader: efi_memory.c: add efi_realloc() for
 realloc memory
Date: Thu, 29 May 2025 12:05:19 +0800
Message-ID: <20250529040520.3799600-4-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250529040520.3799600-1-paulliu@debian.org>
References: <20250529040520.3799600-1-paulliu@debian.org>
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

