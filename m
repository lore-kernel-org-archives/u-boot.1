Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6A2CA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F13C830B4;
	Mon, 25 Aug 2025 15:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="DQkf1MJO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8A4831E1; Mon, 25 Aug 2025 15:55:51 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE08082DA1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 438ECC994A; Mon, 25 Aug 2025 15:55:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1756130149; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=9oKzl1IiNva7jAIYP+wfAbd6mnssdZYD8C1MFPVuMoU=;
 b=DQkf1MJOqQ+JZnSqpxIcvVK7VAGivLBGTmljJ06HBfCa5tQrBwJwFu36lKsQMm29DfWzZ6
 HQ3NXydbuFUtq6U/sUFfLogcZS0/xCItPc3QvSahaIvhPqL8fQ8hX3HQ8K3ApkW/op/WpL
 h+sUbh+WHnPDGPuS1q0HHgO/FaDxjvQ5HMsffeGpli17azeusxqEsmrnuLANtwpO44AKmB
 LgjbUIqOeFUqlrYGmAa9UMtB0X7sIsS4hMshNjYSDFiu0U5VTy72c11UJMrVrBznKFQAQX
 qXfIttQ9jSzHRV6Vqua0e4sKC0YVTSqm4olr4GSnvjaXAPIxKjYgCTs+oaRY7g==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>,
 Annette Kobou <annette.kobou@kontron.de>
Subject: [PATCH 10/11] imx: kontron-sl-mx6ul: Force default environment for
 serial loader boot
Date: Mon, 25 Aug 2025 15:54:34 +0200
Message-ID: <20250825135504.193004-11-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825135504.193004-1-frieder@fris.de>
References: <20250825135504.193004-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Eberhard Stoll <eberhard.stoll@kontron.de>

In case of booting from serial loader (USB) we want to always use the
default environment in order to get a defined state that is
independent of any environment stored in persistent memory.

This way we can avoid corruption of the boot process during
development and manufacturing by existing environment settings in
flash.

Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/sl-mx6ul/sl-mx6ul.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/board/kontron/sl-mx6ul/sl-mx6ul.c b/board/kontron/sl-mx6ul/sl-mx6ul.c
index e33907ee124..65f9b75c1a0 100644
--- a/board/kontron/sl-mx6ul/sl-mx6ul.c
+++ b/board/kontron/sl-mx6ul/sl-mx6ul.c
@@ -104,10 +104,16 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	if (prio)
 		return ENVL_UNKNOWN;
 
+	if (CONFIG_IS_ENABLED(ENV_IS_NOWHERE) && is_boot_from_usb())
+		return ENVL_NOWHERE;
+
 	if (sl_mx6ul_is_spi_nor_boot() && CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
 		return ENVL_SPI_FLASH;
 	else if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
 		return ENVL_MMC;
 
-	return ENVL_NOWHERE;
+	if (CONFIG_IS_ENABLED(ENV_IS_NOWHERE))
+		return ENVL_NOWHERE;
+
+	return ENVL_UNKNOWN;
 }
-- 
2.50.1

