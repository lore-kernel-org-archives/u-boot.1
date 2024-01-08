Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2077FC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 17:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C758887B28;
	Mon,  8 Jan 2024 18:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zIeakZTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D422E87AC7; Mon,  8 Jan 2024 18:33:26 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 515FE87AE5
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 18:33:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 408HX99q100200;
 Mon, 8 Jan 2024 11:33:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704735189;
 bh=ofSUlSEG83EtnosmhexXeF8L30C7B2aaDOp83OJ0nN8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=zIeakZTmC0sAAYfSXHn3wrZYGsb/BYurGICEXB8ex0zRwQUG7A6xePzoSXQgdv094
 slGMZyEhoISDYRkbzteLQ2g3bqu69Ssxe+5T4e0HJltiWCoCLRM1LfiIhj8Ps1mFds
 xxQIBDifagQWUslzrtrLcjfkHFD8EVD9/Ol8gElU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 408HX9ps072369
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jan 2024 11:33:09 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 11:33:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 11:33:08 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 408HX8gi109335;
 Mon, 8 Jan 2024 11:33:08 -0600
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
Subject: [PATCH 09/10] board: beagle: beagleplay: Set fdtfile from C code
 instead of findfdt script
Date: Mon, 8 Jan 2024 11:33:00 -0600
Message-ID: <20240108173301.2692332-10-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108173301.2692332-1-nm@ti.com>
References: <20240108173301.2692332-1-nm@ti.com>
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

Stop using the findfdt script and switch to setting the fdtfile from C
code.

While at this, replace findfdt in environment with a warning as it is
no longer needed.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 board/beagle/beagleplay/beagleplay.c   | 14 ++++++++++++++
 board/beagle/beagleplay/beagleplay.env |  1 -
 configs/am62x_beagleplay_a53_defconfig |  3 ++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beagleplay/beagleplay.c
index 1c376dea372f..00ff86165790 100644
--- a/board/beagle/beagleplay/beagleplay.c
+++ b/board/beagle/beagleplay/beagleplay.c
@@ -27,3 +27,17 @@ int dram_init_banksize(void)
 {
 	return fdtdec_setup_memory_banksize();
 }
+
+#ifdef CONFIG_BOARD_LATE_INIT
+int board_late_init(void)
+{
+	char fdtfile[50];
+
+	snprintf(fdtfile, sizeof(fdtfile), "%s/%s.dtb",
+		 CONFIG_TI_EVM_FDT_FOLDER_PATH, CONFIG_DEFAULT_DEVICE_TREE);
+
+	env_set("fdtfile", fdtfile);
+
+	return 0;
+}
+#endif
diff --git a/board/beagle/beagleplay/beagleplay.env b/board/beagle/beagleplay/beagleplay.env
index 4f0a94a8113e..647b25d14c8e 100644
--- a/board/beagle/beagleplay/beagleplay.env
+++ b/board/beagle/beagleplay/beagleplay.env
@@ -1,5 +1,4 @@
 #include <env/ti/ti_common.env>
-#include <env/ti/default_findfdt.env>
 #include <env/ti/mmc.env>
 
 name_kern=Image
diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
index 0be20045a974..1f43891d10bb 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -33,7 +33,8 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
 CONFIG_AUTOBOOT_DELAY_STR="d"
 CONFIG_AUTOBOOT_STOP_STR=" "
-CONFIG_BOOTCOMMAND="run set_led_state_start_load;run findfdt; run envboot; bootflow scan -lb;run set_led_state_fail_load"
+CONFIG_BOOTCOMMAND="run set_led_state_start_load; run envboot; bootflow scan -lb;run set_led_state_fail_load"
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80c80000
-- 
2.43.0

