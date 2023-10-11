Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D08CD6E5A
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1308586D9C;
	Wed, 11 Oct 2023 12:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OvRTPJKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 120C286D04; Wed, 11 Oct 2023 12:30:47 +0200 (CEST)
Received: from mail-m127209.xmail.ntesmail.com
 (mail-m127209.xmail.ntesmail.com [115.236.127.209])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6317386D17
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhangqing@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=OvRTPJKaNx2zns0BYxxXeFLqQl+EAJnWUAXrNABxOU9fpkngqp5W575tIHgIi6KwbPZF0vWjPs6nn0a8qJlt4vE7Tp/I5S7ncjsEZrpcbvvTWV6nZ+rXlHKSgElk4GQCvyHaIndo/U23VwOoqvsKf23L5atvlcopa2uPeqrTvQo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=3FhhIIvCkYbbItEppY1lgMDKt1TL0Bh86CWUG6y1sZE=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m118115.qiye.163.com (Hmail) with ESMTPA id C08B7AA041D;
 Wed, 11 Oct 2023 18:29:52 +0800 (CST)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: lukma@denx.de, seanga2@gmail.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 3/5] clk: rockchip: rk3588: support aclk_top_root set 750M
Date: Wed, 11 Oct 2023 18:29:45 +0800
Message-Id: <20231011102947.21188-4-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231011102947.21188-1-zhangqing@rock-chips.com>
References: <20231011102947.21188-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx5DHlYaT0tNHhlOQ0sdTUtVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8b1e4928b22ec3kusnc08b7aa041d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6Fio*Hjw8SRYNDxhMFT0j
 QiswCUNVSlVKTUJMS0lLSkJITkNPVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
 C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlJQk83Bg++
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

aclk_top_root choose a parent clock that does not change.

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

