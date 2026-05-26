Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95E2CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 20:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18840848DC;
	Tue, 26 May 2026 22:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JCkpwNHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C7E1846DF; Tue, 26 May 2026 22:22:28 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6AE584855
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 22:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dcdaf06498so7168848a34.2
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779826944; x=1780431744; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qpmOmyoaZt0aRwPW4WaC56s2UJTLtFbW7bmsi5u99pQ=;
 b=JCkpwNHchqHFmm8xJBMH9ololvE/hJSKPRlTuT7juCFgt6ESNtIAys0XkXLL+gVllA
 zf+PaI4yE1MSQ3Y1/sNp0ZKUh42HRAA2Q2qjHk/JU2vLC1A/sTXM+eoXNLSNWkquvnFb
 qFBt7L5yIm2xpTFL6mDoum9tDxNFjGApAJs2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779826944; x=1780431744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qpmOmyoaZt0aRwPW4WaC56s2UJTLtFbW7bmsi5u99pQ=;
 b=Z3unsp9HPalF8fh3odUYhbIf+IhKnySXrewCcHMTHHg0hwOTFogfaRPxfsNMv7Y+rH
 e6/LC3o6WTpwd5Ln+8yqQOyE846Nc72jsy/zvRP4SCYVs7gtgalMoM/6aZbzmpZHaloa
 UyAb3vmOgohjvPJHCE86crZNNZpqpq57UZJjqJjAc1F+KoQgauP3yy34EDRUgY4yiwp8
 dqvNGzHlSB+yJAxMiq5EnBUJQK48TTW/9ipsnLp7RmNgR/IcdSphG5V5nz4NKsW0YDzy
 nmn+3q4fsxX8LH2zJiLyk+3r9Nqg6roXc4YbqYQqCl7aIjd/OCDBO7XXBm54hNjn1GtV
 JbMA==
X-Gm-Message-State: AOJu0Yw8O/aaw+wKGUpO1mSZB6YO1PqtQP4fveP+0cjygdVYM4hLkBjj
 Ls5BhpUayv5CbChapLumrs/ykDu54psNACiX6rT+ufT4ucaEzyzrEQ582Y17ELGiaKsvy3Ip/Wp
 SpLAGjqs=
X-Gm-Gg: Acq92OEzUSfJ8rAf26prAnRvhPK1/IsEhbb5qnjiCN9lvx73gbW8Qa05+NQDl5W5C+E
 AcRQ6KWPqs9rVILuRIQCuEqys5zzLetLAfMbxm56fAxgUnC0uB1L/5MCJ0gz6lLSnT+v+xHA399
 rHix3s2rrq2uDBwAlMTwDVFP0En3ClquzQDmHZ6j6pyx/DPcMSHfFGt7BpHRyzBMyzaGvBLBetm
 oo7OQxe3fmASgsx6zkzBxH/msnFYbQfKwPclOyYHU48xB5agaGM7G5NSyqEf9kx0YFSkk6Zu2Er
 jvd+TJLZ040hgUzmbq4XSiIr8EWt+1EIpWv9Xzrx+jNVVPbSyQiEE1pgacnLCnGV50ke/s7yyEb
 f33Mloifyp/2L2uAz232VXa0QTTN2RDE1P/Aldo9CfRnEvK73RaaNKAQ1NuqJGBOCMVIk3OSCxD
 N4tX9cY/uNrJCsgB4rzn9iSudqd2fZoxDq0gcpQAB+5OZxrWnMnoRTt+gTwgzK6oMkEnqfdbLND
 9GBY2Vgs/poM9XbaMuinE/5cg7NiKWLT53rLkSy7e51FC8h+dGUymHEqMZD9k4m4xpFhQ==
X-Received: by 2002:a05:6830:6384:b0:7d7:4ee9:c39a with SMTP id
 46e09a7af769-7e5fee66230mr11946222a34.4.1779826944300; 
 Tue, 26 May 2026 13:22:24 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60663a2cbsm10593685a34.19.2026.05.26.13.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 13:22:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anton Ivanov <anton@binarly.io>
Subject: [PATCH 1/2] dtc: Resync fdt_check_full() with upstream version
 v1.7.2-35-g52f07dcca47c
Date: Tue, 26 May 2026 14:19:27 -0600
Message-ID: <20260526202218.4004070-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526202218.4004070-1-trini@konsulko.com>
References: <20260526202218.4004070-1-trini@konsulko.com>
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

In the upstream project, the function fdt_check_full has been moved from
fdt_ro.c to its own file, fdt_check.c. This file is not included in the
Linux kernel copy and so has not been synced over. As we do need and use
the fdt_check_full function, bring that file over as of the current
upstream we are synced to. Remove our copy of this function from
fdt_ro.c and add fdt_check.o and 1-liner fdt_check.c where needed. Note
that for now, this will increase size in some cases as upstream does not
have a size reduction method here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 lib/libfdt/Makefile                |  1 +
 lib/libfdt/fdt_check.c             |  2 +
 scripts/dtc/Makefile               |  2 +-
 scripts/dtc/libfdt/Makefile.libfdt |  2 +-
 scripts/dtc/libfdt/fdt_check.c     | 96 ++++++++++++++++++++++++++++++
 scripts/dtc/libfdt/fdt_ro.c        | 88 ---------------------------
 scripts/dtc/update-dtc-source.sh   |  2 +-
 tools/Makefile                     |  3 +-
 tools/libfdt/fdt_check.c           |  2 +
 9 files changed, 106 insertions(+), 92 deletions(-)
 create mode 100644 lib/libfdt/fdt_check.c
 create mode 100644 scripts/dtc/libfdt/fdt_check.c
 create mode 100644 tools/libfdt/fdt_check.c

diff --git a/lib/libfdt/Makefile b/lib/libfdt/Makefile
index c492377032b7..b4113cfb478f 100644
--- a/lib/libfdt/Makefile
+++ b/lib/libfdt/Makefile
@@ -5,6 +5,7 @@
 
 obj-y += \
 	fdt.o \
+	fdt_check.o \
 	fdt_ro.o \
 	fdt_wip.o \
 	fdt_strerror.o \
diff --git a/lib/libfdt/fdt_check.c b/lib/libfdt/fdt_check.c
new file mode 100644
index 000000000000..b7fa4a7c0bbb
--- /dev/null
+++ b/lib/libfdt/fdt_check.c
@@ -0,0 +1,2 @@
+#include <linux/libfdt_env.h>
+#include "../../scripts/dtc/libfdt/fdt_check.c"
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 2ba8dba03be4..6aecae1c6dda 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -10,7 +10,7 @@ dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
 
 # The upstream project builds libfdt as a separate library.  We are choosing to
 # instead directly link the libfdt object files into fdtoverlay.
-libfdt-objs	:= fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o fdt_strerror.o fdt_empty_tree.o fdt_addresses.o fdt_overlay.o
+libfdt-objs	:= fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o fdt_strerror.o fdt_empty_tree.o fdt_addresses.o fdt_overlay.o fdt_check.o
 libfdt		= $(addprefix libfdt/,$(libfdt-objs))
 fdtoverlay-objs	:= $(libfdt) fdtoverlay.o util.o
 
diff --git a/scripts/dtc/libfdt/Makefile.libfdt b/scripts/dtc/libfdt/Makefile.libfdt
index e54639738c8e..b6d8fc02dd0b 100644
--- a/scripts/dtc/libfdt/Makefile.libfdt
+++ b/scripts/dtc/libfdt/Makefile.libfdt
@@ -8,7 +8,7 @@ LIBFDT_soname = libfdt.$(SHAREDLIB_EXT).1
 LIBFDT_INCLUDES = fdt.h libfdt.h libfdt_env.h
 LIBFDT_VERSION = version.lds
 LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c fdt_empty_tree.c \
-	fdt_addresses.c fdt_overlay.c
+	fdt_addresses.c fdt_overlay.c fdt_check.c
 LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
 LIBFDT_LIB = libfdt-$(DTC_VERSION).$(SHAREDLIB_EXT)
 
diff --git a/scripts/dtc/libfdt/fdt_check.c b/scripts/dtc/libfdt/fdt_check.c
new file mode 100644
index 000000000000..a21ebbc9239f
--- /dev/null
+++ b/scripts/dtc/libfdt/fdt_check.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * libfdt - Flat Device Tree manipulation
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
+ */
+#include "libfdt_env.h"
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "libfdt_internal.h"
+
+int fdt_check_full(const void *fdt, size_t bufsize)
+{
+	int err;
+	int num_memrsv;
+	int offset, nextoffset = 0;
+	uint32_t tag;
+	unsigned int depth = 0;
+	const void *prop;
+	const char *propname;
+	bool expect_end = false;
+
+	if (bufsize < FDT_V1_SIZE)
+		return -FDT_ERR_TRUNCATED;
+	if (bufsize < fdt_header_size(fdt))
+		return -FDT_ERR_TRUNCATED;
+	err = fdt_check_header(fdt);
+	if (err != 0)
+		return err;
+	if (bufsize < fdt_totalsize(fdt))
+		return -FDT_ERR_TRUNCATED;
+
+	num_memrsv = fdt_num_mem_rsv(fdt);
+	if (num_memrsv < 0)
+		return num_memrsv;
+
+	while (1) {
+		offset = nextoffset;
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
+
+		if (nextoffset < 0)
+			return nextoffset;
+
+		/* If we see two root nodes, something is wrong */
+		if (expect_end && tag != FDT_END)
+			return -FDT_ERR_BADSTRUCTURE;
+
+		switch (tag) {
+		case FDT_NOP:
+			break;
+
+		case FDT_END:
+			if (depth != 0)
+				return -FDT_ERR_BADSTRUCTURE;
+			return 0;
+
+		case FDT_BEGIN_NODE:
+			depth++;
+			if (depth > INT_MAX)
+				return -FDT_ERR_BADSTRUCTURE;
+
+			/* The root node must have an empty name */
+			if (depth == 1) {
+				const char *name;
+				int len;
+
+				name = fdt_get_name(fdt, offset, &len);
+				if (!name)
+					return len;
+
+				if (*name || len)
+					return -FDT_ERR_BADSTRUCTURE;
+			}
+			break;
+
+		case FDT_END_NODE:
+			if (depth == 0)
+				return -FDT_ERR_BADSTRUCTURE;
+			depth--;
+			if (depth == 0)
+				expect_end = true;
+			break;
+
+		case FDT_PROP:
+			prop = fdt_getprop_by_offset(fdt, offset, &propname,
+						     &err);
+			if (!prop)
+				return err;
+			break;
+
+		default:
+			return -FDT_ERR_INTERNAL;
+		}
+	}
+}
diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
index 3e7e26b4398e..065baa707355 100644
--- a/scripts/dtc/libfdt/fdt_ro.c
+++ b/scripts/dtc/libfdt/fdt_ro.c
@@ -884,91 +884,3 @@ int fdt_node_offset_by_compatible(const void *fdt, int startoffset,
 
 	return offset; /* error from fdt_next_node() */
 }
-
-#if !defined(FDT_ASSUME_MASK) || FDT_ASSUME_MASK != 0xff
-int fdt_check_full(const void *fdt, size_t bufsize)
-{
-	int err;
-	int num_memrsv;
-	int offset, nextoffset = 0;
-	uint32_t tag;
-	unsigned depth = 0;
-	const void *prop;
-	const char *propname;
-	bool expect_end = false;
-
-	if (bufsize < FDT_V1_SIZE)
-		return -FDT_ERR_TRUNCATED;
-	err = fdt_check_header(fdt);
-	if (err != 0)
-		return err;
-	if (bufsize < fdt_totalsize(fdt))
-		return -FDT_ERR_TRUNCATED;
-
-	num_memrsv = fdt_num_mem_rsv(fdt);
-	if (num_memrsv < 0)
-		return num_memrsv;
-
-	while (1) {
-		offset = nextoffset;
-		tag = fdt_next_tag(fdt, offset, &nextoffset);
-
-		if (nextoffset < 0)
-			return nextoffset;
-
-		/* If we see two root nodes, something is wrong */
-		if (expect_end && tag != FDT_END)
-			return -FDT_ERR_BADLAYOUT;
-
-		switch (tag) {
-		case FDT_NOP:
-			break;
-
-		case FDT_END:
-			if (depth != 0)
-				return -FDT_ERR_BADSTRUCTURE;
-			return 0;
-
-		case FDT_BEGIN_NODE:
-			depth++;
-			if (depth > INT_MAX)
-				return -FDT_ERR_BADSTRUCTURE;
-
-			/* The root node must have an empty name */
-			if (depth == 1) {
-				const char *name;
-				int len;
-
-				name = fdt_get_name(fdt, offset, &len);
-				if (*name || len)
-					return -FDT_ERR_BADLAYOUT;
-			}
-			break;
-
-		case FDT_END_NODE:
-			if (depth == 0)
-				return -FDT_ERR_BADSTRUCTURE;
-			depth--;
-			if (depth == 0)
-				expect_end = true;
-			break;
-
-		case FDT_PROP:
-			prop = fdt_getprop_by_offset(fdt, offset, &propname,
-						     &err);
-			if (!prop)
-				return err;
-			break;
-
-		default:
-			return -FDT_ERR_INTERNAL;
-		}
-	}
-}
-#else
-int fdt_check_full(const void __always_unused *fdt,
-		   size_t __always_unused bufsize)
-{
-	return 0;
-}
-#endif /* #if !defined(FDT_ASSUME_MASK) || FDT_ASSUME_MASK != 0xff */
diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-source.sh
index 94627541533e..2b62da683681 100755
--- a/scripts/dtc/update-dtc-source.sh
+++ b/scripts/dtc/update-dtc-source.sh
@@ -34,7 +34,7 @@ DTC_LINUX_PATH=`pwd`/scripts/dtc
 DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c \
 		srcpos.h treesource.c util.c util.h version_gen.h \
 		dtc-lexer.l dtc-parser.y"
-LIBFDT_SOURCE="fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
+LIBFDT_SOURCE="fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c fdt_check.c \
 		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
 		fdt_wip.c libfdt.h libfdt_env.h libfdt_internal.h"
 FDTOVERLAY_SOURCE=fdtoverlay.c
diff --git a/tools/Makefile b/tools/Makefile
index 1a5f425ecdaa..535a5d51c89e 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -82,7 +82,8 @@ HOSTCFLAGS_image-host.o += \
 # The following files are synced with upstream DTC.
 # Use synced versions from scripts/dtc/libfdt/.
 LIBFDT_OBJS := $(addprefix libfdt/, fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o \
-		fdt_strerror.o fdt_empty_tree.o fdt_addresses.o fdt_overlay.o)
+		fdt_strerror.o fdt_empty_tree.o fdt_addresses.o fdt_overlay.o \
+		fdt_check.o)
 
 RSA_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/rsa/, \
 					rsa-sign.o rsa-verify.o \
diff --git a/tools/libfdt/fdt_check.c b/tools/libfdt/fdt_check.c
new file mode 100644
index 000000000000..a17a0194f5c5
--- /dev/null
+++ b/tools/libfdt/fdt_check.c
@@ -0,0 +1,2 @@
+#include "fdt_host.h"
+#include "../scripts/dtc/libfdt/fdt_check.c"
-- 
2.43.0

