Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DA0C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 03:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987C8870BE;
	Sat, 11 Nov 2023 04:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Gv4i/Pkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 336B9870DD; Sat, 11 Nov 2023 04:35:11 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DCD1870AB
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 04:35:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699673702; x=1700278502; i=xypron.glpk@gmx.de;
 bh=l72uLwVsbQQfjGYjSq5DK0zdkms4MOBNmmp6Tnr/lQY=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=Gv4i/PkdGDWsJTLRbLeXS3NwTf6LcpT7jiAxGO0ICk5ebK4vBU12qbmyaLwieXJl
 OIiAYTYUsRAvMoo4L99/lkbVDwMMDwGdmXrSeKEh4xYUUITk3UDlsqn3xX4gOXXWD
 ZFU+zvLnTznvt9xF/W9sfC0ShyMeskHHCaz2j13Jp5Ya1o+qHPHCYVfQDhqOkdPq+
 xtlPaTE4xroCwdOahW/O6qWI1GVlKcA4lZEJ96Zhzfl6IPo3fP2NHpcuksxaBsvLv
 o7iT8Rl5iKlXA9E0NJ57/SMgd9VoqVHjjwyXloT22E+8QSz/PSJ1tNmOW3Fvmx432
 U9QCLCIniir+ndc6SA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1rMKOI2bki-00wRr2; Sat, 11
 Nov 2023 04:35:02 +0100
Message-ID: <a9431d19-29e3-4f3d-99d5-8a737085564a@gmx.de>
Date: Sat, 11 Nov 2023 04:34:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>,
 Dylan Corrales <deathcamel58@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request doc-2024-01-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WTFeTTur6cO83nuCz41sAscDzyYxuXnt5CmbLHHnsvyYJDaOoCd
 SqtZ4BBnyqJuZfUKZ3mGaHsT0Et4MNxa6oGAo/XAmgs2u9xTklm76c9ykEL4BUEtAm1hSkE
 rb9qcB4nhzWSR5g4Kvh0FUOMdKaGUuMMEL75VPBdU7EGg/82CFYcT+hPZJMCR02n9kyg0Nu
 z1BKhdTOMgxleihW5qeow==
UI-OutboundReport: notjunk:1;M01:P0:5xIyUOeiRm0=;1jof7rACyObMPK1z/0gCgL4P9pL
 6rO/ycCqwckMoSCAKP77fzIbn7Gi2+7zkFojfPwzciyNHNdksciyKeP0/84XeZNrVQ27BnMPL
 QCPmz3D4YpUqWHez/Eu7K5bAB0bxLNnh0QZxrIVTySvt2k+wbu5OaITut7Urk8pmQHgsOII0j
 JMcFi4ejLt1RHDyy8TaqanMaSQONQpoFPASqPeNHL0VQSYVocU1UE7kWE8eVIETy9B9Hnv35z
 3r8IbAuRsFxzkotcHZqUddnn5yJagWl+JsntvVqFWnJjRW6KmEEtRp6MFGHljYRUwDLOYITlv
 UC2LZMd6b4MzZUyBss3fcwint+n2ZQtU9CqP6xpuoJh/8mF4dRod/sQ49tVXPVk01unW0R7qi
 a50RZQq8MLthy3vLueWlRW21xqjdS1NKbT/CKM2FKWvTKRdR48ghD5kwjp7W1hF0JMeF+Crsi
 6eOzscwpzTld7j2lZmuYM6UdtMJzMOh3gxiSwTFgf0nB0fjsCl5dw3Etbkuo6z3o/rIPVLWGJ
 +K+P3ebpmcXlCDMAjv8PytsWfBq5bOis736aAGiHQTGsX9w1oHbW3Lx0v0ftwTMhWR4hkNNNb
 GmDxzpp9lmotqxQ979dlDsmjZAmnXQyZsgxqoogRtcKLb9U/pM0FPnTTCBiGaij0Xfxz2Rhzt
 puTn4AWgyrwQSY0Y5btubZQxwMTFzj8rM/t1Fq1/6Q7jDpdgbcgtpYFI1Ua1DXY285AcL8LTy
 4ASLWdUgl9KxwEaj1VefDQr3CDN9ZdtFsgGY6vgCzQpUKPw/xxECWVbznGKmDrXUmh2dX+Umk
 32VdQ5JV/oze3DNZ22kChyUODvGZBnOWGKL69Zrdm0FdrGW9tq2s6awUBlmsSkVtsaRWaB0EK
 IXfX+cHUsXelUh/rzGfE9zqWLVhAY1FZlxeXO4oHeUKi4L20IQfHZMSFxzwHAUvJd320s1oUH
 JlmDDxfZHKj8foZilybSOqogfwI=
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

The following changes since commit da2e3196e4dc28298b58a018ace07f85eecd165=
2:

   Merge patch series "arm: dts: k3-am6: Fix Ethernet/DMA" (2023-11-10
15:25:47 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/doc-2024-01-rc3

for you to fetch changes up to cfaf05839f86ea387786c841c7f578be0fea247b:

   doc: typo 'form' in qfw.rst (2023-11-11 01:44:09 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18517

=2D---------------------------------------------------------------
Documentation:

* hikey960: update link URLs
* j7200_evm: Fix OPTEE platform name
* ti: fix style of examples
* fix typos

=2D---------------------------------------------------------------
Dylan Corrales (1):
       hikey960: Fix 404 links

Heinrich Schuchardt (2):
       doc: shorten overlong title underlines
       doc: typo 'form' in qfw.rst

Milan P. Stani=C4=87 (1):
       doc: build: fix wrongly written targests instead of targets

Nishanth Menon (3):
       doc: ti: j7200_evm: Fix OPTEE platform name
       doc: board: ti: Use prompt prompt_style to simplify documentation
       doc: board: ti: k3 docs: Use ::prompt

  board/hisilicon/hikey960/README        |  14 ++---
  doc/arch/arm64.ffa.rst                 |  20 +++---
  doc/board/AndesTech/ae350.rst          |   2 +-
  doc/board/actions/cubieboard7.rst      |   4 +-
  doc/board/actions/index.rst            |   2 +-
  doc/board/armltd/index.rst             |   2 +-
  doc/board/mediatek/index.rst           |   2 +-
  doc/board/nxp/imx8mm_evk.rst           |   9 +--
  doc/board/nxp/ls1046ardb.rst           |   2 +-
  doc/board/nxp/mx6ul_14x14_evk.rst      |   2 +-
  doc/board/openpiton/riscv64.rst        |   4 +-
  doc/board/purism/librem5.rst           |   2 +-
  doc/board/qualcomm/sdm845.rst          |   7 ++-
  doc/board/samsung/index.rst            |   2 +-
  doc/board/st/st-dt.rst                 |   2 +-
  doc/board/st/stm32_MCU.rst             |   2 +-
  doc/board/starfive/visionfive2.rst     |   3 +-
  doc/board/thead/index.rst              |   2 +-
  doc/board/ti/am335x_evm.rst            |  39 ++++--------
  doc/board/ti/am62x_beagleplay.rst      |  50 +++++++--------
  doc/board/ti/am62x_sk.rst              |  23 +++----
  doc/board/ti/am64x_evm.rst             |  21 ++++---
  doc/board/ti/am65x_evm.rst             | 107
+++++++++++++++++----------------
  doc/board/ti/dra7xx_evm.rst            |   3 +-
  doc/board/ti/j7200_evm.rst             |  23 +++----
  doc/board/ti/j721e_evm.rst             |  43 ++++++-------
  doc/board/ti/j721s2_evm.rst            |  24 +++++---
  doc/board/ti/k3.rst                    |  48 +++++++--------
  doc/board/ti/ks2_evm.rst               |  15 ++---
  doc/board/xilinx/xilinx.rst            |   2 +-
  doc/build/gcc.rst                      |   2 +-
  doc/build/source.rst                   |   2 +-
  doc/develop/driver-model/ethernet.rst  |  12 ++--
  doc/develop/driver-model/migration.rst |   2 +-
  doc/develop/driver-model/nvmxip.rst    |   8 +--
  doc/develop/driver-model/spi-howto.rst |   2 +-
  doc/develop/falcon.rst                 |   2 +-
  doc/usage/cmd/askenv.rst               |   2 +-
  doc/usage/cmd/bootdev.rst              |   4 +-
  doc/usage/cmd/cat.rst                  |   2 +-
  doc/usage/cmd/coninfo.rst              |   2 +-
  doc/usage/cmd/mmc.rst                  |   2 +-
  doc/usage/cmd/part.rst                 |   2 +-
  doc/usage/cmd/qfw.rst                  |   2 +-
  doc/usage/cmd/wdt.rst                  |   2 +-
  doc/usage/cmd/xxd.rst                  |   2 +-
  doc/usage/fit/beaglebone_vboot.rst     |   2 +-
  doc/usage/measured_boot.rst            |   4 +-
  tools/binman/entries.rst               |   2 +-
  49 files changed, 268 insertions(+), 271 deletions(-)
