Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565AECAC592
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 00:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB9E783321;
	Wed, 17 Sep 2025 02:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A7C8331F; Wed, 17 Sep 2025 02:04:46 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8708283321
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 02:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 89CA7B22084D;
 Wed, 17 Sep 2025 02:04:42 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 3/4] riscv: dts: starfive: visionfive2 depend on SYS_CPU
 automatic dtsi inclusion
Date: Tue, 16 Sep 2025 17:02:24 -0700
Message-ID: <20250917000254.1134031-4-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250917000254.1134031-1-e@freeshell.de>
References: <20250917000254.1134031-1-e@freeshell.de>
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

Drop visionfive2 per-board -u-boot.dtsi stubs and instead rely on
automatic inclusion of jh7110-u-boot.dtsi

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi   | 7 -------
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi               | 7 -------
 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi            | 7 -------
 .../dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi     | 7 -------
 .../dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi     | 7 -------
 arch/riscv/dts/jh7110-u-boot.dtsi                          | 1 +
 6 files changed, 1 insertion(+), 35 deletions(-)
 delete mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
deleted file mode 100644
index b9202f2acce..00000000000
--- a/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
+++ /dev/null
@@ -1,7 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright (C) 2024 StarFive Technology Co., Ltd.
- */
-
-#include "jh7110-u-boot.dtsi"
-#include "starfive-visionfive2-binman.dtsi"
diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
deleted file mode 100644
index b9202f2acce..00000000000
--- a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
+++ /dev/null
@@ -1,7 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright (C) 2024 StarFive Technology Co., Ltd.
- */
-
-#include "jh7110-u-boot.dtsi"
-#include "starfive-visionfive2-binman.dtsi"
diff --git a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
deleted file mode 100644
index b9202f2acce..00000000000
--- a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
+++ /dev/null
@@ -1,7 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright (C) 2024 StarFive Technology Co., Ltd.
- */
-
-#include "jh7110-u-boot.dtsi"
-#include "starfive-visionfive2-binman.dtsi"
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
deleted file mode 100644
index b9202f2acce..00000000000
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
+++ /dev/null
@@ -1,7 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright (C) 2024 StarFive Technology Co., Ltd.
- */
-
-#include "jh7110-u-boot.dtsi"
-#include "starfive-visionfive2-binman.dtsi"
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
deleted file mode 100644
index 848ed8225ac..00000000000
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
+++ /dev/null
@@ -1,7 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright (C) 2023 StarFive Technology Co., Ltd.
- */
-
-#include "jh7110-u-boot.dtsi"
-#include "starfive-visionfive2-binman.dtsi"
diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
index cc27dd648f8..0e5dc3685b2 100644
--- a/arch/riscv/dts/jh7110-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-u-boot.dtsi
@@ -83,3 +83,4 @@
 	assigned-clock-rates = <0>; /* FIXME: delete property and implement cpufreq */
 };
 
+#include "starfive-visionfive2-binman.dtsi"
-- 
2.50.0

