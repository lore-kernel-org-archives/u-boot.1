Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2844DF53D81
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46AFB841FA;
	Mon, 16 Mar 2026 19:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="1+kL22Lc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B826984181; Mon, 16 Mar 2026 19:15:38 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0926A84180
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:15:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@wolfssl.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4043b909ed4so3073809fac.3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1773684934; x=1774289734;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZDqhDmX24IgbrH+USaQTdEhzVfJQIUkhDr1p6e6zcI=;
 b=1+kL22LcEH9UxpDUiByitD01KIATOJCmq0ceeiDrDXU5ubt422ZCloHixTv0P1WioO
 uxdl8hRXo8qoaE88fKjb0bkThcRDqGTcNRD8Jrh/8E0vXh0qAoKauSMEsxyYIn+aN9IV
 ZG95+yaY0+iMdBS9ilEhe5qA0GPfF9yPt9bOj/FlDPgmfIGk5Ds7CBN+u4GHUsT8NKPH
 iJvGkuOJOwBLY4DnTDJWScKL+hNDME7UYngOu6+tIo0bYk0/mVwI4pvzOpYJ1+JJvMWR
 YVKVUjCKdgH2ubTUpBTWt8ja3kLe+e6QJNlUmhkR3Idr3XQFbWyUZR7R4NNKhzhtRm2t
 AvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684934; x=1774289734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ZDqhDmX24IgbrH+USaQTdEhzVfJQIUkhDr1p6e6zcI=;
 b=emgUostEvvK8wM0RoF58n85YwnBPb/OP3R8yIFK5wX/SOWh9RLdPEVgN2jhsga+QoH
 p0E6Y1HwbxdAXE0a1LEM6Bw5BG+Orm0WZ30TfI0ph3Z/WBaIpdgiCFaZQ7kFjYLgvytJ
 YDFo7x079G/uhAJB8kxbDNcic5+3MzBxTiIaPc1lCvFPkjEijjQz36tNH/+HUzVT1lwZ
 3PezSImKwpS7FRkFBRndMKioZpccZHZfUTT+FyL9MyKv2EixWvElyNqRL75hPU46zdeG
 lPi9sXIgg0E4bPq3g26vwiB51Ay1gMTkRbTcR4rE6mL1pevqL/T1zgKWmohrgN5x/Z8O
 7waA==
X-Gm-Message-State: AOJu0YwNgiTNVytw5viyK0ffXH+j0rGBRvidvjxED8kN1cDyBLtDSS6a
 z3/SieEkvZMmPXORMiVI92gT8VI3KJCYrCGkmIzFN454Y9PDWaPf0UvivdTQsbZrmR4sJNhncBD
 Om8lU
X-Gm-Gg: ATEYQzxCau7xX//iI9+8XEp2HhYN68MU2cYwFs4nKU1L+TuxmeFw2DEfnTM6mV0TDc+
 KYAuXzfUcqqlj8nPkV3/K0MlojGXIojxqyxDlRdU0QzcuQVubpEjDQeEkg4bBTcHQO0IrmZrlqs
 CbvDMEFkoeE7ad/6TzZUq7wcoIeaO/+/dHiKjW1WDT4JSNhN0WDt5onls2ftbtZJp8jPy7vk/KJ
 XWMszkCis27px4VkluOCV8WnZxolnxD8ng79lr864ZE9Eq3wt6CDGs6gFXLl0I356IKY4ebiEeu
 gI3wmoh71B5Kp7S6dHoKEpoiFTlAMVp8doW6KICdoXKQEBQAYyHMg+hfzl6HcnTHq/K3sWTMAYh
 ME0Q9RnPUhpUjiWwBSO/CZU9/cw3ODCw01urr1j7Hm/Vzj987DkSrX9z81tihBIuNYvf8vBKKYl
 4esYmoE0z5wxZ4TSs7OUWcgKw7KYRFdnZF
X-Received: by 2002:a05:6870:9722:b0:404:16c6:40b3 with SMTP id
 586e51a60fabf-417b94230fcmr7999416fac.37.1773684933628; 
 Mon, 16 Mar 2026 11:15:33 -0700 (PDT)
Received: from localhost ([2605:59c0:2082:bc08:ab40:208e:38fb:2546])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e6c7885sm16033372fac.17.2026.03.16.11.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:15:32 -0700 (PDT)
From: David Garske <david@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Aidan <aidan@wolfssl.com>
Subject: [[PATCH v2] tpm: Add wolfTPM library support for TPM 2.0 07/12] tpm:
 add wolfTPM driver helpers and Kconfig options
Date: Mon, 16 Mar 2026 11:14:36 -0700
Message-ID: <20260316181447.2986278-8-david@wolfssl.com>
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

Add wolfTPM helper functions and configuration options to the TPM
driver subsystem.

drivers/tpm/wolftpm_common.c:
  Shared helper functions used by the wolfTPM command backend:
  - TPM2_IFX_FwData_Cb(): firmware data callback for Infineon
    firmware update streaming
  - TPM2_IFX_GetOpModeStr(): converts Infineon operational mode
    codes to human-readable strings
  - TPM2_IFX_PrintInfo(): prints manufacturer, vendor, firmware
    version, and operational mode from WOLFTPM2_CAPS
  - TPM2_PCRs_Print(): enumerates and prints assigned PCR banks
    and their selected PCR indices
  - TPM2_Init_Device(): initializes wolfTPM with the TPM2_IoCb
    HAL callback

drivers/tpm/Kconfig:
  Adds configuration options under TPM_V2:
  - TPM2_SPI_SANDBOX: sandbox TPM SPI emulator for testing
  - TPM_AUTODETECT: auto-detect TPM chip for swtpm/QEMU
  - WOLFTPM_LINUX_DEV: use U-Boot driver model instead of
    wolfTPM's native TIS layer
  - WOLFTPM_SLB9672/SLB9673: Infineon chip-specific features
  - WOLFTPM_FIRMWARE_UPGRADE: firmware update support

drivers/tpm/Makefile:
  Compiles wolftpm_common.o and sets wolfTPM include paths and
  -DWOLFTPM_USER_SETTINGS when CONFIG_TPM_WOLF is enabled.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 drivers/tpm/Kconfig          |  44 +++++++++++
 drivers/tpm/Makefile         |   9 +++
 drivers/tpm/wolftpm_common.c | 137 +++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/tpm/wolftpm_common.c

diff --git a/drivers/tpm/Kconfig b/drivers/tpm/Kconfig
index 219ea606b50..a2897a0e040 100644
--- a/drivers/tpm/Kconfig
+++ b/drivers/tpm/Kconfig
@@ -158,6 +158,14 @@ config TPM2_TIS_SANDBOX
 	  such as basic configuration, PCR extension and PCR read. Extended
 	  functionalities are not implemented.
 
+config TPM2_SPI_SANDBOX
+	bool "Enable sandbox TPM SPI emulator"
+	depends on TPM_V2 && SANDBOX && DM_SPI
+	help
+	  This driver emulates a TPM connected via SPI for sandbox testing.
+	  It implements the TPM TIS SPI protocol and can be used to test
+	  wolfTPM SPI HAL code without physical hardware.
+
 config TPM2_TIS_SPI
 	bool "Enable support for TPMv2.x SPI chips"
 	depends on TPM_V2 && DM_SPI
@@ -200,6 +208,42 @@ config TPM2_EVENT_LOG_SIZE
 	  allocated twice. One for the eventlog it self and one for the
 	  configuration table that is required from the TCG2 spec
 
+config TPM_AUTODETECT
+    bool "wolfTPM auto-detect TPM chip (for swtpm/QEMU)"
+    depends on TPM_V2 && TPM_WOLF
+    help
+      Enable wolfTPM chip auto-detection instead of using a specific
+      chip type (SLB9672/SLB9673). Use this for swtpm/QEMU testing
+      where no specific hardware chip is present.
+
+config WOLFTPM_LINUX_DEV
+    bool "Use device-level TPM interface (bypass wolfTPM TIS layer)"
+    depends on TPM_V2 && TPM_WOLF
+    default y
+    help
+      Enable wolfTPM to use the underlying TPM driver instead of its own
+      TIS (TPM Interface Specification) layer. On U-Boot, this uses the
+      U-Boot TPM driver model (tpm_xfer). On Linux, this uses /dev/tpm0.
+      This is the recommended setting for U-Boot.
+
+config WOLFTPM_SLB9672
+    bool "Enable support for Infineon SLB9672 TPM"
+    depends on TPM_V2 && TPM_WOLF
+    help
+      Enable support for Infineon SLB9672 TPM features in wolfTPM.
+
+config WOLFTPM_SLB9673
+    bool "Enable support for Infineon SLB9673 TPM"
+    depends on TPM_V2 && TPM_WOLF
+    help
+      Enable support for Infineon SLB9673 TPM features in wolfTPM.
+
+config WOLFTPM_FIRMWARE_UPGRADE
+    bool "Enable firmware upgrade support for wolfTPM"
+    depends on TPM_V2 && TPM_WOLF
+    help
+      Enable support for Infineon TPM firmware upgrade commands in wolfTPM.
+
 endif # TPM_V2
 
 endmenu
diff --git a/drivers/tpm/Makefile b/drivers/tpm/Makefile
index b83ce703ec0..bee4193e9fc 100644
--- a/drivers/tpm/Makefile
+++ b/drivers/tpm/Makefile
@@ -10,7 +10,16 @@ obj-$(CONFIG_TPM_TIS_SANDBOX) += tpm_tis_sandbox.o sandbox_common.o
 
 obj-$(CONFIG_$(PHASE_)TPM2_CR50_I2C) += cr50_i2c.o
 obj-$(CONFIG_TPM2_TIS_SANDBOX) += tpm2_tis_sandbox.o sandbox_common.o
+obj-$(CONFIG_TPM2_SPI_SANDBOX) += tpm_spi_sandbox.o
 obj-$(CONFIG_TPM2_TIS_SPI) += tpm2_tis_core.o tpm2_tis_spi.o
 obj-$(CONFIG_TPM2_TIS_I2C) += tpm2_tis_core.o tpm2_tis_i2c.o
 obj-$(CONFIG_TPM2_FTPM_TEE) += tpm2_ftpm_tee.o
 obj-$(CONFIG_TPM2_MMIO) += tpm2_tis_core.o tpm2_tis_mmio.o
+
+# wolfTPM helper functions
+ifeq ($(CONFIG_TPM_WOLF),y)
+ccflags-y += -I$(srctree)/lib/wolftpm \
+             -I$(srctree)/include/configs \
+             -DWOLFTPM_USER_SETTINGS
+obj-y += wolftpm_common.o
+endif
diff --git a/drivers/tpm/wolftpm_common.c b/drivers/tpm/wolftpm_common.c
new file mode 100644
index 00000000000..bea36cf0229
--- /dev/null
+++ b/drivers/tpm/wolftpm_common.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * wolfTPM common helper functions for U-Boot
+ *
+ * Copyright (C) 2025 wolfSSL Inc.
+ * Author: Aidan Garske <aidan@wolfssl.com>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <wolftpm.h>
+#include <wolftpm/tpm2.h>
+#include <wolftpm/tpm2_wrap.h>
+#include <wolftpm/tpm2_packet.h>
+#include <hal/tpm_io.h>
+#include <stdio.h>
+#include <string.h>
+#include <log.h>
+#include <hash.h>
+#include <examples/wrap/wrap_test.h>
+
+#ifndef WOLFTPM2_NO_WRAPPER
+#ifdef WOLFTPM_FIRMWARE_UPGRADE
+
+/******************************************************************************/
+/* --- BEGIN helper functions -- */
+/******************************************************************************/
+
+struct fw_info {
+	byte *manifest_buf;
+	byte *firmware_buf;
+	size_t manifest_bufSz;
+	size_t firmware_bufSz;
+};
+
+int TPM2_IFX_FwData_Cb(uint8_t *data, uint32_t data_req_sz,
+			uint32_t offset, void *cb_ctx)
+{
+	struct fw_info *fwinfo = (struct fw_info *)cb_ctx;
+
+	if (offset > fwinfo->firmware_bufSz)
+		return BUFFER_E;
+	if (offset + data_req_sz > (uint32_t)fwinfo->firmware_bufSz)
+		data_req_sz = (uint32_t)fwinfo->firmware_bufSz - offset;
+	if (data_req_sz > 0)
+		memcpy(data, &fwinfo->firmware_buf[offset], data_req_sz);
+	return data_req_sz;
+}
+
+const char *TPM2_IFX_GetOpModeStr(int opMode)
+{
+	const char *opModeStr = "Unknown";
+
+	switch (opMode) {
+	case 0x00:
+		opModeStr = "Normal TPM operational mode";
+		break;
+	case 0x01:
+		opModeStr = "TPM firmware update mode (abandon possible)";
+		break;
+	case 0x02:
+		opModeStr = "TPM firmware update mode (abandon not possible)";
+		break;
+	case 0x03:
+		opModeStr = "After successful update, but before finalize";
+		break;
+	case 0x04:
+		opModeStr = "After finalize or abandon, reboot required";
+		break;
+	default:
+		break;
+	}
+	return opModeStr;
+}
+
+void TPM2_IFX_PrintInfo(WOLFTPM2_CAPS *caps)
+{
+	printf("Mfg %s (%d), Vendor %s, Fw %u.%u (0x%x)\n",
+		caps->mfgStr, caps->mfg, caps->vendorStr, caps->fwVerMajor,
+		caps->fwVerMinor, caps->fwVerVendor);
+	printf("Operational mode: %s (0x%x)\n",
+		TPM2_IFX_GetOpModeStr(caps->opMode), caps->opMode);
+	printf("KeyGroupId 0x%x, FwCounter %d (%d same)\n",
+		caps->keyGroupId, caps->fwCounter, caps->fwCounterSame);
+}
+#endif /* WOLFTPM_FIRMWARE_UPGRADE */
+
+int TPM2_PCRs_Print(void)
+{
+	int rc;
+	int pcrCount, pcrIndex;
+	GetCapability_In  capIn;
+	GetCapability_Out capOut;
+	TPML_PCR_SELECTION *pcrSel;
+
+	memset(&capIn, 0, sizeof(capIn));
+	capIn.capability = TPM_CAP_PCRS;
+	capIn.property = 0;
+	capIn.propertyCount = 1;
+	rc = TPM2_GetCapability(&capIn, &capOut);
+	if (rc != TPM_RC_SUCCESS) {
+		log_debug("TPM2_GetCapability failed rc=%d (%s)\n",
+			  rc, TPM2_GetRCString(rc));
+		return rc;
+	}
+	pcrSel = &capOut.capabilityData.data.assignedPCR;
+	printf("Assigned PCR's:\n");
+	for (pcrCount = 0; pcrCount < (int)pcrSel->count; pcrCount++) {
+		printf("\t%s: ",
+		       TPM2_GetAlgName(pcrSel->pcrSelections[pcrCount].hash));
+		for (pcrIndex = 0;
+		     pcrIndex < pcrSel->pcrSelections[pcrCount].sizeofSelect * 8;
+		     pcrIndex++) {
+			if ((pcrSel->pcrSelections[pcrCount].pcrSelect[pcrIndex / 8] &
+			     ((1 << (pcrIndex % 8)))) != 0)
+				printf(" %d", pcrIndex);
+		}
+		printf("\n");
+	}
+	return TPM_RC_SUCCESS;
+}
+
+int TPM2_Init_Device(WOLFTPM2_DEV *dev, void *userCtx)
+{
+	int rc;
+
+	/* Use TPM2_IoCb callback for packet-level access */
+	rc = wolfTPM2_Init(dev, TPM2_IoCb, userCtx);
+	log_debug("tpm2 init: rc = %d (%s)\n", rc, TPM2_GetRCString(rc));
+	return rc;
+}
+
+#endif /* WOLFTPM2_NO_WRAPPER */
+
+/******************************************************************************/
+/* --- END helper functions -- */
+/******************************************************************************/
-- 
2.43.0

