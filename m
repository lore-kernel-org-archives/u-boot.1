Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F58BC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 08:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B46AA84A51;
	Tue, 30 Jun 2026 10:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fCQvodnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF06984A60; Tue, 30 Jun 2026 10:06:58 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0CE584A35
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 79EF3600C3;
 Tue, 30 Jun 2026 08:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875931F000E9;
 Tue, 30 Jun 2026 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782806815;
 bh=ON0SFUqLa/K+kGKasyqdOpciFgi+LOmShyOwhLoha2Q=;
 h=From:To:Cc:Subject:Date;
 b=fCQvodnZaJzGBtaIPn1zTUzSPDYQbMndx72Wasq+b+qCm+veg4Z3pg5w8LJECr/Hb
 6CNYm9CcnQg9KO8hiNejeB7LYGDl4Ms/w2F9WqEgoHa8bUS94eX2tfjIZlNhAJMoVA
 YqqHwVFQJkcjKTBoa41NIwfFYq/2RBn7BrZVR3Y5DAAKiA5BJH2II7U7CxS0bZUDTD
 RzCO20AT0GURu3UfJLug0dFILeXydp6vBMdvOqd6rraZ5cPBuAJD8CQig54hPQCNEm
 D21ZDu5X4VBkWbuG9YspFBKxdziVBaA6GbUSASU6sy16RI5Yx3WgV6Rn4wXVXLrcYi
 H+kp4c+0lOYsQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sam Day <me@samcday.com>, Ye Li
 <ye.li@nxp.com>, Casey Connolly <casey.connolly@linaro.org>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20260629 into next
Date: Tue, 30 Jun 2026 10:06:52 +0200
Message-ID: <878q7w8nab.fsf@kernel.org>
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

Here is a PR for next with the following:

Fastboot:
* Add support for CMD_FASTBOOT_ABORT_KEYED
* Enable CMD_FASTBOOT_ABORT_KEYED for qualcomm phones

Usb Gadget:
* f_mass_storage: Disable eps during disconnect
* f_sdp: Fix spl load failure error handling

CI:
* https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/30562

Thanks,
Mattijs

The following changes since commit 63f6cc8ba618396cb9c0161bb5c6d217604ae1d0:

  Merge patch series "Kconfig restyle part 2" (2026-06-25 15:01:03 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20260629

for you to fetch changes up to 865f62483b86b7936c2136d91bbce252b6406330:

  board: qualcomm: phone: enable CMD_FASTBOOT_ABORT_KEYED (2026-06-26 11:12:22 +0200)

----------------------------------------------------------------
u-boot-dfu-next-20260629

Fastboot:
* Add support for CMD_FASTBOOT_ABORT_KEYED
* Enable CMD_FASTBOOT_ABORT_KEYED for qualcomm phones

Usb Gadget:
* f_mass_storage: Disable eps during disconnect
* f_sdp: Fix spl load failure error handling

----------------------------------------------------------------
Mattijs Korpershoek (1):
      usb: gadget: f_mass_storage: Disable eps during disconnect

Sam Day (2):
      cmd: fastboot: Add keyed abort option
      board: qualcomm: phone: enable CMD_FASTBOOT_ABORT_KEYED

Ye Li (1):
      usb: f_sdp: handle the spl load function failure

 board/qualcomm/qcom-phone.config    |  1 +
 board/qualcomm/qcom-phone.env       |  2 +-
 cmd/Kconfig                         |  7 +++++++
 cmd/fastboot.c                      |  9 ++++++++-
 doc/android/fastboot.rst            |  4 ++++
 drivers/usb/gadget/f_mass_storage.c | 11 +++++++++++
 drivers/usb/gadget/f_sdp.c          | 16 +++++++++++++---
 7 files changed, 45 insertions(+), 5 deletions(-)

