Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47CDC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E037F81FEE;
	Mon, 23 Jun 2025 14:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xmc5zYN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 161AF82D2B; Mon, 23 Jun 2025 14:10:30 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9263181E13
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ad8a8da2376so651213166b.3
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680627; x=1751285427;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oWk4fTffKtcL+25m0sqa032AvNkiN4T0AtCF/11qMJQ=;
 b=xmc5zYN10pNIhPpI+TCeQ6kEmmc1Kg7s6PZ24rAXLK3aEnhgVrFgy208dUab1vqmaS
 M5a7buxU6Bx1i56LkODNuBCrZTHt0+XU4y35EDnnlPuriz+NHWQh2r5ubqhVnOwtCzWh
 vLcATCzyBDq1jhI/dbmx6oXvt4gj6iwEIzxvFryHBlRshwxGMCocHpN75+1wbYpy3QvN
 KZnl2KI3qAvx2K5QLQE9MBI5U7I2HzWkjHktEVybf2Lh9SaJQ4zCQtZ9v+ZuI1Yy65Xl
 2UB3p/t5bstmZoDnqOXG5B0D80Rf4sobf87n9fpVW5FLp5whzzBFKsLwiTFXt+KJiPc+
 yKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680627; x=1751285427;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oWk4fTffKtcL+25m0sqa032AvNkiN4T0AtCF/11qMJQ=;
 b=WSj/ZtYEHfGDO2Ovm2XEXsZyrzcYAjcngO6WyuqdY1ecEsuZ5eNwm0iNvc/eOmwECC
 jkMCHpfSXZCt/6aWLJE2S6lOaW0D36lCVoY127IDcnN7yTM0/u+wRI37iMCjy05OUkXA
 PR50LTVW9PSmhsErzrFLi85Z5RpOKl86+INfYVQDGvnj18djTN7E/Cn1iqSGCHfV7wAD
 qfWi46E/+wJKpu6j86xTy+RzyuIC2XOjxnz+vVd8FDFI45HgiXftbhUgSCkmOqQjtusk
 mPj1ouMrw/qLgJr7RzKm+xlcG3xkjjc+PSRnhd5UsyyrfiicWGnFz1uctpdWcWdVj/M6
 Wz6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmYbd6Z9KU6EaYjAhiZOP0vQRzva0Yfo+6DiwlEJwSWh4MNymLr7Xj1eGXV5X+YGjmv1QwNQM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxa6Jzkm3XjNWjMoQR7Blj1dQnwJ1PhOHcfHlU2rxXY78XMbRAv
 f1AgxXhxwKKazqc7w3oHYwEMcH2eOnz4BiT5yvAFJpQKlkYdlir9KoufW647QwbJ71E=
X-Gm-Gg: ASbGnctxMMLSUXvPWj/Z2DSmTFiCkNJcqaIEwBQ25TvIzkpGrtspye2m/8OJH28RXYs
 W8dttmOrWO+UoyhnoOqjPHUY3HMFhRybvBqmyXjDM/8/qzCtNM5RLdsEnrwhroxOJ5rCuI4WTxU
 fiU2/GgudaXD8sZOnRl9GmYomplVHe6MvyoxBR6Y9TsEcBRWBz75HKzAHNjZtGwKTbJRTUbDGU/
 bgc7Bo7vYyeHfJHbgrX3/sG+rxNZiDzF11mSWj4fWkp+hq53RmvKFGlPwkrp89eCn6tAzLmHpdz
 I4SQ21u5sOh7LauyySAh7gX7/hvsWL3wuzAJZufEp5pTtK2KiCAPnOWE3FY=
X-Google-Smtp-Source: AGHT+IGB1DNkmDp8S5lCgA5DtPs9LUwvSrLAjB8lxrCHO7OOjz+KApT32qkKQ7Wrh2IvTQ/CNiB4sQ==
X-Received: by 2002:a17:907:940d:b0:ad8:9466:3354 with SMTP id
 a640c23a62f3a-ae057cc5eb2mr1248796766b.54.1750680626749; 
 Mon, 23 Jun 2025 05:10:26 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae054209a2dsm711970966b.174.2025.06.23.05.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:26 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 00/22] am62: IO+DDR resume support
Date: Mon, 23 Jun 2025 14:08:23 +0200
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALdDWWgC/4XNywqDMBCF4VeRrDsllxqwq75H6SKXsQ5UI4mEi
 vjujVIodOPyPwPfLCxhJEzsWi0sYqZEYSihThVznRmeCORLM8llzRXXMIWRHJheS6DgfYS8nYB
 fIDoB3CrD2xYbaQUrxhixpffu3x+lO0pTiPP+Lott/cpCHMi54KC19tg4wWtnb9bML7IRzy70b
 MOz/IFaqCNQFlB5qZQxaFRd/4Hrun4A19CjTR4BAAA=
X-Change-ID: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1
To: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, u-boot@lists.denx.de, 
 Kevin Hilman <khilman@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5374; i=msp@baylibre.com;
 h=from:subject:message-id; bh=+VB5lHPtNLjnG4z4VAu4p6zoIwUzotYffcjH5IHPSOg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxI5wMzP66SizDwXJyX9PRvXUBG/veZM2d5cMfzrbhlJ
 ft3iUl5RykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzEo56RoeUDh/Fylo9NLf8M
 A2Nuh0QpfXuzUE/u6tzTvxoOlxw0KGf4K3LR6JBr4Jrf9y98cv37S/ddvZLx0YfmfE4Py+JdHmf
 F8gEA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 23 Jun 2025 14:23:35 +0200
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

Hi,

this series introduces support to resume from IO+DDR. IO+DDR is a low
power mode of am62a and am62p in which nearly everything is powered off
except DDR which is in self-refresh and a few pins which detect
activity and can wakeup the system again.

On resume uboot SPL is loaded and checks if this is a IO+DDR resume. If
it is, the DDR initialization sequence in k3-ddrss differs slightly as
it has to get the DDR out of the self-refresh.

Afterward a specific address determined from DT is used to get the
metadata that stores relevant context addresses. The context is restored
using the tisci message TI_SCI_MSG_MIN_CONTEXT_RESTORE. At the end all
further initializations are skipped and uboot SPL directly jumps into
the DM resume address which takes care of the rest.

The devicetree R5F related patches were picked up from the devicetree
repository tag v6.16-rc1-dts and are required to find the correct
address of the metadata. I picked some additional patches to avoid
conflicts.

k3-ddrss is using absolute register accesses at the moment. I am trying
to submit syscon DT patches upstream to access these through syscon,
unfortunately there is ongoing discussion regarding syscon.

This series is based on next.

I tested this on am62a.

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
Changes in v3:
- Use wait_for_bit helpers in k3-ddrss where possible and add panic
  messages for easier debugging
- Link to v2: https://lore.kernel.org/r/20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com

Changes in v2:
- Remove 'default n' from K3_IODDR
- Pick devicetree patches from upstream instead of mailinglist
- Link to v1: https://lore.kernel.org/r/20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com

---
Devarsh Thakkar (3):
      arm64: dts: ti: k3-am62a-wakeup: Add R5F device node
      arm64: dts: ti: k3-am62a7-sk: Enable IPC with remote processors
      arm64: dts: ti: k3-am62p5-sk: Enable IPC with remote processors

Hari Nagalla (2):
      arm64: dts: ti: k3-am62a-mcu: Add R5F remote proc node
      arm64: dts: ti: k3-am62x-sk-common: Enable IPC with remote processors

Jai Luthra (1):
      arm64: dts: ti: k3-am62a-main: Add C7xv device node

Judith Mendez (3):
      arm64: dts: ti: k3-am62a7-sk: Enable PWM
      arm64: dts: ti: k3-am6*: Add boot phase flag to support MMC boot
      arm64: dts: ti: k3-am6*: Remove disable-wp for eMMC

Markus Schneider-Pargmann (13):
      arm: mach-k3: Remove CANUART IO isolation
      arm: mach-k3: Kconfig: Add symbols for IO+DDR Low Power Mode
      ram: k3-ddrss: Add support for DDR in self-refresh
      firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
      arm: mach-k3: common: Add CANUART wakeup check helpers
      arm: mach-k3: common: Add lpm_resume_from_ddr
      arm: mach-k3: common: Helper for LPM meta data address from DT
      arm: mach-k3: am62a7_init: Resume on LPM exit
      arm: mach-k3: am62p5_init: Resume on LPM exit
      arm: dts: k3-am62a: Add r5 device nodes
      arm: dts: k3-am62p: Add r5 device nodes
      configs: am62ax_evm_r5: Enable IODDR resume support
      configs: am62p_evm_r5_defconfig: Enable IODDR resume support

 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi              |  16 ++
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi              |  20 +++
 arch/arm/mach-k3/Kconfig                           |   8 +
 arch/arm/mach-k3/am62ax/am62a7_init.c              |  11 ++
 arch/arm/mach-k3/am62px/am62p5_init.c              |  12 ++
 arch/arm/mach-k3/am62x/am625_init.c                |   2 +
 arch/arm/mach-k3/common.c                          | 162 +++++++++++++++++++
 arch/arm/mach-k3/common.h                          |   4 +
 arch/arm/mach-k3/include/mach/hardware.h           |  32 ++++
 configs/am62ax_evm_r5_defconfig                    |   1 +
 configs/am62px_evm_r5_defconfig                    |   1 +
 drivers/firmware/ti_sci.c                          |  38 +++++
 drivers/firmware/ti_sci.h                          |  14 ++
 drivers/ram/k3-ddrss/k3-ddrss.c                    | 177 +++++++++++++++++++++
 dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts        |  12 ++
 dts/upstream/src/arm64/ti/k3-am62-phycore-som.dtsi |   1 -
 dts/upstream/src/arm64/ti/k3-am625-beagleplay.dts  |   1 -
 dts/upstream/src/arm64/ti/k3-am62a-main.dtsi       |  12 ++
 dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi        |  25 +++
 .../src/arm64/ti/k3-am62a-phycore-som.dtsi         |   1 -
 dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi     |  25 +++
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts         | 139 +++++++++++++++-
 dts/upstream/src/arm64/ti/k3-am62p5-sk.dts         |  51 +++++-
 dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi  |  35 +++-
 dts/upstream/src/arm64/ti/k3-am642-evm.dts         |   1 -
 dts/upstream/src/arm64/ti/k3-am654-base-board.dts  |   1 -
 .../ti/k3-am6548-iot2050-advanced-common.dtsi      |   1 -
 dts/upstream/src/arm64/ti/k3-am69-sk.dts           |   1 -
 include/linux/soc/ti/ti_sci_protocol.h             |   9 ++
 29 files changed, 786 insertions(+), 27 deletions(-)
---
base-commit: dbf7fd557a73ded3141db3c2cf5c572989378825
change-id: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>

