Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2843C54E71
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5244688BCF;
	Wed, 28 Aug 2024 12:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XhHQfBaw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C8E988B63; Wed, 28 Aug 2024 12:12:34 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9035F88ADB
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 60DF1A434E4;
 Wed, 28 Aug 2024 10:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4DA8C4E679;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724839448;
 bh=NNank+2Dp8rElP96iDyYvfNRfmIedtNKf6SkN/eMynM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=XhHQfBaw/+RFMDQYCotREvrQOgifIdHC17ce3Qo/Kj3NF4uuz3If6iWT4beYiDxd3
 MHO98FY44BA/nDUuuo6UoR8qDaWN6lLXR0vm5H+tDh4WSY6w1QDQ6YRK57gDBDtpqR
 tP41w1R/cjHBv+1l+mgNkf0gIQ8aS6pvLe/a55iVd9hAFIvzsIc6xsFsx3qf8z3jmN
 Cle2eMCGwVwmeOZDSaN303TbadoSu0d/oWixvvby6xBKYjHzE2U5p3/KjMe5HUS6Jx
 Bky1gvUwqmiCPcS6C0VfEuM5Hg7toUWMEvmLyjtQps+1ZOaGa4fdC/KnezCag9BWuA
 ZkgkptKq2TuRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AC9BDC54E83;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Wed, 28 Aug 2024 11:02:16 +0100
Subject: [PATCH 08/20] arm: dts: Support SC598-SOM-EZLITE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-sc5xx-upstreaming-patches-v1-8-44d9adfdf327@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724839434; l=1575;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=M0uaWSxA8CaZN3Qnd9WlPh2aWgwwkP6PgJ7fqjzQrik=;
 b=ewMxmLrxKL+kdkaWh936UipYSGLfr5vFstj9MQDAdtG9YoXin4iJzaZf/4snyPYmGL5u1Vqsq
 /Bneoh5gtFUCnxCJ438Mau9SWv+1GvXsMV+qTNkAh6Op273xW3UB6LB
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

Add minimal device tree for Analog Devices' SC598-SOM-EZLITE board.

This patch depends on Patches 01 and 07, for sc5xx.dtsi and
sc598-som.dtsi respectively.

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 arch/arm/dts/Makefile             |  1 +
 arch/arm/dts/sc598-som-ezlite.dts | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 6b0a762bce..9395feeede 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1282,6 +1282,7 @@ dtb-$(CONFIG_TARGET_SC589_EZKIT) += sc589-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC594_SOM_EZKIT) += sc594-som-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC594_SOM_EZLITE) += sc594-som-ezlite.dtb
 dtb-$(CONFIG_TARGET_SC598_SOM_EZKIT) += sc598-som-ezkit.dtb
+dtb-$(CONFIG_TARGET_SC598_SOM_EZLITE) += sc598-som-ezlite.dtb
 
 ifneq ($(CONFIG_TARGET_IMX8MP_RSB3720A1_4G)$(CONFIG_TARGET_IMX8MP_RSB3720A1_6G),)
 dtb-y += imx8mp-rsb3720-a1.dtb
diff --git a/arch/arm/dts/sc598-som-ezlite.dts b/arch/arm/dts/sc598-som-ezlite.dts
new file mode 100644
index 0000000000..fa23b30f86
--- /dev/null
+++ b/arch/arm/dts/sc598-som-ezlite.dts
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
+	model = "ADI SC598-SOM-EZLITE";
+	compatible = "adi,sc598-som-ezlite", "adi,sc59x-64";
+};

-- 
2.34.1


