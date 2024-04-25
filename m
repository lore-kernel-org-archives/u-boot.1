Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05924C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED23688F1E;
	Thu, 25 Apr 2024 14:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K3EVEC7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45CCA88F42; Thu, 25 Apr 2024 14:21:18 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B515588F37
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 14:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0D7FCCE1954;
 Thu, 25 Apr 2024 12:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA721C2BD10;
 Thu, 25 Apr 2024 12:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714047672;
 bh=FxnTo4qq+53/lSdsPQe2DR2+BW74p/1gSw5Q4AstjkQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=K3EVEC7tF4wdaSwx7LnneWVO9I8ZW/AHwT8y/Z7L2OGzHMzt7YtUz3NNDBL41h5cf
 Ear4t7gnS26y6zUppctr+C7DJGudK2kr1rtkMeDDPsGlsvbHFnn5+UgmzSeXCYIOTn
 SaMiNvpdJX19ZeXKy72oTZyjTGarIIAkbbQhUmJsp+UOSf5r65sU3gLEuu21GHRbnb
 JGZjHgHTjLpqXOKAPHsHoxHvr4hNIfPpN3/UJIlActyIiOsvODCp8vbgzQbIkVVi1v
 c6BH8ztHHAHns11l7ChevbMsD9ftApKkk4FwOcpc9+VhgmGb+Cr0Up3yhn0As5716i
 qbFP6p6CL79zg==
From: Roger Quadros <rogerq@kernel.org>
Date: Thu, 25 Apr 2024 15:20:53 +0300
Subject: [PATCH 2/3] arm: dts: k3-am625-beagleplay: get CPSW Ethernet to work
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-for-2024-07-beagleplay-eth-v1-2-6c985de1c316@kernel.org>
References: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
In-Reply-To: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
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
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmKkqsfqhmsB2UcWbSp9SJKaopfVOQgDeYYQUgK
 rNVxJtb+POJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZipKrAAKCRDSWmvTvnYw
 k8iPEADFjwLA1KNzd12K9tlRqx3V4cKgJtBmkUxfZhm41j8MPtu63qrorGL+TrzoSSwA/4hHU95
 cJG3kBmf1N8av8SvKQT3NnERS6mRFxo4w+ejfKZAdshcSSrkDXHrAgMZaGcVcZqT86ADneUkuEs
 c4d21IfAX3e5ePW/UqgW4pF3HDEr75blPKIwpbiZGgSliB6bJB8f0HLaHQYNDND7z/KSbrm7NT9
 e0lS29lCjdmRGIVZFWn2ASejzO/TvuKbDjnGG4pZCGcGBs99j5RH5seI0ekar34xTvgE8CvbciO
 1p44mrAypao76IouLX4/BY3BdBXVZyBXltCmdke8Szx/d+TSoTuzAKcNTSTmd+9enBA0R84y2j4
 gWN9kZwpHU5Ag+w9DXdttC5LxSVJGyrqlG7QaRFoDvDCpdpGbgHDxKvXAA0vRzNz9TZWSvCXUBs
 TOIet2EGBlpafTtidERqTyHvF5YS8l0NKHAMbFWHOvBVf0pMmTwlWqcOtqzfwe2ctDGb+PAhQ3R
 NTU3Gcog404g4Blf1pdNB0JIa9/jXoK5JfABS28Vua/XNCQQkv1E+sjlI1pZc9cE6HBbgL7sbXX
 PZts6uByYWUDTjGLCS5pFIAfFr6z5ENo/o5OIfyr+DYIOan7PoLijQDcnP8T8G0u+fCtaLTo/Tk
 6X2VjNHyIn8kj+Q==
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

