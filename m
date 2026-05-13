Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B059CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 00:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2612684663;
	Wed, 13 May 2026 02:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="jLYMSXzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C55883FB0; Wed, 13 May 2026 02:26:50 +0200 (CEST)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5285800AE
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 02:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2f7020a928eso8629820eec.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 17:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778632006; x=1779236806;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gSKaZFJvw9VYbhHD8aSRRFpLsogG9HzC66+oj+7VBJI=;
 b=jLYMSXzp2uePtYxnUIHCRoaEfuJTzeBRxzLLr0C0Dzl5hTvJlUriT98mHNLQWX0kzP
 2TOrxZJrYsiOXLmAYPyzLI83gdBw7fEu6pc9xQG6uJ55zGiCJJnjeeXsYcylrzjGy4Ov
 7y3wpdfZMrO61kIMYHGKpGEnwnu/wycmxKg/GD/sL9RVi62SRMWlPvfnreA8nsJWUIjT
 muC9NeafCU61AvD7CvijYdzAyF71g/shPr0jHJumjTG8cwHGGlqp4cZA5vdFbpX9CkEI
 xOQM1rRcisN0oyp91JqQCDb8zqNivHHhyFdj6ufk0JUofSw1yZWFGGWUsflYD+/sIRVV
 XguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778632006; x=1779236806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gSKaZFJvw9VYbhHD8aSRRFpLsogG9HzC66+oj+7VBJI=;
 b=sRJDipQ3q/c1sakPvazwxHqvOH+NOSVj++OYWtmk9ADWEWrFeylHY8YHu92B6GibgJ
 nPOEQwfkYJP475Onyl5jgvZv0+RDP/TlE8ceaSSIiWB+2GcRR13R58zd3YZf41fbpo9d
 4tF2iBTB+yS4B1USsgoNYF7sHTVlepGJ/xhhCzbuM8Th4+kDNgMkBHZNrL6kqBeC4ll/
 diCDpFlto6NcXAIkbtm7zTIcn1ld2S0QowIgiswJzTb+ZMBrd90kZCBhsAXBcLBwKjuY
 B9cAvPhno5ow1f1K4cSQoWaQOR5Qo5U2+aiAA8o3puizLelO0oOsZeU8ygBenQoyWqWw
 8LNg==
X-Gm-Message-State: AOJu0YwDNUGGAv2N3Y9tGehjNcg5/XsEB0H7iSGIVeTok4l6izFLyH+c
 7gBoTEOdbHgE/64WAgga914QjQRWPLzaOvXSGOuVvr3aklM/3+FLd6zU3Vbeg25cFx9+3XeTnzX
 lnY6G1aY=
X-Gm-Gg: Acq92OFPT8UFqILdnVEAymwm56OpQaYZQjDmTv9tGgp64lwPpSZpaRibPVq7Hd06rgi
 9PQCkzzv5kUnt566pg0ZLFETKjr0eiJnAXybIorxJIhNAA/GlmrtAutrK2r0FsPWgzQKQy7Fg2K
 m3rTtQPWzBIwtb47Xhisv05MiXvRt3kEFdpmfPvp6ss6LdIxE9Xpu7sITecCtgtwakn6CvUTDOX
 q05niSeZzXS7sEqfUZ7vlokszlB3NvtZqVxBOfHMSZitjK2xiqPjh4B+nnwiQbpo0wZxp7vkY3S
 Iszxg5IgdeKrJNmf6ZSONm5BC22Qt5WajRaOEmWxScFsgHrnJj/nlDafxVt2uYvRIIzwM1vXwLj
 Z2UgauVO7IDI/Ooft3S01D+HlkVo9Ioaoa6HrfsiS5sQhfRmyzzYsX1vxm5G9Q+55QUDAL+3Xou
 UzdxboitxbhRqabRm//XRMUkmKZXpN+3nmogoeFcDKKOSIHBkwH//N7szGdDn2HWiwK1AgdcCnD
 laPo7Z7by2bP/diK8arrHLMTN+BPQg7
X-Received: by 2002:a05:693c:2d96:b0:2c1:7793:7bbb with SMTP id
 5a478bee46e88-30119f60607mr689578eec.27.1778632005725; 
 Tue, 12 May 2026 17:26:45 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884752ccsm19547827eec.17.2026.05.12.17.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 17:26:45 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, David Garske <david@wolfssl.com>,
 Aidan <aidan@wolfssl.com>
Subject: [PATCH v4 08/14] tpm: add wolfTPM headers and SHA384 glue code
Date: Tue, 12 May 2026 17:26:12 -0700
Message-ID: <20260513002625.76915-8-aidan@wolfssl.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778619453.git.aidan@wolfssl.com>
References: <cover.1778619453.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 02:26:57 +0200
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
2.49.0

