Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDFBD3B7E5
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 15:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A42883B2C;
	Sun, 28 Dec 2025 16:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Mcr+uNEN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF1AE83B2C; Sun, 28 Dec 2025 16:18:39 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABB9483A8C
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 16:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-64b92abe63aso13821923a12.0
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 07:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1766935117; x=1767539917;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IzWNN3kp85CQmQ0rejN0oR/MF5oE71n0kgDVWwkEKm0=;
 b=Mcr+uNENe48yectM0QYZvzFS4kNe1j0JiXcHgY/h00354+g996el7wdlGy61t0+oaN
 VqpUhgPMrvWXzvTdoyICexiS0aHC7Y1lDacZmHm6Rv2bL9gtIJL9ycE8zfGGMIpuhtXL
 kQ8UMGoI8juPizhXQFqfeK3Trb7b0DP8kdu08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766935117; x=1767539917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IzWNN3kp85CQmQ0rejN0oR/MF5oE71n0kgDVWwkEKm0=;
 b=CPD2OIqOL6RiSUnKaSd3ogqoSiVMps2/GVoNifHEWvZ+QFCfZa3cLSgoB3jY5pipa+
 MdeXf0LNyekcVpzkqG9PkT51M46ejhIMB9tMZlt+FYaHVSjA5dXyJgiDQDipcOVehnP2
 8t8b8QHBSRIRc2L5/ZI+e2btJxpvLZazgu2w9Umbf0S/v/rp+Kil10cuIqDgqL3jUtYF
 l5Pn7De9YI+1EX6XljzoIL2mA98b2F/qsvk2/WUUeJmECUe0/vYYgBcWDU7G32ud7xGm
 J2YwuVMA42RkkTs70KloMUqjIm7GDJl0kfu1rGcR/eE1JlKvyAkZEOvNBuW4Kkk1LyUc
 V30A==
X-Gm-Message-State: AOJu0Yz7PZGDyjF5o3ef9tT9qdWRH8GQGJzXmPkSpU80WL76eB0YUv7v
 Z5MQJMnFViHRxQ902kFcM8oVk+CfNMlqA0JKrkgkn0g+E43mXeTGDolctNOZjY3QplWPopd/SFI
 V3dBe
X-Gm-Gg: AY/fxX7o0fUiGsdFtK2AMBc62B+T6KCpxWAzzCiyevccbe2PX2ccihzEx/ALr/4lJf/
 g4qMdxhlcRfAfo5OCbGkvJVLRocp0cG2O1IInBFROmvSDRvjJ23+PD5Ba56+8wuIuOeP29Ac88d
 A5bQlB5Gt8c3nFFg8y22Q+yOyqsdISWu8gkCRstOOAlK7feeHd5QhbHiS48fDA7s1eVrc7YUxjC
 u5Pl18ytmf3+CZMayl6MVs7fX3RzrNS9KYlbotVNB4Gup7zkjyu08LLk9UxRS8xRHZArUIQXgsH
 Xem+jY2Nd/3o42cQ1/AiGhJKZ46Ay1T9V/mbOZyXebndZOS4AlDo7jN+zLxX5myaYrl+3aQljAy
 cGzUsNybf/zhxTaop9/pKrMGlxpuib+mIBqm6Wnk1u5qRNGjt7nsbJLWig0MWcftTxPIXEEPN6b
 2fnxLuDx73UF9muk3fd0ubyf9Y3goZYA1VPlKAjjep4viYtd5/iQr95/Fgj4m7t+7iMbDvKI9cv
 GryfBEWv8Bs2DqSWWbUPS35NpEXj+O7lVfF2wFl3lPj41GnBJ9X4DOB0MAmTP1+sLvC+N8Ebjot
 JkXMUXHVB9I=
X-Google-Smtp-Source: AGHT+IEZ6pYWa92qVbv30Qt/tYdW/WbV2HhSZla87jkUThPm3Z0HKggkAxrNBDWIw6HsnXGPH7rkjA==
X-Received: by 2002:a05:6402:2807:b0:64b:6ebf:b65b with SMTP id
 4fb4d7f45d1cf-64b8e82b993mr28404527a12.5.1766935116837; 
 Sun, 28 Dec 2025 07:18:36 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91494cd7sm28502224a12.16.2025.12.28.07.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 07:18:35 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Daniel Golle <daniel@makrotopia.org>, E Shattow <e@freeshell.de>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Shiji Yang <yangshiji66@outlook.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] tools: Add dumpfwumdata tool for FWU metadata image
Date: Sun, 28 Dec 2025 16:17:54 +0100
Message-ID: <20251228151824.25667-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
References: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
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

Allow reading FWU metadata from userspace.

According to [1], after updating the software on bank B, setting
active_index to point to it (i. e. 1) and marking it as a Valid bank, it
must be possible to read this information from userspace on the next
boot to verify whether the boot chain of bank B succeeded.

The metadata must then be updated again, marking the bank as INVALID if
the active_index points to bank A (i. e. 0) or as VALID if the boot was
successful.

To allow reading the active_index and bank state, this new tool has been
added.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 tools/Kconfig        |   7 +++
 tools/Makefile       |   4 ++
 tools/dumpfwumdata.c | 128 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 tools/dumpfwumdata.c

diff --git a/tools/Kconfig b/tools/Kconfig
index 652b0f225579..9de7eed1bbbb 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -194,6 +194,13 @@ config LUT_SEQUENCE
 	help
 	  Look Up Table Sequence
 
+config TOOLS_DUMPFWUMDATA
+	bool "Build dumpfwumdata command"
+	default y if FWU_MULTI_BANK_UPDATE
+	help
+	  This command allows users to read and display the raw FWU
+	  metadata. The exact access method depends on the platform.
+
 config TOOLS_MKFWUMDATA
 	bool "Build mkfwumdata command"
 	default y if FWU_MULTI_BANK_UPDATE
diff --git a/tools/Makefile b/tools/Makefile
index ae6a30526466..bc105a086927 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -271,6 +271,10 @@ mkeficapsule-objs := generated/lib/uuid.o \
 	mkeficapsule.o
 hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
 
+dumpfwumdata-objs := dumpfwumdata.o generated/lib/crc32.o
+HOSTLDLIBS_dumpfwumdata += -luuid
+hostprogs-$(CONFIG_TOOLS_DUMPFWUMDATA) += dumpfwumdata
+
 mkfwumdata-objs := mkfwumdata.o generated/lib/crc32.o
 HOSTLDLIBS_mkfwumdata += -luuid
 hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) += mkfwumdata
diff --git a/tools/dumpfwumdata.c b/tools/dumpfwumdata.c
new file mode 100644
index 000000000000..4965484df1be
--- /dev/null
+++ b/tools/dumpfwumdata.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025, Amarula Solutions
+ */
+
+#include <errno.h>
+#include <getopt.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <generated/autoconf.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <u-boot/crc.h>
+#include <uuid/uuid.h>
+
+typedef uint8_t u8;
+typedef int16_t s16;
+typedef uint16_t u16;
+typedef uint32_t u32;
+typedef uint64_t u64;
+
+#undef CONFIG_FWU_NUM_BANKS
+#undef CONFIG_FWU_NUM_IMAGES_PER_BANK
+
+/* This will dynamically allocate the fwu_mdata */
+#define CONFIG_FWU_NUM_BANKS		0
+#define CONFIG_FWU_NUM_IMAGES_PER_BANK	0
+
+#include <fwu_mdata.h>
+
+static const char *opts_short = "h";
+
+static struct option options[] = {
+	{"help", no_argument, NULL, 'h'},
+	{NULL, 0, NULL, 0},
+};
+
+static void print_usage(void)
+{
+	fprintf(stderr, "Usage: dumpfwumdata [options] <fwumdata file>\n");
+	fprintf(stderr, "Options:\n"
+		"\t-h, --help                  print a help message\n"
+		);
+}
+
+static void print_mdata(struct fwu_mdata *data)
+{
+	int i;
+
+	fprintf(stdout, "FWU Metadata\n");
+	fprintf(stdout, "crc32: %#x\n", data->crc32);
+	fprintf(stdout, "version: %#x\n", data->version);
+	fprintf(stdout, "active_index: %#x\n", data->active_index);
+	fprintf(stdout, "previous_active_index: %#x\n",
+		data->previous_active_index);
+
+	if (data->version == 2) {
+		uint8_t state;
+		char cstate;
+		for (i = 0; i < 4; i++) {
+			state = data->bank_state[i];
+			if (state == FWU_BANK_ACCEPTED)
+				cstate = 'A';
+			else if (state == FWU_BANK_VALID)
+				cstate = 'V';
+			else if (state == FWU_BANK_INVALID)
+				cstate = 'I';
+			else
+				cstate = '?';
+
+			printf("bank_state[%d]: %c\n", i, cstate);
+		}
+	}
+}
+
+static int fwu_read_mdata(struct fwu_mdata *mdata, const char *mdata_file)
+{
+	FILE *mfile = NULL;
+	size_t ret, size = sizeof(struct fwu_mdata);
+
+	mfile = fopen(mdata_file, "r");
+	if (!mfile) {
+		fprintf(stderr, "Error: Failed to open %s\n",
+			mdata_file);
+		return -1;
+	}
+
+	ret = fread(mdata, 1, size, mfile);
+	fclose(mfile);
+	if (ret != size) {
+		fprintf(stderr, "Error: Failed to read from %s\n",
+			mdata_file);
+		return -1;
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int c, ret;
+	struct fwu_mdata mdata;
+
+	if (argc < 3) {
+		print_usage();
+		return -EINVAL;
+	}
+
+	do {
+		c = getopt_long(argc, argv, opts_short, options, NULL);
+		switch (c) {
+		case 'h':
+			print_usage();
+			return 0;
+		}
+	} while (c != -1);
+
+	ret = fwu_read_mdata(&mdata, argv[argc - 1]);
+	if (ret)
+		return ret;
+
+	print_mdata(&mdata);
+	return 0;
+}
-- 
2.43.0

