Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE5BC55173
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 16:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83F9D80E0C;
	Sat,  1 Aug 2026 16:41:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yxgQ3c989DbC; Sat,  1 Aug 2026 16:40:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 63E7280DE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785602459;
	bh=WgW4oi+/lBCiTfoFKqvbg7goIqj9CB8mWGAW6Mr0/94=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XD1ecDHTi4oUlnfXLMNeCS5KxiSyxaA3eXd17c5d0IKWlDwGmSomLAAVzHE0hXB4X
	 xT3PYMVs8HdNV3f9NuuusHF7M3z3Y4wIkNnYmykn9ZGb9nABVrfpEobiml44esAfxp
	 c5XBESODyKURJhRUF65Qu1DKrFUTb+4xVGjAlMgVa+KLSn+rpDVAhRrwkXhQMKa47L
	 +Qi0k9Pl4vNd1wWbhrpMpxULmeQcQFXyb2UGQvLE1cT2Wosp+KJfHv2nR06YprUen5
	 6/AOg0FylmmYBtJGqK8mdWrrJ1Dr3ZP0H5sICFbgtO68X/tsu3TcalH4YQYXmgSuSU
	 C0WB8EUKE4VIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63E7280DE4;
	Sat,  1 Aug 2026 16:40:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 974EF32E
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D69080DE4
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:40:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O387byuln-0B for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 16:40:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EE08F80D6F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE08F80D6F
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE08F80D6F
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:40:55 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso1940966a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 09:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785602455; x=1786207255;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WgW4oi+/lBCiTfoFKqvbg7goIqj9CB8mWGAW6Mr0/94=;
 b=aGgydbrv6pAMQhiwMNSCsYPLZre7ydJgKLlwajfUDPxjT/9ye9NQWSnVMIt2hbxnfQ
 ryOx9eK23GCJYVDXziBJxwiDQyynSX3vZDz72baeiMjkuj4zVQ1VwZYiyNK4I5meAEVm
 P0Jk9HGpVJAWASZb6RxPfGyGzPPNudpwkX6dq1mja8O8Bb2EUVlDbzxdAmE3orZ+Ua2+
 PeHDiieBYUHb2GUroi01U2Vqrt374hQ0qXsBCWTz70RaahoV3FOv9dONwZqr1aYCCXvQ
 iI3uFifRwGHuqMTLPF6MVu/8Uc/nR1EGOVMClTlQ3J4loU2BbXEL7rjEhTBvWFP874Bm
 ngmw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpG7Ym0RiykEvycJPILtriqca/Nm3Jq3SJ/gzCbB1O61ZZfqEqhpXPKZNgvUgNuVdk0EDwi874=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxtZoLxtfwc6pbk7ymLuppFFmACXRvJJcoeTVf1ixUvW1c1/f52
 j3Mgez8+AVmLM4bF0h4Sk2f6N083YnM9+nuk3/1ukHxaRq+2YRx8Fx7+xTZmAbX+0cI=
X-Gm-Gg: AR+sD10mpZ/3kGw8jWS04mP5mrGOhb/dutTerz3EwpCSsOgMod+IZQO/jqM3RKkaw71
 teCsKR94LHiF+yM6mHomZVNsaQS1+dN82F7hhNbV8hUwu3beE7Ts+2nq0x9qaXDM23SRhsvll+u
 +ZKIOEaqvpPOE5M0m9T5VVopd/L/OBNQEw6FmY7PkonetR+KSEC39kkgvGNNBV8YCdo0ulqajPc
 WRV3DxGlnQ9x0+G/IPpoyrI6ixQQQxJ5AZNTCbWyxlqXtSuqiMtJwZLX4R8ruHDw4Qi2OaR7IAw
 oOpfAVOSc+NkNFy2BIL9miSmKrsOQrfhamIR4nypnQV5ytc8Ukc9RIj8GV9TuhG1j8LpNo2VHat
 tGQQLPkNCBD2yzFWM+8FW8yozosEdnYg9N0kErhyUMjUCOzgYlDbLnowwMDrs0+uqGlgeyj3YGN
 Dd+2R2mOsRkXvnzZNvLoaU3iRjiqTzbo7U4miOhJFnIrBepf5Xg3uMX8QtDX6hhkFSJTPAPryKD
 xRT9VVPJAvQWWl/ejJI9QsEF3rev4osnimkGgh5hS/XhN9JB+Djdhec1+KZ6jrIGDOTTFsrOMwO
 1FcIe5q2k+MMycdWlTK7nJhRUA==
X-Received: by 2002:a17:90b:2604:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-38fbc414a45mr4091940a91.10.1785602454820; 
 Sat, 01 Aug 2026 09:40:54 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab132cc4sm14512998c88.2.2026.08.01.09.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 09:40:54 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH v8 00/11] spacemit mmc driver
Date: Sun, 02 Aug 2026 00:40:41 +0800
Message-Id: <20260802-m4-v8-0-e916643205f3@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIkhbmoC/23QzU7EIBQF4FeZsBbDpVx+XPkexgW/DiYznUBtN
 JO+u9AurNrlSc53LuFOaiw5VvJ0upMS51zzeG1BP5yIP9vrW6Q5tEw445JJbuhFUKMjA4kmxeR
 IK95KTPlzHXl53XL9cO/RT132xjnXaSxf65UZeu/X4AyUUQuQdBBGRsmfS66+TrY8+vFC+ubM/
 yvelHfegJdOD0EfqOFHKYarGppCa5xXiWPyeKDEXqlViaaCCwxAYzIABwp3ivNVYX+hAGsQIgK
 qAyX3arslm+IJNUoZhPb2QKm92n5DdeUdE06kOGjzRy3L8g3YbsUg7QEAAA==
X-Change-ID: 20260629-m4-98e01659fefb
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785602455; x=1786207255;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WgW4oi+/lBCiTfoFKqvbg7goIqj9CB8mWGAW6Mr0/94=;
 b=Y01Wh8kVYx2UJBpIQ3UWTeokljtzSCcBCaIY31JYwsK0TZ0M6b0kjg+dLqT2Y9u+Jd
 EXLkEEhiDcpO8pZjPX83Jp6S5mtI8v3NRmZOIhE/YvvZG7zngqEBfChZubdndGm4T42b
 2n3UgZp2fyc/VcuirtQ1nEM4ppSFWy8CDi7oLXllheNOjHDUxPzInzUH7J5kpvLsE7Rk
 eEJmcLJgGoVPXi7Wv2rEf5C9nCh4xPXMu5Nl0wP9wSR6FFirrbmrRABoaOHFDccHYc2b
 TqkNcrJSTPYcHTU1E/LEyXKoIPXeuNtDX65V7tHTibZCVgks00Yb2e17SdQYNvgzznlj
 pqBg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=Y01Wh8kV
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series adds MMC support for the SpacemiT K1: an SDHCI platform
driver, the SD card device-tree overlay, defconfig options, and SPL
boot-device selection from the SoC strap/config registers. The SDHCI
driver is usable in both SPL and U-Boot proper.

A flashing guide (doc/board/spacemit/k1-mmc.rst) describes how to
write images to eMMC.

---
Changes in v8:
- doc: Remove SD part.
- Link to v7: https://patch.msgid.link/20260729-m4-v7-0-2cb04b4fe389@riscstar.com

Changes in v7:
- spl: Avoid to load product name from ENV.
- spl: Fix DTB matching.
- pinctrl: Simply clrsetbits_le32() on pull-up/pull-down configuration.
- pinctrl: Remove the dependency on SYSCON.
- Link to v6: https://patch.msgid.link/20260727-m4-v6-0-2f58566d48ca@riscstar.com

Changes in v6:
- pinctrl: Fix drive strength configuration.
- pinctrl: Fix pull-up/pull-down configuration.
- pinctrl: Use dev_read_phandle_with_args() to fetch "spacemit,syscon" instead.
- spacemit: rebase on latest upstream branch.
- Link to v5: https://patch.msgid.link/20260722-m4-v5-0-c41a951e5157@riscstar.com

Changes in v5:
- mmc: Split CMD23 support out.
- mmc: Use read_poll_timeout().
- mmc: Set pinctrl state based on selected timing mode.
- mmc: Remove the condition based on quirks.
- pinctrl: Fix power source argument.
- dts: Add missing power source on mmc pins.
- Link to v4: https://patch.msgid.link/20260707-m4-v4-0-dbd01185f911@riscstar.com

Changes in v4:
- mmc: Add CMD23 for write.
- mmc: Fix CMD23 only for CMD18.
- mmc: Update bulk release operations on reset and clocks for spacemit
  platform driver.
- MAINTAINER: update the maintainer of Spacemit K1.
- Link to v3: https://patch.msgid.link/20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com

Changes in v3:
- pinctrl: Fix "fast" by "uhs".
- pinctrl: Add syscon dependency.
- mmc: Fix quick by capability.
- doc: Add SD boot support.
- Link to v2: https://lore.kernel.org/u-boot/20260630-m1-v1-0-83f13347b3ba@riscstar.com/T/#m2aba875a2696a7bb9b704618d22ae2fd7f7f5acc

Changes in v2:
- cmd: drop patches on eminfo & tlv_eeprom.
- configs: Enable ADMA and SYSCON support.
- dts: Use vmmc-supply as vqmmc-supply on the SD card node.
- mmc: k1: Enable ADMA mode support, use CMD23 for multi-block
  read/write, correct pinctrl state from "fast" to "uhs".
- mmc: sdhci: Add new quirk patch to enable CMD23 for multi-block
  transfers.
- pinctrl: k1: Add new IO power domain configuration support for
  dual-voltage GPIO banks.
- spacemit: k1: Use FIELD_GET() to parse boot strap mode.
- Link to v1: https://lore.kernel.org/u-boot/20260521-k1-spl-mmc-sdcard-v1-0-1bd14b8c4f9f@riscstar.com/

To: u-boot-spacemit@groups.io
To: u-boot@lists.denx.de
To: u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tim Ouyang <tim609@andestech.com>
Cc: Leo Liang <leo.liang@sifive.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Han Xu <han.xu@nxp.com>
Cc: Yanir Levin <yanir.levin@tandemg.com>
Cc: Christoph Stoidner <c.stoidner@phytec.de>
Cc: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
Cc: Daniel Palmer <daniel@thingy.jp>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Guodong Xu <guodong@riscstar.com>
Cc: Yao Zi <me@ziyao.cc>
Cc: Rick Chen <rick@andestech.com>
Cc: Leo <ycliang@andestech.com>
Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
Eric Chung (11):
      spacemit: k1: select boot device via config registers
      pinctrl: k1: fix drive strength configuration
      pinctrl: k1: fix pull-up/pull-down configuration
      pinctrl: k1: add IO power domain configuration support
      mmc: k1: add sdhci platform driver
      dts: k1: add SD card support in u-boot overlay
      configs: k1: enable SD and eMMC support
      MAINTAINER: update Spacemit K1 entry
      doc: spacemit: flash on K1 SoC based boards
      config: k1: enable ENV support for eMMC
      spacemit: k1: fix product name detection and DTB matching in SPL

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  91 +++-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  86 +++-
 board/spacemit/k1/MAINTAINERS             |   5 +-
 board/spacemit/k1/spl.c                   | 121 +++++-
 configs/spacemit_k1_defconfig             |  27 +-
 doc/board/spacemit/index.rst              |   1 +
 doc/board/spacemit/k1-mmc.rst             | 167 ++++++++
 drivers/mmc/Kconfig                       |   7 +
 drivers/mmc/Makefile                      |   1 +
 drivers/mmc/spacemit_sdhci.c              | 673 ++++++++++++++++++++++++++++++
 drivers/pinctrl/spacemit/pinctrl-k1.c     | 114 ++++-
 11 files changed, 1256 insertions(+), 37 deletions(-)
---
base-commit: 616c3d79f01cf9204e38738857c4647a730dcb3b
change-id: 20260629-m4-98e01659fefb

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

