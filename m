Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0E7CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D19383771;
	Mon, 27 Oct 2025 17:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KJeBUXFJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NuagKOsk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B04E283826; Mon, 27 Oct 2025 17:33:56 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 384E083700
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwJwx1PJwz9sc8;
 Mon, 27 Oct 2025 17:33:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761582833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8me5lGJSbXMSm0sIPhWtQWGnRHNcgbALvUej02Q2Wqk=;
 b=KJeBUXFJKj9OEkQdZz7OfEiDOWmy4H4+Eg+HTO8xf1p3L4fDfJBTj4B3cUsEqRC91gki00
 nkRVpVJN2y4d7fuBaGitly/rK5MOxHWuZnfUF3zj4Crx3SXg+Sd3TV37A016ngrysJhN8n
 oe9spZmOlzzn32ocCbc5BMcZMx+dCZjWBCSiqvPLF18TKTR/yIGTRKeLdZN7smvGd1P1sC
 23cGGneQkCGWhNcLCTpSIRR0wUTQ+bGDxAuFGEyiZr7y6ehTBmHGyS4aoIuuby9qTKpuYs
 gCmpJ5ykBL1YT5umZlR+zC9FvLKdn7rXNbhnXbA+Fe9ZDVMyiVzVDfPRGQLQMQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761582831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8me5lGJSbXMSm0sIPhWtQWGnRHNcgbALvUej02Q2Wqk=;
 b=NuagKOskVwqCJ4+92sWNj6HoXTqhYVJSD5nZ/ivw7XhFxvbvxB6ydbZd01SP9Qe3s6/n6A
 5zPz625sfp0H3fBx7gmWs5Ci6HYizUWItHjkGatshLfPbzP3gi8+g0zqkyKCgqEg2ekqI1
 lVY50ZNOQEtsBbRxAEUtxhJfAX5ETEZZcHg4mLYNSjzTdgdtU8pAxuFPjMY4G5KYmBUENg
 bKttQ+t7W9BtHWF4Y1w6rN4eBJ38LtTEIgiK+cmYLZ0zWpAKZItFeSMlGQVZ7nc9MP1zdc
 VKA3OlSdn/GW7rcO0/BuSDDOZhh79JL8SAYS1K8ic32YqCsUxJMVUDNu3s/wpA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] clk: renesas: Isolate R-Car Gen3 driver to Gen3,
 Gen4 and RZ/G2L
Date: Mon, 27 Oct 2025 17:33:29 +0100
Message-ID: <20251027163348.11065-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: iuagsxtkf6yxawzafujtqd5tqzikq6uh
X-MBO-RS-ID: da14c8aa70d414cb9b0
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

Isolate Renesas R-Car Gen3 clock driver to R-Car Gen3 and Gen4 and RZ/G2L.
The Renesas R-Car Gen5 uses SCMI clock protocol driver instead. This is
a preparatory change for R-Car Gen5. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/renesas/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 12966d02a22..51c87cc3606 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -51,8 +51,8 @@ config CLK_R8A7794
 	  Enable this to support the clocks on Renesas R8A7794 SoC.
 
 config CLK_RCAR_GEN3
-	bool "Renesas R-Car Gen3 and Gen4 clock driver"
-	def_bool y if RCAR_64
+	bool "Renesas R-Car Gen3, Gen4, RZ/G2L clock driver"
+	def_bool y if RCAR_GEN3 || RCAR_GEN4 || RZG2L
 	depends on CLK_RENESAS
 	select CLK_RCAR
 	select CLK_RCAR_CPG_LIB
-- 
2.51.0

