Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B880EC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ED5983281;
	Fri, 23 May 2025 15:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ksH/Zg4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CDB683236; Fri, 23 May 2025 15:07:59 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 042D283281
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3a35919fa8bso3964520f8f.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748005675; x=1748610475; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDpQ0i2ejne2tmVeNMnTBpuULwm1T8eQ9jODHnTcji0=;
 b=ksH/Zg4h7GdIC43yTXVO6C3q9JsCJGiX/nay2KQlUyUjpBuhvix0T+X9OD5MKR88BR
 8JolZXGWE/Zu0mUFFMttIZmocFeQj9lpd4R7v2AYQiw9nhDLqhLO0X07ahbf9mfe0zJx
 pHrZrxw9wTUf0YkTxdxaJfmuuTZKYWdjTN/sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748005675; x=1748610475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDpQ0i2ejne2tmVeNMnTBpuULwm1T8eQ9jODHnTcji0=;
 b=ey28jZehc2mmdIlu549HhycxSqRNTQfSksjlZlL+ue0jSqVAlzOBd4jHZGBJVyDW/A
 P2HJoFsu02pxsfU4cgt3oWPnhg0sWKy5a53z/UpsiJtcQcsyup55oPWy4HyPeih4DRbP
 y9LjzQ1qhzA7728XfIyuKf+vbv3LtsAPIxZ+EbHdJQE5/oNzlSuKcQEt2aSZIe4JtVcC
 2sllyunKS51h9ywZI30JFFOLWcYO4Y1Q66FgdiXW0chaCHIFRiRfVFid3wTTMYRE6r5X
 jOhAsiIXfstUdzPAe+7i8z56G2M6x0qalVl9XLppvJk5LKwLt0txbgnDOC12HHpXTYgy
 KcLg==
X-Gm-Message-State: AOJu0YwEj4S6tLwIQPFWeM4woFC0bb56NlHXNBZfVUUH5CXHS5L0J+iF
 /5WER7uFfgW7w7uDK7ImCMHZiqOeCUHv37XKMpHIlEtcMkmLKAskemyL2zlrH0xKUs0DCgTcB1V
 1XE4Wjsmk51Y=
X-Gm-Gg: ASbGncvNQU7OEWjSMBIqs1EuF4IPyKjmeP+u++llLX+M/AyZsuMYlmIdPi6vqPt43Lt
 wSXUobb0riKfZpXc+hrLrTWTeVVWPdbV/pogSPM+lPd+1Rxcf0ftQxQfL2+4vf8hDO9ppGb5HqA
 LE8Sx/8tkkTc5y62XYg6LA6TUaUGIoT931Td+sw2ygIN9lLtkDDxr8mX1zqovaSTxVsWe4t6GfR
 R/I4OAWv/QpKUE599M+o4ND7voFVVDbowK1ESnQqb/gn93NXQsznPvLMBwZVBz3AAcQshlv1Ub/
 kCFen7Io3wAKbL3E1J0IApqSmmXsUiFQQRoJv8g4tHPjl5UQZHdQqOchxefjSBJSx3EDAUU=
X-Google-Smtp-Source: AGHT+IG7yqMOdMpxIovpvrNQu/FpYWGRiqxBxsz4Wyu35UESLxPWh9uKidZTIhzeADeF2D2svgGA1Q==
X-Received: by 2002:a5d:5c84:0:b0:3a3:7be3:cb92 with SMTP id
 ffacd0b85a97d-3a37be3cf2bmr14642436f8f.42.1748005675152; 
 Fri, 23 May 2025 06:07:55 -0700 (PDT)
Received: from chromium.org (82-132-216-100.dab.02.net. [82.132.216.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm12109241f8f.100.2025.05.23.06.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 06:07:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Pawel Kochanowski <pkochanowski@sii.pl>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/10] efi: Move the base name and PXE info into lib/efi
Date: Fri, 23 May 2025 14:06:43 +0100
Message-ID: <20250523130651.1329593-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523130651.1329593-1-sjg@chromium.org>
References: <20250523130651.1329593-1-sjg@chromium.org>
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

Move efi_get_basename() and efi_get_pxe_arch() into lib/efi so they can
be used from the app.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS                 |  1 +
 lib/Makefile                |  1 +
 lib/efi/Makefile            |  6 +++
 lib/efi/basename.c          | 85 +++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_helper.c | 74 --------------------------------
 5 files changed, 93 insertions(+), 74 deletions(-)
 create mode 100644 lib/efi/Makefile
 create mode 100644 lib/efi/basename.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 929b0382866..8960c005ed4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1073,6 +1073,7 @@ F:	configs/efi-x86_app*
 F:	doc/develop/uefi/u-boot_on_efi.rst
 F:	drivers/block/efi-media-uclass.c
 F:	drivers/block/sb_efi_media.c
+F:	lib/efi/
 F:	lib/efi_client/
 F:	scripts/build-efi
 F:	test/dm/efi_media.c
diff --git a/lib/Makefile b/lib/Makefile
index 429347f97a2..c9c1eccc187 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,6 +5,7 @@
 
 ifndef CONFIG_XPL_BUILD
 
+obj-$(CONFIG_EFI) += efi/
 obj-$(CONFIG_EFI_CLIENT) += efi_client/
 obj-$(CONFIG_EFI_LOADER) += efi_driver/
 obj-$(CONFIG_EFI_LOADER) += efi_loader/
diff --git a/lib/efi/Makefile b/lib/efi/Makefile
new file mode 100644
index 00000000000..a7dee7d4a6b
--- /dev/null
+++ b/lib/efi/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 Simon Glass <sjg@chromium.org>
+#
+
+obj-y += basename.o
diff --git a/lib/efi/basename.c b/lib/efi/basename.c
new file mode 100644
index 00000000000..4d6eb41cd90
--- /dev/null
+++ b/lib/efi/basename.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2020, Linaro Limited
+ */
+
+#define LOG_CATEGORY LOGC_EFI
+
+#include <efi.h>
+#include <efi_load_initrd.h>
+#include <env.h>
+#include <errno.h>
+
+#undef BOOTEFI_NAME
+
+#if HOST_ARCH == HOST_ARCH_X86_64
+#define HOST_BOOTEFI_NAME "BOOTX64.EFI"
+#define HOST_PXE_ARCH 0x6
+#elif HOST_ARCH == HOST_ARCH_X86
+#define HOST_BOOTEFI_NAME "BOOTIA32.EFI"
+#define HOST_PXE_ARCH 0x7
+#elif HOST_ARCH == HOST_ARCH_AARCH64
+#define HOST_BOOTEFI_NAME "BOOTAA64.EFI"
+#define HOST_PXE_ARCH 0xb
+#elif HOST_ARCH == HOST_ARCH_ARM
+#define HOST_BOOTEFI_NAME "BOOTARM.EFI"
+#define HOST_PXE_ARCH 0xa
+#elif HOST_ARCH == HOST_ARCH_RISCV32
+#define HOST_BOOTEFI_NAME "BOOTRISCV32.EFI"
+#define HOST_PXE_ARCH 0x19
+#elif HOST_ARCH == HOST_ARCH_RISCV64
+#define HOST_BOOTEFI_NAME "BOOTRISCV64.EFI"
+#define HOST_PXE_ARCH 0x1b
+#else
+#error Unsupported Host architecture
+#endif
+
+#if defined(CONFIG_SANDBOX)
+#define BOOTEFI_NAME "BOOTSBOX.EFI"
+#elif defined(CONFIG_ARM64)
+#define BOOTEFI_NAME "BOOTAA64.EFI"
+#elif defined(CONFIG_ARM)
+#define BOOTEFI_NAME "BOOTARM.EFI"
+#elif defined(CONFIG_X86_64)
+#define BOOTEFI_NAME "BOOTX64.EFI"
+#elif defined(CONFIG_X86)
+#define BOOTEFI_NAME "BOOTIA32.EFI"
+#elif defined(CONFIG_ARCH_RV32I)
+#define BOOTEFI_NAME "BOOTRISCV32.EFI"
+#elif defined(CONFIG_ARCH_RV64I)
+#define BOOTEFI_NAME "BOOTRISCV64.EFI"
+#else
+#error Unsupported UEFI architecture
+#endif
+
+#if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI_LOAD_FILE2_INITRD)
+/* GUID used by Linux to identify the LoadFile2 protocol with the initrd */
+const efi_guid_t efi_lf2_initrd_guid = EFI_INITRD_MEDIA_GUID;
+#endif
+
+const char *efi_get_basename(void)
+{
+	return efi_use_host_arch() ? HOST_BOOTEFI_NAME : BOOTEFI_NAME;
+}
+
+int efi_get_pxe_arch(void)
+{
+	if (efi_use_host_arch())
+		return HOST_PXE_ARCH;
+
+	/* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
+	if (IS_ENABLED(CONFIG_ARM64))
+		return 0xb;
+	else if (IS_ENABLED(CONFIG_ARM))
+		return 0xa;
+	else if (IS_ENABLED(CONFIG_X86_64))
+		return 0x6;
+	else if (IS_ENABLED(CONFIG_X86))
+		return 0x7;
+	else if (IS_ENABLED(CONFIG_ARCH_RV32I))
+		return 0x19;
+	else if (IS_ENABLED(CONFIG_ARCH_RV64I))
+		return 0x1b;
+
+	return -EINVAL;
+}
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 117c6811254..9d73200e604 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -23,80 +23,6 @@
 #include <linux/libfdt.h>
 #include <linux/list.h>
 
-#undef BOOTEFI_NAME
-
-#if HOST_ARCH == HOST_ARCH_X86_64
-#define HOST_BOOTEFI_NAME "BOOTX64.EFI"
-#define HOST_PXE_ARCH 0x6
-#elif HOST_ARCH == HOST_ARCH_X86
-#define HOST_BOOTEFI_NAME "BOOTIA32.EFI"
-#define HOST_PXE_ARCH 0x7
-#elif HOST_ARCH == HOST_ARCH_AARCH64
-#define HOST_BOOTEFI_NAME "BOOTAA64.EFI"
-#define HOST_PXE_ARCH 0xb
-#elif HOST_ARCH == HOST_ARCH_ARM
-#define HOST_BOOTEFI_NAME "BOOTARM.EFI"
-#define HOST_PXE_ARCH 0xa
-#elif HOST_ARCH == HOST_ARCH_RISCV32
-#define HOST_BOOTEFI_NAME "BOOTRISCV32.EFI"
-#define HOST_PXE_ARCH 0x19
-#elif HOST_ARCH == HOST_ARCH_RISCV64
-#define HOST_BOOTEFI_NAME "BOOTRISCV64.EFI"
-#define HOST_PXE_ARCH 0x1b
-#else
-#error Unsupported Host architecture
-#endif
-
-#if defined(CONFIG_SANDBOX)
-#define BOOTEFI_NAME "BOOTSBOX.EFI"
-#elif defined(CONFIG_ARM64)
-#define BOOTEFI_NAME "BOOTAA64.EFI"
-#elif defined(CONFIG_ARM)
-#define BOOTEFI_NAME "BOOTARM.EFI"
-#elif defined(CONFIG_X86_64)
-#define BOOTEFI_NAME "BOOTX64.EFI"
-#elif defined(CONFIG_X86)
-#define BOOTEFI_NAME "BOOTIA32.EFI"
-#elif defined(CONFIG_ARCH_RV32I)
-#define BOOTEFI_NAME "BOOTRISCV32.EFI"
-#elif defined(CONFIG_ARCH_RV64I)
-#define BOOTEFI_NAME "BOOTRISCV64.EFI"
-#else
-#error Unsupported UEFI architecture
-#endif
-
-#if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI_LOAD_FILE2_INITRD)
-/* GUID used by Linux to identify the LoadFile2 protocol with the initrd */
-const efi_guid_t efi_lf2_initrd_guid = EFI_INITRD_MEDIA_GUID;
-#endif
-
-const char *efi_get_basename(void)
-{
-	return efi_use_host_arch() ? HOST_BOOTEFI_NAME : BOOTEFI_NAME;
-}
-
-int efi_get_pxe_arch(void)
-{
-	if (efi_use_host_arch())
-		return HOST_PXE_ARCH;
-
-	/* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
-	if (IS_ENABLED(CONFIG_ARM64))
-		return 0xb;
-	else if (IS_ENABLED(CONFIG_ARM))
-		return 0xa;
-	else if (IS_ENABLED(CONFIG_X86_64))
-		return 0x6;
-	else if (IS_ENABLED(CONFIG_X86))
-		return 0x7;
-	else if (IS_ENABLED(CONFIG_ARCH_RV32I))
-		return 0x19;
-	else if (IS_ENABLED(CONFIG_ARCH_RV64I))
-		return 0x1b;
-
-	return -EINVAL;
-}
-
 /**
  * efi_create_current_boot_var() - Return Boot#### name were #### is replaced by
  *			           the value of BootCurrent
-- 
2.43.0

