Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD18C71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 08:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFC3581E18;
	Tue, 17 Jun 2025 10:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WKr8fK/I";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="g61eqPjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9835D82B0F; Tue, 17 Jun 2025 10:17:10 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C965780C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 10:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bM08f3y02z9sj8;
 Tue, 17 Jun 2025 10:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1750148226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tXwLfxZl7b5bpFdvtoVG2h6MNJIZ3sUK2eC8lIB3PCo=;
 b=WKr8fK/IUJPPzg/R5gxAkCRgPFMhAlsyXm7u6zOddZvSs/+gX461qDc2GUi2dSKNsGnd1q
 Dfn40RnZlUwd4q9sT63T1LVOhEJFy5kEPFBliQAdHYZ1XRoQ2BOKGK4TvJiexQpTK9q3pd
 pdX5uQnXHKtG87yeo+L1n3R7ZPtXqn8ldlyZOJhvCIQCl6xnD01AXgHcgf6XWJmdiir17b
 QQSYWOEPZ7YJjCVZe437m4k8LLDwepOaSrKTUuNeIdjpAJq3fqNZFNKtUI06gQ6MUFfOVN
 LFuA5l6f2RhIxWFN8+yAUB6ZmxsiSV9AAOUvkqtVAl3XNLn3h35hncZlfu6itA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1750148224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tXwLfxZl7b5bpFdvtoVG2h6MNJIZ3sUK2eC8lIB3PCo=;
 b=g61eqPjFLQJ9dbvAF0YOD0VM+MV5mpkQFfGCO195f/kGnevciVvL+1rSiTcrc5nUbUs5VZ
 W3N04yBAX8UbqPd1khckrKpuzw3gAr3+6MovO4eqp1ixxP19Stq88NTVts2PPuDbz0x0x/
 3HAPGJNu6piJLo7UgR5IG1bGHXggnmTdYpiU6oT8CLCtDRiwPjFQsCMgk6Xg3oITPWxoqM
 UjqfRaBRYqVIioq8Q5UChG5JeDIPkd0yIzMd5Uy7Qa4az2uFOn/Xm/TVK0JFPimjZf3UFt
 3+wONkfrDgS1ZBU5P0DDOGuqNjeqnvHizy8EWFL3fFEUvEL0hU5WgF3zfGpiJg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, John Crispin <john@phrozen.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io
Subject: [PATCH 1/6] drivers: pci: pcie_dw_common: Add
 dw_pcie_link_set_max_link_width()
Date: Tue, 17 Jun 2025 10:16:27 +0200
Message-ID: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jsqh458kah7znud1zek95ui56fbjitua
X-MBO-RS-ID: 190a0fa05b78b32e24d
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

Add dw_pcie_link_set_max_link_width() implementation ported from Linux kernel
as of commit 89db0793c9f2 ("PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling").
This is common code which is already duplicated in multiple drivers.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: John Crispin <john@phrozen.org>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
 drivers/pci/pcie_dw_common.c | 45 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie_dw_common.h |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/pcie_dw_common.c b/drivers/pci/pcie_dw_common.c
index 78961271a8e..c4cad019373 100644
--- a/drivers/pci/pcie_dw_common.c
+++ b/drivers/pci/pcie_dw_common.c
@@ -13,6 +13,7 @@
 #include <pci.h>
 #include <dm/device_compat.h>
 #include <asm/io.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include "pcie_dw_common.h"
 
@@ -28,6 +29,50 @@ int pcie_dw_get_link_width(struct pcie_dw *pci)
 		PCIE_LINK_STATUS_WIDTH_MASK) >> PCIE_LINK_STATUS_WIDTH_OFF;
 }
 
+void dw_pcie_link_set_max_link_width(struct pcie_dw *pci, u32 num_lanes)
+{
+	u32 lnkcap, lwsc, plc;
+	u8 cap;
+
+	if (!num_lanes)
+		return;
+
+	/* Set the number of lanes */
+	plc = readl(pci->dbi_base + PCIE_PORT_LINK_CONTROL);
+	plc &= ~PORT_LINK_FAST_LINK_MODE;
+	plc &= ~PORT_LINK_MODE_MASK;
+
+	/* Set link width speed control register */
+	lwsc = readl(pci->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+	lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
+	lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
+	switch (num_lanes) {
+	case 1:
+		plc |= PORT_LINK_MODE_1_LANES;
+		break;
+	case 2:
+		plc |= PORT_LINK_MODE_2_LANES;
+		break;
+	case 4:
+		plc |= PORT_LINK_MODE_4_LANES;
+		break;
+	case 8:
+		plc |= PORT_LINK_MODE_8_LANES;
+		break;
+	default:
+		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
+		return;
+	}
+	writel(plc, pci->dbi_base + PCIE_PORT_LINK_CONTROL);
+	writel(lwsc, pci->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+
+	cap = pcie_dw_find_capability(pci, PCI_CAP_ID_EXP);
+	lnkcap = readl(pci->dbi_base + cap + PCI_EXP_LNKCAP);
+	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
+	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes);
+	writel(lnkcap, pci->dbi_base + cap + PCI_EXP_LNKCAP);
+}
+
 static void dw_pcie_writel_ob_unroll(struct pcie_dw *pci, u32 index, u32 reg,
 				     u32 val)
 {
diff --git a/drivers/pci/pcie_dw_common.h b/drivers/pci/pcie_dw_common.h
index 8cb99a12ea1..ccd423081eb 100644
--- a/drivers/pci/pcie_dw_common.h
+++ b/drivers/pci/pcie_dw_common.h
@@ -130,6 +130,8 @@ int pcie_dw_get_link_speed(struct pcie_dw *pci);
 
 int pcie_dw_get_link_width(struct pcie_dw *pci);
 
+void dw_pcie_link_set_max_link_width(struct pcie_dw *pci, u32 num_lanes);
+
 int pcie_dw_prog_outbound_atu_unroll(struct pcie_dw *pci, int index, int type, u64 cpu_addr,
 				     u64 pci_addr, u32 size);
 
-- 
2.47.2

