Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E76CC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 09:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CF4D878E2;
	Tue, 11 Jun 2024 11:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dAxSaKeP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 319C487AD2; Tue, 11 Jun 2024 11:41:58 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A808752A
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70255d5ddc7so785328b3a.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718098913; x=1718703713; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2jdKyNV4bjXUOWN0er947WFNnr1/WM1v3eTrlboHlAE=;
 b=dAxSaKePQHokY9cvYR4wQL83ynDCPvXL83DaOFYkZWXWc8nMPjDodrR1E6w1/G1YmI
 w+Pman+thj/ocE0oOdJPK9ZISLzKnXWD6yQgtGTBoUZsLXOxlJBaC81tKwSgW61aIhoW
 kDaFLED81uT7wsBLijNhMHElKXduP3160pAz0gfaV8ea09KowbUTTuXrr9cV4sTc15Td
 wBN1jMzTDNvXCHZsN+MC6C2Z5ZkIEVCAIZsZNmVKRN7h3hw5KdoyttLjunqXBbnitXMJ
 3duCfo2mczJndKvdCXMfaAypSlllHAhg4J31ma8HkXQE7QAFWalhtebOFudYE+HOdgO6
 DjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718098913; x=1718703713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2jdKyNV4bjXUOWN0er947WFNnr1/WM1v3eTrlboHlAE=;
 b=Dxm85QCLSgQ3lEwsMu4cORCYeO7/i4zlxapkGDBiS3eaaHpiZyj4Z6bZ4ag5VuuDL/
 G9A74vYHoj/5G0YrBPbQVVQ/i5+ZkrZpPkt1EcNw1dDtBFc+VSXl/N+Yhx4aaQJ5LNoQ
 nuyEWWwrEpT0cnjKV56+kGsrBQH4s4SDAqYukwvSkoMz9dHG5np74MMbnrioylH1ATwt
 SeT6EulX8zxoeQKG4JkdnOIkAwSIiKoq8jc1AiQq/rb3WAv+abN5uPx9aRkqnueGqIqN
 f9++qoekU8YwDBZ0vVvXOL3OUkjHJAEPW62QDeYHpDqMklq09u/HRlW1Gth5df3gLJ5X
 VRHQ==
X-Gm-Message-State: AOJu0YwrUjiEbsAPgMBoOYgrYYa04XNkagbavBlZy1qqvb12NVSGDyyK
 Vdg6JPqL3xhVH7F45nxrt41WIgkg8120wqsBSGeZsyz8KP2EA44DRsO4j6oG
X-Google-Smtp-Source: AGHT+IGhkdVt1wJ0eio42C4msZ6Ie1x/uGZedjEyp0XF7olMeuWr4WiCg/NYhnkmwrNkOI5KplU8Jw==
X-Received: by 2002:a05:6a20:7484:b0:1b7:733c:d1b with SMTP id
 adf61e73a8af0-1b7733c0f5fmr5280621637.42.1718098913256; 
 Tue, 11 Jun 2024 02:41:53 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6d859ea3csm76873555ad.178.2024.06.11.02.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 02:41:52 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>, Leo <ycliang@andestech.com>,
 Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH v2 0/4] clk: sophgo: milkv_duo: Add and enable clock
 controller driver
Date: Tue, 11 Jun 2024 17:41:12 +0800
Message-ID: <20240611094134.18868-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series of patches introduces the clock controller driver for the Sophgo
CV1800B SoC, updates the device tree sources to use the new clock controller,
and enables the clock controller in the configuration for the Milk-V Duo board.

Changes in v2:
- Fix compilation error
- Remove unused code

Kongyang Liu (4):
  dt-bindings: clk: import header for clock controller of sophgo CV1800B
  clk: sophgo: cv1800b: Add clock controller driver for cv1800b SoC
  configs: milkv_duo: Enable clock controller
  riscv: dts: sophgo: Replace device clocks with real clocks.

 arch/riscv/dts/cv18xx.dtsi                |  40 +-
 configs/milkv_duo_defconfig               |   9 +-
 drivers/clk/Kconfig                       |   1 +
 drivers/clk/Makefile                      |   1 +
 drivers/clk/sophgo/Kconfig                |  14 +
 drivers/clk/sophgo/Makefile               |   6 +
 drivers/clk/sophgo/clk-common.h           |  74 +++
 drivers/clk/sophgo/clk-cv1800b.c          | 754 ++++++++++++++++++++++
 drivers/clk/sophgo/clk-cv1800b.h          | 123 ++++
 drivers/clk/sophgo/clk-ip.c               | 594 +++++++++++++++++
 drivers/clk/sophgo/clk-ip.h               | 288 +++++++++
 drivers/clk/sophgo/clk-pll.c              | 275 ++++++++
 drivers/clk/sophgo/clk-pll.h              |  74 +++
 include/dt-bindings/clock/sophgo,cv1800.h | 176 +++++
 14 files changed, 2401 insertions(+), 28 deletions(-)
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-common.h
 create mode 100644 drivers/clk/sophgo/clk-cv1800b.c
 create mode 100644 drivers/clk/sophgo/clk-cv1800b.h
 create mode 100644 drivers/clk/sophgo/clk-ip.c
 create mode 100644 drivers/clk/sophgo/clk-ip.h
 create mode 100644 drivers/clk/sophgo/clk-pll.c
 create mode 100644 drivers/clk/sophgo/clk-pll.h
 create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h

-- 
2.41.0

