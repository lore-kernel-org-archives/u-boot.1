Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D54C36017
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3014A81F59;
	Wed,  2 Apr 2025 00:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DZtLipjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5E8180F6B; Wed,  2 Apr 2025 00:52:45 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E02D382012
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so4968537f8f.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743547963; x=1744152763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9PcaSA3Jt90i7Z/+N2YN2ThKaJQeJUBMTCBWI7mOMyI=;
 b=DZtLipjZbfBsxff96uDq4ZMNuEtUzz1kItOZmQKalJufjzMCquVni+F9qbYPrCGXmR
 q3S83M/EbQwKoehDdTk6gcz01EkM69s2KOJZxcxdAHGn6u2pDpTR+Vfb7siE23Cr/tDc
 CscOG7ZPJq/7/EsxKgCVGVJPV+nTKKmkWFO5rNIlcRAUDvoAtNY8/e+3UEMFj9xm3NKA
 9hWTqSRpfONYwf1YvhNNG09NIOtocDkGYctwsWO53kn9QL+Y7WMT7ziwsd2mgSFsCqvJ
 zg6fn1XGccbJ1HKc3xJE/qOrF+xZT1zQpijT6fo9Pm/UVpxF0a7H8kVm8YfBAAsS3BI5
 EOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743547963; x=1744152763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9PcaSA3Jt90i7Z/+N2YN2ThKaJQeJUBMTCBWI7mOMyI=;
 b=mrLDonndkn36Evb3xSSCwCMk9loTbragFvDe7bEO4D+CmKABYG7E4vsoQ/ET+n0bm3
 +FT6MUb8354IimK1kYMsHsaVkVZizRfzC2KImb1wni+syf7lM8xft8mpyKAkkGTcBc/W
 SKG2lVWzM6mSYY1lr6mDW01hinCuZqSu+JaJ13IvTB8fVMFxPXo8mXPkMCEKV+Nkbvr3
 GNrLLDmzwxfFE1enWwfs9noNtWACB7ZHieU1VqBe45oFzIeL4rqA5idcCsN6dSY7U0AY
 +Lczn73nF4DHPx1ox5aIv/koxO0iJgMd6PneNnmFRGeEYLOQ0htNCEJgKBplVsAk1ZnX
 lIcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW49nLLTeVMSEltR89xlY/bHRCIgtJFPwmG9PUJvUqRyLhUdl7tkVy6qP7vXUT8hN4xG4Ul8os=@lists.denx.de
X-Gm-Message-State: AOJu0Yw779V93TmlsZEPcrNV3mls3DhTmF/qIIZI4v5PEQqOcB3oGPuO
 ewos3cUnmnoXGAv9b91IBIB/CFKhfnklX0CF1yc3q1Ej2N+Pd3T9
X-Gm-Gg: ASbGncsMwSEk1JgUsyVfSmKwqVunWPvv1vDZGG/wcNV4JPWb8akZKeWP1ztKYDkgXve
 6SvdVk16XDiG1JbkrF8jUrzE5xpxrTZ/+bYk7/MBl4EgNeZrj4tKa58kycnf5z0EgzaAffx9YcP
 a1AYgRl9I8nLHQoLP1LghLlZgqH/84qZa4CT3UzW/Uszj8YfmA23iMZCHk3mR1cdZQL00nc1IK6
 JS72vI2NL+JJ5u8NH4M4JMub8xQ3e2Fk5hPEGURrL84pOnG8SNxcphfnnnqs1U0+trSwpxuO55G
 Fdf2S44jNgwrmq22bYYwS4jFGEbB5WL6fJ8nSrRJClD3rJxLmHV+tSFbfNAFaChTGKPZ3L3F1WZ
 jcA6cfiXF7nT+zktWRzKjUotK
X-Google-Smtp-Source: AGHT+IFnNPZdRXx5K9FSRXFZt1WnzoQo+B5skyDB1lf++x8Jv6duns5NAgs/LIhY/pZFTw1imbL6fQ==
X-Received: by 2002:a05:6000:18af:b0:390:f4f9:8396 with SMTP id
 ffacd0b85a97d-39c120e3498mr11211394f8f.28.1743547963244; 
 Tue, 01 Apr 2025 15:52:43 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd77bsm2478625e9.19.2025.04.01.15.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:52:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH 06/14] arch: arm: dts: an7581: Add eMMC nodes
Date: Wed,  2 Apr 2025 00:51:38 +0200
Message-ID: <20250401225156.25790-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401225156.25790-1-ansuelsmth@gmail.com>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
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

Add eMMC nodes with the fixed regulator and fixed clock. It's also
needed to assign the clock and set it to 200MHz as it's set to 150Mhz by
default.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7581-u-boot.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index a569044195d..46526ff0f0f 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -14,6 +14,21 @@
 		};
 	};
 
+	clk25m: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "clkxtal";
+	};
+
+	vmmc_3v3: regulator-vmmc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	soc {
 		chip_scu: syscon@1fa20000 {
 			compatible = "airoha,en7581-chip-scu", "syscon";
@@ -43,6 +58,24 @@
 			compatible = "airoha,en7581-switch";
 			reg = <0 0x1fb58000 0 0x8000>;
 		};
+
+		mmc0: mmc@1fa0e000 {
+			compatible = "mediatek,mt7622-mmc";
+			reg = <0x0 0x1fa0e000 0x0 0x1000>,
+				<0x0 0x1fa0c000 0x0 0x60>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scuclk EN7581_CLK_EMMC>, <&clk25m>;
+			clock-names = "source", "hclk";
+			bus-width = <4>;
+			max-frequency = <52000000>;
+			vmmc-supply = <&vmmc_3v3>;
+			disable-wp;
+			cap-mmc-highspeed;
+			non-removable;
+
+			assigned-clocks = <&scuclk EN7581_CLK_EMMC>;
+			assigned-clock-rates = <200000000>;
+		};
 	};
 };
 
-- 
2.48.1

