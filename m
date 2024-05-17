Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B1CC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B24F5882A9;
	Fri, 17 May 2024 14:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QcZqnzE8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E382D88490; Fri, 17 May 2024 07:27:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E2E6882D9
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923676; x=1747459676;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WeBYBKRYAwI1jpZxv+YHrY9kDvTcBDswzxm2Lqc12ZE=;
 b=QcZqnzE86K/DaLItK7up4VRyikPqNYs1UEbOGlNoJJFQI4NIMJG0x9at
 tbKBMxA0I+E3kGy8a6ULJxMP618uT1z1cfn7R1alzd6J760ZvfUG+hF5A
 RjBAS8ZMcAKkYjduc+wVvSyN0PMH+J9uLYGLcHVP7xeLwFiRzNB4lg24/
 L9g4Cgxpi40bpVcBqQt3ag6zgQXDks1TpvnULP7sraU5hu8v+tF/auHhK
 dC2coduswzjX8JSZMUavtp6iV6vkucflWJQZY7Nfb/xPQ/3UJJlb3jc8V
 OGXdv5SrPm5IQMpS1xDp3z0j+ZStHzZdL1WY9+zAXcwzEfp1oFT3sjZNL Q==;
X-CSE-ConnectionGUID: isFuwhQ+QnWkbDjiCSQANA==
X-CSE-MsgGUID: 9wdzggQKSLuikVKsp4LsEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11929978"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11929978"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:27:56 -0700
X-CSE-ConnectionGUID: NWEJYjXxTLKsO51yFazCfQ==
X-CSE-MsgGUID: +d+EN3cZRnaYnOuLSrVidg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188248"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:27:51 -0700
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
 Siew Chin Lim <elly.siew.chin.lim@intel.com>,
 Tingting Meng <tingting.meng@intel.com>
Subject: [Agilex7 M-series Platform Enablement v1 06/16] include: configs:
 soc64: Use CONFIG_SPL_ATF to differentiate bootfile
Date: Fri, 17 May 2024 13:26:51 +0800
Message-Id: <20240517052701.12949-7-tingting.meng@intel.com>
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

From: Siew Chin Lim <elly.siew.chin.lim@intel.com>

ATF boot flow (SPL->ATF->U-Boot Proper->OS) boot to OS via kernel.itb file
using bootm command.

Change to use CONFIG_SPL_ATF to differentiate the bootfile of default
environment variable. We shouldn't use CONFIG_FIT because it is enabled
by default for U-Boot Proper.

Signed-off-by: Siew Chin Lim <elly.siew.chin.lim@intel.com>
Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 arch/arm/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a0842e1933..56e190adf6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -21,6 +21,9 @@ config ARM64_CRC32
 	  not be present on all ARMv8.0, but is always present on ARMv8.1 and
 	  newer.
 
+config BOOTFILE
+	default kernel.itb if SPL_ATF && TARGET_SOCFPGA_SOC64
+
 config COUNTER_FREQUENCY
 	int "Timer clock frequency"
 	depends on ARM64 || CPU_V7A
-- 
2.25.1

