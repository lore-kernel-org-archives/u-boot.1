Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4695C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC833877EF;
	Tue, 12 Dec 2023 17:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="O/r5dRmR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C1A687495; Tue, 12 Dec 2023 17:04:46 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A694871DE
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from adahl by ada.ifak-system.com with local (Exim 4.94.2)
 (envelope-from <ada@thorsis.com>)
 id 1rD5FA-000BXK-4p; Tue, 12 Dec 2023 17:04:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1702397079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Z0RH5WiZPkIGWQLeqRFfKsRQv0AiHlFRW2kItKc4+k=;
 b=O/r5dRmREqMtcVt4XIczna3U4ke2Gd9ifm8tuonqxReUeMiU5KmW2zRu4EmzTZlY8sw6GL
 dfrhOnll9sogUWwLwh0ZygcoK/yh8uSpHyesi/DwKumvH+pX8cy/ku1yOunww8uIpCR/Po
 CKDC9LkKnnRg5oTB6AlqFxTRby9pLJUmKwFTwQw+e1O2ud8waQRuzft1W9BInrtgkkerk9
 0k5w0eSVy1Y2G8t07tDPqPEMZtWmspOf7lrhfE6M4DnAeyfiSxAmeHQuXwGEqKo4PqJ436
 M9wm1ajWsV2of8d0mBcnAjjIGXNx4qLqcSzrUtBRptuyyGaL7yRUWg766urpWA==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de, Eugen Hristev <eugen.hristev@collabora.com>,
 Wenyou Yang <wenyou.yang@microchip.com>
Subject: [PATCH 1/4] ARM: dts: at91: sama5d2: Move sfr node
Date: Tue, 12 Dec 2023 17:04:20 +0100
Message-Id: <20231212160423.44290-2-ada@thorsis.com>
In-Reply-To: <20231212160423.44290-1-ada@thorsis.com>
References: <20231212160423.44290-1-ada@thorsis.com>
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

Nodes are ordered by register offset.

Fixes: 56246d1e8705 ("ARM: dts: at91: sama5: Add the sfr node")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 arch/arm/dts/sama5d2.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/sama5d2.dtsi b/arch/arm/dts/sama5d2.dtsi
index 819564fdd5b..c28a544da6f 100644
--- a/arch/arm/dts/sama5d2.dtsi
+++ b/arch/arm/dts/sama5d2.dtsi
@@ -698,6 +698,11 @@
 				status = "disabled";
 			};
 
+			sfr: sfr@f8030000 {
+				compatible = "atmel,sama5d2-sfr", "syscon";
+				reg = <0xf8030000 0x98>;
+			};
+
 			rstc@f8048000 {
 				compatible = "atmel,sama5d3-rstc";
 				reg = <0xf8048000 0x10>;
@@ -726,11 +731,6 @@
 				status = "disabled";
 			};
 
-			sfr: sfr@f8030000 {
-				compatible = "atmel,sama5d2-sfr", "syscon";
-				reg = <0xf8030000 0x98>;
-			};
-
 			sckc@f8048050 {
 				compatible = "atmel,at91sam9x5-sckc";
 				reg = <0xf8048050 0x4>;
-- 
2.39.2

