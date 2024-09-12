Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497A2EED615
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 15:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A0B89051;
	Thu, 12 Sep 2024 17:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RlwOgR4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F73189013; Thu, 12 Sep 2024 17:51:19 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC14889011
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 18017A456F9;
 Thu, 12 Sep 2024 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43047C4CECF;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726156274;
 bh=V4fHAkKLd+ko4QIQ5dy2w6zAfbTbF/vNvLDTq0Ibm2g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=RlwOgR4NT0oop5Kdb5OS9saka2N7SPMm4or4sY37e+hpcZYzJlb9/hsesM25Tm5RD
 vN33zTNzmvGI6EArjp5jKMDB3b7wyd6s0WyfhFQpoQC2cd8h3QgJG39vaADIsCXsHG
 bmltGTniofMVPbaXwcV+jgoKjYi4WJ6vvqrxhUkul6bS9megDWenQMG4hfXCFmy2IV
 eJgCrpfYyFtcOUE2ufV7h0+heR1fufUBReZyOHe4sT1oB2M1mZ81gRJ9V8h/okbJcv
 rw8h2SLRLtdXi1vJQ6S0N9jM2zGjv+ftM+02nYRHd2/NGNr75mI8qXVsBaF/Y/EQ4H
 khnMznvhUEbwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3E231EED617;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Thu, 12 Sep 2024 16:50:46 +0100
Subject: [PATCH v2 05/20] arm: dts: Support SC594-SOM-EZKIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-sc5xx-upstreaming-patches-v2-5-1185a80df79e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726156261; l=2244;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=1kRWEBIFLXtQAQofIH7BuZdi6n1lwELAFIButun56do=;
 b=E89LPaT8tIgkXYZZmT3LPI5WKhqTQK1Hna0Mgnd7jj3NhyPwcMsnlC5WCFa+OIEOsdPEsiTXX
 M4p1XFOmpiNDeSIdqFYxkrglxRryAVonsDGxx1FFrMqB//Ba8KPcxou
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

Add minimal device tree for Analog Devices' SC594-SOM-EZKIT board, and
the SC594 SoM.

This patch depends on patch 01, for sc5xx.dtsi.

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 arch/arm/dts/Makefile            |  1 +
 arch/arm/dts/sc594-som-ezkit.dts | 13 +++++++++++++
 arch/arm/dts/sc594-som.dtsi      | 19 +++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index a1484c1eee..a56867b3de 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1262,6 +1262,7 @@ dtb-$(CONFIG_TARGET_SC573_EZKIT) += sc573-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC584_EZKIT) += sc584-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC589_MINI) += sc589-mini.dtb
 dtb-$(CONFIG_TARGET_SC589_EZKIT) += sc589-ezkit.dtb
+dtb-$(CONFIG_TARGET_SC594_SOM_EZKIT) += sc594-som-ezkit.dtb
 
 ifneq ($(CONFIG_TARGET_IMX8MP_RSB3720A1_4G)$(CONFIG_TARGET_IMX8MP_RSB3720A1_6G),)
 dtb-y += imx8mp-rsb3720-a1.dtb
diff --git a/arch/arm/dts/sc594-som-ezkit.dts b/arch/arm/dts/sc594-som-ezkit.dts
new file mode 100644
index 0000000000..e744a3a4ed
--- /dev/null
+++ b/arch/arm/dts/sc594-som-ezkit.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+/dts-v1/;
+
+#include "sc594-som.dtsi"
+
+/ {
+	model = "ADI SC594-SOM-EZKIT";
+	compatible = "adi,sc594-som-ezkit", "adi,sc59x";
+};
diff --git a/arch/arm/dts/sc594-som.dtsi b/arch/arm/dts/sc594-som.dtsi
new file mode 100644
index 0000000000..e15473f8e8
--- /dev/null
+++ b/arch/arm/dts/sc594-som.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+/dts-v1/;
+
+#include "sc5xx.dtsi"
+
+&timer0 {
+	clocks = <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
+};
+
+&clk {
+	compatible = "adi,sc594-clocks";
+	reg = <0x3108d000 0x1000>,
+	      <0x3108e000 0x1000>,
+	      <0x3108f000 0x1000>;
+};

-- 
2.34.1


