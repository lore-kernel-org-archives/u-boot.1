Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B51AC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E23B88284;
	Fri, 31 May 2024 16:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B4RoYrRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 733A188284; Fri, 31 May 2024 16:11:39 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2C15881D3
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f480624d04so17964705ad.2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717164695; x=1717769495; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oLN6wLvrRcFEHZtTgivXfYTkK3piHxOoHVkvcthIHwE=;
 b=B4RoYrRnSBJhyytACGTtDZIsoRKIAcUjVFBZQ30hv0iFkwfKLh3FcE6DqYauZubatP
 qkbKT0eZesFKT4QarQ33sGb7RJNhd6sT+vpnTZeWp2yk7cxCYKjyr21mdoFjFpUeETw7
 oLH7kHsyt9casPw93Drvjwjmzm+BjuSyRDsS2Ou7DaoQgZqOjV5QSxdyCL5wd/ODNazP
 CEqYnxK9Sv0Cz0PyJ2Z6+CYHnmDXSK1Tl8Y/wbVZx5RbPlSMAGeNzNxR6nJ0CRf8i2pF
 jKPIZGmDBc2v1+B7WVgDnugq4jNoO6RIMSXmsninBz3hc22zmy4iP8a/f01rOws4d1yC
 WIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717164695; x=1717769495;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oLN6wLvrRcFEHZtTgivXfYTkK3piHxOoHVkvcthIHwE=;
 b=enYKovn2G32tpYtOb9+hEpAqRolHjCo2n7qQA1dLjxDJowFTB9aE4fS76FDO3LyYIp
 l9cGAjuiT99SCHl5dRkzXhK+NYqDzQwNVu6GPlCPssUfIYzk1TVMX/EjVEfbDRTsUjEO
 uTRd1CrrSyWnapmLNiwfSaN5tahM0HPjlkI+HBitFPkb9QF3WrPZ9Tgq7B4h01iwJsC9
 YIeKRd+tZlV5Zoj8tRyluFFsYaRFVsFB3r1UL1fIbsZwaMx2AeK3grH80bSgEO+CfGKe
 xi/NJ1XAaKok1F1F8Mgp/BsDSe70YxAspHsiQb5xEZ/Mj4DOfWyG7Hl6hs9OyK9J81dJ
 iF6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXde/LmP4SdZOHCMVXCRh5O/liVME+g19Mdmh8XhygpYBzVdJTqPk9RPxMrheqXPYA18g/+2v6KunSEpElDlBZ6FD6ksQ==
X-Gm-Message-State: AOJu0YxfHfmg1uQaMKQYgGjzG405UTXxmhBzADs+pI/oQNf0pBC+skOO
 73pLKyCefIP3UtQi1Q/OVwN/WxOpa010pxhn3O5HWhefVQUt6V/7
X-Google-Smtp-Source: AGHT+IGThbL31Rhg8n861Faqdh4mv6KklpbWf0+XJNBbi7zbY/LAga6T0E6nEtO4CVKhVkw1oSxkVQ==
X-Received: by 2002:a17:902:eb8c:b0:1f6:3215:3d16 with SMTP id
 d9443c01a7336-1f63701639emr17488195ad.26.1717164695127; 
 Fri, 31 May 2024 07:11:35 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63232dcf1sm16997765ad.53.2024.05.31.07.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:11:34 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 00/23]  Enable display cpuinfo to get the reset cause
Date: Fri, 31 May 2024 19:40:59 +0530
Message-ID: <20240531141122.13084-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
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

All the Rockchip SoC support reset cauee like POR_RST, GLB_RST,
TSADC_RST, WD_RST by reading the clock reset unit register.

V2: with the feedback from Jonas Karlman and Quentin Schulz
    drop the inply for CONFIG_DISPLAY_CPUINFO as it defaault enabled.
    re-organized the code.

As pointed only as of now RK3328, RK3399 supports this feature for POR
and RST.

On RK3568 and RK3588 SoC it only return POR, for all the case of reboot 
and poweroff. I have tried to debug this issue, found Clock Reset Unit 
will bind to rockchip_sysreset to determine the reset cause.
if there is ant input on this please share.

I have update two new patches from u-boot-radxa, but with no success.

[0] https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/drivers/clk/rockchip/clk_rk3568.c#L2945

# dm tree # RK3568
 clk           5  [ + ]   rockchip_rk3588_cru   |-- clock-controller@fd7c0000
 sysreset      0  [   ]   rockchip_sysreset     |   |-- sysreset
 reset         0  [ + ]   rockchip_reset        |   `-- reset

[1] https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/drivers/clk/rockchip/clk_rk3588.c#L2006

# dm tree  # RK3588
 clk           5  [ + ]   rockchip_rk3588_cru   |-- clock-controller@fd7c0000
 sysreset      0  [   ]   rockchip_sysreset     |   |-- sysreset
 reset         0  [   ]   rockchip_reset        |   `-- reset


Tested on Rock64, Rock-3a, Rock-5b boards.

I have update few Rockchip SoC to verify this feature,
Only Build to since I dont have the hardware.

Thanks
-Anand

Anand Moon (21):
  rockchip: RK3328: Read the reset cause from clock reset unit for
    RK3328 SoC
  rockchip: RK3328: Enable display cpuinfo support on all boards
  rockchip: RK3399: Read the reset cause from clock reset unit for
    RK3399 SoC
  rockchip: RK3399: Enable display cpuinfo support on all boards
  arm: rockchip: Enable display cpuinfo to be build with SPL_BUILD
  rockchip: RK3568: Read the reset cause from clock reset unit for
    RK356x SoC
  rockchip: RK3568: Enable display cpuinfo support on all boards
  rockchip: RK3588: Read the reset cause from clock reset unit for
    RK3588 SoC
  rockchip: RK3588: Enable display cpuinfo support on all boards
  rockchip: PX30: Read the reset cause from clock reset unit for PX30
    SoC
  rockchip: PX30: Enable display cpuinfo support on all boards
  rockchip: RK3288: Read the reset cause from clock reset unit for
    RK3288 SoC
  rockchip: RK3288: Enable display cpuinfo support on all boards
  rockchip: RK3308: Read the reset cause from clock reset unit for
    RK3308 SoC
  rockchip: RK3308: Enable display cpuinfo support on all boards
  rockchip: RK3368: Read the reset cause from clock reset unit for
    RK3368 SoC
  rockchip: RK3368: Enable display cpuinfo support on all boards
  rockchip: RV1108: Read the reset cause from clock reset unit for
    RV1108 SoC
  rockchip: RV1108: Enable display cpuinfo support on all boards
  rockchip: RV1126: Read the reset cause from clock reset unit for
    RV1126 SoC
  rockchip: RV1126: Enable display cpuinfo support on all boards

Andy Yan (1):
  sysreset: rockchip: use dev_read_addr_ptr get cru base

Kever Yang (1):
  sysreset: rockchip: use fst reset for ARM64 SOC

 arch/arm/include/asm/arch-rockchip/cru.h      | 14 +++++++++++++
 arch/arm/mach-rockchip/Makefile               |  3 ---
 arch/arm/mach-rockchip/cpu-info.c             | 20 +++++++++++++++++++
 configs/anbernic-rgxx3-rk3566_defconfig       |  1 -
 configs/bpi-r2-pro-rk3568_defconfig           |  1 -
 configs/chromebit_mickey_defconfig            |  1 -
 configs/chromebook_bob_defconfig              |  1 -
 configs/chromebook_jerry_defconfig            |  1 -
 configs/chromebook_kevin_defconfig            |  1 -
 configs/chromebook_minnie_defconfig           |  1 -
 configs/chromebook_speedy_defconfig           |  1 -
 configs/coolpi-4b-rk3588s_defconfig           |  1 -
 configs/coolpi-cm5-evb-rk3588_defconfig       |  1 -
 configs/elgin-rv1108_defconfig                |  1 -
 configs/evb-px30_defconfig                    |  1 -
 configs/evb-px5_defconfig                     |  1 -
 configs/evb-rk3308_defconfig                  |  1 -
 configs/evb-rk3328_defconfig                  |  1 -
 configs/evb-rk3568_defconfig                  |  1 -
 configs/evb-rk3588_defconfig                  |  1 -
 configs/evb-rv1108_defconfig                  |  1 -
 configs/firefly-px30_defconfig                |  1 -
 configs/geekbox_defconfig                     |  1 -
 configs/generic-rk3568_defconfig              |  1 -
 configs/generic-rk3588_defconfig              |  1 -
 configs/jaguar-rk3588_defconfig               |  1 -
 configs/lion-rk3368_defconfig                 |  1 -
 configs/lubancat-2-rk3568_defconfig           |  1 -
 configs/nanopc-t6-rk3588_defconfig            |  1 -
 configs/nanopi-r2c-plus-rk3328_defconfig      |  1 -
 configs/nanopi-r2c-rk3328_defconfig           |  1 -
 configs/nanopi-r2s-rk3328_defconfig           |  1 -
 configs/nanopi-r5c-rk3568_defconfig           |  1 -
 configs/nanopi-r5s-rk3568_defconfig           |  1 -
 configs/neu2-io-rv1126_defconfig              |  1 -
 configs/neu6a-io-rk3588_defconfig             |  1 -
 configs/neu6b-io-rk3588_defconfig             |  1 -
 configs/odroid-m1-rk3568_defconfig            |  1 -
 configs/orangepi-5-plus-rk3588_defconfig      |  1 -
 configs/orangepi-5-rk3588s_defconfig          |  1 -
 configs/orangepi-r1-plus-lts-rk3328_defconfig |  1 -
 configs/orangepi-r1-plus-rk3328_defconfig     |  1 -
 configs/pinetab2-rk3566_defconfig             |  1 -
 configs/px30-core-ctouch2-of10-px30_defconfig |  1 -
 configs/px30-core-ctouch2-px30_defconfig      |  1 -
 configs/px30-core-edimm2.2-px30_defconfig     |  1 -
 configs/quartz64-a-rk3566_defconfig           |  1 -
 configs/quartz64-b-rk3566_defconfig           |  1 -
 configs/quartzpro64-rk3588_defconfig          |  1 -
 configs/radxa-cm3-io-rk3566_defconfig         |  1 -
 configs/radxa-e25-rk3568_defconfig            |  1 -
 configs/ringneck-px30_defconfig               |  1 -
 configs/roc-cc-rk3308_defconfig               |  1 -
 configs/roc-cc-rk3328_defconfig               |  1 -
 configs/rock-3a-rk3568_defconfig              |  1 -
 configs/rock-pi-e-rk3328_defconfig            |  1 -
 configs/rock-pi-s-rk3308_defconfig            |  1 -
 configs/rock5a-rk3588s_defconfig              |  1 -
 configs/rock5b-rk3588_defconfig               |  1 -
 configs/rock64-rk3328_defconfig               |  1 -
 configs/sheep-rk3368_defconfig                |  1 -
 configs/sonoff-ihost-rv1126_defconfig         |  1 -
 configs/soquartz-blade-rk3566_defconfig       |  1 -
 configs/soquartz-cm4-rk3566_defconfig         |  1 -
 configs/soquartz-model-a-rk3566_defconfig     |  1 -
 configs/toybrick-rk3588_defconfig             |  1 -
 configs/turing-rk1-rk3588_defconfig           |  1 -
 drivers/sysreset/sysreset_rockchip.c          |  9 +++++++--
 68 files changed, 41 insertions(+), 69 deletions(-)

-- 
2.44.0

