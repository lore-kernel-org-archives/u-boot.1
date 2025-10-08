Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C79CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 09:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36F4083942;
	Wed,  8 Oct 2025 11:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="HB9SqWba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B4FB8394E; Wed,  8 Oct 2025 11:08:31 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 060A18393F
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 11:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mathieu.dubois-briand@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 0416FC085F7;
 Wed,  8 Oct 2025 09:08:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6FB05606E5;
 Wed,  8 Oct 2025 09:08:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C72DD102F213B; 
 Wed,  8 Oct 2025 11:08:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759914507; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=ZoA/WsOobli58/TKDzbj/ri5vx143N7Oa2+t1C8hTxc=;
 b=HB9SqWbaz9sihhrep886uRjMStowjQ5D4od1k3bdxJNWaR0lHg+5cUlYGvrqG2uozqtgwl
 BleVxyw5MEdK5zCTsdcrs7m6C1793G3lMpY3tIvhqeLCt6pDOLCG6aqmrsq2uPdOmc51kr
 V7U6XFNdopvpBKa1183L/anrzenzbRqVY5crgVq00gThegt9H5+x5iiD518Br1b2Mi4X+6
 k7J7P2kg3l9UT/E64SbMMDFdTvJwscnpDslAZCdsBbn4opzxWvFdjZUMorlQouth9PgnXT
 g5NBJgMYcj7u1XCHrRMPkqegHtjsKpnjAnCKGRwylmTA75uIV2r4yDn85na5qg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 08 Oct 2025 11:08:16 +0200
Subject: [PATCH] imx93_frdm: Fix USB vendor ID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-mathieu-frdm_imx93_fastboot-fix-v1-1-0dbee2f10b7c@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAP8p5mgC/x2NQQ6DIBAAv2L27CZAaxW/YoxBWXQPiAFsTIx/L
 +lx5jBzQ6LIlKCvboj05cRhLyDrCpbN7Csh28KghGqkEB16kzemE120fmJ/6dfkTMpzCBkdX9i
 0H7u8ldSzFlAqR6Si/4dhfJ4fHrIp5nEAAAA=
X-Change-ID: 20251008-mathieu-frdm_imx93_fastboot-fix-576dc4219b90
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759914501; l=1002;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=Hi+hcHO599gCdmWrregTeXe/BpPIAwjx/7BAlOamPp4=;
 b=+jaOkWllPeHPOsNZAhg++qVhUYTCnYKsy+sZbPpBechNloj2KNOx0Og4SG4vFHiwcP6SENf9p
 FWDrjErRqk+BRj8N9DAHYikggHIofTo2H1WP6Dj5sFhD3ysgQf0b4G0
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
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

NXP manufacturing tools expect the device to have the NXP 0x1fc9 vendor
ID instead of 0x0525. This is the value already used by other i.MX8 and
i.MX9 boards.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 configs/imx93_frdm_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/imx93_frdm_defconfig b/configs/imx93_frdm_defconfig
index eddd36c618d6..ae95c57218ce 100644
--- a/configs/imx93_frdm_defconfig
+++ b/configs/imx93_frdm_defconfig
@@ -127,7 +127,7 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="FSL"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
 CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
 CONFIG_CI_UDC=y
 CONFIG_ULP_WATCHDOG=y

---
base-commit: 92dcb3ad5d98f494b2448a7345e1cb7eefa50278
change-id: 20251008-mathieu-frdm_imx93_fastboot-fix-576dc4219b90

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

