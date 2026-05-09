Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEBBCD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ACF384E29;
	Sat,  9 May 2026 02:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="WHmTzsoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA27184E0B; Sat,  9 May 2026 02:04:48 +0200 (CEST)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com
 [IPv6:2607:f8b0:4864:20::122b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83B7E84E02
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 02:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-12dfee30612so2765329c88.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 17:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778285085; x=1778889885;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOpeNUMlBWK7l7k0WjdMjU+ibuBWvxditEqOtdChToU=;
 b=WHmTzsoUdaRyOUjHrSTrsqPilguGeHYws/84kHqKir0F4b8V63PAkkmL3J3eVDxc+P
 JWDy37TxpldDIz20TLBV6uLxY687W0hqkHbbQPq3XksnzEkaGuPfgIxXFdXNFPH6JqTW
 E8LI8bCPGpRuDH8sN2qHzTAK3wabIOnon7SH+wjF/rLjzH7KyDlKQssr4Q3VLI6+z9Mu
 PzMbglTNhXfGCcpFKXjdEmfTzqX4LtBFouOQ7tFOvcmR7sl0IjVpqGtdqFh/32VA0Nsv
 WuQkynCJGyTuIX4axK3/c4mHn+MU4JmahMnlwOQZZNmRe4mUiZzJhOW2uajN+YHn/I50
 5T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778285085; x=1778889885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wOpeNUMlBWK7l7k0WjdMjU+ibuBWvxditEqOtdChToU=;
 b=cl3U+qhQpABcKADTLLls1c6MxxdBVf1Knn26Q2rPOzVhkTMtbFUQ9kETldRete7Ynw
 U93ldF21TZUiddnDKwtTSWxhb0wdDSDdDqPtPwsj5lDvaJzlhGP2Fybwem3hdG5gt2yO
 q6ZlMR0wlw/HhD5Gg8RgcFUTIzqwRXkWAPjR6w0/aGUJIflAsvrUhdTlgLycEuHuvm4i
 Ba40+7S4VvfqiDHOjcRBrtSzbuoA2MGkwHuCSy38lSjtRRXmOlYoBrbbMSg4UcUPisw7
 nh9pxc0XWZk8/0DbdD1E/KJa20vIbHpYmKWs+S7x9xTVg5kYzG3q1C5uGA8jC6wqmdzG
 btLw==
X-Gm-Message-State: AOJu0Yy88JeTj4ebFkq2NCWUhO65+qmCsY7qJiKBST8YJf74AnGndvob
 RcaxzbHglxxhmAwITawXwdIDjvhFIztC6/xqN7qXrbTsgGs3mr1qmOxKSmFCp07rRJNVJ98dVcP
 1fE7Z
X-Gm-Gg: AeBDievP1qvXn4oYfesDPWSV6XuThGiCQWey5xlIu+igxJymKEsLuRhuQ5/8pVCBTMt
 DxZwN//VyxG8tph90fzOrHRhUbGgPj9foJtBSzV7DG98KaWgIcgXsPHmiT+8zKezIIenjhtw4mF
 NyMFnQUFD4E+iin5bESFnOnjIWhjWbsEkvnurXe6dQ7WXQH5u4uU3B1RfrMq7X69jrqVI2bw8iq
 zwghp6DbUO5qt8UNEXMFUIU7eZgNMTKioetutNHMTcpwNNbrBjlTRGCN7VXExPNdlHglvhP8yyo
 xNjQlMIAh+PFNJK/TsFPaXk07UpPVim5diWPj6RujVQIjtcDq+Zm8RYx7qy2lIAw6wwlyiGcxT6
 Hw/EEch0rTkW6cRDtvnnnm36BqexCryf9RlcWPR69TtCXY0Euvvgfk1XGW8FhXdzfHspUm8pqPG
 kVjiUUF1vjY0BCM9zY8gCk9jvsXmtnV7rJNxeEfSymoSQpwl+3EKXGvyB5DD3xymhniAaTv8QDL
 rJiC6qjs3K4iPLQWrrz/7cE6OXuNMsq
X-Received: by 2002:a05:7022:6606:b0:11d:fd26:234e with SMTP id
 a92af1059eb24-13271382d62mr2781261c88.16.1778285084604; 
 Fri, 08 May 2026 17:04:44 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132787673ffsm5505030c88.15.2026.05.08.17.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:04:44 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: David Garske <david@wolfssl.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 06/12] tpm: add wolfTPM headers and SHA384 glue code
Date: Fri,  8 May 2026 17:04:13 -0700
Message-ID: <766cbe833bbd3cc244d635040252a7fc338d1d5c.1778277334.git.aidan@wolfssl.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778277334.git.aidan@wolfssl.com>
References: <cover.1778277334.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:11 +0200
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

From: Aidan <aidan@wolfssl.com>

Add the wolfTPM integration headers and hash wrapper needed to bridge
wolfTPM with U-Boot's subsystems.

include/wolftpm.h:
  Public header exposing TPM2_PCRs_Print(), TPM2_Init_Device(), and
  Infineon firmware update helpers (TPM2_IFX_FwData_Cb,
  TPM2_IFX_GetOpModeStr, TPM2_IFX_PrintInfo). Includes the core
  wolfTPM headers (tpm2.h, tpm2_wrap.h, tpm2_packet.h).

include/configs/user_settings.h:
  wolfTPM compile-time configuration. Selects TPM chip type
  (SLB9672/SLB9673 for real hardware, WOLFTPM_AUTODETECT for
  swtpm/QEMU), communication mode (native SPI TIS layer for real
  hardware, WOLFTPM_LINUX_DEV for U-Boot driver model), timeout
  tuning, and feature flags (WOLFTPM2_NO_WOLFCRYPT,
  WOLFTPM2_NO_HEAP, WOLFTPM_CHECK_WAIT_STATE).

  user_settings.h pulls in <asm/byteorder.h> up front so U-Boot's
  cpu_to_beXX / beXX_to_cpu macros are defined before wolfTPM's
  tpm2_packet.h, whose fallback definitions are #ifndef-guarded.
  This keeps the workaround on the wolfTPM side rather than
  modifying linux/byteorder/generic.h.

lib/wolftpm.c:
  Provides wc_Sha384Hash() implementation when wolfCrypt is disabled
  (WOLFTPM2_NO_WOLFCRYPT). Uses U-Boot's hash_lookup_algo("sha384")
  to compute SHA-384 digests, which is required for Infineon TPM
  firmware update manifest validation.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 include/configs/user_settings.h | 123 ++++++++++++++++++++++++++++++++
 include/wolftpm.h               |  34 +++++++++
 lib/wolftpm.c                   |  56 +++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 include/configs/user_settings.h
 create mode 100644 include/wolftpm.h
 create mode 100644 lib/wolftpm.c

diff --git a/include/configs/user_settings.h b/include/configs/user_settings.h
new file mode 100644
index 00000000000..6afd6ddc520
--- /dev/null
+++ b/include/configs/user_settings.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * wolfTPM build configuration for U-Boot
+ *
+ * Copyright (C) 2025 wolfSSL Inc.
+ * Author: Aidan Garske <aidan@wolfssl.com>
+ */
+
+#ifndef USER_SETTINGS_H
+#define USER_SETTINGS_H
+
+/* Define U-Boot's byte-order macros first so wolfTPM's #ifndef-guarded
+ * fallbacks in tpm2_packet.h don't redefine them.
+ */
+#include <asm/byteorder.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/******************************************************************************/
+/* --- BEGIN wolfTPM U-boot Settings -- */
+/******************************************************************************/
+
+/* =========================================================================
+ * TPM Chip Configuration
+ * =========================================================================
+ *
+ * CONFIG_TPM_AUTODETECT: For swtpm/QEMU testing (no specific chip)
+ * !CONFIG_TPM_AUTODETECT: For real hardware (SLB9672/SLB9673)
+ */
+#ifdef CONFIG_TPM_AUTODETECT
+	#define WOLFTPM_AUTODETECT
+#else
+	/* Real hardware - Infineon SLB9672/SLB9673
+	 * Firmware upgrade only supported by these chips */
+	#define WOLFTPM_FIRMWARE_UPGRADE
+	#define WOLFTPM_SLB9672
+	/* #define WOLFTPM_SLB9673 */
+#endif
+
+/* Include delay.h and types.h for
+ * U-boot time delay and types */
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <stdint.h>
+
+/* wolfCrypt disabled - pcr_setauthpolicy/pcr_setauthvalue not available
+ * To enable wolfCrypt, you would need to:
+ * 1. Uncomment the line below to undefine WOLFTPM2_NO_WOLFCRYPT
+ * 2. Add wolfCrypt source files to the U-Boot build (lib/Makefile)
+ * 3. Add wolfCrypt settings for embedded/no-OS use
+ */
+#undef  WOLFTPM2_NO_WOLFCRYPT
+#define WOLFTPM2_NO_WOLFCRYPT
+
+/* =========================================================================
+ * TPM Communication Mode Selection (Auto-detected based on chip type)
+ * =========================================================================
+ *
+ * For real SPI hardware (SLB9672/SLB9673):
+ *   - Uses wolfTPM's native TIS layer with raw SPI via tpm_io_uboot.c
+ *   - Requires CONFIG_SPI and CONFIG_DM_SPI enabled in U-Boot
+ *
+ * For swtpm/QEMU testing (no specific chip defined):
+ *   - Uses WOLFTPM_LINUX_DEV mode with U-Boot's TPM driver (tpm_xfer())
+ *   - Works with MMIO-based TPM via tpm2_tis_mmio.c
+ */
+
+#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
+	/* Real SPI hardware - use native wolfTPM TIS with raw SPI */
+	/* WOLFTPM_LINUX_DEV is NOT defined */
+	#define WOLFTPM_EXAMPLE_HAL
+
+	/* SPI bus and chip select for TPM
+	 * Official Raspberry Pi tpm-slb9670 overlay uses CE1 (GPIO7)
+	 * This matches LetsTrust and most Infineon evaluation boards */
+	#ifndef TPM_SPI_BUS
+		#define TPM_SPI_BUS 0
+	#endif
+	#ifndef TPM_SPI_CS
+		#define TPM_SPI_CS 1   /* CE1/GPIO7 - official RPi TPM overlay setting */
+	#endif
+#else
+	/* swtpm/QEMU - use U-Boot's TPM driver with MMIO communication mode */
+	#define WOLFTPM_LINUX_DEV
+#endif
+
+#define XSLEEP_MS(ms) udelay(ms * 1000)
+
+/* Timeout configuration */
+#ifdef WOLFTPM_FIRMWARE_UPGRADE
+	/* Firmware update requires much longer timeout for TPM processing */
+	#define TPM_TIMEOUT_TRIES 2000000
+#else
+	/* Normal operations - reduce from default 1,000,000 to prevent long hangs */
+	#define TPM_TIMEOUT_TRIES 10000
+#endif
+
+/* Add small delay between poll attempts to avoid tight spin loop */
+#define XTPM_WAIT() udelay(100)
+
+/* Do not include API's that use heap(), they are not required */
+#define WOLFTPM2_NO_HEAP
+
+/* Debugging - disabled for clean output */
+/* #define DEBUG_WOLFTPM */
+/* #define WOLFTPM_DEBUG_VERBOSE */
+/* #define WOLFTPM_DEBUG_IO */
+/* #define WOLFTPM_DEBUG_TIMEOUT */
+
+/* SPI Wait state checking - most TPMs use this */
+#define WOLFTPM_CHECK_WAIT_STATE
+
+/******************************************************************************/
+/* --- END wolfTPM U-boot Settings -- */
+/******************************************************************************/
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* USER_SETTINGS_H */
diff --git a/include/wolftpm.h b/include/wolftpm.h
new file mode 100644
index 00000000000..a3cd9d0d2dd
--- /dev/null
+++ b/include/wolftpm.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * wolfTPM integration header for U-Boot
+ *
+ * Copyright (C) 2025 wolfSSL Inc.
+ * Author: Aidan Garske <aidan@wolfssl.com>
+ */
+
+#ifndef __WOLFTPM_H__
+#define __WOLFTPM_H__
+
+#include <wolftpm/tpm2.h>
+#include <wolftpm/tpm2_wrap.h>
+#include <wolftpm/tpm2_packet.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#ifdef WOLFTPM_FIRMWARE_UPGRADE
+int TPM2_IFX_FwData_Cb(uint8_t *data, uint32_t data_req_sz,
+			uint32_t offset, void *cb_ctx);
+const char *TPM2_IFX_GetOpModeStr(int opMode);
+void TPM2_IFX_PrintInfo(WOLFTPM2_CAPS *caps);
+#endif
+
+int TPM2_PCRs_Print(void);
+int TPM2_Init_Device(WOLFTPM2_DEV *dev, void *userCtx);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __WOLFTPM_H__ */
diff --git a/lib/wolftpm.c b/lib/wolftpm.c
new file mode 100644
index 00000000000..49e35401236
--- /dev/null
+++ b/lib/wolftpm.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * wolfTPM wrapper layer for U-Boot
+ *
+ * Copyright (C) 2025 wolfSSL Inc.
+ * Author: Aidan Garske <aidan@wolfssl.com>
+ */
+
+/* wolfTPM wrapper layer to expose U-boot API
+ * when wolfCrypt is not available. This is used by
+ * the U-boot firmware update command.
+ */
+
+#include <configs/user_settings.h>
+#include <hash.h>
+#include <linux/types.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <asm/cache.h>
+#include <errno.h>
+
+/* Add wolfTPM type definitions */
+typedef uint8_t byte;
+typedef uint32_t word32;
+
+#ifdef WOLFTPM2_NO_WOLFCRYPT
+int wc_Sha384Hash(const byte *data, word32 len, byte *hash)
+{
+	struct hash_algo *algo;
+	u8 *output;
+	void *buf;
+
+	if (hash_lookup_algo("sha384", &algo)) {
+		printf("Unknown hash algorithm 'sha384'\n");
+		return -1;
+	}
+
+	output = (u8 *)memalign(ARCH_DMA_MINALIGN,
+				algo->digest_size);
+	if (!output) {
+		return -ENOMEM;
+	}
+
+	buf = (void *)map_sysmem((ulong)data, len);
+	algo->hash_func_ws(buf, len, output, algo->chunk_size);
+	unmap_sysmem(buf);
+
+	memcpy(hash, output, algo->digest_size);
+
+	free(output);
+	return 0;
+}
+#endif /* WOLFTPM2_NO_WOLFCRYPT */
-- 
2.47.3

