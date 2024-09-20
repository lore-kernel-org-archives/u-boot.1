Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1C3CF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F323F893AC;
	Fri, 20 Sep 2024 09:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="n4Mz/pph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CDB1893A5; Fri, 20 Sep 2024 09:03:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D2C89390
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815823; x=1758351823;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eFef632lV/6w++PpMvECWwr7mE9Ep3UAwPOCUyRuyHc=;
 b=n4Mz/pphELp2/x6+/Jf5/7CajgW+R99CSUQ65fIMP4YYteyuDWuHHSMO
 UgXJtQXoUGRbVG/2mtDtC8qZdFnd7p2pipdrkz7fEKrq0iNgK4lVloJpg
 KtSgiiTeCz/4X8/ln62zCQd2wxWmBfbs5BAde4RZCFVvEzNtBGra/qJzc
 QLGmQNnqQGeBDOsQQtuygx9fqd/OmVLsiZuEr27GPe5i5A5YARnYpoIql
 qrAnXzJVRCMskY/47ivsgM1GAae+ZeMF8U8LKWlp1P0TkWlU+r5WFVfCy
 uWI4WH+FqeNQVxi8C/w5+36V6+2QAdrgk8rCgQod3t+DGtIlubTCU04/k w==;
X-CSE-ConnectionGUID: O4wvN1z2QVmZ8M2n6IC+/Q==
X-CSE-MsgGUID: k4G8sNSvQJ+WAaL6dLBlNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961081"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961081"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:41 -0700
X-CSE-ConnectionGUID: +WQ5RlXcQQScu72cn7hLuQ==
X-CSE-MsgGUID: zkhQqpdMQ6aEXQUkGsLxAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235204"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:39 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 13/20] arm: socfpga: Export board ID as U-Boot environment
 variable
Date: Fri, 20 Sep 2024 15:02:35 +0800
Message-Id: <20240920070242.20884-14-tien.fong.chee@intel.com>
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

Board ID is exported as environment variable for use to boot Linux with FIT
configuration.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 arch/arm/mach-socfpga/include/mach/misc.h | 1 +
 arch/arm/mach-socfpga/misc_soc64.c        | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/misc.h b/arch/arm/mach-socfpga/include/mach/misc.h
index 8460acb00d9..e62bea017b0 100644
--- a/arch/arm/mach-socfpga/include/mach/misc.h
+++ b/arch/arm/mach-socfpga/include/mach/misc.h
@@ -52,5 +52,6 @@ void set_regular_boot(unsigned int status);
 void socfpga_pl310_clear(void);
 void socfpga_get_managers_addr(void);
 int qspi_flash_software_reset(void);
+u8 socfpga_get_board_id(void);
 
 #endif /* _SOCFPGA_MISC_H_ */
diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/misc_soc64.c
index 95e1c07e39f..e34c54518a3 100644
--- a/arch/arm/mach-socfpga/misc_soc64.c
+++ b/arch/arm/mach-socfpga/misc_soc64.c
@@ -60,10 +60,15 @@ int print_cpuinfo(void)
 int arch_misc_init(void)
 {
 	char qspi_string[13];
+	char id[3];
 
 	sprintf(qspi_string, "<0x%08x>", cm_get_qspi_controller_clk_hz());
 	env_set("qspi_clock", qspi_string);
 
+	/* Export board_id as environment variable */
+	sprintf(id, "%u", socfpga_get_board_id());
+	env_set("board_id", id);
+
 	return 0;
 }
 #endif
-- 
2.25.1

