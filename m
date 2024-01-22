Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F04C47DD9
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 20:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD75D879B2;
	Mon, 22 Jan 2024 21:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mPU1mT2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78BE98792D; Mon, 22 Jan 2024 21:13:57 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A504087B44
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 21:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 37BE6B81133;
 Mon, 22 Jan 2024 20:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FF75C433F1;
 Mon, 22 Jan 2024 20:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705954434;
 bh=6sYGTjpuzuLQ6HfO0rAlXXMGNX2T9OcyivBH3FIIdpo=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=mPU1mT2yIEdDlIYiCdPN4oQMc8kfv1mkyQh2Mnlged85SUJTyBELlT5dvf/pEBAp4
 eAC5J3VTvW3rv16sn3mdom4iJZRh4MGAeOtrZGKP0WwrpWX+wUtytCrwyHQgyUyke7
 ZbEkw2fVmVJ6nSF/J/CUodJMp6k6LOYnxrQUOldScfEfHAQtRRN1MTOciVPygBNMR3
 r+YbydE8gba7rKsXraXxhxMnNAtiu+W8Kvxnonegca7JyLpLUDg5s7F73yGlsIZo8w
 39d+U1vhr87s4ZwKxVdSd4BObh5SFTqRK2SpuLFzbOF+NlrBgTaLAOV06aFcp7hwNB
 bK2yRjA1nXGzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5F2C47DD9;
 Mon, 22 Jan 2024 20:13:54 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 23 Jan 2024 04:13:52 +0800
Subject: [PATCH] serial: pl01x: set baudrate when probing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-b4-pl011-v1-1-fb576d0a714f@outlook.com>
X-B4-Tracking: v=1; b=H4sIAH/MrmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyNj3SQT3YIcA0ND3dRUS1Nz07Q0o0RjCyWg8oKi1LTMCrBR0bG1tQB
 fV1B5WgAAAA==
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>
Cc: Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705954432; l=1467;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=jw8To+ODKdNHWBou76VXfDtPPAkq6OFIkYy2gU13KU8=;
 b=8p9Dm3o/pbms9fV4ou//OSYQ0G3TlV7KWpjZLslP9+5tPgvgtNNgh+Abxw+HGGPp0Ic0Fp3l5
 052pue3ZYO3Ds1PCOvu4ccrK1xi8liBwltxjuxo3frF+GoCvFzQ0ajy
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

It is found that when DM is enabled, only generic init function is
called in .probe(). Baudrate is never honored. Add a function call
to .setbrg() when probing so that we can update the baudrate of the
serial device.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/serial/serial_pl01x.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/serial_pl01x.c b/drivers/serial/serial_pl01x.c
index 428a4d210d..57bbcaf3b6 100644
--- a/drivers/serial/serial_pl01x.c
+++ b/drivers/serial/serial_pl01x.c
@@ -290,6 +290,7 @@ int pl01x_serial_probe(struct udevice *dev)
 {
 	struct pl01x_serial_plat *plat = dev_get_plat(dev);
 	struct pl01x_priv *priv = dev_get_priv(dev);
+	int ret;
 
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 	struct dtd_serial_pl01x *dtplat = &plat->dtplat;
@@ -301,10 +302,14 @@ int pl01x_serial_probe(struct udevice *dev)
 #endif
 	priv->type = plat->type;
 
-	if (!plat->skip_init)
-		return pl01x_generic_serial_init(priv->regs, priv->type);
-	else
+	if (!plat->skip_init) {
+		ret = pl01x_generic_serial_init(priv->regs, priv->type);
+		if (!ret)
+			return ret;
+		return pl01x_serial_setbrg(dev, gd->baudrate);
+	} else {
 		return 0;
+	}
 }
 
 int pl01x_serial_getc(struct udevice *dev)

---
base-commit: f7cca7ccc5117eaafcc2bde91ad1bed6fee7cfc3
change-id: 20240123-b4-pl011-ee9575ff2a38

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

