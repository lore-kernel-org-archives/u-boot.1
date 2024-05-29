Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB4BC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 10:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CEEC885E1;
	Wed, 29 May 2024 12:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="FVVEHMVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 081D0885AF; Wed, 29 May 2024 12:01:19 +0200 (CEST)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E6BF88349
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 12:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FB701C0003;
 Wed, 29 May 2024 10:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1716976875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JWo4JoKaBJHNaXKwCHderz7ya+GRgASo2f4Fr1HqXSA=;
 b=FVVEHMVuBZbyx5PymRCBmg9uuzU7c9hZXSNCPZIl9WoXtLElgqpEBUqLUkM4BTYvXvFqgx
 r97HEVxnbum/YfCq+B4svn0QOPyaccmOQcsNyIXeEFU8XbCkNshaP0orViQd3sJgBk+SDC
 GssL+uk7Aj4naX3h9M+DeYa+CypODHJsM2e7CGuSkBKOtYfIx3tp5OwQIwY9uu8Lj3rWNp
 0S7sMTOIhwPNaCPhLSKbQtpgsF/KycM3DO14AU0udkQ8qLS/Q7HePZltiFC3ZzCrWIiNpz
 ivHHKU7BCkq0CS3YnWWInJaX7FSDCkDufydLP4AeNCtCjaHS6f15AKgAHKTK6Q==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2] xilinx: zynqmp: Allow multiboot environment write even in
 saved environment
Date: Wed, 29 May 2024 12:01:06 +0200
Message-Id: <20240529100107.137159-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
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

Once the environment was saved, the current multiboot image information
became unreachable. When dealing with firmware updates, this information
is necessary alongside the saved environment to know the booted image.

Move the multiboot environment set operation before the saved environment
check to ensure this information is always available.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Fix nit in the commit message
---
 board/xilinx/zynqmp/zynqmp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index f370fb7347a..16292ed1c7e 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -519,6 +519,10 @@ int board_late_init(void)
 	usb_ether_init();
 #endif
 
+	multiboot = multi_boot();
+	if (multiboot >= 0)
+		env_set_hex("multiboot", multiboot);
+
 	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
 		debug("Saved variables - Skipping\n");
 		return 0;
@@ -531,10 +535,6 @@ int board_late_init(void)
 	if (ret)
 		return ret;
 
-	multiboot = multi_boot();
-	if (multiboot >= 0)
-		env_set_hex("multiboot", multiboot);
-
 	if (IS_ENABLED(CONFIG_DISTRO_DEFAULTS)) {
 		ret = boot_targets_setup();
 		if (ret)
-- 
2.34.1

