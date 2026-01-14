Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B3CD31A28
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 08:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE7C483885;
	Wed, 14 Jan 2026 09:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="sgkAESPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E3580C93; Wed, 14 Jan 2026 09:28:37 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1FB7836D3
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 09:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
 bh=T7mF5A6qUp0PlWQ+Hv6iWG8n2ERM54sSnPLkEA6En8I=; b=sgkAESPVCrqKFiy+Mv/cpAzxwV
 caxFOaVtcD8d7OdADqUdLANJj2uMqycHx/WS6GLIiEbmyaIE7ldDhlX44yeu1Xg6IpdU9A8Cs5aZ4
 MT638pbJFs5vGL4QWpwBIJA2KgeYdbunK19AAOAPlPoqYoyw4qfetB7yMAjlNhY451i75OeAnjNWJ
 m7zc2f8aGL1iEJ0WBy0aGf1yGWHb6nvFmPj3hPWwE0Evn+ZdC/yqCWcBFZOGRfO9DGSi8VG4b6XEB
 NvGemMTchT8zjEC74Ksq7DkF4a27tLi9NWvQbOyB5QsXyTgBWkM1xVmzy5jgqDA/9QVaDArToE3uj
 kLNjyMOQ==;
Received: from i53875b96.versanet.de ([83.135.91.150] helo=phil..)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1vfwEx-002G0M-2c; Wed, 14 Jan 2026 09:28:31 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de,
	trini@konsulko.com,
	u-boot@lists.denx.de
Subject: [PATCH v2 08/12] arm64: dts: rockchip: describe mcu eeprom cells on
 rk3568-ts433
Date: Wed, 14 Jan 2026 09:28:18 +0100
Message-ID: <20260114082822.4007128-9-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20260114082822.4007128-1-heiko@sntech.de>
References: <20260114082822.4007128-1-heiko@sntech.de>
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

The MCU's eeprom contains the unit's serial and a number of slots for
mac-addresses. As the MCU seems to be used in different devices, up to
8 mac addresses can live there and the unused slots are actually
initialized with empty mac-address strings like 00:00:00:00:05:09 .

Interestingly on the TS-433, the PCIe ethernet adapter brings its own
memory to hold its mac, and the gmac0 is supposed to get its mac from
the second mac-slot, while the first one stays empty.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20251112214206.423244-3-heiko@sntech.de

[ upstream commit: 81f116991433d2547d7f350873cb4511ebcd4fec ]

(cherry picked from commit 51b234a762b64dd4d8b1f338b4abbcf7cfc748a4)
---
 .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index 5656554ca28..224db87973b 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -655,6 +655,68 @@
 			#cooling-cells = <2>;
 			cooling-levels = <0 64 89 128 166 204 221 238>;
 		};
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			serial-number@0 {
+				reg = <0x0 0x13>;
+			};
+
+			ext-port@22 {
+				reg = <0x22 0x2>;
+			};
+
+			mac0: mac@24 {
+				compatible = "mac-base";
+				reg = <0x24 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac1: mac@35 {
+				compatible = "mac-base";
+				reg = <0x35 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac2: mac@46 {
+				compatible = "mac-base";
+				reg = <0x46 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac3: mac@57 {
+				compatible = "mac-base";
+				reg = <0x57 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac4: mac@68 {
+				compatible = "mac-base";
+				reg = <0x68 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac5: mac@79 {
+				compatible = "mac-base";
+				reg = <0x79 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac6: mac@8a {
+				compatible = "mac-base";
+				reg = <0x8a 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac7: mac@9b {
+				compatible = "mac-base";
+				reg = <0x9b 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+		};
 	};
 };
 
-- 
2.47.2

