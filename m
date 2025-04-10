Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B227C369A6
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 13:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 875B083CCA;
	Thu, 10 Apr 2025 15:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I/jBpjLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60F3183CCF; Thu, 10 Apr 2025 15:36:20 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8BD883C02
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 15:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 92A625C577D;
 Thu, 10 Apr 2025 13:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC66C4CEEC;
 Thu, 10 Apr 2025 13:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744292176;
 bh=cpWwgPnOgrQG3GszWv6U/6rQCsCRmqvLkbQ3nYlXYqM=;
 h=From:To:Cc:Subject:Date:From;
 b=I/jBpjLe7WVJ6olgaGh47pcmncMfE9bL2F9w7AqkDVkyzq5Bn7ygahbLmR5243X4L
 wuiFEiNgMLNz1SKd13nW/FlkIDIz+Gx+FuflRa9egw8c1BQQu0NHjnB0bjWqgn7u3j
 C8jQ3kmeKjVNYta27147+5NWV7rwChYMEkEyp1/VuNN/jxRdQmc23PE0ptqAx570ky
 FBfrvqHPn0i+TXcexMIws1n8cpRqwIzx4bZHRx+arCn2BTo4eFeUaZD5Q4Ev6KyApW
 4mxT01cSw3X3FIAD/a51h3BBvS7dRzyFrDmachE7p6aSDIhlMymoR2EVDFhznaPzH4
 6HYLiXQlfutmg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Gary Bisson <bisson.gary@gmail.com>,
 Marek Vasut <marex@denx.de>, Michael Walle <mwalle@kernel.org>, Zixun LI
 <admin@hifiphile.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20250410 into master
Date: Thu, 10 Apr 2025 15:36:12 +0200
Message-ID: <87semgf8ab.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Please find the following fixes/developments for master.

Usb gadget:
- Add SAM9X60 support to atmel driver
- Fix memory leaks in f_mass_storage gadget driver
- Fix comment typo in dwc3 gadget driver

Fastboot:
- Lift restrictions on !NET_LWIP for USB

Android:
- Fix possible NULL ptr when AVB is out of memory

CI Job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/25615

Thanks,
Mattijs

The following changes since commit 8a2cf6307a2ccc09c39dde486b6d9375b78c82c2:

  CI: Disable evb-ast2600 (2025-04-09 18:34:08 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20250410

for you to fetch changes up to df50c821e75957113b93e45b363cb22c965e7a9b:

  bootstd: android: avoid possible null pointer dereference (2025-04-10 10:03:21 +0200)

----------------------------------------------------------------
u-boot-dfu-20250410

Usb gadget:
- Add SAM9X60 support to atmel driver
- Fix memory leaks in f_mass_storage gadget driver
- Fix comment typo in dwc3 gadget driver

Fastboot:
- Lift restrictions on !NET_LWIP for USB

Android:
- Fix possible NULL ptr when AVB is out of memory

----------------------------------------------------------------
Gary Bisson (1):
      bootstd: android: avoid possible null pointer dereference

Marek Vasut (1):
      usb: dwc3: gadget: Fix excepts/expects typo

Mattijs Korpershoek (4):
      usb: gadget: f_mass_storage: Remove kref structure use
      usb: gadget: f_mass_storage: Drop invalid kfree() in fsg_common_release()
      usb: gadget: f_mass_storage: Fix NULL dereference in fsg_add()
      usb: gadget: f_mass_storage: Fix memory leak of fsg buffers

Michael Walle (1):
      fastboot: lift restrictions on !NET_LWIP for USB

Zixun LI (1):
      usb: gadget: atmel: Add SAM9X60 support

 arch/arm/mach-at91/include/mach/atmel_usba_udc.h |  2 +-
 boot/bootmeth_android.c                          |  6 ++++--
 cmd/fastboot.c                                   |  4 ++++
 drivers/fastboot/Kconfig                         |  1 -
 drivers/fastboot/fb_common.c                     |  4 ++++
 drivers/usb/dwc3/gadget.c                        |  2 +-
 drivers/usb/gadget/atmel_usba_udc.c              |  1 +
 drivers/usb/gadget/f_mass_storage.c              | 18 ++++++------------
 8 files changed, 21 insertions(+), 17 deletions(-)

