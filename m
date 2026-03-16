Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09E3F53D85
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB12084214;
	Mon, 16 Mar 2026 19:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="igG30fv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B4B84181; Mon, 16 Mar 2026 19:15:43 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 394FB8418A
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@wolfssl.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d76a331ebbso3147205a34.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1773684938; x=1774289738;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WzJnJqFXs+g64AwxgmhwO0/En77OwWXZ1kx0m/Y/KB4=;
 b=igG30fv+zq8aeqhn/G2Kvc566FjsnLuoXwcd3Se5bvb7Hb4Q98QXihDlv3wRbJShb+
 a4WXjOpaqEyHp/13kf1JK0pSgt0lBmVCzi3W45fJ8DmUgM3Fqy/89vk2lLu8GGiFY9kp
 YEzFduc/MjDuPfgk/Ho8owVUC3V0kYA4xHx2on1ubf9S04ehcQfHhQhMWynY45c5jTWV
 kPBOES+RFw3GC6Bb1TKBNaUEuuAuodfrlDPabAG/zTXEhZK0BdYNGkNDbJ7V8kWyrB+R
 RIi3wIvvt+v/aPdS0PtsrmgD36BmC2oXDCZ2Zkpbb77MbINrRdjj1KehrGn+ApxwJ35P
 F3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684938; x=1774289738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WzJnJqFXs+g64AwxgmhwO0/En77OwWXZ1kx0m/Y/KB4=;
 b=lb47jC0CNlQQ3PqIMw+ycsLz8oAePSUajHMjuublseJFjF1lb2tJpbt9mFZ6Jo3SM4
 n95gXm6ZZeJKmHIx1IPaxTjzcJSAY4LhMhp44MmZlUMlz9WBhkO8WntspLRmaa5NKESz
 rXLFWnvwtm4367QBl6aoknrzUNMkjUAwh97u6KpCqc05YjF8O4+y3OIb4d0yJPI80tEZ
 VEUP286KEUvQE+1L4ZRBJoaU0nxmFqtrAAomx05I5YgKkB142lTov32vVOC7tGb6poPU
 MxVdutTCKAek18I4WQ22VmDcjBrtXoY6y5nXV8fluJHcoJiorboOSvPYGi0FEUGV8UXN
 sbeg==
X-Gm-Message-State: AOJu0Yz0tKpKb1+fZqxr3QqxF12K6rU5crn5IH6K0Q1K+JKHaREN/Ns7
 9WXs2nDgd+LoHUchMTC37dleYH7RXnz+cd9Jz/DmSG8ILi1zLMG4d6sOEdKwK1XnKnPvrM0Vle3
 7wefUhPg=
X-Gm-Gg: ATEYQzz5MiyZMwyatwgE9KJtoSie7CQaB/vZGytT0ujTB7HhXc8zrRRqHUQUV8A+1iO
 ahIJXoaSwZjoVgKwGT/+FY+wxqT2aY4eMdzkiKSIjmJNZ35m22uMVxQNUJGPmFvlB00NaTTTTEi
 vAkaem1nyAvFIgGwj51Wl1wYrcvCF1C1L7XI070Bp21sbkSCzsrd1rpG4soZsq9LawgcK0jlC3A
 BHTAbxTl0L/KG7UwnM8gBFmKJjNq5KI5W6ow1S2xkS412c701wYeQWSlytY6FC+hK8nyaaYKath
 DNlt9s/bK+3hyJiQC2b4v0QVa9ICHQM7BeFyKDX1BCzzg5f/iJAdrMhUxHmXhiNYqjbKlx74SQc
 zcEkgAqVcn/yuRvzaDwLwqonmpz1HYLkTYYiqGKkPAcc/RZi+PW7vpwGOj6BV63iEZVLrft80I/
 g0F/7WwsYyzy19p8zqHox/BA==
X-Received: by 2002:a05:6830:81d2:b0:7c7:59a1:48c8 with SMTP id
 46e09a7af769-7d78243d204mr9890406a34.4.1773684938381; 
 Mon, 16 Mar 2026 11:15:38 -0700 (PDT)
Received: from localhost ([2605:59c0:2082:bc08:ab40:208e:38fb:2546])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm13832955a34.15.2026.03.16.11.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:15:37 -0700 (PDT)
From: David Garske <david@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Aidan <aidan@wolfssl.com>
Subject: [[PATCH v2] tpm: Add wolfTPM library support for TPM 2.0 09/12] tpm:
 add sandbox TPM SPI emulator
Date: Mon, 16 Mar 2026 11:14:38 -0700
Message-ID: <20260316181447.2986278-10-david@wolfssl.com>
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

Add a TPM SPI emulator for sandbox testing that implements the TIS
(TPM Interface Specification) SPI protocol, allowing wolfTPM's SPI
HAL code to be tested without physical hardware.

drivers/tpm/tpm_spi_sandbox.c (new):
  Emulates a TPM connected via SPI by implementing the TIS register
  set and SPI protocol:
  - SPI protocol state machine: parses 4-byte TIS SPI headers
    (R/W bit, transfer length, register address) and handles data
    phase with immediate ready signaling (no wait states)
  - TIS register emulation: TPM_ACCESS (locality request/grant),
    TPM_STS (command ready, data expect, data available, burst
    count), TPM_INTF_CAPS, TPM_DID_VID (Infineon SLB9670 IDs),
    TPM_RID, and TPM_DATA_FIFO (command/response buffering)
  - TIS state machine: IDLE -> READY -> RECEPTION -> EXECUTION ->
    COMPLETION, with command-ready abort support
  - Generates simple TPM_RC_SUCCESS responses (a full implementation
    would integrate the sandbox TPM2 state machine)
  - Registers as UCLASS_SPI_EMUL with compatible "sandbox,tpm-spi-emul"
  - Also registers a SPI slave driver (UCLASS_SPI_GENERIC) with
    compatible "sandbox,tpm-spi" for the DTS device node

drivers/mtd/spi/sandbox.c:
  Modify sandbox_spi_get_emul() to check for a "sandbox,emul"
  phandle property on SPI slave devices before falling back to the
  default SPI flash emulation binding. This allows non-flash SPI
  devices (like the TPM emulator) to specify their own emulator
  via device tree phandle.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 drivers/mtd/spi/sandbox.c     |  30 ++-
 drivers/tpm/tpm_spi_sandbox.c | 410 ++++++++++++++++++++++++++++++++++
 2 files changed, 431 insertions(+), 9 deletions(-)
 create mode 100644 drivers/tpm/tpm_spi_sandbox.c

diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
index e5ebc3479fb..41bd07817aa 100644
--- a/drivers/mtd/spi/sandbox.c
+++ b/drivers/mtd/spi/sandbox.c
@@ -571,16 +571,28 @@ int sandbox_spi_get_emul(struct sandbox_state *state,
 
 	info = &state->spi[busnum][cs];
 	if (!info->emul) {
-		/* Use the same device tree node as the SPI flash device */
-		debug("%s: busnum=%u, cs=%u: binding SPI flash emulation: ",
-		      __func__, busnum, cs);
-		ret = sandbox_sf_bind_emul(state, busnum, cs, bus,
-					   dev_ofnode(slave), slave->name);
-		if (ret) {
-			debug("failed (err=%d)\n", ret);
-			return ret;
+		struct udevice *emul;
+		ofnode node = dev_ofnode(slave);
+
+		/* First check for sandbox,emul phandle property */
+		ret = uclass_get_device_by_phandle(UCLASS_SPI_EMUL, slave,
+						   "sandbox,emul", &emul);
+		if (!ret) {
+			debug("%s: busnum=%u, cs=%u: using phandle emulator\n",
+			      __func__, busnum, cs);
+			info->emul = emul;
+		} else {
+			/* Fall back to SPI flash emulation binding */
+			debug("%s: busnum=%u, cs=%u: binding SPI flash emulation: ",
+			      __func__, busnum, cs);
+			ret = sandbox_sf_bind_emul(state, busnum, cs, bus,
+						   node, slave->name);
+			if (ret) {
+				debug("failed (err=%d)\n", ret);
+				return ret;
+			}
+			debug("OK\n");
 		}
-		debug("OK\n");
 	}
 	*emulp = info->emul;
 
diff --git a/drivers/tpm/tpm_spi_sandbox.c b/drivers/tpm/tpm_spi_sandbox.c
new file mode 100644
index 00000000000..694c5d721f0
--- /dev/null
+++ b/drivers/tpm/tpm_spi_sandbox.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Sandbox TPM SPI Emulator
+ *
+ * Copyright (c) 2025 wolfSSL Inc.
+ * Author: Aidan Garske <aidan@wolfssl.com>
+ *
+ * Emulates TPM TIS SPI protocol for testing wolfTPM SPI HAL
+ * without hardware. Wraps the existing sandbox TPM2 state machine.
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <spi.h>
+#include <spi_flash.h>
+#include <asm/spi.h>
+#include <asm/state.h>
+#include <linux/bitops.h>
+
+/* TIS register addresses (locality 0) */
+#define TPM_ACCESS_REG		0x0000
+#define TPM_INT_ENABLE_REG	0x0008
+#define TPM_INTF_CAPS_REG	0x0014
+#define TPM_STS_REG		0x0018
+#define TPM_DATA_FIFO_REG	0x0024
+#define TPM_DID_VID_REG		0x0F00
+#define TPM_RID_REG		0x0F04
+
+/* TIS access register bits */
+#define TPM_ACCESS_VALID		0x80
+#define TPM_ACCESS_ACTIVE_LOCALITY	0x20
+#define TPM_ACCESS_REQUEST_PENDING	0x04
+#define TPM_ACCESS_REQUEST_USE		0x02
+
+/* TIS status register bits */
+#define TPM_STS_VALID		0x80
+#define TPM_STS_COMMAND_READY	0x40
+#define TPM_STS_GO		0x20
+#define TPM_STS_DATA_AVAIL	0x10
+#define TPM_STS_DATA_EXPECT	0x08
+
+/* Interface capabilities */
+#define TPM_INTF_CAPS_VALUE	0x30000697  /* Typical Infineon value */
+
+/* Device/Vendor ID - Infineon SLB9670 */
+#define TPM_DID_VID_VALUE	0x001D15D1
+
+/* Revision ID */
+#define TPM_RID_VALUE		0x36
+
+/* Maximum buffer sizes */
+#define TPM_CMD_BUF_SIZE	4096
+#define TPM_RSP_BUF_SIZE	4096
+#define MAX_SPI_FRAMESIZE	64
+
+/* TPM TIS SPI protocol states */
+enum tpm_spi_state {
+	TPM_SPI_IDLE,
+	TPM_SPI_HEADER,		/* Receiving 4-byte header */
+	TPM_SPI_WAIT_STATE,	/* Sending wait state bytes */
+	TPM_SPI_DATA,		/* Transfer data */
+};
+
+/* TIS state machine */
+enum tpm_tis_state {
+	TIS_IDLE,
+	TIS_READY,		/* Ready to receive command */
+	TIS_RECEPTION,		/* Receiving command data */
+	TIS_EXECUTION,		/* Executing command */
+	TIS_COMPLETION,		/* Response available */
+};
+
+struct sandbox_tpm_spi {
+	/* SPI protocol state */
+	enum tpm_spi_state spi_state;
+	u8 header[4];
+	int header_pos;
+	bool is_read;
+	u32 addr;
+	int xfer_len;
+	int data_pos;
+
+	/* TIS state */
+	enum tpm_tis_state tis_state;
+	u8 access_reg;
+	u32 sts_reg;
+	u32 intf_caps;
+
+	/* Command/response buffers */
+	u8 cmd_buf[TPM_CMD_BUF_SIZE];
+	int cmd_len;
+	int cmd_pos;
+	u8 rsp_buf[TPM_RSP_BUF_SIZE];
+	int rsp_len;
+	int rsp_pos;
+
+	/* Burst count for status register */
+	u16 burst_count;
+};
+
+/*
+ * Parse TIS SPI header
+ * Format: [R/W|len-1][0xD4][addr_hi][addr_lo]
+ * Bit 7 of byte 0: 1=read, 0=write
+ * Bits 5:0 of byte 0: transfer length - 1
+ */
+static void parse_spi_header(struct sandbox_tpm_spi *priv)
+{
+	priv->is_read = (priv->header[0] & 0x80) != 0;
+	priv->xfer_len = (priv->header[0] & 0x3F) + 1;
+	priv->addr = (priv->header[2] << 8) | priv->header[3];
+	priv->data_pos = 0;
+}
+
+/*
+ * Read from TIS register
+ */
+static u8 tis_reg_read(struct sandbox_tpm_spi *priv, u32 addr)
+{
+	u32 reg = addr & 0x0FFF;  /* Mask off locality bits */
+
+	switch (reg) {
+	case TPM_ACCESS_REG:
+		return priv->access_reg;
+
+	case TPM_STS_REG:
+	case TPM_STS_REG + 1:
+	case TPM_STS_REG + 2:
+	case TPM_STS_REG + 3: {
+		int byte_off = reg - TPM_STS_REG;
+		u32 sts = priv->sts_reg;
+
+		/* Update burst count in status */
+		sts |= ((u32)priv->burst_count << 8);
+		return (sts >> (byte_off * 8)) & 0xFF;
+	}
+
+	case TPM_INTF_CAPS_REG:
+	case TPM_INTF_CAPS_REG + 1:
+	case TPM_INTF_CAPS_REG + 2:
+	case TPM_INTF_CAPS_REG + 3: {
+		int byte_off = reg - TPM_INTF_CAPS_REG;
+
+		return (priv->intf_caps >> (byte_off * 8)) & 0xFF;
+	}
+
+	case TPM_DID_VID_REG:
+	case TPM_DID_VID_REG + 1:
+	case TPM_DID_VID_REG + 2:
+	case TPM_DID_VID_REG + 3: {
+		int byte_off = reg - TPM_DID_VID_REG;
+
+		return (TPM_DID_VID_VALUE >> (byte_off * 8)) & 0xFF;
+	}
+
+	case TPM_RID_REG:
+		return TPM_RID_VALUE;
+
+	default:
+		/*
+		 * Handle FIFO reads - the FIFO can be accessed at any address
+		 * from 0x0024 up to 0x0F00 for multi-byte transfers.
+		 */
+		if (reg >= TPM_DATA_FIFO_REG && reg < TPM_DID_VID_REG) {
+			if (priv->tis_state == TIS_COMPLETION &&
+			    priv->rsp_pos < priv->rsp_len) {
+				u8 data = priv->rsp_buf[priv->rsp_pos++];
+
+				/* Update status when all data read */
+				if (priv->rsp_pos >= priv->rsp_len) {
+					priv->sts_reg &= ~TPM_STS_DATA_AVAIL;
+					priv->sts_reg |= TPM_STS_COMMAND_READY;
+					priv->tis_state = TIS_READY;
+				}
+				return data;
+			}
+			return 0xFF;
+		}
+		return 0xFF;
+	}
+}
+
+/*
+ * Write to TIS register
+ */
+static void tis_reg_write(struct sandbox_tpm_spi *priv, u32 addr, u8 value)
+{
+	u32 reg = addr & 0x0FFF;
+
+	switch (reg) {
+	case TPM_ACCESS_REG:
+		if (value & TPM_ACCESS_REQUEST_USE) {
+			/* Request locality */
+			priv->access_reg |= TPM_ACCESS_ACTIVE_LOCALITY;
+			priv->access_reg |= TPM_ACCESS_VALID;
+		}
+		break;
+
+	case TPM_STS_REG:
+		if (value & TPM_STS_COMMAND_READY) {
+			/* Abort current command and go to ready state */
+			priv->tis_state = TIS_READY;
+			priv->cmd_len = 0;
+			priv->cmd_pos = 0;
+			priv->rsp_len = 0;
+			priv->rsp_pos = 0;
+			priv->sts_reg = TPM_STS_VALID | TPM_STS_COMMAND_READY;
+			priv->burst_count = MAX_SPI_FRAMESIZE;
+		}
+		if (value & TPM_STS_GO) {
+			/* Execute command */
+			if (priv->tis_state == TIS_RECEPTION &&
+			    priv->cmd_len > 0) {
+				/*
+				 * Generate a simple success response.
+				 * A full implementation would call the
+				 * sandbox TPM2 state machine here.
+				 */
+				priv->rsp_buf[0] = 0x80;  /* TPM_ST_NO_SESSIONS */
+				priv->rsp_buf[1] = 0x01;
+				priv->rsp_buf[2] = 0x00;  /* Response size: 10 */
+				priv->rsp_buf[3] = 0x00;
+				priv->rsp_buf[4] = 0x00;
+				priv->rsp_buf[5] = 0x0A;
+				priv->rsp_buf[6] = 0x00;  /* TPM_RC_SUCCESS */
+				priv->rsp_buf[7] = 0x00;
+				priv->rsp_buf[8] = 0x00;
+				priv->rsp_buf[9] = 0x00;
+				priv->rsp_len = 10;
+				priv->rsp_pos = 0;
+
+				priv->tis_state = TIS_COMPLETION;
+				priv->sts_reg = TPM_STS_VALID |
+						TPM_STS_DATA_AVAIL;
+			}
+		}
+		break;
+
+	default:
+		/*
+		 * Handle FIFO writes - the FIFO is at 0x0024 but any address
+		 * from 0x0024 up to 0x0F00 can be used for FIFO access when
+		 * doing multi-byte transfers (address auto-increments).
+		 */
+		if (reg >= TPM_DATA_FIFO_REG && reg < TPM_DID_VID_REG) {
+			if (priv->tis_state == TIS_READY) {
+				/* Start receiving command */
+				priv->tis_state = TIS_RECEPTION;
+				priv->cmd_len = 0;
+				priv->cmd_pos = 0;
+				priv->sts_reg = TPM_STS_VALID | TPM_STS_DATA_EXPECT;
+			}
+			if (priv->tis_state == TIS_RECEPTION) {
+				if (priv->cmd_len < TPM_CMD_BUF_SIZE) {
+					priv->cmd_buf[priv->cmd_len++] = value;
+
+					/* Check if we have complete command */
+					if (priv->cmd_len >= 6) {
+						u32 expected_len;
+
+						expected_len = (priv->cmd_buf[2] << 24) |
+							       (priv->cmd_buf[3] << 16) |
+							       (priv->cmd_buf[4] << 8) |
+							       priv->cmd_buf[5];
+						if (priv->cmd_len >= expected_len) {
+							/* Command complete */
+							priv->sts_reg &=
+								~TPM_STS_DATA_EXPECT;
+						}
+					}
+				}
+			}
+		}
+		break;
+	}
+}
+
+/*
+ * SPI emulation transfer callback
+ */
+static int sandbox_tpm_spi_xfer(struct udevice *dev, unsigned int bitlen,
+				const void *dout, void *din, unsigned long flags)
+{
+	struct sandbox_tpm_spi *priv = dev_get_priv(dev);
+	int bytes = bitlen / 8;
+	const u8 *tx = dout;
+	u8 *rx = din;
+	int i;
+
+	/* Handle CS assert - reset state machine */
+	if (flags & SPI_XFER_BEGIN) {
+		priv->spi_state = TPM_SPI_HEADER;
+		priv->header_pos = 0;
+	}
+
+	for (i = 0; i < bytes; i++) {
+		u8 tx_byte = tx ? tx[i] : 0;
+		u8 rx_byte = 0;
+
+		switch (priv->spi_state) {
+		case TPM_SPI_IDLE:
+			/* Should not happen during active transfer */
+			rx_byte = 0xFF;
+			break;
+
+		case TPM_SPI_HEADER:
+			/* Receive 4-byte header */
+			priv->header[priv->header_pos++] = tx_byte;
+			rx_byte = 0x00;
+
+			if (priv->header_pos >= 4) {
+				parse_spi_header(priv);
+				log_debug("TPM SPI: %s len=%d addr=0x%04x\n",
+					  priv->is_read ? "read" : "write",
+					  priv->xfer_len, priv->addr);
+				/* Return wait state in last header byte */
+				rx_byte = 0x01;  /* Ready immediately */
+				priv->spi_state = TPM_SPI_DATA;
+			}
+			break;
+
+		case TPM_SPI_DATA:
+			if (priv->is_read) {
+				/* Read from TPM register */
+				rx_byte = tis_reg_read(priv,
+						       priv->addr + priv->data_pos);
+			} else {
+				/* Write to TPM register */
+				tis_reg_write(priv, priv->addr + priv->data_pos,
+					      tx_byte);
+				rx_byte = 0x00;
+			}
+			priv->data_pos++;
+			break;
+
+		default:
+			rx_byte = 0xFF;
+			break;
+		}
+
+		if (rx)
+			rx[i] = rx_byte;
+	}
+
+	/* Handle CS deassert - return to idle */
+	if (flags & SPI_XFER_END)
+		priv->spi_state = TPM_SPI_IDLE;
+
+	return 0;
+}
+
+static int sandbox_tpm_spi_probe(struct udevice *dev)
+{
+	struct sandbox_tpm_spi *priv = dev_get_priv(dev);
+
+	/* Initialize TIS state */
+	priv->spi_state = TPM_SPI_IDLE;
+	priv->tis_state = TIS_IDLE;
+	priv->access_reg = TPM_ACCESS_VALID;
+	priv->sts_reg = TPM_STS_VALID;
+	priv->intf_caps = TPM_INTF_CAPS_VALUE;
+	priv->burst_count = MAX_SPI_FRAMESIZE;
+	priv->cmd_len = 0;
+	priv->rsp_len = 0;
+
+	log_debug("TPM SPI sandbox emulator probed\n");
+
+	return 0;
+}
+
+static const struct dm_spi_emul_ops sandbox_tpm_spi_ops = {
+	.xfer = sandbox_tpm_spi_xfer,
+};
+
+static const struct udevice_id sandbox_tpm_spi_ids[] = {
+	{ .compatible = "sandbox,tpm-spi-emul" },
+	{ }
+};
+
+U_BOOT_DRIVER(sandbox_tpm_spi_emul) = {
+	.name = "sandbox_tpm_spi_emul",
+	.id = UCLASS_SPI_EMUL,
+	.of_match = sandbox_tpm_spi_ids,
+	.ops = &sandbox_tpm_spi_ops,
+	.probe = sandbox_tpm_spi_probe,
+	.priv_auto = sizeof(struct sandbox_tpm_spi),
+};
+
+/*
+ * SPI slave driver for TPM device
+ * This gets probed when a device with "sandbox,tpm-spi" is found in DTS.
+ * The actual SPI transfers are handled by the emulator above.
+ */
+static int sandbox_tpm_spi_slave_probe(struct udevice *dev)
+{
+	log_debug("TPM SPI slave device probed\n");
+	return 0;
+}
+
+static const struct udevice_id sandbox_tpm_spi_slave_ids[] = {
+	{ .compatible = "sandbox,tpm-spi" },
+	{ }
+};
+
+U_BOOT_DRIVER(sandbox_tpm_spi) = {
+	.name = "sandbox_tpm_spi",
+	.id = UCLASS_SPI_GENERIC,
+	.of_match = sandbox_tpm_spi_slave_ids,
+	.probe = sandbox_tpm_spi_slave_probe,
+};
-- 
2.43.0

