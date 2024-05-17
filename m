Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CBCC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E573884B3;
	Fri, 17 May 2024 14:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J9UNZ2Pi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3276E88496; Fri, 17 May 2024 07:27:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE8AC883C7
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923664; x=1747459664;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FOYT5UVuzdQW7r23Vshr0Or8F6OI6SVQnBgdL6Ai3As=;
 b=J9UNZ2Pi5UyyQyWKzKZujqu34D73zJEk/V0zWttvw/KPxfWdpbl31Sl8
 wozrw17nJBxb6evlWO4nu7yOqdS1oEp69n3URBFNZBDn25uH9wWFk31rk
 XCONr7oiHOJhIywq3SAjPls2WN74k7nQ+Q64GNUfM574ohd+FkLls6VHz
 xIj1LkwrIxYWrlExysLj8ukTf0MGkhQH5XrJCEbZNxYgkR6zfepU6U3Pg
 1x8UDihAy1oWrLijzt2rYGtcHVoyJjF0Dd+y/VDLM/tyl+nrLyPxDoad3
 StBrJfe8/kepQKOqgZrNP773G7/1spUcp7sS3MGNB7aoHLASXO8MZo/Ra A==;
X-CSE-ConnectionGUID: oeZmpBh3Skq6ybJkH02bww==
X-CSE-MsgGUID: aXyyQGXOQzSK5YHHMxV3mA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11929947"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11929947"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:27:43 -0700
X-CSE-ConnectionGUID: lZBf8YljQPyTa8F7w5OuGQ==
X-CSE-MsgGUID: L2KGqWe2SZm9lqERbDUkuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188228"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:27:39 -0700
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
Subject: [Agilex7 M-series Platform Enablement v1 03/16] arch: arm:
 mach-socfpga: Improve help info.
Date: Fri, 17 May 2024 13:26:48 +0800
Message-Id: <20240517052701.12949-4-tingting.meng@intel.com>
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

To improve help info for bridge enable/disable command.

Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 arch/arm/mach-socfpga/misc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 80ad087034..79f7887519 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -210,8 +210,8 @@ static int do_bridge(struct cmd_tbl *cmdtp, int flag, int argc,
 
 U_BOOT_CMD(bridge, 3, 1, do_bridge,
 	   "SoCFPGA HPS FPGA bridge control",
-	   "enable [mask] - Enable HPS-to-FPGA, FPGA-to-HPS, LWHPS-to-FPGA bridges\n"
-	   "bridge disable [mask] - Enable HPS-to-FPGA, FPGA-to-HPS, LWHPS-to-FPGA bridges\n"
+	   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges \n"
+	   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
 	   ""
 );
 
-- 
2.25.1

