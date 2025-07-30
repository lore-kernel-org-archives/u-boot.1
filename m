Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2258C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 23:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA17832EA;
	Thu, 31 Jul 2025 01:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sR/2WljU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 682328319C; Thu, 31 Jul 2025 01:54:12 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60DEF83297
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 01:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5dd1=2M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753919642; bh=EcSGf6Duh7pPLDyfGvOwoKDg4jUmUQK8QcV9iCbkGFA=;
 b=sR/2WljUvl3dLNIKAZZL4noIKwzeeiqxoCyCbhHDw47bGYrOJOoa4t0W0As8iPmq+YiEK+8Uj
 XlElqXfA62GOF/6FwE74wEwShzpPYWfYEfDsdJPhdzoaX9mPvbFosaCMdX0sDhQd8hedm7g6ASD
 H1NviU3mKcp0MULmsdMl6TKT+ylLE32dbd1sxTUDmNevmw2Hdg/VC+Ddhqq7l7OyvUPxs4WJmZc
 AU8RTcpiHFmXHJTacv/z8Wl0MF1ysbXrI4w+fTEZCUE//QKDFMA5bAk6yxjzGWpgEDnp1uoTeBm
 oP4wlrZkuQMqc9YhB5tsXsl0IadGK8cSDxkRMvlCWc7Q==
X-Forward-Email-ID: 688ab06d1851584377f620d8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
Subject: [PATCH 3/8] arm: dts: rockchip: Set init-microvolt for pwm-regulators
 on Radxa E20C
Date: Wed, 30 Jul 2025 23:52:44 +0000
Message-ID: <20250730235301.1774089-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730235301.1774089-1-jonas@kwiboo.se>
References: <20250730235301.1774089-1-jonas@kwiboo.se>
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

Radxa E20C has two main pwm-regulators, vdd_arm and vdd_logic.

Add init-microvolt props to ensure the regulators are initialized at
the recommended power-on sequence voltage instead of at max voltage.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
index 05a58c136bcd..16c47e6b9a9e 100644
--- a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
@@ -5,3 +5,11 @@
 &sdhci {
 	mmc-hs200-1_8v;
 };
+
+&vdd_arm {
+	regulator-init-microvolt = <953000>;
+};
+
+&vdd_logic {
+	regulator-init-microvolt = <900000>;
+};
-- 
2.50.1

