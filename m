Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD59C25B77
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AC6F884BE;
	Fri, 17 May 2024 14:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SbUYbN9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC10E88491; Fri, 17 May 2024 07:27:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DFF1882D9
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923672; x=1747459672;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C0XaL1nnFCD+84yQX+eMpfpnsEGFRIqzHUN3svANlV8=;
 b=SbUYbN9c7fTHkhh5mUZGr0TcJHa+/t3SiSe1dUKhPWKXENmm0TNacJRR
 DDLddgTbaeQQfX4cof6Z75UFgGWgl3Q07WSaU/eHQ+DuPP9uNX/oweIks
 ED8hTz9cvwGFYyuwDf5K65Rr5sw1+5vnK4djN4ovSK5CzW04opPcu1Tid
 xbXAWx4MnuFqd8RIaeRWWjxO/9QnL1nsIKnhT/1uiqKtsc4bjoxVH6dT2
 Me4eu2jOY3cRUBFfkagqS8OcI7zxE7KJUNLlWsbU0ximfGWZ+TPLOORDX
 Dg4R+riIKPpZNBR4XhlhTAn6Smn+jg7wqE1tb4psC335oLAlo3yXUmd2d g==;
X-CSE-ConnectionGUID: LHqFH81LRsurHF5FNRRjYg==
X-CSE-MsgGUID: MFincdjrT22jYPASUwe8MA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11929967"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11929967"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:27:51 -0700
X-CSE-ConnectionGUID: /HApaei+ToSSLR969UCMew==
X-CSE-MsgGUID: oQbkCxsYRf+Ryi9e0r+BWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188241"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:27:47 -0700
From: tingting.meng@intel.com
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Tingting Meng <tingting.meng@intel.com>
Subject: [Agilex7 M-series Platform Enablement v1 05/16] include: configs: Add
 config header file for Agilex7 M-series
Date: Fri, 17 May 2024 13:26:50 +0800
Message-Id: <20240517052701.12949-6-tingting.meng@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240517052701.12949-1-tingting.meng@intel.com>
References: <20240517052701.12949-1-tingting.meng@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 May 2024 14:50:41 +0200
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

From: Wan Yee Lau <wan.yee.lau@intel.com>

Add config header file for new platform Agilex7 M-series.

Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 .../{socfpga_agilex5_socdk.h => socfpga_agilex7m_socdk.h}   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 copy include/configs/{socfpga_agilex5_socdk.h => socfpga_agilex7m_socdk.h} (55%)

diff --git a/include/configs/socfpga_agilex5_socdk.h b/include/configs/socfpga_agilex7m_socdk.h
similarity index 55%
copy from include/configs/socfpga_agilex5_socdk.h
copy to include/configs/socfpga_agilex7m_socdk.h
index b5b5bd767f..433556804e 100644
--- a/include/configs/socfpga_agilex5_socdk.h
+++ b/include/configs/socfpga_agilex7m_socdk.h
@@ -4,9 +4,9 @@
  *
  */
 
-#ifndef __CONFIG_SOCFGPA_AGILEX5_H__
-#define __CONFIG_SOCFGPA_AGILEX5_H__
+#ifndef __CONFIG_SOCFGPA_AGILEX7M_H__
+#define __CONFIG_SOCFGPA_AGILEX7M_H__
 
 #include <configs/socfpga_soc64_common.h>
 
-#endif	/* __CONFIG_SOCFGPA_AGILEX5_H__ */
+#endif	/* __CONFIG_SOCFGPA_AGILEX7M_H__ */
-- 
2.25.1

