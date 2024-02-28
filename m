Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C952C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 10:58:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B3E188007;
	Wed, 28 Feb 2024 11:57:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tBAgqV2Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7923C87E7B; Wed, 28 Feb 2024 11:57:58 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9630788007
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 11:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6789ACE20EC;
 Wed, 28 Feb 2024 10:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A50CFC433C7;
 Wed, 28 Feb 2024 10:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709117872;
 bh=bwQo3yCi8PC9jOvUI1M44a84Ie4YFivuVDh6Xc1qwa0=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=tBAgqV2YYYiwes0qNilhYZArd8cRNjesDWca6cNebkajX6poX58Dwa8RoJHjQjGlf
 JqvMYHOkpdNsXH5EHm/3FZML+RY4C8JB8pmwMU8xZ7yLBx4h/MPOAWtSjR+WMTC2y9
 IfXa216Nt/OUa9J0EBFAgiWXi+qvsMA8CtMEtG1i9tjOu1alxLB2nHQt/0kYwomQBZ
 WOnjs4LlY4oZltbeX875KYc+4+aFJJV77od9w1kI7OmzH2Lc9tzsQsnPBJ0zvnwR3V
 84YHkv4yn85C6dTmmL5GOKKm2a+d/rgZEkgPs2kYKhRSRp+wr3KfrltVLtgYzCqnIV
 wLRCU2T881KNg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAA0C54E41;
 Wed, 28 Feb 2024 10:57:52 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 28 Feb 2024 18:57:52 +0800
Subject: [PATCH v2] serial: pl01x: set baudrate when probing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-b4-pl011-v2-1-92129ba2e23a@outlook.com>
X-B4-Tracking: v=1; b=H4sIAK8R32UC/23MQQ7CIBCF4as0sxbDUBDtynuYLmg7WGItDVSia
 bi72LXL/+Xl2yBScBShqTYIlFx0fi4hDhX0o5nvxNxQGgQXkqOoWSfZMnFERnRRWlkrTH2Gcl8
 CWffeqVtbenRx9eGzywl/6x8kIUNmO6VPAzcapb361zp5/zj2/gltzvkLgRpTSaIAAAA=
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>
Cc: Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709117872; l=1620;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=SF9Ay5KAqk/WshEdgSQMu8Q+ALCWAg7OLJOzuEFI0Hg=;
 b=7frSEL61EkT4Zz8Nee7Azzk7gawOkSW6mvlIQ2J4yrz/hcSBy8i0ldwitKx8zLUn6WAVc/J3X
 t1jkuevRTq1BKA2mZ9tfMV+JMc3kpnilYA7ZRowwr8LXbSW2uHFnWHq
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
Changes in v2:
- reverse if statement (Dan Carpenter)
- Link to v1: https://lore.kernel.org/r/20240123-b4-pl011-v1-1-fb576d0a714f@outlook.com
---
 drivers/serial/serial_pl01x.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/serial_pl01x.c b/drivers/serial/serial_pl01x.c
index 428a4d210de5..f04c21e08264 100644
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
+		if (ret)
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

