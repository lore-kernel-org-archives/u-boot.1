Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FC2C3ABC3
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 01:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F5AE82A25;
	Sun, 11 May 2025 03:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85D878295C; Sun, 11 May 2025 03:10:20 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4F33D80F54
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 03:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C48A126A4;
 Sat, 10 May 2025 18:10:06 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D3353F58B;
 Sat, 10 May 2025 18:10:16 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Philippe Simons <simons.philippe@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 4/6] arm64: dts: allwinner: a100: set maximum MMC frequency
Date: Sun, 11 May 2025 02:10:01 +0100
Message-ID: <20250511011003.15654-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250511011003.15654-1-andre.przywara@arm.com>
References: <20250511011003.15654-1-andre.przywara@arm.com>
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

The manual for the Allwinner A133 SoC mentions that the maximum
supported MMC frequency is 150 MHz, for all of the MMC devices.

Describe that in the DT entry, to help drivers setting the right
interface frequency.

Fixes: fcfbb8d9ec58 ("arm64: allwinner: a100: Add MMC related nodes")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Link: https://patch.msgid.link/20250505202416.23753-1-andre.przywara@arm.com
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 dts/upstream/src/arm64/allwinner/sun50i-a100.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dts/upstream/src/arm64/allwinner/sun50i-a100.dtsi b/dts/upstream/src/arm64/allwinner/sun50i-a100.dtsi
index f9f6fea03b7..bd366389b23 100644
--- a/dts/upstream/src/arm64/allwinner/sun50i-a100.dtsi
+++ b/dts/upstream/src/arm64/allwinner/sun50i-a100.dtsi
@@ -252,6 +252,7 @@
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins>;
+			max-frequency = <150000000>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -267,6 +268,7 @@
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc1_pins>;
+			max-frequency = <150000000>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -282,6 +284,7 @@
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc2_pins>;
+			max-frequency = <150000000>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.46.3

