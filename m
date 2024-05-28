Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D2AC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F519884D1;
	Tue, 28 May 2024 16:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="LAOY/uvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A8A884D2; Tue, 28 May 2024 16:37:36 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A76CC884A7
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFD51FF807;
 Tue, 28 May 2024 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1716907054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LhU1Yov+6JcTGeG19CT8cOIwSBmLUFYGhdfOHexdLNo=;
 b=LAOY/uvuf9SNm/jfgK2VgzRObEi8oFYqGlZ5aaW78UXIJbh4fsVWgLRtVven2GrSu1w3WO
 lSAvSs2BYfgqcu1XuQnT3xlt2vPGWH3gnY6UnCCGnZrptmDImCVEpvLWX2+V9DMZ0mNYCw
 Kk589I7y/CSDHT0Hg8Zu2wfe0x+4D5w6S5UG9aMPMdvTTkI2Jz6Ti+DqR+j+X725xkFRq/
 jLPhnVCqjBKuN9/dmH8qLwhOA0ympC0KcJ6X5XHkQms/B8z6Gkn3776fvHLjfdZCn5a97p
 VGJlkf8bNnOvNBpDs7Td+7rQrG78B17U8xLQlu9IRjMb7hPTFStU1HJy+caNsg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: zynqmp: Allow multiboot environment write even in
 saved environment
Date: Tue, 28 May 2024 16:36:51 +0200
Message-Id: <20240528143652.64489-1-kory.maincent@bootlin.com>
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

Once the environment was saved, we could not retrieve information about
the multiboot image used. When dealing with firmware updates, this
information is necessary alongside the saved environment.

Move the multiboot environment set operation before the saved environment
check to ensure this information is always available.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
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

