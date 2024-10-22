Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8967AD1CDA1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 06:05:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD583891E6;
	Tue, 22 Oct 2024 08:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="LTmWFn9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BECD88F5E; Tue, 22 Oct 2024 08:04:38 +0200 (CEST)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BB7888F6C
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 08:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20241022060433c77011a35c66ea831f for <u-boot@lists.denx.de>;
 Tue, 22 Oct 2024 08:04:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DBW4WuJ41Y3HNejY83R0MIL9XPL2w1AnbLRoOx/q8Ho=;
 b=LTmWFn9xE6Rv1pj/ENgJfPRToi3G5oq81QAToNXPcSJi0N6Kg9akKooePelyASUxR1cESA
 vNWuLFCm1Ma5NkJC9T+1j+FzHHf6/5H3d6xuxfVQ7/jwMG1aBroxBl//+I4cvV7N/oq8fkjr
 U/gduWSfGCvyDuXxUOnEKjGSA1I9AR568X8J/dNgWMezyUCLov4ZdCmMpOzhz/W/nrFcbns5
 f3RNNe9lZWItXxJKg/L6UhkEF7ayowSfCQ74LUdRxO3VBdCK6vn4WZ+dLKL/MAyvyOSXe7SA
 dBxHxujtK39J0g/SpyMPfUdlYKmSc7aF7vIbJuqm+4BFSN65QUSzsDRw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 07/13] arm64: dts: ti: iot2050: Disable lock-step for all
 iot2050 boards
Date: Tue, 22 Oct 2024 08:04:24 +0200
Message-ID: <00089092a49a5356736e0df553a60b7e1bee97b4.1729577070.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1729577070.git.jan.kiszka@siemens.com>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Li Hua Qian <huaqian.li@siemens.com>

The PG1 A variant of the iot2050 series has been identified which
partially lacks support for lock-step mode. This implies that all
iot2050 boards can't support this mode. As a result, lock-step mode has
been disabled across all iot2050 boards for consistency and to avoid
potential issues.

Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Link: https://lore.kernel.org/r/d1f5f84db7a1597cd29628a0b503e578367b7b40.1724830741.git.jan.kiszka@siemens.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: e0133f883cf115d9e97e704169a9fb6003caefb2 ]

(cherry picked from commit 4b4872feb66a9043741819a57af280ffb4a96608)
---
 dts/upstream/src/arm64/ti/k3-am65-iot2050-common-pg2.dtsi | 5 -----
 dts/upstream/src/arm64/ti/k3-am65-iot2050-common.dtsi     | 5 +++++
 dts/upstream/src/arm64/ti/k3-am6528-iot2050-basic.dts     | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am65-iot2050-common-pg2.dtsi b/dts/upstream/src/arm64/ti/k3-am65-iot2050-common-pg2.dtsi
index e2584a5efe3..b3c4c0eec3d 100644
--- a/dts/upstream/src/arm64/ti/k3-am65-iot2050-common-pg2.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am65-iot2050-common-pg2.dtsi
@@ -9,11 +9,6 @@
  * Common bits of the IOT2050 Basic and Advanced variants, PG2
  */
 
-&mcu_r5fss0 {
-	/* lock-step mode not supported on PG2 boards */
-	ti,cluster-mode = <0>;
-};
-
 &main_pmx0 {
 	cp2102n_reset_pin_default: cp2102n-reset-default-pins {
 		pinctrl-single,pins = <
diff --git a/dts/upstream/src/arm64/ti/k3-am65-iot2050-common.dtsi b/dts/upstream/src/arm64/ti/k3-am65-iot2050-common.dtsi
index ef34b851e17..e76828ccf21 100644
--- a/dts/upstream/src/arm64/ti/k3-am65-iot2050-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am65-iot2050-common.dtsi
@@ -635,3 +635,8 @@
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 	};
 };
+
+&mcu_r5fss0 {
+	/* lock-step mode not supported on iot2050 boards */
+	ti,cluster-mode = <0>;
+};
diff --git a/dts/upstream/src/arm64/ti/k3-am6528-iot2050-basic.dts b/dts/upstream/src/arm64/ti/k3-am6528-iot2050-basic.dts
index 29a31891b3d..4968a47f31e 100644
--- a/dts/upstream/src/arm64/ti/k3-am6528-iot2050-basic.dts
+++ b/dts/upstream/src/arm64/ti/k3-am6528-iot2050-basic.dts
@@ -22,8 +22,3 @@
 	compatible = "siemens,iot2050-basic", "ti,am654";
 	model = "SIMATIC IOT2050 Basic";
 };
-
-&mcu_r5fss0 {
-	/* lock-step mode not supported on this board */
-	ti,cluster-mode = <0>;
-};
-- 
2.43.0

