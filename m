Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15FACCD184
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 15:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E642838BB;
	Sun, 19 Oct 2025 17:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="d3DEtcw7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3108C83211; Sun, 19 Oct 2025 17:10:06 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1FFB838B7
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 17:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ad34=45=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1760886602; bh=SQq8N1X8DfwuqX06VSeVl8nmB2ST/5S0Pv95jQ2sL7w=;
 b=d3DEtcw7QMy24hCQ4vIcQ3I+mW13BfdUTROaAxOam0ysJi81yF+1dOVJ6JaIohyRwxYpd5N3f
 ZFwh3Q4/+hV6vYOB7FOPOKR4hU0V32YKTPySEv85CtTqZ7XSDyAA0hIWPlER5dvfU7ZFL2bGwT0
 Qj1wzgosQyHXtOn+opx8aF6vwVTAmozuATK7uAqz6eAiyc62x//SIGTNwf7Vxy6L+rwyqHccYxa
 xGkMDSQImhm2PixKXgLnHk80aPA7229I2nAMmpv/6eZnU/8NBH9T4KRzKBhzhGjcZpBrpZcR6w8
 QQvDuvPchW273WQY6pgFuV/SrJ54hHwUg6QDuTKoiBBw==
X-Forward-Email-ID: 68f4ff465ea0c6742724294a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] rockchip: rk3568: Disable USB3OTG U3 ports early
Date: Sun, 19 Oct 2025 15:09:41 +0000
Message-ID: <20251019150945.823167-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019150945.823167-1-jonas@kwiboo.se>
References: <20251019150945.823167-1-jonas@kwiboo.se>
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

The RK3568 SoC comes with USB OTG support using a DWC3 controller with
a USB2 PHY and a USB3 PHY (COMBPHY).

Some board designs may not use the COMBPHY for USB3 purpose. For these
board to use USB OTG the input clock source must change to use UTMI clk
instead of PIPE clk.

Change to always disable the USB3OTG U3 ports early and leave it to the
COMBPHY driver to re-enable the U3 port when a usb3-phy is described in
the board device tree.

Please note that this may break use of USB 3.0 on RK3568 on Linux kernel
prior to version 6.6.112, 6.12.53, 6.17.3 and 6.18-rc1.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
It may be too soon to apply this patch, we should possible give more
time for OS to adopt to these changes.

The first patch in this series should however be safe to apply.
---
 arch/arm/mach-rockchip/rk3568/rk3568.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index c2b96902d2dd..560af336be4f 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -14,6 +14,9 @@
 #include <dt-bindings/clock/rk3568-cru.h>
 
 #define PMUGRF_BASE			0xfdc20000
+#define PIPE_GRF_BASE			0xfdc50000
+#define USB3OTG0_CON1			0x104
+#define USB3OTG1_CON1			0x144
 #define GRF_BASE			0xfdc60000
 #define GRF_GPIO1B_DS_2			0x218
 #define GRF_GPIO1B_DS_3			0x21c
@@ -139,6 +142,10 @@ int arch_cpu_init(void)
 	/* Enable VO power domain for display */
 	writel((PMU_PD_VO_DWN_ENA << 16),
 	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
+
+	/* Disable USB3OTG U3 ports, later enabled in COMBPHY driver */
+	writel(0xffff0181, PIPE_GRF_BASE + USB3OTG0_CON1);
+	writel(0xffff0181, PIPE_GRF_BASE + USB3OTG1_CON1);
 #endif
 	return 0;
 }
-- 
2.51.0

