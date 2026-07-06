Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD16CC43602
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 17:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9C6C846FD;
	Mon,  6 Jul 2026 19:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B65DE84852; Mon,  6 Jul 2026 19:20:33 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0850846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 19:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id C148E68BEB; Mon,  6 Jul 2026 19:20:28 +0200 (CEST)
Subject: [PATCH v2 0/4] Fix NVMe, not only on Raspberry Pi 5
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Prashant Kamble <prashant.kamble223@gmail.com>,
 Denis Mukhin <dmukhin@ford.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 u-boot@lists.denx.de, duwe@lst.de
Message-Id: <20260706172028.C148E68BEB@verein.lst.de>
Date: Mon,  6 Jul 2026 19:20:28 +0200 (CEST)
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

Hi,

Here's the rework of the central fix as requested by Neil, the DMA
addresses as required by the NVMe device are no longer calculated
"last minute" before going into the registers or into the memory
locations, but early, as they occur.  Hopefully talking variable names
and member names are used to store the values when they are needed at
a later point.

Changes from v1:
  - rework address translation towards the source,
    storing the calculated dma (bus) values where applicable
  - add a unit test for phys_to_bus
  - automatically scan for any NVMes to maybe boot the Pi from
  - remove some dead code
  - add Peter's review and test tags

Changes from the single patch:
  - the ternary in the macro is gone, explanation updated accordingly
  - instead, device_get_dma_constraints is enhanced to try harder
  - Raspberry Pi NVMe config added

Torsten Duwe (4):
  core: Skip parent device nodes without a DT reference when looking for
    dma-ranges
  test: Add a unit test in phys_to_bus for dynamically created device nodes
  nvme: Fix missing address translation for PCIe inbound access
  configs: enable NVMe

 arch/sandbox/dts/test.dts   |  9 +++++
 configs/rpi_arm64_defconfig |  3 +-
 drivers/core/device.c       | 14 +++++++-
 drivers/nvme/nvme.c         | 71 ++++++++++++++-----------------------
 drivers/nvme/nvme.h         |  3 ++
 test/dm/phys2bus.c          | 25 ++++++++++++-
 6 files changed, 77 insertions(+), 48 deletions(-)

-- 
2.54.0

