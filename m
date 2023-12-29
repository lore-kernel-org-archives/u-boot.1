Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBDCC47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 902B287BF0;
	Fri, 29 Dec 2023 18:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VMBx/qiN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5035887BAF; Fri, 29 Dec 2023 18:47:16 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9CAE87BAA
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1dk088948;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=34bGCSaKoffj4OOD9LyCfwnZ0KWOEKbGIUqIrLAfluk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=VMBx/qiNg4n9EObN3hdzFYPkxbfwpYSDcVokaVvmqUdzoM3IaDKfuOA2U8Dwszdzn
 G2b8+jLBOPUcQtsBnAR9lVA5EZWCch+XrRYx35GaOwxmXXvPmpdhL7i6GYZGYHqxnD
 T1msS4/DD/9oHfyx5S8SwmMV7Z1mJAQvb5vp6Weo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl12U115340
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl11u005067;
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
Subject: [PATCH v2 10/26] arm: dts: k3-am654: remove duplicate mcu_ringacc
Date: Fri, 29 Dec 2023 11:47:07 -0600
Message-ID: <20231229174656.634065-38-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016; i=bb@ti.com;
 h=from:subject; bh=roKjrNVbH1uayZu8kVeVTzk7eqrXpMq32T+B1iQ+iFw=;
 b=owNCWmg5MUFZJlNZgnxKcAAAZX///v/frzm7ebfMvc2bXtrn3/m3/3+/r/tv//6f/1t1rfawA
 RmZo4TI0ABpoDQAAZDQ9IYgeoA0GgaDCAyADQA00yAAGmgAAD1NGTTENPUxPUQaNANAADQAANBp
 po0xGhoAAADQAxNMjExBgmmhkNqGgYE00AaeoaDQxDQMJPU0aeoDQNDQDIaPU2o0AGhoNAND1DQ
 AHqZDQA0AAAA00AAAaAAaAyG0QMNQgEQiMhAbV0tAaUupGTAGix7undsyO17Oa5twBjqAOhGLcV
 IPwGkqgNnK+IJ6AhPL5EtCxlJDI01Sw5yCVXvuAHHnLjtVF1uVynIFvRaaPmqVGXfTac+U8OZC0
 XvUsZQGgxlMWbtbmS7a8HE4dRfMAVLJj6ReaTUp5Pgx6qxNAJEO9jJaCV7AVJ5dinFlMSYI02fm
 G1wGzyHOoGiRpyrul8sLjadfOt3auOav4blyCrCRY5QgUkFElgD2yozfO5bqU3WbfUHcA+yoMEc
 0VvDX3U/GDWkBdkq5WJZaTnAl2OyuQvteIAv7PIEe2KVYZrw2NFHwidrMJYOaWhyCIBMIh0y8pK
 GPqV37Ci8+/tas+MCiQqbPHN4BReqVnPYeDiVwLu6K8L7JWL/06sW0g0EtkyoRKBfvMAja5+5AS
 10gOULUQRb/i7kinChIQT4lOAA=
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

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index f462262b9aaac..c4fa84a3d0b05 100644
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

