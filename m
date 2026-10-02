Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6210ACA5FE2
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B40C8122D;
	Fri,  2 Oct 2026 16:47:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J8J2mUSVnnNc; Fri,  2 Oct 2026 16:47:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 93E3481062
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959646;
	b=EHCR7tCuyT6kBkLL35+wxkIvCse5tH9K8LcW8/ZUH+Qm7osEyJeQu317RmXgs2YfPeiW
	 uXTmPIYWbnsFqnDlwKa+WNnztAUj2qxIgfe45iwegV5knEIwUtezMhidjg0A0/P08ffVB
	 q3P/rPGDkZvt6kVyh9vjGV34WHSFYA5Lt9fdekTVZxcpTiyRm9DW0k4Qw5LuaoHB1iWsB
	 0xtIa8hgGxCO2s7gYydVBJQLSiF1g+1yTAkOMIwk7u/z9zf7JsBKXYr8BUxKs0CHUgF15
	 hG++n3mE+RJoDfSdZZulPP/QmIq0OC8G/3P8fCZdgSmqyRSPZPK0L44x/BUd/l66Kvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fYG1cz3rdZD4jP9tNSWTu4N5t1fUg9/GkawqiC5PlJY=;
	b=WGzppjL+BtS2S1CcrjLB+tKvo3DFp9zv3BgBuhSwBnDMitgj9p4iHiqccw7YWEq0IQuf
	 yNc4wt7KyIXQaL/mM3vHcNK2obIkM+Cg5ioyaaoq9OKcEpn1rQmzDLkSIxSF14iPQSo3S
	 NqVXV5FrTaw4J5m3B650+KWq3lM6fWj0WM/lV+LWtHqFCQVrv0gncPwV8cn0yUh6Z5KRC
	 rORjXF1jXLQ8g2+ksAN4i/CtHcC8JMGYhy3Fw2O3dBTdrLoO1FcRjPeZQ2ovwHIrmx3Lf
	 AgvtrKoxJZ/ijjF3qpECmAVckCNgWrkzCR7nvJN9CkdCfShsDz5eGpMD43lvmFGo+5Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959646;
	bh=fYG1cz3rdZD4jP9tNSWTu4N5t1fUg9/GkawqiC5PlJY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oRn5auU4a1t8DVuWft8syeZFfiGNtBdIa1vkph3vogDqIMNGs5+Q70siqYX8Fy3Za
	 6JxNMdPs+sQZOzC8OEilm/mpgcLpF2qxt2gG8grntVTA+DfH4EcxeBcemXlQPjI6jF
	 rtndS7+4Ry9ObuUfGTbSQ7x2LZ9qOYejIvAc8oJzdpqImv24xq3F6VWltUkGwhLwHD
	 6/sbMayjLLK/9nCfZq76p4sTyS26NI85Sp6X9O8JKjNwQaO2bLpKj08pwzHrB3QQZk
	 +LI1KHoohB6TSW/a2I1E+R1w0tYNr50H+fnyGcMd0KLOGoCLfhIiF/TtiYEq672exP
	 tRGOBkO3nZRaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93E3481062;
	Fri,  2 Oct 2026 16:47:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F0584282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5DF460BBC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:13:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 85xfyl3QJHmA for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:13:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AC32160BBB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946824;
 b=IV4rlRaG8B1WX4s+Bhuj4iNQYj/rT+7hkPk+SPUUOLBjiZw7YRQdwsTdyYjA7lmZen3b
 kCY2vJEP41dGRdIsc2B2p39DpiGOck5+3D8p5K8IMNm+iZLu74JyHNbGMGEHnrGupAmbi
 mqWZpKijaQrED3jOCH67HTKyhRUoIB7smaUXvwCk+a2AYYurXf6CZuQ48Bf7y1MoU2bUS
 x+IeNWIW51BHNIVYMd3T+v5j4bplSke6BJXWsINeVOBbhKfOSrBuc3z8qt9qoc+Sy68II
 TPilkvQXsSnJObkBBk5dmRU05tGUl78kZJ3td02aL20Ed0EWEZwot/nyHGr6IZHO/lA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946824;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
 bh=fYG1cz3rdZD4jP9tNSWTu4N5t1fUg9/GkawqiC5PlJY=;
 b=N8O0Nkw7dllOpC5HN8iF7Ycgj70jbI7i8duyMFVk/QsG4LF0IJfMBk6ubcRXU61ENiX6
 IFHBZwppVM96QUYVzYNBHQc20NEARm2/0GPm+/SX65KueAIg8ydA0FuqeUzy7jwMBMWd+
 JhY2oCnjFwZpNH+6Pf/9qF99IsEESZNiS25RcRc+m+OWMeCsH4HveYElPFTfJgiohMgPU
 aZsdXWlgB8qXB+Zpk25M6ohMTxWCQRVuA3KPUKvksk1JU/KR/cRueyYzjmdjs/KtGGvkI
 koy0C4F3pBrlhS4lALyu5MZs6U+6FVtvlaz0lkj2jnZdSuv7bKSfqFktj/bZMroBXcA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=Qb8C+7f0; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=Qb8C+7f0
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC32160BBB
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:13:42 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 199564E41103;
 Fri,  2 Oct 2026 13:13:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CAEFF603DC;
 Fri,  2 Oct 2026 13:13:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 99790103281F4; 
 Fri,  2 Oct 2026 15:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790946817; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=fYG1cz3rdZD4jP9tNSWTu4N5t1fUg9/GkawqiC5PlJY=;
 b=Qb8C+7f0mSWnkFEgip44ggxc/tUa87YUjB2eFIzZago6DDPQ3gVvOtqElWEli233z8lkMV
 euV2quo4SSu91JaJx/I49TKFGpbi3J8kH/G6c2aAhnz73xPTgO7AT7PYYgdy4YWLRU+HWT
 mI5CeGeJQkkevifzGlt/BAbHnzXETwhqhRtLcGlQjMYhvxx74AqBibOYFImxkfDDNBpSrM
 /Oqgqy39mVuI4EsavijHUDOHns1BNM4hW+S8Tj3HDCLmpHw7bGT7PcCYV3Exv3u7z6WBI4
 xaoh7KgAPfIBN735nigQNq27S9RpOzM0jIhWSKXTfgMOA12XXAAgHNC1u0F40Q==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Subject: [PATCH 00/10] riscv: Add support for Metanoia MT2824 SoC and
 MT5824 EVB
Date: Fri, 02 Oct 2026 15:02:18 +0200
Message-Id: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFqrv2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyMj3dwSIwsjE11Lc0NL4zTDtKRUI0sloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AEKbcWGoAAAA=
X-Change-ID: 20260622-mt2824-97193f1fbe29
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Torsten Duwe <duwe@suse.de>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
 Chris Packham <judge.packham@gmail.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?=
 <randolph@andestech.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 02 Oct 2026 16:47:21 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The MT2824 is a RISC-V SoC integrating a dual-core Andes AX45MP with
256 KB of L2 cache, Andes PLIC/PLICSW/PLMT interrupt and timer
controllers, an ATCSPI200 QSPI controller, a DesignWare-derived SDHCI
controller and a DDR controller that is initialized by firmware loaded
by the SPL from the boot device.

The SoC is used together with two MT3812 5G transceivers to form the
MT5824 reference design [1]. The evaluation board allows testing this
reference design and provides a 32 MiB SPI-NOR flash as well as an SD
card port for booting.

This series adds support for the platform: the SoC drivers (SDHCI, DDR
controller and a simple reset controller), the SPL boot flow (GPT
partition lookup with A/B slot selection driven by the ROM one-shot
boot registers), the environment backend selected at runtime from the
boot source, and SPI-NOR support (an nvmxip memory-mapped device plus
spi-mem operations for the Metanoia variant of the ATCSPI200
controller).

The series is organized as follows:

- patches 1-5: generic fixes and helpers (16-bit iopoll variant,
  simple reset controller driver, GPT parsing in SPL, NVM XIP devices
  in SPL, Andes erratum #35102 Kconfig option)
- patches 6-8: spi-mem support for the ATCSPI200 QSPI controller and
  the MT2824 DDR and SDHCI drivers
- patches 9-10: device trees and MT5824 EVB platform support

The series was built and tested on the MT5824 EVB:

- boot from SD card and from QSPI NOR
- environment loaded from the boot device (MMC and SPI flash)
- SPL A/B boot from the GPT partitions
- sf probe/read/erase on the Macronix NOR flash

[1]: https://metanoia-comm.com/products/5g/mt5824/

Base commit: a06e89ab05e ("Prepare v2026.10-rc5")

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
Benoît Monin (9):
      iopoll: Add readw_poll_sleep_timeout
      reset: Add a driver for simple controller
      disk: efi: Reuse the GPT entries buffer with simple malloc
      nvmxip: Make NVM XIP devices available in SPL
      mmc: metanoia_sdhci: Add SDHCI driver for Metanoia MT2824 SoC
      ram: metanoia: Add driver for MT2824 DDR controller
      spi: atcspi200_spi: Add spi-mem support for the Metanoia ATCSPI200 variant
      riscv: dts: add MT2824 SoC and MT5824 EVB device trees
      riscv: metanoia: Add support for the MT5824 EVB platform

Jun Chang (1):
      riscv: andes: Add Kconfig option for Andes erratum #35102

 MAINTAINERS                              |   5 +
 arch/riscv/Kconfig                       |   4 +
 arch/riscv/cpu/andes/Kconfig             |   3 +
 arch/riscv/cpu/andes/cpu.c               |   7 +-
 arch/riscv/dts/Makefile                  |   1 +
 arch/riscv/dts/mt2824-u-boot.dtsi        |  66 +++
 arch/riscv/dts/mt2824.dtsi               | 219 ++++++++++
 arch/riscv/dts/mt5824-evb.dts            |  34 ++
 board/metanoia/mt5824-evb/Kconfig        |  45 ++
 board/metanoia/mt5824-evb/MAINTAINERS    |  11 +
 board/metanoia/mt5824-evb/Makefile       |   7 +
 board/metanoia/mt5824-evb/board.c        |  61 +++
 board/metanoia/mt5824-evb/board.h        |  35 ++
 board/metanoia/mt5824-evb/mt5824-evb.env |   6 +
 board/metanoia/mt5824-evb/spl.c          | 388 +++++++++++++++++
 common/spl/Kconfig                       |   8 +
 configs/metanoia-mt5824-evb_defconfig    |  73 ++++
 disk/part_efi.c                          |  25 +-
 doc/board/index.rst                      |   1 +
 doc/board/metanoia/index.rst             |   9 +
 doc/board/metanoia/mt5824-evb.rst        | 232 ++++++++++
 drivers/mmc/Kconfig                      |  11 +
 drivers/mmc/Makefile                     |   1 +
 drivers/mmc/metanoia_sdhci.c             | 494 +++++++++++++++++++++
 drivers/mtd/Makefile                     |   1 +
 drivers/ram/Kconfig                      |   7 +
 drivers/ram/Makefile                     |   2 +
 drivers/ram/mt2824-ddr.c                 | 706 +++++++++++++++++++++++++++++++
 drivers/reset/Kconfig                    |   8 +
 drivers/reset/Makefile                   |   1 +
 drivers/reset/reset-simple.c             | 115 +++++
 drivers/spi/atcspi200_spi.c              | 176 +++++++-
 include/configs/metanoia-mt5824-evb.h    |  28 ++
 include/linux/iopoll.h                   |   3 +
 34 files changed, 2780 insertions(+), 13 deletions(-)
---
base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
change-id: 20260622-mt2824-97193f1fbe29

Best regards,
--  
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

