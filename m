Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3685CCFB424
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 22:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7479A88875;
	Mon,  7 Oct 2024 00:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC398860B; Mon,  7 Oct 2024 00:22:32 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0E460889E1
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 00:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 024E8FEC;
 Sun,  6 Oct 2024 15:22:59 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 543933F73F;
 Sun,  6 Oct 2024 15:22:28 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev
Subject: [PATCH] clk: sunxi: a80: Fix reset description
Date: Sun,  6 Oct 2024 23:21:48 +0100
Message-ID: <20241006222148.16456-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
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

Clock gates and reset lines share a common structure in the sunxi clock
driver descriptions, but use different flags to tell them apart.

The description of the Allwinner A80 MMC clock reset lines was
erroneously using the "GATE" macro, which made the reset driver ignore
that entry, complaining with:
sunxi_set_reset: (RST-reset:#0) unhandled

Change that to the correct "RESET" macro, to make the reset driver
happy.

Fixes e0c7ce7e52b7 ("sunxi: clk: A80: add MMC clock support")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi/clk_a80.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi/clk_a80.c b/drivers/clk/sunxi/clk_a80.c
index e26d42a5e71..4e37fa39986 100644
--- a/drivers/clk/sunxi/clk_a80.c
+++ b/drivers/clk/sunxi/clk_a80.c
@@ -77,10 +77,10 @@ static const struct ccu_clk_gate a80_mmc_gates[] = {
 };
 
 static const struct ccu_reset a80_mmc_resets[] = {
-	[0]			= GATE(0x0, BIT(18)),
-	[1]			= GATE(0x4, BIT(18)),
-	[2]			= GATE(0x8, BIT(18)),
-	[3]			= GATE(0xc, BIT(18)),
+	[0]			= RESET(0x0, BIT(18)),
+	[1]			= RESET(0x4, BIT(18)),
+	[2]			= RESET(0x8, BIT(18)),
+	[3]			= RESET(0xc, BIT(18)),
 };
 
 static const struct ccu_clk_gate a80_usb_gates[] = {
-- 
2.46.2

