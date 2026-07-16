Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59135C43458
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 04:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B4AF84C5F;
	Thu, 16 Jul 2026 06:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pjnJS9nl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D370584C83; Thu, 16 Jul 2026 06:47:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E9CD84C5A
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784177265; x=1784782065; i=xypron.glpk@gmx.de;
 bh=pIoyyqxab6fZTk3YTTmv9xguDrNqAYRiGJLvm6JLYlw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=pjnJS9nlKx92bM8x1s8HPe1f4KQD3CxyRQchftJCVtrBrJNvPLPw4IL8BZNOkZHr
 IF4ZpYtZXRBJZl+LQkn/yPxCUIL0TIuEzdr8ZfUvM1Gn9yTekF4+6yJsPwJiTvHin
 4qxEf3y4cthCtEc0AmU+WoU5IzXLlMwpUbmpl+ygrM6L4+l7oLp9BLcby4l/px4xI
 MTXRiOhiEoenXiG5GV4DI/g2uuI+yLcRtRehkZ4r5VgxpqmBY8HMk1ZZYj93tWFKJ
 W681VPBRrlXzkPX7y41LWBXm2k2kjRDLA5xCrSITEDDx7fskbbBIbSpYeHRFpIILT
 BqxEYJXM/qZQCRkoZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdiZ-1wpzIC0mtZ-0003ya; Thu, 16
 Jul 2026 06:47:45 +0200
Message-ID: <43faed52-0d4b-4549-b2f9-4fc566f71068@gmx.de>
Date: Thu, 16 Jul 2026 06:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Karl Chan <exxxxkc@getgoogleoff.me>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-10-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E8mN8d6CTKJ5KT7Mwh5v7Wzzy7QjmxeZ+6RMSJ4yXM07SBN15+z
 5XmjsuptWFZXTcSsP6rh6rJ0Ls/XnzlMOzVy3DRLH1ngbVN4Vp91y+EIms5/jawYepFOC5c
 +GMQ7c9oSTkL2fz4+3UYuXFu6qvwVdtfvceAXyYJMrUvF/4qAiI7KILAQkqaEvZ05raqXDr
 ncNlQgurB9un0YGZ1qWdw==
UI-OutboundReport: notjunk:1;M01:P0:XaUheQIJ3NI=;a0yIEqmNX1Jw69qlFk6q8JIOL4z
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

The following changes since commit 8dbe57ba648648c4897717cebbc4505a8e0a8c2=
3:

   Merge patch series "tools: qconfig: print a proper error when=20
database is missing" (2026-07-14 15:42:08 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-10-rc1

for you to fetch changes up to cb4c530f7f229659d2d62a0f52fb1789a9c54ad6:

   doc: CONTRIBUTE: explicitly list tests and documentation as welcome=20
contributions (2026-07-16 00:40:43 +0200)

Gitlab CI showed no issues:
https://git.u-boot-project.org/u-boot/custodians/u-boot-efi/-/pipelines/64=
8

=2D---------------------------------------------------------------
Pull request efi-2026-10-rc1

Documentation:

* board: renesas: Document SH/Aarch32/Aarch64 toolchain setup
* board: renesas: Document Aarch32 toolchain setup in RZ/N1
* board: renesas: Document Renesas R-Car Gen3 H3/M3-W/M3-N Salvator-X(S)=
=20
board
* board: renesas: Document Renesas R-Car Gen3 H3/M3-W/M3-N ULCB board
* board: renesas: Document Renesas R-Car Gen3 M3Le Geist board
* board: renesas: Document Renesas R-Car Gen3 E3 Ebisu board
* board: renesas: Document Renesas R-Car Gen3 D3 Draak board
* board: renesas: Document Retronix R-Car Gen4 V4H Sparrow Hawk board
* board: renesas: Document Renesas R-Car Gen5 X5H Ironhide board
* board: renesas: Update Renesas generic build section
* board: renesas: Convert Renesas board support table to grid table
* boards: amlogic: update documentation for Beelink GT1 Ultimate
* CONTRIBUTE: use internal link instead of hardcoded external URL
* CONTRIBUTE: tell people reviewing *is* contributing
* CONTRIBUTE: explicitly list tests and documentation as welcome=20
contributions

UEFI:

* fix building with CONFIG_EFI_VARIABLES_PRESEED=3Dy
* fix buffer overrun in efi_sigstore_parse_siglist
* Correctly count the size on DTB measurements
* Change the return values if a TPM is missing during GetEventLog
* Measure secure boot variables in the correct PCR if DeployedMode is set
* fix missing EFI_EXIT in efi_disconnect_controller
* efi_selftest: free handles on teardown()
* efi_selftest: test block io revision and pointers

Others:

* qfw: fix RSDP ACPI table ext_checksum computation

=2D---------------------------------------------------------------
Heinrich Schuchardt (3):
       qfw: fix RSDP ext_checksum recomputation
       efi_loader: fix building with CONFIG_EFI_VARIABLES_PRESEED=3Dy
       efi_loader: fix buffer overrun in efi_sigstore_parse_siglist

Ilias Apalodimas (3):
       efi_loader: Correctly count the size on DTB measurements
       efi_loader: Change the return values if a TPM is missing during=20
GetEventLog
       efi_loader: Measure secure boot variables in the correct PCR if=20
DeployedMode is set

Karl Chan (1):
       doc: boards: amlogic: update documentation for Beelink GT1 Ultimate

Marek Vasut (11):
       doc: board: renesas: Document SH/Aarch32/Aarch64 toolchain setup
       doc: board: renesas: Document Aarch32 toolchain setup in RZ/N1
       doc: board: renesas: Document Renesas R-Car Gen3 H3/M3-W/M3-N=20
Salvator-X(S) board
       doc: board: renesas: Document Renesas R-Car Gen3 H3/M3-W/M3-N=20
ULCB board
       doc: board: renesas: Document Renesas R-Car Gen3 M3Le Geist board
       doc: board: renesas: Document Renesas R-Car Gen3 E3 Ebisu board
       doc: board: renesas: Document Renesas R-Car Gen3 D3 Draak board
       doc: board: renesas: Document Retronix R-Car Gen4 V4H Sparrow=20
Hawk board
       doc: board: renesas: Document Renesas R-Car Gen5 X5H Ironhide board
       doc: board: renesas: Update Renesas generic build section
       doc: board: renesas: Convert Renesas board support table to grid=20
table

Quentin Schulz (3):
       doc: CONTRIBUTE: use internal link instead of hardcoded external UR=
L
       doc: CONTRIBUTE: tell people reviewing *is* contributing
       doc: CONTRIBUTE: explicitly list tests and documentation as=20
welcome contributions

Vincent Stehl=C3=A9 (3):
       efi_loader: fix missing EFI_EXIT in efi_disconnect_controller
       efi_selftest: free handles on teardown()
       efi_selftest: test block io revision and pointers

  doc/CONTRIBUTE.rst                           |  19 +-
  doc/board/amlogic/beelink-gt1-ultimate.rst   | 104 ++++----
  doc/board/renesas/build-env-aarch32.rst      |  25 ++
  doc/board/renesas/build-env-aarch64.rst      |  25 ++
  doc/board/renesas/build-env-sh.rst           |  25 ++
  doc/board/renesas/index.rst                  |  13 +
  doc/board/renesas/rcar-gen3-draak.rst        |  47 ++++
  doc/board/renesas/rcar-gen3-ebisu.rst        |  47 ++++
  doc/board/renesas/rcar-gen3-geist.rst        |  45 ++++
  doc/board/renesas/rcar-gen3-install-hf.rst   |  76 ++++++
  doc/board/renesas/rcar-gen3-install-sf.rst   |  29 +++
  doc/board/renesas/rcar-gen3-install.rst      |  34 +++
  doc/board/renesas/rcar-gen3-salvator-x.rst   |  48 ++++
  doc/board/renesas/rcar-gen3-ulcb.rst         |  49 ++++
  doc/board/renesas/rcar-gen4-sparrow-hawk.rst |  91 +++++++
  doc/board/renesas/rcar-gen5-ironhide.rst     | 204 ++++++++++++++++
  doc/board/renesas/renesas.rst                | 353=20
++++++++-------------------
  doc/board/renesas/rzn1.rst                   |   2 +
  drivers/misc/qfw_acpi.c                      |   1 +
  lib/efi_loader/Makefile                      |   7 +-
  lib/efi_loader/efi_boottime.c                |   2 +-
  lib/efi_loader/efi_signature.c               |   3 +-
  lib/efi_loader/efi_tcg2.c                    |  12 +-
  lib/efi_loader/efi_var_seed.S                |   4 +-
  lib/efi_selftest/efi_selftest_block_device.c |  77 +++++-
  25 files changed, 1018 insertions(+), 324 deletions(-)
  create mode 100644 doc/board/renesas/build-env-aarch32.rst
  create mode 100644 doc/board/renesas/build-env-aarch64.rst
  create mode 100644 doc/board/renesas/build-env-sh.rst
  create mode 100644 doc/board/renesas/rcar-gen3-draak.rst
  create mode 100644 doc/board/renesas/rcar-gen3-ebisu.rst
  create mode 100644 doc/board/renesas/rcar-gen3-geist.rst
  create mode 100644 doc/board/renesas/rcar-gen3-install-hf.rst
  create mode 100644 doc/board/renesas/rcar-gen3-install-sf.rst
  create mode 100644 doc/board/renesas/rcar-gen3-install.rst
  create mode 100644 doc/board/renesas/rcar-gen3-salvator-x.rst
  create mode 100644 doc/board/renesas/rcar-gen3-ulcb.rst
  create mode 100644 doc/board/renesas/rcar-gen4-sparrow-hawk.rst
  create mode 100644 doc/board/renesas/rcar-gen5-ironhide.rst
