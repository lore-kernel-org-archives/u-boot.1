Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE973CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA559844CF;
	Tue, 26 May 2026 14:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="GSwfpRLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DA47846CE; Tue, 26 May 2026 14:20:02 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B9268404D
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 14:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1779797999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=75T7ZDmY8RpIm3ZdD43DKhc8uSKXgRxsJqumEXmiRVM=;
 b=GSwfpRLrCw0WwGSlrsoCn6KDNw9AU62Uz3jr+dNbYEkD7hiuF8vkd8OcnnOpqQYhNIuHWa
 JbCfUPO3IcoTuMF6fqHyRLLPCaxEfvf7FhZrwpN2BJ1FEZKDsLI7UsvS7BF+3TYtRsM8W2
 +A2QwPZKXrhZS2YsRS+beRwLc7xF0b+wA/ow3Em52Tg2Z5fonsb7kSouoQwVAoBEM7S2uG
 X4DBdX89LhV9bvZybpaEPEBGRiK2v/MLGrTeAfxHB6lYIesZzfN5LDsMzFh1iffy9GT5/s
 UR4OpfTipIyv73/uZwpiTMGehYRgtGodbGQGsle6n6yeok842HNqvC2TzQMhjQ==
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: uboot-imx@nxp.com, Annette Kobou <annette.kobou@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>,
 Oualid Derouiche <oualid.derouiche@kontron.de>
Subject: [PATCH] imx: kontron-sl-mx6ul: Enable I2C support
Date: Tue, 26 May 2026 14:19:33 +0200
Message-ID: <20260526121934.828310-1-frieder@fris.de>
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

Enable the driver to support using I2C interfaces.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx6ul_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index 4203c3e8a4b..aa86dd8e68f 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -85,6 +85,7 @@ CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
 CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_FASTBOOT_MMC_USER_NAME="mmc1"
 CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
-- 
2.54.0

