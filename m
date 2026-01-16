Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DA2C982C3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 22:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49DB08367F;
	Fri, 16 Jan 2026 23:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fPdNB0Iy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7B73836AC; Fri, 16 Jan 2026 23:10:00 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9B838309A
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 23:09:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b87677a8a96so43582566b.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 14:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768601398; x=1769206198; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LxGajCYLCyHirHc6ptQymByCc3HXpQlDaJLTxrlHb+k=;
 b=fPdNB0IyfHEtfgnkh8vqwem60GNzfhbjMcJG4C5Pe3tr8+Mtp9rCtqI56T5xW8sl3h
 GAr5r+0c7+X5mKcvAs4ueVxb/Byn9FVjdpzT0W9vwJYdtcsEG68ky2wO6dtBaW9BeOGM
 RRmf+wZY9hSKPHUnKsWIUkqGLl8z4QCFWtcZBrshiAmdxdQxYJpCN1/pgvoJHWbvytiR
 mPnTIeCEoDuBqfZiqzJx6PClRlli2cc6SyltZsfWrtmiX4puO3u0fUcSFzdmZ2xKBDhK
 n584f6dRB+bKWzWm0CGFUIsjnBXmD0z0oeTgm+oNuXb0hhHZGJdOF7g/AWCbZ8/CcYgg
 HIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768601398; x=1769206198;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LxGajCYLCyHirHc6ptQymByCc3HXpQlDaJLTxrlHb+k=;
 b=TN8O1kVfhZF31M9/2xaihEwTI9mxCeTFZsNiIRv8fY47C5smPOp22CDArE6ha7T5PM
 LZSEWht/ULQbQTtvdqjobmj2dMwDV1aZpTgpF5N9xk0yGx+W6xqTFx/2Yt5gToEGbeda
 Tqr6Yr5Y2OPo+DRvlPqZrwC3aM83ez2eww3O4UbnWkmbfZqrwlupwdhn8ljUPA9lQBP7
 2oCLh7CZl2MEuO+4s7GLZgmuIcNLXCBpb8NvoqUBaSwEpkZ+4zPf813z3x+h3oItphgi
 /nMHgBCPZQUNXsOzRYG2tCP/U757+LSICvWLFnLEpPCzRSv3gf8s+KbWeKHfh0UO+Slh
 wGHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNpuA1I+thmvQBfK72Sn31fsLRHTf5Ibz/1tmLz42xOJFYt/H13kfS7x0XTKX6A9ogodEjf5U=@lists.denx.de
X-Gm-Message-State: AOJu0Yxo3mhPiaNPt22qc3eeqs1jKi1d1AG621b3r6FRtCGhGipn0p+m
 s/nmRUOsz1r0KeJSSfcSrbdCtbeaf0jt+9HQdEKvTRQ4eqKXfnkwej0v
X-Gm-Gg: AY/fxX5q9MxogOm+a3DOSsqvAAqvHJt+Bvub9GG2+iZotc3Ux0dvtFmPjkFwBiSOCtM
 WPUUN3mN1xFs+7NOIbhEERSQ/s0BxLlro2SSxRLt5gPU998FshWgPv3W9GgeMoLDIRYacPTOTWE
 ci9fG+XXbN2S17PD/H27Oe3OiPbSgk9A1STNb85ezf0uySUEcpmyqIAQP2pvAK4CLEIix9u7YO2
 Gtu3IDHvAtf/JzefYn/TW1DDKKTJ/KZ0coxiEBpGYHOACa6LgU2haYCkxnXRbjRnQ+OWj5KwxCu
 DY8tPm/r4Q3AIVfUM4HcI4tcn59zcUKwqqOF5Mlv9DkFUqelkpHViyP2S+08yL8qGLuMSSnH0p8
 M7boDbsM6Rm/7FtMTF6Oaoy3x05KbSwR3kpr1ytspJUdtgIhU9hrHv9zwEXQTNp0X1I+Jm/ivsP
 QmVSq8TBRDrsikHPXpglqvOnB+FcYCeypyqK2O6oFTNriQOBki6zoknH01jI4X
X-Received: by 2002:a17:906:fd8a:b0:b87:6c1e:a008 with SMTP id
 a640c23a62f3a-b8793275d45mr216513866b.7.1768601398158; 
 Fri, 16 Jan 2026 14:09:58 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879513e9dcsm354692866b.6.2026.01.16.14.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 14:09:57 -0800 (PST)
Message-ID: <a6eba53c-a2db-44fc-9785-d817dbb4ef11@gmail.com>
Date: Fri, 16 Jan 2026 23:09:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 0/6] rockchip: use OF_UPSTREAM for rk3288
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The device tree for rk3288 combined is now
available in the /dts/upstream directory.
Use imply OF_UPSTREAM to migrate all rk3288 boards.
Clean up MAINTAINERS.

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Changed V3:
Makefile
MAINTAINERS

Changed V2:
Rebase
Moved upstream changes to separate patches
Split in smaller pieces

Johan Jonker (6):
  ARM: dts: rockchip: Remove mshc aliases from RK3288
  ARM: dts: rockchip: Add spi_flash label to rk3288-veyron
  ARM: dts: rockchip: move edp assigned-clocks to edp node on rk3288
  rockchip: Switch rk3288-veyron boards to upstream devicetree
  rockchip: Switch remaining rk3288 boards to upstream devicetree
  rockchip: imply OF_UPSTREAM for rk3288 boards

 arch/arm/dts/Makefile                         |  11 -
 arch/arm/dts/cros-ec-sbs.dtsi                 |  52 --
 ...boot.dtsi => rk3288-evb-rk808-u-boot.dtsi} |   0
 arch/arm/dts/rk3288-evb.dts                   |  20 -
 arch/arm/dts/rk3288-evb.dtsi                  | 476 -----------
 arch/arm/dts/rk3288-popmetal.dts              |  20 -
 arch/arm/dts/rk3288-popmetal.dtsi             | 547 ------------
 arch/arm/dts/rk3288-rock-pi-n8.dts            |  17 -
 arch/arm/dts/rk3288-rock2-som.dtsi            | 278 ------
 arch/arm/dts/rk3288-rock2-square.dts          | 181 ----
 arch/arm/dts/rk3288-veyron-chromebook.dtsi    | 205 -----
 arch/arm/dts/rk3288-veyron-jerry.dts          | 208 -----
 arch/arm/dts/rk3288-veyron-mickey.dts         | 266 ------
 arch/arm/dts/rk3288-veyron-minnie.dts         | 302 -------
 arch/arm/dts/rk3288-veyron-speedy.dts         | 143 ----
 arch/arm/dts/rk3288-veyron.dtsi               | 795 ------------------
 arch/arm/dts/rk3288-vmarc-som.dtsi            | 361 --------
 arch/arm/dts/rk3288-vyasa.dts                 | 473 -----------
 .../dts/rockchip-radxa-dalang-carrier.dtsi    | 137 ---
 arch/arm/mach-rockchip/Kconfig                |   1 +
 board/amarula/vyasa-rk3288/MAINTAINERS        |   1 -
 board/chipspark/popmetal_rk3288/MAINTAINERS   |   1 -
 board/google/veyron/MAINTAINERS               |  10 +-
 board/rockchip/evb_rk3288/MAINTAINERS         |   6 +-
 configs/chromebit_mickey_defconfig            |   4 +-
 configs/chromebook_jerry_defconfig            |   4 +-
 configs/chromebook_minnie_defconfig           |   4 +-
 configs/chromebook_speedy_defconfig           |   4 +-
 ...8_defconfig => evb-rk3288-rk808_defconfig} |   4 +-
 configs/firefly-rk3288_defconfig              |   1 -
 configs/miqi-rk3288_defconfig                 |   1 -
 configs/phycore-rk3288_defconfig              |   3 +-
 configs/popmetal-rk3288_defconfig             |   4 +-
 configs/rock-pi-n8-rk3288_defconfig           |   2 +-
 configs/rock2_defconfig                       |   4 +-
 configs/tinker-rk3288_defconfig               |   1 -
 configs/tinker-s-rk3288_defconfig             |   1 -
 configs/vyasa-rk3288_defconfig                |   4 +-
 doc/board/rockchip/rockchip.rst               |   8 +-
 .../src/arm/rockchip/rk3288-veyron.dtsi       |   2 +-
 dts/upstream/src/arm/rockchip/rk3288.dtsi     |   9 +-
 41 files changed, 30 insertions(+), 4541 deletions(-)
 delete mode 100644 arch/arm/dts/cros-ec-sbs.dtsi
 rename arch/arm/dts/{rk3288-evb-u-boot.dtsi => rk3288-evb-rk808-u-boot.dtsi} (100%)
 delete mode 100644 arch/arm/dts/rk3288-evb.dts
 delete mode 100644 arch/arm/dts/rk3288-evb.dtsi
 delete mode 100644 arch/arm/dts/rk3288-popmetal.dts
 delete mode 100644 arch/arm/dts/rk3288-popmetal.dtsi
 delete mode 100644 arch/arm/dts/rk3288-rock-pi-n8.dts
 delete mode 100644 arch/arm/dts/rk3288-rock2-som.dtsi
 delete mode 100644 arch/arm/dts/rk3288-rock2-square.dts
 delete mode 100644 arch/arm/dts/rk3288-veyron-chromebook.dtsi
 delete mode 100644 arch/arm/dts/rk3288-veyron-jerry.dts
 delete mode 100644 arch/arm/dts/rk3288-veyron-mickey.dts
 delete mode 100644 arch/arm/dts/rk3288-veyron-minnie.dts
 delete mode 100644 arch/arm/dts/rk3288-veyron-speedy.dts
 delete mode 100644 arch/arm/dts/rk3288-veyron.dtsi
 delete mode 100644 arch/arm/dts/rk3288-vmarc-som.dtsi
 delete mode 100644 arch/arm/dts/rk3288-vyasa.dts
 delete mode 100644 arch/arm/dts/rockchip-radxa-dalang-carrier.dtsi
 rename configs/{evb-rk3288_defconfig => evb-rk3288-rk808_defconfig} (95%)

--
2.39.5

