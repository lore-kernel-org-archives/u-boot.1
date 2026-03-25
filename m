Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB013FEC0F4
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 01:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E73B383CD3;
	Wed, 25 Mar 2026 02:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jCnnUQSP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aRldd8QB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31C6B83CD3; Wed, 25 Mar 2026 02:09:33 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78FB783A91
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 02:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fgTMX4N7mz9vDG;
 Wed, 25 Mar 2026 02:09:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774400968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ry96jpLlnf2LzEdjvFw11j6m0haYa7qoAMKjiRiXoLU=;
 b=jCnnUQSP1mTl3T9Z8k+bbKDyWXU6XGUdX/iYX5sZyVszZVqfwq/+RJ28u8fVqVxSuMZrej
 rfWrfniNK81ZV2Pw5ojze5Ch3QsBxgfBoZFtj9gHnc8zjHiBseZejlBlhGlivgH4FLo+B5
 1JeExv87w0Al48NI4huKKn9DmUIVb7PDFJlYSlHdqYaOEy8ypYrrgXVBpx7QPsOHH8rNff
 Vv0x3JXEaZg3HOvo02VKUoFKM+JUzeDz2vH+X9sDXyh8OkLMhaB4vqDjfWTnw7iUfXdtUt
 hi+lBn4atkrcMzkf1W9OvCJlKMK6OU1xyf5/nx4BQEUZ4cPIjnuybP01JEVDrg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=aRldd8QB;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774400966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ry96jpLlnf2LzEdjvFw11j6m0haYa7qoAMKjiRiXoLU=;
 b=aRldd8QB6SgE3vdISnIitBkxYbuyFIXVvr7aN1Wu2AqNoB0TL8Tg9Rfa8L1i6VTXdTmvt/
 x4QAJoXEIrJBHJ6f8Zt1a4w97PdwICgerUNyPlZjE9ArZJWWz+NBcrBHnUsjthZZdI39OW
 mPdFYOKxHVbwSQIdgh3e3nlvz1R1RPzW75gh7cuHdhn0swwNDYISH8dsj1+CYI7nLeNbl3
 HT0ZV/2tl0qX+tCi6A7y7tIDXtS/kNc4YGZ59V5KY44X1Z6rfEIS5PEP0VODsGhk/NfpLH
 p8gnpreM5woZYz7gOqTW7Zu+FYhDHCvcaAZoJsGQ7k77WbysATaswuO2Mv5azA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Phong Hoang <phong.hoang.wz@renesas.com>,
 Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Thanh Quan <thanh.quan.xn@renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: rswitch: Avoid NULL pointer dereference during PHY access
Date: Wed, 25 Mar 2026 02:09:05 +0100
Message-ID: <20260325010922.280141-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j3g6e6j4wj4311r9frd8ufprdrt44fe6
X-MBO-RS-ID: 873da63b10273129075
X-Rspamd-Queue-Id: 4fgTMX4N7mz9vDG
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

At the very early stage when PHY ID is being auto-detected, the
PHY device is not yet instantiated and rswitch_etha .phydev is
still NULL. Add missing check for this condition and perform C22
fallback access in this PHY ID auto-detection case.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Phong Hoang <phong.hoang.wz@renesas.com>
Cc: Tam Nguyen <tam.nguyen.xa@renesas.com>
Cc: Thanh Quan <thanh.quan.xn@renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 801c22bbdc7..c51908ed8f3 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -482,7 +482,7 @@ static int rswitch_mii_read_c45(struct mii_dev *miidev, int phyad, int devad, in
 	/* Access PHY register */
 	if (devad != MDIO_DEVAD_NONE)	/* Definitelly C45 */
 		val = rswitch_mii_access_c45(etha_mii, true, phyad, devad, regad, 0);
-	else if (etha->phydev->is_c45)	/* C22 access to C45 PHY */
+	else if (etha->phydev && etha->phydev->is_c45)	/* C22 access to C45 PHY */
 		val = rswitch_mii_access_c45(etha_mii, true, phyad, 1, regad, 0);
 	else
 		val = rswitch_mii_access_c22(etha_mii, true, phyad, regad, 0);
@@ -516,7 +516,7 @@ int rswitch_mii_write_c45(struct mii_dev *miidev, int phyad, int devad, int rega
 	/* Access PHY register */
 	if (devad != MDIO_DEVAD_NONE)	/* Definitelly C45 */
 		rswitch_mii_access_c45(etha_mii, false, phyad, devad, regad, data);
-	else if (etha->phydev->is_c45)	/* C22 access to C45 PHY */
+	else if (etha->phydev && etha->phydev->is_c45)	/* C22 access to C45 PHY */
 		rswitch_mii_access_c45(etha_mii, false, phyad, 1, regad, data);
 	else
 		rswitch_mii_access_c22(etha_mii, false, phyad, regad, data);
-- 
2.53.0

