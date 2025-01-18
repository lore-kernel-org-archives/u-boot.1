Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888D3C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 04:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 009B980763;
	Sat, 18 Jan 2025 05:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KSMHviur";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cS1Z9Mcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3AE980793; Sat, 18 Jan 2025 05:02:17 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6815180786
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZjbp67cBz9tDY;
 Sat, 18 Jan 2025 05:02:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rq3JyGoUPbzg82zrqA06j7BKI/miKmJnMOnLgCax7WU=;
 b=KSMHviurwtn2uOEURWeXfohFN+j2s8NPoq8XVXVfMGP6HF8k52ornO9YbTedf9qSpdSQO2
 SBpPlpWnSwFuy8Znrj/yDeFUxcsprLMtiV3+hXz6IW5m+T5qO/EB7gP/2JPd+t+u6hnLgd
 TmFoYQ4l4C36oHYMCyp1kTnqVR0rEzrRRmuwElGygN4ZgbFKWglwwH9tB/Xx+eTSa6jwl0
 yzuSQZcMoLDn5vCMDOgYDv+fGgBQ4adreK//cOJfHboysVbxGlUk2hYZs/H4I2u10y/Y/L
 5gUb8Uk6dN7jNPrsV6r8ZqTCPg/mrYiFt7oQ1fnC5I5xgyCmWkJkgdlYKE+0RA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rq3JyGoUPbzg82zrqA06j7BKI/miKmJnMOnLgCax7WU=;
 b=cS1Z9McbgxmBZeo7VXI1ZWqpn8vLNMHnWBWuaoHOKPfrb+CA0qFWcZ3m/tn9+um3VF05OL
 WDNpnm7/4o5bt9+OFyInlNCvOqKRJmv+OFZEToAT7MGj4EUbNWKIP/NpwO7Nbqh4SUJd3A
 uptVRuunB5BsRHIQ2ozv9JajcnxAmXydV8kfZOX+BiYQgr0hGY/fj6k7YqJ0OM198aCrDw
 N0H8hjeO6Xma9ThjwAFLP7WA4xvJI9OVZSXXe9ZLDULojnhHEoCyyYSSDaeCHqeUx/KIEg
 /eQMTen7IKui3weBN4rD0StzqFaiDICMoAl47udDZWloc2VfIgLLWoyPXA9dgg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aaron Williams <awilliams@marvell.com>, Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/8] mips: octeon: nic23: Handle return value from
 cyclic_register()
Date: Sat, 18 Jan 2025 05:00:58 +0100
Message-ID: <20250118040130.74921-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
References: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: p9c6pz7xqkjuu4arozxqxb95rozq3a4i
X-MBO-RS-ID: d74e7c04168be225463
X-Rspamd-Queue-Id: 4YZjbp67cBz9tDY
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

Handle the error code returned by cyclic_register(). Report the error,
but do not return it from board_late_init() as that would make the
board not boot, which is undesired. Let the board boot somehow, so
the user can fix the problem, even if the cyclic callback is not
usable.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aaron Williams <awilliams@marvell.com>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Devarsh Thakkar <devarsht@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Ronald Wahl <ronald.wahl@legrand.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/Marvell/octeon_nic23/board.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/board/Marvell/octeon_nic23/board.c b/board/Marvell/octeon_nic23/board.c
index cf20c97684a..5d1bf15ed50 100644
--- a/board/Marvell/octeon_nic23/board.c
+++ b/board/Marvell/octeon_nic23/board.c
@@ -341,6 +341,7 @@ int board_late_init(void)
 	struct cyclic_info *cyclic;
 	struct gpio_desc gpio = {};
 	ofnode node;
+	int ret;
 
 	/* Turn on SFP+ transmitters */
 	ofnode_for_each_compatible_node(node, "ethernet,sfp-slot") {
@@ -358,13 +359,18 @@ int board_late_init(void)
 
 	/* Register cyclic function for PCIe FLR fixup */
 	cyclic = calloc(1, sizeof(*cyclic));
-	if (cyclic) {
-		cyclic_register(cyclic, octeon_board_restore_pf, 100,
-				"pcie_flr_fix");
-	} else {
-		printf("Registering of cyclic function failed\n");
+	if (!cyclic) {
+		printf("Registering of cyclic function failed, ENOMEM\n");
+		/* Do not exit with error code, let the board boot somehow. */
+		return 0;
 	}
 
+	ret = cyclic_register(cyclic, octeon_board_restore_pf, 100,
+			      "pcie_flr_fix");
+	/* Do not exit with error code, let the board boot somehow. */
+	if (ret)
+		printf("Registering of cyclic function failed, %d\n", ret);
+
 	return 0;
 }
 
-- 
2.45.2

