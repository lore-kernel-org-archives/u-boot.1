Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7885C79FA7
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 305DC83D71;
	Mon,  5 Jan 2026 17:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Nlk7MMQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 316258398C; Mon,  5 Jan 2026 17:41:18 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A91DE8398C
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so1266505e9.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631275; x=1768236075;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l1esc1KJoSiIJ6cJBludhh+KuQfvcY6p6He/8YmJVpE=;
 b=Nlk7MMQk2litaPuAx/bvtwOukLJ8rGDYKtdAfabET195Fnhv1Bd9sdcHKvYbTcFG9v
 imdVlusM2bLJbWAjQbrO4Taex9xa6A21gAq1LZXEfK9bGvsETJn5pOL/cgbichiL9ugz
 PupYXBJwnNGi6Bm7TEzmvNe5Sn7joHddCkZLF2vDg3sR+hWyFHNV6G7tI7WlsdpCns8j
 5fNGCrETasyGpoysTkvSCBUCfQLbH4lHiS8rXnmxOEmctcSEBD70KkcCL8Ez9RnI/zsg
 GeMaVWSzdv4PMatEC/VUX0wd4/bt1uUqXvQ+cY+HEWMbbJr+3JNlvK++rFOEqzWjiQ3m
 MFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631275; x=1768236075;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1esc1KJoSiIJ6cJBludhh+KuQfvcY6p6He/8YmJVpE=;
 b=UBtrMKXPzs8n3sKEekRUeb1Jurt9Ql5iPulVBKIrvM36ubM0b5FRf82r/kvwspoPdN
 pBIPqQBHAEZVpwM8ImEV7baeE+pwEKwZQBHNhMkGayijPToXEdf7NOgoDNG1aA5W8kXG
 q5d0pj9TCEf49J/1jyyZc9SN3VD0ZyrJEc+zq9KEFtnpJ8OpzBLXaruQzcJ553a+t9Fs
 BfzZD/tD51Vjap+X0JkO0/V8aGeujMbFvLQ9zlm0RC28586aeoE4l0iC0Y6NxXKNabZb
 uVZFN5WJTn4VVE7fei/7tQ3SOkVEir6kL4w9Ss29+le0fEVoZEc1UlX9bjjZVWO/3ngb
 Gxaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX3XWlOSiMmpZf0JeJt8lxDrhVolU3ameSofA3R2SIfj6ciVsOkDH5hl0Mi8aYtUjutA1B2RM=@lists.denx.de
X-Gm-Message-State: AOJu0YwQMKpfILOmwiqhx+sDhY5KQW2w3K5AJGvBwGaf4EW9XvedFlrV
 G+s7Ta+W4LWqKDETLO+/DTmc8C5tiyTnz72e61kVcT6fKjsNI13dweh/2nUoWnyOMRg=
X-Gm-Gg: AY/fxX64Omei9EVrMmabJcFG9xaOVnp6tHjaa2+Ml9BPAuXgsallpuETEpuZ6kO9RB+
 9YC63aPFLRBf8y1K16+gGzcESpFZlyi7tsr3bxRijnqw4aerR1LoygnBX5n+VNWxfzmG/ZuKbYJ
 4jW00tiLYOyVAYUpw3VtE79QWW2u70yUGodtwC9iwH6JxoSWP7xtrbtsOIWg9fiPCvSoWuiaBeh
 3ZeTqYVh+2+MxC4I/M4cIXwmnO69oHj/EKhy2p+ARru0Xutumv5Vf7AN8nBwUbT8m8N8LTTrwS3
 I2r4EAOBnk7TZfTHxcJOCg6I8VYD3cp7gu4cxa1um3qCe5rlhYwCQEMKDop0f03nvkzKxXDR9ta
 mnQ079An6rWXMxwoLD/073tPI9WZ1KaftqNJ38AflipZZv39e8g1GFw2x+wY79czdi8EDT6uO7S
 dWLcHcUdHp
X-Google-Smtp-Source: AGHT+IHRnrZzbo5gfK2e57pY68eL92uG6w62bqqgEZuaE/tqP+z3bIIy695st6n4A+c2nJvtDRsS4w==
X-Received: by 2002:a05:600c:4e90:b0:46e:3d41:6001 with SMTP id
 5b1f17b1804b1-47d1959440dmr659445825e9.34.1767631274919; 
 Mon, 05 Jan 2026 08:41:14 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d145162sm169493825e9.4.2026.01.05.08.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:41:14 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v9 00/13] am62: IO+DDR resume support
Date: Mon, 05 Jan 2026 17:38:45 +0100
Message-Id: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABXpW2kC/4XRzWrDMAwH8FcpPs/DkhIl6WnvMXbwh7wa1qY4J
 ayUvPucMtYyAr75b8NPsnRTk+Qkk9rvbirLnKY0nkoYXnbKH+zpU3QKJSs02BoyrC/jOXltj4w
 6jSFkPa9P2jQ6e9DGkTUxyoAOVDHOWWL6vvvvHyUf0nQZ8/Vebob19lcGqMhzwTUzBxk8mNa7N
 2evX8llefXjUa34jA+QgWogFpACElkrltp2A6QnEKsgFdA2wRKiB7ZxA2z+QCjTrIFNARsvEXo
 bDSJvgO0DBKiC5aSH3ogYQ+w3QX4CsQryupQQhsF22IHbWkr3ALHeYVfACEAOWo49bc2wfwIRa
 2BfQOlMlADsgP9/eVmWH76LiuIEAwAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6011; i=msp@baylibre.com;
 h=from:subject:message-id; bh=zW+OMkS6F+Ayyvoelrvq0IoTvVGqcd3Zq8ZS7TJXBl4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszol8lyT1nE7I3ikw/N6qxj3pTupsWhaz57aeri3ijGE
 z9fS7J2lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwER2WzP8j3fftGvFIlEOkcwD
 B05I7WW+L7a0XPUD5/qL9SvS58/RkGP4p7eoi9krXsVhT4HI30ie2ceNpzIzna0Tmaj/e+m7fKG
 bjAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 05 Jan 2026 17:42:35 +0100
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
Changes in v9:
- Swap setup_qos() and spl_enable_cache() in am62p5_init.c and
  am62a7_init.c. setup_qos() is still required for lpm resume but
  spl_enable_cache() is not. There should be no dependency between the
  two.
- Link to v8: https://lore.kernel.org/r/20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com

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
 arch/arm/mach-k3/am62ax/am62a7_init.c  |  21 +++-
 arch/arm/mach-k3/am62px/am62p5_init.c  |  17 ++-
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
 18 files changed, 597 insertions(+), 5 deletions(-)
---
base-commit: 0e0a198a68be71148f5ec27ef86796174f91436f
change-id: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

