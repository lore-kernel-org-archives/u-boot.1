Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D07D4978F
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 00:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACF26893C9;
	Mon,  2 Dec 2024 01:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bvghjVvF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B82CE8916D; Mon,  2 Dec 2024 01:13:09 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C924893BF
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 01:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ea462a98b9so1870900b6e.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 16:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733098385; x=1733703185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pd58uXNLqjp5bBdpbCaSuvMYjG54PksUIKSeIZTNMXY=;
 b=bvghjVvF9cHiIi1LzA3lQlTe28bgbP/A/VwGODMF5fCfDri+njggDKlXbNuwSZmYoF
 vhys1C6Y5WP2rfSjiTMSHMnLLi0WNfhmCeKjut7YRWYP8ghwHR9+Wl0j3saOQW4A5wEF
 5WeBfKbpKvLPiqDvZXVPI4PR+HJKeFqJoruvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733098385; x=1733703185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pd58uXNLqjp5bBdpbCaSuvMYjG54PksUIKSeIZTNMXY=;
 b=BecrtxCy5tfZTJD+GWSYj9FXcve+CDVQvS/d0/UFXXJOlBC2RM9nMPBRKCi5o3NbaR
 mnM7Cck/x4gkjXkutgDHDZAJ4uYTwS6zAnuupChwsZKYi2YfaC2Km5Rcj0YX2pT5iTaM
 y5qdG9HJIMIKRe7bGPCPJ4bUH4gYJtDhirZJK2JlNJeZNfXOs+//Qz/3DYtusBDBS/sG
 DE/XzZfH5nyuSSuuejhbZeASTI7ft4TBbuxC3dOlCcEpODqLDuRoxjLCmnDiWmWrr6AU
 VEIUVjW/4yaY+TvvxeA6efJ4DrXw20trxLXmekCJJ5OdaJePUQ9EQyOWM9FsAWOarUs/
 /SJQ==
X-Gm-Message-State: AOJu0YzhweDxQA85G84iMvte5J1KhAG7gMA9VbfI3Bv77TB9U/9s9l8h
 sGRka1/MKgqdLjOQtZk0fHayFDSaVutsgeZOBJcD31C5CiS2t5Zv2iRSoupXlbxB6NtIm237VtI
 =
X-Gm-Gg: ASbGnctQJA9hunTy8kX7nVyr1rLW2Cd5V+7BqNK4BuL50W2DDan8x5AsQeKI5c/KpWY
 o0IqJxvEW2wEgy6jh/6A79ceFCoVdgtpn/GBCFj9sXX8ojylYN2xN5Bs8czUlNz94t8BvYgT0zq
 kzlRETq/GO95qF3yX+ndotMPlNFqzyJPTgK787+piYc/LmpfeC4a9h2UsPAVsznXHDHdRgHJfBo
 q/onbfa8CoTXjuHCYWHZO1OvTatilcCszOCBi2I1Vsg7Q==
X-Google-Smtp-Source: AGHT+IHfNW59Ebg4jDnxqXwBPVF/6CT6RzDEZQ4jhOoGooVE6acC8g8qUq0VSig4oca/IWjSbnpIiQ==
X-Received: by 2002:a05:6808:19a6:b0:3e6:f30:f8ba with SMTP id
 5614622812f47-3ea6dd47ab5mr16092341b6e.29.1733098385498; 
 Sun, 01 Dec 2024 16:13:05 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e6ef90f5dsm14615fac.51.2024.12.01.16.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 16:13:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 5/7] test: efi_loader: Add a simple test for the EFI log
Date: Sun,  1 Dec 2024 17:12:41 -0700
Message-Id: <20241202001243.1283274-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202001243.1283274-1-sjg@chromium.org>
References: <20241202001243.1283274-1-sjg@chromium.org>
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

(no changes since v1)

 MAINTAINERS               |  1 +
 configs/sandbox_defconfig |  3 +++
 lib/efi_loader/efi_log.c  |  7 +++---
 test/lib/Makefile         |  1 +
 test/lib/efi_log.c        | 49 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 57 insertions(+), 4 deletions(-)
 create mode 100644 test/lib/efi_log.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 890ca4290d3..5e795ce9a4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1080,6 +1080,7 @@ M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	include/efi_log.h
 F:	lib/efi_loader/efi_log.c
+F:	test/lib/efi_log.c
 
 EFI PAYLOAD
 M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 718e4a8283c..3c5954b6c7f 100644
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
@@ -71,6 +73,7 @@ CONFIG_CMD_NVEDIT_LOAD=y
 CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_LOOPW=y
 CONFIG_CMD_MD5SUM=y
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
index f516d001747..3556c4d199c 100644
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
2.34.1

