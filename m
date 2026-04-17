Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A49F8E4B7
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AFE283FC0;
	Fri, 17 Apr 2026 10:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gNdYRAe1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 355D68421D; Fri, 17 Apr 2026 10:02:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE03583B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776412920; x=1777017720; i=xypron.glpk@gmx.de;
 bh=xalZZde9FK+lvBBNvC1KBJCbK7K3gvgTohXiglEzt/E=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gNdYRAe1JqIGzZXj0s4eCIzM5cRF5XomuRJlFgr1av+EaX6h0jrdVmcujLLaeH01
 eJaLnlAk7DkzR5O2OadN9M29mTs7OC9E3DfFVAH0kGwBgg+uifNV9U9iEUeEsIAi1
 cOxZLPHMHR6d5gCY3WE+SIivvTLQSVeIPkFAZNaNdKyHbxqELg9ga4vm+j3+24V23
 5fwPQ5DOXtGdkmTlK+IIXO3444G4O5sUIXk3NRcWFykMVS0qWy2L4xI7jrhZO3BYv
 zovl816GUL6pdIXmtNTT9tpHnhpgTJX2ImFNPslW1OgBNDjH6rmwCaNS6GC4D9llS
 k6milCm+e+ndMQlndA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIwzA-1vyipO0RK6-00USf4; Fri, 17
 Apr 2026 10:02:00 +0200
Message-ID: <3bde3ed6-6baa-4d52-a743-d9bb8de36382@gmx.de>
Date: Fri, 17 Apr 2026 10:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Simon Glass <sjg@chromium.org>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Michal Simek <michal.simek@amd.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request for efi-2026-07-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mVRifBWQqEQImCrRynQ+14F57An/HTtv/wYAordjBEUkvw8kOk8
 JWvi1GpM6os6hn3MXWtB9dcLcB+acDRahd7Dl2xfACXIFtcwpRKgByWDYEO6Okse9VwF/Nm
 atXLAls3KwcJMr/4xW345DP+r9NmE9E5oOSjmu//BVdOnvWoncnp/+3mS1ybbRZTXSzgU3e
 85dw9jMNk673DxfZo8VoA==
UI-OutboundReport: notjunk:1;M01:P0:V3cUdxU8Nfc=;qLGMiWPlesomZt2JWcjAfu48v+9
 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
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

The following changes since commit 70fd0c3bb7c26d42f24d10145dd5f3168ac92ea=
c:

   x86: there is no CONFIG_UBOOT_ROMSIZE_KB_12288 (2026-04-14 14:21:55=20
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-07-rc1

for you to fetch changes up to 98d1d3227e8d9513a2705e9fa4c8aa9d20d8eeac:

   doc: board: ti: j784s4_evm: Automate BAR address lookup for PCIe Boot=
=20
(2026-04-17 08:16:03 +0200)

Gitlab CI reported no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/29844

=2D---------------------------------------------------------------
Pull request for efi-2026-07-rc1

Documentation:

* correct title of CONTRIBUTE.rst
* Fix fdt resize argument in fdt_overlays.rst
* api: bootcount: correct bootcount description
* binman: Add Sphinx extension to auto-generate entry and bintool docs
* binman: Remove pre-generated entries.rst and bintools.rst
*  j784s4_evm: Automate BAR address lookup for PCIe Boot

UEFI:

* efi_var_sf: Do not fail on blank SPI Flash
* Allow disabling ANSI console queries via Kconfig
* bootstd: efi: Handle prior-stage FDT in network path
* event: Check return value from event_notify_null()
* event: Introduce EVT_POST_PREBOOT event
* fwu: Move boottime checks to EVT_POST_PREBOOT

=2D---------------------------------------------------------------
Heinrich Schuchardt (1):
       doc: correct title of CONTRIBUTE.rst

Matwey V. Kornilov (1):
       doc: Fix fdt resize argument in fdt_overlays.rst

Michael Opdenacker (1):
       doc: api: bootcount: correct bootcount description

Michal Simek (5):
       efi_loader: efi_var_sf: Do not fail on blank SPI Flash
       event: Check return value from event_notify_null()
       event: Introduce EVT_POST_PREBOOT event
       fwu: Move boottime checks to EVT_POST_PREBOOT
       efi_loader: Allow disabling ANSI console queries via Kconfig

Siddharth Vadapalli (1):
       doc: board: ti: j784s4_evm: Automate BAR address lookup for PCIe Bo=
ot

Simon Glass (3):
       binman: Add Sphinx extension to auto-generate entry and bintool doc=
s
       binman: Remove pre-generated entries.rst and bintools.rst
       bootstd: efi: Handle prior-stage FDT in network path

  boot/bootmeth_efi.c              |   15 +-
  common/board_r.c                 |    6 +-
  common/event.c                   |    3 +
  common/main.c                    |    4 +
  doc/.gitignore                   |    2 +
  doc/CONTRIBUTE.rst               |    4 +-
  doc/api/bootcount.rst            |    2 +-
  doc/board/ti/j784s4_evm.rst      |   16 +-
  doc/conf.py                      |    3 +-
  doc/develop/package/bintools.rst |    1 -
  doc/develop/package/entries.rst  |    1 -
  doc/sphinx/binman_docs.py        |  207 +++
  doc/usage/fdt_overlays.rst       |    4 +-
  include/event.h                  |    9 +
  lib/efi_loader/Kconfig           |   11 +
  lib/efi_loader/efi_console.c     |    3 +
  lib/efi_loader/efi_var_sf.c      |    5 +-
  lib/fwu_updates/fwu.c            |    2 +-
  test/dm/fwu_mdata.c              |    4 +-
  tools/binman/binman.rst          |   12 +-
  tools/binman/bintools.rst        |  249 ---
  tools/binman/entries.rst         | 3133=20
=2D-------------------------------------
  22 files changed, 278 insertions(+), 3418 deletions(-)
  delete mode 120000 doc/develop/package/bintools.rst
  delete mode 120000 doc/develop/package/entries.rst
  create mode 100644 doc/sphinx/binman_docs.py
  delete mode 100644 tools/binman/bintools.rst
  delete mode 100644 tools/binman/entries.rst
