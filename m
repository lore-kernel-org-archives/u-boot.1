Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6769BCCF9E0
	for <u-boot@archiver.kernel.org>; Sat, 25 Oct 2025 02:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5312C838E3;
	Sat, 25 Oct 2025 04:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lprLROM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B050838FA; Sat, 25 Oct 2025 04:48:43 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6795A83893
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 04:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59P2mcaR2019965;
 Fri, 24 Oct 2025 21:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761360518;
 bh=HbB1lfAafZFiTnvJgiZ5Dd/Us25VBrnkInzdAdBXW8M=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=lprLROM3VwYtI+xy+ELeJ4Au4ANf749PiLiCwH1xt0nn8LC7YO/u+JWp+RB3kO/3n
 18COL7fzXTqM7GPWJ6908x9QvxmEy/m0nRK0qFsYqkLvn5djRbNWb6sZRqoAvy5Kfn
 x6a4D9QW2COhdzr5WwW24Cu+xMaOeu0DWNFOgglg=
Received: from DFLE200.ent.ti.com (dfle200.ent.ti.com [10.64.6.58])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59P2mcRi3598414
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 24 Oct 2025 21:48:38 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 21:48:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Oct 2025 21:48:38 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59P2mbxa1259361;
 Fri, 24 Oct 2025 21:48:38 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Sat, 25 Oct 2025 08:18:09 +0530
Subject: [PATCH v3 3/5] arm64: dts: ti: Introduce base support for
 AM6254atl SiP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251025-62sip_support-v3-3-b4c8314d0055@ti.com>
References: <20251025-62sip_support-v3-0-b4c8314d0055@ti.com>
In-Reply-To: <20251025-62sip_support-v3-0-b4c8314d0055@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh R <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761360511; l=1591;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=3HnRyzI0ptrh3M8kWhwwvP+zRg1UXgRjBsgU34NHf78=;
 b=2vNQLlDnEdUEcTt6a0m8l2sWW2VbtIrGRivjNBe5oN0pfFo3nWy0OrzWP+e31f96XFLSIi1Q3
 m933gaDv+5hB9u7eAEeo5moGoxRc2zywgfiRK6cI4wAbU9ghWYscOcS
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

This patch adds the top level dtsi for AM6254atl SiP which integrates
the existing AM625 SoC with 512MiB of DDR in a single package.

More information about the package can be found here:
https://www.ti.com/lit/ds/symlink/am625sip.pdf

Signed-off-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
Link: https://patch.msgid.link/20250814134531.2743874-4-anshuld@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 7c1d13a14e61ab33eec330cb6cabbddb37eecaa9 ]

(cherry picked from commit fa5a6a6e784bde78c6ec74eccd92d51fb9fd49e8)
---
 dts/upstream/src/arm64/ti/k3-am6254atl.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-am6254atl.dtsi b/dts/upstream/src/arm64/ti/k3-am6254atl.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..976ad7dc1e713fa8db98542c87976279dec57a4d
--- /dev/null
+++ b/dts/upstream/src/arm64/ti/k3-am6254atl.dtsi
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * DTS for AM625 SiP SoC family in Quad core configuration and 512MiB RAM.
+ *
+ * Webpage: https://www.ti.com/product/AM625SIP
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-am625.dtsi"
+
+/ {
+	model = "Texas Instruments AM6254atl SiP";
+	compatible = "ti,am6254atl", "ti,am625";
+
+	memory@80000000 {
+		/* 512MiB of integrated RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x20000000>;
+		device_type = "memory";
+		bootph-all;
+	};
+
+};

-- 
2.51.0

