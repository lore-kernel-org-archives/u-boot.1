Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A5DC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5965B880AD;
	Mon,  8 Apr 2024 20:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kgNVVm6Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD7168811C; Mon,  8 Apr 2024 20:14:59 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD6E880AD
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 20:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d79=LO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1712600088; bh=tmFA48QK1rSazIGVuasVDc9P8V4cBIS+VUTzhPUn8Iw=;
 b=kgNVVm6YDkgwrgE7mzWh0MiYEYzJHitIOKmq46OU1DCx76vDxdN2Vl5TCRx9ExTKllRe+qJmk
 gTG7S8ObabvMm2XllnUazlr7Gg/GDSLK1HCSHEbY4VT+z9wOrNDX2r/v8dV0ADomBz7TkkfOH2N
 RucmOt/fN6AluQO+1Ay3G8UaAbvogqrephXrGGFqXly92PQXwea0/vWFJ29l9V73wAV1Z1FxR+e
 NWW1padJ9kbljDfZgaljdeEKXCpBsQdS/xGQWY5t2Mqay7TxQGWVXXuw23BFHhmF8dd2jER3lb7
 uAm36+gNXk04jUR64lpm7xAulc2gCoZUXFkNPI4sRVXw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 04/14] rockchip: rk3308: Generate ethaddr based on cpu id
Date: Mon,  8 Apr 2024 18:14:01 +0000
Message-ID: <20240408181429.3676856-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240408181429.3676856-1-jonas@kwiboo.se>
References: <20240408181429.3676856-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6614341745fff4c2aa5b4a31
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
v2: Add clocks and resets props
---
 arch/arm/dts/rk3308-u-boot.dtsi | 16 ++++++++++++++++
 arch/arm/mach-rockchip/Kconfig  |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
index db2c20a7055e..436f66d1b87d 100644
--- a/arch/arm/dts/rk3308-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-u-boot.dtsi
@@ -10,6 +10,22 @@
 		mmc0 = &emmc;
 		mmc1 = &sdmmc;
 	};
+
+	otp: nvmem@ff210000 {
+		compatible = "rockchip,rk3308-otp";
+		reg = <0x0 0xff210000 0x0 0x4000>;
+		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
+			 <&cru PCLK_OTP_PHY>;
+		clock-names = "otp", "apb_pclk", "phy";
+		resets = <&cru SRST_OTP_PHY>;
+		reset-names = "phy";
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

