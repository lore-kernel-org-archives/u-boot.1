Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC88D10C11
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B559890BC;
	Mon, 28 Oct 2024 13:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z0ZmT0Yg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B985B8918B; Mon, 28 Oct 2024 13:48:48 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2E8E89177
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so530955166b.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119726; x=1730724526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ywcvnxbO9NAmQMGamrT8PIc2NkOdlvneLwXNTnVojM=;
 b=Z0ZmT0YgQrt9KVFTQMNdgSt5jxCRHASF4HNrv3jC20qRJTINcBSI3BI2HJ/7yaWtXW
 1+nCv9tpdA7IW57YnbDVhBRZplzvlNHdmeTWDz0qju45x+DKqyYth9FvANJR1lX+FRax
 F8kdHgeMYYRxOxChYUrAxsOQ8ORC/JY/6H1ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119726; x=1730724526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ywcvnxbO9NAmQMGamrT8PIc2NkOdlvneLwXNTnVojM=;
 b=Cb+t6FKPf70s+FsNMhkp2UkSLnIMpBXRQMnDs+NS//EjkMdom0QXjZH7nNg4XnfpQT
 J0hflecSk1jeyGMCE/vmY0whLOa+zDV7ODv75ZsY5vrVDRB1MJh0s2boM6XEouiaySuL
 9cC5RjKups8Io05H7sAbvbmh37gsnFFDafR/JSU5EnWaQYcXVjAEcv4Qa2YFuLjFd3od
 3ku88x2fmgvSzYp+Ksn8z5HAEZHUK46kM7Hvx5M7C90fDUs1HmsEQ3TSJ8naWZP1ND5N
 HhJMBvPbfSeRjxdl/vM0Ly6WVSGGaujPDxTXwlcoJg2v9p+vkRcg25ndpZsdLIMHSzRy
 0EIw==
X-Gm-Message-State: AOJu0Yw7RXY86rYOGnYswo7V9WnlyFNpVOdfnhc7oIOEpWeSiHQnVmA9
 W9kaNJj/aHk4slvhcgMFtsv3j8vNocaGmh8BXp0aLEoOK8tgKovcBxiVlxsApL7LMUeyPzpiBaO
 RNQ==
X-Google-Smtp-Source: AGHT+IER5XZmXw3z1XINs3VAg31ie1AQ0GI+TY9WysiGzZ2MeDjSfako5OxRKi1QKd8NFwsj28o9nA==
X-Received: by 2002:a17:907:96a6:b0:a9a:3cec:b322 with SMTP id
 a640c23a62f3a-a9de615a8cfmr763331866b.45.1730119725716; 
 Mon, 28 Oct 2024 05:48:45 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 13/15] test: efi_loader: Add a simple test for the EFI log
Date: Mon, 28 Oct 2024 13:48:04 +0100
Message-ID: <20241028124815.47262-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
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

Create a test which does some sample calls and checks the output.

Expand the size of the sandbox bloblist to accommodate the log.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS               |  1 +
 configs/sandbox_defconfig |  3 +++
 lib/efi_loader/efi_log.c  |  7 +++---
 test/lib/Makefile         |  1 +
 test/lib/efi_log.c        | 49 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 57 insertions(+), 4 deletions(-)
 create mode 100644 test/lib/efi_log.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ade0ca4bc3..3e571174ad5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1072,6 +1072,7 @@ M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	include/efi_log.h
 F:	lib/efi_loader/efi_log.c
+F:	test/lib/efi_log.c
 
 EFI PAYLOAD
 M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index d111858082d..afba6c78e28 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -17,6 +17,7 @@ CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_EFI_CAPSULE_AUTHENTICATE=y
 CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
+CONFIG_EFI_LOG=y
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_RSASSA_PSS=y
@@ -50,6 +51,7 @@ CONFIG_LOG_DEFAULT_LEVEL=6
 CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_STACKPROTECTOR=y
+CONFIG_BLOBLIST_SIZE_RELOC=0x5000
 CONFIG_CMD_CPU=y
 CONFIG_CMD_LICENSE=y
 CONFIG_CMD_SMBIOS=y
@@ -72,6 +74,7 @@ CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_LOOPW=y
 CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MEM_SEARCH=y
 CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MEMTEST=y
diff --git a/lib/efi_loader/efi_log.c b/lib/efi_loader/efi_log.c
index 01e495d3995..780860d8b2f 100644
--- a/lib/efi_loader/efi_log.c
+++ b/lib/efi_loader/efi_log.c
@@ -129,6 +129,7 @@ int efi_logs_testing(enum efil_test_t enum_val, efi_uintn_t int_val,
 	if (ret < 0)
 		return ret;
 
+	rec->enum_val = enum_val;
 	rec->int_val = int_val;
 	rec->buffer = buffer;
 	rec->memory = memory;
@@ -194,10 +195,8 @@ void show_rec(int seq, struct efil_rec_hdr *rec_hdr)
 		show_addr("buf", map_to_sysmem(rec->buffer));
 		show_addr("mem", map_to_sysmem(rec->memory));
 		if (rec_hdr->ended) {
-			show_addr("*buf",
-				  (ulong)map_to_sysmem((void *)rec->e_buffer));
-			show_addr("*mem",
-				  (ulong)rec->e_memory);
+			show_addr("*buf", (ulong)map_to_sysmem(rec->e_buffer));
+			show_addr("*mem", (ulong)rec->e_memory);
 			show_ret(rec_hdr->e_ret);
 		}
 	}
diff --git a/test/lib/Makefile b/test/lib/Makefile
index 217c3baf881..050eaef4bb9 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -11,6 +11,7 @@ obj-y += abuf.o
 obj-y += alist.o
 obj-$(CONFIG_EFI_LOADER) += efi_device_path.o
 obj-$(CONFIG_EFI_SECURE_BOOT) += efi_image_region.o
+obj-$(CONFIG_EFI_LOG) += efi_log.o
 obj-y += hexdump.o
 obj-$(CONFIG_SANDBOX) += kconfig.o
 obj-y += lmb.o
diff --git a/test/lib/efi_log.c b/test/lib/efi_log.c
new file mode 100644
index 00000000000..414b7081bd9
--- /dev/null
+++ b/test/lib/efi_log.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <efi_log.h>
+#include <mapmem.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* basic test of logging */
+static int lib_test_efi_log_base(struct unit_test_state *uts)
+{
+	void **buf = map_sysmem(0x1000, 0);
+	u64 *addr = map_sysmem(0x1010, 0);
+	int ofs1, ofs2;
+
+	ut_assertok(efi_log_reset());
+
+	ofs1 = efi_logs_testing(EFI_LOG_TEST0, 123, &buf[0], &addr[0]);
+
+	ofs2 = efi_logs_testing(EFI_LOG_TEST1, 456, &buf[1], &addr[1]);
+
+	/* simulate an EFI call setting the return values */
+	addr[0] = 0x100;
+	buf[0] = map_sysmem(0x1100, 0);
+	addr[1] = 0x200;
+	buf[1] = map_sysmem(0x1200, 0);
+
+	ut_assertok(efi_loge_testing(ofs2, EFI_LOAD_ERROR));
+	ut_assertok(efi_loge_testing(ofs1, EFI_SUCCESS));
+
+	ut_assertok(efi_log_show());
+	ut_assert_nextline("EFI log (size 98)");
+	ut_assert_nextline(
+		"  0      testing test0 int 7b/123 buf 1000 mem 1010 *buf 1100 *mem 100 ret OK");
+	ut_assert_nextline(
+		"  1      testing test1 int 1c8/456 buf 1008 mem 1018 *buf 1200 *mem 200 ret load");
+	ut_assert_nextline("2 records");
+	ut_assert_console_end();
+
+	unmap_sysmem(buf);
+	unmap_sysmem(addr);
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_log_base, UTF_CONSOLE);
-- 
2.43.0

