Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691EBC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 23:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30AC384C26;
	Fri, 10 Jul 2026 01:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="cPTnSM6A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7552E84B20; Fri, 10 Jul 2026 01:02:57 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E722684B61
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 01:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4682=FE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783638173; bh=kVf8Rf7CYHL6T6QZDA/ijx7UjHhp0xESR2Ly6JUQ6YY=;
 b=cPTnSM6ANNIQ41XU78CEs1wU3Xabvvu2+EeK7ye3NjXxAINSQIP80fL/4yizmv8zlHIIA2BhL
 SioCcA4mswYVuOwGv/gagc+8nv1FiRTxHoyCUm3JmeDeLotOurFiMi+bIXJr/ZVCz0Qbo23yry6
 X86IMoO+IjewWrM9PeEwH7EVJhAviqVw3r0ekC/XB8LUeU7qg38ijW/rXMj1oKgYTtI6jJotkv3
 VJ1HSnuROMjkWOrTZYrxj60mCdXx8yzRPVonkA1spgl/irAzpct45AvbEmH8X6o+sjk86caokVe
 vRFn6QRgb9ZbhG+BH0NsFREYjariyq/c5VPhNqM+9VGA==
X-Forward-Email-ID: 6a50289d145c9a471a72e2a3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/4] mmc: dw_mmc: Allow use of in-spec voltage range for
 vqmmc-supply
Date: Thu,  9 Jul 2026 23:02:41 +0000
Message-ID: <20260709230244.3516247-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709230244.3516247-1-jonas@kwiboo.se>
References: <20260709230244.3516247-1-jonas@kwiboo.se>
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

The Rockchip RK3399 SoC SDMMC IO domain supports 1.8V and 3.0V mode, and
the 3.0V mode is within SD Standards allowed 2.7V-3.6V range. However,
the commit 0b75109b6aaf ("mmc: dw_mmc: return error for invalid voltage
setting") help enforce strict 1.8V and 3.3V when setting vqmmc-supply
making mmc_set_signal_voltage() now fail for MMC_SIGNAL_VOLTAGE_330 and
leading to an improper switch to MMC_SIGNAL_VOLTAGE_180.

Use regulator_set_value_clamp() to set an SD Standards voltage range,
1.70V-1.95V and 2.7V-3.6V, I/O voltage instead of requiring an exact
regulator value to closer match Linux and to fix use of 3.3V signal
voltage on Rockchip RK3399 boards using MMC_IO_VOLTAGE=y.

Fixes: 0b75109b6aaf ("mmc: dw_mmc: return error for invalid voltage setting")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
v2: Collect r-b tag
---
 drivers/mmc/dw_mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index d9c05b223d5f..c2424d7875ca 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -645,9 +645,11 @@ static int dwmci_set_ios(struct mmc *mmc)
 		int ret;
 
 		if (mmc->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
-			ret = regulator_set_value(mmc->vqmmc_supply, 1800000);
+			ret = regulator_set_value_clamp(mmc->vqmmc_supply,
+							1700000, 1800000, 1950000);
 		else
-			ret = regulator_set_value(mmc->vqmmc_supply, 3300000);
+			ret = regulator_set_value_clamp(mmc->vqmmc_supply,
+							2700000, 3300000, 3600000);
 		if (ret && ret != -ENOSYS)
 			return ret;
 	}
-- 
2.54.0

