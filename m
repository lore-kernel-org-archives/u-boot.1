Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB6DCF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E0A893A0;
	Fri, 20 Sep 2024 09:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DjUzGUM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 637E989391; Fri, 20 Sep 2024 09:03:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0434889393
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815834; x=1758351834;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hpaUwe6SCcCtUFjcAZi9CJ8edUOZ8tJJ0EagCALe1NE=;
 b=DjUzGUM6ejRBQopbGXHUHR/8nZrVBiZGOa+2zEe3FEdvccu3odTXhtF1
 7hk6WeOw8dMBWAJ5JJ5j+omRrNu/mroiD4Qo//z1+vYfRqLHmcuxHRrg6
 KnGcPz4MkMScKUl0ZvvpDzGd0vJn3n/7O62fWgiuINoLHkPX0cDJg/Qm2
 qL7+pWcyxLGTFmAfaTBV7O4eSvsmWZdn70SBGSru2O91KVZf8vgzPIy3c
 giLq0Wf+rhqkqtabNPw1tY3ZliGFDmIkFxnMLAYw33Ps2R9F+HS07Omro
 JsQJMY307irsrS7BI7T0o4gxTE54JVtNpgqLHApVQ0KRdqobv6VYO2NIZ A==;
X-CSE-ConnectionGUID: 4n9MnywDR0Gppo+URCL1UA==
X-CSE-MsgGUID: Lz3SFhYnTPasKrCiZZHeSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961118"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961118"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:53 -0700
X-CSE-ConnectionGUID: qz2PO5nhROq0MsaYVFvlZg==
X-CSE-MsgGUID: BeLxl+/ZRiSp1uv2a6czkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235282"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:50 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 18/20] configs: socfpga: soc64: agilex5: Enable XGMAC
Date: Fri, 20 Sep 2024 15:02:40 +0800
Message-Id: <20240920070242.20884-19-tien.fong.chee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920070242.20884-1-tien.fong.chee@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
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

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 configs/socfpga_agilex5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 81bbe967dcf..a4a5064d9c2 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -92,3 +92,4 @@ CONFIG_WDT=y
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
 # CONFIG_EFI_LOADER is not set
+CONFIG_DWC_ETH_XGMAC=y
-- 
2.25.1

