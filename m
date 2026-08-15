Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9055C5DF6A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 03:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B1EB81350;
	Sat, 15 Aug 2026 03:42:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nRkLQCRbk8TN; Sat, 15 Aug 2026 03:42:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5AE4C8134D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786765331;
	bh=BedXlA4d6SgkkZAB/UHYMZWNIsYlUFsCIxggrvSKtks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qct/wewR2apaY33ESfwkoc0act9haWOnVqeCzUD2pF0NX5/V5nOrDcG7bfuRfA9eM
	 ozdr3ABq2LCFf/xMV0i/0CHrq5EXBCD2P/AqLOsUTJ2O2Daxrr5XAN9ZWIKCJyWBMP
	 GygeCfAz7jEyCK9euo0EvVx1fs5KMbQXofZ57/vB+LBZ6cHCyljrz5nG0MfPBl3lvj
	 5/8Q1yfh1Ni2RZoOoOoXdhUD3nslI1tK9c+27HrLRwuApwUh3zuMP4hJ8YiPrj9aZq
	 Dbpla9k2vaB5XvwLvZU1/JSvpV1IL3K3yAhIpxaKc75TML1HAUAsCuaR21XxB0mrot
	 mKn/BKrlG84hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AE4C8134D;
	Sat, 15 Aug 2026 03:42:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D10654CD
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0DB78134C
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 940RIYO2YLkh for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 03:42:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 249938134A
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 249938134A
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=J7yGFLrx
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 249938134A
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786765293; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MHphU3+57tYVJ5mfyFqIToVUKDMSPIaXcWJimpLIdnJyc0U8Z6jGW9rfuY27ew0wFNRsB3lpk5035/XZQUt37xAXf3yPBSlRU8k5ZuH/qxB+Dsp08nA4uibrP6pUCO+2CEUNt3lATKa9KcBsggacbmTUITFC/xtAPc3PGt1ldhA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786765293;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BedXlA4d6SgkkZAB/UHYMZWNIsYlUFsCIxggrvSKtks=; 
 b=XujDtT+IPD5w7rhtR5k+v+kExNrqswnOsXxbXcl7SFgVAN14MebvO5tNIy030S0MC7us8q5YW13LHe2D3q2VKTmSxHxJnmbfg8d/m2Nbk5QODaaywu0t7MslgdZ2fYvv/UGZLsj3Hqk+qAAfos0o4N6da1xEU2Ed49qEfi+S3Qo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786765293; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=BedXlA4d6SgkkZAB/UHYMZWNIsYlUFsCIxggrvSKtks=;
 b=J7yGFLrxYT+Cjr2ZwgYBVjFjxWAgw5dP2lTsSgLJHdztl+l0NSm9umpGWAJCXmib
 pzCTYIu8Upyg+Jk5FTaI4cIF5oTzKAsGObR2xDzUtB+mv23DG21bOrURrGJA4yBxTYR
 nGEYn9sCK5g5ED/bZQJlD1fVw3eW/kVVqCLMjXRA=
Received: by mx.zohomail.com with SMTPS id 1786765292115640.463971231211;
 Fri, 14 Aug 2026 20:41:32 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sat, 15 Aug 2026 11:40:21 +0800
Subject: [PATCH v2 1/4] i2c: k1: fix wrong bus speed setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-k1-i2c-fix-v2-1-7d2a48607233@pigmoral.tech>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
In-Reply-To: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
To: Heiko Schocher <hs@nabladev.com>, u-boot-spacemit@groups.io, 
 u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>, 
 Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=NCYnb7W9VXbs9OwlsZl2GTLHCwFOv9B3i6XrFpk12+Y=;
 b=kA0DAAoWY61lynhep/wByyZiAGp/39GiHOEEtgkFcRyt7PUfkJB0kkLUm6oekVuU4hiCGCUFa
 Yh1BAAWCgAdFiEECk8X/jssDPbEEIXfY61lynhep/wFAmp/39EACgkQY61lynhep/y9SgD/Ra2D
 SK2vMGqx+Tgl9NS8oIXS1OzAJbaOaVcEjTAmR4cA/jkKpana40Up25quJ0OtNzILqhNM3eSRJgj
 kVKfQxgkC
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
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

The controller bus mode should be selected according to the requested
I2C bus speed. However, the driver currently passes the functional clock
rate to k1_i2c_set_bus_speed(), so the selected mode does not reflect
the requested bus speed.

Fix this by reading the clock-frequency property from the Device Tree,
defaulting to standard speed, and drop the unused clk_rate field.

Fixes: 271546fb8e54 ("i2c: k1: add I2C driver support")
Reviewed-by: Heiko Schocher <hs@nabladev.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/i2c/k1_i2c.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/k1_i2c.c b/drivers/i2c/k1_i2c.c
index a08ff15803d0..2c7a1e0d3775 100644
--- a/drivers/i2c/k1_i2c.c
+++ b/drivers/i2c/k1_i2c.c
@@ -52,7 +52,6 @@ struct k1_i2c_priv {
 	int id;
 	void __iomem *base;
 	struct clk clk;
-	u32 clk_rate;
 };
 
 /*
@@ -466,6 +465,7 @@ static int k1_i2c_probe(struct udevice *bus)
 {
 	struct k1_i2c_priv *priv = dev_get_priv(bus);
 	struct reset_ctl reset;
+	u32 speed;
 	int ret;
 
 	priv->id = dev_seq(bus);
@@ -496,10 +496,13 @@ static int k1_i2c_probe(struct udevice *bus)
 		debug("%s: failed to enable clock\n", __func__);
 		return ret;
 	}
-	priv->clk_rate = clk_get_rate(&priv->clk);
 
 	priv->base = (void *)devfdt_get_addr_ptr(bus);
-	k1_i2c_set_bus_speed(bus, priv->clk_rate);
+
+	speed = dev_read_u32_default(bus, "clock-frequency",
+				     I2C_SPEED_STANDARD_RATE);
+	k1_i2c_set_bus_speed(bus, speed);
+
 	return 0;
 }
 

-- 
2.55.0

