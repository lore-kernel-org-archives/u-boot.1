Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B80C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F21F881DF;
	Fri, 22 Mar 2024 12:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711107824;
	bh=ptbjB7vny7LMXOI5RNKTmwDDnUc7llEs9SFC1px7cdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GBuLHRstP1PzLk4uBSrUuc61A6a15VyKy6egx4qOWrG6h+A+VMKDpVN/erJV5QvDL
	 7bJ9SUxF6bDF7MrAYWyS/FYrNpNi2lZ1eSWfdHoKT93M3QKgzxrUIIeUAP4urajiY4
	 1ZIcfbXIiJkKTrHHc9BHINFHr1V1Gti9Z/7HCMw6zu0y4NN/7nfT9dkN8wgYkbHk3w
	 hhPEAnt84YHzVmJCrhLQI7ckIOLw+6MGWLVjwcRPy8dC698rNW5pDgEuSCkWk7Z6Ld
	 78YNco4nQjQGTGMGpFzT0NrWzD7dJVI63X6Q22AaWDWvOyr+eREVfeCKFDgo+LYm9f
	 WTGK04n/E00ng==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9944C881E6;
 Fri, 22 Mar 2024 12:43:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711107819;
 bh=ptbjB7vny7LMXOI5RNKTmwDDnUc7llEs9SFC1px7cdg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fXNcgeV2BIIWzPR4E0bqYIse2p4QqL3liUEwMTNsqfwWiinOZ8EHd143Qr/tWSA9f
 gmj9p6hd7foRk9GSSiGYU8LjEXs6df29qWWqzTw6NWK8yg44BIKjrYNBLrgdpJMRpB
 w2DLrTab4x5EEzUoUwrH6z8L0tuL8OTchp50Txm87hLn5Xzu/36t2GzuvrBQ5pyg+P
 TJCX0g/FT09chX376Ib9rAMew5h/NcMv+Zm2asxDGHKc63wSRLYeEBGR03IPptu9LO
 Y6EJo6HcfGPrv6jSE2Qnch7BpnppDxVUi6//UWebgdF4yUUUgKVic4Az78STspmsvY
 IRgURDlMAc/Hg==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>,
	u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, FUKAUMI Naoki <naoki@radxa.com>,
 Fabio Estevam <festevam@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Mathieu Othacehe <othacehe@gnu.org>,
 Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/12] dts: xea: Add device tree description for XEA HW rev. 2
Date: Fri, 22 Mar 2024 12:43:10 +0100
Message-Id: <20240322114315.2720727-8-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322114315.2720727-1-lukma@denx.de>
References: <20240322114315.2720727-1-lukma@denx.de>
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

For SPL and u-boot proper, the difference between revsions boils
down only to the GPIO pin for PHY reset.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

 arch/arm/dts/Makefile                |  3 ++-
 arch/arm/dts/imx28-xea-2-u-boot.dtsi | 11 +++++++++++
 arch/arm/dts/imx28-xea-2.dts         |  8 ++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/imx28-xea-2-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx28-xea-2.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 4fc508bcfc..69131599ae 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -879,7 +879,8 @@ dtb-$(CONFIG_TARGET_MX23_OLINUXINO) += \
 
 dtb-$(CONFIG_MX28) += \
 	imx28-evk.dtb \
-	imx28-xea-1.dtb
+	imx28-xea-1.dtb \
+	imx28-xea-2.dtb
 
 dtb-$(CONFIG_MX51) += \
 	imx51-babbage.dtb
diff --git a/arch/arm/dts/imx28-xea-2-u-boot.dtsi b/arch/arm/dts/imx28-xea-2-u-boot.dtsi
new file mode 100644
index 0000000000..6ce82531d5
--- /dev/null
+++ b/arch/arm/dts/imx28-xea-2-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2024
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+#include "imx28-xea-u-boot.dtsi"
+
+&mac0 {
+	phy-reset-gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/dts/imx28-xea-2.dts b/arch/arm/dts/imx28-xea-2.dts
new file mode 100644
index 0000000000..8cb1190ba5
--- /dev/null
+++ b/arch/arm/dts/imx28-xea-2.dts
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2024
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/dts-v1/;
+#include "imx28-xea.dtsi"
-- 
2.39.2

