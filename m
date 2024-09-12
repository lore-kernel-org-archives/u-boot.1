Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE22AEED615
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 15:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7034389041;
	Thu, 12 Sep 2024 17:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EtX3BiQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 662C889041; Thu, 12 Sep 2024 17:51:19 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900EA88FD9
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D21ADA456F5;
 Thu, 12 Sep 2024 15:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14F71C4CEC6;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726156274;
 bh=WGHxPvwpb4gRW7heAnl/tM8+yJhsctTwMg4a2SzZboI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=EtX3BiQtDGAZyuy74YOaxRffagvaw8a48/KZFZo6at1W5bNbC4nj0tAyVUDT34Bdl
 2EN/Ays2XbBtQhVTPKVWogIYUJLNPsg+ZLZF2OfnvT1GrAzz8D5HaiUDGrSkbMe35H
 pDI4M6Rr8h2cVU+m+5/o7Xxiv9avyU0AOk2LaYqIf6DJcsra1j+s7prrPqmGEqQExL
 Ngprxv4C6kYlwSlpUUIF7N+qIsZJxb7d74u+oiuvgfGPwl7fWtBdn0kXp9f6w9jOmF
 w4x7Y07YD6dLU3Ak7iknFGh0X4HHvr6sc8kTYWi7fZphW5vlYa9UjehA0TLlvLSFQo
 EiHhxxE6B9Qmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFD2EED618;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Thu, 12 Sep 2024 16:50:43 +0100
Subject: [PATCH v2 02/20] arm: dts: Support SC584-EZKIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-sc5xx-upstreaming-patches-v2-2-1185a80df79e@analog.com>
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
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Trevor Woerner <twoerner@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726156261; l=2418;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=Kjbf4HiTqSZvX7MRaVYHu8DVn06cr3aVpH6PlAozzHc=;
 b=7gtB7QDomH9++6LMP9YpsLP1Bw/2RdW5UGxEspR1uioGn9w70xCZUqq4WmJMOgOFnSNdQobIx
 M/MWKz2iKooD4793J20YbIZyvJu0XBtBRiDhYfTmu4muV/aGowlOFVP
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

Add minimal device tree for Analog Devices' SC584-EZKIT board, and
common files for the SC58x family.

This patch depends on Patch 01, for sc5xx.dtsi.

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Trevor Woerner <twoerner@gmail.com>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 arch/arm/dts/Makefile        |  1 +
 arch/arm/dts/sc584-ezkit.dts | 13 +++++++++++++
 arch/arm/dts/sc58x.dtsi      | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d2194908d9..c827b5b4a4 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1259,6 +1259,7 @@ dtb-$(CONFIG_TARGET_IMX8MM_CL_IOT_GATE_OPTEE) += imx8mm-cl-iot-gate-optee.dtb \
 					imx8mm-cl-iot-gate-ied-tpm1.dtbo
 
 dtb-$(CONFIG_TARGET_SC573_EZKIT) += sc573-ezkit.dtb
+dtb-$(CONFIG_TARGET_SC584_EZKIT) += sc584-ezkit.dtb
 
 ifneq ($(CONFIG_TARGET_IMX8MP_RSB3720A1_4G)$(CONFIG_TARGET_IMX8MP_RSB3720A1_6G),)
 dtb-y += imx8mp-rsb3720-a1.dtb
diff --git a/arch/arm/dts/sc584-ezkit.dts b/arch/arm/dts/sc584-ezkit.dts
new file mode 100644
index 0000000000..4ec6bcfb65
--- /dev/null
+++ b/arch/arm/dts/sc584-ezkit.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+/dts-v1/;
+
+#include "sc58x.dtsi"
+
+/ {
+	model = "ADI SC584-EZKIT";
+	compatible = "adi,sc584-ezkit", "adi,sc58x";
+};
diff --git a/arch/arm/dts/sc58x.dtsi b/arch/arm/dts/sc58x.dtsi
new file mode 100644
index 0000000000..66145315ab
--- /dev/null
+++ b/arch/arm/dts/sc58x.dtsi
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+#include "sc5xx.dtsi"
+
+/ {
+	gic: interrupt-controller@310b2000 {
+		compatible = "arm,cortex-a5-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x310B2000 0x1000>,
+		      <0x310B4000 0x100>;
+	};
+};
+
+&timer0 {
+	reg = <0x31001004 0x100>,
+	      <0x31001060 0x100>;
+	clocks = <&clk ADSP_SC58X_CLK_CGU0_SCLK0>;
+};

-- 
2.34.1


