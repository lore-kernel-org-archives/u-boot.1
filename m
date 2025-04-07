Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D0EC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D78F482EAA;
	Tue,  8 Apr 2025 00:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="F8maP11B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C22682E77; Tue,  8 Apr 2025 00:48:22 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D38682EAA
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066097; bh=nCb60GQvw3M6zfzRwNp33zRGx/ZlTD83wzhtL4EjlaE=;
 b=F8maP11BfPoa6+un6CmxIhiS6lkCyafrJWQZcDY1g4w49x1I3/FDREePzxxtTGIha4VPqlMBe
 r+WWEVXoaVcVgLNyjgpoCTVrISKKC8NgVPccEm6TPu0gdEHy03o47pin4o5RJozzOk1z6ZajHOk
 4g7jXvaBXU8+Mua0liGdWitnktcnPJzpjbqHxmnYNSO4nqnxrKkqtT1z4cgd+eEjg/iyZVHPdjl
 j1UFdycq1tpSOAwcAbG1YsDlsZ3YZItbvYAP37EXTlofIbRkgTIs6OrcdPBFl4lfGQ+OsTKZk+i
 yfeLXzBi4jMNKS5jjw+d9W3AgGxnTncdq0usWKfWe16w==
X-Forward-Email-ID: 67f4562e9fd75b9b965127cf
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 07/30] arm64: dts: rockchip: Add SARADC node for RK3528
Date: Mon,  7 Apr 2025 22:46:40 +0000
Message-ID: <20250407224743.2423921-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
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

Add a device tree node for the SARADC controller used by RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20250304201642.831218-4-jonas@kwiboo.se
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 6e58302c84ce90aadbecd41efe1f69098a6f91e5 ]

(cherry picked from commit 8ba64ba5cb301bca777ba7f0d2a2a72f49af5ff2)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 dts/upstream/src/arm64/rockchip/rk3528.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3528.dtsi b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
index 4be53868f324..c2eaa0c6ea90 100644
--- a/dts/upstream/src/arm64/rockchip/rk3528.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rockchip,rk3528-cru.h>
+#include <dt-bindings/reset/rockchip,rk3528-cru.h>
 
 / {
 	compatible = "rockchip,rk3528";
@@ -455,6 +456,18 @@
 			status = "disabled";
 		};
 
+		saradc: adc@ffae0000 {
+			compatible = "rockchip,rk3528-saradc";
+			reg = <0x0 0xffae0000 0x0 0x10000>;
+			clocks = <&cru CLK_SARADC>, <&cru PCLK_SARADC>;
+			clock-names = "saradc", "apb_pclk";
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&cru SRST_P_SARADC>;
+			reset-names = "saradc-apb";
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl {
 			compatible = "rockchip,rk3528-pinctrl";
 			rockchip,grf = <&ioc_grf>;
-- 
2.49.0

