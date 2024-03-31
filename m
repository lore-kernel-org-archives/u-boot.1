Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCF9CD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 21:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E3A88273;
	Sun, 31 Mar 2024 23:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lAJ0xYNz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B7EE87E50; Sun, 31 Mar 2024 22:03:38 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B5887FA0
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugeneuriev@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-515c3eeea5dso3895534e87.1
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711915413; x=1712520213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYw3M+Lwsqzgyt039QrsQyAsviAsIJHKsL9TdIF+/RM=;
 b=lAJ0xYNzaGg9jSoH7l9s1MirCval56oM8ky1szy3OswPjPBZ7ZIMP+6Yz2fx3RvzOE
 zUv3J2Dpv38li+zF1cBba7klFp9aHiTn61DPkyzLKmxEi8UtYlzwMBDjMp7qLIG1u17o
 Ar9aVFhYWOto0NSeGI5/q01m2A74TJxv42cGUu3uEnqrvcjvzl/2s/eJEyCsbmxYJIjj
 jVfRie8CH3YqoloPPLbj06GtXjIpcIF9gwz4XopqEtq2xPBRFM/GOHPMB+ypLniNzCQJ
 e1gykHNxD+V9etOlWoYlC8xGUpngeRZdTx1DDaGgFqPZ1qDlh/CIq3esiuLXc6vNBUle
 ZBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711915413; x=1712520213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gYw3M+Lwsqzgyt039QrsQyAsviAsIJHKsL9TdIF+/RM=;
 b=bZ9PrRzXLQf4NWSV++OJqqHlAq1a2A/VKp+520d4NCj7T1YlLROYU1Oe9uqxL4J36O
 olrQmxX5ZXlM4TVdb+C0d7SoSP+mqPZWD/ZKEMM5rHH9bPBwnJYd3qHqW4xNynYdEHjf
 5BjccBZu1+ZeHI70NjMejRhh0d7WZQpOxMrsgM+mlO75l9fGUaA7dwglMzwKhskQM8aO
 ptv2Dr+ivLJFMAPJI0UqDK67TLuMHcl75yBGUQGupcMWoSqZa+htQD8jb0FC129zqfUH
 87MWaUx4K37zLSL1uDXlLyYwDaaU3F89G+idAt9rZ4/LZ+mRXI8EPE8R0hZUmodTU2P7
 CZ6Q==
X-Gm-Message-State: AOJu0YxB6fj6SmsTgH5NK4CuY7E3dXI3XSYyK1rn3HdZRf6JjxDUzdCv
 Uz75RAV4l4J9pIo7bPo/jDI+Nkr210q6Wd3UJxhSCEZ+k56d8W4ioVZmqn1Y
X-Google-Smtp-Source: AGHT+IF0btegrtEz3m8c5e0RQje1JVM++aloJB3PU9ZzPgGs7VJXEbvWH6TxESPicR9t5pgF//KbnA==
X-Received: by 2002:a19:7608:0:b0:516:9fbe:3b93 with SMTP id
 c8-20020a197608000000b005169fbe3b93mr2563942lff.15.1711915413392; 
 Sun, 31 Mar 2024 13:03:33 -0700 (PDT)
Received: from BlackProtonRN.clients.gtk.su ([185.16.100.35])
 by smtp.gmail.com with ESMTPSA id
 l5-20020ac25545000000b00516a08ce8f8sm425000lfk.269.2024.03.31.13.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 13:03:32 -0700 (PDT)
From: Eugene Uriev <eugeneuriev@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Eugene Uriev <eugeneuriev@gmail.com>
Subject: [PATCH 3/9] mcheck: introduce essentials of mcheck
Date: Sun, 31 Mar 2024 23:03:21 +0300
Message-Id: <20240331200327.29141-4-eugeneuriev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240331200327.29141-1-eugeneuriev@gmail.com>
References: <20240331200327.29141-1-eugeneuriev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 Mar 2024 23:00:15 +0200
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

The core part of mcheck, but without memalign.
memalign - to be added in ensuing commits.

Signed-off-by: Eugene Uriev <eugeneuriev@gmail.com>
---

 common/mcheck_core.inc.h | 220 +++++++++++++++++++++++++++++++++++++++
 include/mcheck.h         |  42 ++++++++
 2 files changed, 262 insertions(+)
 create mode 100644 common/mcheck_core.inc.h
 create mode 100644 include/mcheck.h

diff --git a/common/mcheck_core.inc.h b/common/mcheck_core.inc.h
new file mode 100644
index 0000000000..6f26ef00d9
--- /dev/null
+++ b/common/mcheck_core.inc.h
@@ -0,0 +1,220 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 Free Software Foundation, Inc.
+ * Written by Eugene Uriev, based on glibc 2.0 prototype of Mike Haertel.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Library General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Library General Public License for more details.
+ * <https://www.gnu.org/licenses/>
+ */
+
+/*
+ * TL;DR: this is a porting of glibc mcheck into U-Boot
+ *
+ * This file contains no entities for external linkage.
+ * So mcheck protection may be used in parallel, e.g. for "malloc_simple(..)" and "malloc(..)".
+ * To do so, the file should be shared/include twice, - without linkage conflicts.
+ * I.e. "core"-part is shared as a source, but not as a binary.
+ * Maybe some optimization here make sense, to engage more binary sharing too.
+ * But, currently I strive to keep it as simple, as possible.
+ * And this, programmers'-only, mode don't pretend to be main.
+ *
+ * This library is aware of U-Boot specific. It's also aware of ARM alignment concerns.
+ * Unlike glibc-clients, U-Boot has limited malloc-usage, and only one thread.
+ * So it's better to make the protection heavier.
+ * Thus overflow canary here is greater, than glibc's one. Underflow canary is bigger too.
+ * Heavy canary allows to catch not only memset(..)-errors,
+ * but overflow/underflow of struct-array access:
+ *	{
+ *		struct mystruct* p = malloc(sizeof(struct mystruct) * N);
+ *		p[-1].field1 = 0;
+ *		p[N].field2 = 13;
+ *	}
+ * TODO: In order to guarantee full coverage of that kind of errors, a user can add variable-size
+ *       canaries here. So pre- and post-canary with size >= reqested_size, could be provided
+ *       (with the price of 3x heap-usage). Therefore, it would catch 100% of changes beyond
+ *       an array, for index(+1/-1) errors.
+ *
+ * U-Boot is a BL, not an OS with a lib. Activity of the library is set not in runtime,
+ * rather in compile-time, by MCHECK_HEAP_PROTECTION macro. That guarantees that
+ * we haven't missed first malloc.
+ */
+#ifndef _MCHECKCORE_INC_H
+#define _MCHECKCORE_INC_H      1
+#include "mcheck.h"
+
+#if defined(MCHECK_HEAP_PROTECTION)
+#define mcheck_flood memset
+
+// these are from /dev/random:
+#define MAGICWORD	0x99ccf430fa562a05ULL
+#define MAGICFREE	0x4875e63c0c6fc08eULL
+#define MAGICTAIL	0x918dbcd7df78dcd6ULL
+#define MALLOCFLOOD	((char)0xb6)
+#define FREEFLOOD	((char)0xf5)
+#define PADDINGFLOOD	((char)0x58)
+
+#define CANARY_DEPTH	2
+
+typedef unsigned long long mcheck_elem;
+typedef struct {
+	mcheck_elem elems[CANARY_DEPTH];
+} mcheck_canary;
+struct mcheck_hdr {
+	size_t size; /* Exact size requested by user.  */
+	mcheck_canary canary; /* Magic number to check header integrity.  */
+};
+
+static void mcheck_default_abort(enum mcheck_status status)
+{
+	const char *msg;
+
+	switch (status) {
+	case MCHECK_OK:
+		msg = "memory is consistent, library is buggy\n";
+		break;
+	case MCHECK_HEAD:
+		msg = "memory clobbered before allocated block\n";
+		break;
+	case MCHECK_TAIL:
+		msg = "memory clobbered past end of allocated block\n";
+		break;
+	case MCHECK_FREE:
+		msg = "block freed twice\n";
+		break;
+	default:
+		msg = "bogus mcheck_status, library is buggy\n";
+		break;
+	}
+	printf("\n\nmcheck: %s!!!\n\n", msg);
+}
+
+static mcheck_abortfunc_t mcheck_abortfunc = &mcheck_default_abort;
+
+static inline size_t allign_size_up(size_t sz, size_t grain)
+{
+	return (sz + grain - 1) & ~(grain - 1);
+}
+
+#define mcheck_allign_customer_size(SZ) allign_size_up(SZ, sizeof(mcheck_elem))
+
+static enum mcheck_status mcheck_OnNok(enum mcheck_status status)
+{
+	(*mcheck_abortfunc)(status);
+	return status;
+}
+
+static enum mcheck_status mcheck_checkhdr(const struct mcheck_hdr *hdr)
+{
+	int i;
+
+	for (i = 0; i < CANARY_DEPTH; ++i)
+		if (hdr->canary.elems[i] == MAGICFREE)
+			return mcheck_OnNok(MCHECK_FREE);
+
+	for (i = 0; i < CANARY_DEPTH; ++i)
+		if (hdr->canary.elems[i] != MAGICWORD)
+			return mcheck_OnNok(MCHECK_HEAD);
+
+	const size_t payload_size = hdr->size;
+	const size_t payload_size_aligned = mcheck_allign_customer_size(payload_size);
+	const size_t padd_size = payload_size_aligned - hdr->size;
+
+	const char *payload = (const char *)&hdr[1];
+
+	for (i = 0; i < padd_size; ++i)
+		if (payload[payload_size + i] != PADDINGFLOOD)
+			return mcheck_OnNok(MCHECK_TAIL);
+
+	const mcheck_canary *tail = (const mcheck_canary *)&payload[payload_size_aligned];
+
+	for (i = 0; i < CANARY_DEPTH; ++i)
+		if (tail->elems[i] != MAGICTAIL)
+			return mcheck_OnNok(MCHECK_TAIL);
+	return MCHECK_OK;
+}
+
+enum { KEEP_CONTENT = 0, CLEAN_CONTENT, ANY_ALIGNMENT = 1 };
+static void *mcheck_free_helper(void *ptr, int clean_content)
+{
+	if (!ptr)
+		return ptr;
+
+	struct mcheck_hdr *hdr = &((struct mcheck_hdr *)ptr)[-1];
+	int i;
+
+	mcheck_checkhdr(hdr);
+	for (i = 0; i < CANARY_DEPTH; ++i)
+		hdr->canary.elems[i] = MAGICFREE;
+
+	if (clean_content)
+		mcheck_flood(ptr, FREEFLOOD, mcheck_allign_customer_size(hdr->size));
+	return hdr;
+}
+
+static void *mcheck_free_prehook(void *ptr) { return mcheck_free_helper(ptr, CLEAN_CONTENT); }
+static void *mcheck_reallocfree_prehook(void *ptr) { return mcheck_free_helper(ptr, KEEP_CONTENT); }
+
+static size_t mcheck_alloc_prehook(size_t sz)
+{
+	sz = mcheck_allign_customer_size(sz);
+	return sizeof(struct mcheck_hdr) + sz + sizeof(mcheck_canary);
+}
+
+static void *mcheck_allocated_helper(void *altoghether_ptr, size_t customer_sz,
+				     size_t alignment, int clean_content)
+{
+	struct mcheck_hdr *hdr = (struct mcheck_hdr *)altoghether_ptr;
+	int i;
+
+	hdr->size = customer_sz;
+	for (i = 0; i < CANARY_DEPTH; ++i)
+		hdr->canary.elems[i] = MAGICWORD;
+
+	char *payload = (char *)&hdr[1];
+
+	if (clean_content)
+		mcheck_flood(payload, MALLOCFLOOD, customer_sz);
+
+	const size_t customer_size_aligned = mcheck_allign_customer_size(customer_sz);
+
+	mcheck_flood(payload + customer_sz, PADDINGFLOOD, customer_size_aligned - customer_sz);
+
+	mcheck_canary *tail = (mcheck_canary *)&payload[customer_size_aligned];
+
+	for (i = 0; i < CANARY_DEPTH; ++i)
+		tail->elems[i] = MAGICTAIL;
+	return payload;
+}
+
+static void *mcheck_alloc_posthook(void *altoghether_ptr, size_t customer_sz)
+{
+	return mcheck_allocated_helper(altoghether_ptr, customer_sz, ANY_ALIGNMENT, CLEAN_CONTENT);
+}
+
+static void *mcheck_alloc_noclean_posthook(void *altoghether_ptr, size_t customer_sz)
+{
+	return mcheck_allocated_helper(altoghether_ptr, customer_sz, ANY_ALIGNMENT, KEEP_CONTENT);
+}
+
+static enum mcheck_status mcheck_mprobe(void *ptr)
+{
+	struct mcheck_hdr *hdr = &((struct mcheck_hdr *)ptr)[-1];
+
+	return mcheck_checkhdr(hdr);
+}
+
+static void mcheck_initialize(mcheck_abortfunc_t new_func, char pedantic_flag)
+{
+	mcheck_abortfunc = (new_func) ? new_func : &mcheck_default_abort;
+}
+
+#endif
+#endif
diff --git a/include/mcheck.h b/include/mcheck.h
new file mode 100644
index 0000000000..a049745e4e
--- /dev/null
+++ b/include/mcheck.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.1+ */
+/*
+ * Copyright (C) 1996-2024 Free Software Foundation, Inc.
+ * This file is part of the GNU C Library.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ * <https://www.gnu.org/licenses/>.
+ */
+#ifndef _MCHECK_H
+#define _MCHECK_H       1
+
+/*
+ * Return values for `mprobe': these are the kinds of inconsistencies that
+ * `mcheck' enables detection of.
+ */
+enum mcheck_status {
+	MCHECK_DISABLED = -1,         /* Consistency checking is not turned on.  */
+	MCHECK_OK,                    /* Block is fine.  */
+	MCHECK_FREE,                  /* Block freed twice.  */
+	MCHECK_HEAD,                  /* Memory before the block was clobbered.  */
+	MCHECK_TAIL                   /* Memory after the block was clobbered.  */
+};
+
+typedef void (*mcheck_abortfunc_t)(enum mcheck_status);
+
+int mcheck(mcheck_abortfunc_t func);
+
+/*
+ * Check for aberrations in a particular malloc'd block. These are the
+ * same checks that `mcheck' does, when you free or reallocate a block.
+ */
+enum mcheck_status mprobe(void *__ptr);
+
+#endif
-- 
2.25.1

