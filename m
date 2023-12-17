Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1493C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 13:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E892877AC;
	Sun, 17 Dec 2023 14:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IThS0lFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60052877B3; Sun, 17 Dec 2023 14:47:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21288877AA
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 14:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702820861; x=1703425661; i=xypron.glpk@gmx.de;
 bh=iHBdAnTjEnIWn8KukBZIEdKTjW0wmnLJRBZsHdfZ1dQ=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=IThS0lFyNch6DruDdsZ1NZOwc/nbTeLaqOzPZPsCdcthNbhIu9byYAZFtyoxFFq6
 5xYQs858yvEwfoiBOFqkiE2EggWD4FEyzsBLYZYo0mWHHerL3eaEz/nSiBA5jmvex
 p4q4xx0vVLxHH6sDtFi7TfmHdexFepKfaDlnnzMDBc5uQ0JBuhu9h2liE4arLvCl1
 4ywx/8TJm/hU+htGbmE6w7z/7QvldrZs+dKke4KXoJbfmQwq1cV4b26ae/CCHGGgh
 Pm1YmsJXRpHPFBoIFcwoo0SL94WJXtPCynvH0s0Gowt0PlKeFDTMVuZruOZ7eOTH0
 Q5AX1uMQOrYZJykDmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0G1n-1rQSks0zvL-00xM8K; Sun, 17
 Dec 2023 14:47:41 +0100
Message-ID: <2836e8ee-2a9d-4d8f-848f-ce77ac8bf080@gmx.de>
Date: Sun, 17 Dec 2023 14:47:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Sean Anderson <seanga2@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [NEXT] Pull request for efi-next-20231217
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cBZDUq+Wr9Zz4dEaa79G4s4oho4SS2e6iNQ+A7/OgQyHNlJxBez
 jRY4kTYosO5XLLvJNiAXiKhRo5NAFrVX7bG/OK9wYVsDBdp0kwTrOOC5neqJN9ASE6gEQwm
 r3OjqEKyyaXp3P892u7oksu0l5NdtfpRip21bQ1wsNF+TpgE0oLYmrz7DIhfgbyYNqCWhLy
 am43Pa2KZAXUl15Kkcq/w==
UI-OutboundReport: notjunk:1;M01:P0:rm3lBqyOwc4=;teZNcRzhe3SXnc+zBqjAIiH4p1Z
 t1wStjlHiR60t4ByxQeyN/XbC0e+aCUdbIMztobTS1Fr2yAmEKiulF17uLaHvs8BSNkoC1FDK
 YJQLYoKb1tO27uw72MzzgWd8X8H5yrh2Z9d29Blb9sn+xUtG6jlCfuYF3KpEhcTFZTm1GKoJO
 +r1jjGMsTtp2ZrJ9UPvzUQUccfjAP//cp4M3Exb3BLj9d5b6CAJ7B+hwWe4/+ZtqmnhmVgDME
 5RI2CQPNngFV8h5RKRcSP+IR7K45JQBbsuwdGE/PZpJ0butZCCsRVDCQ3Lfes4/PLzXm2lTZU
 0TxZS+0aQtyDbktKgrxxbINNQPAwz3ITmNaslkLID2Yf44h6aiyI9c0bBqImtZJoxmqK9NQ04
 QNz9ShXIB/LE955UIJMqxEcNz+MM9KpHz8+PFR2V1Kn8FU34XKcw+YRkdV2SpuoBc6/HhrQzA
 pDFMHtnr1DqN3DPwJY/idxcQC/qjuZmyOfRSszGbAz7KtYhW/iBIWtILuNm2B84cBWbGSmOjd
 6OLuwf6X7RovM7MotwtLf2jbI8bk7kxfd/8F4/14ujSrBsppvYJc/GxRNeHp+QPNBf/prCLIG
 mYqV+vCl4LJX98PThu5eigP2L/amvvOh7rD1MnGhIDo//8x4uBHrmQatCuEoowo5Gj9DgEFQX
 t+0dHdl1MxqthItn6BipV8Q2GV9OwvmwHwW2N3+fvED58/OwPtEqRnvi+a2nmo1aWQFWsqhBX
 uqLc5Fe9DahDAlPQcr0eLdR7I0QKtDNsB2ZzBkLpZpFkjm/DzozQ/wRzL3avzofdtJ2lW3pLq
 Dl4uV1YGuqbbqtXOQTe4vQviZOsCOSNUVKEBCCaOtjAZOTZY3adR95nCo8mh0D34ux5M+46Nl
 tcPfFMZ/6Q+t5ABTIggFVDoJ76Ul0qBLQ3CqGvf9Lyy1/eQQ/46kCWR5gzNJYNyntszS1/YBL
 unKCdU+fgaBgJG9NaY1pB4Eqzlc=
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

This pull request if for the next branch.

The following changes since commit cd948210332783c2b1c6d10a982a80c0da4f69b=
9:

   Revert "board: ti: am62x/am62ax: Update virtual interrupt allocations
in board config" (2023-12-15 20:23:59 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-next-20231217

for you to fetch changes up to 291ab919355df5ee28183546049d5fbdb2777d2d:

   doc: Replace examples of MD5 and SHA1 with SHA256 (2023-12-17
13:06:48 +0100)

Gitlab CI showed no issues:

https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18990

=2D---------------------------------------------------------------
Pull request for efi-next-20231217

Documentation:

* replace MD5 and SHA1 by SHA256 in examples

UEFI:

* Refactor boot manager and bootefi command to let the EFI boot method
work without shell.

=2D---------------------------------------------------------------
AKASHI Takahiro (8):
       cmd: bootefi: unfold do_bootefi_image()
       cmd: bootefi: re-organize do_bootefi()
       cmd: bootefi: carve out EFI boot manager interface
       cmd: bootefi: carve out binary execution interface
       cmd: bootefi: localize global device paths for efi_selftest
       cmd: bootefi: move library interfaces under lib/efi_loader
       cmd: efidebug: ease efi configuration dependency
       bootmeth: use efi_loader interfaces instead of bootefi command

Sean Anderson (1):
       doc: Replace examples of MD5 and SHA1 with SHA256

  boot/Kconfig                             |   4 +-
  boot/Makefile                            |   2 +-
  boot/bootm_os.c                          |  32 +-
  boot/bootmeth_efi.c                      |   8 +-
  boot/bootmeth_efi_mgr.c                  |   2 +-
  cmd/Kconfig                              |  16 +-
  cmd/bootefi.c                            | 670
+++++--------------------------
  cmd/efidebug.c                           |   4 +-
  doc/chromium/files/chromebook_jerry.its  |   4 +-
  doc/chromium/files/nyan-big.its          |   4 +-
  doc/usage/cmd/imxtract.rst               |   6 +-
  doc/usage/fit/beaglebone_vboot.rst       |  74 ++--
  doc/usage/fit/howto.rst                  |  40 +-
  doc/usage/fit/kernel.rst                 |   6 +-
  doc/usage/fit/kernel_fdt.rst             |   4 +-
  doc/usage/fit/kernel_fdts_compressed.rst |   6 +-
  doc/usage/fit/multi-with-fpga.rst        |   6 +-
  doc/usage/fit/multi-with-loadables.rst   |   8 +-
  doc/usage/fit/multi.rst                  |  12 +-
  doc/usage/fit/sign-configs.rst           |   6 +-
  doc/usage/fit/sign-images.rst            |   4 +-
  doc/usage/fit/signature.rst              |  22 +-
  doc/usage/fit/update3.rst                |   6 +-
  doc/usage/fit/update_uboot.rst           |   2 +-
  doc/usage/fit/x86-fit-boot.rst           |   8 +-
  include/efi_loader.h                     |  12 +-
  lib/efi_loader/efi_bootmgr.c             | 530 ++++++++++++++++++++++++
  test/boot/bootflow.c                     |   2 +-
  28 files changed, 771 insertions(+), 729 deletions(-)
