Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2167BCD5BAB
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 20:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 899AA847C6;
	Thu, 21 May 2026 22:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nhWZg4DA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gAi46ttT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BDE784825; Thu, 21 May 2026 22:18:10 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4582B846FA
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 22:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gM08b6dpTz9tm7;
 Thu, 21 May 2026 22:18:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779394687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AFQtbm+7U9G8PSYcJj5JMWNeyOd5kPdrfdOsT5WZ9g8=;
 b=nhWZg4DATQW5Iz5kWiEMPiE5oOGVZOJ8QDzO/tdhgbLzeCkDsDl+NHlQ/O9/QHjEZm1xWu
 EczzAzTV/G2Ca2jO2bLZJbz/i/96GUieBrv0bKqyIdBss9ads+/VXwhjSH2ucLsUwt5HWJ
 E8aYVNc9QfDWuXajr9nx+H1XL5E4ZT7zbTUSpYKQwXy1D2d7uwqdONCGYilma3Too0VhmK
 lMrPWbiNMp5Fvg2K+Fh1q5JCJ5brKF4/vIFQDtQ5u/cJicrypEr/8JRZ+a6nPv+7n1T2MV
 EvDASEcxjob2hulPbJk6jWJwx52tj4YRMzH18CCjHy8Yj9dMibvGPN9N1gJilg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=gAi46ttT;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779394686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AFQtbm+7U9G8PSYcJj5JMWNeyOd5kPdrfdOsT5WZ9g8=;
 b=gAi46ttTK0xLeobKQV1FGYuhUofJoR5Tg2W4yOF6l0RepIkWkXGbNVVaqDFv0tcc7KBAHJ
 Fm3v+aycGN2AKHYHBqVnXXg9eAtwyjHRbR/V/Xq/ZQeDMhXhPJ+M3wO7o2d9Ykgdo8NAoC
 rHAl1dfYkJJwtSH2GBa/YJjzivyUceYD+A6hUnrx3LPK1RQU0GKTXRHBBoVe1zAq7M0WPu
 Zviz+bTWT8t4VCLA7yTUcCehSmTQF4lbxmwJnwkGt4BUeQgeBnCq8so2shir0iuaGiMMS9
 1k2BkBBvagrGgMWHIiHc0EI/6nUg9/lBucKPar5cOoozK0lzNRzN2cUDVQtu/A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Replace ASpeed with N:
Date: Thu, 21 May 2026 22:17:49 +0200
Message-ID: <20260521201801.44018-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wetfq4ko9a48q538iuakz88hk7q1egs7
X-MBO-RS-ID: 50a03f48bf622941002
X-Rspamd-Queue-Id: 4gM08b6dpTz9tm7
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

Use N: to match on all aspeed/ast2500 files, drop the large list of
entries which represent the same set of relevant files and miss a
few in the process.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 MAINTAINERS | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c52a9645b1..b56ebbd82d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -170,22 +170,11 @@ M:	Chia-Wei Wang <chiawei_wang@aspeedtech.com>
 R:	Aspeed BMC SW team <BMC-SW@aspeedtech.com>
 R:	Joel Stanley <joel@jms.id.au>
 S:	Maintained
-F:	arch/arm/mach-aspeed/
-F:	arch/arm/include/asm/arch-aspeed/
-F:	board/aspeed/
-F:	drivers/clk/aspeed/
-F:	drivers/crypto/aspeed/
-F:	drivers/gpio/gpio-aspeed.c
 F:	drivers/i2c/ast_i2c.[ch]
-F:	drivers/mmc/aspeed_sdhci.c
-F:	drivers/net/aspeed_mdio.c
 F:	drivers/net/ftgmac100.[ch]
-F:	drivers/pinctrl/aspeed/
-F:	drivers/pwm/pwm-aspeed.c
-F:	drivers/ram/aspeed/
-F:	drivers/reset/reset-ast2500.c
 F:	drivers/watchdog/ast_wdt.c
 N:	aspeed
+N:	ast2500
 
 ARM BROADCOM BCM283X / BCM27XX
 M:	Matthias Brugger <mbrugger@suse.com>
-- 
2.53.0

