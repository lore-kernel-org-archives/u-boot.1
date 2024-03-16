Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49504C54E68
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 22:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85B0A8807F;
	Sat, 16 Mar 2024 23:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="DEkgdAs+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6902288094; Sat, 16 Mar 2024 23:57:29 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C5E87B30
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 23:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b2e=KX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710629834; bh=HObmgaY4Lfbo1sOi4xWF1GEjNprbtKLyp3i7+tiG8iQ=;
 b=DEkgdAs+jwDeMupdsGcoBv7ou8ePsyoMoNPXS3z1ofBf9v+wZxq5d7gbX88fiig/ROShLkzU+
 UBrkgI/Zo1o8ylDnGNsh58MfEB3FI5NusmwygxkakksgBeAS1MN3uywNYxxo9FCXhm3d1Pz5wUc
 P5iPj/YECIDaQg7QURLvQm8R6BTT3jnK+9KPRmJBbIQ9OK76iYByPD2B5SPfjitptMBvqdvWRkE
 RmwMXHllC6ja8u0Chu9IdhsB3J9d7+RxkTQOEj1yYnxVbL3dCxk48ig2pAtLKCjE5v2lK6HSGlJ
 CI8MB4dcjnn44XfjADSSSGGgkTbPhbNup82GuAgAgSeA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 04/13] rockchip: rk3308: Generate ethaddr based on cpu id
Date: Sat, 16 Mar 2024 22:56:30 +0000
Message-ID: <20240316225655.3244348-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240316225655.3244348-1-jonas@kwiboo.se>
References: <20240316225655.3244348-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f623c90957eaab7babfcc3
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

Like other Rockchip SoCs the RK3308 has cpu id programmed into OTP
memory. The rockchip_otp driver already support the RK3308 variant.
However, the device tree is missing a node to enable use of OTP.

Add the missing otp node to soc u-boot.dtsi, enable the rockchip_otp
driver and enable use of misc_init_r() to set ethaddr based on cpu id.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3308-u-boot.dtsi | 11 +++++++++++
 arch/arm/mach-rockchip/Kconfig  |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
index db2c20a7055e..396fefb743cf 100644
--- a/arch/arm/dts/rk3308-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-u-boot.dtsi
@@ -10,6 +10,17 @@
 		mmc0 = &emmc;
 		mmc1 = &sdmmc;
 	};
+
+	otp: nvmem@ff210000 {
+		compatible = "rockchip,rk3308-otp";
+		reg = <0x0 0xff210000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		cpu_id: id@7 {
+			reg = <0x07 0x10>;
+		};
+	};
 };
 
 &cru {
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 71c5945b5742..6e07a70bf4ae 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -163,7 +163,10 @@ config ROCKCHIP_RK3308
 	imply ARMV8_CRYPTO
 	imply ARMV8_SET_SMPEN
 	imply LEGACY_IMAGE_FORMAT
+	imply MISC
+	imply MISC_INIT_R
 	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_OTP
 	imply SPL_CLK
 	imply SPL_FIT_SIGNATURE
 	imply SPL_RAM
-- 
2.43.2

