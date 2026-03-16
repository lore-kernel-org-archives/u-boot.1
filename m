Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB570F53D85
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D2B841E2;
	Mon, 16 Mar 2026 19:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="lZuWTC2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A281C8418A; Mon, 16 Mar 2026 19:15:36 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73AFC84183
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@wolfssl.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-67ba5921b84so3095969eaf.3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1773684932; x=1774289732;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhAPM12TZwplif6LMiyFLZgrIles6uFM5KwoCmKOIc0=;
 b=lZuWTC2z2V8wYNgvLjPz5xeoaPXiZosBGtAAkJA0h7ILPLsv4Vl387KDxg3kZU7w5H
 oAfei0Hiz9aX2VPBFdVp3poVloEfN0lC1TjV2mosqf6g1+86c0MrieiMkXwlJDOc2xsj
 qzcqDH6lW1oItH2BKUnX8RX6xW142aycn00LFLNaH+ww69FS8FG+fuqU9uvxASVnLDUC
 mJfW5b0iqwsgbR930frTmNgF6eE9znJ6EjM7+WKs6oXSrRrW7T1sEzv3Z4PqwAPUAx2j
 DEhjptrgL38ELQxezNy6JsQyuwPpiUHQ6Wodrr2FxqPzfxw82uG18ghhrYNtgWnnHMvv
 OWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684932; x=1774289732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NhAPM12TZwplif6LMiyFLZgrIles6uFM5KwoCmKOIc0=;
 b=Mz5eIS0Q9abdY6HnKh9rVnu0sxc//qHQfY43ukTZ65BM0T9b25jtp7d0jsXiVsNRsT
 Ljc7iuXc5IMyNdfbxI6OAhDfiOLnW1Nfo0uXvhXFEfZs7dGAgQGA+m9dGimgEz2WfyW+
 dnlhdBYKWNW3tEo10AhU2J9G1ZLYeNfXJ27VN9QwKX5hPcULYLj8ieOf6lSsDmynMJMx
 Qjkdg15/vsC7etMbSX8e88e/UU81IzLH9IH7Jr83j8oeFueyKi6k/M44DVMMkH85RvJY
 C0fJJx1NGQo5IGRv09CXHTObHK6RwNUqp5aiB8H+xdrEPDxmzADM7PWUZICi91Q6y5ml
 Aitg==
X-Gm-Message-State: AOJu0Yz8411mFb1zqMj2wwwbSr1NoLPFpPIq7WVnZopxPeyvT7QAFltz
 6LOQbvlcj+B88RS4p21S6D3vEPqT3qhIyuhVf2g/H62nf9+cqx+Yh1qhhAr3A0RlPfXz0mr274q
 kCjhm
X-Gm-Gg: ATEYQzwZ1x4Dtrcojope6dCDi8yRcSdJSbpY+4DGpwgeNdE/Wq/FUl3XadRwUicjQQ5
 6pFck/6Ft8QVutFtPh1y8Rew7ry1fwGL2gYd9CBr/r8hKx8uB7VaFF7lF1aq401TmDiMGTMyazA
 tWl/JkKgFUjIIPk2AONNiUZ9f2oXXkak9VIkIMy4gFAGWahz/lk0oJyxG3gG2CYQu/f/PEBipEM
 U40vOz7nc8f7dIQnoem5UA563paor5lMo8jSShMVUGTQ3PUxJzudvyqXh4OstYbub+utYqIpszs
 PKqO0Q5NhtjZDo8zK0JVVhRI9VTrg6aOVluaWxHko/q4h0fdAm6MAf2zEI0aqVfM22FvDje1MeD
 9zF3dCeMTmrLz+KN7RB5NlDCudA+VbzuMgKqIpS+5i1S5Ae3VvLtNc4+Zfv6hAi2DmATE3LMknR
 7hOgcyseOIZ2EfuXDjgz8U6g==
X-Received: by 2002:a05:6820:210a:b0:679:e6eb:818 with SMTP id
 006d021491bc7-67bdaa6d899mr9868115eaf.59.1773684931441; 
 Mon, 16 Mar 2026 11:15:31 -0700 (PDT)
Received: from localhost ([2605:59c0:2082:bc08:ab40:208e:38fb:2546])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc914b4fcsm10190468eaf.8.2026.03.16.11.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:15:30 -0700 (PDT)
From: David Garske <david@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Aidan <aidan@wolfssl.com>
Subject: [[PATCH v2] tpm: Add wolfTPM library support for TPM 2.0 06/12] tpm:
 add wolfTPM headers and SHA384 glue code
Date: Mon, 16 Mar 2026 11:14:35 -0700
Message-ID: <20260316181447.2986278-7-david@wolfssl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316181447.2986278-1-david@wolfssl.com>
References: <20260316181447.2986278-1-david@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Mar 2026 19:24:09 +0100
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

lib/wolftpm.c:
  Provides wc_Sha384Hash() implementation when wolfCrypt is disabled
  (WOLFTPM2_NO_WOLFCRYPT). Uses U-Boot's hash_lookup_algo("sha384")
  to compute SHA-384 digests, which is required for Infineon TPM
  firmware update manifest validation.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 include/configs/user_settings.h | 118 ++++++++++++++++++++++++++++++++
 include/wolftpm.h               |  34 +++++++++
 lib/wolftpm.c                   |  56 +++++++++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 include/configs/user_settings.h
 create mode 100644 include/wolftpm.h
 create mode 100644 lib/wolftpm.c

diff --git a/include/configs/user_settings.h b/include/configs/user_settings.h
new file mode 100644
index 00000000000..e62be7a8f30
--- /dev/null
+++ b/include/configs/user_settings.h
@@ -0,0 +1,118 @@
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
2.43.0

