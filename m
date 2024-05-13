Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC754C25B75
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 12:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C6C8830F;
	Mon, 13 May 2024 14:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="POdBf3Eq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E6E88324; Mon, 13 May 2024 14:14:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85C6288301
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 14:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2BC8F60DBC;
 Mon, 13 May 2024 12:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E9AC32782;
 Mon, 13 May 2024 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715602460;
 bh=FxnTo4qq+53/lSdsPQe2DR2+BW74p/1gSw5Q4AstjkQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=POdBf3EqGOrsnflLx1deZTyWJAsnWmCWNHLmiHBvNBqwkINqLBYARHJ0SDi5Z25CK
 cMKVRTI66aqPxKthAbJ4gvlR2qRf767rBKX4QFQvuY/OqrUwBdpFWu2Oiq+O+Z2A/X
 RhSXk+0s7Whz21I+VQ9IWxl71U2J1n1BEY+UWFahScZYJy5WpdXsoZmG1T3JasxSnA
 ciT0B0/a0vH7EqETU6VTYExKs4VCmQK9ar+cqGcCqO80chcp9ywPxdO0JjEQFE8ro9
 Oar5xH4eH1fTb63BIl7o2A/+rECXiqB+vdOMg1WP1ZIZSO7Z3kccJozkm06EtywbNP
 RJhsU72BsIgUg==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 13 May 2024 15:13:55 +0300
Subject: [PATCH v2 2/3] arm: dts: k3-am625-beagleplay: get CPSW Ethernet to
 work
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-for-2024-07-beagleplay-eth-v2-2-a9bf457c3bb8@kernel.org>
References: <20240513-for-2024-07-beagleplay-eth-v2-0-a9bf457c3bb8@kernel.org>
In-Reply-To: <20240513-for-2024-07-beagleplay-eth-v2-0-a9bf457c3bb8@kernel.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com, 
 danishanwar@ti.com, u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1836; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=FxnTo4qq+53/lSdsPQe2DR2+BW74p/1gSw5Q4AstjkQ=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmQgQRDQyJbPv7QtR20dAoTDJnVGqWj9jn4Vzq/
 hzArT4q+Q+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZkIEEQAKCRDSWmvTvnYw
 kylFD/4xSOo4Ao0IvK52yURDIDbGve7QUQ+aFnTThEPoT6UP6Axcgra1WJdcIKCis8pmtjtKZQm
 BWVlpM+O5QpO1zMGQrHNb8DI/1rAOIiStiF3XCtAK8QArJFRbInUkSiu6Y2bxdlCwzoNuyXIazp
 VBq2FRH+qk+Jt3sMUIX459aj/kheTYIkgjW/LOxmT+c3VPZyzcFF7Z7MhgcS6L8wj8udQwiIooP
 Tit6OyLW8G5EGiI9AQJJjamFAgFacG6RmY5JnJEaBrNfuXBvh0u7/IvnsucvYcJoOlTDj+O/vOa
 D8sF1Yl37xcWo8FQB36JzUpOdmYWCukaSUE5xxb90rHJeMugqpqm3JO3EGGJ1/1O1pqy5/oDBnx
 IEjNhI6FUTRnO7HVtnXxldBVbqoGoUHYpthCQFHY851B6GCX5ZJbXlApB2+1yM246sztQp3Ay9E
 Q/xvOFuInF+VLeqZG9oNPq45iJb9vmjzg0XrOE0wR5Sdfz0l7BDcP5TnzGPEbKyoHiRSda78/+0
 DDw7V5ky40RIHxuLAFy/idk6/qPuE38yheXpzX8AqDFtJ2WpXX5iEYa6H7dDGlOdxYW1lr2uzrg
 0HohvsYXqYpAIYF54Uq5wbeitG23LyfwsV7R9EjrpYG1e98/gj7qZTb4M4gubt3gEWlfSlLFRKb
 FFpndguqY22fqAg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

Add missing bits in -u-boot.dtsi to get CPSW Ethernet working.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index fb2032068d1..54a7702037d 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -206,3 +206,66 @@
 	};
 };
 #endif
+
+&main_bcdma {
+	reg = <0x00 0x485c0100 0x00 0x100>,
+	      <0x00 0x4c000000 0x00 0x20000>,
+	      <0x00 0x4a820000 0x00 0x20000>,
+	      <0x00 0x4aa40000 0x00 0x20000>,
+	      <0x00 0x4bc00000 0x00 0x100000>,
+	      <0x00 0x48600000 0x00 0x8000>,
+	      <0x00 0x484a4000 0x00 0x2000>,
+	      <0x00 0x484c2000 0x00 0x2000>;
+	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
+		    "cfg", "tchan", "rchan";
+};
+
+&main_pktdma {
+	reg = <0x00 0x485c0000 0x00 0x100>,
+	      <0x00 0x4a800000 0x00 0x20000>,
+	      <0x00 0x4aa00000 0x00 0x40000>,
+	      <0x00 0x4b800000 0x00 0x400000>,
+	      <0x00 0x485e0000 0x00 0x20000>,
+	      <0x00 0x484a0000 0x00 0x4000>,
+	      <0x00 0x484c0000 0x00 0x2000>,
+	      <0x00 0x48430000 0x00 0x4000>;
+	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt", "cfg",
+		    "tchan", "rchan", "rflow";
+	bootph-all;
+};
+
+&mdio0_pins_default {
+	bootph-all;
+};
+
+&cpsw3g_mdio {
+	bootph-all;
+};
+
+&cpsw3g_phy0 {
+	bootph-all;
+};
+
+&rgmii1_pins_default {
+	bootph-all;
+};
+
+&cpsw3g {
+	bootph-all;
+
+	ethernet-ports {
+		bootph-all;
+	};
+};
+
+&phy_gmii_sel {
+	bootph-all;
+};
+
+&cpsw_port1 {
+	bootph-all;
+};
+
+&cpsw_port2 {
+	status = "disabled";
+};

-- 
2.34.1

