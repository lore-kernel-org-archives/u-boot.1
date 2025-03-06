Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6501C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D5A81D27;
	Thu,  6 Mar 2025 17:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d4S7jHYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AFC281DAB; Thu,  6 Mar 2025 17:06:01 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4740881D0B
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3cf82bd380bso6901765ab.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277157; x=1741881957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Parypb5/X7+YEQG7uuJ6OkRta7AG17KTTx5oCeSaQHU=;
 b=d4S7jHYOt4K+hkR17Jmwsjqg8MT2q5xihlQ7dKQ5PP175ypStVgBdzvOUhsR8WOxQs
 +X54UTvQH+N5PlE5lMU1XsXo111x5VCNvu0YtQ0sbioBh32NGRDur2spq9LsFC6IRiDS
 bAXfNqvcz/lCq3/KbggqaSx6qytScwDxfiwcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277157; x=1741881957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Parypb5/X7+YEQG7uuJ6OkRta7AG17KTTx5oCeSaQHU=;
 b=Utl9WB8I16DH5OPODb/GjPpDbvc8EVh2jvJWQvq6vSfhLNo5W6C+c4ZuUxCJrIRBD7
 +2+WEj8Qwdq0NvSVBWi9r6eyWwbFUGkpRN7U+rrn19qP4d1DZVCCSj0ZTQLxftbc1m2F
 cLFCy/grbwePMvR9Yr0H4+XvDiityrX52tmNIVnoYlmGig6x7zuSaUufpYUWZOigzX7F
 CCySxtLrhaVM6I5WPpRGQVwdVATDO2NJiO2+0wcEHqO2FocXckukZ5QKwFYEVxX9cOcH
 XhSWdRupAHKEMHUE2aTzgNFwkWDmg4AoYdvOABwoP6bzWuPCCikYu24Rdyfz3f9tAtNn
 xmBA==
X-Gm-Message-State: AOJu0Yy2BpnivfVhsqG/SyZZWGkoYVEc4jleMxsDdVmNHOBOGBV2Ga72
 dKhMjHvGAJtpThQwaRm0+7JHhBAP0Wx1cR1Y9ziGJI6jiIL2WV1MlplS0zl1RneWVh2Q7RZ7IH8
 =
X-Gm-Gg: ASbGncsGmaxpu+g9cfzMXt7pjaWVw3YJ/I3AE1JAb7LNMr9i3wtC4OdPAalLqTuhjkJ
 HyGuJGj1S4JLKj6CbY8OEqCyF1cfzDHZy95N1DYHCahml573mDGU2BUMKnK0RfWc0gE6sy5Lq+T
 WSyxP02l6cR++WiEJfDUw7KKYYQ5836504xVd4IJmI6sJiNBYg6nKO1cpItMUkAkUbDA5nPLWjF
 4+uttoklwC3sUK1pvb/Zw5ERaQRyj/G8//GZhabak1UNVeW9aJi65/u5vUYRjGoOKcLEIDof/LF
 UJWD6qtf0IfDzi8IZFgDCHZZmTzCodn5zFpMI2rJOrtlNl01DuH6emuMkgS3l5ru79SQuY1c4Kt
 jy5kG2g==
X-Google-Smtp-Source: AGHT+IHJ5DP3kVe7GzekRC870xL09gnDEhxeQsqSvijG1T45T2M0gsogLWlNveVheV+xgohiCspCCg==
X-Received: by 2002:a05:6e02:2144:b0:3d3:e296:1c1c with SMTP id
 e9e14a558f8ab-3d441960cbcmr319565ab.9.1741277157384; 
 Thu, 06 Mar 2025 08:05:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 33/47] x86: Add a new API for e820
Date: Thu,  6 Mar 2025 09:04:00 -0700
Message-ID: <20250306160428.3041057-34-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

(no changes since v3)

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

