Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD178C369A1
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 157B2830E9;
	Mon,  7 Apr 2025 22:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kV/AoQuv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F1C083100; Mon,  7 Apr 2025 22:02:43 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D71A830E3
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4394a823036so44579115e9.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056161; x=1744660961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9PcaSA3Jt90i7Z/+N2YN2ThKaJQeJUBMTCBWI7mOMyI=;
 b=kV/AoQuvtsXnqASWqeZf0JS4rmvHVsaEJUr9V4kfHPy+5TYEe4c6VYy1LkODkgC/Iz
 xqr2CYEj9IIC3A/F6SZIK3BAlMwUOKWcPoNR1gRn+HsCROdxx9gORpHvR3N0vjUweLNx
 xdLw9F7SuuGNAliND6XbVzfSd58h/n55KhaguOe/xjASwyuQkC9hoKKTkX5sus/HS8xw
 3k6/XCZqwEq6YclBnoj1mreIe1T/9zl1/PkurQq81JXwClcoUL0IXpzSLs8g0Tq/zbNY
 Uk6Es8wFwAgAhXtu0Y3+/my19eqhF6YIkxh8kDzv8SJk6d6n9FuXGbiafQDwPtNqCDOD
 tfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056161; x=1744660961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9PcaSA3Jt90i7Z/+N2YN2ThKaJQeJUBMTCBWI7mOMyI=;
 b=T10c9DQf36K1CCtFnuslKLOflotkd8EGdUj6dSWeD7oTpXrmCraz3tuD9d9B4dxNqr
 XmjY474uApS8UFldZkgwI/LYHkfEjzDr6bF+fe3gOaK5nzkAvmah0h6PZcYyofFHr6b3
 HJaOYQeUw96rrN4y4+knYv1PoDuKlUM9Xgq2yqCrSl6pZtXKOW8a9aSqIz2PDcuNpkyE
 cleksQ00rMcy1t32WdZRhsm5lhEE9KjVHg/XN59TdgiQ2ZLc7RjlmLF5I0cylWVsRWst
 qUKM2u0EHs2dIOBVATljVU6KdApzzDZlAp1zhLA/ZDLDSjd8BCuQWI0W5r7/eD3xJUYg
 RBRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/V536YFDZ3xOoFzOKpN5o0fzOxWDj5v9rwbibYXOjUwrXRPtXXS8iii+70RvQaw2wk1YmpWc=@lists.denx.de
X-Gm-Message-State: AOJu0YwDkOgc900o+h/E0EIZKMNPxkZF8eKAS0JzurklSVptsR3J9LYU
 b9G+fhUrNPN6d3/PIlfdWLvz1+ahnFbojxaQUbHj4NyunnCerTmR
X-Gm-Gg: ASbGncvRtCTAW+NWGwHU/f+skZ7SHjtUuHgTx/76TrMpnyO/IkLEcTAwZ8tGGRuBhFS
 OhwXxh0p3unyLkb//6jVrnLqiBCsWqynV46zez5PhFnD0dET0q9cc2IAEdoWaUf1nbIPrmFffwV
 GzKSaAyjAgZwLIooUa9VlDYA/QnjUKKQNcF82OP9FNbyKhNvqVEpJ/lHRUPBqoXZzJ+eEz6hXDj
 dXwCR6lPvldC7TlNoItfhtIWTJdNk5IpISGRz9owGwp2LnAyFlG8B4LAXTKW8vM8KB4RLV6gbEP
 Hr9FiNakocnidhrAe4GQCP9DQZx5KUYoWHFrv4jTZ/+C5+s9HgSUj53jw2FAOeimA8ncDfT1rxs
 E2iQNte2OUnEPmA==
X-Google-Smtp-Source: AGHT+IH6l9+d+OXMuKDAmZ2Tqgpr+I4Krh2q32dHc8XYzPAtNBcQFKK+qBmfcEpGM0mZFlwh39FTnQ==
X-Received: by 2002:a05:600c:1c9d:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-43ee077fb74mr70672145e9.27.1744056160677; 
 Mon, 07 Apr 2025 13:02:40 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c301b9d55sm12723354f8f.42.2025.04.07.13.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 13:02:40 -0700 (PDT)
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
Subject: [PATCH v2 06/14] arch: arm: dts: an7581: Add eMMC nodes
Date: Mon,  7 Apr 2025 22:01:50 +0200
Message-ID: <20250407200208.25594-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200208.25594-1-ansuelsmth@gmail.com>
References: <20250407200208.25594-1-ansuelsmth@gmail.com>
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

