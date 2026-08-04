Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF6EC561E6
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E1F380DBD;
	Tue,  4 Aug 2026 21:45:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vA5ToXdl24RR; Tue,  4 Aug 2026 21:45:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3391780DAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785879914;
	bh=KqZleAZRpwx0SilAgsfuuD+RZ+RWp81MFM9v/zGaXG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=swwdA8dF3Unf+J4N5V85RQgH346PKLw1rAx2PoiB7pVxzNgGwvar1iI9FUaRzs9Yd
	 2yR6V7mxiWzWPj+uqWtcjn5APiSKBl/meALal0Fqx8RFD13ffmgEQ9VzLGlgd0jnnw
	 4WtXwYD9aDv+eb/3NNaDSNtiyMv3YY8b0N780pzrWWrvW6FFMEQp+WetmsBXubvDdz
	 WwZ8Iqrh4NVDjP17kM1BTRj5HBezSmZu7B3Q0dE+HbLIksCSmkFR5WT1ypBYGYPFJ8
	 8FnPXHdAGMqXIFrMGyFiRv230BF4MXf7b+4JGlZtbt8oSIssIUJgdb0p3oG1Buv+bG
	 PV7R5mKSDe97Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3391780DAC;
	Tue,  4 Aug 2026 21:45:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C056210E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A6C4D405D0
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SU-0Hqb3HZZQ for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:45:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1695=f6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 681BE40571
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 681BE40571
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 681BE40571
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:11 +0000 (UTC)
X-Forward-Email-ID: 6a725d6396269bde0830459e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.6
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
Subject: [PATCH 07/10] rockchip: rk3588: Remove unused rockchip_get_clk()
 helper
Date: Tue,  4 Aug 2026 21:44:36 +0000
Message-ID: <20260804214442.2592597-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804214442.2592597-1-jonas@kwiboo.se>
References: <20260804214442.2592597-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785879910; bh=KqZleAZRpwx0SilAgsfuuD+RZ+RWp81MFM9v/zGaXG4=;
 b=O/DE/k15PbFTJlJ/bu+gFsfKPtXKoYIUep0H4ocV7tGmi1856G8XQ7TnCts91VB1ryRByVR7s
 E1MoEMGzLIhZgdVEUdB0NF7H/cwBCAMPXQ87IiCt581hsvjtvJtpbpV3DBhzVkBPC91fu5heRBA
 0L0teSQHxYt/pGIcVUXVmckbjQy732enGvuYW9t8rlfKpHxXEaqlj0sszVdPUhL9tsA3TeJV60y
 ohhjbcnAaLrqE3/oMxglQbw0L2YiYB0CfR7L4IiYzR+uALR2Ip2A85gQ7wshxkvVn8DsWuJJygo
 4zKlAPyoTkCBhmxhxxKYA0O7c5H2bUY1N0NPO2LWFMRQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=O/DE/k15
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

The rockchip_get_clk() helper is typically used by SDRAM init code of
older SoC generations or to help get the CRU base address from the clock
driver private data.

RK3588 has no uses for the rockchip_get_clk() helper, let's drop it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3588/clk_rk3588.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
index 9b112e45f1de..272d28e973b3 100644
--- a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
@@ -3,15 +3,9 @@
  * (C) Copyright 2020 Rockchip Electronics Co., Ltd.
  */
 
-#include <dm.h>
+#include <linux/kernel.h>
 #include <asm/arch-rockchip/cru_rk3588.h>
 
-int rockchip_get_clk(struct udevice **devp)
-{
-	return uclass_get_device_by_driver(UCLASS_CLK,
-			DM_DRIVER_GET(rockchip_rk3588_cru), devp);
-}
-
 void *rockchip_get_cru(void)
 {
 	return (void *)RK3588_CRU_BASE;
-- 
2.54.0

