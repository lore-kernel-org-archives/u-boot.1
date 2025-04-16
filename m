Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E112C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 03:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8439F8008A;
	Wed, 16 Apr 2025 05:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C4FA8056A; Wed, 16 Apr 2025 05:07:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D6B38006D
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 05:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
X-CSE-ConnectionGUID: M00OOyVRSy2OKO2OvT4Aow==
X-CSE-MsgGUID: OQa+JRfcQdSzA9/JkHWF8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="57672285"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="57672285"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2025 20:07:43 -0700
X-CSE-ConnectionGUID: PR/+yUh2RSC9HfG82yf5Ww==
X-CSE-MsgGUID: fsf840SxQUyN30jlcvoJYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="131219277"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa009.fm.intel.com with ESMTP; 15 Apr 2025 20:07:41 -0700
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
Subject: [PATCH v1] configs: agilex5: Restore fixed bloblist
Date: Wed, 16 Apr 2025 11:07:38 +0800
Message-Id: <20250416030738.28328-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.25.1
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

From: Tingting Meng <tingting.meng@altera.com>

CONFIG_BLOBLIST_FIXED and CONFIG_BLOBLIST_ADDR options were
unintentionally removed during recent external updates to the defconfig.
This patch restores the missing entries to ensure proper board
functionality. No new features are introduced.

Fixes: d6a53f523afe ("spl: Add an SPL_HAVE_INIT_STACK option")

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
---
 configs/socfpga_agilex5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 77112664e8a..ad0625a59fa 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -157,6 +157,8 @@ CONFIG_WDT=y
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
+CONFIG_BLOBLIST_ADDR=0x7e000
 CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_BLOBLIST_ADDR=0x72000
 CONFIG_HANDOFF=y
-- 
2.25.1

