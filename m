Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0854EED615
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 15:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66BCA88FCF;
	Thu, 12 Sep 2024 17:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nByzAHYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA2989013; Thu, 12 Sep 2024 17:51:19 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5394F89015
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 29219A456FA;
 Thu, 12 Sep 2024 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60C5FC4CED2;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726156274;
 bh=3xaZe0R4KOw2yuSwrD2qoGmQvkRpDtsDgU/yFsZ11U0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=nByzAHYDyIxXJD1xroOa9/X1fekil9pbvwddBKda0ZM1plPwuGa9ne+EU0NtAgHZM
 XjFgeG+B+KmZH1MJ5mSoZ8RaTSrGl0b7/bSskgE997mu7YgQlmyjxSNoHxelMc6IL1
 6BJfvE5syyziR3xSDuqIriZQeVxY1sSWR338W9HfNmYc/beLBYf32AUSnCaC1Is6xi
 CqpOME6SGGIMeX0GtstjGewYY+k+Nmj//3Uix28ARFIno46BEEa8G6pPIHGm82Z4F9
 UGlPLyR5Z6eFDsAOUeSgCv8XcgNaLigXKPueawLvSI2TpRuAPQF+l8YL+LLzogB5Qi
 SVOkTrYCMs8OQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 58E5EEED618;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Thu, 12 Sep 2024 16:50:47 +0100
Subject: [PATCH v2 06/20] arm: dts: Support SC594-SOM-EZLITE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-sc5xx-upstreaming-patches-v2-6-1185a80df79e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726156261; l=1676;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=EOGKrLN34VGPZVPLtrZGatsYePkJhtF2kzJugCc4/4M=;
 b=E/fQGsu4xXYE6ehF+3gr2eY7+b48fJDxQCSWA3qUQbM/BbFU7FNVamfQlHU7bzYuM/YHOhTGH
 D0IkldF3ayCDiLfPGrCaOPo4OCH9mr6p4Bvikp6vDWUQV+HgTnmtWAb
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

Add minimal device tree for Analog Devices' SC594-SOM-EZLITE board.

This patch depends on Patches 01 and 05, for sc5xx.dtsi and
sc594-som.dtsi respectively.

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 arch/arm/dts/Makefile             |  1 +
 arch/arm/dts/sc594-som-ezlite.dts | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index a56867b3de..7a1dd24838 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1263,6 +1263,7 @@ dtb-$(CONFIG_TARGET_SC584_EZKIT) += sc584-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC589_MINI) += sc589-mini.dtb
 dtb-$(CONFIG_TARGET_SC589_EZKIT) += sc589-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC594_SOM_EZKIT) += sc594-som-ezkit.dtb
+dtb-$(CONFIG_TARGET_SC594_SOM_EZLITE) += sc594-som-ezlite.dtb
 
 ifneq ($(CONFIG_TARGET_IMX8MP_RSB3720A1_4G)$(CONFIG_TARGET_IMX8MP_RSB3720A1_6G),)
 dtb-y += imx8mp-rsb3720-a1.dtb
diff --git a/arch/arm/dts/sc594-som-ezlite.dts b/arch/arm/dts/sc594-som-ezlite.dts
new file mode 100644
index 0000000000..7d81b40fe8
--- /dev/null
+++ b/arch/arm/dts/sc594-som-ezlite.dts
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
+	model = "ADI SC594-SOM-EZLITE";
+	compatible = "adi,sc594-som-ezlite", "adi,sc59x";
+};

-- 
2.34.1


