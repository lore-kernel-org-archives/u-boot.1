Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398F2C83F17
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 23:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3353582FCA;
	Mon, 14 Jul 2025 01:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uEJz3UsF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23AF8309A; Mon, 14 Jul 2025 01:35:42 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0147483020
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 01:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=afea=Z3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752449731; bh=EU7IX7SygAys/7MmG7b3mKTEiIYq/cOTT/Anr/BKwWg=;
 b=uEJz3UsFZ2+InCB50PaxZTg6bnczM7xPECW0VEavm57egi3coT6afRMHTNucUiOl4XBPnHQUO
 BBTRA0Z2pwieyezIYKV9bFaPdvOimYbn3HcOgByoWXGXNJKSXb+51kgx8LpiZg0c4nFFq9Rhi3X
 A769IDor9M1eoPFQ7woAbVKHzFYCh/mcxWazIRk64p0LZIqQ4SkS0mYQhRZZTR9YWpr8ps+pBok
 WYUdNWTqeoMcYlyAxcExx5Jx7zKwr+Q4Q2byF8kyBzpMoStDIQQ5KDRpwohIRupNqXqZfMUf4Wz
 fCxIUTx0Vil03fdaBbHqHorgODe3v0sr3lhLYWnYmfKw==
X-Forward-Email-ID: 687442c05c59ddd2f404ffb2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 14/17] rockchip: odroid-go2: Turn on the blue LED at boot
Date: Sun, 13 Jul 2025 23:34:02 +0000
Message-ID: <20250713233429.1376172-15-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250713233429.1376172-1-jonas@kwiboo.se>
References: <20250713233429.1376172-1-jonas@kwiboo.se>
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

Use default-state prop to ensure that the blue heartbeat LED turns on
at boot to inticate that U-Boot proper has been reached.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
index 393710246e1c..170e0f7d8475 100644
--- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
@@ -5,6 +5,11 @@
 
 #include "rk3326-u-boot.dtsi"
 
+&blue_led {
+	default-state = "on";
+	u-boot,default-brightness = <127>;
+};
+
 &i2c0_xfer {
 	bootph-pre-ram;
 };
-- 
2.49.0

