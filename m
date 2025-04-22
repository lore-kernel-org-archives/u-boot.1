Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B9AC369D1
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 21:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9278817C4;
	Tue, 22 Apr 2025 23:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Wub53012";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 167A58003E; Tue, 22 Apr 2025 23:12:34 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57C880FF7
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 23:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e320=XJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1745356350; bh=aobLE5u5gELg4LmqpoSMf+sHkQLpcNWvHYSci+tFlV8=;
 b=Wub53012ms/Ik5G5Vuw24HuV7pRM1EI79LawNZs0ZCXKuQ6PWUzYUJea6Ji/BPhFDYYBBhxfk
 M8qvP6NUrckRw4SzQcvhq4PRBblRrxJrmz5sG6IuH/+C3Swjw6Yn/MNsAc4tz2o+p1JtiD8tTpE
 U9B/x9kZMG/LuNixnXsH11iUbV9OmKGsms32SNFscUjtg0lcXWelMm3Bs8keeZW4jIEHDfX71Gr
 V5FRTcVHG0FLSHH9wZnMEFnqoBocuuv3SirdRkooX/clO+vkBNgYL21xLpm4pPahKxxj+pf8km8
 zo3eH0H3zCCe3o2ElK53PJ/F7A92TJfhjufSK1SVgeYg==
X-Forward-Email-ID: 6808063a305f69a6701c5995
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/4] rockchip: rk3576: Add rng node to u-boot.dtsi
Date: Tue, 22 Apr 2025 21:12:06 +0000
Message-ID: <20250422211216.3727559-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422211216.3727559-1-jonas@kwiboo.se>
References: <20250422211216.3727559-1-jonas@kwiboo.se>
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

The RK3576 SoC contains a RKRNG block that can be used to generate
random numbers using the rockchip_rng driver.

  => rng list
  RNG #0 - rng@2a410000

  => rng
  00000000: 36 dd ab 98 ec fb fe d1 cf 36 b3 e1 9b 3d 00 90  6........6...=..
  00000010: f5 84 de 75 6b 27 48 9e 13 62 12 6c 50 ca 47 1a  ...uk'H..b.lP.G.
  00000020: b3 4d fc 43 c5 b5 2d be 07 27 03 26 bb 69 61 2a  .M.C..-..'.&.ia*
  00000030: 6f 70 01 83 4e ce 91 7a 5a 6c 7c 00 43 87 3e c5  op..N..zZl|.C.>.

Add a rng node to the SoC specific u-boot.dtsi until full support has
landed in a device tree from dts/upstream.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3576-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
index be99a48a630f..928960862597 100644
--- a/arch/arm/dts/rk3576-u-boot.dtsi
+++ b/arch/arm/dts/rk3576-u-boot.dtsi
@@ -14,6 +14,13 @@
 		compatible = "rockchip,rk3576-dmc";
 		bootph-all;
 	};
+
+	soc {
+		rng: rng@2a410000 {
+			compatible = "rockchip,rkrng";
+			reg = <0x0 0x2a410000 0x0 0x200>;
+		};
+	};
 };
 
 &cru {
-- 
2.49.0

