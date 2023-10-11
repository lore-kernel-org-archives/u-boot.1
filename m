Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CA6CD6E59
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47E0886D17;
	Wed, 11 Oct 2023 12:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Oy1qdITV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1260B86D05; Wed, 11 Oct 2023 12:30:46 +0200 (CEST)
Received: from mail-m127107.qiye.163.com (mail-m127107.qiye.163.com
 [115.236.127.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53CD686D07
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhangqing@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Oy1qdITVgOykZ+B3xUvLg+jp/gYKPUZWLScOO+xM1sb8/uTPbZoCr1syKzwjubpOtCPja6rJ2m3AuBDDHb9J/UnyvO2SyvA9UHtJZW2g0sKaRf2JR8gmzHE1CYQIBR5WhfO07nKJixvrq/JkKTigniCuUg5msrp6D/kbYAhUNeU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=+Qxxjth0tTNUPEKQ6+VrIRgL53lLoGqnqppV+PKVK8g=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m118115.qiye.163.com (Hmail) with ESMTPA id 29BC1AA02CC;
 Wed, 11 Oct 2023 18:29:50 +0800 (CST)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: lukma@denx.de, seanga2@gmail.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 0/5]  clk : rockchip: update rk3568 and rk3588 clk driver
Date: Wed, 11 Oct 2023 18:29:42 +0800
Message-Id: <20231011102947.21188-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkJCT1ZCGEkaQksdQx9OSR5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8b1e491e9e2ec3kusn29bc1aa02cc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mio6DQw*PTw3SRYXTB5LFTYz
 DzRPClFVSlVKTUJMS0lLSkJLQkxNVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
 C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpNS083Bg++
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

Change in V2:
drop [PATCH v1 1/7] and [PATCH v1 2/7], upstream kernel first.
update commit message and remove change id.

Elaine Zhang (3):
  clk: rockchip: rk3568: support dclk_vop select more parent clks
  clk: rockchip: rk3588: support aclk_top_root set 750M
  clk: rockchip: rk3588: fix up the frac pll calculation

Guochun Huang (1):
  clk: rk3588: Add 742.5M parameter for PLL

Wyon Bi (1):
  clk: rockchip: rk3588: Avoid re-setting the pll rate of dclk_vop's
    parent

 drivers/clk/rockchip/clk_pll.c    | 102 +++++++++++++++++++++++-------
 drivers/clk/rockchip/clk_rk3568.c |  10 ++-
 drivers/clk/rockchip/clk_rk3588.c |  35 +++++++---
 3 files changed, 112 insertions(+), 35 deletions(-)

-- 
2.17.1

