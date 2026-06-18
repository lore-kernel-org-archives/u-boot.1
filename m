Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F1DCD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 06:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFD11847C3;
	Thu, 18 Jun 2026 08:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="svwpnxrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A50847EF; Thu, 18 Jun 2026 08:14:03 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F9A68460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1781763240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3G0WaMclShlR+5LMbnBtPS7DzIJFWb1h/CydkNwkqgE=;
 b=svwpnxrvfCfAzrxByCRoJVztnYkoQs32QHSi+Dewal2ycwoxwjdJT91kkdmtGZ538Dh0NW
 DZ+BmYW+SNBDJcFtVOlmvz7jFe0yet8f9KvqB1cyiOKtn+BPY+8yl+KKSfCj+dxunGuO3q
 TAbt5c+HAYUtbFPxELbmBO5pka0U5jfKUGA9upHAceAeiravBeGjjVJFHZ/ltayyY6X98H
 qnZMXbFHRM5abF4z82peEN3Ava9FtpFFjUJJ6C+Il2EQnUBQp/k2EnbsEw+1gWpJ4xB+4r
 TZp6xZJ77tTTRECAk3WBy1ndr8eTzxJ3yRffRk77uofQkSokvcx2nGMg7Mc79g==
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: uboot-imx@nxp.com, Eberhard Stoll <eberhard.stoll@kontron.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH] imx: kontron-sl-mx8mm: Enable the watchdog at boot
Date: Thu, 18 Jun 2026 08:13:24 +0200
Message-ID: <20260618061325.8547-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

We want the watchdog to be enabled at boot by default so it can
handle emergency situations in any case.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx8mm_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index f999ed073e8..006477b5e01 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -210,5 +210,4 @@ CONFIG_SDP_LOADADDR=0x40400000
 CONFIG_USB_ETHER=y
 CONFIG_USB_ETH_CDC=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
-# CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_IMX_WATCHDOG=y
-- 
2.54.0

