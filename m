Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD484F4485A
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 13:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1549E84120;
	Fri, 10 Apr 2026 15:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="WF0fdJOQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9046D84154; Fri, 10 Apr 2026 15:32:53 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28DC583DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43cf8d550bdso2013387f8f.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775827970; x=1776432770;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qHC54+TSfF6JYiprCrL0iQXOB4ksBnlCDqJKgCpR/vg=;
 b=WF0fdJOQg2p2TiFMn7K0NM6m59kxuLMmLVhXSVaiWdSgW8BsxqXk8BrgIKajw0Saq2
 MlsoMW6wPcQ/lHxSAdoQVm2PajRXdPiUd+xNSJLx1rbG3C7DfIgFjpCL3+0EH6qI3aSS
 mzXfSoDM2aWX3RsdrKKFfsd2AYqflhsPA8X8jJ0LYykc1446/yFzdeuAyoZeAj/j7BPX
 SfRGIbT2IX+EmdAxiVPQqmzJAz5SuXWvsAFTDLSndwdC7Ug8A+r6K4Ses5zu6P1pibw+
 RSyDAja25c6DPUvKt99TPjf65swVFBzHSQP1rdA78uTMT89TfWzlsvr76OUD029WKVQr
 ne6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775827970; x=1776432770;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHC54+TSfF6JYiprCrL0iQXOB4ksBnlCDqJKgCpR/vg=;
 b=QM1aFzQub3OzMh9UY4PIr/i5NOwVB3A1yI4ZGgYk6n6qLaSyzF7gTQm35aEHaCS8/H
 pBgiaGucvUkCxjO9BcPKbk/UqdxXJDvWgLkrfjMpjFeThur5GHP447SzAhEmLJjBYzp2
 TOW1tr7brt+tQ1cTNP90w4Jt6gZfB+VGXQe1JiO0HHtiiySP0rvmOAfvudAp1Q/vBeA3
 MzKw5tzxOkJFRFXjvaC60k/nOg8rAitvC1bu/jg3K4SP2BM4k4mLdlY4dcumiFeCRQvT
 BlYWAco2HlhD8r/pv7uxt+sYSdKP6fe8kCR7NBGacgM8sBK70riCaX0wJLdehG4T3BD0
 4JtQ==
X-Gm-Message-State: AOJu0YzjTMO7Uxkdi2Dx0Y6/x2llM/0Fyg95VK7e76lEyntM/c+p9I/D
 cSkqXVNlyzKpYpneX482dYc8w32g3SzNDHDUrGihMJSLvUnUBrTBD23I9iAlmLIoZE4=
X-Gm-Gg: AeBDieuzSEyyZqGpFtPzFpIFTLUOofOJ7P5lFkyWTkb7F1IFE5r2o+Zaj7HPbYmbbzq
 2BvUpZA6d3mcviRrjCTtx9UXphmJdul2E+qcjfb92nVnhhBTNkNeRh3EhDZ0C8ncilj42w8+rSq
 UY4TRuCbEP0OGcuwBSXZWCZSbVQSJutlD8+VjQ3CKk7bQLiDu1rz7XgQyswBMTxhW6xyBc0T0F+
 IMHltunQ3LGRyihsmBGRrlAoUCK7VbqjSsqcfYZFNfw1bemPBdJNWOyTh8CTXp6psXd96bR7FT/
 8DLAcJZeslfRW94KHe8UsSW69P12J1E1eXTjgJm9Il3FQ1Ks2s1G8/4TneDzTbSw5eyaVhdhNM/
 WcB5VBAvl/vTaVYTrx/WBEaa6MQRyZoFnVGesLSHTe09GgFlcGbTOreBLxHgeLOQuifG4w69lZW
 I5Td7NxZN/7MwL8EjPffUD
X-Received: by 2002:a05:6000:40cd:b0:43d:61d:382d with SMTP id
 ffacd0b85a97d-43d642a647bmr4735455f8f.22.1775827970300; 
 Fri, 10 Apr 2026 06:32:50 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e4f16bsm7836079f8f.26.2026.04.10.06.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:32:49 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Subject: [PATCH v5 00/12] arm: am335x: Switch to upstream devicetree
Date: Fri, 10 Apr 2026 15:31:40 +0200
Message-Id: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALz72GkC/43RwW7CMAwG4Fepcp6RnaRp6WnvMXFIU3eNtFKWZ
 AWEePeFMjQ0IbGjbemz5f8kIgfPUTTFSQSeffTTNhflSyHcYLfvDL7LtZAoSyKqIU0778COSgH
 PI0x9Csww57kBJGBbITGqvna9yMgucO8Py4K3Ta4HH9MUjsu+mS7df9MzAcKaHJNyxhDL19YeP
 3wbeOWmUVz0Wd6J8rkos6ilrY1SqPW6fiCqX1GifiqqLKqOSmMc685VD0R9Ew2SrJ6KOovY2a7
 FitDxX/F8fXLgz68cXrp+WrQ2MuT56FNTLNYKtbgPtSmWCzThzwVuF/cQ9z654ba9gi0fEtRrl
 tTLTmptmhza5nz+BgM9RvE4AgAA
X-Change-ID: 20251118-topic-am33-evm-oftree-v2026-01-ea701e03f8cf
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4697; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Lcb5uSixmmLSKWw27QnkWq7MYaQD0znf3KQJraF0tSE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbv/e3VHFtiAwQ2bZ7tjyjuJBneXP1lscLl7Q8W3oub
 bHynq0LO0pZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAi+/UYGZbOupdy55R8DtO6
 vCUM+4/MDf+2Re7/+6LaafN/Hr67688zhv8h7ydPkD3H9vzzhJ+1Aj+UA6Y0sm04rnfts8eGebd
 +X5XgAgA=
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
- Patches 4-12: Make upstream devicetree working with uboot. This
  adds tick-timer, adds compatibility of the board code for different
  USB probing, makes SPL smaller and updates the defconfig.

The series has been tested on am335x-evm. Note that I don't have all
other boards built with the am335x_*evm_*defconfig, so tests are
appreciated. buildman reports builds are working.

Dependencies:
  - net: cpsw: Add cpsw-switch DT binding support
      https://lore.kernel.org/r/20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
Changes in v5:
- Add patch to add lcdc on beagle bone black to all boot phases. Without
  this patch booting uboot on bbb fails.
- Add patch to split SIMPLE_PM_BUS into two, one for SPL and one for
  normal u-boot. This was done to reduce the size of SPL.
- Link to v4: https://lore.kernel.org/r/20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com

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
Markus Schneider-Pargmann (TI) (12):
      arm: dts: am335x-evm: Add backlight to the panel
      configs: am335x_evm_defconfig: Enable panel
      include: configs: am335x_evm: Enable vidconsole
      configs: am335x_evm: Enable SPL_OPTIMIZE_INLINING
      configs: am335x_evm: Unify evm board defconfigs
      am33xx: Avoid hard failure on USB probe issue
      arm: dts: am335x-*-u-boot: Add chosen tick-timer
      arm: dts: am335x-boneblack-u-boot: Add lcdc to all boot phases
      am33xx: Fix comment about config symbols
      am33xx: Support upstream devicetree USB device
      dm: core: Split SIMPLE_PM_BUS into phases
      configs: am335x_evm_defconfig: Switch to upstream devicetree

 arch/arm/dts/am335x-bone-common-u-boot.dtsi        | 14 ++++
 arch/arm/dts/am335x-bone-u-boot.dtsi               |  6 ++
 arch/arm/dts/am335x-boneblack-u-boot.dtsi          | 17 ++++
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
 drivers/core/Kconfig                               |  8 ++
 drivers/core/Makefile                              |  2 +-
 include/configs/am335x_evm.h                       |  2 +
 20 files changed, 221 insertions(+), 356 deletions(-)
---
base-commit: 32750a1d473aa4932de6303e62afc5306aee2b1f
change-id: 20251118-topic-am33-evm-oftree-v2026-01-ea701e03f8cf
prerequisite-change-id: 20260410-topic-cpsw-switch-v2026-07-next-89e21f2d2446:v1
prerequisite-patch-id: 896e00f13956d28e056dd63764ad8906a0b626ef
prerequisite-patch-id: f612a9425d5a466c7585decbd8990d497a02cdfb
prerequisite-patch-id: 9b18f917297f98b76a75f3d16536283b4c1bc76b
prerequisite-patch-id: 2baa422fb10baa29bf4274a658eb7afba8c7b489

Best regards,
-- 
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

