Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEFECD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1D4846BD;
	Thu, 21 May 2026 17:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gmTtmO2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 751FD846F9; Thu, 21 May 2026 17:24:37 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8EC1844CF
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 17:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 83495600C3;
 Thu, 21 May 2026 15:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD761F000E9;
 Thu, 21 May 2026 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779377073;
 bh=6YERgR01SiCvlUW7ikt0oYrutFcjXbVY3dh4uSvCaNc=;
 h=From:To:Cc:Subject:Date;
 b=gmTtmO2JyPZxfRZV88wX+KmfVg+UeScA6bnbcsgNzF7xORL4ptgBahKQVvZiRXIcz
 HtDrusHMO1UNuGHVXVJpl9ZAmrUIjJ9MpFtU91AJ00OuiIdJn67/qAKDR61qphg2kW
 Iaxc+ceQRMatau7nYTZ5fbcuf33zGzAAlmaiwyV+RWxSp/qL8UVefWwOhQeVv3P3sj
 CW4d1eXZIZur0UZ/ocdi+n8g/MXRR2hZb+pCo0WJtDyMSeDZTiX46bmzfWfh/S1HmK
 J0dg+4LjsEUzmdDLPgq/HOBdJWWx8WVyGcjqgaVr8MQfANp08JpjXwxqllqbv9fTjy
 TAV66fRXa6mSQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Francois Berder <fberder@outlook.fr>,
 Zixun LI <admin@hifiphile.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20260521 into master
Date: Thu, 21 May 2026 17:24:30 +0200
Message-ID: <877bowokep.fsf@kernel.org>
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

Here is a PR for master with some fixes for USB gadget.

Usb Gadget:
* f_acm: Fix memory leak in acm_add()
* atmel: Fix gadget support on bus reset

CI:
* https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/30195

Thanks,
Mattijs

The following changes since commit 36d4c653580824b16574560b21d4401614d8b68e:

  virtio: fix return value check (2026-05-12 12:38:49 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20260521

for you to fetch changes up to 7f34bb50a59804f6ebe02c1f62b7b29093eb103c:

  usb: gadget: atmel: do not disable endpoints in reset_all_endpoints() (2026-05-20 12:09:29 +0200)

----------------------------------------------------------------
u-boot-dfu-20260521

Usb Gadget:
* f_acm: Fix memory leak in acm_add()
* atmel: Fix gadget support on bus reset

----------------------------------------------------------------
Francois Berder (1):
      usb: gadget: f_acm: Fix memory leak in acm_add

Zixun LI (1):
      usb: gadget: atmel: do not disable endpoints in reset_all_endpoints()

 drivers/usb/gadget/atmel_usba_udc.c | 18 ------------------
 drivers/usb/gadget/f_acm.c          | 12 +++++++-----
 2 files changed, 7 insertions(+), 23 deletions(-)


