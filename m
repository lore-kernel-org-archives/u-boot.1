Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89988D185F9
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D575A8415D;
	Thu,  8 Jan 2026 14:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="jVvZl8tV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C149B83A26; Thu,  8 Jan 2026 03:17:09 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94367839F1
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 03:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8E5F610B030; Thu,  8 Jan 2026 03:17:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1767838627; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=0Qt7l6OG7mZBuPmoER87AzE5iYWoeaHOp0jbpJhzDNk=;
 b=jVvZl8tV+NBqRMm5JpkxKf9ZdgdrqIlh82Reu4ZhP3m6VzokEarKtCZ7KQMV39IrI2/LgE
 dv9kC/x6DTFtz/Tz/rCrFfqzW7SBbWPNLkM9KmeiWcUIiJ66jdB7MTaY+R28v3QO+kb2UZ
 9ckTFchGDLKzMLx1fwB4UuC1pW/5rUrJFjpBucDntZ8hYnxEJOV85Qf/sDS9101IYjnwzu
 6955hNTk0Sd27vd5zPguzpGTgkInGnSoYPNgl3QQdzmdB0dXm1TlS4vaqqn2uh5nsKHwcy
 PpA3gjU6SQvPYMlqp/Gce912wcj5SBcVT+ZH9kv/X0xtRwlfbd+EwRW7qUtbDw==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Antonio Borneo <antonio.borneo@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Reinstate missing SPL configs for DH STM32MP15xx
 DHSOM
Date: Thu,  8 Jan 2026 03:16:51 +0100
Message-ID: <20260108021705.518243-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:16 +0100
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

Re-enable missing configs for DH STM32MP15xx DHSOM, to allow those
devices to successfully boot again.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 configs/stm32mp15_dhsom.config | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/configs/stm32mp15_dhsom.config b/configs/stm32mp15_dhsom.config
index d5ecbac29e0..24420372e3f 100644
--- a/configs/stm32mp15_dhsom.config
+++ b/configs/stm32mp15_dhsom.config
@@ -38,7 +38,13 @@ CONFIG_WATCHDOG_AUTOSTART=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
-CONFIG_SPL_TEXT_BASE=0x2FFC2500
 CONFIG_SPL_BLOCK_CACHE=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR_STPMIC1=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
 CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SPL_TEXT_BASE=0x2FFC2500
+CONFIG_SPL_USB_GADGET=y
-- 
2.51.0

