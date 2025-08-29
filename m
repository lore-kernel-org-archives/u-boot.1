Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E669C8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 05:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97891834E5;
	Fri, 29 Aug 2025 07:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HTanSEQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF732834E1; Fri, 29 Aug 2025 07:35:00 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA0083443
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 07:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T5YuVC2143885;
 Fri, 29 Aug 2025 00:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756445696;
 bh=uTaGdFdufoXmvwQzkWCIJ9d3GTCJ8Zu9FezMuDz9biE=;
 h=From:To:CC:Subject:Date;
 b=HTanSEQ/mkNWMqDKj+HSZZjMBErKilB8GFaYmf6q6UJO8ySuOjL5ke8kbK65rb1Fs
 RIcd92mtM+q8dlZinKm+u4vqKluYLnHC7WJfGX7qDzbwPb1caqncjNpPAD3pzubnwu
 GixyhgiaELL9c3bNXeDUH/VTEfi+9iaE+9TKgzA0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T5YttK3782994
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 29 Aug 2025 00:34:56 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 00:34:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 00:34:55 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T5YqT31836809;
 Fri, 29 Aug 2025 00:34:52 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <hnagalla@ti.com>,
 <n-francis@ti.com>, <jm@ti.com>, <u-kumar1@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 0/4] Enable Early Boot of IPUs on TI AM57xx platforms
Date: Fri, 29 Aug 2025 11:04:47 +0530
Message-ID: <20250829053451.3615976-1-b-padhi@ti.com>
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

Early Boot of IPUs occur at SPL stage of bootloader and thus require
memory carveouts, page table carveouts, MMU configuration and timers to
be defined at {}-u-boot.dtsi. Include "dra7-ipu-common-early-boot.dtsi"
which defines above nodes in board level -uboot DTSIs.

Also add the necessary configs to enable remoteproc, fs_loader and reset
drivers at the SPL stage to load a firmware from boot media to cores.

Remove the ARCH_K3 dependency from REMOTEPROC_TI_IPU as IPU rprocs are
only present in TI OMAP SoCs.

Beleswar Padhi (4):
  Revert "remoteproc: Tighten some remoteproc driver dependencies"
  arm: dts: am57xx-idk-common-u-boot: Include IPU Early Boot changes
  configs: am57xx_evm_defconfig: Enable configs needed for Early Boot
  configs: am57xx_hs_evm_defconfig: Enable configs needed for Early Boot

 arch/arm/dts/am57xx-idk-common-u-boot.dtsi | 1 +
 configs/am57xx_evm_defconfig               | 7 +++++++
 configs/am57xx_hs_evm_defconfig            | 7 +++++++
 drivers/remoteproc/Kconfig                 | 1 -
 4 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.34.1

