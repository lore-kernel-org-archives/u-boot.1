Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC84C44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EDFF84A5B;
	Sun, 19 Jul 2026 20:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lcPGdM4C";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xWoWY0DJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62FAD84A7A; Sun, 19 Jul 2026 20:13:18 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8085C84A4B
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h3BbH5t85zKvrv;
 Sun, 19 Jul 2026 20:13:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784484795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6wq28QaxUiMyrw8ZOkONZcYC67WQIupvG9g3iUA1rKQ=;
 b=lcPGdM4CAJr8w/TI8plJu0pfR1LCL0h7/lDfT3VsQTOS+XoMKh1I++nLZvfcMo8oZi4wrd
 HWtirDfVq/aEgOGTQh1g2QfzfXH2UkVqzur1JcRNpPKTczm0kV3s+ShyIdpm8jFjjF9n2S
 ZBWNIoGZh6AmloWEZI259mxmqoJAD7XPl+6X5EGvJ8m0PkalkXyvPWHJr+eR1pDWdXgG2X
 A4r13cTzgWB9l1iErxe/X4dRLR9tWmyLcUGvGImIdQ5ijhmrmVowcN77t6eqy+wBJFWu4A
 QssFVyTW1CuBLQEbVjydfXg6sy6wNdOG/n8Ir+knu/ZJrv1cIyTlOmrrKjnbGw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xWoWY0DJ;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784484794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6wq28QaxUiMyrw8ZOkONZcYC67WQIupvG9g3iUA1rKQ=;
 b=xWoWY0DJFrkzDlljA+rQwas2YWu7T89iGl+KlxQJEVzd4FLu449De7AA15ZldGFBpY2WzN
 UHlJaUrcdRSw8FdMXO6mR2EzCAO6RON8QzK8pRK9w0LqG4cBM1SHqUpRgVezPl8Zysoo4t
 MsN9IeTySY65BUNnEt05vlAWD+U43x84NBoXpJd0d+bI3Gr+ynzAVbhGYa7l/4zXozuClU
 HSKnVA9fxIfBk7VNLm3EpsjsW57qBXjdiKm5y72JixW8sRD1iD9hkopccaTwbiK1muP9x4
 4zWUphyx49peTmr1XVXuLlTCmtRZLYc6DeicI9+uZi4G1HNR4qDcrA+P5F4VCA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] Revert "arm64: dts: renesas: r8a779g3: Reinstate basic
 PCIe clock description for Sparrow Hawk"
Date: Sun, 19 Jul 2026 20:11:52 +0200
Message-ID: <20260719181303.245004-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260719181303.245004-1-marek.vasut+renesas@mailbox.org>
References: <20260719181303.245004-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 87c940914a35d685251
X-MBO-RS-META: ir3hhmdfc97a5ezn35fw3u419y4h766q
X-Rspamd-Queue-Id: 4h3BbH5t85zKvrv
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

This reverts commit a6f018b7b503c026cc66d25bd59868bac70150dc.

The a6f018b7b503 ("arm64: dts: renesas: r8a779g3: Reinstate basic PCIe
clock description for Sparrow Hawk") workaround for missing PCIe clock
generator driver is no longer necessary, as the Renesas 9-series PCIe
clock generator driver is now available. Drop the workaround.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
index 968cf6684c5..dff0355150d 100644
--- a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
@@ -49,24 +49,6 @@
 	status = "okay";
 };
 
-&pcie0_clkref {
-	clock-frequency = <100000000>;
-	status = "okay";
-};
-
-&pciec0 {
-	clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
-};
-
-&pcie1_clkref {
-	clock-frequency = <100000000>;
-	status = "okay";
-};
-
-&pciec1 {
-	clocks = <&cpg CPG_MOD 625>, <&pcie1_clkref>;
-};
-
 &rpc {
 	flash@0 {
 		/*
-- 
2.53.0

