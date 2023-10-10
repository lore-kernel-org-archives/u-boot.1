Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61617CD690B
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 08:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFCDE86DAF;
	Tue, 10 Oct 2023 10:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QubHSpM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2FEB86B1B; Tue, 10 Oct 2023 10:52:52 +0200 (CEST)
Received: from mail-m155116.qiye.163.com (mail-m155116.qiye.163.com
 [101.71.155.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA2B86489
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 10:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhangqing@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=QubHSpM+ptlWaXIKQvsybZmLl0/AEh18BQJTZSYjKwQIwkuyjZSgMdwLvxrjAhAwbtui+92o5lIH9p+tuvhqehSO8+hx6ipRFSCchFtwe8fwGADHyPqjJuonaTDnpq2bqP9NQUN8pfaGHXIUPXuqKPzNZGPRLspl+1oza5558OA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=WJktHfQcDPSXZ0RrFC9N31rg1Y276c/vaY86Ao5gZBs=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 18B1F4003E6;
 Tue, 10 Oct 2023 16:52:06 +0800 (CST)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: lukma@denx.de, seanga2@gmail.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 0/7]  clk : rockchip: update rk3568 and rk3588 clk driver
Date: Tue, 10 Oct 2023 16:51:48 +0800
Message-Id: <20231010085155.31027-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhgZTlZKS0hJSRlOGhgaHkpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8b18c948042eb3kusn18b1f4003e6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjY6TRw4Ejw3DBEpThwzLyEe
 MyMwCxZVSlVKTUJNQklMQklNQ01KVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
 C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpMS0g3Bg++
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

Elaine Zhang (5):
  rockchip: dts: rk3568: Resync from kernel-4.19
  clk: rockchip: rk3568: add i2s3 clk
  clk: rockchip: rk3568: support dclk_vop select more parent clks
  clk: rockchip: rk3588: support aclk_top_root set 750M
  clk: rockchip: rk3588: fix up the frac pll calculation

Guochun Huang (1):
  clk: rk3588: Add 742.5M parameter for PLL

Wyon Bi (1):
  clk: rockchip: rk3588: Avoid re-setting the pll rate of dclk_vop's
    parent

 .../include/asm/arch-rockchip/cru_rk3568.h    |  36 +++
 drivers/clk/rockchip/clk_pll.c                | 102 ++++++--
 drivers/clk/rockchip/clk_rk3568.c             | 228 +++++++++++++++++-
 drivers/clk/rockchip/clk_rk3588.c             |  35 ++-
 include/dt-bindings/clock/rk3568-cru.h        |   7 +
 5 files changed, 373 insertions(+), 35 deletions(-)

-- 
2.17.1

