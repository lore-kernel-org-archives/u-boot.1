Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FA7C369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 22:12:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B0E28318F;
	Wed,  9 Apr 2025 00:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="mpcY23AT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC1B8801BE; Wed,  9 Apr 2025 00:12:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8AF8343B
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 00:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6bf1=W3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744150324; bh=rMt3U9chego1zZUD+rbfd5ClpT1dwBh9ct9WkqCGnW4=;
 b=mpcY23ATC/wv2IZay6xrYRSUPnOaE3eyijSRosreoLjJ7Y81FQBNW05imXwuYdIr/hJLJIbB1
 7fuvNLZ8C8Q6pZE3e5V5A1tAFVMR+KmG0VhqlhMbJ2pe6MbUsOIsjGPQNgUsRK8bzf97xbhrkWD
 AxF1vlNRE6fknE2HlIZDL1uElgGP6Zh2cpA6DyA7I+PCneg7/xeNxc50rxoRSJsz39MVUYD0gfo
 SAZlLSiYHBurnAe51AGhFp156j2mbC5hkilsoPlz2Unb5H6GcLWFA7gBK5RItxd2Q/okWFdF+eC
 NVMCaEz0Ad/Vy8EWjwgJHKrjlGihUAFOj6CVrmP02Dtg==
X-Forward-Email-ID: 67f59f329e1b52744186acba
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/4] rockchip: rk356x: Remove rng node from u-boot.dtsi
Date: Tue,  8 Apr 2025 22:11:43 +0000
Message-ID: <20250408221151.2762853-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408221151.2762853-1-jonas@kwiboo.se>
References: <20250408221151.2762853-1-jonas@kwiboo.se>
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

Linux commit afeccc408496 ("arm64: dts: rockchip: add DT entry for RNG
to RK356x") merged for v6.12-rc1 add a proper rng node to the SoC DT.

Remove the rng node from SoC u-boot.dtsi now that the rng driver support
the compatible used in dts/upstream DT. Ensure the rng node is enabled
to support rng on RK3566 variants.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Split SoC u-boot.dtsi change into own patch
---
 arch/arm/dts/rk356x-u-boot.dtsi | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index 24a976cf7e21..871869739536 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -21,11 +21,6 @@
 		bootph-all;
 	};
 
-	rng: rng@fe388000 {
-		compatible = "rockchip,cryptov2-rng";
-		reg = <0x0 0xfe388000 0x0 0x2000>;
-	};
-
 	otp: nvmem@fe38c000 {
 		compatible = "rockchip,rk3568-otp";
 		reg = <0x0 0xfe38c000 0x0 0x4000>;
@@ -121,6 +116,10 @@
 	bootph-all;
 };
 
+&rng {
+	status = "okay";
+};
+
 &sdhci {
 	bootph-pre-ram;
 	bootph-some-ram;
-- 
2.49.0

