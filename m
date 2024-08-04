Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8DAC3DA64
	for <u-boot@archiver.kernel.org>; Sun,  4 Aug 2024 15:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50B4E87A09;
	Sun,  4 Aug 2024 17:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zvgFfAad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24FAC87C69; Sun,  4 Aug 2024 17:10:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B891087876
 for <u-boot@lists.denx.de>; Sun,  4 Aug 2024 17:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=32c7=PE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1722784209;
 bh=C88K7UmnZvtJQewZMzgD7PX7wKtzQw6ZhhER/Hfxc8E=;
 b=zvgFfAad+f8HpG4HlUthwErLiUQmwRaz/t0ZugFXGCtgbUa46NnmfEt8OpkTYOtx+pu6lGgtP
 fpNmYDeJCsEe3tGXr5s6x0cWNzg4PZLSUtbBXdQdVoFsclLDc5slIqnI9qVL5AOFqHdqRKNVbOm
 P1uVI3yv5uI3q9b8H125Cz72nDsBDr8KpjWHdnJMRq/TNOmMdnXhwG+fbITo97CHr/sMtMPaJY6
 853kX4yWr5c1KMb5VRlV2Ic8H4jgCPPNRaGmVTaBMlNwcOReDhsW56HC09TUXjTZeSKweFbgoGN
 AGUDeuK1i9AB861FouNymbQwap/GxHZl3EnpJixtISdg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] serial: ns16550: Try get serial clock rate from DT before CLK
Date: Sun,  4 Aug 2024 15:09:52 +0000
Message-ID: <20240804150955.3521296-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66af99ceb04314fb234e332f
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

Initializing a clock driver to read a known static clock rate can take
some time at U-Boot proper pre-reloc phase.

Change to first try and read clock rate from DT to speed up boot time,
fall back to getting the clock rate from clock driver.

This help reduce boot time by around:
- ~35ms on a Radxa ROCK Pi 4 (RK3399)
- ~15ms on a Radxa ZERO 3W (RK3566)
Time that is wasted getting a static rate known at compile time.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/serial/ns16550.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 6fcb5b523acb..07f9ac00e113 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -565,19 +565,19 @@ int ns16550_serial_of_to_plat(struct udevice *dev)
 	plat->reg_shift = dev_read_u32_default(dev, "reg-shift", 0);
 	plat->reg_width = dev_read_u32_default(dev, "reg-io-width", 1);
 
-	err = clk_get_by_index(dev, 0, &clk);
-	if (!err) {
-		err = clk_get_rate(&clk);
-		if (!IS_ERR_VALUE(err))
-			plat->clock = err;
-	} else if (err != -ENOENT && err != -ENODEV && err != -ENOSYS) {
-		debug("ns16550 failed to get clock\n");
-		return err;
-	}
-
 	if (!plat->clock)
-		plat->clock = dev_read_u32_default(dev, "clock-frequency",
-						   CFG_SYS_NS16550_CLK);
+		plat->clock = dev_read_u32_default(dev, "clock-frequency", 0);
+	if (!plat->clock) {
+		err = clk_get_by_index(dev, 0, &clk);
+		if (!err) {
+			err = clk_get_rate(&clk);
+			if (!IS_ERR_VALUE(err))
+				plat->clock = err;
+		} else if (err != -ENOENT && err != -ENODEV && err != -ENOSYS) {
+			debug("ns16550 failed to get clock\n");
+			return err;
+		}
+	}
 	if (!plat->clock)
 		plat->clock = CFG_SYS_NS16550_CLK;
 	if (!plat->clock) {
-- 
2.45.2

