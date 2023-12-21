Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6A3C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C4C878D0;
	Thu, 21 Dec 2023 18:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vMFqeOWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FE97878F7; Thu, 21 Dec 2023 18:44:28 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D31B87862
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEp7118517;
 Thu, 21 Dec 2023 11:44:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180654;
 bh=sT+550x8h1oSINfUKRflQ1vOgfXVx/N7rWS3XxDL7XI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=vMFqeOWtd4vpC7JTFhzlOw2nvo/emnw4jq43t8BgY6tC9YpgI56tRvML7NQ+0gbns
 NezJ404jqGVYajARYOpDjUEtycaOg8i51sPm6FDCq+L/32rrhLH+J1H2twvL5JBN4p
 6A1Qp74KewtPK/T4veFv+S1Hbr/eqIb514AbQokE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiERp113460
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:14 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiE4c080234;
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
Subject: [PATCH 10/26] arm: dts: k3-am654: remove duplicate mcu_ringacc
Date: Thu, 21 Dec 2023 11:43:56 -0600
Message-ID: <20231221174412.210807-11-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=bb@ti.com;
 h=from:subject; bh=lx5Gwd+3u2eaJdz3pmURJV+CpM9YPaLjTbICDwI8jpU=;
 b=owNCWmg5MUFZJlNZBNkBcgAAY3////9pa/fz+vz52/fn37wWqc52146fe8/l599/3/3f3u+wA
 RmbRDyhoaNDQGnpAA0NA0DI9JpoDQAMgAMgAMhgg0NAAaDJoAAGgDT1A2psUMoaaNNAA0GTIABo
 BoaGEDTQAaAYgBpoyDTJgQBo0yNDIAA0Damg0BsUaDtI9R6mj1NPSNA0A0PUA0AekGgAA8oA0AN
 AGgMgDINAAAGQDQDTRoepkekNNAQSbwMcMK4BEDNEHtxQdC00jJlY8SggSwOGy26vlVZatLjvQu
 ZJQUMhkU60CO0Jb3Np1QzS/i6PkXxgk1TKLhgaDm2mIW9crGKufcbVS5nkZ3j6jK7EU/fpCnF5D
 Qs1TzwaqnS4Wt7LqggkYc598eGmpc67/WxBAuE72Ts5Dq2Lx6d3EnFh7q/Mr/XrrlrRrcj3zoLt
 BFAGBojgLVE3FxoNkGoO2w/mAbINPa22TDWZggiBMDjT6Howllv2cXJ1MszlMKP7fhU5lh+cZW4
 6Wb4bHAEnnUGh+G+0Bjr2za96bLRmESSK7SRNIFMUi+ukysKPoaWns8J5qI+HNGCRVTNKveH4cC
 XGKIAWs2Bg4jYBe0kIzFT5AwGsKUD2qxd++q77CWDij+OAgasQRrortw4aAyNZE1DIggDyEoCd4
 qTEMQ2n+LuSKcKEgCbIC5A=
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
duplicate mcu_ringacc node. Remove it

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 3b27ad842532c..cb25db7a3afd0 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -54,16 +54,6 @@
 	};
 
 	mcu_navss: bus@28380000 {
-		ringacc@2b800000 {
-			reg =	<0x0 0x2b800000 0x0 0x400000>,
-				<0x0 0x2b000000 0x0 0x400000>,
-				<0x0 0x28590000 0x0 0x100>,
-				<0x0 0x2a500000 0x0 0x40000>,
-				<0x0 0x28440000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
-			ti,dma-ring-reset-quirk;
-		};
-
 		dma-controller@285c0000 {
 			reg =	<0x0 0x285c0000 0x0 0x100>,
 				<0x0 0x284c0000 0x0 0x4000>,
-- 
2.43.0

