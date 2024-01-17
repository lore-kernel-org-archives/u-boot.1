Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCB4C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 10:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7FAB8796E;
	Wed, 17 Jan 2024 11:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ShxhnRa/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A9587B47; Wed, 17 Jan 2024 11:57:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4797B878A5
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 11:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705489059; x=1706093859; i=xypron.glpk@gmx.de;
 bh=2JdPM/EkyEeUuiJ7+xyFAhg2WOfwVlyYnO+c3evXV+M=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=ShxhnRa/m9SlS/h0mWFVJphuALG96HnfkBlZ5xukoVWM7Pw8MNai1bV62Bw4XmDX
 JvEy+YBiYv8OUexUXpjb4Au3fGWOs4COGhDG2CFEfcl2fanCwShjtoJ+zPq6Q/PsK
 fGTTCy/5CIS9tuuXw5iuoNxmcxBFSTydAvOsuo2F7/8SR8MMqvUY2p64Fgf6sL3xt
 LSXNW9afhDovqyMCLr84/Wq1o3LqIqIffNZcfXt7zGL6xT70PMyeUCVmCN3jJKjQq
 +0HpaOQDAp5WYFoVJ4dFjQeitk5BbNj2O09WeNKVYAzjZ/42nvHRlgKmfyFXvZJxc
 OlnmTljov/59sObrqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QWA-1rURKl2XRI-004PYh; Wed, 17
 Jan 2024 11:57:39 +0100
Message-ID: <0f47c120-3c4a-44a9-9aa3-0a99fdb5696d@gmx.de>
Date: Wed, 17 Jan 2024 11:57:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-04-rc1-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O4qYSUfH9nnu9qkegUcR8iuJAt6Xo5POekUYV/7NMlt7WDXMSLF
 uEunwm8LI71F4jbtdBy8dL7wVZE3rlz63PiedgXkttICjfu8om5xrW7VaWsQGBA7DywS1M0
 wiHZQ/TVEZnh0duiNLkEr81bZEb7p0w42f5HKem51Qw/tu+pDkSF/Ch83ePuK7BiqIUKCCR
 XYvqg6DxF+wcji2Espytw==
UI-OutboundReport: notjunk:1;M01:P0:tjXY18BIrz0=;VcbvS/q71aoE7zf+0n1izl5qA/V
 wgHTG2SjuObN8T/8Qd6xrJ0Fjm8JIpbdG/DhOLWn3ejyW8lhcycGHlqjUgv/fcyI6lK/hjyPW
 7r/KeHu6LhUgaJYQHiAXg3P9zU6Qil1sGM/PJOKg2pBvKTGtBh+XSOnVve9LGkcfmae+l0Mf4
 GxffaqJTFhWuWrWNecUWszMWg+h+2rduD3hbEdbH2W5b+sROB2seqIX8DrjU+35cakw5cDFLh
 B7dhC4vKIyi+WgtcKn40Edprab9C13JwVB4mq9lnlpd0wMNq3XoWNxjJ4mwXKRQHoWzszBK93
 KIa4+ho9LBe/yiFtCvdg38KYLayIwkdj2O7uqLCR0CTWHVPDa0mrPTeHyiEzH/skRRwSgG7tO
 yDjJjQzZmY/scZLQhcI28dN9e9SqUHnnz1lj6YyTdLh/HsG3VKBcKrsC0tqhD0tjs1Vqk5+g2
 ams2BW8rG1qGqkTSPQczsk5LPj2fL39z8UX4DMyrg94GKx1H4n9wZF2ir/EGuUk9SRCyeucSc
 0/HnUeqd+2sOmVErKDezZrb35T2VOqIS6ACCXGSnlbIsQ8Yseigovp2q0vRslN7lP0p7582i6
 vtT06+BkIWivotnrMXLy4hbaU38OFu6ehbsJCqjVlgip6Lsy86/3JbTfeYlS4nxJTRXdfhkVk
 nFOdVJL7YxLyr0lQHjhrL8KEVuPrfgeVDM/JuOIZQev+9LFq1h4Lt7SMvhb/v+773Jeoe0+b5
 0g04cqHzYZG5ifJXDF9ahT0Y33NaX6HxSBGw6QwD8wiIOLcFp5fDEvAXHZS9NhtklkCgazu2O
 l8xHOxLx8bRR7xJa9zvkVjuoPwDBuIBQsvnATswoLF+8rVVp46Zxi9QGv9zheMj92sv7Y+20f
 bb2umaQz51ceeMAVQsatWZN6JUwGkkvBNMnt2j69ASYDIqCSwa9XtOvAUv3CjWoYhCe0uZ1TL
 xnIshIsupIT3XMo5LfFqLV64g3A=
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

Dear Tom,

The following changes since commit 043ca8c8a9b181cf6f17441e9b89b5ee3320630=
9:

   Merge tag 'qcom-2024.04-rc1' of
https://gitlab.denx.de/u-boot/custodians/u-boot-snapdragon (2024-01-16
09:51:16 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-04-rc1-2

for you to fetch changes up to 21c856797e2735fbd4e8b900803e6c42eae8d434:

   riscv: qemu: imply GOLDFISH_RTC (2024-01-17 09:03:43 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19345

=2D---------------------------------------------------------------
Documentation:

* add generated index to table of contents
* create index entries for commands
* update Python packages used to build the documentation
* fix typos in dfu documentation

UEFI:

* split unrelated code from efi_bootmgr.c
* rename CONFIG_BOOTEFI_BOOTMGR to CONFIG_EFI_BOOTMGR
* net: tftp: remove explicit EFI configuration dependency
* fs: remove explicit EFI configuration dependency

Other:

* Add Goldfish RTC driver and make it available on RISC-V QEMU

=2D---------------------------------------------------------------
AKASHI Takahiro (4):
       efi_loader: split unrelated code from efi_bootmgr.c
       efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
       net: tftp: remove explicit efi configuration dependency
       fs: remove explicit efi configuration dependency

Heinrich Schuchardt (8):
       doc: add generated index to table of contents
       doc: create index entries for commands
       doc: add sphinx_rtd_theme extension
       doc: update theme_overrides.css
       doc: import Sphinx theme.css and pygments.css
       doc: update requirements.txt
       rtc: driver for Goldfish RTC
       riscv: qemu: imply GOLDFISH_RTC

Mattijs Korpershoek (1):
       doc: dfu: fix a handful of typos

Oliver Faso (1):
       docs/sphinx: Explicitly convert Sphinx paths to str

  board/emulation/qemu-riscv/Kconfig    |   2 +
  boot/Kconfig                          |   4 +-
  boot/Makefile                         |   2 +-
  cmd/Kconfig                           |  10 +-
  cmd/efidebug.c                        |   4 +-
  doc/conf.py                           |   2 +-
  doc/genindex.rst                      |   4 +
  doc/index.rst                         |   5 +-
  doc/sphinx-static/theme_overrides.css |  47 +++-
  doc/sphinx/kerneldoc.py               |   2 +-
  doc/sphinx/kfigure.py                 |   2 +-
  doc/sphinx/requirements.txt           |  43 ++-
  doc/usage/cmd/acpi.rst                |   3 +
  doc/usage/cmd/addrmap.rst             |   3 +
  doc/usage/cmd/armffa.rst              |   3 +
  doc/usage/cmd/askenv.rst              |   3 +
  doc/usage/cmd/base.rst                |   3 +
  doc/usage/cmd/bdinfo.rst              |   3 +
  doc/usage/cmd/bind.rst                |   3 +
  doc/usage/cmd/blkcache.rst            |   3 +
  doc/usage/cmd/bootd.rst               |   3 +
  doc/usage/cmd/bootdev.rst             |   3 +
  doc/usage/cmd/bootefi.rst             |   3 +
  doc/usage/cmd/bootflow.rst            |   3 +
  doc/usage/cmd/booti.rst               |   3 +
  doc/usage/cmd/bootm.rst               |   3 +
  doc/usage/cmd/bootmenu.rst            |   3 +
  doc/usage/cmd/bootmeth.rst            |   3 +
  doc/usage/cmd/bootz.rst               |   3 +
  doc/usage/cmd/button.rst              |   3 +
  doc/usage/cmd/cat.rst                 |   3 +
  doc/usage/cmd/cedit.rst               |   3 +
  doc/usage/cmd/cli.rst                 |   3 +
  doc/usage/cmd/cls.rst                 |   3 +
  doc/usage/cmd/cmp.rst                 |   3 +
  doc/usage/cmd/coninfo.rst             |   3 +
  doc/usage/cmd/conitrace.rst           |   3 +
  doc/usage/cmd/cp.rst                  |   3 +
  doc/usage/cmd/cyclic.rst              |   3 +
  doc/usage/cmd/dm.rst                  |   3 +
  doc/usage/cmd/ebtupdate.rst           |   3 +
  doc/usage/cmd/echo.rst                |   3 +
  doc/usage/cmd/efi.rst                 |   3 +
  doc/usage/cmd/eficonfig.rst           |   3 +
  doc/usage/cmd/env.rst                 |   3 +
  doc/usage/cmd/event.rst               |   3 +
  doc/usage/cmd/exception.rst           |   3 +
  doc/usage/cmd/exit.rst                |   3 +
  doc/usage/cmd/extension.rst           |   3 +
  doc/usage/cmd/false.rst               |   3 +
  doc/usage/cmd/fatinfo.rst             |   3 +
  doc/usage/cmd/fatload.rst             |   3 +
  doc/usage/cmd/fdt.rst                 |   3 +
  doc/usage/cmd/font.rst                |   3 +
  doc/usage/cmd/for.rst                 |   3 +
  doc/usage/cmd/fwu_mdata.rst           |   3 +
  doc/usage/cmd/gpio.rst                |   3 +
  doc/usage/cmd/gpt.rst                 |   3 +
  doc/usage/cmd/history.rst             |   3 +
  doc/usage/cmd/host.rst                |   3 +
  doc/usage/cmd/imxtract.rst            |   3 +
  doc/usage/cmd/load.rst                |   3 +
  doc/usage/cmd/loadb.rst               |   3 +
  doc/usage/cmd/loadm.rst               |   3 +
  doc/usage/cmd/loads.rst               |   3 +
  doc/usage/cmd/loadx.rst               |   3 +
  doc/usage/cmd/loady.rst               |   3 +
  doc/usage/cmd/mbr.rst                 |   3 +
  doc/usage/cmd/md.rst                  |   3 +
  doc/usage/cmd/mmc.rst                 |   3 +
  doc/usage/cmd/mtest.rst               |   3 +
  doc/usage/cmd/mtrr.rst                |   3 +
  doc/usage/cmd/panic.rst               |   3 +
  doc/usage/cmd/part.rst                |   3 +
  doc/usage/cmd/pause.rst               |   3 +
  doc/usage/cmd/pinmux.rst              |   3 +
  doc/usage/cmd/printenv.rst            |   3 +
  doc/usage/cmd/pstore.rst              |   3 +
  doc/usage/cmd/qfw.rst                 |   3 +
  doc/usage/cmd/reset.rst               |   3 +
  doc/usage/cmd/rng.rst                 |   3 +
  doc/usage/cmd/saves.rst               |   3 +
  doc/usage/cmd/sbi.rst                 |   3 +
  doc/usage/cmd/scmi.rst                |   3 +
  doc/usage/cmd/scp03.rst               |   3 +
  doc/usage/cmd/seama.rst               |   3 +
  doc/usage/cmd/setexpr.rst             |   3 +
  doc/usage/cmd/sf.rst                  |   3 +
  doc/usage/cmd/size.rst                |   3 +
  doc/usage/cmd/sleep.rst               |   3 +
  doc/usage/cmd/sm.rst                  |   3 +
  doc/usage/cmd/sound.rst               |   3 +
  doc/usage/cmd/source.rst              |   3 +
  doc/usage/cmd/temperature.rst         |   3 +
  doc/usage/cmd/tftpput.rst             |   3 +
  doc/usage/cmd/trace.rst               |   3 +
  doc/usage/cmd/true.rst                |   3 +
  doc/usage/cmd/ums.rst                 |   3 +
  doc/usage/cmd/unbind.rst              |   3 +
  doc/usage/cmd/ut.rst                  |   3 +
  doc/usage/cmd/wdt.rst                 |   3 +
  doc/usage/cmd/wget.rst                |   3 +
  doc/usage/cmd/write.rst               |   3 +
  doc/usage/cmd/xxd.rst                 |   3 +
  doc/usage/dfu.rst                     |  60 ++---
  drivers/rtc/Kconfig                   |   7 +
  drivers/rtc/Makefile                  |   1 +
  drivers/rtc/goldfish_rtc.c            | 105 ++++++++
  fs/fs.c                               |   7 +-
  include/efi_loader.h                  |  28 +-
  lib/efi_loader/Kconfig                |  11 +-
  lib/efi_loader/Makefile               |   3 +-
  lib/efi_loader/efi_bootbin.c          | 211 +++++++++++++++
  lib/efi_loader/efi_bootmgr.c          | 488
=2D---------------------------------
  lib/efi_loader/efi_device_path.c      |   3 +-
  lib/efi_loader/efi_helper.c           | 286 ++++++++++++++++++++
  net/tftp.c                            |  10 +-
  test/boot/bootflow.c                  |   2 +-
  118 files changed, 1042 insertions(+), 583 deletions(-)
  create mode 100644 doc/genindex.rst
  create mode 100644 drivers/rtc/goldfish_rtc.c
  create mode 100644 lib/efi_loader/efi_bootbin.c
