Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83BDC25B79
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC6788361;
	Tue, 28 May 2024 10:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="djZe/J/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C300B88412; Tue, 28 May 2024 10:13:08 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A46087F8D
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S8D47G116154;
 Tue, 28 May 2024 03:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716883984;
 bh=bLFt5QI4+xx3Jr9dCSszSVYZa3vteb9+jqoR25b8ePQ=;
 h=From:Subject:Date:To:CC;
 b=djZe/J/1ke3Pa2ThdIAQINpDlW6pEYtvnXvQyugPsC27zGQIU3LtPlyDaCTL1P5Ut
 2MhJmfEWehYf/yTEN//gxd/N8v3IlMoGiXMmY0Tqe91Zku8MtNAk05tG4RveP6rs2d
 qzd8B2hSGUU+/HyId6MP3Fy6lOQPnQp3Oe8XZt7w=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S8D4xF119011
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 03:13:04 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 03:13:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 03:13:04 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S8Cxul066670;
 Tue, 28 May 2024 03:13:00 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v2 0/7] Add AVS support for J721S2
Date: Tue, 28 May 2024 13:42:59 +0530
Message-ID: <20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAuSVWYC/3WNyw6CMBBFf4XM2jHt8GblfxgWtRQZEx7pYKMh/
 LsV1y7PTe45G4jz7ASaZAPvAgvPUwQ6JWAHM90dchcZSFGmdKrwluFzkdU7M+KjJC2EJghWVld
 ll/aOCgPxvHjX8+sQX9vIA8s6+/fRCfq7/pSkin/KoDHmylxlqc3ruqgvK5/tPEK77/sHiOAXR
 7kAAAA=
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716883980; l=1607;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=N8Q/jncUjbRA5+qOFd5H/xdsH+dWx4ZZ5iVnHACGe3U=;
 b=aTdHso8CUDlKDw9h1O07N6yqRdQrlLJAHdS107T8jU5Yn+ynqfmtMm75ZRhOlHYSWwZguL+sE
 jNnhUDh55++C0FBmWZbetrn/etWOv4px7owdYyoGw8H4v14H968O50B
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

This series adds support for AVS on J721S2.

AVS Test for J721S2: https://gist.github.com/manorit2001/d7690ded6ef685aa8ffa5b16746cc529
Boot Test results: https://gist.github.com/manorit2001/6775d721b3df5a690497d94d012b93c4

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v2:
- Move AVS Initialization point to after do_dt_magic
  ( Otherwise AM68 unknowingly ends up probing AVS and fails )
- Rebase on top of OF_UPSTREAM Support
- Link to v1: https://lore.kernel.org/r/20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com

---
Manorit Chawdhry (7):
      power: pmic: tps65941: Add DM_PMIC dependency
      drivers: misc: k3_avs: Use soc_match_device instead of compatible.
      drivers: misc: k3_avs: Check return code while programming AVS
      drivers: misc: k3_avs: Add AVS Support for J721S2.
      arm: mach-k3: j721s2_init: Initialize AVS Class 0
      arm: dts: j721s2: Add VTM node in R5
      configs: j721s2_evm_r5_defconfig: Add AVS Configs

 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts |   9 +
 arch/arm/mach-k3/j721s2/j721s2_init.c           |  10 ++
 configs/am68_sk_r5_defconfig                    |   4 +
 configs/j721s2_evm_r5_defconfig                 |   6 +
 drivers/misc/k3_avs.c                           | 216 ++++++++++++++----------
 drivers/power/pmic/Kconfig                      |   1 +
 6 files changed, 159 insertions(+), 87 deletions(-)
---
base-commit: 377e91c162ab09ec20f96f966f380cb55c590edd
change-id: 20240130-b4-upstream-j721s2-avs-8c187d3fe26a

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

