Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F885E67816
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94082890A9;
	Sun,  3 Nov 2024 01:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SJjAUW91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABFE7890FE; Sun,  3 Nov 2024 01:30:20 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D74F4890D9
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20cbcd71012so35994725ad.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730593815; x=1731198615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XQULe8JSpfj53i+mE5brr7oDoLKxc82B9mb3GYT+a0=;
 b=SJjAUW91a3zptG4vTDuNhnd6+qdSCRHR/FPlK7nSJQu6Ur2NY4sghR7Lo9CL3FHL05
 fn+5EucnvFtOI0sxt/tY9ut7QxQR4gDMXKetXEVVfNwvZpeJgE0Cnr/E2CTem9mvazoX
 SvibYilG8W7WzzWicr2RyuHNoEZ/UnijKPJy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730593815; x=1731198615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XQULe8JSpfj53i+mE5brr7oDoLKxc82B9mb3GYT+a0=;
 b=cDz2w7qVRR73RCaibFijw0flE+KhQk9tMuj9Sywv9GatrrK7lLPnB80EcNbpo7NUP1
 ZOEdFvk5qyLpSvmGyH1rYY98z9GB71tPOqHu7H7nKT5HU57UES5cmKjsTmyTMQEUg3bQ
 3XIAQnubZmc/Slijw0IB4NDrITZtXYOMgDnqz7vS6bTNdml81PTyOjx9anUOxcMs/lJl
 ZIB+yjxpEByofkYGek0233PV0FTBGnrqVCisuVKnDxULjltxgPpqQvcTct9zTmWH/1sQ
 /VdqCV6IBiRIOa9/y3TcGGm2zMOuFZmJM0D2BmqQ4umm8aaPu9+gV4dov6JkA2JfH+kL
 tKFA==
X-Gm-Message-State: AOJu0YwLvMPHOVRXA29Ezpaf9FbWZa0uvUx9QoWWRfDwjMkbg0ybRd+W
 3OzhPTOzypz1NcBnn721ruke+KTAUPIgTFZLymamdsCGaVa+Uod0tzMA7xEAZu+zKdgp8QYCrH/
 XKA==
X-Google-Smtp-Source: AGHT+IGGZrfalVO8Jj4mFr0bxeSLgiPdIrN7NCjk59cpbVQAmKnAqXgTWEgYv+hn8+sKWWb9yk2Pcg==
X-Received: by 2002:a17:902:ea01:b0:20c:e262:2568 with SMTP id
 d9443c01a7336-2111aec8299mr110796935ad.5.1730593815588; 
 Sat, 02 Nov 2024 17:30:15 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211056edc65sm39133335ad.10.2024.11.02.17.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:30:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 4/9] efi: Drop the memset() from efi_alloc()
Date: Sat,  2 Nov 2024 18:28:21 -0600
Message-ID: <20241103002828.624931-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103002828.624931-1-sjg@chromium.org>
References: <20241103002828.624931-1-sjg@chromium.org>
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

Comments were made in v3 that another project uses memset() when
allocating memory, but that is not required by the spec. In any case, as
above, from inspection, none of the users need the memory to be zeroed,
as they fill the entire region with their own data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Expand the commit message

Changes in v3:
- Add new patch to drop the memset() from efi_alloc()
- Drop patch to convert device_path allocation to use malloc()

 include/efi_loader.h        | 11 ++++++++++-
 lib/efi_loader/efi_memory.c |  1 -
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 291eca5c077..f940dc81345 100644
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
index 2982c45dc38..8b086b165a7 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -696,7 +696,6 @@ void *efi_alloc(size_t size)
 		log_err("out of memory\n");
 		return NULL;
 	}
-	memset(buf, 0, size);
 
 	return buf;
 }
-- 
2.43.0

