Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FAEC3DA6D
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 03:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5220680AE0;
	Fri, 16 May 2025 05:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="ZMUJGZ6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF9A82935; Fri, 16 May 2025 05:05:49 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15449806D8
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 05:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id B78A5260D9;
 Fri, 16 May 2025 05:05:42 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VWQoa8P9JiJG; Fri, 16 May 2025 05:05:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1747364741; bh=7HnM9Ae1GBLH6axu24FPMp7eal3g7DW4jJFJ+NnrhZA=;
 h=From:To:Cc:Subject:Date;
 b=ZMUJGZ6JiIQ8/egqjnC5mf/W4YLQhVpNca6VQlsKJiH1xrv0otK1SaLdy37sox5+5
 0t3YlWV2VWwzzTo0kqVEiVdPAm7JJskC6R8a1IHa8Bzajy1sppQvqEuul6+NAwEUyg
 sibrZ5w30FZAiN9ItssGkRigsf71mR2tqW6pRh4asuZLua9ivLT6Q23AqAmLlcAtMg
 ThXtxWShRVegAGgNDqt4CX3IFTPAvq18vuLs/8iVCBLh/87vBel9xSdOIxiod2ILkC
 tBbCOsPkenNUJWbNCrcgaKSTmEk/CycYbKfKCYhYy0gR2tjLRusI3zq3Brtvv5uwZr
 nFvfrF5LmXhPA==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Yao Zi <ziyao@disroot.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 0/4] Improve usability of TH1520 with mainline SPL
Date: Fri, 16 May 2025 03:05:21 +0000
Message-ID: <20250516030525.31361-1-ziyao@disroot.org>
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

Depending on the previous SPL support series of TH1520[1], this series
further improves usability of TH1520 SoC when booting with mainline SPL.

The T-Head customized IOPMPs are initialized in SPL and a clock driver
is ported from Linux kernel to support operation of various peripherals.

With this series, it's possible to properly initialize GPIO and eMMC
when booting with mainline SPL on the 16GiB variant of Lichee Pi 4A.
SDIO controller fails to initialize the SD card sometimes, which may be
related to incorrect pin configuration.

A bootlog with eMMC/SD information shown could be obtained here[2].
Thanks for your time and review.

[1]: https://lore.kernel.org/all/20250513090503.46670-1-ziyao@disroot.org/
[2]: https://gist.github.com/ziyao233/75ff1e5b2cf9161093fcc12ed0a62395

Yao Zi (4):
  riscv: cpu: th1520: Initialize IOPMPs in SPL
  clk: thead: Port clock controller driver of TH1520 SoC
  riscv: cpu: th1520: Select clock driver
  riscv: dts: th1520: Complete clock tree

 arch/riscv/cpu/th1520/Kconfig               |    1 +
 arch/riscv/cpu/th1520/spl.c                 |   65 ++
 arch/riscv/dts/th1520-lichee-module-4a.dtsi |    8 -
 arch/riscv/dts/th1520.dtsi                  |   75 +-
 arch/riscv/include/asm/arch-th1520/iopmp.h  |   42 +
 drivers/clk/Kconfig                         |    1 +
 drivers/clk/Makefile                        |    1 +
 drivers/clk/thead/Kconfig                   |   19 +
 drivers/clk/thead/Makefile                  |    5 +
 drivers/clk/thead/clk-th1520-ap.c           | 1031 +++++++++++++++++++
 10 files changed, 1204 insertions(+), 44 deletions(-)
 create mode 100644 arch/riscv/include/asm/arch-th1520/iopmp.h
 create mode 100644 drivers/clk/thead/Kconfig
 create mode 100644 drivers/clk/thead/Makefile
 create mode 100644 drivers/clk/thead/clk-th1520-ap.c

-- 
2.49.0

