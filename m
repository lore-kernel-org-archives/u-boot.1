Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C400C3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 16:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC86188722;
	Wed, 10 Jul 2024 18:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DhmxlI2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF42E8871A; Wed, 10 Jul 2024 18:26:45 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56ED388714
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 18:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5957040e32aso1388650a12.2
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 09:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720628802; x=1721233602; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=brbG/MV9YdWbRTNa+TEXpoX8MmNZWhcXqEJNVqdCH+M=;
 b=DhmxlI2vL+iMJWpqY0ZO5aeDE31AXKezH2fSF88Zho2pmE0FnOoT20Q3HuAfDAf7YL
 DA/iCW+1ohSNxPYA4zWieMb7rwgPtio9b9Y2ZcH2I2+YP3IDwHxKFanzcX1R3vqD+Sej
 9pyRokZrvChyZJYKu4sVDXkY1ZGClluM1ph7WsxRCmbC8UwYpbfdc/RiW/o84n7bP+eB
 LZkBfPTppbiIo7EH12y4RGFk1FYKM9RYtftMBMGhRtVDNrC5pxtxojS6IwkCQg43HNB6
 xKo+k6NI2rhyVBmj3eL445ma+81ygEAMx8YdpfS5IqPtkND0NjywEwAIjHjX7pEh51WC
 Dr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720628802; x=1721233602;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brbG/MV9YdWbRTNa+TEXpoX8MmNZWhcXqEJNVqdCH+M=;
 b=a7jKHsQX+qPmbNE8LHDSdS5bBR1WiEXQ0zk1sBMR0Bx77oR8y9R0qkjo/RiEyNQNhQ
 Jg9lp88WTRa80IHc1kjnQR2mF/MyS781JA+3bNY6m/IOutRq5tu1FofD51glh6m2SozR
 1O6eS5ujjv9O7ALzz/nEZHDccPqPN0UyG3CrDqkzVINDKJy816XWeCzDksqnVkkxYzza
 1gJI6CDfM5JEN+MQpZrjLEaH5JlPNwPrXPrhMPihBm5LqHd1P0NLV3HBdf90MZrnpNYW
 4yJRUK7WRphOkBbBpgF+s/+V8hr54eLLE6N/d6bIRCub7sPZsUWd4TdnBFTd4gGTrOAn
 HEug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUauBLwKP7bZNTr7lHkTrjmj1Bg8QVK+xNJdmnV3sZZFDx4NlIawF8d2nQCwgG64TPUlEfGy4N0aemPEXhS0IAvRQ1oCg==
X-Gm-Message-State: AOJu0YwrYCinw0a6mcj+jHonAnvRFhJlPwAp7H2L5MRuiWE5J8t1M9cb
 nUDZUXibrNrx2UuZD0bxNG2cewjc7bnt63h/39OI2qH1KomqdHQkZiJBCcUisaOQbThH03PbVLZ
 A
X-Google-Smtp-Source: AGHT+IFM88wkTzdDVMMALeOvUXQeXd30+jo24Ouxrp6xqWKTylFR8E7g4W8jfR3Gk30f3/gPxTszxA==
X-Received: by 2002:a05:6402:510c:b0:58c:15a5:3e12 with SMTP id
 4fb4d7f45d1cf-594bcba84c9mr6020866a12.38.1720628802040; 
 Wed, 10 Jul 2024 09:26:42 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bc4e8255sm2370348a12.48.2024.07.10.09.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 09:26:41 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 10 Jul 2024 18:26:19 +0200
Subject: [PATCH RFC 2/3] add support for symbol lookups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-arm64-backtrace-v1-2-5a2ba50485dd@linaro.org>
References: <20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org>
In-Reply-To: <20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=25535;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=BOiWkWiqsDHdqQkSvXPC5VAPy6/4ysfdAK/inm7t2l8=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjrY+6iKIe11qR1cqcXSaYbGNWGSLtpWEp56oI
 OH522lvv62JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo62PgAKCRAFgzErGV9k
 trOZD/98yVHtQJaXmS+nzzlsoqEihFDflwDtGy12PlJFxOxSfmhWHrKn9YZtBRtOVqqYylBbejf
 n0DK+hYYjIFVGDR9WNMWju+/VO1Le2rmxHFBdPZQbkFc9Q5/xdyR60W/c8EbJprtWKK6Gy73G9o
 yQS+CZxPKHasooll+xZVGTU1Vl90lle72ZvC/KhC/ors7oVbJ04aDB9HpO2sP507iaHOCdqvxHh
 GBeB++2NMjfIRQ/nVBJlj1O8xdkQM/45pdZBGDl1vu4OcqMj55bH7wztSYREA02bTpM497HQOd1
 0lpZ6zEQqPHRQFop22rvESt6ZiyOoElVTt3XvzWAu+JFG4LXVPfc4hK0IHUxZSWDx/JW9d5Dxdl
 MzZ0lWlKyHDPA25Vy7o04jOdDS/vgmMDE78M83JYeqw16/FU1ZzyStl174q+22gxttuqRAPdpe/
 Ucen1eCgVRecuVYW92J//vewpS8F0CpZeW4p/IBITPlYdXvKyKExI3Tqgjmu4QSnsJJTm7jTZDe
 7BoYXXSYx2krkycTV+6i9DUhGll4jnkU2VVfQTCDJpesIswoaUdjlHeos4zCqGol5oDPW/meEvO
 4uiXxKL9uPv6tL7MWzyljzKkeoGyoDnZEBZr17+8yGbARtErbfwmuYGp44/c4TpNnOdAT7kL/AP
 OIEeZkF3db+/unA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 Makefile          |  15 +-
 include/symbols.h |  19 ++
 lib/Kconfig       |   6 +
 lib/Makefile      |   1 +
 lib/symbols.c     | 126 +++++++++++
 tools/Makefile    |   3 +
 tools/symbols.c   | 646 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 815 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index fcb9565d2fff..ae899fe97724 100644
--- a/Makefile
+++ b/Makefile
@@ -1781,16 +1781,29 @@ quiet_cmd_u-boot__ ?= LD      $@
       cmd_u-boot__ ?= $(LD) $(KBUILD_LDFLAGS) $(LDFLAGS_u-boot) -o $@		\
 		-T u-boot.lds $(u-boot-init)					\
 		--whole-archive							\
 			$(u-boot-main)						\
+			$(if $(shell [ "$@" = "u-boot" ] && echo "true"),lib/symbols.o u-boot.sym.o,)			\
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
index 000000000000..b17f122be339
--- /dev/null
+++ b/include/symbols.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#include <string.h>
+#include <asm/types.h>
+
+#define KSYM_NAME_LEN 127
+
+#if IS_ENABLED(CONFIG_SYMBOL_LOOKUP)
+const char * __attribute__((weak)) symbols_lookup(unsigned long addr, unsigned long *symaddr, unsigned long *offset,
+			   char *namebuf);
+#else
+static inline const char *symbols_lookup(unsigned long addr, unsigned long *symaddr, unsigned long *offset,
+			   char *namebuf)
+{
+	strcpy(namebuf, "???");
+	namebuf[3] = '\0';
+	return namebuf;
+}
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index b3baa4b85b07..06a78f83b7d6 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -977,8 +977,14 @@ config VPL_OF_LIBFDT_ASSUME_MASK
 	  are made, and libfdt is able to deal with malicious data. A value of
 	  0xff means all assumptions are made and any invalid data may cause
 	  unsafe execution. See FDT_ASSUME_PERFECT, etc. in libfdt_internal.h
 
+config SYMBOL_LOOKUP
+	bool "Enable symbol lookup"
+	help
+	  This enables support for looking up symbol names from addresses. The
+	  primary usecase for this is improved debugging support.
+
 menu "System tables"
 	depends on (!EFI && !SYS_COREBOOT) || (ARM && EFI_LOADER)
 
 config BLOBLIST_TABLES
diff --git a/lib/Makefile b/lib/Makefile
index e389ad014f89..a4ccda76f438 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -121,8 +121,9 @@ obj-y += linux_string.o
 obj-$(CONFIG_LMB) += lmb.o
 obj-y += membuff.o
 obj-$(CONFIG_REGEX) += slre.o
 obj-y += string.o
+#obj-y += symbols.o
 obj-y += tables_csum.o
 obj-y += time.o
 obj-y += hexdump.o
 obj-$(CONFIG_GETOPT) += getopt.o
diff --git a/lib/symbols.c b/lib/symbols.c
new file mode 100644
index 000000000000..e881d5603425
--- /dev/null
+++ b/lib/symbols.c
@@ -0,0 +1,126 @@
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
+DECLARE_GLOBAL_DATA_PTR;
+
+/* expand a compressed symbol data into the resulting uncompressed string,
+   given the offset to where the symbol is in the compressed stream */
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
+const char *symbols_lookup(unsigned long addr, unsigned long *symaddr, unsigned long *offset, char *namebuf)
+{
+	unsigned long low, high, mid;
+
+	addr -= (unsigned long)_start;
+
+	namebuf[KSYM_NAME_LEN] = 0;
+	namebuf[0] = 0;
+
+	/* do a binary search on the sorted symbols_addresses array */
+	low = 0;
+	high = symbols_num_syms;
+
+	while (high - low > 1) {
+		mid = (low + high) / 2;
+		if (symbols_address(mid) <= addr) {
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
+	*symaddr = symbols_address(low);
+	*offset = addr - symbols_address(low);
+	return namebuf;
+}
diff --git a/tools/Makefile b/tools/Makefile
index 6a4280e3668f..278539ea77be 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -225,8 +225,11 @@ hostprogs-$(CONFIG_ARCH_MVEBU) += kwboot
 
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
2.45.2

