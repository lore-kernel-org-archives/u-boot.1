Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5B0CCD1A5
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 08:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 586E9835FE;
	Fri, 24 Oct 2025 10:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Bpm6z0rW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C76168362A; Fri, 24 Oct 2025 10:14:15 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C9668331F
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59O8EB9D1864664;
 Fri, 24 Oct 2025 03:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761293651;
 bh=vAwsr/bPnkJmfGo6D8as7/WVdsW0/C0zz594LKox7Gk=;
 h=From:To:CC:Subject:Date;
 b=Bpm6z0rWK0ii8ayziP7RwWXDD+UbpSBWJ8gwzLAS+xcFREh8658O2M5Yg1WCmRe9W
 USuN9rjAgzXUdDk9bWT/PVgRxl+iTdIGk0xboXkSpDiUnVZY8jwYqAFIZxjQMWs659
 GX/6dAJ3GB4+0ZxDWBweHxYArvL3YgHaIKY+o/8Y=
Received: from DLEE203.ent.ti.com (dlee203.ent.ti.com [157.170.170.78])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59O8EBqe3323606
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 24 Oct 2025 03:14:11 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 03:14:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Oct 2025 03:14:11 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59O8EAUa041613;
 Fri, 24 Oct 2025 03:14:10 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v3 0/4] Allow falcon boot from A-core SPL on K3 devices
Date: Fri, 24 Oct 2025 13:44:03 +0530
Message-ID: <20251024081408.1610102-1-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
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

With the addition of secure falcon mode since commit 7674ac9c820f ("Merge patch
series "Add support for secure falcon mode: disable args file""), this series now
adds support for the same to TI's K3 devices and documents the feature taking
AM62x EVM as an example.

With secure falcon mode from A-Core SPL, the boot flow changes as follows:

Existing:
  R5 SPL -> TFA -> OP-TEE -> A-Core SPL -> *U-Boot* -> Linux Kernel

Modified:
  R5 SPL -> TFA -> OP-TEE -> A-Core SPL -> Linux Kernel

Depends on:
  [PATCH v8 0/2] Remove usage of CMD_BOOTx from SPL code
  https://lore.kernel.org/u-boot/20251024-fix_cmd_bootx-v8-0-230f70c5e5f8@ti.com/

Regards,
Anshul
---
Changes in v3:
- Remove the [5/5] patch but instead depend on the above CMD_BOOTx series
- Guard definition of spl_start_uboot with (ARM64 && SPL_OS_BOOT_SECURE) instead
- Link to v2: https://lore.kernel.org/u-boot/20251015104702.3726411-1-anshuld@ti.com/

Changes in v2:
- Use CMD_SPL instead of CMD_CACHE in commit message of [2/5]
- Use #ifdef instead of CONFIG_IS_ENABLED(OS_BOOT)
- Link to v1: https://lore.kernel.org/u-boot/20251010131829.3737258-1-anshuld@ti.com/
---

Anshul Dalal (4):
  spl: Kconfig: allow falcon mode for TI secure devices
  board: ti: common: Kconfig: add CMD_SPL
  arm: mach-k3: enable support for falcon mode
  doc: develop: add docs for secure falcon mode

 arch/arm/mach-k3/common.c |   8 ++
 board/ti/common/Kconfig   |   1 +
 common/spl/Kconfig        |   2 +-
 doc/develop/falcon.rst    | 252 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 262 insertions(+), 1 deletion(-)

-- 
2.51.0

