Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0CBCCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF58B83AA0;
	Mon, 10 Nov 2025 21:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z08C2eyz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFEFD83AAC; Mon, 10 Nov 2025 21:11:41 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4241583A98
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b729f239b39so31272066b.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762805499; x=1763410299;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ChdtcBqTRZrVmNP5w7GXggPvDCmk1IrL0r79TabfqU0=;
 b=Z08C2eyzQ9abwsWQMjDnnLAI0uBLvwRWENf/27BAe/eqSSjWJNguV0LJ3fijZAvKW6
 ae25OVL7kLik2/T/y2vKl0S+YZxFkQlYdUFkuqPFm98m58CvM04dcTBDSKaAQWY83Bgs
 jK0fizfhCjeTVaGokAw2GOx+Xkn4A63nUb5cRYzKjjLoY3sXGoq6vCCHeRVKyveipc6o
 4YAyZgqbtcD8qJPhH7IBx/s2esIzDuuey+3aPA9QFDj28XKZ0zmfTo6f9VCpQtg6e9vJ
 nRTx5q8Df6YvmRZysPjD583TwQvVajhegJ+o4gvs0KOugMeI8tztgwzKcd6f77HqWICC
 5guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762805499; x=1763410299;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChdtcBqTRZrVmNP5w7GXggPvDCmk1IrL0r79TabfqU0=;
 b=AJAseZrdcXDhylih2kTdS7dg+MyqKLUNQ/QRpGjGhnHih1eppoV7NPiB8R2PnuR+lY
 x8h/aAcbditjoR+wwSS2ORFESaX/8Nk9Vhecu/4zssdF/aoQG4mJi3mdzoCTF6IONUKe
 pWCv4sB8WrYjscfTx6xRPDg9Z3jrEVVxpxfzxPAuzcpkC0bzrxoah9uyu6oomaiQnMY2
 JwqrTYICVK265LBCSc7yG4a942PekD9hruwNsMw03nMq51EoVznUc7qhnbTiIPtBaKqD
 hz+GMGxnJALLCDDanXa53BiRRYLx5KEQc2AacYH9AWdnf2RFD4fjDurzL7p9QAWKj/BJ
 A4FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuQPpI05IRvTTeLTI0Ax5r1OTb5ySIZGPP8X1mm8HPAbRQubJZpuZT1b7U8UJUJtpeads8H+c=@lists.denx.de
X-Gm-Message-State: AOJu0YxKjOtIlPgowM7iU/NhbbWWdcvFOwgPKDqGyjWojv4uBtp3FSCY
 O9IAiidbPMQm5TYp5f3V1OLK7PxCgAFXQ9F4Byy3lAZhNCV4cG4OTqj/PVFLu5VlCw8=
X-Gm-Gg: ASbGnctMh5fDeQCxEmf6WGymc51Hmap6EI6bFArUtQYI0IxNvmTPkM+JgZn6D7mWS4h
 zQjG5Q5R/sZJyCew7CTNcBlAF54tV1q/630aWpFACfY4Ius4EbUNBeh/Nd8I51nxLwgjPdvYMZt
 D02XD7m/ui1RXK2lnWsjwccLB2RwHZDUiWWqwTHyoV6Mgwog419gtbAHgTD7sfh87WpqKMYMRfU
 V0RNw90nc42e+ozQLGL2LnAtkim+fLImWbauJJbtGxZjmNzfr7vY4Y/dB4ylsiUMIw+CsjfXDVP
 Zy0lrVbLdDL14rASU9FJv5WURMzv+l+fTPnyC31RVdufG+SssmCE91Z9aSSVgGEOiNmMWt3hhw/
 OqJWlL2n/B+D3hn84rPTa4dFbc8i15d59HKyKP2OaNOJhmNAH2FuT5pcg+Iix1yIrSJ81gibOlg
 G+lI1nJg==
X-Google-Smtp-Source: AGHT+IENsqGrbrMILKxyHrwoAAO2eqn6Rqrk9EEoVOVoIzqGoZ98nbi8DhiPc+MxgRyrl2AKQKNpBw==
X-Received: by 2002:a17:907:3f0f:b0:b70:b323:b7e1 with SMTP id
 a640c23a62f3a-b731d913478mr68677866b.28.1762805498601; 
 Mon, 10 Nov 2025 12:11:38 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf9bcd59sm1151728566b.53.2025.11.10.12.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 12:11:38 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v5 00/13] am62: IO+DDR resume support
Date: Mon, 10 Nov 2025 21:10:24 +0100
Message-Id: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALBGEmkC/4XQ0WpDIQyA4VcpXs9hEpV1V3uPsYuocRXWWjxFV
 sp593pK2cYonMs/gS+Qi5qkFZnU6+aimvQylXoY4Z42Ku748Cm6pNEKDTpDxutTPZaoee9Rl5p
 S031ZaWN1i6BNIDY5yxYDqGEcm+TyffPfP0bvynSq7Xw712GZ3mWAFbkPXHvvk2wjGBfDW+DzV
 wlNnmPdqwXv+At6oDUQB0gJiZiFybkHIP0BcRWkAbJNTIgRPOcHoP0BYXxzDbQDtFEyvHA2iP4
 fOM/zFclLMFnAAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4220; i=msp@baylibre.com;
 h=from:subject:message-id; bh=zQbbOrdkcmSjmI1jq0iA79vjXaE/S5fk3YsAMT2XVJI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwht83vNxUs4mf8uILtVMCBtXsXLo86p5x/ir9x58Wf4
 T5HgkSTOkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiGQ8Y/gecuf+ktpfzme7H
 FjW5gn15P3dJzKsytzzPNyttxqPJe90Z/sc4PptguqpzTUTV/0etGs5rqv7dP71O7ea7ybbfHu1
 RU2MCAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 10 Nov 2025 21:13:08 +0100
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

 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi    |  16 +++
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi    |  20 ++++
 arch/arm/mach-k3/Kconfig                 |   8 ++
 arch/arm/mach-k3/am62ax/am62a7_init.c    |  11 ++
 arch/arm/mach-k3/am62px/am62p5_init.c    |  12 +++
 arch/arm/mach-k3/am62x/am625_init.c      |   2 +
 arch/arm/mach-k3/common.c                | 166 +++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h                |   4 +
 arch/arm/mach-k3/include/mach/hardware.h |  32 ++++++
 configs/am62ax_evm_r5_defconfig          |   1 +
 configs/am62px_evm_r5_defconfig          |   1 +
 drivers/firmware/ti_sci.c                |  38 +++++++
 drivers/firmware/ti_sci.h                |  16 +++
 drivers/ram/k3-ddrss/k3-ddrss.c          | 177 +++++++++++++++++++++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h   |   9 ++
 15 files changed, 513 insertions(+)
---
base-commit: e34d01d23e45e007368685ffa6dfd674b6dd7b17
change-id: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

