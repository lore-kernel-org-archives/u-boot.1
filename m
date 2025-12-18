Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5020D6ACF5
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 12:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73AA183D90;
	Thu, 18 Dec 2025 13:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8FAF83DBD; Thu, 18 Dec 2025 13:19:19 +0100 (CET)
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch
 [45.157.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C675E83D00
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 13:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dX8q93JRdzb0C;
 Thu, 18 Dec 2025 13:19:17 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dX8q828xdzq0j; Thu, 18 Dec 2025 13:19:16 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 18 Dec 2025 13:19:07 +0100
Subject: [PATCH] boot: fix missing dependency for BOOTMETH_ANDROID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-bootmeth_android-deps-v1-1-0113c804f951@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgumEBGvIiLVRM1gK62IULy7x
 fEN/2dIElUS9FWGKLcmDb4A6wqW3flNjHIx2MYSWuzMHMJ1yLVPznMMyoblTMZhS0SMbScEpT2
 jrPr832F83w8XXsCeZwAAAA==
X-Change-ID: 20251218-bootmeth_android-deps-a16555d168e5
To: Julien Masson <jmasson@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The code depends on set_avendor_bootimg_addr and set_abootimg_addr
functions which are only defined in cmd/abootimg.c, only built when
CMD_ABOOTIMG=y so let's add a dependency.

It should be "depends on" to be properly implemented, but we get a
circular dependency otherwise:
boot/Kconfig:566:error: recursive dependency detected!
boot/Kconfig:566:	symbol BOOTMETH_ANDROID depends on CMD_ABOOTIMG
cmd/Kconfig:504:	symbol CMD_ABOOTIMG depends on ANDROID_BOOT_IMAGE
boot/Kconfig:7:	symbol ANDROID_BOOT_IMAGE is selected by BOOTMETH_ANDROID

so instead we do a select. It is safe because CMD_ABOOTIMG depends on
ANDROID_BOOT_IMAGE which we select here as well.

Fixes: 125d9f3306ea ("bootstd: Add a bootmeth for Android")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 boot/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 245e120c70b..aa135a4e1a5 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -568,6 +568,7 @@ config BOOTMETH_ANDROID
 	depends on X86 || ARM || SANDBOX
 	depends on CMDLINE
 	select ANDROID_BOOT_IMAGE
+	select CMD_ABOOTIMG
 	select CMD_BCB
 	imply CMD_FASTBOOT
 	imply FASTBOOT if !NET_LWIP

---
base-commit: 47b50fb1125c539d80ed3e7f739c02c6486e1b52
change-id: 20251218-bootmeth_android-deps-a16555d168e5

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

