Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B551C54E49
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 00:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A6A87C77;
	Sun, 25 Feb 2024 01:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bapfFk+N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DC2787D16; Sun, 25 Feb 2024 01:38:38 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2323A87C77
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 01:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E03A5CE0B4E;
 Sun, 25 Feb 2024 00:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02585C433C7;
 Sun, 25 Feb 2024 00:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708821512;
 bh=QH4F59ftRchpY1AJN5ENbRCHNlozx+PPUrvEAbf8Fsc=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=bapfFk+NQzx0UpDNLaqIrvNDtCd+rSJjExOr5B8lEyxuBL54gS9ZTrzRguzEnSB/W
 hz1zhuI0hxNc8xqHgOnMapekpdX33K5SaAJsjBIFCY3EAUVyAEnKnAPZGNUkL/44g3
 0ypEMpjgQYKYq+XHy4UNXTmMDt/XvTe31oUHi+8f7w51un0iNtyUho+FEDnIeUuZu2
 czYKtVs1QpB6PHZhakujYmzYCqzLgk6weLnGEAGGdZ7t+2s7S01EDOOb7QZeUsss3r
 4I7gth5A36oZijX06VExqLRQIGTDaPtnO4xlsVxII2V7PEKNIAZc8/lW+j0nSdCw5H
 oFdwOHBQKOdog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E3D1DC48BF6;
 Sun, 25 Feb 2024 00:38:31 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 25 Feb 2024 08:38:33 +0800
Subject: [PATCH RESEND] serial: pl01x: set baudrate when probing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-b4-pl011-v1-1-2686496c1a17@outlook.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>
Cc: Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708821513; l=1471;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=wFtp8JoYVTLrWd010MWe1rn493w7ENxVoxhvFpDp7q4=;
 b=mwg1kme2Jf0rKcyD0nWu9RqFoZOcw6JZjDRrZdKP1EaqOTJGuQeq3ljfDarZSq/1qBsBKAHJd
 gU3LTYFIXs+DRCczgB04wlQOLdHzn80X4HbY0UiJkRClbWeU3bukLYg
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
index 428a4d210de5..57bbcaf3b619 100644
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

