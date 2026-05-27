Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7138CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D6184857;
	Wed, 27 May 2026 18:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KSWbRdV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A658584875; Wed, 27 May 2026 18:11:16 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F54284843
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e4de538f83so6691662a34.1
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779898272; x=1780503072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dw4T7A9qLszaFiFauYr0kFJfns356bhpLGgkJBuxFv8=;
 b=KSWbRdV14cu6vcOm2Xdemb4vS2hPLtjQyILFF78wY3e05X6HtDK/XENgLEtcu3GpTv
 1HBVAr57R0gfXU+3BX/jkeKVz/m5jHV0jwOo1fLjffIT0M4JDkOW5+P1zVy8ikUbOze1
 QIoYpMCczkeWqbSJz8I0IVqk7AMCY5QWAwGbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898272; x=1780503072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dw4T7A9qLszaFiFauYr0kFJfns356bhpLGgkJBuxFv8=;
 b=iyTOVpoTFXrbwgEa7tGEzMRAt6rdkHW5iAPoD7yyj9szEs2I5phlwe8/dhu3lPex2n
 UzWCs5Yu9jJ4ZFjU+762nFNoK9+8DREo+KD2DRTCz7/DamLnKqLvPAS5U2hXL7RDXqYI
 EZObT3zyb7J4whEESe6MbWYKiLFk96FhKhoPTT4wlE/WR5rsemLkzKF/ss/6uvDcd+0C
 AgZd8p00qCnCN/tSuMb3LT/akP2iQi9z525BPeMdrx2o5ovIgmjiZdcEi4CLphRmZR1F
 KguUCG3f28KPdlYciLtUuQzU8MjHTmKewrkud27DHe0lNhH145oogmVHaPZlgjdm+U6p
 7cPA==
X-Gm-Message-State: AOJu0Yx/+PzBwhDnCzefBLOmVIuAM89uoR/ZEkhaKy65jcKXQwSj+3rJ
 sLa8C2ywF2thT1kzjdWppsyHEU5CzQaUfx5BAyYcuay/c+16s2XCO3qQ3k6r0FPttvVw//HKX9b
 6uUNYw/kAXuzmCQ==
X-Gm-Gg: Acq92OEa07N35GA7JtVvWmB7E8uxS7mF6k8wsp9yiXuxzy0VeyMox1Z1oeBoessV57t
 AIkXaq7oaxcKTtcLYAYKH0vDyFvfv5FfLHqw/NSfV/F5mcIWuBkXRAUwi1X5vXbrYy+WSwl5am1
 8qePtJH70qi/zZpAc2WP9q1xPR7Wivq+YSBCXWai8n4jnDy4nKPZ7fkWVOtClNxxqcEwxTq2lQE
 Lqkx6PyTTeRtMAXHIMT7ftj7GnObQUFv+Mj7wkU4mVqV3CWqB511ID373xreNX6LrYrVLj63hNp
 gY6LRI1GziLQLSgVFhY0Q3EorXJ7jcCGnFAT5U49UjgGSfAsX08iLuCCtMb7/+xh0bx7o0Mr+ia
 o1VlNyAkRFyRBOpDfXYH53dU9jFgDp/6Mtu/z93SXit2ifs9sX6bqBpLaZHRFlNUdLjuVRMFqz3
 +qd6dhaNmWUdwzJ8u3qg==
X-Received: by 2002:a05:6830:349f:b0:7e5:f7e6:7d8b with SMTP id
 46e09a7af769-7e5ff01dfbcmr15057036a34.18.1779898272278; 
 Wed, 27 May 2026 09:11:12 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7cb6sm12102085a34.16.2026.05.27.09.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:11:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/13] sandbox: Support memory-mapped I/O
Date: Wed, 27 May 2026 10:10:13 -0600
Message-ID: <20260527161033.3273795-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161033.3273795-1-sjg@chromium.org>
References: <20260527161033.3273795-1-sjg@chromium.org>
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

Add a way for calls to readl()/writel() etc. to be picked up by a driver
in order to implement MMIO.

This works by registering some functions, which are then called when
accesses occur.

Add comments to sandbox_read() and sandbox_write() while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/cpu/mem.c           | 49 +++++++++++++++++++++++
 arch/sandbox/cpu/state.c         |  2 +
 arch/sandbox/include/asm/io.h    | 15 +++++++
 arch/sandbox/include/asm/state.h | 67 ++++++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+)

diff --git a/arch/sandbox/cpu/mem.c b/arch/sandbox/cpu/mem.c
index 54a55c1558c..010dc9c16a0 100644
--- a/arch/sandbox/cpu/mem.c
+++ b/arch/sandbox/cpu/mem.c
@@ -6,6 +6,7 @@
 
 #define LOG_CATEGORY	LOGC_SANDBOX
 
+#include <alist.h>
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
@@ -231,9 +232,20 @@ void sandbox_map_list(void)
 	}
 }
 
+static bool in_range(const struct sandbox_mmio *mmio, const void *addr)
+{
+	return addr >= mmio->base && addr < mmio->base + mmio->size;
+}
+
 unsigned long sandbox_read(const void *addr, enum sandboxio_size_t size)
 {
 	struct sandbox_state *state = state_get_current();
+	const struct sandbox_mmio *mmio;
+
+	alist_for_each(mmio, &state->mmio) {
+		if (in_range(mmio, addr))
+			return mmio->h_read(mmio->ctx, addr, size);
+	}
 
 	if (!state->allow_memio)
 		return 0;
@@ -255,6 +267,14 @@ unsigned long sandbox_read(const void *addr, enum sandboxio_size_t size)
 void sandbox_write(void *addr, unsigned int val, enum sandboxio_size_t size)
 {
 	struct sandbox_state *state = state_get_current();
+	const struct sandbox_mmio *mmio;
+
+	alist_for_each(mmio, &state->mmio) {
+		if (in_range(mmio, addr)) {
+			mmio->h_write(mmio->ctx, addr, val, size);
+			return;
+		}
+	}
 
 	if (!state->allow_memio)
 		return;
@@ -286,3 +306,32 @@ void sandbox_set_enable_pci_map(int enable)
 {
 	enable_pci_map = enable;
 }
+
+int sandbox_mmio_add(void *base, ulong size, sandbox_mmio_read_func h_read,
+		     sandbox_mmio_write_func h_write, void *ctx)
+{
+	struct sandbox_state *state = state_get_current();
+	struct sandbox_mmio mmio;
+
+	mmio.base = base;
+	mmio.size = size;
+	mmio.h_read = h_read;
+	mmio.h_write = h_write;
+	mmio.ctx = ctx;
+	if (!alist_add(&state->mmio, mmio))
+		return -ENOMEM;
+
+	return 0;
+}
+
+void sandbox_mmio_remove(void *ctx)
+{
+	struct sandbox_state *state = state_get_current();
+	struct sandbox_mmio *from, *to;
+
+	alist_for_each_filter(from, to, &state->mmio) {
+		if (from->ctx != ctx)
+			*to++ = *from;
+	}
+	alist_update_end(&state->mmio, to);
+}
diff --git a/arch/sandbox/cpu/state.c b/arch/sandbox/cpu/state.c
index 6a15c8b0a18..01742b63d05 100644
--- a/arch/sandbox/cpu/state.c
+++ b/arch/sandbox/cpu/state.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2011-2012 The Chromium OS Authors.
  */
 
+#include <alist.h>
 #include <bloblist.h>
 #include <config.h>
 #include <errno.h>
@@ -487,6 +488,7 @@ int state_init(void)
 		printf("Out of memory\n");
 		os_exit(1);
 	}
+	alist_init_struct(&state->mmio, struct sandbox_mmio);
 
 	state_reset_for_test(state);
 	/*
diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index e3034b9c703..99702532bc7 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -41,7 +41,22 @@ void unmap_physmem(const void *vaddr, unsigned long flags);
 /* Map from a pointer to our RAM buffer */
 phys_addr_t map_to_sysmem(const void *ptr);
 
+/**
+ * sandbox_read() - Perform a memory read
+ *
+ * @addr: Pointer to read from
+ * @size: Access size of read
+ * Return: Value obtained
+ */
 unsigned long sandbox_read(const void *addr, enum sandboxio_size_t size);
+
+/**
+ * sandbox_write() - Perform a memory write
+ *
+ * @addr: Pointer to write to
+ * @val: Value to write
+ * @size: Access size of write
+ */
 void sandbox_write(void *addr, unsigned int val, enum sandboxio_size_t size);
 
 #define readb(addr) ({ u8 __v = sandbox_read((const void *)addr, SB_SIZE_8); __v; })
diff --git a/arch/sandbox/include/asm/state.h b/arch/sandbox/include/asm/state.h
index 9dea0980bfc..582d8fa21a5 100644
--- a/arch/sandbox/include/asm/state.h
+++ b/arch/sandbox/include/asm/state.h
@@ -6,11 +6,14 @@
 #ifndef __SANDBOX_STATE_H
 #define __SANDBOX_STATE_H
 
+#include <alist.h>
 #include <sysreset.h>
 #include <stdbool.h>
 #include <linux/list.h>
 #include <linux/stringify.h>
 
+enum sandboxio_size_t;
+
 /**
  * Selects the behavior of the serial terminal.
  *
@@ -64,6 +67,69 @@ struct sandbox_mapmem_entry {
 	struct list_head sibling_node;
 };
 
+/**
+ * sandbox_read() - Read function for sandbox_mmio
+ *
+ * @addr: Pointer to read from
+ * @size: Access size of read
+ * Return: Value obtained
+ */
+typedef long (*sandbox_mmio_read_func)(void *ctx, const void *addr,
+				       enum sandboxio_size_t size);
+
+/**
+ * sandbox_write() - Write function for sandbox_mmio
+ *
+ * @addr: Pointer to write to
+ * @val: Value to write
+ * @size: Access size of write
+ */
+typedef void (*sandbox_mmio_write_func)(void *ctx, void *addr, unsigned int val,
+					enum sandboxio_size_t size);
+
+/**
+ * sandbox_mmio_add() - Add a new MMIO region
+ *
+ * Register a new set of read/write functions to be called for a particular
+ *	memory region
+ *
+ * @base: Base pointer for region
+ * @size: Size of region
+ * @h_read: Read handler
+ * @h_write: Write handler
+ * @ctx: Context pointer to passed to read/write functions
+ */
+int sandbox_mmio_add(void *base, ulong size, sandbox_mmio_read_func h_read,
+		     sandbox_mmio_write_func h_write, void *ctx);
+
+/**
+ * sandbox_mmio_remove() - Remove an MMIO region
+ *
+ * All regions with the given @ctx are removed
+ *
+ * @ctx: Context to search for
+ */
+void sandbox_mmio_remove(void *ctx);
+
+/**
+ * struct sandbox_mmio - defines a region of memory-mapped I/O
+ *
+ * This allows accesses to a region of memory to go through provided functions
+ *
+ * @base: Base pointer of region
+ * @size: Size of region
+ * @h_read: Read handler
+ * @h_write: Write handler
+ * @ctx: Context pointer provided when registering
+ */
+struct sandbox_mmio {
+	void *base;
+	ulong size;
+	sandbox_mmio_read_func h_read;
+	sandbox_mmio_write_func h_write;
+	void *ctx;
+};
+
 /* The complete state of the test system */
 struct sandbox_state {
 	const char *cmd;		/* Command to execute */
@@ -119,6 +185,7 @@ struct sandbox_state {
 	void *other_fdt_buf;		/* 'other' FDT blob used by tests */
 	int other_size;			/* size of other FDT blob */
 
+	struct alist mmio;		/* list of struct sandbox_mmio */
 	/*
 	 * This struct is getting large.
 	 *
-- 
2.43.0

