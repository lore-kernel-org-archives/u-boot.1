Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DFCC0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 16:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C8F6812BB;
	Mon, 27 Jan 2025 17:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fmW5yKCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D195C81292; Mon, 27 Jan 2025 17:25:19 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2307812C8
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 17:25:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50RGPEe71820470
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 10:25:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737995114;
 bh=2Okgj87j0RC6E8shnY3OLSrIYEgLDpU/Aqr1+OzvZyo=;
 h=From:To:CC:Subject:Date;
 b=fmW5yKCwXkMM3SM/oSyVIxJiM2RytNhaP6iKK+ucywissOCuX+d41u2dbvbLqlDkd
 bwHRlWUpICDYaGr5tlovQyTWR6ZCk0QM0U9+DbG6jyukCuTQdQ8uBpM83VGAcbvMK8
 WEsnF0fjkoAIsbDPfJ/I8xoypYzQMUuYASjuhgQY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50RGPDgL010763
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Jan 2025 10:25:13 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 10:25:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 10:25:13 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.104])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50RGPA3m086944; 
 Mon, 27 Jan 2025 10:25:10 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <a-limaye@ti.com>, <n-francis@ti.com>,
 <a-dutta@ti.com>, <vaishnav@ti.com>, <p-mantena@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] configs: j7200_evm_a72_defconfig: Re-enable CONFIG_MUX_MMIO
Date: Mon, 27 Jan 2025 21:53:33 +0530
Message-ID: <20250127162509.965644-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
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

Commit under Fixes which claimed to enable configs for Hyperflash, changed
"CONFIG_MUX_MMIO=y" to "CONFIG_SPL_MUX_MMIO=y" in j7200_evm_a72_defconfig.
As a result, PCIe functionality in U-Boot prior was broken, since the PCIe
driver depends on the SERDES Lane Muxing to be setup for PCIe, which is
done by the drivers/mux/mmio.c driver.

Fix this by re-enabling CONFIG_MUX_MMIO.

Fixes: 038f6faea9f0 ("configs: j7200_evm_*_defconfig: Add configs for Hyperflash boot")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
d8a7100d658 Subtree merge tag 'v6.13-dts' of dts repo [1] into dts/upstream
of the Master branch of U-Boot.

Logs verifying PCIe functionality by enumerating an NVMe SSD at U-Boot with
this patch applied:
https://gist.github.com/Siddharth-Vadapalli-at-TI/12c245ad0b5db83c6dacf56a329f5009

Regards,
Siddharth.

 configs/j7200_evm_a72_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index e1ef6e86d49..ac5b10ba149 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -144,6 +144,7 @@ CONFIG_SPI_FLASH_S28HX_T=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_MULTIPLEXER=y
+CONFIG_MUX_MMIO=y
 CONFIG_PHY_TI_DP83869=y
 CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
-- 
2.43.0

