Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C03C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 21:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E4680A55;
	Tue, 11 Feb 2025 22:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="u5ObXDw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC62780BAA; Tue, 11 Feb 2025 22:06:12 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA166809D0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 22:06:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id CF6FC1F8BC;
 Tue, 11 Feb 2025 22:06:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1739307969;
 bh=W0zEGS875Uby7dRejYb2T3PdcPWCnuVAmvv0wbV7fyg=; h=From:To:Subject;
 b=u5ObXDw+1OBcWbCMPcMOvGeqD1YhG+jVnP0UiUgU8HZPzQarmrTnqbH8b0GY1L6bs
 F0paOM8JJUTEind0+1sJEqndzdNlL6+IOOvF7y2Ccmlu7pVLsnVx2/w3Crit0X0eeP
 Ym4drIdTYVcJSHDNYGdMnJjwSDcMy10Mo2pPbj8gQAZ3yvbK84ZFjpoAS2TuhQ8gl7
 eCgWesTqX9VrVpBD7mf5g75/x3EMyZUbBQhzzOUujgQoCIcSq2+5U7/NxSPvkQQAIF
 OLuq6xbL77R5653QSGOoYuiMKHWgslAgsZDGAgwKW895EQn5vMrmt5WjGG4gO7MqhR
 NTMpHQ/4t7DDw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1] gpio: pca953x: support pcal6408 and pcal6416
Date: Tue, 11 Feb 2025 22:06:00 +0100
Message-Id: <20250211210600.277504-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add support to NXP GPIO expanders pcal6408, documented at [1], and
pcal6416, documented at [2].

[1] https://www.nxp.com/docs/en/data-sheet/PCAL6408A.pdf
[2] https://www.nxp.com/docs/en/data-sheet/PCAL6416A.pdf

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/gpio/pca953x_gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/pca953x_gpio.c b/drivers/gpio/pca953x_gpio.c
index e84038f312ea..523ca8473a8c 100644
--- a/drivers/gpio/pca953x_gpio.c
+++ b/drivers/gpio/pca953x_gpio.c
@@ -393,6 +393,8 @@ static const struct udevice_id pca953x_ids[] = {
 	{ .compatible = "nxp,pca9575", .data = OF_957X(16, PCA_INT), },
 	{ .compatible = "nxp,pca9698", .data = OF_953X(40, 0), },
 
+	{ .compatible = "nxp,pcal6408", .data = OF_953X(8, PCA_LATCH_INT), },
+	{ .compatible = "nxp,pcal6416", .data = OF_953X(16, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal6524", .data = OF_953X(24, PCA_LATCH_INT), },
 
 	{ .compatible = "maxim,max7310", .data = OF_953X(8, 0), },
-- 
2.39.5

