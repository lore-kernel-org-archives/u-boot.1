Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3845CC43602
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 10:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E518A8484C;
	Sun, 28 Jun 2026 12:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BDgOcJOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4803F84931; Sun, 28 Jun 2026 12:25:42 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 067BF84866
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 12:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9abc=EY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1782642338; bh=7LmzPN2rFVImeHf2k49h8QHbMry7YieOPz2A3nbuNY0=;
 b=BDgOcJOyoiaHFsjHbvH+v1EnJ4idf+FehWTD9WC+6Dy2mERx8acX9uLbV2a1YhJ8TPp8RhdhD
 Z4a6lidVS1zmo0jQ5Dbbn1/4EGtV7fW44CZKxoIcTV4bOQO66ic4pKkClbvL/SCwqjN0JzCzAf2
 RUNwT2Xen57CIsUGMCWjapj1nzBIRuOlp4IBL+acN+8voY/uBSB0eQNAq2D2BMO7jEW6sP3sj2i
 YQfNBCtHtZ1yvMRNXq2yvs2ynHFZxkSbEwsV0OKe4rscXPq271tb5KNAUKIUpTmLIyFXbuAitZB
 UnaIog/MFC9D2c689gU7MZXKLvAz3avQedhYX9zRu0Kg==
X-Forward-Email-ID: 6a40f6a17915ab77658c870f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.9.1
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
Subject: [PATCH 3/4] mmc: dw_mmc: Allow use of in-spec voltage range for
 vqmmc-supply
Date: Sun, 28 Jun 2026 10:25:25 +0000
Message-ID: <20260628102527.1247889-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628102527.1247889-1-jonas@kwiboo.se>
References: <20260628102527.1247889-1-jonas@kwiboo.se>
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

