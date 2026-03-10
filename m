Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67B4EB1054
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 14:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AA888405B;
	Tue, 10 Mar 2026 15:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="t02awtlA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E287F8408D; Tue, 10 Mar 2026 15:13:34 +0100 (CET)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBAC98409A
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id CD0C060134;
 Tue, 10 Mar 2026 15:13:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773152011;
 bh=c12gn6OM/d/IhB61hv69TBlqA/Q4Kdy4xy1iqYjIpTo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t02awtlAh30ydQn8zOwEcna23pJMNC/JW0H6JcubmnMjQLBYmwoejMTEKLS300OCn
 QOBMDA4VGo60IoNxnzTUO8jfkqAG0lfWTQijUVkkZjnPuP7zOCcw+P0l86KWcj6h16
 8v/f3VtKo+XkNAtd//1YHX0r4ln2/TwSP9T3HrBDjLyRjKyjgx9kJ3943qml3qks+g
 CLlDRxQoJVuH4LS8GTvwiJoCNZ2pEDYAjMtlD+bIVwOMLj3Io34CJEhS19hZvUFK6f
 5Od/ZCtMJMPkQJWwdDi5jc1Kpq9cmN7MBbQeNk1EAKbXPxY7DtuIHBOVI1bOzL+uec
 aasal4ItPFNaA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 vjardin@free.fr
Subject: [PATCH v1 3/5] arm: dts: armada-8040-nbx: add U-Boot dtsi for
 conditional OP-TEE
Date: Tue, 10 Mar 2026 15:12:50 +0100
Message-ID: <23919414aa41272279b0e835f92c71f823213cba.1773151972.git.vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773151972.git.vjardin@free.fr>
References: <cover.1773151972.git.vjardin@free.fr>
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

Add armada-8040-nbx-u-boot.dtsi with the firmware/optee node guarded
by CONFIG_OPTEE. This allows U-Boot to probe the OP-TEE driver only
when OP-TEE support is enabled in the configuration.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 arch/arm/dts/armada-8040-nbx-u-boot.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm/dts/armada-8040-nbx-u-boot.dtsi

diff --git a/arch/arm/dts/armada-8040-nbx-u-boot.dtsi b/arch/arm/dts/armada-8040-nbx-u-boot.dtsi
new file mode 100644
index 00000000000..dec473b7156
--- /dev/null
+++ b/arch/arm/dts/armada-8040-nbx-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Free Mobile, Vincent Jardin
+ */
+
+#ifdef CONFIG_OPTEE
+/ {
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+};
+#endif
-- 
2.43.0

