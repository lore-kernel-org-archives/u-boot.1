Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE7ED2502D
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 16:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8471B83A79;
	Sun, 11 Jan 2026 17:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hububdWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5400B83A9F; Sun, 11 Jan 2026 17:27:08 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C46D83A41
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 17:27:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64b6f896689so784482a12.0
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 08:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768148826; x=1768753626; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A24M7YXQp0BQJTfIni21Xyl/MzADXxbWMDcUdnI5dd4=;
 b=hububdWiD0sk2HR9raPtFWNlYHh2rbtCWGPkCxQviIGRg3li0Nc1V2XOIiSeKx76ux
 XR4n+cm+fxcYRd8ST8yMrxoUzlT1tpKzbrwnYDiieW9z6l08P/V9EjJlUtJ8vFygE/rD
 o9h2HiyxDCOMUPKgfKwbnNKxsMk5hNzcHbUNRTWM86SaV316/r2IkKXxQpiPlO0W1GFM
 RWMv7ZthMJMhTg1k+AjYzz/rEIwp5xjlYz/mWcmuZ5oiOpPT5OwfZYoScuHaD3EGLMdu
 vDS1XWC/o9Cek8CPNcPyjtcevpftrHYHz77DQGsmg7f8rp/JZJUEKt7rkB2ZYQxnkdl7
 2+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768148826; x=1768753626;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A24M7YXQp0BQJTfIni21Xyl/MzADXxbWMDcUdnI5dd4=;
 b=fQCTUvYHQSMaIvtM8Q9bG5nd5jKxMqHYFExQlIQM+FbK2hyq4kPTMiwDM8+L6XdPd+
 2jGWVgj7xYSjNU7Tm/9fgS2m/0KnQpvpbGPEsGe3n0XZTgjNAYx0Rtfzqa4yCqKtEMNg
 VQAkXQljxsAg2Cm/96J0YFZl4WuTPgW+U7o+9Zuxbsfcg0A2ucruDPwuI4j1LKfCLH8x
 AYt+NgmJl7NT9JkV6+KKkrGpy0MKxbtcJu7cNtSzpal5L39IZbeWDHfJJTBIOhD4QmLy
 1tuka2MGNHDFfBsZLGCek+gae52haOGR4pI7Xy4VQw3uejbM+qd02/q+igRFgeBwLni2
 iWcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtBYje5xGjXLKKSGQMSTTR9SWUv6huhqmHSsySboeiW3128OVfhvf6NE/yNvooSkKCBABkcOk=@lists.denx.de
X-Gm-Message-State: AOJu0YyqLqATY8GcKaTxouERiN+BAUczhKOZrvbm2DxerZDpOD0SZjya
 0ozUBpPvXD/i3A25aFhCVDtHc1gPV857T3Urwp3UnLfgX3ntzZf8gYex
X-Gm-Gg: AY/fxX7C3AKNI0j57CXSv6FIgOrFtrRXfRRSoDZfOOYT5FfMae+ahaaR2M6tzzFYuRT
 Xc79KHAbRha12zr7qMGwVmo7MOsovMU438rVXsGpGhTfKXkA/5NykDsyOwDEZv+uLzi+5imIO2c
 t+aA+sHa6czSN92CPWqhzEKFLGfvKsDe6RfhFj62jKLiUNRv4kLEOrcS6OtnmiUKQ/fMqHtd8yh
 eksyKSlKrrBu0V3oEu90KLsa+d/rhJ2grmv9jdrxtQmfWp4cj1PlSsoC19857k7SPXlhK0Ta6Rx
 T3LtsnfIIrzILaoscFkPsNMxAtHy7LDdZtmAzL4EWtSCILLFLrf6dQ7da7cSlY7up8XEfzUanbC
 jQ2jjGB22TuOsO7YHSbkLW7Sz9E4mDf3OFLOKSOnfSHH7STkvhwRq7O8GmtULqOq11Hte6HctN7
 LBbnWs2/dmRn39fwz3HZ2c4mGsmOL/JaDxPUQDYZJgfdksWd4bAuOsZy84q+dY
X-Google-Smtp-Source: AGHT+IHKehTWYQwJAHjsdqpu5WXU0vyhyRMwGqEWAUo5ftgPluv7xe5r0hCsJyN86RVgzDOh95fFLA==
X-Received: by 2002:a05:6402:254f:b0:647:9bdd:3211 with SMTP id
 4fb4d7f45d1cf-65097e3c766mr8337597a12.4.1768148825334; 
 Sun, 11 Jan 2026 08:27:05 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf661fesm16521815a12.25.2026.01.11.08.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 08:27:04 -0800 (PST)
Message-ID: <deeedc19-e992-44d4-ad77-2b9b2d891675@gmail.com>
Date: Sun, 11 Jan 2026 17:27:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 0/6] rockchip: use OF_UPSTREAM for rk3288
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
 board/radxa/rock2/MAINTAINERS                 |   1 -
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
 41 files changed, 30 insertions(+), 4531 deletions(-)
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

