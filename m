Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310BEC3DA60
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 03:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F79B88481;
	Thu, 18 Jul 2024 05:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="cXe0sP7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE7C884CA; Thu, 18 Jul 2024 05:52:10 +0200 (CEST)
Received: from mail-m1282.netease.com (mail-m1282.netease.com [103.209.128.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8672C88481
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 05:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=cXe0sP7JyF8szggv3O10x0OeC/Krr5S6WXjSKSy8Nvy9Vp61SYOuu731WKpCqGEmg6uOaK2RFCsx7KyS0yRPGNCgpB487CBXX71w/rycHd279Bm48WS4ma0dSyNpKWuLD358q+54oC3JethMz3BmyBnFwuvIX2CGJfjCGBwv9aI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Cp+2WIGYXGOq/zD368ne15Fvgue10DmnlG/3jm0ywR8=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id BAFB990027C;
 Thu, 18 Jul 2024 11:52:00 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20240614
Date: Thu, 18 Jul 2024 11:52:00 +0800
Message-Id: <20240718035200.394004-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUoeTVZCT0lJGk5LS0NCHxhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90c3f7e25c03a9kunmbafb990027c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBQ6GBw*VjI1DBcITRFWMzEB
 KBVPFDdVSlVKTElKSUxPTElKSEpLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0pMNwY+
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

Hi Tom,

Please pull the fixex for rockchip platform:
- pmic fix for rk8xx;
- pinctrl fix for rk3188/rv1126/rk3588;
- mkimage fix for rockcihp "-l" option;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/21111

Thanks,
- Kever

The following changes since commit ca6a992e09441d6cca73439c63c3735f86b36ea4:

  cmd: sound: fix help text (2024-06-13 09:31:56 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20240614

for you to fetch changes up to 3f9a19befe9277db2a337552912c6ddbcc0c8b10:

  rockchip: mkimage: fix mkimage -l for header v1 (2024-06-14 17:07:59 +0800)

----------------------------------------------------------------
Chris Morgan (2):
      Revert "board: rockchip: Add early ADC button detect for RGxx3"
      board: rockchip: rgxx3: Use sdmmc0 as first device

Jonas Karlman (3):
      pinctrl: rockchip: rk3188: Fix support for IOMUX_GPIO_ONLY flag
      pinctrl: rockchip: rv1126: Fix support for IOMUX_L_SOURCE_PMU flag
      pinctrl: rockchip: rk3588: Fix support for rockchip_get_mux()

Quentin Schulz (4):
      regulator: rk8xx: fix incorrect device used for _ldo_[sg]et_suspend_value
      regulator: rk8xx: pass pmic udevice instead of regulator to all internal functions
      regulator: rk8xx: clarify operator precedence
      rockchip: mkimage: fix mkimage -l for header v1

 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi   |  2 +-
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c       | 64 ------------------------
 drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 40 ++++++++++++---
 drivers/power/regulator/rk8xx.c                  | 54 ++++++++++----------
 tools/rkcommon.c                                 |  2 +-
 5 files changed, 63 insertions(+), 99 deletions(-)
