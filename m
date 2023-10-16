Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970B2CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10E8386E17;
	Mon, 16 Oct 2023 11:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFE3586B1D; Mon, 16 Oct 2023 11:26:09 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id A250386F14
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,229,1694703600"; d="scan'208";a="179418319"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 16 Oct 2023 18:26:05 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.82])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 944F341F9DEF;
 Mon, 16 Oct 2023 18:26:02 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 03/21] dt-bindings: Add RZ/G2L PFC bindings
Date: Mon, 16 Oct 2023 10:25:25 +0100
Message-Id: <20231016092543.3833-4-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
References: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
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

Import bindings for the Port Function Control (PFC) module in the
Renesas RZ/G2L SoC family.

This patch is based on the dt-bindings in Linux v6.5
(commit 52e12027d50affbf60c6c9c64db8017391b0c22e).

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
v2->v3: No changes.
v1->v2:
  * Added the exact Linux commit we imported from.
  * Add Marek's Reivewed-by.

 include/dt-bindings/pinctrl/rzg2l-pinctrl.h | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/rzg2l-pinctrl.h

diff --git a/include/dt-bindings/pinctrl/rzg2l-pinctrl.h b/include/dt-bindings/pinctrl/rzg2l-pinctrl.h
new file mode 100644
index 000000000000..c78ed5e5efb7
--- /dev/null
+++ b/include/dt-bindings/pinctrl/rzg2l-pinctrl.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for Renesas RZ/G2L family pinctrl bindings.
+ *
+ * Copyright (C) 2021 Renesas Electronics Corp.
+ *
+ */
+
+#ifndef __DT_BINDINGS_RZG2L_PINCTRL_H
+#define __DT_BINDINGS_RZG2L_PINCTRL_H
+
+#define RZG2L_PINS_PER_PORT	8
+
+/*
+ * Create the pin index from its bank and position numbers and store in
+ * the upper 16 bits the alternate function identifier
+ */
+#define RZG2L_PORT_PINMUX(b, p, f)	((b) * RZG2L_PINS_PER_PORT + (p) | ((f) << 16))
+
+/* Convert a port and pin label to its global pin index */
+#define RZG2L_GPIO(port, pin)	((port) * RZG2L_PINS_PER_PORT + (pin))
+
+#endif /* __DT_BINDINGS_RZG2L_PINCTRL_H */
-- 
2.39.2

