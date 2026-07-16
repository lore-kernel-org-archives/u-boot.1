Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFFDC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D108F84E91;
	Thu, 16 Jul 2026 18:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jz2j54tF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61D5884CE8; Thu, 16 Jul 2026 15:44:43 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B5A84CC4
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-698af3e3620so1000379a12.2
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209481; x=1784814281; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iuD6vlQyk5/Gu1aQm/mSQHKeSHy379Hw1CkCioMdThc=;
 b=jz2j54tFyl0k0nF+mhck8e8qhJiKwpUQ2BM1sU+bLCGK75JqGxMMVulkCU8SmqbX46
 iJWyD21Im4NtycD/cUBRMMAk8ZQtc7HJbMewfrxRWqAPgRjckzyNYUc92LV2Dbqi1vza
 a+G/csqDHR17BPD/w6eQd4lFHkPJhb09KJ9p67++FIqZ3voXWqmiMoL6FEixy/+mrBQt
 PZAQMo7OXVvp1CYT+5aQZqiWWsJMkCNzQLD3KEldMp+W/IaPecPGR7XCMx8kc5i2nZIt
 TWiJAhBHjLQUqUNy1xYApx4XiDewhN7VDO9ADPOms7sWq0c7MUEixNIi3mN71GT7cRP3
 JDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209481; x=1784814281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iuD6vlQyk5/Gu1aQm/mSQHKeSHy379Hw1CkCioMdThc=;
 b=PxX+ekdvS13ebN12ShYMGLLntqETR3b2d8A/XymS4DNi0lt86Z02DdqaSoLpEAEnMk
 ns7ewp+mLhUaY0z2qJ8A0sYPJsAjNQ2xxUEYRMvXHYTxvhxbZWTJldiUDEGI2BUIXhRK
 pQVimpVhOppywyB6Fl2gQtIj/zP53xGOXKoAeizrVkb1yYhaPOT4nBSBWEa2Sag+hUbg
 Z3BymO4Hv4dSegK4MzBDP+BobjNXiLYgX3lybdfeTbIZW1LS6kK6tOuXnDCCQoAME7xE
 OPXysZr1N6/IH462MyjopcS8QgoM/tqRqpXIp9TalGDq8+3KgL/24zY7VApT5kEdsPfd
 igtQ==
X-Gm-Message-State: AOJu0Ywp+7xHy8rtwgao6xX/Ca9E39uKkpaJ7JxrYQs5roKZNXpBQNdS
 U4Pjsm+M20/sAskPSAeQ6lEUu42xiZuqzuKGJofFintdSzQR2pYSCsLZWB26PMSZHmHC+5LRQxk
 Bwt7G
X-Gm-Gg: AfdE7clIDxg/plFkovN5R06rCOS+mAE/Son46561aLQT5dx8WexPn53sCFjKqJe7FwA
 aJD40M4ZxjQLdYDf4DtCrwuiGKy8xYB3bO4FlVoK75+vpniBaovhjzchxzEi2fhCxvwfcr1IJk9
 o4etpxGcRVyMXxpbVn5zHJqkWRob/ObIUmegGAfD4Cy28t8/LyNCOG6cubKQNKc33KgNccziu3Z
 F3cg8R1YgnTcAeu8luiprGKr4+9obmyjKTity7Og9xP2mCfJZT+4DK9xjjjzccv1Y4VAfzXumHK
 SH48H2oX1T2WrHH2Xq1M/Diu2LBf0A4OrdYTUILsxzPq+7IuM9+TPkMDsUn/HRItwWbxs4zOKWE
 fpl7CP+j5pH53uYHOIKIf7A5S8M+1GI9GcZpw4lYZPjAQhEM7dpzHZAEz7PSOWO7z91SQxghosq
 LMsEvZWakmQp7+ovuEvU4YvNUPrlJZbDPAgD93jw==
X-Received: by 2002:a05:6402:40d3:b0:698:d8d2:df38 with SMTP id
 4fb4d7f45d1cf-69e2e3fcad3mr925065a12.2.1784209480639; 
 Thu, 16 Jul 2026 06:44:40 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69cd2937527sm4712868a12.20.2026.07.16.06.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:44:40 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v5 61/75] usb: host: re-import xhci-ext-caps.h from kernel
 v6.16
Date: Thu, 16 Jul 2026 15:42:31 +0200
Message-ID: <20260716134305.614278-62-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716134305.614278-1-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 18:09:05 +0200
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

From: Jerome Forissier <jerome.forissier@linaro.org>

Import drivers/usb/host/xhci-ext-caps.h from Linux v6.16. The file
is needed by the updated DWC3 code.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/host/xhci-ext-caps.h | 158 +++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 drivers/usb/host/xhci-ext-caps.h

diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
new file mode 100644
index 000000000000..c93bcf4f4f7d
--- /dev/null
+++ b/drivers/usb/host/xhci-ext-caps.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Imported from Linux v6.16 */
+/*
+ * xHCI host controller driver
+ *
+ * Copyright (C) 2008 Intel Corp.
+ *
+ * Author: Sarah Sharp
+ * Some code borrowed from the Linux EHCI driver.
+ */
+
+/* HC should halt within 16 ms, but use 32 ms as some hosts take longer */
+#define XHCI_MAX_HALT_USEC	(32 * 1000)
+/* HC not running - set to 1 when run/stop bit is cleared. */
+#define XHCI_STS_HALT		(1<<0)
+
+/* HCCPARAMS offset from PCI base address */
+#define XHCI_HCC_PARAMS_OFFSET	0x10
+/* HCCPARAMS contains the first extended capability pointer */
+#define XHCI_HCC_EXT_CAPS(p)	(((p)>>16)&0xffff)
+
+/* Command and Status registers offset from the Operational Registers address */
+#define XHCI_CMD_OFFSET		0x00
+#define XHCI_STS_OFFSET		0x04
+
+#define XHCI_MAX_EXT_CAPS		50
+
+/* Capability Register */
+/* bits 7:0 - how long is the Capabilities register */
+#define XHCI_HC_LENGTH(p)	(((p)>>00)&0x00ff)
+
+/* Extended capability register fields */
+#define XHCI_EXT_CAPS_ID(p)	(((p)>>0)&0xff)
+#define XHCI_EXT_CAPS_NEXT(p)	(((p)>>8)&0xff)
+#define	XHCI_EXT_CAPS_VAL(p)	((p)>>16)
+/* Extended capability IDs - ID 0 reserved */
+#define XHCI_EXT_CAPS_LEGACY	1
+#define XHCI_EXT_CAPS_PROTOCOL	2
+#define XHCI_EXT_CAPS_PM	3
+#define XHCI_EXT_CAPS_VIRT	4
+#define XHCI_EXT_CAPS_ROUTE	5
+/* IDs 6-9 reserved */
+#define XHCI_EXT_CAPS_DEBUG	10
+/* Vendor caps */
+#define XHCI_EXT_CAPS_VENDOR_INTEL	192
+#define XHCI_EXT_CAPS_INTEL_SPR_SHADOW	206
+/* USB Legacy Support Capability - section 7.1.1 */
+#define XHCI_HC_BIOS_OWNED	(1 << 16)
+#define XHCI_HC_OS_OWNED	(1 << 24)
+
+/* USB Legacy Support Capability - section 7.1.1 */
+/* Add this offset, plus the value of xECP in HCCPARAMS to the base address */
+#define XHCI_LEGACY_SUPPORT_OFFSET	(0x00)
+
+/* USB Legacy Support Control and Status Register  - section 7.1.2 */
+/* Add this offset, plus the value of xECP in HCCPARAMS to the base address */
+#define XHCI_LEGACY_CONTROL_OFFSET	(0x04)
+/* bits 1:3, 5:12, and 17:19 need to be preserved; bits 21:28 should be zero */
+#define	XHCI_LEGACY_DISABLE_SMI		((0x7 << 1) + (0xff << 5) + (0x7 << 17))
+#define XHCI_LEGACY_SMI_EVENTS		(0x7 << 29)
+
+/* USB 2.0 xHCI 0.96 L1C capability - section 7.2.2.1.3.2 */
+#define XHCI_L1C               (1 << 16)
+
+/* USB 2.0 xHCI 1.0 hardware LMP capability - section 7.2.2.1.3.2 */
+#define XHCI_HLC               (1 << 19)
+#define XHCI_BLC               (1 << 20)
+
+/* Intel SPR shadow capability */
+#define XHCI_INTEL_SPR_ESS_PORT_OFFSET  0x8ac4	/* SuperSpeed port control */
+#define XHCI_INTEL_SPR_TUNEN	BIT(4)		/* Tunnel mode enabled */
+
+/* command register values to disable interrupts and halt the HC */
+/* start/stop HC execution - do not write unless HC is halted*/
+#define XHCI_CMD_RUN		(1 << 0)
+/* Event Interrupt Enable - get irq when EINT bit is set in USBSTS register */
+#define XHCI_CMD_EIE		(1 << 2)
+/* Host System Error Interrupt Enable - get irq when HSEIE bit set in USBSTS */
+#define XHCI_CMD_HSEIE		(1 << 3)
+/* Enable Wrap Event - '1' means xHC generates an event when MFINDEX wraps. */
+#define XHCI_CMD_EWE		(1 << 10)
+
+#define XHCI_IRQS		(XHCI_CMD_EIE | XHCI_CMD_HSEIE | XHCI_CMD_EWE)
+
+/* true: Controller Not Ready to accept doorbell or op reg writes after reset */
+#define XHCI_STS_CNR		(1 << 11)
+
+/**
+ * struct xhci_protocol_caps
+ * @revision:		major revision, minor revision, capability ID,
+ *			and next capability pointer.
+ * @name_string:	Four ASCII characters to say which spec this xHC
+ *			follows, typically "USB ".
+ * @port_info:		Port offset, count, and protocol-defined information.
+ */
+struct xhci_protocol_caps {
+	u32	revision;
+	u32	name_string;
+	u32	port_info;
+};
+
+#define	XHCI_EXT_PORT_MAJOR(x)	(((x) >> 24) & 0xff)
+#define	XHCI_EXT_PORT_MINOR(x)	(((x) >> 16) & 0xff)
+#define	XHCI_EXT_PORT_PSIC(x)	(((x) >> 28) & 0x0f)
+#define	XHCI_EXT_PORT_OFF(x)	((x) & 0xff)
+#define	XHCI_EXT_PORT_COUNT(x)	(((x) >> 8) & 0xff)
+
+#define	XHCI_EXT_PORT_PSIV(x)	(((x) >> 0) & 0x0f)
+#define	XHCI_EXT_PORT_PSIE(x)	(((x) >> 4) & 0x03)
+#define	XHCI_EXT_PORT_PLT(x)	(((x) >> 6) & 0x03)
+#define	XHCI_EXT_PORT_PFD(x)	(((x) >> 8) & 0x01)
+#define	XHCI_EXT_PORT_LP(x)	(((x) >> 14) & 0x03)
+#define	XHCI_EXT_PORT_PSIM(x)	(((x) >> 16) & 0xffff)
+
+#include <linux/io.h>
+
+/**
+ * Find the offset of the extended capabilities with capability ID id.
+ *
+ * @base	PCI MMIO registers base address.
+ * @start	address at which to start looking, (0 or HCC_PARAMS to start at
+ *		beginning of list)
+ * @id		Extended capability ID to search for, or 0 for the next
+ *		capability
+ *
+ * Returns the offset of the next matching extended capability structure.
+ * Some capabilities can occur several times, e.g., the XHCI_EXT_CAPS_PROTOCOL,
+ * and this provides a way to find them all.
+ */
+
+static inline int xhci_find_next_ext_cap(void __iomem *base, u32 start, int id)
+{
+	u32 val;
+	u32 next;
+	u32 offset;
+
+	offset = start;
+	if (!start || start == XHCI_HCC_PARAMS_OFFSET) {
+		val = readl(base + XHCI_HCC_PARAMS_OFFSET);
+		if (val == ~0)
+			return 0;
+		offset = XHCI_HCC_EXT_CAPS(val) << 2;
+		if (!offset)
+			return 0;
+	}
+	do {
+		val = readl(base + offset);
+		if (val == ~0)
+			return 0;
+		if (offset != start && (id == 0 || XHCI_EXT_CAPS_ID(val) == id))
+			return offset;
+
+		next = XHCI_EXT_CAPS_NEXT(val);
+		offset += next << 2;
+	} while (next);
+
+	return 0;
+}
-- 
2.53.0

