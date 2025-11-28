Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA4FD116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 22:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E853A83C94;
	Fri, 28 Nov 2025 23:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0xBCGr4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60F483B8B; Fri, 28 Nov 2025 21:47:37 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5955B83B63
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 21:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b3c965df5so1355097f8f.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764362855; x=1764967655;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Uy3/kSuGr/+Qcz1ghwrkCdCerBpub7DYivsZI06Ngs=;
 b=0xBCGr4apU0KOesmFYpHxcAxQZKZmkg85hX5CcivgR3nbiDlqP96+Che089iabD1o3
 RlDAtF5niaVF6cGpqowLVWr1OVnWC5m/4dAx53jbYjzToOeTDICKAvN40O8mtpdj+Kbi
 e8juojdyY9ZodRpfG3yaVnK736iBeKNS9VWjhHjGhQplxl350PwFabZg58KNEtsfEMfB
 CIypHNgXdrIXHjO+OSRLABy+410YxLtL/K/saTdw62yJASQaDE8k1I+nCa6TCyq6ISil
 msf35s41Hrd2P8lJnYnDspPsCD2l4RHeqYcHUY3teeWCq52DCRLKuoyQfDkSEcCfW+2h
 Wi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764362855; x=1764967655;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Uy3/kSuGr/+Qcz1ghwrkCdCerBpub7DYivsZI06Ngs=;
 b=q/saBPC5bF35B/UbIzMcrfYKTrefYXzZ1/OQ0cWNdzr2lqirRwdojNN1X432akFBKQ
 bAn/8mKAC9Q5A5TuYEUeAx91k3LwdV/MvtVSqmusqRht13vboHNpOiZRiCIDXIjBiB+2
 HyAzdbKOF6qsFJ/l3U9FURPR08CmOsuzup1HgeYdLiUylRQRvEnVu9DjV3HJPvXWj1rb
 wr03ySzak8+JUHpYnOkfGSrgFStKjv9qsCHA/UQ91TS38RL/dxtHipQOaa7K4Dtzbomz
 PswmWXs6VmvX9ATsVEmxjYWzQdv/A6aIWb8MaKNSYQAbi22QoyHRQDbw8wsrFMH15U6z
 hOJg==
X-Gm-Message-State: AOJu0YwzTk1B2jnw6V1mY9veaU49+qBgxjUVuXqusoj4gdssz3+Cg2HY
 vslQr2c2zt8PUCwS3PuapPoIFeI+DYIZpK0kD4jeeD6nx/IpFNP1gdRMsC3nFY17c14=
X-Gm-Gg: ASbGncux0xbqZx2UFdxnfEvGZYEUCgyzv9joQPQntktc9ZIApBc3QCqYrT4JjWzoFsY
 TJwd4sQXVxaOASmyRkmuRzqinDOoCDVuwc36X+joP5P9yVf/LoeVOCZblzhCLY3/jyZOlRR1wHG
 IO/FTEksN5yB8ZVUpA5RQpOYV3p0GCGkUfs79D31oW5pyqaROXRN7tAuSk8gTLB1ZQtgmM2lbrm
 qsdQsxLBfmO6FCZSW30hNnBUvzfgACx9LJmgt8gfD455YPrChFQRUjhMQLCYjf9zrtiql+M4wQ2
 x3BhPMlVTFSTCdKZYo7wqnWxBZAu7ZzDpFw/iHv3KnO1dfSugdcw8IW69Puxg7Wc90rMIoQCkY0
 nhi/FKxw3HWV//rPfXORQ3H480L0MaBHwYrjKf7ixkYOGOFc37LV4nF24prw0AmnYP91PF+pPaX
 4Tm1sP7mA=
X-Google-Smtp-Source: AGHT+IGTwp9nc5pZhDyyvoCfj2sjB8+ydVBg1PmsLPlsXVbW7jprjlRV2zIoifGB+Y0Hf5zMU4w1Cw==
X-Received: by 2002:a05:6000:4313:b0:401:5ad1:682 with SMTP id
 ffacd0b85a97d-42e0f213731mr17636663f8f.14.1764362854650; 
 Fri, 28 Nov 2025 12:47:34 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42e1ca1a6fesm12083415f8f.20.2025.11.28.12.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 12:47:34 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v2 0/7] arm: am335x: Switch to upstream devicetree
Date: Fri, 28 Nov 2025 21:46:30 +0100
Message-Id: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACYKKmkC/42RS27CMBCGr4K87iA/IAlZ9R4VC3s8Bqsxdu0QF
 SHuXhPUwqIqXY5H8/0Pn1mh7KmwfnFmmSZffDzUQb4sGO71YUfgbZ2Z5HIthOhgjMkj6KAU0BQ
 gujETwVT3DXABpFsuiCvXoWMVkjI5/zkLvG3rvPdljPk0603i+vpv9CSAw0YgCYVNI0i+Gn0av
 Mm0xBjY9nKTy/RxrDHGmyYzuhDUffBjv5hZy8rKqNhjxJp4diHXjy5weIdMu6ATWEp3J7LppFY
 bQ2R1P8m/SeFYDKQcjT/s7gihVso514m2MX0t4lfEdyXFhzQQpADmWCCmsX6SHqq9iO/lgYlWd
 cZ2VtnuKfOn5gHtHcH5yrUrLREdPkXEazEph/s5blqUHO2atL6eby+XL9eZmPhiAgAA
X-Change-ID: 20251118-topic-am33-evm-oftree-v2026-01-ea701e03f8cf
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4368; i=msp@baylibre.com;
 h=from:subject:message-id; bh=4BL8nGibMZUo2D8xUhvzPpFSxTbm/HaSGHLAylBJhHw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwtLu1La8y/CYfO+lFyxdk6+cfOup2Jk8L+i76vlPhdK
 i784+LZjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZiIw1NGhpdeyY1hplri6340
 yc89fmt68Kkkvo2hTKdWMBa+VLZnVmL4p2Jds0VlU3LglYdO1m3FgUwn/vO6zfOR5HBYW9/18nI
 pNwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 23:32:55 +0100
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
- Patches 4-7: Make upstream devicetree working with uboot. This
  adds tick-timer, adds compatibility of the board code for different
  USB probing and updates the defconfig.

The series has been tested on am335x-evm. Note that I don't have all
other boards built with the am335x_evm_defconfig, so tests are
appreciated.

Dependencies:
  - clk: ti: Cleanup common functions and omap-cm
      https://lore.kernel.org/r/20251128-topic-am33-clk-regmap-dep-v2026-01-v1-0-d722c79506b2@baylibre.com
  - dm: core: Support same compatible in host/gadget musb drivers
      https://lore.kernel.org/r/20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com
  - simple-pm-bus: Make clocks optional
      https://lore.kernel.org/r/20251128-topic-simple-pm-bus-optional-clocks-v2026-01-v1-1-e38040c88b6d@baylibre.com
  - video: simple_panel support for am335x evm panel
      https://lore.kernel.org/r/20251128-topic-am33-evm-lcd-v2026-01-v1-0-ef75d4330d3d@baylibre.com
  - power: domain: Add ti-omap-prm stub
      https://lore.kernel.org/r/20251128-topic-omap-prm-v2026-01-v1-1-72c5cc4c7728@baylibre.com

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Changes in v2:
- Most of the independent patches were extracted in smaller series
- Added patch to add vidconsole for am335x-evm
- Add chosen tick-timer to all devicetrees that are used with the
  am335x_evm_defconfig
- Link to v1: https://lore.kernel.org/r/20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com

---
Markus Schneider-Pargmann (TI.com) (7):
      arm: dts: am335x-evm: Add backlight to the panel
      configs: am335x_evm_defconfig: Enable panel
      include: configs: am335x_evm: Enable vidconsole
      arm: dts: am335x-*-u-boot: Add chosen tick-timer
      am33xx: Fix comment about config symbols
      am33xx: Support upstream devicetree binding
      configs: am335x_evm_defconfig: Switch to upstream devicetree

 arch/arm/dts/am335x-bone-common-u-boot.dtsi           | 14 ++++++++++++++
 arch/arm/dts/am335x-bone-u-boot.dtsi                  |  6 ++++++
 arch/arm/dts/am335x-boneblack-u-boot.dtsi             |  6 ++++++
 arch/arm/dts/am335x-bonegreen-u-boot.dtsi             |  6 ++++++
 arch/arm/dts/am335x-evm-u-boot.dtsi                   |  6 ++++++
 arch/arm/dts/am335x-evm.dts                           |  3 ++-
 arch/arm/dts/am335x-evmsk-u-boot.dtsi                 |  6 ++++++
 arch/arm/dts/am335x-icev2-u-boot.dtsi                 |  4 ++++
 arch/arm/dts/am335x-pocketbeagle-u-boot.dtsi          |  6 ++++++
 .../dts/am335x-sancloud-bbe-extended-wifi-u-boot.dtsi |  6 ++++++
 arch/arm/mach-omap2/am33xx/board.c                    | 16 ++++++++++------
 configs/am335x_evm_defconfig                          | 19 +++++++++++++++++--
 include/configs/am335x_evm.h                          |  2 ++
 13 files changed, 91 insertions(+), 9 deletions(-)
---
base-commit: f4cc2a9f36bdc1b9731aa285cc305d76c48ec79c
change-id: 20251118-topic-am33-evm-oftree-v2026-01-ea701e03f8cf
prerequisite-change-id: 20251125-topic-am33-clk-regmap-dep-v2026-01-2682a39beeda:v2
prerequisite-patch-id: adc433677bb6413c278d00b9e1d6b04b12d4a825
prerequisite-patch-id: 949cc619ccbb8cca5b29ab30ac37377e45ae607f
prerequisite-change-id: 20251125-topic-musb-probing-v2026-01-1343fff8176b:v1
prerequisite-patch-id: b8514a3b43228ff9ef6812dc5fe5eb53e2f141ae
prerequisite-patch-id: abfdeaa1999e4cbf98229c4eeafa9dd8dac4509e
prerequisite-patch-id: c6cc3f7eba8b785fbb8ea91cea349517c7c364fe
prerequisite-patch-id: 37352dffe91e2aef085c2a08fcbc922723dae7c1
prerequisite-change-id: 20251128-topic-simple-pm-bus-optional-clocks-v2026-01-1cd38bd8d3d8:v1
prerequisite-patch-id: af032219347b46e51f58b7d26dac1f59de77fda9
prerequisite-change-id: 20251128-topic-am33-evm-lcd-v2026-01-004f74a2ccfc:v1
prerequisite-patch-id: e00071ea7e9f3cff3f91b320134fcf9164986449
prerequisite-patch-id: 65efd192958e9b5f852dc4bafb30afe526624649
prerequisite-change-id: 20251128-topic-omap-prm-v2026-01-c97c20cd5eaa:v1
prerequisite-patch-id: 92857feb9e8685fe0e68a0e8e18dcdb57df56634

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

