Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B339C71135
	for <u-boot@archiver.kernel.org>; Sat, 14 Jun 2025 09:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94078807B1;
	Sat, 14 Jun 2025 11:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MQv7vNKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CAB58129F; Sat, 14 Jun 2025 11:37:52 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C632780050
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 11:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55E9bTVa2176793;
 Sat, 14 Jun 2025 04:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749893849;
 bh=fu7/obz6WzSQ9MbUQ6h5bwOkzYqmX2DyLZXZYpcYzVs=;
 h=From:To:CC:Subject:Date;
 b=MQv7vNKTPegLDUp8puciXXc6sSIJHxxNSqhD+ukXnr0Cxgr1CBICvYEznNxOcvVOa
 eSVa3nWIEAs65vFeiJvsqeCrvchY0PNxIuKUTsyFY6A9Kj+n51r/97vmSMgXxfjeaL
 3cvUiqNECw4736VhOtUSOnB5pF4yXIws32gkv8rc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55E9bT1D4113377
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Sat, 14 Jun 2025 04:37:29 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 14
 Jun 2025 04:37:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 14 Jun 2025 04:37:29 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55E9bOPp840286;
 Sat, 14 Jun 2025 04:37:24 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <ggiordano@phytec.com>, <wegorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <jm@ti.com>, <n-francis@ti.com>,
 <bb@ti.com>, <vitor.soares@toradex.com>, <contact@paulk.fr>,
 <Oliver.Gaskell@analog.com>, <marex@denx.de>,
 <jerome.forissier@linaro.org>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 0/2] malloc size cleanup for K3 devices
Date: Sat, 14 Jun 2025 15:07:15 +0530
Message-ID: <20250614093717.2479920-1-u-kumar1@ti.com>
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

Many boards based upon K3 ARCH overrides default malloc size to 32MB,
as part of cleanup, add default size of 32MB for K3 ARCH.

Udit Kumar (2):
  Kconfig: Add default malloc size of K3 ARCH
  configs: j7*/*am62*: Remove malloc size overwrite at config level.

 Kconfig                                    | 2 +-
 configs/am62x_a53_usbdfu.config            | 1 -
 configs/am64x_evm_a53_defconfig            | 1 -
 configs/am64x_evm_r5_defconfig             | 1 -
 configs/am65x_evm_a53_defconfig            | 1 -
 configs/am65x_evm_r5_defconfig             | 1 -
 configs/am65x_evm_r5_usbdfu_defconfig      | 1 -
 configs/am65x_evm_r5_usbmsc_defconfig      | 1 -
 configs/j7200_evm_a72_defconfig            | 1 -
 configs/j7200_evm_r5_defconfig             | 1 -
 configs/j721e_beagleboneai64_a72_defconfig | 1 -
 configs/j721e_beagleboneai64_r5_defconfig  | 1 -
 configs/j721e_evm_a72_defconfig            | 1 -
 configs/j721e_evm_r5_defconfig             | 1 -
 configs/j721s2_evm_a72_defconfig           | 1 -
 configs/j721s2_evm_r5_defconfig            | 1 -
 configs/j784s4_evm_a72_defconfig           | 1 -
 configs/j784s4_evm_r5_defconfig            | 1 -
 configs/phycore_am62ax_a53_defconfig       | 1 -
 configs/phycore_am62x_a53_defconfig        | 1 -
 configs/phycore_am64x_a53_defconfig        | 1 -
 configs/phycore_am64x_r5_defconfig         | 1 -
 configs/verdin-am62_a53_defconfig          | 1 -
 23 files changed, 1 insertion(+), 23 deletions(-)

-- 
2.34.1

