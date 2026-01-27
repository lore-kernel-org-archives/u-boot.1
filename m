Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A7FD340BB
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B0E984148;
	Tue, 27 Jan 2026 17:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GXDz2cBK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A402A84181; Tue, 27 Jan 2026 17:51:15 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B7B684101
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so49630655e9.3
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769532667; x=1770137467;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Iem6iYH6Lsm8EseEOah5+/cpLy4u8tezw28o4qOJGZM=;
 b=GXDz2cBK16WlVNP6rtUl5DN2e3hgteSZ9XV5fWvBn3g+Vwdmy7TL6RKifOCPqIrtI/
 ZT4yuaezqC7TT5IJQRlxmblbdy/myTjhKTWsjeHycRSdQ1voysM58cBPkdpkNqKmC+3/
 8ruPkHzoXyfWr8/Fv1g8AL2rwajejOLbxqulfipZjopG4hQ5rioXp2hCPXsD9RBrWkIP
 MOOgu1vpT5ZiFuCCwvkM0XrQsz7skZIzBYGw2Egp17ouaIvKfEZPn7dt3OOo3ptzS/ou
 48reCm/mlR+1wRl7wufB0DIfnCEePCccBnhkqWyiWX6anNHM1lRqkQMDk5wpbDI9Z7YG
 xhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769532667; x=1770137467;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iem6iYH6Lsm8EseEOah5+/cpLy4u8tezw28o4qOJGZM=;
 b=Jmeuekd60BofUQnqE7jeCIx8Uq/sL9Cp80e6K87Nk7cyAhWixWvwj27FHB473BNBXB
 e/F7MSB2w2ZkrO07sLv1g4gyFW2tq/2YLwZjSYWm2SMiSl/t1MeuiilX88oKWvqAQ/E7
 AWci+uWQLeCAWnNh5SfoVbOc+gkAvijhSnoCnEu2bLIezDbvKtccUvInTgAgOjmtSlVr
 kubVUY+MqcsAjR1lfSADjMDXiquDPVWN3aUDROx2w9pOCQToZqYKv2GYPNNQxkT1xn9P
 nlykROfjeO4xoGo1MKpXvoL6ZVhVlmTnpBF7ssxIii1ctuwI1elpXFbLw/aoMxkQJwds
 tabQ==
X-Gm-Message-State: AOJu0YwzvDaXiWj3ZPT4CpTko7Gn2ZMxGxKf6A8Gv8pXSaeT3HTL6WfZ
 0wRCud/0JjlnYeaWpDcTGW5OgPnHzu21BTEq9M6lmH5aqQ9MlLRxNdn3l8W9B+kqyy0=
X-Gm-Gg: AZuq6aL90yVF49oxFMmf6eJjbtsuWtOk7lcukDDI3cH5fXVe+PPUEqz/KW3sNrJVcJP
 6avlq85Z1XqJmactzewC3FS8nDRCdvggexKv2mSOi5UKbgQzyOM7RvkQq3EvatNh46KlWTxag9U
 +ht9hOgr6YuB3GfiWJB5xEXJBHFZZVRvC3uS8SMwdObnsrBgKuboRhiuEzMgC34xGPTBcn4kQJ2
 3A1I9sIJPpHvRscZC7Zg7vjRYfroIxG0rmDwyGIEdOulvcQzfhcBUAlAq2mFPS6zhJ8L80Och4w
 Du9NRYaRXU3uhGhiKCaoLYrhS3zRyhNuIYkaHC7B2r9ekTSZF91tfQ8xcrYrRDJdjug1YUsV46V
 Tka73ME0JhdV2UvVFslIIXk5rKLTARnVeZwXbMnBbUKhaJltEgpxsXEOuFteWF+BHa6VtsHmXEy
 Q2prl/6q4u
X-Received: by 2002:a05:600c:154c:b0:47e:e9bf:dd8a with SMTP id
 5b1f17b1804b1-48069cb2fddmr31495555e9.37.1769532666955; 
 Tue, 27 Jan 2026 08:51:06 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804db8da59sm136284785e9.5.2026.01.27.08.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:51:06 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v4 00/10] arm: am335x: Switch to upstream devicetree
Date: Tue, 27 Jan 2026 17:48:14 +0100
Message-Id: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE7seGkC/43RwW7DIAwG4FeJOM8VBkLSnPYe0w6BmBZpCSmka
 FXVdx9NK7WaJnVHY+n7jX1miaKnxLrqzCJln3yYSqHeKmb3/bQj8EOpmeCiRsQWljB7C/0oJVA
 eIbglEkEufQ0cgfqGI3HpWutYQeZIzn+vAR+fpd77tIR4WvMyXl//TWcEDlu0hNJqjSTeTX/68
 ibSxoaRXfUsnkTxWhRFVKJvtZRcqW37hygfouDqpSiLKAestbakBtv8Ei+3lUQ6HMuql9temOk
 TQemPfumq1dqUqGiRPZ+hq+7/qu9TjMdkYI7B+Gn3GAGlks65FhttuqxK5uUHkm+qYeYBAAA=
X-Change-ID: 20251118-topic-am33-evm-oftree-v2026-01-ea701e03f8cf
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4271; i=msp@baylibre.com;
 h=from:subject:message-id; bh=n3iqp45vhwvPQW6PADgG23uW/w/+zUEKbyU0aEbzLJU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyKN8ve12+3VFHhqpIW+Pj35iszyW//74rb5T9M0E/Vc
 3yQIqzdUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABNZ3MXwzzq5apLLCS0zpoMr
 rtyf3MNb/fB3hqGyxqHfU7dG/3wmu53hn4HZzVWsyjczvi+JOTurOWm31J130gdrbB8z7dhezj6
 lngUA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

The series is split into two logical groups:

- Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
  with the current u-boot devicetree.
- Patches 4-10: Make upstream devicetree working with uboot. This
  adds tick-timer, adds compatibility of the board code for different
  USB probing and updates the defconfig.

The series has been tested on am335x-evm. Note that I don't have all
other boards built with the am335x_*evm_*defconfig, so tests are
appreciated. buildman reports builds are working.

Dependencies:
  - dm: core: Support same compatible in host/gadget musb drivers
      https://lore.kernel.org/r/20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Changes in v4:
- Add patch to enable SPL_OPTIMIZE_INLINING to reduce size and fix the
  build
- Link to v3: https://lore.kernel.org/r/20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com

Changes in v3:
- Add patch to unify all config variants for the am335x-evm and similar
  boards. This also updates the upstream defconfig enablement patch to
  effectively switch all config variants to OF_UPSTREAM.
- Link to v2: https://lore.kernel.org/r/20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com

Changes in v2:
- Most of the independent patches were extracted in smaller series
- Added patch to add vidconsole for am335x-evm
- Add chosen tick-timer to all devicetrees that are used with the
  am335x_evm_defconfig
- Link to v1: https://lore.kernel.org/r/20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com

---
Markus Schneider-Pargmann (TI.com) (10):
      arm: dts: am335x-evm: Add backlight to the panel
      configs: am335x_evm_defconfig: Enable panel
      include: configs: am335x_evm: Enable vidconsole
      configs: am335x_evm: Enable SPL_OPTIMIZE_INLINING
      configs: am335x_evm: Unify evm board defconfigs
      am33xx: Avoid hard failure on USB probe issue
      arm: dts: am335x-*-u-boot: Add chosen tick-timer
      am33xx: Fix comment about config symbols
      am33xx: Support upstream devicetree USB device
      configs: am335x_evm_defconfig: Switch to upstream devicetree

 arch/arm/dts/am335x-bone-common-u-boot.dtsi        | 14 ++++
 arch/arm/dts/am335x-bone-u-boot.dtsi               |  6 ++
 arch/arm/dts/am335x-boneblack-u-boot.dtsi          |  6 ++
 arch/arm/dts/am335x-bonegreen-u-boot.dtsi          |  6 ++
 arch/arm/dts/am335x-evm-u-boot.dtsi                |  6 ++
 arch/arm/dts/am335x-evm.dts                        |  3 +-
 arch/arm/dts/am335x-evmsk-u-boot.dtsi              |  6 ++
 arch/arm/dts/am335x-icev2-u-boot.dtsi              |  4 +
 arch/arm/dts/am335x-pocketbeagle-u-boot.dtsi       |  6 ++
 .../am335x-sancloud-bbe-extended-wifi-u-boot.dtsi  |  6 ++
 arch/arm/mach-omap2/am33xx/board.c                 | 21 +++--
 configs/am335x_evm.config                          | 86 +++++++++++++++++++
 configs/am335x_evm_defconfig                       | 96 ++++------------------
 configs/am335x_evm_spiboot_defconfig               | 85 +------------------
 configs/am335x_hs_evm.config                       | 14 ++++
 configs/am335x_hs_evm_defconfig                    | 95 +--------------------
 configs/am335x_hs_evm_uart_defconfig               | 94 +--------------------
 include/configs/am335x_evm.h                       |  2 +
 18 files changed, 201 insertions(+), 355 deletions(-)
---
base-commit: ec5a49db0222f309e3aba6601ca4d8d02da15de3
change-id: 20251118-topic-am33-evm-oftree-v2026-01-ea701e03f8cf
prerequisite-change-id: 20251125-topic-musb-probing-v2026-01-1343fff8176b:v4
prerequisite-patch-id: be515ce444bdebafdb734fea04e5290239c99056
prerequisite-patch-id: a1af765d3524eaf8fc221d712f7016e118492687
prerequisite-patch-id: e1145c3582cbefb28815df883beb8990b9875ca6
prerequisite-patch-id: ec3fd2f06b6f9c26aa1347ae284594baa2c0e66c
prerequisite-patch-id: 76d25fb9c19f7c1396d0ba10283549d702a491cf
prerequisite-patch-id: c6cc3f7eba8b785fbb8ea91cea349517c7c364fe
prerequisite-patch-id: 37352dffe91e2aef085c2a08fcbc922723dae7c1

Best regards,
-- 
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

