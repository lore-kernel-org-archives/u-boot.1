Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19474C55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 12:30:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D076E608A1;
	Thu, 30 Jul 2026 12:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UuhnN2XEAS6K; Thu, 30 Jul 2026 12:30:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 52E3E60884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785414614;
	bh=Fwdu+sZt5mpNFo5viylcCRLzgBtoLIu2qQSIYh9i9Bc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PwWsRu4az2EBbV3HeOhl7svQ0vVtI5ZR02KWfiT/wfeWTZX1+4djzf5jZTy678oU9
	 lK7YhQ+e11aQhZbaQdcn+TtnUDG9RsUyE5sxUXLVYNMh3zQF8woYhal/S2iwSfW9yY
	 Mk7zxHlOcsnXJZMGEyIijBBsAMlNvl8AnDhjr4VOQvXUjfJpO3WfvsCQ2DMrI9qufm
	 +49TfepdqDSAWw+7J3JHGW+z6zQCDt2qYoSg+DhV5UEevnpB7pePolU3H9CPxzYYnu
	 7ToH7B/BXoPM2vRPgv90LDcqa1yI/R+oT92YBo1h9uKtWnasYzTm82zIxC6D937w0K
	 WqGUAm9Bmipcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52E3E60884;
	Thu, 30 Jul 2026 12:30:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EAE5227B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D09E280C8B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:30:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QOZ9FwbvpDRM for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 12:30:12 +0000 (UTC)
X-Greylist: delayed 1121 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 30 Jul 2026 12:30:11 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D73A280D8B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D73A280D8B
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D73A280D8B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:30:11 +0000 (UTC)
X-Forward-Email-ID: 6a6b43cc28c4da9522fea2b9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.12.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.u-boot-project.org
Subject: [PATCH] rockchip: rk3576: Disable force_jtag by default
Date: Thu, 30 Jul 2026 12:30:00 +0000
Message-ID: <20260730123001.1211166-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1785414611;
 bh=Fwdu+sZt5mpNFo5viylcCRLzgBtoLIu2qQSIYh9i9Bc=;
 b=s30O8XepnYwSSm43lr9PKm45wEJw/bM4zNjLT6w0lUdkAnDDtfDlR7eZsO0+0jfuCRSnZ33lm
 24aedOzFxn1qaQiv+xoPYOgRKBt0BUQhyr+Qo89JCrUxjbXJSJxgaV8L4ik8wcDSLoQKb6yGC2i
 t/JnfnlTqFV7fvp7o+ENWPpkweD47pYAiF5Ilvc8l4b78aVY2qoHqzJHE5iPzPjGTjt7SKr3KPj
 t7hOYBMxhbiNxE/cW3q+j4tSOt8/gQ9vbEiaWmak47Myr7zumHThny6HcXf8bjp9Kxs1QhExPDK
 59qa+D0j7cUyyAdcdWQH7m+WbmtKFMrVbfZlBYJLeKBg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=s30O8Xep
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Rockchip SoCs can automatically switch between jtag and sdmmc based on
the following rules:
- all the SDMMC pins including SDMMC_DET set as SDMMC function in GRF,
- force_jtag bit in GRF is 1,
- SDMMC_DET is low (no card detected),

Note that the BootROM may mux all SDMMC pins in their SDMMC function or
not, depending on the boot medium that were tried.

Because SDMMC_DET pin is not guaranteed to be used as an SD card card
detect pin, it could be low at boot or even switch at runtime, which
would enable the jtag function and render the SD card unusable.

Or boards using cd-gpios may switch the SDMMC_DET pin to GPIO function,
which would enable the jtag function and render the SD card unusable.

With commit d0a838bdc629 ("Subtree merge tag 'v7.1-dts' of dts repo [1]
into dts/upstream") there are now RK3576 boards that have changed to use
cd-gpios for the SDMMC_DET pin, e.g. NanoPi R76S, that may have issues
detecting SD card unless force_jtag is disabled.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3576/rk3576.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
index e3e93f663959..0f41f210a9a5 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -26,6 +26,9 @@
 #define SYS_SGRF_SOC_CON15	0x005C
 #define SYS_SGRF_SOC_CON20	0x0070
 
+#define TOP_IOC_BASE		0x26044000
+#define IOC_MISC_CON		0x00F0
+
 #define FW_PMU1SGRF_BASE	0x26003000
 #define PMU1SGRF_SLV_LOOKUP0	0x80
 
@@ -190,6 +193,10 @@ int arch_cpu_init(void)
 	 */
 	writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
 
+	/* Disable JTAG exposed on SDMMC pins (GPIO2A2 and GPIO2A3) */
+	if (IS_ENABLED(CONFIG_ROCKCHIP_DISABLE_FORCE_JTAG))
+		writel(0x00020000, TOP_IOC_BASE + IOC_MISC_CON);
+
 	/* Disable USB3OTG0 U3 port, later enabled by USBDP PHY driver */
 	writel(0xffff0188, USB_GRF_BASE + USB3OTG0_CON1);
 
-- 
2.54.0

