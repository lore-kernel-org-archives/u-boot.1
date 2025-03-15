Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A412C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC1D581E60;
	Sat, 15 Mar 2025 15:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cbznLcO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4EEC81D4F; Sat, 15 Mar 2025 15:28:22 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8FEC81D1F
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39130ee05b0so2962619f8f.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048899; x=1742653699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Parypb5/X7+YEQG7uuJ6OkRta7AG17KTTx5oCeSaQHU=;
 b=cbznLcO574Y54cXSjQTXwXzNIDlbHtfmljfQnPyPDT4eG9iHXoiW0MEpg/xNu5hAbu
 IGNICfhEatnqYhozYzfdWCHwDq4spo4sL3458zYVqHcTXKlYb2/+pADmtrlc+9/ffDtT
 dF5bp8YFLVVo02dCCvbsmBBMf5B8xgmv7qcqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048899; x=1742653699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Parypb5/X7+YEQG7uuJ6OkRta7AG17KTTx5oCeSaQHU=;
 b=B2L/TKsjCCfHg/2SgCUtoTwxyZvb1mCCcl+/k5c3vH69TIwiNrabBc6qcBaK6f9l2J
 qvwBAAdiH2bIVIrfMNE2hwkeIsGBYBpV+wQgMyiFqqYDcrnStY0QsSXiFFi4w+PRt1yI
 R6LGKNcKdaKefxbspfwx3OFQMmsCTDJutBJAoI1PrvioCQFppXFh4db7j0bvOWmVZOPq
 5pise9VMa3CzTTsMIJPFiqhFT2T08fu09XM2GErwBJ9DtCqcqMEc3jbJeEuhkFuDjlqX
 YcsPzwQoms1F64b8WS21qL1eg6pd0ti0vHr+fuI25Z8C8JLfynLnX5yPvf2do3RQ3s4c
 gelg==
X-Gm-Message-State: AOJu0Yys0ePzzaYoT9oNtS0F4kMJlZN7GBGaTMPgU8FfvfXas4nfVelk
 OSjRTwxOcQbBioAzsYvHTMhjE8k6KgnX6P8jJWafv04dUyYljpqdTSqhL4YO6+1nqD9FpzJbbRN
 4UQ==
X-Gm-Gg: ASbGncuwcxpbrMYm4VsgOAbDOBYzLLpbqGZhIn/mslOq225z2p8QQLQY0YazxYjQZnN
 arnF9I+/dhHdqYredxA4Wf5HB3euBXqt2+g3KB/420Og24PDYYa1Eg7wRXPQNjLGmxoBcfPmUid
 njdagoZCb/3AzidbUxBrz6ZWz0MZm5hni/ZsCpZhSsmyvY/84bJWCDkAf53usr60T2+8XV21UMW
 lbVGOkGSk0mQpBcNqNdA05ljHFcSsoQDq7ucDYloEWAeD9UsP2uy7RZkBTa1rtOd2R8jHr3Mma8
 99jHvwoGUN5WHE4hsU79ir4S1MbE54KP4GX65PILAA==
X-Google-Smtp-Source: AGHT+IHEenZ6o/gaakd1B/s4lFDOunqfJ86GwgeBryT81Cqj7oDLEMiU7GWa1YwaS8xF5JQ4HLjQmw==
X-Received: by 2002:a5d:6d88:0:b0:391:2a9a:47a3 with SMTP id
 ffacd0b85a97d-3971a873726mr10193130f8f.0.1742048899148; 
 Sat, 15 Mar 2025 07:28:19 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 33/46] x86: Add a new API for e820
Date: Sat, 15 Mar 2025 14:25:53 +0000
Message-ID: <20250315142643.2600605-34-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

