Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDD2CD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 22:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A28881B9;
	Tue,  9 Apr 2024 00:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j3JPiMs4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3E6588180; Mon,  8 Apr 2024 23:12:23 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CBA58817C
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 23:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 438LCD70097972;
 Mon, 8 Apr 2024 16:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712610733;
 bh=QuN4Ac2W7J72yxGLZi8mTU9OJbKwJ3UswXp1j6bjrmw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=j3JPiMs49Kdh0a1BA8Z/mPXOL3aqYpyRTO+DEaSP3T7Jv99k4GoroXoCKS1N78+GY
 8UvoQrRvClHPtBSUcpnmyXNGzEsPXJos1ChKlJFdujHiCKTg/eDTwdP5QLBpk3PELg
 qDIo2h+fqLK0KOaH74tYQRwtgXJVP/9yFLVdwwNY=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 438LCDmj052314
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Apr 2024 16:12:13 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 16:12:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 16:12:12 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 438LCDvL014553;
 Mon, 8 Apr 2024 16:12:13 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Simon Glass <sjg@chromium.org>, Neha Malcom Francis <n-francis@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Andrew Davis <afd@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH 11/15] configs: am62x: cosmetic config cleanup
Date: Mon, 8 Apr 2024 16:10:56 -0500
Message-ID: <20240408211100.93936-12-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408211100.93936-1-j-humphreys@ti.com>
References: <20240408211100.93936-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 09 Apr 2024 00:46:15 +0200
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

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 configs/am62x_evm_a53_defconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 4c1e4d7cc42..3e174ec37aa 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -17,6 +17,10 @@ CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x80c80000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
 CONFIG_SPL_FS_FAT=y
@@ -32,12 +36,8 @@ CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x80c80000
-CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SPL_STACK_R=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
-- 
2.34.1

