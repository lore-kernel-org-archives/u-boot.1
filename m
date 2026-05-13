Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E79CD343F
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 00:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4758468E;
	Wed, 13 May 2026 02:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="KyZtcMqp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7209584666; Wed, 13 May 2026 02:26:53 +0200 (CEST)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 166E784663
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 02:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2f3c623322bso10284949eec.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 17:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778632009; x=1779236809;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0El8fL7V2rnlVI+N9BFKj/5T74k++xVdhb8wf4QXRXM=;
 b=KyZtcMqpbF5S9aoJcIoTwtIumnqLAC1yXlKfP48rNDvBPd8Pixqu2i6r2EoJdtdQC9
 vR5/PlSgTUeRIbWSzF+3X50TdVNhRhMC7mnfMIBMpgtcaQCQ3VWNm+eOOwFxPKkGRJfd
 Ki84IKe0QIu5A9KatAjHKB+klQxh0qSx683Tkaera6rC3iRsT5unkiw+8a8yiwaPxZQ6
 bjxpTzvlFcAeyh0/bqViHE0/kBLrz/YlAYIwQ4oXcVkALrl/EEz9owlLTT6LPsm+Oais
 X/7JTTjk5mzPLDgas+SLPcMn6nsLapD4iJKchQmgx1ezNdKeKSx8ldp8fhN5+ts4KURc
 yQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778632009; x=1779236809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0El8fL7V2rnlVI+N9BFKj/5T74k++xVdhb8wf4QXRXM=;
 b=OPMfVShAv0ENswXJRDHrgKGOwOF6gP1dKq76gD9qpGvPalnGP5nP1t6d53yu7u0RIv
 sl1LVyJ7jlb42Z8PhTNC8GkgPRwMu31aLOh/ydAFClLKHtp2MRI5a/zYnHUqOo9I0tld
 yaBLnFt4K0AuIe4pMYsnUfpCv4n9MtukzSRjEqXFLwxm42U7XxL9pJ7yPZ8nX4MTL4kp
 SzMDSvD5F/9As+r6fH/qfk+T89i9+dPu7GWuG1dVDCFzVd1SzHOvMgW3pzLbqHNeY4Mr
 aDEzaklBAgI9EXkM2UpWtiuT8Ss++Cu6wp08KvuWW/+3Jw3c/DSLP0NEqKb0+6T/q8ef
 K8nA==
X-Gm-Message-State: AOJu0Yw+oqNUxi49vcRDeX9Awo0gSfPuUnAkGXsjyY2rAm/jPb16h4Xt
 2aB0XZ08WgydoVG97FLajWCq64RCi2fJ3vmymbm8jI9qITGYSUIRPtL/WuYz0ENl2TFp8aZoaiZ
 SkoCGi5w=
X-Gm-Gg: Acq92OF1ArXvAlzTiKqu0SNQR2H32gIA+M1ERdLo68Z8PzLNTnentE7QCDlHU8KrzSg
 P03GvxyyrzpiAsRctcKLdXHt73WIrcn5HiYRvLOeZCjCSxT8yQgIY7GiEoTR8axY906VghcsohJ
 tYoOpQ0Y5/QbfXeJ83EZesh6FFjExDbmK2Q/Uy+1WdTxTT8Ph2uyXe39PoMq+PVyGCyRkaMXlD4
 In7dqhm996R7I6mTRaLr7WlUfsZSogvhCiDLoXTZEfPIzKojiXD50t2st2XYO/En/amhZamfKND
 nPOASx8SVICDKgqI6bEzDU5t9Vr2Zbhuhxi4Fcf7oHFSnUpvrLfFBCuDNURTmIiXujphEYjJYrG
 4NWmnRyMePCfu5L/nDgrDxPZtxCSHWsZAe2ipEiThjTrQcKc9fjWFEqaLAnkJuMHjXS3ZLyA9Ox
 H/I40evG1rADgY5N8f8T0BmUVFVK4qkB1yMm8Ks7kBCHZnQ4FxETEJtB7MplRSSK8PkQ8g10usD
 9TxbI/XMQfb8cJvf1UoZm8hPJ7Rt4Ur
X-Received: by 2002:a05:7300:dc88:b0:2dd:6937:79c8 with SMTP id
 5a478bee46e88-30153adf92emr290771eec.5.1778632008912; 
 Tue, 12 May 2026 17:26:48 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884752ccsm19547827eec.17.2026.05.12.17.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 17:26:48 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, David Garske <david@wolfssl.com>,
 Aidan <aidan@wolfssl.com>
Subject: [PATCH v4 09/14] tpm: add wolfTPM driver helpers and Kconfig options
Date: Tue, 12 May 2026 17:26:13 -0700
Message-ID: <20260513002625.76915-9-aidan@wolfssl.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778619453.git.aidan@wolfssl.com>
References: <cover.1778619453.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 02:27:02 +0200
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
2.49.0

