Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA977C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A58BB87931;
	Thu, 21 Dec 2023 18:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C5vO7bQ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5825C8785E; Thu, 21 Dec 2023 18:44:33 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF762878E9
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiE8S027117;
 Thu, 21 Dec 2023 11:44:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180654;
 bh=xMO3wSTb6JGlt3WZnkRnhW3gY+ko0XrdpTMFdE62670=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=C5vO7bQ8g5DTsJcXwN2PlpCIL6N0Kec7uR/8g7ybvV2agxkLghADBfxrSrJJ/5ZDS
 Gk1eV758v1wA1KtP8wm5M+s8c18dtvxsbYtEwx3X8AQVr6O4Xzl3xvBFOzYP47Gp9A
 eKH6R40bA8p68zXMuqFVSI0Y6Hgu1JNfJY4A/uK0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiEV0025783
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:14 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiDp5080209;
 Thu, 21 Dec 2023 11:44:13 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 02/26] configs: am65x_evm_a53: disable CONSOLE_MUX
Date: Thu, 21 Dec 2023 11:43:48 -0600
Message-ID: <20231221174412.210807-3-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=bb@ti.com;
 h=from:subject; bh=KWMAxy/dMQ8jSkTT16EeAW0ytnOUgZo6m+APfNN09Aw=;
 b=owNCWmg5MUFZJlNZRQ5dqQAAbf///7fdSv9+j13ia3G7cs//33a7645nPEK3/N/8v9/f4u+wA
 RswHagAAGRoBoMjQGgNDQAAAaANBoG1DQyGjIyGTJpoNGQNqNGg0ep6TaNTzVDk9Q0BkADTJoDJ
 oDQDIyYmIZDIyMjQyGgAM1BgjExMTTQNMmmjTTRpoyGQ0IaHpANAyAaGT1DJkDRiZDQaZGmQxAa
 GQ0aAGIMBGCaNMhpk0aA0NGjJowQAA95gwF2zWjClJ1xNz+EGsBYMsYqweU90ATlnSUMhtdgTck
 rsLF8QV/oEqbJjfEEe4CxnkxdLguALUlDhSNpoXqm3eOzbtHP8IfvIP1TPfvK4FoA26G6GAw0gw
 8ewlX4xnWNPXW6oMnUwVr4sJBNieachQ2L2Kc+TgD5T4U+Wu2slNgXXS15d3zgSkghp1S0GQOeH
 ar+wbceCvWHPSp9t1N69oWSJ/HP+dpsjhETP0UsnHGIW63Dx0oZ5wuSdHclLvIvj/WB6ohUMSrm
 DLdAcsiK+ztVohLrvINFxAw5eWttJryXzdkSEdPySbpDdmkf4spP3gkfdcY36t77MQFQZtJxKiV
 HMSOZhYupyjzzRdlN19DYBIGgwWmbSxrF6SrfiHxyYCVJfj+rVjDW6mgJMspTR4xwHmAgDZoESC
 VKwQPox9F/i7kinChIIocu1IA==
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

We do not have a need to share a single console with the evaluation
board and disabling this option reduces the complexity of configuring
the consoles. Disable CONSOLE_MUX

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 configs/am65x_evm_a53_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index f4369865bf665..4d95e3bd29630 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -36,7 +36,6 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd; run init_${boot}; run boot_rprocs; if test ${boot_fit} -eq 1; then run get_fit_${boot}; run get_overlaystring; run run_fit; else; run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}; run run_kern; fi;"
 CONFIG_LOGLEVEL=7
-CONFIG_CONSOLE_MUX=y
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80a00000
-- 
2.43.0

