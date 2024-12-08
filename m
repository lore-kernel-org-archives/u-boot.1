Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19B5E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 22:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91371895B9;
	Sun,  8 Dec 2024 23:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="U7Y1jS6t";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tvwQmTGZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B904893AE; Sun,  8 Dec 2024 23:06:29 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B28D889522
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Y5zbk3H93z9shx;
 Sun,  8 Dec 2024 23:06:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TtZlF+hxzthMnV30h7E+zfJOUD1G0KTfI0HaZ63igs=;
 b=U7Y1jS6tWST+vOXzfEA8YrHkm6JcC8sNZdgVNETAy0CuX0yw7/YDhGgTopDpBz7hQG8Ng9
 FM1yM/NAhnFG1eja/VKHUstQ1aj7MePlQ5ZDxAj8T03kM0p+AOUopt0QQVe2nJ2umFWTUW
 DlkBc20Rilg4fMGaa2+YoMHlxFxlT3/qnzUc+IawoHHtgfVyEdfi1T6X27AJggPzPuvcWC
 Dybsc/22r31Cfh19erIsU9tTbs3ztThS3ah1KsyulPa+EbYQhid6zKpqw1594AdZhRzfLP
 1nNHYVKiUqzADQ5c8jDXR5lHNpia4J0TPrjC+TFTm7EZnswaxqGy+ZeB5cLp+g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TtZlF+hxzthMnV30h7E+zfJOUD1G0KTfI0HaZ63igs=;
 b=tvwQmTGZy4WBcKcEr6CYqtlhROypw6NS0GAhFmxjn8HmqAewxEid/6AvHD+ExeF2FtgVQr
 HEpDIcS53nRuDDLESgCz0e7Xewit1fAnOfcPlS7evO2OPR+R7OTobCnPj+mKkLpbsnhdj1
 8uXkx5phmF230LRhaSPqXv13Rbg0tjAsYnWeRJl4+JHWn91F4McMOpusY2CJWhOGBZi+/Q
 D5shiSqq81mFX5wHOorr0x6AhPYBZQEUOSJ6CrJ9iIl4tzQPl3kLenvjVBDWPpkOdadc5H
 lZxc7O95DEFq0dRcyCW5Nq/pXc3eb/pt+TL6pDLt8pnCLzyZq0rHETdAj6J/8g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/13] phy: renesas: Fix R-Car spelling
Date: Sun,  8 Dec 2024 23:04:02 +0100
Message-ID: <20241208220551.204743-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
References: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mrwryxx3jkwcsr7f4sxqsrzeineb3zpi
X-MBO-RS-ID: e30feee4b686a712ab5
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

The correct spelling is R-Car, including the dash, update the usage.
Kconfig strings and comment changes only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/phy/phy-rcar-gen2.c | 2 +-
 drivers/phy/phy-rcar-gen3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-rcar-gen2.c b/drivers/phy/phy-rcar-gen2.c
index f9428c7ad12..be736629d51 100644
--- a/drivers/phy/phy-rcar-gen2.c
+++ b/drivers/phy/phy-rcar-gen2.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Renesas RCar Gen2 USB PHY driver
+ * Renesas R-Car Gen2 USB PHY driver
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/drivers/phy/phy-rcar-gen3.c b/drivers/phy/phy-rcar-gen3.c
index b278f995f37..8c004eaf4c6 100644
--- a/drivers/phy/phy-rcar-gen3.c
+++ b/drivers/phy/phy-rcar-gen3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Renesas RCar Gen3 USB PHY driver
+ * Renesas R-Car Gen3 USB PHY driver
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
-- 
2.45.2

