Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C70C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 10:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 340578496E;
	Fri, 10 Jul 2026 12:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OIL1E/KA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87AF284A49; Fri, 10 Jul 2026 12:05:44 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0345C84659
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 12:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4682=FE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783677940; bh=5ROcOEb3fN1YJRClRztVgLX0nOCZaoBocujuUHL6t+Q=;
 b=OIL1E/KAtR7YmnRGf1UpgMjc+mZenSpkDMD7AHn5gRIa6gMMIS4MNgZl5Tc7O5erHB35ajQQg
 3x3IvqNhVjWz/Z965XmjmICHApQKq0sOiQgEie9CM/PNAPoQWZV6zaJRIUgfkj402NsUpDhsMUU
 bhaK+N/C0GicYW2Rd5cqMM9jDkaZBfiGPgKlv1nzNv11OjUDBKYj3OdqT9aNfKMBwBj/tmQ3/yk
 vQoaagu+c2MO7uCmIub1cilmD65FyVDRqShC3RHGMyxgdNB1ilkZpocBjK1qRl8pZUqgwW+ywsq
 OXOGtgAHP8Mg8xoCy6YSnbOAmtVbr5fgNlKnbRgXFifA==
X-Forward-Email-ID: 6a50c3f328378fa077a395a8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6/7] arm64: dts: rockchip: Enable USB 2.0 ports on NanoPi Zero2
Date: Fri, 10 Jul 2026 10:05:18 +0000
Message-ID: <20260710100521.3677247-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710100521.3677247-1-jonas@kwiboo.se>
References: <20260710100521.3677247-1-jonas@kwiboo.se>
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

The NanoPi Zero2 has one USB 2.0 Type-A HOST port and one USB 2.0 Type-C
OTG port.

Add support for using the USB 2.0 ports on NanoPi Zero2.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20260529190355.4148175-6-heiko@sntech.de

[ upstream commit: ff660109f4129a13bbdc31bc14ca233ebf0c9450 ]

(cherry picked from commit 2f28b83dd0d59cddb15927dbf30eb6960fbf772d)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../arm64/rockchip/rk3528-nanopi-zero2.dts    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3528-nanopi-zero2.dts b/dts/upstream/src/arm64/rockchip/rk3528-nanopi-zero2.dts
index 9f683033c5f3..97d85124d21b 100644
--- a/dts/upstream/src/arm64/rockchip/rk3528-nanopi-zero2.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3528-nanopi-zero2.dts
@@ -338,3 +338,32 @@
 	pinctrl-0 = <&uart0m0_xfer>;
 	status = "okay";
 };
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	extcon = <&usb2phy>;
+	maximum-speed = "high-speed";
+	phys = <&usb2phy_otg>;
+	phy-names = "usb2-phy";
+	status = "okay";
+};
+
+&usb2phy {
+	status = "okay";
+};
+
+&usb2phy_host {
+	phy-supply = <&usb2_host_5v>;
+	status = "okay";
+};
+
+&usb2phy_otg {
+	status = "okay";
+};
-- 
2.54.0

