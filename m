Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36940C47DDF
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 12:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C49B487D58;
	Wed, 24 Jan 2024 13:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uSWk2HVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56405878A5; Wed, 24 Jan 2024 07:50:15 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 467E487BC3
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 07:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40O6nwG7046302;
 Wed, 24 Jan 2024 00:49:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706078998;
 bh=7Owf/3KZkCtkJCZ0mDb0igY3iRNHVNdboZLt0zpW5Vw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=uSWk2HVrhoJWehCyEx53/eaIPeS0oPJGpj8Oa4kTnwM8AUmZjynTbgRxVTr+XQkbe
 SwNedL5gD6qCzfF7s8No0SVRZqYentLPHlREdeLpNAUS+aURKW1Ij9BlosKT8Hq0Oo
 NPN318f1aQKqmBoS8AhSsHy9D9U0FzSi2Pnc1d00=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40O6nw2F009162
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 00:49:58 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 00:49:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 00:49:57 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40O6nvWn071917;
 Wed, 24 Jan 2024 00:49:57 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40O6nu6Z011007;
 Wed, 24 Jan 2024 00:49:57 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, Bryan Brattlof
 <bb@ti.com>, Sean Anderson <seanga2@gmail.com>, Martyn Welch
 <martyn.welch@collabora.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Simon
 Glass <sjg@chromium.org>, MD Danish Anwar <danishanwar@ti.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Kever Yang <kever.yang@rock-chips.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH v3 11/15] arm: dts: k3-am65x-binman: Add ICSSG2 overlay
 and configuration
Date: Wed, 24 Jan 2024 12:19:26 +0530
Message-ID: <20240124064930.1787929-12-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124064930.1787929-1-danishanwar@ti.com>
References: <20240124064930.1787929-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 24 Jan 2024 13:42:05 +0100
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

Add ICSSG2 overlay and configuration to tispl and u-boot images.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm/dts/k3-am65x-binman.dtsi | 65 +++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-am65x-binman.dtsi b/arch/arm/dts/k3-am65x-binman.dtsi
index 8cc24da1f3..d0cd4889cd 100644
--- a/arch/arm/dts/k3-am65x-binman.dtsi
+++ b/arch/arm/dts/k3-am65x-binman.dtsi
@@ -98,6 +98,8 @@
 #define SPL_AM654_EVM_DTB "spl/dts/k3-am654-base-board.dtb"
 #define AM654_EVM_DTB "u-boot.dtb"
 
+#define AM654_EVM_ICSSG2_DTBO "arch/arm/dts/k3-am654-icssg2.dtbo"
+
 &binman {
 	ti-spl {
 		insert-template = <&ti_spl_template>;
@@ -124,6 +126,20 @@
 						filename = SPL_AM654_EVM_DTB;
 					};
 				};
+
+				fdt-1 {
+					description = "k3-am654-icssg2 overlay";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&spl_am65x_evm_icssg2_dtb>;
+						keyfile = "custMpk.pem";
+					};
+					spl_am65x_evm_icssg2_dtb: blob-ext {
+						filename = AM654_EVM_ICSSG2_DTBO;
+					};
+				};
 			};
 
 			configurations {
@@ -133,7 +149,7 @@
 					description = "k3-am654-base-board";
 					firmware = "atf";
 					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
+					fdt = "fdt-0", "fdt-1";
 				};
 			};
 		};
@@ -168,6 +184,24 @@
 					};
 				};
 
+				fdt-1 {
+					description = "k3-am654-icssg2 overlay";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&am65x_evm_icssg2_dtb>;
+						keyfile = "custMpk.pem";
+
+					};
+					am65x_evm_icssg2_dtb: blob-ext {
+						filename = AM654_EVM_ICSSG2_DTBO;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+
 			};
 
 			configurations {
@@ -177,7 +211,7 @@
 					description = "k3-am654-base-board";
 					firmware = "uboot";
 					loadables = "uboot";
-					fdt = "fdt-0";
+					fdt = "fdt-0", "fdt-1";
 				};
 			};
 		};
@@ -205,6 +239,16 @@
 						filename = SPL_AM654_EVM_DTB;
 					};
 				};
+
+				fdt-1 {
+					description = "k3-am654-icssg2 overlay";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					blob {
+						filename = AM654_EVM_ICSSG2_DTBO;
+					};
+				};
 			};
 
 			configurations {
@@ -214,7 +258,7 @@
 					description = "k3-am654-base-board";
 					firmware = "atf";
 					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
+					fdt = "fdt-0", "fdt-1";
 				};
 			};
 		};
@@ -243,6 +287,19 @@
 						algo = "crc32";
 					};
 				};
+
+				fdt-1 {
+					description = "k3-am654-icssg2";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					blob {
+						filename = AM654_EVM_ICSSG2_DTBO;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
 			};
 
 			configurations {
@@ -252,7 +309,7 @@
 					description = "k3-am654-base-board";
 					firmware = "uboot";
 					loadables = "uboot";
-					fdt = "fdt-0";
+					fdt = "fdt-0", "fdt-1";
 				};
 			};
 		};
-- 
2.34.1

