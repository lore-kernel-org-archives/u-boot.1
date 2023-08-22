Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28ECAEE49A4
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B75A871FC;
	Tue, 22 Aug 2023 05:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GrJ0hZF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBA95871DB; Tue, 22 Aug 2023 05:17:16 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF870871D5
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79210064604so116693439f.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674231; x=1693279031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2dycOpSN/kJqD+T7tdC5LgasU04smWxjQugWw6/3UA=;
 b=GrJ0hZF8FWaRqRkW77d/Dx/ikEI/39RozgaFJvImdskBd32FvawKF7HgZsf6WG0Zlp
 QhUpv1XgL9WDmd8zHlp/Slp/dkDp5VkewlE6xHXLCw9IT/50l/5mX7bYzYooyAYsm1Mp
 03SeiKp/wCpWCmPErhdGLRMpcl5wadewZAGWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674231; x=1693279031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z2dycOpSN/kJqD+T7tdC5LgasU04smWxjQugWw6/3UA=;
 b=PNNhijziXvUqJhjhgiK3BQEnl29Am1sQ/rlru9ZKISg8s1ET25pAoaByWEBmNEBkCi
 r4UbZfZ+AKo0T6C317IQ15gyO3AycIEPEKAWd2Eqkhmiz6+pJHQnmBKRkqEi5peOTTUA
 J/NTbUlZ8FYHKBobHZciV+Z6JtDK2tX7kPqznCzp8PtxDQs7FNRjqYUle7TiJ/AVf1PV
 3bDTLoz2NaHlHYWFSNTtoP6VbWYcpbhMyxC9Hji40MAbWJP7JCHZpnAlS72sXcnGA4Mq
 wpmZkLK01NhcpBBxlXIsw11XzEEg/r7SuDoBRyhL1m1o+X/eSbXRnzKNFZ6FI5XHTuTV
 sjBw==
X-Gm-Message-State: AOJu0YzJIBOx+0/b4q+8azjCVKj5IyDjGsvV95aKE73puuO+jW5VDij0
 R1Y5UTUJryRHhohDD0DRhcb7qfiWY2QZqniDS44=
X-Google-Smtp-Source: AGHT+IE9hTnQUK/Va7FjRTRqJIRX1rJx4TqGCf0yO0mQ17nTt9YYB2LRaGM8nzGRoNbicXsalo9r+g==
X-Received: by 2002:a6b:610a:0:b0:790:b399:3ae9 with SMTP id
 v10-20020a6b610a000000b00790b3993ae9mr11106214iob.14.1692674231583; 
 Mon, 21 Aug 2023 20:17:11 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 02/14] Revert "initcall: Move to inline function"
Date: Mon, 21 Aug 2023 21:16:49 -0600
Message-ID: <20230822031705.1340941-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822031705.1340941-1-sjg@chromium.org>
References: <20230822031705.1340941-1-sjg@chromium.org>
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

Somehow I do not see any inlining with initcalls now. I was sure I saw
it when this commit went in, but now it seems to make things worse.

This reverts commit 47870afab92fca6e672c03d0dea802a55e200675.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/board_r.c   |  5 ++++-
 include/initcall.h | 46 +---------------------------------------
 lib/Makefile       |  1 +
 lib/initcall.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 46 deletions(-)
 create mode 100644 lib/initcall.c

diff --git a/common/board_r.c b/common/board_r.c
index 598155c7753d..85860861f0ac 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -583,7 +583,10 @@ static int run_main_loop(void)
 }
 
 /*
- * We hope to remove most of the driver-related init and do it if/when
+ * Over time we hope to remove these functions with code fragments and
+ * stub functions, and instead call the relevant function directly.
+ *
+ * We also hope to remove most of the driver-related init and do it if/when
  * the driver is later used.
  *
  * TODO: perhaps reset the watchdog in the initcall function after each call?
diff --git a/include/initcall.h b/include/initcall.h
index 69ce26807051..01f3f2833f10 100644
--- a/include/initcall.h
+++ b/include/initcall.h
@@ -8,50 +8,6 @@
 
 typedef int (*init_fnc_t)(void);
 
-#include <log.h>
-#ifdef CONFIG_EFI_APP
-#include <efi.h>
-#endif
-#include <asm/global_data.h>
-
-/*
- * To enable debugging. add #define DEBUG at the top of the including file.
- *
- * To find a symbol, use grep on u-boot.map
- */
-static inline int initcall_run_list(const init_fnc_t init_sequence[])
-{
-	const init_fnc_t *init_fnc_ptr;
-
-	for (init_fnc_ptr = init_sequence; *init_fnc_ptr; ++init_fnc_ptr) {
-		unsigned long reloc_ofs = 0;
-		int ret;
-
-		/*
-		 * Sandbox is relocated by the OS, so symbols always appear at
-		 * the relocated address.
-		 */
-		if (IS_ENABLED(CONFIG_SANDBOX) || (gd->flags & GD_FLG_RELOC))
-			reloc_ofs = gd->reloc_off;
-#ifdef CONFIG_EFI_APP
-		reloc_ofs = (unsigned long)image_base;
-#endif
-		if (reloc_ofs)
-			debug("initcall: %p (relocated to %p)\n",
-					(char *)*init_fnc_ptr - reloc_ofs,
-					(char *)*init_fnc_ptr);
-		else
-			debug("initcall: %p\n", (char *)*init_fnc_ptr - reloc_ofs);
-
-		ret = (*init_fnc_ptr)();
-		if (ret) {
-			printf("initcall sequence %p failed at call %p (err=%d)\n",
-			       init_sequence,
-			       (char *)*init_fnc_ptr - reloc_ofs, ret);
-			return -1;
-		}
-	}
-	return 0;
-}
+int initcall_run_list(const init_fnc_t init_sequence[]);
 
 #endif
diff --git a/lib/Makefile b/lib/Makefile
index 8d8ccc8bbc39..839872d804b5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_GZIP_COMPRESSED) += gzip.o
 obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += smbios.o
 obj-$(CONFIG_SMBIOS_PARSER) += smbios-parser.o
 obj-$(CONFIG_IMAGE_SPARSE) += image-sparse.o
+obj-y += initcall.o
 obj-y += ldiv.o
 obj-$(CONFIG_XXHASH) += xxhash.o
 obj-y += net_utils.o
diff --git a/lib/initcall.c b/lib/initcall.c
new file mode 100644
index 000000000000..eedb0fbf1d5c
--- /dev/null
+++ b/lib/initcall.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2013 The Chromium OS Authors.
+ */
+
+#include <common.h>
+#include <efi.h>
+#include <initcall.h>
+#include <log.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/*
+ * To enable debugging. add #define DEBUG at the top of the including file.
+ *
+ * To find a symbol, use grep on u-boot.map
+ */
+int initcall_run_list(const init_fnc_t init_sequence[])
+{
+	const init_fnc_t *init_fnc_ptr;
+
+	for (init_fnc_ptr = init_sequence; *init_fnc_ptr; ++init_fnc_ptr) {
+		unsigned long reloc_ofs = 0;
+		int ret;
+
+		/*
+		 * Sandbox is relocated by the OS, so symbols always appear at
+		 * the relocated address.
+		 */
+		if (IS_ENABLED(CONFIG_SANDBOX) || (gd->flags & GD_FLG_RELOC))
+			reloc_ofs = gd->reloc_off;
+#ifdef CONFIG_EFI_APP
+		reloc_ofs = (unsigned long)image_base;
+#endif
+		if (reloc_ofs)
+			debug("initcall: %p (relocated to %p)\n",
+			      (char *)*init_fnc_ptr - reloc_ofs,
+			      (char *)*init_fnc_ptr);
+		else
+			debug("initcall: %p\n", (char *)*init_fnc_ptr - reloc_ofs);
+
+		ret = (*init_fnc_ptr)();
+		if (ret) {
+			printf("initcall sequence %p failed at call %p (err=%d)\n",
+			       init_sequence,
+			       (char *)*init_fnc_ptr - reloc_ofs, ret);
+			return -1;
+		}
+	}
+	return 0;
+}
-- 
2.42.0.rc1.204.g551eb34607-goog

