Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B242CCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1717A83923;
	Thu, 30 Oct 2025 14:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IU2gUNap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76CE6832AD; Thu, 30 Oct 2025 11:01:29 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10525800B1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-429b9b6ce96so230585f8f.3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 03:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761818486; x=1762423286;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9pzstgNm1EzjD2Vr8RZHjsV8mtJTz6V+2IFQkefuYH4=;
 b=IU2gUNapDF4apqiPVbuPy1/p8u/uPxuBNP3RPiEFblIWCiqrqHF8WuuPJ3useWsFBy
 etGVAn0bV3Cd/AFf3tk+QFGYh2enijpjmdPBaCwiETybOyZyRsu1IsY01HS0FoKlo3hw
 PYZrLf+iMXV+4Jvegml5sDexePF4AWlqT/N3fiumJ6YWETsF7F/2+mRMtuGOLWIOS8P5
 dbT8nY35jJROKnDLfb7UW695JDdm3rxAOb8aBPOd9R25Yospu5+qafKpmgDJKd7JS9Qb
 /cLEgr8CdoI4S9RDNVlBix2F/LUrNjtNQCTLAwgOWeJ2/Ue30aJtwh8LSLVvMpl4UW6m
 mNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818486; x=1762423286;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9pzstgNm1EzjD2Vr8RZHjsV8mtJTz6V+2IFQkefuYH4=;
 b=jUlWyJRwUp0nPCFF6y6A5hLCE98cNBH+Pakl/uI1QGXIO39PG35dgvzEAjkYQOmwP8
 xizqd9MwPLcOYuWO2xrv3UIKylSAyY0CvtowwkSrG519Ih59EPt5Wu0BawYlk+szceZG
 D2PjgUqLKJCkcwfgyuJwUVSkDdxoWwP+wU/ufEN2/Epr5jieLx/Iy6vOof9yX+hm5f8x
 GIv4LRn2tK+nn1mBxfBleg14QbdD3pamYbmCmYxxSa6lpY+GM8UCLIP/m3FRQZD1SsQD
 6F0PyO2GE/a8mpp5ErMWTnPtfK113vqadDXuNkrwrYqtcUVqQsEsI2qrOWw2VDCwTMaw
 /ROQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlcSDuTG/x/kl7B4rYsWL0RmTh2yXA4KcN+jYDu1IHbAl9lxBE8tbwdxyqL7b5fa39HTkQ0CM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywd0AsjsY7t3I1dcfXxUT2Y+bWAuex8CHSiQ6fxVHoJFpLxy2HS
 xOiFKk2yhlQggWSVlsj84leplmW+YS+aRmRx3D4bTOqD6/Oo5yza8nFba01G1XvxRJs=
X-Gm-Gg: ASbGnct02EjGPC8lQsy3t16wiw50+fRImbxBOkCqpfSg6TMh+Mf7qilHzVIdMP/Rqb/
 3Cva6mwyMKIRIX3y6HW2G7dm4mvbK0M93RdDD6bJuC91647v3nsUbrkTHyseTleDxlvVpwW6arG
 rLD1Eei3y4++rpRqCK2B54U/6g00wa0TORPBu5q2N/389Q8hYaTghjXOUlCpVXUVQ+VdBep1v3H
 2kMkd91cnc0Jt6XIUpiJMxJQwo94oVt5v9gafs/V3wcdPOsitpajl+M9cXrlDKzBHaQ3tB9zHVI
 OaJjsgZ1ElBEKc2vUHzPdcBgHbgxu7029XwEHfCAqzQwqt63nIYDEZdc/WytoXgaQg6hzIrPor/
 JsgwIDcpixzgX5hw8pgsf3LIgDkJB/qQ2Mp09TS0wNWzHEPH/28LQp4qWRd+qezjYgM0R86erp9
 R0EG8ptY5u
X-Google-Smtp-Source: AGHT+IGDcuogduAR8N7QvvLBdZuZ8PyJK8ZQxVkJk1UOkf5vQlpzIiKPexfrv1ESa9QonAHRat3lrw==
X-Received: by 2002:a05:6000:22c6:b0:427:665:e37f with SMTP id
 ffacd0b85a97d-429aef78905mr4591730f8f.4.1761818486245; 
 Thu, 30 Oct 2025 03:01:26 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-429952da12dsm31651640f8f.29.2025.10.30.03.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 03:01:25 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v4 00/13] am62: IO+DDR resume support
Date: Thu, 30 Oct 2025 10:59:18 +0100
Message-Id: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPY2A2kC/4XNwWrDMAzG8VcpPk/DlhJDe9p7lB1kW1kFbV2cY
 FZK3r1OKbSMQY7/T/DTzYxSVEaz29xMkaqj5nOL7mNj4oHPPwKaWhu02FuyHqZ80Qh88giaUyp
 QlxPYDkp0YAOxHQbZYnCmGZcig/4+/P1364OOUy7Xx7vqlvUpO7ci14aD9z7JNjrbx/AV+HrUU
 OQz5pNZ8Iov0DtaA7GBlJCIWZj6/h+Q3kBcBamB3CUmxOg8D3/AeZ7vTtAkZG8BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4065; i=msp@baylibre.com;
 h=from:subject:message-id; bh=tXIgl0mr+W0VD0UYJQMUda8yKAGvcL5N727+YIfWqbY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxms987Pt3o6P7M68Wv+lhzSkhOic/aPbuu/7nC7yXKU
 XBZ6uqejlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjI5Q5Gho98h0MXv1xwN7Rp
 d0NaK++Rnn7BmYuX1+bcLj/SsmyKXiLDH67dQiFKSgsW+kznyHpw7sDtZs4w5bW/16lO8nN3KJy
 7nQ8A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 30 Oct 2025 14:00:47 +0100
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

