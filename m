Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7ADC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 05:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66B3F80312;
	Fri, 17 Jan 2025 06:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="myLvqfHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 733728069D; Fri, 17 Jan 2025 04:15:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C88801B0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 04:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737083744; x=1768619744;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JJb8ONUjLDPM9IMafaC1H5vVI1fIwfBAfAtfdtLEE24=;
 b=myLvqfHUDfmDjXcLKvw6YGDbRcuMGyHNuMwM1OJfTi8c+Q0ECoZPYxVP
 KZtgZixjRinmlkPCPvwSwMqRZ2SpuWi09AaOgYajvk6mWuGLevj1DhEGR
 xQZTZEawsMQEyuv1IbUbiwFoZKvHEA83ibhIEPwM5TrzJzuXVpODCyQbX
 G+y1X77HK7TTeTFwPyhpoQvS9DIeeEGnXW5Rc3wnaalKtUaqlQwteBDe9
 /pTk1m6ec9g5bv+oamFjnnGbHnaBYuos3XoYdShDoCEe4IhreXlaOPbLf
 qJRtC/ccXACqgv8ehIk6S7otkHd+KV26zlevJM+OsNBfgyfKos5JBVaw+ Q==;
X-CSE-ConnectionGUID: 1nGbQNaNS+6ZSBYdz0YSpw==
X-CSE-MsgGUID: ZBoHy/D3TYSL5O4ACVqCNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="47992627"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; d="scan'208";a="47992627"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 19:15:42 -0800
X-CSE-ConnectionGUID: gxlXPsZCTwK38otyk4ae1w==
X-CSE-MsgGUID: cWselVgTQmWd4ss2CClAWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="110313893"
Received: from apgcp0d551112.png.altera.com ([10.244.77.50])
 by fmviesa005.fm.intel.com with ESMTP; 16 Jan 2025 19:15:40 -0800
From: Boon Khai Ng <boon.khai.ng@intel.com>
To: Uboot Open List <u-boot@lists.denx.de>
Cc: Tien Fong Chee <tien.fong.chee@intel.com>,
 Kok Kiang Hea <kok.kiang.hea@intel.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tom Rini <trini@konsulko.com>, Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [XGMAC dt bindings v1 0/1] Add Synopsys DWC XGMAC Binding
Date: Fri, 17 Jan 2025 11:15:33 +0800
Message-Id: <20250117031535.19595-1-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Jan 2025 06:52:46 +0100
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

The proposed patch introduces a new binding for the
Synopsys DWC 10G Ethernet MAC IP block(XGMAC). This block is
configurable and supports a wide range of options, including
various bus types, clocking and reset structures, and feature sets.

The patch includes the essential properties and optional
configurations to ensure compatibility with different
hardware setups that incorporate the Synopsys DWC XGMAC IP block.

Boon Khai Ng (1):
  dt: net: add DWC XGMAC binding

 .../net/snps,dwc-xgmac-ethernet.txt           | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 doc/device-tree-bindings/net/snps,dwc-xgmac-ethernet.txt

-- 
2.26.2

