Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E513CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 767D38469F;
	Tue, 19 May 2026 00:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Ek4GVZlx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41A13846AE; Tue, 19 May 2026 00:27:25 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BDC98465A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c80227c9572so1274500a12.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779143241; x=1779748041;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T5mVW7NInFvIue+7vmPOXXUosmsNnvnykRopOe+FDuM=;
 b=Ek4GVZlxytuQgOkaLuGMupwF93l/UIKJu2lJwmu2cDBehzHcMf5ieljBCNDDOCisXW
 5IeuwI7jTznkiUi05HMT1fza7WS3pwW6UZGRPIhb69lsWJqEhRM5TMxGBcMgxYaXT/j7
 9wlu331srnNeBlO8euO4Z69pOPLfNV9LQ59KaDDW70gltbAgOwweqeut2jco1TlHyTYx
 sHTh3W5UIL1K58m/Hm5XRqr2q3B6oBSUaHlYBZ8xVvFUZ5TrfMHRsx7qNyIHOLEhHX2J
 CsLpui2Gh3pXhLeThyXeFBrVbF7cT8fwRe+Zqu8XMTZ7vIPO2J5nmKfxiHSnQCF1MJuo
 TU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779143241; x=1779748041;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5mVW7NInFvIue+7vmPOXXUosmsNnvnykRopOe+FDuM=;
 b=a6gxQcoftGmMQUmkyE+5PmjJOXwcRNVPMaIzKxF6x7VgGm5BWG1qV4HkH5MkguiqZ7
 EZUnMCrlfQ4EyETBf8HKzr5d3y+CIdbm/EX3/x9y3lCgbuD6++ATchkzM+6yVKCZiHVz
 fp6awOhbmhZIzrB4SujH4YgNk4aiU3hizmlXe2iI2FCh3DY4e6EBjbcVJ81S4YFgqGOT
 3DZloLn6apZbAr0nirCQUSudP8lW2MTls0FESOpqAo1SDeUj+B+FUVWY35VkUc6Y3+rL
 0+4k7g5BJMubbw4rxopg/2dfPwmTVfgXL5l2sOjnD8/ymdbIvL1YUbawMdGa7Mx8MlE1
 94ZQ==
X-Gm-Message-State: AOJu0Yw3lkB6BhElRqUHHOBKdWax7Jvw7dCR4NskCgy/JU3qFjRkOile
 iTdOmg8P5vW00RD6667xja4AaJgKJT9nUhhBo+eR+r02ZURDuwUb3UpNmpF86GlriNg=
X-Gm-Gg: Acq92OEmUqNPHGBU3iHtWahWiqKo7JmDajqVyUFAe4wwJEpWx5cM/Z194T+0lSRgNij
 wH9MLiognSjRP7Dn8DxBAnjZ004CEx/ER1AZsiVuV3sTdUZ8PxTNURdirgI2JOCgufiZlqsMcp+
 EvdDf0WaunpMZ5oSIf7tQsW6TyxSVrIETcK6twVk1XiMlCpf8fbHPvvNMRUy/X41dRpiaqud1/c
 yaGrKpsCD/EIixMtP/7YvaBP4IUtG3YXwpjjFSMmwGzEkxreHBFIoQh2FQDmvaizMCyoRDqWSNz
 /IAKRmNylG3VZceOyw4rTZMMxY/NZ/dDWTSapNkedTCh8Yi0Itol7ZgCGVHwBBznzj7nt/A24BN
 5exPrMvzGAnN/1dtw3eEMBxHS2AnsFdlwVk8hlVJv67HRjN7RROVRUdh9CXZ/neUxJL0iZYgYiu
 lrludBiInmeEps5xeLS62RjKkOc8HnlY3pdz6jhrk2kNBtG63BUt4MAA==
X-Received: by 2002:a17:902:c403:b0:2bd:8dbd:17e6 with SMTP id
 d9443c01a7336-2bd8dbd19c6mr162225815ad.35.1779143240815; 
 Mon, 18 May 2026 15:27:20 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5ef27sm206379265ad.8.2026.05.18.15.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:27:20 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v4 00/14] riscv: spacemit: k1: add SPL support
Date: Tue, 19 May 2026 06:26:18 -0400
Message-Id: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMo6DGoC/yXMwQqDMAyA4VeRnBcwpRPZq4wdTM00bnSlURHEd
 7fbjt/h/3cwySoGt2qHLKuafmKBv1QQxi4OgtoXg6tdU1+pRfb4IrT0Rs4aB1wSMhFTG5xrOg8
 lTFmeuv2m98fftvAkYf6e4DhOT4D3znYAAAA=
X-Change-ID: 20260518-b4-k1-spl-bring-up-b11b18c226a4
To: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Henrik Grimler <henrik@grimler.se>, 
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Tue, 19 May 2026 00:38:07 +0200
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

This series adds SPL support for the SpacemiT K1 SoC, enabling boot
on K1-based boards such as the BananaPi F3.

From v4 I am taking over this submission from Raymond Mao.

The main v4 change is the move to the upstream K1 DT (via
dts/upstream/src/riscv/spacemit/). v4 sits on top of my K1
clock/reset/dts migration [1], which obsoletes four v3 patches:

- v3 4/16 "reset: k1: remove TWSI8 reset restriction" - drop
- v3 5/16 "dt-bindings: clock: import k1-syscon from upstream" - drop
- v3 6/16 "dts: k1: import dts file from upstream folder" - drop
- v3 7/16 "clk: spacemit: Add support for K1 SoC" (Junhui Liu) —
  absorbed into [1] as its patch 1/8.

V4 has the following new patches:
- v4 4/14 "clk: spacemit: k1: prune SPL clock tree"
- v4 14/14 "doc: spacemit: add K1 SPL build and test guide"

To verify, please refer to patch 14/14 ("doc: spacemit: add K1 SPL
build and test guide") for build and test steps.

Vincent Legoll: I dropped your v3 Tested-by tags because v4's DT
handling changed substantially (OF_UPSTREAM). If you can re-test on
BPI-F3 8GB, a fresh Tested-by would help. Branch with all patches:
[2].

BR,
Guodong Xu

Link: https://lore.kernel.org/u-boot/20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com/ [1]
Link: https://github.com/docularxu/u-boot/tree/b4/k1-spl-bring-up-v4 [2]

Changelog
---------

Changes in v4 (vs v3):
- Switch to the upstream K1 device tree (depends on the K1 clock/reset
  migration series linked above).
- All U-Boot-specific DT deltas now live in
  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi.
- Per-patch v4 notes are placed below the `---` cutoff line in the
  corresponding patches.
Link to v3: https://lore.kernel.org/u-boot/20260325223232.1553212-1-raymondmaoca@gmail.com/

Changes in v3 (Raymond Mao):
- Merge CONFIG_ARCH_K1 and CONFIG_TARGET_BANANAPI_F3 into
  CONFIG_TARGET_SPACEMIT_K1. This configuration should be used for all
  boards with Spacemit K1 SoC.
- Remove CONFIG_SPL_RESET_SPACEMIT_K1, CONFIG_SPL_CLK_SPACEMIT_K1,
  CONFIG_SPL_PMIC_SPACEMIT_P1, CONFIG_SPL_DM_REGULATOR_SPACEMIT_P1.
  Since they're redundant for SPL stage.
- Fix the calculation on clock ID. While the clock driver is
  initialized in uboot stage, it'll be run twice. Without the
  protection, it'll cause panic in the second time.
Link to v2: https://lore.kernel.org/u-boot/20260210151459.2348758-1-raymondmaoca@gmail.com/

Changes in v2 (Raymond Mao):
- Use read_poll_timeout() in k1 i2c driver.
- Abandon to parse offset and size from Kconfig & Makefile for binman.
- Abandon to attach firmware image into the patch set.
- Update the related document and some minor changes.
Link to v1: https://lore.kernel.org/u-boot/20260117190231.977686-1-raymondmaoca@gmail.com/

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
Guodong Xu (2):
      clk: spacemit: k1: prune SPL clock tree
      doc: spacemit: add K1 SPL build and test guide

Raymond Mao (12):
      spacemit: k1: support multi-board infrastructure
      spacemit: k1: enable SPL with debug UART
      configs: k1: enable early timer support
      configs: k1: add default option for clock driver in SPL
      dts: k1: enable clocks in SPL
      board: k1: initialize clock and serial devices in SPL
      i2c: k1: add I2C driver support
      spacemit: k1: add TLV EEPROM support in SPL
      spacemit: k1: Add DDR firmware support to SPL
      power: pmic: add support for Spacemit P1 PMIC
      power: regulator: add support for Spacemit P1 SoC
      board: k1: enable pmic in spl

 arch/riscv/Kconfig                              |   8 +-
 arch/riscv/cpu/k1/Kconfig                       |   6 +
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi       | 100 +++++
 board/spacemit/bananapi-f3/MAINTAINERS          |   6 -
 board/spacemit/bananapi-f3/Makefile             |   5 -
 board/spacemit/{bananapi-f3 => k1}/Kconfig      |   6 +-
 board/spacemit/k1/MAINTAINERS                   |  11 +
 board/spacemit/k1/Makefile                      |  28 ++
 board/spacemit/{bananapi-f3 => k1}/board.c      |   0
 board/spacemit/k1/spl.c                         | 343 ++++++++++++++++
 board/spacemit/k1/tlv_codes.h                   |  22 +
 configs/bananapi-f3_defconfig                   |  26 --
 configs/spacemit_k1_defconfig                   |  66 +++
 doc/board/spacemit/bananapi-f3.rst              |   2 +-
 doc/board/spacemit/index.rst                    |   1 +
 doc/board/spacemit/k1-spl.rst                   | 243 +++++++++++
 drivers/clk/spacemit/clk-k1.c                   | 128 ++++++
 drivers/i2c/Kconfig                             |   7 +
 drivers/i2c/Makefile                            |   1 +
 drivers/i2c/k1_i2c.c                            | 523 ++++++++++++++++++++++++
 drivers/i2c/k1_i2c.h                            |  69 ++++
 drivers/power/pmic/Kconfig                      |   8 +
 drivers/power/pmic/Makefile                     |   1 +
 drivers/power/pmic/pmic_spacemit_p1.c           |  94 +++++
 drivers/power/regulator/Kconfig                 |   7 +
 drivers/power/regulator/Makefile                |   1 +
 drivers/power/regulator/spacemit_p1_regulator.c | 464 +++++++++++++++++++++
 include/configs/bananapi-f3.h                   |  13 -
 include/configs/k1.h                            |  20 +
 include/power/spacemit_p1.h                     | 163 ++++++++
 30 files changed, 2314 insertions(+), 58 deletions(-)
---
base-commit: 52ec53db8f18ed476f30de3799067652948eba28
change-id: 20260518-b4-k1-spl-bring-up-b11b18c226a4

Best regards,
--  
Guodong Xu <guodong@riscstar.com>

