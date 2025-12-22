Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C3AE69166
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 20:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA85783B99;
	Mon, 22 Dec 2025 21:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PNA3YuIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 246EB83D1A; Mon, 22 Dec 2025 21:02:52 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CD5F83B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so26953865e9.0
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766433768; x=1767038568;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tGjtCu1OGwnYCdUAdpPnMj2wjs6uJtwtaNowjfX2TmM=;
 b=PNA3YuIBqt+5RBA1Iy+1po9l+WZ6V/EuP0rfhSi7lcO25mdmDY9f1AiFJO5Z+fpQDK
 X/Df6m0D4ktohPx4DOX+F5OcZ04unvRaKhoW1JxbSyIxU3soTSUhu51CRfPUqICzytd7
 42l5AR9cTg2474XjX2//D8alYMa/3PrCIySpBgJMFt0h9jwkSbIQtcIY0yJ1hL+O98Qq
 Caojbcjjw0cM+88you9/eVKggLVwWSmGHtSnR6dLhRve30WZNcglRyFvIJ0z5+RzQFYc
 HG2gVWXafUEapTLP1dnCaUaQX+Ud9xtxRR/j7F+KfPjrQxaPHpJbK01qyYkhwJ5pwWrI
 cdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433768; x=1767038568;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGjtCu1OGwnYCdUAdpPnMj2wjs6uJtwtaNowjfX2TmM=;
 b=vaFC+b3kqECJpt3WOgpfwKhfX02YDvZdEbORlRW1KAqHDj7H78dX9iQWE/8760cy9n
 H0MHTNu01RbyI+jjYkGgjQ4szUWbeer+8ReZlfp0PmWcvS969ijUR1vM9WcnrCWd3rk1
 p7es+B9VHoQVdCS+ph7MuM1ruNchOxMk/l+kGGBqcB9zhBQhdMeABZ6Ph8fqeFKTTNzr
 QS9yOHAY4uZcu1nBREg5H8XPuQAXWCs5cKG4muksXfGtV1iUvwmbGcaFklsfT2dd5wDj
 JvCk7DWXzaDUY6VRP2a/Q2ihAetcuPVeEX++pMKU3HPRi/MGN4WVOeUwEWlHuYrmCept
 aPAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMcEUsXx6pIYUenPSJqudvZhh8ZP4csT5Dc9seb10V8U7MPNW+07JgJ9CITXwtGZCgGs8AKjA=@lists.denx.de
X-Gm-Message-State: AOJu0YzCpt4REVaGbuskeiD4vjA7A7XEaUnGLUwsFq44ccCNg+aJ/5uS
 uEUDxazJGT3g4bDcWPonoiT0e7stJsft1/PKbkecLjnFJ3SK5mJCIt5FAvqjZiM/NgY=
X-Gm-Gg: AY/fxX4z3XTRhTHYMLlkM6rJcJmfcwxH2kMlZWfK6YmWlgUnsmy7m5/AG8nOjWhhXbn
 dGcJla4b/1/g6UpPdgSyxMTEor+uzUU5sbh2CG6wWtltM4V5JdcGyJK3+iSido03jbVuhvTxuRI
 1tOwyrVagoIaatPQowz/KdwCbDPGoLuGDMJZilcyq2t9H6M5+HOzsT3LGjbMZpuN3CLeRPXW0sX
 OvBPVaZ5c36lrXXCHbfZrQbtHMIjc4EsrKjatbSz8VwS61ZhUwqf63CBDsCfg/2VWIHXJJvt3a6
 5i0ZCEtUx67f56D6LlwpEVHpoz/vluB6FhshmXY3w7frn6guHI38Xjw+5H8xoAGFRNwss48hO0h
 /DmmImYa0ZRLyPJP3RohEkX1loSV5yIG+D3holuMrLIgeggyD2+BIEyq1qwMVqac86eoevBXSIn
 eB94EOQijj
X-Google-Smtp-Source: AGHT+IGbKpIxmD+mpvf68DwZMo9nYLVdYiXQGDCXwuo0Rary4sayL0pyLYMeCobELhhS8xYj5ekC4Q==
X-Received: by 2002:a05:600c:154e:b0:477:76cb:4812 with SMTP id
 5b1f17b1804b1-47d194bbcf0mr121737215e9.0.1766433768448; 
 Mon, 22 Dec 2025 12:02:48 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3af6dbdsm103604985e9.19.2025.12.22.12.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 12:02:47 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v8 00/13] am62: IO+DDR resume support
Date: Mon, 22 Dec 2025 21:01:21 +0100
Message-Id: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJGjSWkC/4XRzWrDMAwH8FcpPs/DkhIl6WnvMXbwh7wa1qY4J
 ayUvPucMtYyAr75b8FPQrqpSXKSSe13N5VlTlMaTyX0LzvlD/b0KTqFkhUabA0Z1pfxnLy2R0a
 dxhCynteSNo3OHrRxZE2MMqADVYxzlpi+7/77R8mHNF3GfL23m2H9/ZUBKvJccM3MQQYPpvXuz
 dnrV3JZXv14VCs+4wNkoBqIBaSARNaKpbbdAOkJxCpIBbRNsITogW3cAJs/EMo2a2BTwMZLhN5
 Gg8gbYPsAAapgeemhNyLGEPtNkJ9ArIK8HiWEYbAdduC2jtI9QKxP2BUwApCDlmNP/3e4LMsPU
 5itsrMCAAA=
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
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5669; i=msp@baylibre.com;
 h=from:subject:message-id; bh=MiG9lzaS3GnCSlCL325WjuQk3H6XtRgwJA2D2XtguSg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzPxVNa/jFLNe/POnX8w/obrO/WSYV7OvNOuxnuZHfEw
 8f/4cmKjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIuX2MDOs+OLAIi1Wenp/S
 sKZVNXe/7GqF8OLomuPhj7LXJG1/68LI8J8nSMZ97UpWsQMHndZ1LdkaMv9gweVJqokpM3/ofOY
 9wwoA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 22 Dec 2025 21:04:36 +0100
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
Changes in v8:
- Create and use am62xx-lpm-common for am62xx lpm common functions
- Create platform dependent functions in k3-ddrss in k3_ddrss_data
- Align am62a and am62p initialization regarding caches and QoS
- Link to v7: https://lore.kernel.org/r/20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com

Changes in v7:
- Removed parent nodes bootph-pre-ram properties as not necessary
  anymore.
- Added missing new line in
    arm: mach-k3: common: Helper for LPM meta data address from DT
- Split off LPM specific ddr code into its own file k3-ddrss-lpm
- Rename lpm_ops->restore_context to lpm_ops->min_context_restore
- Pulled patch to add wakeup check helpers before the IO isolation
  removal to remove later cleanup of
  wkup_ctrl_remove_can_io_isolation_if_set()
- Some reviewed-bys and tested-bys removed due to changes in the
  patches
- Link to v6: https://lore.kernel.org/r/20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com

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
      arm: mach-k3: Kconfig: Add symbol for IO+DDR Low Power Mode
      arm: mach-k3: am62xx-lpm-common: Add CANUART wakeup check helpers
      arm: mach-k3: Remove CANUART IO isolation
      ram: k3-ddrss: Add support for DDR in self-refresh
      firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
      arm: mach-k3: am62xx-lpm-common: Add lpm_resume_from_ddr
      arm: mach-k3: am62xx-lpm-common: Helper for LPM meta data address from DT
      arm: mach-k3: am62a7_init: Resume on LPM exit
      arm: mach-k3: am62p5_init: Resume on LPM exit
      arm: dts: k3-am62a: Add r5 device nodes
      arm: dts: k3-am62p: Add r5 device nodes
      configs: am62ax_evm_r5: Enable IODDR resume support
      configs: am62p_evm_r5_defconfig: Enable IODDR resume support

 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi  |   8 ++
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi  |   8 ++
 arch/arm/mach-k3/Kconfig               |   8 ++
 arch/arm/mach-k3/Makefile              |   3 +
 arch/arm/mach-k3/am62ax/am62a7_init.c  |  14 +++
 arch/arm/mach-k3/am62px/am62p5_init.c  |  14 +++
 arch/arm/mach-k3/am62x/am625_init.c    |   5 +
 arch/arm/mach-k3/am62xx-lpm-common.c   | 220 +++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/am62xx-lpm-common.h   |  19 +++
 configs/am62ax_evm_r5_defconfig        |   1 +
 configs/am62px_evm_r5_defconfig        |   1 +
 drivers/firmware/ti_sci.c              |  38 ++++++
 drivers/firmware/ti_sci.h              |  16 +++
 drivers/ram/k3-ddrss/Makefile          |   1 +
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c    | 181 +++++++++++++++++++++++++++
 drivers/ram/k3-ddrss/k3-ddrss-lpm.h    |  20 +++
 drivers/ram/k3-ddrss/k3-ddrss.c        |  26 +++-
 include/linux/soc/ti/ti_sci_protocol.h |   9 ++
 18 files changed, 591 insertions(+), 1 deletion(-)
---
base-commit: 0e0a198a68be71148f5ec27ef86796174f91436f
change-id: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

