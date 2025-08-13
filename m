Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33331CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 10:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB5582AC4;
	Wed, 13 Aug 2025 12:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="d2IyJ5fi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8688582AFC; Wed, 13 Aug 2025 12:10:10 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 209DC82063
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 12:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id CE2EE25746;
 Wed, 13 Aug 2025 12:10:07 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bhGkdUV3PCRR; Wed, 13 Aug 2025 12:10:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1755079806; bh=wQTC+NUhW2kSO23LQmblCa1dUMsZH8Tf25S8yIeo9KY=;
 h=From:To:Cc:Subject:Date;
 b=d2IyJ5fifbBO5lgv3l44Jvqo8EHCqmXnEdGIzfloECcCPDcqbfnYWB3qxOySf1lEe
 0mBTjP8CQxv6DeF/ol+ZGw+lD28xf3ARniW2TrS+d+7Dmf54BOzW1P/XDfw5qPXYOz
 spKXln/PbjjgGLLTjxBnsiTDHlHBAhgRH3PNi6hzegDjMuy1KMA+i1CJpFj9y/jQ+d
 nmciNc9XQ45gXs7lWzYpMLOXs3EqRhu74nAx/8QkHzFve6dTPiEjApRFEScRy4JerS
 UdvSFCQOL98Yw8uvtlIQgZa32zBrNfOJCFsHxby9PdnAuHAc43LPljYv1vg8ixDZHl
 ouwVh/1UW8fBw==
From: Yao Zi <ziyao@disroot.org>
To: Yao Zi <ziyao@disroot.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 0/4] Switch to upstream devicetree for TH1520 platform
Date: Wed, 13 Aug 2025 10:09:23 +0000
Message-ID: <20250813100926.51725-2-ziyao@disroot.org>
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

This series switches the TH1520 platform along with the only board,
th1520_lpi4a, to use upstream devicetree.

The upstream dt specifies pinctrl configuration for the UART, which is
probed before proper U-Boot relocation. This means we must make
pincontroller, and resource used by the pincontroller available in
relocation. too, so here come PATCH 2 and 3.

Making more drivers bind and probe before relocation raises requirement
of pre-relocation malloc pool, PATCH 1 increases SYS_MALLOC_F_LEN to
0x10000 to fit drivers' usage.

Tested on Lichee Pi 4A 16GiB variant, and it introduces no functionality
regression. Thanks for your time and review.

Yao Zi (4):
  configs: th1520_lpi4a: Enlarge SYS_MALLOC_F_LEN to 0x10000
  clk: thead: th1520-ap: Mark drivers as DM_FLAG_PRE_RELOC
  pinctrl: th1520: Mark driver as DM_FLAG_PRE_RELOC
  dts: th1520: Switch to upstream devicetree

 arch/riscv/cpu/th1520/Kconfig                 |   1 +
 arch/riscv/dts/Makefile                       |   1 -
 .../dts/th1520-lichee-module-4a-u-boot.dtsi   |  10 +
 arch/riscv/dts/th1520-lichee-module-4a.dtsi   | 164 ------
 .../riscv/dts/th1520-lichee-pi-4a-u-boot.dtsi |  27 +
 arch/riscv/dts/th1520-lichee-pi-4a.dts        |  33 --
 arch/riscv/dts/th1520-u-boot.dtsi             |  44 ++
 arch/riscv/dts/th1520.dtsi                    | 530 ------------------
 configs/th1520_lpi4a_defconfig                |   4 +-
 drivers/clk/thead/clk-th1520-ap.c             |   3 +
 drivers/pinctrl/pinctrl-th1520.c              |   1 +
 11 files changed, 88 insertions(+), 730 deletions(-)
 create mode 100644 arch/riscv/dts/th1520-lichee-module-4a-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/th1520-lichee-module-4a.dtsi
 create mode 100644 arch/riscv/dts/th1520-lichee-pi-4a-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/th1520-lichee-pi-4a.dts
 create mode 100644 arch/riscv/dts/th1520-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/th1520.dtsi

-- 
2.50.1

