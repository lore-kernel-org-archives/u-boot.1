Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F241C3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F7B588846;
	Tue, 30 Jul 2024 16:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="eOus6u/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B515887B9; Tue, 30 Jul 2024 16:52:26 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B0D8887E
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722351134; bh=PoW3HoXVQR+apxtlo3G+xD7dw13BaMu8BBO7ctNRS3k=;
 b=eOus6u/iSfY/+aesjbjOeXW978obZj6Su9VefIKS2v/Qb+fAbdFhtcprefLDm+2yVTV9Crf1a
 yNYlJZRko/S6EnJZ49XjFkAOT7zb3XCT3j+HbinBRcK4IWbHyfHB1+R5zNgcfe8NBn7sgLjqvWI
 YiIJT0w4Vc++ZczYqwfmZbvdIv9eXo4cb5iTrjeCqMULK2abNpuTvOxalQMy6VprobH5Eo6KAMy
 YVuH2irAt41MQJwsbZTENfejEyAU65f6+dlIlcsbg0iZ6BPDdX/tAtFe6xSXjwSdHxmBqrcTFOn
 uS6NQwjaNcuAwSWTSdabUvKyA4dOCV0jBeoe+ScdFXhQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 5/8] arm64: dts: rockchip: Add io-domains to rk3308-rock-pi-s
Date: Tue, 30 Jul 2024 14:51:45 +0000
Message-ID: <20240730145148.849245-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730145148.849245-1-jonas@kwiboo.se>
References: <20240730145148.849245-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66a8fe1b88a51d097cb15602
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

The VCCIO4 io-domain used for WiFi/BT is using 1v8 IO signal voltage.

Add io-domains node with the VCCIO supplies connected on the board.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20240521211029.1236094-13-jonas@kwiboo.se
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 100b3bdee6035192f6d4a1847970fe004bb505fb ]

(cherry picked from commit f93b224359278728f01767a4701678ada9c25570)
---
 dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts b/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
index f6fb90e13ad0..5c702f00b27f 100644
--- a/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
@@ -231,6 +231,16 @@
 	status = "okay";
 };
 
+&io_domains {
+	vccio0-supply = <&vcc_io>;
+	vccio1-supply = <&vcc_io>;
+	vccio2-supply = <&vcc_io>;
+	vccio3-supply = <&vcc_io>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_io>;
+	status = "okay";
+};
+
 &pinctrl {
 	pinctrl-names = "default";
 	pinctrl-0 = <&rtc_32k>;
-- 
2.45.2

