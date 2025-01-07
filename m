Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C250CE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 22:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3233805E2;
	Tue,  7 Jan 2025 23:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aaYpCye2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8F5F805E2; Tue,  7 Jan 2025 23:51:02 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14568801FD
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 23:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 507Mot512635869
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 7 Jan 2025 16:50:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736290255;
 bh=lcVKBPk0xfzxmP9ios5B6beAp9s2d90bj4L328J1hbc=;
 h=From:To:CC:Subject:Date;
 b=aaYpCye2ynieHxUXoPtWMRphtUZ6GYuTWsIyL9HrPiqRxauibNpxAJTl3qgFA3aG3
 UCxC02ebOxIaCf7LleXr/54iDlzQkcq03p1ftaY7CJrcN+eUzkTuter2WpD984klyk
 0Dq04wIABCtW4ZBv6Mrdm+TDffLJH1INFPW6GsRc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 507Motqq004514;
 Tue, 7 Jan 2025 16:50:55 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Jan 2025 16:50:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Jan 2025 16:50:55 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 507Mot2e006730;
 Tue, 7 Jan 2025 16:50:55 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: "Andrew F . Davis" <afd@ti.com>, Hong Guan <hguan@ti.com>, Paul
 Kocialkowski <contact@paulk.fr>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: [RFC PATCH] am335x* defconfig: Increase u-boot partition in mtdparts
Date: Tue, 7 Jan 2025 16:50:55 -0600
Message-ID: <20250107225055.592941-1-jm@ti.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

From: Hong Guan <hguan@ti.com>

Fix u-boot NAND partition in MTDPARTS_DEFAULT since the size
of u-boot image has grown beyond 1MB and no longer fits in 1MB
NAND partition, thus we are failing to flash and boot via GPMC
NAND.

Increase the size of NAND.u-boot to 2MB since the size of
u-boot.img is currently 1.4M.

Signed-off-by: Hong Guan <hguan@ti.com>
[Judith: extend fix to HS defconfigs and add commit msg]
Signed-off-by: Judith Mendez <jm@ti.com>
---
This patch is marked RFC to understand if solution is acceptable
since changing partition sizes will not be backwards compatible
solution.

One other solution was too try to reduce the size of u-boot proper,
but removing features (boot modes.. etc) did not seem to get the
size of u-boot proper to 1MB with a usable u-boot proper.
---
 configs/am335x_evm_defconfig         | 2 +-
 configs/am335x_hs_evm_defconfig      | 2 +-
 configs/am335x_hs_evm_uart_defconfig | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 6d1da0cfc7c..787a919855e 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_NAND=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),2m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIST="am335x-evm am335x-bone am335x-sancloud-bbe am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle"
diff --git a/configs/am335x_hs_evm_defconfig b/configs/am335x_hs_evm_defconfig
index 396e7432c40..ea2e12f737f 100644
--- a/configs/am335x_hs_evm_defconfig
+++ b/configs/am335x_hs_evm_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_NAND=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),2m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle"
diff --git a/configs/am335x_hs_evm_uart_defconfig b/configs/am335x_hs_evm_uart_defconfig
index 4be0b2f3933..58e12ca4bd8 100644
--- a/configs/am335x_hs_evm_uart_defconfig
+++ b/configs/am335x_hs_evm_uart_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_NAND=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),2m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle"
-- 
2.47.1

