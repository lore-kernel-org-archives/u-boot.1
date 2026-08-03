Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A47C55822
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EB9860725;
	Mon,  3 Aug 2026 19:10:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EWhOBnxyJ3mR; Mon,  3 Aug 2026 19:10:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4ECEA60721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784208;
	bh=7fuS9+M4GxcMNudrm56sskXBhx5tfcWlqLZiHf6db/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=to1nIAO5fl7IAyMSGIaTIlnUth9eSbSqYn/QvKrlYWekeELSFUzJAQQpV+2+f6Hyb
	 Pui2wQvauLKcz/EOAoz2Gv4128f7lKRNtbQ+fphxDZYt2lMvdS0mTlUD4za8BPFR0f
	 3PZaoxf2AF2KYAvfysbCj8D/YhOI1DeQrvfdDxAlqg979L7VNWDUVuriclrsCjkUk8
	 goPtxakR+HXqNyMf5qbh4u6TGMSWmpAoRxWACcGA3DY0h7XpKzNzOo5MuM8XILqjRJ
	 ML9WJ4GfyE+359Yx1DDdGg6VItYtQnMQ8dxg+Q9Yrf7ciZE97yXvsaCy2TResM/9CG
	 AjGZmBH/7ooYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4ECEA60721;
	Mon,  3 Aug 2026 19:10:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 79861194
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 773EE80BDB
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:10:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p296DiILQWBi for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:10:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a02:6ea0:d71e::9;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 68A3980C27
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 68A3980C27
Received: from smtp.forwardemail.net (smtp.forwardemail.net
 [IPv6:2a02:6ea0:d71e::9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68A3980C27
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:10:04 +0000 (UTC)
X-Forward-Email-ID: 6a70e789ae1ce3dd2fb7e5f0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 6/6] rockchip: rk3506: Use FIELD_PREP_WM16 macro
Date: Mon,  3 Aug 2026 19:09:44 +0000
Message-ID: <20260803190946.2259514-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803190946.2259514-1-jonas@kwiboo.se>
References: <20260803190946.2259514-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785784203; bh=7fuS9+M4GxcMNudrm56sskXBhx5tfcWlqLZiHf6db/Y=;
 b=Umos5cyQRpYMB7fWDh3ZYTAWOReQjHeQH0GSEGQboglsgWR+ZX3Rbmz40Cm3mBkbB98q4MIfM
 LKgyI+3kWJI17GCf0iDKFF2/HW/bD/FOYkhesjVclxks5kUdC3pS5oia9E4ogbjserwwARHYnIt
 9Kj+J+vAZGcTBarilyHopN1EmPn9bMqg+BJqEKccsoeT4Tyg4rwrurpDM4DPH4Pg88LwPn2mGkR
 OXSElyyOdELdyS/46aTPA394DILKetBpMU/teEeGh3E3CFuam8hpblxFPEhls6AwGoXnbg2OTHK
 Z/hOBug6ztdseJKmIUY93uAcAP67Ypdlcwwf6wKH1ziw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Umos5cyQ
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

Change to use writel() together with the FIELD_PREP_WM16() macro instead
of using the rk_clrreg() macro or custom write-enable bit handling.

No change in behavior is expected due to this code style change.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3506/rk3506.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3506/rk3506.c b/arch/arm/mach-rockchip/rk3506/rk3506.c
index 2ed1dcc128e0..ef0943434e5e 100644
--- a/arch/arm/mach-rockchip/rk3506/rk3506.c
+++ b/arch/arm/mach-rockchip/rk3506/rk3506.c
@@ -6,7 +6,8 @@
 #include <dm.h>
 #include <misc.h>
 #include <asm/arch-rockchip/bootrom.h>
-#include <asm/arch-rockchip/hardware.h>
+#include <asm/io.h>
+#include <linux/hw_bitfield.h>
 
 #define SGRF_BASE			0xff210000
 
@@ -32,7 +33,7 @@ int arch_cpu_init(void)
 		return 0;
 
 	/* Select non-secure OTPC */
-	rk_clrreg(SGRF_BASE + 0x100, BIT(1));
+	writel(FIELD_PREP_WM16(BIT(1), 0), SGRF_BASE + 0x0100);
 
 	/* Set the sdmmc/emmc to access ddr memory */
 	val = readl(FIREWALL_DDR_BASE + FW_DDR_MST1_REG);
@@ -77,7 +78,7 @@ void rockchip_stimer_init(void)
 	asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (CONFIG_COUNTER_FREQUENCY));
 	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT0_REG);
 	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT1_REG);
-	writel((TIMER_EN << 16) | TIMER_EN, HP_TIMER_BASE + HP_CTRL_REG);
+	writel(FIELD_PREP_WM16(TIMER_EN, 1), HP_TIMER_BASE + HP_CTRL_REG);
 }
 
 #define RK3506_OTP_CPU_CODE_OFFSET		0x02
-- 
2.54.0

