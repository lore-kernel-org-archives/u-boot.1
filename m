Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098EAC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 22:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 995F882C4C;
	Wed, 16 Apr 2025 00:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="vJ5wp2Cb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EA3B82C4D; Wed, 16 Apr 2025 00:21:29 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26BC182B44
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 00:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=dJ3dbn6a0yHQg4LeCjJk917LqJhb//qiB3RQ8rxNI6g=; b=vJ5wp2CbMzx3/rFQg31k+3uckl
 8VkvWCJ0ufbMMTJCb/RuBEK/taH9ockdFHPkieucqlUV/e7mDGG0IBeIz6rnCKhxDRvH7fQYkSqRr
 FqyFoZIKGzawyu/XyXY+hsoMesQqP6DVhuXp/H3QXz2bupIl8sh+nf9v1OLLfuei4PEZyoGPyR2hv
 fbivr7m7uu17QiSjieUvHq0VsV9tT80zreFpMR/w9b2I0z4lXf/bzeLIwQMj5ltVxZ6VHUefb+0oG
 d+jV7We/IW/B+7fUZTY/tAwBZRmQ4kNp9bxwDpZ2MSFfYt7FggbdnF3W+npzAm11tzA6/wDT+g82B
 Sxc/gINQ==;
Received: from i53875b95.versanet.de ([83.135.91.149]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u4oCK-0007Uo-BT; Tue, 15 Apr 2025 23:52:04 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v3 12/15] arm64: dts: rockchip: add rk3576 otp node
Date: Tue, 15 Apr 2025 23:51:25 +0200
Message-ID: <20250415215128.1475593-13-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250415215128.1475593-1-heiko@sntech.de>
References: <20250415215128.1475593-1-heiko@sntech.de>
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

This adds the otp node to the rk3576 soc devicetree including the
individual fields we know about.

Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20250210224510.1194963-7-heiko@sntech.de

[ upstream commit: 8715d2eeb062f6859c252bb6c87b363230b66e9f ]

(cherry picked from commit d67cf6de8aacb4abcdfb516eeb8a511a4a657bc1)
---
 dts/upstream/src/arm64/rockchip/rk3576.dtsi | 39 +++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3576.dtsi b/dts/upstream/src/arm64/rockchip/rk3576.dtsi
index 4dde954043e..29b47799849 100644
--- a/dts/upstream/src/arm64/rockchip/rk3576.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3576.dtsi
@@ -1260,6 +1260,45 @@
 			status = "disabled";
 		};
 
+		otp: otp@2a580000 {
+			compatible = "rockchip,rk3576-otp";
+			reg = <0x0 0x2a580000 0x0 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cru CLK_OTPC_NS>, <&cru PCLK_OTPC_NS>,
+				 <&cru CLK_OTP_PHY_G>;
+			clock-names = "otp", "apb_pclk", "phy";
+			resets = <&cru SRST_OTPC_NS>, <&cru SRST_P_OTPC_NS>;
+			reset-names = "otp", "apb";
+
+			/* Data cells */
+			cpu_code: cpu-code@2 {
+				reg = <0x02 0x2>;
+			};
+			otp_cpu_version: cpu-version@5 {
+				reg = <0x05 0x1>;
+				bits = <3 3>;
+			};
+			otp_id: id@a {
+				reg = <0x0a 0x10>;
+			};
+			cpub_leakage: cpub-leakage@1e {
+				reg = <0x1e 0x1>;
+			};
+			cpul_leakage: cpul-leakage@1f {
+				reg = <0x1f 0x1>;
+			};
+			npu_leakage: npu-leakage@20 {
+				reg = <0x20 0x1>;
+			};
+			gpu_leakage: gpu-leakage@21 {
+				reg = <0x21 0x1>;
+			};
+			log_leakage: log-leakage@22 {
+				reg = <0x22 0x1>;
+			};
+		};
+
 		gic: interrupt-controller@2a701000 {
 			compatible = "arm,gic-400";
 			reg = <0x0 0x2a701000 0 0x10000>,
-- 
2.47.2

