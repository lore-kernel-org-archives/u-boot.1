Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45751C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 06:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3A182F30;
	Thu,  3 Jul 2025 08:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FB4phmC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 913DB81FEE; Thu,  3 Jul 2025 08:28:27 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9473382E08
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 08:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso52543215e9.2
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 23:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751524105; x=1752128905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwIjXfw10tzvAQDCt9shPWVnIg8BBp5MmBWpMrCnUkE=;
 b=FB4phmC04hYBEtcCLVDoPPwt9RF0nU2KwLsT1qyblJi6QcgXEaL559M7JsIaLBaC85
 Th7G+VDt5A00xRhS5yCmpfpYrjHzifBXG2hZ3805RCtzEn3iFAgtYdgWNXBemhOce8H6
 q6fMYN5pGtW2noYQ6xP1ikLsC5J/szDBcflmkM/FGW3VHS700B893APLuNq+BjF17P8w
 U9+xN4/tYykvtlxpiRKIKhgbXYr9OJruuIZJfLDCL1xbSRM+XTCrt+oqVLjqy9ScF09K
 ao7GJCWqj+9zYsrD3vNqQmzA180SqxvAtFwRBuLxy6Bp1rEL+OpYlI/nJomUrP+ZMQl9
 JQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751524105; x=1752128905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UwIjXfw10tzvAQDCt9shPWVnIg8BBp5MmBWpMrCnUkE=;
 b=dwO878rpRyrBpV2VnEmepPiCx9Hi++wPNgH3IIhQ1sb3KEzzn9ks8x91mhQPKEzdHf
 ui//H25lsroRo1H2WyLAG28FW2s6VOCipDIOGttJDM/qxVR3Mn1VJa/8lCY9udWe/1hn
 lpUiERLoBikA4tHx7/K0t+Q2lNC6+oSOxQnz0JZXl/7tTdMmw1Stkwac+/qpK48cKyr6
 wPd+1Wu/r8XyAJzmczoDNmI3YW59ipHYredAwXAygeN7jywM6X6EVQQ/ieDV3t2azMhM
 MwXF5Z0x+gIlTVvA7H7gHDgVrxDooxHaOqnokVaCJdpl3jCfLnj+YZk8vbc3mJatUrRj
 fdBQ==
X-Gm-Message-State: AOJu0YwUZMoTwEkNbWKNkNDQrbMTRfjNcaVJB0yGiJFv5BkhQyml+9zU
 Mt25y4dEMSQeyX9vOwWqgi7aLF9NtV3gqTegJmaXq1wcgmmrVeOwe8mxWlPdKPtW
X-Gm-Gg: ASbGncspvjCQwHZqPZ0wJyIRDKoR1vtHzbSfxauRX0UxhQjcfGuSL4Sh7Hr9g6j6Af6
 o0ouJIWZJQ87aW9dYW0M4HwVgN0UsetfmdDzdPzpafsqZoHAQt4L9Q6CNHLiC4ly6uq7mAyciHM
 7kcEfD5svbwJaXPq1i047UoK93puk8LNRRRoB0PwSMyHL8PWqQmvhv8UwZ/iSPKypKqT3o+i2Qr
 hrQThqWkvpZ/YTAWNVZ8xm0x7zFN9zqslS9KjQlv7g4GVHGDNyr9ysf6Pt6OVrxlH+ozcOvyZ3V
 odYWZXDKELjKjIMFbvnZrqOqxa7YkOmkO1vQ3Xth5geIH/5IyP/3DNN6b1iHMw==
X-Google-Smtp-Source: AGHT+IH/mepcK+Re4jCTUO8A4KlIhd5cBujdLcOXzffnZaWf5RwttX7Dp6XO+aJHkiQPw7h1hMU79g==
X-Received: by 2002:a05:600c:468b:b0:453:483b:6272 with SMTP id
 5b1f17b1804b1-454ab52041cmr10613055e9.7.1751524104557; 
 Wed, 02 Jul 2025 23:28:24 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bdf038sm17109315e9.27.2025.07.02.23.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 23:28:24 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v8 5/5] efi: selftest: add selftest for EFI_DEBUG_SUPPORT
Date: Thu,  3 Jul 2025 07:28:11 +0100
Message-Id: <20250703062811.72871-6-paulliu@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703062811.72871-1-paulliu@debian.org>
References: <20250703062811.72871-1-paulliu@debian.org>
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

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

Add selftest to check the installed configuration table that has
the correct GUID.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
V7: add selftest for EFI_DEBUG_SUPPORT
V8: refine the selftest.
---
 lib/efi_selftest/Makefile                     |  2 +
 lib/efi_selftest/efi_selftest_debug_support.c | 40 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 lib/efi_selftest/efi_selftest_debug_support.c

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index d78bf7d6191..842433f68aa 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -78,6 +78,8 @@ endif
 
 obj-$(CONFIG_EFI_ESRT) += efi_selftest_esrt.o
 
+obj-$(CONFIG_EFI_DEBUG_SUPPORT) += efi_selftest_debug_support.o
+
 targets += \
 efi_miniapp_file_image_exception.h \
 efi_miniapp_file_image_exit.h \
diff --git a/lib/efi_selftest/efi_selftest_debug_support.c b/lib/efi_selftest/efi_selftest_debug_support.c
new file mode 100644
index 00000000000..9ca8b3f82f5
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_debug_support.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * efi_selftest_debug_support
+ *
+ * Copyright (c) 2025 Ying-Chun Liu, Linaro Ltd. <paul.liu@linaro.org>
+ *
+ * Test the EFI_DEBUG_SUPPORT
+ */
+
+#include <efi_loader.h>
+#include <efi_selftest.h>
+
+/**
+ * efi_st_debug_support_execute() - execute test
+ *
+ * Test EFI_DEBUG_SUPPORT tables.
+ *
+ * Return:	status code
+ */
+static int efi_st_debug_support_execute(void)
+{
+	struct efi_debug_image_info_table_header *efi_st_debug_info_table_header = NULL;
+	efi_guid_t efi_debug_image_info_table_guid = EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
+
+	/* get EFI_DEBUG_IMAGE_INFO_TABLE */
+	efi_st_debug_info_table_header = efi_st_get_config_table(&efi_debug_image_info_table_guid);
+
+	if (!efi_st_debug_info_table_header) {
+		efi_st_error("Missing EFI_DEBUG_IMAGE_INFO_TABLE\n");
+		return EFI_ST_FAILURE;
+	}
+
+	return EFI_ST_SUCCESS;
+}
+
+EFI_UNIT_TEST(debug_support) = {
+	.name = "debug_support",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.execute = efi_st_debug_support_execute,
+};
-- 
2.39.5

