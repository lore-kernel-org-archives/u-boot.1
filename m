Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF69FC48260
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 00:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E74C87EE0;
	Sat, 17 Feb 2024 01:28:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RtM+krpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B803487E6F; Sat, 17 Feb 2024 01:27:17 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC7CD87EAE
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 01:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4c2a=J2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708129451; bh=4LXQnM/g9ii4+RnBMP5V5jS1Xw3k9vrpJ4WXpQdEYSE=;
 b=RtM+krpGBH6JQvKoF+DgJB2aLpyO0VGmsOUlIoo79nWE5KT/uWZewxGRhUgQyALvvsbN6AzSt
 yL9zUQm7JvJnDKUNYz4ugHfpYRioq07DitScZ1cNOO/PUT06FPcDIyVmaJWW+hE8rVWa1qrEUr7
 ePp/hkmMJZN5BlBLKM4qLK8cFOvIo0nwdXTgMGuqObmYuGtywhFkKaaMHy6ryhgNtPOQ/h4ClDC
 0bRzb/fhU2aIo2E/u/eJA48RsTm2N0FnHXzO9sjyA2As4EizdMWTK6PVvcMauZ4CpwY/iiNA9/B
 VeqKDMT+F2LS0W7F26XJsMeuWj3KEllIEZktSFbOOv2w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 13/15] rockchip: rk3328: Add support to build bootable SPI
 image
Date: Sat, 17 Feb 2024 00:22:39 +0000
Message-ID: <20240217002304.2141064-14-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217002304.2141064-1-jonas@kwiboo.se>
References: <20240217002304.2141064-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65cffca9bb96cee8b5411f69
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

Similar to RK35xx the BootRom in RK3328 can read all data and look for
idbloader at 0x8000, same as it does for SD and eMMC.

Use the rksd format and modify the mkimage offset to generate a bootable
u-boot-rockchip-spi.bin that can be written to 0x0 of SPI NOR flash.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- No change
---
 arch/arm/dts/rk3328-u-boot.dtsi        | 11 +++++++++++
 arch/arm/mach-rockchip/rk3328/rk3328.c |  1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index a030f1a5e51d..4d43fe2fb51a 100644
--- a/arch/arm/dts/rk3328-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-u-boot.dtsi
@@ -133,3 +133,14 @@
 &usb20_otg {
 	hnp-srp-disable;
 };
+
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
+			offset = <0x8000>;
+		};
+	};
+};
+#endif
diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c b/arch/arm/mach-rockchip/rk3328/rk3328.c
index b591d38fe412..b82b209de9e2 100644
--- a/arch/arm/mach-rockchip/rk3328/rk3328.c
+++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
@@ -36,6 +36,7 @@
 
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff520000",
+	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff190000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/mmc@ff500000",
 };
 
-- 
2.43.0

