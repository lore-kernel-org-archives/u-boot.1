Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB1AC87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8458B83A5A;
	Wed,  6 Aug 2025 16:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VYaZHzW+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I+dOFZKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE61E83A9A; Wed,  6 Aug 2025 16:59:20 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F6A83721
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bxtjf1H1Kz9tKs;
 Wed,  6 Aug 2025 16:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754492358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=imj1ou1iirbylkObgzoj4x67yvrz+sEe408JIooNCl4=;
 b=VYaZHzW+HMUiqQ6ryb81q+Znn2i3tKXJY//thV3zyIxtGEJFp140aqHN3a9EwoOz1WsodG
 i7G6jMQ6aYlRX9ZIDtmJ0HJhbgQ2D9R5u7dpusRy/iHa2AHA+I91519nKA0yURCxhBuc7U
 ob6f3dMK5KFauENdVBOnCuLQrEKxkJOmvHdXb5r4WxLeds6j/WBUDoclgP6VfDqbvrlCEw
 d8dEYrS/KBT9//k1v5hZGuTYHb/55Rj3lPyYj0bPcVTT+XD8TMRMIRC4xQaXhLUwoAA3Mj
 nL9sDd0DHrVrZSHCJANZPO3SbtcKovQP/mNR6nMqJwHagBaWaJ+ZFG9Qa2qbfQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=I+dOFZKT;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754492356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=imj1ou1iirbylkObgzoj4x67yvrz+sEe408JIooNCl4=;
 b=I+dOFZKTxQMeKgjqF2xPH9CZPnPoU3mXzf0Ea8ra+ftfQp2LljCMgdi6YZv6AXuMSsZsSM
 pHrmkRZer1Ww5f9jfeT/99mqlQ1n3mVnFHZDRXLeDj/8TlUAFCXMvu+en6oHI/4aZcTfnt
 NAaPdnBU2INAGZghSM6f1rrsTxsqok7JaWqf3BWn6fQTcV6QXNg5mCbytd4M8453kQdebk
 2zPgJJ3Wu4F8qgWWVcSRQmUpDjVgk5Jm66sXI5nXpA4TnbG8huOAlt6mWnULR98ItUzYJ9
 c+fONohn1XII0zfIJOu9jilcoaAbBfLrQNN8IkHlI9vCosq1ipLKcN/ErcwNqQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/2] arm64: dts: renesas: r8a779g3: Describe generic SPI
 NOR support on Retronix R-Car V4H Sparrow Hawk board
Date: Wed,  6 Aug 2025 16:58:53 +0200
Message-ID: <20250806145903.8996-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nso5z4m3atuj3mrsbwdrsphqujjrqng9
X-MBO-RS-ID: 843b3ad99a29e4f8f10
X-Rspamd-Queue-Id: 4bxtjf1H1Kz9tKs
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

Retronix R-Car V4H Sparrow Hawk EVTA1 is populated with Spansion S25FS512S,
EVTB1 is populated with Winbond W77Q51NW. Describe the SPI NOR using generic
"jedec,spi-nor" compatible, because both flashes can be auto-detected based
on their built-in IDs.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Update commit message, s@spi-flash@jedec,spi-nor@
V3: Use capital F in the comment, s@fS@FS@
---
 dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts b/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
index 6955eafd8d6..a9ecef67d5d 100644
--- a/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
+++ b/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
@@ -729,7 +729,11 @@
 	status = "okay";
 
 	flash@0 {
-		compatible = "spansion,s25fs512s", "jedec,spi-nor";
+		/*
+		 * EVTA1 is populated with Spansion S25FS512S
+		 * EVTB1 is populated with Winbond W77Q51NW
+		 */
+		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <40000000>;
 		spi-rx-bus-width = <4>;
-- 
2.47.2

