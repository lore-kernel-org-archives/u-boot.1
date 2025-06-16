Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B38C71155
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 12:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE2181760;
	Mon, 16 Jun 2025 14:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KAMq16Lw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8EF881E18; Mon, 16 Jun 2025 14:12:38 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70D418070C
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 14:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 78B43A4D857;
 Mon, 16 Jun 2025 12:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFE4C4CEEA;
 Mon, 16 Jun 2025 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750075955;
 bh=z2cf/2GGsK08Hwd4q7O+juDrNO9zV+NCCZnkrEKvkkI=;
 h=From:To:Cc:Subject:Date:From;
 b=KAMq16Lw7EFK5njfC7ziH+Oy1mIJ8bknWeXkOB0oZqkyvr4sVAkgl8/IHBqXYo66g
 dvZweodQITcvQ6dTpfHZht5ShhoHqjTRP0rtLwIBR6A/athJQIZIRnQff60GMjf18z
 Nka82WhUe15ubA9U+JeBTzX6o0+wihbJjDID44UfNG8vFGphz/I5KmGl8HF39HwRVP
 HN27JwEswDE4A6YnOl1Uc/sp//KdjZRPjnEukSXdwewJ6XuLc/Kvz2+ezOyfEv0bgR
 HKBXgrrEjI+OXpHbcbdexZgmGrxwVPLg3wSH3Gslb76fqxeB+MvOzdHMO0jJPdTJnC
 Zb/qU7SQx+XMQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Kory Maincent
 <kory.maincent@bootlin.com>, Ivan Pang <ipman@amazon.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20250616 into master
Date: Mon, 16 Jun 2025 14:12:32 +0200
Message-ID: <87zfe7ga1b.fsf@kernel.org>
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

Please find the following fixes for master:

Usb gadget:
- Fix ti_musb driver in gadget mode (with DM_USB_GADGET)

DFU:
- mmc/scsi backends when using 10 or more partitions

CI job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26696

Thanks,
Mattijs

The following changes since commit c5afa1fef49f55146e78d6157470520391c40eca:

  Merge tag 'rpi-2025.07-rc4' of https://source.denx.de/u-boot/custodians/u-boot-raspberrypi (2025-06-15 10:31:03 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20250616

for you to fetch changes up to e6eca9ea6457e79acb4e2a426f1e078842c17b25:

  usb: gadget: musb: Fix duplicate ops assignment in ti_musb_peripheral (2025-06-16 09:00:55 +0200)

----------------------------------------------------------------
u-boot-dfu-20250616

Usb gadget:
- Fix ti_musb driver in gadget mode (with DM_USB_GADGET)

DFU:
- mmc/scsi backends when using 10 or more partitions

----------------------------------------------------------------
Ivan Pang (1):
      dfu: fix dev_part_str for file operations

Kory Maincent (1):
      usb: gadget: musb: Fix duplicate ops assignment in ti_musb_peripheral

 drivers/dfu/dfu_mmc.c          | 2 +-
 drivers/dfu/dfu_scsi.c         | 2 +-
 drivers/usb/musb-new/ti-musb.c | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)
