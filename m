Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F07D5E364
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 10:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4B188DB6;
	Sat,  9 Nov 2024 11:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UXHMjGuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FDAE88E14; Sat,  9 Nov 2024 11:10:10 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC18C88D70
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 11:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731146999; x=1731751799; i=xypron.glpk@gmx.de;
 bh=neqNobIC0VlP2s2C5IunJrHd3bJ0sl+2D00vjTLR4nw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=UXHMjGuDOAnfHgohmWXLPsAdtQovxWpFm4/9Yb3jsB+X9gpfb6uWfGbdQumvYRVK
 CU754nOvY+Aka+EBzNJyDJ+RrXAjhV9ADXY06cEm6EvpupUX0yGH6dniBD7kBNGve
 x6nZlYKsWur2sr2ttIzM1NMdmUjTnb1Tc1JUQQbElGU3bUJg+2w+z0lKcWbmJU9s1
 JGyEuzCPlL9LbwVYXH68RAgJmbXi+PWI6yxExU0Cr/ib5ok7QL6dkjAtzHedtbsX8
 vy7+oe+o09Gh6H8BymTwjIjRbPEwaAMtUc3p/ckXEbuo4gYTrOraBfFHQ6luGY/FR
 dxOC0o6JPTXMPlM3mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.72]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9dsV-1tut6Z3Qhx-0126Je; Sat, 09
 Nov 2024 11:09:58 +0100
Message-ID: <efa929c9-b8a8-4264-8bd2-8e98bd61c5c6@gmx.de>
Date: Sat, 9 Nov 2024 11:09:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Moritz Fischer <moritzf@google.com>,
 mason1920@use.startmail.com
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2025-01-rc2-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f+BynrQaIvviO43sLJlw8XgeksIOjXi6bghl2JStvF8b5gV3PPt
 +Sk+6kNxkmoTqOvGh0g5dpG7jax/wGD6nQ4IVEuQRwv2fEmGz13jQIQBS4n7Ktko3jCFIOh
 0cDE3YtckGXulinUnnqMSuKs9PRoHbOJzhi2dNuBXXFrsmXm3E5pHb0RJd6sjY4k/9pL3AB
 t3d8QpAqPrcAERtTxyJgw==
UI-OutboundReport: notjunk:1;M01:P0:jIFeMxbVtHA=;mi0o67yQxKB+QfmZ37r2W4OrhOt
 Z4v1yzv4WtuOcgd31ik0xL1VruDlLHSIoyMBXu97EJ3gdsfxJUIngMd/NW+5Wi6vydj3d5J54
 9ODA/L74xPe8CQd/9zLdKSdg7PGljYLRDFtiIURL20jFmWgAq/ZrOipljSY9a/r+9B03gNykv
 AFp39SfYppHA6jZLcFTzWmQ56SrYhV8yYmKAEvNZ2p+4eLDs/Smcfqq64zCbvG1jN/WXqnIbN
 bfsybgF7Hc0PsYEXczUGjpGHBiuUlytlAuced3kzlwVl9XyeNDrdnXNhpx0IXTJPxS3872njP
 LMYwydxSTI/DfI+/pJvn9tbPdLBSfs38JBzA9sn0w7PDO1jmzXWgufhW5s1pVYlxnLizVaf+I
 Km/pchXtVQWHev8dlBzbhH3weSfTtnDrj4d41YbHZKZ1dm26jQ+xexiwRpcsVAKgXryQ1hF7+
 XWKzQMItx31ZtMoYjOwfEVj+r+aaDRQMl5y9nNfGE5xxMjJx7Fw7JOQrisp/BNWO8CDAhDfBv
 fhvCH6AhXq2uQCBD+XLGReML+TYmOji+9Ljb4hOeXQ/8PaDuVQCZVG1qVrkGraFbH5Nsq5QBc
 1BA6dD1XjpWjYVOYdF1YHohlhKCV9CZjyFd32zhw4nk7/SHR31U5KI2Teb+B/yzJiKHyb5OQ9
 8wYQrCHErZqlN1QUN4HmI8Coa2vVx8xA8W12ui9qKVypOwTaZUcG6fwqYPGZ1J0S47ME26bKa
 oJbY+OanRQnUBCDmgmauxQMRDwvn9UibKt5CYN2cEnwVMHf2EJdQiEpspxLLRwRCXPgC3/NXL
 MD/ryJ16oe7Iwo3ki3D+yVyg==
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

The following changes since commit a7a96a37cbd875994bc8d25adb0536bf00e4a30=
e:

   Merge https://source.denx.de/u-boot/custodians/u-boot-riscv
(2024-11-06 10:44:33 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git efi-2025-01-rc2=
-2

for you to fetch changes up to 70b78d52937b5f18afbbc4257bd3b89b0e75a186:

   test: efi: boot: Add a test for the efi bootmeth (2024-11-09 10:01:47
+0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23260

=2D---------------------------------------------------------------
Pull request efi-2025-01-rc2-2

Documentation:

* correct title and author of rst2pdf generated pdf
* describe CONFIG_DEBUG_SBI_CONSOLE
* remove vile language

UEFI

* correct printf codes in mkeficapsule
* add an EFI test app
* move default filename to a function
* move get_efi_pxe_arch() to efi_helper
* allow reporting the host defaults in efidebug
* drop sandbox PXE architecture

Other:

* do not reserve extra 16 KiB of stack in lmb
* disable the sandbox virtio blk device
* provide -N command line flag to control EFI default boot file name
   on the sandbox
* provide a unit test for the efi bootmeth

=2D---------------------------------------------------------------
Heinrich Schuchardt (3):
       tools: mkeficapsule: use %zd to print ssize_t.
       doc: conf.py: correct title and author of generated pdf
       doc: qemu-riscv: describe CONFIG_DEBUG_SBI_CONSOLE

Moritz Fischer (1):
       efi_loader: Change efi_dp_from_mem() to use size

Simon Glass (11):
       lmb: Drop extra 16KB of stack space
       efi_loader: Add a test app
       sandbox: Add a -N flag to control on-host behaviour
       efi: Move default filename to a function
       efi_loader: Move get_efi_pxe_arch() to efi_helper
       efi_loader: Allow reporting the host defaults
       sandbox: Report host default-filename in native mode
       efi_loader: Drop sandbox PXE architecture
       sandbox: virtio: Disable the sandbox virtio blk device
       test: efi: boot: Set up an image suitable for EFI testing
       test: efi: boot: Add a test for the efi bootmeth

mason1920 (1):
       doc: remove vile language

  arch/Kconfig                        |   3 +-
  arch/sandbox/cpu/start.c            |  10 +++++
  arch/sandbox/dts/test.dts           |   2 +-
  arch/sandbox/include/asm/state.h    |   1 +
  boot/bootmeth_efi.c                 |  29 ++------------
  cmd/efidebug.c                      |  25 ++++++++++++
  doc/board/emulation/qemu-riscv.rst  |   5 +++
  doc/conf.py                         |   8 +---
  doc/develop/devicetree/control.rst  |   2 +-
  include/efi.h                       |  34 ++++++++++++++++
  include/efi_default_filename.h      |  56 --------------------------
  include/efi_loader.h                |   2 +-
  lib/efi_loader/Kconfig              |  10 +++++
  lib/efi_loader/Makefile             |   1 +
  lib/efi_loader/efi_bootbin.c        |   1 -
  lib/efi_loader/efi_bootmgr.c        |  10 +++--
  lib/efi_loader/efi_device_path.c    |   7 ++--
  lib/efi_loader/efi_helper.c         |  71
+++++++++++++++++++++++++++++++++
  lib/efi_loader/testapp.c            |  56 ++++++++++++++++++++++++++
  lib/lmb.c                           |   2 -
  test/boot/bootdev.c                 |  18 ++++++++-
  test/boot/bootflow.c                |  76
++++++++++++++++++++++++++++++++++--
  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 4924 bytes
  test/py/tests/test_ut.py            |  53 ++++++++++++++++++++++---
  tools/mkeficapsule.c                |   4 +-
  25 files changed, 372 insertions(+), 114 deletions(-)
  delete mode 100644 include/efi_default_filename.h
  create mode 100644 lib/efi_loader/testapp.c
  create mode 100644 test/py/tests/bootstd/flash1.img.xz
