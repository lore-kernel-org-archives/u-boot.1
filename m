Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4B4C27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6B39889CD;
	Fri, 14 Jun 2024 14:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="DGQVjknL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDB1386784; Fri, 14 Jun 2024 14:20:10 +0200 (CEST)
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com
 [95.215.58.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E56CB889FB
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
X-Envelope-To: jagan@amarulasolutions.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1718367606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3nceZEU6XG+W2vq8G+kvamKDSmxkG76T7GJPifojXw4=;
 b=DGQVjknL7FGKR2hKY8QqTRePxl6a+NWfCMfMM5hjwuT2W5SscStnjOPCjIgkjUczEHFmdP
 6V/nxdEbNtkr52IPDXTTSYGoj0F4o5oPk4/iqDihnlhf95zS/AvPuSSGwAk2uKyJoxBUnx
 x7Z9RqPjPQDQkQcUbjYvAlLbUglDxFmFxbBu9WtcwjxHpsHrms+Xwx7Ayc+pkd6yeVUwhz
 Acw7K7qpeDsjTHRDSdP91iAQk1g9dYMGmOY0N73I3YkH6qFbifNeWs0SVAOp0NyW11Xwje
 GwuqCSMu0PO1bBBqNLkrWVK7a0UGSdkmxkFzMHD8AhfsNl/69dX+PO2muE++QQ==
X-Envelope-To: agust@denx.de
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: trini@konsulko.com
X-Envelope-To: contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Date: Fri, 14 Jun 2024 22:18:45 +1000
Subject: [PATCH 5/5] video: add support for MIPI DBI interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-mipi_dbi-v1-5-946eb82f8533@jookia.org>
References: <20240614-mipi_dbi-v1-0-946eb82f8533@jookia.org>
In-Reply-To: <20240614-mipi_dbi-v1-0-946eb82f8533@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1718367553; l=5303;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=rsfDi51M3wXU8ZdhxUYVk/XVGRQ21hIPBjIrpZ+jSV4=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgPs7MDd2XR
 g2uRE9caV1lPPPeu0VzIG9fPrrVmYyAhLcAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAXXy2POTYTWIfHkCoOKnCUn9
 u2xWDpF5d7M6u0u4UWSURBdDMxI5hcrH6CfRGILYvpkxG1psTCZfCpDgmvadlDgUAAP+1
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:/gEvgms/9HpbgpcH+K7O4GYXmqkP7siJx9zHeEWRZTg
X-Migadu-Flow: FLOW_OUT
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

This interface supports sending MIPI commands over an SPI bus.
This driver only implements the Type C1 protocol for now.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/video/Kconfig    |  6 ++++
 drivers/video/Makefile   |  1 +
 drivers/video/mipi_dbi.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 include/mipi_dbi.h       | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7808ae7919..e9d069d440 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -157,6 +157,12 @@ config VIDEO_MIPI_DSI
 	  The MIPI Display Serial Interface (MIPI DSI) defines a high-speed
 	  serial interface between a host processor and a display module.
 
+config VIDEO_MIPI_DBI
+	bool "Support MIPI DBI interface"
+	help
+	  Support MIPI DBI interface for driving a MIPI compatible device
+	  over a SPI interface.
+
 config CONSOLE_NORMAL
 	bool "Support a simple text console"
 	default y
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index f3f70cd04a..ad77c60973 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_VIDEO_LCD_TDO_TL070WSH30) += tdo-tl070wsh30.o
 obj-$(CONFIG_VIDEO_MCDE_SIMPLE) += mcde_simple.o
 obj-${CONFIG_VIDEO_MESON} += meson/
 obj-${CONFIG_VIDEO_MIPI_DSI} += mipi_dsi.o
+obj-${CONFIG_VIDEO_MIPI_DBI} += mipi_dbi.o
 obj-$(CONFIG_VIDEO_MVEBU) += mvebu_lcd.o
 obj-$(CONFIG_VIDEO_MXS) += mxsfb.o videomodes.o
 obj-$(CONFIG_VIDEO_NX) += nexell_display.o videomodes.o nexell/
diff --git a/drivers/video/mipi_dbi.c b/drivers/video/mipi_dbi.c
new file mode 100644
index 0000000000..d7457bb6e2
--- /dev/null
+++ b/drivers/video/mipi_dbi.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MIPI DBI Bus support
+ *
+ * Copyright 2024 John Watts <contact@jookia.org>
+ */
+
+#include <mipi_dbi.h>
+
+int mipi_dbi_spi_init(struct spi_slave *slave, struct mipi_dbi *dbi,
+		      struct gpio_desc *dc)
+{
+	/* D/C GPIO isn't supported yet */
+	if (dc)
+		return -1;
+
+	dbi->spi = slave;
+
+	return 0;
+}
+
+int mipi_dbi_xfer(struct mipi_dbi *dbi, u8 data, int pos, int len)
+{
+	struct spi_slave *spi = dbi->spi;
+	bool is_data = (pos != 0);
+	int flags = 0;
+	u8 buf[2];
+
+	/* Mimic Linux's behaviour of pulling CS active each word */
+	flags |= SPI_XFER_ONCE;
+
+	buf[0] = (is_data ? 0x80 : 0x00) | (data >> 1);
+	buf[1] = ((data & 0x1) << 7);
+
+	return spi_xfer(spi, 9, &buf, NULL, flags);
+}
+
+int mipi_dbi_command_buf(struct mipi_dbi *dbi, u8 cmd, const u8 *data, size_t len)
+{
+	struct spi_slave *spi = dbi->spi;
+	int wordlen;
+	int retval = -1;
+
+	if (spi_claim_bus(spi))
+		return -1;
+
+	wordlen = spi_set_wordlen(spi, 9);
+	if (wordlen == -1)
+		goto done;
+
+	if (mipi_dbi_xfer(dbi, cmd, 0, len) != 0)
+		goto done;
+
+	for (int i = 1; i <= len; ++i) {
+		u8 dat = data[i - 1];
+
+		if (mipi_dbi_xfer(dbi, dat, i, len) != 0)
+			goto done;
+	}
+
+	retval = 0;
+
+done:
+	if (wordlen != -1)
+		spi_set_wordlen(spi, wordlen);
+
+	spi_release_bus(spi);
+
+	return retval;
+}
diff --git a/include/mipi_dbi.h b/include/mipi_dbi.h
new file mode 100644
index 0000000000..1c0c21ba81
--- /dev/null
+++ b/include/mipi_dbi.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * MIPI DBI Bus support
+ *
+ * Copyright 2024 John Watts <contact@jookia.org>
+ */
+#ifndef MIPI_DBI_H
+#define MIPI_DBI_H
+
+#include <asm/gpio.h>
+#include <mipi_display.h>
+#include <spi.h>
+
+/**
+ * struct mipi_dbi - MIPI DBI bus info
+ *
+ * This contains information about a MIPI DBI bus.
+ * Use mipi_dbi_spi_init to create and initialize this structure.
+ *
+ * @spi:	SPI slave this bus operates on.
+ */
+struct mipi_dbi {
+	struct spi_slave *spi;
+};
+
+/**
+ * mipi_dbi_spi_init - Creates a new MIPI DBI bus
+ *
+ * Creates and sets up a 'struct mipi_dbi' using the provided SPI slave
+ * and optional D/C GPIO.
+ *
+ * @slave:	SPI slave the bus is on
+ * @dbi:	Destination mipi_dbi structure to initialize
+ * @dc:		D/C GPIO (NULL if unused)
+ *
+ * Returns: 0 on success, -1 on failure.
+ */
+int mipi_dbi_spi_init(struct spi_slave *slave, struct mipi_dbi *dbi,
+		      struct gpio_desc *dc);
+
+/**
+ * mipi_dbi_command_buf - Sends a command and data over the bus
+ *
+ * Sends a command and any optional data over a bus.
+ *
+ * @dbi:	MIPI DBI bus to use
+ * @cmd:	MIPI DBI command
+ * @data:	Command data (NULL if len is 0)
+ * @len:	Length of data in bytes
+ *
+ * Returns: 0 on success, -1 on failure.
+ */
+int mipi_dbi_command_buf(struct mipi_dbi *dbi, u8 cmd, const u8 *data, size_t len);
+
+/**
+ * mipi_dbi_command - Sends a command and data sequence over the bus
+ *
+ * Sends a command and any optional data over a bus.
+ * The data is a variadic sequence.
+ *
+ * @dbi:	MIPI DBI bus to use
+ * @cmd:	MIPI DBI command
+ * @seq:	Command data bytes
+ *
+ * Returns: 0 on success, -1 on failure.
+ */
+#define mipi_dbi_command(dbi, cmd, seq...) \
+({ \
+	const u8 data[] = { seq }; \
+	mipi_dbi_command_buf(dbi, cmd, data, ARRAY_SIZE(data)); \
+})
+
+#endif /* MIPI_DBI_H */

-- 
2.45.2

