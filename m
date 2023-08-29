Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA11DC71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 22:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D00278650A;
	Wed, 30 Aug 2023 00:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GaUO+p5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0FA486516; Wed, 30 Aug 2023 00:15:11 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31BEC864F5
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 00:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37TMF0hZ072849;
 Tue, 29 Aug 2023 17:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693347300;
 bh=a9Ag159GbZt95rFfXYoMbc0lN+ECdH3IfDu7IdfAIKM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=GaUO+p5fRRr25PmwomdL0Ekv6yQpML0nkp0RGidPNwuhxFtkXLjUNbdKW++WkOuh9
 uTDOtAbbDYrw53hE7R97deJQv6h0VHy7lquzXicgk/oNy4RlKhQOFwsV4YnwVLSQBT
 rkTt76Bz2DFf4MC7DzqOnB5wI6KUTwAgFNhssjaU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37TMF06B071811
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Aug 2023 17:15:00 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Aug 2023 17:15:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Aug 2023 17:15:00 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37TMEwMn028583;
 Tue, 29 Aug 2023 17:14:59 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [RFC PATCH 2/2] configs: Add am62x_beagleplay_* defconfigs
Date: Tue, 29 Aug 2023 17:14:57 -0500
Message-ID: <20230829221457.101469-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829221457.101469-1-afd@ti.com>
References: <20230829221457.101469-1-afd@ti.com>
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

Add am62x_beagleplay_r5_defconfig for R5 SPL and
am62x_beagleplay_a53_defconfig for A53 SPL and U-Boot support.

These defconfigs are composite defconfigs built from the config fragment
board/ti/am62x/beagleplay_*.config applied onto the base
am62x_evm_*_defconfig.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 configs/am62x_beagleplay_a53_defconfig | 3 +++
 configs/am62x_beagleplay_r5_defconfig  | 3 +++
 2 files changed, 6 insertions(+)
 create mode 100644 configs/am62x_beagleplay_a53_defconfig
 create mode 100644 configs/am62x_beagleplay_r5_defconfig

diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
new file mode 100644
index 00000000000..ad708e15397
--- /dev/null
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -0,0 +1,3 @@
+// The BeaglePlay defconfig for A53 core
+#include "configs/am62x_evm_a53_defconfig"
+#include "board/ti/am62x/beagleplay_a53.config"
diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
new file mode 100644
index 00000000000..276b1f81a3e
--- /dev/null
+++ b/configs/am62x_beagleplay_r5_defconfig
@@ -0,0 +1,3 @@
+// The BeaglePlay defconfig for R5 core
+#include "configs/am62x_evm_r5_defconfig"
+#include "board/ti/am62x/beagleplay_r5.config"
-- 
2.39.2

