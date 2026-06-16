Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B644ECD98CF
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 08:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D570846CF;
	Tue, 16 Jun 2026 10:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K/1XW/qg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD188484C; Tue, 16 Jun 2026 10:26:20 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14B96846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 10:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6FD4C408E1;
 Tue, 16 Jun 2026 08:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06331F000E9;
 Tue, 16 Jun 2026 08:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781598376;
 bh=wL+buX22O/BqcrwyR1kw7BtEmaJxS3FHu/lgM362BLw=;
 h=From:To:Cc:Subject:Date;
 b=K/1XW/qg7gVsZCdGpUrzCCUf3OkGK07WkGVMeRfy3p3ETH3CScGJCvxogogpTbE0V
 bliww+f0SwPzDWRrG1HYj/wp+1H8IM46beIFFTKqEE+kxXQjyD9148/ZpPSeOqq0s7
 fBkXVFmSjJ79AI2ZwKSy6ZaAhq34kY2Gdufa1kEdQz8AbUU+s3HLC3PRK356ERyvYq
 gokiXDl7sJjaGdcRiQU9jiqOsYAXv8P3wL9+uQvqVXXwhA7mejzhT2RjfqkE3xs2US
 nTGnK1dIyDGnu+q8VNLCQteBTdbo5ddK/uJsLV3HfVmJjL9JU4h2zqCs5Es1nXxllx
 EpHj1YFI43Ymw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Francois Berder <fberder@outlook.fr>,
 Zixun LI <admin@hifiphile.com>, Colin Pinnell McAllister
 <colinmca242@gmail.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20260616 into master
Date: Tue, 16 Jun 2026 10:26:13 +0200
Message-ID: <87qzm6howq.fsf@kernel.org>
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

Here is a PR for master with some fixes for Android, Fastboot and Usb
Gadget:

Android:
* Fix A/B slot selection when marked successful and tries = 0

Fastboot:
* Handle partial blk_dwrite() as errors instead of success

Usb Gadget:
* Atmel: Use calloc() to initialize endpoint list

CI:
* https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/30480

I know it's pretty late in the release cycle already so if you prefer to
pull this into next (or if I should a new PR), let me know.

Thanks,
Mattijs

The following changes since commit 1e80ee41441c612f05787a93bbef4e6e422e29d1:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2026-06-14 15:35:00 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20260616

for you to fetch changes up to 033eb908d0a8ed938bc652f34a2d702a29a8726f:

  usb: gadget: atmel: use calloc() to allocate endpoint list (2026-06-15 09:15:25 +0200)

----------------------------------------------------------------
u-boot-dfu-20260616

Android:
* Fix A/B slot selection when marked successful and tries = 0

Fastboot:
* Handle partial blk_dwrite() as errors instead of success

Usb Gadget:
* Atmel: Use calloc() to initialize endpoint list

----------------------------------------------------------------
Colin Pinnell McAllister (1):
      android_ab: fix slot selection

Francois Berder (1):
      fastboot: Fix blk_dwrite error checking

Zixun LI (1):
      usb: gadget: atmel: use calloc() to allocate endpoint list

 boot/android_ab.c                   | 7 +++++--
 drivers/fastboot/fb_mmc.c           | 6 +++---
 drivers/usb/gadget/atmel_usba_udc.c | 2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

