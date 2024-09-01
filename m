Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9D4C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:23:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CFFE889FC;
	Mon,  2 Sep 2024 00:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cmds8J2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F7718882C; Mon,  2 Sep 2024 00:23:09 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 166B98882C
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-82a3acaa1bbso42137639f.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229385; x=1725834185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/3bMtd/oOnKUojGMHkW+I6zk6qtnwSbt5uzTu9YQylg=;
 b=cmds8J2fUz29DKtvH+XifoFIOJ1yhs1I88zmxrPsFKy27nhFueSzb1hYqbxi96QTGp
 Fr6eFERxr5bUpN1Y4Za6zTbVxvj1Qs+p12OrnpkEkz265nTvV5iI4F/C83WrTVjv/6E/
 hwuAW2sDKp53DHWtVz8x5PH5AurXrHP/qavnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229385; x=1725834185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/3bMtd/oOnKUojGMHkW+I6zk6qtnwSbt5uzTu9YQylg=;
 b=R/PfykvdWdYFWotnv50Pn/AWIYv7KxYM8HeuELHZOmjaP8TwD91B7aWjsHwFCETPyi
 usoSebK7Kf6lyPLxG6KPekMBldITfc5pedo7crHZFSVCqBbou9bwWvGSv9guX52CMBIM
 2rPHuDb7X7KnZth8hKLtDOcfB8/jKO/U2HI6tUmeGyYlyjISOpTHm7h9+cmABwwjE1GE
 Wd4+G7VATjgSMUsXC+9l0m8UEsv0+XMwXcwwhN50xnEKTi70gWvGxgT4++0pK93YNUOL
 aw9nPFojG7scEv7d+6Szme/BDwg5cWAInFL/UABiAYbHvfU0IaRbuMTVUb1hltAbnGN+
 bLmA==
X-Gm-Message-State: AOJu0YwltxoBfFT3GcnC5ikmNk3oE/LCq7MDRzW6gsKhKpEaDngbQ7l3
 X42sC6sroNqe7pW51Hbt94aUMff00II55ZCGHLuvu3+VHpggJ5GIHQ4gCcttjB0pCbvtRRv3MaI
 =
X-Google-Smtp-Source: AGHT+IGJf0jOjZxY8P7htSrPowV5ekSZWtlsoloENq0H/6Jljw3rEWgDZ6/is1StWeDU8UrqTCsamA==
X-Received: by 2002:a05:6602:2d8e:b0:82a:4480:badc with SMTP id
 ca18e2360f4ac-82a4480bcc7mr382374039f.10.1725229385278; 
 Sun, 01 Sep 2024 15:23:05 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a2f0759sm213887339f.2.2024.09.01.15.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:23:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 1/3] efi: Drop the memset() from efi_alloc()
Date: Sun,  1 Sep 2024 16:22:57 -0600
Message-Id: <20240901222259.456932-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222259.456932-1-sjg@chromium.org>
References: <20240901222259.456932-1-sjg@chromium.org>
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

From my inspection none of the users need the memory to be zeroed. It
is somewhat unexpected that it does so, since the name gives no clue to
this.

Drop the memset() so that it effectively becomes a wrapper around the
normal EFI-pool allocator.

Another option would be to drop this function and call
efi_allocate_pool() directly, but that increase code size a little.

Move the function comment to the header file like most other exported
functions in U-Boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to drop the memset() from efi_alloc()
- Drop patch to convert device_path allocation to use malloc()

 include/efi_loader.h        | 11 ++++++++++-
 lib/efi_loader/efi_memory.c |  9 ---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index f84852e384f..38971d01442 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -758,8 +758,17 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
  * Return:	size in pages
  */
 #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
-/* Allocate boot service data pool memory */
+
+/**
+ * efi_alloc() - allocate boot services data pool memory
+ *
+ * Allocate memory from pool with type EFI_BOOT_SERVICES_DATA
+ *
+ * @size:	number of bytes to allocate
+ * Return:	pointer to allocated memory, or NULL if out of memory
+ */
 void *efi_alloc(size_t len);
+
 /* Allocate pages on the specified alignment */
 void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
 /* More specific EFI memory allocator, called by EFI payloads */
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index c6f1dd09456..50cb2f3898b 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -664,14 +664,6 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
 	return r;
 }
 
-/**
- * efi_alloc() - allocate boot services data pool memory
- *
- * Allocate memory from pool and zero it out.
- *
- * @size:	number of bytes to allocate
- * Return:	pointer to allocated memory or NULL
- */
 void *efi_alloc(size_t size)
 {
 	void *buf;
@@ -681,7 +673,6 @@ void *efi_alloc(size_t size)
 		log_err("out of memory");
 		return NULL;
 	}
-	memset(buf, 0, size);
 
 	return buf;
 }
-- 
2.34.1

