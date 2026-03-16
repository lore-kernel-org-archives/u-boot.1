Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A59F506C3
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 12:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F261C84035;
	Mon, 16 Mar 2026 13:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qmHaM81b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7550F8403D; Mon, 16 Mar 2026 13:38:23 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 263A08400F
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 13:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BAF7D40640;
 Mon, 16 Mar 2026 12:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D790C19421;
 Mon, 16 Mar 2026 12:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773664699;
 bh=cZHOQPmuyWBm/bfILa1B0V0nmVciKotP3cMu4nz6mVc=;
 h=From:To:Cc:Subject:Date:From;
 b=qmHaM81bwrbdfbyu4hpEEaXCOUjWVbmbS7WmBIJvqHNkXN3vJjNzqWyuxCPcv/LvN
 TzctVl3TjEkwnc5jAuaRc1/unEvPAsd6+IFWTqwvMYq4SG8ymKDNtgRj0cd3qZlRQi
 GstVAP2lo0HIeF4+QwrWzLcXbHZLgbU4Hw7UJs9nBmM8FFHviHe1NqP8H/s7QNm4lQ
 ziLoUxsTbJaxj6Kp1vNXM8nCTWzp9ojZ38lDlfFV6l+M8wFGWDwinrJufKrBk7LDBT
 KWkIMPHwqQTr2GqaWMBSXs6Aa6hBELTjn/CRe1j2O3uZO3rQ7MHX+H4wf62ylDVZ9f
 lC+0f88v2X1Bg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20260316 into master
Date: Mon, 16 Mar 2026 13:38:17 +0100
Message-ID: <87y0jsrlty.fsf@kernel.org>
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

Here is a PR for master.

It contains a couple of very small changes. I don't think that they are
particularly urgent so if you prefer I can also resend them for next
instead.

DFU:
* Make DFU_WRITE_ALT symbol available outside of DFU
* Fix PCI subclass_code warning in spl_dfu

Usb Gadget:
* Mark udc_disconnect() as static

CI:
* https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/29533

Thanks,
Mattijs

The following changes since commit 8d24789abed0822fbe41a2f9d72cf19650159dc6:

  common/memsize.c: Fix get_ram_size() original data restore (2026-03-02 08:21:47 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20260316

for you to fetch changes up to 4b77b07811c2fb48b4a65ae14c387540ae6b8998:

  dfu: Make the DFU_WRITE_ALT symbol available outside of DFU (2026-03-16 10:38:47 +0100)

----------------------------------------------------------------
u-boot-dfu-20260316

DFU:
* Make DFU_WRITE_ALT symbol available outside of DFU
* Fix PCI subclass_code warning in spl_dfu

Usb Gadget:
* Mark udc_disconnect() as static

----------------------------------------------------------------
Siddharth Vadapalli (1):
      common: spl: spl_dfu.c: Fix warning associated with PCI subclass_code

Tom Rini (2):
      usb: gadget: Mark udc_disconnect as static
      dfu: Make the DFU_WRITE_ALT symbol available outside of DFU

 arch/arm/include/asm/bootm.h | 2 --
 common/spl/spl_dfu.c         | 2 +-
 drivers/dfu/Kconfig          | 2 +-
 drivers/usb/gadget/ci_udc.c  | 2 +-
 include/usb.h                | 9 ---------
 include/usb/udc.h            | 1 -
 6 files changed, 3 insertions(+), 15 deletions(-)
