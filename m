Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B370C27C4F
	for <u-boot@archiver.kernel.org>; Sat, 15 Jun 2024 12:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E868A87ABC;
	Sat, 15 Jun 2024 14:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Yx9DbqDD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C097887CF1; Sat, 15 Jun 2024 14:12:01 +0200 (CEST)
Received: from mail-m12770.qiye.163.com (mail-m12770.qiye.163.com
 [115.236.127.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2B9187964
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 14:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Yx9DbqDDufBKkzojda3JBQdtKP9we1S9dwwmgqFIS+aBNUOrIpm5bKmoSoYB9K4c1M7K8IV4xVTqsueeYeaOvPMLn873dV59227yJUq3NsP8Vrvav7GXOEhznW/1jNDiAm+O4KPvPbAsYTgryktS4Hs1G4Z+9qiLiyEbHDjE5t0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=Cp+2WIGYXGOq/zD368ne15Fvgue10DmnlG/3jm0ywR8=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [59.56.82.162])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 799E99002BC;
 Sat, 15 Jun 2024 20:11:49 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20240614
Date: Sat, 15 Jun 2024 20:11:49 +0800
Message-Id: <20240615121149.2203028-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTBpOVkgdHx0YQ0seHU4fTlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQlVOTVVDSVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
 pCS0tZBg++
X-HM-Tid: 0a901bcf9db503a9kunm799e99002bc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pjo6LTo4KjNMGgktPU4wPjBC
 T0waCRBVSlVKTEpDT05ITktCQktOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQlVOTVVDSVVKTUlZV1kIAVlBSU9KQjcG
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
