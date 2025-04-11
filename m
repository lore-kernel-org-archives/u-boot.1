Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C786C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5CA783F89;
	Fri, 11 Apr 2025 14:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="N+sAE8w3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C861F83F9C; Fri, 11 Apr 2025 14:58:13 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 501DD83F2D
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744376278; x=1744981078; i=xypron.glpk@gmx.de;
 bh=ifPjZuCBvrwRhXDu9q0Zg9gc89bXXUkNsKfslDLYJ+I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=N+sAE8w3RdI9+CYqT7IknJYOy6gn+54tfVsYXctfyreEDGIRygvMnlOsxb06CLZg
 G65Tme4XBupGqMvO7nVArG5Kex4M9oZV7VND0PTAGCCmQFtD7YBSjBmi+pHoKUhZP
 mXGpr9VDAzdd57Emwt5o7sxHxq+wLOUmt6U/DVK6r4cySAqRL8z4I69PJ25lJQ5pO
 coJaLNzXwBZ4zaUs8qKMs1DcgURUwSfE91OnVBDIGBMJITtXk/UJ68yW/flGyh3em
 0GTREWGPiwmXOCFSxA+12JGG/1muB+aRMYw8xHYj73dIQlsxnFAA+Lox3a8n/D4QX
 QIOBmIutTbLEW9bc+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.109.163]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72oH-1txzp30ipL-00EAqm; Fri, 11
 Apr 2025 14:57:58 +0200
Message-ID: <f7894cc5-7f47-4b75-a722-7c0e67c3c7df@gmx.de>
Date: Fri, 11 Apr 2025 14:57:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adriano.cordova@canonical.com>, Bryan Brattlof <bb@ti.com>,
 =?UTF-8?Q?Christian_Kohlschu=CC=88tter?= <christian@kohlschutter.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Michal Simek
 <michal.simek@amd.com>, Pawel Kochanowski <pkochanowski@sii.pl>,
 Simon Glass <sjg@chromium.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2025-07-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/8YBYSjkd4e2q9w08I+uXXpHxIqQKSZYd6o7oR+NJwst6iZYC4g
 OmYgqkaMCPJPIVV2zP2/nB0Og05gxlkEJm+fVqSmizoOo+qe+VZ+GuK40NRJMTMrP1E2npl
 eLlgJ2lCuXsZz7j9Vgf5v615y2NbGfcK/Jf0llq9MrWmr96F9answwkFyht1PkKZ4vYS2MT
 NuEb3tfEfX1uWGNza3CTA==
UI-OutboundReport: notjunk:1;M01:P0:bLT92KH5sfI=;mJ4JypcT9BczN0b/v+UzMAGkdhd
 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
 g==
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

The following changes since commit cb7555e93075114fe4af0adb806877ac4d4ef80=
d:

   Merge patch series "*** Add Ethernet boot support for AM62Ax +
phyCORE-AM62 SoMs ***" (2025-04-10 15:04:09 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2025-07-rc1

for you to fetch changes up to a73b854700abcf680379497c32b92aa39fed6270:

   efi_selftest: remove un-needed NULL checks (2025-04-11 13:27:54 +0200)

Gitlab CI showed no issues:

https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/25648

=2D---------------------------------------------------------------
Pull request efi-2025-07-rc1

Documentation:

* Update authenticated capsules documentation

UEFI:

* add support for loading FIT images including initrd
   - efi_loader: efi_load_initrd: provide a memory mapped initrd
   - efi_loader: binary_run: register an initrd
   - bootm: add support for initrd in do_bootm_efi
* efi_selftest: remove un-needed NULL checks
* efi: Fix efiboot for payloads loaded from memory

* Print extra information from the bootmgr
* Move public cert for capsules to .rodata
* set EFI capsule dfu_alt_info env explicitly
* Make FDT extra space configurable
* Install the ACPI table from the bloblist
* Handle GD_FLG_SKIP_RELOC
* handle malloc() errors

Others:

* acpi: select CONFIG_BLOBLIST
* smbios: select CONFIG_BLOBLIST
* xilinx: dfu: Fill directly update_info.dfu_string
* cmd: fwu: Dump custom fields from mdata structure
* board: remove capsule update support in set_dfu_alt_info()

=2D---------------------------------------------------------------
Adriano Cordova (3):
       efi_loader: efi_load_initrd: provide a memory mapped initrd
       efi_loader: binary_run: register an initrd
       bootm: add support for initrd in do_bootm_efi

Bryan Brattlof (1):
       efi_selftest: remove un-needed NULL checks

Christian Kohlschu=CC=88tter (1):
       efi: Fix efiboot for payloads loaded from memory

Heinrich Schuchardt (3):
       acpi: select CONFIG_BLOBLIST
       smbios: select CONFIG_BLOBLIST
       doc/buildman: typo 'require'

Ilias Apalodimas (3):
       efi_loader: Print extra information from the bootmgr
       efi_loader: Move public cert for capsules to .rodata
       doc: Update authenticated capsules documentation

Jonathan Humphreys (2):
       efi_firmware: set EFI capsule dfu_alt_info env explicitly
       board: remove capsule update support in set_dfu_alt_info()

Michal Simek (2):
       xilinx: dfu: Fill directly update_info.dfu_string
       cmd: fwu: Dump custom fields from mdata structure

Pawel Kochanowski (1):
       efi: Make FDT extra space configurable

Simon Glass (1):
       efi_loader: Install the ACPI table from the bloblist

Varadarajan Narayanan (1):
       efi_loader: Handle GD_FLG_SKIP_RELOC

Vincent Stehl=C3=A9 (1):
       efi_loader: handle malloc() errors

  Makefile                                           |  2 +-
  board/beagle/beagleboneai64/beagleboneai64.c       |  8 ---
  board/beagle/beagleplay/beagleplay.c               |  8 ---
  board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   |  2 -
  board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   |  2 -
  board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c |  2 -
  board/phytec/common/k3/board.c                     |  8 ---
  board/ti/am62px/evm.c                              |  8 ---
  board/ti/am62x/evm.c                               |  8 ---
  board/ti/am64x/evm.c                               |  8 ---
  board/ti/j721e/evm.c                               |  8 ---
  board/ti/j784s4/evm.c                              |  8 ---
  board/xilinx/common/board.h                        |  3 +
  board/xilinx/versal/board.c                        | 16 ++---
  board/xilinx/zynq/board.c                          | 16 ++---
  board/xilinx/zynqmp/zynqmp.c                       | 16 ++---
  boot/bootm_os.c                                    |  4 +-
  cmd/Kconfig                                        |  1 +
  cmd/bootefi.c                                      |  2 +-
  cmd/fwu_mdata.c                                    | 25 +++++++
  common/board_r.c                                   |  3 +-
  doc/develop/uefi/uefi.rst                          | 15 ----
  drivers/misc/Kconfig                               |  1 +
  include/asm-generic/sections.h                     |  2 +
  include/efi_loader.h                               |  4 +-
  lib/Kconfig                                        |  1 +
  lib/efi_loader/Kconfig                             |  2 -
  lib/efi_loader/Makefile                            | 18 +++++
  lib/efi_loader/capsule_esl.dtsi.in                 | 11 ---
  lib/efi_loader/efi_acpi.c                          | 42 +++++++----
  lib/efi_loader/efi_bootbin.c                       | 23 +++++-
  lib/efi_loader/efi_bootmgr.c                       |  4 +-
  lib/efi_loader/efi_capsule.c                       | 37 +++-------
  lib/efi_loader/efi_capsule_key.S                   | 17 +++++
  lib/efi_loader/efi_dt_fixup.c                      |  2 +-
  lib/efi_loader/efi_firmware.c                      | 56 ++++++++++++---
  lib/efi_loader/efi_helper.c                        |  2 +-
  lib/efi_loader/efi_hii.c                           |  3 +
  lib/efi_loader/efi_load_initrd.c                   | 71 +++++++++++++++-=
--
  lib/efi_selftest/efi_selftest_hii.c                | 84
++++++++++------------
  scripts/Makefile.lib                               | 27 -------
  tools/buildman/buildman.rst                        |  2 +-
  42 files changed, 307 insertions(+), 275 deletions(-)
  delete mode 100644 lib/efi_loader/capsule_esl.dtsi.in
  create mode 100644 lib/efi_loader/efi_capsule_key.S
