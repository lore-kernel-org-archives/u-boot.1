Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D2DCD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B5084D5A;
	Fri,  8 May 2026 17:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 074C284D62; Fri,  8 May 2026 17:41:13 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4441484D2F
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 336B968BEB; Fri,  8 May 2026 17:41:08 +0200 (CEST)
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
    Tom Rini <trini@konsulko.com>, Andrea della Porta <andrea.porta@suse.com>,
    Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
    "Jan Čermák" <sairon@sairon.cz>, Bin Meng <bmeng.cn@gmail.com>,
    Andrew Goodbody <andrew.goodbody@linaro.org>, duwe@lst.de
Subject: [PATCH 0/3] Fix NVMe, not only on Raspberry Pi 5
Message-Id: <20260508154108.336B968BEB@verein.lst.de>
Date: Fri,  8 May 2026 17:41:08 +0200 (CEST)
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

Hi all,

This simple quick fix has now turned into a small series. It contains
the required changes to translate inbound access addresses, with the
handling of dynamically found devices going into its own patch, content
as suggested by Neil. While at it, I also added the NVMe enablement for
raspberries. It might already work on RPi4 setups (to be tested). RPi5
OTOH will require the other series to enable PCIe on the bcm2712.

Changes from the single patch:
  - the ternary in the macro is gone, explanation updated accordingly
  - instead, device_get_dma_constraints is enhanced to try harder
  - Raspberry Pi NVMe config added

Torsten Duwe (3):
  Skip parent device nodes without a DT reference when looking for
    dma-ranges
  Fix missing address translation for PCIe inbound access
  rpi: enable NVMe

 configs/rpi_arm64_defconfig |  1 +
 drivers/core/device.c       | 14 +++++++++++++-
 drivers/nvme/nvme.c         | 34 +++++++++++++++++++++-------------
 3 files changed, 35 insertions(+), 14 deletions(-)

-- 
2.54.0

