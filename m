Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6A5CD6E59
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE3C86CF3;
	Wed, 11 Oct 2023 12:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="cMIypelA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 021DE86D33; Wed, 11 Oct 2023 12:30:45 +0200 (CEST)
Received: from m177126.mail.qiye.163.com (m177126.mail.qiye.163.com
 [123.58.177.126])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A8EC86CF3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhangqing@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=cMIypelAykllArOZbGPKpVYu0Ep+UtHBOY0zIWBXQaVBv5Q1WohhYr1SjOn4uD6ME6LkCMrTWzy+fcw2VVkemw7NfyWYqFHGHJBw8Pyq3UDoPZAWzLrR3Y9joJz+cy0wvhDWgaNkSDQcjrfAjhfgrQAS/gYr0k7cTYUaae7JcGM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=+yUKYdghR28lv3bUo6/M4ERryaxATCdrAVh2J+sX98o=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m118115.qiye.163.com (Hmail) with ESMTPA id CC770AA041A;
 Wed, 11 Oct 2023 18:29:51 +0800 (CST)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: lukma@denx.de, seanga2@gmail.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com,
 Guochun Huang <hero.huang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 2/5] clk: rk3588: Add 742.5M parameter for PLL
Date: Wed, 11 Oct 2023 18:29:44 +0800
Message-Id: <20231011102947.21188-3-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231011102947.21188-1-zhangqing@rock-chips.com>
References: <20231011102947.21188-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkhDH1ZMQkkfGR8ZT0xMQx1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8b1e4925292ec3kusncc770aa041a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAg6OQw6DDw9SRYLTBgiFTkr
 SDUKCjpVSlVKTUJMS0lLSkJJTE9LVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
 C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlLTkM3Bg++
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

From: Guochun Huang <hero.huang@rock-chips.com>

For a specific frequency.

Signed-off-by: Guochun Huang <hero.huang@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk_rk3588.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 119b1337bdf2..c86176264147 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -36,6 +36,7 @@ static struct rockchip_pll_rate_table rk3588_pll_rates[] = {
 	RK3588_PLL_RATE(816000000, 2, 272, 2, 0),
 	RK3588_PLL_RATE(786432000, 2, 262, 2, 9437),
 	RK3588_PLL_RATE(786000000, 1, 131, 2, 0),
+	RK3588_PLL_RATE(742500000, 4, 495, 2, 0),
 	RK3588_PLL_RATE(722534400, 8, 963, 2, 24850),
 	RK3588_PLL_RATE(600000000, 2, 200, 2, 0),
 	RK3588_PLL_RATE(594000000, 2, 198, 2, 0),
-- 
2.17.1

