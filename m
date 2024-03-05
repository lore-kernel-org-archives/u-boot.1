Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B741EC54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D5C588076;
	Tue,  5 Mar 2024 14:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="enPMmljo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 370778805D; Tue,  5 Mar 2024 14:25:25 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1784287FA5
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 14:25:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9F40161381;
 Tue,  5 Mar 2024 13:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A5FC43141;
 Tue,  5 Mar 2024 13:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709645118;
 bh=saM3fx0ckZ3B7Bn/drgcT5EmHQ3FFszlcw76wVquAuM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=enPMmljoAiS+6sls+/DH9rWmbINx4K59Jn6A+3mWzSTYmEy5tlFE3/Y5qmf3zpSiW
 H6+5+07V21D7CzKDBvmsG30OepiZ+S+46+pK/zYGRHvJrvzqdYknQuNBn8qoP8rWta
 W1C8bdiyfRk4ZWhaZ03WQfen7YBOQZ6q7SRezNG+BlRo5mbA6SuZgJ5iSuPbobTa0D
 UTITBnMl5tQVPUKxdmILlQVulI0xEF3nXOfXMHFKn1gWkT90fWFRjlJNXjQSxkyV1l
 T+nDdP1/9Y2cOj6ZXeM5GJHCmXvzBZt7P5jYVWQUdVg6xDjhxThVtSToFvwM6Apf3v
 AYNqxT3THbVlg==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 05 Mar 2024 15:24:56 +0200
Subject: [PATCH not-for-merge 4/5] k3-am625-beagleplay-u-boot: get CPSW
 Ethernet to work
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-for-2024-07-beagleplay-eth-v1-4-e1294a575cc1@kernel.org>
References: <20240305-for-2024-07-beagleplay-eth-v1-0-e1294a575cc1@kernel.org>
In-Reply-To: <20240305-for-2024-07-beagleplay-eth-v1-0-e1294a575cc1@kernel.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com, 
 danishanwar@ti.com, u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1818; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=saM3fx0ckZ3B7Bn/drgcT5EmHQ3FFszlcw76wVquAuM=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl5x0r1kCEzWzeBilU06eVvk/tMhn4+SY2fOx2V
 jLBrro1W9WJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZecdKwAKCRDSWmvTvnYw
 kwcoEACVzxyWuBwP695To5aMmODrfoAtKJa2fViIcZTY42V3plcbq8zQE/wF1lVCP9zDVIfsBqf
 0B6lk79wdEhtOvkWztAWXYXsBmbIpg2BXrhlrjTLSc6BkLkkZh9RSfajZrO6ML+sd1QjpWGHlP4
 DNqpZHEQMb8mZCIaB/SN9DWYNjtH3LHYsIOXDszeKcogzZxIrDp0RiXnXWriEDWnqy0N+Yu10DD
 4/ED7LIhO7WtmdauGfuuceUHqgeVKzTx0EFTjZ1cOdQAolWOnUv9mFXvfOjbAafoInOQkTldgNB
 mut12ab0RpwaT/oe2CBq+64NBNZrwC9m4afHAmyt4poCRDOoveko9yE+VWUAQ5YHSlteN4mmVz0
 HjecRjxywNSgfZNCGOgvrKeYhyX65NsEql+0S9FHbvsUPqwTbmCwTHME6Szux7HgoYDXK4mYxw7
 BmpBmp/7QVHM/NymgIUPZriZ+fU2PjHKcmii5FONg/majxgL2/uZFjo1VHJmtGmdxpUlAy8nGj7
 G0Lf9a4A10SvkkTjRk1LB4b4vccFsRH10WDUNzIA1UcUSHMHVi/iFV5/nIJYnmFez957MexNL8Y
 7CA9iwRhoCft6LMUlvKtxPzbMBr30J0sucsHBNjvJ9hl4V79GPQ8yPnI89Jkc3+Y+VFnzfAvV4p
 jth4w5WSdlcJl0A==
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

Add missing bits to get CPSW Ethernet working.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index a723caa580..fc05121ccc 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -213,3 +213,66 @@
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

