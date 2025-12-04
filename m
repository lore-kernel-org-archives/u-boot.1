Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEA2D1D878
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 07:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58BFF83D3C;
	Thu,  4 Dec 2025 08:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gEzR/Jea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C4B83D77; Thu,  4 Dec 2025 08:45:51 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 225BA83B87
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 08:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EBCDA60185;
 Thu,  4 Dec 2025 07:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56246C19421;
 Thu,  4 Dec 2025 07:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764834347;
 bh=UCdslYJpMES25yiaJO82DDzXDEDjPX4BCNIKgSy9Zs4=;
 h=From:To:Cc:Subject:Date:From;
 b=gEzR/Jeaacav4HIMZIiRDmlJozslzqVg293omUlaAp6SxDgm3+y1RtF2TvF+HpXYF
 GiKC1UIXYKQAk4VDQ+NioVRjl5JCUKVFY9mKFFQENbEhhdD3785/GMTu+XT4T7fijQ
 mzSQH8iHPDjoB8Qgfsa6ZnatajcZkMMDYwhyBVRQ6vP/Q2+0fpj9ddHwY34dRQqcgi
 9VRH/LsiJT8mkti1hVB24nUCUyd+RjxiteEOtKUQDA9iwg5LId/TrRjgnu1tmbVP4d
 gDZhTM4Drchp1AVkbthzCR5By6FZ0wdAXa61A+qd5yPunOtwrynZNY9I7DYatBtQ1l
 L+i3I5bbWOFRg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Dmitrii Merkurev
 <dimorinny@google.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20251203 into next
Date: Thu, 04 Dec 2025 08:45:44 +0100
Message-ID: <87tsy6sn9z.fsf@kernel.org>
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

Here is a PR for next

Fastboot:
* Add generic flashing support using BLK

CI:
* https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/28617

Regards,
Mattijs

The following changes since commit 6e7d2399c8139f8e2d037e446236b8d8bdbca604:

  Merge tag 'efi-next-2025-11-25' of https://source.denx.de/u-boot/custodians/u-boot-efi into next (2025-11-22 10:34:03 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20251203

for you to fetch changes up to 769c6cbbb53074025c3af53d8df5571ae18d74c3:

  fastboot: integrate block flashing back-end (2025-11-24 10:51:17 +0100)

----------------------------------------------------------------
u-boot-dfu-next-20251203

Fastboot:
- Add generic flashing support using BLK

----------------------------------------------------------------
Dmitrii Merkurev (3):
      fastboot: blk: introduce fastboot block flashing support
      fastboot: blk: switch emmc to use the block helpers
      fastboot: integrate block flashing back-end

 drivers/fastboot/Kconfig      |  32 ++++-
 drivers/fastboot/Makefile     |   4 +-
 drivers/fastboot/fb_block.c   | 322 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_command.c |   8 ++
 drivers/fastboot/fb_common.c  |  22 ++-
 drivers/fastboot/fb_getvar.c  |   8 +-
 drivers/fastboot/fb_mmc.c     | 210 ++-------------------------
 include/fb_block.h            | 105 ++++++++++++++
 8 files changed, 505 insertions(+), 206 deletions(-)
 create mode 100644 drivers/fastboot/fb_block.c
 create mode 100644 include/fb_block.h

