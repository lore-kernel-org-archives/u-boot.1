Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F60C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 13:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A558187CFE;
	Wed, 31 Jan 2024 14:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ASsGbx3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD53087C68; Wed, 31 Jan 2024 14:34:17 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B006A87CFE
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 14:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 04500CE20BE;
 Wed, 31 Jan 2024 13:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EC1C433F1;
 Wed, 31 Jan 2024 13:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706708040;
 bh=Hg1axtO9FWU1mvKW/soqsr2Vi6KeYNXKyqqXhlJ8JKU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ASsGbx3PDddcydAL46UrMhcCem/SXbRCFSnqWXtEsvX+Fme20nbNCgrw0Xydeq1Fd
 72J7oLVWwveItDAbMq+tJajYvNqo7dq5f+8TOilAZvBZoBGahKndPzMqhIqLz/dWkn
 a/8I+/PR7rirBg74fvewctQ/Ep/036K22fMubdAS4eB51mt2r7o+MZhrCr1+lROXw6
 qEqnqZFWEl0vO0jKHeaEnIYJrpYvKQNxxNlsnP1ObYaFoH9sy8HqeQjOaRa2olgLke
 hAr5xrf1esvcZ5xywDcuO5/d/VRIEp/bSJnrikQkl/LCV0zBDIB8vEsD251gsGgMDb
 crvd2r1f+HW/w==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, s-vadapalli@ti.com, srk@ti.com, r-gunasekaran@ti.com,
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/3] arm: dts: k3-u-boot: Drop usage of "u-boot, mux-autoprobe"
Date: Wed, 31 Jan 2024 15:33:47 +0200
Message-Id: <20240131133348.182987-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131133348.182987-1-rogerq@kernel.org>
References: <20240131133348.182987-1-rogerq@kernel.org>
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

MUX driver should autoprobe if the device tree has "idle-states"
property. Drop using the custom "u-boot,mux-autoprobe" property.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am642-sk-u-boot.dtsi                | 4 ----
 arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi    | 2 --
 arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi | 8 --------
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi                | 8 --------
 4 files changed, 22 deletions(-)

diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
index 2eb227c1d0..f3ed376ab7 100644
--- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
@@ -184,10 +184,6 @@
 	bootph-all;
 };
 
-&serdes_ln_ctrl {
-	u-boot,mux-autoprobe;
-};
-
 &usbss0 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
index 017a5a722e..f83caf7998 100644
--- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
@@ -165,7 +165,6 @@
 
 &serdes_ln_ctrl {
 	bootph-all;
-	u-boot,mux-autoprobe;
 };
 
 &serdes2_usb_link {
@@ -174,7 +173,6 @@
 
 &usb_serdes_mux {
 	bootph-all;
-	u-boot,mux-autoprobe;
 };
 
 &serdes_wiz2 {
diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
index 7ae7cf3d4c..b77f8d92de 100644
--- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
@@ -93,14 +93,6 @@
 	bootph-all;
 };
 
-&serdes_ln_ctrl {
-	u-boot,mux-autoprobe;
-};
-
-&usb_serdes_mux {
-	u-boot,mux-autoprobe;
-};
-
 &main_usbss0_pins_default {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
index 479b7bcd6f..370fe5190b 100644
--- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
@@ -89,14 +89,6 @@
 	bootph-all;
 };
 
-&serdes_ln_ctrl {
-	u-boot,mux-autoprobe;
-};
-
-&usb_serdes_mux {
-	u-boot,mux-autoprobe;
-};
-
 &main_usbss0_pins_default {
 	bootph-all;
 };
-- 
2.34.1

