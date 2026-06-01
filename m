Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC61CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 10:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C418487C;
	Mon,  1 Jun 2026 12:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 381FF8487F; Mon,  1 Jun 2026 12:36:02 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F6A184878
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 12:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 022EB68B05; Mon,  1 Jun 2026 12:35:57 +0200 (CEST)
Subject: [PATCH v5 0/9] ARM: RPi5: Enable PCIe
To: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>,"Jan Čermák" <sairon@sairon.cz>,Andrea della Porta <andrea.porta@suse.com>,"Ivan T. Ivanov" <iivanov@suse.de>, Stanimir Varbanov <stanimir.varbanov@suse.com>, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Volodymyr Babchuk <volodymyr_babchuk@epam.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,Paul Barker <paul.barker.ct@bp.renesas.com>,Patrice Chotard <patrice.chotard@foss.st.com>,Christian Marangi <ansuelsmth@gmail.com>,Patrick Delaunay <patrick.delaunay@foss.st.com>,Huan Zhou <me@per1cycle.org>,Gabriel Fernandez <gabriel.fernandez@foss.st.com>,Kever Yang <kever.yang@rock-chips.com>,Jonas Karlman <jonas@kwiboo.se>,Joseph Chen <chenjh@rock-chips.com>,Elaine Zhang <zhangqing@rock-chips.com>, Pedro Falcato <pfalcato@suse.de>,u-boot@lists.denx.de,duwe@lst.de
Message-Id: <20260601103557.022EB68B05@verein.lst.de>
Date: Mon,  1 Jun 2026 12:35:56 +0200 (CEST)
From: duwe@lst.de (Torsten Duwe)
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

Basic PCIe support for the RPi5. This is the prerequisite for PCIe
slot adapters / HATs and NVMe storage. Those might require their own
supporting drivers or changes. It is also the prerequisite for all
peripherials residing on the RP1 I/O controller, like USB, network,
GPIOs and all serial ports beyond the debug connector.

Changes from v4:
  - fixed remaining style issues, no functional changes
  - patches 3&6 Reviewed-by Neil Armstrong

Changes from v3:
  - differentiate only between bcm2711 and -12. No possible future
    extensions for other chips. In particular, keep EXT_CFG_INDEX and
    EXT_CFG_DATA offsets fixed, no functions in the cfg struct that
    are the same for both, like bridge_sw_init_set and rc_mode.
  - pass error codes through the newly introduced reset call chain
  - some patches Reviewed-by Neil Armstrong

Changes from v2:
  - fix wrong subject prefixes
  - make reset drivers only found on the RPi5 depend on ARCH_BCM283X
  - some patches Reviewed-by Peter Robinson

Changes from v1:
  - fixed inbound window rewrite, which broke RPi4
  - series Tested-by Pedro Falcato

Andrea della Porta (1):
  pci: brcmstb: Fix PCIe bus numbers

Torsten Duwe (8):
  ARM: bcm283x: Add bcm2712 PCIe memory window
  pci: brcmstb: Support different variants using a cfg struct
  reset: Add RPi5 brcmstb reset facilities
  reset: Add RPi5 rescal reset facilities
  pci: brcmstb: Get and use bridge and rescal reset properties
  pci: brcmstb: Fix iBAR size calculation
  pci: brcmstb: rework iBAR handling
  pci: brcmstb: Adapt to AXI bridge

 .../mach-bcm283x/include/mach/acpi/bcm2711.h  |   6 +
 arch/arm/mach-bcm283x/init.c                  |  10 +-
 configs/rpi_arm64_defconfig                   |   2 +
 drivers/pci/pcie_brcmstb.c                    | 389 ++++++++++++++++--
 drivers/reset/Kconfig                         |  16 +
 drivers/reset/Makefile                        |   2 +
 drivers/reset/reset-brcmstb-rescal.c          | 103 +++++
 drivers/reset/reset-brcmstb.c                 |  97 +++++
 8 files changed, 589 insertions(+), 36 deletions(-)
 create mode 100644 drivers/reset/reset-brcmstb-rescal.c
 create mode 100644 drivers/reset/reset-brcmstb.c

-- 
2.54.0

