Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75D3EA71B1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 01:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BDFF8428C;
	Mon, 20 Apr 2026 03:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tRyOKfzr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vjdc2/TF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A33C84297; Mon, 20 Apr 2026 03:22:36 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88AFB80433
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 03:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fzSQf2Bh0z9tQY;
 Mon, 20 Apr 2026 03:22:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776648154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ue573oEW30uhKaq7kVsqzw1M5lH05jix3I6JeDfCozw=;
 b=tRyOKfzrQxwZh6SBaKH54yon4Xq17jmazZjGymWrfxfARYeYa0RfBvV+V+0+WpoBxV5Ac3
 9SZKoIpjW6oFHBlt3IuJ2zySxa9R77RA+NEMUP+hR/kXWG7zjL7L0pImGOHH9rWGCmN6TN
 PhhIodqCy5364ou5gZunc5HGEXZ9RV6PKJlWXO1jdMfLGpQPwqV78D20ry0nNeRNW5wiHj
 A0c4ePfJG3YFswSFeCSL+8kWco+qbA0KkVr0JznJZ5jSm74QvIBoOZov9LREDmq/0XVjge
 6E8/xikt1pyqa9+6vG9z6+c1/LitYs3qRPIu1DckyZTWJOdUQe7v3uwkaHMAAA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776648152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ue573oEW30uhKaq7kVsqzw1M5lH05jix3I6JeDfCozw=;
 b=vjdc2/TFmQQrUJP7MV7rIiahP0eQPjMBHfPvwNcC1lQXAbH8/GXFdpsNCdElUZta3fumRO
 90J+Wxm37vYtitfuMtlvRf5/C4wizhFwByzde4HG1sSF1X16pWZQBBWorYxt9XCXf8mxJ8
 kVllssAG1MANIbrTfaqrV4XTfuymrNfr5gcU3DQKUvkMjl7CYw8Z6wNsr5+9coimFGKVKe
 SFGb2YSmfRd3Cpkvu/Fz3JXwIdJqXAWXATsGeJAJQx0eU8HiWFlOMk8+nFToYFiGmo/JIf
 flJ8HAtAOZtUollswT73+Z+o468McGaLEA7lJcB0T9EcDPNfXvxkvpVzx5hvdQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: dts: renesas: Remove duplicate AVB pinmux assignment on
 V3M
Date: Mon, 20 Apr 2026 03:22:12 +0200
Message-ID: <20260420012229.400421-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2ef2cd125f33c210da5
X-MBO-RS-META: zgnzc6f64zbwne8wuibeey69strw1qs9
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

Both R-Car V3M Eagle and V3MSK U-Boot DT extras contain AVB pinmux
assignment, which is a leftover from before the same pinmux was part
of upstream DTs. Remove the duplicate AVB pinmux assignment in favor
of the upstream DT content. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a77970-eagle-u-boot.dtsi | 19 -------------------
 arch/arm/dts/r8a77970-v3msk-u-boot.dtsi | 19 -------------------
 2 files changed, 38 deletions(-)

diff --git a/arch/arm/dts/r8a77970-eagle-u-boot.dtsi b/arch/arm/dts/r8a77970-eagle-u-boot.dtsi
index b18ec9a695d..27709ac8a71 100644
--- a/arch/arm/dts/r8a77970-eagle-u-boot.dtsi
+++ b/arch/arm/dts/r8a77970-eagle-u-boot.dtsi
@@ -13,25 +13,6 @@
 	};
 };
 
-&avb {
-	pinctrl-0 = <&avb0_pins>;
-	pinctrl-names = "default";
-
-};
-
-&phy0 {
-	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
-};
-
-&pfc {
-	avb0_pins: avb {
-		mux {
-			groups = "avb0_link", "avb0_mdio", "avb0_rgmii", "avb0_txcrefclk";
-			function = "avb0";
-		};
-	};
-};
-
 &rpc {
 	status = "okay";
 	#address-cells = <1>;
diff --git a/arch/arm/dts/r8a77970-v3msk-u-boot.dtsi b/arch/arm/dts/r8a77970-v3msk-u-boot.dtsi
index e5352a663f4..a94fe92c831 100644
--- a/arch/arm/dts/r8a77970-v3msk-u-boot.dtsi
+++ b/arch/arm/dts/r8a77970-v3msk-u-boot.dtsi
@@ -24,25 +24,6 @@
 	};
 };
 
-&avb {
-	pinctrl-0 = <&avb0_pins>;
-	pinctrl-names = "default";
-
-};
-
-&phy0 {
-	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
-};
-
-&pfc {
-	avb0_pins: avb {
-		mux {
-			groups = "avb0_link", "avb0_mdio", "avb0_rgmii", "avb0_txcrefclk";
-			function = "avb0";
-		};
-	};
-};
-
 &rpc {
 	status = "okay";
 	#address-cells = <1>;
-- 
2.53.0

