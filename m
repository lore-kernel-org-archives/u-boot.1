Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD1DC25B77
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 985B5884FD;
	Fri, 17 May 2024 14:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mQiz2dJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40D678848F; Fri, 17 May 2024 07:28:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0DF6882D9
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923707; x=1747459707;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gZzOFN4ajd3LfA46lNar7SiJPGUwAO4TnnnWcPwn6QA=;
 b=mQiz2dJrs95U/oi/wZAkTlfVZqL6jMsEMX0IVoSP++Esit7epB+B4jLW
 5SE/n/uD9yPeGkgv8ApchW0vnOexkSO6mQbO0ErlZr0a/jJTYS4Ltkp/6
 OaezNLiDyPqTPCx3b54zoCaJnvplYhu57rswQRATi25hLwJjMUGxdWAza
 fVM26fGJQXh/ldkxz6jhp0hu6uf8OUNF7I5nanIbhZzevExAYj8ZFJRb0
 tAxvku7iONfCBOxbOG7yP4l/cgrvhgrh1op5joXWWp3usERYN7fF/J3QY
 k+NVxbF5xDongxkIRcc6kDatUEu+vAuOZa3v0eS1ORxjq1zO5l8DFsBi1 Q==;
X-CSE-ConnectionGUID: kj4XqVhQQb6RUeUUs2/4tg==
X-CSE-MsgGUID: QiphOZFxQ4WSekcz3Z05HA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11930036"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11930036"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:28:26 -0700
X-CSE-ConnectionGUID: T04dqJnrQ5u28rnFp9tGTg==
X-CSE-MsgGUID: RnAl30SpQoW4AkFW/wjObA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188368"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:28:22 -0700
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
 Tingting Meng <tingting.meng@intel.com>
Subject: [Agilex7 M-series Platform Enablement v1 13/16] ddr: altera: soc64:
 Fix dram size calculation in clamshell mode
Date: Fri, 17 May 2024 13:26:58 +0800
Message-Id: <20240517052701.12949-14-tingting.meng@intel.com>
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

From: Teik Heng Chong <teik.heng.chong@intel.com>

This patch is to fix wrong memory size calculation in clamshell mode

Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 drivers/ddr/altera/sdram_soc64.c | 16 +++++++++++++++-
 drivers/ddr/altera/sdram_soc64.h |  5 +++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index 8f2085f3a0..27580cce2f 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -27,6 +27,9 @@
 
 #define PGTABLE_OFF	0x4000
 
+#define SINGLE_RANK_CLAMSHELL	0xC3C3
+#define DUAL_RANK_CLAMSHELL	0xA5A5
+
 #if !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
 u32 hmc_readl(struct altera_sdram_plat *plat, u32 reg)
 {
@@ -240,8 +243,19 @@ phys_size_t sdram_calculate_size(struct altera_sdram_plat *plat)
 {
 	u32 dramaddrw = hmc_readl(plat, DRAMADDRW);
 
+	u32 reg_ctrlcfg6_value = hmc_readl(plat, CTRLCFG6);
+	u32 cs_rank = CTRLCFG6_CFG_CS_CHIP(reg_ctrlcfg6_value);
+	u32 cs_addr_width;
+
+	if (cs_rank == SINGLE_RANK_CLAMSHELL)
+		cs_addr_width = 0;
+	else if (cs_rank == DUAL_RANK_CLAMSHELL)
+		cs_addr_width = 1;
+	else
+		cs_addr_width = DRAMADDRW_CFG_CS_ADDR_WIDTH(dramaddrw);
+
 	phys_size_t size = (phys_size_t)1 <<
-			(DRAMADDRW_CFG_CS_ADDR_WIDTH(dramaddrw) +
+			(cs_addr_width +
 			 DRAMADDRW_CFG_BANK_GRP_ADDR_WIDTH(dramaddrw) +
 			 DRAMADDRW_CFG_BANK_ADDR_WIDTH(dramaddrw) +
 			 DRAMADDRW_CFG_ROW_ADDR_WIDTH(dramaddrw) +
diff --git a/drivers/ddr/altera/sdram_soc64.h b/drivers/ddr/altera/sdram_soc64.h
index add7df01a5..8b3b53cf5d 100644
--- a/drivers/ddr/altera/sdram_soc64.h
+++ b/drivers/ddr/altera/sdram_soc64.h
@@ -78,6 +78,8 @@ struct altera_sdram_plat {
 #define CTRLCFG0			0x28
 #define CTRLCFG1			0x2c
 #define CTRLCFG3                        0x34
+#define CTRLCFG5                        0x3c
+#define CTRLCFG6                        0x40
 #define DRAMTIMING0			0x50
 #define CALTIMING0			0x7c
 #define CALTIMING1			0x80
@@ -118,6 +120,9 @@ struct altera_sdram_plat {
 #define CTRLCFG1_CFG_CTRL_EN_ECC(x)			\
 	(((x) >> 7) & 0x1)
 
+#define CTRLCFG6_CFG_CS_CHIP(x)				\
+	((x) & 0xFFFF)
+
 #define DRAMTIMING0_CFG_TCL(x)				\
 	((x) & 0x7F)
 
-- 
2.25.1

