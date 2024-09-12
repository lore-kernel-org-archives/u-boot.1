Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13843EED617
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 15:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29EBD89021;
	Thu, 12 Sep 2024 17:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LwVCnPlc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47CAD88FC7; Thu, 12 Sep 2024 17:51:21 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F0D89017
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4FEFEA456FB;
 Thu, 12 Sep 2024 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73F8BC4CED1;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726156274;
 bh=Wcxtvv9FqjMHskCvc1I7aQ59n67oR7D8TEARjpn3e+w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=LwVCnPlc49NY5WJvdeh427cASOTUoP/bEU95nDorWe08s6Ht64K0a3Y3dpklNsr0+
 nlmZA7vEgp2VZyowED3sXsLltgk/INBMs5FID0xCNIrriXNU9BN6JNAWjXMfFsIiAa
 nRcjXQJTQ5tOmOPUn3OEVMO1pyJfZmVYyifnb/ylI7tV4YYCud6s666yv8etVtIeEo
 iMCICjNqwuSaSZmtsVqAGc1xx1r7GY/DNZAh28hIz4lmHdIGRY33lKVbK71xm7uMJT
 kfg5HCDC3n0Wi5IAEu//trN0RJ3NQoPBZw+HZW5+Xfoc7my7sCcfHCU2BHCo4DImxz
 9bYoYgbYJqoQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6C744EED619;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Thu, 12 Sep 2024 16:50:48 +0100
Subject: [PATCH v2 07/20] arm: dts: Support SC598-SOM-EZKIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-sc5xx-upstreaming-patches-v2-7-1185a80df79e@analog.com>
References: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
In-Reply-To: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
To: Tom Rini <trini@konsulko.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726156261; l=2588;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=oRH7CqqIIeZCLwUk0nrEISnn1gUKi7bmcfu76neRw9U=;
 b=BLUyeA34byXt6aIJeERWs/0IZOGIFP0j5PQQlf+xfKvn6G5UmqDcvwzh+mzMPaxWEBNIoa+mo
 /zOKgo33GChDBE7LO5dDC3piJlGH9J7aFbXCWGrUtd1WmfxsyloqYzB
X-Developer-Key: i=Oliver.Gaskell@analog.com; a=ed25519;
 pk=Icq9TxwFJ6FePHS28YbBWMvtZpFWxpPQLhLA9cNvZ/Y=
X-Endpoint-Received: by B4 Relay for Oliver.Gaskell@analog.com/20240821
 with auth_id=197
X-Original-From: Oliver Gaskell <Oliver.Gaskell@analog.com>
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
Reply-To: Oliver.Gaskell@analog.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Oliver Gaskell <Oliver.Gaskell@analog.com>

Add minimal device tree for Analog Devices' SC598-SOM-EZKIT board, and
the SC598 SoM.

This patch depends on patch 01, for sc5xx.dtsi.

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 arch/arm/dts/Makefile            |  1 +
 arch/arm/dts/sc598-som-ezkit.dts | 13 +++++++++++++
 arch/arm/dts/sc598-som.dtsi      | 31 +++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 7a1dd24838..59871e167a 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1264,6 +1264,7 @@ dtb-$(CONFIG_TARGET_SC589_MINI) += sc589-mini.dtb
 dtb-$(CONFIG_TARGET_SC589_EZKIT) += sc589-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC594_SOM_EZKIT) += sc594-som-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC594_SOM_EZLITE) += sc594-som-ezlite.dtb
+dtb-$(CONFIG_TARGET_SC598_SOM_EZKIT) += sc598-som-ezkit.dtb
 
 ifneq ($(CONFIG_TARGET_IMX8MP_RSB3720A1_4G)$(CONFIG_TARGET_IMX8MP_RSB3720A1_6G),)
 dtb-y += imx8mp-rsb3720-a1.dtb
diff --git a/arch/arm/dts/sc598-som-ezkit.dts b/arch/arm/dts/sc598-som-ezkit.dts
new file mode 100644
index 0000000000..7289e4d1d5
--- /dev/null
+++ b/arch/arm/dts/sc598-som-ezkit.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+/dts-v1/;
+
+#include "sc598-som.dtsi"
+
+/ {
+	model = "ADI SC598-SOM-EZKIT";
+	compatible = "adi,sc598-som-ezkit", "adi,sc59x-64";
+};
diff --git a/arch/arm/dts/sc598-som.dtsi b/arch/arm/dts/sc598-som.dtsi
new file mode 100644
index 0000000000..8bcc8bb8f1
--- /dev/null
+++ b/arch/arm/dts/sc598-som.dtsi
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+/dts-v1/;
+
+#include "sc5xx.dtsi"
+
+/ {
+	gic: interrupt-controller@31200000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x31200000 0x40000>, /* GIC Dist */
+		      <0x31240000 0x40000>; /* GICR */
+	};
+};
+
+&clk {
+	compatible = "adi,sc598-clocks";
+	reg = <0x3108d000 0x1000>,
+	      <0x3108e000 0x1000>,
+	      <0x3108f000 0x1000>,
+	      <0x310a9000 0x1000>;
+	reg-names = "cgu0", "cgu1", "cdu", "pll3";
+};
+
+&timer0 {
+	clocks = <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
+};

-- 
2.34.1


