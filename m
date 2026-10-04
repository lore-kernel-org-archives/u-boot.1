Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53BFCA5FF0
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 21:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2208B4059C;
	Sun,  4 Oct 2026 21:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Djq7WUbE_W-Z; Sun,  4 Oct 2026 21:14:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 34E95406CC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791148444;
	b=e3fA02o+f3Zi2b9szV1ye6eWS/wEh5miZpz4rORYwYvO0N0NUyw0+iikF04zragnktim
	 bWe05aF9ObgQczgIpQh58pp16C3CrmPcScWc8gTgZHjluobwKy8LbGiVyrmDRz6ZG+kgI
	 quP+HD9607LfEQqnkaAB4EIyQa2cD1wlFYq19UsTZM9fN/fauqRJm4t62wuDMrRpc7hGT
	 yVV5/90V+U4yFZq5LalB0ZYWTUuiYeLsEPJzo9H4lcr6OHmDrsg2Ors4JXhPqUnLYP06o
	 /WlSH2K3uAYhdkLCoz9mJTMvHxn+i+xn/kGVJlW2pAxFD4/2bSzTuHxuHHBzkG3Avbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791148444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xN/WwBKsupAB8pshqgRidqIeSO6/E3IH1lXmSRFkwI4=;
	b=fAFzZCRDyiaHUoJdzaAfJoLT1W2Ha06XJGgq2kriKyHpalOXKUq7LlssviBbiL5vvvRt
	 0gKWSsAyvu/ouTeAZy0eR2b9j8AS8PnvFV583Cvu2ONAOCQkX/yZnL/q7sr7WWft2sjri
	 XRoxvSMi8tkcp9/X8gEWljNYJ8R3rsFUSO2xfdZ6/eWywWofXFnxdKmqV399uHR2WwYiL
	 NZYOcxoFfSyYb7aCEqX+JFetzMCRsz62FkqKKogOkI/DdTekL9qBAEBWOgyStcxZJX8wT
	 XIw2LeOKep39XIBubCkOAkJ2aUGDPRFmqgSl0DiL5AeUur25tL4InrFCIg5vtPkAyqg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791148444;
	bh=xN/WwBKsupAB8pshqgRidqIeSO6/E3IH1lXmSRFkwI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rd0EdFUvQ2mQbRdkY+J3ZeYEQIq89meS1NnARvNO1IbSwD49Cd4NiC2hmI6rIKrDO
	 t6+CPGtA2cQ26NSI2sY7vsZcwzFO5LfS5Bt06jwuN8jrrQDp0JQ5YyBOIAQGsA6tHx
	 B4JF/honoQ8Hga2itYq/B5R5ZTOxodljykchL3JKsXCELLdBeVeMKawN74U07qngde
	 LrpGMt9YZtvv07xaQ32+cKHzTOcQzndD0Hq05JhU79WmXl4qwLh2RSb4+mtMCI6w26
	 +ldxuh6OdjDHDshTR5V4uhCyCvdfjsH8pvXHS1dPaho+1KC1hBtWw2WDdL6oW3G5Y9
	 Z4Bi1elf4bEFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34E95406CC;
	Sun,  4 Oct 2026 21:14:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 93E9E1A6
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6FCE640049
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:14:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nYxcby0_gZVn for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 21:14:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8DE8140004
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791148441;
 b=rzLO9B+F8qMBvVxT+Rq6dzgFTk04NQs4ndNzVu1qpIkhBL1h5KFqElb+XbJrQzdL9Dnb
 6mcOR4C2TJ083IBcmu1zSmRwTZ5eWFMc4E8JJXJ8o0viMN0NnWfcHu8NcKle+tWoabQtT
 CZEc3efLGGJLzrEYqkCaPPbQ8zdSZqB6cNW8T0JEwRet23S1eVqcya9MQezYr+3yzuRJQ
 VRDB+AQnO2ObezXzBHRD5fl96kdHYGRwvbqwQ3bI3RKqHj916ems/bRdo8orMGFa+VMOn
 83g5uIpHCqyDa4r52w446V0BDxJYpnpMwBOZ/CDzff7XAUG04gka1/da6BxIXVW8Wfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791148441;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=xN/WwBKsupAB8pshqgRidqIeSO6/E3IH1lXmSRFkwI4=;
 b=ZQWX/Hb5Fvvfs/9+hkQLAx+OFlwF9gOhWpw8+UdrTfzjzlpX+L6rivGAsymc1FOFzBoN
 AftXlQwjOZIYrwvaPVLhzanZO5sOpFS1EOSID/bjnNgIdlJRsw1mCY1Tvi9lN+aHZwIaH
 mGuzLtD1AtymfF7R3dISS1+iC1TUoykZP+Zn1UOrso83JP0w0E3pWnMr58FSzmSlYzk8B
 T5GBSvncrc0xxSqSsLzC3Gt/68VkBakNQ0QrIbDkb9bdezRNPbPkgKvZrXKoE7Q66RmP8
 OZMYH+4eG6Um2uB9zetevHlzqzFBFfZBxMvitMEgzlXfrMWffygLyESOo1A6NsCDELg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=ZdKtBa5G; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ZdKtBa5G
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8DE8140004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791148438; bh=xN/WwBKsupAB8pshqgRidqIeSO6/E3IH1lXmSRFkwI4=;
 b=ZdKtBa5GHqpAozHG2XLgNGdWEg0nlYvYvPvFXzO3ciZkiwfXOQ6I4a97Uml7gWF2dMdzCW6mj
 YaYg28inJf0KVTasOwruI0h4q2Y6BG3CusdAdoHEP0kEVC5dM+8WiloQMC6dxXzaiL2R6Mdpc4u
 DhEn4RrX6Uj1LAcpD0jd8jCJsfHACXmF/lQoEjgqnTephKcRkIRO+eXdc2L7hLyWTszUXPGtY3L
 EJPNx/TXAdxljbJtrW5B23A/guE0dIp7inKpSFUiUoplBJ15wX/jePrTZjzUnRXVc63c3xJ4qgo
 wN17EexjrQr7Q5j56DPoqiUmSDmkrbYGT/XyudUxUlLg==
X-Forward-Email-ID: 6ac2c195341e63db0e52ac7e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] rng: rockchip_rng: Enable clocks when reading data
Date: Sun,  4 Oct 2026 21:13:48 +0000
Message-ID: <20261004211349.62883-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004211349.62883-1-jonas@kwiboo.se>
References: <20261004211349.62883-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The vendor TF-A blobs for RK3562 leave the TRNG and RK RNG clocks gated
when returning to U-Boot proper.

Try to enable clocks while reading or otherwise accessing TRNG/RKRNG
regs to ensure random data can successfully be read on affected SoCs.

This is not expected to have any impact on SoCs using a clock driver
with unimplemented enable/disable ops.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/rng/rockchip_rng.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
index 178a76c09347..b674d270d8ac 100644
--- a/drivers/rng/rockchip_rng.c
+++ b/drivers/rng/rockchip_rng.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2020 Fuzhou Rockchip Electronics Co., Ltd
  */
 
+#include <clk.h>
 #include <dm.h>
 #include <rng.h>
 #include <asm/arch-rockchip/hardware.h>
@@ -103,6 +104,7 @@ struct rk_rng_soc_data {
 
 struct rk_rng_plat {
 	fdt_addr_t base;
+	struct clk_bulk clks;
 	struct rk_rng_soc_data *soc_data;
 };
 
@@ -296,7 +298,7 @@ static int rockchip_rng_read(struct udevice *dev, void *data, size_t len)
 {
 	unsigned char *buf = data;
 	unsigned int i;
-	int ret = -EIO;
+	int ret;
 
 	struct rk_rng_plat *pdata = dev_get_priv(dev);
 
@@ -306,6 +308,10 @@ static int rockchip_rng_read(struct udevice *dev, void *data, size_t len)
 	if (!pdata->soc_data || !pdata->soc_data->rk_rng_read)
 		return -EINVAL;
 
+	ret = clk_enable_bulk(&pdata->clks);
+	if (ret && ret != -ENOENT)
+		return ret;
+
 	for (i = 0; i < len / RK_HW_RNG_MAX; i++, buf += RK_HW_RNG_MAX) {
 		ret = pdata->soc_data->rk_rng_read(dev, buf, RK_HW_RNG_MAX);
 		if (ret)
@@ -317,6 +323,7 @@ static int rockchip_rng_read(struct udevice *dev, void *data, size_t len)
 						   len % RK_HW_RNG_MAX);
 
 exit:
+	clk_disable_bulk(&pdata->clks);
 	return ret;
 }
 
@@ -336,12 +343,22 @@ static int rockchip_rng_of_to_plat(struct udevice *dev)
 static int rockchip_rng_probe(struct udevice *dev)
 {
 	struct rk_rng_plat *pdata = dev_get_priv(dev);
-	int ret = 0;
+	int ret;
+
+	ret = clk_get_bulk(dev, &pdata->clks);
+	if (ret && ret != -ENOENT && ret != -ENOSYS)
+		return ret;
 
 	pdata->soc_data = (struct rk_rng_soc_data *)dev_get_driver_data(dev);
 
-	if (pdata->soc_data->rk_rng_init)
+	if (pdata->soc_data->rk_rng_init) {
+		ret = clk_enable_bulk(&pdata->clks);
+		if (ret && ret != -ENOENT)
+			return ret;
+
 		ret = pdata->soc_data->rk_rng_init(dev);
+		clk_disable_bulk(&pdata->clks);
+	}
 
 	return ret;
 }
-- 
2.55.0

