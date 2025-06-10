Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824CCC677C4
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 16:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 266BD82BD6;
	Tue, 10 Jun 2025 18:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vetlq1JC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401B482B7C; Tue, 10 Jun 2025 18:51:18 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56E7582B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 18:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so34390765e9.2
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749574275; x=1750179075; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EyDWKDzd9TYH77ftnT6J9P6bRsqEL1fPcouzAnMp5/8=;
 b=Vetlq1JCUZG56iRbujejKZaFEvXPZ7WokogGoemQLhjseEkGja0sF8+Lrp89qKYEII
 j4Sq0xxLxlAG8Mx9RJU7mjqrKD0ANUQ3kJcAXR0eGRlXABlBi5GPm4QDefaZHF698frl
 nCrdT7cfLVbsGvQHrx2A5SjWmkT7dmjWf01Aalub7oSvjkb/CqrlunAcc7n02s/6x2b0
 foNnIc1HNdAKN1umH52xWTknM3gSgqUarHo4jZThPxaO2xESBC7ZZATdPgJHJn7YvO65
 n0UxOXXWRopJSiqYx/M9saJDbtaYvi3uIItkRrHbDBooHRtPL+Pf/rt2Kj3usKp+eAQs
 Onpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749574275; x=1750179075;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EyDWKDzd9TYH77ftnT6J9P6bRsqEL1fPcouzAnMp5/8=;
 b=hZhSP0BK2J3i/nJWMOTOLryVhM3LuLeNBlVH29bstKDXLZhdFPBj19FYldN1hTz0DQ
 d7IRo8KmwJCR5DwJXVVNB2IQWA4G5LOlZAaAWHesOIYAAi6TE1FCD9MhQs81WWR686xZ
 +mCaSXrmKgk1FICC4Zgn87RuIPBJU/hnxDUVpBU7MkItZSlqeBXb9kVkFqkha+yDinAb
 wCYhgKXlkTitQwaE7s6DG16fT8RKJ7UqCduX2hK8rY+YNqkAyeVHAE+49FOcf+yk3a98
 X0dgbovW+t+PehU0OXKBNyROQShiP75J3ozTTo7Jr6+H0qAFCrmRKYZO1Dt4B5UCQVfo
 I0Ow==
X-Gm-Message-State: AOJu0YxUFNpfDmrEnm/l411kiR4YypKdLN9IDIFgCnqU5fHFCTMkUIWe
 C1BZlh46/3Po7Vbgw2ZzcUOzRQxwJjlvupA8SbPBd57ipwq/YooC0zFIwCLX85xDlMU=
X-Gm-Gg: ASbGncuPP4il2hKwDX/u8MHLCxeTVgHxlODkaMeb1BwppLfy5Kgz43Rn04PsSF+T9r5
 OGtDmE5tiDehSHwXhE2skYQn5NxBaUg3YnPerZDZGiB8ph6ylWV9mPUAXh1W1gaT0AZRCr8ZUiw
 yOxu80brefQiYkrdsghtMu7CAmJNr4m4eoaxN+IZPfJmOQI3f22kknzR+xkSoEo8O6nAMuB8xd+
 BC7UW3lUJrCVc31NqjB9l1yJz5Tf5hDfmATLucD/xNe7JAxHeYJR0cXRZSMwq4DgsSlXWPqXe8a
 IPSgm1fhQYVQaWt1Q+bFKPB6/hhslA6Jdsb2edO8vaCEbOd2BUpORRRZkvEDQ1vQbzXnYIGV
X-Google-Smtp-Source: AGHT+IFmi9KbBja8eB1sP8Vf5qQjbfrj7VdL3B0TMxuzQ9XTCcBFt/lVECgCmRhsF4z6Rdb+SYTNqA==
X-Received: by 2002:a05:600c:a10c:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-4531de00a37mr29031775e9.12.1749574274510; 
 Tue, 10 Jun 2025 09:51:14 -0700 (PDT)
Received: from toyger.local ([2a01:170:117e:fc:3626:366e:4bd3:97c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452669ada25sm148665345e9.0.2025.06.10.09.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 09:51:13 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 10 Jun 2025 18:50:51 +0200
Subject: [PATCH v2 2/3] misc: introduce Qcom GENI wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250610-geni-load-fw-v2-2-7cad6bc18db0@linaro.org>
References: <20250610-geni-load-fw-v2-0-7cad6bc18db0@linaro.org>
In-Reply-To: <20250610-geni-load-fw-v2-0-7cad6bc18db0@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=31277;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=BdkcsBMpgLSu5OziMh4rJB/e58gEkDs77CrDs3Z1f1M=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSGJ+Lr2yxC3FJnEKZ4DsLUobN8z/BVWPfqOVv
 IW/UCKZ24mJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaEhifgAKCRAFgzErGV9k
 trKND/4q7LZhnu8VfMc4gcCxckdlx3Qy8ZY33S2wZEJ0A4O8eKjJ0bIzc6ramspze1+wGwxX++k
 6ZJ6yrC/b7WtFbrcb4H0zUrFErerqEpOP8/d8pUF9WaPSxxgJuU5UCV523iBtCci5x1WgNXWRZ3
 WzncH57LNBU6jBJ8OtPBlC9WwUpClUG/6fYDp9XqFOdndD5evc7YbNkbpi668q2PQ5+bfgfa/L6
 idI7H5awomQbGziTvNHR/HexPHjU4JRrDhB7zVxp4uyigSFPhy4htCWx77RlcHU635cjNlmCyy8
 oBA8f6bx31LBmYlXKSI8DV0udlBT4l4I2690I4kK24sDYh5iikuX6iUtssF9VDv92gtzWYqFWhU
 3vEN6fa2zE38el9GjuuWtQeRFySJs4Ue3pmh9Pp6qWZolRgKfamKlAvFB3LYFd/1xCobkarH+I+
 On0ICEja2hCRc2ILORZoetfqMCGlPNVb+r2lYsTXJFmXh37U9YCUZ0aqwwxgwBrtS+/RYh0rS0J
 MLeuf1/SGxFcx8ZtMTf4FO4l4JbbhxlkjvIx2+wZhVWhg2770gk7TL53zu72TQ5i4TLLQYfgeAW
 8jThKfkCvYEEKn5RLUQF2UA6rje5SNP0lNDnTgewBWj7tdEGBMgNajs5PkIYpS5xfvl73Tyvfzw
 crdqksk4DvDmY8g==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Qualcomm peripherals like UART, SPI, I2C, etc are all exposed under a
common GENI Serial Engine wrapper device. Replace the stub driver we use
for this currently with a full-on misc device and implement support for
loading peripheral firmware.

Each of the peripherals has it's own protocol-specific firmware, this is
stored on the internal storage of the device with a well-known partition
type GUID.

To support this, GENI will bind peripherals in two stages. First the
ones that already have firmware loaded (such as the serial port) are
bound in the typical way. But devices that require firmware loading are
deferred until EVT_LAST_STAGE_INIT. At this point we can be sure that
the storage device is available, so we load the firmware and then bind
and probe the remaining children.

Child devices are expected to determine if firmware loading is necessary
and call qcom_geni_load_firmware().

Since Linux currently doesn't support loading firmware (and firmware may
not be available), we probe all GENI peripherals to ensure that they
always load firmware if necessary.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/Kconfig                 |   1 +
 drivers/misc/Kconfig             |   9 +
 drivers/misc/Makefile            |   1 +
 drivers/misc/qcom_geni.c         | 576 +++++++++++++++++++++++++++++++++++++++
 drivers/serial/serial_msm_geni.c |  13 -
 include/soc/qcom/geni-se.h       |  36 +++
 include/soc/qcom/qup-fw-load.h   | 178 ++++++++++++
 7 files changed, 801 insertions(+), 13 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 579c8acfcb466122c4fe66950ec7ca24c355b43a..5b83e3386be6ab7fa8d7f5306851d90a87fb75c3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1124,8 +1124,9 @@ config ARCH_SNAPDRAGON
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
 	select SYSRESET_PSCI
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
+	select QCOM_GENI
 	imply OF_UPSTREAM
 	imply CMD_DM
 	imply DM_USB_GADGET
 
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ffc5868c0dd3e884fddb98b10f4b878d3f08b43a..78aaf003852aab96450963d93678787d30892f1b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -82,8 +82,17 @@ config GATEWORKS_SC
 	  Enable access for the Gateworks System Controller used on Gateworks
 	  boards to provide a boot watchdog, power control, temperature monitor,
 	  voltage ADCs, and EEPROM.
 
+config QCOM_GENI
+	bool "Qualcomm Generic Interface (GENI) driver"
+	depends on MISC
+	select PARTITION_TYPE_GUID
+	help
+	  Enable support for Qualcomm GENI and it's peripherals. GENI is responseible
+	  for providing a common interface for various peripherals like UART, I2C, SPI,
+	  etc.
+
 config ROCKCHIP_EFUSE
         bool "Rockchip e-fuse support"
 	depends on MISC
 	help
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 248068d5b4369bfe6d23216e92de4ee32bdfd081..627eef29af33fe06f44506467721e7121f64d502 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -68,8 +68,9 @@ obj-$(CONFIG_QFW_PIO) += qfw_pio.o
 obj-$(CONFIG_QFW_MMIO) += qfw_mmio.o
 obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
+obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
 obj-$(CONFIG_SANDBOX) += syscon_sandbox.o misc_sandbox.o
diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
new file mode 100644
index 0000000000000000000000000000000000000000..2b652765aa310b5a21d4aa99b50842c2e17e5942
--- /dev/null
+++ b/drivers/misc/qcom_geni.c
@@ -0,0 +1,576 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2025, Linaro Ltd.
+ */
+
+#include <blk.h>
+#include <part.h>
+#include <dm/device.h>
+#include <dm/read.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <elf.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <misc.h>
+#include <linux/printk.h>
+#include <soc/qcom/geni-se.h>
+#include <soc/qcom/qup-fw-load.h>
+#include <dm/device_compat.h>
+
+struct qup_se_rsc {
+	phys_addr_t base;
+	phys_addr_t wrapper_base;
+	struct udevice *dev;
+
+	enum geni_se_xfer_mode mode;
+	enum geni_se_protocol_type protocol;
+};
+
+struct geni_se_plat {
+	bool need_firmware_load;
+};
+
+/**
+ * geni_enable_interrupts() Enable interrupts.
+ * @rsc: Pointer to a structure representing SE-related resources.
+ *
+ * Enable the required interrupts during the firmware load process.
+ *
+ * Return: None.
+ */
+static void geni_enable_interrupts(struct qup_se_rsc *rsc)
+{
+	u32 reg_value;
+
+	/* Enable required interrupts. */
+	writel_relaxed(M_COMMON_GENI_M_IRQ_EN, rsc->base + GENI_M_IRQ_ENABLE);
+
+	reg_value = S_CMD_OVERRUN_EN | S_ILLEGAL_CMD_EN |
+				S_CMD_CANCEL_EN | S_CMD_ABORT_EN |
+				S_GP_IRQ_0_EN | S_GP_IRQ_1_EN |
+				S_GP_IRQ_2_EN | S_GP_IRQ_3_EN |
+				S_RX_FIFO_WR_ERR_EN | S_RX_FIFO_RD_ERR_EN;
+	writel_relaxed(reg_value, rsc->base + GENI_S_IRQ_ENABLE);
+
+	/* DMA mode configuration. */
+	reg_value = DMA_TX_IRQ_EN_SET_RESET_DONE_EN_SET_BMSK |
+		    DMA_TX_IRQ_EN_SET_SBE_EN_SET_BMSK |
+		    DMA_TX_IRQ_EN_SET_DMA_DONE_EN_SET_BMSK;
+	writel_relaxed(reg_value, rsc->base + DMA_TX_IRQ_EN_SET);
+	reg_value = DMA_RX_IRQ_EN_SET_FLUSH_DONE_EN_SET_BMSK |
+		    DMA_RX_IRQ_EN_SET_RESET_DONE_EN_SET_BMSK |
+		    DMA_RX_IRQ_EN_SET_SBE_EN_SET_BMSK |
+		    DMA_RX_IRQ_EN_SET_DMA_DONE_EN_SET_BMSK;
+	writel_relaxed(reg_value, rsc->base + DMA_RX_IRQ_EN_SET);
+}
+
+/**
+ * geni_flash_fw_revision() - Flash the firmware revision.
+ * @rsc: Pointer to a structure representing SE-related resources.
+ * @hdr: Pointer to the ELF header of the Serial Engine.
+ *
+ * Flash the firmware revision and protocol into the respective register.
+ *
+ * Return: None.
+ */
+static void geni_flash_fw_revision(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
+{
+	u32 reg_value;
+
+	/* Flash firmware revision register. */
+	reg_value = (hdr->serial_protocol << FW_REV_PROTOCOL_SHFT) |
+		    (hdr->fw_version & 0xFF << FW_REV_VERSION_SHFT);
+	writel_relaxed(reg_value, rsc->base + SE_GENI_FW_REVISION);
+
+	reg_value = (hdr->serial_protocol << FW_REV_PROTOCOL_SHFT) |
+		    (hdr->fw_version & 0xFF << FW_REV_VERSION_SHFT);
+
+	writel_relaxed(reg_value, rsc->base + SE_S_FW_REVISION);
+}
+
+/**
+ * geni_configure_xfer_mode() - Set the transfer mode.
+ * @rsc: Pointer to a structure representing SE-related resources.
+ *
+ * Set the transfer mode to either FIFO or DMA according to the mode specified by the protocol
+ * driver.
+ *
+ * Return: 0 if successful, otherwise return an error value.
+ */
+static int geni_configure_xfer_mode(struct qup_se_rsc *rsc)
+{
+	/* Configure SE FIFO, DMA or GSI mode. */
+	switch (rsc->mode) {
+	case GENI_GPI_DMA:
+		geni_setbits32(rsc->base + QUPV3_SE_GENI_DMA_MODE_EN,
+			       GENI_DMA_MODE_EN_GENI_DMA_MODE_EN_BMSK);
+		writel_relaxed(0x0, rsc->base + SE_IRQ_EN);
+		writel_relaxed(SE_GSI_EVENT_EN_BMSK, rsc->base + SE_GSI_EVENT_EN);
+		break;
+
+	case GENI_SE_FIFO:
+		geni_clrbits32(rsc->base + QUPV3_SE_GENI_DMA_MODE_EN,
+			       GENI_DMA_MODE_EN_GENI_DMA_MODE_EN_BMSK);
+		writel_relaxed(SE_IRQ_EN_RMSK, rsc->base + SE_IRQ_EN);
+		writel_relaxed(0x0, rsc->base + SE_GSI_EVENT_EN);
+		break;
+
+	case GENI_SE_DMA:
+		geni_setbits32(rsc->base + QUPV3_SE_GENI_DMA_MODE_EN,
+			       GENI_DMA_MODE_EN_GENI_DMA_MODE_EN_BMSK);
+		writel_relaxed(SE_IRQ_EN_RMSK, rsc->base + SE_IRQ_EN);
+		writel_relaxed(0x0, rsc->base + SE_GSI_EVENT_EN);
+		break;
+
+	default:
+		dev_err(rsc->dev, "invalid se mode: %d\n", rsc->mode);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/**
+ * geni_config_common_control() - Configure common CGC and disable high priority interrupt.
+ * @rsc: Pointer to a structure representing SE-related resources.
+ *
+ * Configure the common CGC and disable high priority interrupts until the current low priority
+ * interrupts are handled.
+ *
+ * Return: None.
+ */
+static void geni_config_common_control(struct qup_se_rsc *rsc)
+{
+	/*
+	 * Disable high priority interrupt until current low priority interrupts are handled.
+	 */
+	geni_setbits32(rsc->wrapper_base + QUPV3_COMMON_CFG,
+		       FAST_SWITCH_TO_HIGH_DISABLE_BMASK);
+
+	/*
+	 * Set AHB_M_CLK_CGC_ON to indicate hardware controls se-wrapper cgc clock.
+	 */
+	geni_setbits32(rsc->wrapper_base + QUPV3_SE_AHB_M_CFG,
+		       AHB_M_CLK_CGC_ON_BMASK);
+
+	/* Let hardware to control common cgc. */
+	geni_setbits32(rsc->wrapper_base + QUPV3_COMMON_CGC_CTRL,
+		       COMMON_CSR_SLV_CLK_CGC_ON_BMASK);
+}
+
+static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
+{
+	const u32 *fw_val_arr, *cfg_val_arr;
+	const u8 *cfg_idx_arr;
+	u32 i, reg_value, mask, ramn_cnt;
+	int ret;
+
+	fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
+	cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
+	cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
+
+	geni_config_common_control(rsc);
+
+	/* Allows to drive corresponding data according to hardware value. */
+	writel_relaxed(0x0, rsc->base + GENI_OUTPUT_CTRL);
+
+	/* Set SCLK and HCLK to program RAM */
+	geni_setbits32(rsc->base + GENI_CGC_CTRL, GENI_CGC_CTRL_PROG_RAM_SCLK_OFF_BMSK |
+		       GENI_CGC_CTRL_PROG_RAM_HCLK_OFF_BMSK);
+	writel_relaxed(0x0, rsc->base + SE_GENI_CLK_CTRL);
+	geni_clrbits32(rsc->base + GENI_CGC_CTRL, GENI_CGC_CTRL_PROG_RAM_SCLK_OFF_BMSK |
+		       GENI_CGC_CTRL_PROG_RAM_HCLK_OFF_BMSK);
+
+	/* Enable required clocks for DMA CSR, TX and RX. */
+	reg_value = DMA_GENERAL_CFG_AHB_SEC_SLV_CLK_CGC_ON_BMSK |
+		DMA_GENERAL_CFG_DMA_AHB_SLV_CLK_CGC_ON_BMSK |
+		DMA_GENERAL_CFG_DMA_TX_CLK_CGC_ON_BMSK |
+		DMA_GENERAL_CFG_DMA_RX_CLK_CGC_ON_BMSK;
+
+	geni_setbits32(rsc->base + DMA_GENERAL_CFG, reg_value);
+
+	/* Let hardware control CGC by default. */
+	writel_relaxed(DEFAULT_CGC_EN, rsc->base + GENI_CGC_CTRL);
+
+	/* Set version of the configuration register part of firmware. */
+	writel_relaxed(hdr->cfg_version, rsc->base + GENI_INIT_CFG_REVISION);
+	writel_relaxed(hdr->cfg_version, rsc->base + GENI_S_INIT_CFG_REVISION);
+
+	/* Configure GENI primitive table. */
+	for (i = 0; i < hdr->cfg_size_in_items; i++)
+		writel_relaxed(cfg_val_arr[i],
+			       rsc->base + GENI_CFG_REG0 + (cfg_idx_arr[i] * sizeof(u32)));
+
+	/* Configure condition for assertion of RX_RFR_WATERMARK condition. */
+	reg_value = readl_relaxed(rsc->base + QUPV3_SE_HW_PARAM_1);
+	mask = (reg_value >> RX_FIFO_WIDTH_BIT) & RX_FIFO_WIDTH_MASK;
+	writel_relaxed(mask - 2, rsc->base + GENI_RX_RFR_WATERMARK_REG);
+
+	/* Let hardware control CGC */
+	geni_setbits32(rsc->base + GENI_OUTPUT_CTRL, DEFAULT_IO_OUTPUT_CTRL_MSK);
+
+	ret = geni_configure_xfer_mode(rsc);
+	if (ret) {
+		dev_err(rsc->dev, "failed to configure xfer mode: %d\n", ret);
+		return ret;
+	}
+
+	geni_enable_interrupts(rsc);
+
+	geni_flash_fw_revision(rsc, hdr);
+
+	ramn_cnt = hdr->fw_size_in_items;
+	if (hdr->fw_size_in_items % 2 != 0)
+		ramn_cnt++;
+
+	if (ramn_cnt >= MAX_GENI_CFG_RAMn_CNT) {
+		dev_err(rsc->dev, "firmware size is too large\n");
+		return -EINVAL;
+	}
+
+	/* Program RAM address space. */
+	for (i = 0; i < hdr->fw_size_in_items; i++)
+		writel_relaxed(fw_val_arr[i], rsc->base + SE_GENI_CFG_RAMN + i * sizeof(u32));
+
+	/* Put default values on GENI's output pads. */
+	writel_relaxed(0x1, rsc->base + GENI_FORCE_DEFAULT_REG);
+
+	/* High to low SCLK and HCLK to finish RAM. */
+	geni_setbits32(rsc->base + GENI_CGC_CTRL, GENI_CGC_CTRL_PROG_RAM_SCLK_OFF_BMSK |
+			GENI_CGC_CTRL_PROG_RAM_HCLK_OFF_BMSK);
+	geni_setbits32(rsc->base + SE_GENI_CLK_CTRL, GENI_CLK_CTRL_SER_CLK_SEL_BMSK);
+	geni_clrbits32(rsc->base + GENI_CGC_CTRL, GENI_CGC_CTRL_PROG_RAM_SCLK_OFF_BMSK |
+			GENI_CGC_CTRL_PROG_RAM_HCLK_OFF_BMSK);
+
+	/* Serial engine DMA interface is enabled. */
+	geni_setbits32(rsc->base + SE_DMA_IF_EN, DMA_IF_EN_DMA_IF_EN_BMSK);
+
+	/* Enable or disable FIFO interface of the serial engine. */
+	if (rsc->mode == GENI_SE_FIFO)
+		geni_clrbits32(rsc->base + SE_FIFO_IF_DISABLE, FIFO_IF_DISABLE);
+	else
+		geni_setbits32(rsc->base + SE_FIFO_IF_DISABLE, FIFO_IF_DISABLE);
+
+	return 0;
+}
+
+/**
+ * elf_phdr_valid() - Validate an ELF header.
+ * @phdr: Pointer to the ELF header.
+ *
+ * Validate the ELF header by comparing the fields stored in p_flags and the payload type.
+ *
+ * Return: true if the validation is successful, false otherwise.
+ */
+static bool elf_phdr_valid(const Elf32_Phdr *phdr)
+{
+	if (phdr->p_type != PT_LOAD || !phdr->p_memsz)
+		return false;
+
+	if (MI_PBT_PAGE_MODE_VALUE(phdr->p_flags) == MI_PBT_NON_PAGED_SEGMENT &&
+	    MI_PBT_SEGMENT_TYPE_VALUE(phdr->p_flags) != MI_PBT_HASH_SEGMENT &&
+	    MI_PBT_ACCESS_TYPE_VALUE(phdr->p_flags) != MI_PBT_NOTUSED_SEGMENT &&
+	    MI_PBT_ACCESS_TYPE_VALUE(phdr->p_flags) != MI_PBT_SHARED_SEGMENT)
+		return true;
+
+	return false;
+}
+
+/**
+ * valid_seg_size() - Validate the segment size.
+ * @pelfseg: Pointer to the ELF header.
+ * @p_filesz: Pointer to the file size.
+ *
+ * Validate the ELF segment size by comparing the file size.
+ *
+ * Return: true if the segment is valid, false if the segment is invalid.
+ */
+static bool valid_seg_size(struct elf_se_hdr *pelfseg, Elf32_Word p_filesz)
+{
+	if (p_filesz >= pelfseg->fw_offset + pelfseg->fw_size_in_items * sizeof(u32) &&
+	    p_filesz >= pelfseg->cfg_idx_offset + pelfseg->cfg_size_in_items * sizeof(u8) &&
+	    p_filesz >= pelfseg->cfg_val_offset + pelfseg->cfg_size_in_items * sizeof(u32))
+		return true;
+	return false;
+}
+
+/**
+ * read_elf() - Read an ELF file.
+ * @rsc: Pointer to the SE resources structure.
+ * @fw: Pointer to the firmware buffer.
+ * @pelfseg: Pointer to the SE-specific ELF header.
+ * @phdr: Pointer to one of the valid headers from the list in the firmware buffer.
+ *
+ * Read the ELF file and output a pointer to the header data, which contains the firmware data and
+ * any other details.
+ *
+ * Return: 0 if successful, otherwise return an error value.
+ */
+static int read_elf(struct qup_se_rsc *rsc, const void *fw,
+		    struct elf_se_hdr **pelfseg)
+{
+	Elf32_Phdr *phdr;
+	const Elf32_Ehdr *ehdr = (const Elf32_Ehdr *)fw;
+	Elf32_Phdr *phdrs = (Elf32_Phdr *)(ehdr + 1);
+	const u8 *addr;
+	int i;
+
+	ehdr = (Elf32_Ehdr *)fw;
+
+	if (ehdr->e_phnum < 2)
+		return -EINVAL;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = &phdrs[i];
+		if (!elf_phdr_valid(phdr))
+			continue;
+
+		if (phdr->p_filesz >= sizeof(struct elf_se_hdr)) {
+			addr =  fw + phdr->p_offset;
+			*pelfseg = (struct elf_se_hdr *)addr;
+
+			if ((*pelfseg)->magic == MAGIC_NUM_SE &&
+			    (*pelfseg)->version == 1 &&
+			    valid_seg_size(*pelfseg, phdr->p_filesz) &&
+			    (*pelfseg)->serial_protocol == rsc->protocol &&
+			    (*pelfseg)->serial_protocol != GENI_SE_NONE)
+				return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+int qcom_geni_load_firmware(phys_addr_t qup_base,
+			    struct udevice *dev)
+{
+	struct qup_se_rsc rsc;
+	struct elf_se_hdr *hdr;
+	int ret;
+	void *fw;
+
+	rsc.dev = dev;
+	rsc.base = qup_base;
+	rsc.wrapper_base = dev_read_addr(dev->parent);
+
+	/* FIXME: GSI DMA mode if device has property qcom,gsi-dma-allowed */
+	rsc.mode = GENI_SE_FIFO;
+
+	switch (device_get_uclass_id(dev)) {
+	case UCLASS_I2C:
+		rsc.protocol = GENI_SE_I2C;
+		break;
+	case UCLASS_SPI:
+		rsc.protocol = GENI_SE_SPI;
+		break;
+	case UCLASS_SERIAL:
+		rsc.protocol = GENI_SE_UART;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* The firmware blob is the private data of the GENI wrapper (parent) */
+	fw = dev_get_priv(dev->parent);
+
+	ret = read_elf(&rsc, fw, &hdr);
+	if (ret) {
+		dev_err(dev, "Failed to read ELF: %d\n", ret);
+		return ret;
+	}
+
+	printf("Loading firmware for %s\n", dev->name);
+
+	return load_se_firmware(&rsc, hdr);
+}
+
+/*
+ * We need to determine if firmware loading is necessary. Best way to do that is to check the FW
+ * revision of each QUP and see if it has already been loaded.
+ */
+static int geni_se_of_to_plat(struct udevice *dev)
+{
+	ofnode child;
+	struct resource res;
+	u32 proto;
+	struct geni_se_plat *plat = dev_get_plat(dev);
+
+	plat->need_firmware_load = false;
+
+	dev_for_each_subnode(child, dev) {
+		if (!ofnode_is_enabled(child))
+			continue;
+
+		if (ofnode_read_resource(child, 0, &res))
+			continue;
+
+		proto = readl(res.start + GENI_FW_REVISION_RO);
+		proto &= FW_REV_PROTOCOL_MSK;
+		proto >>= FW_REV_PROTOCOL_SHFT;
+
+		if (proto == GENI_SE_INVALID_PROTO) {
+			plat->need_firmware_load = true;
+		} else {
+			/* Bind any devices that don't need firmware loading now. */
+			lists_bind_fdt(dev, child, NULL, NULL, false);
+		}
+	}
+
+	return 0;
+}
+
+#define QUPFW_PART_TYPE_GUID "21d1219f-2ed1-4ab4-930a-41a16ae75f7f"
+
+static int find_qupfw_part(struct udevice **blk_dev, struct disk_partition *part_info)
+{
+	struct blk_desc *desc;
+	int ret, partnum;
+
+	uclass_foreach_dev_probe(UCLASS_BLK, *blk_dev) {
+		if (device_get_uclass_id(*blk_dev) != UCLASS_BLK)
+			continue;
+
+		desc = dev_get_uclass_plat(*blk_dev);
+		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
+			continue;
+		for (partnum = 1;; partnum++) {
+			ret = part_get_info(desc, partnum, part_info);
+			if (ret)
+				break;
+			if (!strcmp(part_info->type_guid, QUPFW_PART_TYPE_GUID))
+				return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static int probe_children_load_firmware(struct udevice *dev)
+{
+	struct geni_se_plat *plat;
+	ofnode child;
+	struct udevice *child_dev;
+	struct resource res;
+	u32 proto;
+
+	plat = dev_get_plat(dev);
+
+	dev_for_each_subnode(child, dev) {
+		if (!ofnode_is_enabled(child))
+			continue;
+
+		if (ofnode_read_resource(child, 0, &res))
+			continue;
+
+		proto = readl(res.start + GENI_FW_REVISION_RO);
+		proto &= FW_REV_PROTOCOL_MSK;
+		proto >>= FW_REV_PROTOCOL_SHFT;
+
+		if (proto != GENI_SE_INVALID_PROTO)
+			continue;
+
+		/*
+		 * Now we're ready, bind and probe the child, this will trigger firmware loading.
+		 */
+		lists_bind_fdt(dev, child, &child_dev, NULL, false);
+		debug("Probing child %s for fw loading\n", child_dev->name);
+		device_probe(child_dev);
+	}
+
+	return 0;
+}
+
+#define MAX_FW_BUF_SIZE (128 * 1024)
+
+/*
+ * Load firmware for QCOM GENI peripherals from the dedicated partition on storage and bind/probe
+ * all the peripheral devices that need firmware to be loaded.
+ */
+static int qcom_geni_fw_initialise(void)
+{
+	debug("Loading firmware for QCOM GENI SE\n");
+	struct udevice *geni_wrapper, *blk_dev;
+	struct disk_partition part_info;
+	int ret;
+	void *fw_buf;
+	size_t fw_size = MAX_FW_BUF_SIZE;
+	struct geni_se_plat *plat;
+
+	/* Find the first GENI SE wrapper that needs fw loading */
+	for (uclass_first_device(UCLASS_MISC, &geni_wrapper);
+	     geni_wrapper;
+	     uclass_next_device(&geni_wrapper)) {
+		if (device_get_uclass_id(geni_wrapper) == UCLASS_MISC &&
+		    !strcmp(geni_wrapper->driver->name, "geni-se-qup")) {
+			plat = dev_get_plat(geni_wrapper);
+			if (plat->need_firmware_load)
+				break;
+		}
+	}
+	if (!geni_wrapper) {
+		printf("GENI SE wrapper not found\n");
+		return 0;
+	}
+
+	ret = find_qupfw_part(&blk_dev, &part_info);
+	if (ret) {
+		printf("QUP firmware partition not found\n");
+		return 0;
+	}
+
+	if (part_info.size * part_info.blksz > MAX_FW_BUF_SIZE) {
+		printf("Firmware partition too large\n");
+		return -EINVAL;
+	}
+	fw_size = part_info.size * part_info.blksz;
+
+	fw_buf = malloc(fw_size);
+	if (!fw_buf) {
+		printf("Failed to allocate buffer for firmware\n");
+		return -ENOMEM;
+	}
+	memset(fw_buf, 0, fw_size);
+
+	ret = blk_read(blk_dev, part_info.start, part_info.size, fw_buf);
+	if (ret < 0) {
+		printf("Failed to read firmware from partition\n");
+		free(fw_buf);
+		return 0;
+	}
+
+	/*
+	 * OK! Firmware is loaded, now bind and probe remaining children. They will attempt to load
+	 * firmware during probe. Do this for each GENI SE wrapper that needs firmware loading.
+	 */
+	for (; geni_wrapper;
+	     uclass_next_device(&geni_wrapper)) {
+		if (device_get_uclass_id(geni_wrapper) == UCLASS_MISC &&
+		    !strcmp(geni_wrapper->driver->name, "geni-se-qup")) {
+			plat = dev_get_plat(geni_wrapper);
+			if (plat->need_firmware_load) {
+				dev_set_priv(geni_wrapper, fw_buf);
+				probe_children_load_firmware(geni_wrapper);
+			}
+		}
+	}
+
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qcom_geni_fw_initialise);
+
+static const struct udevice_id geni_ids[] = {
+	{ .compatible = "qcom,geni-se-qup" },
+	{}
+};
+
+U_BOOT_DRIVER(sifive_otp) = {
+	.name = "geni-se-qup",
+	.id = UCLASS_MISC,
+	.of_match = geni_ids,
+	.of_to_plat = geni_se_of_to_plat,
+	.plat_auto = sizeof(struct geni_se_plat),
+	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 620cb9a59343bd50df639dd342271f1da19d9cee..35e0029144be7948eb5ab0da5a2d1317a08fb0c5 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -602,21 +602,8 @@ U_BOOT_DRIVER(serial_msm_geni) = {
 	.ops = &msm_serial_ops,
 	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
-static const struct udevice_id geniqup_ids[] = {
-	{ .compatible = "qcom,geni-se-qup" },
-	{ }
-};
-
-U_BOOT_DRIVER(geni_se_qup) = {
-	.name = "geni-se-qup",
-	.id = UCLASS_NOP,
-	.of_match = geniqup_ids,
-	.bind = dm_scan_fdt_dev,
-	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
-};
-
 #ifdef CONFIG_DEBUG_UART_MSM_GENI
 
 static struct msm_serial_data init_serial_data = {
 	.base = CONFIG_VAL(DEBUG_UART_BASE)
diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
index 698a9256d2656d3fd207cb48a9f4918afc365a1b..fc9a8e82cd88a63cd50dcfb0647fa28b53adad37 100644
--- a/include/soc/qcom/geni-se.h
+++ b/include/soc/qcom/geni-se.h
@@ -5,16 +5,24 @@
 
 #ifndef _QCOM_GENI_SE
 #define _QCOM_GENI_SE
 
+enum geni_se_xfer_mode {
+	GENI_SE_INVALID,
+	GENI_SE_FIFO,
+	GENI_SE_DMA,
+	GENI_GPI_DMA,
+};
+
 /* Protocols supported by GENI Serial Engines */
 enum geni_se_protocol_type {
 	GENI_SE_NONE,
 	GENI_SE_SPI,
 	GENI_SE_UART,
 	GENI_SE_I2C,
 	GENI_SE_I3C,
 	GENI_SE_SPI_SLAVE,
+	GENI_SE_INVALID_PROTO = 255,
 };
 
 #define QUP_HW_VER_REG			0x4
 
@@ -28,8 +36,9 @@ enum geni_se_protocol_type {
 #define GENI_SER_M_CLK_CFG		0x48
 #define GENI_SER_S_CLK_CFG		0x4c
 #define GENI_IF_DISABLE_RO		0x64
 #define GENI_FW_REVISION_RO		0x68
+#define GENI_DFS_IF_CFG			0x80
 #define SE_GENI_CLK_SEL			0x7c
 #define SE_GENI_CFG_SEQ_START		0x84
 #define SE_GENI_BYTE_GRAN		0x254
 #define SE_GENI_DMA_MODE_EN		0x258
@@ -56,17 +65,26 @@ enum geni_se_protocol_type {
 #define SE_GENI_RX_RFR_WATERMARK_REG	0x814
 #define SE_GENI_IOS			0x908
 #define SE_DMA_TX_IRQ_STAT		0xc40
 #define SE_DMA_TX_IRQ_CLR		0xc44
+#define SE_DMA_TX_IRQ_EN_SET		0xc4c
 #define SE_DMA_TX_FSM_RST		0xc58
 #define SE_DMA_RX_IRQ_STAT		0xd40
 #define SE_DMA_RX_IRQ_CLR		0xd44
+#define SE_DMA_RX_IRQ_EN_SET		0xd4c
 #define SE_DMA_RX_LEN_IN		0xd54
 #define SE_DMA_RX_FSM_RST		0xd58
 #define SE_GSI_EVENT_EN			0xe18
 #define SE_IRQ_EN			0xe1c
 #define SE_HW_PARAM_0			0xe24
 #define SE_HW_PARAM_1			0xe28
+#define SE_DMA_GENERAL_CFG		0xe30
+
+/* GENI_DFS_IF_CFG fields */
+#define DFS_IF_EN BIT(0)
+
+/* SE_DMA_RX_IRQ_EN_SET fields */
+#define RESET_DONE_EN_SET BIT(3)
 
 /* GENI_FORCE_DEFAULT_REG fields */
 #define FORCE_DEFAULT	BIT(0)
 
@@ -261,5 +279,23 @@ enum geni_se_protocol_type {
 
 /* QUP SE VERSION value for major number 2 and minor number 5 */
 #define QUP_SE_VERSION_2_5                  0x20050000
 
+/* SE_DMA_GENERAL_CFG */
+#define DMA_RX_CLK_CGC_ON		BIT(0)
+#define DMA_TX_CLK_CGC_ON		BIT(1)
+#define DMA_AHB_SLV_CFG_ON		BIT(2)
+#define AHB_SEC_SLV_CLK_CGC_ON		BIT(3)
+#define DUMMY_RX_NON_BUFFERABLE		BIT(4)
+#define RX_DMA_ZERO_PADDING_EN		BIT(5)
+#define RX_DMA_IRQ_DELAY_MSK		GENMASK(8, 6)
+#define RX_DMA_IRQ_DELAY_SHFT		6
+
+#define GENI_SE_DMA_DONE_EN	BIT(0)
+#define GENI_SE_DMA_EOT_EN	BIT(1)
+#define GENI_SE_DMA_AHB_ERR_EN	BIT(2)
+
+#define GENI_SE_DMA_EOT_BUF	BIT(0)
+
+#define GENI_DMA_MODE_EN	BIT(0)
+
 #endif
diff --git a/include/soc/qcom/qup-fw-load.h b/include/soc/qcom/qup-fw-load.h
new file mode 100644
index 0000000000000000000000000000000000000000..a67a93c72a4b705eff5bd29b185a4172c19ae1d7
--- /dev/null
+++ b/include/soc/qcom/qup-fw-load.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _LINUX_QCOM_QUP_FW_LOAD
+#define _LINUX_QCOM_QUP_FW_LOAD
+
+#include <linux/kernel.h>
+
+/*Magic numbers*/
+#define MAGIC_NUM_SE			0x57464553
+
+/* Common SE registers*/
+#define GENI_INIT_CFG_REVISION		0x0
+#define GENI_S_INIT_CFG_REVISION	0x4
+#define GENI_FORCE_DEFAULT_REG		0x20
+#define GENI_CGC_CTRL			0x28
+#define GENI_CFG_REG0			0x100
+
+#define QUPV3_SE_HW_PARAM_1		0xE28
+#define RX_FIFO_WIDTH_BIT		24
+#define RX_FIFO_WIDTH_MASK		0x3F
+
+/*Same registers as GENI_DMA_MODE_EN*/
+#define QUPV3_SE_GENI_DMA_MODE_EN	0x258
+#define GENI_M_IRQ_ENABLE		0x614
+#define GENI_S_IRQ_ENABLE		0x644
+#define GENI_RX_RFR_WATERMARK_REG	0x814
+#define DMA_TX_IRQ_EN_SET		0xC4C
+#define DMA_RX_IRQ_EN_SET		0xD4C
+#define DMA_GENERAL_CFG			0xE30
+#define SE_GENI_FW_REVISION		0x1000
+#define SE_S_FW_REVISION		0x1004
+#define SE_GENI_CFG_RAMN		0x1010
+#define SE_GENI_CLK_CTRL		0x2000
+#define SE_DMA_IF_EN			0x2004
+#define SE_FIFO_IF_DISABLE		0x2008
+
+#define MAX_GENI_CFG_RAMn_CNT		455
+
+#define MI_PBT_NON_PAGED_SEGMENT	0x0
+#define MI_PBT_HASH_SEGMENT		0x2
+#define MI_PBT_NOTUSED_SEGMENT		0x3
+#define MI_PBT_SHARED_SEGMENT		0x4
+#define MI_PBT_FLAG_PAGE_MODE_MASK	0x100000
+#define MI_PBT_FLAG_PAGE_MODE_SHIFT	0x14
+#define MI_PBT_FLAG_SEGMENT_TYPE_MASK	0x7000000
+#define MI_PBT_FLAG_SEGMENT_TYPE_SHIFT	0x18
+#define MI_PBT_FLAG_ACCESS_TYPE_MASK	0xE00000
+#define MI_PBT_FLAG_ACCESS_TYPE_SHIFT	0x15
+
+#define MI_PBT_PAGE_MODE_VALUE(x) \
+	(((x) & MI_PBT_FLAG_PAGE_MODE_MASK) >> \
+	  MI_PBT_FLAG_PAGE_MODE_SHIFT)
+
+#define MI_PBT_SEGMENT_TYPE_VALUE(x) \
+	(((x) & MI_PBT_FLAG_SEGMENT_TYPE_MASK) >> \
+		MI_PBT_FLAG_SEGMENT_TYPE_SHIFT)
+
+#define MI_PBT_ACCESS_TYPE_VALUE(x) \
+	(((x) & MI_PBT_FLAG_ACCESS_TYPE_MASK) >> \
+	  MI_PBT_FLAG_ACCESS_TYPE_SHIFT)
+
+/* GENI_FORCE_DEFAULT_REG fields */
+#define FORCE_DEFAULT			BIT(0)
+
+/* FW_REVISION_RO fields */
+#define FW_REV_PROTOCOL_SHFT		8
+#define FW_REV_VERSION_SHFT		0
+
+#define GENI_FW_REVISION_RO		0x68
+#define GENI_S_FW_REVISION_RO		0x6C
+
+/* SE_GENI_DMA_MODE_EN */
+#define GENI_DMA_MODE_EN		BIT(0)
+
+/* GENI_M_IRQ_EN fields */
+#define M_CMD_DONE_EN			BIT(0)
+#define M_IO_DATA_DEASSERT_EN		BIT(22)
+#define M_IO_DATA_ASSERT_EN		BIT(23)
+#define M_RX_FIFO_RD_ERR_EN		BIT(24)
+#define M_RX_FIFO_WR_ERR_EN		BIT(25)
+#define M_RX_FIFO_WATERMARK_EN		BIT(26)
+#define M_RX_FIFO_LAST_EN		BIT(27)
+#define M_TX_FIFO_RD_ERR_EN		BIT(28)
+#define M_TX_FIFO_WR_ERR_EN		BIT(29)
+#define M_TX_FIFO_WATERMARK_EN		BIT(30)
+#define M_COMMON_GENI_M_IRQ_EN	(GENMASK(6, 1) | \
+				M_IO_DATA_DEASSERT_EN | \
+				M_IO_DATA_ASSERT_EN | M_RX_FIFO_RD_ERR_EN | \
+				M_RX_FIFO_WR_ERR_EN | M_TX_FIFO_RD_ERR_EN | \
+				M_TX_FIFO_WR_ERR_EN)
+
+/* GENI_S_IRQ_EN fields */
+#define S_CMD_OVERRUN_EN		BIT(1)
+#define S_ILLEGAL_CMD_EN		BIT(2)
+#define S_CMD_CANCEL_EN			BIT(4)
+#define S_CMD_ABORT_EN			BIT(5)
+#define S_GP_IRQ_0_EN			BIT(9)
+#define S_GP_IRQ_1_EN			BIT(10)
+#define S_GP_IRQ_2_EN			BIT(11)
+#define S_GP_IRQ_3_EN			BIT(12)
+#define S_RX_FIFO_RD_ERR_EN		BIT(24)
+#define S_RX_FIFO_WR_ERR_EN		BIT(25)
+#define S_COMMON_GENI_S_IRQ_EN	(GENMASK(5, 1) | GENMASK(13, 9) | \
+				 S_RX_FIFO_RD_ERR_EN | S_RX_FIFO_WR_ERR_EN)
+
+#define GENI_CGC_CTRL_PROG_RAM_SCLK_OFF_BMSK		0x00000200
+#define GENI_CGC_CTRL_PROG_RAM_HCLK_OFF_BMSK		0x00000100
+
+#define GENI_DMA_MODE_EN_GENI_DMA_MODE_EN_BMSK		0x00000001
+
+#define DMA_TX_IRQ_EN_SET_RESET_DONE_EN_SET_BMSK	0x00000008
+#define DMA_TX_IRQ_EN_SET_SBE_EN_SET_BMSK		0x00000004
+#define DMA_TX_IRQ_EN_SET_DMA_DONE_EN_SET_BMSK		0x00000001
+
+#define DMA_RX_IRQ_EN_SET_FLUSH_DONE_EN_SET_BMSK	0x00000010
+#define DMA_RX_IRQ_EN_SET_RESET_DONE_EN_SET_BMSK	0x00000008
+#define DMA_RX_IRQ_EN_SET_SBE_EN_SET_BMSK		0x00000004
+#define DMA_RX_IRQ_EN_SET_DMA_DONE_EN_SET_BMSK		0x00000001
+
+#define DMA_GENERAL_CFG_AHB_SEC_SLV_CLK_CGC_ON_BMSK	0x00000008
+#define DMA_GENERAL_CFG_DMA_AHB_SLV_CLK_CGC_ON_BMSK	0x00000004
+#define DMA_GENERAL_CFG_DMA_TX_CLK_CGC_ON_BMSK		0x00000002
+#define DMA_GENERAL_CFG_DMA_RX_CLK_CGC_ON_BMSK		0x00000001
+
+#define GENI_CLK_CTRL_SER_CLK_SEL_BMSK			0x00000001
+#define DMA_IF_EN_DMA_IF_EN_BMSK			0x00000001
+#define SE_GSI_EVENT_EN_BMSK				0x0000000f
+#define SE_IRQ_EN_RMSK					0x0000000f
+
+#define QUPV3_COMMON_CFG				0x0120
+#define FAST_SWITCH_TO_HIGH_DISABLE_BMASK		0x00000001
+
+#define QUPV3_SE_AHB_M_CFG				0x0118
+#define AHB_M_CLK_CGC_ON_BMASK				0x00000001
+
+#define QUPV3_COMMON_CGC_CTRL				0x021C
+#define COMMON_CSR_SLV_CLK_CGC_ON_BMASK			0x00000001
+
+/* access ports */
+#define geni_setbits32(_addr, _v) writel_relaxed(readl_relaxed(_addr) |  (_v), (_addr))
+#define geni_clrbits32(_addr, _v) writel_relaxed(readl_relaxed(_addr) & ~(_v), (_addr))
+
+/**
+ * struct elf_se_hdr - firmware configurations
+ *
+ * @magic: set to 'SEFW'
+ * @version: A 32-bit value indicating the structure’s version number
+ * @core_version: QUPV3_HW_VERSION
+ * @serial_protocol: Programmed into GENI_FW_REVISION
+ * @fw_version: Programmed into GENI_FW_REVISION
+ * @cfg_version: Programmed into GENI_INIT_CFG_REVISION
+ * @fw_size_in_items: Number of (uint32_t) GENI_FW_RAM words
+ * @fw_offset: Byte offset of GENI_FW_RAM array
+ * @cfg_size_in_items: Number of GENI_FW_CFG index/value pairs
+ * @cfg_idx_offset: Byte offset of GENI_FW_CFG index array
+ * @cfg_val_offset: Byte offset of GENI_FW_CFG values array
+ */
+struct elf_se_hdr {
+	u32 magic;
+	u32 version;
+	u32 core_version;
+	u16 serial_protocol;
+	u16 fw_version;
+	u16 cfg_version;
+	u16 fw_size_in_items;
+	u16 fw_offset;
+	u16 cfg_size_in_items;
+	u16 cfg_idx_offset;
+	u16 cfg_val_offset;
+};
+
+struct udevice;
+
+int qcom_geni_load_firmware(phys_addr_t qup_base, struct udevice *dev);
+
+#endif /* _LINUX_QCOM_QUP_FW_LOAD */

-- 
2.49.0

