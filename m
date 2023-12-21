Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF0DC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADBE5878E3;
	Thu, 21 Dec 2023 18:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gm+XdMzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DDFF87921; Thu, 21 Dec 2023 18:44:30 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C1B878CD
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiFfE083899;
 Thu, 21 Dec 2023 11:44:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180655;
 bh=OfnY9CDq7ObuQsFtUuDPsDOJq6WqXomNDQDQL4jm9x4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gm+XdMztpbQUIEhUOcQovqiKzaeucQTd3VvIeTT2twBRRRGoFi9PdU9pgMmjo7JPs
 iPi2IBpWdEHxpSP7fynBcAzTEkfAt1YsNjLgVRCRDvVaG1tYR9oRklxKmNp0K1ywdk
 HoRbUpcpAlTUySI4/KzylhcrOEgy0/A3BMuxEj1s=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiFCF032102
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:15 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:15 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:15 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiF7S080263;
 Thu, 21 Dec 2023 11:44:15 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 25/26] arm: dts: k3-am65: remove duplicate mcu secure proxy
 node
Date: Thu, 21 Dec 2023 11:44:11 -0600
Message-ID: <20231221174412.210807-26-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1466; i=bb@ti.com;
 h=from:subject; bh=FXWBP+EgZ7bmu1h8XteJo1qzoxpDwOlBzNtmA4YF1d4=;
 b=owNCWmg5MUFZJlNZioMLCgAAbH/////v7y//bX/KcPb3Xvn/+ff+SicCz+8Xbd//qP779XWwA
 Rmwx2o0Mg00A00BoNAAAA0NMTQAA0MjQGjQBoBoA0ADTI2RDRpiGIMn6iPIhyaGQ00000GhkNDR
 oA0BkYjTE9TTRkyAANGjah6gaMg0yAaYjQGgBkaaYJkAAHQeo000GTEPUAaY1NNA0AGg9QaGE00
 0A0A0DQaGnpDQAAZGg0aNBhMIZADEaAAOxp6AmMoActhLAgZ5FToIYFw/sPbukY9CCSFB+ApkNf
 k2mLDdxChmFXiJfN8EWQpqZSJLJMDQyq01OUGRPmYLjDMAyNPDQMdOyXobJX9iWvWdzrYZZQInT
 mNEcc4wcfVydmx2giSxwCO/AGrXX72HZAniYTmy8pIBZaXWaQeBJ8AMcAvXPjyMSCRoqEOrJo0m
 5fLK9E+IBKJJYbVlvrBytHtDbwDylSHChj8lsMqJk1Y5Q1cIyJygIG1PfDZkCweeNozFbClw18G
 UOL1vnJhTPyxjSX8uRLM6dLH1+fgpKlkLoOGNEi2QX5FUZO+q0T2SsPpGlJmzjMSJLnihUbYcgC
 QcDj7Kj2laWFiAk9sZ1wWLVDeBNp69QuQawG7f3Gwp/qTINWrTDN/0YNQamJc+uQulZKhdO4QY5
 6/gag+JyTb3/F3JFOFCQioMLCg=
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

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 057853fa3c285..ed890f61e3ea9 100644
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
@@ -75,7 +68,9 @@
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

