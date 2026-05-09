Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2048ACD37AC
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F6284E34;
	Sat,  9 May 2026 02:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="tOKYPyES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6314F84E10; Sat,  9 May 2026 02:04:54 +0200 (CEST)
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com
 [IPv6:2607:f8b0:4864:20::122e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF14484E0A
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 02:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-12713e56abdso1740800c88.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 17:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778285090; x=1778889890;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A76CLe5OoYZj7fv7gI0UxJtBvXWI13dCHitFpmL3r2Y=;
 b=tOKYPyESeiPpe77j4GHerNlApVD+G8HFtbP/kFoRYN5nN1GNiXi2MQRRMA3gaOklOo
 h2tZw88I+locQrwjZupGwCwnTX6nEFE5HQieXgKjh6GWvaFO8mSCNwIR7tpYCaCbXF04
 E8S3C/c12P0Haypdk0rCWu0gAKeKkojudcxASjHkZoyMqPwhMm2evgzvYCy/Lx2/tnI8
 PuPO/iATO0ejcX/C45dNedIZUyS0cfcpJJJJ86LAWDfA7DB9H2W5i30TlEN2PEHHquTK
 qS+1BFa6jGmm+u8S17DWJcFqx062H7axf0y6r9R44sUBjf4BamxRD/JyhSP1NVeqhvGg
 qW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778285090; x=1778889890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A76CLe5OoYZj7fv7gI0UxJtBvXWI13dCHitFpmL3r2Y=;
 b=Z0frPBFznST5ffM8+pSuxrEB79codXDcK6k+PwmsmsnzYxTcUzampeccbbdBb6rOQR
 l8h6PGtcpBfzE44He7Po4/fwvC4GcK7DFaUyow4FX4g8iohP1YbGesj7XirKP965UQSl
 rm4z895NaOuu7Skv2ck0E7yy0JMcvdGYY/5lAX9pr/JRSjAIqBQGtdZvjzxc6xxzBIsw
 ymNuZ3j9exMUuzDRNCh8deO7nrrozsq6N/q37yKNaHFZ6URDfoAIJxORcIjGGg2SjHWC
 YpxX3oGKiloo/Hq+zwZYs+cgsQc534ndHl3+II4nj+qKp+WBJXpM8ZviTSsXsald0ThJ
 H9Rw==
X-Gm-Message-State: AOJu0YynfddUyv352Ubf4fOST9LaKUIyqXCnXOojIPEEmdQeBSpS0YyE
 CRpREV+uFr4fh0Pxv7KH5zl9tCDwmwzmQF56309vDWmVpCjIvwv++o8Ogw+SYtiI4lzOp+dDVzf
 5SDu+
X-Gm-Gg: AeBDieug+cXlXPwELyjHv5c3ukQtuKteauqjlU4jvEpqtJwaMJasDYEGnrYkq/nA22n
 E0pqOH8iR3SMDj5CZOL3Qnyhij5KvXmAanIN8NlDu4nmKlNs46m3yJPa2ZFoXGm3tCoMLouqpak
 ZMBFUxcMDkBqXc5eVc2q0fCZZKFvmMuA9NGp0uBrWnklB/EvLLIOGOShXvQnZaS87CzxWZrfUNM
 /blS9MF8zM2akQmtOqfIPcGQN6Y9kSpd7vknenlp7Xv9T5kVbncKztCZkuHe+PRbxE4NBsatLaK
 Q/j+7RUXo+c989ixi6aqaG2SkH3WuM2lWET/oFL9I1d3ZLZT2ZDXeK2Bz6giADPMwPKTQrysTeI
 oqG5CPfocmsGmR8APguh7DCZ/6/yCMpF0xyOKbKXBmWN3DnJg7iTlFjolQR9Co9XAfvQw6LJGlV
 33Vi+JENyKKl6wlv+MkbRxjU2tvA8jd3SZD3fyklrfrk9sJFUiDh5FVVWUiq3/NvN/Q0wAtUMbS
 slJ0U2pGPCkh4Crcl323QBmjAXI00DG
X-Received: by 2002:a05:7022:6187:b0:12a:6d05:3938 with SMTP id
 a92af1059eb24-1323aa67954mr4533273c88.7.1778285089802; 
 Fri, 08 May 2026 17:04:49 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132787673ffsm5505030c88.15.2026.05.08.17.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:04:49 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: David Garske <david@wolfssl.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 09/12] tpm: add sandbox TPM SPI emulator
Date: Fri,  8 May 2026 17:04:16 -0700
Message-ID: <c964c8cc4075a5f331a3dd108f103302bcbcc365.1778277334.git.aidan@wolfssl.com>
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
2.47.3

