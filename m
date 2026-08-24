Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E3EC5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5955F80C8A;
	Mon, 24 Aug 2026 16:44:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YVgznB_51udB; Mon, 24 Aug 2026 16:43:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589837;
	bh=EPnDN5mqPRCP4fFRs5P7OsCYt7+b0rC3dsviOcNl7JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u0brV7tQr89/lgQr/3Ska8KbxmSLjvZl35eHptHXR5BNkGyvP0XH55aaEiSoqFhVx
	 9/0woUPYzGTTTb0ZkzLt75sAfU24ZSckhqBjNVK49zyh5jPL2kz9D8GlG+YkvMKaWe
	 HgQTKKbzghluSFKaaG6LNT7fQCt6xXzyxzWVfuIDwYxCwdacDSdk5dPf4D3EYkWTua
	 AbZLhEa5J8bVZBotVlbYGZY/dIZ9c3jXq/K1PIg606EOI9xXdRjnP8yIcJcbYOmND2
	 rfdzL9rvdaJ8xp1tJ6Mj/IWADcCkyvrLogrU4o/hpGOmg7n1oU7J1QPaoblGl7JyPz
	 EgZwI1l/2zo0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A873180AC6;
	Mon, 24 Aug 2026 16:43:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A644E396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CCC3605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hoO3gBZYVlPs for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:28:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Hq7ftNcD
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D25A605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:02 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c1f1f5631f8so34341666b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585281; x=1788190081;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EPnDN5mqPRCP4fFRs5P7OsCYt7+b0rC3dsviOcNl7JQ=;
 b=Hq7ftNcDtwavzAnPXlhxe+UcpXRXKIRBWbr1/cUu5fB4VzMZMliuzfYMOdP9SH5Ofq
 9kP6jGZ2VaEUGOpI8qpsdnPD9bnuQwI5HwymnCswIQjgKzq4Ns+j9EzXVOTuHbEz8sPo
 NzfAMl6+PNKCcwtIC7E9JwNcAcO2qLylx4cUv8c2lSNhxVm8Fx6O0NQNxsYNQEXZW+cO
 ywHwAjpGuDyBnsbsPj9xI/4LJHpwnoQugpRiT3ZYWWeJpDch13TqKwPnvq3UZxXOwmCR
 XEb7BeapBhcivIoUUBH0ET02esTbEjFtRG2fthkfMiKXmeHrj5gl1y/+NziRpr90+Nwu
 2Lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585281; x=1788190081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EPnDN5mqPRCP4fFRs5P7OsCYt7+b0rC3dsviOcNl7JQ=;
 b=VP7OCQb2MpyCJM5parAsvhN7QJc/MbnJ0AKtF07NwTonAUotBqhZ8NRgWko3qJZO5s
 nptKmhXN8W/9gUDptyihN8GsTrreJlFbg2gCqsItfUUrxgdrU8NffhXSXDzFFx3O5h5g
 Pk0z0dM1tmYQsBQ7XbslB+tiq/jKOiig+CPdxzCBaSya5jzl0qguLu1FnUbUPUa594in
 nOZgESPorXpSc+d7wdWPxZD6caZqwLJs3+yMA0mJCfCWzSbrhQDXpZZzv4unDO3LPUqg
 VocRzcsKIQ0SQ1H00A5mkBD9SNZAGQhjw7PolUQPVMFdd9b3/ytR00cbnYt9gKX88ovb
 pPdA==
X-Gm-Message-State: AFuF++k6PAdIOB7kBSeuvEIs1vqOG1E9W1tf8Pixbb9e4Qe5zEmPaPuK
 t2OEVlH3Qd+OfOw7JvKTk6OyUGRkLCyzg1AWR6cRdDNvrub291+jQtkjw9/ZYjQzixRCH6FmUI+
 GyB9o
X-Gm-Gg: AR+sD128hrUobju+GlOqPSerWJuBqCWM9ssC9eaI94Q1AOitQy2L1mvioLCONaKocc4
 Na2TyEvrcyuKbCqwwD+jbtGpT81z5neAGa5msPkNajqB++PJsmbf09d7hDeGAp1LdvyBNVyutHy
 DQMrjv+pFWSGHDx08R8tCzK+AreVZyzzBcD3RmPRG/YiivdYmO4KZztfGWiTIwpL4kgRTTHOLZD
 9dsyPla/3jS7XeZPDNK3WJUr/TwVeUS0DPvnDqdT84rRD+xxvcMUx0SLRAcz+DDthPP5Y4NpDqB
 7tsC4+TVW8nxN1P34m4OMP3V+zrJfp68ZuXj6oW5BntOH8+gk0+zSMsBs1byOSmyv0+fpr1Ms1/
 6y4eeE40R93CvvmzHZTyhSlUNn270WROyMCcCFwb91OPcuWH/v7qmAyJliuADOkMF8Jc2njbdwS
 2lisIe25BwusfIcSIj3ji++XD1lVk34wjAqtQ0L2EiPQtpmAJQAIxozWwFigDmBjv3VAMVeWzPw
 z9CPU/aE8/N3fFGaZ5mQA==
X-Received: by 2002:a17:907:1c26:b0:c21:8555:5f55 with SMTP id
 a640c23a62f3a-c246a65eda7mr1785235466b.2.1787585280860; 
 Mon, 24 Aug 2026 08:28:00 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa1dsm1247744766b.56.2026.08.24.08.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:28:00 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 01/63] usb: host: re-import xhci-ext-caps.h from kernel
 v6.16
Date: Mon, 24 Aug 2026 17:26:32 +0200
Message-ID: <20260824152734.159794-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824152734.159794-1-anders.roxell@linaro.org>
References: <20260824152734.159794-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jerome Forissier <jerome.forissier@linaro.org>

Import drivers/usb/host/xhci-ext-caps.h from Linux v6.16. The file
is needed by the updated DWC3 code.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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

