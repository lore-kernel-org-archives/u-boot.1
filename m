Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C232AC54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 14:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D5482012;
	Mon,  2 Jun 2025 16:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QOspEwOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70D4282045; Mon,  2 Jun 2025 16:36:58 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E3081FFC
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 16:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A04849B98;
 Mon,  2 Jun 2025 14:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3846C4CEEE;
 Mon,  2 Jun 2025 14:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748875014;
 bh=+sS4hGl97kfhDWr8RISJbTi3zp33uZ2oCetVcBhBguk=;
 h=From:To:Cc:Subject:Date:From;
 b=QOspEwOPxGXBpibV5J8py4MijuSgtAmmJZG0SMB5PQ4/O8XyVhgtZd9Q8e/5fjlMU
 SRJ6BABZ0h3dhhDDkJDfexDICHjD6/LBf5FhPJlBGsGblMYoaALRIl1ehgL0uZPrDL
 3rNJ+daJLG2nxu7twgZKqpLW9pLvdU5AL/LnOT8UF2aQe5x6rC92ep2GwwVDbcdq98
 qRAAweQkEOJQrINb5bpPRYXthvNRY5aNXClW2kthwE8U8IR4OZGmqrHALgWs9q3EA5
 HyfDHam9dKUuAXyhVi+8IkgAVAmu8XpGQXWSk7xvMQ7U7BtGQ35Fib3B1S11Pma2u8
 QkQK3B1kLHKMA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20250602 into next
Date: Mon, 02 Jun 2025 16:36:51 +0200
Message-ID: <87ldqamcqk.fsf@kernel.org>
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

Please find the following developments for next:

Usb gadget:
- dwc2: Fix incorrect ULPI_UTMI_SEL bit setting
- dwc2: Fix HBstLen setting for external DMA mode
- dwc2: Various refactors to get the code closer to Linux
- dwc2: Support reset logic for v4.20a

CI Job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26466

Thanks,
Mattijs

The following changes since commit 6e03ca240945ebf78d72e6839e9972c8e3893e54:

  Merge tag 'dm-pull-30may25' of git://git.denx.de/u-boot-dm into next (2025-05-30 13:53:50 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20250602

for you to fetch changes up to 42911f61b776cda40ba2b8c9e57988a84ad359a5:

  usb: dwc2: Refactor register operations with clrsetbits macros (2025-06-02 10:02:46 +0200)

----------------------------------------------------------------
u-boot-dfu-20250602

Usb gadget:
dwc2: Fix incorrect ULPI_UTMI_SEL bit setting
dwc2: Fix HBstLen setting for external DMA mode
dwc2: Various refactors to get the code closer to Linux
dwc2: Support reset logic for v4.20a

----------------------------------------------------------------
Junhui Liu (2):
      usb: dwc2: Fix incorrect ULPI_UTMI_SEL bit setting
      usb: dwc2: Refactor register operations with clrsetbits macros

Kongyang Liu (7):
      usb: dwc2: Extract register definitions to common header file
      usb: dwc2: Fix HBstLen setting for external DMA mode
      usb: dwc2: Clean up with bitfield macros
      usb: dwc2: Align macros with Linux kernel definitions
      usb: dwc2: Extract macro definitions to common header
      usb: dwc2: Unify flush and reset logic with v4.20a support
      usb: dwc2: Replace uint<x>_t types with u<x>

 drivers/usb/common/Makefile                |   2 +
 drivers/usb/common/dwc2_core.c             | 131 +++++
 drivers/usb/common/dwc2_core.h             | 560 +++++++++++++++++++++
 drivers/usb/gadget/dwc2_udc_otg.c          | 119 +++--
 drivers/usb/gadget/dwc2_udc_otg_phy.c      |  33 +-
 drivers/usb/gadget/dwc2_udc_otg_regs.h     | 289 ++---------
 drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 311 ++++++------
 drivers/usb/host/dwc2.c                    | 494 ++++++++-----------
 drivers/usb/host/dwc2.h                    | 750 +----------------------------
 9 files changed, 1145 insertions(+), 1544 deletions(-)
 create mode 100644 drivers/usb/common/dwc2_core.c
 create mode 100644 drivers/usb/common/dwc2_core.h
