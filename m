Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DB4C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 14:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 149CB88646;
	Fri, 26 Jul 2024 16:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZLIt3h0F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 993EE88585; Fri, 26 Jul 2024 16:00:54 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D23878ED
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 16:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-397580fa3bcso4177875ab.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722002450; x=1722607250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbwhSn2K7CziFhIefw/iSaCyPSPm3P7+cLsecE0fcOo=;
 b=ZLIt3h0F651ZaqSnu4vrYKXPzsl/SjGyOQSvw908SzEVBIyj9b787vPjSlz68R74lK
 2ZA1mcF3H1pqgbdfpuptfHreCuYctpi/7paxfJ5Ho9mlymRlSuSbbxKwLMQAecNtqGQq
 XPNl1rf2lDKGjFd2HrqvAs8sO7OM10Kn9B1Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722002450; x=1722607250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbwhSn2K7CziFhIefw/iSaCyPSPm3P7+cLsecE0fcOo=;
 b=bdweubdDYIyHqNNt9bXzRHUSs8YYFFoD+aMmgNxgge6dWlpA5QKEp0HOzSaYaYwc8R
 8L/VsyaHEcuXy4OVJT8QY7eExPIhhwsmMmuYKQBbSCfPy+ta/NWeCxJ+5ViB/wqVDdb8
 7MuOIaPHMSOFCebYnUXlzl1ZRK6BD7KPJbIOOOE9qnuRquVzBLWzKypt0GwYx/YUalJJ
 09hDuDXD6joa1vbdNm5AX9ulj6gIuEK1YfpRz03eI4ZRwAP7zt4ihqesoWweNYtGMFlK
 pmngPG7aB9/BJDPa3aofWbzUo5mGFNjkPcF5J9v34oZnWXfJfwZIrSk4NYBub7QR0m2W
 V9vQ==
X-Gm-Message-State: AOJu0YyhUUpgzLpaXSwnx+WvGFB3ZOQIcCGNSDvyYCNBROsqPWOnXqq4
 zWWlb5UhUOnxzCaASZw/E84w2WRPKLb4TZos/YBROoYnTN3Q+4qQ/HmjmF5wgXRVFDQ5UpVEXJs
 =
X-Google-Smtp-Source: AGHT+IHHC69gcxg+9O44lEoWOYV5Jm+3Yc2mERRYTePEk46WGPsM6ud3q+AmHWpMpuAHWzaCsNMA/w==
X-Received: by 2002:a92:c54b:0:b0:396:da2b:db7d with SMTP id
 e9e14a558f8ab-39a2184f65emr76588065ab.17.1722002450157; 
 Fri, 26 Jul 2024 07:00:50 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a22e7ec25sm14411905ab.6.2024.07.26.07.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 07:00:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Anand Moon <linux.amoon@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 3/4] alist: Add support for an allocated pointer list
Date: Fri, 26 Jul 2024 08:00:37 -0600
Message-Id: <20240726140038.194946-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726140038.194946-1-sjg@chromium.org>
References: <20240726140038.194946-1-sjg@chromium.org>
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

In various places it is useful to have an array of structures, but allow
it to grow. In some cases we work around it by setting maximum number of
entries, using a Kconfig option. In other places we use a linked list,
which does not provide for random access and can complicate the code.

Introduce a new data structure, which is a variable-sized list of structs
each of the same, pre-set size. It provides O(1) access and is reasonably
efficient at expanding linearly, since it doubles in size when it runs out
of space.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Avoid using realloc() unless specifically enabled by Kconfig

Changes in v3:
- Add prototype for alist_expand_by()

Changes in v2:
- Fix 'typeee' typo
- Make alist_get_ptr() take a const alist *
- Make alist_add() take a struct rather than a pointer
- Declare alist_expand_by() as static

 include/alist.h   | 214 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig       |  10 +++
 lib/Makefile      |   1 +
 lib/alist.c       | 157 ++++++++++++++++++++++++++++++++++
 test/lib/Makefile |   1 +
 test/lib/alist.c  | 197 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 580 insertions(+)
 create mode 100644 include/alist.h
 create mode 100644 lib/alist.c
 create mode 100644 test/lib/alist.c

diff --git a/include/alist.h b/include/alist.h
new file mode 100644
index 00000000000..6cc3161dcda
--- /dev/null
+++ b/include/alist.h
@@ -0,0 +1,214 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Handles a contiguous list of pointers which be allocated and freed
+ *
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#ifndef __ALIST_H
+#define __ALIST_H
+
+#include <stdbool.h>
+#include <linux/bitops.h>
+#include <linux/types.h>
+
+/**
+ * struct alist - object list that can be allocated and freed
+ *
+ * Holds a list of objects, each of the same size. The object is typically a
+ * C struct. The array is alloced in memory can change in size.
+ *
+ * The list rememebers the size of the list, but has a separate count of how
+ * much space is allocated, This allows it increase in size in steps as more
+ * elements are added, which is more efficient that reallocating the list every
+ * time a single item is added
+ *
+ * Two types of access are provided:
+ *
+ * alist_get...(index)
+ *	gets an existing element, if its index is less that size
+ *
+ * alist_ensure(index)
+ *	address an existing element, or creates a new one if not present
+ *
+ * @data: object data of size `@obj_size * @alloc`. The list can grow as
+ * needed but never shrinks
+ * @obj_size: Size of each object in bytes
+ * @count: number of objects in array
+ * @alloc: allocated length of array, to which @count can grow
+ * @flags: flags for the alist (ALISTF_...)
+ */
+struct alist {
+	void *data;
+	u16 obj_size;
+	u16 count;
+	u16 alloc;
+	u16 flags;
+};
+
+/**
+ * enum alist_flags - Flags for the alist
+ *
+ * @ALIST_FAIL: true if any allocation has failed. Once this has happened, the
+ * alist is dead and cannot grow further
+ */
+enum alist_flags {
+	ALISTF_FAIL	= BIT(0),
+};
+
+/**
+ * alist_has() - Check if an index is within the list range
+ *
+ * Checks if index is within the current alist count
+ *
+ * @lst: alist to check
+ * @index: Index to check
+ * Returns: true if value, else false
+ */
+static inline bool alist_has(struct alist *lst, uint index)
+{
+	return index < lst->count;
+}
+
+/**
+ * alist_err() - Check if the alist is still valid
+ *
+ * @lst: List to check
+ * Return: false if OK, true if any previous allocation failed
+ */
+static inline bool alist_err(struct alist *lst)
+{
+	return lst->flags & ALISTF_FAIL;
+}
+
+/**
+ * alist_get_ptr() - Get the value of a pointer
+ *
+ * @lst: alist to check
+ * @index: Index to read from
+ * Returns: pointer, if present, else NULL
+ */
+const void *alist_get_ptr(const struct alist *lst, uint index);
+
+/**
+ * alist_getd() - Get the value of a pointer directly, with no checking
+ *
+ * This must only be called on indexes for which alist_has() returns true
+ *
+ * @lst: alist to check
+ * @index: Index to read from
+ * Returns: pointer value (may be NULL)
+ */
+static inline const void *alist_getd(struct alist *lst, uint index)
+{
+	return lst->data + index * lst->obj_size;
+}
+
+#define alist_get(_lst, _index, _struct)	\
+	((const _struct *)alist_get_ptr(_lst, _index))
+
+/**
+ * alist_ensure_ptr() - Ensure an object exists at a given index
+ *
+ * This provides read/write access to an array element. If it does not exist,
+ * it is allocated, reading for the caller to store the object into
+ *
+ * Allocates a object at the given index if needed
+ *
+ * @lst: alist to check
+ * @index: Index to address
+ * Returns: pointer where struct can be read/written, or NULL if out of memory
+ */
+void *alist_ensure_ptr(struct alist *lst, uint index);
+
+/**
+ * alist_ensure() - Address a struct, the correct object type
+ *
+ * Use as:
+ *	struct my_struct *ptr = alist_ensure(&lst, 4, struct my_struct);
+ */
+#define alist_ensure(_lst, _index, _struct)	\
+	((_struct *)alist_ensure_ptr(_lst, _index))
+
+/**
+ * alist_add_ptr() - Ad a new object to the list
+ *
+ * @lst: alist to add to
+ * @obj: Pointer to object to copy in
+ * Returns: pointer to where the object was copied, or NULL if out of memory
+ */
+void *alist_add_ptr(struct alist *lst, void *obj);
+
+/**
+ * alist_expand_by() - Expand a list by the given amount
+ *
+ * @lst: alist to expand
+ * @inc_by: Amount to expand by
+ * Return: true if OK, false if out of memory
+ */
+bool alist_expand_by(struct alist *lst, uint inc_by);
+
+/**
+ * alist_add() - Used to add an object type with the correct type
+ *
+ * Use as:
+ *	struct my_struct obj;
+ *	struct my_struct *ptr = alist_add(&lst, &obj, struct my_struct);
+ */
+#define alist_add(_lst, _obj, _struct)	\
+	((_struct *)alist_add_ptr(_lst, (_struct *)&(_obj)))
+
+/**
+ * alist_init() - Set up a new object list
+ *
+ * Sets up a list of objects, initially empty
+ *
+ * @lst: alist to set up
+ * @obj_size: Size of each element in bytes
+ * @alloc_size: Number of items to allowed to start, before reallocation is
+ * needed (0 to start with no space)
+ * Return: true if OK, false if out of memory
+ */
+bool alist_init(struct alist *lst, uint obj_size, uint alloc_size);
+
+#define alist_init_struct(_lst, _struct)	\
+	alist_init(_lst, sizeof(_struct), 0)
+
+/**
+ * alist_uninit_move_ptr() - Return the allocated contents and uninit the alist
+ *
+ * This returns the alist data to the caller, so that the caller receives data
+ * that it can be sure will hang around. The caller is responsible for freeing
+ * the data.
+ *
+ * If the alist size is 0, this returns NULL
+ *
+ * The alist is uninited as part of this.
+ *
+ * The alist must be inited before this can be called.
+ *
+ * @alist: alist to uninit
+ * @countp: if non-NULL, returns the number of objects in the returned data
+ * (which is @alist->size)
+ * Return: data contents, allocated with malloc(), or NULL if the data could not
+ *	be allocated, or the data size is 0
+ */
+void *alist_uninit_move_ptr(struct alist *alist, size_t *countp);
+
+/**
+ * alist_uninit_move() - Typed version of alist_uninit_move_ptr()
+ */
+#define alist_uninit_move(_lst, _countp, _struct)	\
+	(_struct *)alist_uninit_move_ptr(_lst, _countp)
+
+/**
+ * alist_uninit() - Free any memory used by an alist
+ *
+ * The alist must be inited before this can be called.
+ *
+ * @alist: alist to uninit
+ */
+void alist_uninit(struct alist *alist);
+
+#endif /* __ALIST_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 2059219a120..40b59adbefc 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -8,6 +8,16 @@ config ADDR_MAP
 
 	  This library only works in the post-relocation phase.
 
+config ALIST_REALLOC
+	bool "Use realloc() in the alist implementation"
+	help
+	  An alist must expand when it runs out of space. It is more efficient
+	  to use realloc() for this, but for boards which don't otherwise use
+	  this function it can add 1KB of code space, so separate malloc() and
+	  free are normally used instead.
+
+	  Enable this to use realloc() in alist
+
 config SYS_NUM_ADDR_MAP
 	int "Size of the address-map table"
 	depends on ADDR_MAP
diff --git a/lib/Makefile b/lib/Makefile
index e389ad014f8..81b503ab526 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -147,6 +147,7 @@ endif
 obj-$(CONFIG_$(SPL_)OID_REGISTRY) += oid_registry.o
 
 obj-y += abuf.o
+obj-y += alist.o
 obj-y += date.o
 obj-y += rtc-lib.o
 obj-$(CONFIG_LIB_ELF) += elf.o
diff --git a/lib/alist.c b/lib/alist.c
new file mode 100644
index 00000000000..89339c02dfb
--- /dev/null
+++ b/lib/alist.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Handles a contiguous list of pointers which be allocated and freed
+ *
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <alist.h>
+#include <display_options.h>
+#include <malloc.h>
+#include <stdio.h>
+#include <string.h>
+
+enum {
+	ALIST_INITIAL_SIZE	= 4,	/* default size of unsized list */
+};
+
+bool alist_init(struct alist *lst, uint obj_size, uint start_size)
+{
+	/* Avoid realloc for the initial size to help malloc_simple */
+	memset(lst, '\0', sizeof(struct alist));
+	if (start_size) {
+		lst->data = calloc(obj_size, start_size);
+		if (!lst->data) {
+			lst->flags = ALISTF_FAIL;
+			return false;
+		}
+		lst->alloc = start_size;
+	}
+	lst->obj_size = obj_size;
+
+	return true;
+}
+
+void alist_uninit(struct alist *lst)
+{
+	free(lst->data);
+
+	/* Clear fields to avoid any confusion */
+	memset(lst, '\0', sizeof(struct alist));
+}
+
+/**
+ * alist_expand_to() - Expand a list to the given size
+ *
+ * @lst: List to modify
+ * @inc_by: Amount to expand to
+ * Return: true if OK, false if out of memory
+ */
+static bool alist_expand_to(struct alist *lst, uint new_alloc)
+{
+	void *new_data;
+
+	if (lst->flags & ALISTF_FAIL)
+		return false;
+
+	if (CONFIG_IS_ENABLED(ALIST_REALLOC))
+		new_data = realloc(lst->data, lst->obj_size * new_alloc);
+	else
+		new_data = malloc(lst->obj_size * new_alloc);
+	if (!new_data) {
+		lst->flags |= ALISTF_FAIL;
+		return false;
+	}
+
+	if (!CONFIG_IS_ENABLED(ALIST_REALLOC)) {
+		memcpy(new_data, lst->data, lst->obj_size * lst->alloc);
+		free(lst->data);
+	}
+
+	memset(new_data + lst->obj_size * lst->alloc, '\0',
+	       lst->obj_size * (new_alloc - lst->alloc));
+	lst->alloc = new_alloc;
+	lst->data = new_data;
+
+	return true;
+}
+
+bool alist_expand_by(struct alist *lst, uint inc_by)
+{
+	return alist_expand_to(lst, lst->alloc + inc_by);
+}
+
+/**
+ * alist_expand_min() - Expand to at least the provided size
+ *
+ * Expands to the lowest power of two which can incorporate the new size
+ *
+ * @lst: alist to expand
+ * @min_alloc: Minimum new allocated size; if 0 then ALIST_INITIAL_SIZE is used
+ * Return: true if OK, false if out of memory
+ */
+static bool alist_expand_min(struct alist *lst, uint min_alloc)
+{
+	uint new_alloc;
+
+	for (new_alloc = lst->alloc ?: ALIST_INITIAL_SIZE;
+	     new_alloc < min_alloc;)
+		new_alloc *= 2;
+
+	return alist_expand_to(lst, new_alloc);
+}
+
+const void *alist_get_ptr(const struct alist *lst, uint index)
+{
+	if (index >= lst->count)
+		return NULL;
+
+	return lst->data + index * lst->obj_size;
+}
+
+void *alist_ensure_ptr(struct alist *lst, uint index)
+{
+	uint minsize = index + 1;
+	void *ptr;
+
+	if (index >= lst->alloc && !alist_expand_min(lst, minsize))
+		return NULL;
+
+	ptr = lst->data + index * lst->obj_size;
+	if (minsize >= lst->count)
+		lst->count = minsize;
+
+	return ptr;
+}
+
+void *alist_add_ptr(struct alist *lst, void *obj)
+{
+	void *ptr;
+
+	ptr = alist_ensure_ptr(lst, lst->count);
+	if (!ptr)
+		return ptr;
+	memcpy(ptr, obj, lst->obj_size);
+
+	return ptr;
+}
+
+void *alist_uninit_move_ptr(struct alist *alist, size_t *countp)
+{
+	void *ptr;
+
+	if (countp)
+		*countp = alist->count;
+	if (!alist->count) {
+		alist_uninit(alist);
+		return NULL;
+	}
+
+	ptr = alist->data;
+
+	/* Clear everything out so there is no record of the data */
+	alist_init(alist, alist->obj_size, 0);
+
+	return ptr;
+}
diff --git a/test/lib/Makefile b/test/lib/Makefile
index e75a263e6a4..70f14c46b1e 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -5,6 +5,7 @@
 ifeq ($(CONFIG_SPL_BUILD),)
 obj-y += cmd_ut_lib.o
 obj-y += abuf.o
+obj-y += alist.o
 obj-$(CONFIG_EFI_LOADER) += efi_device_path.o
 obj-$(CONFIG_EFI_SECURE_BOOT) += efi_image_region.o
 obj-y += hexdump.o
diff --git a/test/lib/alist.c b/test/lib/alist.c
new file mode 100644
index 00000000000..f9050a963e0
--- /dev/null
+++ b/test/lib/alist.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <alist.h>
+#include <string.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+struct my_struct {
+	uint val;
+	uint other_val;
+};
+
+enum {
+	obj_size	= sizeof(struct my_struct),
+};
+
+/* Test alist_init() */
+static int lib_test_alist_init(struct unit_test_state *uts)
+{
+	struct alist lst;
+	ulong start;
+
+	start = ut_check_free();
+
+	/* with a size of 0, the fields should be inited, with no memory used */
+	memset(&lst, '\xff', sizeof(lst));
+	ut_assert(alist_init_struct(&lst, struct my_struct));
+	ut_asserteq_ptr(NULL, lst.data);
+	ut_asserteq(0, lst.count);
+	ut_asserteq(0, lst.alloc);
+	ut_assertok(ut_check_delta(start));
+	alist_uninit(&lst);
+	ut_asserteq_ptr(NULL, lst.data);
+	ut_asserteq(0, lst.count);
+	ut_asserteq(0, lst.alloc);
+
+	/* use an impossible size */
+	ut_asserteq(false, alist_init(&lst, obj_size,
+				      CONFIG_SYS_MALLOC_LEN));
+	ut_assertnull(lst.data);
+	ut_asserteq(0, lst.count);
+	ut_asserteq(0, lst.alloc);
+
+	/* use a small size */
+	ut_assert(alist_init(&lst, obj_size, 4));
+	ut_assertnonnull(lst.data);
+	ut_asserteq(0, lst.count);
+	ut_asserteq(4, lst.alloc);
+
+	/* free it */
+	alist_uninit(&lst);
+	ut_asserteq_ptr(NULL, lst.data);
+	ut_asserteq(0, lst.count);
+	ut_asserteq(0, lst.alloc);
+	ut_assertok(ut_check_delta(start));
+
+	/* Check for memory leaks */
+	ut_assertok(ut_check_delta(start));
+
+	return 0;
+}
+LIB_TEST(lib_test_alist_init, 0);
+
+/* Test alist_get() and alist_getd() */
+static int lib_test_alist_get(struct unit_test_state *uts)
+{
+	struct alist lst;
+	ulong start;
+	void *ptr;
+
+	start = ut_check_free();
+
+	ut_assert(alist_init(&lst, obj_size, 3));
+	ut_asserteq(0, lst.count);
+	ut_asserteq(3, lst.alloc);
+
+	ut_assertnull(alist_get_ptr(&lst, 2));
+	ut_assertnull(alist_get_ptr(&lst, 3));
+
+	ptr = alist_ensure_ptr(&lst, 1);
+	ut_assertnonnull(ptr);
+	ut_asserteq(2, lst.count);
+	ptr = alist_ensure_ptr(&lst, 2);
+	ut_asserteq(3, lst.count);
+	ut_assertnonnull(ptr);
+
+	ptr = alist_ensure_ptr(&lst, 3);
+	ut_assertnonnull(ptr);
+	ut_asserteq(4, lst.count);
+	ut_asserteq(6, lst.alloc);
+
+	ut_assertnull(alist_get_ptr(&lst, 4));
+
+	alist_uninit(&lst);
+
+	/* Check for memory leaks */
+	ut_assertok(ut_check_delta(start));
+
+	return 0;
+}
+LIB_TEST(lib_test_alist_get, 0);
+
+/* Test alist_has() */
+static int lib_test_alist_has(struct unit_test_state *uts)
+{
+	struct alist lst;
+	ulong start;
+	void *ptr;
+
+	start = ut_check_free();
+
+	ut_assert(alist_init(&lst, obj_size, 3));
+
+	ut_assert(!alist_has(&lst, 0));
+	ut_assert(!alist_has(&lst, 1));
+	ut_assert(!alist_has(&lst, 2));
+	ut_assert(!alist_has(&lst, 3));
+
+	/* create a new one to force expansion */
+	ptr = alist_ensure_ptr(&lst, 4);
+	ut_assertnonnull(ptr);
+
+	ut_assert(alist_has(&lst, 0));
+	ut_assert(alist_has(&lst, 1));
+	ut_assert(alist_has(&lst, 2));
+	ut_assert(alist_has(&lst, 3));
+	ut_assert(alist_has(&lst, 4));
+	ut_assert(!alist_has(&lst, 5));
+
+	alist_uninit(&lst);
+
+	/* Check for memory leaks */
+	ut_assertok(ut_check_delta(start));
+
+	return 0;
+}
+LIB_TEST(lib_test_alist_has, 0);
+
+/* Test alist_ensure() */
+static int lib_test_alist_ensure(struct unit_test_state *uts)
+{
+	struct my_struct *ptr3, *ptr4;
+	struct alist lst;
+	ulong start;
+
+	start = ut_check_free();
+
+	ut_assert(alist_init_struct(&lst, struct my_struct));
+	ut_asserteq(obj_size, lst.obj_size);
+	ut_asserteq(0, lst.count);
+	ut_asserteq(0, lst.alloc);
+	ptr3 = alist_ensure_ptr(&lst, 3);
+	ut_asserteq(4, lst.count);
+	ut_asserteq(4, lst.alloc);
+	ut_assertnonnull(ptr3);
+	ptr3->val = 3;
+
+	ptr4 = alist_ensure_ptr(&lst, 4);
+	ut_asserteq(8, lst.alloc);
+	ut_asserteq(5, lst.count);
+	ut_assertnonnull(ptr4);
+	ptr4->val = 4;
+	ut_asserteq(4, alist_get(&lst, 4, struct my_struct)->val);
+
+	ut_asserteq_ptr(ptr4, alist_ensure(&lst, 4, struct my_struct));
+
+	alist_ensure(&lst, 4, struct my_struct)->val = 44;
+	ut_asserteq(44, alist_get(&lst, 4, struct my_struct)->val);
+	ut_asserteq(3, alist_get(&lst, 3, struct my_struct)->val);
+	ut_assertnull(alist_get(&lst, 7, struct my_struct));
+	ut_asserteq(8, lst.alloc);
+	ut_asserteq(5, lst.count);
+
+	/* add some more, checking handling of malloc() failure */
+	malloc_enable_testing(0);
+	ut_assertnonnull(alist_ensure(&lst, 7, struct my_struct));
+	ut_assertnull(alist_ensure(&lst, 8, struct my_struct));
+	malloc_disable_testing();
+
+	lst.flags &= ~ALISTF_FAIL;
+	ut_assertnonnull(alist_ensure(&lst, 8, struct my_struct));
+	ut_asserteq(16, lst.alloc);
+	ut_asserteq(9, lst.count);
+
+	alist_uninit(&lst);
+
+	/* Check for memory leaks */
+	ut_assertok(ut_check_delta(start));
+
+	return 0;
+}
+LIB_TEST(lib_test_alist_ensure, 0);
-- 
2.34.1

