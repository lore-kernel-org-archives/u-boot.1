Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06795C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 13:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D5DD82C65;
	Fri, 13 Jun 2025 15:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GVVfDISn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6268882D18; Fri, 13 Jun 2025 15:21:57 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB06782C30
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-604f26055c6so6068544a12.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820914; x=1750425714;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e0vKZibrfw5SiX7GUJgrBPLrA4zO8NCRhNOvF7wM8KQ=;
 b=GVVfDISnRcmJOah5WSsSTlpf65OBpEImiTKsm1//8pcFAdII72oZ//5TIlAnr4nJK1
 r3/tKEOGyDEhJI07wgnQVe0TziXmFDL5zO9F3qSDxJhfJf4dv8hHFKnN8z9Pj27790G6
 0LEW25urW1e6k9/ugxlynzE+K/cv/fdidsfxXk3G8zPh/XlUBvTTXLnHgyZtQb0bOnio
 LA6sLDDPmpSRLTLnDjlMU/hV9RJ8FN7mjQJHS3JArzmfdf9raZc87j/hdlOx9m+1vwwE
 xtyHsMmsowWTBINe4T4QhIMy9jVPIV81ah3sAh6DyAhHlA2ReFe/th74kXi1f1HOnl6T
 qMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820914; x=1750425714;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e0vKZibrfw5SiX7GUJgrBPLrA4zO8NCRhNOvF7wM8KQ=;
 b=K4AZxGcVfPVf3Mf8OxzCJyqEvFZNpnw6OQolmhb3fdVn6EbTiMkplM4rLnupPI0XcD
 XkJoC6trs/HfpP8GqNy/2vOdqIAeplB7Vo4j46+hnx9H07vvW60MexDg4eXfY7gW8xRo
 Zn+86HpKSXX5vsLa4mg9fTdj7TkYqou2NMUPUT7n4e6ke0t28lUjf4rsa/Q6uzVahuJ/
 YGhNhfaDEcCR7cntolI5X2eBnn4uL1ayDMk6PA28EOXzhC75ka4C3cpXPbyCJbo0ItfB
 bAAxRn++ybKoWThHyFN70VZxGbZbbJnvnhDiA1uHGc1/SchxoryoivK6lUkct0Ggp5/G
 oRjw==
X-Gm-Message-State: AOJu0YwiCeQ5YiU2luIi/wiKEs+UO6s4C3AD6tvK+3pXm5/RFkVuPCj3
 tc9ft3atvTfs0vR1qTOevrEvucXW0YjvSEr/Wp6j0kvVWs1tl2qiFcnRNGhPcmUrk5WbHoUy1tC
 mc+uK
X-Gm-Gg: ASbGncvSFly8PhpQvuXwlBM2ZDygm+4r5rmidExg7qWMsOqdC9jq6kyXj0aNHPxcsJz
 X/LRFP+a5XMaOa2aQtE3iTMFwYRT0ma7aijNMAiMB2fqrrvTHycz6ukRuGk6bxvmT0xiE7ZBSYX
 f14IzIkMFOsEfS0rYieTOfbvw3XnrelhuJbczpIa1LklQ5pms9i4d+VY6Jws6BJRFIf8s9mR+GM
 jmxGTn4omxNfiplzW2Kihza3g3gLI/bVY6u5GlUAvStXITp+UnytBsr3OwKl1VzY0O8l2XCtZUh
 KPzZ88Ihj3r6ywfdjHse3W92c5Q1xldb93kFy+wXQa7nWIINaoEbj5mLI/8=
X-Google-Smtp-Source: AGHT+IEpDmripWPvX3BYLxbyuTb0HcO4lLaaqzkxH7cKbZVihqN4uNUJCngf3RPnJq04T11n3LGEOg==
X-Received: by 2002:a17:906:9f88:b0:ad8:8e23:86ef with SMTP id
 a640c23a62f3a-adf53b4c800mr63502966b.4.1749820914321; 
 Fri, 13 Jun 2025 06:21:54 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec8900998sm126444666b.88.2025.06.13.06.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:21:53 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 00/22] am62: IO+DDR resume support
Date: Fri, 13 Jun 2025 15:19:20 +0200
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFglTGgC/4XNTQqDMBCG4atI1p2SxBqwq96juMjPWAeqkYmEi
 nj3Rum+y/cbeGYTCZkwiXu1CcZMieJUQl8q4Qc7vRAolBZa6kbW0sASZ/JgR6OBYggM+TiBvAF
 7BdLVVvY9ttopUYyZsafP6T+70gOlJfJ6vsvqWH+yUn/kXHAwxgRsvZKNdw9n1zc5xquPo+j2f
 f8CfRYTds0AAAA=
X-Change-ID: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5149; i=msp@baylibre.com;
 h=from:subject:message-id; bh=o+Ah4a4fIoArGPz4CxbrefAzgmKJbb3Mbjdflk2sTf4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1ZJdB/zvPopfe3NBQdHmOQ/eSAWZ5y+Nki3yF+bOL
 f3jor6to5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACaiEcTwh2ez8x7bLU5/0yYq
 VHvrqHBzXDjPHSS2e8lj9+VTZU48fMDw35239YOBVljUrjfqU4QOCT+znDSH/bpZMevJy/P+r20
 9yQQA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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
 arch/arm/mach-k3/common.c                          | 162 ++++++++++++++++++++
 arch/arm/mach-k3/common.h                          |   4 +
 arch/arm/mach-k3/include/mach/hardware.h           |  32 ++++
 configs/am62ax_evm_r5_defconfig                    |   1 +
 configs/am62px_evm_r5_defconfig                    |   1 +
 drivers/firmware/ti_sci.c                          |  38 +++++
 drivers/firmware/ti_sci.h                          |  14 ++
 drivers/ram/k3-ddrss/k3-ddrss.c                    | 165 +++++++++++++++++++++
 dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts        |  12 ++
 dts/upstream/src/arm64/ti/k3-am62-phycore-som.dtsi |   1 -
 dts/upstream/src/arm64/ti/k3-am625-beagleplay.dts  |   1 -
 dts/upstream/src/arm64/ti/k3-am62a-main.dtsi       |  12 ++
 dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi        |  25 ++++
 .../src/arm64/ti/k3-am62a-phycore-som.dtsi         |   1 -
 dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi     |  25 ++++
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts         | 139 ++++++++++++++++-
 dts/upstream/src/arm64/ti/k3-am62p5-sk.dts         |  51 ++++++-
 dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi  |  35 ++++-
 dts/upstream/src/arm64/ti/k3-am642-evm.dts         |   1 -
 dts/upstream/src/arm64/ti/k3-am654-base-board.dts  |   1 -
 .../ti/k3-am6548-iot2050-advanced-common.dtsi      |   1 -
 dts/upstream/src/arm64/ti/k3-am69-sk.dts           |   1 -
 include/linux/soc/ti/ti_sci_protocol.h             |   9 ++
 29 files changed, 774 insertions(+), 27 deletions(-)
---
base-commit: 548d997229b7929bd7f0782415952d5a85eb7e64
change-id: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>

