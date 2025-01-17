Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F46C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E9048036F;
	Fri, 17 Jan 2025 15:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DC3XyEaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2E54806FB; Fri, 17 Jan 2025 07:14:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39C5C80312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 07:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737094450; x=1768630450;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jpGH2cW7IMzwKFihi1a9IyFdtrKTMk2IVMax+0U30Dw=;
 b=DC3XyEaR7L5/tgB2Yy9vIBQdPADMRz5kAW3ZPHDMzF8ctBDmGVvrhVh8
 cVlrQLBrOcaVMbyIUkvPSkFxROdaPE1PWu3FVp14bg2f7fkieNsv7nU9Y
 bPxaPmidHnnd/nMr/mOxbY6cP3ZM2PEyKooXVY5yY5zxDeRbMB8Fgkske
 EqfmrjtCkbIv4/raIheaFbE/Hh8wT0P3/mKix0wjtPeRjhpatB58eGisX
 qUEq1zV1o9JIPxj5sZgUAat0bTYt3nvCTNF1EB51guhx/34x2vgOURDZP
 MbqCBUpgmm50Ty6aSRDchq/WePM0tckatqtJFknRyY+jMxwUK3uBDgmjD Q==;
X-CSE-ConnectionGUID: m9m8q0pNT8yrw9p3n4sFVw==
X-CSE-MsgGUID: WbOytMp7Te25t3ixgRj48A==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48912155"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; d="scan'208";a="48912155"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 22:14:09 -0800
X-CSE-ConnectionGUID: C64V7vVdRLas3cDYOwGTBw==
X-CSE-MsgGUID: uZlhoYrCQs6UfKa14pqWTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; d="scan'208";a="136564633"
Received: from apgcp0d551112.png.altera.com ([10.244.77.50])
 by orviesa002.jf.intel.com with ESMTP; 16 Jan 2025 22:14:04 -0800
From: Boon Khai Ng <boon.khai.ng@intel.com>
To: Uboot Open List <u-boot@lists.denx.de>
Cc: Tien Fong Chee <tien.fong.chee@intel.com>,
 Kok Kiang Hea <kok.kiang.hea@intel.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [config 2 support v1 0/1] Add support for distinct mac-mode and phy
 mode.
Date: Fri, 17 Jan 2025 14:14:01 +0800
Message-Id: <20250117061402.31985-1-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Jan 2025 15:10:26 +0100
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

This patch adds support for configuring the ethernet MAC mode independently
from the PHY mode on our SoC FPGA board. Specifically, this is necessary
for a scenario where the ethernet controller MAC is connected to the
FPGA HVIO with a different GMII interface, and the FPGA output is routed
to the PHY using a RGMII interface.

To support this configuration, a mechanism is introduced to handle
separate MAC mode settings, ensuring that the MAC controller and PHY
can operate correctly with their respective interface modes.

If mac-mode is not defined, the MAC mode will default to the PHY mode,
ensuring compatibility and proper operation between the MAC and PHY.

Boon Khai Ng (1):
  net: dwc_eth_xgmac_socfpga: Add support for distinct mac-mode and phy
    mode.

 drivers/net/dwc_eth_xgmac_socfpga.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

-- 
2.26.2

