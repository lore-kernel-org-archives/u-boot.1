Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76543E7F15D
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 04:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07ED886D82;
	Wed, 27 Sep 2023 06:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bx4vX6yI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC7D286D7A; Wed, 27 Sep 2023 06:08:04 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C18F686D46
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 06:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38R480PY035665;
 Tue, 26 Sep 2023 23:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695787680;
 bh=F8tO1zQOBTwwd2UfmES/CRBMJrnNMmy8BeN9ZDAFifM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=bx4vX6yIFm+1pzHeDGz6yc6+mzE7CPVZcgcPI26yQQBRFCpPkiU0xBJBCDAbLP+X/
 oTX8Yb4pYkAykGSGXtg0AsSVJDwKwqkT8+Yz/oL3W7poo5gRPiWOzQdaG6KhozV6zV
 +z+ZPdttm+oiXA8UKAFNKxf+EwSNM2qFZEU4SLDQ=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38R480C4017370
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Sep 2023 23:08:00 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 23:07:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 23:08:00 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38R47qDi045178;
 Tue, 26 Sep 2023 23:07:57 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <a-nandan@ti.com>
Subject: [PATCH v2 2/2] DONOTMERGE: arm: dts: k3-j7200-binman: Enable split
 mode for MCU R5
Date: Wed, 27 Sep 2023 09:37:51 +0530
Message-ID: <20230927040751.622194-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927040751.622194-1-n-francis@ti.com>
References: <20230927040751.622194-1-n-francis@ti.com>
MIME-Version: 1.0
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

Set boot core-opts to enable split mode for MCU R5 cluster by default.
This patch serves to demonstrate how this can be done.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/dts/k3-j7200-binman.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index 14f7dea65e..025a0bd071 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -55,6 +55,7 @@
 				<&combined_dm_cfg>, <&sysfw_inner_cert>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			sysfw-inner-cert;
 			keyfile = "custMpk.pem";
 			sw-rev = <1>;
@@ -100,6 +101,7 @@
 				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			sysfw-inner-cert;
 			keyfile = "custMpk.pem";
 			sw-rev = <1>;
@@ -146,6 +148,7 @@
 				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			content-sbl = <&u_boot_spl_unsigned>;
 			load = <0x41c00000>;
 			content-sysfw = <&ti_fs_gp>;
-- 
2.34.1

