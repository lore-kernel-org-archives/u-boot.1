Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22051C02188
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D29F6807B6;
	Fri, 17 Jan 2025 15:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HelS6fTI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C9CC80713; Fri, 17 Jan 2025 07:56:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEE4E801B0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 07:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737096997; x=1768632997;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o1oKVlDr7O02pJAZPkQX36caTePePZt4ycAbguRgpgk=;
 b=HelS6fTIuJCHbpMHEX/2cuVN2neWGWYfAx/N2QqbpXYR+SPeWbBz1xLo
 7f4ABgpIXlcUHnQDfAFO5qLn7xGB8hj9IHOHp7qLvw0hJMBmbiesZdp6Q
 GLsswspV90xiL4d4Hh2b0XaCv2P8laewPSd1/QlJSfTzGyLQD2IFuDyeV
 b/8cQ0okow8ubsNNEtyUV6z7PeCLsz694ZOz46Ju8pgaGChA3WIO8wbkc
 DUITtDnU3QGxbY2kY9zHrvy+OFCnUX10pF54dC0Z2cwzw7f/nf6yoSx6g
 NoEB5oR1n1jJk6SLVcWVBVG98WalXjbDGLPjWtgY4IUxj05oGBbGUYKwj A==;
X-CSE-ConnectionGUID: MjocSc7sThWxwJh1WVK7IQ==
X-CSE-MsgGUID: Yc91frXrSQeeqCc2eocz/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48936690"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="48936690"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 22:56:37 -0800
X-CSE-ConnectionGUID: GCY3FaYhS+mV4EV1SGOzrw==
X-CSE-MsgGUID: Xw6EXmQVQtm2MliJmqwOqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; d="scan'208";a="105905703"
Received: from apgcp0d551112.png.altera.com ([10.244.77.50])
 by fmviesa008.fm.intel.com with ESMTP; 16 Jan 2025 22:56:32 -0800
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
Subject: [XGMAC RGMII-ID fix v1 1/1] net: dwc_eth_xgmac_socfpga: Add support
 for rgmii-id mode.
Date: Fri, 17 Jan 2025 14:56:25 +0800
Message-Id: <20250117065625.27832-2-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250117065625.27832-1-boon.khai.ng@intel.com>
References: <20250117065625.27832-1-boon.khai.ng@intel.com>
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

An issue was identified where selecting the phy-mode as
rgmii-id in the device tree source (DTS) would cause the
`dwc_eth_xgmac_socfpga` driver to raise an unsupported phy mode error.

From the MAC controller's perspective, the rgmii and rgmii-id
phy modes are effectively identical. To address this, both
modes will now be configured to rgmii in the MAC controller.

This change ensures that the rgmii-id phy mode is properly
supported without error.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
---
 drivers/net/dwc_eth_xgmac_socfpga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dwc_eth_xgmac_socfpga.c b/drivers/net/dwc_eth_xgmac_socfpga.c
index 87fb7e887e..1864187c17 100644
--- a/drivers/net/dwc_eth_xgmac_socfpga.c
+++ b/drivers/net/dwc_eth_xgmac_socfpga.c
@@ -80,6 +80,7 @@ static int xgmac_probe_resources_socfpga(struct udevice *dev)
 		modereg = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RMII;
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
 		modereg = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RGMII;
 		break;
 	default:
-- 
2.26.2

