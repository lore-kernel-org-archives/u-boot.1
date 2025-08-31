Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32EECA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 11:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 021328392E;
	Sun, 31 Aug 2025 13:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yqkRouEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB7B8392E; Sun, 31 Aug 2025 13:21:25 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 563A983447
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 13:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0b89=3L=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756639280; bh=gJq+M9F5Z0zxsDyWADadDk9a24ByohkeoXEfrCY9/YM=;
 b=yqkRouEZRqFOr8orqUIwEUa7i3V6XGfoej2RF+m5VJjUyLRC/Moei/oLAkeDlUXz69V3zPwQF
 q+lFc7dqwF0Vv3aXMqXMchxT42wYt+YqTbXIm6QqUjxSaW4LQhWjH9ntuf7xgg1gVngvTG7neDX
 xEaMe7/3gpxC8lhVUkUZ8xQIMdTevp9o06MQc1rjbAqgAS2ja2slmBnufsE9eylgrNR9ylfrord
 Msa9kSdNXkijGOto5XAvaaU8MSYJhNtbrjujY+ix2A/wqdpjgS5XRZpEiOJsXb9eFGouJUxcRpx
 Bdn1x8hf7wIU4HCsF2/glgjtv4eeGPy2RGz2al3/OZQQ==
X-Forward-Email-ID: 68b4302e32f03f9a5e908690
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v3 05/10] arm64: dts: rockchip: enable PCIe on ROCK 4D
Date: Sun, 31 Aug 2025 11:20:26 +0000
Message-ID: <20250831112046.2642363-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831112046.2642363-1-jonas@kwiboo.se>
References: <20250831112046.2642363-1-jonas@kwiboo.se>
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

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The RADXA ROCK 4D board has a PCIe controller connected to a flat flex
connector, compatible with the one the RPi5 uses.

Enable the associated combphy and pcie controller node, as well as add
the remaining pinctrl definition for the reset.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Link: https://lore.kernel.org/r/20250621-rk3576-rock4d-pcie-v1-1-2b33c9f12955@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 29ff4bbff793334d6aff2238fdc3ccf3859d60da ]

(cherry picked from commit 2c6901d159a6586975f2e5edf8faabd015e9e03d)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch
---
 .../src/arm64/rockchip/rk3576-rock-4d.dts         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts b/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
index 6756403111e7..0388d72076bf 100644
--- a/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
@@ -194,6 +194,10 @@
 	};
 };
 
+&combphy0_ps {
+	status = "okay";
+};
+
 &combphy1_psu {
 	status = "okay";
 };
@@ -652,6 +656,14 @@
 	};
 };
 
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_reset>;
+	reset-gpios = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc_3v3_pcie>;
+	status = "okay";
+};
+
 &pinctrl {
 	hym8563 {
 		hym8563_int: hym8563-int {
@@ -678,6 +690,9 @@
 		pcie_pwren: pcie-pwren {
 			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+		pcie_reset: pcie-reset {
+			rockchip,pins = <2 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	usb {
-- 
2.51.0

