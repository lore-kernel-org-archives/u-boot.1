Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9372FC54E71
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E69E88B7F;
	Wed, 28 Aug 2024 12:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WWvAQ02m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EFC888AA7; Wed, 28 Aug 2024 12:12:30 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B9F88A92
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0259EA434DD;
 Wed, 28 Aug 2024 10:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64B11C4E673;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724839448;
 bh=FsDg2ciRwd9eoPssEW8BpY0SdC3k7lLgrnfi6L/U51Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=WWvAQ02mO2PpJvP31L+GTlWppHHXjTOU7zmbyKZWzkwOoadhnVQYFzcy6V1w3p5DF
 FqwpJqQsq9YDblfQmUKbaBQuSBP7PGAIcvCQDtBkfY94vbkK83emibQwx3qbYQePYW
 zhKuce7PKPbhO19VE5EuaNJ8n1w2Xl/Lfrhtl0JYkj/NFj2q2prmkITytM4GL7ks0K
 8tfOcwjuX93Y2ejsQarLSDKGIKvplrc13rSF4Ci7AOZFBey+yif2jqdu/nGNK0MmiH
 cp5C4RUsi2MOk6k19hjKqCcGwppYa0NxZdAa6hB/qRAk978icsz/s89bYgESdO/b3z
 /wZCFnIL/QW4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5077AC54E62;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Wed, 28 Aug 2024 11:02:10 +0100
Subject: [PATCH 02/20] arm: dts: Support SC584-EZKIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-sc5xx-upstreaming-patches-v1-2-44d9adfdf327@analog.com>
References: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
In-Reply-To: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724839434; l=2242;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=EoyEUlZv09rvrO+SsveRQ7V0mANa/r8vHcsllKcx6Po=;
 b=c1IgKImCz7G9JO3eERJ5NBEZSyyOER4gMn79VAJcoJhbt4w7yAPG0J3vX6EZX4lCaTfOM1zFQ
 81RsbAy6YZpByCbSNcapLTujgm8ycPxW1nGD6Hv2GGRut11FxYxHjrB
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
Co-developed-by: Trevor Woerner <twoerner@gmail.com>
Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 arch/arm/dts/Makefile        |  1 +
 arch/arm/dts/sc584-ezkit.dts | 13 +++++++++++++
 arch/arm/dts/sc58x.dtsi      | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 8fa56cc9f4..5b87c8972f 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1276,6 +1276,7 @@ dtb-$(CONFIG_TARGET_IMX8MM_CL_IOT_GATE_OPTEE) += imx8mm-cl-iot-gate-optee.dtb \
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


