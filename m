Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07B6C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 18:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33AE082D60;
	Fri, 13 Jun 2025 20:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MCHsM1c+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92A7C82F83; Fri, 13 Jun 2025 20:10:24 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E651082D5E
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 20:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4533a53a6efso3128615e9.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 11:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749838221; x=1750443021; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j5fw0n8DDsTZ2RLk+IMAVas9o3LnCpYNsfMk9iW28a4=;
 b=MCHsM1c+U65KBX1y8nDHRClfW+LNUm2pr+SyxcuLPvi5tneYPACEi/AOpY/dUj+1Iv
 zAvYpkJ3sKeRrPzI5pwQVJOlDA1GNtHUAmvtFqHQU2Oq+312LPp4iaNbfGTYrxk7py6h
 IAig+bOotZNG13HNtZqqqUEcAIofDbHFR5yqEAutrHwNxaHxohHzQy20AubylkPGL0lR
 k2oS3E0iFDM94mcRwvWv6zWQKAKNINyFJ7JV4x9YjDW5OaEkEBy6n8NCCXGUMNQ0HTjT
 5HN9zc9uIAVKAgLa9RLXp5Rk98qDiE7RP5Rhc/D/sl54UNg2CdVOAC4/UHmF4ABFputs
 RSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749838221; x=1750443021;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5fw0n8DDsTZ2RLk+IMAVas9o3LnCpYNsfMk9iW28a4=;
 b=cBjUHb4bXhuJkTHxN615KI0mVZ9mRoaHZPGHLpMZZI3+B1nQE4h7sMf5BPPEMh8yby
 ELXfYaoEZFHwecQE+MMhyKT7m1XYj/dUtJQdCBAh9U8NPfKwctRG9GrFhx5x9Z8JIPFB
 BqFyX/eWZqxzw5+qkSFxXdObm3srD1DKzDrPWJglOpF/CC2Tknq3DlCt4Fe7p8dxXulK
 jKzbmfQBsFJ9tiTOUsjEp+Ly2MScOqW7UKjin50S3AKgw+OEOuAJoGNmRhWOAGcRM3H7
 rsoDpsG7SUgWc6bIPw//lGcPbq6Eu9iGSTam5QFKVGwwiZHNoUczksbbWK+0/3HVZv6V
 Pfbw==
X-Gm-Message-State: AOJu0YwEaXP9n4jiVH8T15ukgNRE8odzViGNipDqaE8R0jONno48cb+O
 /6oy/DxYNs2zyfnnjvfacHkIRLqHnsux6h/yzER/iz/14UHhgHm9NJUxEdf3sQC4pz8=
X-Gm-Gg: ASbGncvkKAMzF3+7HHm22Xg6vN6MGhIrrB21LyO5hZ/fw+O9qyaQguehDKIwRJhipfF
 chhQ+9s5o5cDbbJf7sSbMczNbbELWuj0JkeRW6ysHM7NHwXBS2A6FxIVw52rxvwXDTqiA2nukzn
 6cO3ZNNuZVdPT/RwKTDyvgxETjr6w3wbrnGNKR5ZOz/InqSi9Fsb0MV6yS67NbkgA6YU2vTiqok
 yAoE9db089GK/egwQRxJFoABrHTxWxojf4yZ7zstCygGY+l2JQiQQ34Y5FRntAWgMoRvRB/lQ6x
 vh7IQ9g6Oagh8TuqMnPFxY8Oc5gIoXJwGDh+sc4OI6Ri4WhCxYqJ2VCddEBtgKt1+vFQlp9A5Jz
 Wwbw=
X-Google-Smtp-Source: AGHT+IECgxHdgfIdTYbR1hDZW1v3rfjYidrROd367lni0/0Re0qgh+Dfb/DuUYux009O4H8aSOj5Gw==
X-Received: by 2002:a05:600d:10b:b0:43c:ec72:3daf with SMTP id
 5b1f17b1804b1-4533b27ea08mr15429655e9.14.1749838221106; 
 Fri, 13 Jun 2025 11:10:21 -0700 (PDT)
Received: from toyger.lan ([213.240.182.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e14fc98sm61511975e9.29.2025.06.13.11.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 11:10:20 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 13 Jun 2025 20:10:15 +0200
Subject: [PATCH v3 2/5] misc: introduce Qcom GENI wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250613-geni-load-fw-v3-2-be778b3b101b@linaro.org>
References: <20250613-geni-load-fw-v3-0-be778b3b101b@linaro.org>
In-Reply-To: <20250613-geni-load-fw-v3-0-be778b3b101b@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=31314;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=prgby0aHh4ZoaNvse4uXb38rm/3ZbUMdU4G4PqpqnwA=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTGmHk6McwsDDa8oljJuCrnnHA1yd9Ss6UBMLr
 7ms9PipGwOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExphwAKCRAFgzErGV9k
 tkDBD/0bqS++feyPlSa4QVfsXkz1gRfMoFsHp1FAGFOkf4D2R6XJHdtRt5NJMOHFKgSDt4/wnA3
 VKIXud3xj/3bP5z8Q9SJ4kc24KWV3MwzWgolE+xFlzQjS6jQc45CkBQw1/hc3rDQf/L85keWgT+
 //m9mg7UEiXmfjQg1zRiS3DzfvJjA4fO+JWi96gvCF5HQal+NPoq6tSKY34mNqttoFB4BQhVoXC
 lJw6o8tI/st9lqIQn2bTpHwuOvvJM7kdlIDeh/+dm70nEW9bpK1ukuOCVi6TmV8RHASVp1FG6L9
 GyqpxGD6Z4d238gBRdD0KeiREx/7hpvRkhnAqMagokKWqbvoizNf8ykOpL/4No6q3yjtNgvEfDR
 Hp/NguVvDCswD5P5FmAPJdFXMRV1C5q3P2YXxSGrhX4xBkWOA+hkDX+v7n1c7g1kEGaH6tKO8HO
 BN+GZbV0RK0tRP7YWJMQaCGchwLO2/Nb0lC0QpCCYHRZmqoEIKzzxoH8JIpoHW0cPTABBVxrXNw
 KyQSBDhT5nmL81vFQWclMve/K8w16hKEBbK8lk8tuT+NvzVgCdb0s3wGTnRV0AZ5nK2SfxbPhBN
 Zj5K/oxY8vaILBgI7rDVyO4kaQ0yeUARUlP+sXanunD4XTU0UNPAK5heD32ryq7ZNc+yvGgBVkC
 pKPThLd73ekEfoA==
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
 drivers/misc/qcom_geni.c         | 578 +++++++++++++++++++++++++++++++++++++++
 drivers/serial/serial_msm_geni.c |  13 -
 include/soc/qcom/geni-se.h       |  36 +++
 include/soc/qcom/qup-fw-load.h   | 178 ++++++++++++
 7 files changed, 803 insertions(+), 13 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 12f354b86b6c740a8ae4c59a1a48b0be6595acfb..d9baaf743eee0c339f88b458aaa812b7bfbd73cc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1125,8 +1125,9 @@ config ARCH_SNAPDRAGON
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
index 0000000000000000000000000000000000000000..aa1999bfab320b8a11278cbc3d9903f3e554f055
--- /dev/null
+++ b/drivers/misc/qcom_geni.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2025, Linaro Ltd.
+ */
+
+#define pr_fmt(fmt) "GENI-SE: " fmt
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
+	dev_info(dev, "Loading QUP firmware...\n");
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
+		pr_err("GENI SE wrapper not found\n");
+		return 0;
+	}
+
+	ret = find_qupfw_part(&blk_dev, &part_info);
+	if (ret) {
+		pr_err("QUP firmware partition not found\n");
+		return 0;
+	}
+
+	if (part_info.size * part_info.blksz > MAX_FW_BUF_SIZE) {
+		pr_err("Firmware partition too large\n");
+		return -EINVAL;
+	}
+	fw_size = part_info.size * part_info.blksz;
+
+	fw_buf = malloc(fw_size);
+	if (!fw_buf) {
+		pr_err("Failed to allocate buffer for firmware\n");
+		return -ENOMEM;
+	}
+	memset(fw_buf, 0, fw_size);
+
+	ret = blk_read(blk_dev, part_info.start, part_info.size, fw_buf);
+	if (ret < 0) {
+		pr_err("Failed to read firmware from partition\n");
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

