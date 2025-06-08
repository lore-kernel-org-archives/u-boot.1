Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E7FC5AD49
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 07:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B59CE808AF;
	Sun,  8 Jun 2025 09:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dZkB9zz2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A013808AF; Sun,  8 Jun 2025 09:54:48 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B2FF807B1
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 09:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 61C1D44702
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 07:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749369285;
 bh=qZtEA3ISj0WaQDmf4d92kR1zK3WheBdME5wVi3bxOrU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=dZkB9zz2uh0Bg9Ox2TZP6lq0OrKgkjczpJZr7Cg8U+eBHmM/q+sYmP7W5go1hNQ+C
 fK4wsKaxOT3m8nTefxoFldFvqOACx9dkaaWwgY8Cxt0dpl7AMzGF1UD/Wns7yVPUDm
 W1PrPzUWNBKpovy+POuCfYv9LrRoFZZaO7Agl9E6fBcfmpKPx2NobGKMdS3HRdzkz1
 nK++6T2+CwahatcX6bAAGMjp5iRRY1kX/UXW8f59kksZ8XBnvo4CMpFMSkYkY5WDV6
 LrGI+xbcBP1PLXzqNxjAujwoj0KMRvYl4ot28+2GWPl/rrtsKk82txhvqZnnCgtnku
 Y0DAP0fwrrjBg==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ade57fec429so13370566b.3
 for <u-boot@lists.denx.de>; Sun, 08 Jun 2025 00:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749369280; x=1749974080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZtEA3ISj0WaQDmf4d92kR1zK3WheBdME5wVi3bxOrU=;
 b=sydY02M548wx6ztBC08gWQ0ODrbDT2Ku2d0HJx+F6vldFJdzdKCB6MwaofFYa7fbvh
 JUdP/T5BhAEOV/8zhEs5i+8ofI+d+MmQ6nzep+8l7n3QACk2QgsLrSH/a2zgtci3YDnx
 FCbCKRcNW19RiyFFpLvSu5PF/UY4GuGSZJ9jap2c+bP/puaMKVw9qTcGH6Pg87inMVEs
 pZhA2rICxiVqxXHO7AtZgpXNJgPEeJwKIdnvA23LF8U6QP0hietkr4BX/Q4cGBFMiOSl
 ui+R7aR2WlDvhqLojDmTpKRxUvJU51mVWN3ncTyaDE34YSCbY9haSOXFgZ317NyrluvX
 f6KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw2BRalwGIRpNLcYZ6Sbh9Z9g3FXc/9lvVdGQ1DEVAuASCNh4rqVvQSsl8ecZaDlffkgQne2c=@lists.denx.de
X-Gm-Message-State: AOJu0YzocegktWpIxBdcXmCdHQq+H5F2fH5y7At/WThvRM+faniUVssq
 eIb8lsatJykOGvJJaUt5cttrPgIIAmuw4aj/2jMQ5xbNjVolse/JyPCUCDoAw3kENpST3MxJJiH
 NM3cAdzZsj1JxnSCdb5Kd+2FfB9KtGW5RWvidwXNBQVg98l5l9pJVwuXDifORBU8VN3CzTho=
X-Gm-Gg: ASbGncs+mEvP5Q8j0ZyxUn3OJDAZ8Hk/XHV+2x7RrqBBYQ+HZXN5JfeVbC3k7TdWfZI
 WjGDxXxQ0x6TNsp0krOk0qN7hKWi/CbQvia9rsNJ+QodvIWhfCkyXXUPJ94jVaVVkrkl+8sXYXz
 cqy/8JqAxMCnN+C5bkwupvcxLL1ZMO/CjULwd1nysBKHwl7qWBs6CjBnJuQTlQC/DqwF7GDHXsn
 bJOPhXkprVyToiD5g/W7ub4hSV2mGOP/459+/2PhzwU3z6W4UhXh3ayDkOLAjGI14VleT5hJHXI
 WdO2kaBreWi4Wq1pIo81ZuWh5vXHRINQjCm/yIEjhCBhNSm/bJCReSCm7sFUmrtTyA9/mQwkyvA
 D51XV757Tt8V/bQ==
X-Received: by 2002:a17:907:720d:b0:ad8:9909:20a8 with SMTP id
 a640c23a62f3a-ade1a9e911emr891326666b.49.1749369280133; 
 Sun, 08 Jun 2025 00:54:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8AAC5A5ziOBJuRLTos2dDu3up7Eh8YEOChj8LYAvepP3sHyGhSqG2HlZNzb8UWDffZM7ASw==
X-Received: by 2002:a17:907:720d:b0:ad8:9909:20a8 with SMTP id
 a640c23a62f3a-ade1a9e911emr891324866b.49.1749369279703; 
 Sun, 08 Jun 2025 00:54:39 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade34ea5adesm270956066b.80.2025.06.08.00.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 00:54:39 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>,
 Casey Connolly <casey.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ying-Chun Liu <paul.liu@linaro.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/3] test: unit test for efi_alloc_aligned_pages()
Date: Sun,  8 Jun 2025 09:54:28 +0200
Message-ID: <20250608075428.32631-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250608075428.32631-1-heinrich.schuchardt@canonical.com>
References: <20250608075428.32631-1-heinrich.schuchardt@canonical.com>
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

Provide unit tests for efi_alloc_aligned_pages() and
efi_allocate_pages().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 test/lib/Makefile     |  2 +-
 test/lib/efi_memory.c | 63 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 test/lib/efi_memory.c

diff --git a/test/lib/Makefile b/test/lib/Makefile
index ff4ff63270d..35b40b584c4 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_$(PHASE_)UT_COMPRESSION) += compression.o
 ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += abuf.o
 obj-y += alist.o
-obj-$(CONFIG_EFI_LOADER) += efi_device_path.o
+obj-$(CONFIG_EFI_LOADER) += efi_device_path.o efi_memory.o
 obj-$(CONFIG_EFI_SECURE_BOOT) += efi_image_region.o
 obj-y += hexdump.o
 obj-$(CONFIG_SANDBOX) += kconfig.o
diff --git a/test/lib/efi_memory.c b/test/lib/efi_memory.c
new file mode 100644
index 00000000000..d2e1ab6b4a3
--- /dev/null
+++ b/test/lib/efi_memory.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Test memory functions
+ *
+ * Copyright (c) 2025 Heinrich Schuchardt <xypron.glpk@gmx.de>
+ */
+
+#include <efi_loader.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int lib_test_efi_alloc_aligned_pages(struct unit_test_state *uts)
+{
+	efi_status_t ret;
+
+	void *addr;
+	unsigned long align = 0x400000;
+
+	addr = efi_alloc_aligned_pages(4096, EFI_PERSISTENT_MEMORY_TYPE,
+				       EFI_PAGE_SIZE);
+	ut_asserteq_ptr(NULL, addr);
+
+	addr = efi_alloc_aligned_pages(4096, 0x6FFFFFFF, EFI_PAGE_SIZE);
+	ut_asserteq_ptr(NULL, addr);
+
+	align = 0x200;
+	addr = efi_alloc_aligned_pages(4096, EFI_ACPI_RECLAIM_MEMORY, align);
+	ut_assertnonnull(addr);
+	ut_asserteq_64(0, (uintptr_t)addr & (align - 1));
+
+	ret = efi_free_pages((uintptr_t) addr, 1);
+	ut_asserteq_64(ret, EFI_SUCCESS);
+
+	align = 0x400000;
+	addr = efi_alloc_aligned_pages(4096, EFI_ACPI_RECLAIM_MEMORY, align);
+	ut_assertnonnull(addr);
+	ut_asserteq_64(0, (uintptr_t)addr & (align - 1));
+
+	ret = efi_free_pages((uintptr_t) addr, 1);
+	ut_asserteq_64(ret, EFI_SUCCESS);
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_alloc_aligned_pages, 0);
+
+static int lib_test_efi_allocate_pages(struct unit_test_state *uts)
+{
+	efi_status_t ret;
+	u64 memory;
+
+	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
+				 EFI_ACPI_RECLAIM_MEMORY,
+				 1, &memory);
+	ut_asserteq_64(ret, EFI_SUCCESS);
+	ut_asserteq_64(0, memory & EFI_PAGE_MASK);
+
+	ret = efi_free_pages(memory, 1);
+	ut_asserteq_64(ret, EFI_SUCCESS);
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_allocate_pages, 0);
-- 
2.48.1

