Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ECBCD690A
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 08:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8ED386DC3;
	Tue, 10 Oct 2023 10:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Bkx+rQGI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C409786DB4; Tue, 10 Oct 2023 10:52:54 +0200 (CEST)
Received: from mail-m49228.qiye.163.com (mail-m49228.qiye.163.com
 [45.254.49.228])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 697C586D86
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 10:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhangqing@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Bkx+rQGI8Hq4xjm25V7Z5SD4bP0HdWux9e/kAdTbKX5DX5JpwBMg3fFuvIXdQIXdtkDZBUrx2g9VJgD9YP/BUax4h06ZDO7iEKF1nCzzBMjR2wGDDCL2yvoQXtCzl4tjgj3fUeJzShXIVx1PTZfbhgtoIWPm3q+WywbkjLk/IdU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=WB6yo2+y2vIP0jFN3BGX3+tOl/FPOaItPEYeoeHJQOY=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id A34D540034F;
 Tue, 10 Oct 2023 16:52:10 +0800 (CST)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: lukma@denx.de, seanga2@gmail.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 5/7] clk: rockchip: rk3588: support aclk_top_root set 750M
Date: Tue, 10 Oct 2023 16:51:53 +0800
Message-Id: <20231010085155.31027-6-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231010085155.31027-1-zhangqing@rock-chips.com>
References: <20231010085155.31027-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk4eS1ZCGk0aS0xNGk4dTE9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8b18c959cf2eb3kusna34d540034f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OEk6Ixw6FTwrEBE4NxIvLykV
 PT8KCh1VSlVKTUJNQklMQkhKTk9IVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
 C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlJQ0w3Bg++
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

Change-Id: I78f00d37a645f37e28587d1c31f3179d5fa891e7
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk_rk3588.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index c86176264147..7ba037ad72ba 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -306,12 +306,18 @@ static ulong rk3588_top_set_clk(struct rk3588_clk_priv *priv,
 
 	switch (clk_id) {
 	case ACLK_TOP_ROOT:
-		src_clk_div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		if (!(priv->cpll_hz % rate)) {
+			src_clk = ACLK_TOP_ROOT_SRC_SEL_CPLL;
+			src_clk_div = DIV_ROUND_UP(priv->cpll_hz, rate);
+		} else {
+			src_clk = ACLK_TOP_ROOT_SRC_SEL_GPLL;
+			src_clk_div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		}
 		assert(src_clk_div - 1 <= 31);
 		rk_clrsetreg(&cru->clksel_con[8],
 			     ACLK_TOP_ROOT_DIV_MASK |
 			     ACLK_TOP_ROOT_SRC_SEL_MASK,
-			     (ACLK_TOP_ROOT_SRC_SEL_GPLL <<
+			     (src_clk <<
 			      ACLK_TOP_ROOT_SRC_SEL_SHIFT) |
 			     (src_clk_div - 1) << ACLK_TOP_ROOT_DIV_SHIFT);
 		break;
-- 
2.17.1

