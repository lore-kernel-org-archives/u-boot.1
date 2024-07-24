Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CDBC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 07:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB19887F5;
	Wed, 24 Jul 2024 09:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="p5AqP24L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF27C887F5; Wed, 24 Jul 2024 09:44:30 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 509DD88829
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 09:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=SRS0=3f2b=OY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1721807059;
 bh=jcQ9nWiAYkpmKA+PlG7YjZoX9XheKFBRf6BAeVRXPwE=;
 b=p5AqP24Lse9UyVKcHq4FHqZHwT2O5p/9NW7ugsp/1wWktFZR6yCTYfG1p8bAcjMJTsZxSbHZw
 ebK3PMX1nXK4V5IrlWUfREFURu/ANmX/MdbWjJvD14hK17b2FCJhJRRwrMZ+w5H2YKUU40aX3JT
 tguwZ2dwopg/P4sjOFwbobRnv7TNPOkDKGtTIa5YiLRpgd02mI5s+GMBYR2+yLhl5SupYx5BY8H
 d8nMSk04Ws8IxECrLtDFEOxNhM/66bBLRdswMdZSM3zvf08+pnHOyQbpqbJHpixhebZRMKQm27P
 KJaMl9iHO4It3kUsyO6v3Oc1171zPeoD0FVwkGbHfqaA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3308: Update otp node in u-boot dtsi to match
 v6.11-rc1
Date: Wed, 24 Jul 2024 07:44:07 +0000
Message-ID: <20240724074409.2758552-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a0b0ce78718bd2bf1d4b89
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

The merged upstream DT node for OTP differs slightly, update node in
rk3308-u-boot.dtsi to match Linux kernel v6.11-rc1 in order to reduce
possible issue in future when devicetree-rebasing v6.11-dts is merged.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3308-u-boot.dtsi | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
index 684fa7abddb1..82b522eef8ec 100644
--- a/arch/arm/dts/rk3308-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-u-boot.dtsi
@@ -21,20 +21,28 @@
 		bootph-all;
 	};
 
-	otp: nvmem@ff210000 {
+	otp: efuse@ff210000 {
 		compatible = "rockchip,rk3308-otp";
 		reg = <0x0 0xff210000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
 			 <&cru PCLK_OTP_PHY>;
 		clock-names = "otp", "apb_pclk", "phy";
 		resets = <&cru SRST_OTP_PHY>;
 		reset-names = "phy";
-		#address-cells = <1>;
-		#size-cells = <1>;
 
 		cpu_id: id@7 {
 			reg = <0x07 0x10>;
 		};
+
+		cpu_leakage: cpu-leakage@17 {
+			reg = <0x17 0x1>;
+		};
+
+		logic_leakage: logic-leakage@18 {
+			reg = <0x18 0x1>;
+		};
 	};
 
 	rng: rng@ff2f0000 {
-- 
2.45.2

