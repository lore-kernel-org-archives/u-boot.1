Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7FFE7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 22:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA41C895E3;
	Sun,  8 Dec 2024 23:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dqqkL025";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Xs+xBOt8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC0C9893AE; Sun,  8 Dec 2024 23:06:29 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410F789500
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Y5zbl0GJyz9sjZ;
 Sun,  8 Dec 2024 23:06:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUhv6a/V4DQjGEOVPY/UsQrCZNoqp+dfDrt63JsigsE=;
 b=dqqkL025lhYJ0yAplnh9UeI2MbpAC022EPOdEYWePmi5GO5s2i0OahRab9zGaFht3lI9r+
 1tBIYy2Wnu/NKbumrguBJHCDxhyB4IPZ5hvRb2sO3RPCflouw54KKrFxYiF5fgEl+i7FLF
 9WzH74AeO64hLsjBKKzAJRDDjRxJa6fo9N1EZb2EBRbRx7nsFOM9thp3dlVzH8S0apQgb6
 BY/IbRccfP5gT/rjcLzECBejuXa7anCSAQStBt1ZpnZVTKeTFvQWx4mepnIiZcUOH5Wf/Q
 zYlfuJ9nyLFriLIKPeR9SZnjEabIUsPIij952toJh97BXHnebMUZaBbBZymS6A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUhv6a/V4DQjGEOVPY/UsQrCZNoqp+dfDrt63JsigsE=;
 b=Xs+xBOt8ZQCHrebFlVpsoeI5ujm6CKfG7spwBURSq6OO769dzKOY0bmHfez1igYvgTPbNX
 hgZaDsn4f192ju5B8XDzrqeAYXxsBdIjYq0SbsYiS+ApWwGYk0RmlwbRRNiIJ3/kpTdN3M
 AP1LHrp6jLNnqKPLlUWvFXtQtyOS0jedL81ri/SGoWv7imgZgzIlQHOwj1TXdep3QV3kDy
 VZBnA/NLdthHJbMNIhI6gjqx4C+kbWDLhJP4U2r1WlEM5HRQeMZYKemiomLfDj3/ldsXVZ
 l1CUNjkKNJSCd5t1A67ZVmUf9OtAMrWCTsKIoEV5kWuOO6nEmWVGSv6Q7IPTIg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/13] pinctrl: renesas: Fix R-Car spelling
Date: Sun,  8 Dec 2024 23:04:03 +0100
Message-ID: <20241208220551.204743-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
References: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dccb9f71ac6e2212807
X-MBO-RS-META: 1zfceia4yofm6r6rzko89ns79g71spfu
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

