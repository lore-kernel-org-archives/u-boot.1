Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061FFC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B7B8399A;
	Fri, 25 Jul 2025 14:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TsqN9Stg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53929839A7; Fri, 25 Jul 2025 14:57:36 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A2C88397B
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4563cfac19cso22714595e9.2
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753448253; x=1754053053; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FjUWSnkrut32jkMJUGpFciyOKDGe8Ek3Yf+92Kz7SoY=;
 b=TsqN9Stg2Q5uN76SVV5Oqg352wPUZ+t6E5xkMtPa47hfOxOfTX5GImoHKT8gLcDLRj
 NXV0V4jFMJbSxA5L0kiHMx1uSgNFvle+Gj97ky2xfA1ENUpBmR0hTbjnxN9rrej3LAeN
 72B0oJ1JQn1g4BpXYvLqkeqvNTMkWdz6a9QGkZppIcTWy6/vQVBClRkFgeUQdnHRH5jl
 OaiajhRbg4PYP9aWHesk0mcK/XaKWwz4aU4PCnHW4lW8PUoZrPRM90EaYY3SpgtW+p/2
 b4JR7ujZck8iRf6T5gWl+SAL4hc9o/hEf/lHs3i3xZbY4v+0rZOwUX7IQmfNY/uMlvL6
 UmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448253; x=1754053053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FjUWSnkrut32jkMJUGpFciyOKDGe8Ek3Yf+92Kz7SoY=;
 b=Z5xHt/37uCLTljf/oTNwtT7nVafajjBbJj3pB7l6l9Fozo25TxjePHM5I5T1DzGN9G
 kP6lW5lxTuZXp9aVdaHwJ6BZMC9sTZ3TMYucJiJOK9E4Tax3v2bJ1sGOsAZf75n4O7n0
 P3Hdr71N0ucYC1QKZlc+hdXbiMuwOoEseW+ex9bVqfURGcDO+9IxeTM4NvbEX2jmv6tr
 ffQjgKVgan1GwzKDhHJB9sKbY+nz5n0kIzAeflpWna7SFVWUotxqD6g4vtYKDdsLgP9R
 3wpJIb68MiwZfhg5TFuoxUgm2obaRQPlKKsMTH3otL/NCX7FMz6Kwnr/WJjimQslB6w/
 lNTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAkRHe4Vl09Wjg1OOUxZnk4iHn5gVmkdQTW0nYURSvOHu9h3NajQLPjBclqlvT+9KWdYLfpJg=@lists.denx.de
X-Gm-Message-State: AOJu0YyFQkZ/0bbXikFIKofc4nSKpavF7XJvEM3VnJBFe+AhCe34mdam
 qI4D46hBFdZT/lh5LR8YoKGfgYcG/K2omieHzb8JrXCxYzB6BVFyrBZA5gerBiiCeEM=
X-Gm-Gg: ASbGncvgMTZQwwf8n5Wr5TNznuFtpe5QpzTD5SMMxSZUffYtXgNYM0KD2NHfrC5MuWE
 RYrLLKf7ccZ4dmlFRkDtv+ZTGJ4N57W97PwcLvG0keUJAjd4MbW7Jh+q8ZV0ARDO3G0feaVrrgW
 YrcNYrbjpwh4/XfzTiKJkk9EyBSL4Qa8ZJnTbqWqjK0hduuKp3kd/rXRqKX2O0tNf0eg96Qm6L8
 Qeq4FZ2yLwihscEvaOa2ALBUmuQrFBvkFeORFgw4MvviUC6zjsXQVja+Mh7qyhUqq6fiFFF/yEU
 nK8ndIMZW2JQnrC3YOxZLmh0G6D7DsRVFomvqB2XvVB2vX1Y1kgxgHvPFTASeMe/YslWiKRgW3w
 ZGHyocb56gn+9Yxse2gguyLZKE5L3Reo5Yyifw0aBov1mg5c0YZwy7GEwpaFq3B6lzg==
X-Google-Smtp-Source: AGHT+IFkUwdQohbia8BVVxBsnX7c1REljttt+J1OqClZAeS0vIFpiQWut4Qkp3PdNHx5IgekkXWAmQ==
X-Received: by 2002:a05:600c:6217:b0:456:58e:318e with SMTP id
 5b1f17b1804b1-45876665de5mr19469355e9.30.1753448252703; 
 Fri, 25 Jul 2025 05:57:32 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4fcfsm53115355e9.29.2025.07.25.05.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:57:31 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 25 Jul 2025 14:57:08 +0200
Subject: [PATCH v2 4/7] add support for symbol lookups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-b4-arm64-backtrace-symbols-v2-4-230a9665085b@linaro.org>
References: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
In-Reply-To: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=26102;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=TnSwoagMd0Z+jmeydD5ap9ynBN7pG7qey1M1CFU/Lkw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhozmerMJazlmO2/n/P7u1BJFL/f7NquO8H11tNumkXutO
 UV5t3JpRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIshrDHw7rsowdk2yYcpk2
 HzB+5Hbr3d1OmU3CIgbm0dXeHpUKsgx/Zd95K/N1fet6c0KktHB6z8plVQ2nXa9HPPWfGXnC+82
 jMgA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This is mostly a port of the Xen hypervisor implementation. The U-Boot
binary is built as normal, then its symbol table is fed into
tools/symbols to generate an optimised lookup table. U-Boot is rebuilt
with the symbol table and handling code in lib/symbols.c.

Based on code from Xen at
  c20850540ad6("x86/altcall: always use a temporary parameter stashing variable")

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 Makefile          |  15 +-
 include/symbols.h |  22 ++
 lib/Kconfig       |   9 +
 lib/symbols.c     | 141 ++++++++++++
 tools/Makefile    |   3 +
 tools/symbols.c   | 646 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 835 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 57f95db81202..531dca7b3e64 100644
--- a/Makefile
+++ b/Makefile
@@ -2013,16 +2013,29 @@ quiet_cmd_u-boot__ ?= LD      $@
 		$(LD) $(KBUILD_LDFLAGS) $(LDFLAGS_u-boot) -o $@			\
 		-T u-boot.lds $(u-boot-init)					\
 		--whole-archive							\
 			$(u-boot-main)						\
+			$(if $(shell [ "$@" = "u-boot" ] && echo "true"),lib/symbols.o u-boot.sym.o,)	\
 		--no-whole-archive						\
 		$(PLATFORM_LIBS) -Map u-boot.map;				\
 		$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 endif
 
-u-boot:	$(u-boot-init) $(u-boot-main) $(u-boot-keep-syms-lto) u-boot.lds FORCE
+u-boot.nosyms:	$(u-boot-init) $(u-boot-main) $(u-boot-keep-syms-lto) u-boot.lds FORCE
 	+$(call if_changed,u-boot__)
 
+ifeq ($(CONFIG_SYMBOL_LOOKUP),y)
+u-boot: u-boot.nosyms FORCE
+	@$(NM) -n -pa --format=sysv u-boot.nosyms | tools/symbols --all-symbols --sysv --sort > u-boot.sym.S
+	@$(CC) $(c_flags) -c $(srctree)/lib/symbols.c -o lib/symbols.o
+	@$(AS) u-boot.sym.S -o u-boot.sym.o
+	@$(call cmd,u-boot__)
+else
+u-boot: u-boot.nosyms FORCE
+	+$(call if_changed,copy)
+endif
+
+
 ifeq ($(CONFIG_RISCV),y)
 	@tools/prelink-riscv $@
 endif
 
diff --git a/include/symbols.h b/include/symbols.h
new file mode 100644
index 000000000000..560bf2e44bf7
--- /dev/null
+++ b/include/symbols.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#include <asm/types.h>
+#include <string.h>
+
+#define KSYM_NAME_LEN 127
+
+#if IS_ENABLED(CONFIG_SYMBOL_LOOKUP)
+const char * __attribute__((weak)) symbol_lookup(unsigned long addr, unsigned long *symaddr, unsigned long *offset,
+			   char *namebuf);
+#else
+static inline const char *symbol_lookup(unsigned long addr, unsigned long *symaddr, unsigned long *offset,
+			   char *namebuf)
+{
+	/* We can't find the actual symbol address so just use the search address */
+	*symaddr = addr;
+	*offset = 0;
+	strcpy(namebuf, "???");
+	namebuf[3] = '\0';
+	return namebuf;
+}
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index 6a89f797beff..3744afeb6d96 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1094,8 +1094,17 @@ config VPL_OF_LIBFDT_ASSUME_MASK
 	  are made, and libfdt is able to deal with malicious data. A value of
 	  0xff means all assumptions are made and any invalid data may cause
 	  unsafe execution. See FDT_ASSUME_PERFECT, etc. in libfdt_internal.h
 
+config SYMBOL_LOOKUP
+	bool "Enable symbol lookup"
+	depends on ARM64
+	select FRAMEPOINTER
+	help
+	  This enables support for looking up symbol names from addresses. When
+	  enabled U-Boot will print stack traces with function names when an
+	  exception occurs.
+
 menu "System tables"
 	depends on (!EFI && !SYS_COREBOOT) || (ARM && EFI_LOADER)
 
 config BLOBLIST_TABLES
diff --git a/lib/symbols.c b/lib/symbols.c
new file mode 100644
index 000000000000..f1fda505328f
--- /dev/null
+++ b/lib/symbols.c
@@ -0,0 +1,141 @@
+/*
+ * symbols.c: in-kernel printing of symbolic oopses and stack traces.
+ * Ported from Xen hypervisor
+ *
+ * Copyright 2002 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
+ *
+ * ChangeLog:
+ *
+ * (25/Aug/2004) Paulo Marques <pmarques@grupopie.com>
+ *      Changed the compression method from stem compression to "table lookup"
+ *      compression (see tools/symbols.c for a more complete description)
+ */
+
+#include <asm-generic/sections.h>
+#include <asm/esr.h>
+#include <asm/global_data.h>
+#include <asm/ptrace.h>
+#include <hexdump.h>
+#include <linux/compiler.h>
+#include <symbols.h>
+
+extern const uint64_t symbols_offsets[];
+extern const unsigned int symbols_num_syms;
+extern const u8 symbols_names[];
+extern const u8 symbols_token_table[];
+extern const u16 symbols_token_index[];
+extern const unsigned int symbols_markers[];
+
+#define symbols_address(n) (symbols_offsets[n] + 0UL)
+
+/*
+ * expand a compressed symbol data into the resulting uncompressed string,
+ * given the offset to where the symbol is in the compressed stream.
+ */
+static unsigned int symbols_expand_symbol(unsigned int off, char *result)
+{
+	int len, skipped_first = 0;
+	const u8 *tptr, *data;
+
+	/* get the compressed symbol length from the first symbol byte */
+	data = &symbols_names[off];
+	len = *data;
+	data++;
+
+	/* update the offset to return the offset for the next symbol on
+	 * the compressed stream */
+	off += len + 1;
+
+	/* for every byte on the compressed symbol data, copy the table
+	 * entry for that byte */
+	while (len) {
+		tptr = &symbols_token_table[symbols_token_index[*data]];
+		data++;
+		len--;
+
+		while (*tptr) {
+			if (skipped_first) {
+				*result = *tptr;
+				result++;
+			} else
+				skipped_first = 1;
+			tptr++;
+		}
+	}
+
+	*result = '\0';
+
+	/* return to offset to the next symbol */
+	return off;
+}
+
+/* find the offset on the compressed stream given and index in the
+ * symbols array */
+static unsigned int get_symbol_offset(unsigned long pos)
+{
+	const u8 *name;
+	int i;
+
+	/* use the closest marker we have. We have markers every 256 positions,
+	 * so that should be close enough */
+	name = &symbols_names[symbols_markers[pos >> 8]];
+
+	/* sequentially scan all the symbols up to the point we're searching for.
+	 * Every symbol is stored in a [<len>][<len> bytes of data] format, so we
+	 * just need to add the len to the current pointer for every symbol we
+	 * wish to skip */
+	for (i = 0; i < (pos & 0xFF); i++)
+		name = name + (*name) + 1;
+
+	return name - symbols_names;
+}
+
+/**
+ * symbol_lookup - look up a symbol by address
+ * @addr: address nearest to the symbol (typically link register value)
+ * @symaddr: pointer to store the actual address of the symbol
+ * @offset: pointer to store the offset between @search_addr and the found symbol address
+ * @namebuf: buffer to store the symbol name (must be at least KSYM_NAME_LEN + 1 bytes long)
+ * Return: pointer to the symbol name (namebuf)
+ */
+const char *symbol_lookup(unsigned long search_addr, unsigned long *symaddr, unsigned long *offset, char *namebuf)
+{
+	unsigned long low, high, mid;
+
+	/* Symbol addresses are not relative to the load address of U-Boot */
+	search_addr -= (unsigned long)_start;
+
+	namebuf[KSYM_NAME_LEN] = 0;
+	namebuf[0] = '?';
+
+	/* do a binary search on the sorted symbols_addresses array */
+	low = 0;
+	high = symbols_num_syms;
+
+	while (high - low > 1) {
+		mid = (low + high) / 2;
+		if (symbols_address(mid) <= search_addr) {
+			low = mid;
+		} else {
+			high = mid;
+		}
+	}
+
+	/* search for the first aliased symbol. Aliased symbols are
+	 * symbols with the same address */
+	while (low && symbols_address(low - 1) == symbols_address(low))
+		--low;
+
+	/* Grab name */
+	symbols_expand_symbol(get_symbol_offset(low), namebuf);
+
+	/*
+	 * _start is used over gd->relocaddr because it will always be correct,
+	 * even if U-Boot was built as relocatable and loaded at an arbitrary
+	 * address (both pre and post-relocation) since it is fixed up before
+	 * the C runtime is initialized.
+	 */
+	*symaddr = symbols_address(low) + (unsigned long)_start;
+	*offset = search_addr - symbols_address(low);
+	return namebuf;
+}
diff --git a/tools/Makefile b/tools/Makefile
index 02297e8c93a3..3fe957f49366 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -242,8 +242,11 @@ hostprogs-$(CONFIG_ARCH_MVEBU) += kwboot
 
 hostprogs-y += proftool
 proftool-objs = proftool.o generated/lib/abuf.o
 
+HOSTCFLAGS_symbols.o += -DCONFIG_TEXT_BASE=$(CONFIG_TEXT_BASE)
+hostprogs-$(CONFIG_SYMBOL_LOOKUP) += symbols
+
 hostprogs-$(CONFIG_STATIC_RELA) += relocate-rela
 hostprogs-$(CONFIG_RISCV) += prelink-riscv
 
 hostprogs-$(CONFIG_ARCH_OCTEON) += update_octeon_header
diff --git a/tools/symbols.c b/tools/symbols.c
new file mode 100644
index 000000000000..9e3c4f62cf24
--- /dev/null
+++ b/tools/symbols.c
@@ -0,0 +1,646 @@
+/* Generate assembler source containing symbol information
+ *
+ * Copyright 2002       by Kai Germaschewski
+ *
+ * Based on Xen implementation as of March 2024
+ *	c20850540ad6 ("x86/altcall: always use a temporary parameter stashing variable")
+ *
+ * Simplified and adjusted for U-Boot, notably the generated ASM is simplified with the
+ * text offset applied at runtime to better support U-Boot relocation.
+ *
+ * This software may be used and distributed according to the terms
+ * of the GNU General Public License, incorporated herein by reference.
+ *
+ * Usage: nm -n vmlinux | scripts/symbols [--all-symbols] > symbols.S
+ *
+ * ChangeLog:
+ *
+ * (25/Aug/2004) Paulo Marques <pmarques@grupopie.com>
+ *      Changed the compression method from stem compression to "table lookup"
+ *      compression
+ *
+ *      Table compression uses all the unused char codes on the symbols and
+ *  maps these to the most used substrings (tokens). For instance, it might
+ *  map char code 0xF7 to represent "write_" and then in every symbol where
+ *  "write_" appears it can be replaced by 0xF7, saving 5 bytes.
+ *      The used codes themselves are also placed in the table so that the
+ *  decompresion can work without "special cases".
+ *      Applied to kernel symbols, this usually produces a compression ratio
+ *  of about 50%.
+ *
+ */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <ctype.h>
+
+#define KSYM_NAME_LEN		127
+
+
+struct sym_entry {
+	unsigned long long addr;
+	unsigned int len;
+	unsigned char *sym;
+	char *orig_symbol;
+	unsigned int addr_idx;
+	unsigned int stream_offset;
+	unsigned char type;
+};
+#define SYMBOL_NAME(s) ((char *)(s)->sym + 1)
+
+static struct sym_entry *table;
+static unsigned int table_size, table_cnt;
+static unsigned long long _stext, _etext, _sinittext, _einittext, _sextratext, _eextratext;
+static int all_symbols = 0;
+static int sort_by_name = 0;
+static int map_only = 0;
+static char symbol_prefix_char = '\0';
+static enum { fmt_bsd, fmt_sysv } input_format;
+static int compare_name(const void *p1, const void *p2);
+
+int token_profit[0x10000];
+
+/* the table that holds the result of the compression */
+unsigned char best_table[256][2];
+unsigned char best_table_len[256];
+
+
+static void usage(void)
+{
+	fprintf(stderr, "Usage: symbols [--all-symbols] [--symbol-prefix=<prefix char>] < in.map > out.S\n");
+	exit(1);
+}
+
+/*
+ * This ignores the intensely annoying "mapping symbols" found
+ * in ARM ELF files: $a, $t and $d.
+ */
+static inline int is_arm_mapping_symbol(const char *str)
+{
+	return str[0] == '$' && strchr("atd", str[1])
+	       && (str[2] == '\0' || str[2] == '.');
+}
+
+static int read_symbol(FILE *in, struct sym_entry *s)
+{
+	char str[500], type[20] = "";
+	char *sym, stype;
+	static char *filename = NULL;
+	int rc = -1;
+
+	switch (input_format) {
+	case fmt_bsd:
+		rc = fscanf(in, "%llx %c %499s\n", &s->addr, &stype, str);
+		break;
+	case fmt_sysv:
+		while (fscanf(in, "\n") == 1)
+			/* nothing */;
+		rc = fscanf(in, "%499[^ |] |%llx | %c |",
+			    str, &s->addr, &stype);
+		if (rc == 3 && fscanf(in, " %19[^ |] |", type) != 1)
+			*type = '\0';
+		break;
+	}
+	if (rc != 3) {
+		if (rc != EOF) {
+			/* skip line */
+			if (fgets(str, 500, in) == NULL)
+				return -1; /* must check fgets result */
+		
+			//printf("SKIP: %s\n", str);
+		}
+		return -1;
+	}
+
+	sym = strrchr(str, '.');
+	if (strcasecmp(type, "FILE") == 0 ||
+	    (/*
+	      * GNU nm prior to binutils commit 552e55ed06 (expected to
+	      * appear in 2.27) doesn't produce a type for EFI binaries.
+	      */
+	     input_format == fmt_sysv && !*type && stype == '?' && sym &&
+	     sym[1] && strchr("cSsoh", sym[1]) && !sym[2])) {
+		free(filename);
+		//filename = *str ? strdup(str) : NULL;
+		goto skip_tail;
+	}
+
+	/*
+	 * Keep all symbols relative to TEXT_BASE, it gets added back at runtime.
+	 * this simplifies handling relocation.
+	 */
+	s->addr -= CONFIG_TEXT_BASE;
+
+	rc = -1;
+
+	sym = str;
+	/* skip prefix char */
+	if (symbol_prefix_char && str[0] == symbol_prefix_char)
+		sym++;
+
+	/* Ignore most absolute/undefined (?) symbols. */
+	if (strcmp(sym, "_stext") == 0)
+		_stext = s->addr;
+	else if (strcmp(sym, "_etext") == 0)
+		_etext = s->addr;
+	else if (strcmp(sym, "_sinittext") == 0)
+		_sinittext = s->addr;
+	else if (strcmp(sym, "_einittext") == 0)
+		_einittext = s->addr;
+	else if (strcmp(sym, "_sextratext") == 0)
+		_sextratext = s->addr;
+	else if (strcmp(sym, "_eextratext") == 0)
+		_eextratext = s->addr;
+	else if (toupper((uint8_t)stype) == 'A')
+	{
+		/* Keep these useful absolute symbols */
+		if (strcmp(sym, "__gp"))
+			goto skip_tail;
+	}
+	else if (toupper((uint8_t)stype) == 'U' ||
+		 toupper((uint8_t)stype) == 'N' ||
+		 is_arm_mapping_symbol(sym))
+		goto skip_tail;
+	/* exclude also MIPS ELF local symbols ($L123 instead of .L123) */
+	else if (str[0] == '$')
+		goto skip_tail;
+
+	/* include the type field in the symbol name, so that it gets
+	 * compressed together */
+	s->len = strlen(str) + 1;
+	if (islower((unsigned char)stype) && filename)
+		s->len += strlen(filename) + 1;
+	s->sym = malloc(s->len + 1);
+	sym = SYMBOL_NAME(s);
+	if (islower((unsigned char)stype) && filename) {
+		sym = stpcpy(sym, filename);
+		*sym++ = ':';
+	}
+	strcpy(sym, str);
+	if (sort_by_name || map_only) {
+		s->orig_symbol = strdup(SYMBOL_NAME(s));
+		s->type = stype; /* As s->sym[0] ends mangled. */
+	}
+	s->sym[0] = stype;
+	rc = 0;
+
+ skip_tail:
+	if ((input_format == fmt_sysv) && fgets(str, 500, in) == NULL)
+		/* ignore errors while discarding rest of line */;
+
+	return rc;
+}
+
+static int symbol_valid(struct sym_entry *s)
+{
+	int offset = 1;
+
+	/* skip prefix char */
+	if (symbol_prefix_char && *(s->sym + 1) == symbol_prefix_char)
+		offset++;
+
+	/* if --all-symbols is not specified, then symbols outside the text
+	 * and inittext sections are discarded */
+	if (!all_symbols) {
+		if ((s->addr < _stext || s->addr > _etext)
+		    && (s->addr < _sinittext || s->addr > _einittext)
+		    && (s->addr < _sextratext || s->addr > _eextratext))
+			return 0;
+		/* Corner case.  Discard any symbols with the same value as
+		 * _etext _einittext or _eextratext; they can move between pass
+		 * 1 and 2 when the symbols data are added.  If these symbols
+		 * move then they may get dropped in pass 2, which breaks the
+		 * symbols rules.
+		 */
+		if ((s->addr == _etext && strcmp((char*)s->sym + offset, "_etext")) ||
+		    (s->addr == _einittext && strcmp((char*)s->sym + offset, "_einittext")) ||
+		    (s->addr == _eextratext && strcmp((char*)s->sym + offset, "_eextratext")))
+			return 0;
+	}
+
+	/* Exclude symbols which vary between passes. */
+	if (strstr((char *)s->sym + offset, "_compiled."))
+		return 0;
+
+	return 1;
+}
+
+static void read_map(FILE *in)
+{
+	while (!feof(in)) {
+		if (table_cnt >= table_size) {
+			table_size += 10000;
+			table = realloc(table, sizeof(*table) * table_size);
+			if (!table) {
+				fprintf(stderr, "out of memory\n");
+				exit (1);
+			}
+		}
+		if (read_symbol(in, &table[table_cnt]) == 0)
+			table_cnt++;
+	}
+}
+
+static void output_label(char *label)
+{
+	if (symbol_prefix_char)
+		printf(".globl %c%s\n", symbol_prefix_char, label);
+	else
+		printf(".globl %s\n", label);
+	printf("\t.align 8\n");
+	if (symbol_prefix_char)
+		printf("%c%s:\n", symbol_prefix_char, label);
+	else
+		printf("%s:\n", label);
+}
+
+/* uncompress a compressed symbol. When this function is called, the best table
+ * might still be compressed itself, so the function needs to be recursive */
+static int expand_symbol(unsigned char *data, int len, char *result)
+{
+	int c, rlen, total=0;
+
+	while (len) {
+		c = *data;
+		/* if the table holds a single char that is the same as the one
+		 * we are looking for, then end the search */
+		if (best_table[c][0]==c && best_table_len[c]==1) {
+			*result++ = c;
+			total++;
+		} else {
+			/* if not, recurse and expand */
+			rlen = expand_symbol(best_table[c], best_table_len[c], result);
+			total += rlen;
+			result += rlen;
+		}
+		data++;
+		len--;
+	}
+	*result=0;
+
+	return total;
+}
+
+/* Sort by original (non mangled) symbol name, then type. */
+static int compare_name_orig(const void *p1, const void *p2)
+{
+	const struct sym_entry *sym1 = p1;
+	const struct sym_entry *sym2 = p2;
+	int rc;
+
+	rc = strcmp(sym1->orig_symbol, sym2->orig_symbol);
+
+	if (!rc)
+		rc = sym1->type - sym2->type;
+
+	return rc;
+}
+
+static void write_src(void)
+{
+	unsigned int i, k, off;
+	unsigned int best_idx[256];
+	unsigned int *markers;
+	char buf[KSYM_NAME_LEN+1];
+
+	if (map_only) {
+		for (i = 0; i < table_cnt; i++)
+			printf("%#llx %c %s\n", table[i].addr, table[i].type,
+						table[i].orig_symbol);
+
+		return;
+	}
+	printf("\t.section .rodata, \"a\"\n");
+
+	output_label("symbols_offsets");
+	for (i = 0; i < table_cnt; i++) {
+		printf("\t.quad\t%#llx\n", table[i].addr);
+	}
+	printf("\n");
+
+	output_label("symbols_num_syms");
+	printf("\t.long\t%d\n", table_cnt);
+	printf("\n");
+
+	/* table of offset markers, that give the offset in the compressed stream
+	 * every 256 symbols */
+	markers = (unsigned int *) malloc(sizeof(unsigned int) * ((table_cnt + 255) / 256));
+
+	output_label("symbols_names");
+	off = 0;
+	for (i = 0; i < table_cnt; i++) {
+		if ((i & 0xFF) == 0)
+			markers[i >> 8] = off;
+
+		printf("\t.byte 0x%02x", table[i].len);
+		for (k = 0; k < table[i].len; k++)
+			printf(", 0x%02x", table[i].sym[k]);
+		printf("\n");
+
+		table[i].stream_offset = off;
+		off += table[i].len + 1;
+	}
+	printf("\n");
+
+	output_label("symbols_markers");
+	for (i = 0; i < ((table_cnt + 255) >> 8); i++)
+		printf("\t.long\t%d\n", markers[i]);
+	printf("\n");
+
+
+	output_label("symbols_token_table");
+	off = 0;
+	for (i = 0; i < 256; i++) {
+		best_idx[i] = off;
+		expand_symbol(best_table[i], best_table_len[i], buf);
+		printf("\t.asciz\t\"%s\"\n", buf);
+		off += strlen(buf) + 1;
+	}
+	printf("\n");
+
+	output_label("symbols_token_index");
+	for (i = 0; i < 256; i++)
+		printf("\t.short\t%d\n", best_idx[i]);
+	printf("\n");
+
+	if (!sort_by_name) {
+		free(markers);
+		return;
+	}
+
+	/* Sorted by original symbol names and type. */
+	qsort(table, table_cnt, sizeof(*table), compare_name_orig);
+
+	output_label("symbols_sorted_offsets");
+	/* A fixed sized array with two entries: offset in the
+	 * compressed stream (for symbol name), and offset in
+	 * symbols_addresses (or symbols_offset). */
+	for (i = 0; i < table_cnt; i++) {
+		printf("\t.long %u, %u\n", table[i].stream_offset, table[i].addr_idx);
+	}
+	printf("\n");
+
+	free(markers);
+}
+
+
+/* table lookup compression functions */
+
+/* count all the possible tokens in a symbol */
+static void learn_symbol(unsigned char *symbol, int len)
+{
+	int i;
+
+	for (i = 0; i < len - 1; i++)
+		token_profit[ symbol[i] + (symbol[i + 1] << 8) ]++;
+}
+
+/* decrease the count for all the possible tokens in a symbol */
+static void forget_symbol(unsigned char *symbol, int len)
+{
+	int i;
+
+	for (i = 0; i < len - 1; i++)
+		token_profit[ symbol[i] + (symbol[i + 1] << 8) ]--;
+}
+
+/* remove all the invalid symbols from the table and do the initial token count */
+static void build_initial_tok_table(void)
+{
+	unsigned int i, pos;
+
+	pos = 0;
+	for (i = 0; i < table_cnt; i++) {
+		if ( symbol_valid(&table[i]) ) {
+			if (pos != i)
+				table[pos] = table[i];
+			learn_symbol(table[pos].sym, table[pos].len);
+			pos++;
+		}
+	}
+	table_cnt = pos;
+}
+
+static void *memmem_pvt(void *h, size_t hlen, void *n, size_t nlen)
+{
+	char *p;
+	for (p = h; (p - (char *)h) <= (long)(hlen - nlen); p++)
+		if (!memcmp(p, n, nlen)) return p;
+	return NULL;
+}
+
+/* replace a given token in all the valid symbols. Use the sampled symbols
+ * to update the counts */
+static void compress_symbols(unsigned char *str, int idx)
+{
+	unsigned int i, len, size;
+	unsigned char *p1, *p2;
+
+	for (i = 0; i < table_cnt; i++) {
+
+		len = table[i].len;
+		p1 = table[i].sym;
+
+		table[i].addr_idx = i;
+		/* find the token on the symbol */
+		p2 = memmem_pvt(p1, len, str, 2);
+		if (!p2) continue;
+
+		/* decrease the counts for this symbol's tokens */
+		forget_symbol(table[i].sym, len);
+
+		size = len;
+
+		do {
+			*p2 = idx;
+			p2++;
+			size -= (p2 - p1);
+			memmove(p2, p2 + 1, size);
+			p1 = p2;
+			len--;
+
+			if (size < 2) break;
+
+			/* find the token on the symbol */
+			p2 = memmem_pvt(p1, size, str, 2);
+
+		} while (p2);
+
+		table[i].len = len;
+
+		/* increase the counts for this symbol's new tokens */
+		learn_symbol(table[i].sym, len);
+	}
+}
+
+/* search the token with the maximum profit */
+static int find_best_token(void)
+{
+	int i, best, bestprofit;
+
+	bestprofit=-10000;
+	best = 0;
+
+	for (i = 0; i < 0x10000; i++) {
+		if (token_profit[i] > bestprofit) {
+			best = i;
+			bestprofit = token_profit[i];
+		}
+	}
+	return best;
+}
+
+/* this is the core of the algorithm: calculate the "best" table */
+static void optimize_result(void)
+{
+	int i, best;
+
+	/* using the '\0' symbol last allows compress_symbols to use standard
+	 * fast string functions */
+	for (i = 255; i >= 0; i--) {
+
+		/* if this table slot is empty (it is not used by an actual
+		 * original char code */
+		if (!best_table_len[i]) {
+
+			/* find the token with the breates profit value */
+			best = find_best_token();
+			if (token_profit[best] == 0)
+			        break;
+
+			/* place it in the "best" table */
+			best_table_len[i] = 2;
+			best_table[i][0] = best & 0xFF;
+			best_table[i][1] = (best >> 8) & 0xFF;
+
+			/* replace this token in all the valid symbols */
+			compress_symbols(best_table[i], i);
+		}
+	}
+}
+
+/* start by placing the symbols that are actually used on the table */
+static void insert_real_symbols_in_table(void)
+{
+	unsigned int i, j, c;
+
+	memset(best_table, 0, sizeof(best_table));
+	memset(best_table_len, 0, sizeof(best_table_len));
+
+	for (i = 0; i < table_cnt; i++) {
+		for (j = 0; j < table[i].len; j++) {
+			c = table[i].sym[j];
+			best_table[c][0]=c;
+			best_table_len[c]=1;
+		}
+	}
+}
+
+static void optimize_token_table(void)
+{
+	build_initial_tok_table();
+
+	insert_real_symbols_in_table();
+
+	/* When valid symbol is not registered, exit to error */
+	if (!table_cnt) {
+		fprintf(stderr, "No valid symbol.\n");
+		exit(1);
+	}
+
+	optimize_result();
+}
+
+static int compare_value(const void *p1, const void *p2)
+{
+	const struct sym_entry *sym1 = p1;
+	const struct sym_entry *sym2 = p2;
+
+	if (sym1->addr < sym2->addr)
+		return -1;
+	if (sym1->addr > sym2->addr)
+		return +1;
+	/* Prefer global symbols. */
+	if (isupper(*sym1->sym))
+		return -1;
+	if (isupper(*sym2->sym))
+		return +1;
+	return 0;
+}
+
+static int compare_name(const void *p1, const void *p2)
+{
+	const struct sym_entry *sym1 = p1;
+	const struct sym_entry *sym2 = p2;
+
+	return strcmp(SYMBOL_NAME(sym1), SYMBOL_NAME(sym2));
+}
+
+int main(int argc, char **argv)
+{
+	unsigned int i;
+	bool unsorted = false, warn_dup = false, error_dup = false, found_dup = false;
+
+	if (argc >= 2) {
+		for (i = 1; i < argc; i++) {
+			if(strcmp(argv[i], "--all-symbols") == 0)
+				all_symbols = 1;
+			else if (strncmp(argv[i], "--symbol-prefix=", 16) == 0) {
+				char *p = &argv[i][16];
+				/* skip quote */
+				if ((*p == '"' && *(p+2) == '"') || (*p == '\'' && *(p+2) == '\''))
+					p++;
+				symbol_prefix_char = *p;
+			} else if (strcmp(argv[i], "--sysv") == 0)
+				input_format = fmt_sysv;
+			else if (strcmp(argv[i], "--sort") == 0)
+				unsorted = true;
+			else if (strcmp(argv[i], "--sort-by-name") == 0)
+				sort_by_name = 1;
+			else if (strcmp(argv[i], "--warn-dup") == 0)
+				warn_dup = true;
+			else if (strcmp(argv[i], "--error-dup") == 0)
+				warn_dup = error_dup = true;
+			else if (strcmp(argv[i], "--xensyms") == 0)
+				map_only = true;
+			else
+				usage();
+		}
+	} else if (argc != 1)
+		usage();
+
+	read_map(stdin);
+
+	if (warn_dup) {
+		qsort(table, table_cnt, sizeof(*table), compare_name);
+		for (i = 1; i < table_cnt; ++i)
+			if (strcmp(SYMBOL_NAME(table + i - 1),
+				   SYMBOL_NAME(table + i)) == 0 &&
+			    table[i - 1].addr != table[i].addr) {
+				fprintf(stderr,
+					"Duplicate symbol '%s' (%llx != %llx)\n",
+					SYMBOL_NAME(table + i),
+					table[i].addr, table[i - 1].addr);
+				found_dup = true;
+			}
+		unsorted = true;
+	}
+
+	if (error_dup && found_dup)
+		exit(1);
+
+	if (unsorted)
+		qsort(table, table_cnt, sizeof(*table), compare_value);
+
+	optimize_token_table();
+	write_src();
+
+	return 0;
+}

-- 
2.50.1

