Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908EEC79F85
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 16:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2001980AA3;
	Sun,  6 Sep 2026 16:46:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k25858YpEJFR; Sun,  6 Sep 2026 16:46:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 20FB480AC4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788713204;
	b=PWxjHf4GKE4OR9RMtevlA8w3rctc0zIu3ZtVBE5iLNFGJAw7U/eUzpAlJ/JhorxLRKv7
	 cQUpPULUPehJTNFIfmHwfClBkPFt8SBYKeDkXJ2S6wwR9LDVAXVleMDsFZda1IdGVxxPQ
	 PFMNVTNsl/NhllTBCWzd09HnAdSfyrQwHvnZEw4PZN0WCLvMQDYyS1+ZamzVfmgOf1/du
	 izjQosKwlFGAQr10nYwyl70oMBAuHkRNSYZLMkl9zRXM0BLsb66unw1LNHg0rU3c1alXz
	 OrcPYht+lRGvPiIt3xBkeK39SYKuAJPOv7hLmD9HX3AihlvKIoKXrxLCzoymYig/y2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788713204;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bsOm4m7dzo1h9UbJK7F3gmIYWQxI1W7o0P3beaooLSg=;
	b=fInLGVLft3rcpGEwdE+oDB3DYvk4j9ubbJ/6gy+17QgcCc933tzeybzRq6O/xZNgf4Vm
	 CHxEM3nNXD6IEPJMwEiLlbUyKv1J9qPGpFFxSCTGJRqPaTwaxz1g4/38aW+biuOr7eNjy
	 NB75I+thHioBruzkCz63HDJHhzwEgtqocb0F+mtUtD+1Yh60lyfWS62/kAxslHNk8m5zc
	 cn4PpWI9v30gBvgcAzMb50tPBmP/+BuDFixkoCvQLbGopC2m3SyTMpqdKunbv7nlwOLXQ
	 rdevMi1EE9Qo7zvTOxRsB/CJ+TmkLF5gGfu3dY71VhC0xOZU0OA9TczhBmt84iRVNDQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cCqw0DD4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788713204;
	bh=bsOm4m7dzo1h9UbJK7F3gmIYWQxI1W7o0P3beaooLSg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cXgLNTjjM3NpTuYu18h6R2H6ga1/oYiyQeevW7mkZ8G76ggvQu9oeTvC4kRsRKILK
	 8R6GlpDL3TT8FKylMBhMuIoUIM2vCaj3v4MkrjEYZbokxc6ARwSkQNNJRkR4pHbVvy
	 cUsIPuPfp1nMgI3X/2SiAd5D8+zd9Zwmwuv0l3QG2e3VqJL/mqd5VK3sceiqKwmHZu
	 fizVL9qZEQF2jj2S6hRfjWaq86jKz++2tQn6pvZr7nR/nP7dkRrvwPkMHC1/mny+oD
	 o75PhFLJQouSmFHYTq+5AzqY2+IRGSiKeln22/YEdK9aaFt6SK5Gq1oAiHWzAVFpQ8
	 6SF/ac0/xl86g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20FB480AC4;
	Sun,  6 Sep 2026 16:46:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ECC4A118
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE24A80DBF
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QH85AHME-Poi for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 12:09:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C717A80D80
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788696549;
 b=QFeVNzgp3NiCMzUGWKOMXcUzzBnboF/NrPkLBSA8BDzJaR+g6O7T7d4/bLjFLhPv0B9r
 Tly+r5rJfAeZC3KAXBEQZqR3fNRe2l3et1lhOH2oxBlCsgeqnbbOPWc4c4VWpBAD0W/Ji
 TJUA79nJdrg1dvP+/QQvy703b45dCFLSI+eZ+jIJN+xU4nODhwqBjMpeKcT+vZyzJeUZp
 1SemdWTJ+bYYNMn2DpOaLaHEIa9hpXyC47hoHjhjouE4f0sO+TRswOOzMBKTMVzG04Yns
 7Pfu7P5e5r+U+wMkTu2MDmKi9iHRqs3emEouFPzzB1WK4pDaTsFQ+TrBFCo7ppQbG5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788696549;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=bsOm4m7dzo1h9UbJK7F3gmIYWQxI1W7o0P3beaooLSg=;
 b=c6HbDVv3/XOiXytFOndJJbg9AoEB5JXOQ7GEo4iKM0M5/xDZQ3TTX2IktuHfT3qGEQZV
 9VeFCHUq38c1FFpLCKNh6QISPDzu+GqOPQYX3boN9bSEcDmHZdljrsQofroz2gE3w2NwC
 xp5prsXI5dNn3pi8V5bYGu9WuFPoLDxPOJ3Hn26uw2jW3ki+K7LrzXSHhwGSDsSrPyrak
 gLsO6Xkc/kSnCa8SNq7yXyUfFDtJPdBzX4uapCBVJeAdJ58RXMWtt+N/PEqKhX+dC0FLM
 yRVZfzN80w+HHLIhyWTGa6W0YUP1eTupmEjiUJFWPQnI+r4TtMfu67IsXfePJiO4qJA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cCqw0DD4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=lucienzx159@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cCqw0DD4
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C717A80D80
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:09:09 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-381b831d535so4331608a91.0
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 05:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788696549; x=1789301349;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bsOm4m7dzo1h9UbJK7F3gmIYWQxI1W7o0P3beaooLSg=;
 b=cCqw0DD40xta9SrtUftnRmnOoUERLwd7YiNi7YRofII3BVFDoSGDDASCwh7KwNkv8i
 vH7wLggTgeSgfQspewng6wINZUfLVkH8CaOLhogJ4rnGSXLZXId7Gg1X70tuZUAaDvzt
 aLfKo6y3HKjsccIaNyYSGXi+aSvgTyyhu6ZhIOiTRp8Fg6R/h5p0xSIDp+9EFZ3HAPNn
 iySjMti+uRjgxc0c+ML5ZjKbdgb80iIC6cefhvBiP3Y+6kyY7hEU3KlsexsskEK2jmH4
 apRR/9y8xmIu2trhDe8/Vxi8slN+EHAMxXTYW0f90wtd/XpcZXeIfET86l0Lq6itK4d3
 nk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788696549; x=1789301349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bsOm4m7dzo1h9UbJK7F3gmIYWQxI1W7o0P3beaooLSg=;
 b=lP8MZxMFTwGspYFm+wCWmmECx4YeG/xrROZB+h16RFKYCS78edg73YiRIXZz2zjqXO
 ujJwT3a7/v7d0yXg6BIWJ8l2NyNlN4zalTY2WDVEa/KHJ5w+NcnDeh9OjKYT1YYrNSPs
 ObNCxZz3Q6OwBlaROhiCoUpQ5E7rBEXASmGlBDAsP480zFyPROAYagpO9QLyA/VlV4+b
 +jBkTf6PU9jKArbPtGXx49SuI2xbijzvNRcrO2aaz0XiFPptj0ZWx32ubKBteIhIK/E8
 j5hyW9CA9drtE8lwqqE83fQATlMnVRQJja9f8Z5KviWC0RT7ZM3WjulsNGErLCifUUZ2
 aHxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxclDoY9Or1Faacw82oYi6djwKM0XzeZrdoEq3+o+kZDdx+9AWRQ2cP5Bq03s2GYXj0NEXg2Zc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nBhkSk4sOTWHgpWIPVTp8bf4X4ENldxzRHs3/Gu2w7f04cTdIp
 nREdoE0zSN5hXKtRpA/aO3vfmu2CB4yW4hNm3FXF6Ups/8pQVr5PuSGNYmSssw==
X-Gm-Gg: AYBFou0VzJMJ+mNWe72aebTVzL/0ODPKAiB7pS9s/oAW8ML2wiobek27H7qye0HP2Hc
 uqHH0kMOnKS9UoPfhhnrXd3rQzOHIBc5W2xODKoWhsQToHdL778rvIPb+bFjYttKYAIJ8zkU2Od
 k9V6PUEovaootqWealj44T74y2tOVzI9NjWSbBcQecVILH+uzp8RdeGyYy2uB3c6oVe+EK1Wpfd
 jh3H5i50+GVpG99APftA1OWf15ibabrEKxlTGMY+Aojxr63pI5HYpGvRLIh6YiKXlZGCHXW+jya
 XteXg//oieYMbtaXHmcLoTXdHutuWTfJ4HRV7Ve0zbIYMIkjZi1pN6G3W/SOCoGHzKGYIw7n50V
 REHfj01a+jT+1mzSILB7JwD4uwf7C/yaFBpEqR0AV6SwFAkwmY86yAL0oKEt7aOfaBzT+AzuQrt
 8cFfVdshzHPjARD2uhJ7KD34C3XPw11PhR6qJSc9k5hx3sPsAfHsIjShaFIi6cpPWTIzdSs3KWl
 yNWweHlfoDtqDv/V3WGyUqvNzdEH2BXjqsNXsfeXe1Npj7AeYudQQ2iQGU=
X-Received: by 2002:a17:90b:3943:b0:398:d8eb:cb2a with SMTP id
 98e67ed59e1d1-39b26273e31mr28864837a91.23.1788696548627; 
 Sun, 06 Sep 2026 05:09:08 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08bcc060sm23976996a91.3.2026.09.06.05.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 05:09:08 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 igor.belwon@mentallysanemainliners.org, dlechner@baylibre.com,
 jstephan@baylibre.com, GSS_MTK_Uboot_upstream@mediatek.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, jbx6244@gmail.com,
 msp@baylibre.com, u-boot@lists.u-boot-project.org
Cc: frank-w@public-files.de, daniel@makrotopia.org, lucienzx159@gmail.com,
 skylake.huang@mediatek.com
Subject: [PATCH v1] arm: mediatek: add BPi-R3 Mini eMMC board support
Date: Sun,  6 Sep 2026 20:07:56 +0800
Message-Id: <20260906120756.8290-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 06 Sep 2026 16:46:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add device tree and defconfig for the Bananapi BPi-R3 Mini, an
eMMC-only variant of the BPi-R3 board built around the MT7986A SoC.

The board dtsi enables the MT7986 eMMC controller, SPI-NAND flash,
PWM, and the on-board Airoha EN8811H 2.5G PHY via mdio.

The mt7986a_bpir3_mini_emmc_defconfig enables the drivers needed for
this variant: SPI-NAND (MTD/UBI), USB xHCI, PCIe Gen3 with NVMe, the
Airoha EN8811H PHY driver, and RNG/pstore support.

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
 arch/arm/dts/Makefile                     |   1 +
 arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts | 236 ++++++++++++++++++++++
 configs/mt7986a_bpir3_mini_emmc_defconfig | 139 +++++++++++++
 3 files changed, 376 insertions(+)
 create mode 100644 arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts
 create mode 100644 configs/mt7986a_bpir3_mini_emmc_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 1b533721bb4..b62a4334750 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1080,6 +1080,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7981-sd-rfb.dtb \
 	mt7986a-bpi-r3-sd.dtb \
 	mt7986a-bpi-r3-emmc.dtb \
+	mt7986a-bpi-r3-mini-emmc.dtb \
 	mt7986a-rfb.dtb \
 	mt7986b-rfb.dtb \
 	mt7986a-sd-rfb.dtb \
diff --git a/arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts b/arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts
new file mode 100644
index 00000000000..18320b20be8
--- /dev/null
+++ b/arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/dts-v1/;
+#include "mt7986.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	model = "Bananapi BPi-R3 Mini";
+	compatible = "mediatek,mt7986", "mediatek,mt7986-rfb";
+
+	chosen {
+		stdout-path = &uart0;
+		tick-timer = &timer0;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x80000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-reset {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&pio 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		status_led: led-0 {
+			label = "green:status";
+			gpios = <&pio 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-1 {
+			label = "blue:wlan2g";
+			gpios = <&pio 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-2 {
+			label = "blue:wlan5g";
+			gpios = <&pio 2 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&eth {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins>;
+
+	mediatek,gmac-id = <0>;
+	phy-mode = "2500base-x";
+	phy-handle = <&phy14>;
+
+	phy14: eth-phy@14 {
+		compatible = "ethernet-phy-id03a2.a411";
+		reg = <14>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&en8811_pwr_a>;
+		airoha,pnswap-rx;
+
+		reset-gpios = <&pio 49 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <20000>;
+	};
+
+	/*phy15: eth-phy@15 {
+		compatible = "ethernet-phy-id03a2.a411";
+		reg = <15>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&en8811_pwr_b>;
+		airoha,pnswap-rx;
+
+		reset-gpios = <&pio 47 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <20000>;
+	};*/
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_default>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	non-removable;
+	status = "okay";
+};
+
+&pio {
+	en8811_pwr_a: en8811-pwr-a {
+		pins = "GPIO_11";
+		drive-strength = <MTK_DRIVE_8mA>;
+		bias-pull-down = <MTK_PUPD_SET_R1R0_11>;
+		output-low;
+	};
+
+	en8811_pwr_b: en8811-pwr-b {
+		pins = "GPIO_12";
+		drive-strength = <MTK_DRIVE_8mA>;
+		bias-pull-down = <MTK_PUPD_SET_R1R0_11>;
+		output-low;
+	};
+
+	mdio_pins: mdio-pins {
+		mux {
+			function = "eth";
+			groups = "mdc_mdio";
+		};
+	};
+
+	mmc0_pins_default: mmc0default {
+		mux {
+			function = "flash";
+			groups =  "emmc_51";
+		};
+
+		conf-cmd-dat {
+			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
+			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
+			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		conf-clk {
+			pins = "EMMC_CK";
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		conf-dsl {
+			pins = "EMMC_DSL";
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		conf-rst {
+			pins = "EMMC_RSTB";
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	spi_flash_pins: spi0-pins-func-1 {
+		mux {
+			function = "flash";
+			groups = "spi0", "spi0_wp_hold";
+		};
+
+		conf-pu {
+			pins = "SPI2_CS", "SPI2_HOLD", "SPI2_WP";
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_11>;
+		};
+
+		conf-pd {
+			pins = "SPI2_CLK", "SPI2_MOSI", "SPI2_MISO";
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_11>;
+		};
+	};
+
+	pwm_pins: pwm0-pins-func-1 {
+		mux {
+			function = "pwm";
+			groups = "pwm0";
+		};
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pins>;
+	status = "okay";
+};
+
+&spi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_flash_pins>;
+	status = "okay";
+	must_tx;
+	enhance_timing;
+	dma_ext;
+	ipm_design;
+	support_quad;
+	tick_dly = <1>;
+	sample_sel = <0>;
+
+	spi_nand@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		spi-max-frequency = <52000000>;
+	};
+
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&watchdog {
+	status = "disabled";
+};
diff --git a/configs/mt7986a_bpir3_mini_emmc_defconfig b/configs/mt7986a_bpir3_mini_emmc_defconfig
new file mode 100644
index 00000000000..411ad11d6a7
--- /dev/null
+++ b/configs/mt7986a_bpir3_mini_emmc_defconfig
@@ -0,0 +1,139 @@
+CONFIG_ARM=y
+CONFIG_ARM_SMCCC=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x41e00000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x80000
+CONFIG_ENV_OFFSET=0x300000
+CONFIG_DEFAULT_DEVICE_TREE="mt7986a-bpi-r3-mini-emmc"
+CONFIG_TARGET_MT7986=y
+CONFIG_DEBUG_UART_BASE=0x11002000
+CONFIG_DEBUG_UART_CLOCK=40000000
+CONFIG_SYS_LOAD_ADDR=0x46000000
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="mt7986a-bpi-r3-mini-emmc"
+CONFIG_LOGLEVEL=7
+CONFIG_LOG=y
+CONFIG_SYS_PROMPT="BPI-R3M> "
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=1049
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_UNLZ4 is not set
+# CONFIG_CMD_UNZIP is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_GPT_RENAME=y
+CONFIG_CMD_LSBLK=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_READ=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_SMC=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_MTK=y
+CONFIG_PHY_FIXED=y
+CONFIG_DM_MDIO=y
+CONFIG_MEDIATEK_ETH=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT7986=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MTK_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_FAT_WRITE=y
+CONFIG_HEXDUMP=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_LMB_MAX_REGIONS=64
+
+CONFIG_AUTOBOOT=y
+#CONFIG_BOOTDELAY=2
+
+CONFIG_FIT=y
+CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
+CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="uEnv_r3.txt"
+CONFIG_HUSH_PARSER=y
+
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_UBI=y
+CONFIG_CMD_UBI=y
+CONFIG_CMD_UBIFS=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_MTK_SPIM=y
+#CONFIG_MTK_SPI_NAND=y
+#CONFIG_MTK_SPI_NAND_MTD=y
+#CONFIG_MTK_SNOR=y
+#CONFIG_MTK_SNFI_SPI=y
+CONFIG_SPI_FLASH=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_CMD_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_CMD_SF=y
+#CONFIG_MTD_RAW_NAND=y
+#CONFIG_CMD_NAND=y
+#CONFIG_CMD_NAND_TRIMFFS=y
+CONFIG_ENABLE_NAND_NMBM=y
+CONFIG_MTDIDS_DEFAULT="nmbm0=nmbm0"
+CONFIG_MTDPARTS_DEFAULT="nmbm0:1024k(bl2),512k(u-boot-env),2048k(factory),2048k(fip),65536k(ubi)"
+CONFIG_PHY=y
+CONFIG_PHY_MTK_TPHY=y
+CONFIG_DM_USB=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_MTK=y
+CONFIG_CMD_USB=y
+CONFIG_USB_STORAGE=y
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_STRINGS=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_CMD_BOOTMENU=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+
+CONFIG_FS_LOADER=y
+CONFIG_PHY_AIROHA=y
+CONFIG_PHY_AIROHA_EN8811=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_AIROHA_FW_BUILTIN=y
+CONFIG_PHY_ETHERNET_ID=y
+
+CONFIG_PCI=y
+CONFIG_PCIE_MEDIATEK_GEN3=y
+CONFIG_CMD_PCI=y
+CONFIG_NVME_PCI=y
+CONFIG_NVME=y
+CONFIG_CMD_CACHE=y
+
+CONFIG_CMD_PSTORE=y
+CONFIG_CMD_PSTORE_MEM_ADDR=0x42ff0000
+CONFIG_CMD_PSTORE_RECORD_SIZE=0x1000
+#CONFIG_CMD_PSTORE_CONSOLE_SIZE=0x1000
+#CONFIG_CMD_PSTORE_FTRACE_SIZE=0x0
+#CONFIG_CMD_PSTORE_PMSG_SIZE=0x1000
+
+CONFIG_DM_RNG=y
+CONFIG_RNG_MTK_V2=y
+CONFIG_CMD_RNG=y
--
2.34.1

