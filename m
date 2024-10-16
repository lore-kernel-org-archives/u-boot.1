Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E40D2A559
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 20:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB57F88DE1;
	Wed, 16 Oct 2024 22:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="W/W4Y6/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1828588DF8; Wed, 16 Oct 2024 22:14:33 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A8EC88DD1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 22:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=97a5=RN=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1729109661;
 bh=ml0oaJy0Y6aqsAhalMs6VuJDizKOQFS/j5y03P49Osk=;
 b=W/W4Y6/fnJj/oKHb2R7z3RfqpclW5xmsfZrM6of2Gfofb0S8jLs3W6LXoMTdtYtBJLtKxnH1U
 8aR9Rwl9UunSdioBtqjbNb+8/TXF6+IlBcSYA4fhH6iM9eTpF7GdlkWQk8fCb0CcCrNf3t2jUkK
 pF13/eTd6/czrZUKSv0JZVhDRGLD0FW7oBpvbILJ/f2tmXnjvhUpniu8xG91Qv0SI9MmRasH0rG
 aeGxoOjaTQ/Ch6XGavpORRa2n5VsHAEFJwTooZGVbSb4tLAouMmZrsd7nSfnI/gBNhix87gd5Mo
 w9mB9uyxceg0qM2H1jEumFZFnO5ieXjsvMDVwKHqBiYw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3588-rock-5b: Drop upstream props from u-boot.dtsi
Date: Wed, 16 Oct 2024 20:14:11 +0000
Message-ID: <20241016201413.903112-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67101e9cd62e1ab7640f71c3
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

The SPI flash node has been added in upstream DT, drop all props beside
bootph-* props from the SPI flash related nodes in u-boot.dtsi.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index 4dd17ff408cb..3ff3bb64e4f7 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -16,18 +16,9 @@
 };
 
 &sfc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&fspim2_pins>;
-	status = "okay";
-
 	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
 		bootph-pre-ram;
 		bootph-some-ram;
-		spi-max-frequency = <24000000>;
-		spi-rx-bus-width = <4>;
-		spi-tx-bus-width = <1>;
 	};
 };
 
-- 
2.46.2

