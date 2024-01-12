Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0408C4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 12:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01737879F6;
	Fri, 12 Jan 2024 13:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lzMH467m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E0C087947; Fri, 12 Jan 2024 13:50:12 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3CAA879F5
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 694F561D01;
 Fri, 12 Jan 2024 12:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656D4C43390;
 Fri, 12 Jan 2024 12:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705063808;
 bh=r91NdKHxE+tAHUcVFE663sGeid3oKWnZu39PkxP5l8U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lzMH467m4+73UEd8yyKIVMgJn+PlSkX1KxR3d5DnfNSYc+Ils3pWFeQR62axRHY50
 AJ+Gm5N+GtyeMqJ5w4uShLTThOco3cbYTo10mntMg4jV+6wd7Bk+rRJy0vF7Cn9Wto
 9X8CC5AcDGvnv/9o9HqFeEmZgk4Pxf4Z/K8IVpCBYIdT3XDqTc+ay3tnSiJ/FwK7tQ
 PTrWz9R0Kq15+21vIJESI1XZDBduDpL+175GVrGfTYE44ewpsIL+87faE99542IlCA
 QkBijVJ3ylzk20xch/K0E5Y1UzZEKjGGgKemwkoH7zx+CRGrBczU1gLldLZB3Gpsql
 2/rt1yEVerB8g==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	robertcnelson@gmail.com,
	trini@konsulko.com,
	marex@denx.de
Cc: n-francis@ti.com, praneeth@ti.com, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, srk@ti.com, vigneshr@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 3/5] arm: dts: k3-j721e: Fix USB0 operation
Date: Fri, 12 Jan 2024 14:49:49 +0200
Message-Id: <20240112124951.238098-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112124951.238098-1-rogerq@kernel.org>
References: <20240112124951.238098-1-rogerq@kernel.org>
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

Without correct SERDES MUX and Lane control settings
USB0 will be broken. Set the MUX and Lane control devices
to be auto probed so they are configured correctly.

Fixes: 69b19ca67bcb ("arm: dts: k3-j721e: Sync with v6.6-rc1")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi | 8 ++++++++
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi                | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
index b77f8d92de..7ae7cf3d4c 100644
--- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
@@ -93,6 +93,14 @@
 	bootph-all;
 };
 
+&serdes_ln_ctrl {
+	u-boot,mux-autoprobe;
+};
+
+&usb_serdes_mux {
+	u-boot,mux-autoprobe;
+};
+
 &main_usbss0_pins_default {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
index 370fe5190b..479b7bcd6f 100644
--- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
@@ -89,6 +89,14 @@
 	bootph-all;
 };
 
+&serdes_ln_ctrl {
+	u-boot,mux-autoprobe;
+};
+
+&usb_serdes_mux {
+	u-boot,mux-autoprobe;
+};
+
 &main_usbss0_pins_default {
 	bootph-all;
 };
-- 
2.34.1

