Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B7FCCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E4AB83914;
	Mon, 27 Oct 2025 17:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="es1sLfwU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="slld7zcG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1911583918; Mon, 27 Oct 2025 17:38:34 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A83838D5
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwK2H5bg1z9tNb;
 Mon, 27 Oct 2025 17:38:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tS17D8Yn/ztaMG+wl45SxSMIZ5hV4MaH60nPOZtoa2g=;
 b=es1sLfwUl1ybLICOwAw8TEpe6PSVgit+zZZsS+3UybmTlKi8xNTbd71l+tczzXlaRG74w9
 4CEOO3bLqIMcurblteoEuwuLQ6FXFkRFXApXtJjGfoLLlAW1L1LFD3eUJQkd5rFWBXfaUl
 55rpvD1oFnwwq98O6Cp1bx5dlL51dJa6idKaijunIibuScTUkhQzONxmka07IIJfABkhyn
 ZjWWAR0RaUdj0MKINQWFakeG5T5X+CujC0XSWKqkugroH00PpcPMCtPVQTMoO8/g6rSHXa
 /UHE01qwOmun0SGbANkRhMqNg7sI9TaAQxgiw6r0tY1uP2DMUfdaIFYpmGF8Pw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=slld7zcG;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tS17D8Yn/ztaMG+wl45SxSMIZ5hV4MaH60nPOZtoa2g=;
 b=slld7zcGzAaChptgG0ufKMEMNDZWlh+U2ZoMOsAs5Y0pQUaH8rpnHdx3qtdtv7iA1MvxiA
 uVq5ws1fXstQ5Vee6eKCLH4jiu4GCrZcUtZyCjJ80AyF2zSmLuV0sQ2dMcX/+NSNydYQq1
 xE0O2IzvyFIy1NhqwdFDoTD+oQqxUTEdqMK4Jlzz0uhlCgAdBJkqQzrVqmW7N/m1lyTeQh
 mebz+jDP8d//mRYeQFA5KsWmafMXGG8iflvEmqwG+UgfcrbiA1af/xUqCA534+tU2ojPmf
 4EhaxzwkHZjjIFuaqSeooOi8EgCVYzrFsajImSmHFSA3mw//09f1FKzKvXW0LQ==
To: u-boot@lists.denx.de
Cc: Minh Le <minh.le.aj@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] i2c: rcar_i2c: Add R-Car Gen5 support
Date: Mon, 27 Oct 2025 17:38:04 +0100
Message-ID: <20251027163826.11785-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gpym1s3k8ak9uayrhxqj5ojgahzz7n94
X-MBO-RS-ID: 4363589f099f102cc43
X-Rspamd-Queue-Id: 4cwK2H5bg1z9tNb
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

From: Minh Le <minh.le.aj@renesas.com>

Add support for R-Car Gen5 SoCs into the driver.
I2C on R-Car Gen5 is treated the same as Gen3 and Gen4.

Signed-off-by: Minh Le <minh.le.aj@renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # Tweak commit message
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Minh Le <minh.le.aj@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/i2c/rcar_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/rcar_i2c.c b/drivers/i2c/rcar_i2c.c
index 3bd5108fd23..9562119bb5b 100644
--- a/drivers/i2c/rcar_i2c.c
+++ b/drivers/i2c/rcar_i2c.c
@@ -368,6 +368,7 @@ static const struct udevice_id rcar_i2c_ids[] = {
 	{ .compatible = "renesas,rcar-gen2-i2c", .data = RCAR_I2C_TYPE_GEN2 },
 	{ .compatible = "renesas,rcar-gen3-i2c", .data = RCAR_I2C_TYPE_GEN3 },
 	{ .compatible = "renesas,rcar-gen4-i2c", .data = RCAR_I2C_TYPE_GEN3 },
+	{ .compatible = "renesas,rcar-gen5-i2c", .data = RCAR_I2C_TYPE_GEN3 },
 	{ }
 };
 
-- 
2.51.0

