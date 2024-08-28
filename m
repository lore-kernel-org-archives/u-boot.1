Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE30CC54E92
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12A8F88B67;
	Wed, 28 Aug 2024 12:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YoLj2a/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A65888874; Wed, 28 Aug 2024 12:12:30 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F400388A8E
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 02551A4347F;
 Wed, 28 Aug 2024 10:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A774C4E677;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724839448;
 bh=/kkI339A5F/et4twAWjGRQEKz7jNaxW0tmv7IihHsHY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=YoLj2a/kSWCGDUt0xDWfEeOAackhEY1q9OHB6W7AQazlx1/xUWCC3+ERWU0JNPbFu
 z/PNJwE69yHGo0m8hsgr1SD0RRMPyNqsAhLsQixR1eSOnT3DlKiB7HsZ2PSeqwjK28
 Um48Lki6PgIZ/1oGPon2bjea3lm4O5K2wlk+bex4mLu0rukO7pDQIpnzjY+c9PYh/S
 MsRtiR9bZPRWmwHdmziRYsQ+hRXWV6W/B5proOwgmIy4d1o1SR/pgvKbpabjKcifWf
 kucZuHL2x4uk0zgqi1Zj7LwcFlFeGT4Xv6eLQBXNhAnp2hWmQDmxOpemWPqDLNuuRL
 fGtorwpGHfV3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8F26AC5474B;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Wed, 28 Aug 2024 11:02:14 +0100
Subject: [PATCH 06/20] arm: dts: Support SC594-SOM-EZLITE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-sc5xx-upstreaming-patches-v1-6-44d9adfdf327@analog.com>
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
 Oliver Gaskell <Oliver.Gaskell@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724839434; l=1552;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=sJ3AA+4nNO2X/f+kxcLmNn3Q/1Jkk6MkZMvzHfkwRqY=;
 b=4nXyiA3VmXauVGXJevpjlE3I5mNRK/MphNbIM5z7QCb1KPK9IoV4fup7zmmmnMGnuAewPtNr4
 MXsCOUpX78bAHqZAcZFrsCDPkuBgmz8vB2BS8p4yR4YTXbVO16SkKq1
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
Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 arch/arm/dts/Makefile             |  1 +
 arch/arm/dts/sc594-som-ezlite.dts | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 25c236039b..0c9984232b 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1280,6 +1280,7 @@ dtb-$(CONFIG_TARGET_SC584_EZKIT) += sc584-ezkit.dtb
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


