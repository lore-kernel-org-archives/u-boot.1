Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCF9E9371F
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 23:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43D8986ACA;
	Tue, 10 Oct 2023 01:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696893361;
	bh=zHiegYBVTYNt3kicUspPR8jsYsgvsymnJ6TXbGuJhAQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=imai++0BEMRpZHvafb2gBtH10oiRPWRtYzZJKBoCMV6RgygaAeYc4FoHny1KGVJGc
	 6mWChh4aRupJf+tH8cXhrInXPx5eGi4u/OFZbmptkxqHBtI7GJsF2Nv4CsduJUOC9U
	 PXYsBipdojpjFj7bteJvdFdx8FtzwKWTO/b9+SV6qcQDVbTCKZ54m+7t3LWWybLZGW
	 JA1ASB/lxsiP5cuRvEhuYVDbHSAyswfTdEgAITFj/bsgo7KYH45Yzma/OZjrFYqo0R
	 mZcFjibmuolSZjmtZZnMsjMZx6JbUY8gDJWJgjuwnZDkt7GKrfzAq5/7Bndw1Fy53Y
	 HOKUD/bS1QTyA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0B8DE86CAD;
 Tue, 10 Oct 2023 01:15:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696893358;
 bh=zHiegYBVTYNt3kicUspPR8jsYsgvsymnJ6TXbGuJhAQ=;
 h=From:To:Cc:Subject:Date:From;
 b=Z4iV3Ey19aO/42GiTo+UERC5ZOagYh3mtf33B8OUex1e/hssW3YQ/LJ4ucXKAxbUO
 +wPgSB1jWcl+ENovTb4z2ifWsa5Q469RngiI/AJQulRH1HYLBmJ2+15KVftTHfjF13
 u4r6R5Xkrx1t7rr/DpcPCwG6WGB9YLWjC291O8Qg+GkYN5yTKdTNbgmvw8PMmz50oO
 yLbjm+aTgYaRv0p5bqtsN1WMcsKDp+moTr9U5vXgTvsguV7mmfEDrU//p7s7RQotfr
 +ZqO+UKTCAbFMI/awrGgM1kJsi4n2WMB1mMx83z9pLCmxgfEmXOAt8SJJem4EjSujR
 7OJRRm06xVjCw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32mp: Repair damage from alignment with v6.3
Date: Tue, 10 Oct 2023 01:15:51 +0200
Message-Id: <20231009231551.354425-1-marex@denx.de>
X-Mailer: git-send-email 2.40.1
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

The patch fixed by this commit renders ST STM32MP15xx EV1 board and
all DHSOM SoM based boards unbootable from SPI NOR. Fix the damage
by updating -u-boot.dtsi to match the stm32mp15-pinctrl.dtsi update.

Fixes: 08002ffd083d ("ARM: dts: stm32mp: alignment with v6.3")
Signed-off-by: Marek Vasut <marex@denx.de>
---
NOTE: It is truly incomprehensible how 08002ffd083d was ever tested
      at ST, I can only speculate it never was tested at all, grumb.
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi   | 16 ++++++++++++----
 arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi | 12 +++---------
 arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi |  8 ++++++--
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi b/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi
index 1f7fdbce530..eb283cacd27 100644
--- a/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi
@@ -135,20 +135,28 @@
 
 &qspi_bk1_pins_a {
 	bootph-pre-ram;
-	pins1 {
+	pins {
 		bootph-pre-ram;
 	};
-	pins2 {
+};
+
+&qspi_cs1_pins_a {
+	bootph-pre-ram;
+	pins {
 		bootph-pre-ram;
 	};
 };
 
 &qspi_bk2_pins_a {
 	bootph-pre-ram;
-	pins1 {
+	pins {
 		bootph-pre-ram;
 	};
-	pins2 {
+};
+
+&qspi_cs2_pins_a {
+	bootph-pre-ram;
+	pins {
 		bootph-pre-ram;
 	};
 };
diff --git a/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi b/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
index f12941b05f6..2f70b0690d2 100644
--- a/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
@@ -134,20 +134,14 @@
 
 &qspi_bk1_pins_a {
 	bootph-pre-ram;
-	pins1 {
-		bootph-pre-ram;
-	};
-	pins2 {
+	pins {
 		bootph-pre-ram;
 	};
 };
 
-&qspi_bk2_pins_a {
+&qspi_cs1_pins_a {
 	bootph-pre-ram;
-	pins1 {
-		bootph-pre-ram;
-	};
-	pins2 {
+	pins {
 		bootph-pre-ram;
 	};
 };
diff --git a/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi b/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi
index eb905ad2820..552b35db3c7 100644
--- a/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi
@@ -98,10 +98,14 @@
 
 &qspi_bk1_pins_a {
 	bootph-pre-ram;
-	pins1 {
+	pins {
 		bootph-pre-ram;
 	};
-	pins2 {
+};
+
+&qspi_cs1_pins_a {
+	bootph-pre-ram;
+	pins {
 		bootph-pre-ram;
 	};
 };
-- 
2.40.1

