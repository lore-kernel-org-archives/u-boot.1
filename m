Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09B6CD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 22:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ECA8881E7;
	Tue,  9 Apr 2024 00:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="flKtvHF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3869687EB4; Mon,  8 Apr 2024 23:12:27 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51AB088166
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 23:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 438LCDrY050448;
 Mon, 8 Apr 2024 16:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712610733;
 bh=yVjqKNbTM9nsCshnMNxQx51+qel1cx1PSlGkfs9DLDk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=flKtvHF716OYBpoOEyh+QXiUFi6L27gFxqMfO21/quMpAyXbOGcGVBFh7MfEUNrle
 imJ5vUfTkMWr8ekuw5D3/ptieIhDg7pYMcZA9caWwPLDdKbiE117rLxhmF+GAEQ0NC
 FCso0yoVFoLznydbPLKBA3PKydkGg1dO3L0vwWbo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 438LCDHF097999
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Apr 2024 16:12:13 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 16:12:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 16:12:13 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 438LCD5J067510;
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
Subject: [PATCH 13/15] configs: am62x: Enable RTC emulation
Date: Mon, 8 Apr 2024 16:10:58 -0500
Message-ID: <20240408211100.93936-14-j-humphreys@ti.com>
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

This is required to pass SystemReadyIR tests.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 configs/am62x_evm_a53_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index ee585b3bc84..d650b8575b6 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -96,6 +96,8 @@ CONFIG_TI_SCI_POWER_DOMAIN=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SOC_DEVICE_TI_K3=y
@@ -107,3 +109,4 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_EFI_SET_TIME=y
-- 
2.34.1

