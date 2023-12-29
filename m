Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FE4C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE5487BF3;
	Fri, 29 Dec 2023 18:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b6BuI6Kr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FFA87B9D; Fri, 29 Dec 2023 18:47:16 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D15AE87BB5
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1dP088952;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=okYgoOJZNG99+0N2dHgYx4y/I8jw2Sf4ppBlZJ80+mE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=b6BuI6Kra8wSLGKVn7jk61JMrqAQcyPYuytAk/OjirOo1jDjDC2zdcYphCXy1d9PF
 hcOtqjr8J6syBT1bGNkXJZdQCCLoXShO4p8FGoht4ypHHHJQXCmuvihw+swa32PmX1
 9qz0l3PotPNNTVgOY6d1aWQqkVjIKd+GUXfWnetY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1KD025011
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:00 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl0En122675;
 Fri, 29 Dec 2023 11:47:00 -0600
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
Subject: [PATCH v2 06/26] arm: dts: k3-am654: include a53 board dtb for r5
 build
Date: Fri, 29 Dec 2023 11:47:03 -0600
Message-ID: <20231229174656.634065-34-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=bb@ti.com;
 h=from:subject; bh=WnVUafK3SWxNLgGdapHf8t7w7OX5fxDWq6DbvSrqnBw=;
 b=owNCWmg5MUFZJlNZFGcQ5gAAYn///v7dR/v0+t719/P/u8nf9OU++c3V/V//7149m17p0P2wA
 RsxoyIAAAAAAaB6gABkAekDQDQANAAAAaA00BppoNDTxTajR5NRmo9R6anqHINAaNA0PRBoAAPU
 wATRtIAAGTQxA0yGAQxNBkAaAABo0AAMTAQ7RPU9IDJoPSBoDQDTIAyGjIaAyAADEYQaaGjQAxM
 QANAZNBpoGgBkyemoCDvQEagCTgkYFISKhzSgZpyT+HwvH2qIBkhlKyQtwM7M6dYiU0cb3l1noB
 dLQe7ZbapHYAPNUD7GaF3bQXvd9RgTJjkOEgNS/A54Dr7BW/EW/6YnXp4GGQ32rHzCQKGC+uscX
 RekTG4FCZqxjC+u12GYde6e5aV2EI0gRMb71PhwNuI0ssDl7kyoZkUAHhxhltsAtFSjrUgq08PE
 he580hdk5BTS7ZQT70oVqkcgICXKnefkbFpKU6SPqx73ZLRCoUyynWVCMwT0TJBBlPl1T8pFjTA
 hx4tPN8ZBLdcjBGbwdAbtM2BFgmRLwGBpIpagUdt+kFcUleM5cxjUfy7laoji4Mi8wRmvPKoaQP
 eat2EfnC1eYAC2NTnFwDookmk73czRiln6gp2vFCvbxGVPhJRQG9wn1RCl3/CcH8CgOYpN3/F3J
 FOFCQFGcQ5g
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

To make things as organized as possible, start from the Linux board dtbs
and apply all properties needed for U-Boot in our *-u-boot.dtsi file for
the MAIN SPL and U-Boot builds.

We can then include these files for the WKUP SPL build making further
edits to the needed properties and nodes for the WKUP SPL bootloader's
view of the am65x.

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 8f55dab508ee6..79ca6387c22bb 100644
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

