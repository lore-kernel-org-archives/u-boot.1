Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466A3C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 23:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C2283322;
	Thu, 31 Jul 2025 01:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="L1Uq7N9Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E984983287; Thu, 31 Jul 2025 01:54:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5A683285
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 01:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5dd1=2M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753919642; bh=XrumoHeIOzOdeTe21zCGbkRmPUn8lYBZ+N/FtFoAilU=;
 b=L1Uq7N9ZER6erfbSul0FcLNIVRd7eAjxGzKdivorG7Ufkhq+KPLouaiPbNgkAI2/eT7T4Zc7N
 wBqUZAQm/yeUydzblt6X/BkOzFvU29KYfIGXP0VjBk1SCMqAJyHwyrNvc+UuchPQ42+hlfT01+T
 Bo1Tm+GmoveTrN8XGHQCJ1/QEHTdPM2SMAbXolpuYxmCfNx3kAfu59fVxFTH5KpU/hZAqeZ2z9t
 rXBk4go+ss4HBTJDsJDNii9PHfs0c7zOPQorjeKok77GHlQQ3GhbfBtDAv69y0G2MzplXze2VIW
 8Tr6uNNeNJxYkR+7NYSUR+9wcXxZE7jAXDJ+2r+o6dqQ==
X-Forward-Email-ID: 688ab0701851584377f62105
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 4/8] rockchip: rk3528: Disable USB3OTG U3 port early
Date: Wed, 30 Jul 2025 23:52:45 +0000
Message-ID: <20250730235301.1774089-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730235301.1774089-1-jonas@kwiboo.se>
References: <20250730235301.1774089-1-jonas@kwiboo.se>
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

The RK3528 SoC comes with USB OTG support using a DWC3 controller with
a USB2 PHY and a USB3 PHY (COMBPHY).

Some board designs may not use the COMBPHY for USB3 purpose. For these
board to use USB OTG the input clock source must change to use UTMI clk
instead of PIPE clk.

Change to always disable the USB3OTG U3 port early and leave it to the
COMBPHY driver to re-enable the U3 port when a usb3-phy is described in
the board device tree.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3528/rk3528.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3528/rk3528.c b/arch/arm/mach-rockchip/rk3528/rk3528.c
index 4892ff6ba9d2..f9bfc445b857 100644
--- a/arch/arm/mach-rockchip/rk3528/rk3528.c
+++ b/arch/arm/mach-rockchip/rk3528/rk3528.c
@@ -9,6 +9,9 @@
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/hardware.h>
 
+#define VPU_GRF_BASE			0xff340000
+#define USB3OTG_CON1			0x44
+
 #define FIREWALL_DDR_BASE		0xff2e0000
 #define FW_DDR_MST6_REG			0x58
 #define FW_DDR_MST7_REG			0x5c
@@ -69,6 +72,9 @@ int arch_cpu_init(void)
 	val = readl(FIREWALL_DDR_BASE + FW_DDR_MST16_REG);
 	writel(val & 0xffff0000, FIREWALL_DDR_BASE + FW_DDR_MST16_REG);
 
+	/* Disable USB3OTG U3 port, later enabled in COMBPHY driver */
+	writel(0xffff0181, VPU_GRF_BASE + USB3OTG_CON1);
+
 	return 0;
 }
 
-- 
2.50.1

