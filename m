Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFC6105D986
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 22:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C03F1840BE;
	Wed,  8 Apr 2026 00:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="krm/eiVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3E0B84129; Wed,  8 Apr 2026 00:35:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 05AEF80398
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 00:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44E0A3549;
 Tue,  7 Apr 2026 15:34:54 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 C5D8C3F632; Tue,  7 Apr 2026 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775601300; bh=c9zy5O2WPAHs1EpAo/D3JPndFAwUuQbakGizB9QGLl4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=krm/eiVarYpXPye+fKTVhe5K0LKbcMAqZ76HQNoQV1YUQFZBfBdp/Wvx1vPzEILLE
 Sf0scpcN0RRR6qx8NCdDCZyideKe/+CPBXEvansDZdwMSj7sWCdV6HBfMnuvR0aj+V
 r3MfmLe85rZs/MTzPOuvZ/GiQ8KMTrcn39Ljhshg=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>, linux-sunxi@lists.linux.dev
Subject: [PATCH 1/3] sunxi: spl: fix SPL_SUNXI_LED active low configuration
Date: Wed,  8 Apr 2026 00:34:45 +0200
Message-ID: <20260407223447.4956-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20260407223447.4956-1-andre.przywara@arm.com>
References: <20260407223447.4956-1-andre.przywara@arm.com>
MIME-Version: 1.0
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

The newly introduced Allwinner SPL LED "framework" defined a
SPL_SUNXI_LED_STATUS_STATE Kconfig symbol, that was supposed to denote
the active-low vs. active-high polarity of the LED. However this is
a bool symbol, so it will simply vanish if not defined, and we cannot use
it directly inside a C statement.

Filter the symbol through the IS_ENABLED() macro, which will return 0 if
the symbol is not defined, which is the intended value here.

This fixes configuring LEDs with active-low polarity.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 board/sunxi/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index d7722d1858a..80dcae9c1a4 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -563,7 +563,7 @@ static void sunxi_spl_store_dram_size(phys_addr_t dram_size)
 static void status_led_init(void)
 {
 #if CONFIG_IS_ENABLED(SUNXI_LED_STATUS)
-	unsigned int state = CONFIG_SPL_SUNXI_LED_STATUS_STATE;
+	unsigned int state = IS_ENABLED(CONFIG_SPL_SUNXI_LED_STATUS_STATE);
 	unsigned int gpio = CONFIG_SPL_SUNXI_LED_STATUS_BIT;
 
 	gpio_request(gpio, "gpio_led");
-- 
2.46.4

