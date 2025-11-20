Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6381ECF8864
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFD568409B;
	Thu, 20 Nov 2025 17:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bY5GVoqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E983883A6A; Thu, 20 Nov 2025 17:04:59 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 689CD83935
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:04:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-640d0ec9651so1597598a12.3
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763654697; x=1764259497;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L0dOZHpV+AqBwSIGD/nI0ettP4TyTOXkAOabN88/H00=;
 b=bY5GVoqfCu/itQ9CQ5jyhE7NKIpF8WqIA5p2MBQjlIoptpj/04cO7zJRvR2Quno8ut
 fLqF+pFm8vIY+uHYazOjXDeOv9gSDDyUoFjz6Dofq6HSgRAbll4uomkT9Ii4ImhR8wlc
 AEASe6p3jND9xLE5KcMhXgS1mQ2FiTAfccDRmS05YMllAH2SEk6h4r6sP1giZBAmTTf+
 1Qw6f0M5QD4dCux77JIfLFHAl+sUR3KP6so59S/5adKa1XkXeo0EFlrEMwmRm08Rum1z
 8HwQryrjatygDsFNEj797wHDVuaI5Lutn5H7OtPWFy4Q8AuLWf1PIW+cr36Rdb3o4IXN
 BufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654697; x=1764259497;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0dOZHpV+AqBwSIGD/nI0ettP4TyTOXkAOabN88/H00=;
 b=T45kisoXcsU5lfVX+hazGrcaTigZ45oxYpOq2w9+8QELwjPIJA86q3uYkVDPr49j1C
 YV6lY12u98SCIIZUkMbW6h+07QNshkbiGmX+HofwMfSqLR2/cAaSscIBECSLkG+J+0dh
 kAaWmUFh7zenvLaORLLCTRERFJLS+uMbEmLNkBQMS/UPhqzTGurjztP0NJOAqwgIlT6P
 4IhyO21z+nL5mrd6MdncYa1zt3uni5FI/AmsjiBmiIMmJKvPkbqAvbfN+H6yvchDXF70
 gr6OYrLXfkjjJ/cwO/Az6dFBe8KEr5YiGnuY1DSekNb6WQZsHTmwcf5z8/BI0L20RS3O
 orNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2L1EgO2y1QTauXNgdsw9juFDjvZV0WKOGW6jFUSkVzsNUpk2FbZDW8qAcCGUw88RauauIBVs=@lists.denx.de
X-Gm-Message-State: AOJu0YxQEBiRT5fgDmsOwB5eTZbKvfyco6PFkJJcgN7zqiQCwyFoISoX
 SkCDH2Fs/51NdLadryt3XejYFVQP6hokKwtfF4ioGgrC9InkHlPBtZ0Hci3F8G70GvQ=
X-Gm-Gg: ASbGncsF4Bb406f5cNaE2JKBHAJc1/tuw4SrvOzxCpuw0GTzWvbnkEcMoBIPYy92dE7
 YHpJ4DYgY5rfHbS6BpzqISPXvB6RstrWGwdddsgi3H5jpAgYXcBN2X9AqEB1H0GnVwBxEhk6Qua
 9bMNDROhkzcYua119Gv7GPUrJTIT3YqNIjj+jGEDfKGB08nZ1pT4+RuLpfPxntcZG+mP1gIrcgj
 kVTllkZDEJXyyn+1MPJ/01dfyTFbjllfBU2EpEBmHlpeaNt7F/wKTRURP+5I76tFUbavZgnzH3w
 3cm8qpQybMO0q/WZI10D9ABUsuVgi1f+ytfr+Oi/zy/2GdVwYuEAiP2SBhnShpE5+RHvRIvDjES
 YKgYDLifuf+OC+iuEs1vn1x65eckwgedekqjzU/tBCpfJPPBhEZ70oyHMQdGI6xeqVOoyK/49z3
 Vs/EdGhVM=
X-Google-Smtp-Source: AGHT+IGIxMKVUWKkR0TRVEHLOfO0yw8pzfNTGvsTZUVSAvYGbddbNluPyeVu7dgpC7qFk8mJfRjzdg==
X-Received: by 2002:a17:907:97d2:b0:b73:7280:782a with SMTP id
 a640c23a62f3a-b7654fc85e0mr380180266b.36.1763654696652; 
 Thu, 20 Nov 2025 08:04:56 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b7654cf0435sm238861266b.4.2025.11.20.08.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:04:56 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v6 00/13] am62: IO+DDR resume support
Date: Thu, 20 Nov 2025 17:03:17 +0100
Message-Id: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMU7H2kC/4XQTWrDMBAF4KsErasyP7aIu+o9ShdjadQImijIw
 TQE371yKE2hBu3mzYNvYG5m0pJ0Mi+7myk6pynlUw3uaWf8QU4falOo2RBQDwzOXvI5eStHRzb
 lEIqd18pCZ4tHCyMLxKgDjWiqcS4a09fdf3uv+ZCmSy7X+7kZ1+2PjNiQ54pb51zQwSP0fnwd5
 fqZxqLPPh/Nis/0AB1yC6QKciBmERXu+w2Q/4DUBLmC0gVhIo9O4gbY/YJYv9kCuwp2XiPuJQK
 R2wD7B4jYBOtkhz2oArDz/8BlWb4BOMNkpxECAAA=
X-Change-ID: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4507; i=msp@baylibre.com;
 h=from:subject:message-id; bh=nOZ/NsBoO+843Al2AR7C+tONqMFK8ykSH0KUmdE+eA8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkx569MuXyaWc1sdnnXUJLLr8gpWpd93haZbnVLxN57Kn
 nh92U75jlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZgISyDD/8L7ZxRX7XjEM+XH
 Z603HH/qcu7ea5/99Jyur7m58OkbKz0YGQ41u9xncFpbvOY6w6ZO412m5udlTl0u/8h561Dapew
 mYX4A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 20 Nov 2025 17:09:03 +0100
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

k3-ddrss is using absolute register accesses at the moment. I am trying
to submit syscon DT patches upstream to access these through syscon,
unfortunately there is ongoing discussion regarding syscon.

I tested this on am62a.

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Changes in v6:
- Add comment for last part of removing can io isolation
- Only mention a single kconfig symbol in the commit message
- Add defines for timeouts in k3-ddrss
- Link to v5: https://lore.kernel.org/r/20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com

Changes in v5:
- Fixed compile warnings
- Link to v4: https://lore.kernel.org/r/20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com

Changes in v4:
- Copy lpm_meta_data into the stack to be able to debug unstable memory
  issues
- Add missing comments about ctx_lo and ctx_hi
- Use absolute addresses for k3-ddrss CANUART_WAKE_STAT1 and
  CANUART_WAKE_OFF_MODE_STAT to avoid using addresses outside of the
  range given in the devicetree
- Remove the cherry picked devicetree patches as they are already
  included now
- In lpm_resume_from_ddr() print upper and lower 32bit of the meta data
  values separately.
- Link to v3: https://lore.kernel.org/r/20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com

Changes in v3:
- Use wait_for_bit helpers in k3-ddrss where possible and add panic
  messages for easier debugging
- Link to v2: https://lore.kernel.org/r/20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com

Changes in v2:
- Remove 'default n' from K3_IODDR
- Pick devicetree patches from upstream instead of mailinglist
- Link to v1: https://lore.kernel.org/r/20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com

---
Markus Schneider-Pargmann (TI.com) (13):
      arm: mach-k3: Remove CANUART IO isolation
      arm: mach-k3: Kconfig: Add symbol for IO+DDR Low Power Mode
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

 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi    |  16 +++
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi    |  20 ++++
 arch/arm/mach-k3/Kconfig                 |   8 ++
 arch/arm/mach-k3/am62ax/am62a7_init.c    |  11 ++
 arch/arm/mach-k3/am62px/am62p5_init.c    |  12 +++
 arch/arm/mach-k3/am62x/am625_init.c      |   2 +
 arch/arm/mach-k3/common.c                | 167 ++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h                |   4 +
 arch/arm/mach-k3/include/mach/hardware.h |  32 ++++++
 configs/am62ax_evm_r5_defconfig          |   1 +
 configs/am62px_evm_r5_defconfig          |   1 +
 drivers/firmware/ti_sci.c                |  38 +++++++
 drivers/firmware/ti_sci.h                |  16 +++
 drivers/ram/k3-ddrss/k3-ddrss.c          | 180 +++++++++++++++++++++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h   |   9 ++
 15 files changed, 517 insertions(+)
---
base-commit: e34d01d23e45e007368685ffa6dfd674b6dd7b17
change-id: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

