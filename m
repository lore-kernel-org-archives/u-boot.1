Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998DEC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC14880771;
	Fri, 17 Jan 2025 15:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Usg/bu8i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7327D806D8; Fri, 17 Jan 2025 07:48:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C421D80312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 07:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737096512; x=1768632512;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UgT7xf0V03vTJJ+WEsMgbuZHkbl81bKwpd4KE9Bp/Q4=;
 b=Usg/bu8iM/qXILdcQhUZYW7mFkQsgaoZ0ArIEOiyzDd+3D9i+qq1rMKy
 GY2zGSNufjhGqg5OpLgmqsulV1b7F4hRaZ5FYsOJiqbVO2LwrXpTJ8xpl
 HsTvDZDrjCHXo+/xPog5hjAjV9v+D29JX8gIqdisi4I86+e7lxLcLKTKy
 NJFjvLM2uta7+ZrcYR01NqYLm1s37/ao4J7/RTKMY4ldBusZbkK/Sfc1C
 7JGDI63cE89ZgIimvMbOyvq9sO0FkdPKPZU3X0GH0m1T0eH7k0cTSj+ui
 nq25Ap1c+otsLzsr9uc3Ko5Ll87QkbiPhQNV0u6nPbCGavG+B+K0IUO6q Q==;
X-CSE-ConnectionGUID: k6uwO7tUSeOeDVOQm7Z71g==
X-CSE-MsgGUID: 4sitcoyxSZKqJvx8Ixs6Xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="41451374"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; d="scan'208";a="41451374"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 22:48:30 -0800
X-CSE-ConnectionGUID: +po7GafeSN2BgyufmLgJ3Q==
X-CSE-MsgGUID: vDxzKgNaSNCKE84Q5tFdhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="143009845"
Received: from apgcp0d551112.png.altera.com ([10.244.77.50])
 by orviesa001.jf.intel.com with ESMTP; 16 Jan 2025 22:48:27 -0800
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
 Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [XGMAC error message v1 0/1] Adding device name when printing error.
Date: Fri, 17 Jan 2025 14:48:22 +0800
Message-Id: <20250117064823.23512-1-boon.khai.ng@intel.com>
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

In Intel SoC FPGA Agilex5, it support several ethernet instances,
when there is an error occured at multiple interface it hardly tell
which instances that is associated to that error.

Hence, adding the device name at the error message to differentiate
between which instance is having issue.

Boon Khai Ng (1):
  net: dwc_eth_xgmac: Add device name for the error message.

 drivers/net/dwc_eth_xgmac.c | 82 +++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 30 deletions(-)

-- 
2.26.2

