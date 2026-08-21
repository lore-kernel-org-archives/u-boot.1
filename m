Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F804C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7009F606A6;
	Fri, 21 Aug 2026 13:11:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xew5p5EmmQQ0; Fri, 21 Aug 2026 13:11:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787317902;
	bh=EPnDN5mqPRCP4fFRs5P7OsCYt7+b0rC3dsviOcNl7JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qj9GNM4O/EgZxEc+RluqBF9fs0UTDnCpvUupuQOsTzqCzF08Yk/BlknsCPh/Bk9uy
	 Q3APbZIUMoxTnv5ogx9LD9Zh9RciR8UD993RqfFHWUK59WCAQ6I1FyqTfm3ZXFOO+z
	 W3Vtuj2Z+uPejs0vJPX1Fl/O4i8UtwATpPenbeZSkoUZjw2rQgZWliHT+AxHXs4+ug
	 Trmxt2RZiOM0rz829uYWArMK2cSuNN4y/cbHy38xUe0k+lYiMbWC+kjtN3zNjxcLH0
	 wFv3owDVsCiosXkoFLuSPhW3ZtrZtTmCeZFE8HVuGTTsfNnv3IbCmTUKMQAvCRe2Al
	 n0YBQBU35i8ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81094606BD;
	Fri, 21 Aug 2026 13:11:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 681D6476
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4559D81000
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6k0_q2d35-ne for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:50:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ntUrxdYe
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1AEC80FF9
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:50:49 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69f4acf7047so132837a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302248; x=1787907048;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EPnDN5mqPRCP4fFRs5P7OsCYt7+b0rC3dsviOcNl7JQ=;
 b=ntUrxdYegV7irEgcQGyeSNCwWfGT7Jkwq9VkHpmCfE71p8OvEKO5o85TRR791zrcr0
 Bf8aspB+DU1DRr/FPn+p9NO1TmMvlUcSyV5vazxzCd9BIFf1taVteinmdZMdkOx5qlew
 uKWWqCMjU+/9MYe6gmRwHxEE+IDTOh0DB4DQxGpYbqB0PvIhbkTLP6iGWal2gjmPv6Vn
 DhR4/pF0CaJWw9/ZSBiJNZMt1CLXr05VM6+72RoEum7vmVwAkYdmCeVkgZljk1ieoiLX
 MzBVGbm6vlZe2wtGllQ4eBMC4dLzZpTd594k+xXGL2jD1C9cXwhDUEp1bqQ1HGL7u17y
 1UuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302248; x=1787907048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EPnDN5mqPRCP4fFRs5P7OsCYt7+b0rC3dsviOcNl7JQ=;
 b=cnLGspvIeEKWnLnVN4EFZ2S61vc1usV6TLvGL4uVwZuHhp1mqi7IrDBupWK+BPygxz
 tL7vE8C1xyIy0TKHF0dpreHh6wZMLmFfpT0x90DG4yj0tYQJ02Kzbc799hHQnOZiXeAl
 ng83U1eBFOvFlZwOWed0X5tQndm3t4JDnEq4Cr6BQJqPer/l53Y/mPqe0ak+DRzHxz2c
 BQ2ltfOqeSiz/z5h8zeov9oFCJrrHLtVHKU74GM1h8yDs3DhzdIFlCy3PbcFkfmueotR
 jqLeCjRQ5Too4a2IPZJjt4ma5OAtRy6NWV75DJfa4c9NDRYAyiEpP/+JphVGKpqB3gmd
 ffXw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrF52+T0FnaF5BCSNI5FfnSxyEyANmuQTFhDw7QNE/8ZcE0sFgHd3Xa/4/4rA1GiG/XOlYqFnQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kTQWWZ1rZUCzVVj5oXxHacBWLOnfy6gjj0P8/ovgQQLiAV7442
 d0aEyuwr0Jv3iJiBCl155KsYKaB6YxIVTBRcfj1olICwhxuTRPeKWkg+A4l7iprpDgRw5CpLi0U
 H8YfM
X-Gm-Gg: AR+sD10S9kA/mn2A5bzEXgWl9icLG3Z5i+gMq7FUl4fRrcM0l2zrEU/r2U4oVEBeeMf
 a0/BqzxTQfnkUuLNJE9xO4LsI2xbse4x7C9Yu2BmnaA7aPtriEzVNKw2dRJUqjFCuqGDjx+FK1x
 mbHcdgIxL2eBwEQ1Ge8vMlh7sKqWzqk+dz5iwnwE6N7joKgK0Yi1jv1RmJTKMjTTvhug+lpCmMz
 mgimslsxbIfl73n5un1DoX61MiQmwkVJ+3ns+ggTzR3DZJC9bvv4bEW48gz9fHLBRASl6+zcXbm
 abu5FKjrgpolPAJHbvMgd+vnUzTtsSUmSM/BfzIGOHFMWv95Qv5ZGqttBIFUdYnz1+uR4Ntxv8u
 DWuTpToRwBL7ztU5Us4Pvsh2G9v4GaZSRKZKGSaTe9Wg9O9K7b5OGguUrsK1cJKinKJMcU0oNUd
 +P/KkLeAtTwq63NJxrM9ryMh0FGHfjLznLYlOHO4/tGrSaNdTIZgsFV7l+kybYBBnjWO1dzZgjo
 mUGwOYKgrg8t+aCCxuD9YQj
X-Received: by 2002:a05:6402:5d0:b0:6a1:de1:f739 with SMTP id
 4fb4d7f45d1cf-6a42f21945emr2669335a12.2.1787302247461; 
 Fri, 21 Aug 2026 01:50:47 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3feec9d52sm5735382a12.2.2026.08.21.01.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:50:46 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 01/87] usb: host: re-import xhci-ext-caps.h from kernel
 v6.16
Date: Fri, 21 Aug 2026 10:46:37 +0200
Message-ID: <20260821084829.2070426-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:39 +0000
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

