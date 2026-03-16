Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EE7F46442
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 09:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9122783FF5;
	Mon, 16 Mar 2026 10:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="HcruFaFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3013583FF9; Mon, 16 Mar 2026 10:51:41 +0100 (CET)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [72.51.58.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E0983FEE
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 10:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding; 
 bh=kd+m3374QR57KfT33Hgl01WtWm8adfZVRGVnQFuTWng=;
 b=HcruFaFbxULiZwnmJ1eEKQRUwMno1HicD42ELkalxjX6Iqy03jZI3uAHIUc7WBwaOEjMSh2Y8DJd1970KJU/9rS7vjLx23Nypq88NnYngSEQBTg0Tugo1K2tN0L7Xy3DVdDU3YABS/h8lMNNYs+K0eg6DD0Nu0w9FI0ZEc525ete0ZRHOeUvDEHs4fHTGNlmZ8YNhT/Fe1ICb9J3NxB6B9B6M0Z93CLIld3RQGnb1UGJ8OZR7ZOUfGjM4c
 C7a2bz67qRGuQHLGS+I6Ia0ZGmRqjnII0KjxSKL0nDV8NKqlDhM+e8uvgAIMPFW0U9/WRgwQVIyuRZNtObdMRYxd5Y8Q==
Received: from TkB (188-24-192-137.rdsnet.ro [188.24.192.137])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Mon, 16 Mar 2026 09:51:30 +0000
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: u-boot@lists.denx.de
Cc: Marius Dinu <m95d+git@psihoexpert.ro>
Subject: [PATCH] clk: rk3288: add stub for ops->enable
Date: Mon, 16 Mar 2026 11:57:09 +0200
Message-ID: <20260316095709.2701-1-m95d+git@psihoexpert.ro>
X-Mailer: git-send-email 2.52.0
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

This fixes a bug where the watchdog can't enable the clock.
AFAIK, this clock is always enabled.

Tested on Asus TinkerBoard. Test results:
wdt dev         => works
wdt start 200   => works, but timeout is 43s
wdt start 10000 => works, but timeout is 1m27s
wdt reset       => works
wdt stop        => doesn't work

Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
---
 drivers/clk/rockchip/clk_rk3288.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
index a4ff1c41abb..9cc883662ff 100644
--- a/drivers/clk/rockchip/clk_rk3288.c
+++ b/drivers/clk/rockchip/clk_rk3288.c
@@ -745,6 +745,10 @@ static ulong rockchip_saradc_set_clk(struct rockchip_cru *cru, uint hz)
 	return rockchip_saradc_get_clk(cru);
 }
 
+static int rk3288_clk_enable(struct clk *clk){
+	return 0;
+}
+
 static ulong rk3288_clk_get_rate(struct clk *clk)
 {
 	struct rk3288_clk_priv *priv = dev_get_priv(clk->dev);
@@ -947,6 +951,7 @@ static int __maybe_unused rk3288_clk_set_parent(struct clk *clk, struct clk *par
 }
 
 static struct clk_ops rk3288_clk_ops = {
+	.enable		= rk3288_clk_enable,
 	.get_rate	= rk3288_clk_get_rate,
 	.set_rate	= rk3288_clk_set_rate,
 #if CONFIG_IS_ENABLED(OF_REAL)
-- 
2.52.0


