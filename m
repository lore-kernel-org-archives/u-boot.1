Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B02CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 10:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E67BA83A6A;
	Tue,  2 Sep 2025 12:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QKd+rZb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DC6B83A9F; Tue,  2 Sep 2025 12:20:08 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B98E832AD
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 12:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 582AK41q2963170;
 Tue, 2 Sep 2025 05:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756808404;
 bh=7oBW5JLV8UjQ09DM13/I9q89Ru0Fh51fK18XRfsIEpI=;
 h=From:To:CC:Subject:Date;
 b=QKd+rZb28yrAHP29b7FboILZBtbHD+g0FJnVl7f39FpTSdeXYr4oKx4WWqeG42CX7
 boi5Xb5vtIU3EDGXegejs+CaltFriZlUcVZfZGYn9E0RHwlABrWH/6cIMgv1pjhhTG
 ohuVNe/1a+9Rsdzhpt1SA/QKRGlcYGy+5tNh8Xzs=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 582AK38W2207337
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 2 Sep 2025 05:20:03 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 05:20:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 05:20:03 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 582AK1D93915378;
 Tue, 2 Sep 2025 05:20:01 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <n-francis@ti.com>, <u-kumar1@ti.com>
CC: <a-dutta@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 0/3] Hyperflash boot fixes for j721e
Date: Tue, 2 Sep 2025 15:49:57 +0530
Message-ID: <20250902102000.1388848-1-a-dutta@ti.com>
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
enabling hyperflash at R5 SPL stage and Kconfig changes that are
required for HBMC boot on j721e

Test logs:
j721e : https://gist.github.com/anuragdutta731/f228b509e69a324f08c250e0d84a97ab
j7200 : https://gist.github.com/anuragdutta731/adf340a5a3ba727baae930fcec382524

Changelog : v3 :
1. Modified commit messages and added correct fixes tag

Link to v2:
https://lore.kernel.org/all/20250902064839.1296877-1-a-dutta@ti.com/

Changelog : v2 :
1. Modified commit messages according to review comments
2. Added configs for r5 spl for j721e for hbmc boot

Link to v1 :
https://lore.kernel.org/all/20250416061652.2394419-1-a-dutta@ti.com/

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

