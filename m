Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481D2D6911A
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F282F89D32;
	Thu, 28 Nov 2024 16:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mfqe/bdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E0A893D7; Thu, 28 Nov 2024 16:47:42 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F292389885
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:47:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3e916196023so507637b6e.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808858; x=1733413658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ViPtTEytVJ4ek3tLX8e2jW2U6xs7bf3/e91Xu08UqMs=;
 b=Mfqe/bdjgQn3MTXbLDF09BYgVDbwKvSWoW/rexjFZTgQRNXvV4ww8pHJrUZKJvhTXO
 gt4Kl0NIGDw9VJ9iIMLKgx+YKJxk8gQqM41GktpxdYM28RJI1Y1c31zJ/X5mdMbbucYo
 LR2K6noLW1wHSpzmThctXw35CKLXellx8mnAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808858; x=1733413658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ViPtTEytVJ4ek3tLX8e2jW2U6xs7bf3/e91Xu08UqMs=;
 b=TaVWjRGtG5vqUmo9KDgm8vL3P3WmNmOO57d4A/QgHg8LWqIQw1ITGsJig/y3f4gdHJ
 eNPCFQsO2tpAkXJWEqLSOuhwDWjTywQjDL//MYwpwzxKp0uXvk8BWr7v/WG4fzk9U/5q
 xmIiGDlZF9gdjg4kX/LIDmatRljnHB8R/nU2XzdBEzTYq8lSX29DYE7zST/7hWfb4SBR
 +yA3RYU8G8Khl9ElmsmFGOiDnJ5WvjTW4aI0mQXkJIhxyGrn7J56muu0To0Rh6Z4cuUA
 wJPFdfm/xNQkY1VsShbjLkMU4MLaDjegR+q7CzpeQDUTHT7jlaml8GDO/+Ex1wOSDlWf
 bWUQ==
X-Gm-Message-State: AOJu0Yx3cocnBC6gLsES4YdiEi8GJ5mMg7tt6DWhtD+o1UCAcBdKMxsO
 VAkRTSlmuOCVn8R0a+sVLuwHp6rP/cNF0dFyco3GZnhqDy+B/KFVL3KKvT0q5CDFMNyMkFWm944
 =
X-Gm-Gg: ASbGncvCTR++u+iVVDuSA3Yq94apA4vpFXGGFXr7WjD8ZvofC160gx0zRhTSNGf9jVh
 redNKiaCFNO8f2KKDg2sNEEs5kM+efjtopv90vdMehN5zgzUlc0hYSxktEJb3kiKXhKOX3bc8LI
 BZsDKiM6uNRYH93g5YKgXL+bxO8jRvMRZbn+xMhLOMm9101gltmUFs9w+e+7yml6W8L0wHGBXPg
 a9UhmkHmfnYCpjX1J23bYkhCH+gIYLTD/aTNnIXRV+bVA==
X-Google-Smtp-Source: AGHT+IEXQqs7MKYbNxmAye2qEPcojezVJAOd9yLFpGH0nnsKtyosgYM0FtxhbqqRZKndFFI4ZN4EYg==
X-Received: by 2002:a05:6808:138e:b0:3e6:61f0:4797 with SMTP id
 5614622812f47-3ea6dda89e8mr7557331b6e.40.1732808857903; 
 Thu, 28 Nov 2024 07:47:37 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:47:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 01/28] efi: Define fields in struct efi_mem_desc
Date: Thu, 28 Nov 2024 08:47:00 -0700
Message-Id: <20241128154727.771871-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

There is quite a bit of confusion in the EFI code as to whether a field
contains an address or a pointer. As a first step towards resolving
this, document the memory-descriptor struct, indicating that it holds
pointers, not addresses.

Dro the same for efi_add_memory_map() as it is widely used, as well as
efi_add_memory_map_pg() which is only used by lmb

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Fix missing @
- Note that this holds pointers, not addresses

 include/efi.h               | 15 +++++++++++++++
 include/efi_loader.h        |  6 ++++--
 lib/efi_loader/efi_memory.c |  4 +++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/efi.h b/include/efi.h
index c559fda3004..3fce281233c 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -273,6 +273,21 @@ enum efi_memory_type {
 #define EFI_PAGE_SIZE		(1ULL << EFI_PAGE_SHIFT)
 #define EFI_PAGE_MASK		(EFI_PAGE_SIZE - 1)
 
+/**
+ * struct efi_mem_desc - defines an EFI memory record
+ *
+ * Note that this struct is for use outside U-Boot, so the two 'start' fields
+ * are pointers, not addresses. Use map_to_sysmem() to convert to an address, so
+ * that sandbox operates correctly.
+ *
+ * @type (enum efi_memory_type): EFI memory-type
+ * @reserved: unused
+ * @physical_start: Start address of region in physical memory
+ * @virtual_start: Start address of region in physical memory
+ * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
+ *	bytes)
+ * @attribute: Memory attributes (see EFI_MEMORY_...)
+ */
 struct efi_mem_desc {
 	u32 type;
 	u32 reserved;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 39809eac1bc..ee0cdd36500 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -788,8 +788,10 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
 /**
  * efi_add_memory_map_pg() - add pages to the memory map
  *
- * @start:			start address, must be a multiple of
- *				EFI_PAGE_SIZE
+ * @start: start address, must be a multiple of EFI_PAGE_SIZE. Note that this
+ * is actually a pointer provided as an integer. To pass in an address, pass
+ * in (ulong)map_to_sysmem(addr)
+ *
  * @pages:			number of pages to add
  * @memory_type:		type of memory added
  * @overlap_conventional:	region may only overlap free(conventional)
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index e493934c713..f1154f73e05 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -384,7 +384,9 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 /**
  * efi_add_memory_map() - add memory area to the memory map
  *
- * @start:		start address of the memory area
+ * @start:		start address of the memory area. Note that this is
+ *			actually a pointer provided as an integer. To pass in
+ *			an address, pass in (ulong)map_to_sysmem(addr)
  * @size:		length in bytes of the memory area
  * @memory_type:	type of memory added
  *
-- 
2.34.1

