Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4352C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 23:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0710F80BB0;
	Thu, 30 Jan 2025 00:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y2WPxtFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A43CD80C85; Thu, 30 Jan 2025 00:44:07 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 690AD80B9B
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 00:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50TNi3L11397827
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 17:44:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738194243;
 bh=83Ob7lqdBkuCL1hyEx6tIMylKlZ4Q6QkDch71mdvUS4=;
 h=From:To:CC:Subject:Date;
 b=y2WPxtFI8xpPwSV/K4gV8544vd28Kl1HBy0mVBMJjoyXSjQV2YPMT70uW+FlohGHW
 8aGpNrZiv/9gfpykM0GLUdWuiKon3ErbUmt4hMa/vFl0bs4S1Omxu/C4xHsEomIGSv
 E2n6tJ8mYgqjd33fyeh60pkiWt/zPWmTu4si7cfY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50TNi3s6018736
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 Jan 2025 17:44:03 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 Jan 2025 17:44:03 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 Jan 2025 17:44:03 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50TNi3fc023664;
 Wed, 29 Jan 2025 17:44:03 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Santhosh Kumar K <s-k6@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Judith Mendez <jm@ti.com>
Subject: [PATCH 0/2] Enable MCU ESM reset
Date: Wed, 29 Jan 2025 17:44:01 -0600
Message-ID: <20250129234403.574766-1-jm@ti.com>
X-Mailer: git-send-email 2.48.0
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

This patch series enables ESM reset configuration in board_init_f
for am62x and am62px devices.

This is necessary in order for error events to reset the system.

This patches are tested using watchdog to reset the system via ESM.

Santhosh Kumar K (2):
  arm: mach-k3: am62*_init: Probe ESM nodes
  configs: am62*_evm_r5: Enable ESM and MISC configs

 arch/arm/mach-k3/am62ax/am62a7_init.c | 26 ++++++++++++++++++++++++++
 arch/arm/mach-k3/am62px/am62p5_init.c | 26 ++++++++++++++++++++++++++
 configs/am62ax_evm_r5_defconfig       |  3 +++
 configs/am62px_evm_r5_defconfig       |  3 +++
 4 files changed, 58 insertions(+)


base-commit: d6da3dbaef57fc1d319b6b552efa009e2489d7d9
-- 
2.48.0

