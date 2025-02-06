Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA8FC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 01:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F0F38082A;
	Thu,  6 Feb 2025 02:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FNfI6XB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E7CA8033D; Thu,  6 Feb 2025 02:54:19 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 707B5807D9
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 02:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5161s7ik3535336
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Feb 2025 19:54:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738806847;
 bh=TBxv9eCu8y86CcNBtuysIQuL4Gyv9dWhPKJkFppwVGQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FNfI6XB+YCgAz4M4tA4R5elwkHzBfCN5aYIY+NDv1pQ+XFI76zq7sP9es29NFi2Pm
 AfLhgheDXwoDK7HMPzRv7Tuc788KovMufzonrD65qxdT7EpHUBAbeYERZjYLtD2hc2
 fisLlGj9oklOkViPzFv6AWsRsXMXHDldL+LTlkFs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5161s7Zd010851
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Feb 2025 19:54:07 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Feb 2025 19:54:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Feb 2025 19:54:07 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5161s682036392;
 Wed, 5 Feb 2025 19:54:07 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Judith
 Mendez <jm@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v4 6/6] configs: am6*_evm_a53_defconfig: Enable remoteproc
 support
Date: Wed, 5 Feb 2025 19:54:06 -0600
Message-ID: <20250206015406.2702944-7-jm@ti.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250206015406.2702944-1-jm@ti.com>
References: <20250206015406.2702944-1-jm@ti.com>
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

From: Hari Nagalla <hnagalla@ti.com>

Enable configs needed to enable remoteproc drivers for AM62
and AM64 devices.

While we are here, cleanup some remoteproc configs, there
is no DSP subsystem for am62px device.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v3:
- Add remoteproc support configs for am62x
- Cleanup remoteproc configs for am62p and am64x.
---
 configs/am62px_evm_a53_defconfig | 1 -
 configs/am62x_evm_a53_defconfig  | 2 ++
 configs/am64x_evm_a53_defconfig  | 4 +++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
index 30b4a24ee9a..10e00519bc1 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -147,7 +147,6 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
-CONFIG_REMOTEPROC_TI_K3_DSP=y
 CONFIG_REMOTEPROC_TI_K3_R5F=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index c77e09db156..51b8c0ae3fb 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -56,6 +56,7 @@ CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_OF_CONTROL=y
@@ -121,6 +122,7 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_REMOTEPROC_TI_K3_M4F=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index a501f3f567e..5528f54549d 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -70,6 +70,7 @@ CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
@@ -149,8 +150,9 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_TPS65219=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_REMOTEPROC_TI_K3_M4F=y
+CONFIG_REMOTEPROC_TI_K3_R5F=y
 CONFIG_REMOTEPROC_TI_PRU=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
-- 
2.48.0

