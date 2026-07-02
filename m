Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B86C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5697184CFA;
	Thu,  2 Jul 2026 11:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AA1884C92; Thu,  2 Jul 2026 09:17:36 +0200 (CEST)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E019084C6C
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 09:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 2 Jul
 2026 15:17:10 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 2 Jul 2026 15:17:10 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 2 Jul 2026 15:17:10 +0800
Subject: [PATCH] watchdog: ast2600: add AST2700 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260702-aspeed_wdt-v1-1-1c44c38430e6@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAHUQRmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwMj3cTigtTUlPjylBJdc7NUc+M0w2QLC1NjJaCGgqLUtMwKsGHRsbW
 1AAiUbE1cAAAA
X-Change-ID: 20260702-aspeed_wdt-76e73f1c8853
To: <u-boot@lists.denx.de>
CC: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, "Alif
 Zakuan Yuslaimi" <alif.zakuan.yuslaimi@altera.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Lukasz Majewski <lukma@nabladev.com>,
 Johan Jonker <jbx6244@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782976630; l=1984;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=4meYW5hO2gGWQllmyYIl6BFbYjbIq3d7w9jtAn/1Jdc=;
 b=qEogfZH7x7wsrIInI6748Ghya6kcqjO4k3VSYt5RO++/6W7Qy8akaec44qBDOtWgUCfpJwaOP
 aP3LIBYbQTnAIXkZuAGv3g45dxgyBOUV5Ctti+bxMyWG5ysL9lY6elp
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=
X-Mailman-Approved-At: Thu, 02 Jul 2026 11:20:23 +0200
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

The AST2700 reuses the AST2600 watchdog block unchanged. Bind the
driver to the aspeed,ast2700-wdt compatible and enable WDT_AST2600
on the AST2700.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
The AST2700 reuses the AST2600 watchdog block with an identical register
layout and reset behaviour, so no new driver is needed. Bind the existing
ast2600 watchdog driver to the aspeed,ast2700-wdt compatible and allow
WDT_AST2600 to be selected on the AST2700.
---
 drivers/watchdog/Kconfig       | 6 +++---
 drivers/watchdog/ast2600_wdt.c | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b91727e1265..3c56c541505 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -130,11 +130,11 @@ config WDT_ASPEED
 	  Second Boot.
 
 config WDT_AST2600
-	bool "Aspeed AST2600 watchdog timer support"
-	depends on WDT && ASPEED_AST2600
+	bool "Aspeed AST2600/AST2700 watchdog timer support"
+	depends on WDT && (ASPEED_AST2600 || ASPEED_AST2700)
 	default y
 	help
-	  Select this to enable watchdog timer for Aspeed ast2500/ast2400 devices.
+	  Select this to enable watchdog timer for Aspeed ast2600/ast2700 devices.
 	  The watchdog timer is stopped when initialized. It performs reset, either
 	  full SoC reset or CPU or just some peripherals, based on the flags.
 
diff --git a/drivers/watchdog/ast2600_wdt.c b/drivers/watchdog/ast2600_wdt.c
index 190490f3692..5eb9b4ba96f 100644
--- a/drivers/watchdog/ast2600_wdt.c
+++ b/drivers/watchdog/ast2600_wdt.c
@@ -87,6 +87,7 @@ static const struct wdt_ops ast2600_wdt_ops = {
 
 static const struct udevice_id ast2600_wdt_ids[] = {
 	{ .compatible = "aspeed,ast2600-wdt" },
+	{ .compatible = "aspeed,ast2700-wdt" },
 	{ }
 };
 

---
base-commit: e800cc67f5b6cb50a20f37c993ec1cd4063bdbd3
change-id: 20260702-aspeed_wdt-76e73f1c8853

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>

