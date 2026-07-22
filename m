Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3076BC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 15:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAF694087A;
	Wed, 22 Jul 2026 15:07:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9WcFp5xTw51; Wed, 22 Jul 2026 15:07:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB6A24085D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784732849;
	bh=NYp0qM+ZXj+PyuJd7s2j0moSMKKC6iATSLqe4qz9iG8=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=HhnwHPz25Vdb0D8TVFLhzf6MkKLGMr2YWGe2R7jUkNsNa8ruz+aJFTWjIvFtOJu6e
	 ZC15Mqxzd6jn2jJaJSDa7wW3MiicTjhSAiW95Zg9q4eCwfQQRU5KYdHYczuxMzah4P
	 SN2iTbP1gIE+3ETyANnVE/qJns1PaeKq8brCD0gfU0dHyhpzo9cFGleiIQwXv+3rfk
	 TDZSUIL9FZb+EcQGls7SE3dFtzsFVjO7al0wXBHzu+Fv3+pVZv7JNh2rwyt5+QDIDV
	 MDUhTpBzltN8TRe1PUH3OqoiUMqJ24m/JizVj9hcVPCNDbs7/pGQ790O2FIsbZaGom
	 jG2ZsEy2BCnBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB6A24085D;
	Wed, 22 Jul 2026 15:07:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ACA62224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 92E2C80EFB
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:07:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QJn80VNGABC7 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:07:27 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3585A80F0B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3585A80F0B
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3585A80F0B
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:07:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D128494B; Wed, 22 Jul 2026 17:07:23 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F9E848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:07:20 +0200 (CEST)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so10487222a91.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784732838; x=1785337638;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NYp0qM+ZXj+PyuJd7s2j0moSMKKC6iATSLqe4qz9iG8=;
 b=bfujyvqyfS3v2WOE3LasPPyXo/s9HUrGo5u/sECQAJkOoFrPdAO3mSz9/9UaYPt8/C
 43iL8jyaHZkx0X2F/TERtV0jZqsDDbizTxaeCh0DimuDQDI/TPYkwtAYjM5UnqSz8dC6
 aqwC62c1L2idKJIEAZo0TkFESTBjIqfLCbLM525Xc7gDBhkasiCnetPZcrszXBcQ9JRX
 ASFEu5jmcSS8/XWuSvQuyj75IgoZ345+DQYD5uoS8od90Zy8GXLIJ6sHKVY+Uc4Z6a0I
 eWuismskVWTJDRp9qAO+HM76I5+IWsZJKmH7DUgOjxvGgIVAq6AnbyB1MGF673eECj38
 vMcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqOrpLzoiJu/FKawjVnGvUWTg+Pjz8uOEBlMKZasohcAT+ru3hpxrQJqmlSd1G68huXh7STbFk=@lists.denx.de
X-Gm-Message-State: AOJu0YxaOydlRodhwk3FGrHIaQUQrg8Ef08l7YAuMi05xZZFcH78kWo7
 Fk8rlN897+ffgkply8kMaPeKaoUGgF+2z51NdL3eDemrjbVHpuXl9VqERUzvJi6ieZs=
X-Gm-Gg: AR+sD12upQV3225bAYGaCFKKYc1iEawxO9jNQzGdiBD8D/ijpAxPvVTTxndbheymdjA
 s+KYSkMrkffAJbGFV0LcYuIsgVyJ9bZDpbAYH1B26tx2sJFuapcOdCvCEOvWUJy3qrgYzmJ58ec
 3R1CUO/fjwVPVUdMNFkG6r1HpbNyyYQcwy8z6UP62egzuXfCDOXmSh9g3fOO2UzoDRvZMZbJPr5
 EsBwX61BVWUn7/IAEn1WGWEBCH9glfzOFs+z+cc8bL8e1cj7zBXl8SGtPCLAmUWVvYqDTFd6/Wn
 dzavP5t9EoP3uawk1Ki0QB0RQvt5f00sOnk1spjHsnGddoSxtqSt4AxWrSUU6k8sB9om0Bh4Nh4
 m84VORnGtlkVddJXvsoAxq8eGbemiujuj5y20pHNrRtW1M9Pu9S9TE6ezTpghgaG/yw05/Q36i+
 +qGqN4nIT7SfEecV7MnaIxwzOaGJ/RQV324t7ecgc53pdHRNjmhtqA3wNZtjaHEvvwniMFC6xa2
 IcRe+fjTJgu0u6X1nxDl3UIEvxwFXFKKqKCsTQwP9R0t1eiPs4W+g==
X-Received: by 2002:a17:90b:2f0b:b0:381:18c3:1b99 with SMTP id
 98e67ed59e1d1-38e4b51bfbcmr24933928a91.23.1784732838523; 
 Wed, 22 Jul 2026 08:07:18 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e088d3fsm10622267eec.25.2026.07.22.08.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:07:17 -0700 (PDT)
Subject: [PATCH v5 0/9] spacemit mmc driver
Date: Wed, 22 Jul 2026 23:06:56 +0800
Message-Id: <20260722-m4-v5-0-c41a951e5157@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJHcYGoC/23NzW7DIBAE4FeJOJeIxQZDTnmPKAezLDWVEkfgo
 FSR373YOfTPx5Hmm3myTClSZofdkyUqMcfxWoN62zEc+us78ehrZlJILbS0/NJya0iAVjZQcKw
 Wb4lCfKwjp/Mr57v7IJwWuTSGmKcxfa4vBZber8ECXPAeIBjfWk1aHlPMmKc+7XG8sGWzyP9KV
 oUOLaB2pvFmQzXfqhNqVU1VqrcOuyBVQLWh2p+qW1VblXdeABgVLMAfNc/zFxJBb4lLAQAA
X-Change-ID: 20260629-m4-98e01659fefb
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
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
 Eric Chung <eric.chung@riscstar.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784732838; x=1785337638;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NYp0qM+ZXj+PyuJd7s2j0moSMKKC6iATSLqe4qz9iG8=;
 b=XeqXFy02ApSQtEDK0yW3Xl4eifst7IfO7rLomsJgNHCk019R21KjmbVFXWLUXpjNxF
 W2dXp6M82uIDo6dMm7XS1kRyP6kKf54Ge3NPw2jtYSvj+TPSj1bigC6fuKSwO4KGrJaD
 JcaSeKe89cMGuODZeGY3wAkn6wXYEO/BZ7VWFzermc20+e4CMdTnMygJ4DY2z9Vro/9k
 cCmPWZJl2F8ROLWjDRF6rr81uB/ZobH1KIBxPXOoqBgE2hem1o5CiT6T/ddT0BTVxXfb
 SwhqohLJh7U7fpQVh+SdrZADwz84RpO5nDvSKTD0FYxad6h2wjqkbU8X+IbY83w9R9RX
 R5zA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=XeqXFy02
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.chung@riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.b="XeqXFy02"; 
 dkim-atps=neutral
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
From: Eric Chung via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Eric Chung <eric.chung@riscstar.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series adds MMC support for the SpacemiT K1: an SDHCI platform
driver, the SD card device-tree overlay, defconfig options, and SPL
boot-device selection from the SoC strap/config registers. The SDHCI
driver is usable in both SPL and U-Boot proper.

A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
write images to eMMC.

This series sits on top of three series still under review, and must be
applied after them, in this order:

  1. K1 clock/reset/dts migration [1]    (8 patches)
  2. K1 SPL bring-up v4 [2]              (14 patches)
  3. K1 pinctrl/GPIO and SPI NOR v2 [3]   (9 patches)
  Then this series                        (10 patches)

For each series:

  b4 am <cover-msgid>
  git am ./*.mbx

Link: https://lore.kernel.org/u-boot/20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com/ [1]
Link: https://lore.kernel.org/u-boot/20260630-m1-v1-0-83f13347b3ba@riscstar.com/T/#m2aba875a2696a7bb9b704618d22ae2fd7f7f5acc [2]
Link: https://lore.kernel.org/u-boot/20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com/ [3]

---
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
Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
Eric Chung (9):
      spacemit: k1: select boot device via config registers
      pinctrl: k1: add IO power domain configuration support
      mmc: k1: add sdhci platform driver
      dts: k1: add SD card support in u-boot overlay
      configs: k1: enable SD and eMMC support
      MAINTAINER: update Spacemit K1 entry
      doc: spacemit: flash on K1 SoC based boards
      config: k1: enable ENV support for eMMC
      spacemit: k1: load product name from environment variable

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  91 +++-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  86 +++-
 board/spacemit/k1/MAINTAINERS             |   5 +-
 board/spacemit/k1/spl.c                   | 122 ++++--
 configs/spacemit_k1_defconfig             |  26 +-
 doc/board/spacemit/index.rst              |   1 +
 doc/board/spacemit/k1-mmc.rst             | 320 ++++++++++++++
 drivers/mmc/Kconfig                       |   7 +
 drivers/mmc/Makefile                      |   1 +
 drivers/mmc/spacemit_sdhci.c              | 681 ++++++++++++++++++++++++++++++
 drivers/pinctrl/spacemit/Kconfig          |   2 +-
 drivers/pinctrl/spacemit/pinctrl-k1.c     |  86 +++-
 12 files changed, 1376 insertions(+), 52 deletions(-)
---
base-commit: e7a6b33b153be98fcca16729e189f90c2d91a98c
change-id: 20260629-m4-98e01659fefb

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

