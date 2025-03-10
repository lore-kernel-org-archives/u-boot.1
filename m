Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A44C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 12:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C75FD8141E;
	Mon, 10 Mar 2025 13:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZQrRGueC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5A9D81428; Mon, 10 Mar 2025 13:09:10 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A083A811DF
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 13:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52AC91TO473143
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 07:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741608541;
 bh=4l7dOwWLXdmu2mxGqWQf3EMT71wh/QfHsU2MSGngcIc=;
 h=From:To:CC:Subject:Date;
 b=ZQrRGueCjkSspEwvHG9IudMpluDRdT//ojm8yPwUygn5hkapFtyB/TUeAWOMCTJVS
 32HRJ65Ou/NP3xDYG2VLQyoiXh9r79T9K0YUK4m5nc1YtIG4B+kjcvP6/ki9tfxjjI
 Wpj+2T4IHc9zAarr6Q3RlPkaRApOFz88xdJNp/co=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52AC91Uu043383
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Mar 2025 07:09:01 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Mar 2025 07:09:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Mar 2025 07:09:00 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52AC8u9l046607;
 Mon, 10 Mar 2025 07:08:57 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <vigneshr@ti.com>, <trini@konsulko.com>, <j-humphreys@ti.com>, <jm@ti.com>,
 <n-francis@ti.com>, <seanga2@gmail.com>, <afd@ti.com>,
 <sjg@chromium.org>, <rogerq@kernel.org>, <danishanwar@ti.com>
CC: <h-salunke@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH] configs: am64x_evm_a53_defconfig: Enable support for UMS
Date: Mon, 10 Mar 2025 17:38:56 +0530
Message-ID: <20250310120856.603150-1-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
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

Enable support for USB mass storage class (UMS) via USB0 instance of
USB on AM64x SoC. UMS allows USB host to access U-Boot block device
and enable file transfer.

Example usage of UMS command :
	=> mmc list
	mmc@fa10000: 0 (eMMC)
	mmc@fa00000: 1
	=> ums 0 mmc 1
	UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x3b72400

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
This patch is based on following commit on master branch
0fd7ee0306a (origin/master, origin/HEAD) scripts/checkpatch.pl: Upgrade IS_ENABLED_CONFIG to error for U-Boot

configs/am64x_evm_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index a501f3f567e..19993e10601 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -71,6 +71,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_PMIC=y
-- 
2.34.1

