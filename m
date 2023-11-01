Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2801C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 17:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7E2887D32;
	Wed,  1 Nov 2023 18:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PqQvFzoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F368F876D7; Wed,  1 Nov 2023 18:05:39 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E63287716
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 18:05:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A1H5Nwv047001;
 Wed, 1 Nov 2023 12:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698858323;
 bh=WdV7rHE7tzX1oFRHYow158EMtyifqTBh+3NUKj1cZDU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PqQvFzoqD6WWgxpbP3pkJvBAX5JoBqksK72gB+qY2z12SNsLB2LXRqIMjKEvy0L+t
 0SZkIV5CxE1dBYBsAGloOfBnJLNKN7BtsjMs1SHrSzjQoCMJ6B+mx9YaZQYk8M5GLk
 3VPNKoIfGI9hfl7a1ZJp8atzJQmD8HU8qiI/TUoM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A1H5Nrl069800
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 1 Nov 2023 12:05:23 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 Nov 2023 12:05:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 Nov 2023 12:05:23 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A1H5KBA014687;
 Wed, 1 Nov 2023 12:05:22 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/2] configs: Add am62x_beagleplay_* defconfigs
Date: Wed, 1 Nov 2023 12:05:19 -0500
Message-ID: <20231101170519.39627-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101170519.39627-1-afd@ti.com>
References: <20231101170519.39627-1-afd@ti.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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

