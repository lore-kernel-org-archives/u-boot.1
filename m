Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5039BC4707B
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 19:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFADB87AB5;
	Tue,  9 Jan 2024 20:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TN7DTAd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC78087A99; Tue,  9 Jan 2024 20:18:07 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5664C879E4
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 20:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409JHvrs008524;
 Tue, 9 Jan 2024 13:17:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704827877;
 bh=E45dut37uH6/micncE8cTcIjwsMITKVVmtoYmzfC5Xs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=TN7DTAd7yeKpGSxvjBn0tHiHZm56uBA2cC4aMBfrPxvNdoeuW/MWg3MqtbP54B7up
 jPRXu1lYCVakxzo3xB5D6jc766zEftragoFa/j+v1T3UpubsZKDvW0Pr1S6cNCZ0Ui
 a3N5IVhxTQX1NZz3Hsyr4qmvPaLw8h2OewrRmmEk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409JHv1r029076
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 13:17:57 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 13:17:57 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 13:17:56 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409JHuGP075216;
 Tue, 9 Jan 2024 13:17:56 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 03/10] board: ti: am62x: Set fdtfile from C code instead of
 findfdt script
Date: Tue, 9 Jan 2024 13:14:58 -0600
Message-ID: <20240109191506.3820908-4-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109191506.3820908-1-nm@ti.com>
References: <20240109191506.3820908-1-nm@ti.com>
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

Stop using the findfdt script and switch to setting the fdtfile from
C code.

While at this, replace findfdt in environment with a warning as it is
no longer needed

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes from V1: None.
I have retained the central call ti_set_fdt_env() to retain the
population of fdtfile name using the CONFIG fall back logic and the
population of (now deprecated) legacy variables for downstream script
users.

V1: https://lore.kernel.org/r/20240108173301.2692332-4-nm@ti.com
 board/ti/am62x/am62x.env        | 1 -
 board/ti/am62x/evm.c            | 8 ++++++++
 configs/am62x_evm_a53_defconfig | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
index e53a55c38fbb..9cb186c2a03c 100644
--- a/board/ti/am62x/am62x.env
+++ b/board/ti/am62x/am62x.env
@@ -1,5 +1,4 @@
 #include <env/ti/ti_common.env>
-#include <env/ti/default_findfdt.env>
 #include <env/ti/mmc.env>
 
 name_kern=Image
diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index ad939088402e..b76ef1b94a61 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -54,6 +54,14 @@ int dram_init(void)
 	return fdtdec_setup_mem_size_base();
 }
 
+#ifdef CONFIG_BOARD_LATE_INIT
+int board_late_init(void)
+{
+	ti_set_fdt_env(NULL, NULL);
+	return 0;
+}
+#endif
+
 int dram_init_banksize(void)
 {
 	return fdtdec_setup_memory_banksize();
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index aa96c1b3125c..3cf3b93a93fc 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -32,6 +32,7 @@ CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80c80000
-- 
2.43.0

