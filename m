Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46D0C021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2689681277;
	Tue, 25 Feb 2025 00:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MY21Zlv2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B18981276; Tue, 25 Feb 2025 00:08:07 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D20F1811D8
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-855a7e3be0eso120397839f.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438483; x=1741043283; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+NzNQnUbMI/zK+9N4OgalQB1dprLWW/K+T9T2v+V5Y=;
 b=MY21Zlv2RzRxiOAXT1uMki4WmRByFGsbP4cznKtMj4U68K467hy9MGD0HjJRgCBx8j
 P8Fw+lfYnEbB9RNplU9+Z1kE22Pgg2eAqvdKmDT7sT96GuZ0xKWDLfAJdk2M1osaKGS3
 oIoI285U9FLOHa6x6MWHe5F322zbfL80/xjZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438483; x=1741043283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+NzNQnUbMI/zK+9N4OgalQB1dprLWW/K+T9T2v+V5Y=;
 b=ViYScEMdL6xA4DK9vnOEC5JmkcQUcgb84uNwRelNBQ5ICDSLFVYgn3nF7iSp4xj1Ct
 DMlMAgV517ALEjSe5NLIGfl4AXLDo3d3vuOB5Crn2hNYK73sPz+Jh7jhLxOzWA1A9rGy
 Zi1MYBj5xNWs6jQWW5ffnEA0kSg+mwURFdUm6OMmvD5wS0iB+/P1nrT4Kq2SxR5DNPs7
 tiD2QsAB3VKfyHMW3crOUQCNhl/LQ5fRwqXY5l6ciJi0wxAPMPKX/e12MYaUdvzGxJgY
 4S7S6TbE0qPMV2fO5nqu3eHRS2Xd6ZbVdakQ4e884O7kjUKp4LnJSX74yTxgpYeqH1gh
 KzGQ==
X-Gm-Message-State: AOJu0YyfCB+gx2E5QyJcN1B1kCIZ4GMtel5FJ3DhcW3s+Qu2Xv3WQyfQ
 8OAO4QkPQme8mYMCKEFjB/xEuZcbB+SyMTzqzLYnq3efmwJj9/FY9Mm0yeDPssWWK4x2oNBFPig
 =
X-Gm-Gg: ASbGncv3+x6EyuzlvlclTUOEuWhOBuOxGwWAu71kD1qq3KZ/PUzrA5pZffAtnrD1OgY
 009HxUDUsoCi1aXENfD6Hn9ard08aQCkjtVRlGXt/wEcc09yXQCrGOx0O2aVdioMzSATsovCW5+
 GJc6lPSBFslSnM3UmhiYwjzAiMuUPzwccVbxPlWEnj1HeemP9Ixk/GK9IuJb1AO54ODDblmVSvi
 JMFJjnIQYlR/vJg8uZkV89VrzwttWWlCe82FnG+NNxrtoLYXvuwpUgmuM146ftTaVLgO5M5XOCf
 YxnLJ1D+bvhRhe6TP/5LqdYP+WnY1LWYjXwpqRwwKItPXDNHvtpDSCqZEvPQBsk=
X-Google-Smtp-Source: AGHT+IGLT/anAypJA5EYzcVVQvaAmi5FDmk7A8Qxpn/BZKnB7MTkuxbq3GMs7K1mWr9Cs90+EvKN/g==
X-Received: by 2002:a05:6602:6403:b0:855:c980:6eb6 with SMTP id
 ca18e2360f4ac-85620129666mr144914839f.2.1740438483005; 
 Mon, 24 Feb 2025 15:08:03 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 31/44] x86: Add a new API for e820
Date: Mon, 24 Feb 2025 16:06:20 -0700
Message-ID: <20250224230640.2665206-32-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

The existing mechanism is pretty painful as it requires manual
calculations for anything but a trivial setup.

Add a new API for adding e820 entries.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch with an API for e820

 arch/x86/include/asm/e820.h | 87 ++++++++++++++++++++++++++++++++++++-
 arch/x86/lib/e820.c         | 47 ++++++++++++++++++++
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/e820.h b/arch/x86/include/asm/e820.h
index cc3758b59fd..a535818b2d5 100644
--- a/arch/x86/include/asm/e820.h
+++ b/arch/x86/include/asm/e820.h
@@ -3,6 +3,8 @@
 
 #define E820MAX		128	/* number of entries in E820MAP */
 
+#ifdef __ASSEMBLY__
+
 #define E820_RAM	1
 #define E820_RESERVED	2
 #define E820_ACPI	3
@@ -10,9 +12,21 @@
 #define E820_UNUSABLE	5
 #define E820_COUNT	6	/* Number of types */
 
-#ifndef __ASSEMBLY__
+#else
+
 #include <linux/types.h>
 
+/* Available e820 memory-region types */
+enum e820_type {
+	E820_RAM	= 1,
+	E820_RESERVED,
+	E820_ACPI,
+	E820_NVS,
+	E820_UNUSABLE,
+
+	E820_COUNT,
+};
+
 struct e820_entry {
 	__u64 addr;	/* start of memory segment */
 	__u64 size;	/* size of memory segment */
@@ -22,10 +36,81 @@ struct e820_entry {
 #define ISA_START_ADDRESS	0xa0000
 #define ISA_END_ADDRESS		0x100000
 
+/**
+ * Context to use for e820_add()
+ *
+ * @entries: Table being filled in
+ * @addr: Current address we are up to
+ * @count: Number of entries added to @entries so far
+ * @max_entries: Maximum number of entries allowed
+ */
+struct e820_ctx {
+	struct e820_entry *entries;
+	u64 addr;
+	int count;
+	int max_entries;
+};
+
+/**
+ * e820_init() - Start setting up an e820 table
+ *
+ * @ctx: Context to set up
+ * @entries: Place to put entries
+ * @max_entries: Maximum size of @entries
+ */
+void e820_init(struct e820_ctx *ctx, struct e820_entry *entries,
+	       int max_entries);
+
+/**
+ * e820_add() - Add an entry to the table
+ *
+ * @ctx: Context
+ * @type: Type of entry
+ * @addr: Start address of entry
+ * @size Size of entry
+ */
+void e820_add(struct e820_ctx *ctx, enum e820_type type, u64 addr, u64 size);
+
+/**
+ * e820_to_addr() - Add an entry that covers the space up to a given address
+ *
+ * @ctx: Context
+ * @type: Type of entry
+ * @end_addr: Address where the entry should finish
+ */
+void e820_to_addr(struct e820_ctx *ctx, enum e820_type type, u64 end_addr);
+
+/**
+ * e820_next() - Add an entry that carries on from the last one
+ *
+ * @ctx: Context
+ * @type: Type of entry
+ * @size Size of entry
+ */
+void e820_next(struct e820_ctx *ctx, enum e820_type type, u64 size);
+
+/**
+ * e820_finish() - Finish the table
+ *
+ * Checks the table is not too large, panics if so
+ *
+ * @ctx: Context
+ * Returns: Number of entries
+ */
+int e820_finish(struct e820_ctx *ctx);
+
 /* Implementation-defined function to install an e820 map */
 unsigned int install_e820_map(unsigned int max_entries,
 			      struct e820_entry *);
 
+/**
+ * e820_dump() - Dump the e820 table
+ *
+ * @entries: Pointer to start of table
+ * @count: Number of entries in the table
+ */
+void e820_dump(struct e820_entry *entries, uint count);
+
 /**
  * cb_install_e820_map() - Install e820 map provided by coreboot sysinfo
  *
diff --git a/arch/x86/lib/e820.c b/arch/x86/lib/e820.c
index 00ca94776d2..bcc5f6f3044 100644
--- a/arch/x86/lib/e820.c
+++ b/arch/x86/lib/e820.c
@@ -3,8 +3,11 @@
  * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
+#define LOG_CATEGORY	LOGC_ARCH
+
 #include <efi_loader.h>
 #include <lmb.h>
+#include <log.h>
 #include <asm/e820.h>
 #include <asm/global_data.h>
 
@@ -60,6 +63,50 @@ __weak unsigned int install_e820_map(unsigned int max_entries,
 	return 4;
 }
 
+void e820_init(struct e820_ctx *ctx, struct e820_entry *entries,
+	       int max_entries)
+{
+	memset(ctx, '\0', sizeof(*ctx));
+	ctx->entries = entries;
+	ctx->max_entries = max_entries;
+}
+
+void e820_add(struct e820_ctx *ctx, enum e820_type type, u64 addr, u64 size)
+{
+	struct e820_entry *entry = &ctx->entries[ctx->count++];
+
+	if (ctx->count <= ctx->max_entries) {
+		entry->addr = addr;
+		entry->size = size;
+		entry->type = type;
+	}
+	ctx->addr = addr + size;
+}
+
+void e820_next(struct e820_ctx *ctx, enum e820_type type, u64 size)
+{
+	e820_add(ctx, type, ctx->addr, size);
+}
+
+void e820_to_addr(struct e820_ctx *ctx, enum e820_type type, u64 addr)
+{
+	e820_next(ctx, type, addr - ctx->addr);
+}
+
+int e820_finish(struct e820_ctx *ctx)
+{
+	if (ctx->count > ctx->max_entries) {
+		printf("e820 has %d entries but room for only %d\n", ctx->count,
+		       ctx->max_entries);
+		panic("e820 table too large");
+	}
+	log_debug("e820 map installed, n=%d\n", ctx->count);
+	if (_DEBUG)
+		e820_dump(ctx->entries, ctx->count);
+
+	return ctx->count;
+}
+
 #if CONFIG_IS_ENABLED(EFI_LOADER)
 void efi_add_known_memory(void)
 {
-- 
2.43.0

