Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A19C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5972E82145;
	Sun, 23 Mar 2025 17:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745737;
	bh=/Q8YUvOrmwjCJoLIY6ztYiC/z9DW8li7/zKs1j/crCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eDqt5cHoh/ysqCrqG41ZJ33mv7+o0J7qRpPAUxF/43S96ycR8qWirDyAyjwmJK1xG
	 0WJTybFNIqdbUh1LXjHI4VDy1rG/l6FtlJMBNkUNThVREgEQYRxaVghc9kdThK9PbI
	 Vj2CXcwgSJMztQB7/4/AFzBohiqnCM5UUaW4ZmdtcuSLt28FIleWO4lvs+4HXBQ+d4
	 EkLDSeJXXUBYnHNniyVPPQ0M9uwfUuCsUh9aGMewthJyDMvXVyzUjEUbY4zQmBtRnS
	 UgC9QCII+PGZf4W8XIT5cCDcmUrh28c68b6yE0e5EZcT0/C90Baon0CbNWaP18v8pn
	 OhCAbTyK+qCvg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CAF2820FE; Sun, 23 Mar 2025 17:02:14 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72926820B0
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="HQOsyjAD"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AE29810290252; Sun, 23 Mar 2025 17:02:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745730; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=/Q8YUvOrmwjCJoLIY6ztYiC/z9DW8li7/zKs1j/crCg=;
 b=HQOsyjADYdqKHn8WBUUQKHfriYzpBo8A+DoPLOsWT/a8jrhVqtM4K/kxGVnsygqVehcI+g
 f0yrL67UgQ3Wpvs9+p9Bf2KbTZIemiphAsGZMbqYAyDCoRYyftIHO/0o37KxDotb8F56eE
 5XF85x1IfmNNT9hmOFc8aDdURTBTUhFsYc8o62rPggRFmE2PKJkXzHjEz8xfAA4RMwTcmc
 qfulng3YOcOaz62vg8yCLuVIVZHj4Eu3eft2lmbiq0OpXb8NEqCSw2FqABUn9f5WUzITlb
 8uD+IOmtwOKe57ATLQmQaeganhr+bS7XAwfcnqlMtbGqfea5f/pmqPjfC/mGFg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 18/24] clk: imx: pllv3: Resolve parent clock by name
Date: Sun, 23 Mar 2025 16:58:47 +0100
Message-ID: <20250323160107.145749-19-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250323160107.145749-1-marex@denx.de>
References: <20250323160107.145749-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Use clock-names property which is accessible via parent clock OF node
to look up the parent clock by name instead of depending on unreliable
global clock name to perform look up.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
V2: Rebase on u-boot/next with additional clock patches
---
 drivers/clk/imx/clk-pllv3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index bc9916385c8..85b6a9809e8 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -339,7 +339,8 @@ struct clk *imx_clk_pllv3(struct udevice *dev, enum imx_pllv3_type type,
 	pll->div_mask = div_mask;
 	clk = &pll->clk;
 
-	ret = clk_register(clk, drv_name, name, parent_name);
+	ret = clk_register(clk, drv_name, name,
+			   clk_resolve_parent_clk(dev, parent_name));
 	if (ret) {
 		kfree(pll);
 		return ERR_PTR(ret);
-- 
2.47.2

