Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D9FC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 633BA87900;
	Thu, 21 Dec 2023 18:44:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RbhigohV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC12287917; Thu, 21 Dec 2023 18:44:29 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 995AD878D0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiElD083870;
 Thu, 21 Dec 2023 11:44:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180654;
 bh=B+C3Rmx/saUPBocFsmEDTtK+5TjH+W8z/s0YO0JM9+w=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RbhigohVjY0VOkqSBZnG7GgjR153vI2JxlSiSiiWgnUmh71rLEDDyvnHeKqP2KlAG
 YkpAG6JTus8ZYg1NUjcE6ioO4QyQxDSZvC+E8wI1yLSFVTDfLMukGzvMNSrbOGuaUc
 jA4LFMEP40mcgq4zDVG5vHaiF7Cl9dQcQ8gr1gC0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiETd097303
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:14 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEm4080226;
 Thu, 21 Dec 2023 11:44:14 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 07/26] arm: dts: k3-am654: remove duplicate vtt_supply
Date: Thu, 21 Dec 2023 11:43:53 -0600
Message-ID: <20231221174412.210807-8-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=844; i=bb@ti.com;
 h=from:subject; bh=FRkh77SlZ3pD6pY+S7E+8OW4B+hO0vkd13DciefXgas=;
 b=owNCWmg5MUFZJlNZxxtwLQAAaP///v9/v7utz/vu22kr/z+297T31//zWV/97/9+3Z/b4X2wA
 RsYIeoGnqaBoAAGgDQAAaABpoeoAABoAAGgAAAA0DRk0AaPU09RtRpk9JmU2UOgDQ0AAeoeoAHq
 AaPUBo0A0AaA00NAaaaaNNPUGQyZABoAaPaoANAGRoyNNAAZTRp6hoNADTTIAAAGI0YjTQNAZGQ
 BkAGjJoDCDE00aBoDQAyaANNBk0aNGmgKFZhqnxBwZFze3h8fqUCViwUwgrZu7+HAfUnaAcCOmN
 BNNFkDDGyJPzcLQ5k8MhtJkRNMHbBcERVfcmDeGX+k/2TB3pL1hGvnQZNAwjzSEsIK+/SxFTLlK
 Ox3wx8JQeMJ9Wzv/NvGdhjZhOc18+1ubwCm+zOUuZKlv4/yaRIzgHDTutwVqUUI2gqVR+L40PPp
 ldBUrDJpac62Hhh0Di9EgELcTHjc3wHX2QBMaaYKCAXqrFXEVnxcuQZw3qJ0K02mQUQS6gR21CN
 MqZBKInPomvdBOFjuUypXs8H6rgMAduSIOAyY0bN6CxBAYpEmIQrDSrtdcMYu1dYnu+HelV8lzJ
 /VFNGFanuBFR2OytLfYqsDqIbxQI2POZFHEKqQJIeHcAFCgdZua94MUVHdmLYPpS+SP/E+xH6T4
 gBhlMZJQfgUC8/4u5IpwoSGONuBaA==
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

With the Linux and U-Boot board dtb files unified we now have a
duplicate vtt_supply node. Remove it

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index bc7291a1adb60..d55ddb83837f3 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -46,15 +46,6 @@
 		ti,sci-host-id = <10>;
 		bootph-pre-ram;
 	};
-
-	vtt_supply: vtt_supply {
-		compatible = "regulator-gpio";
-		regulator-name = "vtt";
-		regulator-min-microvolt = <0>;
-		regulator-max-microvolt = <3300000>;
-		gpios = <&wkup_gpio0 28 GPIO_ACTIVE_HIGH>;
-		states = <0 0x0 3300000 0x1>;
-	};
 };
 
 &cbass_main {
-- 
2.43.0

