Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F02BC83F09
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 03:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DDE7835B9;
	Thu, 10 Jul 2025 05:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="LoI0f4jW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EAD1835CD; Thu, 10 Jul 2025 05:42:18 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FAC9834BC
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 05:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id E3AF922F39;
 Thu, 10 Jul 2025 05:42:15 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y82Mnl0dm9OC; Thu, 10 Jul 2025 05:42:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1752118935; bh=bHJfX7+Ay4i7UaIOpw06oSeAtJFDXjiKYz7RM8flVW4=;
 h=From:To:Cc:Subject:Date;
 b=LoI0f4jWsJzpdq5l/lHUyzUfvutcDH/vDjwClPWR1zE/UadIEfTKLAa6biMkP58DR
 evyZvOtJKMC7vSvHjijONSJMnD5JlpXlRKKKp3MQ/xuoDBfEh2XTN0/sJ6GW2pr8C2
 0nKmdLy6p78bE3w0rzYVACz0e5SNW6jJT7LilljfLlQ2VvOAJ2nWAkl3a5wmQyI1Zt
 DrfyuXdUlMahD1RvfcbhetoHbPhUKfOpgllkW2m9otdmBs7Vbcnk3Fmf+FRCdHjejH
 Vc+aAmR7VWZ60OVk3A6vg+rINrTY8q+of9nAcpoYaCQ4wZqI3CSPMSwG1VVfHzv8DK
 DpwY5n1r2PUwQ==
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 0/5] Add support for TH1520-integrated GMACs
Date: Thu, 10 Jul 2025 03:41:56 +0000
Message-ID: <20250710034201.39901-1-ziyao@disroot.org>
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

TH1520 SoC integrates two MAC controllers based on Designware IP that
could operate at 1 Gbps. This series ports the MAC glue driver from
Linux, and then enables networking on the TH1520-based Lichee Pi 4A
board.

The driver could send and receive data correctly under link speed of
10Mbps, 100Mbps and 1Gbps. Under 1Gbps, tftp could transfer data at
more than 10MiB/s.

Note the bug fixed by the first patch doesn't cause any problem with
existing supported peripherals, thus the fix isn't urgent.

Yao Zi (5):
  clk: thead: th1520-ap: Correctly handle flags for dividers
  riscv: cpu: th1520: Limit upper RAM boundary to 4 GiB
  drivers: net: Add T-Head DWMAC glue layer
  riscv: dts: th1520: Describe GMACs and enable them on Lichee Pi 4A
  configs: th1520_lpi4a: Enable network support

 MAINTAINERS                                 |   1 +
 arch/riscv/cpu/th1520/dram.c                |  16 ++
 arch/riscv/dts/th1520-lichee-module-4a.dtsi | 119 ++++++++
 arch/riscv/dts/th1520.dtsi                  |  42 +++
 configs/th1520_lpi4a_defconfig              |   7 +-
 drivers/clk/thead/clk-th1520-ap.c           |   4 +-
 drivers/net/Kconfig                         |   8 +
 drivers/net/Makefile                        |   1 +
 drivers/net/dwmac_thead.c                   | 288 ++++++++++++++++++++
 9 files changed, 484 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/dwmac_thead.c

-- 
2.50.0

