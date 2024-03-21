Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F94C54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 07:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3743887FF2;
	Thu, 21 Mar 2024 08:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Ti/NrL2U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1300E87FF2; Thu, 21 Mar 2024 08:56:11 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C84A78744F
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 08:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711007766; x=1711612566; i=xypron.glpk@gmx.de;
 bh=rAcH0FbrAtB4ou/9gbi4QG2S5lDmIby/UEAiXdWndSc=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=Ti/NrL2UCUhkl21azGgpZ3nT/9/lmtWdGTCPrhlWUW9pzns4nLo0Og3XV9Dy8cm7
 Cydk4A5BbsmjNlVbACs+XtZw8EmyhYmF7wN9b0HovvKcAP1fKgq2xJCVlF+rRpJyk
 BsBBtd5kVIFYhgWkC9Uu1N0CQDSUEp0OKFL/FRlmH0z2aQuOI6TxHIc4LrfWbYfFU
 0Zv8FiL2r4AiMo8ZWZ+/u3vaFNJedXeOF/+Hp5TVYVF/18Z76zEfpUtf83+UljiT0
 oUoK5xLkMqP+M7Wkb/Jjc91DiTOY819yRK37ikj2ioP7metshN5Ht/uY2ATdvWE9k
 dieKq8hUpL+FMu3Siw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzyP-1rBx7Z2kal-00dYnl; Thu, 21
 Mar 2024 08:56:06 +0100
Message-ID: <2c0ee51f-4f03-40b2-b286-5b8642ba207f@gmx.de>
Date: Thu, 21 Mar 2024 08:56:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Douglas Anderson <dianders@chromium.org>,
 Hiago De Franco <hiago.franco@toradex.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-04-rc5-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0KylRAdmM4l75cixtd///sHQWazURw0bQkAJU5lTizet/epzvtB
 t3D0psWSyUjQo+GfSSbH/ZhipnuymhGy0MjOnR8jwphJF1TPzVA8BAhiSZlZZZncLm4Xo2d
 wOlwQiRtrQn+F0w4ZXrHCjwdDoh6eKH0rnwq2/muMLgJlM5WUhNFJTUEvz17zCwAMiO18p5
 vn6ZEB08aaFio4ewcQJVg==
UI-OutboundReport: notjunk:1;M01:P0:l4xOdLDPQaM=;Lh1rsetMCfJeQdPa2aybKWh00qR
 lrZLJsjnheyfoSzHYFmqIQiKiUnckxGLJT5eOoxUj/65pRPxbW/Ps51sEa6mJHKzEIjovUShy
 AVZmYk2PNipHjzEjiTUNes/cgVffcmw6oYcZueuF/mepipt7eW+shiTaAtFTR02NouprcKuYm
 CJ3ba0AgIq+1JskKiUh0fJCKjf9qu87TKTi8iK6NzvHYpOS2ctfIVOmevfLK2KZ69tlE2DAps
 7/Hiwz2L4nRD5+V5+PUvxEHzoRgxeFNwdlqaubhSaG5cVnCuUeuIJgtHOx1ezitYEtyQJwFi7
 JXa6qK1kvNx/r1EobuwQJv8TzdVYyAWS0tdxfGm8k+GWRnQEuNi0Ul2QXZrATFi03PqUHALjG
 wRuzQH5/JbbHapY2xo6XTdm23v62whNNt/+4nmTSiiNOyU4fJRuvMti3U8FSjYiF/lF2vQrus
 wCc06Bad/qdKo96IXbUONfCyT2N4He8irSKz6Bl1F3AP/q8iikORskFhKbPBytgQ9JUlL7IYR
 QvJIBqlsc1zUD5+gvDKNu7q/Sv7D2q8K/aoNIzgXsOFqgaSpgMnNxIeA8fFPPJAkoYDRbSTrr
 69vGixvWyLasWG+HCYzHHhDYoDARoTZ/ZN1+UhnsuiXq52nCCFGQa0Va9jr2wEIGdpsxUmTAr
 +vB66WD8zVkPoQsH+tnItmI+kkQB95HIXELHu2TqC1vLSsRTS0EUv5BFoeYAAxDYAywFOPIoY
 E5x0Fc39LFTd/tcypKUxItJOqUu5vrHfM2bL0EobLQd14kO/agARKnuUnpws/JMrw60LaAmHA
 POcOzl17k5Yvrd4CbaMjK3hLYriSqoiiig1morD9pv0/M=
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

The following changes since commit 6ec096a7116a5f1f7dfac5f69ef192429331905=
c:

   Merge tag 'u-boot-imx-master-20240317' of
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-03-17 19:43:02
-0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-04-rc5-2

for you to fetch changes up to fcd0c8b8474f7db0b94608424715a73fbeba92dc:

   patman: Properly document the patchwork_url setting (2024-03-21
07:36:54 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20013

=2D---------------------------------------------------------------
Pull request efi-2024-04-rc5-2

Documentation:

* patman: Properly document the patchwork_url setting
* doc: man-page for if
* colibri-imx8x, apalis-imx8: update board documentation

UEFI:

* correct handling of EFI binary return code
* don't show usage help if EFI binary fails.
* correct error handling for bootefi selftest command

=2D---------------------------------------------------------------
Douglas Anderson (1):
       patman: Properly document the patchwork_url setting

Heinrich Schuchardt (5):
       efi_loader: correct handling of EFI binary return code
       cmd: bootefi: Don't show usage help if EFI binary fails.
       cmd: bootefi: error handling bootefi selftest
       doc: man-page for if
       doc: typo Synopis

Hiago De Franco (2):
       doc: board: colibri-imx8x: Update and improve documentation
       doc: board: apalis-imx8: Update and improve documentation

  cmd/bootefi.c                       | 12 ++-----
  doc/board/toradex/apalis-imx8.rst   | 32 ++++++++---------
  doc/board/toradex/colibri-imx8x.rst | 23 ++++++++----
  doc/usage/cmd/acpi.rst              |  4 +--
  doc/usage/cmd/bootdev.rst           |  4 +--
  doc/usage/cmd/bootflow.rst          |  4 +--
  doc/usage/cmd/bootmeth.rst          |  4 +--
  doc/usage/cmd/cbsysinfo.rst         |  4 +--
  doc/usage/cmd/cedit.rst             |  4 +--
  doc/usage/cmd/cli.rst               |  4 +--
  doc/usage/cmd/dm.rst                |  4 +--
  doc/usage/cmd/fdt.rst               |  4 +--
  doc/usage/cmd/font.rst              |  4 +--
  doc/usage/cmd/for.rst               |  4 +--
  doc/usage/cmd/history.rst           |  4 +--
  doc/usage/cmd/host.rst              |  4 +--
  doc/usage/cmd/if.rst                | 72
+++++++++++++++++++++++++++++++++++++
  doc/usage/cmd/md.rst                |  4 +--
  doc/usage/cmd/mtrr.rst              |  4 +--
  doc/usage/cmd/panic.rst             |  4 +--
  doc/usage/cmd/part.rst              |  4 +--
  doc/usage/cmd/sf.rst                |  4 +--
  doc/usage/cmd/sm.rst                |  4 +--
  doc/usage/cmd/trace.rst             |  4 +--
  doc/usage/cmd/ut.rst                |  4 +--
  doc/usage/index.rst                 |  1 +
  lib/efi_loader/efi_bootbin.c        | 16 ++++++---
  tools/patman/patman.rst             |  8 ++---
  28 files changed, 165 insertions(+), 83 deletions(-)
  create mode 100644 doc/usage/cmd/if.rst
