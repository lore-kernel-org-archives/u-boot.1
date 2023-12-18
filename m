Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187B7C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 10:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 615D587D6A;
	Mon, 18 Dec 2023 11:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="g463E3dc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A1087DE0; Mon, 18 Dec 2023 11:26:35 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C1578773F
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-28b79d1ebd6so311890a91.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 02:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702895190; x=1703499990;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NHYMFt14l3UhYykO02ZuYW5r47gls3XoT6qB9zK/yIU=;
 b=g463E3dcPMl75mp6KFIflK8xXIx2mATElKi3Hm1GHoqEt07mS7vcAqZ5GMaQh1fBZA
 aKkBBCwyR1VTeMa3x+YTKrxLWkNvu8MT1bA6Bd9XU1B0K1t/ar9kLQZHAr/5LX+oOuIW
 OTGqguXbBSJ0k/YZ1uCHtUJblviLsvxuUbw1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702895190; x=1703499990;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NHYMFt14l3UhYykO02ZuYW5r47gls3XoT6qB9zK/yIU=;
 b=wLRegEKxSiDevDT5oQ82WQnvhLdOGZmcK7SGCpyrbKHWOxyucwwV1RJdTYDvDIuKAH
 qhczOumLOkfebVBMqnOSbryJmQzllZKNcNCeN/uKpOyn19vzKl191wDwhh+TpzZF/+Yo
 771NG700N5MVJfcNg40zUIZi70QQekKMQzc2K09jkUF8dbDanHF5JYck0mf7fPtYQKiI
 cI40ZT3CritaQrZTxx5f6PT1p61SFGoz5aqN3sHzbypB2Kzr6SAsmsb6pqfRAdf3bJMG
 PSHsrLk8stxXaSr0XctmMy+P3zlRZOx+oTB3Zgg3UlY+pya3PO4IuvWkOqHXf8Utt+s6
 mirQ==
X-Gm-Message-State: AOJu0Yz1q704JimpeVT10Fm8uOy6J5z7IzWUDfe2QHwC8bqMNokpZlRe
 hm1DPOCO0WYWeMTx7+MV4G9HAWIePPFKH6lpjFf6bw==
X-Google-Smtp-Source: AGHT+IE4DTU2PKnvMM+HZyQ1khDtZi5yW6uwUlRGEFCW5FAdYL4HEdItqlddt6fb8t2yOmTBU6hk4Q==
X-Received: by 2002:a17:90a:e54d:b0:28b:6b52:8198 with SMTP id
 ei13-20020a17090ae54d00b0028b6b528198mr370090pjb.37.1702895190566; 
 Mon, 18 Dec 2023 02:26:30 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 sc16-20020a17090b511000b0028b2ff2208esm5961002pjb.19.2023.12.18.02.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 02:26:30 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-spi/master [for-next]
Date: Mon, 18 Dec 2023 15:56:25 +0530
Message-Id: <20231218102625.1050191-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
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

Hi Tom,

Please pull this PR for next.

Summary:
- spi_nor_read_sfdp_dma_unsafe (Vaishnav)
- w25q01/02 (Jim)

CI:
https://source.denx.de/u-boot/custodians/u-boot-spi/-/pipelines/18995

thanks,
Jagan.

The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b63:

  Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-spi master

for you to fetch changes up to 959a4a0838acf7ef733e000d1304cea6711b8945:

  spi: cadence-quadspi: Fix error message on stuck busy state (2023-12-14 23:56:19 +0530)

----------------------------------------------------------------
Bruce Suen (1):
      mtd: spi-nor-ids: add support for xtx XT55Q02G

Godfrey Mwangi (1):
      mtd: spi-nor: Add MT25QU128AB params

Igor Prusov (1):
      mtd: spinand: add support for ESMT F50x1G41LB

Jan Kiszka (1):
      spi: cadence-quadspi: Fix error message on stuck busy state

Jim Liu (1):
      mtd: spi-nor: add flash model w25q01/02 support

Jit Loon Lim (1):
      mtd: spi-nor: Add MT25U01G part number for SPI NOR Flash

Jonas Karlman (1):
      mtd: spi-nor: Add support for Silicon Kaiser sk25lp128

Teik Heng Chong (1):
      drivers: mtd: spi: Add support for GD55LB02GEBIR SPI NOR flash

Udit Kumar (1):
      spi: cadence_qspi: Select flash subnode at runtime

Vaishnav Achath (1):
      mtd: spi-nor-core: Implement spi_nor_read_sfdp_dma_unsafe() for sfdp parse

William Zhang (1):
      spi: bcm63xx-hsspi: Fix compiler warning

 drivers/mtd/nand/spi/Makefile  |   3 +-
 drivers/mtd/nand/spi/core.c    |   1 +
 drivers/mtd/nand/spi/esmt.c    | 137 +++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi/Kconfig        |   5 ++
 drivers/mtd/spi/spi-nor-core.c |  34 +++++++++-
 drivers/mtd/spi/spi-nor-ids.c  |  23 +++++++
 drivers/spi/bcm63xx_hsspi.c    |   2 +-
 drivers/spi/cadence_qspi.c     |   7 ++-
 drivers/spi/cadence_qspi.h     |   1 +
 drivers/spi/cadence_qspi_apb.c |   3 +-
 include/linux/mtd/spinand.h    |   1 +
 11 files changed, 210 insertions(+), 7 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/esmt.c
