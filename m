Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE278CD610B
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 16:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3415886DC7;
	Mon,  9 Oct 2023 18:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0E7286DA8; Mon,  9 Oct 2023 18:47:16 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id BA50886D62
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 18:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,210,1694703600"; d="scan'208";a="178655027"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 10 Oct 2023 01:47:12 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.229])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id AE317402A8D6;
 Tue, 10 Oct 2023 01:47:09 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 04/19] dt-bindings: Add RZ/G2L IRQC bindings
Date: Mon,  9 Oct 2023 17:46:30 +0100
Message-Id: <20231009164645.164464-5-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
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

Import bindings for the Interrupt Controller (IRQC) module in the
Renesas RZ/G2L SoC family.

This patch is based on the dt-bindings in Linux v6.5
(commit 52e12027d50affbf60c6c9c64db8017391b0c22e).

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
v1->v2:
  * Added the exact Linux commit we imported from.
  * Add Marek's Reivewed-by.

 .../interrupt-controller/irqc-rzg2l.h         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 include/dt-bindings/interrupt-controller/irqc-rzg2l.h

diff --git a/include/dt-bindings/interrupt-controller/irqc-rzg2l.h b/include/dt-bindings/interrupt-controller/irqc-rzg2l.h
new file mode 100644
index 000000000000..34ce778885a1
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/irqc-rzg2l.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for Renesas RZ/G2L family IRQC bindings.
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ *
+ */
+
+#ifndef __DT_BINDINGS_IRQC_RZG2L_H
+#define __DT_BINDINGS_IRQC_RZG2L_H
+
+/* NMI maps to SPI0 */
+#define RZG2L_NMI	0
+
+/* IRQ0-7 map to SPI1-8 */
+#define RZG2L_IRQ0	1
+#define RZG2L_IRQ1	2
+#define RZG2L_IRQ2	3
+#define RZG2L_IRQ3	4
+#define RZG2L_IRQ4	5
+#define RZG2L_IRQ5	6
+#define RZG2L_IRQ6	7
+#define RZG2L_IRQ7	8
+
+#endif /* __DT_BINDINGS_IRQC_RZG2L_H */
-- 
2.39.2

