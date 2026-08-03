Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4357C55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 18:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CAB480BB7;
	Mon,  3 Aug 2026 18:49:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zwoQX5a1lANh; Mon,  3 Aug 2026 18:49:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B11D28081F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785782946;
	bh=kIGstptYZ473uWQFWB4i6aaKCuybCaTOt3Sf90kNNiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W/Wzh324elZ1VCrW3JEMS2smYnugNw+E/gNZ61igXqfNfD6J4gwCYWi9zNu+s3doG
	 CPYwG4V+5ixng0GBuKWigH4mqb1ILmw0QPuD/t7WD51A3Ndzl/SDMxEIo/Xg2W8ipk
	 Jmr3tqbgttYeM22NPiqyfe9hPL4qi7wQnBSd6C1ygU6cJNTgzHpNXI2xSN0ESTMyIJ
	 +LKJ0bgwnLvwO1rKzBTq434F7TLD6fHLg6710zSwOc65ZAxmMuxefFLyTA02u06e2a
	 easyVqLewDd1v4wz6zpg5uR5JixklVVMyEb21E+uPjBKAKPDxZ91wUoKNKAh+ZL6UI
	 s2/zE+BPrJUMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B11D28081F;
	Mon,  3 Aug 2026 18:49:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CBC212CE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:49:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BDCAF606AE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:49:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HUlyw81oFUHo for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 18:49:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8AB566069D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AB566069D
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8AB566069D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:49:04 +0000 (UTC)
X-Forward-Email-ID: 6a70e14c0b3ab441388a897c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 2/2] rockchip: rk3576: Disable force_jtag by default
Date: Mon,  3 Aug 2026 18:43:13 +0000
Message-ID: <20260803184314.2240153-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803184314.2240153-1-jonas@kwiboo.se>
References: <20260803184314.2240153-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785782942; bh=kIGstptYZ473uWQFWB4i6aaKCuybCaTOt3Sf90kNNiI=;
 b=l1qWJ2FoPfnlMHWhNXTTwqhantecxV1Qmk6EI8AWorDPhKjEbxH/0uTJp4Rpu9j/KFwbqPD7E
 0lHfDmAixNROgJrKu3c2u5gSNCT9ZfNunBTMQCWr18lhZW8XYtBbbq2+sx946Or/40UjS8j278l
 Qbgu2hAIekAPp6qwt0V8zTbzY7l185NiR58nM0K3JF3ooOvoAVw9TV4ItpjL4/J5Rv83FDJMBny
 Mi6FfoJcDnCH9y6s25J0we5YM6E4n6dhB5u5rZE63fs6gN1JvWCISTDbpWfv1zB+WchK7V34DmU
 N2eWP9+eT9vQbzRelvNljOYLJOK2zC+crgSb7ADqv0cA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=l1qWJ2Fo
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
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Define TOP_IOC_FORCE_JTAG and use FIELD_PREP_WM16
- Collect r-b tag
---
 arch/arm/mach-rockchip/rk3576/rk3576.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
index e3e93f663959..76119cdb1aec 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -9,7 +9,8 @@
 #include <misc.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
-#include <asm/arch-rockchip/hardware.h>
+#include <asm/io.h>
+#include <linux/hw_bitfield.h>
 
 #define SYS_GRF_BASE		0x2600A000
 #define SYS_GRF_SOC_CON2	0x0008
@@ -21,6 +22,10 @@
 #define GPIO0B_PULL_L		0x0024
 #define GPIO0B_IE_L		0x002C
 
+#define TOP_IOC_BASE		0x26044000
+#define IOC_MISC_CON		0x00F0
+#define TOP_IOC_FORCE_JTAG	BIT(1)
+
 #define SYS_SGRF_BASE		0x26004000
 #define SYS_SGRF_SOC_CON14	0x0058
 #define SYS_SGRF_SOC_CON15	0x005C
@@ -190,6 +195,11 @@ int arch_cpu_init(void)
 	 */
 	writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
 
+	/* Disable JTAG exposed on SDMMC pins (GPIO2A2 and GPIO2A3) */
+	if (IS_ENABLED(CONFIG_ROCKCHIP_DISABLE_FORCE_JTAG))
+		writel(FIELD_PREP_WM16(TOP_IOC_FORCE_JTAG, 0),
+		       TOP_IOC_BASE + IOC_MISC_CON);
+
 	/* Disable USB3OTG0 U3 port, later enabled by USBDP PHY driver */
 	writel(0xffff0188, USB_GRF_BASE + USB3OTG0_CON1);
 
-- 
2.54.0

