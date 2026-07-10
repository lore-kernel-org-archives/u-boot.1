Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB10C44506
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 10:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A82384A4A;
	Fri, 10 Jul 2026 12:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QFe27tqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2994084659; Fri, 10 Jul 2026 12:05:46 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05CFA849D2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 12:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4682=FE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783677940; bh=ilgLtcUnUj7AVttNv/8CJRFkGfzbcnVXZGiBFZzDMx4=;
 b=QFe27tqMoZOvWBQl30yOh2qHp1ELznluDllZh2imB7Nh5f6PACQht5Wnl84qj0YPsr3WVwq/S
 RnWjrLr/klW4dt3rbQP0mIRe/rlWw657cuLuao+h521VOAAQ6TkMjKHLUgoynf3Y555+JUMKCRs
 B6xZFmDOZstJ5coSPj8bFH2prI5hoWIPfMOAsFBA2ranDaKB4QJ82JcTRhe+Jp0l0PPTeCdmYjn
 IQBHxSBIZ9825yTbTnGFrmbTQLu/hhyPb5kqQEuQV0xFj+KcrzEJ0LGpX+yNEk9dIlDh3sAN94C
 C1T1mQ7ClyWr+J4Nw0bRnGpdKYATdxdPaV/7izbTta6A==
X-Forward-Email-ID: 6a50c3f128378fa077a3958d
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
Subject: [PATCH 5/7] arm64: dts: rockchip: Enable USB 2.0 ports on ArmSoM Sige1
Date: Fri, 10 Jul 2026 10:05:17 +0000
Message-ID: <20260710100521.3677247-6-jonas@kwiboo.se>
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

The ArmSoM Sige1 has two USB 2.0 Type-A HOST ports behind an onboard
USB hub, and one USB 2.0 Type-C OTG port.

Add support for using the USB 2.0 ports on ArmSoM Sige1.

The onboard USB hub handles OHCI so only the EHCI controller is enabled.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
[added phy-supply for otg port]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20260529190355.4148175-5-heiko@sntech.de

[ upstream commit: b6b74087f90a201cfdd6da6a43e7b92dba8370e3 ]

(cherry picked from commit 959d0d70460b569e212c0daa70404b794cbcd37c)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../arm64/rockchip/rk3528-armsom-sige1.dts    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3528-armsom-sige1.dts b/dts/upstream/src/arm64/rockchip/rk3528-armsom-sige1.dts
index c41af8fc0c8d..ee4183fb980d 100644
--- a/dts/upstream/src/arm64/rockchip/rk3528-armsom-sige1.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3528-armsom-sige1.dts
@@ -480,3 +480,28 @@
 		vddio-supply = <&vcc_1v8>;
 	};
 };
+
+&usb_host0_ehci {
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
+	status = "okay";
+};
+
+&usb2phy_otg {
+	phy-supply = <&vcc5v0_usb_otg>;
+	status = "okay";
+};
-- 
2.54.0

