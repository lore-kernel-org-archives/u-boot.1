Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05C8C83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 06:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D07E682F4E;
	Thu,  3 Jul 2025 08:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gPhb9Lsx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BE8C82F8F; Thu,  3 Jul 2025 08:28:25 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08D2E82F14
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 08:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so45564635e9.2
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 23:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751524102; x=1752128902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydNmL5Gk1TuCL7/qVzPwHMAwrmFgsuXUQqMEZZL11K8=;
 b=gPhb9LsxgBmZHZltFqmaBW8Lyfz7MtDybzdFbiAZtsPqK8RKaAKKQCT1UjOcStWlhZ
 xOXIrxq/EHJ9MFV+fLtTyZA5Uy4fn2lVI8FFrE3HrvNwx4HJTJBxIp2BIiXutFqeBWK3
 VcU/T90Wf8NJRiYRIsSMM2300AijT0h0MTpqyVLgrugQW1OndlTEDkJDWF/OgKENhTqc
 SI/h8G0UQX5h7hSbNldDiqivA3J/FbiHZFt0aTv/9WP7Y3ECKj9nEUfnjHw6uijRj45j
 0CLA9R+hmo6a6CFvRyYTyo6+QnTUF9mtahCDS5X0DVRgVRb80DAHu0GbQjaGmzUOuKC5
 jMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751524102; x=1752128902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ydNmL5Gk1TuCL7/qVzPwHMAwrmFgsuXUQqMEZZL11K8=;
 b=PUO40EpeoPd41A7vnQcFM3DddgJ7e4YCVAtrkmSeVkp2o7leDZ8LU3iOgtsz4aBpnn
 Zk3+gb8dtKgYisgtfm3wlPR/i6V5UPVPP7o2PPrz9Qhm0bsaJBtKUlRdKXV5kqSTITLY
 wmQ0d4mV4RuGh9YguAFuROAkqh/xtAlzmIhTKaS16rGFayrijJY9W0ZOZJFXcFNG7a9y
 ruJ8vsGUhlYwmU+gxTER5aK9NMEXszqQmkplqssjv+NmFTp1o2Cc+FAkSVM728pQ4s6I
 7hMQvxT4g+e/OO93/NXmAZeZ/MGHqt35eO1zJGAjUhNc+H8rphcWWmLAlWs05PyVe7iA
 7HGQ==
X-Gm-Message-State: AOJu0YxzQd5U1pu+ZbvjzGrBGV6CocqLgh0KgEHMNLZqRgpmHdIOqHk+
 8RYRxvwLKREbj3CbrtWgiV+p/l+DDffjzRnbpJUIVXDG3HwEdV6mG1rkTzEW6EtoSPo=
X-Gm-Gg: ASbGncuTlZpQZrJQE4U9Ty+wMSjDgFX+N8DKm3TTjtHwpm3bX0CV55PCZ8zAMO4mGvA
 FubtmUaa7uRXhOG49/uHtSOkLo16M2rFLUDBaTiQUkybORkqReWN2Hdk7aQp1eHbPsF1XMeFhXs
 VEYzxXKOkPqyMuY0j5crv3CjFAkgF2PmdJiy248O3p+JQ7T7GZddsIchp0Tw2RhH2RQ1XSOuMt1
 LBQ37XaRHbKrxR03s4Ry5YYEwe8rni8sz47LgDdnFwWS0WRS4lf8qwgiQu7Fbt66bWdxxqw19AD
 ybPL/XZshU7pzybUq0DuzJhVZdi10MWGjHKrMtqoS2HCnuRWJgO0NaoSznhLLw==
X-Google-Smtp-Source: AGHT+IEZ0clD32aRm7j3btSkYZWFMy8rA5radSl8jdsQMRawM96jPOeVj8ENGsWW7SEijrqHAY6FCQ==
X-Received: by 2002:a05:600c:8212:b0:453:23fe:ca86 with SMTP id
 5b1f17b1804b1-454af316964mr343985e9.4.1751524101718; 
 Wed, 02 Jul 2025 23:28:21 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bdf21csm16982145e9.29.2025.07.02.23.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 23:28:21 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 3/5] lib: efi_loader: efi_memory.c: add efi_realloc() for
 realloc memory
Date: Thu,  3 Jul 2025 07:28:09 +0100
Message-Id: <20250703062811.72871-4-paulliu@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703062811.72871-1-paulliu@debian.org>
References: <20250703062811.72871-1-paulliu@debian.org>
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

