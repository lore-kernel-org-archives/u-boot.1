Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC50C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 22:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B31F88826;
	Sat,  1 Jun 2024 00:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K0eRg+C3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 893978882E; Sat,  1 Jun 2024 00:32:50 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AF4C8872E
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 00:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VMWiS3117578;
 Fri, 31 May 2024 17:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717194764;
 bh=jiBMbMUdaemh/kavh1nf/XFdk8MkHPS4yP3nk8L1Ik4=;
 h=From:To:CC:Subject:Date;
 b=K0eRg+C3t08BrC3VK9NnauEIhwKVrbOzMWyupxgezHFX4vnQ4TO3t5mJXdzxr9tBC
 zYn3hKvV2jOgU3bpjtwp5/y7p/aK9Yc4CPuvzjKdUA9ZC1EQe+4gnSAdwkI7uJIn3g
 W4+BnL3/qrzOlnYfmwGVYIEQiM4FHBmuydfDN3jk=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VMWihj053569
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 17:32:44 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 17:32:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 17:32:44 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VMWhNC042364;
 Fri, 31 May 2024 17:32:43 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Hari Nagalla <hnagalla@ti.com>, Nishanth Menon <nm@ti.com>, Andrew Davis
 <afd@ti.com>, Roger Quadros <rogerq@kernel.org>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH] configs: j784s4: Enable OSPI NOR boot
Date: Fri, 31 May 2024 17:32:41 -0500
Message-ID: <20240531223241.2619357-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
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

Set necessary configs to enable the j784s4 device to boot from OSPI NOR
flash.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 configs/j784s4_evm_a72_defconfig | 2 ++
 configs/j784s4_evm_r5_defconfig  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index 8ef50f690fb..e999a25319d 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -49,6 +49,8 @@ CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_SUPPORT=y
 CONFIG_SPL_RAM_DEVICE=y
+# CONFIG_SPL_SPI_FLASH_TINY is not set
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_THERMAL=y
diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index f5fe7432206..71b39b876e9 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -56,6 +56,8 @@ CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_SUPPORT=y
 CONFIG_SPL_RAM_DEVICE=y
 CONFIG_SPL_REMOTEPROC=y
+# CONFIG_SPL_SPI_FLASH_TINY is not set
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
 CONFIG_SPL_THERMAL=y
-- 
2.34.1

