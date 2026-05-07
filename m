Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AC3CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9540D84B76;
	Thu,  7 May 2026 11:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="agE2wl0t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 297EA84B7E; Thu,  7 May 2026 11:31:46 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4264B84B76
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5a86bfa2a4eso761045e87.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146299; x=1778751099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P141Vl1Ditynr7hgB6lVtLJupZNZVd7+ONjb0qhpvQg=;
 b=agE2wl0tmn1Yy5jcT6QlX7/LO3Nrl7TFZn5EX/1pSFpyzLYK02MlNM5wky7Lm5nZC1
 5F2NsEcFjHXk+mDfYi3/z7WfytTVsMm5Ipuk55iqbzEjoI4frLCbE6pvpAWeahBe6Csw
 anaYUQ9U71hk2yQzFZ6h9lwPyoJt9OROFmARRZirksrfIR65bHkrlqgJX5PuJ+cGmmjU
 fjDxr10hMgQm35xVh0K/aTeD4moEYA+owpORu/+OR+VkkgrzpAOi0xFMyVlFXpxy568d
 XPpUmUx6kxxaAQ/Q/UDi85duaMT2AoAyAMtSOvnLPhx/2m4BlSpaBlSE7TNfa+LM++tp
 YDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146299; x=1778751099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P141Vl1Ditynr7hgB6lVtLJupZNZVd7+ONjb0qhpvQg=;
 b=eBB5P0a3WHi+YH47iykfNk1t3hFLVnbOcXEbfVZ3+6FN/sN/SDCU2ci2fmG3umVpAA
 TFXcLhkuQlfGV6AK7sWOPHJzmpKg6AO1fiY5fThCIH+uaTjBYEbQS0ETMYD+EU13XsPm
 WJGBLDI3gAICiPj09cy10VAPotuvm6mPNzN/7irq2wv8M8BT8+DFvjgD/t7sR3WCy/ge
 gZTJXlTAezwPc4fUdGfwMYxZkkh3WnCjRgrN3bGDxX27bOqGCwOd7aNXnvJ9Nhp0VkL6
 cvJxQP/Fl+57l8zXYd52lnXScjQKjKvFEijVrrFcfnz/2sZgSvmE2epa1yA8X7AHua45
 he1A==
X-Gm-Message-State: AOJu0YzfEXSAsRYfLrQhvoRKvDiBqJZDDc//rOakJXYkE9cN1WXZZaRi
 Ry6+1B6UxV6L14ph0CBoz0oAwNW//2Q7vZeHZq2z4B111EErtSonmBYQlv9NaEZuDz6RN+Z36su
 dhxFSEmrBhA==
X-Gm-Gg: AeBDievypEN1h0HNnHXZqLaN9JlzQ9tc/0Hp9nDs/UElU9dYFCaoHch/JpA7Gr/AuxX
 tpe0ZwKRvDyHcRUw6rOtnkNzMZGRpaHBCtb4QTL9vbj4FLPRnFnRa8Jb1XSP0DuNHnBV1V6TGnb
 WvunzxkArCkuDPtKurrhv2B9P/hifIpTqUgRTAtVGGeCtLyLa581H1lGmIWSODlbUPNa3g+8BE1
 8yrhKLXehUUEBLSHap4FMNbQWZUtiLuFSUXlYMRSpf4TVxW3gXx89deNjPw3w9M/vuUMOPxj8tj
 pyErmyhlUnynUVxCf8aK6voUegrpUgMCyHoruHZTH3u4Se/HE/MIPNChaolpvK4HmPbo65vVZ3Y
 gob8UkZyBpAAAvdGA9km+GCsMd0w0VQDaPm3Zd8vtDM4oeLNXh3RTIHK7fDkWJCeNpCcboWbYL5
 75EaBMF34g0kXKwQsShZBF+9mSRGWX0LuBFka8e5IxtPaP+/wWEqDo0Xhy6AJhMZfrd0oPxKS2E
 TwfjfLLWF8rdZc2Kn1dKutwVhQ7kSnM3BhOeOo+58wM2TRuDWqJ
X-Received: by 2002:a05:6512:3d03:b0:5a8:7f42:7053 with SMTP id
 2adb3069b0e04-5a887ada563mr2458938e87.2.1778146299321; 
 Thu, 07 May 2026 02:31:39 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:31:38 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [RFC PATCH v2 61/64] usb: host: re-import xhci-ext-caps.h from kernel
 v6.16-rc7
Date: Thu,  7 May 2026 11:28:08 +0200
Message-ID: <20260507092843.358908-62-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507092843.358908-1-jens.wiklander@linaro.org>
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Import drivers/usb/host/xhci-ext-caps.h from Linux v6.16-rc7. The file
is needed by the updated DWC3 code.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/host/xhci-ext-caps.h | 158 +++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 drivers/usb/host/xhci-ext-caps.h

diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
new file mode 100644
index 000000000000..fd23eda6f616
--- /dev/null
+++ b/drivers/usb/host/xhci-ext-caps.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Imported from Linux v6.16-rc7 */
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
2.43.0

