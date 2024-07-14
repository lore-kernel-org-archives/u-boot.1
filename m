Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF40C3DA42
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 15:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D986687FA7;
	Sun, 14 Jul 2024 17:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BCTUWAHW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 604A288189; Sun, 14 Jul 2024 17:08:51 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D0A687EFA
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 17:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-25d634c5907so2107708fac.2
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720969727; x=1721574527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXAfQQSy47+63c0dQPoQruJiPX8Oov1vqGnpXaryPg0=;
 b=BCTUWAHWtBwK+bAw6r2f13flF6h0VjpHkgrir0rvMcP7ZzPuBpNmU21SZ5HvGyTh9O
 Avp4UTlD+C9omp9Jt/1Leq8FaO7RjM2matYMvh9FqLlG361ZYvRQq2hyYipbxONK3wFo
 5xJDB0uMtKsRMweuUtzAUJgW3AGurDwqLZj3fSu0IWKuQUKU7p52FuvKxz0DROVc2PAL
 uwidcZSC3iQa3yfofJbwDDx2C09Y9z8HvRvWr5bg5tU9ywgc87BSDK5RufHvapAdGvt1
 MTkgO7R7T/eqT9Mhbm1QIX/v9UmclsVhNnMQOdPrLt3K2cxgepuEIZNaLgKWkBuCyCLR
 nQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720969727; x=1721574527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZXAfQQSy47+63c0dQPoQruJiPX8Oov1vqGnpXaryPg0=;
 b=Rtf4v7VeAiUvE1H7C5g0W4gNGYz7YUiBFWuoVTWfXWzhRL6SIzudKDuFCkhrzgn805
 bSPSFtVxtadrd/hXfjmKsEWMDofFmDRLN0Xku7olZZCWi3PkYPakpvyds9G51XKg28tL
 WLJZXrcJfnXI477qJZ39M2B6iYCLgI1H3zWNhIbi9c/WhadAESyBRfC+J9wD2l3t7CYl
 jrbR8hABcDaibe3hx4tKVPlHhoFsRU/qGA0n/SV2uMs9elQ5a1kgyy+7/7unUOWwCEAV
 UhoyP6VPUGokFcNa9SnVO9oT4rkdWGsMKXLM5NRBS49RxbcqGRu3F4OTqvIiWMkvBpb3
 H2AA==
X-Gm-Message-State: AOJu0YxkAy429xCQkhhrGvdtxdrQqo2yljTXHSaSB7CNWbkdubHn86Us
 IprrzhHPgM/hDeJrgOZPs4qmrXs8jo0ISpA5qtF+s6ACMiLpEjKRJkqZYI8Q
X-Google-Smtp-Source: AGHT+IG9Z/jckCh21EkQA09/v3ZFZJaAID/yT/q6K6jivJgNvZXG6OW5GEdddYN6jLYCBtuv5pJQbQ==
X-Received: by 2002:a05:6870:5693:b0:25d:f8fa:b535 with SMTP id
 586e51a60fabf-25eae778f1bmr14475534fac.6.1720969726675; 
 Sun, 14 Jul 2024 08:08:46 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ebc4637sm2686529b3a.88.2024.07.14.08.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 08:08:46 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Leo <ycliang@andestech.com>, Michal Simek <michal.simek@amd.com>,
 Nishanth Menon <nm@ti.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH 0/2] riscv: spacemit: bananapi_f3: add support for Banana Pi
 F3 board
Date: Sun, 14 Jul 2024 23:08:23 +0800
Message-ID: <20240714150828.736-1-seashell11234455@gmail.com>
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

Banana Pi F3 board is a industrial grade RISC-V development board, it
design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
computing power. 4G DDR and 16G eMMC onboard.2x GbE Ethernet prot, 4x USB
3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.

This patch introduces fundamental support for the Banana Pi F3 board,
encompassing UART, CPU, and PLIC support. This ensures that U-Boot can
operate in serial console mode.


Kongyang Liu (2):
  riscv: spacemit: bananapi_f3: initial support added
  doc: spacemit: bananapi_f3: document Banana Pi F3 board

 arch/riscv/Kconfig                     |   5 +
 arch/riscv/cpu/k1/Kconfig              |  18 ++
 arch/riscv/cpu/k1/Makefile             |   6 +
 arch/riscv/cpu/k1/cpu.c                |   9 +
 arch/riscv/cpu/k1/dram.c               |  39 +++
 arch/riscv/dts/Makefile                |   1 +
 arch/riscv/dts/k1-bananapi-f3.dts      |  20 ++
 arch/riscv/dts/k1.dtsi                 | 375 +++++++++++++++++++++++++
 board/spacemit/bananapi_f3/Kconfig     |  25 ++
 board/spacemit/bananapi_f3/MAINTAINERS |   6 +
 board/spacemit/bananapi_f3/Makefile    |   5 +
 board/spacemit/bananapi_f3/board.c     |   9 +
 configs/bananapi_f3_defconfig          |  20 ++
 doc/board/index.rst                    |   1 +
 doc/board/spacemit/bananapi_f3.rst     |  78 +++++
 doc/board/spacemit/index.rst           |   8 +
 include/configs/bananapi_f3.h          |  15 +
 17 files changed, 640 insertions(+)
 create mode 100644 arch/riscv/cpu/k1/Kconfig
 create mode 100644 arch/riscv/cpu/k1/Makefile
 create mode 100644 arch/riscv/cpu/k1/cpu.c
 create mode 100644 arch/riscv/cpu/k1/dram.c
 create mode 100644 arch/riscv/dts/k1-bananapi-f3.dts
 create mode 100644 arch/riscv/dts/k1.dtsi
 create mode 100644 board/spacemit/bananapi_f3/Kconfig
 create mode 100644 board/spacemit/bananapi_f3/MAINTAINERS
 create mode 100644 board/spacemit/bananapi_f3/Makefile
 create mode 100644 board/spacemit/bananapi_f3/board.c
 create mode 100644 configs/bananapi_f3_defconfig
 create mode 100644 doc/board/spacemit/bananapi_f3.rst
 create mode 100644 doc/board/spacemit/index.rst
 create mode 100644 include/configs/bananapi_f3.h

-- 
2.41.0

