Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B578CE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 07:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6D638027E;
	Wed, 11 Dec 2024 08:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="csDmlpZw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Xe9Hr6NP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8142D8031D; Wed, 11 Dec 2024 08:32:40 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58CDF80278
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Y7S46139Xz9scX;
 Wed, 11 Dec 2024 08:32:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JTQSpOe+RdO5/mn8zgE07CLX9ARfpY2zGYtiM/E28Ug=;
 b=csDmlpZwAZGY50AR/phhH7Qzxsb2h3U1/D9cRIQfl0K/AELBp6kD+yxjwH8+uy1EfDZ/tv
 B8KLJL7ZZd9wEx5tvC3QSVojgHnWilBUtbrTEhzErCBAhf9l2jR9txldc1cPF5A5buxkny
 8EqgA/21KMxKmaYNHUyyBK1/AHxtz/9mfpvhMwnQij8sp5xxWXOMZsZvo+Hg1IrxyvjrZP
 TOVstvr9PIx6BUVw4A8tp5tC67NMRywfyAKs5MQqnhFiE0EpaJbzttPH1u5rJ8jSaicMoV
 MktFXIvglMtawis0rHNJtTdMjQPCBFz9lZMQKwMn8R7px4CYt4LQb4Z0z0oaCw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JTQSpOe+RdO5/mn8zgE07CLX9ARfpY2zGYtiM/E28Ug=;
 b=Xe9Hr6NPg8Vf6QnYyDL0+Edv/9RNDgzSoHdHYq5lymz6bmFfuQ00ZsspqFAwZks+afxxaS
 /2W4Z6A0dF5+xQSO7kQAxQK3uccJ4eVuoTlCbwOQMJvq5Ro7oH3Pk3/oRMv7K6f31RXrpx
 YuRfcRyjZiKERyl3nFhsGKnP7apKBmMKCGP6ROSNcWah26WPFbJ5nUFsmSw3yYrzS7Xe7s
 W5b6jX9E3aoThGq9J2GZuZ9iOxMv/A/boOPw0+U+sW3evyVLGpjH/2YudFX4mx2cf0zEMq
 vASXGkKcFM9cQ0G7QA7HLtdhI3s6n98IeFzCuT9rIBKnv44/au9UAMuGNs1cUA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/13] pinctrl: renesas: Fix R-Car spelling
Date: Wed, 11 Dec 2024 08:30:34 +0100
Message-ID: <20241211073210.8087-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
References: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: b9yymbinb89k67y7kbkzaqcm98wi8umn
X-MBO-RS-ID: 6616c4637b0ab4dd9cc
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

The correct spelling is R-Car, including the dash, update the usage.
Kconfig strings and comment changes only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
---
 drivers/pinctrl/renesas/Kconfig | 68 ++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 57e88604aa2..a209193b332 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -12,34 +12,34 @@ config PINCTRL_PFC
 	  available multiplex function.
 
 config PINCTRL_PFC_R8A7790
-	bool "Renesas RCar Gen2 R8A7790 pin control driver"
+	bool "Renesas R-Car Gen2 R8A7790 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen2 R8A7790 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen2 R8A7790 SoCs.
 
 config PINCTRL_PFC_R8A7791
-	bool "Renesas RCar Gen2 R8A7791 pin control driver"
+	bool "Renesas R-Car Gen2 R8A7791 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen2 R8A7791 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen2 R8A7791 SoCs.
 
 config PINCTRL_PFC_R8A7792
-	bool "Renesas RCar Gen2 R8A7792 pin control driver"
+	bool "Renesas R-Car Gen2 R8A7792 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen2 R8A7792 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen2 R8A7792 SoCs.
 
 config PINCTRL_PFC_R8A7793
-	bool "Renesas RCar Gen2 R8A7793 pin control driver"
+	bool "Renesas R-Car Gen2 R8A7793 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen2 R8A7793 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen2 R8A7793 SoCs.
 
 config PINCTRL_PFC_R8A7794
-	bool "Renesas RCar Gen2 R8A7794 pin control driver"
+	bool "Renesas R-Car Gen2 R8A7794 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen2 R8A7794 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen2 R8A7794 SoCs.
 
 config PINCTRL_PFC_R8A774A1
         bool "Renesas RZ/G2 R8A774A1 pin control driver"
@@ -66,76 +66,76 @@ config PINCTRL_PFC_R8A774E1
           Support pin multiplexing control on Renesas RZ/G2H R8A774E1 SoCs.
 
 config PINCTRL_PFC_R8A77951
-	bool "Renesas RCar Gen3 R8A7795 pin control driver"
+	bool "Renesas R-Car Gen3 R8A7795 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen3 R8A7795 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen3 R8A7795 SoCs.
 
 config PINCTRL_PFC_R8A77960
-	bool "Renesas RCar Gen3 R8A77960 pin control driver"
+	bool "Renesas R-Car Gen3 R8A77960 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen3 R8A77960 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen3 R8A77960 SoCs.
 
 config PINCTRL_PFC_R8A77961
-	bool "Renesas RCar Gen3 R8A77961 pin control driver"
+	bool "Renesas R-Car Gen3 R8A77961 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen3 R8A77961 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen3 R8A77961 SoCs.
 
 config PINCTRL_PFC_R8A77965
-	bool "Renesas RCar Gen3 R8A77965 pin control driver"
+	bool "Renesas R-Car Gen3 R8A77965 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen3 R8A77965 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen3 R8A77965 SoCs.
 
 config PINCTRL_PFC_R8A77970
-	bool "Renesas RCar Gen3 R8A77970 pin control driver"
+	bool "Renesas R-Car Gen3 R8A77970 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen3 R8A77970 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen3 R8A77970 SoCs.
 
 config PINCTRL_PFC_R8A77980
-	bool "Renesas RCar Gen3 R8A77980 pin control driver"
+	bool "Renesas R-Car Gen3 R8A77980 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen3 R8A77980 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen3 R8A77980 SoCs.
 
 config PINCTRL_PFC_R8A77990
-	bool "Renesas RCar Gen3 R8A77990 pin control driver"
+	bool "Renesas R-Car Gen3 R8A77990 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen3 R8A77990 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen3 R8A77990 SoCs.
 
 config PINCTRL_PFC_R8A77995
-	bool "Renesas RCar Gen3 R8A77995 pin control driver"
+	bool "Renesas R-Car Gen3 R8A77995 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen3 R8A77995 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen3 R8A77995 SoCs.
 
 config PINCTRL_PFC_R8A779A0
-	bool "Renesas RCar Gen3 R8A779A0 pin control driver"
+	bool "Renesas R-Car Gen3 R8A779A0 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen3 R8A779A0 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen3 R8A779A0 SoCs.
 
 config PINCTRL_PFC_R8A779F0
-	bool "Renesas RCar Gen4 R8A779F0 pin control driver"
+	bool "Renesas R-Car Gen4 R8A779F0 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen4 R8A779F0 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen4 R8A779F0 SoCs.
 
 config PINCTRL_PFC_R8A779G0
-	bool "Renesas RCar Gen4 R8A779G0 pin control driver"
+	bool "Renesas R-Car Gen4 R8A779G0 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen4 R8A779G0 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen4 R8A779G0 SoCs.
 
 config PINCTRL_PFC_R8A779H0
-	bool "Renesas RCar Gen4 R8A779H0 pin control driver"
+	bool "Renesas R-Car Gen4 R8A779H0 pin control driver"
 	depends on PINCTRL_PFC
 	help
-	  Support pin multiplexing control on Renesas RCar Gen4 R8A779H0 SoCs.
+	  Support pin multiplexing control on Renesas R-Car Gen4 R8A779H0 SoCs.
 
 config PINCTRL_RZA1
 	bool "Renesas RZ/A1 R7S72100 pin control driver"
-- 
2.45.2

