Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C11CCCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 13:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD9683D0C;
	Fri,  7 Nov 2025 14:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C5j3Vjcp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E55ED83D1A; Fri,  7 Nov 2025 14:26:02 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 338C783CB1
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 14:26:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 00786618FF;
 Fri,  7 Nov 2025 13:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548FEC4AF09;
 Fri,  7 Nov 2025 13:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762521958;
 bh=kOyEZigEAkmVSqkx3tf1M/5BIinqDTUP0CnT41j0n7w=;
 h=From:To:Cc:Subject:Date:From;
 b=C5j3VjcppKXIxe5OSscP/McL7bs9eFAM1xdAEfrNq/+A1ijooieoCTDYKC8g5pnPL
 myaonm0764nmtex0+2HBvg1mtvv4Eq1V1GXQEwWTWGsBryqBwWVovInXlo3nmVyqXF
 icgDwSuuPQdClgatNR4KKbd9elDv4UTHZcmIUYAIMQjJN7e35fZQrIASadKQREKWL3
 uwU+R3ih7OudH4yqjMbkcoP7DcDoqSSHe43gc5e9XuPYQ4+Xos/dNk+xcGNlXSgLPC
 nEDSArR701ffufzcfnM+n0FhYE7oyFLsBL+AUD8GBnlO7S1PWB3BH9a+g5Gk+dyDhv
 jXMT+kIcoLR6g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Nicolas Belin (TI.com)
 <nbelin@baylibre.com>, Hrushikesh Salunke <h-salunke@ti.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20251107 into master
Date: Fri, 07 Nov 2025 14:25:56 +0100
Message-ID: <87ikfm9dp7.fsf@kernel.org>
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

Here is a PR for master

Android:
* Add bootargs environment to kernel commandline

DFU:
* Support DFU over PCIe in SPL

CI:
* https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/28223

Regards,
Mattijs

The following changes since commit 1c250e444ad3b15315ee8b0fcb3fc3acc26449e2:

  Merge tag 'u-boot-imx-master-20251104' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2025-11-04 13:06:26 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20251107

for you to fetch changes up to 10da28729949f3e2160f98d82df45833d4c175cf:

  bootstd: android: add the bootargs env to the commandline (2025-11-06 10:19:31 +0100)

----------------------------------------------------------------
u-boot-dfu-20251107

Android:
* Add bootargs environment to kernel commandline

DFU:
* Support DFU over PCIe in SPL

----------------------------------------------------------------
Hrushikesh Salunke (1):
      spl: Add support for Device Firmware Upgrade (DFU) over PCIe

Nicolas Belin (TI.com) (1):
      bootstd: android: add the bootargs env to the commandline

 boot/bootmeth_android.c | 35 +++++++++++++++++++
 common/spl/Kconfig      | 62 +++++++++++++++++++++++++++++++++
 common/spl/spl_dfu.c    | 91 +++++++++++++++++++++++++++++++++++++++++++++++++
 common/spl/spl_ram.c    | 18 ++++++++++
 drivers/Makefile        |  1 +
 5 files changed, 207 insertions(+)
