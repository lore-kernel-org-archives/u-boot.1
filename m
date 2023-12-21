Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF1DC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928C7878F2;
	Thu, 21 Dec 2023 18:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oDX2+abX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6995E87913; Thu, 21 Dec 2023 18:44:29 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9634D878AD
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEHo118513;
 Thu, 21 Dec 2023 11:44:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180654;
 bh=HXhQqWDx+qqwbs+/bmRtrP46EfIppFv4tvFNw6kLjMI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=oDX2+abXXeVkN/Ldw7d/YnjwYOjMxbM8XtWQfNmHuc5NIejuRnXBUs66lxoNTctyy
 b4/PdM+QI0aR9pwUTX/1XLQZwl4kRE+Sb/OBVW4pfpEdQY3D5B//cGDmF0s07z2JuO
 FopIXsc0fs9LOsKf1mg12noGVp1t6K6+flgQGtMI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiE08032083
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:14 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiE4o069239;
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
Subject: [PATCH 06/26] arm: dts: k3-am654: include a53 board dtb for r5 build
Date: Thu, 21 Dec 2023 11:43:52 -0600
Message-ID: <20231221174412.210807-7-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; i=bb@ti.com;
 h=from:subject; bh=Nuf5PC0ALbEC61gDoB6jdgtZvCsmBvDNC/AQxRrBxJU=;
 b=owNCWmg5MUFZJlNZdAkx6gAAYn///7/5++N4/vba41wP9ifui//3++/O/lsfWNz/9Xd//f+wA
 RswHahoGgAaAAGjIGgaaGmgNADQNAGgAZGjRiAZBpkB6hoMg0xMR6mm1MmTJ6CHIANGgNMj0Jk0
 00AaDQZAaaMTI0Bk9QBoaDQyGg0ZAxAMQyMhkDTTT1ABk0AdGmmg0GjQyaAyGmmQxNMmQ0BoBiA
 xAMCGjEyZMJhDQADEAAYIGgADQAgXdE2GqDnEkKFitjHDJsMj5DYjqM/BzvAxogMAG9ADmVAcgH
 sjmHJOjOIx1wT0thBYrGhcseVJ5gbBWZfbtmepQDd656Mjc42m2Dsw/iFJ4hWBzZrBbYAPT2vV1
 1vfWodW6oUqpaqWvuDP5zIpL365bagDGcBvvXF4Wp/RwkqcmqSiGFdFxDqF6ziBs0TOtQEgMRGa
 N34ijTyErSef8zPLMrAVeQpIVhCNrhFjjcmvckG3J6KRCSC9Phhm7OTJevArX564mZPXw4euRAq
 KcJePG7QZ9IBJGH8c3UCJ7patVmBpdKrxlRZA0RlGLZpOFgwQp03w/nyLhfg9mrUtS2j271zY4D
 USVRbhRgBpqhdwyBZWTH7OH1KwQBOyamkbjsZ5jo5+1Tdwo1ogUIMCZoXTtO52AiLlezr07sA6d
 QuivemdsMEvi/4u5IpwoSDoEmPU
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

To make things as organized as possible, start from the Libux board dtbs
and apply all properties needed for U-Boot in our *-u-boot.dtsi file for
the MAIN SPL and U-Boot builds.

We can then include these files for the WKUP SPL build making further
edits to the needed properties and nodes for the WKUP SPL bootloader's
view of the am65x.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 2 +-
 arch/arm/dts/k3-am654-r5-base-board.dts      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index 0ecd7a56ebdbb..7ec65f8fa98aa 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -97,7 +97,7 @@
 	bootph-pre-ram;
 };
 
-&wkup_i2c_pins_default {
+&wkup_i2c0_pins_default {
 	bootph-pre-ram;
 };
 
diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 821c7dcb5e936..bc7291a1adb60 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -5,7 +5,8 @@
 
 /dts-v1/;
 
-#include "k3-am654.dtsi"
+#include "k3-am654-base-board.dts"
+#include "k3-am654-base-board-u-boot.dtsi"
 #include "k3-am654-base-board-ddr4-1600MTs.dtsi"
 #include "k3-am654-ddr.dtsi"
 
-- 
2.43.0

