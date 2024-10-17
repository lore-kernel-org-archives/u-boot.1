Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBABD3C530
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 20:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C2C6890CD;
	Thu, 17 Oct 2024 22:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="x6+MBQPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4620B890BF; Thu, 17 Oct 2024 22:01:14 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E2BD89099
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 22:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a54c=RO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1729195263; bh=OJ57kb7IjyoFoolbnE8cxv+pBKzphE2zcnWsdqGTohU=;
 b=x6+MBQPoyZPgt1JWv2qJliv8B470u302TKRbazi57ZPrVeRG0j/KwDzE74pOP6kLQcFJZWJ4k
 18TLiXvNiekAENLFiSZ4CL8KPzWyCnxgb4GormI0kGGXrc2sZLURxSjRvuOQuHUR/20TWu662jw
 9Szhv8JB91cLspOuloeAuxUyi+bxUNf8EUiO8JN7kqlo8ueC8RNe44ktKpzAbsf4C3uEabF27Dy
 PXa/0JsGRQR26bLY8NUn+wHN09wqfyS75A0RU69yMxPIg6TeOsQU9rm5TrhSpQuW21eKXV8rf20
 uIetUu2ZiP3fcl91J11Y6L+p82k5EjYAJvcB8n7hJ5fw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4/8] arm64: dts: rockchip: add SPI flash on NanoPC-T6
Date: Thu, 17 Oct 2024 20:00:23 +0000
Message-ID: <20241017200039.1235524-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017200039.1235524-1-jonas@kwiboo.se>
References: <20241017200039.1235524-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 67116cfb6385e073f5ab13e0
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

FriendlyELEC NanoPC-T6 has optional SPI flash chip on-board.
It is populated with 32MB one on LTS version.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20240829-friendlyelec-nanopc-t6-lts-v6-5-edff247e8c02@linaro.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: a22a629c63b1addcf2d81eaf30383c1deca5b7a9 ]

(cherry picked from commit 7588da65fdf09c7de9f903780c212a8ae96f2866)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../src/arm64/rockchip/rk3588-nanopc-t6.dtsi      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi
index d199f51a220c..77580c671b36 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi
@@ -560,6 +560,21 @@
 	status = "okay";
 };
 
+/* optional on non-LTS, populated on LTS version */
+&sfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspim1_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <104000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
 &spi2 {
 	status = "okay";
 	assigned-clocks = <&cru CLK_SPI2>;
-- 
2.46.2

