Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69576C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 22:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D90F83830;
	Tue, 22 Jul 2025 00:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uj1MlKcg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 657D6837F5; Tue, 22 Jul 2025 00:08:14 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C518583830
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dd2a=2D=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753135690; bh=atrArPIAZKOHPxbPSZOtKOLqnUrBzB1Hez+uhYV/IJg=;
 b=uj1MlKcgcPJuNpQ0RhtjN1OHkpCFsxqL9A/R5MEw7mxK1X8MEUeWrWvPjILItOMHU4NwdzkRq
 raSJIZcuy13wINyUqUuz9LTW2r5EXZECqcN0Oa55Ymon5E8PCN+TjcoK8a7l1d+jLipRA4d4Jju
 NFY+EAlh66V6NBORwveR8tStIrq1bVCR0JKL2LMgDg99YFlVAJG+LMylU92jlN/pWhrIe6MCX7l
 JKENbbiJH1S0X6ODNrno00YaGfHOOjmQQNu9RuvWbKfi1nNi+P1aYs1rgNdCyN/Q5qM0ObbD1Ms
 iqE7Qjm1uPQ/jCzyyRivvyhor00e+oCNIWg1QIOfAy8Q==
X-Forward-Email-ID: 687eba47285c52264128955f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 08/10] rockchip: rk3588: Disable USB3OTG U3 ports early
Date: Mon, 21 Jul 2025 22:07:17 +0000
Message-ID: <20250721220734.1617117-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721220734.1617117-1-jonas@kwiboo.se>
References: <20250721220734.1617117-1-jonas@kwiboo.se>
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

The RK3588 SoC comes with USB OTG support using a DWC3 controller with
a USB2 PHY and a USB3 PHY (USBDP PHY).

Some board designs may not use the USBDP PHY for USB3 purpose. For these
board to use USB OTG the input clock source must change to use UTMI clk
instead of PIPE clk.

Change to always disable the USB3OTG U3 ports early and leave it to the
USBDP PHY driver to re-enable the U3 port when a usb3-phy is described
in the board device tree.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3588/rk3588.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index e2278ff792b4..c01a40020896 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -15,6 +15,10 @@
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/ioc_rk3588.h>
 
+#define USB_GRF_BASE			0xfd5ac000
+#define USB3OTG0_CON1			0x001c
+#define USB3OTG1_CON1			0x0034
+
 #define FIREWALL_DDR_BASE		0xfe030000
 #define FW_DDR_MST5_REG			0x54
 #define FW_DDR_MST13_REG		0x74
@@ -184,6 +188,10 @@ int arch_cpu_init(void)
 	/* Disable JTAG exposed on SDMMC */
 	rk_clrreg(&sys_grf->soc_con[6], SYS_GRF_FORCE_JTAG);
 #endif
+
+	/* Disable USB3OTG U3 ports, later enabled by USBDP PHY driver */
+	writel(0xffff0188, USB_GRF_BASE + USB3OTG0_CON1);
+	writel(0xffff0188, USB_GRF_BASE + USB3OTG1_CON1);
 #endif
 
 	return 0;
-- 
2.50.1

