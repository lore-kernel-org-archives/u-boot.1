Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2F6C07E97
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 01:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A0A87496;
	Sat,  2 Dec 2023 02:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701481720;
	bh=Lh91U0vCMN2upzHQJgiayfEL9cUm4LHK0HW6xoWC4fs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DT4O7hRWowwTGTVaSaqa6lephsY+5Dbl+gSxhZvqS+rQ9NwUTR2zCooMGxD3yMSnk
	 lAu/AjE1GhUpBZtPmJ3ul9dKYugC6HV5fPU5gTeSFm9OCTI9yxs9P1Jrqu+RJ7ZCR8
	 RDG+GQbvsFcJcwrOoY33qzMbI/YInEEn8lpOPz5tJ6dU14UCnFBWDNMihwkdVcWu0c
	 UkXkIn+XoLzgFIqXKe38OH/knv5UYVWJ/pW0bpSB8RvUuI7jTIpztYU06kOhQW2M6Q
	 V6+egSVZxE7oBaA6AnwhoHBQytd+i0WuzkHzoZ9IDjm8L8D5K7/BhlZn0NY7wSR0/U
	 zfMOtlRGO36ZA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 258E487076;
 Sat,  2 Dec 2023 02:48:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1701481718;
 bh=Lh91U0vCMN2upzHQJgiayfEL9cUm4LHK0HW6xoWC4fs=;
 h=From:To:Cc:Subject:Date:From;
 b=y2JMCK9DXvO0ygQ4di1s59/Fi5WOpE0jJtBSUC061FNIdtq0J8Qi9nGwa7HVIrtxL
 iCo29+FM5YJT3pJ4LM4zE6XcaP3btG9ZoVtObWaClYBye5e0lrWw5Lr1DAE7j7DA83
 AEBjUZGiHeq+9dDHHjjkpg7crEYV+kIl9hl31cYvn0XiOFQ+Jf6iaeaykrJu0LWoAP
 KT7/3KSWq9VpnoCm+1au/rSgm4AIfRi7mIM+eItEJf7QxfEOeRhxW83QCZslZwR3ze
 4bh+5R1XczpAfb/fmaK/fGrIEhMuLRYHmQx6Bs+GmtqseTV/KAXhPPLErQG6PELjXY
 UNy7IE1nic0MA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefano Babic <sbabic@denx.de>, Ye Li <ye.li@nxp.com>
Subject: [PATCH] ddr: imx: Handle 3734 in addition to 3733 and 3732 MTps rates
Date: Sat,  2 Dec 2023 02:48:00 +0100
Message-ID: <20231202014826.212858-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

The new MX8M DDR tool 3.31 now generates a programming file which uses
data rate 3734 instead of 3733 or 3732 . Handle another rounding option .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jacky Bai <ping.bai@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 drivers/ddr/imx/phy/ddrphy_utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ddr/imx/phy/ddrphy_utils.c b/drivers/ddr/imx/phy/ddrphy_utils.c
index fd8b4113b7b..d5dac0fce92 100644
--- a/drivers/ddr/imx/phy/ddrphy_utils.c
+++ b/drivers/ddr/imx/phy/ddrphy_utils.c
@@ -111,6 +111,7 @@ void ddrphy_init_set_dfi_clk(unsigned int drate)
 		dram_pll_init(MHZ(1000));
 		dram_disable_bypass();
 		break;
+	case 3734:
 	case 3733:
 	case 3732:
 		dram_pll_init(MHZ(933));
-- 
2.42.0

