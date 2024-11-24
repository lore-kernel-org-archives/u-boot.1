Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCACE6780A
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 20:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55950899BE;
	Sun, 24 Nov 2024 21:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dtGddXLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE86F895AD; Sun, 24 Nov 2024 21:27:39 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F25C895B0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so628299866b.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 12:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732480057; x=1733084857; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g24thDeGzFqn4fR2qRDSIk9ZZg63dpkzDzU0hMVE3gE=;
 b=dtGddXLUVyQNsvWbOBHgiZVNsVx+8wGGKFNDXYuE3N0jbdi8d6kcvogLVMPxwxfDE5
 G55amY92IHprKlUkQGJgeN8H54CkKoS7miY5Br46WAL34Xjr+XHk0SPyzQ3AZ3NvinHy
 PGvRsLtgY6BAyqOhkIL4/NVBR/7TrCw8uvXd9AFoMGx0eFBdgL5PxtoVNNlCGbGYnqL0
 HP4DiPLpnrA0PRNs2N59Hu852MkhDD+O3eUmhTjsSEy0Ou04VgTs640BeqXyZoxLqWrx
 igB8dQqJrTDFAu38w+mkzqKQO4N8Nty4w+AkWOYsg5q5PpMjXEXqGVREnUpCWaw2gjAz
 L4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732480057; x=1733084857;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g24thDeGzFqn4fR2qRDSIk9ZZg63dpkzDzU0hMVE3gE=;
 b=clVaMRCcEkz5vyqhumYaL/+0Ir5Tm1rFh3mc7mUhZgDv0YpuT6tQXnrxPRuEue4dlu
 ZcIHBAzNLR19iMaMdNg8qTFV5hKnnRM+PEthbsPFPzLv7nw/rmXFiwvVF4b1pl6GdLLU
 p7hQNC2FD6z8X1hYG6hfdm0Xq62GIK+fP4ehozscnlUQ8jKu/LsVWl9TOVbZCYWt3Lg3
 IxmtCYZeRDIk6DaUxFaHBTu03/T7xL8vdUteKKupsM1CGA3+oIk3ix7D4kZLq9q5N0Jm
 ZsbYtLPqnGm7bOhWbnqJwPeMPl7mx3CDkCX9/ZTHo9Qwpu7yjl2Bg1ZfnLdrEohHsQ4V
 Wr7w==
X-Gm-Message-State: AOJu0YzkF2zWHMV+Rqy12sOP4aTYY2hnLnHs0gIKjUMZnRpTZVwSVk6m
 Fx2kpie9e8s8YJHbSL9j1gEwErbJXkxFWKhHSAWqaGQIxQN1sElxqekyjaw2lNQ=
X-Gm-Gg: ASbGncsypCJf6ifSwmoCCgccsZDfF3bhGcFBEWhG5JALNE5HeeWwrwYuqi8U6Nz82Rl
 nBoVnJNk0nJ9b2G7bG25SmYmiaJY5+kOPTNrI9bjDpnHCaZG1DEgBJuOurFPofCXpDebEwHrexg
 GNEjw4RQeVSwC+YYWlfaldbVdQI+4lrZPlrrUMq5oGuGHbFWt+fX09+xPP2V3PN1ehe2qn7NkUu
 v2B9aw5GT1iPPuXJtKT0KketAmut0HpzlDRbdtZFmodOOlW2BtZdFc8EL0GFVG11ki0
X-Google-Smtp-Source: AGHT+IEionknA6G8n2huyfYJB52WdWT2sCo1P1eg0qxQehkSOit3IztXe6W5j1DVAuzu8zBX2bF01A==
X-Received: by 2002:a17:907:77c5:b0:aa5:11fa:626d with SMTP id
 a640c23a62f3a-aa511fa6426mr722776166b.3.1732480056956; 
 Sun, 24 Nov 2024 12:27:36 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28cda1sm378720666b.9.2024.11.24.12.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 12:27:36 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 21:26:59 +0100
Subject: [PATCH RFC 03/14] efi: move efi_info_get() to a new header file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-efistub-arm64-v1-3-3e33f0340071@linaro.org>
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5761;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=GxRiPAPfDI3V0zydS7anqZn5E0A6kCpt5AK9398JmAk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTnHsPPn9/ul+2Sfq440VMu/Wpzc9iSwIUpehMtWTUdr
 k83ucTXUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACZyWJSRYbOj+qtJMuw//7wy
 bc2pC9U8r3l8W/3T58ocspsPlEsnLmH4K1B1+fGO2SrGzAsO+6693FW2xCpu14I8y5XzzraXW23
 fqwEA
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

Split out the EFI stub specific code to a new efi_stub.h header file.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/x86/cpu/efi/payload.c |  1 +
 cmd/efi.c                  |  1 +
 drivers/video/efi.c        |  1 +
 include/efi.h              | 25 -------------------------
 include/efi_stub.h         | 38 ++++++++++++++++++++++++++++++++++++++
 lib/efi/efi_app.c          |  1 +
 lib/efi/efi_info.c         |  1 +
 lib/efi/efi_stub_arm64.c   |  1 +
 lib/efi/efi_stub_x86.c     |  1 +
 9 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/arch/x86/cpu/efi/payload.c b/arch/x86/cpu/efi/payload.c
index 6845ce72ff94..68cda25aca63 100644
--- a/arch/x86/cpu/efi/payload.c
+++ b/arch/x86/cpu/efi/payload.c
@@ -6,8 +6,9 @@
 
 #include <cpu_func.h>
 #include <efi.h>
 #include <efi_api.h>
+#include <efi_stub.h>
 #include <errno.h>
 #include <event.h>
 #include <init.h>
 #include <log.h>
diff --git a/cmd/efi.c b/cmd/efi.c
index 1fb67a83aae5..53213be0a2fa 100644
--- a/cmd/efi.c
+++ b/cmd/efi.c
@@ -6,8 +6,9 @@
 
 #include <command.h>
 #include <efi.h>
 #include <efi_api.h>
+#include <efi_stub.h>
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
 #include <sort.h>
diff --git a/drivers/video/efi.c b/drivers/video/efi.c
index 78d123fad4be..a7b6d47f9a15 100644
--- a/drivers/video/efi.c
+++ b/drivers/video/efi.c
@@ -8,8 +8,9 @@
 #define LOG_CATEGORY LOGC_EFI
 
 #include <dm.h>
 #include <efi_api.h>
+#include <efi_stub.h>
 #include <log.h>
 #include <vesa.h>
 #include <video.h>
 
diff --git a/include/efi.h b/include/efi.h
index a6eff13a6bbb..933be35852df 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -321,18 +321,8 @@ struct efi_open_protocol_info_entry {
 	u32 attributes;
 	u32 open_count;
 };
 
-enum efi_entry_t {
-	EFIET_END,	/* Signals this is the last (empty) entry */
-	EFIET_MEMORY_MAP,
-	EFIET_GOP_MODE,
-	EFIET_SYS_TABLE,
-
-	/* Number of entries */
-	EFIET_MEMORY_COUNT,
-};
-
 #define EFI_TABLE_VERSION	1
 
 /**
  * struct efi_info_hdr - Header for the EFI info table
@@ -609,23 +599,8 @@ void efi_puts(struct efi_priv *priv, const char *str);
  * @ch:		Character to write (note this is not unicode)
  */
 void efi_putc(struct efi_priv *priv, const char ch);
 
-/**
- * efi_info_get() - get an entry from an EFI table
- *
- * This function is called from U-Boot proper to read information set up by the
- * EFI stub. It can only be used when running from the EFI stub, not when U-Boot
- * is running as an app.
- *
- * @type:	Entry type to search for
- * @datap:	Returns pointer to entry data
- * @sizep:	Returns entry size
- * Return: 0 if OK, -ENODATA if there is no table, -ENOENT if there is no entry
- * of the requested type, -EPROTONOSUPPORT if the table has the wrong version
- */
-int efi_info_get(enum efi_entry_t type, void **datap, int *sizep);
-
 /**
  * efi_store_memory_map() - Collect the memory-map info from EFI
  *
  * Collect the memory info and store it for later use, e.g. in calling
diff --git a/include/efi_stub.h b/include/efi_stub.h
new file mode 100644
index 000000000000..4780badd3ac4
--- /dev/null
+++ b/include/efi_stub.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Helpers for U-Boot running as an EFI payload.
+ *
+ * Copyright (c) 2024 Linaro, Ltd
+ */
+
+#ifndef _EFI_STUB_H
+#define _EFI_STUB_H
+
+#include <linux/types.h>
+
+enum efi_entry_t {
+	EFIET_END,	/* Signals this is the last (empty) entry */
+	EFIET_MEMORY_MAP,
+	EFIET_GOP_MODE,
+	EFIET_SYS_TABLE,
+
+	/* Number of entries */
+	EFIET_MEMORY_COUNT,
+};
+
+/**
+ * efi_info_get() - get an entry from an EFI table
+ *
+ * This function is called from U-Boot proper to read information set up by the
+ * EFI stub. It can only be used when running from the EFI stub, not when U-Boot
+ * is running as an app.
+ *
+ * @type:	Entry type to search for
+ * @datap:	Returns pointer to entry data
+ * @sizep:	Returns entry size
+ * Return: 0 if OK, -ENODATA if there is no table, -ENOENT if there is no entry
+ * of the requested type, -EPROTONOSUPPORT if the table has the wrong version
+ */
+int efi_info_get(enum efi_entry_t type, void **datap, int *sizep);
+
+#endif /* _EFI_STUB_H */
diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
index 9b94a93ee4f1..2c66133648e4 100644
--- a/lib/efi/efi_app.c
+++ b/lib/efi/efi_app.c
@@ -12,8 +12,9 @@
 #include <debug_uart.h>
 #include <dm.h>
 #include <efi.h>
 #include <efi_api.h>
+#include <efi_stub.h>
 #include <errno.h>
 #include <init.h>
 #include <malloc.h>
 #include <sysreset.h>
diff --git a/lib/efi/efi_info.c b/lib/efi/efi_info.c
index 5fa4baeec635..32ba7e499c57 100644
--- a/lib/efi/efi_info.c
+++ b/lib/efi/efi_info.c
@@ -5,8 +5,9 @@
  * Access to the EFI information table
  */
 
 #include <efi.h>
+#include <efi_stub.h>
 #include <errno.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
 
diff --git a/lib/efi/efi_stub_arm64.c b/lib/efi/efi_stub_arm64.c
index 54bee6c55d7e..2cabb16f2414 100644
--- a/lib/efi/efi_stub_arm64.c
+++ b/lib/efi/efi_stub_arm64.c
@@ -11,8 +11,9 @@
 
 #include <debug_uart.h>
 #include <efi.h>
 #include <efi_api.h>
+#include <efi_stub.h>
 #include <malloc.h>
 #include <asm/io.h>
 #include <linux/err.h>
 #include <linux/types.h>
diff --git a/lib/efi/efi_stub_x86.c b/lib/efi/efi_stub_x86.c
index 40fc29d9adf7..ea1993f745d3 100644
--- a/lib/efi/efi_stub_x86.c
+++ b/lib/efi/efi_stub_x86.c
@@ -11,8 +11,9 @@
 
 #include <debug_uart.h>
 #include <efi.h>
 #include <efi_api.h>
+#include <efi_stub.h>
 #include <errno.h>
 #include <malloc.h>
 #include <ns16550.h>
 #include <asm/cpu.h>

-- 
2.47.0

