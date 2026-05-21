Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7B9CD5BAB
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 20:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85A4784713;
	Thu, 21 May 2026 22:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Y0U858Hx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I59exFru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AFB8847B0; Thu, 21 May 2026 22:17:21 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11B7A846FA
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 22:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gM07f4wgQz9tFH;
 Thu, 21 May 2026 22:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779394638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lrDHih8qJf4IcLN8ITITLPP7cB4epY2pa4d9JjBSCZY=;
 b=Y0U858Hx1mPZ356PaqxKb/S3sUqOiJuUWgL7PbS6TCh+zFNFPcTMl2Dm6dhtX3H9ThLUbd
 L6IyDc5YbCeFBPzxgm9iQGKb6VCERgMySOuutT7DhfBRKU5BbxqMLYLWOshhC4jojCrZbY
 Ea7tHDXLcckI46H6xqWViRGT9UmgE0hAQ3rdkUkskcVAUuKQcF4gSfFeFnf8XNVUxmdXsI
 h6BZrob3fcHvFeuFZxXlMAdmK8UeC+Fy41FOsWLaEjx7Y7F7XV8T5sMAlGe6nHNYhZSR/O
 SgsfdeWK03cx37p3C+Jc1wC8CL5UEb1LmzcV8y6PVZzrOfcUSirrQnX5Odh3uw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779394637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lrDHih8qJf4IcLN8ITITLPP7cB4epY2pa4d9JjBSCZY=;
 b=I59exFru+LWkIHxT/qir5wcy8bdENc1Qq/XAzW215B7hkB/RIYbNMwfRNIcRfrDoRE1pYV
 qnvjgVBe98sGrEjJwMTkctPTrFWfhSVGmpp6yeE4TtEnE9JTKubq66h8/cpO77jAtFZQut
 CLherpOudFw/yCBVjhNy8joML0NnGe65hBaA1x8tTY9xtXT6Xw5Vy0C80+6ibblDGJch1x
 QfdXjFdhLuKYIcIpJP6mDhV/IddHU+0nLITt3hBc2R9MWtKD9TjoMEHwHaaSrtSk29Csoh
 0svNBhQRFU70xeT8TIk/5OuRaYItEurv7r3zMs6qQw1t/D6RIa6D+DdsZMHIEw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Janne Grunau <j@jannau.net>,
 Mark Kettenis <kettenis@openbsd.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Replace Apple with N:
Date: Thu, 21 May 2026 22:16:59 +0200
Message-ID: <20260521201712.43955-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fca11ebf054f11e70f1
X-MBO-RS-META: mdyij66dipqt5a3w1dj33z77hq5yq4tf
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

Use N: to match on all apple files, drop the large list of
entries which represent the same set of relevant files and
miss a few in the process.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>
---
 MAINTAINERS | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2613929cdf5..e83d52dc528 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -135,22 +135,7 @@ APPLE M1 SOC SUPPORT
 M:	Mark Kettenis <kettenis@openbsd.org>
 R:	Janne Grunau <j@jannau.net>
 S:	Maintained
-F:	arch/arm/include/asm/arch-apple/
-F:	arch/arm/mach-apple/
-F:	board/apple/
-F:	configs/apple_m1_defconfig
-F:	doc/board/apple/
-F:	drivers/input/apple_spi_kbd.c
-F:	drivers/iommu/apple_dart.c
-F:	drivers/mailbox/apple-mbox.c
-F:	drivers/nvme/nvme_apple.c
-F:	drivers/pci/pcie_apple.c
-F:	drivers/phy/phy-apple-atc.c
-F:	drivers/pinctrl/pinctrl-apple.c
-F:	drivers/power/domain/apple-pmgr.c
-F:	drivers/spi/apple_spi.c
-F:	drivers/watchdog/apple_wdt.c
-F:	include/configs/apple.h
+N:	apple
 
 ARM
 M:	Tom Rini <trini@konsulko.com>
-- 
2.53.0

