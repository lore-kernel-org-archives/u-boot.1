Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0958CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 15:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C026081D6A;
	Wed,  1 Oct 2025 17:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VtPF7isi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7604883335; Wed,  1 Oct 2025 17:24:28 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA65800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 17:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BA34761E73;
 Wed,  1 Oct 2025 15:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20742C4CEF1;
 Wed,  1 Oct 2025 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759332264;
 bh=PzpSS2pH/QIcqZbFs9ta5+TMJQLtQGr9YS9BzbApq1Q=;
 h=From:To:Cc:Subject:Date:From;
 b=VtPF7isinSC+OcbiDZMNlXLDs4nis/BSMZjVbSdHfDgNEECeFt9BtV/rl4i/lijHJ
 ISAk5Y2Zyfcje+TnO9jfEvDM4P9jpZl8O34CZx16yetxMe9bpPfmNvAmZqgbtbE/8h
 OtxKtuAK+V51KYUrWPtaO2Bp1V/R+mDtYm65f32qAT6iBF1SCi9/G/07ve+532Y8x/
 J39UY2xbYZ4s5gApm1hTQA1ffVOHAU8ps8VZldKsYWY/W/+YiRKobyPIBkEsTBK43q
 Oni6BeMM7snAoQ0iWLVhjzwB1tbgT9NWvWau8EQy9us9L4R3PhG0/1nu3LnoJnpvvV
 c3+NAsCsEYB7Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Chance Yang <chance.yang@kneron.us>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20251001 into next
Date: Wed, 01 Oct 2025 17:24:22 +0200
Message-ID: <877bxeir15.fsf@kernel.org>
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

I'm finally back from paternity leave.
Thanks again for picking up the urgent things while I was away.

Here is a small PR for next:

Fastboot:
- Fix has-slot command when using nand back-end.

USB gadget:
- Add missing null checks to atmel, dwc2 drivers (smatch)
- Remove redundant check in dwc3 gadget (smatch)

CI:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/27791

Regards,
Mattijs

The following changes since commit 9710d98e8942151fc0c62d54100d9d27e8263d04:

  Merge tag 'doc-next-2025-09-27' of https://source.denx.de/u-boot/custodians/u-boot-efi into next (2025-09-27 09:49:01 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20251001

for you to fetch changes up to 8cd4a5e94ba2ab73fde3301d6314549dd5a25cb4:

  usb: dwc3: Remove redundant test (2025-09-30 11:55:23 +0200)

----------------------------------------------------------------
u-boot-dfu-next-20251001

Fastboot:
- Fix has-slot command when using nand back-end.

USB gadget:
- Add missing null checks to atmel, dwc2 drivers (smatch)
- Remove redundant check in dwc3 gadget (smatch)

----------------------------------------------------------------
Andrew Goodbody (3):
      usb: gadget: atmel: Add missing null check
      usb: dwc2: Add missing null check
      usb: dwc3: Remove redundant test

Chance Yang (1):
      fastboot: Fix has-slot command always returning yes for fb_nand

 drivers/fastboot/fb_nand.c                 | 7 ++++++-
 drivers/usb/dwc3/ep0.c                     | 5 +----
 drivers/usb/gadget/atmel_usba_udc.c        | 2 +-
 drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)
