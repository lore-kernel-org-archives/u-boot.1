Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0012CCD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E071284E2E;
	Sat,  9 May 2026 02:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="kSz2UADp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A55D684E10; Sat,  9 May 2026 02:04:50 +0200 (CEST)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C9E84E0F
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 02:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-130c9dcbd25so3054193c88.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 17:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778285086; x=1778889886;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWgXEyOxcvsKo7k9PShIaHo5DHtnMfjPJMe4Spd6224=;
 b=kSz2UADp2bwpDQ/JaBB5XwhFh+1EHQQNnyMyHq/mIim3Sgb+qfM5NISQeSgLSr7FwQ
 EVTphOSxZ1zPiiKc2KHETDQ4RicVnrAkofUbJUaQwpd0661bAgiN58GBNJS6SvenI7OD
 Gfv7X0I1UhlPnRb0EKa7v/h3VLBQ7UDzWi93oF9qmoxX9/z6WYjRm7w7DiMtYXzz8oAL
 9kUEHUffkCIdY54oY7FgFV0pEBQJZ9dRbTkixMw/kMr/n7zJu8h3EpRTSmep2FKiccwE
 SygJQ0krfOrsy+0KA+SOcEoqk+R9W1kbKudXkL2ki0tHLBgs0zT7N7ikvaADT+SG555J
 PsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778285086; x=1778889886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lWgXEyOxcvsKo7k9PShIaHo5DHtnMfjPJMe4Spd6224=;
 b=s7/G+gcjyDUu4e9m8xjJ9IQSU+PWa01/Veg/uCGeAXkBjFLwSqlA0ZvJwLxt5it4Yf
 wU3FbbQgMTcx+zO4KD6KMFoe+Qi5ag8OoEyjGn0FGGqacie08Qj+xC3/TfjudcPo8ELm
 I0loLjz0nN1Mb2fQRULYpJAG+Nj/fdS0xft7348Cpd/TKRAOSVXzp6arLMRjKvW06ncd
 bITCXHwS2MQnpiZgnMDzUrPjO/k0dYQxbrQjUq1FjrNDM8Tx7l1tarjVDMtIoUIoHHBB
 YBYGpHQbYaFjEuHLIA1jvXMrFMolUf0w0K0rY5wXurRE3Q4Q0kXZpG1Yfm5Hy4msLjGn
 8fmg==
X-Gm-Message-State: AOJu0Yy/+afEQEefF95k+0VtGUHfhsgZfcEVmPViK6DpeARBIsiNByFF
 ins5i0q4ha0rzhqwg/0bBqA+GieYoqD6CQ7HDWE5W5EfliLVU3S4AU13CVUr6BYoAvrbch4hva+
 39kti
X-Gm-Gg: AeBDietLqN39R+nXqdUrLUuLBtHSgESzCBXOTpRA/KE7Hv8Hhx5WFtlBB1tBgIbseet
 9kDAOAT0ZA41HiVZxRsaBmbAzTAHkpvWONfvcy8u7EbsQ35C/4/eyB0OMX2d9UiC6PmuAs+BMj9
 F3sLh2Lw3mTcAKH4Oah2ra1Q0T4q6c8YPrpLrygwzEN0hw4/xf2iGx4Nc9Wyy9s8OoXITZVbiR2
 zjYqP/CWnmYFxBq0WGQtB5su82RRzbnP74XgpEQw3phN0/E8w3/j9yQdpHuFvVKj0sTpmoABCvy
 0H4cQ/P2QXgid92AQArexQoOSHvKxFFmbWVrUX7HX/oKKPB8S0LTe1L/c/FaxxfU2d1wZFXx99c
 p0JFpuCMxCYrhSDXXa7ctjFpp638/nZuXho0LnMwsgxYsuy3rYo73G3UNULKgNqTGaM/58yO4br
 LnG69YlP5PTRhL7QstqHMiCePd8rsjNtiEEWp1LDEntjxHTuxfY6NVeaTHPHb1Be8FhowSqNyIV
 9vzzZ8mLf6BHlJR3dxEhgdhxw/tCY8D
X-Received: by 2002:a05:7022:2224:b0:12c:8eb:80b9 with SMTP id
 a92af1059eb24-1323aa6552cmr3715480c88.6.1778285086091; 
 Fri, 08 May 2026 17:04:46 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132787673ffsm5505030c88.15.2026.05.08.17.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:04:45 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: David Garske <david@wolfssl.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 07/12] tpm: add wolfTPM driver helpers and Kconfig options
Date: Fri,  8 May 2026 17:04:14 -0700
Message-ID: <44fb6aa80d06ea63fe1fd7db92e07a363d2a4509.1778277334.git.aidan@wolfssl.com>
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
2.47.3

