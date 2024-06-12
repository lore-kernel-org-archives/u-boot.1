Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C90CC27C77
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 11:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00225887D5;
	Wed, 12 Jun 2024 13:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lYmoLL/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58EF5883D3; Wed, 12 Jun 2024 13:08:02 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 347DB884A7
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CB7tAF024387;
 Wed, 12 Jun 2024 06:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718190475;
 bh=xD1oF2TeFUaLdJx5ZDG8obIdg03gz1TJARR3oHOZ8WE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lYmoLL/vDRXxu6A1BaAY5rvdokGmSdO9zIXO9EMgANa1kgmTud1M5iYOukW5SKdkk
 Pix+lJ6s0K9j9/fetDmW6FRZquIcCZGUTvqTZR+bCjf0l5VjCF2GaiClUlDsfcArsD
 XqfZj6QMcMiAEmAPQA+FkSUtxqWHcdq4oopzpmW8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CB7tKD014770
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Jun 2024 06:07:55 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 06:07:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 06:07:55 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CB7tm6099602;
 Wed, 12 Jun 2024 06:07:55 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 45CB7sfW031839;
 Wed, 12 Jun 2024 06:07:55 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Judith Mendez <jm@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Simon Glass <sjg@chromium.org>,
 Roger Quadros <rogerq@kernel.org>, Andrew Davis <afd@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Nishanth Menon <nm@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
Subject: [PATCH v2 1/2] configs: am64x_evm_a53: Enable ICSSG Driver
Date: Wed, 12 Jun 2024 16:37:48 +0530
Message-ID: <20240612110749.1699824-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612110749.1699824-1-danishanwar@ti.com>
References: <20240612110749.1699824-1-danishanwar@ti.com>
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

Enable ICSSG driver, DP83869 phy driver, REMOTEPROC and PRU_REMOTEPROC
in am64x_evm_a53_defconfig. All these configs are needed for ICSSG
driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 configs/am64x_evm_a53_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index e000549d6d..6063286798 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -126,8 +126,10 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_MULTIPLEXER=y
 CONFIG_MUX_MMIO=y
 CONFIG_PHY_TI_DP83867=y
+CONFIG_PHY_TI_DP83869=y
 CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_TI_ICSSG_PRUETH=y
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_PHY_CADENCE_TORRENT=y
@@ -143,6 +145,8 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_TPS65219=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_REMOTEPROC_TI_PRU=y
+CONFIG_CMD_REMOTEPROC=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
@@ -150,6 +154,7 @@ CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SOC_DEVICE_TI_K3=y
 CONFIG_SOC_TI=y
+CONFIG_TI_PRUSS=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_CADENCE_QSPI=y
-- 
2.34.1

