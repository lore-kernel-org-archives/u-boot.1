Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D67C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E98B680F5C;
	Tue, 18 Feb 2025 09:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="k+YSSdy1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B21580FDC; Tue, 18 Feb 2025 09:36:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A7780FB1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867777; x=1771403777;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BylQ7OZ1hVKWkOzutuHz/ScVO002wAJ6l1PJnz9X2io=;
 b=k+YSSdy1eWiTbfRP4ZC+7h3DyCruOeM70cs3bYLGMyiX2SVSl7YDsosX
 uYOziezz6llcmljhn/Q+XDR9pkR25SKM8o1bAjML6ba54khamw0/2y7MW
 wz6omKXMdJQurrm1iK6l6uUB7xGwRJ+fyTTaM3J+V+AI8eVGYMtr5kYto
 3zpzbZgDtPY0mgSuiVxxMh17o40EPJl9QI486or+WzDhssr/Dwdpks2Zb
 UID6DTzdITDZS0JAkGlarQjbc0d2Tm9xmTPHhca/bmccPrD4DpHekfxte
 urex2JTAw66eyByry0W4u+lmJO2X73LN+v4e5CuG5XFqh6eayAdr5tvh/ w==;
X-CSE-ConnectionGUID: 32waB45+SKKP5J/HwCUzCA==
X-CSE-MsgGUID: Zw/3vnUzQP62x9tEG++kDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028220"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028220"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:36:16 -0800
X-CSE-ConnectionGUID: dtIUzdKsR4WE7a/NbJeQkQ==
X-CSE-MsgGUID: oVL0TbZ0RIqCplLcwuNE0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237832"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:36:14 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 23/26] configs: socfpga: soc64: agilex5: Enable XGMAC
Date: Tue, 18 Feb 2025 16:35:08 +0800
Message-Id: <20250218083511.29249-24-alif.zakuan.yuslaimi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Tien Fong Chee <tien.fong.chee@intel.com>

Enable XGMAC for SoCFPGA Agilex5 devkit.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 configs/socfpga_agilex5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 97b00a82129..2b71ccac025 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -97,3 +97,4 @@ CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_BLOBLIST_ADDR=0x7e000
 CONFIG_HANDOFF=y
 CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_DWC_ETH_XGMAC=y
-- 
2.25.1

