Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9BECA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 16:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C04FC8397B;
	Sun, 31 Aug 2025 18:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CZgWrIKk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D96D83977; Sun, 31 Aug 2025 18:50:46 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B41183965
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 18:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b2fe=3M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756659041; bh=veJVyWGNYTFx7XeueU/wLVfXG1DTv1olPrRa6hSUM/I=;
 b=CZgWrIKklRyHVv7OLDQcChDBYdzsACezdpk+3sVUmAp+ffDSYSzE1atreiwHyYQhe1/MVQGJ6
 CdoRRjnNgc+aA+umtEzQUiQKhLK9Kx8UxsiFza3eLTMS2K+3aM1ANcfedDOTPDImU5wqyVEN1EY
 OBoAO1e+4SxhqIxT//5VgmqpmXbGQ3m3V2WkDA4hfh/loW+H8vCJpNAfu9uHEFUgmtOYq8WJFbO
 TTzteRRnfRKpBlVZFVF5AQHlTTNxLL50e5YWhAU6mR32Ybu0mYo+6jiqooOtarDdvialk8N76Pg
 Ixr4An9jSJ95i24O47HeYokMchOLlYoyEpl4paCIvNEg==
X-Forward-Email-ID: 68b47d607f68b507ca9c3a1d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.11
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
Subject: [PATCH v2 05/18] rockchip: odroid-go2: Use appropriate bootph props
Date: Sun, 31 Aug 2025 16:49:22 +0000
Message-ID: <20250831165001.2749711-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831165001.2749711-1-jonas@kwiboo.se>
References: <20250831165001.2749711-1-jonas@kwiboo.se>
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

GPIO devices are needed in U-Boot proper phase, sdmmc and sfc devices
are needed in SPL and pre-reloc phase.

Update bootph- props to match what boot phase devices are needed at.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Collect r-b tag
---
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
index df21747fad78..a27994e450c0 100644
--- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
@@ -27,22 +27,18 @@
 };
 
 &gpio0 {
-	bootph-all;
 	gpio-ranges = <&pinctrl 0 0 32>;
 };
 
 &gpio1 {
-	bootph-all;
 	gpio-ranges = <&pinctrl 0 32 32>;
 };
 
 &gpio2 {
-	bootph-all;
 	gpio-ranges = <&pinctrl 0 64 32>;
 };
 
 &gpio3 {
-	bootph-all;
 	gpio-ranges = <&pinctrl 0 96 32>;
 };
 
@@ -78,28 +74,30 @@
 };
 
 &sdmmc {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 
 	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
 	u-boot,spl-fifo-mode;
 };
 
 &sfc {
-	bootph-all;
+	bootph-some-ram;
 };
 
 &{/spi@ff3a0000/flash@0} {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &uart1 {
-	clock-frequency = <24000000>;
 	bootph-all;
+	clock-frequency = <24000000>;
 };
 
 &uart2 {
-	clock-frequency = <24000000>;
 	bootph-all;
+	clock-frequency = <24000000>;
 };
 
 &xin24m {
-- 
2.51.0

