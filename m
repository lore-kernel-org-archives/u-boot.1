Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ED2C47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C2B87C15;
	Fri, 29 Dec 2023 18:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z1xj9EIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DB9187B82; Fri, 29 Dec 2023 18:47:20 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A9AE87BBA
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1vr025745;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=i78b7sPHwA9oS8dVZPg0mLwTznUup8aStGkImQ0X8dc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Z1xj9EITU6x03RMT7SWq/AxhYBlClc7INOBDVAuTcArAKFY8+28ls8DERH7LBp5bw
 QeSCoJsa1XXAKP7pTB7J1CcbI1SOAdTOAV+PjEdliQWFNWxn95u8UBXKsBHS5K2Wk6
 MfIhzKOKIGItv5Mg/5bk6DrRqAmyT0QmUceYCobM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1Vc115370
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1lu122729;
 Fri, 29 Dec 2023 11:47:01 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 25/26] arm: dts: k3-am654: remove duplicate mcu secure
 proxy node
Date: Fri, 29 Dec 2023 11:47:22 -0600
Message-ID: <20231229174656.634065-53-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=bb@ti.com;
 h=from:subject; bh=lSaDJrICVhDos39vEUPaEGuKMXS4pSLU7pqmDsxVjDk=;
 b=owNCWmg5MUFZJlNZm5AI9QAAZf////79qud5i33TG+by9n/S/4fr/m/PeHvXT/tu+f7a6U+wA
 RmMkPUGmhpo09R6gMmgNNAAaGENGgaDQyAHqAADBAyYjIMg00NNGhpo9QMhp6h5NQ5AAaAD1A0D
 RoDQBpoeoZAMg9Q0NBo9T1NA9EADyQekGh5IaaDIZA9QNGJppkORk0aDRpsiBoZDEBp6mjTIyGj
 TagYgAZNDIMRmk0aGjIDTTTTRoADQaGRoBoBo14pj/oMRCPwljfgHkyJRpSlF4o1Fh9N+pfBQpF
 +nmgoiUFKDcgLAhsv0ICgBzJbhgC5JQRPQ+31YxXtA3AfSCDMNUkS1Abd3eGTX439yTImngVJ4t
 8vzJZ4ArrUoQC5QfOgneGKLcMxj1HVuck0zVrFJd+GE4wggadd9jZgyyRFnqnPkhDYpLYvkXqu8
 pETGUhstM5YwmLy+TYhqm/o12TVC9p5ICOpW+1s08fBaJamCClSO6HSulGs1HX3Lfb9f29Ye9k7
 P/LeJD4pvGDRilGesQj0Y0SD6YAJ4KmtNNNsnfpqG5kRete6lkxwefd6kB3vHDTXaVAME6GSiPb
 D0e+2OBfWNsCKEAN8x4kPMvCAz4uLOTv8KD+GAOl9vUr+zayiA5W6xUhyIPFtgijbcGfP0g/6OY
 IACzniKdThvP8XckU4UJCbkAj1A
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

With the Linux and U-Boot board dtb files unified, we now have a
duplicate mcu secure proxy node. Remove it

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index b27b2b05ad840..dea2ba85dcb31 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -39,22 +39,15 @@
 	};
 };
 
-&cbass_mcu {
-	mcu_secproxy: secproxy@28380000 {
-		compatible = "ti,am654-secure-proxy";
-		reg = <0x0 0x2a380000 0x0 0x80000>,
-		      <0x0 0x2a400000 0x0 0x80000>,
-		      <0x0 0x2a480000 0x0 0x80000>;
-		reg-names = "rt", "scfg", "target_data";
-		#mbox-cells = <1>;
-		bootph-pre-ram;
-	};
+&secure_proxy_mcu {
+	status = "okay";
+	bootph-pre-ram;
 };
 
 &cbass_wakeup {
 	sysctrler: sysctrler {
 		compatible = "ti,am654-system-controller";
-		mboxes= <&mcu_secproxy 4>, <&mcu_secproxy 5>;
+		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
 		mbox-names = "tx", "rx";
 		bootph-pre-ram;
 	};
@@ -76,7 +69,9 @@
 };
 
 &dmsc {
-	mboxes= <&mcu_secproxy 8>, <&mcu_secproxy 6>, <&mcu_secproxy 5>;
+	mboxes = <&secure_proxy_mcu 8>,
+		 <&secure_proxy_mcu 6>,
+		 <&secure_proxy_mcu 5>;
 	mbox-names = "tx", "rx", "notify";
 	ti,host-id = <4>;
 	ti,secure-host;
-- 
2.43.0

