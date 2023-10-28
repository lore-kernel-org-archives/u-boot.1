Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4490DC27C47
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 17:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 511868786A;
	Sat, 28 Oct 2023 19:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uFEX1dha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30A68878D9; Sat, 28 Oct 2023 19:36:22 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21CC686DD2
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 19:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id B8960B8167D;
 Sat, 28 Oct 2023 17:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6CCC433C8;
 Sat, 28 Oct 2023 17:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698514579;
 bh=CtkZhLku20W5Fxbudm3Jeic+s78gB9Rq128Bi1lZQhE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uFEX1dhaADHzlveHUqT7gedUD/tSqLs9CPcTTE9wBtazU4FifgpNWpAKYcoiss/DD
 NQa9AClk5IiAfdHod56qD5wo4n/MgazES94TWhpY1mfgWdXgYW37JY0tJe5elN94qR
 rbl7zbGHiJnik4xZ8iX3EkRgEdqI16w4CqiyTw/SaCgKasXgtZP2oSnIGNTX3diHbW
 XeEzQ5gYrETx5jqJa6nmmHEkuopvjsi/WsjicX/+cl2CmwQseR0qioJYJrTfiItfHN
 koIPMDv2fPMN0XkmkvLhXUc8OVz5j4FpzvXSCchR9TVm/LOmgjRUuWjkOIObK/bti2
 GpdBA6tfsxoRA==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	trini@konsulko.com
Cc: s-vadapalli@ti.com, r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
 marcel.ziswiler@toradex.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 3/3] arm: dts: k3-am642: Update main_bcdma and main_pktdma
 nodes
Date: Sat, 28 Oct 2023 20:36:03 +0300
Message-Id: <20231028173603.24338-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028173603.24338-1-rogerq@kernel.org>
References: <20231028173603.24338-1-rogerq@kernel.org>
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

From: Siddharth Vadapalli <s-vadapalli@ti.com>

Update main_bcdma and main_pktdma nodes for native configuration in the
absence of DM services.

Drop duplicate main_pktdma node in k3-am642-sk-u-boot.dtsi.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/dts/k3-am642-evm-u-boot.dtsi | 23 +++++++++++++++++++++++
 arch/arm/dts/k3-am642-sk-u-boot.dtsi  | 24 ++++++++++++++++++++----
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
index 953bbe9aaf..b843078243 100644
--- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
@@ -116,7 +116,30 @@
 	bootph-all;
 };
 
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
 &main_pktdma {
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
 	bootph-all;
 };
 
diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
index 40a53df0b0..2eb227c1d0 100644
--- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
@@ -96,10 +96,6 @@
 	bootph-all;
 };
 
-&main_pktdma {
-	bootph-all;
-};
-
 &mdio1_pins_default {
 	bootph-all;
 };
@@ -141,10 +137,30 @@
 };
 
 &main_bcdma {
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
 	bootph-all;
 };
 
 &main_pktdma {
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
 	bootph-all;
 };
 
-- 
2.34.1

