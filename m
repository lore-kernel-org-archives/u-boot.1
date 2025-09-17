Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15282CA0EE8
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 09:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5465783542;
	Wed, 17 Sep 2025 11:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ve1E1Dn6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DCF783544; Wed, 17 Sep 2025 11:47:08 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE4E38004F
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 11:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58H9l3iP1483098;
 Wed, 17 Sep 2025 04:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758102423;
 bh=vrlsycDB1rWe5s0mXezd4WJSCzm5//YI5IWSFb8f/YU=;
 h=From:To:CC:Subject:Date;
 b=Ve1E1Dn6lhvar/A1SGlLecR43+4ZDqxR6op4bHTeNC1Bu1rK4QKH1tUjIN9nNXnXZ
 dGveO7iHhIw0o5Sa1EuEjWFjwDOf/ucwZNn6KAts9bwqRdhzWKTq051ecLgNvtr6Zy
 hDuMbLrPuV98R9v30vjHHmvFRaTZRaVU9zrd64mI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58H9l3HE670135
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 17 Sep 2025 04:47:03 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 04:47:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 04:47:02 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58H9l0Bu3103753;
 Wed, 17 Sep 2025 04:47:00 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>,
 <a-dutta@ti.com>
Subject: [PATCH v4 0/4] Hyperflash boot fixes for j721e/j7200
Date: Wed, 17 Sep 2025 15:16:55 +0530
Message-ID: <20250917094659.3922343-1-a-dutta@ti.com>
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

Hi all,
This series introdues a couple of small fixes that involves
enabling hyperflash at R5 SPL and u-boot proper stage and
Kconfig changes that are required for HBMC boot on j721e/j7200

Test logs:
https://gist.github.com/anuragdutta731/0f56e8d9bdf0cfe3d221c69d09a58704

Changelog: v4:
1. Removed fixes tag from commit message
2. Added configs for j7200 as well

Link to v3:
https://lore.kernel.org/all/20250902102000.1388848-1-a-dutta@ti.com/

Changelog : v3 :
1. Modified commit messages and added correct fixes tag

Link to v2:
https://lore.kernel.org/all/20250902064839.1296877-1-a-dutta@ti.com/

Changelog : v2 :
1. Modified commit messages according to review comments
2. Added configs for r5 spl for j721e for hbmc boot

Link to v1 :
https://lore.kernel.org/all/20250416061652.2394419-1-a-dutta@ti.com/

P.S.: We have cross-checked the generated .config file to verify whether
the configurations added in this series are actually reflected. And Yes,
they are. So, please include this series in the 2025.10 master.

Anurag Dutta (4):
  mtd: Kconfig: Add SPL_MUX_MMIO dependency to HBMC driver
  configs: j721e_evm_r5: Enable HBMC and MUX_MMIO at SPL
  configs: j7200_evm_*_defconfig: Enable HBMC and MUX_MMIO at SPL
  arm: dts: k3-j721e-r5-common-proc-board: Enable HBMC in R5 SPL stage

 arch/arm/dts/k3-j721e-r5-common-proc-board.dts | 1 +
 configs/j7200_evm_a72_defconfig                | 1 +
 configs/j7200_evm_r5_defconfig                 | 2 ++
 configs/j721e_evm_r5_defconfig                 | 2 ++
 drivers/mtd/Kconfig                            | 2 +-
 5 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.34.1

