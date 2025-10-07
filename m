Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB17CCA476
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEF958393D;
	Tue,  7 Oct 2025 10:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="fZLjhz0J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49045838F3; Tue,  7 Oct 2025 10:18:29 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 765248388D
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C6986C9A51; Tue,  7 Oct 2025 10:18:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1759825107; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=b/nq1WQI4hWAT7UhcEjWWksIB7SxqfkauN5HhKfCfM0=;
 b=fZLjhz0JGwlL19WgaTpXGQdJgpMbzKk0VZIVVJvaa2a4xmwkKnipQjZRx6+uZIzC6yWAGt
 zdNjU5R+zH81TORA+aSVwcKdbNH3u7DBHuqPDdPFfBJxapAvkjLlPl68EcZyqUDZ6FkGYV
 BKJdxkh5oLDjexDLIkuKhSv1BHwOwjT8/SifSDeHSqMczXeRP7/SPikWzwKDX90dTD1ABy
 1cUyLHWK+ldc3/B6aDPu6Z40t2hGByXt+FoTBBjgScCYFycFcsDGldKag72AeRgozvMHXo
 HY/wJqoeJIvsMOn4lSSum6kajf4DodFYn4o5l5zL5UynM2UKpUROr7ZQY34DpA==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 12/13] imx: kontron-sl-mx8mm: Force default environment for
 serial loader boot
Date: Tue,  7 Oct 2025 10:16:09 +0200
Message-ID: <20251007081640.61772-13-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081640.61772-1-frieder@fris.de>
References: <20251007081640.61772-1-frieder@fris.de>
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

Enable CONFIG_ENV_IS_NOWHERE and force default environment when SoC
boots from serial loader. In this case the U-Boot environment cannot
be stored to flash with the 'saveenv' command.

This makes serial loader boot completely independent from any
environment stored in flash.

Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/sl-mx8mm/sl-mx8mm.c  | 8 +++++++-
 configs/kontron-sl-mx8mm_defconfig | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/board/kontron/sl-mx8mm/sl-mx8mm.c b/board/kontron/sl-mx8mm/sl-mx8mm.c
index 220c9701ca5..df92765cb2d 100644
--- a/board/kontron/sl-mx8mm/sl-mx8mm.c
+++ b/board/kontron/sl-mx8mm/sl-mx8mm.c
@@ -182,6 +182,9 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	if (prio)
 		return ENVL_UNKNOWN;
 
+	if (CONFIG_IS_ENABLED(ENV_IS_NOWHERE) && is_usb_boot())
+		return ENVL_NOWHERE;
+
 	/*
 	 * Make sure that the environment is loaded from
 	 * the MMC if we are running from SD card or eMMC.
@@ -194,7 +197,10 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	if (CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
 		return ENVL_SPI_FLASH;
 
-	return ENVL_NOWHERE;
+	if (CONFIG_IS_ENABLED(ENV_IS_NOWHERE))
+		return ENVL_NOWHERE;
+
+	return ENVL_UNKNOWN;
 }
 
 #if defined(CONFIG_ENV_IS_IN_MMC)
diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index a2cc4d03963..f9484b908d9 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -112,6 +112,7 @@ CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="imx8mm-kontron-bl imx8mm-kontron-bl-osm-s"
+CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-- 
2.51.0

