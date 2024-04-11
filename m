Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90348C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 23:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD3D7881EA;
	Fri, 12 Apr 2024 01:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="ScgBlVOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFFCF8821D; Fri, 12 Apr 2024 01:40:46 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 145D3881EA
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 01:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6184acc1ef3so3245317b3.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 16:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712878843; x=1713483643;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TjCBTJMIf7qMPTEfqQIXGlzveNGt3kWNiyPeGV5Vv/8=;
 b=ScgBlVOvo8gQFWgfPJfzGU0TDf6qIJn2CWEyEcyG0TupP+G3v0jPh8CiaMEeZODMdw
 sSZ/k1FIGPDKRHFU9SPxIQB8lnuLryF68xeRO6byxfDWhE7jRdL0qLrQFywspFdhgknH
 ZK09EiY89E0npkl8xCR99ro0BG/eZLnbeS56IxWdAJqYYTsavNJSwAKmBQa47xfTQDdc
 aVtQpZEItceFc4tEf+jjqBAlGUbAjmP0ONrRNTwe5UQAW9utwAG20lONLE0bPCK1l2G1
 WJ/KIwBKtVEJ/mLUoJLj6mz3r5aiN/j7hBPQGGRyGi/IPnbI9oTShq2IRRX1+VJm8AHz
 90Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712878843; x=1713483643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TjCBTJMIf7qMPTEfqQIXGlzveNGt3kWNiyPeGV5Vv/8=;
 b=ur1A1y4ZTCxR6O2v3Npo+oawm4nQOuVF3EbpLKimFQJjlznf1bcbW3MvORPWhEbjby
 UiwJ0vy7fA5juVAf/UxvjbVD/CiU/sCm9/twWqLEpul/kmCeg59+2IOo6lU6ANG3zx7R
 4Vyyi0j+SkIsXYtkD5jnEEyucB9wgOTA9PYp8q3tXGeHXWx+ceFr8Vj39bzbQhUExjaf
 aQ4zrnDJA8MGI+Txv8Z68DKN5K9zZewoV16mEgtbM2vs4Qql7fz9V1YYT/CH00z64x5x
 IPEl2ZDOSqixuM979G/TZ90N4r+wFO2bpEedcU708T3S7z/u23nzFe4cxZrQJeAxuRMM
 MNwQ==
X-Gm-Message-State: AOJu0YzKaFjNScIDsepmDnn/hIifJo0kPoAx6EuqQeLdmIabLsE8E7Yr
 gKs8SoYIc2AmcbpgpbCyz52r9cJRLDPESRsw/kLwZfsgOXAUxW9ChZgcdVV3+rmNlTgk3nHd6ES
 2rw==
X-Google-Smtp-Source: AGHT+IGoDIA9vl967g48KlzpAjjy7z4zEhhgTfDWOgP/d955UhTEH6Q58pfxy3vTehEml3oTcgHBog==
X-Received: by 2002:a81:b641:0:b0:611:191e:1de8 with SMTP id
 h1-20020a81b641000000b00611191e1de8mr1113190ywk.18.1712878842622; 
 Thu, 11 Apr 2024 16:40:42 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a81ec13000000b00617b17f8572sm533855ywm.104.2024.04.11.16.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 16:40:42 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@sysam.it>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Linus Walleij <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <monstr@monstr.eu>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Samuel Holland <samuel@sholland.org>, Scott McNutt <smcnutt@psyent.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Thomas Chou <thomas@wytron.com.tw>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wolfgang Denk <wd@denx.de>, Yang Xiwen <forbidden405@outlook.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: [PATCH 0/3] arm: Add Analog Devices SC5xx Machine Type
Date: Thu, 11 Apr 2024 19:37:27 -0400
Message-ID: <20240411234021.14534-1-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Apr 2024 01:48:49 +0200
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


This series adds support for the ADI SC5xx machine type and includes two
core drivers that are required for being able to boot any board--a UART
driver and the clock tree driver. Our corresponding Linux support relies
on u-boot configuring the clocks correctly before booting, so it is not
possible to boot any board without the CGU/CDU configuration happening
here. The clock tree itself is only used by the UART in this minimal
patch set, but is of course broadly useful for all other peripheral
drivers to be submitted in future patch sets. There are also no board
files or defconfigs included here, but some common definitions that will
be used to build board files currently are.

Some of the configuration code in dmcinit and clkinit is quite scary and
causes a lot of checkpatch violations. It is modified from code
initially provided by ADI, but it has not been fully rewritten. There's
a question of how important it is to clean up this code--it has some
quality violations, but it has been in use (including in production) for
over two years and is known to work for performing the low level SoC
initialization, while a rewrite might introduce bugs that could take a
significant amount of time to detect in the future.

Please provide any feedback or comments that will be helpful in creating
a v2 of this patch that will be ready to submit for inclusion into the
main tree, as well as general observations that we should consider in
other driver patches before submitting them.

Thank you!


Nathan Barrett-Morrison (3):
  arch: arm: Add Analog Devices SC5xx machine type
  drivers: clk: adi: Add in SC5XX-family clock driver
  drivers: serial: Add in UART for ADI SC5XX-family processors

 MAINTAINERS                                  |  15 +
 arch/arm/Kconfig                             |   6 +
 arch/arm/Makefile                            |   1 +
 arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h  | 115 +++
 arch/arm/include/asm/arch-adi/sc5xx/soc.h    |  18 +
 arch/arm/include/asm/arch-adi/sc5xx/spl.h    |  41 +
 arch/arm/include/asm/mach-types.h            |   4 +
 arch/arm/mach-sc5xx/Kconfig                  | 464 +++++++++
 arch/arm/mach-sc5xx/Makefile                 |  19 +
 arch/arm/mach-sc5xx/config.mk                |  21 +
 arch/arm/mach-sc5xx/init/Makefile            |  11 +
 arch/arm/mach-sc5xx/init/clkinit.c           | 543 +++++++++++
 arch/arm/mach-sc5xx/init/clkinit.h           |  18 +
 arch/arm/mach-sc5xx/init/dmcinit.c           | 973 +++++++++++++++++++
 arch/arm/mach-sc5xx/init/dmcinit.h           |  29 +
 arch/arm/mach-sc5xx/init/init.c              |  68 ++
 arch/arm/mach-sc5xx/init/init.h              |  37 +
 arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h |  63 ++
 arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h |  51 +
 arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h |  51 +
 arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h |  50 +
 arch/arm/mach-sc5xx/rcu.c                    |  22 +
 arch/arm/mach-sc5xx/sc57x.c                  |  21 +
 arch/arm/mach-sc5xx/sc58x.c                  |  21 +
 arch/arm/mach-sc5xx/sc59x.c                  |  32 +
 arch/arm/mach-sc5xx/sc59x_64.c               |  36 +
 arch/arm/mach-sc5xx/soc.c                    | 142 +++
 arch/arm/mach-sc5xx/spl.c                    | 140 +++
 drivers/clk/Kconfig                          |   1 +
 drivers/clk/Makefile                         |   1 +
 drivers/clk/adi/Kconfig                      |  83 ++
 drivers/clk/adi/Makefile                     |  16 +
 drivers/clk/adi/clk-adi-pll.c                |  94 ++
 drivers/clk/adi/clk-adi-sc57x.c              | 205 ++++
 drivers/clk/adi/clk-adi-sc58x.c              | 221 +++++
 drivers/clk/adi/clk-adi-sc594.c              | 230 +++++
 drivers/clk/adi/clk-adi-sc598.c              | 307 ++++++
 drivers/clk/adi/clk-shared.c                 |  48 +
 drivers/clk/adi/clk.h                        | 122 +++
 drivers/serial/Makefile                      |   1 +
 drivers/serial/serial_adi_uart4.c            | 228 +++++
 include/configs/sc_adi_common.h              | 226 +++++
 include/dt-bindings/clock/adi-sc5xx-clock.h  | 271 ++++++
 43 files changed, 5066 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h
 create mode 100644 arch/arm/include/asm/arch-adi/sc5xx/soc.h
 create mode 100644 arch/arm/include/asm/arch-adi/sc5xx/spl.h
 create mode 100644 arch/arm/mach-sc5xx/Kconfig
 create mode 100644 arch/arm/mach-sc5xx/Makefile
 create mode 100644 arch/arm/mach-sc5xx/config.mk
 create mode 100644 arch/arm/mach-sc5xx/init/Makefile
 create mode 100644 arch/arm/mach-sc5xx/init/clkinit.c
 create mode 100644 arch/arm/mach-sc5xx/init/clkinit.h
 create mode 100644 arch/arm/mach-sc5xx/init/dmcinit.c
 create mode 100644 arch/arm/mach-sc5xx/init/dmcinit.h
 create mode 100644 arch/arm/mach-sc5xx/init/init.c
 create mode 100644 arch/arm/mach-sc5xx/init/init.h
 create mode 100644 arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h
 create mode 100644 arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h
 create mode 100644 arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h
 create mode 100644 arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h
 create mode 100644 arch/arm/mach-sc5xx/rcu.c
 create mode 100644 arch/arm/mach-sc5xx/sc57x.c
 create mode 100644 arch/arm/mach-sc5xx/sc58x.c
 create mode 100644 arch/arm/mach-sc5xx/sc59x.c
 create mode 100644 arch/arm/mach-sc5xx/sc59x_64.c
 create mode 100644 arch/arm/mach-sc5xx/soc.c
 create mode 100644 arch/arm/mach-sc5xx/spl.c
 create mode 100644 drivers/clk/adi/Kconfig
 create mode 100644 drivers/clk/adi/Makefile
 create mode 100644 drivers/clk/adi/clk-adi-pll.c
 create mode 100644 drivers/clk/adi/clk-adi-sc57x.c
 create mode 100644 drivers/clk/adi/clk-adi-sc58x.c
 create mode 100644 drivers/clk/adi/clk-adi-sc594.c
 create mode 100644 drivers/clk/adi/clk-adi-sc598.c
 create mode 100644 drivers/clk/adi/clk-shared.c
 create mode 100644 drivers/clk/adi/clk.h
 create mode 100644 drivers/serial/serial_adi_uart4.c
 create mode 100644 include/configs/sc_adi_common.h
 create mode 100644 include/dt-bindings/clock/adi-sc5xx-clock.h

-- 
2.43.2

