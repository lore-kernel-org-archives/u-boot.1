Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E90AC71155
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 14:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9421281760;
	Mon, 16 Jun 2025 16:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ipyQZr+i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D89781E18; Mon, 16 Jun 2025 16:32:38 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AE9D80E9A
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 16:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EAC7061129;
 Mon, 16 Jun 2025 14:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45718C4CEF0;
 Mon, 16 Jun 2025 14:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750084354;
 bh=A0kG63ZLeCKClv7DxS5fMz3mbrRV7Naz5S605tURIWE=;
 h=From:To:Cc:Subject:Date:From;
 b=ipyQZr+ib9g4GU9jXaLYPf5UESvRX5cxXeP6MNTbM7V5SJ01FyPr0wMdcpjuCbT/i
 T3G1iDsm5ysdrdT2LjPg5ed8VXXJkMnWbrbo+u+SbFvtw4LYQ4yMjCrQeDvXMVY8ds
 gpi9lAblpFVc8egPtbD9i8vwo4TDY53ZnYotYD2Zau/yIemn40VLwK4WbYPhJfi7s0
 frcKYJD4NtL7pgoERWUWZTlAGL5X5ERvDEspLEplIsIEYDETNsxVonmLNlyRyk2qae
 cc+uJ/R/v96+MldiyscYX3vMQNkyBwapeg9zot33RYDjLHEN3MqVUGBRUbZnPJP9ae
 U7umqlqTpZC6A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Zixun LI <admin@hifiphile.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20250616 into next
Date: Mon, 16 Jun 2025 16:32:32 +0200
Message-ID: <87wm9bg3jz.fsf@kernel.org>
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

Please find the following fixes/developments for next:

Usb gadget:
- Atmel: Improve gadget disconnect stability by power cycling

CI Job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26704

Thanks,
Mattijs

The following changes since commit 9de873b4c3098c0662d4adaeb1cc31be4e6d2688:

  Merge patch series "linux/bitfield.h: sync <linux/bitfield.h> from Linux 6.15 + winbond" (2025-06-14 09:13:39 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20250616

for you to fetch changes up to ca036308a513759e3e4cbe9f8191861c3232c611:

  usb: gadget: atmel: reliably generate disconnect by disabling controller (2025-06-16 11:56:19 +0200)

----------------------------------------------------------------
u-boot-dfu-next-20250616

Usb gadget:
- Atmel: Improve gadget disconnect stability by power cycling

----------------------------------------------------------------
Zixun LI (1):
      usb: gadget: atmel: reliably generate disconnect by disabling controller

 drivers/usb/gadget/atmel_usba_udc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)
