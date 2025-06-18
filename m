Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0F2C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 09:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D128882CC9;
	Wed, 18 Jun 2025 11:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="NwPmcd1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D68B882CD5; Wed, 18 Jun 2025 11:55:22 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6407882C8D
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 11:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 190532600C;
 Wed, 18 Jun 2025 11:55:20 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JzaSR9qe_T4T; Wed, 18 Jun 2025 11:55:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1750240519; bh=FMhVz31SglFFiw7vt3c+us4DDz6sylB8R3Skx+k2BXU=;
 h=From:To:Cc:Subject:Date;
 b=NwPmcd1CChKwc0rJQMMnworFSSWD9gwU6xC5WFcvHCWkL/KCG0fKtUB/h76asjcrO
 wS2MiFmn7fOp4vugPa8GxEC01/YQJ0hch6uWOO8fohhxfbJKefEtdveQiox+nFouAf
 f8oUoF3ZrifpSUUEcNkmOKRZLNXFeheTYgT6FEYwHtYvj5NtLd73XvPXkeY02zbVrb
 E0ozWngGl97DhqvX1z3WZZTv5d9IHmu7Wa60VAu2BCkhmJ2GsBbL4/3c5B3Z8CNV3v
 FgMRQphck/WMYbqnbE/P9lPmVxIwh7QqUKYa5zXjaunhg+CW+1ZyvAoZdOJbhsl8/W
 msOnWJeiDBemw==
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 0/3] Add pinctrl support for TH1520 SoC
Date: Wed, 18 Jun 2025 09:54:54 +0000
Message-ID: <20250618095457.45926-1-ziyao@disroot.org>
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

This series adds pin configuration support for TH1520 SoC with a
driver ported from Linux kernel, and enables it by default. As a test,
random configuration is specified in devicetree, then the effects are
verified by reading back registers or observing hardware behavior.

With several downstream patches, I've also successfully brought up the
second GMAC controller on TH1520. Since the controller won't work with
the default pin configuration, this also serves as a proof of the
driver's functionality.

This series may depend on the previous series "Bring up secondary cores
on Lichee Pi 4A"[1] for a clean apply. An output of pinmux status -a
could be obtained here[2].

[1]: https://lore.kernel.org/u-boot/20250606042804.64311-1-ziyao@disroot.org/
[2]: https://gist.github.com/ziyao233/55738ed1a33d450ccb1dc3752494a2b4

Yao Zi (3):
  pinctrl: Port pin controller driver for T-Head TH1520 SoC
  riscv: dts: th1520: Add pin controllers
  riscv: cpu: th1520: Enable pinctrl by default

 MAINTAINERS                      |   1 +
 arch/riscv/cpu/th1520/Kconfig    |   1 +
 arch/riscv/dts/th1520.dtsi       |  28 ++
 configs/th1520_lpi4a_defconfig   |   1 +
 drivers/pinctrl/Kconfig          |   8 +
 drivers/pinctrl/Makefile         |   1 +
 drivers/pinctrl/pinctrl-th1520.c | 700 +++++++++++++++++++++++++++++++
 7 files changed, 740 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-th1520.c

-- 
2.49.0

