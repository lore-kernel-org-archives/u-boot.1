Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591A4D0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B54AF893E8;
	Fri, 11 Oct 2024 23:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ix62QobQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55E73893DA; Fri, 11 Oct 2024 23:23:41 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32D66893DB
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a3b1aa0e80so8913435ab.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728681818; x=1729286618; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hOE2qC4osWomWGqPi7G1DgSBuJ0nl0Q3c2xb+4pF00=;
 b=ix62QobQ5iTI+dflVClg5+Wojjz4P36yQprhQ8vVyLlM+hjNyapH3JbuQ+qLCpwMgM
 2is5xiNMcm7meWeKm8HA5lUSGySncfw1PaafRkcyowKhsrpBdf2rf81/Kb/Y9TqW9Q4j
 ffdpx1HHFd6rXJK6kGAbZjDpViZH9et6unyig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728681818; x=1729286618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4hOE2qC4osWomWGqPi7G1DgSBuJ0nl0Q3c2xb+4pF00=;
 b=MePe3nG8FGcs74/W9EaY3B79LTe4JehGh5JwbuteHbs9hCRcgvp0QS2nm/4rp3WGxZ
 FyroqCUvU2LD2wXf+wifkdcx3dgBiK4Q66mL8NJntKbrAONFxCUsGDLDUhhGdoHg3Xiw
 pbOGsdIkpExrqiuHSq7IgdNq8yOdUehuah41BIHX2Fsb4Vp3z63NpQA5haHhcpu8Fzqx
 redXyQDUL+dB0fnphRloQngFgt/bHuvHA+ydySiy3PhKUBZimVLvjnP+QvRTteeOWJyN
 W+dFRbJN/00+iUPA7hk2AVxG8NUcJxnsjL0vCoHFcKiGh9tbVZvyRoYNERMbnnVpr2Ps
 hFGw==
X-Gm-Message-State: AOJu0Yx8HwH1gaQfifG7joS1hUj8DHlfAkU5uVIt5+ieQDgAe6MzL95Y
 NG0vNv3Jt3v+uOO8kvxS/1MhErfBhJFpf/mjcrHbPJc/OaIOr87pVexXBqt7UqveqJM4cASfWlQ
 FHQ==
X-Google-Smtp-Source: AGHT+IFBbXVaUzQ3lLP8q0dNTMUT1HHYVcoEsDfkQEXqbZ6LNHHiehBk/gTAhvIrddm05tX+/gfSEQ==
X-Received: by 2002:a05:6e02:1aa8:b0:3a3:4391:24e9 with SMTP id
 e9e14a558f8ab-3a3b603e0dbmr23651905ab.20.1728681817714; 
 Fri, 11 Oct 2024 14:23:37 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbad9b13e5sm784789173.1.2024.10.11.14.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 14:23:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 1/5] efi: Drop the memset() from efi_alloc()
Date: Fri, 11 Oct 2024 15:21:22 -0600
Message-Id: <20241011212126.747741-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011212126.747741-1-sjg@chromium.org>
References: <20241011212126.747741-1-sjg@chromium.org>
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

Changes in v4:
- Expand the commit message

Changes in v3:
- Add new patch to drop the memset() from efi_alloc()
- Drop patch to convert device_path allocation to use malloc()

 include/efi_loader.h        | 11 ++++++++++-
 lib/efi_loader/efi_memory.c |  9 ---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 511281e150e..08e27e61b06 100644
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

