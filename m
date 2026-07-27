Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231FDC531FC
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 06:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C08B540612;
	Mon, 27 Jul 2026 06:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ayv_8kqDdqNh; Mon, 27 Jul 2026 06:59:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B678540607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785135558;
	bh=kDUlL9YmysvAcJ+RCjirm9FqR8WmL+ys4+8jr36Yajs=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NlL93tEHwChlDg4EqkDsKQ4PtsDrpzQDFSPpjmxx8f8HOqroi/zZWGp29IRg0xX/I
	 kwi0Lwl6X0N1ifoI2qupIXb92hW8Tb39AFYhPxclLtiiGI+lJynhzfPVJiSaIiOA2S
	 iIoslBc9wmOTlP1Zd6VyWSHQHP9ck4k98U117iO8GP4fIeHnzB+9XivAeZrSfrD8XO
	 /W+Ms9ubwYzyDSBYyVLp7DCDVpbsqvcfxGv4BReF4TJTTayzJCqczHkoOHOAqyQfq+
	 V8Uf0Y3SO6viYEcl+7oOT8t3UhR3rGpqwLjCEZVZY7c6/498EPD+LCffRGtMFL9iqd
	 hFcmfBL3mJwqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B678540607;
	Mon, 27 Jul 2026 06:59:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E1794C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74532605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KTQQkSQGLt5c for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 06:59:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7B902605E5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B902605E5
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B902605E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:14 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so1930480a91.3
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 23:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785135554; x=1785740354;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kDUlL9YmysvAcJ+RCjirm9FqR8WmL+ys4+8jr36Yajs=;
 b=eDuqXopNwJQ8YVjsxEiwmodM+z2lqqVeD6xru4c9hVWgJIuA0xzUVX6tA3rFv2q1RK
 qndZtWde6Arm0QH0XApGSKqMvPQlsqzaJ9nPgTdrUd9ciTphvdKubF52giQbym2ilDK+
 RMvnbCYutery3MY87iiXlitfI0OmxxfEDR96l8G74QITKvzlIgDw2PyysspcVh3o3s/T
 K3LzEWYDU58skzo3tZth1vhVp3KBBlUVp3xcNC/Zfogyr+vQ7qdHbwsDgVmJ1Q3dhiR8
 C09m5J6jJLO5ihT3pgbbHfaUBH9bABilg3YUDiMVVAKZTIX7wGrWKnUhLZv0NFRjAGjs
 l01w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmECoqwug6mDEBbqQPoN7Y+YhVBaB5NCSsuPgVt8J+RpbOCIdgdNwXDy/hUH/TveBa9ad8CbY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx8EcVFLcKjbawpT6Ga1LxBXeuAFMk8V0e/mJQaPiV9TT7Qn+X6
 7lrqcMLM5RGBr7uUBgujsD6bfoOfSyQHTRQ90+Gox1IKtNv/RVMmji72q0UzubsHvdM=
X-Gm-Gg: AR+sD10GtbeixcqJEBcMsfFqgrgaO4VtQi+yXESJdVnHWrmfo1/AhPutEk2VLXen+09
 dyHTqlj6zN/IEr5bpB4pKAezgr07weXSjGGNT0494nZzhtQYua+RBa7N1dwb3Mnwt8vlfypOzAh
 +NEBJymXKUf4R3zsfWfYEMz5jW9vrdb6ZUSPoDLSKfxiCTOPbGUfwW7T7pVTMAu6PNccmYbW8ZR
 OhoFYUIjbsloeqtdMC/Yi9aRa53Kg6uzi77Ahqzorm5fR0Zo6ffxGWdbKjNlWDyqZTjEMSxUgcG
 Xxbfw4jqFdMdsAr8LodLPDF8bwnIe+Qm4xzDwmCHTJxpECcmW7ODXUGl68XaIFyNaHNyRQwvRlj
 eb73KbQcHU6u49vxJdxiEM2LNw8+E4exRLzyDHtXtlnJFsqXF9HXfH48MKvcKBjPNV4bieTJ5VK
 XKt5ODnTAJUGiyth14BGoIB48Zgo9VYkVIuPA4rx5+kpkYy4xxi+w2ovK2oBaG09me76tb46Io3
 QorA+wLKu3kv0NZLIheM2PZVtrxXXrFNShnOKWax3g=
X-Received: by 2002:a17:90b:560b:b0:381:26f:8f05 with SMTP id
 98e67ed59e1d1-38f2939b4cbmr6539760a91.3.1785135554325; 
 Sun, 26 Jul 2026 23:59:14 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e52f0c6f2sm22969489c88.11.2026.07.26.23.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 23:59:13 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH v6 00/11] spacemit mmc driver
Date: Mon, 27 Jul 2026 14:59:02 +0800
Message-Id: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALYBZ2oC/23OTU7DMBAF4KtUXmPkcTxOzIp7VCz8M6ZGaoPsE
 BVVuTu2WVAgyye9783cWKGcqLCnw41lWlNJ86UG/XBg/mQvr8RTqJlJIbXQ0vCz4mYiARpNpOh
 YLb5niunaR44v37l8uDfyS5OtcUplmfNnv7JC6/0aXIELbgHiFJTRpOVzTsWXxeZHP59Z21zlf
 yWr8s4b8NpNQ5h21PCjRoFdDVWhNc6PUWL0uKPUvRq7UlUFFwTAhNEA7Ci8U1J2he1DBdYgEAK
 Of9S2bV8Yz3YHgQEAAA==
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785135554; x=1785740354;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kDUlL9YmysvAcJ+RCjirm9FqR8WmL+ys4+8jr36Yajs=;
 b=crNQnV9R+n+LyM7C/UXB3ctnfquFFcepH3UsgILB397MrvrmE7H9snI46hVRghAZVK
 pgfqunVsTq+xw0hJUEKgrnXV/Jh6RiRG0ilf6UnTFeQPi+zenqAlGibIj9gMMaBqHjOQ
 a5BEdHW5BFloIs7UtWy0WqUhIVqfh5eg6rx48Jxb6Tz4iqVJpKBAX944jQ0CYXvXhOqT
 jgjy9MiDwyPujgPOcKdZo91J1O3pc3FJHTvKl1Bts3jDch/H2Hsgsgq5z7abcTtvtZbd
 gh0R1R6UbuDZRvx0C4virw2OLWN/kwh4WXDah0L1n9epr1DyxVVxiK5WbmlXesJ4bltd
 drFA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=crNQnV9R
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

A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
write images to eMMC.

---
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
      spacemit: k1: load product name from environment variable

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  91 +++-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  86 +++-
 board/spacemit/k1/MAINTAINERS             |   5 +-
 board/spacemit/k1/spl.c                   | 160 ++++---
 configs/spacemit_k1_defconfig             |  27 +-
 doc/board/spacemit/index.rst              |   1 +
 doc/board/spacemit/k1-mmc.rst             | 320 ++++++++++++++
 drivers/mmc/Kconfig                       |   7 +
 drivers/mmc/Makefile                      |   1 +
 drivers/mmc/spacemit_sdhci.c              | 673 ++++++++++++++++++++++++++++++
 drivers/pinctrl/spacemit/Kconfig          |   2 +-
 drivers/pinctrl/spacemit/pinctrl-k1.c     | 118 +++++-
 12 files changed, 1422 insertions(+), 69 deletions(-)
---
base-commit: b635d43bca429500cb8ef20aa151cb5773b9a8a5
change-id: 20260629-m4-98e01659fefb

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

