Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ACAC71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 12:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A095B82E17;
	Tue, 17 Jun 2025 14:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UfTpgXjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42AB582D60; Tue, 17 Jun 2025 14:09:13 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4638D82BA1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 14:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a35c894313so6358117f8f.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 05:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750162150; x=1750766950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydNmL5Gk1TuCL7/qVzPwHMAwrmFgsuXUQqMEZZL11K8=;
 b=UfTpgXjWxwe3888iZdt7hk7I68mcEnu57E+NjM3STOLcxlH3Mnp3Rpc6HcVZGNFk9i
 RsCexvoiy4/f2L0+2AIg+wRvJQUTq1YSUvLHx3WHJglmaHUAhhGiVcqp959PcT/apcnk
 3mX4OuNK84a9qK2lssIzLDsUx/5NlwQ/g+RcJ+i4oi7rxGq0qYqzATMCTrYmEpaUvT+b
 H3MMVXGx8CDqtmkdOqzcVOr/xXaNvKUVZKJK4ij495zc/uj1/QidwBKNEm4axY9X4n03
 MRCRez5TZHiN+KrIalDhqKI0l4ejEDTSsBzGodogPHvG+DBB5nXoFWHW8w4WzVWtQB8u
 HIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750162150; x=1750766950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ydNmL5Gk1TuCL7/qVzPwHMAwrmFgsuXUQqMEZZL11K8=;
 b=Jbr2tsXO7i6LloMQgDfFUqd4vUy65En/cPdLEz+5RBTRPUE1go+5k8sGWQk9TpbfAR
 6wB4wtDKA/gaYtAQDknfjSLL6RQUoBclnuTWiCSolg7VBJAz1DG+izsiFXEgAjMX2yP0
 eO8C8/x3R289aGu9mk8/NEdYL92IFNQvKgIP5xNmOSEqfVtMK6FPjV+iB/4r+8xCX8de
 DAA4H8IcByePHsHy8lSdJzeHFKu3X/pW+6Jo5dp7QS8WMAlDlptAuU60+EdCF4towB/5
 zQGvWFBMdatRXeWeF3STcu0SbjiZa6ZucTqW/MJITTs5e96hHuJ3evPs/KN2omKycDXK
 1btA==
X-Gm-Message-State: AOJu0YwbGEFrR2FvFE6lNbWDCqNldhXoLTK4tqdLPHfIEqVvFqtEJSfR
 VNsQyS6sY0S0Vhp1UiERRx52EPLuny5Jxc+ndKha1zdZiImCfodkNTynSTDVD29B73U=
X-Gm-Gg: ASbGnct+97mKPNb9xTtDxBvYV0DQWmtFdR6HG+gKSgqHggoeejRY4oRJRCfREpPDL6j
 X/vPlJd3z4OH81mfDordX42LNsBc+kOyx5ThyfEYdZH5J4N+7vMCOSf/UOb1qwTRxk0BYaewDc7
 VM9rOkUSGUZCF2sU2wJZVhwPg5o5x3qRcGNVm/alGHhWrLT6XRxtRgeUrnzbYSWyosW3m52NPBn
 GNWyo1PU75ccBITfBBiNW8zM6k7fgfRz+yV0YVgFYiukmnOPRJJCwJrtK33vyC0aothOw7JGaQi
 i0tBmm98BpCNK11t1d4hT4yRrjoEMDb5P/SgGFMp0MwkxAGIggPJr+BdxGgLKA==
X-Google-Smtp-Source: AGHT+IFyELmZXOFtr95gO1sRQkuXr872zPME31hnGDIS8aZ0UcAMb+HnYK+qNoEn45PACOq3Z/V4MA==
X-Received: by 2002:a05:6000:2184:b0:3a5:783f:5296 with SMTP id
 ffacd0b85a97d-3a5783f5728mr6156685f8f.56.1750162150319; 
 Tue, 17 Jun 2025 05:09:10 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5780c5004sm10228630f8f.56.2025.06.17.05.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 05:09:09 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 3/4] lib: efi_loader: efi_memory.c: add efi_realloc() for
 realloc memory
Date: Tue, 17 Jun 2025 13:08:54 +0100
Message-Id: <20250617120855.87492-4-paulliu@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617120855.87492-1-paulliu@debian.org>
References: <20250617120855.87492-1-paulliu@debian.org>
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

