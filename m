Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCCCCF044D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 11:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E3288FB7;
	Wed,  9 Oct 2024 13:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OmmFiD60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4915E88FB7; Wed,  9 Oct 2024 13:04:54 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C2FB89152
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 13:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 499B4ml2005203;
 Wed, 9 Oct 2024 06:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728471888;
 bh=oi+y1Q8AZdD2jGAImD1yQy2GwGwZ7er6Fz0daYmP4Us=;
 h=From:To:CC:Subject:Date;
 b=OmmFiD60fvfygTYadavg95avEkWyGTwmUH0Ry7tpQFWW7TKIBlRPjI4LqKkB4W8cl
 MnmQaIaOSJzTObuC9+2aoDHCD/O7Cs0kFOPBjnf+gfiJaFcGaGg75yillvUU1pWOjd
 jqabTvSGQ9NWrnAGn+SXYGi0Y64BHRNd6wkSHzws=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 499B4m71047868;
 Wed, 9 Oct 2024 06:04:48 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Oct 2024 06:04:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Oct 2024 06:04:48 -0500
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com
 [172.24.227.158])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 499B4l81002772;
 Wed, 9 Oct 2024 06:04:48 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <trini@konsulko.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <kamlesh@ti.com>, <j-humphreys@ti.com>, <d-gole@ti.com>, <bb@ti.com>,
 <u-boot@lists.denx.de>
CC: <j-choudhary@ti.com>
Subject: [PATCH] arm: dts: k3-j722s-binman: Add support for HS-SE
Date: Wed, 9 Oct 2024 16:34:47 +0530
Message-ID: <20241009110447.296776-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

From: Udit Kumar <u-kumar1@ti.com>

J722S SOC have two variants as HS-FS and HS-SE.
Add binman support for HS-SE variant.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
[j-choudhary@ti.com: Fix load-dm-data entry and indentation]
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm/dts/k3-j722s-binman.dtsi | 50 +++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/dts/k3-j722s-binman.dtsi b/arch/arm/dts/k3-j722s-binman.dtsi
index 28087a3b6f..6b52116657 100644
--- a/arch/arm/dts/k3-j722s-binman.dtsi
+++ b/arch/arm/dts/k3-j722s-binman.dtsi
@@ -7,6 +7,56 @@
 
 #if IS_ENABLED(CONFIG_TARGET_J722S_R5_EVM)
 
+&binman {
+	tiboot3-j722s-hs-evm.bin {
+		filename = "tiboot3-j722s-hs-evm.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
+				  <&combined_dm_cfg>, <&sysfw_inner_cert>;
+			combined;
+			dm-data;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl>;
+			content-sysfw = <&ti_fs_enc>;
+			content-sysfw-data = <&combined_tifs_cfg>;
+			content-sysfw-inner-cert = <&sysfw_inner_cert>;
+			content-dm-data = <&combined_dm_cfg>;
+			load = <0x43c00000>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x67000>;
+			load-dm-data = <0x43c7a800>;
+		};
+
+		u_boot_spl: u-boot-spl {
+			no-expanded;
+		};
+
+		ti_fs_enc: ti-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+
+		combined_tifs_cfg: combined-tifs-cfg.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+
+		sysfw_inner_cert: sysfw-inner-cert {
+			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+
+		combined_dm_cfg: combined-dm-cfg.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+};
+
 &binman {
 	tiboot3-j722s-hs-fs-evm.bin {
 		filename = "tiboot3-j722s-hs-fs-evm.bin";
-- 
2.34.1

