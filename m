Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF90C369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F7EB8056A;
	Thu, 24 Apr 2025 14:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eWwrZLps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E95806FC; Thu, 24 Apr 2025 14:37:43 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C46DA803CC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4E7545C5BE7;
 Thu, 24 Apr 2025 12:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A114EC4CEE3;
 Thu, 24 Apr 2025 12:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745498259;
 bh=wnx7097z6wNp36eXYFT4NsEeJcoYJ5L+B+JOPI34gm4=;
 h=From:To:Cc:Subject:Date:From;
 b=eWwrZLps1bdqLeh50iBl9MB0j2Ytu2X9b0IlF3eH+zndbp7b47wJRIfSeFe8FcxJA
 T8SbFwOFVxVqj3aB80P9EerkMvidOcypiyyqzDty8C2GFK+jsGz1t0hk7HcBe4hImw
 xz4hBlkw9anKNZgiHeqZpD56JNu6jm2fQabvhD+w0ilXMVoY62MYz0k8e411uZUpGD
 1E8QuxuhX8WKMFMekGgvLQY+DmguCfHTUacYm8mGIAFd1rKDomPmmySMuN0b8HQkop
 wi/IYeI4o1t4O0INVzZ+XrPoNUlVYcaWc7n5HeA62/h50XHVZ7I204gVo4hRSpoHAa
 KgN5ryP+nwkSQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Vincent =?utf-8?Q?Stehl=C3=A9?=
 <vincent.stehle@arm.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20250424 into master
Date: Thu, 24 Apr 2025 14:37:35 +0200
Message-ID: <87jz79enw0.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Please find the following fixes/developments for master:

Usb gadget:
- Fix ACM gadget release
- Allow ACM gadget restart after releasing it
- Add 'enabled' flag to usb_ep structure

DFU:
- Fix alt buffer clearing for DeveloperBox board

CI Job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/25923

Thanks,
Mattijs

The following changes since commit 4446bc331c65d3efb8a9321d6368c61edb56479b:

  mips: mt7688: gardena-smart-gateway: Increase CONFIG_SYS_BOOTM_LEN (2025-=
04-22 15:16:11 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-2=
0250424

for you to fetch changes up to 39a719dce59607d6abcac17cc2683aa9f2162539:

  fwu: developerbox: fix dfu alt buffer clearing (2025-04-23 09:52:52 +0200)

----------------------------------------------------------------
u-boot-dfu-20250425

Usb gadget:
- Fix ACM gadget release
- Allow ACM gadget restart after releasing it
- Add 'enabled' flag to usb_ep structure

DFU:
- Fix alt buffer clearing for DeveloperBox board

----------------------------------------------------------------
Stephan Gerhold (3):
      usb: gadget: f_acm: Claim requested USB endpoints
      usb: gadget: f_acm: Allow restarting ACM console after stopping it
      usb: gadget: introduce 'enabled' flag in struct usb_ep

Vincent Stehl=C3=A9 (1):
      fwu: developerbox: fix dfu alt buffer clearing

 board/socionext/developerbox/fwu_plat.c |  2 +-
 drivers/usb/gadget/f_acm.c              |  4 ++++
 include/linux/usb/gadget.h              | 27 +++++++++++++++++++++++++--
 3 files changed, 30 insertions(+), 3 deletions(-)

