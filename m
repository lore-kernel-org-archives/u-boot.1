Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E24C369CA
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 00:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A9382F73;
	Thu, 17 Apr 2025 02:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E7F882F6A; Thu, 17 Apr 2025 02:06:37 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0B9FD8192A
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 02:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04750152B;
 Wed, 16 Apr 2025 17:06:32 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34B0A3F66E;
 Wed, 16 Apr 2025 17:06:33 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Yixun Lan <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/3] sunxi: add "fake" FEL button feature
Date: Thu, 17 Apr 2025 01:05:36 +0100
Message-ID: <20250417000539.3709-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
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

Some boards with Allwinner SoCs feature a "FEL" key, sometimes also
labelled "uboot", which allows to easily enter the BootROM FEL mode, when
pressed upon power-on or reset. This allows to access the USB-OTG boot
protocol, for convenient access to memory and uploading code.

Add a software emulation of this functionality for boards without a button
connected to this special SoC pin, to give easy FEL access to more
boards. Any GPIO can be used, as long as the button uses active-low
logic.

This is used on the X96 Mate TV box, where the hidden "update" button is
actually just some GPIO, checked by the vendor firmware.

Please have a look!

Cheers,
Andre

Changelog v1 .. v2:
- add patch to fix return_to_fel() prototype
- document signal needs to be active-low
- activate internal pull-up resistors
- add patch to activate button on the X96 Mate TV box

Andre Przywara (3):
  sunxi: fix return_to_fel() prototype
  sunxi: add "fake" FEL pin support
  sunxi: x96_mate: Add "fake" FEL key definition

 arch/arm/include/asm/arch-sunxi/sys_proto.h |  4 +--
 arch/arm/mach-sunxi/Kconfig                 | 10 +++++++
 arch/arm/mach-sunxi/board.c                 | 31 +++++++++++++++++++++
 configs/x96_mate_defconfig                  |  1 +
 4 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.46.3

