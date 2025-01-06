Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E264E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 10:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2BC6801E8;
	Mon,  6 Jan 2025 11:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AES8ta5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AA188036B; Mon,  6 Jan 2025 11:04:07 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAEDC801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 11:04:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 506A426j119449;
 Mon, 6 Jan 2025 04:04:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736157842;
 bh=LJQIwMMuY5FzTP/22NqA7D03dmExYfPzkEYasIwK3UY=;
 h=From:To:CC:Subject:Date;
 b=AES8ta5/RHDdn2eWMqs1pvRvWj8R3W/2ArmCU3PoJkqaQWPC5whQ3bQIlFMfbKMhL
 6+soaAg9FuPYLWCibL7efLKckGwR5aOcf13qCUO/kAop+sf0s1i8UIrc3vXgb8OnMp
 f1X/7cR0GPh1T9j4M2TPGYrKsPOxf+YvLXZiTn/E=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 506A429v012030;
 Mon, 6 Jan 2025 04:04:02 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Jan 2025 04:04:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Jan 2025 04:04:02 -0600
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com
 [10.24.69.71])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 506A41im040526;
 Mon, 6 Jan 2025 04:04:01 -0600
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <afd@ti.com>
CC: <n-francis@ti.com>, <m-chawdhry@ti.com>, <sabiya.d@ti.com>,
 <j-choudhary@ti.com>
Subject: [PATCH] arch: arm: mach-k3: j784s4_init: Set CTRL_MMR for
 AUDIO_REFCLK1 clk_sel
Date: Mon, 6 Jan 2025 15:34:00 +0530
Message-ID: <20250106100400.93799-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The default value for the mux to select the parent clock,
AUDIO_REFCLK1_CTRL_CLK_SEL is '11111' (31) but the mux input for 31
is marked as 'Reserved' so the ti-sci-clk call for get-parent fails.
Mark it to a valid value, '11100' (28) for MAIN_PLL4_HSDIV2_CLKOUT
to get rid of the linux failures during boot-time like:
"[    1.573193] ti-sci-clk 44083000.system-controller:clock-controller:
 get-parent failed for dev=157, clk=34, ret=-19"

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm/mach-k3/j784s4/j784s4_init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 8a41cd3bb5..787cf6261e 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -23,6 +23,9 @@
 
 #define J784S4_MAX_DDR_CONTROLLERS	4
 
+#define CTRL_MMR_CFG0_AUDIO_REFCLK1_CTRL	0x001082e4
+#define AUDIO_REFCLK1_DEFAULT			0x1c
+
 /* NAVSS North Bridge (NB) */
 #define NAVSS0_NBSS_NB0_CFG_MMRS		0x03702000
 #define NAVSS0_NBSS_NB1_CFG_MMRS		0x03703000
@@ -201,6 +204,8 @@ void k3_spl_init(void)
 		remove_fwl_configs(navss_cbass0_fwls, ARRAY_SIZE(navss_cbass0_fwls));
 	}
 
+	writel(AUDIO_REFCLK1_DEFAULT, (uintptr_t)CTRL_MMR_CFG0_AUDIO_REFCLK1_CTRL);
+
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
 }
-- 
2.34.1

