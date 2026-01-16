Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4304C982CA
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 15:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D4DF83015;
	Fri, 16 Jan 2026 16:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qdk4evpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69DA08309A; Fri, 16 Jan 2026 16:12:41 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C6798003E
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 16:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B0B116016F;
 Fri, 16 Jan 2026 15:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C1CC116C6;
 Fri, 16 Jan 2026 15:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768576357;
 bh=SAdgrM9pbiuu7xDTncj3143iQtCfcTFMa+9X/9ePl0s=;
 h=From:To:Cc:Subject:Date:From;
 b=Qdk4evpl6z5485PlRF6FPsqh7r6FRNLj/9lXpr4lZJKIf2cl/q4PzfamRIUxz6JR3
 kE7aDABw0MTu0bAUYddwn8hoLW1MP723XjcVvFHPz2Jky0Oi/iFSsn8sljIt8gmLi7
 fhKbvzJgqRAIDfm/tFnRba6oDabwFRkWcpUNXFTFiqDdPUUokQjdfQM3sRtpTwQDbX
 BUuz7TAwJLjEhUXmauE4R0dkXXyonv0pZfMXeRqMk7E9qBu2oqY6SwapYVhBRyo3FY
 RgkD1mtZSEWKJT+l7aQavo/XRJHY65ltmBtQj0Y52b+ZkbMBibmDXZAd3eJdplyrJs
 D5EW52q3iCS0w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Francois Berder <fberder@outlook.fr>,
 Guillaume La Roque (TI.com) <glaroque@baylibre.com>, Sean Anderson
 <sean.anderson@linux.dev>, Petr =?utf-8?Q?Bene=C5=A1?=
 <petr.benes@ysoft.com>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [GIT PULL] Please pull u-boot-dfu-20260116 into master
Date: Fri, 16 Jan 2026 16:12:33 +0100
Message-ID: <87sec5d21q.fsf@kernel.org>
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

Here is a PR for master

Android:
* Fix missing dependency for BOOTMETH_ANDROID
* Add bootconfig support
* Add 'get ramdisk' command to abootimg

DFU:
* Improve error handling in dfu_fill_entity()

USB Gadget:
* ci_udc: Ensure ci_ep->desc is valid before using it
* ci_udc: Add additional debug prints

CI:
* https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/29018

Regards,
Mattijs

The following changes since commit c05dba22f1f2b0b2655ee3971644acf1936cd07a:

  Merge branch 'master' of git://source.denx.de/u-boot-usb (2026-01-08 10:2=
8:15 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-2=
0260116

for you to fetch changes up to 0efe1d9502a022d5d5c39c73340dd0b7b3f9cbe5:

  test: abootimg: Add test for bootconfig handling (2026-01-16 14:07:58 +01=
00)

----------------------------------------------------------------
u-boot-dfu-20260116

Android:
* Fix missing dependency for BOOTMETH_ANDROID
* Add bootconfig support
* Add 'get ramdisk' command to abootimg

DFU:
* Improve error handling in dfu_fill_entity()

USB Gadget:
* ci_udc: Ensure ci_ep->desc is valid before using it
* ci_udc: Add additional debug prints

----------------------------------------------------------------
Francois Berder (1):
      bootstd: android: Add missing free in android_read_bootflow

Guillaume La Roque (TI.com) (4):
      boot: android: Add sandbox memory mapping support
      boot: android: Add bootconfig support
      cmd: abootimg: Add 'get ramdisk' command
      test: abootimg: Add test for bootconfig handling

Mattijs Korpershoek (TI.com) (1):
      boot: android: import addBootConfigParameters() from AOSP

Petr Bene=C5=A1 (2):
      usb: ci_udc: Check ci_ep->desc before use
      usb: ci_udc: cosmetics: EP and requests debug info

Quentin Schulz (1):
      boot: fix missing dependency for BOOTMETH_ANDROID

Sean Anderson (1):
      dfu: Report error codes

 boot/Kconfig                                |   1 +
 boot/bootmeth_android.c                     |   4 +-
 boot/image-android.c                        | 272 ++++++++++++++++++++++++=
----
 cmd/abootimg.c                              |  55 ++++--
 drivers/dfu/dfu.c                           |  52 +++---
 drivers/usb/gadget/ci_udc.c                 |  57 +++++-
 test/py/tests/test_android/test_abootimg.py |  89 +++++++--
 7 files changed, 436 insertions(+), 94 deletions(-)

