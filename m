Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8A6C28B30
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DACBD81D5A;
	Tue, 11 Mar 2025 14:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XXHyqdax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA80B807D7; Tue, 11 Mar 2025 11:33:22 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD3F181878
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2902f7c2aso388192366b.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689166; x=1742293966;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCzZqHEDX+nt2cGsMA7agwqeglVZ1PHGFHx2neFF224=;
 b=XXHyqdaxGBsy5eD8bdevVVaEWo1DnU0uH7ZHGCM2lmJNUu2fObgArOP0+e6TUKm5jx
 stAJhpBLaJ4v8Vth2xJy/kyd85OuwkYJowrDwgV/Yl5Zl/j0HTnim7jhQxMUl6XRpJam
 12XvqjGqC/UIIqDkMmOYTHyGYYJGofFzayni4vxEo2WD0xqnnnhr4VRhavzf6S9L8r+R
 MeN40F3lXfkUMAp2K5VP+xmlRX9avr+6f2yFFnEtyMIRYx1TyEXQaJR8GxqPUlOdPKrE
 3EmUEXUyggi2Sy9I/BTvHF2qw4T03G98epl2063Qtt7oc1WmiHkknUBadl6LdV2zz2Dz
 FVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689166; x=1742293966;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZCzZqHEDX+nt2cGsMA7agwqeglVZ1PHGFHx2neFF224=;
 b=rPlm/w34JBBDhQBRwLm/qUrWUkquYnkLElxhXMwU78AAoaQnXxlXtCpg/Bx7BILeU8
 0YeUKiO57AM6zPL4BSOoM88pGd8j9h3jDt10kygBkXX37YWJgLwrjv4Ioz9pHzzX3xKE
 mDopBZO6uDlJPLYT/1KUMwzKkcEI2gynZfg/mZeKFpfNitaDPVo/czruCPsRJAlooxoz
 gqjulzAzKVa32nktnUBKS7JSJ138v5/oQ+W3k317VNWSSGXJ5wfUYWvO0ubC1i+bZxwf
 ZQPYry18nikfUF0RP9dnwc5DOYpm0ZkMARt9P/bQok0xwrsXkaLnAl9fDBlWHFedSXTU
 F1eQ==
X-Gm-Message-State: AOJu0Yyv9OY4QCy79APh/zLF3PcxbVsN/F/WIeDcCjzFwsLXdBtXSycy
 VH0sMxL5F6X1QHs7TQgLlcQ6mb5QRbh/Udob7UUNNROdvHwIYj3EjQeeXSpz3SUmgLvLjGT+LTX
 +
X-Gm-Gg: ASbGncvajJBNf0J0IbaCW//SPM0XGvsbRy+49pHs0BJb7HApaYmcrZFwPdRQYsgY++G
 59GgbkYAFHJIvOkuxUCLSy+h4MShM5D9vlUq9rA2IkuYu5yVhxRT1Lirz+Zu1P73tR+ifMPZaIR
 aOpJ+QJfcY3NnEjhgN1mHRsg4LUWg0dcBQh/pUbbFkx0vcw3dJCVvIrMGj/i0JoABd83ViTvFSb
 XQRjQ1cM2AivgYPVdlLvgLDyGtf7zxyHbEC42z/vGWuWA2XIf5+j8KM/45FJi538WJzYFPgf1W5
 Wavahq04MWzJ4BEyMf0kI2HeafIbKu19CV0lM7/4
X-Google-Smtp-Source: AGHT+IF5JGCMPlBrW7X7OWgd1ljZZ7MYn9jkLX3mkVdmhpb1QaALR1S66TU+5j9tmNGRSabT4gnZrA==
X-Received: by 2002:a17:907:9691:b0:abf:6a53:2cd5 with SMTP id
 a640c23a62f3a-ac253035876mr1974614766b.48.1741689166442; 
 Tue, 11 Mar 2025 03:32:46 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac2394859b2sm905580466b.69.2025.03.11.03.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:32:45 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 00/19] am62: IO+DDR resume support
Date: Tue, 11 Mar 2025 11:30:39 +0100
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM8Q0GcC/x3MQQqDMBBA0avIrB2YRBvQqxQXMZm0s2gikyKCe
 PemLh8f/gmVVbjC3J2gvEuVkhtM30F4+/xilNgMluyDBnL4LZsE9B9nUUqMivs/IY2owSCtg6e
 UeLKrgfbYlJMc9/+5XNcP/DNmFm8AAAA=
X-Change-ID: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Hari Nagalla <hnagalla@ti.com>, Judith Mendez <jm@ti.com>, 
 Andrew Davis <afd@ti.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4498; i=msp@baylibre.com;
 h=from:subject:message-id; bh=KEq7Ww1k9cCrW4XNnaFzLM5MiqBiLO+WWgU3UOi2Bkw=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCLw4oqcU5Mdcx2q36XBmaI34kfrJz7SMk3+YzVh+u
 +auzjvjjlIWBjEOBlkxRZa7Hxa+q5O7viBi3SNHmDmsTCBDGLg4BWAiW7QY/inac5hMu9xQejSQ
 VT+bdevUZfEG3t9tK7r/2my/snTi5yUM/0OUJ65O0FKrz7hlLvyX71++b1Gx4Px2q52aJ4QzGZT
 b2QA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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

Afterwards a specific address determined from DT is used to get the
metadata that stores relevant context addresses. The context is restored
using the tisci message TI_SCI_MSG_MIN_CONTEXT_RESTORE. At the end all
further initializations are skipped and uboot SPL directly jumps into
the DM resume address which takes care of the rest.

The devicetree R5F related patches were picked up from the mailinglist
and are required to find the correct address of the metadata.

k3-ddrss is using absolute register accesses at the moment. I am trying
to submit syscon DT patches upstream to access these through syscon,
unfortunately there is ongoing discussion regarding syscon.

I tested this on am62a.

Best,
Markus

To: Tom Rini <trini@konsulko.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
To: Bryan Brattlof <bb@ti.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de

Cc: Vishal Mahaveer <vishalm@ti.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Dhruva Gole <d-gole@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>
Cc: Kendall Willis <k-willis@ti.com>
Cc: Akashdeep Kaur <a-kaur@ti.com>

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
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

 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi             |  16 +++
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi             |  20 +++
 arch/arm/mach-k3/Kconfig                          |   9 ++
 arch/arm/mach-k3/am62ax/am62a7_init.c             |  11 ++
 arch/arm/mach-k3/am62px/am62p5_init.c             |  12 ++
 arch/arm/mach-k3/am62x/am625_init.c               |   2 +
 arch/arm/mach-k3/common.c                         | 162 +++++++++++++++++++++
 arch/arm/mach-k3/common.h                         |   4 +
 arch/arm/mach-k3/include/mach/hardware.h          |  32 +++++
 configs/am62ax_evm_r5_defconfig                   |   1 +
 configs/am62px_evm_r5_defconfig                   |   1 +
 drivers/firmware/ti_sci.c                         |  38 +++++
 drivers/firmware/ti_sci.h                         |  14 ++
 drivers/ram/k3-ddrss/k3-ddrss.c                   | 165 ++++++++++++++++++++++
 dts/upstream/src/arm64/ti/k3-am62a-main.dtsi      |  12 ++
 dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi       |  25 ++++
 dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi    |  25 ++++
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts        |  96 ++++++++++++-
 dts/upstream/src/arm64/ti/k3-am62p5-sk.dts        |  50 ++++++-
 dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi |  35 ++++-
 include/linux/soc/ti/ti_sci_protocol.h            |   9 ++
 21 files changed, 721 insertions(+), 18 deletions(-)
---
base-commit: a517796cfa5d8f4ca2f0c11c78c24a08a102c047
change-id: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>

