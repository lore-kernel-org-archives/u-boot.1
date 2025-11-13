Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA29CD5BCE
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 11:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4423683E0B;
	Thu, 13 Nov 2025 12:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Dq91mRfL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="v2bxd3ZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 194EF83E0B; Thu, 13 Nov 2025 12:57:13 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A8D083E0B
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:57:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d6dzp6Rmwz9tFm;
 Thu, 13 Nov 2025 12:57:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763035030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kc91mC/Eg6JX+1spz+pvI5CMfRwFTNl5QM2MSVKUffg=;
 b=Dq91mRfLclJmIN2WY2GhrD+QXmkrlU8ERNrCfaqdtogI1EB36Q3R2WRQjGE5TJjk3l4NJR
 VeQ26lhNWaeYO87VXnN0b1/HZvhv8KynmrQ4DEJWDBVRwi5KrJ7e0zDuT5kgfpaaMQkUMn
 k+1U0QRUXpbnfdR8n0UhvJc6DJnA1gbVHm5I4+EOW8vO8HhQZbnqhImr0hidQR1TMVeBuq
 OypXkRvhtqkzaqnxv/AxY9CMKwxi85p/YYOTgFbvOHiXn9LIwJUMOEUUlkcI/vhUu3Hhzl
 qeAsLCGgzAQJ6e7mkq51Qd20yPqYukKVdbcqmBW11TQiKS9WvAmsQTzonWDJ1w==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=v2bxd3ZA;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763035029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kc91mC/Eg6JX+1spz+pvI5CMfRwFTNl5QM2MSVKUffg=;
 b=v2bxd3ZA7lyk/zomlyIleAt1HgLozlRbgLHW4Doz4bVGi89YYt/qBZ3a7Bk7ncfC926e9u
 3k0Ohh6euTpPXT1O8J8d1WnveuhPAN65kNytM+Mcv5eNEebag7pmxWKvPk5Jwi5uBgQhvz
 +nqbc/Toa6wt7az3yxTkrKJ7Pr7THhxwebrIIxEvdn2N0huEgZjIDpsPD5bEQ6x2QpPIqT
 LwThP0CuTkXXMuDIO4pTy0HdW+HIIuOYEuVf/PKM36CJcSYHWJEOA6Uo+wOloJ32e2e2JI
 G+taDXIdXwAS7pk/mvG7mzOUWyabnxHBhMx7aOGQ6kNbESoth08Td6OXRp2z7Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heiko Schocher <hs@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] sandbox: Fix DT compiler pin warnings in sandbox DTs
Date: Thu, 13 Nov 2025 12:56:30 +0100
Message-ID: <20251113115658.947953-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251113115658.947953-1-marek.vasut+renesas@mailbox.org>
References: <20251113115658.947953-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: bf2e3b2499b004a2e78
X-MBO-RS-META: a43mhdtjsy5jzgee4gbeiyrikx9rdwcy
X-Rspamd-Queue-Id: 4d6dzp6Rmwz9tFm
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

Trivially fix the following warnings in sandbox DTs, which show up with
DTC 1.7.2. Assign pin groups less confusing node names with pins- prefix
to avoid confusing DT compiler into thinking the node is really a bus node:

"
arch/sandbox/dts/.test.dtb.pre.tmp:1831.20-1841.5: Warning (i2c_bus_bridge): /pinctrl/i2c: incorrect #address-cells for I2C bus
arch/sandbox/dts/.test.dtb.pre.tmp:1831.20-1841.5: Warning (i2c_bus_bridge): /pinctrl/i2c: incorrect #size-cells for I2C bus
arch/sandbox/dts/test.dtb: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
arch/sandbox/dts/.test.dtb.pre.tmp:1848.20-1856.5: Warning (spi_bus_bridge): /pinctrl/spi: incorrect #address-cells for SPI bus
arch/sandbox/dts/.test.dtb.pre.tmp:1848.20-1856.5: Warning (spi_bus_bridge): /pinctrl/spi: incorrect #size-cells for SPI bus
arch/sandbox/dts/test.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/sandbox/dts/test.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 86db3939cfd..b7ad79a2753 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1804,7 +1804,7 @@
 		pinctrl-0 = <&pinctrl_gpios>, <&pinctrl_i2s>;
 		pinctrl-1 = <&pinctrl_spi>, <&pinctrl_i2c>;
 
-		pinctrl_gpios: gpios {
+		pinctrl_gpios: pins-gpios {
 			gpio0 {
 				pins = "P5";
 				function = "GPIO";
@@ -1828,7 +1828,7 @@
 			};
 		};
 
-		pinctrl_i2c: i2c {
+		pinctrl_i2c: pins-i2c {
 			groups {
 				groups = "I2C_UART";
 				function = "I2C";
@@ -1840,12 +1840,12 @@
 			};
 		};
 
-		pinctrl_i2s: i2s {
+		pinctrl_i2s: pins-i2s {
 			groups = "SPI_I2S";
 			function = "I2S";
 		};
 
-		pinctrl_spi: spi {
+		pinctrl_spi: pins-spi {
 			groups = "SPI_I2S";
 			function = "SPI";
 
-- 
2.51.0

