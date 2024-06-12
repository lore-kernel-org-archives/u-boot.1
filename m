Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECE6C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 12:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06BFE887E7;
	Wed, 12 Jun 2024 14:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11FD7887C3; Wed, 12 Jun 2024 12:05:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1A6328701E
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 12:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE0211595;
 Wed, 12 Jun 2024 03:05:20 -0700 (PDT)
Received: from e132995.cambridge.arm.com (e132995.arm.com [10.1.35.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 245D63F73B;
 Wed, 12 Jun 2024 03:04:54 -0700 (PDT)
From: harsimransingh.tungal@arm.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, rui.silva@linaro.org,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH] arm: dts: corstone1000: enable secondary cores for FVP
Date: Wed, 12 Jun 2024 11:04:21 +0100
Message-Id: <20240612100421.47938-1-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Jun 2024 14:49:51 +0200
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

From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

Add the secondary cores nodes in the dts file

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Rui Miguel Silva <rui.silva@linaro.org>
---
 arch/arm/dts/corstone1000-fvp.dts | 25 +++++++++++++++++++++++++
 arch/arm/dts/corstone1000.dtsi    |  2 +-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/corstone1000-fvp.dts b/arch/arm/dts/corstone1000-fvp.dts
index 26b0f1b3ce..3076fb9f34 100644
--- a/arch/arm/dts/corstone1000-fvp.dts
+++ b/arch/arm/dts/corstone1000-fvp.dts
@@ -49,3 +49,28 @@
 		clock-names = "smclk", "apb_pclk";
 	};
 };
+
+&cpus {
+	cpu1: cpu@1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a35";
+		reg = <0x1>;
+		enable-method = "psci";
+		next-level-cache = <&L2_0>;
+	};
+	cpu2: cpu@2 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a35";
+		reg = <0x2>;
+		enable-method = "psci";
+		next-level-cache = <&L2_0>;
+	};
+	cpu3: cpu@3 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a35";
+		reg = <0x3>;
+		enable-method = "psci";
+		next-level-cache = <&L2_0>;
+	};
+};
+
diff --git a/arch/arm/dts/corstone1000.dtsi b/arch/arm/dts/corstone1000.dtsi
index 1e0ec075e4..5d9d95b21c 100644
--- a/arch/arm/dts/corstone1000.dtsi
+++ b/arch/arm/dts/corstone1000.dtsi
@@ -21,7 +21,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	cpus {
+	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-- 
2.25.1

