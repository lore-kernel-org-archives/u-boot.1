Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316D1D3C924
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C7F4836C8;
	Wed, 10 Dec 2025 16:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vNk9Wgnw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85CFA8389A; Wed, 10 Dec 2025 15:10:51 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DFE580077
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6418738efa0so12078493a12.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765375848; x=1765980648;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TDl3bqdBjTR77TjGRSAF/OvISEL8aq8r10OKTWhg67I=;
 b=vNk9Wgnwz6yLnPE0m8iGLXqVRVmfAgTEjy+xq3697I6GcnNyy44hL9MkEipFjK+r8q
 DvPhucg879P0d9iLtqR+jCfrPdPZdrDk/g3tvu1hgA99C5Fauj1fsKyhLCXZdeG/K7U5
 uUceYCmycpB3v6LNoNin+U4etdlXeDTzs4teJh0Ed39b4U5hl73pfh02ew0q9PW3LOUh
 bi1XdqL75hejjrB9786lg5maSXYKBMvuMbGlu4+k/nUv2J8Rrig/PpADON2Y3uYThzHt
 ehTaTDKZwKUb/LzGZEwHoz1I4BrqHzJxJOuMzbb+My/7LEtFctNTZZY4jRB74JGPVd/V
 yotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375848; x=1765980648;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDl3bqdBjTR77TjGRSAF/OvISEL8aq8r10OKTWhg67I=;
 b=bPUNSlvMDTB0od+8CNpQv7Lyq97fwLhHQYDqwHMhNGYn5t4ys5DL4d06o2LRcZx3FZ
 gWDAaN44lItI+bzarz1wwds25UBD8TlCIdjGN1ItKTNsySmomLKsVJPb/wSR4A5X3bnq
 qDl5jDfPX8UmyiCGPfaueLUpl9AMUFLW30GrizcFfSKlicrmsJ/EyEdXhA5W+HY9vRBq
 szMC9UQ3yRHMGnVjz1/zNaI9OO/8RIPRjePPaL73bKnkJosFkLXucV9l4udNrbYIpa39
 nzQNb04g0suSdpLBd4OSUE9g/JmpCBakHEv+IhfE3FrVyaZHAEeHXqVZOGJWkwfwehth
 8MXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKHEVawjoH4FQgSi6tAd4RvJpY5CqjfYh2nbIVnP2Mj6oOAfnBa994WSQWLDpefPA8vdiW5Lg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+pD24UiSaLpMUiKPR0p4xdD60RqoCKbKreQhIeVJR3v80UlqM
 03IltEJuZuLUnW5arAfKeHAQPTiTbYvzkBNsAs6Fk8WuK4IZFL3dqTGdCYLLtxQT+zljIVgZkrv
 fI/cb
X-Gm-Gg: AY/fxX4tETXiVGkW9bNgn4k3TUeHPKhiz/gvihiuSMcUYX/E39OnjZ2jAUDdQzUml51
 ZUJ/fOdCGUdqQByQxEECJ4QsIz5EFfJgI5AeTI/2qSl8LOPSSwl7zUHn9y5Mp7VhiA5Lc8XeKho
 q3zu68UVuES656YlfdQNbxKCQ4rFZ7lxV/dqbGLV32fzJiA4AzIjcyNXxeDj0SqvExLvwKlDsUA
 WvevC+N6fLMyR6CNMT5I8FbkXkT2ijpEF8Jbp9KJPu+SLGdf4Z6o8awXDv+EsPpzPTd0lu6v2Kj
 X5ySdjamPvGxG7W2qWp5ZbFCkEnsMrmMcot39FJSQlVYKTQICWgrAXSHxOw/kdyqL0iX0nPjiYE
 QcqfD/edpXZ6gsE87DFSNSBEvFjEUacLcd28LYeiA5lepxLbqH7+f1IMkTrpX36hzlrxqRYPfAz
 oKqJ6U2/nPXFjUFGhZ7bQ=
X-Google-Smtp-Source: AGHT+IHnKuqec1YjeYwdymlsnUJIjVTsy60wGcEHdydt4FsIvuaZT4fpVfHjBMDS1/EHFvua9toB7A==
X-Received: by 2002:a05:6402:2816:b0:649:2368:4d64 with SMTP id
 4fb4d7f45d1cf-6496cbd3b2fmr2432625a12.26.1765375848275; 
 Wed, 10 Dec 2025 06:10:48 -0800 (PST)
Received: from localhost ([2001:4091:a246:86d6:2b1a:7262:ad08:3918])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6496cb445b4sm2362059a12.17.2025.12.10.06.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:10:47 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v7 00/13] am62: IO+DDR resume support
Date: Wed, 10 Dec 2025 15:08:54 +0100
Message-Id: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPZ+OWkC/4XRwWrDMAwG4FcpPs9DkhOn6WnvMXqQbXk1rE1xS
 mgpefc5ZaxlBHzTL8EnkO5qlJxkVLvNXWWZ0piGUwnd20b5A5++RKdQsiKgFgxYfRnOyWs+WtJ
 pCCHraRlpaHT2qMEZhhilJ4eqGOcsMV0f/ue+5EMaL0O+PdZNuHR/ZcSKPBVcW2uD9B6h9e7D8
 e07uSzvfjiqBZ/oCVo0NZAKaAIZwyxs2nYFNC8gVUFTQG4CGyKPluMK2PyBWK5ZA5sCNl4ibjk
 CkV0B2yeIWAVLpfstiAAY61dB+wJSFbTLU0Loe+6oQ/f/KfM8/wCjm92DYgIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5330; i=msp@baylibre.com;
 h=from:subject:message-id; bh=D3ndXuP1nbiHbC2kSZEcgoKbOvD8Idv7PKJ0tOqj+pY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzLul+8FzMCkg7xLp7dMm/6CYWazr72jxNadoes+Ly7Q
 V9/TfGFjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIoiCG/5ViETe/Cry8O29u
 bePan30HlwTJzrww8/ymORzVb1hyph1mZLjH6Wy+qqGdvXl1uOGrfM4NTxdM4850epiywbT1TLm
 oDwMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 10 Dec 2025 16:53:41 +0100
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
      arm: mach-k3: common: Add CANUART wakeup check helpers
      arm: mach-k3: Remove CANUART IO isolation
      ram: k3-ddrss: Add support for DDR in self-refresh
      firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
      arm: mach-k3: common: Add lpm_resume_from_ddr
      arm: mach-k3: common: Helper for LPM meta data address from DT
      arm: mach-k3: am62a7_init: Resume on LPM exit
      arm: mach-k3: am62p5_init: Resume on LPM exit
      arm: dts: k3-am62a: Add r5 device nodes
      arm: dts: k3-am62p: Add r5 device nodes
      configs: am62ax_evm_r5: Enable IODDR resume support
      configs: am62p_evm_r5_defconfig: Enable IODDR resume support

 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi    |   8 ++
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi    |   8 ++
 arch/arm/mach-k3/Kconfig                 |   8 ++
 arch/arm/mach-k3/am62ax/am62a7_init.c    |  13 +++
 arch/arm/mach-k3/am62px/am62p5_init.c    |  14 +++
 arch/arm/mach-k3/am62x/am625_init.c      |   4 +
 arch/arm/mach-k3/common.c                | 171 ++++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h                |   4 +
 arch/arm/mach-k3/include/mach/hardware.h |  32 ++++++
 configs/am62ax_evm_r5_defconfig          |   1 +
 configs/am62px_evm_r5_defconfig          |   1 +
 drivers/firmware/ti_sci.c                |  38 +++++++
 drivers/firmware/ti_sci.h                |  16 +++
 drivers/ram/k3-ddrss/Makefile            |   1 +
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c      | 175 +++++++++++++++++++++++++++++++
 drivers/ram/k3-ddrss/k3-ddrss-lpm.h      |   9 ++
 drivers/ram/k3-ddrss/k3-ddrss.c          |  16 +++
 include/linux/soc/ti/ti_sci_protocol.h   |   9 ++
 18 files changed, 528 insertions(+)
---
base-commit: 0e0a198a68be71148f5ec27ef86796174f91436f
change-id: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

