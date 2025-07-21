Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686C3C83F26
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 22:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56859837F5;
	Tue, 22 Jul 2025 00:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ru8aOOub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33D2C830EA; Tue, 22 Jul 2025 00:08:19 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C2B8383E
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dd2a=2D=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753135695; bh=U5Qc8sPa43YRvxZfpKml8hdj9zVIGWyvwEsd6DkREQM=;
 b=ru8aOOubW6KezZbmGMujDbXVvFI9j5tEmBHbC9EJqUMY3OJHxagfUkjzJ+vzEnk8GePTrJDJo
 rtHF/Cx42VELmYDqm1wwKeqKbPtT9gchw8sJmI9pbR8qlHuCggWPiwOrnXieC0KQqOATcTKh//l
 RWNJAZcsqONDfHPN4xHl0SPcYk028XGV81aIyXZB+Kqg/IT7+eKoYW5Z5yTNTybHHe/4nQvO6Dt
 ICwZ+IH7qX4Uyuw0BWUKka8hmP7Bnc7Q15OJeSQaIGkXgioUKKp1wWPr+qGslNji+MJ0wzOp0Gm
 D6EC8o8a7ZCULDm+IhedYThrqFCgTfcTilNHh0TS5eCQ==
X-Forward-Email-ID: 687eba4a285c522641289574
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
Subject: [PATCH 09/10] rockchip: rk3576: Disable USB3OTG0 U3 port early
Date: Mon, 21 Jul 2025 22:07:18 +0000
Message-ID: <20250721220734.1617117-10-jonas@kwiboo.se>
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

The RK3576 SoC comes with USB OTG support using a DWC3 controller with
a USB2 PHY and a USB3 PHY (USBDP PHY).

Some board designs may not use the USBDP PHY for USB3 purpose. For these
board to use USB OTG the input clock source must change to use UTMI clk
instead of PIPE clk.

Change to always disable the USB3OTG0 U3 port early and leave it to the
USBDP PHY driver to re-enable the U3 port when a usb3-phy is described
in the board device tree.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3576/rk3576.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
index ba5c94b4b3dd..dc53941ab2f5 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -29,6 +29,9 @@
 #define SGRF_DOMAIN_CON4	0x10
 #define SGRF_DOMAIN_CON5	0x14
 
+#define USB_GRF_BASE		0x2601E000
+#define USB3OTG0_CON1		0x0030
+
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/soc/mmc@2a330000",
 	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
@@ -151,5 +154,8 @@ int arch_cpu_init(void)
 	 */
 	writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
 
+	/* Disable USB3OTG0 U3 port, later enabled by USBDP PHY driver */
+	writel(0xffff0188, USB_GRF_BASE + USB3OTG0_CON1);
+
 	return 0;
 }
-- 
2.50.1

