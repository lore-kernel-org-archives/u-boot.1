Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE35D1266A
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 19:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5872E83EC8;
	Tue,  2 Dec 2025 20:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MhfiLBgZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OmZj4Erm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C8B983F00; Tue,  2 Dec 2025 20:33:29 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32BBE83C01
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 20:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dLWCN5Bwcz9tGj;
 Tue,  2 Dec 2025 20:33:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764704000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cMg/ZkmSALXAaQIYXA39g7cEIDfaURQFl3NFuQbyCKI=;
 b=MhfiLBgZP6urVWEEOghPV+kipf6f2cpAPLhR3sn3DVzAh55IZe3kmtp+d9uB+jHlELPFQ8
 0Kstl93mE5QrFMneU8xJYoJ61R12AlbpCpU3BP1UMrQDYLMdaxhyr3XMoAJpGnFCeopLAI
 r1jS2u64B5R5Gg6tRheb07Bbpr+owXRJFNxqd4FDyaaQ4ytm175JVWLaS0OoWV5vWvzZ/6
 TPAvLIPpIWR1eUxn5283t8A2STtKn+Ey2lCtfrb7gpVi/xPfmV3J7Hfr2r2m7qvq5gVufF
 hPxa39A0f4kNE3smyi46m7odp8SBBf0PNWLzTDtWpD1cIE7oaquDySf9mhn0Dw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=OmZj4Erm;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764703998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cMg/ZkmSALXAaQIYXA39g7cEIDfaURQFl3NFuQbyCKI=;
 b=OmZj4ErmmBktymf4iXtmujSO+UyQnpa6dqG/E0GYYFDiRbr/sVgULpnnp9PEbQa7xaE+eS
 940Fs29t0BjTSp/0i2dS4pu8x1GfqRYyauvXeTrDv0ogNxSkGAILPKQqEut6PFUkQlXf/e
 ErbEr58cDtow90pr6Al0eCipGxxrmQfX2du/E4wHKjDCotsu368SuEpcxfo2PLIojz8krw
 Tk7BmzuepOgKwyFSgcgXofG1eeP6xYuAXg5sUNx7Z3s0JuszOWsizgUUNckGiNawH6AM4L
 46NUeW6+gTZ4l+D6QcDrIzxy9wHrylI0XcTC6xDnEQEpN1i2ucRdp2ImS2i5+Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Date: Tue,  2 Dec 2025 20:32:50 +0100
Message-ID: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: aea3dec110afbbe7d29
X-MBO-RS-META: pr1m4adoyj1j8efpjo4o7za5gj6dnbk7
X-Rspamd-Queue-Id: 4dLWCN5Bwcz9tGj
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

Synchronize local copy of DTC with Linux 6.17 . This includes the
following picked and squashed commits from Linux kernel. The squash
was necessary, since the DTC here contains changes which were also
part of DTC in Linux alraedy, and the squash helped resolve those
without going back and forth with the changes.

The following commits from Linux are picked:

8f324cd712df7 # scripts/dtc: consolidate include path options in Makefile
b5b3d9b63b0ee # scripts/dtc: Add yamltree.c to dtc sources
7d97a76f226d6 # scripts/dtc: Update to upstream version v1.4.7-14-gc86da84d30e4
ea6f243be74e5 # scripts/dtc: Update to upstream version v1.4.7-57-gf267e674d145
02d435d4eccd8 # scripts/dtc: Update to upstream version v1.5.0-23-g87963ee20693
6e321b7637396 # scripts/dtc: Update to upstream version v1.5.0-30-g702c1b6c0e73
9f19ec91a7a35 # scripts/dtc: dtx_diff - add color output support
8287d642f38d1 # scripts/dtc: Update to upstream version v1.5.1-22-gc40aeb60b47a
4c52deef9225d # scripts/dtc: Revert "yamltree: Ensure consistent bracketing of properties with phandles"
5d3827e1452ed # scripts/dtc: Remove unused makefile fragments
40dd266887654 # scripts/dtc: Update to upstream version v1.6.0-2-g87a656ae5ff9
8d4cf6b6acb59 # scripts/dtc: use pkg-config to include <yaml.h> in non-standard path
b9bf9ace5ae90 # scripts/dtc: Update to upstream version v1.6.0-11-g9d7888cbf19c
69a883b6f5ac0 # scripts/dtc: dtx_diff - make help text formatting consistent
8f829108b8aed # scripts/dtc: only append to HOST_EXTRACFLAGS instead of overwriting
b39b4342ac495 # scripts/dtc: Update to upstream version v1.6.0-31-gcbca977ea121
93c6424c486b3 # scripts: dtc: Fetch fdtoverlay.c from external DTC project
0dd574a1d75c3 # scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9
ec38b5df8a231 # scripts: dtc: Build fdtoverlay tool
a0c8c431411f5 # scripts: dtc: Remove the unused fdtdump.c file
e7dc653d4e890 # scripts/dtc: Add missing fdtoverlay to gitignore
d2bf5d2e3f09c # scripts/dtc: Update to upstream version v1.6.1-19-g0a3a9d3449c8
a60878f5532d0 # scripts/dtc: dtx_diff: remove broken example from help text
8b739d8658a9b # scripts/dtc: Call pkg-config POSIXly correct
b6eeafa67df00 # scripts/dtc: Update to upstream version v1.6.1-63-g55778a03df61
f96cc4c787588 # scripts/dtc: Update to upstream version v1.6.1-66-gabbd523bae6e
09ab9c092ef2b # scripts/dtc: Update to upstream version v1.7.0-93-g1df7b047fe43
ded8a5a498f2d # scripts/dtc: Update to upstream version v1.7.0-95-gbcd02b523429
ee6ff6fca7e71 # scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c

This also includes forward port of U-Boot commit
e8c2d25845c7 ("libfdt: Revert 6dcb8ba4 from upstream libfdt")
to avoid binary size growth.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Sam Edwards <cfsworks@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: - Fix off-by-one in fdt_remove_unused_strings()
    - Restore e8c2d25845c7 ("libfdt: Revert 6dcb8ba4 from upstream libfdt")
---
 scripts/Makefile.lib                 |   4 +-
 scripts/dtc/.gitignore               |   1 +
 scripts/dtc/Makefile                 |  23 +-
 scripts/dtc/Makefile.dtc             |  18 -
 scripts/dtc/checks.c                 | 686 +++++++++++++++++++++------
 scripts/dtc/data.c                   |  74 ++-
 scripts/dtc/dtc-lexer.l              |  38 +-
 scripts/dtc/dtc-parser.y             | 109 +++--
 scripts/dtc/dtc.c                    |  58 ++-
 scripts/dtc/dtc.h                    | 137 ++++--
 scripts/dtc/fdtoverlay.c             | 214 +++++++++
 scripts/dtc/flattree.c               |  70 ++-
 scripts/dtc/fstree.c                 |  26 +-
 scripts/dtc/libfdt/fdt.c             |  84 ++--
 scripts/dtc/libfdt/fdt.h             |   4 +-
 scripts/dtc/libfdt/fdt_addresses.c   |   2 +-
 scripts/dtc/libfdt/fdt_overlay.c     | 386 +++++++++++----
 scripts/dtc/libfdt/fdt_ro.c          | 100 ++--
 scripts/dtc/libfdt/fdt_rw.c          | 101 ++--
 scripts/dtc/libfdt/fdt_strerror.c    |   1 +
 scripts/dtc/libfdt/fdt_sw.c          |  26 +-
 scripts/dtc/libfdt/libfdt.h          | 414 +++++++++++++---
 scripts/dtc/libfdt/libfdt_internal.h | 141 ++++--
 scripts/dtc/livetree.c               | 156 +++---
 scripts/dtc/srcpos.c                 | 190 ++++++--
 scripts/dtc/srcpos.h                 |  31 +-
 scripts/dtc/treesource.c             | 319 ++++++++-----
 scripts/dtc/update-dtc-source.sh     |   7 +-
 scripts/dtc/util.c                   | 122 ++---
 scripts/dtc/util.h                   |  61 +--
 scripts/dtc/version_gen.h            |   2 +-
 scripts/dtc/yamltree.c               | 235 +++++++++
 tools/libfdt/fdt_rw.c                |   2 +-
 33 files changed, 2830 insertions(+), 1012 deletions(-)
 delete mode 100644 scripts/dtc/Makefile.dtc
 create mode 100644 scripts/dtc/fdtoverlay.c
 create mode 100644 scripts/dtc/yamltree.c

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 791eb1cb327..b062db7e87f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -319,6 +319,7 @@ quiet_cmd_gzip = GZIP    $@
 # DTC
 # ---------------------------------------------------------------------------
 DTC ?= $(objtree)/scripts/dtc/dtc
+DTC_FLAGS += -Wno-interrupt_provider
 
 # Disable noisy checks by default
 ifeq ($(findstring 1,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
@@ -338,7 +339,8 @@ endif
 
 ifneq ($(findstring 2,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
 DTC_FLAGS += -Wnode_name_chars_strict \
-	-Wproperty_name_chars_strict
+	-Wproperty_name_chars_strict \
+	-Winterrupt_provider
 endif
 
 DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
diff --git a/scripts/dtc/.gitignore b/scripts/dtc/.gitignore
index 689b9be0f93..60984f72e27 100644
--- a/scripts/dtc/.gitignore
+++ b/scripts/dtc/.gitignore
@@ -1 +1,2 @@
 /dtc
+/fdtoverlay
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index faa72d95e28..73081b17d18 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -1,15 +1,32 @@
 # SPDX-License-Identifier: GPL-2.0
 # scripts/dtc makefile
 
-hostprogs-y	:= dtc
-always		:= $(hostprogs-y)
+# *** Also keep .gitignore in sync when changing ***
+hostprogs-y	+= dtc fdtoverlay
+always		+= dtc
 
 dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
 		   srcpos.o checks.o util.o
 dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
 
+# The upstream project builds libfdt as a separate library.  We are choosing to
+# instead directly link the libfdt object files into fdtoverlay.
+libfdt-objs	:= fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o fdt_strerror.o fdt_empty_tree.o fdt_addresses.o fdt_overlay.o
+libfdt		= $(addprefix libfdt/,$(libfdt-objs))
+fdtoverlay-objs	:= $(libfdt) fdtoverlay.o util.o
+
 # Source files need to get at the userspace version of libfdt_env.h to compile
-HOST_EXTRACFLAGS := -I$(src)/libfdt
+HOST_EXTRACFLAGS += -I$(src)/libfdt
+
+ifeq ($(wildcard /usr/include/yaml.h),)
+HOST_EXTRACFLAGS += -DNO_YAML
+else
+dtc-objs	+= yamltree.o
+# To include <yaml.h> installed in a non-default path
+HOSTCFLAGS_yamltree.o := $(shell pkg-config --cflags yaml-0.1)
+# To link libyaml installed in a non-default path
+HOSTLDLIBS_dtc	:= $(shell pkg-config --libs yaml-0.1)
+endif
 
 # Generated files need one more search path to include headers in source tree
 HOSTCFLAGS_dtc-lexer.lex.o := -I$(src)
diff --git a/scripts/dtc/Makefile.dtc b/scripts/dtc/Makefile.dtc
deleted file mode 100644
index bece49b3553..00000000000
--- a/scripts/dtc/Makefile.dtc
+++ /dev/null
@@ -1,18 +0,0 @@
-# Makefile.dtc
-#
-# This is not a complete Makefile of itself.  Instead, it is designed to
-# be easily embeddable into other systems of Makefiles.
-#
-DTC_SRCS = \
-	checks.c \
-	data.c \
-	dtc.c \
-	flattree.c \
-	fstree.c \
-	livetree.c \
-	srcpos.c \
-	treesource.c \
-	util.c
-
-DTC_GEN_SRCS = dtc-lexer.lex.c dtc-parser.tab.c
-DTC_OBJS = $(DTC_SRCS:%.c=%.o) $(DTC_GEN_SRCS:%.c=%.o)
diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index 2feec44a0f7..d10c49eeb2a 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -1,24 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2007.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include "dtc.h"
+#include "srcpos.h"
 
 #ifdef TRACE_CHECKS
 #define TRACE(c, ...) \
@@ -45,7 +31,7 @@ typedef void (*check_fn)(struct check *c, struct dt_info *dti, struct node *node
 struct check {
 	const char *name;
 	check_fn fn;
-	void *data;
+	const void *data;
 	bool warn, error;
 	enum checkstatus status;
 	bool inprogress;
@@ -78,23 +64,57 @@ static inline void  PRINTF(5, 6) check_msg(struct check *c, struct dt_info *dti,
 					   const char *fmt, ...)
 {
 	va_list ap;
-	va_start(ap, fmt);
+	char *str = NULL;
+	struct srcpos *pos = NULL;
+	char *file_str;
+
+	if (!(c->warn && (quiet < 1)) && !(c->error && (quiet < 2)))
+		return;
 
-	if ((c->warn && (quiet < 1))
-	    || (c->error && (quiet < 2))) {
-		fprintf(stderr, "%s: %s (%s): ",
-			strcmp(dti->outname, "-") ? dti->outname : "<stdout>",
+	if (prop && prop->srcpos)
+		pos = prop->srcpos;
+	else if (node && node->srcpos)
+		pos = node->srcpos;
+
+	if (pos) {
+		file_str = srcpos_string(pos);
+		xasprintf(&str, "%s", file_str);
+		free(file_str);
+	} else if (streq(dti->outname, "-")) {
+		xasprintf(&str, "<stdout>");
+	} else {
+		xasprintf(&str, "%s", dti->outname);
+	}
+
+	xasprintf_append(&str, ": %s (%s): ",
 			(c->error) ? "ERROR" : "Warning", c->name);
-		if (node) {
-			fprintf(stderr, "%s", node->fullpath);
-			if (prop)
-				fprintf(stderr, ":%s", prop->name);
-			fputs(": ", stderr);
-		}
-		vfprintf(stderr, fmt, ap);
-		fprintf(stderr, "\n");
+
+	if (node) {
+		if (prop)
+			xasprintf_append(&str, "%s:%s: ", node->fullpath, prop->name);
+		else
+			xasprintf_append(&str, "%s: ", node->fullpath);
 	}
+
+	va_start(ap, fmt);
+	xavsprintf_append(&str, fmt, ap);
 	va_end(ap);
+
+	xasprintf_append(&str, "\n");
+
+	if (!prop && pos) {
+		pos = node->srcpos;
+		while (pos->next) {
+			pos = pos->next;
+
+			file_str = srcpos_string(pos);
+			xasprintf_append(&str, "  also defined at %s\n", file_str);
+			free(file_str);
+		}
+	}
+
+	fputs(str, stderr);
+	free(str);
 }
 
 #define FAIL(c, dti, node, ...)						\
@@ -123,6 +143,14 @@ static void check_nodes_props(struct check *c, struct dt_info *dti, struct node
 		check_nodes_props(c, dti, child);
 }
 
+static bool is_multiple_of(int multiple, int divisor)
+{
+	if (divisor == 0)
+		return multiple == 0;
+	else
+		return (multiple % divisor) == 0;
+}
+
 static bool run_check(struct check *c, struct dt_info *dti)
 {
 	struct node *dt = dti->dt;
@@ -179,7 +207,7 @@ static void check_is_string(struct check *c, struct dt_info *dti,
 			    struct node *node)
 {
 	struct property *prop;
-	char *propname = c->data;
+	const char *propname = c->data;
 
 	prop = get_property(node, propname);
 	if (!prop)
@@ -198,7 +226,7 @@ static void check_is_string_list(struct check *c, struct dt_info *dti,
 {
 	int rem, l;
 	struct property *prop;
-	char *propname = c->data;
+	const char *propname = c->data;
 	char *str;
 
 	prop = get_property(node, propname);
@@ -226,7 +254,7 @@ static void check_is_cell(struct check *c, struct dt_info *dti,
 			  struct node *node)
 {
 	struct property *prop;
-	char *propname = c->data;
+	const char *propname = c->data;
 
 	prop = get_property(node, propname);
 	if (!prop)
@@ -277,19 +305,20 @@ ERROR(duplicate_property_names, check_duplicate_property_names, NULL);
 #define LOWERCASE	"abcdefghijklmnopqrstuvwxyz"
 #define UPPERCASE	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 #define DIGITS		"0123456789"
-#define PROPNODECHARS	LOWERCASE UPPERCASE DIGITS ",._+*#?-"
+#define NODECHARS	LOWERCASE UPPERCASE DIGITS ",._+-@"
+#define PROPCHARS	LOWERCASE UPPERCASE DIGITS ",._+*#?-"
 #define PROPNODECHARSSTRICT	LOWERCASE UPPERCASE DIGITS ",-"
 
 static void check_node_name_chars(struct check *c, struct dt_info *dti,
 				  struct node *node)
 {
-	int n = strspn(node->name, c->data);
+	size_t n = strspn(node->name, c->data);
 
 	if (n < strlen(node->name))
 		FAIL(c, dti, node, "Bad character '%c' in node name",
 		     node->name[n]);
 }
-ERROR(node_name_chars, check_node_name_chars, PROPNODECHARS "@");
+ERROR(node_name_chars, check_node_name_chars, NODECHARS);
 
 static void check_node_name_chars_strict(struct check *c, struct dt_info *dti,
 					 struct node *node)
@@ -310,6 +339,20 @@ static void check_node_name_format(struct check *c, struct dt_info *dti,
 }
 ERROR(node_name_format, check_node_name_format, NULL, &node_name_chars);
 
+static void check_node_name_vs_property_name(struct check *c,
+					     struct dt_info *dti,
+					     struct node *node)
+{
+	if (!node->parent)
+		return;
+
+	if (get_property(node->parent, node->name)) {
+		FAIL(c, dti, node, "node name and property name conflict");
+	}
+}
+WARNING(node_name_vs_property_name, check_node_name_vs_property_name,
+	NULL, &node_name_chars);
+
 static void check_unit_address_vs_reg(struct check *c, struct dt_info *dti,
 				      struct node *node)
 {
@@ -332,7 +375,7 @@ static void check_unit_address_vs_reg(struct check *c, struct dt_info *dti,
 			FAIL(c, dti, node, "node has a reg or ranges property, but no unit name");
 	} else {
 		if (unitname[0])
-			FAIL(c, dti, node, "node has a unit name, but no reg property");
+			FAIL(c, dti, node, "node has a unit name, but no reg or ranges property");
 	}
 }
 WARNING(unit_address_vs_reg, check_unit_address_vs_reg, NULL);
@@ -343,14 +386,14 @@ static void check_property_name_chars(struct check *c, struct dt_info *dti,
 	struct property *prop;
 
 	for_each_property(node, prop) {
-		int n = strspn(prop->name, c->data);
+		size_t n = strspn(prop->name, c->data);
 
 		if (n < strlen(prop->name))
 			FAIL_PROP(c, dti, node, prop, "Bad character '%c' in property name",
 				  prop->name[n]);
 	}
 }
-ERROR(property_name_chars, check_property_name_chars, PROPNODECHARS);
+ERROR(property_name_chars, check_property_name_chars, PROPCHARS);
 
 static void check_property_name_chars_strict(struct check *c,
 					     struct dt_info *dti,
@@ -360,7 +403,7 @@ static void check_property_name_chars_strict(struct check *c,
 
 	for_each_property(node, prop) {
 		const char *name = prop->name;
-		int n = strspn(name, c->data);
+		size_t n = strspn(name, c->data);
 
 		if (n == strlen(prop->name))
 			continue;
@@ -477,7 +520,7 @@ static cell_t check_phandle_prop(struct check *c, struct dt_info *dti,
 
 	phandle = propval_cell(prop);
 
-	if ((phandle == 0) || (phandle == -1)) {
+	if (!phandle_is_valid(phandle)) {
 		FAIL_PROP(c, dti, node, prop, "bad value (0x%x) in %s property",
 		     phandle, prop->name);
 		return 0;
@@ -536,7 +579,7 @@ static void check_name_properties(struct check *c, struct dt_info *dti,
 	if (!prop)
 		return; /* No name property, that's fine */
 
-	if ((prop->val.len != node->basenamelen+1)
+	if ((prop->val.len != node->basenamelen + 1U)
 	    || (memcmp(prop->val.val, node->name, node->basenamelen) != 0)) {
 		FAIL(c, dti, node, "\"name\" property is incorrect (\"%s\" instead"
 		     " of base node name)", prop->val.val);
@@ -625,6 +668,8 @@ ERROR(path_references, fixup_path_references, NULL, &duplicate_node_names);
 static void fixup_omit_unused_nodes(struct check *c, struct dt_info *dti,
 				    struct node *node)
 {
+	if (generate_symbols && node->labels)
+		return;
 	if (node->omit_if_unused && !node->is_referenced)
 		delete_node(node);
 }
@@ -635,7 +680,6 @@ ERROR(omit_unused_nodes, fixup_omit_unused_nodes, NULL, &phandle_references, &pa
  */
 WARNING_IF_NOT_CELL(address_cells_is_cell, "#address-cells");
 WARNING_IF_NOT_CELL(size_cells_is_cell, "#size-cells");
-WARNING_IF_NOT_CELL(interrupt_cells_is_cell, "#interrupt-cells");
 
 WARNING_IF_NOT_STRING(device_type_is_string, "device_type");
 WARNING_IF_NOT_STRING(model_is_string, "model");
@@ -650,8 +694,7 @@ static void check_names_is_string_list(struct check *c, struct dt_info *dti,
 	struct property *prop;
 
 	for_each_property(node, prop) {
-		const char *s = strrchr(prop->name, '-');
-		if (!s || !streq(s, "-names"))
+		if (!strends(prop->name, "-names"))
 			continue;
 
 		c->data = prop->name;
@@ -669,6 +712,11 @@ static void check_alias_paths(struct check *c, struct dt_info *dti,
 		return;
 
 	for_each_property(node, prop) {
+		if (streq(prop->name, "phandle")
+		    || streq(prop->name, "linux,phandle")) {
+			continue;
+		}
+
 		if (!prop->val.val || !get_node_by_path(dti->dt, prop->val.val)) {
 			FAIL_PROP(c, dti, node, prop, "aliases property is not a valid node (%s)",
 				  prop->val.val);
@@ -726,7 +774,7 @@ static void check_reg_format(struct check *c, struct dt_info *dti,
 	size_cells = node_size_cells(node->parent);
 	entrylen = (addr_cells + size_cells) * sizeof(cell_t);
 
-	if (!entrylen || (prop->val.len % entrylen) != 0)
+	if (!is_multiple_of(prop->val.len, entrylen))
 		FAIL_PROP(c, dti, node, prop, "property has invalid length (%d bytes) "
 			  "(#address-cells == %d, #size-cells == %d)",
 			  prop->val.len, addr_cells, size_cells);
@@ -738,13 +786,15 @@ static void check_ranges_format(struct check *c, struct dt_info *dti,
 {
 	struct property *prop;
 	int c_addr_cells, p_addr_cells, c_size_cells, p_size_cells, entrylen;
+	const char *ranges = c->data;
 
-	prop = get_property(node, "ranges");
+	prop = get_property(node, ranges);
 	if (!prop)
 		return;
 
 	if (!node->parent) {
-		FAIL_PROP(c, dti, node, prop, "Root node has a \"ranges\" property");
+		FAIL_PROP(c, dti, node, prop, "Root node has a \"%s\" property",
+			  ranges);
 		return;
 	}
 
@@ -756,23 +806,24 @@ static void check_ranges_format(struct check *c, struct dt_info *dti,
 
 	if (prop->val.len == 0) {
 		if (p_addr_cells != c_addr_cells)
-			FAIL_PROP(c, dti, node, prop, "empty \"ranges\" property but its "
+			FAIL_PROP(c, dti, node, prop, "empty \"%s\" property but its "
 				  "#address-cells (%d) differs from %s (%d)",
-				  c_addr_cells, node->parent->fullpath,
+				  ranges, c_addr_cells, node->parent->fullpath,
 				  p_addr_cells);
 		if (p_size_cells != c_size_cells)
-			FAIL_PROP(c, dti, node, prop, "empty \"ranges\" property but its "
+			FAIL_PROP(c, dti, node, prop, "empty \"%s\" property but its "
 				  "#size-cells (%d) differs from %s (%d)",
-				  c_size_cells, node->parent->fullpath,
+				  ranges, c_size_cells, node->parent->fullpath,
 				  p_size_cells);
-	} else if ((prop->val.len % entrylen) != 0) {
-		FAIL_PROP(c, dti, node, prop, "\"ranges\" property has invalid length (%d bytes) "
+	} else if (!is_multiple_of(prop->val.len, entrylen)) {
+		FAIL_PROP(c, dti, node, prop, "\"%s\" property has invalid length (%d bytes) "
 			  "(parent #address-cells == %d, child #address-cells == %d, "
-			  "#size-cells == %d)", prop->val.len,
+			  "#size-cells == %d)", ranges, prop->val.len,
 			  p_addr_cells, c_addr_cells, c_size_cells);
 	}
 }
-WARNING(ranges_format, check_ranges_format, NULL, &addr_size_cells);
+WARNING(ranges_format, check_ranges_format, "ranges", &addr_size_cells);
+WARNING(dma_ranges_format, check_ranges_format, "dma-ranges", &addr_size_cells);
 
 static const struct bus_type pci_bus = {
 	.name = "PCI",
@@ -842,7 +893,7 @@ static void check_pci_device_bus_num(struct check *c, struct dt_info *dti, struc
 	} else {
 		cells = (cell_t *)prop->val.val;
 		min_bus = fdt32_to_cpu(cells[0]);
-		max_bus = fdt32_to_cpu(cells[0]);
+		max_bus = fdt32_to_cpu(cells[1]);
 	}
 	if ((bus_num < min_bus) || (bus_num > max_bus))
 		FAIL_PROP(c, dti, node, prop, "PCI bus number %d out of range, expected (%d - %d)",
@@ -862,10 +913,8 @@ static void check_pci_device_reg(struct check *c, struct dt_info *dti, struct no
 		return;
 
 	prop = get_property(node, "reg");
-	if (!prop) {
-		FAIL(c, dti, node, "missing PCI reg property");
+	if (!prop)
 		return;
-	}
 
 	cells = (cell_t *)prop->val.val;
 	if (cells[1] || cells[2])
@@ -910,7 +959,7 @@ static bool node_is_compatible(struct node *node, const char *compat)
 
 	for (str = prop->val.val, end = str + prop->val.len; str < end;
 	     str += strnlen(str, end - str) + 1) {
-		if (strprefixeq(str, end - str, compat))
+		if (streq(str, compat))
 			return true;
 	}
 	return false;
@@ -921,7 +970,8 @@ static void check_simple_bus_bridge(struct check *c, struct dt_info *dti, struct
 	if (node_is_compatible(node, "simple-bus"))
 		node->bus = &simple_bus;
 }
-WARNING(simple_bus_bridge, check_simple_bus_bridge, NULL, &addr_size_cells);
+WARNING(simple_bus_bridge, check_simple_bus_bridge, NULL,
+	&addr_size_cells, &compatible_is_string_list);
 
 static void check_simple_bus_reg(struct check *c, struct dt_info *dti, struct node *node)
 {
@@ -962,6 +1012,160 @@ static void check_simple_bus_reg(struct check *c, struct dt_info *dti, struct no
 }
 WARNING(simple_bus_reg, check_simple_bus_reg, NULL, &reg_format, &simple_bus_bridge);
 
+static const struct bus_type i2c_bus = {
+	.name = "i2c-bus",
+};
+
+static void check_i2c_bus_bridge(struct check *c, struct dt_info *dti, struct node *node)
+{
+	if (strprefixeq(node->name, node->basenamelen, "i2c-bus") ||
+	    strprefixeq(node->name, node->basenamelen, "i2c-arb")) {
+		node->bus = &i2c_bus;
+	} else if (strprefixeq(node->name, node->basenamelen, "i2c")) {
+		struct node *child;
+		for_each_child(node, child) {
+			if (strprefixeq(child->name, child->basenamelen, "i2c-bus"))
+				return;
+		}
+		node->bus = &i2c_bus;
+	} else
+		return;
+
+	if (!node->children)
+		return;
+
+	if (node_addr_cells(node) != 1)
+		FAIL(c, dti, node, "incorrect #address-cells for I2C bus");
+	if (node_size_cells(node) != 0)
+		FAIL(c, dti, node, "incorrect #size-cells for I2C bus");
+
+}
+WARNING(i2c_bus_bridge, check_i2c_bus_bridge, NULL, &addr_size_cells);
+
+#define I2C_OWN_SLAVE_ADDRESS	(1U << 30)
+#define I2C_TEN_BIT_ADDRESS	(1U << 31)
+
+static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node *node)
+{
+	struct property *prop;
+	const char *unitname = get_unitname(node);
+	char unit_addr[17];
+	uint32_t reg = 0;
+	int len;
+	cell_t *cells = NULL;
+
+	if (!node->parent || (node->parent->bus != &i2c_bus))
+		return;
+
+	prop = get_property(node, "reg");
+	if (prop)
+		cells = (cell_t *)prop->val.val;
+
+	if (!cells) {
+		FAIL(c, dti, node, "missing or empty reg property");
+		return;
+	}
+
+	reg = fdt32_to_cpu(*cells);
+	/* Ignore I2C_OWN_SLAVE_ADDRESS */
+	reg &= ~I2C_OWN_SLAVE_ADDRESS;
+	snprintf(unit_addr, sizeof(unit_addr), "%x", reg);
+	if (!streq(unitname, unit_addr))
+		FAIL(c, dti, node, "I2C bus unit address format error, expected \"%s\"",
+		     unit_addr);
+
+	for (len = prop->val.len; len > 0; len -= 4) {
+		reg = fdt32_to_cpu(*(cells++));
+		/* Ignore I2C_OWN_SLAVE_ADDRESS */
+		reg &= ~I2C_OWN_SLAVE_ADDRESS;
+
+		if (reg & I2C_TEN_BIT_ADDRESS) {
+			if ((reg & ~I2C_TEN_BIT_ADDRESS) > 0x3ff)
+				FAIL_PROP(c, dti, node, prop, "I2C address must be less than 10-bits, got \"0x%x\"",
+				  reg);
+		} else if (reg > 0x7f)
+			FAIL_PROP(c, dti, node, prop, "I2C address must be less than 7-bits, got \"0x%x\". Set I2C_TEN_BIT_ADDRESS for 10 bit addresses or fix the property",
+				  reg);
+	}
+}
+WARNING(i2c_bus_reg, check_i2c_bus_reg, NULL, &reg_format, &i2c_bus_bridge);
+
+static const struct bus_type spi_bus = {
+	.name = "spi-bus",
+};
+
+static void check_spi_bus_bridge(struct check *c, struct dt_info *dti, struct node *node)
+{
+	int spi_addr_cells = 1;
+
+	if (strprefixeq(node->name, node->basenamelen, "spi")) {
+		node->bus = &spi_bus;
+	} else {
+		/* Try to detect SPI buses which don't have proper node name */
+		struct node *child;
+
+		if (node_addr_cells(node) != 1 || node_size_cells(node) != 0)
+			return;
+
+		for_each_child(node, child) {
+			struct property *prop;
+			for_each_property(child, prop) {
+				if (strstarts(prop->name, "spi-")) {
+					node->bus = &spi_bus;
+					break;
+				}
+			}
+			if (node->bus == &spi_bus)
+				break;
+		}
+
+		if (node->bus == &spi_bus && get_property(node, "reg"))
+			FAIL(c, dti, node, "node name for SPI buses should be 'spi'");
+	}
+	if (node->bus != &spi_bus || !node->children)
+		return;
+
+	if (get_property(node, "spi-slave"))
+		spi_addr_cells = 0;
+	if (node_addr_cells(node) != spi_addr_cells)
+		FAIL(c, dti, node, "incorrect #address-cells for SPI bus");
+	if (node_size_cells(node) != 0)
+		FAIL(c, dti, node, "incorrect #size-cells for SPI bus");
+
+}
+WARNING(spi_bus_bridge, check_spi_bus_bridge, NULL, &addr_size_cells);
+
+static void check_spi_bus_reg(struct check *c, struct dt_info *dti, struct node *node)
+{
+	struct property *prop;
+	const char *unitname = get_unitname(node);
+	char unit_addr[9];
+	uint32_t reg = 0;
+	cell_t *cells = NULL;
+
+	if (!node->parent || (node->parent->bus != &spi_bus))
+		return;
+
+	if (get_property(node->parent, "spi-slave"))
+		return;
+
+	prop = get_property(node, "reg");
+	if (prop)
+		cells = (cell_t *)prop->val.val;
+
+	if (!cells) {
+		FAIL(c, dti, node, "missing or empty reg property");
+		return;
+	}
+
+	reg = fdt32_to_cpu(*cells);
+	snprintf(unit_addr, sizeof(unit_addr), "%x", reg);
+	if (!streq(unitname, unit_addr))
+		FAIL(c, dti, node, "SPI bus unit address format error, expected \"%s\"",
+		     unit_addr);
+}
+WARNING(spi_bus_reg, check_spi_bus_reg, NULL, &reg_format, &spi_bus_bridge);
+
 static void check_unit_address_format(struct check *c, struct dt_info *dti,
 				      struct node *node)
 {
@@ -978,7 +1182,7 @@ static void check_unit_address_format(struct check *c, struct dt_info *dti,
 		/* skip over 0x for next test */
 		unitname += 2;
 	}
-	if (unitname[0] == '0' && isxdigit(unitname[1]))
+	if (unitname[0] == '0' && isxdigit((unsigned char)unitname[1]))
 		FAIL(c, dti, node, "unit name should not have leading 0s");
 }
 WARNING(unit_address_format, check_unit_address_format, NULL,
@@ -1013,29 +1217,48 @@ WARNING(avoid_default_addr_size, check_avoid_default_addr_size, NULL,
 static void check_avoid_unnecessary_addr_size(struct check *c, struct dt_info *dti,
 					      struct node *node)
 {
-	struct property *prop;
 	struct node *child;
-	bool has_reg = false;
 
 	if (!node->parent || node->addr_cells < 0 || node->size_cells < 0)
 		return;
 
-	if (get_property(node, "ranges") || !node->children)
+	if (get_property(node, "ranges") || get_property(node, "dma-ranges") || !node->children)
 		return;
 
 	for_each_child(node, child) {
-		prop = get_property(child, "reg");
-		if (prop)
-			has_reg = true;
+		/*
+		 * Even if the child devices' address space is not mapped into
+		 * the parent bus (no 'ranges' property on node), children can
+		 * still have registers on a local bus, or map local addresses
+		 * to another subordinate address space. The properties on the
+		 * child nodes then make #address-cells/#size-cells necessary:
+		 */
+		if (get_property(child, "reg") || get_property(child, "ranges"))
+			return;
 	}
 
-	if (!has_reg)
-		FAIL(c, dti, node, "unnecessary #address-cells/#size-cells without \"ranges\" or child \"reg\" property");
+	FAIL(c, dti, node, "unnecessary #address-cells/#size-cells without \"ranges\", \"dma-ranges\" or child \"reg\" or \"ranges\" property");
 }
 WARNING(avoid_unnecessary_addr_size, check_avoid_unnecessary_addr_size, NULL, &avoid_default_addr_size);
 
-static void check_unique_unit_address(struct check *c, struct dt_info *dti,
-					      struct node *node)
+static bool node_is_disabled(struct node *node)
+{
+	struct property *prop;
+
+	prop = get_property(node, "status");
+	if (prop) {
+		char *str = prop->val.val;
+		if (streq("disabled", str))
+			return true;
+	}
+
+	return false;
+}
+
+static void check_unique_unit_address_common(struct check *c,
+						struct dt_info *dti,
+						struct node *node,
+						bool disable_check)
 {
 	struct node *childa;
 
@@ -1052,18 +1275,38 @@ static void check_unique_unit_address(struct check *c, struct dt_info *dti,
 		if (!strlen(addr_a))
 			continue;
 
+		if (disable_check && node_is_disabled(childa))
+			continue;
+
 		for_each_child(node, childb) {
 			const char *addr_b = get_unitname(childb);
 			if (childa == childb)
 				break;
 
+			if (disable_check && node_is_disabled(childb))
+				continue;
+
 			if (streq(addr_a, addr_b))
 				FAIL(c, dti, childb, "duplicate unit-address (also used in node %s)", childa->fullpath);
 		}
 	}
 }
+
+static void check_unique_unit_address(struct check *c, struct dt_info *dti,
+					      struct node *node)
+{
+	check_unique_unit_address_common(c, dti, node, false);
+}
 WARNING(unique_unit_address, check_unique_unit_address, NULL, &avoid_default_addr_size);
 
+static void check_unique_unit_address_if_enabled(struct check *c, struct dt_info *dti,
+					      struct node *node)
+{
+	check_unique_unit_address_common(c, dti, node, true);
+}
+CHECK_ENTRY(unique_unit_address_if_enabled, check_unique_unit_address_if_enabled,
+	    NULL, false, false, &avoid_default_addr_size);
+
 static void check_obsolete_chosen_interrupt_controller(struct check *c,
 						       struct dt_info *dti,
 						       struct node *node)
@@ -1143,15 +1386,15 @@ struct provider {
 };
 
 static void check_property_phandle_args(struct check *c,
-					  struct dt_info *dti,
-				          struct node *node,
-				          struct property *prop,
-				          const struct provider *provider)
+					struct dt_info *dti,
+					struct node *node,
+					struct property *prop,
+					const struct provider *provider)
 {
 	struct node *root = dti->dt;
-	int cell, cellsize = 0;
+	unsigned int cell, cellsize = 0;
 
-	if (prop->val.len % sizeof(cell_t)) {
+	if (!is_multiple_of(prop->val.len, sizeof(cell_t))) {
 		FAIL_PROP(c, dti, node, prop,
 			  "property size (%d) is invalid, expected multiple of %zu",
 			  prop->val.len, sizeof(cell_t));
@@ -1161,14 +1404,15 @@ static void check_property_phandle_args(struct check *c,
 	for (cell = 0; cell < prop->val.len / sizeof(cell_t); cell += cellsize + 1) {
 		struct node *provider_node;
 		struct property *cellprop;
-		int phandle;
+		cell_t phandle;
+		unsigned int expected;
 
 		phandle = propval_cell_n(prop, cell);
 		/*
 		 * Some bindings use a cell value 0 or -1 to skip over optional
 		 * entries when each index position has a specific definition.
 		 */
-		if (phandle == 0 || phandle == -1) {
+		if (!phandle_is_valid(phandle)) {
 			/* Give up if this is an overlay with external references */
 			if (dti->dtsflags & DTSF_PLUGIN)
 				break;
@@ -1211,10 +1455,12 @@ static void check_property_phandle_args(struct check *c,
 			break;
 		}
 
-		if (prop->val.len < ((cell + cellsize + 1) * sizeof(cell_t))) {
+		expected = (cell + cellsize + 1) * sizeof(cell_t);
+		if ((expected <= cell) || prop->val.len < expected) {
 			FAIL_PROP(c, dti, node, prop,
-				  "property size (%d) too small for cell size %d",
+				  "property size (%d) too small for cell size %u",
 				  prop->val.len, cellsize);
+			break;
 		}
 	}
 }
@@ -1223,7 +1469,7 @@ static void check_provider_cells_property(struct check *c,
 					  struct dt_info *dti,
 				          struct node *node)
 {
-	struct provider *provider = c->data;
+	const struct provider *provider = c->data;
 	struct property *prop;
 
 	prop = get_property(node, provider->prop_name);
@@ -1234,7 +1480,8 @@ static void check_provider_cells_property(struct check *c,
 }
 #define WARNING_PROPERTY_PHANDLE_CELLS(nm, propname, cells_name, ...) \
 	static struct provider nm##_provider = { (propname), (cells_name), __VA_ARGS__ }; \
-	WARNING(nm##_property, check_provider_cells_property, &nm##_provider, &phandle_references);
+	WARNING_IF_NOT_CELL(nm##_is_cell, cells_name); \
+	WARNING(nm##_property, check_provider_cells_property, &nm##_provider, &nm##_is_cell, &phandle_references);
 
 WARNING_PROPERTY_PHANDLE_CELLS(clocks, "clocks", "#clock-cells");
 WARNING_PROPERTY_PHANDLE_CELLS(cooling_device, "cooling-device", "#cooling-cells");
@@ -1255,24 +1502,17 @@ WARNING_PROPERTY_PHANDLE_CELLS(thermal_sensors, "thermal-sensors", "#thermal-sen
 
 static bool prop_is_gpio(struct property *prop)
 {
-	char *str;
-
 	/*
 	 * *-gpios and *-gpio can appear in property names,
 	 * so skip over any false matches (only one known ATM)
 	 */
-	if (strstr(prop->name, "nr-gpio"))
+	if (strends(prop->name, ",nr-gpios"))
 		return false;
 
-	str = strrchr(prop->name, '-');
-	if (str)
-		str++;
-	else
-		str = prop->name;
-	if (!(streq(str, "gpios") || streq(str, "gpio")))
-		return false;
-
-	return true;
+	return strends(prop->name, "-gpios") ||
+		streq(prop->name, "gpios") ||
+		strends(prop->name, "-gpio") ||
+		streq(prop->name, "gpio");
 }
 
 static void check_gpios_property(struct check *c,
@@ -1307,13 +1547,10 @@ static void check_deprecated_gpio_property(struct check *c,
 	struct property *prop;
 
 	for_each_property(node, prop) {
-		char *str;
-
 		if (!prop_is_gpio(prop))
 			continue;
 
-		str = strstr(prop->name, "gpio");
-		if (!streq(str, "gpio"))
+		if (!strends(prop->name, "gpio"))
 			continue;
 
 		FAIL_PROP(c, dti, node, prop,
@@ -1337,6 +1574,121 @@ static bool node_is_interrupt_provider(struct node *node)
 
 	return false;
 }
+
+static void check_interrupt_provider(struct check *c,
+				     struct dt_info *dti,
+				     struct node *node)
+{
+	struct property *prop;
+	bool irq_provider = node_is_interrupt_provider(node);
+
+	prop = get_property(node, "#interrupt-cells");
+	if (irq_provider && !prop) {
+		FAIL(c, dti, node,
+		     "Missing '#interrupt-cells' in interrupt provider");
+		return;
+	}
+
+	if (!irq_provider && prop) {
+		FAIL(c, dti, node,
+		     "'#interrupt-cells' found, but node is not an interrupt provider");
+		return;
+	}
+}
+WARNING(interrupt_provider, check_interrupt_provider, NULL, &interrupts_extended_is_cell);
+
+static void check_interrupt_map(struct check *c,
+				struct dt_info *dti,
+				struct node *node)
+{
+	struct node *root = dti->dt;
+	struct property *prop, *irq_map_prop;
+	size_t cellsize, cell, map_cells;
+
+	irq_map_prop = get_property(node, "interrupt-map");
+	if (!irq_map_prop)
+		return;
+
+	if (node->addr_cells < 0) {
+		FAIL(c, dti, node,
+		     "Missing '#address-cells' in interrupt-map provider");
+		return;
+	}
+	cellsize = node_addr_cells(node);
+	cellsize += propval_cell(get_property(node, "#interrupt-cells"));
+
+	prop = get_property(node, "interrupt-map-mask");
+	if (prop && (prop->val.len != (cellsize * sizeof(cell_t))))
+		FAIL_PROP(c, dti, node, prop,
+			  "property size (%d) is invalid, expected %zu",
+			  prop->val.len, cellsize * sizeof(cell_t));
+
+	if (!is_multiple_of(irq_map_prop->val.len, sizeof(cell_t))) {
+		FAIL_PROP(c, dti, node, irq_map_prop,
+			  "property size (%d) is invalid, expected multiple of %zu",
+			  irq_map_prop->val.len, sizeof(cell_t));
+		return;
+	}
+
+	map_cells = irq_map_prop->val.len / sizeof(cell_t);
+	for (cell = 0; cell < map_cells; ) {
+		struct node *provider_node;
+		struct property *cellprop;
+		int phandle;
+		size_t parent_cellsize;
+
+		if ((cell + cellsize) >= map_cells) {
+			FAIL_PROP(c, dti, node, irq_map_prop,
+				  "property size (%d) too small, expected > %zu",
+				  irq_map_prop->val.len, (cell + cellsize) * sizeof(cell_t));
+			break;
+		}
+		cell += cellsize;
+
+		phandle = propval_cell_n(irq_map_prop, cell);
+		if (!phandle_is_valid(phandle)) {
+			/* Give up if this is an overlay with external references */
+			if (!(dti->dtsflags & DTSF_PLUGIN))
+				FAIL_PROP(c, dti, node, irq_map_prop,
+					  "Cell %zu is not a phandle(%d)",
+					  cell, phandle);
+			break;
+		}
+
+		provider_node = get_node_by_phandle(root, phandle);
+		if (!provider_node) {
+			FAIL_PROP(c, dti, node, irq_map_prop,
+				  "Could not get phandle(%d) node for (cell %zu)",
+				  phandle, cell);
+			break;
+		}
+
+		cellprop = get_property(provider_node, "#interrupt-cells");
+		if (cellprop) {
+			parent_cellsize = propval_cell(cellprop);
+		} else {
+			FAIL(c, dti, node, "Missing property '#interrupt-cells' in node %s or bad phandle (referred from interrupt-map[%zu])",
+			     provider_node->fullpath, cell);
+			break;
+		}
+
+		cellprop = get_property(provider_node, "#address-cells");
+		if (cellprop)
+			parent_cellsize += propval_cell(cellprop);
+		else
+			FAIL_PROP(c, dti, node, irq_map_prop,
+				"Missing property '#address-cells' in node %s, using 0 as fallback",
+				provider_node->fullpath);
+
+		cell += 1 + parent_cellsize;
+		if (cell > map_cells)
+			FAIL_PROP(c, dti, node, irq_map_prop,
+				"property size (%d) mismatch, expected %zu",
+				irq_map_prop->val.len, cell * sizeof(cell_t));
+	}
+}
+WARNING(interrupt_map, check_interrupt_map, NULL, &phandle_references, &addr_size_cells, &interrupt_provider);
+
 static void check_interrupts_property(struct check *c,
 				      struct dt_info *dti,
 				      struct node *node)
@@ -1344,13 +1696,13 @@ static void check_interrupts_property(struct check *c,
 	struct node *root = dti->dt;
 	struct node *irq_node = NULL, *parent = node;
 	struct property *irq_prop, *prop = NULL;
-	int irq_cells, phandle;
+	cell_t irq_cells, phandle;
 
 	irq_prop = get_property(node, "interrupts");
 	if (!irq_prop)
 		return;
 
-	if (irq_prop->val.len % sizeof(cell_t))
+	if (!is_multiple_of(irq_prop->val.len, sizeof(cell_t)))
 		FAIL_PROP(c, dti, node, irq_prop, "size (%d) is invalid, expected multiple of %zu",
 		     irq_prop->val.len, sizeof(cell_t));
 
@@ -1363,10 +1715,14 @@ static void check_interrupts_property(struct check *c,
 		prop = get_property(parent, "interrupt-parent");
 		if (prop) {
 			phandle = propval_cell(prop);
-			/* Give up if this is an overlay with external references */
-			if ((phandle == 0 || phandle == -1) &&
-			    (dti->dtsflags & DTSF_PLUGIN))
+			if (!phandle_is_valid(phandle)) {
+				/* Give up if this is an overlay with
+				 * external references */
+				if (dti->dtsflags & DTSF_PLUGIN)
 					return;
+				FAIL_PROP(c, dti, parent, prop, "Invalid phandle");
+				continue;
+			}
 
 			irq_node = get_node_by_phandle(root, phandle);
 			if (!irq_node) {
@@ -1390,12 +1746,12 @@ static void check_interrupts_property(struct check *c,
 
 	prop = get_property(irq_node, "#interrupt-cells");
 	if (!prop) {
-		FAIL(c, dti, irq_node, "Missing #interrupt-cells in interrupt-parent");
+		/* We warn about that already in another test. */
 		return;
 	}
 
 	irq_cells = propval_cell(prop);
-	if (irq_prop->val.len % (irq_cells * sizeof(cell_t))) {
+	if (!is_multiple_of(irq_prop->val.len, irq_cells * sizeof(cell_t))) {
 		FAIL_PROP(c, dti, node, prop,
 			  "size is (%d), expected multiple of %d",
 			  irq_prop->val.len, (int)(irq_cells * sizeof(cell_t)));
@@ -1421,6 +1777,11 @@ static void check_graph_nodes(struct check *c, struct dt_info *dti,
 		      get_property(child, "remote-endpoint")))
 			continue;
 
+                /* The root node cannot be a port */
+		if (!node->parent) {
+			FAIL(c, dti, node, "root node contains endpoint node '%s', potentially misplaced remote-endpoint property", child->name);
+			continue;
+		}
 		node->bus = &graph_port_bus;
 
 		/* The parent of 'port' nodes can be either 'ports' or a device */
@@ -1434,31 +1795,6 @@ static void check_graph_nodes(struct check *c, struct dt_info *dti,
 }
 WARNING(graph_nodes, check_graph_nodes, NULL);
 
-static void check_graph_child_address(struct check *c, struct dt_info *dti,
-				      struct node *node)
-{
-	int cnt = 0;
-	struct node *child;
-
-	if (node->bus != &graph_ports_bus && node->bus != &graph_port_bus)
-		return;
-
-	for_each_child(node, child) {
-		struct property *prop = get_property(child, "reg");
-
-		/* No error if we have any non-zero unit address */
-		if (prop && propval_cell(prop) != 0)
-			return;
-
-		cnt++;
-	}
-
-	if (cnt == 1 && node->addr_cells != -1)
-		FAIL(c, dti, node, "graph node has single child node '%s', #address-cells/#size-cells are not necessary",
-		     node->children->name);
-}
-WARNING(graph_child_address, check_graph_child_address, NULL, &graph_nodes);
-
 static void check_graph_reg(struct check *c, struct dt_info *dti,
 			    struct node *node)
 {
@@ -1496,17 +1832,21 @@ static void check_graph_port(struct check *c, struct dt_info *dti,
 	if (node->bus != &graph_port_bus)
 		return;
 
+	check_graph_reg(c, dti, node);
+
+	/* skip checks below for overlays */
+	if (dti->dtsflags & DTSF_PLUGIN)
+		return;
+
 	if (!strprefixeq(node->name, node->basenamelen, "port"))
 		FAIL(c, dti, node, "graph port node name should be 'port'");
-
-	check_graph_reg(c, dti, node);
 }
 WARNING(graph_port, check_graph_port, NULL, &graph_nodes);
 
 static struct node *get_remote_endpoint(struct check *c, struct dt_info *dti,
 					struct node *endpoint)
 {
-	int phandle;
+	cell_t phandle;
 	struct node *node;
 	struct property *prop;
 
@@ -1516,7 +1856,7 @@ static struct node *get_remote_endpoint(struct check *c, struct dt_info *dti,
 
 	phandle = propval_cell(prop);
 	/* Give up if this is an overlay with external references */
-	if (phandle == 0 || phandle == -1)
+	if (!phandle_is_valid(phandle))
 		return NULL;
 
 	node = get_node_by_phandle(dti->dt, phandle);
@@ -1534,11 +1874,15 @@ static void check_graph_endpoint(struct check *c, struct dt_info *dti,
 	if (!node->parent || node->parent->bus != &graph_port_bus)
 		return;
 
-	if (!strprefixeq(node->name, node->basenamelen, "endpoint"))
-		FAIL(c, dti, node, "graph endpont node name should be 'endpoint'");
-
 	check_graph_reg(c, dti, node);
 
+	/* skip checks below for overlays */
+	if (dti->dtsflags & DTSF_PLUGIN)
+		return;
+
+	if (!strprefixeq(node->name, node->basenamelen, "endpoint"))
+		FAIL(c, dti, node, "graph endpoint node name should be 'endpoint'");
+
 	remote_node = get_remote_endpoint(c, dti, node);
 	if (!remote_node)
 		return;
@@ -1549,10 +1893,35 @@ static void check_graph_endpoint(struct check *c, struct dt_info *dti,
 }
 WARNING(graph_endpoint, check_graph_endpoint, NULL, &graph_nodes);
 
+static void check_graph_child_address(struct check *c, struct dt_info *dti,
+				      struct node *node)
+{
+	int cnt = 0;
+	struct node *child;
+
+	if (node->bus != &graph_ports_bus && node->bus != &graph_port_bus)
+		return;
+
+	for_each_child(node, child) {
+		struct property *prop = get_property(child, "reg");
+
+		/* No error if we have any non-zero unit address */
+                if (prop && propval_cell(prop) != 0 )
+			return;
+
+		cnt++;
+	}
+
+	if (cnt == 1 && node->addr_cells != -1)
+		FAIL(c, dti, node, "graph node has single child node '%s', #address-cells/#size-cells are not necessary",
+		     node->children->name);
+}
+WARNING(graph_child_address, check_graph_child_address, NULL, &graph_nodes, &graph_port, &graph_endpoint);
+
 static struct check *check_table[] = {
 	&duplicate_node_names, &duplicate_property_names,
 	&node_name_chars, &node_name_format, &property_name_chars,
-	&name_is_string, &name_properties,
+	&name_is_string, &name_properties, &node_name_vs_property_name,
 
 	&duplicate_label,
 
@@ -1560,7 +1929,7 @@ static struct check *check_table[] = {
 	&phandle_references, &path_references,
 	&omit_unused_nodes,
 
-	&address_cells_is_cell, &size_cells_is_cell, &interrupt_cells_is_cell,
+	&address_cells_is_cell, &size_cells_is_cell,
 	&device_type_is_string, &model_is_string, &status_is_string,
 	&label_is_string,
 
@@ -1569,7 +1938,7 @@ static struct check *check_table[] = {
 	&property_name_chars_strict,
 	&node_name_chars_strict,
 
-	&addr_size_cells, &reg_format, &ranges_format,
+	&addr_size_cells, &reg_format, &ranges_format, &dma_ranges_format,
 
 	&unit_address_vs_reg,
 	&unit_address_format,
@@ -1581,32 +1950,57 @@ static struct check *check_table[] = {
 	&simple_bus_bridge,
 	&simple_bus_reg,
 
+	&i2c_bus_bridge,
+	&i2c_bus_reg,
+
+	&spi_bus_bridge,
+	&spi_bus_reg,
+
 	&avoid_default_addr_size,
 	&avoid_unnecessary_addr_size,
 	&unique_unit_address,
+	&unique_unit_address_if_enabled,
 	&obsolete_chosen_interrupt_controller,
 	&chosen_node_is_root, &chosen_node_bootargs, &chosen_node_stdout_path,
 
 	&clocks_property,
+	&clocks_is_cell,
 	&cooling_device_property,
+	&cooling_device_is_cell,
 	&dmas_property,
+	&dmas_is_cell,
 	&hwlocks_property,
+	&hwlocks_is_cell,
 	&interrupts_extended_property,
+	&interrupts_extended_is_cell,
 	&io_channels_property,
+	&io_channels_is_cell,
 	&iommus_property,
+	&iommus_is_cell,
 	&mboxes_property,
+	&mboxes_is_cell,
 	&msi_parent_property,
+	&msi_parent_is_cell,
 	&mux_controls_property,
+	&mux_controls_is_cell,
 	&phys_property,
+	&phys_is_cell,
 	&power_domains_property,
+	&power_domains_is_cell,
 	&pwms_property,
+	&pwms_is_cell,
 	&resets_property,
+	&resets_is_cell,
 	&sound_dai_property,
+	&sound_dai_is_cell,
 	&thermal_sensors_property,
+	&thermal_sensors_is_cell,
 
 	&deprecated_gpio_property,
 	&gpios_property,
 	&interrupts_property,
+	&interrupt_provider,
+	&interrupt_map,
 
 	&alias_paths,
 
@@ -1630,7 +2024,7 @@ static void enable_warning_error(struct check *c, bool warn, bool error)
 
 static void disable_warning_error(struct check *c, bool warn, bool error)
 {
-	int i;
+	unsigned int i;
 
 	/* Lowering level, also lower it for things this is the prereq
 	 * for */
@@ -1651,7 +2045,7 @@ static void disable_warning_error(struct check *c, bool warn, bool error)
 
 void parse_checks_option(bool warn, bool error, const char *arg)
 {
-	int i;
+	unsigned int i;
 	const char *name = arg;
 	bool enable = true;
 
@@ -1678,7 +2072,7 @@ void parse_checks_option(bool warn, bool error, const char *arg)
 
 void process_checks(bool force, struct dt_info *dti)
 {
-	int i;
+	unsigned int i;
 	int error = 0;
 
 	for (i = 0; i < ARRAY_SIZE(check_table); i++) {
diff --git a/scripts/dtc/data.c b/scripts/dtc/data.c
index aa37a16c889..5b25aa06041 100644
--- a/scripts/dtc/data.c
+++ b/scripts/dtc/data.c
@@ -1,21 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include "dtc.h"
@@ -36,10 +21,10 @@ void data_free(struct data d)
 		free(d.val);
 }
 
-struct data data_grow_for(struct data d, int xlen)
+struct data data_grow_for(struct data d, unsigned int xlen)
 {
 	struct data nd;
-	int newsize;
+	unsigned int newsize;
 
 	if (xlen == 0)
 		return d;
@@ -74,7 +59,8 @@ struct data data_copy_escape_string(const char *s, int len)
 	struct data d;
 	char *q;
 
-	d = data_grow_for(empty_data, len + 1);
+	d = data_add_marker(empty_data, TYPE_STRING, NULL);
+	d = data_grow_for(d, len + 1);
 
 	q = d.val;
 	while (i < len) {
@@ -94,10 +80,11 @@ struct data data_copy_file(FILE *f, size_t maxlen)
 {
 	struct data d = empty_data;
 
+	d = data_add_marker(d, TYPE_NONE, NULL);
 	while (!feof(f) && (d.len < maxlen)) {
 		size_t chunksize, ret;
 
-		if (maxlen == -1)
+		if (maxlen == (size_t)-1)
 			chunksize = 4096;
 		else
 			chunksize = maxlen - d.len;
@@ -241,11 +228,7 @@ struct data data_add_marker(struct data d, enum markertype type, char *ref)
 {
 	struct marker *m;
 
-	m = xmalloc(sizeof(*m));
-	m->offset = d.len;
-	m->type = type;
-	m->ref = ref;
-	m->next = NULL;
+	m = alloc_marker(d.len, type, ref);
 
 	return data_append_markers(d, m);
 }
@@ -267,3 +250,44 @@ bool data_is_one_string(struct data d)
 
 	return true;
 }
+
+struct data data_insert_data(struct data d, struct marker *m, struct data old)
+{
+	unsigned int offset = m->offset;
+	struct marker *next = m->next;
+	struct marker *marker;
+	struct data new_data;
+	char *ref;
+
+	new_data = data_insert_at_marker(d, m, old.val, old.len);
+
+	/* Copy all markers from old value */
+	marker = old.markers;
+	for_each_marker(marker) {
+		ref = NULL;
+
+		if (marker->ref)
+			ref = xstrdup(marker->ref);
+
+		m->next = alloc_marker(marker->offset + offset, marker->type,
+				       ref);
+		m = m->next;
+	}
+	m->next = next;
+
+	return new_data;
+}
+
+struct marker *alloc_marker(unsigned int offset, enum markertype type,
+			    char *ref)
+{
+	struct marker *m;
+
+	m = xmalloc(sizeof(*m));
+	m->offset = offset;
+	m->type = type;
+	m->ref = ref;
+	m->next = NULL;
+
+	return m;
+}
diff --git a/scripts/dtc/dtc-lexer.l b/scripts/dtc/dtc-lexer.l
index d34e1b04220..15d585c8079 100644
--- a/scripts/dtc/dtc-lexer.l
+++ b/scripts/dtc/dtc-lexer.l
@@ -1,21 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 %option noyywrap nounput noinput never-interactive
@@ -72,7 +57,7 @@ static void PRINTF(1, 2) lexical_error(const char *fmt, ...);
 			push_input_file(name);
 		}
 
-<*>^"#"(line)?[ \t]+[0-9]+[ \t]+{STRING}([ \t]+[0-9]+)? {
+<*>^"#"(line)?[ \t]+[0-9]+[ \t]+{STRING}([ \t]+[0-9]+)* {
 			char *line, *fnstart, *fnend;
 			struct data fn;
 			/* skip text before line # */
@@ -166,6 +151,21 @@ static void PRINTF(1, 2) lexical_error(const char *fmt, ...);
 			return DT_LABEL;
 		}
 
+<V1>{LABEL} 	{
+			/* Missed includes or macro definitions while
+			 * preprocessing can lead to unexpected identifiers in
+			 * the input. Report a slightly more informative error
+			 * in this case */
+
+			lexical_error("Unexpected '%s'", yytext);
+
+			/* Treat it as a literal which often generates further
+			 * useful error messages */
+
+			yylval.integer = 0;
+			return DT_LITERAL;
+		}
+
 <V1>([0-9]+|0[xX][0-9a-fA-F]+)(U|L|UL|LL|ULL)? {
 			char *e;
 			DPRINT("Integer Literal: '%s'\n", yytext);
@@ -212,14 +212,14 @@ static void PRINTF(1, 2) lexical_error(const char *fmt, ...);
 <*>\&{LABEL}	{	/* label reference */
 			DPRINT("Ref: %s\n", yytext+1);
 			yylval.labelref = xstrdup(yytext+1);
-			return DT_REF;
+			return DT_LABEL_REF;
 		}
 
 <*>"&{"{PATHCHAR}*\}	{	/* new-style path reference */
 			yytext[yyleng-1] = '\0';
 			DPRINT("Ref: %s\n", yytext+2);
 			yylval.labelref = xstrdup(yytext+2);
-			return DT_REF;
+			return DT_PATH_REF;
 		}
 
 <BYTESTRING>[0-9a-fA-F]{2} {
diff --git a/scripts/dtc/dtc-parser.y b/scripts/dtc/dtc-parser.y
index b3b9c83873d..4d5eece5262 100644
--- a/scripts/dtc/dtc-parser.y
+++ b/scripts/dtc/dtc-parser.y
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
+%locations
+
 %{
 #include <stdio.h>
 #include <inttypes.h>
@@ -32,6 +19,8 @@ extern void yyerror(char const *s);
 		treesource_error = true; \
 	} while (0)
 
+#define YYERROR_CALL(msg) yyerror(msg)
+
 extern struct dt_info *parser_output;
 extern bool treesource_error;
 
@@ -76,7 +65,8 @@ static bool is_ref_relative(const char *ref)
 %token <byte> DT_BYTE
 %token <data> DT_STRING
 %token <labelref> DT_LABEL
-%token <labelref> DT_REF
+%token <labelref> DT_LABEL_REF
+%token <labelref> DT_PATH_REF
 %token DT_INCBIN
 
 %type <data> propdata
@@ -89,6 +79,7 @@ static bool is_ref_relative(const char *ref)
 %type <data> bytestring
 %type <prop> propdef
 %type <proplist> proplist
+%type <labelref> dt_ref
 
 %type <node> devicetree
 %type <node> nodedef
@@ -164,6 +155,8 @@ memreserve:
 		}
 	;
 
+dt_ref: DT_LABEL_REF | DT_PATH_REF;
+
 devicetree:
 	  '/' nodedef
 		{
@@ -173,7 +166,7 @@ devicetree:
 		{
 			$$ = merge_nodes($1, $3);
 		}
-	| DT_REF nodedef
+	| dt_ref nodedef
 		{
 			/*
 			 * We rely on the rule being always:
@@ -184,9 +177,12 @@ devicetree:
 				ERROR(&@2, "Label or path %s not found", $1);
 			else if (is_ref_relative($1))
 				ERROR(&@2, "Label-relative reference %s not supported in plugin", $1);
-			$$ = add_orphan_node(name_node(build_node(NULL, NULL), ""), $2, $1);
+			$$ = add_orphan_node(
+					name_node(build_node(NULL, NULL, NULL),
+						  ""),
+					$2, $1);
 		}
-	| devicetree DT_LABEL DT_REF nodedef
+	| devicetree DT_LABEL dt_ref nodedef
 		{
 			struct node *target = get_node_by_ref($1, $3);
 
@@ -200,7 +196,7 @@ devicetree:
 				ERROR(&@3, "Label or path %s not found", $3);
 			$$ = $1;
 		}
-	| devicetree DT_REF nodedef
+	| devicetree DT_PATH_REF nodedef
 		{
 			/*
 			 * We rely on the rule being always:
@@ -221,7 +217,26 @@ devicetree:
 			}
 			$$ = $1;
 		}
-	| devicetree DT_DEL_NODE DT_REF ';'
+	| devicetree DT_LABEL_REF nodedef
+		{
+			struct node *target = get_node_by_ref($1, $2);
+
+			if (target) {
+				merge_nodes(target, $3);
+			} else {
+				/*
+				 * We rely on the rule being always:
+				 *   versioninfo plugindecl memreserves devicetree
+				 * so $-1 is what we want (plugindecl)
+				 */
+				if ($<flags>-1 & DTSF_PLUGIN)
+					add_orphan_node($1, $3, $2);
+				else
+					ERROR(&@2, "Label or path %s not found", $2);
+			}
+			$$ = $1;
+		}
+	| devicetree DT_DEL_NODE dt_ref ';'
 		{
 			struct node *target = get_node_by_ref($1, $3);
 
@@ -233,7 +248,7 @@ devicetree:
 
 			$$ = $1;
 		}
-	| devicetree DT_OMIT_NO_REF DT_REF ';'
+	| devicetree DT_OMIT_NO_REF dt_ref ';'
 		{
 			struct node *target = get_node_by_ref($1, $3);
 
@@ -250,7 +265,7 @@ devicetree:
 nodedef:
 	  '{' proplist subnodes '}' ';'
 		{
-			$$ = build_node($2, $3);
+			$$ = build_node($2, $3, &@$);
 		}
 	;
 
@@ -268,15 +283,18 @@ proplist:
 propdef:
 	  DT_PROPNODENAME '=' propdata ';'
 		{
-			$$ = build_property($1, $3);
+			$$ = build_property($1, $3, &@$);
+			free($1);
 		}
 	| DT_PROPNODENAME ';'
 		{
-			$$ = build_property($1, empty_data);
+			$$ = build_property($1, empty_data, &@$);
+			free($1);
 		}
 	| DT_DEL_PROP DT_PROPNODENAME ';'
 		{
 			$$ = build_property_delete($2);
+			free($2);
 		}
 	| DT_LABEL propdef
 		{
@@ -298,8 +316,9 @@ propdata:
 		{
 			$$ = data_merge($1, $3);
 		}
-	| propdataprefix DT_REF
+	| propdataprefix dt_ref
 		{
+			$1 = data_add_marker($1, TYPE_STRING, $2);
 			$$ = data_add_marker($1, REF_PATH, $2);
 		}
 	| propdataprefix DT_INCBIN '(' DT_STRING ',' integer_prim ',' integer_prim ')'
@@ -353,22 +372,27 @@ arrayprefix:
 	DT_BITS DT_LITERAL '<'
 		{
 			unsigned long long bits;
+			enum markertype type = TYPE_UINT32;
 
 			bits = $2;
 
-			if ((bits !=  8) && (bits != 16) &&
-			    (bits != 32) && (bits != 64)) {
+			switch (bits) {
+			case 8: type = TYPE_UINT8; break;
+			case 16: type = TYPE_UINT16; break;
+			case 32: type = TYPE_UINT32; break;
+			case 64: type = TYPE_UINT64; break;
+			default:
 				ERROR(&@2, "Array elements must be"
 				      " 8, 16, 32 or 64-bits");
 				bits = 32;
 			}
 
-			$$.data = empty_data;
+			$$.data = data_add_marker(empty_data, type, NULL);
 			$$.bits = bits;
 		}
 	| '<'
 		{
-			$$.data = empty_data;
+			$$.data = data_add_marker(empty_data, TYPE_UINT32, NULL);
 			$$.bits = 32;
 		}
 	| arrayprefix integer_prim
@@ -383,14 +407,19 @@ arrayprefix:
 				 * within the mask to one (i.e. | in the
 				 * mask), all bits are one.
 				 */
-				if (($2 > mask) && (($2 | mask) != -1ULL))
-					ERROR(&@2, "Value out of range for"
-					      " %d-bit array element", $1.bits);
+				if (($2 > mask) && (($2 | mask) != -1ULL)) {
+					char *loc = srcpos_string(&@2);
+					fprintf(stderr,
+						"WARNING: %s: Value 0x%016" PRIx64
+						" truncated to 0x%0*" PRIx64 "\n",
+						loc, $2, $1.bits / 4, ($2 & mask));
+					free(loc);
+				}
 			}
 
 			$$.data = data_append_integer($1.data, $2, $1.bits);
 		}
-	| arrayprefix DT_REF
+	| arrayprefix dt_ref
 		{
 			uint64_t val = ~0ULL >> (64 - $1.bits);
 
@@ -468,8 +497,8 @@ integer_rela:
 	;
 
 integer_shift:
-	  integer_shift DT_LSHIFT integer_add { $$ = $1 << $3; }
-	| integer_shift DT_RSHIFT integer_add { $$ = $1 >> $3; }
+	  integer_shift DT_LSHIFT integer_add { $$ = ($3 < 64) ? ($1 << $3) : 0; }
+	| integer_shift DT_RSHIFT integer_add { $$ = ($3 < 64) ? ($1 >> $3) : 0; }
 	| integer_add
 	;
 
@@ -512,7 +541,7 @@ integer_unary:
 bytestring:
 	  /* empty */
 		{
-			$$ = empty_data;
+			$$ = data_add_marker(empty_data, TYPE_UINT8, NULL);
 		}
 	| bytestring DT_BYTE
 		{
@@ -544,10 +573,12 @@ subnode:
 	  DT_PROPNODENAME nodedef
 		{
 			$$ = name_node($2, $1);
+			free($1);
 		}
 	| DT_DEL_NODE DT_PROPNODENAME ';'
 		{
-			$$ = name_node(build_node_delete(), $2);
+			$$ = name_node(build_node_delete(&@$), $2);
+			free($2);
 		}
 	| DT_OMIT_NO_REF subnode
 		{
diff --git a/scripts/dtc/dtc.c b/scripts/dtc/dtc.c
index c36994e6eac..b3445b7d647 100644
--- a/scripts/dtc/dtc.c
+++ b/scripts/dtc/dtc.c
@@ -1,21 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include <sys/stat.h>
@@ -27,14 +12,16 @@
  * Command line options
  */
 int quiet;		/* Level of quietness */
-int reservenum;		/* Number of memory reservation slots */
+unsigned int reservenum;/* Number of memory reservation slots */
 int minsize;		/* Minimum blob size */
 int padsize;		/* Additional padding to blob */
-int alignsize;		/* Additional padding to blob accroding to the alignsize */
+int alignsize;		/* Additional padding to blob according to the alignsize */
 int phandle_format = PHANDLE_EPAPR;	/* Use linux,phandle or phandle properties */
 int generate_symbols;	/* enable symbols & fixup support */
 int generate_fixups;		/* suppress generation of fixups on symbol support */
 int auto_label_aliases;		/* auto generate labels -> aliases */
+int annotate;		/* Level of annotation: 1 for input source location
+			   >1 for full input source location. */
 
 static int is_power_of_2(int x)
 {
@@ -60,7 +47,7 @@ static void fill_fullpaths(struct node *tree, const char *prefix)
 
 /* Usage related data. */
 static const char usage_synopsis[] = "dtc [options] <input file>";
-static const char usage_short_opts[] = "qI:O:o:V:d:R:S:p:a:fb:i:H:sW:E:@Ahv";
+static const char usage_short_opts[] = "qI:O:o:V:d:R:S:p:a:fb:i:H:sW:E:@LAThv";
 static struct option const usage_long_opts[] = {
 	{"quiet",            no_argument, NULL, 'q'},
 	{"in-format",         a_argument, NULL, 'I'},
@@ -80,7 +67,9 @@ static struct option const usage_long_opts[] = {
 	{"warning",           a_argument, NULL, 'W'},
 	{"error",             a_argument, NULL, 'E'},
 	{"symbols",	     no_argument, NULL, '@'},
+	{"local-fixups",     no_argument, NULL, 'L'},
 	{"auto-alias",       no_argument, NULL, 'A'},
+	{"annotate",         no_argument, NULL, 'T'},
 	{"help",             no_argument, NULL, 'h'},
 	{"version",          no_argument, NULL, 'v'},
 	{NULL,               no_argument, NULL, 0x0},
@@ -95,6 +84,9 @@ static const char * const usage_opts_help[] = {
 	"\n\tOutput formats are:\n"
 	 "\t\tdts - device tree source text\n"
 	 "\t\tdtb - device tree blob\n"
+#ifndef NO_YAML
+	 "\t\tyaml - device tree encoded as YAML\n"
+#endif
 	 "\t\tasm - assembler source",
 	"\n\tBlob version to produce, defaults to "stringify(DEFAULT_FDT_VERSION)" (for dtb and asm output)",
 	"\n\tOutput dependency file",
@@ -113,7 +105,9 @@ static const char * const usage_opts_help[] = {
 	"\n\tEnable/disable warnings (prefix with \"no-\")",
 	"\n\tEnable/disable errors (prefix with \"no-\")",
 	"\n\tEnable generation of symbols",
+	"\n\tPossibly generates a __local_fixups__ and a __fixups__ node at the root node",
 	"\n\tEnable auto-alias of labels",
+	"\n\tAnnotate output .dts with input source file and line (-T -T for more details)",
 	"\n\tPrint this help and exit",
 	"\n\tPrint version and exit",
 	NULL,
@@ -128,6 +122,10 @@ static const char *guess_type_by_name(const char *fname, const char *fallback)
 		return fallback;
 	if (!strcasecmp(s, ".dts"))
 		return "dts";
+	if (!strcasecmp(s, ".yaml"))
+		return "yaml";
+	if (!strcasecmp(s, ".dtbo"))
+		return "dtb";
 	if (!strcasecmp(s, ".dtb"))
 		return "dtb";
 	return fallback;
@@ -201,7 +199,7 @@ int main(int argc, char *argv[])
 			depname = optarg;
 			break;
 		case 'R':
-			reservenum = strtol(optarg, NULL, 0);
+			reservenum = strtoul(optarg, NULL, 0);
 			break;
 		case 'S':
 			minsize = strtol(optarg, NULL, 0);
@@ -256,9 +254,17 @@ int main(int argc, char *argv[])
 		case '@':
 			generate_symbols = 1;
 			break;
+
+		case 'L':
+			generate_fixups = 1;
+			break;
+
 		case 'A':
 			auto_label_aliases = 1;
 			break;
+		case 'T':
+			annotate++;
+			break;
 
 		case 'h':
 			usage(NULL);
@@ -283,7 +289,9 @@ int main(int argc, char *argv[])
 		if (!depfile)
 			die("Couldn't open dependency file %s: %s\n", depname,
 			    strerror(errno));
-		fprintf(depfile, "%s:", outname);
+
+		fprint_path_escaped(depfile, outname);
+		fputc(':', depfile);
 	}
 
 	if (inform == NULL)
@@ -297,6 +305,8 @@ int main(int argc, char *argv[])
 				outform = "dts";
 		}
 	}
+	if (annotate && (!streq(inform, "dts") || !streq(outform, "dts")))
+		die("--annotate requires -I dts -O dts\n");
 	if (streq(inform, "dts"))
 		dti = dt_from_source(arg);
 	else if (streq(inform, "fs"))
@@ -350,6 +360,12 @@ int main(int argc, char *argv[])
 
 	if (streq(outform, "dts")) {
 		dt_to_source(outf, dti);
+#ifndef NO_YAML
+	} else if (streq(outform, "yaml")) {
+		if (!streq(inform, "dts"))
+			die("YAML output format requires dts input format\n");
+		dt_to_yaml(outf, dti);
+#endif
 	} else if (streq(outform, "dtb")) {
 		dt_to_blob(outf, dti, outversion);
 	} else if (streq(outform, "asm")) {
diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
index 39c50a2c4fc..fcc97bbc70e 100644
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
@@ -1,24 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef DTC_H
 #define DTC_H
 
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include <stdio.h>
@@ -50,14 +35,15 @@
  * Command line options
  */
 extern int quiet;		/* Level of quietness */
-extern int reservenum;		/* Number of memory reservation slots */
+extern unsigned int reservenum;	/* Number of memory reservation slots */
 extern int minsize;		/* Minimum blob size */
 extern int padsize;		/* Additional padding to blob */
-extern int alignsize;		/* Additional padding to blob accroding to the alignsize */
+extern int alignsize;		/* Additional padding to blob according to the alignsize */
 extern int phandle_format;	/* Use linux,phandle or phandle properties */
 extern int generate_symbols;	/* generate symbols for nodes with labels */
 extern int generate_fixups;	/* generate fixups */
 extern int auto_label_aliases;	/* auto generate labels -> aliases */
+extern int annotate;		/* annotate .dts with input source location */
 
 #define PHANDLE_LEGACY	0x1
 #define PHANDLE_EPAPR	0x2
@@ -65,28 +51,88 @@ extern int auto_label_aliases;	/* auto generate labels -> aliases */
 
 typedef uint32_t cell_t;
 
+static inline bool phandle_is_valid(cell_t phandle)
+{
+	return phandle != 0 && phandle != ~0U;
+}
+
+static inline uint16_t dtb_ld16(const void *p)
+{
+	const uint8_t *bp = (const uint8_t *)p;
+
+	return ((uint16_t)bp[0] << 8)
+		| bp[1];
+}
+
+static inline uint32_t dtb_ld32(const void *p)
+{
+	const uint8_t *bp = (const uint8_t *)p;
+
+	return ((uint32_t)bp[0] << 24)
+		| ((uint32_t)bp[1] << 16)
+		| ((uint32_t)bp[2] << 8)
+		| bp[3];
+}
+
+static inline uint64_t dtb_ld64(const void *p)
+{
+	const uint8_t *bp = (const uint8_t *)p;
+
+	return ((uint64_t)bp[0] << 56)
+		| ((uint64_t)bp[1] << 48)
+		| ((uint64_t)bp[2] << 40)
+		| ((uint64_t)bp[3] << 32)
+		| ((uint64_t)bp[4] << 24)
+		| ((uint64_t)bp[5] << 16)
+		| ((uint64_t)bp[6] << 8)
+		| bp[7];
+}
+
 #define streq(a, b)	(strcmp((a), (b)) == 0)
 #define strstarts(s, prefix)	(strncmp((s), (prefix), strlen(prefix)) == 0)
 #define strprefixeq(a, n, b)	(strlen(b) == (n) && (memcmp(a, b, n) == 0))
+static inline bool strends(const char *str, const char *suffix)
+{
+	unsigned int len, suffix_len;
+
+	len = strlen(str);
+	suffix_len = strlen(suffix);
+	if (len < suffix_len)
+		return false;
+	return streq(str + len - suffix_len, suffix);
+}
 
 #define ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
 
 /* Data blobs */
 enum markertype {
+	TYPE_NONE,
 	REF_PHANDLE,
 	REF_PATH,
 	LABEL,
+	TYPE_UINT8,
+	TYPE_UINT16,
+	TYPE_UINT32,
+	TYPE_UINT64,
+	TYPE_STRING,
 };
 
+static inline bool is_type_marker(enum markertype type)
+{
+	return type >= TYPE_UINT8;
+}
+
+extern const char *markername(enum markertype markertype);
+
 struct  marker {
 	enum markertype type;
-	int offset;
+	unsigned int offset;
 	char *ref;
 	struct marker *next;
 };
 
 struct data {
-	int len;
+	unsigned int len;
 	char *val;
 	struct marker *markers;
 };
@@ -99,9 +145,26 @@ struct data {
 	for_each_marker(m) \
 		if ((m)->type == (t))
 
+static inline struct marker *next_type_marker(struct marker *m)
+{
+	for_each_marker(m)
+		if (is_type_marker(m->type))
+			break;
+	return m;
+}
+
+static inline size_t type_marker_length(struct marker *m)
+{
+	struct marker *next = next_type_marker(m->next);
+
+	if (next)
+		return next->offset - m->offset;
+	return 0;
+}
+
 void data_free(struct data d);
 
-struct data data_grow_for(struct data d, int xlen);
+struct data data_grow_for(struct data d, unsigned int xlen);
 
 struct data data_copy_mem(const char *mem, int len);
 struct data data_copy_escape_string(const char *s, int len);
@@ -118,7 +181,10 @@ struct data data_append_addr(struct data d, uint64_t addr);
 struct data data_append_byte(struct data d, uint8_t byte);
 struct data data_append_zeroes(struct data d, int len);
 struct data data_append_align(struct data d, int align);
+struct data data_insert_data(struct data d, struct marker *m, struct data old);
 
+struct marker *alloc_marker(unsigned int offset, enum markertype type,
+			    char *ref);
 struct data data_add_marker(struct data d, enum markertype type, char *ref);
 
 bool data_is_one_string(struct data d);
@@ -147,6 +213,7 @@ struct property {
 	struct property *next;
 
 	struct label *labels;
+	struct srcpos *srcpos;
 };
 
 struct node {
@@ -166,6 +233,7 @@ struct node {
 
 	struct label *labels;
 	const struct bus_type *bus;
+	struct srcpos *srcpos;
 
 	bool omit_if_unused, is_referenced;
 };
@@ -194,14 +262,16 @@ struct node {
 void add_label(struct label **labels, char *label);
 void delete_labels(struct label **labels);
 
-struct property *build_property(char *name, struct data val);
-struct property *build_property_delete(char *name);
+struct property *build_property(const char *name, struct data val,
+				struct srcpos *srcpos);
+struct property *build_property_delete(const char *name);
 struct property *chain_property(struct property *first, struct property *list);
 struct property *reverse_properties(struct property *first);
 
-struct node *build_node(struct property *proplist, struct node *children);
-struct node *build_node_delete(void);
-struct node *name_node(struct node *node, char *name);
+struct node *build_node(struct property *proplist, struct node *children,
+			struct srcpos *srcpos);
+struct node *build_node_delete(struct srcpos *srcpos);
+struct node *name_node(struct node *node, const char *name);
 struct node *omit_node_if_unused(struct node *node);
 struct node *reference_node(struct node *node);
 struct node *chain_node(struct node *first, struct node *list);
@@ -215,12 +285,13 @@ void add_child(struct node *parent, struct node *child);
 void delete_node_by_name(struct node *parent, char *name);
 void delete_node(struct node *node);
 void append_to_property(struct node *node,
-			char *name, const void *data, int len);
+			char *name, const void *data, int len,
+			enum markertype type);
 
 const char *get_unitname(struct node *node);
 struct property *get_property(struct node *node, const char *propname);
 cell_t propval_cell(struct property *prop);
-cell_t propval_cell_n(struct property *prop, int n);
+cell_t propval_cell_n(struct property *prop, unsigned int n);
 struct property *get_property_by_label(struct node *tree, const char *label,
 				       struct node **node);
 struct marker *get_marker_label(struct node *tree, const char *label,
@@ -266,9 +337,9 @@ struct dt_info *build_dt_info(unsigned int dtsflags,
 			      struct reserve_info *reservelist,
 			      struct node *tree, uint32_t boot_cpuid_phys);
 void sort_tree(struct dt_info *dti);
-void generate_label_tree(struct dt_info *dti, char *name, bool allocph);
-void generate_fixups_tree(struct dt_info *dti, char *name);
-void generate_local_fixups_tree(struct dt_info *dti, char *name);
+void generate_label_tree(struct dt_info *dti, const char *name, bool allocph);
+void generate_fixups_tree(struct dt_info *dti, const char *name);
+void generate_local_fixups_tree(struct dt_info *dti, const char *name);
 
 /* Checks */
 
@@ -287,6 +358,10 @@ struct dt_info *dt_from_blob(const char *fname);
 void dt_to_source(FILE *f, struct dt_info *dti);
 struct dt_info *dt_from_source(const char *f);
 
+/* YAML source */
+
+void dt_to_yaml(FILE *f, struct dt_info *dti);
+
 /* FS trees */
 
 struct dt_info *dt_from_fs(const char *dirname);
diff --git a/scripts/dtc/fdtoverlay.c b/scripts/dtc/fdtoverlay.c
new file mode 100644
index 00000000000..ee1eb8f3ad2
--- /dev/null
+++ b/scripts/dtc/fdtoverlay.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2017 Konsulko Group Inc. All rights reserved.
+ *
+ * Author:
+ *	 Pantelis Antoniou <pantelis.antoniou@konsulko.com>
+ */
+
+#include <assert.h>
+#include <ctype.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <inttypes.h>
+
+#include <libfdt.h>
+
+#include "util.h"
+
+#define BUF_INCREMENT	65536
+
+/* Usage related data. */
+static const char usage_synopsis[] =
+	"apply a number of overlays to a base blob\n"
+	"	fdtoverlay <options> [<overlay.dtbo> [<overlay.dtbo>]]";
+static const char usage_short_opts[] = "i:o:v" USAGE_COMMON_SHORT_OPTS;
+static struct option const usage_long_opts[] = {
+	{"input",            required_argument, NULL, 'i'},
+	{"output",	     required_argument, NULL, 'o'},
+	{"verbose",	           no_argument, NULL, 'v'},
+	USAGE_COMMON_LONG_OPTS,
+};
+static const char * const usage_opts_help[] = {
+	"Input base DT blob",
+	"Output DT blob",
+	"Verbose messages",
+	USAGE_COMMON_OPTS_HELP
+};
+
+int verbose = 0;
+
+static void *apply_one(char *base, const char *overlay, size_t *buf_len,
+		       const char *name)
+{
+	char *tmp = NULL;
+	char *tmpo;
+	int ret;
+	bool has_symbols;
+
+	/*
+	 * We take copies first, because a failed apply can trash
+	 * both the base blob and the overlay
+	 */
+	tmpo = xmalloc(fdt_totalsize(overlay));
+
+	do {
+		tmp = xrealloc(tmp, *buf_len);
+		ret = fdt_open_into(base, tmp, *buf_len);
+		if (ret) {
+			fprintf(stderr,
+				"\nFailed to make temporary copy: %s\n",
+				fdt_strerror(ret));
+			goto fail;
+		}
+		ret = fdt_path_offset(tmp, "/__symbols__");
+		has_symbols = ret >= 0;
+
+		memcpy(tmpo, overlay, fdt_totalsize(overlay));
+
+		ret = fdt_overlay_apply(tmp, tmpo);
+		if (ret == -FDT_ERR_NOSPACE) {
+			*buf_len += BUF_INCREMENT;
+		}
+	} while (ret == -FDT_ERR_NOSPACE);
+
+	if (ret) {
+		fprintf(stderr, "\nFailed to apply '%s': %s\n",
+			name, fdt_strerror(ret));
+		if (!has_symbols) {
+			fprintf(stderr,
+				"base blob does not have a '/__symbols__' node, "
+				"make sure you have compiled the base blob with '-@' option\n");
+		}
+		goto fail;
+	}
+
+	free(base);
+	free(tmpo);
+	return tmp;
+
+fail:
+	free(tmpo);
+	if (tmp)
+		free(tmp);
+
+	return NULL;
+}
+static int do_fdtoverlay(const char *input_filename,
+			 const char *output_filename,
+			 int argc, char *argv[])
+{
+	char *blob = NULL;
+	char **ovblob = NULL;
+	size_t buf_len;
+	int i, ret = -1;
+
+	blob = utilfdt_read(input_filename, &buf_len);
+	if (!blob) {
+		fprintf(stderr, "\nFailed to read '%s'\n", input_filename);
+		goto out_err;
+	}
+	if (fdt_totalsize(blob) > buf_len) {
+		fprintf(stderr,
+ "\nBase blob is incomplete (%lu / %" PRIu32 " bytes read)\n",
+			(unsigned long)buf_len, fdt_totalsize(blob));
+		goto out_err;
+	}
+
+	/* allocate blob pointer array */
+	ovblob = xmalloc(sizeof(*ovblob) * argc);
+	memset(ovblob, 0, sizeof(*ovblob) * argc);
+
+	/* read and keep track of the overlay blobs */
+	for (i = 0; i < argc; i++) {
+		size_t ov_len;
+		ovblob[i] = utilfdt_read(argv[i], &ov_len);
+		if (!ovblob[i]) {
+			fprintf(stderr, "\nFailed to read '%s'\n", argv[i]);
+			goto out_err;
+		}
+		if (fdt_totalsize(ovblob[i]) > ov_len) {
+			fprintf(stderr,
+"\nOverlay '%s' is incomplete (%lu / %" PRIu32 " bytes read)\n",
+				argv[i], (unsigned long)ov_len,
+				fdt_totalsize(ovblob[i]));
+			goto out_err;
+		}
+	}
+
+	buf_len = fdt_totalsize(blob);
+
+	/* apply the overlays in sequence */
+	for (i = 0; i < argc; i++) {
+		blob = apply_one(blob, ovblob[i], &buf_len, argv[i]);
+		if (!blob)
+			goto out_err;
+	}
+
+	fdt_pack(blob);
+	ret = utilfdt_write(output_filename, blob);
+	if (ret)
+		fprintf(stderr, "\nFailed to write '%s'\n",
+			output_filename);
+
+out_err:
+	if (ovblob) {
+		for (i = 0; i < argc; i++) {
+			if (ovblob[i])
+				free(ovblob[i]);
+		}
+		free(ovblob);
+	}
+	free(blob);
+
+	return ret;
+}
+
+int main(int argc, char *argv[])
+{
+	int opt, i;
+	char *input_filename = NULL;
+	char *output_filename = NULL;
+
+	while ((opt = util_getopt_long()) != EOF) {
+		switch (opt) {
+		case_USAGE_COMMON_FLAGS
+
+		case 'i':
+			input_filename = optarg;
+			break;
+		case 'o':
+			output_filename = optarg;
+			break;
+		case 'v':
+			verbose = 1;
+			break;
+		}
+	}
+
+	if (!input_filename)
+		usage("missing input file");
+
+	if (!output_filename)
+		usage("missing output file");
+
+	argv += optind;
+	argc -= optind;
+
+	if (argc <= 0)
+		usage("missing overlay file(s)");
+
+	if (verbose) {
+		printf("input  = %s\n", input_filename);
+		printf("output = %s\n", output_filename);
+		for (i = 0; i < argc; i++)
+			printf("overlay[%d] = %s\n", i, argv[i]);
+	}
+
+	if (do_fdtoverlay(input_filename, output_filename, argc, argv))
+		return 1;
+
+	return 0;
+}
diff --git a/scripts/dtc/flattree.c b/scripts/dtc/flattree.c
index 086c5abf10f..ae3f9dec82f 100644
--- a/scripts/dtc/flattree.c
+++ b/scripts/dtc/flattree.c
@@ -1,21 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include "dtc.h"
@@ -139,7 +124,8 @@ static void asm_emit_cell(void *e, cell_t val)
 {
 	FILE *f = e;
 
-	fprintf(f, "\t.byte 0x%02x; .byte 0x%02x; .byte 0x%02x; .byte 0x%02x\n",
+	fprintf(f, "\t.byte\t0x%02x\n" "\t.byte\t0x%02x\n"
+		"\t.byte\t0x%02x\n" "\t.byte\t0x%02x\n",
 		(val >> 24) & 0xff, (val >> 16) & 0xff,
 		(val >> 8) & 0xff, val & 0xff);
 }
@@ -149,9 +135,9 @@ static void asm_emit_string(void *e, const char *str, int len)
 	FILE *f = e;
 
 	if (len != 0)
-		fprintf(f, "\t.string\t\"%.*s\"\n", len, str);
+		fprintf(f, "\t.asciz\t\"%.*s\"\n", len, str);
 	else
-		fprintf(f, "\t.string\t\"%s\"\n", str);
+		fprintf(f, "\t.asciz\t\"%s\"\n", str);
 }
 
 static void asm_emit_align(void *e, int a)
@@ -164,14 +150,14 @@ static void asm_emit_align(void *e, int a)
 static void asm_emit_data(void *e, struct data d)
 {
 	FILE *f = e;
-	int off = 0;
+	unsigned int off = 0;
 	struct marker *m = d.markers;
 
 	for_each_marker_of_type(m, LABEL)
 		emit_offset_label(f, m->ref, m->offset);
 
 	while ((d.len - off) >= sizeof(uint32_t)) {
-		asm_emit_cell(e, fdt32_to_cpu(*((fdt32_t *)(d.val+off))));
+		asm_emit_cell(e, dtb_ld32(d.val + off));
 		off += sizeof(uint32_t);
 	}
 
@@ -234,7 +220,7 @@ static struct emitter asm_emitter = {
 
 static int stringtable_insert(struct data *d, const char *str)
 {
-	int i;
+	unsigned int i;
 
 	/* FIXME: do this more efficiently? */
 
@@ -310,7 +296,7 @@ static struct data flatten_reserve_list(struct reserve_info *reservelist,
 {
 	struct reserve_info *re;
 	struct data d = empty_data;
-	int    j;
+	unsigned int j;
 
 	for (re = reservelist; re; re = re->next) {
 		d = data_append_re(d, re->address, re->size);
@@ -360,7 +346,7 @@ static void make_fdt_header(struct fdt_header *fdt,
 void dt_to_blob(FILE *f, struct dt_info *dti, int version)
 {
 	struct version_info *vi = NULL;
-	int i;
+	unsigned int i;
 	struct data blob       = empty_data;
 	struct data reservebuf = empty_data;
 	struct data dtbuf      = empty_data;
@@ -393,7 +379,7 @@ void dt_to_blob(FILE *f, struct dt_info *dti, int version)
 			padlen = 0;
 			if (quiet < 1)
 				fprintf(stderr,
-					"Warning: blob size %d >= minimum size %d\n",
+					"Warning: blob size %"PRIu32" >= minimum size %d\n",
 					fdt32_to_cpu(fdt.totalsize), minsize);
 		}
 	}
@@ -453,7 +439,7 @@ static void dump_stringtable_asm(FILE *f, struct data strbuf)
 
 	while (p < (strbuf.val + strbuf.len)) {
 		len = strlen(p);
-		fprintf(f, "\t.string \"%s\"\n", p);
+		fprintf(f, "\t.asciz \"%s\"\n", p);
 		p += len+1;
 	}
 }
@@ -461,7 +447,7 @@ static void dump_stringtable_asm(FILE *f, struct data strbuf)
 void dt_to_asm(FILE *f, struct dt_info *dti, int version)
 {
 	struct version_info *vi = NULL;
-	int i;
+	unsigned int i;
 	struct data strbuf = empty_data;
 	struct reserve_info *re;
 	const char *symprefix = "dt";
@@ -517,7 +503,7 @@ void dt_to_asm(FILE *f, struct dt_info *dti, int version)
 	 * Reserve map entries.
 	 * Align the reserve map to a doubleword boundary.
 	 * Each entry is an (address, size) pair of u64 values.
-	 * Always supply a zero-sized temination entry.
+	 * Always supply a zero-sized termination entry.
 	 */
 	asm_emit_align(f, 8);
 	emit_label(f, symprefix, "reserve_map");
@@ -525,7 +511,7 @@ void dt_to_asm(FILE *f, struct dt_info *dti, int version)
 	fprintf(f, "/* Memory reserve map from source file */\n");
 
 	/*
-	 * Use .long on high and low halfs of u64s to avoid .quad
+	 * Use .long on high and low halves of u64s to avoid .quad
 	 * as it appears .quad isn't available in some assemblers.
 	 */
 	for (re = dti->reservelist; re; re = re->next) {
@@ -618,11 +604,11 @@ static void flat_realign(struct inbuf *inb, int align)
 		die("Premature end of data parsing flat device tree\n");
 }
 
-static char *flat_read_string(struct inbuf *inb)
+static const char *flat_read_string(struct inbuf *inb)
 {
 	int len = 0;
 	const char *p = inb->ptr;
-	char *str;
+	const char *str;
 
 	do {
 		if (p >= inb->limit)
@@ -630,7 +616,7 @@ static char *flat_read_string(struct inbuf *inb)
 		len++;
 	} while ((*p++) != '\0');
 
-	str = xstrdup(inb->ptr);
+	str = inb->ptr;
 
 	inb->ptr += len;
 
@@ -692,7 +678,7 @@ static struct property *flat_read_property(struct inbuf *dtbuf,
 
 	val = flat_read_data(dtbuf, proplen);
 
-	return build_property(name, val);
+	return build_property(name, val, NULL);
 }
 
 static struct reserve_info *flat_read_mem_reserve(struct inbuf *inb)
@@ -723,7 +709,8 @@ static struct reserve_info *flat_read_mem_reserve(struct inbuf *inb)
 	return reservelist;
 }
 
-static char *nodename_from_path(const char *ppath, const char *cpath)
+
+static const char *nodename_from_path(const char *ppath, const char *cpath)
 {
 	int plen;
 
@@ -737,7 +724,7 @@ static char *nodename_from_path(const char *ppath, const char *cpath)
 	if (!streq(ppath, "/"))
 		plen++;
 
-	return xstrdup(cpath + plen);
+	return cpath + plen;
 }
 
 static struct node *unflatten_tree(struct inbuf *dtbuf,
@@ -745,17 +732,18 @@ static struct node *unflatten_tree(struct inbuf *dtbuf,
 				   const char *parent_flatname, int flags)
 {
 	struct node *node;
-	char *flatname;
+	const char *flatname;
 	uint32_t val;
 
-	node = build_node(NULL, NULL);
+	node = build_node(NULL, NULL, NULL);
 
 	flatname = flat_read_string(dtbuf);
 
 	if (flags & FTF_FULLPATH)
-		node->name = nodename_from_path(parent_flatname, flatname);
+		node->name = xstrdup(nodename_from_path(parent_flatname,
+							flatname));
 	else
-		node->name = flatname;
+		node->name = xstrdup(flatname);
 
 	do {
 		struct property *prop;
@@ -797,10 +785,6 @@ static struct node *unflatten_tree(struct inbuf *dtbuf,
 		}
 	} while (val != FDT_END_NODE);
 
-	if (node->name != flatname) {
-		free(flatname);
-	}
-
 	return node;
 }
 
diff --git a/scripts/dtc/fstree.c b/scripts/dtc/fstree.c
index ae7d06c3c49..0f9a534bacd 100644
--- a/scripts/dtc/fstree.c
+++ b/scripts/dtc/fstree.c
@@ -1,21 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include "dtc.h"
@@ -34,7 +19,7 @@ static struct node *read_fstree(const char *dirname)
 	if (!d)
 		die("Couldn't opendir() \"%s\": %s\n", dirname, strerror(errno));
 
-	tree = build_node(NULL, NULL);
+	tree = build_node(NULL, NULL, NULL);
 
 	while ((de = readdir(d)) != NULL) {
 		char *tmpname;
@@ -45,7 +30,7 @@ static struct node *read_fstree(const char *dirname)
 
 		tmpname = join_path(dirname, de->d_name);
 
-		if (lstat(tmpname, &st) < 0)
+		if (stat(tmpname, &st) < 0)
 			die("stat(%s): %s\n", tmpname, strerror(errno));
 
 		if (S_ISREG(st.st_mode)) {
@@ -58,9 +43,10 @@ static struct node *read_fstree(const char *dirname)
 					"WARNING: Cannot open %s: %s\n",
 					tmpname, strerror(errno));
 			} else {
-				prop = build_property(xstrdup(de->d_name),
+				prop = build_property(de->d_name,
 						      data_copy_file(pfile,
-								     st.st_size));
+								     st.st_size),
+						      NULL);
 				add_property(tree, prop);
 				fclose(pfile);
 			}
diff --git a/scripts/dtc/libfdt/fdt.c b/scripts/dtc/libfdt/fdt.c
index 28f4e1a5f15..95f644c31f9 100644
--- a/scripts/dtc/libfdt/fdt.c
+++ b/scripts/dtc/libfdt/fdt.c
@@ -19,9 +19,16 @@ int32_t fdt_ro_probe_(const void *fdt)
 {
 	uint32_t totalsize = fdt_totalsize(fdt);
 
+	if (can_assume(VALID_DTB))
+		return totalsize;
+
+	/* The device tree must be at an 8-byte aligned address */
+	if ((uintptr_t)fdt & 7)
+		return -FDT_ERR_ALIGNMENT;
+
 	if (fdt_magic(fdt) == FDT_MAGIC) {
 		/* Complete tree */
-		if (fdt_chk_version()) {
+		if (!can_assume(LATEST)) {
 			if (fdt_version(fdt) < FDT_FIRST_SUPPORTED_VERSION)
 				return -FDT_ERR_BADVERSION;
 			if (fdt_last_comp_version(fdt) >
@@ -30,7 +37,7 @@ int32_t fdt_ro_probe_(const void *fdt)
 		}
 	} else if (fdt_magic(fdt) == FDT_SW_MAGIC) {
 		/* Unfinished sequential-write blob */
-		if (fdt_size_dt_struct(fdt) == 0)
+		if (!can_assume(VALID_INPUT) && fdt_size_dt_struct(fdt) == 0)
 			return -FDT_ERR_BADSTATE;
 	} else {
 		return -FDT_ERR_BADMAGIC;
@@ -75,17 +82,21 @@ size_t fdt_header_size_(uint32_t version)
 
 size_t fdt_header_size(const void *fdt)
 {
-	return fdt_chk_version() ? fdt_header_size_(fdt_version(fdt)) :
-		FDT_V17_SIZE;
+	return can_assume(LATEST) ? FDT_V17_SIZE :
+		fdt_header_size_(fdt_version(fdt));
 }
 
 int fdt_check_header(const void *fdt)
 {
 	size_t hdrsize;
 
+	/* The device tree must be at an 8-byte aligned address */
+	if ((uintptr_t)fdt & 7)
+		return -FDT_ERR_ALIGNMENT;
+
 	if (fdt_magic(fdt) != FDT_MAGIC)
 		return -FDT_ERR_BADMAGIC;
-	if (fdt_chk_version()) {
+	if (!can_assume(LATEST)) {
 		if ((fdt_version(fdt) < FDT_FIRST_SUPPORTED_VERSION)
 		    || (fdt_last_comp_version(fdt) >
 			FDT_LAST_SUPPORTED_VERSION))
@@ -94,8 +105,7 @@ int fdt_check_header(const void *fdt)
 			return -FDT_ERR_BADVERSION;
 	}
 	hdrsize = fdt_header_size(fdt);
-	if (fdt_chk_basic()) {
-
+	if (!can_assume(VALID_DTB)) {
 		if ((fdt_totalsize(fdt) < hdrsize)
 		    || (fdt_totalsize(fdt) > INT_MAX))
 			return -FDT_ERR_TRUNCATED;
@@ -104,11 +114,9 @@ int fdt_check_header(const void *fdt)
 		if (!check_off_(hdrsize, fdt_totalsize(fdt),
 				fdt_off_mem_rsvmap(fdt)))
 			return -FDT_ERR_TRUNCATED;
-	}
 
-	if (fdt_chk_extra()) {
 		/* Bounds check structure block */
-		if (fdt_chk_version() && fdt_version(fdt) < 17) {
+		if (!can_assume(LATEST) && fdt_version(fdt) < 17) {
 			if (!check_off_(hdrsize, fdt_totalsize(fdt),
 					fdt_off_dt_struct(fdt)))
 				return -FDT_ERR_TRUNCATED;
@@ -137,13 +145,13 @@ const void *fdt_offset_ptr(const void *fdt, int offset, unsigned int len)
 	if (offset < 0)
 		return NULL;
 
-	if (fdt_chk_basic())
+	if (!can_assume(VALID_INPUT))
 		if ((absoffset < uoffset)
 		    || ((absoffset + len) < absoffset)
 		    || (absoffset + len) > fdt_totalsize(fdt))
 			return NULL;
 
-	if (!fdt_chk_version() || fdt_version(fdt) >= 0x11)
+	if (can_assume(LATEST) || fdt_version(fdt) >= 0x11)
 		if (((uoffset + len) < uoffset)
 		    || ((offset + len) > fdt_size_dt_struct(fdt)))
 			return NULL;
@@ -154,13 +162,13 @@ const void *fdt_offset_ptr(const void *fdt, int offset, unsigned int len)
 uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
 {
 	const fdt32_t *tagp, *lenp;
-	uint32_t tag;
+	uint32_t tag, len, sum;
 	int offset = startoffset;
 	const char *p;
 
 	*nextoffset = -FDT_ERR_TRUNCATED;
 	tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
-	if (fdt_chk_basic() && !tagp)
+	if (!can_assume(VALID_DTB) && !tagp)
 		return FDT_END; /* premature end */
 	tag = fdt32_to_cpu(*tagp);
 	offset += FDT_TAGSIZE;
@@ -172,20 +180,27 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
 		do {
 			p = fdt_offset_ptr(fdt, offset++, 1);
 		} while (p && (*p != '\0'));
-		if (fdt_chk_basic() && !p)
+		if (!can_assume(VALID_DTB) && !p)
 			return FDT_END; /* premature end */
 		break;
 
 	case FDT_PROP:
 		lenp = fdt_offset_ptr(fdt, offset, sizeof(*lenp));
-		if (fdt_chk_basic() && !lenp)
+		if (!can_assume(VALID_DTB) && !lenp)
 			return FDT_END; /* premature end */
+
+		len = fdt32_to_cpu(*lenp);
+		sum = len + offset;
+		if (!can_assume(VALID_DTB) &&
+		    (INT_MAX <= sum || sum < (uint32_t) offset))
+			return FDT_END; /* premature end */
+
 		/* skip-name offset, length and value */
-		offset += sizeof(struct fdt_property) - FDT_TAGSIZE
-			+ fdt32_to_cpu(*lenp);
-		if (fdt_chk_version() &&
-		    fdt_version(fdt) < 0x10 && fdt32_to_cpu(*lenp) >= 8 &&
-		    ((offset - fdt32_to_cpu(*lenp)) % 8) != 0)
+		offset += sizeof(struct fdt_property) - FDT_TAGSIZE + len;
+
+		if (!can_assume(LATEST) &&
+		    fdt_version(fdt) < 0x10 && len >= 8 &&
+		    ((offset - len) % 8) != 0)
 			offset += 4;
 		break;
 
@@ -198,8 +213,7 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
 		return FDT_END;
 	}
 
-	if (fdt_chk_basic() &&
-	    !fdt_offset_ptr(fdt, startoffset, offset - startoffset))
+	if (!fdt_offset_ptr(fdt, startoffset, offset - startoffset))
 		return FDT_END; /* premature end */
 
 	*nextoffset = FDT_TAGALIGN(offset);
@@ -208,8 +222,11 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
 
 int fdt_check_node_offset_(const void *fdt, int offset)
 {
-	if ((offset < 0) || (offset % FDT_TAGSIZE)
-	    || (fdt_next_tag(fdt, offset, &offset) != FDT_BEGIN_NODE))
+	if (!can_assume(VALID_INPUT)
+	    && ((offset < 0) || (offset % FDT_TAGSIZE)))
+		return -FDT_ERR_BADOFFSET;
+
+	if (fdt_next_tag(fdt, offset, &offset) != FDT_BEGIN_NODE)
 		return -FDT_ERR_BADOFFSET;
 
 	return offset;
@@ -217,8 +234,11 @@ int fdt_check_node_offset_(const void *fdt, int offset)
 
 int fdt_check_prop_offset_(const void *fdt, int offset)
 {
-	if ((offset < 0) || (offset % FDT_TAGSIZE)
-	    || (fdt_next_tag(fdt, offset, &offset) != FDT_PROP))
+	if (!can_assume(VALID_INPUT)
+	    && ((offset < 0) || (offset % FDT_TAGSIZE)))
+		return -FDT_ERR_BADOFFSET;
+
+	if (fdt_next_tag(fdt, offset, &offset) != FDT_PROP)
 		return -FDT_ERR_BADOFFSET;
 
 	return offset;
@@ -292,21 +312,21 @@ int fdt_next_subnode(const void *fdt, int offset)
 	return offset;
 }
 
-const char *fdt_find_string_(const char *strtab, int tabsize, const char *s)
+const char *fdt_find_string_len_(const char *strtab, int tabsize, const char *s,
+				 int slen)
 {
-	int len = strlen(s) + 1;
-	const char *last = strtab + tabsize - len;
+	const char *last = strtab + tabsize - (slen + 1);
 	const char *p;
 
 	for (p = strtab; p <= last; p++)
-		if (memcmp(p, s, len) == 0)
+		if (memcmp(p, s, slen) == 0 && p[slen] == '\0')
 			return p;
 	return NULL;
 }
 
 int fdt_move(const void *fdt, void *buf, int bufsize)
 {
-	if (fdt_chk_basic() && bufsize < 0)
+	if (!can_assume(VALID_INPUT) && bufsize < 0)
 		return -FDT_ERR_NOSPACE;
 
 	FDT_RO_PROBE(fdt);
diff --git a/scripts/dtc/libfdt/fdt.h b/scripts/dtc/libfdt/fdt.h
index f2e68807f27..c6e4d7838dc 100644
--- a/scripts/dtc/libfdt/fdt.h
+++ b/scripts/dtc/libfdt/fdt.h
@@ -7,7 +7,7 @@
  * Copyright 2012 Kim Phillips, Freescale Semiconductor.
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct fdt_header {
 	fdt32_t magic;			 /* magic word FDT_MAGIC */
@@ -45,7 +45,7 @@ struct fdt_property {
 	char data[0];
 };
 
-#endif /* !__ASSEMBLY */
+#endif /* !__ASSEMBLER__ */
 
 #define FDT_MAGIC	0xd00dfeed	/* 4: version, 4: total size */
 #define FDT_TAGSIZE	sizeof(fdt32_t)
diff --git a/scripts/dtc/libfdt/fdt_addresses.c b/scripts/dtc/libfdt/fdt_addresses.c
index 9a82cd0ba2f..c40ba094f1f 100644
--- a/scripts/dtc/libfdt/fdt_addresses.c
+++ b/scripts/dtc/libfdt/fdt_addresses.c
@@ -73,7 +73,7 @@ int fdt_appendprop_addrrange(void *fdt, int parent, int nodeoffset,
 	/* check validity of address */
 	prop = data;
 	if (addr_cells == 1) {
-		if ((addr > UINT32_MAX) || ((UINT32_MAX + 1 - addr) < size))
+		if ((addr > UINT32_MAX) || (((uint64_t) UINT32_MAX + 1 - addr) < size))
 			return -FDT_ERR_BADVALUE;
 
 		fdt32_st(prop, (uint32_t)addr);
diff --git a/scripts/dtc/libfdt/fdt_overlay.c b/scripts/dtc/libfdt/fdt_overlay.c
index 7a65c35af6f..ee64f0b8110 100644
--- a/scripts/dtc/libfdt/fdt_overlay.c
+++ b/scripts/dtc/libfdt/fdt_overlay.c
@@ -40,37 +40,22 @@ static uint32_t overlay_get_target_phandle(const void *fdto, int fragment)
 	return fdt32_to_cpu(*val);
 }
 
-/**
- * overlay_get_target - retrieves the offset of a fragment's target
- * @fdt: Base device tree blob
- * @fdto: Device tree overlay blob
- * @fragment: node offset of the fragment in the overlay
- * @pathp: pointer which receives the path of the target (or NULL)
- *
- * overlay_get_target() retrieves the target offset in the base
- * device tree of a fragment, no matter how the actual targeting is
- * done (through a phandle or a path)
- *
- * returns:
- *      the targeted node offset in the base device tree
- *      Negative error code on error
- */
-static int overlay_get_target(const void *fdt, const void *fdto,
-			      int fragment, char const **pathp)
+int fdt_overlay_target_offset(const void *fdt, const void *fdto,
+			      int fragment_offset, char const **pathp)
 {
 	uint32_t phandle;
 	const char *path = NULL;
 	int path_len = 0, ret;
 
 	/* Try first to do a phandle based lookup */
-	phandle = overlay_get_target_phandle(fdto, fragment);
+	phandle = overlay_get_target_phandle(fdto, fragment_offset);
 	if (phandle == (uint32_t)-1)
 		return -FDT_ERR_BADPHANDLE;
 
 	/* no phandle, try path */
 	if (!phandle) {
 		/* And then a path based lookup */
-		path = fdt_getprop(fdto, fragment, "target-path", &path_len);
+		path = fdt_getprop(fdto, fragment_offset, "target-path", &path_len);
 		if (path)
 			ret = fdt_path_offset(fdt, path);
 		else
@@ -116,26 +101,22 @@ static int overlay_get_target(const void *fdt, const void *fdto,
 static int overlay_phandle_add_offset(void *fdt, int node,
 				      const char *name, uint32_t delta)
 {
-	const fdt32_t *val;
-	uint32_t adj_val;
+	fdt32_t *valp, val;
 	int len;
 
-	val = fdt_getprop(fdt, node, name, &len);
-	if (!val)
+	valp = fdt_getprop_w(fdt, node, name, &len);
+	if (!valp)
 		return len;
 
-	if (len != sizeof(*val))
+	if (len != sizeof(val))
 		return -FDT_ERR_BADPHANDLE;
 
-	adj_val = fdt32_to_cpu(*val);
-	if ((adj_val + delta) < adj_val)
+	val = fdt32_ld(valp);
+	if (val + delta < val || val + delta == (uint32_t)-1)
 		return -FDT_ERR_NOPHANDLES;
 
-	adj_val += delta;
-	if (adj_val == (uint32_t)-1)
-		return -FDT_ERR_NOPHANDLES;
-
-	return fdt_setprop_inplace_u32(fdt, node, name, adj_val);
+	fdt32_st(valp, val + delta);
+	return 0;
 }
 
 /**
@@ -228,8 +209,8 @@ static int overlay_update_local_node_references(void *fdto,
 
 	fdt_for_each_property_offset(fixup_prop, fdto, fixup_node) {
 		const fdt32_t *fixup_val;
-		const char *tree_val;
 		const char *name;
+		char *tree_val;
 		int fixup_len;
 		int tree_len;
 		int i;
@@ -243,7 +224,7 @@ static int overlay_update_local_node_references(void *fdto,
 			return -FDT_ERR_BADOVERLAY;
 		fixup_len /= sizeof(uint32_t);
 
-		tree_val = fdt_getprop(fdto, tree_node, name, &tree_len);
+		tree_val = fdt_getprop_w(fdto, tree_node, name, &tree_len);
 		if (!tree_val) {
 			if (tree_len == -FDT_ERR_NOTFOUND)
 				return -FDT_ERR_BADOVERLAY;
@@ -252,33 +233,15 @@ static int overlay_update_local_node_references(void *fdto,
 		}
 
 		for (i = 0; i < fixup_len; i++) {
-			fdt32_t adj_val;
-			uint32_t poffset;
+			fdt32_t *refp;
 
-			poffset = fdt32_to_cpu(fixup_val[i]);
+			refp = (fdt32_t *)(tree_val + fdt32_ld_(fixup_val + i));
 
 			/*
-			 * phandles to fixup can be unaligned.
-			 *
-			 * Use a memcpy for the architectures that do
-			 * not support unaligned accesses.
+			 * phandles to fixup can be unaligned, so use
+			 * fdt32_{ld,st}() to read/write them.
 			 */
-			memcpy(&adj_val, tree_val + poffset, sizeof(adj_val));
-
-			adj_val = cpu_to_fdt32(fdt32_to_cpu(adj_val) + delta);
-
-			ret = fdt_setprop_inplace_namelen_partial(fdto,
-								  tree_node,
-								  name,
-								  strlen(name),
-								  poffset,
-								  &adj_val,
-								  sizeof(adj_val));
-			if (ret == -FDT_ERR_NOSPACE)
-				return -FDT_ERR_BADOVERLAY;
-
-			if (ret)
-				return ret;
+			fdt32_st(refp, fdt32_ld(refp) + delta);
 		}
 	}
 
@@ -344,7 +307,6 @@ static int overlay_update_local_references(void *fdto, uint32_t delta)
 
 /**
  * overlay_fixup_one_phandle - Set an overlay phandle to the base one
- * @fdt: Base Device Tree blob
  * @fdto: Device tree overlay blob
  * @symbols_off: Node offset of the symbols node in the base device tree
  * @path: Path to a node holding a phandle in the overlay
@@ -352,7 +314,7 @@ static int overlay_update_local_references(void *fdto, uint32_t delta)
  * @name: Name of the property holding the phandle reference in the overlay
  * @name_len: number of name characters to consider
  * @poffset: Offset within the overlay property where the phandle is stored
- * @label: Label of the node referenced by the phandle
+ * @phandle: Phandle referencing the node
  *
  * overlay_fixup_one_phandle() resolves an overlay phandle pointing to
  * a node in the base device tree.
@@ -365,34 +327,17 @@ static int overlay_update_local_references(void *fdto, uint32_t delta)
  *      0 on success
  *      Negative error code on failure
  */
-static int overlay_fixup_one_phandle(void *fdt, void *fdto,
-				     int symbols_off,
+static int overlay_fixup_one_phandle(void *fdto, int symbols_off,
 				     const char *path, uint32_t path_len,
 				     const char *name, uint32_t name_len,
-				     int poffset, const char *label)
+				     int poffset, uint32_t phandle)
 {
-	const char *symbol_path;
-	uint32_t phandle;
 	fdt32_t phandle_prop;
-	int symbol_off, fixup_off;
-	int prop_len;
+	int fixup_off;
 
 	if (symbols_off < 0)
 		return symbols_off;
 
-	symbol_path = fdt_getprop(fdt, symbols_off, label,
-				  &prop_len);
-	if (!symbol_path)
-		return prop_len;
-
-	symbol_off = fdt_path_offset(fdt, symbol_path);
-	if (symbol_off < 0)
-		return symbol_off;
-
-	phandle = fdt_get_phandle(fdt, symbol_off);
-	if (!phandle)
-		return -FDT_ERR_NOTFOUND;
-
 	fixup_off = fdt_path_offset_namelen(fdto, path, path_len);
 	if (fixup_off == -FDT_ERR_NOTFOUND)
 		return -FDT_ERR_BADOVERLAY;
@@ -404,7 +349,7 @@ static int overlay_fixup_one_phandle(void *fdt, void *fdto,
 						   name, name_len, poffset,
 						   &phandle_prop,
 						   sizeof(phandle_prop));
-};
+}
 
 /**
  * overlay_fixup_phandle - Set an overlay phandle to the base one
@@ -431,6 +376,10 @@ static int overlay_fixup_phandle(void *fdt, void *fdto, int symbols_off,
 	const char *value;
 	const char *label;
 	int len;
+	const char *symbol_path;
+	int prop_len;
+	int symbol_off;
+	uint32_t phandle;
 
 	value = fdt_getprop_by_offset(fdto, property,
 				      &label, &len);
@@ -441,6 +390,18 @@ static int overlay_fixup_phandle(void *fdt, void *fdto, int symbols_off,
 		return len;
 	}
 
+	symbol_path = fdt_getprop(fdt, symbols_off, label, &prop_len);
+	if (!symbol_path)
+		return prop_len;
+
+	symbol_off = fdt_path_offset(fdt, symbol_path);
+	if (symbol_off < 0)
+		return symbol_off;
+
+	phandle = fdt_get_phandle(fdt, symbol_off);
+	if (!phandle)
+		return -FDT_ERR_NOTFOUND;
+
 	do {
 		const char *path, *name, *fixup_end;
 		const char *fixup_str = value;
@@ -480,9 +441,9 @@ static int overlay_fixup_phandle(void *fdt, void *fdto, int symbols_off,
 		if ((*endptr != '\0') || (endptr <= (sep + 1)))
 			return -FDT_ERR_BADOVERLAY;
 
-		ret = overlay_fixup_one_phandle(fdt, fdto, symbols_off,
+		ret = overlay_fixup_one_phandle(fdto, symbols_off,
 						path, path_len, name, name_len,
-						poffset, label);
+						poffset, phandle);
 		if (ret)
 			return ret;
 	} while (len > 0);
@@ -535,6 +496,255 @@ static int overlay_fixup_phandles(void *fdt, void *fdto)
 	return 0;
 }
 
+/**
+ * overlay_adjust_local_conflicting_phandle: Changes a phandle value
+ * @fdto: Device tree overlay
+ * @node: The node the phandle is set for
+ * @fdt_phandle: The new value for the phandle
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_adjust_local_conflicting_phandle(void *fdto, int node,
+						    uint32_t fdt_phandle)
+{
+	const fdt32_t *php;
+	int len, ret;
+
+	php = fdt_getprop(fdto, node, "phandle", &len);
+	if (php && len == sizeof(*php)) {
+		ret = fdt_setprop_inplace_u32(fdto, node, "phandle", fdt_phandle);
+		if (ret)
+			return ret;
+	}
+
+	php = fdt_getprop(fdto, node, "linux,phandle", &len);
+	if (php && len == sizeof(*php)) {
+		ret = fdt_setprop_inplace_u32(fdto, node, "linux,phandle", fdt_phandle);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * overlay_update_node_conflicting_references - Recursively replace phandle values
+ * @fdto: Device tree overlay blob
+ * @tree_node: Node to recurse into
+ * @fixup_node: Node offset of the matching local fixups node
+ * @fdt_phandle: Value to replace phandles with
+ * @fdto_phandle: Value to be replaced
+ *
+ * Replaces all phandles with value @fdto_phandle by @fdt_phandle.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_update_node_conflicting_references(void *fdto, int tree_node,
+						      int fixup_node,
+						      uint32_t fdt_phandle,
+						      uint32_t fdto_phandle)
+{
+	int fixup_prop;
+	int fixup_child;
+	int ret;
+
+	fdt_for_each_property_offset(fixup_prop, fdto, fixup_node) {
+		const fdt32_t *fixup_val;
+		const char *name;
+		char *tree_val;
+		int fixup_len;
+		int tree_len;
+		int i;
+
+		fixup_val = fdt_getprop_by_offset(fdto, fixup_prop,
+						  &name, &fixup_len);
+		if (!fixup_val)
+			return fixup_len;
+
+		if (fixup_len % sizeof(uint32_t))
+			return -FDT_ERR_BADOVERLAY;
+		fixup_len /= sizeof(uint32_t);
+
+		tree_val = fdt_getprop_w(fdto, tree_node, name, &tree_len);
+		if (!tree_val) {
+			if (tree_len == -FDT_ERR_NOTFOUND)
+				return -FDT_ERR_BADOVERLAY;
+
+			return tree_len;
+		}
+
+		for (i = 0; i < fixup_len; i++) {
+			fdt32_t *refp;
+			uint32_t valp;
+
+			refp = (fdt32_t *)(tree_val + fdt32_ld_(fixup_val + i));
+			valp = fdt32_ld(refp);
+
+			if (valp == fdto_phandle)
+				fdt32_st(refp, fdt_phandle);
+		}
+	}
+
+	fdt_for_each_subnode(fixup_child, fdto, fixup_node) {
+		const char *fixup_child_name = fdt_get_name(fdto, fixup_child, NULL);
+		int tree_child;
+
+		tree_child = fdt_subnode_offset(fdto, tree_node, fixup_child_name);
+
+		if (tree_child == -FDT_ERR_NOTFOUND)
+			return -FDT_ERR_BADOVERLAY;
+		if (tree_child < 0)
+			return tree_child;
+
+		ret = overlay_update_node_conflicting_references(fdto, tree_child,
+								 fixup_child,
+								 fdt_phandle,
+								 fdto_phandle);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * overlay_update_local_conflicting_references - Recursively replace phandle values
+ * @fdto: Device tree overlay blob
+ * @fdt_phandle: Value to replace phandles with
+ * @fdto_phandle: Value to be replaced
+ *
+ * Replaces all phandles with value @fdto_phandle by @fdt_phandle.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_update_local_conflicting_references(void *fdto,
+						       uint32_t fdt_phandle,
+						       uint32_t fdto_phandle)
+{
+	int fixups;
+
+	fixups = fdt_path_offset(fdto, "/__local_fixups__");
+	if (fixups == -FDT_ERR_NOTFOUND)
+		return 0;
+	if (fixups < 0)
+		return fixups;
+
+	return overlay_update_node_conflicting_references(fdto, 0, fixups,
+							  fdt_phandle,
+							  fdto_phandle);
+}
+
+/**
+ * overlay_prevent_phandle_overwrite_node - Helper function for overlay_prevent_phandle_overwrite
+ * @fdt: Base Device tree blob
+ * @fdtnode: Node in fdt that is checked for an overwrite
+ * @fdto: Device tree overlay blob
+ * @fdtonode: Node in fdto matching @fdtnode
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_prevent_phandle_overwrite_node(void *fdt, int fdtnode,
+						  void *fdto, int fdtonode)
+{
+	uint32_t fdt_phandle, fdto_phandle;
+	int fdtochild;
+
+	fdt_phandle = fdt_get_phandle(fdt, fdtnode);
+	fdto_phandle = fdt_get_phandle(fdto, fdtonode);
+
+	if (fdt_phandle && fdto_phandle) {
+		int ret;
+
+		ret = overlay_adjust_local_conflicting_phandle(fdto, fdtonode,
+							       fdt_phandle);
+		if (ret)
+			return ret;
+
+		ret = overlay_update_local_conflicting_references(fdto,
+								  fdt_phandle,
+								  fdto_phandle);
+		if (ret)
+			return ret;
+	}
+
+	fdt_for_each_subnode(fdtochild, fdto, fdtonode) {
+		const char *name = fdt_get_name(fdto, fdtochild, NULL);
+		int fdtchild;
+		int ret;
+
+		fdtchild = fdt_subnode_offset(fdt, fdtnode, name);
+		if (fdtchild == -FDT_ERR_NOTFOUND)
+			/*
+			 * no further overwrites possible here as this node is
+			 * new
+			 */
+			continue;
+
+		ret = overlay_prevent_phandle_overwrite_node(fdt, fdtchild,
+							     fdto, fdtochild);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * overlay_prevent_phandle_overwrite - Fixes overlay phandles to not overwrite base phandles
+ * @fdt: Base Device Tree blob
+ * @fdto: Device tree overlay blob
+ *
+ * Checks recursively if applying fdto overwrites phandle values in the base
+ * dtb. When such a phandle is found, the fdto is changed to use the fdt's
+ * phandle value to not break references in the base.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_prevent_phandle_overwrite(void *fdt, void *fdto)
+{
+	int fragment;
+
+	fdt_for_each_subnode(fragment, fdto, 0) {
+		int overlay;
+		int target;
+		int ret;
+
+		overlay = fdt_subnode_offset(fdto, fragment, "__overlay__");
+		if (overlay == -FDT_ERR_NOTFOUND)
+			continue;
+
+		if (overlay < 0)
+			return overlay;
+
+		target = fdt_overlay_target_offset(fdt, fdto, fragment, NULL);
+		if (target == -FDT_ERR_NOTFOUND)
+			/*
+			 * The subtree doesn't exist in the base, so nothing
+			 * will be overwritten.
+			 */
+			continue;
+		else if (target < 0)
+			return target;
+
+		ret = overlay_prevent_phandle_overwrite_node(fdt, target,
+							     fdto, overlay);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * overlay_apply_node - Merges a node into the base device tree
  * @fdt: Base Device Tree blob
@@ -636,7 +846,7 @@ static int overlay_merge(void *fdt, void *fdto)
 		if (overlay < 0)
 			return overlay;
 
-		target = overlay_get_target(fdt, fdto, fragment, NULL);
+		target = fdt_overlay_target_offset(fdt, fdto, fragment, NULL);
 		if (target < 0)
 			return target;
 
@@ -779,7 +989,7 @@ static int overlay_symbol_update(void *fdt, void *fdto)
 			return -FDT_ERR_BADOVERLAY;
 
 		/* get the target of the fragment */
-		ret = overlay_get_target(fdt, fdto, fragment, &target_path);
+		ret = fdt_overlay_target_offset(fdt, fdto, fragment, &target_path);
 		if (ret < 0)
 			return ret;
 		target = ret;
@@ -801,7 +1011,7 @@ static int overlay_symbol_update(void *fdt, void *fdto)
 
 		if (!target_path) {
 			/* again in case setprop_placeholder changed it */
-			ret = overlay_get_target(fdt, fdto, fragment, &target_path);
+			ret = fdt_overlay_target_offset(fdt, fdto, fragment, &target_path);
 			if (ret < 0)
 				return ret;
 			target = ret;
@@ -838,18 +1048,26 @@ int fdt_overlay_apply(void *fdt, void *fdto)
 	if (ret)
 		goto err;
 
+	/* Increase all phandles in the fdto by delta */
 	ret = overlay_adjust_local_phandles(fdto, delta);
 	if (ret)
 		goto err;
 
+	/* Adapt the phandle values in fdto to the above increase */
 	ret = overlay_update_local_references(fdto, delta);
 	if (ret)
 		goto err;
 
+	/* Update fdto's phandles using symbols from fdt */
 	ret = overlay_fixup_phandles(fdt, fdto);
 	if (ret)
 		goto err;
 
+	/* Don't overwrite phandles in fdt */
+	ret = overlay_prevent_phandle_overwrite(fdt, fdto);
+	if (ret)
+		goto err;
+
 	ret = overlay_merge(fdt, fdto);
 	if (ret)
 		goto err;
diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
index d65656aaa8b..3e7e26b4398 100644
--- a/scripts/dtc/libfdt/fdt_ro.c
+++ b/scripts/dtc/libfdt/fdt_ro.c
@@ -16,7 +16,7 @@ static int fdt_nodename_eq_(const void *fdt, int offset,
 	int olen;
 	const char *p = fdt_get_name(fdt, offset, &olen);
 
-	if (!p || (fdt_chk_extra() && olen < len))
+	if (!p || olen < len)
 		/* short match */
 		return 0;
 
@@ -39,7 +39,7 @@ const char *fdt_get_string(const void *fdt, int stroffset, int *lenp)
 	int err;
 	const char *s, *n;
 
-	if (!fdt_chk_extra()) {
+	if (can_assume(VALID_INPUT)) {
 		s = (const char *)fdt + fdt_off_dt_strings(fdt) + stroffset;
 
 		if (lenp)
@@ -60,7 +60,7 @@ const char *fdt_get_string(const void *fdt, int stroffset, int *lenp)
 	if (fdt_magic(fdt) == FDT_MAGIC) {
 		if (stroffset < 0)
 			goto fail;
-		if (!fdt_chk_version() || fdt_version(fdt) >= 17) {
+		if (can_assume(LATEST) || fdt_version(fdt) >= 17) {
 			if ((unsigned)stroffset >= fdt_size_dt_strings(fdt))
 				goto fail;
 			if ((fdt_size_dt_strings(fdt) - stroffset) < len)
@@ -72,7 +72,7 @@ const char *fdt_get_string(const void *fdt, int stroffset, int *lenp)
 		if ((stroffset >= 0) ||
 		    (sw_stroffset > fdt_size_dt_strings(fdt)))
 			goto fail;
-		if ((sw_stroffset) < len)
+		if (sw_stroffset < len)
 			len = sw_stroffset;
 	} else {
 		err = -FDT_ERR_INTERNAL;
@@ -162,7 +162,7 @@ static const struct fdt_reserve_entry *fdt_mem_rsv(const void *fdt, int n)
 	unsigned int offset = n * sizeof(struct fdt_reserve_entry);
 	unsigned int absoffset = fdt_off_mem_rsvmap(fdt) + offset;
 
-	if (fdt_chk_extra()) {
+	if (!can_assume(VALID_INPUT)) {
 		if (absoffset < fdt_off_mem_rsvmap(fdt))
 			return NULL;
 		if (absoffset > fdt_totalsize(fdt) -
@@ -178,11 +178,11 @@ int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size)
 
 	FDT_RO_PROBE(fdt);
 	re = fdt_mem_rsv(fdt, n);
-	if (fdt_chk_extra() && !re)
+	if (!can_assume(VALID_INPUT) && !re)
 		return -FDT_ERR_BADOFFSET;
 
-	*address = fdt64_to_cpu(re->address);
-	*size = fdt64_to_cpu(re->size);
+	*address = fdt64_ld_(&re->address);
+	*size = fdt64_ld_(&re->size);
 	return 0;
 }
 
@@ -192,7 +192,7 @@ int fdt_num_mem_rsv(const void *fdt)
 	const struct fdt_reserve_entry *re;
 
 	for (i = 0; (re = fdt_mem_rsv(fdt, i)) != NULL; i++) {
-		if (fdt64_to_cpu(re->size) == 0)
+		if (fdt64_ld_(&re->size) == 0)
 			return i;
 	}
 	return -FDT_ERR_TRUNCATED;
@@ -255,6 +255,9 @@ int fdt_path_offset_namelen(const void *fdt, const char *path, int namelen)
 
 	FDT_RO_PROBE(fdt);
 
+	if (!can_assume(VALID_INPUT) && namelen <= 0)
+		return -FDT_ERR_BADPATH;
+
 	/* see if we have an alias */
 	if (*path != '/') {
 		const char *q = memchr(path, '/', end - p);
@@ -303,14 +306,13 @@ const char *fdt_get_name(const void *fdt, int nodeoffset, int *len)
 	const char *nameptr;
 	int err;
 
-	if (fdt_chk_extra() &&
-	    (((err = fdt_ro_probe_(fdt)) < 0)
-	     || ((err = fdt_check_node_offset_(fdt, nodeoffset)) < 0)))
-		goto fail;
+	if (((err = fdt_ro_probe_(fdt)) < 0)
+	    || ((err = fdt_check_node_offset_(fdt, nodeoffset)) < 0))
+			goto fail;
 
 	nameptr = nh->name;
 
-	if (fdt_chk_version() && fdt_version(fdt) < 0x10) {
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
 		/*
 		 * For old FDT versions, match the naming conventions of V16:
 		 * give only the leaf name (after all /). The actual tree
@@ -361,7 +363,8 @@ static const struct fdt_property *fdt_get_property_by_offset_(const void *fdt,
 	int err;
 	const struct fdt_property *prop;
 
-	if (fdt_chk_basic() && (err = fdt_check_prop_offset_(fdt, offset)) < 0) {
+	if (!can_assume(VALID_INPUT) &&
+	    (err = fdt_check_prop_offset_(fdt, offset)) < 0) {
 		if (lenp)
 			*lenp = err;
 		return NULL;
@@ -370,7 +373,7 @@ static const struct fdt_property *fdt_get_property_by_offset_(const void *fdt,
 	prop = fdt_offset_ptr_(fdt, offset);
 
 	if (lenp)
-		*lenp = fdt32_to_cpu(prop->len);
+		*lenp = fdt32_ld_(&prop->len);
 
 	return prop;
 }
@@ -382,7 +385,7 @@ const struct fdt_property *fdt_get_property_by_offset(const void *fdt,
 	/* Prior to version 16, properties may need realignment
 	 * and this API does not work. fdt_getprop_*() will, however. */
 
-	if (fdt_chk_version() && fdt_version(fdt) < 0x10) {
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
 		if (lenp)
 			*lenp = -FDT_ERR_BADVERSION;
 		return NULL;
@@ -404,11 +407,11 @@ static const struct fdt_property *fdt_get_property_namelen_(const void *fdt,
 		const struct fdt_property *prop;
 
 		prop = fdt_get_property_by_offset_(fdt, offset, lenp);
-		if (fdt_chk_extra() && !prop) {
+		if (!can_assume(LIBFDT_FLAWLESS) && !prop) {
 			offset = -FDT_ERR_INTERNAL;
 			break;
 		}
-		if (fdt_string_eq_(fdt, fdt32_to_cpu(prop->nameoff),
+		if (fdt_string_eq_(fdt, fdt32_ld_(&prop->nameoff),
 				   name, namelen)) {
 			if (poffset)
 				*poffset = offset;
@@ -428,7 +431,7 @@ const struct fdt_property *fdt_get_property_namelen(const void *fdt,
 {
 	/* Prior to version 16, properties may need realignment
 	 * and this API does not work. fdt_getprop_*() will, however. */
-	if (fdt_chk_version() && fdt_version(fdt) < 0x10) {
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
 		if (lenp)
 			*lenp = -FDT_ERR_BADVERSION;
 		return NULL;
@@ -458,8 +461,8 @@ const void *fdt_getprop_namelen(const void *fdt, int nodeoffset,
 		return NULL;
 
 	/* Handle realignment */
-	if (fdt_chk_version() && fdt_version(fdt) < 0x10 &&
-	    (poffset + sizeof(*prop)) % 8 && fdt32_to_cpu(prop->len) >= 8)
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10 &&
+	    (poffset + sizeof(*prop)) % 8 && fdt32_ld_(&prop->len) >= 8)
 		return prop->data + 4;
 	return prop->data;
 }
@@ -476,23 +479,23 @@ const void *fdt_getprop_by_offset(const void *fdt, int offset,
 		const char *name;
 		int namelen;
 
-		if (fdt_chk_extra()) {
-			name = fdt_get_string(fdt, fdt32_to_cpu(prop->nameoff),
+		if (!can_assume(VALID_INPUT)) {
+			name = fdt_get_string(fdt, fdt32_ld_(&prop->nameoff),
 					      &namelen);
+			*namep = name;
 			if (!name) {
 				if (lenp)
 					*lenp = namelen;
 				return NULL;
 			}
-			*namep = name;
 		} else {
-			*namep = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
+			*namep = fdt_string(fdt, fdt32_ld_(&prop->nameoff));
 		}
 	}
 
 	/* Handle realignment */
-	if (fdt_chk_version() && fdt_version(fdt) < 0x10 &&
-	    (offset + sizeof(*prop)) % 8 && fdt32_to_cpu(prop->len) >= 8)
+	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10 &&
+	    (offset + sizeof(*prop)) % 8 && fdt32_ld_(&prop->len) >= 8)
 		return prop->data + 4;
 	return prop->data;
 }
@@ -517,19 +520,34 @@ uint32_t fdt_get_phandle(const void *fdt, int nodeoffset)
 			return 0;
 	}
 
-	return fdt32_to_cpu(*php);
+	return fdt32_ld_(php);
+}
+
+static const void *fdt_path_getprop_namelen(const void *fdt, const char *path,
+					    const char *propname, int propnamelen,
+					    int *lenp)
+{
+	int offset = fdt_path_offset(fdt, path);
+
+	if (offset < 0)
+		return NULL;
+
+	return fdt_getprop_namelen(fdt, offset, propname, propnamelen, lenp);
 }
 
 const char *fdt_get_alias_namelen(const void *fdt,
 				  const char *name, int namelen)
 {
-	int aliasoffset;
+	int len;
+	const char *alias;
+
+	alias = fdt_path_getprop_namelen(fdt, "/aliases", name, namelen, &len);
 
-	aliasoffset = fdt_path_offset(fdt, "/aliases");
-	if (aliasoffset < 0)
+	if (!can_assume(VALID_DTB) &&
+	    !(alias && len > 0 && alias[len - 1] == '\0' && *alias == '/'))
 		return NULL;
 
-	return fdt_getprop_namelen(fdt, aliasoffset, name, namelen, NULL);
+	return alias;
 }
 
 const char *fdt_get_alias(const void *fdt, const char *name)
@@ -537,6 +555,17 @@ const char *fdt_get_alias(const void *fdt, const char *name)
 	return fdt_get_alias_namelen(fdt, name, strlen(name));
 }
 
+const char *fdt_get_symbol_namelen(const void *fdt,
+				   const char *name, int namelen)
+{
+	return fdt_path_getprop_namelen(fdt, "/__symbols__", name, namelen, NULL);
+}
+
+const char *fdt_get_symbol(const void *fdt, const char *name)
+{
+	return fdt_get_symbol_namelen(fdt, name, strlen(name));
+}
+
 int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen)
 {
 	int pdepth = 0, p = 0;
@@ -617,7 +646,7 @@ int fdt_supernode_atdepth_offset(const void *fdt, int nodeoffset,
 		}
 	}
 
-	if (fdt_chk_extra()) {
+	if (!can_assume(VALID_INPUT)) {
 		if ((offset == -FDT_ERR_NOTFOUND) || (offset >= 0))
 			return -FDT_ERR_BADOFFSET;
 		else if (offset == -FDT_ERR_BADOFFSET)
@@ -634,7 +663,8 @@ int fdt_node_depth(const void *fdt, int nodeoffset)
 
 	err = fdt_supernode_atdepth_offset(fdt, nodeoffset, 0, &nodedepth);
 	if (err)
-		return (!fdt_chk_extra() || err < 0) ? err : -FDT_ERR_INTERNAL;
+		return (can_assume(LIBFDT_FLAWLESS) || err < 0) ? err :
+			-FDT_ERR_INTERNAL;
 	return nodedepth;
 }
 
diff --git a/scripts/dtc/libfdt/fdt_rw.c b/scripts/dtc/libfdt/fdt_rw.c
index 2eb2b38703b..7475cafce07 100644
--- a/scripts/dtc/libfdt/fdt_rw.c
+++ b/scripts/dtc/libfdt/fdt_rw.c
@@ -13,8 +13,6 @@
 static int fdt_blocks_misordered_(const void *fdt,
 				  int mem_rsv_size, int struct_size)
 {
-	if (!fdt_chk_basic())
-		return false;
 	return (fdt_off_mem_rsvmap(fdt) < FDT_ALIGN(sizeof(struct fdt_header), 8))
 		|| (fdt_off_dt_struct(fdt) <
 		    (fdt_off_mem_rsvmap(fdt) + mem_rsv_size))
@@ -26,16 +24,16 @@ static int fdt_blocks_misordered_(const void *fdt,
 
 static int fdt_rw_probe_(void *fdt)
 {
-	if (!fdt_chk_basic())
+	if (can_assume(VALID_DTB))
 		return 0;
 	FDT_RO_PROBE(fdt);
 
-	if (fdt_chk_version() && fdt_version(fdt) < 17)
+	if (!can_assume(LATEST) && fdt_version(fdt) < 17)
 		return -FDT_ERR_BADVERSION;
 	if (fdt_blocks_misordered_(fdt, sizeof(struct fdt_reserve_entry),
 				   fdt_size_dt_struct(fdt)))
 		return -FDT_ERR_BADLAYOUT;
-	if (fdt_chk_version() && fdt_version(fdt) > 17)
+	if (!can_assume(LATEST) && fdt_version(fdt) > 17)
 		fdt_set_version(fdt, 17);
 
 	return 0;
@@ -44,11 +42,11 @@ static int fdt_rw_probe_(void *fdt)
 #define FDT_RW_PROBE(fdt) \
 	{ \
 		int err_; \
-		if (fdt_chk_extra() && (err_ = fdt_rw_probe_(fdt)) != 0) \
+		if ((err_ = fdt_rw_probe_(fdt)) != 0) \
 			return err_; \
 	}
 
-static inline int fdt_data_size_(void *fdt)
+static inline unsigned int fdt_data_size_(void *fdt)
 {
 	return fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
 }
@@ -56,15 +54,16 @@ static inline int fdt_data_size_(void *fdt)
 static int fdt_splice_(void *fdt, void *splicepoint, int oldlen, int newlen)
 {
 	char *p = splicepoint;
-	char *end = (char *)fdt + fdt_data_size_(fdt);
+	unsigned int dsize = fdt_data_size_(fdt);
+	size_t soff = p - (char *)fdt;
 
-	if (((p + oldlen) < p) || ((p + oldlen) > end))
+	if ((oldlen < 0) || (soff + oldlen < soff) || (soff + oldlen > dsize))
 		return -FDT_ERR_BADOFFSET;
-	if ((p < (char *)fdt) || ((end - oldlen + newlen) < (char *)fdt))
+	if ((p < (char *)fdt) || (dsize + newlen < (unsigned)oldlen))
 		return -FDT_ERR_BADOFFSET;
-	if ((end - oldlen + newlen) > ((char *)fdt + fdt_totalsize(fdt)))
+	if (dsize - oldlen + newlen > fdt_totalsize(fdt))
 		return -FDT_ERR_NOSPACE;
-	memmove(p + newlen, p + oldlen, end - p - oldlen);
+	memmove(p + newlen, p + oldlen, ((char *)fdt + dsize) - (p + oldlen));
 	return 0;
 }
 
@@ -122,34 +121,36 @@ static int fdt_splice_string_(void *fdt, int newlen)
  * @fdt: pointer to the device tree to check/adjust
  * @s: string to find/add
  * @allocated: Set to 0 if the string was found, 1 if not found and so
- *	allocated. Ignored if !fdt_chk_basic()
- * Return: offset of string in the string table (whether found or added)
+ *	allocated. Ignored if can_assume(NO_ROLLBACK)
+ * @return offset of string in the string table (whether found or added)
  */
-static int fdt_find_add_string_(void *fdt, const char *s, int *allocated)
+static int fdt_find_add_string_(void *fdt, const char *s, int slen,
+				int *allocated)
 {
 	char *strtab = (char *)fdt + fdt_off_dt_strings(fdt);
 	const char *p;
 	char *new;
-	int len = strlen(s) + 1;
 	int err;
 
-	if (fdt_chk_basic())
+	if (!can_assume(NO_ROLLBACK))
 		*allocated = 0;
 
-	p = fdt_find_string_(strtab, fdt_size_dt_strings(fdt), s);
+	p = fdt_find_string_len_(strtab, fdt_size_dt_strings(fdt), s, slen);
 	if (p)
 		/* found it */
 		return (p - strtab);
 
 	new = strtab + fdt_size_dt_strings(fdt);
-	err = fdt_splice_string_(fdt, len);
+	err = fdt_splice_string_(fdt, slen + 1);
 	if (err)
 		return err;
 
-	if (fdt_chk_basic())
+	if (!can_assume(NO_ROLLBACK))
 		*allocated = 1;
 
-	memcpy(new, s, len);
+	memcpy(new, s, slen);
+	new[slen] = '\0';
+
 	return (new - strtab);
 }
 
@@ -182,13 +183,15 @@ int fdt_del_mem_rsv(void *fdt, int n)
 	return fdt_splice_mem_rsv_(fdt, re, 1, 0);
 }
 
-static int fdt_resize_property_(void *fdt, int nodeoffset, const char *name,
+static int fdt_resize_property_(void *fdt, int nodeoffset,
+				const char *name, int namelen,
 				int len, struct fdt_property **prop)
 {
 	int oldlen;
 	int err;
 
-	*prop = fdt_get_property_w(fdt, nodeoffset, name, &oldlen);
+	*prop = fdt_get_property_namelen_w(fdt, nodeoffset, name, namelen,
+					   &oldlen);
 	if (!*prop)
 		return oldlen;
 
@@ -201,7 +204,7 @@ static int fdt_resize_property_(void *fdt, int nodeoffset, const char *name,
 }
 
 static int fdt_add_property_(void *fdt, int nodeoffset, const char *name,
-			     int len, struct fdt_property **prop)
+			     int namelen, int len, struct fdt_property **prop)
 {
 	int proplen;
 	int nextoffset;
@@ -212,7 +215,7 @@ static int fdt_add_property_(void *fdt, int nodeoffset, const char *name,
 	if ((nextoffset = fdt_check_node_offset_(fdt, nodeoffset)) < 0)
 		return nextoffset;
 
-	namestroff = fdt_find_add_string_(fdt, name, &allocated);
+	namestroff = fdt_find_add_string_(fdt, name, namelen, &allocated);
 	if (namestroff < 0)
 		return namestroff;
 
@@ -222,7 +225,7 @@ static int fdt_add_property_(void *fdt, int nodeoffset, const char *name,
 	err = fdt_splice_struct_(fdt, *prop, 0, proplen);
 	if (err) {
 		/* Delete the string if we failed to add it */
-		if (fdt_chk_basic() && allocated)
+		if (!can_assume(NO_ROLLBACK) && allocated)
 			fdt_del_last_string_(fdt, name);
 		return err;
 	}
@@ -256,17 +259,18 @@ int fdt_set_name(void *fdt, int nodeoffset, const char *name)
 	return 0;
 }
 
-int fdt_setprop_placeholder(void *fdt, int nodeoffset, const char *name,
-			    int len, void **prop_data)
+int fdt_setprop_placeholder_namelen(void *fdt, int nodeoffset, const char *name,
+				    int namelen, int len, void **prop_data)
 {
 	struct fdt_property *prop;
 	int err;
 
 	FDT_RW_PROBE(fdt);
 
-	err = fdt_resize_property_(fdt, nodeoffset, name, len, &prop);
+	err = fdt_resize_property_(fdt, nodeoffset, name, namelen, len, &prop);
 	if (err == -FDT_ERR_NOTFOUND)
-		err = fdt_add_property_(fdt, nodeoffset, name, len, &prop);
+		err = fdt_add_property_(fdt, nodeoffset, name, namelen, len,
+					&prop);
 	if (err)
 		return err;
 
@@ -274,13 +278,14 @@ int fdt_setprop_placeholder(void *fdt, int nodeoffset, const char *name,
 	return 0;
 }
 
-int fdt_setprop(void *fdt, int nodeoffset, const char *name,
-		const void *val, int len)
+int fdt_setprop_namelen(void *fdt, int nodeoffset, const char *name,
+			int namelen, const void *val, int len)
 {
 	void *prop_data;
 	int err;
 
-	err = fdt_setprop_placeholder(fdt, nodeoffset, name, len, &prop_data);
+	err = fdt_setprop_placeholder_namelen(fdt, nodeoffset, name, namelen,
+					      len, &prop_data);
 	if (err)
 		return err;
 
@@ -308,7 +313,8 @@ int fdt_appendprop(void *fdt, int nodeoffset, const char *name,
 		prop->len = cpu_to_fdt32(newlen);
 		memcpy(prop->data + oldlen, val, len);
 	} else {
-		err = fdt_add_property_(fdt, nodeoffset, name, len, &prop);
+		err = fdt_add_property_(fdt, nodeoffset, name, strlen(name),
+					len, &prop);
 		if (err)
 			return err;
 		memcpy(prop->data, val, len);
@@ -350,7 +356,10 @@ int fdt_add_subnode_namelen(void *fdt, int parentoffset,
 		return offset;
 
 	/* Try to place the new node after the parent's properties */
-	fdt_next_tag(fdt, parentoffset, &nextoffset); /* skip the BEGIN_NODE */
+	tag = fdt_next_tag(fdt, parentoffset, &nextoffset);
+	/* the fdt_subnode_offset_namelen() should ensure this never hits */
+	if (!can_assume(LIBFDT_FLAWLESS) && (tag != FDT_BEGIN_NODE))
+		return -FDT_ERR_INTERNAL;
 	do {
 		offset = nextoffset;
 		tag = fdt_next_tag(fdt, offset, &nextoffset);
@@ -392,7 +401,9 @@ int fdt_del_node(void *fdt, int nodeoffset)
 }
 
 static void fdt_packblocks_(const char *old, char *new,
-			    int mem_rsv_size, int struct_size)
+			    int mem_rsv_size,
+			    int struct_size,
+			    int strings_size)
 {
 	int mem_rsv_off, struct_off, strings_off;
 
@@ -407,8 +418,7 @@ static void fdt_packblocks_(const char *old, char *new,
 	fdt_set_off_dt_struct(new, struct_off);
 	fdt_set_size_dt_struct(new, struct_size);
 
-	memmove(new + strings_off, old + fdt_off_dt_strings(old),
-		fdt_size_dt_strings(old));
+	memmove(new + strings_off, old + fdt_off_dt_strings(old), strings_size);
 	fdt_set_off_dt_strings(new, strings_off);
 	fdt_set_size_dt_strings(new, fdt_size_dt_strings(old));
 }
@@ -427,17 +437,20 @@ int fdt_open_into(const void *fdt, void *buf, int bufsize)
 	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
 		* sizeof(struct fdt_reserve_entry);
 
-	if (!fdt_chk_version() || fdt_version(fdt) >= 17) {
+	if (can_assume(LATEST) || fdt_version(fdt) >= 17) {
 		struct_size = fdt_size_dt_struct(fdt);
-	} else {
+	} else if (fdt_version(fdt) == 16) {
 		struct_size = 0;
 		while (fdt_next_tag(fdt, struct_size, &struct_size) != FDT_END)
 			;
 		if (struct_size < 0)
 			return struct_size;
+	} else {
+		return -FDT_ERR_BADVERSION;
 	}
 
-	if (!fdt_blocks_misordered_(fdt, mem_rsv_size, struct_size)) {
+	if (can_assume(LIBFDT_ORDER) ||
+	    !fdt_blocks_misordered_(fdt, mem_rsv_size, struct_size)) {
 		/* no further work necessary */
 		err = fdt_move(fdt, buf, bufsize);
 		if (err)
@@ -465,7 +478,8 @@ int fdt_open_into(const void *fdt, void *buf, int bufsize)
 			return -FDT_ERR_NOSPACE;
 	}
 
-	fdt_packblocks_(fdt, tmp, mem_rsv_size, struct_size);
+	fdt_packblocks_(fdt, tmp, mem_rsv_size, struct_size,
+			fdt_size_dt_strings(fdt));
 	memmove(buf, tmp, newsize);
 
 	fdt_set_magic(buf, FDT_MAGIC);
@@ -485,7 +499,8 @@ int fdt_pack(void *fdt)
 
 	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
 		* sizeof(struct fdt_reserve_entry);
-	fdt_packblocks_(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt));
+	fdt_packblocks_(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt),
+			fdt_size_dt_strings(fdt));
 	fdt_set_totalsize(fdt, fdt_data_size_(fdt));
 
 	return 0;
diff --git a/scripts/dtc/libfdt/fdt_strerror.c b/scripts/dtc/libfdt/fdt_strerror.c
index b4356931b06..d852b77e81e 100644
--- a/scripts/dtc/libfdt/fdt_strerror.c
+++ b/scripts/dtc/libfdt/fdt_strerror.c
@@ -39,6 +39,7 @@ static struct fdt_errtabent fdt_errtable[] = {
 	FDT_ERRTABENT(FDT_ERR_BADOVERLAY),
 	FDT_ERRTABENT(FDT_ERR_NOPHANDLES),
 	FDT_ERRTABENT(FDT_ERR_BADFLAGS),
+	FDT_ERRTABENT(FDT_ERR_ALIGNMENT),
 };
 #define FDT_ERRTABSIZE	((int)(sizeof(fdt_errtable) / sizeof(fdt_errtable[0])))
 
diff --git a/scripts/dtc/libfdt/fdt_sw.c b/scripts/dtc/libfdt/fdt_sw.c
index d9e67fa2a61..4c569ee7eb0 100644
--- a/scripts/dtc/libfdt/fdt_sw.c
+++ b/scripts/dtc/libfdt/fdt_sw.c
@@ -12,7 +12,7 @@
 
 static int fdt_sw_probe_(void *fdt)
 {
-	if (fdt_chk_basic()) {
+	if (!can_assume(VALID_INPUT)) {
 		if (fdt_magic(fdt) == FDT_MAGIC)
 			return -FDT_ERR_BADSTATE;
 		else if (fdt_magic(fdt) != FDT_SW_MAGIC)
@@ -25,14 +25,14 @@ static int fdt_sw_probe_(void *fdt)
 #define FDT_SW_PROBE(fdt) \
 	{ \
 		int err; \
-		if (fdt_chk_basic() && (err = fdt_sw_probe_(fdt)) != 0) \
+		if ((err = fdt_sw_probe_(fdt)) != 0) \
 			return err; \
 	}
 
 /* 'memrsv' state:	Initial state after fdt_create()
  *
  * Allowed functions:
- *	fdt_add_reservmap_entry()
+ *	fdt_add_reservemap_entry()
  *	fdt_finish_reservemap()		[moves to 'struct' state]
  */
 static int fdt_sw_probe_memrsv_(void *fdt)
@@ -41,7 +41,7 @@ static int fdt_sw_probe_memrsv_(void *fdt)
 	if (err)
 		return err;
 
-	if (fdt_chk_extra() && fdt_off_dt_strings(fdt) != 0)
+	if (!can_assume(VALID_INPUT) && fdt_off_dt_strings(fdt) != 0)
 		return -FDT_ERR_BADSTATE;
 	return 0;
 }
@@ -49,7 +49,7 @@ static int fdt_sw_probe_memrsv_(void *fdt)
 #define FDT_SW_PROBE_MEMRSV(fdt) \
 	{ \
 		int err; \
-		if (fdt_chk_extra() && (err = fdt_sw_probe_memrsv_(fdt)) != 0) \
+		if ((err = fdt_sw_probe_memrsv_(fdt)) != 0) \
 			return err; \
 	}
 
@@ -63,15 +63,12 @@ static int fdt_sw_probe_memrsv_(void *fdt)
  */
 static int fdt_sw_probe_struct_(void *fdt)
 {
-	int err;
-
-	if (!fdt_chk_extra())
-		return 0;
-	err = fdt_sw_probe_(fdt);
+	int err = fdt_sw_probe_(fdt);
 	if (err)
 		return err;
 
-	if (fdt_off_dt_strings(fdt) != fdt_totalsize(fdt))
+	if (!can_assume(VALID_INPUT) &&
+	    fdt_off_dt_strings(fdt) != fdt_totalsize(fdt))
 		return -FDT_ERR_BADSTATE;
 	return 0;
 }
@@ -79,7 +76,7 @@ static int fdt_sw_probe_struct_(void *fdt)
 #define FDT_SW_PROBE_STRUCT(fdt) \
 	{ \
 		int err; \
-		if (fdt_chk_extra() && (err = fdt_sw_probe_struct_(fdt)) != 0) \
+		if ((err = fdt_sw_probe_struct_(fdt)) != 0) \
 			return err; \
 	}
 
@@ -161,7 +158,8 @@ int fdt_resize(void *fdt, void *buf, int bufsize)
 	headsize = fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt);
 	tailsize = fdt_size_dt_strings(fdt);
 
-	if (fdt_chk_extra() && (headsize + tailsize) > fdt_totalsize(fdt))
+	if (!can_assume(VALID_DTB) &&
+	    headsize + tailsize > fdt_totalsize(fdt))
 		return -FDT_ERR_INTERNAL;
 
 	if ((headsize + tailsize) > (unsigned)bufsize)
@@ -379,7 +377,7 @@ int fdt_finish(void *fdt)
 	fdt_set_totalsize(fdt, newstroffset + fdt_size_dt_strings(fdt));
 
 	/* And fix up fields that were keeping intermediate state. */
-	fdt_set_last_comp_version(fdt, FDT_FIRST_SUPPORTED_VERSION);
+	fdt_set_last_comp_version(fdt, FDT_LAST_COMPATIBLE_VERSION);
 	fdt_set_magic(fdt, FDT_MAGIC);
 
 	return 0;
diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
index 16ec53e78b8..7f8bb05c545 100644
--- a/scripts/dtc/libfdt/libfdt.h
+++ b/scripts/dtc/libfdt/libfdt.h
@@ -9,7 +9,12 @@
 #include "libfdt_env.h"
 #include "fdt.h"
 
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 #define FDT_FIRST_SUPPORTED_VERSION	0x02
+#define FDT_LAST_COMPATIBLE_VERSION	0x10
 #define FDT_LAST_SUPPORTED_VERSION	0x11
 
 /* Error codes: informative error codes */
@@ -97,7 +102,11 @@
 	/* FDT_ERR_BADFLAGS: The function was passed a flags field that
 	 * contains invalid flags or an invalid combination of flags. */
 
-#define FDT_ERR_MAX		18
+#define FDT_ERR_ALIGNMENT	19
+	/* FDT_ERR_ALIGNMENT: The device tree base address is not 8-byte
+	 * aligned. */
+
+#define FDT_ERR_MAX		19
 
 /* constants */
 #define FDT_MAX_PHANDLE 0xfffffffe
@@ -117,6 +126,23 @@ static inline void *fdt_offset_ptr_w(void *fdt, int offset, int checklen)
 
 uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset);
 
+/*
+ * External helpers to access words from a device tree blob. They're built
+ * to work even with unaligned pointers on platforms (such as ARMv5) that don't
+ * like unaligned loads and stores.
+ */
+static inline uint16_t fdt16_ld(const fdt16_t *p)
+{
+	const uint8_t *bp = (const uint8_t *)p;
+
+	return ((uint16_t)bp[0] << 8) | bp[1];
+}
+
+static inline uint32_t fdt32_ld(const fdt32_t *p)
+{
+	return fdt32_to_cpu(*p);
+}
+
 static inline void fdt32_st(void *property, uint32_t value)
 {
 	uint8_t *bp = (uint8_t *)property;
@@ -127,6 +153,11 @@ static inline void fdt32_st(void *property, uint32_t value)
 	bp[3] = value & 0xff;
 }
 
+static inline uint64_t fdt64_ld(const fdt64_t *p)
+{
+	return fdt64_to_cpu(*p);
+}
+
 static inline void fdt64_st(void *property, uint64_t value)
 {
 	uint8_t *bp = (uint8_t *)property;
@@ -149,23 +180,23 @@ int fdt_next_node(const void *fdt, int offset, int *depth);
 
 /**
  * fdt_first_subnode() - get offset of first direct subnode
- *
  * @fdt:	FDT blob
  * @offset:	Offset of node to check
+ *
  * Return: offset of first subnode, or -FDT_ERR_NOTFOUND if there is none
  */
 int fdt_first_subnode(const void *fdt, int offset);
 
 /**
  * fdt_next_subnode() - get offset of next direct subnode
+ * @fdt:	FDT blob
+ * @offset:	Offset of previous subnode
  *
  * After first calling fdt_first_subnode(), call this function repeatedly to
  * get direct subnodes of a parent node.
  *
- * @fdt:	FDT blob
- * @offset:	Offset of previous subnode
  * Return: offset of next subnode, or -FDT_ERR_NOTFOUND if there are no more
- * subnodes
+ *         subnodes
  */
 int fdt_next_subnode(const void *fdt, int offset);
 
@@ -190,7 +221,6 @@ int fdt_next_subnode(const void *fdt, int offset);
  * Note that this is implemented as a macro and @node is used as
  * iterator in the loop. The parent variable be constant or even a
  * literal.
- *
  */
 #define fdt_for_each_subnode(node, fdt, parent)		\
 	for (node = fdt_first_subnode(fdt, parent);	\
@@ -201,7 +231,7 @@ int fdt_next_subnode(const void *fdt, int offset);
 /* General functions                                                  */
 /**********************************************************************/
 #define fdt_get_header(fdt, field) \
-	(fdt32_to_cpu(((const struct fdt_header *)(fdt))->field))
+	(fdt32_ld(&((const struct fdt_header *)(fdt))->field))
 #define fdt_magic(fdt)			(fdt_get_header(fdt, magic))
 #define fdt_totalsize(fdt)		(fdt_get_header(fdt, totalsize))
 #define fdt_off_dt_struct(fdt)		(fdt_get_header(fdt, off_dt_struct))
@@ -219,32 +249,36 @@ int fdt_next_subnode(const void *fdt, int offset);
 		struct fdt_header *fdth = (struct fdt_header *)fdt; \
 		fdth->name = cpu_to_fdt32(val); \
 	}
-fdt_set_hdr_(magic);
-fdt_set_hdr_(totalsize);
-fdt_set_hdr_(off_dt_struct);
-fdt_set_hdr_(off_dt_strings);
-fdt_set_hdr_(off_mem_rsvmap);
-fdt_set_hdr_(version);
-fdt_set_hdr_(last_comp_version);
-fdt_set_hdr_(boot_cpuid_phys);
-fdt_set_hdr_(size_dt_strings);
-fdt_set_hdr_(size_dt_struct);
+fdt_set_hdr_(magic)
+fdt_set_hdr_(totalsize)
+fdt_set_hdr_(off_dt_struct)
+fdt_set_hdr_(off_dt_strings)
+fdt_set_hdr_(off_mem_rsvmap)
+fdt_set_hdr_(version)
+fdt_set_hdr_(last_comp_version)
+fdt_set_hdr_(boot_cpuid_phys)
+fdt_set_hdr_(size_dt_strings)
+fdt_set_hdr_(size_dt_struct)
 #undef fdt_set_hdr_
 
 /**
  * fdt_header_size - return the size of the tree's header
  * @fdt: pointer to a flattened device tree
+ *
+ * Return: size of DTB header in bytes
  */
 size_t fdt_header_size(const void *fdt);
 
 /**
- * fdt_header_size_ - internal function which takes a version number
+ * fdt_header_size_ - internal function to get header size from a version number
+ * @version: device tree version number
+ *
+ * Return: size of DTB header in bytes
  */
 size_t fdt_header_size_(uint32_t version);
 
 /**
  * fdt_check_header - sanity check a device tree header
-
  * @fdt: pointer to data which might be a flattened device tree
  *
  * fdt_check_header() checks that the given buffer contains what
@@ -369,8 +403,7 @@ static inline uint32_t fdt_get_max_phandle(const void *fdt)
  * highest phandle value in the device tree blob) will be returned in the
  * @phandle parameter.
  *
- * Returns:
- *   0 on success or a negative error-code on failure
+ * Return: 0 on success or a negative error-code on failure
  */
 int fdt_generate_phandle(const void *fdt, uint32_t *phandle);
 
@@ -390,9 +423,11 @@ int fdt_num_mem_rsv(const void *fdt);
 /**
  * fdt_get_mem_rsv - retrieve one memory reserve map entry
  * @fdt: pointer to the device tree blob
- * @address, @size: pointers to 64-bit variables
+ * @n: index of reserve map entry
+ * @address: pointer to 64-bit variable to hold the start address
+ * @size: pointer to 64-bit variable to hold the size of the entry
  *
- * On success, *address and *size will contain the address and size of
+ * On success, @address and @size will contain the address and size of
  * the n-th reserve map entry from the device tree blob, in
  * native-endian format.
  *
@@ -415,6 +450,8 @@ int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size);
  * namelen characters of name for matching the subnode name.  This is
  * useful for finding subnodes based on a portion of a larger string,
  * such as a full path.
+ *
+ * Return: offset of the subnode or -FDT_ERR_NOTFOUND if name not found.
  */
 #ifndef SWIG /* Not available in Python */
 int fdt_subnode_offset_namelen(const void *fdt, int parentoffset,
@@ -454,6 +491,8 @@ int fdt_subnode_offset(const void *fdt, int parentoffset, const char *name);
  *
  * Identical to fdt_path_offset(), but only consider the first namelen
  * characters of path as the path name.
+ *
+ * Return: offset of the node or negative libfdt error value otherwise
  */
 #ifndef SWIG /* Not available in Python */
 int fdt_path_offset_namelen(const void *fdt, const char *path, int namelen);
@@ -471,12 +510,37 @@ int fdt_path_offset_namelen(const void *fdt, const char *path, int namelen);
  * level matching the given component, differentiated only by unit
  * address).
  *
+ * If the path is not absolute (i.e. does not begin with '/'), the
+ * first component is treated as an alias.  That is, the property by
+ * that name is looked up in the /aliases node, and the value of that
+ * property used in place of that first component.
+ *
+ * For example, for this small fragment
+ *
+ * / {
+ *     aliases {
+ *         i2c2 = &foo; // RHS compiles to "/soc@0/i2c@30a40000/eeprom@52"
+ *     };
+ *     soc@0 {
+ *         foo: i2c@30a40000 {
+ *             bar: eeprom@52 {
+ *             };
+ *         };
+ *     };
+ * };
+ *
+ * these would be equivalent:
+ *
+ *   /soc@0/i2c@30a40000/eeprom@52
+ *   i2c2/eeprom@52
+ *
  * returns:
  *	structure block offset of the node with the requested path (>=0), on
  *		success
- *	-FDT_ERR_BADPATH, given path does not begin with '/' or is invalid
+ *	-FDT_ERR_BADPATH, given path does not begin with '/' and the first
+ *		component is not a valid alias
  *	-FDT_ERR_NOTFOUND, if the requested node does not exist
- *      -FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADMAGIC,
  *	-FDT_ERR_BADVERSION,
  *	-FDT_ERR_BADSTATE,
  *	-FDT_ERR_BADSTRUCTURE,
@@ -521,7 +585,7 @@ const char *fdt_get_name(const void *fdt, int nodeoffset, int *lenp);
  *	structure block offset of the property (>=0), on success
  *	-FDT_ERR_NOTFOUND, if the requested node has no properties
  *	-FDT_ERR_BADOFFSET, if nodeoffset did not point to an FDT_BEGIN_NODE tag
- *      -FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADMAGIC,
  *	-FDT_ERR_BADVERSION,
  *	-FDT_ERR_BADSTATE,
  *	-FDT_ERR_BADSTRUCTURE,
@@ -542,7 +606,7 @@ int fdt_first_property_offset(const void *fdt, int nodeoffset);
  *	structure block offset of the next property (>=0), on success
  *	-FDT_ERR_NOTFOUND, if the given property is the last in its node
  *	-FDT_ERR_BADOFFSET, if nodeoffset did not point to an FDT_PROP tag
- *      -FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADMAGIC,
  *	-FDT_ERR_BADVERSION,
  *	-FDT_ERR_BADSTATE,
  *	-FDT_ERR_BADSTRUCTURE,
@@ -553,9 +617,9 @@ int fdt_next_property_offset(const void *fdt, int offset);
 /**
  * fdt_for_each_property_offset - iterate over all properties of a node
  *
- * @property_offset:	property offset (int, lvalue)
- * @fdt:		FDT blob (const void *)
- * @node:		node offset (int)
+ * @property:	property offset (int, lvalue)
+ * @fdt:	FDT blob (const void *)
+ * @node:	node offset (int)
  *
  * This is actually a wrapper around a for loop and would be used like so:
  *
@@ -607,6 +671,13 @@ int fdt_next_property_offset(const void *fdt, int offset);
 const struct fdt_property *fdt_get_property_by_offset(const void *fdt,
 						      int offset,
 						      int *lenp);
+static inline struct fdt_property *fdt_get_property_by_offset_w(void *fdt,
+								int offset,
+								int *lenp)
+{
+	return (struct fdt_property *)(uintptr_t)
+		fdt_get_property_by_offset(fdt, offset, lenp);
+}
 
 /**
  * fdt_get_property_namelen - find a property based on substring
@@ -618,12 +689,22 @@ const struct fdt_property *fdt_get_property_by_offset(const void *fdt,
  *
  * Identical to fdt_get_property(), but only examine the first namelen
  * characters of name for matching the property name.
+ *
+ * Return: pointer to the structure representing the property, or NULL
+ *         if not found
  */
 #ifndef SWIG /* Not available in Python */
 const struct fdt_property *fdt_get_property_namelen(const void *fdt,
 						    int nodeoffset,
 						    const char *name,
 						    int namelen, int *lenp);
+static inline struct fdt_property *
+fdt_get_property_namelen_w(void *fdt, int nodeoffset, const char *name,
+			   int namelen, int *lenp)
+{
+	return (struct fdt_property *)(uintptr_t)fdt_get_property_namelen(
+		fdt, nodeoffset, name, namelen, lenp);
+}
 #endif
 
 /**
@@ -676,7 +757,7 @@ static inline struct fdt_property *fdt_get_property_w(void *fdt, int nodeoffset,
  * to within the device blob itself, not a copy of the value).  If
  * lenp is non-NULL, the length of the property value is also
  * returned, in the integer pointed to by lenp.  If namep is non-NULL,
- * the property's namne will also be returned in the char * pointed to
+ * the property's name will also be returned in the char * pointed to
  * by namep (this will be a pointer to within the device tree's string
  * block, not a new copy of the name).
  *
@@ -684,7 +765,7 @@ static inline struct fdt_property *fdt_get_property_w(void *fdt, int nodeoffset,
  *	pointer to the property's value
  *		if lenp is non-NULL, *lenp contains the length of the property
  *		value (>=0)
- *		if namep is non-NULL *namep contiains a pointer to the property
+ *		if namep is non-NULL *namep contains a pointer to the property
  *		name.
  *	NULL, on error
  *		if lenp is non-NULL, *lenp contains an error code (<0):
@@ -710,6 +791,8 @@ const void *fdt_getprop_by_offset(const void *fdt, int offset,
  *
  * Identical to fdt_getprop(), but only examine the first namelen
  * characters of name for matching the property name.
+ *
+ * Return: pointer to the property's value or NULL on error
  */
 #ifndef SWIG /* Not available in Python */
 const void *fdt_getprop_namelen(const void *fdt, int nodeoffset,
@@ -731,10 +814,10 @@ static inline void *fdt_getprop_namelen_w(void *fdt, int nodeoffset,
  * @lenp: pointer to an integer variable (will be overwritten) or NULL
  *
  * fdt_getprop() retrieves a pointer to the value of the property
- * named 'name' of the node at offset nodeoffset (this will be a
+ * named @name of the node at offset @nodeoffset (this will be a
  * pointer to within the device blob itself, not a copy of the value).
- * If lenp is non-NULL, the length of the property value is also
- * returned, in the integer pointed to by lenp.
+ * If @lenp is non-NULL, the length of the property value is also
+ * returned, in the integer pointed to by @lenp.
  *
  * returns:
  *	pointer to the property's value
@@ -776,11 +859,14 @@ uint32_t fdt_get_phandle(const void *fdt, int nodeoffset);
 /**
  * fdt_get_alias_namelen - get alias based on substring
  * @fdt: pointer to the device tree blob
- * @name: name of the alias th look up
+ * @name: name of the alias to look up
  * @namelen: number of characters of name to consider
  *
- * Identical to fdt_get_alias(), but only examine the first namelen
- * characters of name for matching the alias name.
+ * Identical to fdt_get_alias(), but only examine the first @namelen
+ * characters of @name for matching the alias name.
+ *
+ * Return: a pointer to the expansion of the alias named @name, if it exists,
+ *	   NULL otherwise
  */
 #ifndef SWIG /* Not available in Python */
 const char *fdt_get_alias_namelen(const void *fdt,
@@ -790,10 +876,10 @@ const char *fdt_get_alias_namelen(const void *fdt,
 /**
  * fdt_get_alias - retrieve the path referenced by a given alias
  * @fdt: pointer to the device tree blob
- * @name: name of the alias th look up
+ * @name: name of the alias to look up
  *
  * fdt_get_alias() retrieves the value of a given alias.  That is, the
- * value of the property named 'name' in the node /aliases.
+ * value of the property named @name in the node /aliases.
  *
  * returns:
  *	a pointer to the expansion of the alias named 'name', if it exists
@@ -801,6 +887,42 @@ const char *fdt_get_alias_namelen(const void *fdt,
  */
 const char *fdt_get_alias(const void *fdt, const char *name);
 
+/**
+ * fdt_get_symbol_namelen - get symbol based on substring
+ * @fdt: pointer to the device tree blob
+ * @name: name of the symbol to look up
+ * @namelen: number of characters of name to consider
+ *
+ * Identical to fdt_get_symbol(), but only examine the first @namelen
+ * characters of @name for matching the symbol name.
+ *
+ * Return: a pointer to the expansion of the symbol named @name, if it exists,
+ *	   NULL otherwise
+ */
+#ifndef SWIG /* Not available in Python */
+const char *fdt_get_symbol_namelen(const void *fdt,
+				   const char *name, int namelen);
+#endif
+
+/**
+ * fdt_get_symbol - retrieve the path referenced by a given symbol
+ * @fdt: pointer to the device tree blob
+ * @name: name of the symbol to look up
+ *
+ * fdt_get_symbol() retrieves the value of a given symbol.  That is,
+ * the value of the property named @name in the node
+ * /__symbols__. Such a node exists only for a device tree blob that
+ * has been compiled with the -@ dtc option. Each property corresponds
+ * to a label appearing in the device tree source, with the name of
+ * the property being the label and the value being the full path of
+ * the node it is attached to.
+ *
+ * returns:
+ *	a pointer to the expansion of the symbol named 'name', if it exists
+ *	NULL, if the given symbol or the /__symbols__ node does not exist
+ */
+const char *fdt_get_symbol(const void *fdt, const char *name);
+
 /**
  * fdt_get_path - determine the full path of a node
  * @fdt: pointer to the device tree blob
@@ -969,14 +1091,13 @@ int fdt_node_offset_by_prop_value(const void *fdt, int startoffset,
 int fdt_node_offset_by_phandle(const void *fdt, uint32_t phandle);
 
 /**
- * fdt_node_check_compatible: check a node's compatible property
+ * fdt_node_check_compatible - check a node's compatible property
  * @fdt: pointer to the device tree blob
  * @nodeoffset: offset of a tree node
  * @compatible: string to match against
  *
- *
  * fdt_node_check_compatible() returns 0 if the given node contains a
- * 'compatible' property with the given string as one of its elements,
+ * @compatible property with the given string as one of its elements,
  * it returns non-zero otherwise, or on error.
  *
  * returns:
@@ -1040,7 +1161,7 @@ int fdt_node_offset_by_compatible(const void *fdt, int startoffset,
  * one or more strings, each terminated by \0, as is found in a device tree
  * "compatible" property.
  *
- * @return: 1 if the string is found in the list, 0 not found, or invalid list
+ * Return: 1 if the string is found in the list, 0 not found, or invalid list
  */
 int fdt_stringlist_contains(const char *strlist, int listlen, const char *str);
 
@@ -1049,7 +1170,8 @@ int fdt_stringlist_contains(const char *strlist, int listlen, const char *str);
  * @fdt: pointer to the device tree blob
  * @nodeoffset: offset of a tree node
  * @property: name of the property containing the string list
- * @return:
+ *
+ * Return:
  *   the number of strings in the given property
  *   -FDT_ERR_BADVALUE if the property value is not NUL-terminated
  *   -FDT_ERR_NOTFOUND if the property does not exist
@@ -1069,7 +1191,7 @@ int fdt_stringlist_count(const void *fdt, int nodeoffset, const char *property);
  * small-valued cell properties, such as #address-cells, when searching for
  * the empty string.
  *
- * @return:
+ * return:
  *   the index of the string in the list of strings
  *   -FDT_ERR_BADVALUE if the property value is not NUL-terminated
  *   -FDT_ERR_NOTFOUND if the property does not exist or does not contain
@@ -1093,7 +1215,7 @@ int fdt_stringlist_search(const void *fdt, int nodeoffset, const char *property,
  * If non-NULL, the length of the string (on success) or a negative error-code
  * (on failure) will be stored in the integer pointer to by lenp.
  *
- * @return:
+ * Return:
  *   A pointer to the string at the given index in the string list or NULL on
  *   failure. On success the length of the string will be stored in the memory
  *   location pointed to by the lenp parameter, if non-NULL. On failure one of
@@ -1130,8 +1252,8 @@ const char *fdt_stringlist_get(const void *fdt, int nodeoffset,
  *
  * returns:
  *	0 <= n < FDT_MAX_NCELLS, on success
- *      2, if the node has no #address-cells property
- *      -FDT_ERR_BADNCELLS, if the node has a badly formatted or invalid
+ *	2, if the node has no #address-cells property
+ *	-FDT_ERR_BADNCELLS, if the node has a badly formatted or invalid
  *		#address-cells property
  *	-FDT_ERR_BADMAGIC,
  *	-FDT_ERR_BADVERSION,
@@ -1151,8 +1273,8 @@ int fdt_address_cells(const void *fdt, int nodeoffset);
  *
  * returns:
  *	0 <= n < FDT_MAX_NCELLS, on success
- *      1, if the node has no #size-cells property
- *      -FDT_ERR_BADNCELLS, if the node has a badly formatted or invalid
+ *	1, if the node has no #size-cells property
+ *	-FDT_ERR_BADNCELLS, if the node has a badly formatted or invalid
  *		#size-cells property
  *	-FDT_ERR_BADMAGIC,
  *	-FDT_ERR_BADVERSION,
@@ -1181,6 +1303,8 @@ int fdt_size_cells(const void *fdt, int nodeoffset);
  * starting from the given index, and using only the first characters
  * of the name. It is useful when you want to manipulate only one value of
  * an array and you have a string that doesn't end with \0.
+ *
+ * Return: 0 on success, negative libfdt error value otherwise
  */
 #ifndef SWIG /* Not available in Python */
 int fdt_setprop_inplace_namelen_partial(void *fdt, int nodeoffset,
@@ -1294,8 +1418,13 @@ static inline int fdt_setprop_inplace_u64(void *fdt, int nodeoffset,
 
 /**
  * fdt_setprop_inplace_cell - change the value of a single-cell property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node containing the property
+ * @name: name of the property to change the value of
+ * @val: new value of the 32-bit cell
  *
  * This is an alternative name for fdt_setprop_inplace_u32()
+ * Return: 0 on success, negative libfdt error number otherwise.
  */
 static inline int fdt_setprop_inplace_cell(void *fdt, int nodeoffset,
 					   const char *name, uint32_t val)
@@ -1367,14 +1496,14 @@ int fdt_nop_node(void *fdt, int nodeoffset);
 
 /**
  * fdt_create_with_flags - begin creation of a new fdt
- * @fdt: pointer to memory allocated where fdt will be created
+ * @buf: pointer to memory allocated where fdt will be created
  * @bufsize: size of the memory space at fdt
  * @flags: a valid combination of FDT_CREATE_FLAG_ flags, or 0.
  *
  * fdt_create_with_flags() begins the process of creating a new fdt with
  * the sequential write interface.
  *
- * fdt creation process must end with fdt_finished() to produce a valid fdt.
+ * fdt creation process must end with fdt_finish() to produce a valid fdt.
  *
  * returns:
  *	0, on success
@@ -1385,7 +1514,7 @@ int fdt_create_with_flags(void *buf, int bufsize, uint32_t flags);
 
 /**
  * fdt_create - begin creation of a new fdt
- * @fdt: pointer to memory allocated where fdt will be created
+ * @buf: pointer to memory allocated where fdt will be created
  * @bufsize: size of the memory space at fdt
  *
  * fdt_create() is equivalent to fdt_create_with_flags() with flags=0.
@@ -1425,7 +1554,7 @@ static inline int fdt_property_cell(void *fdt, const char *name, uint32_t val)
  * @fdt: pointer to the device tree blob
  * @name: name of property to add
  * @len: length of property value in bytes
- * @valp: returns a pointer to where where the value should be placed
+ * @valp: returns a pointer to where the value should be placed
  *
  * returns:
  *	0, on success
@@ -1450,7 +1579,8 @@ int fdt_pack(void *fdt);
 /**
  * fdt_add_mem_rsv - add one memory reserve map entry
  * @fdt: pointer to the device tree blob
- * @address, @size: 64-bit values (native endian)
+ * @address: 64-bit start address of the reserve map entry
+ * @size: 64-bit size of the reserved region
  *
  * Adds a reserve map entry to the given blob reserving a region at
  * address address of length size.
@@ -1521,6 +1651,38 @@ int fdt_del_mem_rsv(void *fdt, int n);
  */
 int fdt_set_name(void *fdt, int nodeoffset, const char *name);
 
+/**
+ * fdt_setprop_namelen - create or change a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @namelen: length of the name
+ * @val: pointer to data to set the property value to
+ * @len: length of the property value
+ *
+ * fdt_setprop_namelen() sets the value of the named property in the given
+ * node to the given value and length, creating the property if it
+ * does not already exist.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_setprop_namelen(void *fdt, int nodeoffset, const char *name,
+			int namelen, const void *val, int len);
+
 /**
  * fdt_setprop - create or change a property
  * @fdt: pointer to the device tree blob
@@ -1549,8 +1711,44 @@ int fdt_set_name(void *fdt, int nodeoffset, const char *name);
  *	-FDT_ERR_BADLAYOUT,
  *	-FDT_ERR_TRUNCATED, standard meanings
  */
-int fdt_setprop(void *fdt, int nodeoffset, const char *name,
-		const void *val, int len);
+static inline int fdt_setprop(void *fdt, int nodeoffset, const char *name,
+			      const void *val, int len)
+{
+	return fdt_setprop_namelen(fdt, nodeoffset, name, strlen(name), val,
+				   len);
+}
+
+/**
+ * fdt_setprop_placeholder_namelen - allocate space for a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @namelen: length of the name
+ * @len: length of the property value
+ * @prop_data: return pointer to property data
+ *
+ * fdt_setprop_placeholder_namelen() allocates the named property in the given node.
+ * If the property exists it is resized. In either case a pointer to the
+ * property data is returned.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_setprop_placeholder_namelen(void *fdt, int nodeoffset, const char *name,
+				    int namelen, int len, void **prop_data);
 
 /**
  * fdt_setprop_placeholder - allocate space for a property
@@ -1560,7 +1758,7 @@ int fdt_setprop(void *fdt, int nodeoffset, const char *name,
  * @len: length of the property value
  * @prop_data: return pointer to property data
  *
- * fdt_setprop_placeholer() allocates the named property in the given node.
+ * fdt_setprop_placeholder() allocates the named property in the given node.
  * If the property exists it is resized. In either case a pointer to the
  * property data is returned.
  *
@@ -1580,8 +1778,13 @@ int fdt_setprop(void *fdt, int nodeoffset, const char *name,
  *	-FDT_ERR_BADLAYOUT,
  *	-FDT_ERR_TRUNCATED, standard meanings
  */
-int fdt_setprop_placeholder(void *fdt, int nodeoffset, const char *name,
-			    int len, void **prop_data);
+static inline int fdt_setprop_placeholder(void *fdt, int nodeoffset,
+					  const char *name, int len,
+					  void **prop_data)
+{
+	return fdt_setprop_placeholder_namelen(fdt, nodeoffset, name,
+					       strlen(name), len, prop_data);
+}
 
 /**
  * fdt_setprop_u32 - set a property to a 32-bit integer
@@ -1655,8 +1858,14 @@ static inline int fdt_setprop_u64(void *fdt, int nodeoffset, const char *name,
 
 /**
  * fdt_setprop_cell - set a property to a single cell value
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: 32-bit integer value for the property (native endian)
  *
  * This is an alternative name for fdt_setprop_u32()
+ *
+ * Return: 0 on success, negative libfdt error value otherwise.
  */
 static inline int fdt_setprop_cell(void *fdt, int nodeoffset, const char *name,
 				   uint32_t val)
@@ -1695,6 +1904,39 @@ static inline int fdt_setprop_cell(void *fdt, int nodeoffset, const char *name,
 #define fdt_setprop_string(fdt, nodeoffset, name, str) \
 	fdt_setprop((fdt), (nodeoffset), (name), (str), strlen(str)+1)
 
+/**
+ * fdt_setprop_namelen_string - set a property to a string value
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @namelen: number of characters of name to consider
+ * @str: string value for the property
+ *
+ * fdt_setprop_namelen_string() sets the value of the named property in the
+ * given node to the given string value (using the length of the
+ * string to determine the new length of the property), or creates a
+ * new property with that value if it does not already exist.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+#define fdt_setprop_namelen_string(fdt, nodeoffset, name, namelen, str)    \
+	fdt_setprop_namelen((fdt), (nodeoffset), (name), (namelen), (str), \
+			    strlen(str) + 1)
+
 /**
  * fdt_setprop_empty - set a property to an empty value
  * @fdt: pointer to the device tree blob
@@ -1826,8 +2068,14 @@ static inline int fdt_appendprop_u64(void *fdt, int nodeoffset,
 
 /**
  * fdt_appendprop_cell - append a single cell value to a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: 32-bit integer value to append to the property (native endian)
  *
  * This is an alternative name for fdt_appendprop_u32()
+ *
+ * Return: 0 on success, negative libfdt error value otherwise.
  */
 static inline int fdt_appendprop_cell(void *fdt, int nodeoffset,
 				      const char *name, uint32_t val)
@@ -1878,7 +2126,7 @@ static inline int fdt_appendprop_cell(void *fdt, int nodeoffset,
  * address and size) to the value of the named property in the given
  * node, or creates a new property with that value if it does not
  * already exist.
- * If "name" is not specified, a default "reg" is used.
+ *
  * Cell sizes are determined by parent's #address-cells and #size-cells.
  *
  * This function may insert data into the blob, and will therefore
@@ -1908,7 +2156,7 @@ int fdt_appendprop_addrrange(void *fdt, int parent, int nodeoffset,
  * @nodeoffset: offset of the node whose property to nop
  * @name: name of the property to nop
  *
- * fdt_del_property() will delete the given property.
+ * fdt_delprop() will delete the given property.
  *
  * This function will delete data from the blob, and will therefore
  * change the offsets of some existing nodes.
@@ -1930,13 +2178,16 @@ int fdt_delprop(void *fdt, int nodeoffset, const char *name);
  * fdt_add_subnode_namelen - creates a new node based on substring
  * @fdt: pointer to the device tree blob
  * @parentoffset: structure block offset of a node
- * @name: name of the subnode to locate
+ * @name: name of the subnode to create
  * @namelen: number of characters of name to consider
  *
- * Identical to fdt_add_subnode(), but use only the first namelen
- * characters of name as the name of the new node.  This is useful for
+ * Identical to fdt_add_subnode(), but use only the first @namelen
+ * characters of @name as the name of the new node.  This is useful for
  * creating subnodes based on a portion of a larger string, such as a
  * full path.
+ *
+ * Return: structure block offset of the created subnode (>=0),
+ *	   negative libfdt error value otherwise
  */
 #ifndef SWIG /* Not available in Python */
 int fdt_add_subnode_namelen(void *fdt, int parentoffset,
@@ -1955,10 +2206,9 @@ int fdt_add_subnode_namelen(void *fdt, int parentoffset,
  *
  * This function will insert data into the blob, and will therefore
  * change the offsets of some existing nodes.
-
+ *
  * returns:
- *	structure block offset of the created nodeequested subnode (>=0), on
- *		success
+ *	structure block offset of the created subnode (>=0), on success
  *	-FDT_ERR_NOTFOUND, if the requested subnode does not exist
  *	-FDT_ERR_BADOFFSET, if parentoffset did not point to an FDT_BEGIN_NODE
  *		tag
@@ -1968,7 +2218,7 @@ int fdt_add_subnode_namelen(void *fdt, int parentoffset,
  *		blob to contain the new node
  *	-FDT_ERR_NOSPACE
  *	-FDT_ERR_BADLAYOUT
- *      -FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADMAGIC,
  *	-FDT_ERR_BADVERSION,
  *	-FDT_ERR_BADSTATE,
  *	-FDT_ERR_BADSTRUCTURE,
@@ -2013,7 +2263,7 @@ int fdt_del_node(void *fdt, int nodeoffset);
  * returns:
  *	0, on success
  *	-FDT_ERR_NOSPACE, there's not enough space in the base device tree
- *	-FDT_ERR_NOTFOUND, the overlay points to some inexistant nodes or
+ *	-FDT_ERR_NOTFOUND, the overlay points to some nonexistent nodes or
  *		properties in the base DT
  *	-FDT_ERR_BADPHANDLE,
  *	-FDT_ERR_BADOVERLAY,
@@ -2030,6 +2280,24 @@ int fdt_del_node(void *fdt, int nodeoffset);
  */
 int fdt_overlay_apply(void *fdt, void *fdto);
 
+/**
+ * fdt_overlay_target_offset - retrieves the offset of a fragment's target
+ * @fdt: Base device tree blob
+ * @fdto: Device tree overlay blob
+ * @fragment_offset: node offset of the fragment in the overlay
+ * @pathp: pointer which receives the path of the target (or NULL)
+ *
+ * fdt_overlay_target_offset() retrieves the target offset in the base
+ * device tree of a fragment, no matter how the actual targeting is
+ * done (through a phandle or a path)
+ *
+ * returns:
+ *      the targeted node offset in the base device tree
+ *      Negative error code on error
+ */
+int fdt_overlay_target_offset(const void *fdt, const void *fdto,
+			      int fragment_offset, char const **pathp);
+
 /**
  * fdt_overlay_apply_node - Merges a node into the base device tree
  *
@@ -2043,4 +2311,8 @@ int fdt_overlay_apply_node(void *fdt, int target, void *fdto, int node);
 
 const char *fdt_strerror(int errval);
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif /* LIBFDT_H */
diff --git a/scripts/dtc/libfdt/libfdt_internal.h b/scripts/dtc/libfdt/libfdt_internal.h
index 5436e2ceeac..b60b5456f59 100644
--- a/scripts/dtc/libfdt/libfdt_internal.h
+++ b/scripts/dtc/libfdt/libfdt_internal.h
@@ -10,20 +10,25 @@
 #define FDT_ALIGN(x, a)		(((x) + (a) - 1) & ~((a) - 1))
 #define FDT_TAGALIGN(x)		(FDT_ALIGN((x), FDT_TAGSIZE))
 
-int fdt_ro_probe_(const void *fdt);
+int32_t fdt_ro_probe_(const void *fdt);
 #define FDT_RO_PROBE(fdt)					\
 	{							\
-		int totalsize_;					\
-		if (fdt_chk_basic()) {				\
-			totalsize_ = fdt_ro_probe_(fdt);	\
-			if (totalsize_ < 0)			\
-				return totalsize_;		\
-		}						\
+		int32_t totalsize_;				\
+		if ((totalsize_ = fdt_ro_probe_(fdt)) < 0)	\
+			return totalsize_;			\
 	}
 
 int fdt_check_node_offset_(const void *fdt, int offset);
 int fdt_check_prop_offset_(const void *fdt, int offset);
-const char *fdt_find_string_(const char *strtab, int tabsize, const char *s);
+
+const char *fdt_find_string_len_(const char *strtab, int tabsize, const char *s,
+				 int s_len);
+static inline const char *fdt_find_string_(const char *strtab, int tabsize,
+					   const char *s)
+{
+	return fdt_find_string_len_(strtab, tabsize, s, strlen(s));
+}
+
 int fdt_node_end_offset_(void *fdt, int nodeoffset);
 
 static inline const void *fdt_offset_ptr_(const void *fdt, int offset)
@@ -49,6 +54,25 @@ static inline struct fdt_reserve_entry *fdt_mem_rsv_w_(void *fdt, int n)
 	return (void *)(uintptr_t)fdt_mem_rsv_(fdt, n);
 }
 
+/*
+ * Internal helpers to access structural elements of the device tree
+ * blob (rather than for example reading integers from within property
+ * values).  We assume that we are either given a naturally aligned
+ * address for the platform or if we are not, we are on a platform
+ * where unaligned memory reads will be handled in a graceful manner.
+ * If not the external helpers fdtXX_ld() from libfdt.h can be used
+ * instead.
+ */
+static inline uint32_t fdt32_ld_(const fdt32_t *p)
+{
+	return fdt32_to_cpu(*p);
+}
+
+static inline uint64_t fdt64_ld_(const fdt64_t *p)
+{
+	return fdt64_to_cpu(*p);
+}
+
 #define FDT_SW_MAGIC		(~FDT_MAGIC)
 
 /**********************************************************************/
@@ -61,20 +85,21 @@ static inline struct fdt_reserve_entry *fdt_mem_rsv_w_(void *fdt, int n)
 
 /*
  * Defines assumptions which can be enabled. Each of these can be enabled
- * individually. For maximum saftey, don't enable any assumptions!
+ * individually. For maximum safety, don't enable any assumptions!
  *
- * For minimal code size and no safety, use FDT_ASSUME_PERFECT at your own risk.
+ * For minimal code size and no safety, use ASSUME_PERFECT at your own risk.
  * You should have another method of validating the device tree, such as a
  * signature or hash check before using libfdt.
  *
  * For situations where security is not a concern it may be safe to enable
- * FDT_ASSUME_FRIENDLY.
+ * ASSUME_SANE.
  */
 enum {
 	/*
 	 * This does essentially no checks. Only the latest device-tree
-	 * version is correctly handled. Incosistencies or errors in the device
-	 * tree may cause undefined behaviour or crashes.
+	 * version is correctly handled. Inconsistencies or errors in the device
+	 * tree may cause undefined behaviour or crashes. Invalid parameters
+	 * passed to libfdt may do the same.
 	 *
 	 * If an error occurs when modifying the tree it may leave the tree in
 	 * an intermediate (but valid) state. As an example, adding a property
@@ -85,17 +110,35 @@ enum {
 	 * Only use this if you have a fully validated device tree with
 	 * the latest supported version and wish to minimise code size.
 	 */
-	FDT_ASSUME_PERFECT	= 0xff,
+	ASSUME_PERFECT		= 0xff,
 
 	/*
 	 * This assumes that the device tree is sane. i.e. header metadata
 	 * and basic hierarchy are correct.
 	 *
-	 * These checks will be sufficient if you have a valid device tree with
-	 * no internal inconsistencies. With this assumption, libfdt will
-	 * generally not return -FDT_ERR_INTERNAL, -FDT_ERR_BADLAYOUT, etc.
+	 * With this assumption enabled, normal device trees produced by libfdt
+	 * and the compiler should be handled safely. Malicious device trees and
+	 * complete garbage may cause libfdt to behave badly or crash. Truncated
+	 * device trees (e.g. those only partially loaded) can also cause
+	 * problems.
+	 *
+	 * Note: Only checks that relate exclusively to the device tree itself
+	 * (not the parameters passed to libfdt) are disabled by this
+	 * assumption. This includes checking headers, tags and the like.
+	 */
+	ASSUME_VALID_DTB	= 1 << 0,
+
+	/*
+	 * This builds on ASSUME_VALID_DTB and further assumes that libfdt
+	 * functions are called with valid parameters, i.e. not trigger
+	 * FDT_ERR_BADOFFSET or offsets that are out of bounds. It disables any
+	 * extensive checking of parameters and the device tree, making various
+	 * assumptions about correctness.
+	 *
+	 * It doesn't make sense to enable this assumption unless
+	 * ASSUME_VALID_DTB is also enabled.
 	 */
-	FDT_ASSUME_SANE		= 1 << 0,
+	ASSUME_VALID_INPUT	= 1 << 1,
 
 	/*
 	 * This disables checks for device-tree version and removes all code
@@ -104,34 +147,54 @@ enum {
 	 * Only enable this if you know you have a device tree with the latest
 	 * version.
 	 */
-	FDT_ASSUME_LATEST	= 1 << 1,
+	ASSUME_LATEST		= 1 << 2,
 
 	/*
-	 * This disables any extensive checking of parameters and the device
-	 * tree, making various assumptions about correctness. Normal device
-	 * trees produced by libfdt and the compiler should be handled safely.
-	 * Malicious device trees and complete garbage may cause libfdt to
-	 * behave badly or crash.
+	 * This assumes that it is OK for a failed addition to the device tree,
+	 * due to lack of space or some other problem, to skip any rollback
+	 * steps (such as dropping the property name from the string table).
+	 * This is safe to enable in most circumstances, even though it may
+	 * leave the tree in a sub-optimal state.
 	 */
-	FDT_ASSUME_FRIENDLY	= 1 << 2,
-};
+	ASSUME_NO_ROLLBACK	= 1 << 3,
 
-/** fdt_chk_basic() - see if basic checking of params and DT data is enabled */
-static inline bool fdt_chk_basic(void)
-{
-	return !(FDT_ASSUME_MASK & FDT_ASSUME_SANE);
-}
+	/*
+	 * This assumes that the device tree components appear in a 'convenient'
+	 * order, i.e. the memory reservation block first, then the structure
+	 * block and finally the string block.
+	 *
+	 * This order is not specified by the device-tree specification,
+	 * but is expected by libfdt. The device-tree compiler always created
+	 * device trees with this order.
+	 *
+	 * This assumption disables a check in fdt_open_into() and removes the
+	 * ability to fix the problem there. This is safe if you know that the
+	 * device tree is correctly ordered. See fdt_blocks_misordered_().
+	 */
+	ASSUME_LIBFDT_ORDER	= 1 << 4,
 
-/** fdt_chk_version() - see if we need to handle old versions of the DT */
-static inline bool fdt_chk_version(void)
-{
-	return !(FDT_ASSUME_MASK & FDT_ASSUME_LATEST);
-}
+	/*
+	 * This assumes that libfdt itself does not have any internal bugs. It
+	 * drops certain checks that should never be needed unless libfdt has an
+	 * undiscovered bug.
+	 *
+	 * This can generally be considered safe to enable.
+	 */
+	ASSUME_LIBFDT_FLAWLESS	= 1 << 5,
+};
 
-/** fdt_chk_extra() - see if extra checking is enabled */
-static inline bool fdt_chk_extra(void)
+/**
+ * can_assume_() - check if a particular assumption is enabled
+ *
+ * @mask: Mask to check (ASSUME_...)
+ * @return true if that assumption is enabled, else false
+ */
+static inline bool can_assume_(int mask)
 {
-	return !(FDT_ASSUME_MASK & FDT_ASSUME_FRIENDLY);
+	return FDT_ASSUME_MASK & mask;
 }
 
+/** helper macros for checking assumptions */
+#define can_assume(_assume)	can_assume_(ASSUME_ ## _assume)
+
 #endif /* LIBFDT_INTERNAL_H */
diff --git a/scripts/dtc/livetree.c b/scripts/dtc/livetree.c
index 4cfc2adccdd..1e121d41a89 100644
--- a/scripts/dtc/livetree.c
+++ b/scripts/dtc/livetree.c
@@ -1,24 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include "dtc.h"
+#include "srcpos.h"
 
 /*
  * Tree building functions
@@ -50,25 +36,27 @@ void delete_labels(struct label **labels)
 		label->deleted = 1;
 }
 
-struct property *build_property(char *name, struct data val)
+struct property *build_property(const char *name, struct data val,
+				struct srcpos *srcpos)
 {
 	struct property *new = xmalloc(sizeof(*new));
 
 	memset(new, 0, sizeof(*new));
 
-	new->name = name;
+	new->name = xstrdup(name);
 	new->val = val;
+	new->srcpos = srcpos_copy(srcpos);
 
 	return new;
 }
 
-struct property *build_property_delete(char *name)
+struct property *build_property_delete(const char *name)
 {
 	struct property *new = xmalloc(sizeof(*new));
 
 	memset(new, 0, sizeof(*new));
 
-	new->name = name;
+	new->name = xstrdup(name);
 	new->deleted = 1;
 
 	return new;
@@ -97,7 +85,8 @@ struct property *reverse_properties(struct property *first)
 	return head;
 }
 
-struct node *build_node(struct property *proplist, struct node *children)
+struct node *build_node(struct property *proplist, struct node *children,
+			struct srcpos *srcpos)
 {
 	struct node *new = xmalloc(sizeof(*new));
 	struct node *child;
@@ -106,6 +95,7 @@ struct node *build_node(struct property *proplist, struct node *children)
 
 	new->proplist = reverse_properties(proplist);
 	new->children = children;
+	new->srcpos = srcpos_copy(srcpos);
 
 	for_each_child(new, child) {
 		child->parent = new;
@@ -114,22 +104,23 @@ struct node *build_node(struct property *proplist, struct node *children)
 	return new;
 }
 
-struct node *build_node_delete(void)
+struct node *build_node_delete(struct srcpos *srcpos)
 {
 	struct node *new = xmalloc(sizeof(*new));
 
 	memset(new, 0, sizeof(*new));
 
 	new->deleted = 1;
+	new->srcpos = srcpos_copy(srcpos);
 
 	return new;
 }
 
-struct node *name_node(struct node *node, char *name)
+struct node *name_node(struct node *node, const char *name)
 {
 	assert(node->name == NULL);
 
-	node->name = name;
+	node->name = xstrdup(name);
 
 	return node;
 }
@@ -183,6 +174,8 @@ struct node *merge_nodes(struct node *old_node, struct node *new_node)
 
 				old_prop->val = new_prop->val;
 				old_prop->deleted = 0;
+				srcpos_free(old_prop->srcpos);
+				old_prop->srcpos = new_prop->srcpos;
 				free(new_prop);
 				new_prop = NULL;
 				break;
@@ -223,6 +216,8 @@ struct node *merge_nodes(struct node *old_node, struct node *new_node)
 			add_child(old_node, new_child);
 	}
 
+	old_node->srcpos = srcpos_extend(old_node->srcpos, new_node->srcpos);
+
 	/* The new node contents are now merged into the old node.  Free
 	 * the new node. */
 	free(new_node);
@@ -239,21 +234,23 @@ struct node * add_orphan_node(struct node *dt, struct node *new_node, char *ref)
 	char *name;
 
 	if (ref[0] == '/') {
+		d = data_add_marker(d, TYPE_STRING, ref);
 		d = data_append_data(d, ref, strlen(ref) + 1);
 
-		p = build_property("target-path", d);
+		p = build_property("target-path", d, NULL);
 	} else {
 		d = data_add_marker(d, REF_PHANDLE, ref);
 		d = data_append_integer(d, 0xffffffff, 32);
 
-		p = build_property("target", d);
+		p = build_property("target", d, NULL);
 	}
 
 	xasprintf(&name, "fragment@%u",
 			next_orphan_fragment++);
 	name_node(new_node, "__overlay__");
-	node = build_node(p, new_node);
+	node = build_node(p, new_node, NULL);
 	name_node(node, name);
+	free(name);
 
 	add_child(dt, node);
 	return dt;
@@ -340,18 +337,21 @@ void delete_node(struct node *node)
 }
 
 void append_to_property(struct node *node,
-				    char *name, const void *data, int len)
+			char *name, const void *data, int len,
+			enum markertype type)
 {
 	struct data d;
 	struct property *p;
 
 	p = get_property(node, name);
 	if (p) {
-		d = data_append_data(p->val, data, len);
+		d = data_add_marker(p->val, type, name);
+		d = data_append_data(d, data, len);
 		p->val = d;
 	} else {
-		d = data_append_data(empty_data, data, len);
-		p = build_property(name, d);
+		d = data_add_marker(empty_data, type, name);
+		d = data_append_data(d, data, len);
+		p = build_property(name, d, NULL);
 		add_property(node, p);
 	}
 }
@@ -439,9 +439,9 @@ cell_t propval_cell(struct property *prop)
 	return fdt32_to_cpu(*((fdt32_t *)prop->val.val));
 }
 
-cell_t propval_cell_n(struct property *prop, int n)
+cell_t propval_cell_n(struct property *prop, unsigned int n)
 {
-	assert(prop->val.len / sizeof(cell_t) >= n);
+	assert(prop->val.len / sizeof(cell_t) > n);
 	return fdt32_to_cpu(*((fdt32_t *)prop->val.val + n));
 }
 
@@ -504,7 +504,7 @@ struct node *get_subnode(struct node *node, const char *nodename)
 	struct node *child;
 
 	for_each_child(node, child)
-		if (streq(child->name, nodename))
+		if (streq(child->name, nodename) && !child->deleted)
 			return child;
 
 	return NULL;
@@ -527,8 +527,7 @@ struct node *get_node_by_path(struct node *tree, const char *path)
 	p = strchr(path, '/');
 
 	for_each_child(tree, child) {
-		if (p && (strlen(child->name) == p-path) &&
-		    strprefixeq(path, p - path, child->name))
+		if (p && strprefixeq(path, (size_t)(p - path), child->name))
 			return get_node_by_path(child, p+1);
 		else if (!p && streq(path, child->name))
 			return child;
@@ -561,7 +560,7 @@ struct node *get_node_by_phandle(struct node *tree, cell_t phandle)
 {
 	struct node *child, *node;
 
-	if ((phandle == 0) || (phandle == -1)) {
+	if (!phandle_is_valid(phandle)) {
 		assert(generate_fixups);
 		return NULL;
 	}
@@ -618,11 +617,27 @@ struct node *get_node_by_ref(struct node *tree, const char *ref)
 	return target;
 }
 
+static void add_phandle_property(struct node *node,
+				 const char *name, int format)
+{
+	struct data d;
+
+	if (!(phandle_format & format))
+		return;
+	if (get_property(node, name))
+		return;
+
+	d = data_add_marker(empty_data, TYPE_UINT32, NULL);
+	d = data_append_cell(d, node->phandle);
+
+	add_property(node, build_property(name, d, NULL));
+}
+
 cell_t get_node_phandle(struct node *root, struct node *node)
 {
 	static cell_t phandle = 1; /* FIXME: ick, static local */
 
-	if ((node->phandle != 0) && (node->phandle != -1))
+	if (phandle_is_valid(node->phandle))
 		return node->phandle;
 
 	while (get_node_by_phandle(root, phandle))
@@ -630,17 +645,8 @@ cell_t get_node_phandle(struct node *root, struct node *node)
 
 	node->phandle = phandle;
 
-	if (!get_property(node, "linux,phandle")
-	    && (phandle_format & PHANDLE_LEGACY))
-		add_property(node,
-			     build_property("linux,phandle",
-					    data_append_cell(empty_data, phandle)));
-
-	if (!get_property(node, "phandle")
-	    && (phandle_format & PHANDLE_EPAPR))
-		add_property(node,
-			     build_property("phandle",
-					    data_append_cell(empty_data, phandle)));
+	add_phandle_property(node, "linux,phandle", PHANDLE_LEGACY);
+	add_phandle_property(node, "phandle", PHANDLE_EPAPR);
 
 	/* If the node *does* have a phandle property, we must
 	 * be dealing with a self-referencing phandle, which will be
@@ -809,18 +815,18 @@ void sort_tree(struct dt_info *dti)
 }
 
 /* utility helper to avoid code duplication */
-static struct node *build_and_name_child_node(struct node *parent, char *name)
+static struct node *build_and_name_child_node(struct node *parent, const char *name)
 {
 	struct node *node;
 
-	node = build_node(NULL, NULL);
-	name_node(node, xstrdup(name));
+	node = build_node(NULL, NULL, NULL);
+	name_node(node, name);
 	add_child(parent, node);
 
 	return node;
 }
 
-static struct node *build_root_node(struct node *dt, char *name)
+static struct node *build_root_node(struct node *dt, const char *name)
 {
 	struct node *an;
 
@@ -874,8 +880,9 @@ static void generate_label_tree_internal(struct dt_info *dti,
 
 			/* insert it */
 			p = build_property(l->label,
-				data_copy_mem(node->fullpath,
-						strlen(node->fullpath) + 1));
+				data_copy_escape_string(node->fullpath,
+						strlen(node->fullpath)),
+				NULL);
 			add_property(an, p);
 		}
 
@@ -919,13 +926,19 @@ static void add_fixup_entry(struct dt_info *dti, struct node *fn,
 	/* m->ref can only be a REF_PHANDLE, but check anyway */
 	assert(m->type == REF_PHANDLE);
 
+	/* The format only permits fixups for references to label, not
+	 * references to path */
+	if (strchr(m->ref, '/'))
+		die("Can't generate fixup for reference to path &{%s}\n",
+		    m->ref);
+
 	/* there shouldn't be any ':' in the arguments */
 	if (strchr(node->fullpath, ':') || strchr(prop->name, ':'))
 		die("arguments should not contain ':'\n");
 
 	xasprintf(&entry, "%s:%s:%u",
 			node->fullpath, prop->name, m->offset);
-	append_to_property(fn, m->ref, entry, strlen(entry) + 1);
+	append_to_property(fn, m->ref, entry, strlen(entry) + 1, TYPE_STRING);
 
 	free(entry);
 }
@@ -985,7 +998,7 @@ static void add_local_fixup_entry(struct dt_info *dti,
 	char **compp;
 	int i, depth;
 
-	/* walk back retreiving depth */
+	/* walk back retrieving depth */
 	depth = 0;
 	for (wn = node; wn; wn = wn->parent)
 		depth++;
@@ -1000,15 +1013,13 @@ static void add_local_fixup_entry(struct dt_info *dti,
 	/* walk the path components creating nodes if they don't exist */
 	for (wn = lfn, i = 1; i < depth; i++, wn = nwn) {
 		/* if no node exists, create it */
-		nwn = get_subnode(wn, compp[i]);
-		if (!nwn)
-			nwn = build_and_name_child_node(wn, compp[i]);
+		nwn = build_root_node(wn, compp[i]);
 	}
 
 	free(compp);
 
 	value_32 = cpu_to_fdt32(m->offset);
-	append_to_property(wn, prop->name, &value_32, sizeof(value_32));
+	append_to_property(wn, prop->name, &value_32, sizeof(value_32), TYPE_UINT32);
 }
 
 static void generate_local_fixups_tree_internal(struct dt_info *dti,
@@ -1034,7 +1045,7 @@ static void generate_local_fixups_tree_internal(struct dt_info *dti,
 		generate_local_fixups_tree_internal(dti, lfn, c);
 }
 
-void generate_label_tree(struct dt_info *dti, char *name, bool allocph)
+void generate_label_tree(struct dt_info *dti, const char *name, bool allocph)
 {
 	if (!any_label_tree(dti, dti->dt))
 		return;
@@ -1042,18 +1053,31 @@ void generate_label_tree(struct dt_info *dti, char *name, bool allocph)
 				     dti->dt, allocph);
 }
 
-void generate_fixups_tree(struct dt_info *dti, char *name)
+void generate_fixups_tree(struct dt_info *dti, const char *name)
 {
+	struct node *n = get_subnode(dti->dt, name);
+
+	/* Start with an empty __fixups__ node to not get duplicates */
+	if (n)
+		n->deleted = true;
+
 	if (!any_fixup_tree(dti, dti->dt))
 		return;
-	generate_fixups_tree_internal(dti, build_root_node(dti->dt, name),
+	generate_fixups_tree_internal(dti,
+				      build_and_name_child_node(dti->dt, name),
 				      dti->dt);
 }
 
-void generate_local_fixups_tree(struct dt_info *dti, char *name)
+void generate_local_fixups_tree(struct dt_info *dti, const char *name)
 {
+	struct node *n = get_subnode(dti->dt, name);
+
+	/* Start with an empty __local_fixups__ node to not get duplicates */
+	if (n)
+		n->deleted = true;
 	if (!any_local_fixup_tree(dti, dti->dt))
 		return;
-	generate_local_fixups_tree_internal(dti, build_root_node(dti->dt, name),
+	generate_local_fixups_tree_internal(dti,
+					    build_and_name_child_node(dti->dt, name),
 					    dti->dt);
 }
diff --git a/scripts/dtc/srcpos.c b/scripts/dtc/srcpos.c
index 0ad89e2af60..627a0760e6e 100644
--- a/scripts/dtc/srcpos.c
+++ b/scripts/dtc/srcpos.c
@@ -1,23 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 
 #include <stdio.h>
 
@@ -33,6 +21,10 @@ struct search_path {
 /* This is the list of directories that we search for source files */
 static struct search_path *search_path_head, **search_path_tail;
 
+/* Detect infinite include recursion. */
+#define MAX_SRCFILE_DEPTH     (200)
+static int srcfile_depth; /* = 0 */
+
 static char *get_dirname(const char *path)
 {
 	const char *slash = strrchr(path, '/');
@@ -50,10 +42,51 @@ static char *get_dirname(const char *path)
 
 FILE *depfile; /* = NULL */
 struct srcfile_state *current_srcfile; /* = NULL */
+static char *initial_path; /* = NULL */
+static int initial_pathlen; /* = 0 */
+static bool initial_cpp = true;
 
-/* Detect infinite include recursion. */
-#define MAX_SRCFILE_DEPTH     (100)
-static int srcfile_depth; /* = 0 */
+static void set_initial_path(char *fname)
+{
+	int i, len = strlen(fname);
+
+	xasprintf(&initial_path, "%s", fname);
+	initial_pathlen = 0;
+	for (i = 0; i != len; i++)
+		if (initial_path[i] == '/')
+			initial_pathlen++;
+}
+
+static char *shorten_to_initial_path(char *fname)
+{
+	char *p1, *p2, *prevslash1 = NULL;
+	int slashes = 0;
+
+	for (p1 = fname, p2 = initial_path; *p1 && *p2; p1++, p2++) {
+		if (*p1 != *p2)
+			break;
+		if (*p1 == '/') {
+			prevslash1 = p1;
+			slashes++;
+		}
+	}
+	p1 = prevslash1 + 1;
+	if (prevslash1) {
+		int diff = initial_pathlen - slashes, i, j;
+		int restlen = strlen(fname) - (p1 - fname);
+		char *res;
+
+		res = xmalloc((3 * diff) + restlen + 1);
+		for (i = 0, j = 0; i != diff; i++) {
+			res[j++] = '.';
+			res[j++] = '.';
+			res[j++] = '/';
+		}
+		strcpy(res + j, p1);
+		return res;
+	}
+	return NULL;
+}
 
 /**
  * Try to open a file in a given directory.
@@ -127,8 +160,10 @@ FILE *srcfile_relative_open(const char *fname, char **fullnamep)
 			    strerror(errno));
 	}
 
-	if (depfile)
-		fprintf(depfile, " %s", fullname);
+	if (depfile) {
+		fputc(' ', depfile);
+		fprint_path_escaped(depfile, fullname);
+	}
 
 	if (fullnamep)
 		*fullnamep = fullname;
@@ -155,6 +190,9 @@ void srcfile_push(const char *fname)
 	srcfile->colno = 1;
 
 	current_srcfile = srcfile;
+
+	if (srcfile_depth == 1)
+		set_initial_path(srcfile->name);
 }
 
 bool srcfile_pop(void)
@@ -195,18 +233,6 @@ void srcfile_add_search_path(const char *dirname)
 	search_path_tail = &node->next;
 }
 
-/*
- * The empty source position.
- */
-
-struct srcpos srcpos_empty = {
-	.first_line = 0,
-	.first_column = 0,
-	.last_line = 0,
-	.last_column = 0,
-	.file = NULL,
-};
-
 void srcpos_update(struct srcpos *pos, const char *text, int len)
 {
 	int i;
@@ -232,13 +258,46 @@ struct srcpos *
 srcpos_copy(struct srcpos *pos)
 {
 	struct srcpos *pos_new;
+	struct srcfile_state *srcfile_state;
+
+	if (!pos)
+		return NULL;
 
 	pos_new = xmalloc(sizeof(struct srcpos));
+	assert(pos->next == NULL);
 	memcpy(pos_new, pos, sizeof(struct srcpos));
 
+	/* allocate without free */
+	srcfile_state = xmalloc(sizeof(struct srcfile_state));
+	memcpy(srcfile_state, pos->file, sizeof(struct srcfile_state));
+	pos_new->file = srcfile_state;
+
 	return pos_new;
 }
 
+struct srcpos *srcpos_extend(struct srcpos *pos, struct srcpos *newtail)
+{
+	struct srcpos *p;
+
+	if (!pos)
+		return newtail;
+
+	for (p = pos; p->next != NULL; p = p->next);
+	p->next = newtail;
+	return pos;
+}
+
+void srcpos_free(struct srcpos *pos)
+{
+	struct srcpos *p_next;
+
+	while (pos) {
+		p_next = pos->next;
+		free(pos);
+		pos = p_next;
+	}
+}
+
 char *
 srcpos_string(struct srcpos *pos)
 {
@@ -263,6 +322,68 @@ srcpos_string(struct srcpos *pos)
 	return pos_str;
 }
 
+static char *
+srcpos_string_comment(struct srcpos *pos, bool first_line, int level)
+{
+	char *pos_str, *fresh_fname = NULL, *first, *rest;
+	const char *fname;
+
+	if (!pos) {
+		if (level > 1) {
+			xasprintf(&pos_str, "<no-file>:<no-line>");
+			return pos_str;
+		} else {
+			return NULL;
+		}
+	}
+
+	if (!pos->file)
+		fname = "<no-file>";
+	else if (!pos->file->name)
+		fname = "<no-filename>";
+	else if (level > 1)
+		fname = pos->file->name;
+	else {
+		fresh_fname = shorten_to_initial_path(pos->file->name);
+		if (fresh_fname)
+			fname = fresh_fname;
+		else
+			fname = pos->file->name;
+	}
+
+	if (level > 1)
+		xasprintf(&first, "%s:%d:%d-%d:%d", fname,
+			  pos->first_line, pos->first_column,
+			  pos->last_line, pos->last_column);
+	else
+		xasprintf(&first, "%s:%d", fname,
+			  first_line ? pos->first_line : pos->last_line);
+
+	if (fresh_fname)
+		free(fresh_fname);
+
+	if (pos->next != NULL) {
+		rest = srcpos_string_comment(pos->next, first_line, level);
+		xasprintf(&pos_str, "%s, %s", first, rest);
+		free(first);
+		free(rest);
+	} else {
+		pos_str = first;
+	}
+
+	return pos_str;
+}
+
+char *srcpos_string_first(struct srcpos *pos, int level)
+{
+	return srcpos_string_comment(pos, true, level);
+}
+
+char *srcpos_string_last(struct srcpos *pos, int level)
+{
+	return srcpos_string_comment(pos, false, level);
+}
+
 void srcpos_verror(struct srcpos *pos, const char *prefix,
 		   const char *fmt, va_list va)
 {
@@ -291,4 +412,9 @@ void srcpos_set_line(char *f, int l)
 {
 	current_srcfile->name = f;
 	current_srcfile->lineno = l;
+
+	if (initial_cpp) {
+		initial_cpp = false;
+		set_initial_path(f);
+	}
 }
diff --git a/scripts/dtc/srcpos.h b/scripts/dtc/srcpos.h
index fcd9937a911..0b634f212eb 100644
--- a/scripts/dtc/srcpos.h
+++ b/scripts/dtc/srcpos.h
@@ -1,20 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #ifndef SRCPOS_H
@@ -74,6 +60,7 @@ struct srcpos {
     int last_line;
     int last_column;
     struct srcfile_state *file;
+    struct srcpos *next;
 };
 
 #define YYLTYPE struct srcpos
@@ -93,18 +80,18 @@ struct srcpos {
 				YYRHSLOC(Rhs, 0).last_column;			\
 			(Current).file = YYRHSLOC (Rhs, 0).file;		\
 		}								\
+		(Current).next = NULL;						\
 	} while (0)
 
-/*
- * Fictional source position used for IR nodes that are
- * created without otherwise knowing a true source position.
- * For example,constant definitions from the command line.
- */
-extern struct srcpos srcpos_empty;
-
 extern void srcpos_update(struct srcpos *pos, const char *text, int len);
 extern struct srcpos *srcpos_copy(struct srcpos *pos);
+extern struct srcpos *srcpos_extend(struct srcpos *new_srcpos,
+				    struct srcpos *old_srcpos);
+extern void srcpos_free(struct srcpos *pos);
 extern char *srcpos_string(struct srcpos *pos);
+extern char *srcpos_string_first(struct srcpos *pos, int level);
+extern char *srcpos_string_last(struct srcpos *pos, int level);
+
 
 extern void PRINTF(3, 0) srcpos_verror(struct srcpos *pos, const char *prefix,
 					const char *fmt, va_list va);
diff --git a/scripts/dtc/treesource.c b/scripts/dtc/treesource.c
index 8c8b914698d..d25f01fc693 100644
--- a/scripts/dtc/treesource.c
+++ b/scripts/dtc/treesource.c
@@ -1,21 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include "dtc.h"
@@ -61,24 +46,18 @@ static bool isstring(char c)
 		|| strchr("\a\b\t\n\v\f\r", c));
 }
 
-static void write_propval_string(FILE *f, struct data val)
+static void write_propval_string(FILE *f, const char *s, size_t len)
 {
-	const char *str = val.val;
-	int i;
-	struct marker *m = val.markers;
-
-	assert(str[val.len-1] == '\0');
+	const char *end = s + len - 1;
 
-	while (m && (m->offset == 0)) {
-		if (m->type == LABEL)
-			fprintf(f, "%s: ", m->ref);
-		m = m->next;
-	}
-	fprintf(f, "\"");
+	if (!len)
+		return;
 
-	for (i = 0; i < (val.len-1); i++) {
-		char c = str[i];
+	assert(*end == '\0');
 
+	fprintf(f, "\"");
+	while (s < end) {
+		char c = *s++;
 		switch (c) {
 		case '\a':
 			fprintf(f, "\\a");
@@ -108,91 +87,103 @@ static void write_propval_string(FILE *f, struct data val)
 			fprintf(f, "\\\"");
 			break;
 		case '\0':
-			fprintf(f, "\", ");
-			while (m && (m->offset <= (i + 1))) {
-				if (m->type == LABEL) {
-					assert(m->offset == (i+1));
-					fprintf(f, "%s: ", m->ref);
-				}
-				m = m->next;
-			}
-			fprintf(f, "\"");
+			fprintf(f, "\\0");
 			break;
 		default:
 			if (isprint((unsigned char)c))
 				fprintf(f, "%c", c);
 			else
-				fprintf(f, "\\x%02hhx", c);
+				fprintf(f, "\\x%02"PRIx8, c);
 		}
 	}
 	fprintf(f, "\"");
-
-	/* Wrap up any labels at the end of the value */
-	for_each_marker_of_type(m, LABEL) {
-		assert (m->offset == val.len);
-		fprintf(f, " %s:", m->ref);
-	}
 }
 
-static void write_propval_cells(FILE *f, struct data val)
+static void write_propval_int(FILE *f, const char *p, size_t len, size_t width)
 {
-	void *propend = val.val + val.len;
-	fdt32_t *cp = (fdt32_t *)val.val;
-	struct marker *m = val.markers;
-
-	fprintf(f, "<");
-	for (;;) {
-		while (m && (m->offset <= ((char *)cp - val.val))) {
-			if (m->type == LABEL) {
-				assert(m->offset == ((char *)cp - val.val));
-				fprintf(f, "%s: ", m->ref);
-			}
-			m = m->next;
-		}
+	const char *end = p + len;
+	assert(len % width == 0);
 
-		fprintf(f, "0x%x", fdt32_to_cpu(*cp++));
-		if ((void *)cp >= propend)
+	for (; p < end; p += width) {
+		switch (width) {
+		case 1:
+			fprintf(f, "%02"PRIx8, *(const uint8_t*)p);
 			break;
-		fprintf(f, " ");
-	}
-
-	/* Wrap up any labels at the end of the value */
-	for_each_marker_of_type(m, LABEL) {
-		assert (m->offset == val.len);
-		fprintf(f, " %s:", m->ref);
+		case 2:
+			fprintf(f, "0x%02"PRIx16, dtb_ld16(p));
+			break;
+		case 4:
+			fprintf(f, "0x%02"PRIx32, dtb_ld32(p));
+			break;
+		case 8:
+			fprintf(f, "0x%02"PRIx64, dtb_ld64(p));
+			break;
+		}
+		if (p + width < end)
+			fputc(' ', f);
 	}
-	fprintf(f, ">");
 }
 
-static void write_propval_bytes(FILE *f, struct data val)
+static const char *delim_start[] = {
+	[TYPE_UINT8] = "[",
+	[TYPE_UINT16] = "/bits/ 16 <",
+	[TYPE_UINT32] = "<",
+	[TYPE_UINT64] = "/bits/ 64 <",
+	[TYPE_STRING] = "",
+};
+static const char *delim_end[] = {
+	[TYPE_UINT8] = "]",
+	[TYPE_UINT16] = ">",
+	[TYPE_UINT32] = ">",
+	[TYPE_UINT64] = ">",
+	[TYPE_STRING] = "",
+};
+
+/*
+ * The invariants in the marker list are:
+ *  - offsets are non-strictly monotonically increasing
+ *  - for a single offset there is at most one type marker
+ *  - for a single offset that has both a type marker and non-type markers, the
+ *    type marker appears before the others.
+ */
+static struct marker **add_marker(struct marker **mi,
+				  enum markertype type, unsigned int offset, char *ref)
 {
-	void *propend = val.val + val.len;
-	const char *bp = val.val;
-	struct marker *m = val.markers;
-
-	fprintf(f, "[");
-	for (;;) {
-		while (m && (m->offset == (bp-val.val))) {
-			if (m->type == LABEL)
-				fprintf(f, "%s: ", m->ref);
-			m = m->next;
-		}
+	struct marker *nm;
 
-		fprintf(f, "%02hhx", (unsigned char)(*bp++));
-		if ((const void *)bp >= propend)
-			break;
-		fprintf(f, " ");
-	}
+	while (*mi && (*mi)->offset < offset)
+		mi = &(*mi)->next;
 
-	/* Wrap up any labels at the end of the value */
-	for_each_marker_of_type(m, LABEL) {
-		assert (m->offset == val.len);
-		fprintf(f, " %s:", m->ref);
+	if (*mi && (*mi)->offset == offset && is_type_marker((*mi)->type)) {
+		if (is_type_marker(type))
+			return mi;
+		mi = &(*mi)->next;
 	}
-	fprintf(f, "]");
+
+	if (*mi && (*mi)->offset == offset && type == (*mi)->type)
+		return mi;
+
+	nm = xmalloc(sizeof(*nm));
+	nm->type = type;
+	nm->offset = offset;
+	nm->ref = ref;
+	nm->next = *mi;
+	*mi = nm;
+
+	return &nm->next;
 }
 
-static void write_propval(FILE *f, struct property *prop)
+static void add_string_markers(struct property *prop)
+{
+	int l, len = prop->val.len;
+	const char *p = prop->val.val;
+	struct marker **mi = &prop->val.markers;
+
+	for (l = strlen(p) + 1; l < len; l += strlen(p + l) + 1)
+		mi = add_marker(mi, TYPE_STRING, l, NULL);
+}
+
+static enum markertype guess_value_type(struct property *prop)
 {
 	int len = prop->val.len;
 	const char *p = prop->val.val;
@@ -201,11 +192,6 @@ static void write_propval(FILE *f, struct property *prop)
 	int nnotstringlbl = 0, nnotcelllbl = 0;
 	int i;
 
-	if (len == 0) {
-		fprintf(f, ";\n");
-		return;
-	}
-
 	for (i = 0; i < len; i++) {
 		if (! isstring(p[i]))
 			nnotstring++;
@@ -220,17 +206,116 @@ static void write_propval(FILE *f, struct property *prop)
 			nnotcelllbl++;
 	}
 
-	fprintf(f, " = ");
-	if ((p[len-1] == '\0') && (nnotstring == 0) && (nnul < (len-nnul))
+	if ((p[len-1] == '\0') && (nnotstring == 0) && (nnul <= (len-nnul))
 	    && (nnotstringlbl == 0)) {
-		write_propval_string(f, prop->val);
+		if (nnul > 1)
+			add_string_markers(prop);
+		return TYPE_STRING;
 	} else if (((len % sizeof(cell_t)) == 0) && (nnotcelllbl == 0)) {
-		write_propval_cells(f, prop->val);
-	} else {
-		write_propval_bytes(f, prop->val);
+		return TYPE_UINT32;
 	}
 
-	fprintf(f, ";\n");
+	return TYPE_UINT8;
+}
+
+static void write_propval(FILE *f, struct property *prop)
+{
+	size_t len = prop->val.len;
+	struct marker *m = prop->val.markers;
+	struct marker dummy_marker;
+	enum markertype emit_type = TYPE_NONE;
+	char *srcstr;
+
+	if (len == 0) {
+		fprintf(f, ";");
+		if (annotate) {
+			srcstr = srcpos_string_first(prop->srcpos, annotate);
+			if (srcstr) {
+				fprintf(f, " /* %s */", srcstr);
+				free(srcstr);
+			}
+		}
+		fprintf(f, "\n");
+		return;
+	}
+
+	fprintf(f, " =");
+
+	if (!next_type_marker(m)) {
+		/* data type information missing, need to guess */
+		dummy_marker.type = guess_value_type(prop);
+		dummy_marker.next = prop->val.markers;
+		dummy_marker.offset = 0;
+		dummy_marker.ref = NULL;
+		m = &dummy_marker;
+	}
+
+	for_each_marker(m) {
+		size_t chunk_len = (m->next ? m->next->offset : len) - m->offset;
+		size_t data_len = type_marker_length(m) ? : len - m->offset;
+		const char *p = &prop->val.val[m->offset];
+		struct marker *m_phandle;
+
+		if (is_type_marker(m->type)) {
+			emit_type = m->type;
+			fprintf(f, " %s", delim_start[emit_type]);
+		} else if (m->type == LABEL)
+			fprintf(f, " %s:", m->ref);
+
+		if (emit_type == TYPE_NONE || chunk_len == 0)
+			continue;
+
+		switch(emit_type) {
+		case TYPE_UINT16:
+			write_propval_int(f, p, chunk_len, 2);
+			break;
+		case TYPE_UINT32:
+			m_phandle = prop->val.markers;
+			for_each_marker_of_type(m_phandle, REF_PHANDLE)
+				if (m->offset == m_phandle->offset)
+					break;
+
+			if (m_phandle) {
+				if (m_phandle->ref[0] == '/')
+					fprintf(f, "&{%s}", m_phandle->ref);
+				else
+					fprintf(f, "&%s", m_phandle->ref);
+				if (chunk_len > 4) {
+					fputc(' ', f);
+					write_propval_int(f, p + 4, chunk_len - 4, 4);
+				}
+			} else {
+				write_propval_int(f, p, chunk_len, 4);
+			}
+			if (data_len > chunk_len)
+				fputc(' ', f);
+			break;
+		case TYPE_UINT64:
+			write_propval_int(f, p, chunk_len, 8);
+			break;
+		case TYPE_STRING:
+			write_propval_string(f, p, chunk_len);
+			break;
+		default:
+			write_propval_int(f, p, chunk_len, 1);
+		}
+
+		if (chunk_len == data_len) {
+			size_t pos = m->offset + chunk_len;
+			fprintf(f, pos == len ? "%s" : "%s,",
+			        delim_end[emit_type] ? : "");
+			emit_type = TYPE_NONE;
+		}
+	}
+	fprintf(f, ";");
+	if (annotate) {
+		srcstr = srcpos_string_first(prop->srcpos, annotate);
+		if (srcstr) {
+			fprintf(f, " /* %s */", srcstr);
+			free(srcstr);
+		}
+	}
+	fprintf(f, "\n");
 }
 
 static void write_tree_source_node(FILE *f, struct node *tree, int level)
@@ -238,14 +323,24 @@ static void write_tree_source_node(FILE *f, struct node *tree, int level)
 	struct property *prop;
 	struct node *child;
 	struct label *l;
+	char *srcstr;
 
 	write_prefix(f, level);
 	for_each_label(tree->labels, l)
 		fprintf(f, "%s: ", l->label);
 	if (tree->name && (*tree->name))
-		fprintf(f, "%s {\n", tree->name);
+		fprintf(f, "%s {", tree->name);
 	else
-		fprintf(f, "/ {\n");
+		fprintf(f, "/ {");
+
+	if (annotate) {
+		srcstr = srcpos_string_first(tree->srcpos, annotate);
+		if (srcstr) {
+			fprintf(f, " /* %s */", srcstr);
+			free(srcstr);
+		}
+	}
+	fprintf(f, "\n");
 
 	for_each_property(tree, prop) {
 		write_prefix(f, level+1);
@@ -259,7 +354,15 @@ static void write_tree_source_node(FILE *f, struct node *tree, int level)
 		write_tree_source_node(f, child, level+1);
 	}
 	write_prefix(f, level);
-	fprintf(f, "};\n");
+	fprintf(f, "};");
+	if (annotate) {
+		srcstr = srcpos_string_last(tree->srcpos, annotate);
+		if (srcstr) {
+			fprintf(f, " /* %s */", srcstr);
+			free(srcstr);
+		}
+	}
+	fprintf(f, "\n");
 }
 
 void dt_to_source(FILE *f, struct dt_info *dti)
diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-source.sh
index 1a009fd195d..32ff17ffd08 100755
--- a/scripts/dtc/update-dtc-source.sh
+++ b/scripts/dtc/update-dtc-source.sh
@@ -32,11 +32,12 @@ DTC_UPSTREAM_PATH=`pwd`/../dtc
 DTC_LINUX_PATH=`pwd`/scripts/dtc
 
 DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c \
-		srcpos.h treesource.c util.c util.h version_gen.h Makefile.dtc \
+		srcpos.h treesource.c util.c util.h version_gen.h yamltree.c \
 		dtc-lexer.l dtc-parser.y"
-LIBFDT_SOURCE="Makefile.libfdt fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
+LIBFDT_SOURCE="fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
 		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
 		fdt_wip.c libfdt.h libfdt_env.h libfdt_internal.h"
+FDTOVERLAY_SOURCE=fdtoverlay.c
 
 get_last_dtc_version() {
 	git log --oneline scripts/dtc/ | grep 'upstream' | head -1 | sed -e 's/^.* \(.*\)/\1/'
@@ -54,7 +55,7 @@ dtc_log=$(git log --oneline ${last_dtc_ver}..)
 
 # Copy the files into the Linux tree
 cd $DTC_LINUX_PATH
-for f in $DTC_SOURCE; do
+for f in $DTC_SOURCE $FDTOVERLAY_SOURCE; do
 	cp ${DTC_UPSTREAM_PATH}/${f} ${f}
 	git add ${f}
 done
diff --git a/scripts/dtc/util.c b/scripts/dtc/util.c
index 25d4db1e8c2..0e19a9f8acf 100644
--- a/scripts/dtc/util.c
+++ b/scripts/dtc/util.c
@@ -1,24 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2011 The Chromium Authors, All Rights Reserved.
  * Copyright 2008 Jon Loeliger, Freescale Semiconductor, Inc.
  *
  * util_is_printable_string contributed by
  *	Pantelis Antoniou <pantelis.antoniou AT gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #include <ctype.h>
@@ -27,6 +13,7 @@
 #include <stdarg.h>
 #include <string.h>
 #include <assert.h>
+#include <inttypes.h>
 
 #include <errno.h>
 #include <fcntl.h>
@@ -36,6 +23,22 @@
 #include "util.h"
 #include "version_gen.h"
 
+void fprint_path_escaped(FILE *fp, const char *path)
+{
+	const char *p = path;
+
+	while (*p) {
+		if (*p == ' ') {
+			fputc('\\', fp);
+			fputc(' ', fp);
+		} else {
+			fputc(*p, fp);
+		}
+
+		p++;
+	}
+}
+
 char *xstrdup(const char *s)
 {
 	int len = strlen(s) + 1;
@@ -57,36 +60,54 @@ char *xstrndup(const char *s, size_t n)
 	return d;
 }
 
-/* based in part from (3) vsnprintf */
-int xasprintf(char **strp, const char *fmt, ...)
+int xavsprintf_append(char **strp, const char *fmt, va_list ap)
 {
-	int n, size = 128;	/* start with 128 bytes */
+	int n, size = 0;	/* start with 128 bytes */
 	char *p;
-	va_list ap;
+	va_list ap_copy;
 
-	/* initial pointer is NULL making the fist realloc to be malloc */
-	p = NULL;
-	while (1) {
-		p = xrealloc(p, size);
+	p = *strp;
+	if (p)
+		size = strlen(p);
 
-		/* Try to print in the allocated space. */
-		va_start(ap, fmt);
-		n = vsnprintf(p, size, fmt, ap);
-		va_end(ap);
+	va_copy(ap_copy, ap);
+	n = vsnprintf(NULL, 0, fmt, ap_copy) + 1;
+	va_end(ap_copy);
+
+	p = xrealloc(p, size + n);
+
+	n = vsnprintf(p + size, n, fmt, ap);
 
-		/* If that worked, return the string. */
-		if (n > -1 && n < size)
-			break;
-		/* Else try again with more space. */
-		if (n > -1)	/* glibc 2.1 */
-			size = n + 1; /* precisely what is needed */
-		else		/* glibc 2.0 */
-			size *= 2; /* twice the old size */
-	}
 	*strp = p;
 	return strlen(p);
 }
 
+int xasprintf_append(char **strp, const char *fmt, ...)
+{
+	int n;
+	va_list ap;
+
+	va_start(ap, fmt);
+	n = xavsprintf_append(strp, fmt, ap);
+	va_end(ap);
+
+	return n;
+}
+
+int xasprintf(char **strp, const char *fmt, ...)
+{
+	int n;
+	va_list ap;
+
+	*strp = NULL;
+
+	va_start(ap, fmt);
+	n = xavsprintf_append(strp, fmt, ap);
+	va_end(ap);
+
+	return n;
+}
+
 char *join_path(const char *path, const char *name)
 {
 	int lenp = strlen(path);
@@ -238,11 +259,11 @@ char get_escape_char(const char *s, int *i)
 	return val;
 }
 
-int utilfdt_read_err_len(const char *filename, char **buffp, off_t *len)
+int utilfdt_read_err(const char *filename, char **buffp, size_t *len)
 {
 	int fd = 0;	/* assume stdin */
 	char *buf = NULL;
-	off_t bufsize = 1024, offset = 0;
+	size_t bufsize = 1024, offset = 0;
 	int ret = 0;
 
 	*buffp = NULL;
@@ -275,20 +296,15 @@ int utilfdt_read_err_len(const char *filename, char **buffp, off_t *len)
 		free(buf);
 	else
 		*buffp = buf;
-	*len = bufsize;
+	if (len)
+		*len = bufsize;
 	return ret;
 }
 
-int utilfdt_read_err(const char *filename, char **buffp)
-{
-	off_t len;
-	return utilfdt_read_err_len(filename, buffp, &len);
-}
-
-char *utilfdt_read_len(const char *filename, off_t *len)
+char *utilfdt_read(const char *filename, size_t *len)
 {
 	char *buff;
-	int ret = utilfdt_read_err_len(filename, &buff, len);
+	int ret = utilfdt_read_err(filename, &buff, len);
 
 	if (ret) {
 		fprintf(stderr, "Couldn't open blob from '%s': %s\n", filename,
@@ -299,12 +315,6 @@ char *utilfdt_read_len(const char *filename, off_t *len)
 	return buff;
 }
 
-char *utilfdt_read(const char *filename)
-{
-	off_t len;
-	return utilfdt_read_len(filename, &len);
-}
-
 int utilfdt_write_err(const char *filename, const void *blob)
 {
 	int fd = 1;	/* assume stdout */
@@ -369,11 +379,11 @@ int utilfdt_decode_type(const char *fmt, int *type, int *size)
 	}
 
 	/* we should now have a type */
-	if ((*fmt == '\0') || !strchr("iuxs", *fmt))
+	if ((*fmt == '\0') || !strchr("iuxsr", *fmt))
 		return -1;
 
 	/* convert qualifier (bhL) to byte size */
-	if (*fmt != 's')
+	if (*fmt != 's' && *fmt != 'r')
 		*size = qualifier == 'b' ? 1 :
 				qualifier == 'h' ? 2 :
 				qualifier == 'l' ? 4 : -1;
@@ -410,7 +420,7 @@ void utilfdt_print_data(const char *data, int len)
 
 		printf(" = <");
 		for (i = 0, len /= 4; i < len; i++)
-			printf("0x%08x%s", fdt32_to_cpu(cell[i]),
+			printf("0x%08" PRIx32 "%s", fdt32_to_cpu(cell[i]),
 			       i < (len - 1) ? " " : "");
 		printf(">");
 	} else {
diff --git a/scripts/dtc/util.h b/scripts/dtc/util.h
index 23e32962385..2d63a9a9d8d 100644
--- a/scripts/dtc/util.h
+++ b/scripts/dtc/util.h
@@ -1,6 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef UTIL_H
 #define UTIL_H
 
+#include <stdlib.h>
 #include <stdarg.h>
 #include <stdbool.h>
 #include <getopt.h>
@@ -8,25 +10,16 @@
 /*
  * Copyright 2011 The Chromium Authors, All Rights Reserved.
  * Copyright 2008 Jon Loeliger, Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- *                                                                   USA
  */
 
 #ifdef __GNUC__
+#ifdef __MINGW_PRINTF_FORMAT
+#define PRINTF(i, j)	__attribute__((format (__MINGW_PRINTF_FORMAT, i, j)))
+#elif __GNUC__ >= 5 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 4)
+#define PRINTF(i, j)	__attribute__((format (gnu_printf, i, j)))
+#else
 #define PRINTF(i, j)	__attribute__((format (printf, i, j)))
+#endif
 #define NORETURN	__attribute__((noreturn))
 #else
 #define PRINTF(i, j)
@@ -49,6 +42,11 @@ static inline void NORETURN PRINTF(1, 2) die(const char *str, ...)
 	exit(1);
 }
 
+/**
+ * Writes path to fp, escaping spaces with a backslash.
+ */
+void fprint_path_escaped(FILE *fp, const char *path);
+
 static inline void *xmalloc(size_t len)
 {
 	void *new = malloc(len);
@@ -73,6 +71,8 @@ extern char *xstrdup(const char *s);
 extern char *xstrndup(const char *s, size_t len);
 
 extern int PRINTF(2, 3) xasprintf(char **strp, const char *fmt, ...);
+extern int PRINTF(2, 3) xasprintf_append(char **strp, const char *fmt, ...);
+extern int PRINTF(2, 0) xavsprintf_append(char **strp, const char *fmt, va_list ap);
 extern char *join_path(const char *path, const char *name);
 
 /**
@@ -99,16 +99,10 @@ char get_escape_char(const char *s, int *i);
  * stderr.
  *
  * @param filename	The filename to read, or - for stdin
- * Return: Pointer to allocated buffer containing fdt, or NULL on error
- */
-char *utilfdt_read(const char *filename);
-
-/**
- * Like utilfdt_read(), but also passes back the size of the file read.
- *
  * @param len		If non-NULL, the amount of data we managed to read
+ * @return Pointer to allocated buffer containing fdt, or NULL on error
  */
-char *utilfdt_read_len(const char *filename, off_t *len);
+char *utilfdt_read(const char *filename, size_t *len);
 
 /**
  * Read a device tree file into a buffer. Does not report errors, but only
@@ -117,24 +111,18 @@ char *utilfdt_read_len(const char *filename, off_t *len);
  *
  * @param filename	The filename to read, or - for stdin
  * @param buffp		Returns pointer to buffer containing fdt
- * Return: 0 if ok, else an errno value representing the error
- */
-int utilfdt_read_err(const char *filename, char **buffp);
-
-/**
- * Like utilfdt_read_err(), but also passes back the size of the file read.
- *
  * @param len		If non-NULL, the amount of data we managed to read
+ * @return 0 if ok, else an errno value representing the error
  */
-int utilfdt_read_err_len(const char *filename, char **buffp, off_t *len);
+int utilfdt_read_err(const char *filename, char **buffp, size_t *len);
 
 /**
  * Write a device tree buffer to a file. This will report any errors on
  * stderr.
  *
  * @param filename	The filename to write, or - for stdout
- * @param blob		Poiner to buffer containing fdt
- * Return: 0 if ok, -1 on error
+ * @param blob		Pointer to buffer containing fdt
+ * @return 0 if ok, -1 on error
  */
 int utilfdt_write(const char *filename, const void *blob);
 
@@ -144,8 +132,8 @@ int utilfdt_write(const char *filename, const void *blob);
  * an error message for the user.
  *
  * @param filename	The filename to write, or - for stdout
- * @param blob		Poiner to buffer containing fdt
- * Return: 0 if ok, else an errno value representing the error
+ * @param blob		Pointer to buffer containing fdt
+ * @return 0 if ok, else an errno value representing the error
  */
 int utilfdt_write_err(const char *filename, const void *blob);
 
@@ -163,6 +151,7 @@ int utilfdt_write_err(const char *filename, const void *blob);
  *		i	signed integer
  *		u	unsigned integer
  *		x	hex
+ *		r	raw
  *
  * TODO: Implement ll modifier (8 bytes)
  * TODO: Implement o type (octal)
@@ -180,7 +169,7 @@ int utilfdt_decode_type(const char *fmt, int *type, int *size);
  */
 
 #define USAGE_TYPE_MSG \
-	"<type>\ts=string, i=int, u=unsigned, x=hex\n" \
+	"<type>\ts=string, i=int, u=unsigned, x=hex, r=raw\n" \
 	"\tOptional modifier prefix:\n" \
 	"\t\thh or b=byte, h=2 byte, l=4 byte (default)";
 
diff --git a/scripts/dtc/version_gen.h b/scripts/dtc/version_gen.h
index b00f14ff7a1..226c48bf75d 100644
--- a/scripts/dtc/version_gen.h
+++ b/scripts/dtc/version_gen.h
@@ -1 +1 @@
-#define DTC_VERSION "DTC 1.4.6-g84e414b0"
+#define DTC_VERSION "DTC 1.7.2-g52f07dcc"
diff --git a/scripts/dtc/yamltree.c b/scripts/dtc/yamltree.c
new file mode 100644
index 00000000000..55908c829c9
--- /dev/null
+++ b/scripts/dtc/yamltree.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright Linaro, Ltd. 2018
+ * (C) Copyright Arm Holdings.  2017
+ * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
+ */
+
+#include <stdlib.h>
+#include <yaml.h>
+#include "dtc.h"
+#include "srcpos.h"
+
+char *yaml_error_name[] = {
+	[YAML_NO_ERROR] = "no error",
+	[YAML_MEMORY_ERROR] = "memory error",
+	[YAML_READER_ERROR] = "reader error",
+	[YAML_SCANNER_ERROR] = "scanner error",
+	[YAML_PARSER_ERROR] = "parser error",
+	[YAML_COMPOSER_ERROR] = "composer error",
+	[YAML_WRITER_ERROR] = "writer error",
+	[YAML_EMITTER_ERROR] = "emitter error",
+};
+
+#define yaml_emitter_emit_or_die(emitter, event) (			\
+{									\
+	if (!yaml_emitter_emit(emitter, event))				\
+		die("yaml '%s': %s in %s, line %i\n",			\
+		    yaml_error_name[(emitter)->error], 			\
+		    (emitter)->problem, __func__, __LINE__);		\
+})
+
+static void yaml_propval_int(yaml_emitter_t *emitter, struct marker *markers,
+	char *data, unsigned int seq_offset, unsigned int len, int width)
+{
+	yaml_event_t event;
+	void *tag;
+	unsigned int off;
+
+	switch(width) {
+		case 1: tag = "!u8"; break;
+		case 2: tag = "!u16"; break;
+		case 4: tag = "!u32"; break;
+		case 8: tag = "!u64"; break;
+		default:
+			die("Invalid width %i", width);
+	}
+	assert(len % width == 0);
+
+	yaml_sequence_start_event_initialize(&event, NULL,
+		(yaml_char_t *)tag, width == 4, YAML_FLOW_SEQUENCE_STYLE);
+	yaml_emitter_emit_or_die(emitter, &event);
+
+	for (off = 0; off < len; off += width) {
+		char buf[32];
+		struct marker *m;
+		bool is_phandle = false;
+
+		switch(width) {
+		case 1:
+			sprintf(buf, "0x%"PRIx8, *(uint8_t*)(data + off));
+			break;
+		case 2:
+			sprintf(buf, "0x%"PRIx16, dtb_ld16(data + off));
+			break;
+		case 4:
+			sprintf(buf, "0x%"PRIx32, dtb_ld32(data + off));
+			m = markers;
+			is_phandle = false;
+			for_each_marker_of_type(m, REF_PHANDLE) {
+				if (m->offset == (seq_offset + off)) {
+					is_phandle = true;
+					break;
+				}
+			}
+			break;
+		case 8:
+			sprintf(buf, "0x%"PRIx64, dtb_ld64(data + off));
+			break;
+		}
+
+		if (is_phandle)
+			yaml_scalar_event_initialize(&event, NULL,
+				(yaml_char_t*)"!phandle", (yaml_char_t *)buf,
+				strlen(buf), 0, 0, YAML_PLAIN_SCALAR_STYLE);
+		else
+			yaml_scalar_event_initialize(&event, NULL,
+				(yaml_char_t*)YAML_INT_TAG, (yaml_char_t *)buf,
+				strlen(buf), 1, 1, YAML_PLAIN_SCALAR_STYLE);
+		yaml_emitter_emit_or_die(emitter, &event);
+	}
+
+	yaml_sequence_end_event_initialize(&event);
+	yaml_emitter_emit_or_die(emitter, &event);
+}
+
+static void yaml_propval_string(yaml_emitter_t *emitter, char *str, int len)
+{
+	yaml_event_t event;
+	int i;
+
+	assert(str[len-1] == '\0');
+
+	/* Make sure the entire string is in the lower 7-bit ascii range */
+	for (i = 0; i < len; i++)
+		assert(isascii(str[i]));
+
+	yaml_scalar_event_initialize(&event, NULL,
+		(yaml_char_t *)YAML_STR_TAG, (yaml_char_t*)str,
+		len-1, 0, 1, YAML_DOUBLE_QUOTED_SCALAR_STYLE);
+	yaml_emitter_emit_or_die(emitter, &event);
+}
+
+static void yaml_propval(yaml_emitter_t *emitter, struct property *prop)
+{
+	yaml_event_t event;
+	unsigned int len = prop->val.len;
+	struct marker *m = prop->val.markers;
+	struct marker *markers = prop->val.markers;
+
+	/* Emit the property name */
+	yaml_scalar_event_initialize(&event, NULL,
+		(yaml_char_t *)YAML_STR_TAG, (yaml_char_t*)prop->name,
+		strlen(prop->name), 1, 1, YAML_PLAIN_SCALAR_STYLE);
+	yaml_emitter_emit_or_die(emitter, &event);
+
+	/* Boolean properties are easiest to deal with. Length is zero, so just emit 'true' */
+	if (len == 0) {
+		yaml_scalar_event_initialize(&event, NULL,
+			(yaml_char_t *)YAML_BOOL_TAG,
+			(yaml_char_t*)"true",
+			strlen("true"), 1, 0, YAML_PLAIN_SCALAR_STYLE);
+		yaml_emitter_emit_or_die(emitter, &event);
+		return;
+	}
+
+	if (!m)
+		die("No markers present in property '%s' value\n", prop->name);
+
+	yaml_sequence_start_event_initialize(&event, NULL,
+		(yaml_char_t *)YAML_SEQ_TAG, 1, YAML_FLOW_SEQUENCE_STYLE);
+	yaml_emitter_emit_or_die(emitter, &event);
+
+	for_each_marker(m) {
+		int chunk_len;
+		char *data = &prop->val.val[m->offset];
+
+		if (m->type < TYPE_UINT8)
+			continue;
+
+		chunk_len = type_marker_length(m) ? : len;
+		assert(chunk_len > 0);
+		len -= chunk_len;
+
+		switch(m->type) {
+		case TYPE_UINT16:
+			yaml_propval_int(emitter, markers, data, m->offset, chunk_len, 2);
+			break;
+		case TYPE_UINT32:
+			yaml_propval_int(emitter, markers, data, m->offset, chunk_len, 4);
+			break;
+		case TYPE_UINT64:
+			yaml_propval_int(emitter, markers, data, m->offset, chunk_len, 8);
+			break;
+		case TYPE_STRING:
+			yaml_propval_string(emitter, data, chunk_len);
+			break;
+		default:
+			yaml_propval_int(emitter, markers, data, m->offset, chunk_len, 1);
+			break;
+		}
+	}
+
+	yaml_sequence_end_event_initialize(&event);
+	yaml_emitter_emit_or_die(emitter, &event);
+}
+
+
+static void yaml_tree(struct node *tree, yaml_emitter_t *emitter)
+{
+	struct property *prop;
+	struct node *child;
+	yaml_event_t event;
+
+	if (tree->deleted)
+		return;
+
+	yaml_mapping_start_event_initialize(&event, NULL,
+		(yaml_char_t *)YAML_MAP_TAG, 1, YAML_ANY_MAPPING_STYLE);
+	yaml_emitter_emit_or_die(emitter, &event);
+
+	for_each_property(tree, prop)
+		yaml_propval(emitter, prop);
+
+	/* Loop over all the children, emitting them into the map */
+	for_each_child(tree, child) {
+		yaml_scalar_event_initialize(&event, NULL,
+			(yaml_char_t *)YAML_STR_TAG, (yaml_char_t*)child->name,
+			strlen(child->name), 1, 0, YAML_PLAIN_SCALAR_STYLE);
+		yaml_emitter_emit_or_die(emitter, &event);
+		yaml_tree(child, emitter);
+	}
+
+	yaml_mapping_end_event_initialize(&event);
+	yaml_emitter_emit_or_die(emitter, &event);
+}
+
+void dt_to_yaml(FILE *f, struct dt_info *dti)
+{
+	yaml_emitter_t emitter;
+	yaml_event_t event;
+
+	yaml_emitter_initialize(&emitter);
+	yaml_emitter_set_output_file(&emitter, f);
+	yaml_stream_start_event_initialize(&event, YAML_UTF8_ENCODING);
+	yaml_emitter_emit_or_die(&emitter, &event);
+
+	yaml_document_start_event_initialize(&event, NULL, NULL, NULL, 0);
+	yaml_emitter_emit_or_die(&emitter, &event);
+
+	yaml_sequence_start_event_initialize(&event, NULL, (yaml_char_t *)YAML_SEQ_TAG, 1, YAML_ANY_SEQUENCE_STYLE);
+	yaml_emitter_emit_or_die(&emitter, &event);
+
+	yaml_tree(dti->dt, &emitter);
+
+	yaml_sequence_end_event_initialize(&event);
+	yaml_emitter_emit_or_die(&emitter, &event);
+
+	yaml_document_end_event_initialize(&event, 0);
+	yaml_emitter_emit_or_die(&emitter, &event);
+
+	yaml_stream_end_event_initialize(&event);
+	yaml_emitter_emit_or_die(&emitter, &event);
+
+	yaml_emitter_delete(&emitter);
+}
diff --git a/tools/libfdt/fdt_rw.c b/tools/libfdt/fdt_rw.c
index 7189f014295..95d47be2d8a 100644
--- a/tools/libfdt/fdt_rw.c
+++ b/tools/libfdt/fdt_rw.c
@@ -26,7 +26,7 @@ int fdt_remove_unused_strings(const void *old, void *new)
 		new_prop = (struct fdt_property *)(unsigned long)
 			fdt_get_property_by_offset(new, offset, NULL);
 		str = fdt_string(old, fdt32_to_cpu(old_prop->nameoff));
-		ret = fdt_find_add_string_(new, str, &allocated);
+		ret = fdt_find_add_string_(new, str, strlen(str), &allocated);
 		if (ret < 0)
 			return ret;
 		new_prop->nameoff = cpu_to_fdt32(ret);
-- 
2.51.0

