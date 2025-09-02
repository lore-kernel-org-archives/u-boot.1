Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8377BCA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 06:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 961178319C;
	Tue,  2 Sep 2025 08:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MNoMt8Im";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0598E83281; Tue,  2 Sep 2025 08:48:48 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916028317B
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 08:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5826mhZ82467694;
 Tue, 2 Sep 2025 01:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756795723;
 bh=0rvMX4emrgHbdXvKjg9JS+GVMKaG6GxElCwVicDlal0=;
 h=From:To:CC:Subject:Date;
 b=MNoMt8Imv9+DOiPzWeNuJDqI1l3DcZ0I7xETWLCWUcxmIAaOkkHdMwbYFvo2Lrp6t
 v/zLbgjIPxih2trnMZB3TNpz1yP3F6WaV9x33i6tFeEm5h/KCw6InMMETEbFEOTTMx
 tS5MgxcT6va8Cv/BK/P2NXVk+m8qO0d1ABgGjq7g=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5826mhdM2542235
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 2 Sep 2025 01:48:43 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 01:48:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 01:48:42 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5826meRN3366774;
 Tue, 2 Sep 2025 01:48:41 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <n-francis@ti.com>, <u-kumar1@ti.com>
CC: <a-dutta@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v2 0/3] Hyperflash boot fixes for j721e
Date: Tue, 2 Sep 2025 12:18:36 +0530
Message-ID: <20250902064839.1296877-1-a-dutta@ti.com>
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

This series introdues a couple of small fixes that involves
enabling hyperflash at R5 SPL stage and Kconfig changes that are
required for HBMC boot on j721e

Test logs:
j721e : https://gist.github.com/anuragdutta731/f228b509e69a324f08c250e0d84a97ab
j7200 : https://gist.github.com/anuragdutta731/adf340a5a3ba727baae930fcec382524

Changelog : v2 :
1. Modified commit messages according to review comments
2. Added configs for r5 spl for j721e for hbmc boot

Link to v1 : https://lore.kernel.org/all/20250416061652.2394419-1-a-dutta@ti.com/

Anurag Dutta (3):
  mtd: Kconfig: Add SPL_MUX_MMIO dependency to HBMC driver
  configs: j721e_evm_r5: Enable HBMC and MUX_MMIO at SPL
  arm: dts: k3-j721e-r5-common-proc-board: Enable HBMC in R5 SPL stage

 arch/arm/dts/k3-j721e-r5-common-proc-board.dts | 1 +
 configs/j721e_evm_r5_defconfig                 | 2 ++
 drivers/mtd/Kconfig                            | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1

