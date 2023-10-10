Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5ACCD690A
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 08:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F6C986D86;
	Tue, 10 Oct 2023 10:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NNMCTSYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A56D86DE4; Tue, 10 Oct 2023 10:52:59 +0200 (CEST)
Received: from mail-m155104.qiye.163.com (mail-m155104.qiye.163.com
 [101.71.155.104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF7B286D94
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 10:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhangqing@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=NNMCTSYPtGEEAPoIH5Elh+AThq7KE+uEQ8G1+ILPFNEHv48qeHRzzP1PDn1gcN/Ebuh9e1r6doa87//LSCFvz149ycZvZmdCnyXSf9kKuNzPyZDDpqYCMBaQQdnF8qktawprL9Z42gs8THjSczxqAKVpca5YA6io/yDtRpyWoIo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=jebnwOW59D+g7NczpRtohby7P3HgEpfVq0oSfCVY9ms=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id B97BF4003D8;
 Tue, 10 Oct 2023 16:52:09 +0800 (CST)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: lukma@denx.de, seanga2@gmail.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com,
 Guochun Huang <hero.huang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 4/7] clk: rk3588: Add 742.5M parameter for PLL
Date: Tue, 10 Oct 2023 16:51:52 +0800
Message-Id: <20231010085155.31027-5-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231010085155.31027-1-zhangqing@rock-chips.com>
References: <20231010085155.31027-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0wfGlZIQkpOSx4ZGB5DSkNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8b18c956672eb3kusnb97bf4003d8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjI6GDo4SDwyIhFKCRwQLyNP
 Qy4wCT9VSlVKTUJNQklMQkhLTUpJVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
 C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlLQ0g3Bg++
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

Change-Id: I5a842a3103df9a566789e7635fb484e4bb0bf427
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

